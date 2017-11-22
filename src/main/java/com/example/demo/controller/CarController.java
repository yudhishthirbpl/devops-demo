package com.example.demo.controller;

import java.util.Hashtable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.model.Car;
import com.example.demo.service.CarService;

@RestController
@RequestMapping("/cars")
public class CarController {
	@Autowired
	CarService carService;
	
	@RequestMapping("/all")
	public Hashtable<String, Car> getAll() {
		return carService.getAll();
	}
	
	@RequestMapping("{model}")
	public Car getCar(@PathVariable("model") String model) {
		return carService.getCar(model);
	}
	
}//end of controller
