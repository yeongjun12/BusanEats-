package com.busan.eats.common.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data @Builder @AllArgsConstructor
public class CertVO {
	private String who, secret, when;

}
