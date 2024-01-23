package com.busan.eats.reservation.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.busan.eats.reservation.model.vo.Reservation;

@Repository
public class ReservationDao {

	public int insertReservation(Reservation r, SqlSessionTemplate sqlSession) {
		System.out.println("dao "  + r);
		return sqlSession.insert("reservationMapper.insertReservation",r);
	};
}
