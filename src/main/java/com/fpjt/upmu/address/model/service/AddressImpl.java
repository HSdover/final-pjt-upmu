package com.fpjt.upmu.address.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fpjt.upmu.address.model.dao.AddressDao;
import com.fpjt.upmu.address.model.vo.Address;
import com.fpjt.upmu.address.model.vo.AddressExt;

@Service
public class AddressImpl implements AddressService {

	@Autowired
	private AddressDao addressDao;
	
	@Override
	public int insertAddr(Address address) {
		
		return addressDao.insertAddr(address);
	}

	@Override
	public List<AddressExt> selectAddrList(int byEmp) {
		
		return addressDao.selectAddrList(byEmp);
	}

	@Override
	public int deleteAddr(Address address) {
		
		return  addressDao.deleteAddr(address);
	}

	@Override
	public AddressExt selectOneAddr(AddressExt address) {
		
		return addressDao.selectOneAddr(address);
	}
	
	
}
