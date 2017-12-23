package com.devops.demo.service;

import java.util.Hashtable;

import org.springframework.stereotype.Service;

import com.devops.demo.model.Car;

@Service
public class CarService {

	protected Hashtable<String, Car> cars = new Hashtable<>();

	public CarService() {
		// TODO Auto-generated constructor stub
		Car car = new Car();
		car.setMake("suzuki");
		car.setModel("swift-nd");
		car.setModelYear("2017");
		car.setModelRegion("EMEA");
		car.setModelDesc("New Design Swift for EMEA region");
		car.setCo2e("10 - index is high");
		cars.put(car.getModel(), car);

		car = new Car();
		car.setMake("bmw");
		car.setModel("X1-nd");
		car.setModelYear("2017");
		car.setModelRegion("EMEA");
		car.setModelDesc("New Design X1 for EMEA region");
		car.setCo2e("16 - - index is very high");
		cars.put(car.getModel(), car);
		
		car = new Car();
		car.setMake("hyundai");
		car.setModel("creta-lq");
		car.setModelYear("2017");
		car.setModelRegion("APAC");
		car.setModelDesc("New Design Creta for APAC region");
		car.setCo2e("17 - - index is high");
		cars.put(car.getModel(), car);
		
		car = new Car();
		car.setMake("Tata");
		car.setModel("nexon");
		car.setModelYear("2017");
		car.setModelRegion("APAC,MENA");
		car.setModelDesc("New Design Nexon for APAC and MENA regions");
		car.setCo2e("8 - index is OK");
		cars.put(car.getModel(), car);
		
		car = new Car();
		car.setMake("jlr");
		car.setModel("discovery-sp");
		car.setModelYear("2017");
		car.setModelRegion("APAC");
		car.setModelDesc("New Design discovery sports for APAC");
		car.setCo2e("5 - - index is Good");
		cars.put(car.getModel(), car);

	}

	public Car getCar(String model) {
		if(cars.containsKey(model)) {
			return cars.get(model);
		}
		return null;
	}//end of getCar


	public Hashtable<String, Car> getAll(){
		return cars;
	}

}//end of class
