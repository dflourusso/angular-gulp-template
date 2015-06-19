class Routes extends Config
  constructor: ($routeProvider) ->
    $routeProvider
    .when '/',
      controller: 'homeController'
      templateUrl: 'app/home/home.tpl.html'
      pageOptions:
        title: 'Home'
        animate: 'home'
