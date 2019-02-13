(function () {
    'use strict';

    angular.module('app.user').directive('appUsersControls', function () {
        return {
            template: require('./app-users-controls.html'),
            scope: {
                onSearchFn: '&'
            },
            controller: ($scope) => {
                'ngInject';

                const vm =  {
                    onFC: () => {
                        debugger
                        vm.onSearchFn();
                    }
                }

                return vm;
            },
            controllerAs: '$ctrl',
            bindToController: true,
            restrict: 'E',
            replace: true
        };
    });

})();
