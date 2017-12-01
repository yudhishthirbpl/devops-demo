/**
 * 
 */
var app = angular.module("CarDashboard", []);


app.controller('CarDashboard', function($scope, $http) {
    $http.get('/cars/all').
        then(function(response) {
            $scope.cars = response.data;
        });
    
	$scope.showModelDetails = function (data) {
		console.log("hello, You have selected " + data + ", for more details");
		$http.get('/cars/'+ data).
        then(function(response) {
            $scope.car = response.data;
        });
	}
});







