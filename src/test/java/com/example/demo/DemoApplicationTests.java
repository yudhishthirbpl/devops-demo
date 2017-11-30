package com.example.demo;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import static org.junit.Assert.assertEquals;

import com.example.demo.service.CarService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class DemoApplicationTests {

	@Autowired
	CarService carService;
	String testCarModel;
	
	@Before
	public void loadData() {
		testCarModel = "X1-nd";
	}
	
	@Test
	public void contextLoads() {
		System.out.println("loaded context successfully");
	}
	
	@Test
	public void validateBMWX1ND() {
		assertEquals(testCarModel,carService.getCar("X1-nd").getModel());
	}

}
