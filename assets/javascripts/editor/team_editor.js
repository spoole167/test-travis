angular.module('teamEditorApp', ["xeditable"])
  .controller('ProductController', function($scope,$http) {


    $http.get('/api/v1/metrics').success(function(data) {

    $scope.products = data;
  });

  $http.get('/api/v1/metric_names').success(function(data) {

  $scope.metric_names = data;
});

$scope.trends = [
 {value: -1, text: 'reversing'},
 {value: 0, text: 'stable'},
 {value: 1, text: 'improving'},
];

$scope.showTrend = function(v) {
    if ( v < 0) return -1;
    if (v > 0) return 1;
    return 0;
};


$scope.updateMetric = function(product) {

 data= $http.post('/api/v1/product', product);
 return data;

 };
  });
