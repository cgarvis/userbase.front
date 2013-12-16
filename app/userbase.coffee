angular.module('userbase.front', ['analytics'])
  .directive 'signUpBtn', (analytics) ->
    restrict: 'E'
    replace: true
    scope:
      position: '@'
    template: '''
      <a class="btn btn-lg btn-success" href="#" role="button" ng-click="signUp()" ng-transclude>Sign up</a>
    '''
    transclude: true
    link: (scope, element, attrs) ->
      scope.signUp = ->
        opts = { 'Action': 'Sign up' }
        opts['Position'] = scope.position if scope.position?
        analytics.track 'Clicked call to action', opts

angular.module('analytics', ['segmentio'])
  .constant('SEGMENTIO_KEY', 'nfown78gx0')

  .run (SEGMENTIO_KEY, segmentio) ->
    segmentio.load(SEGMENTIO_KEY)

  .factory 'analytics', (segmentio) ->
    return segmentio
