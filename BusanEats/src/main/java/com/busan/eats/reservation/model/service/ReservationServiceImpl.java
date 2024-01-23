package com.busan.eats.reservation.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busan.eats.reservation.model.dao.ReservationDao;
import com.busan.eats.reservation.model.vo.Reservation;

@Service
public class ReservationServiceImpl implements ReservationService {
	@Autowired
	private SqlSessionTemplate sqlSession;	
	@Autowired
	private  ReservationDao reservationDao;
	
	@Override
	public int insertReservation(Reservation r) {
		
		System.out.println("service "  + r);
		return reservationDao.insertReservation(r,sqlSession);
	}

}
