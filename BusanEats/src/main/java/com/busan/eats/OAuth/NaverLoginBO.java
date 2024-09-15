package com.busan.eats.OAuth;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.client.resource.OAuth2ProtectedResourceDetails;
import org.springframework.security.oauth2.client.token.grant.code.AuthorizationCodeResourceDetails;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpSession;
import java.util.Arrays;

@Component
public class NaverLoginBO {

    // 네이버 OAuth2 설정 정보 (application.properties에서 설정)
    @Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;

    @Value("${naver.redirect.uri}")
    private String redirectUri;

    // 네이버 액세스 토큰 요청
    public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) {
        OAuth2RestTemplate restTemplate = new OAuth2RestTemplate(getClientResourceDetails());
        OAuth2AccessToken accessToken = restTemplate.getAccessToken(); // 액세스 토큰 가져오기
        session.setAttribute("oauthToken", accessToken);
        return accessToken;
    }

    // 네이버 사용자 프로필 정보 요청
    public String getUserProfile(OAuth2AccessToken oauthToken) {
        String apiUrl = "https://openapi.naver.com/v1/nid/me"; // 네이버 사용자 정보 요청 URL
        RestTemplate restTemplate = new RestTemplate();

        // 액세스 토큰을 헤더에 추가하여 사용자 정보 요청
        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + oauthToken.getValue());
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // 사용자 정보 요청
        ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);
        return response.getBody();
    }

    // OAuth2 설정 정보 (네이버 인증을 위한 설정)
    private OAuth2ProtectedResourceDetails getClientResourceDetails() {
        AuthorizationCodeResourceDetails resourceDetails = new AuthorizationCodeResourceDetails();
        resourceDetails.setClientId(clientId);
        resourceDetails.setClientSecret(clientSecret);
        resourceDetails.setAccessTokenUri("https://nid.naver.com/oauth2.0/token");
        resourceDetails.setUserAuthorizationUri("https://nid.naver.com/oauth2.0/authorize");
        resourceDetails.setPreEstablishedRedirectUri(redirectUri); // 수정된 부분: setPreEstablishedRedirectUri 사용
        resourceDetails.setGrantType("authorization_code");
        resourceDetails.setScope(Arrays.asList("profile", "email")); // 필요한 권한 설정
        resourceDetails.setUseCurrentUri(false); // 리다이렉트 URI 설정 사용
        return resourceDetails;
    }
}
