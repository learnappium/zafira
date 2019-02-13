(function () {
    'use strict';

    angular.module('app.appUsers')
        .controller('AppUsersController', AppUsersController);

    // **************************************************************************
    function AppUsersController($scope, $controller, $rootScope, $location, $mdDateRangePicker, $state, $mdDialog,
                                UserService, GroupService, UtilService, DashboardService) {
        'ngInject';

        $scope.UtilService = UtilService;
        $scope.DashboardService = DashboardService;

        $scope.users = [];
        $scope.order = 'username';

        $scope.tabs[$scope.tabs.indexOfField('name', 'Users')].countFunc = function() {
            return $scope.sr && $scope.sr.totalResults ? $scope.sr.totalResults : 0;
        };

        $scope.showChangePasswordDialog = function($event, user) {
            $mdDialog.show({
                controller: function ($scope, $mdDialog, UtilService) {
                    'ngInject';

                    $scope.UtilService = UtilService;
                    $scope.user = user;
                    $scope.changePassword = {'userId' : user.id};
                    $scope.updateUserPassword = function(changePassword)
                    {
                        UserService.updateUserPassword(changePassword)
                            .then(function (rs) {
                                if(rs.success)
                                {
                                    $scope.changePassword = {};
                                    $scope.hide();
                                    alertify.success('Password changed');
                                }
                                else
                                {
                                    alertify.error(rs.message);
                                }
                            });
                    };
                    $scope.hide = function() {
                        $mdDialog.hide(true);
                    };
                    $scope.cancel = function() {
                        $mdDialog.cancel(false);
                    };
                },
                template: require('./password_modal.html'),
                parent: angular.element(document.body),
                targetEvent: $event,
                clickOutsideToClose:true,
                fullscreen: true
            })
                .then(function(answer) {
                    if(answer)
                    {
                        $state.reload();
                    }
                }, function() {
                });
        };

        $scope.showEditProfileDialog = function(event, user, index) {
            $mdDialog.show({
                controller: function ($scope, $mdDialog, UtilService) {
                    'ngInject';

                    $scope.UtilService = UtilService;
                    $scope.user = angular.copy(user);
                    $scope.updateStatus = function(user, status, index) {
                        user.status = status;
                        UserService.updateStatus(user).then(function (rs) {
                            if(rs.success) {
                                $scope.cancel(rs.data.status);
                            } else {
                                alertify.error(rs.message);
                            }
                        });
                    };
                    $scope.updateUser = function() {
                        UserService.createOrUpdateUser($scope.user).then(function(rs) {
                            if(rs.success)
                            {
                                $scope.hide();
                                alertify.success('Profile changed');
                            }
                            else
                            {
                                alertify.error(rs.message);
                            }
                        });
                    };
                    $scope.hide = function() {
                        $mdDialog.hide(true);
                    };
                    $scope.cancel = function(status) {
                        $mdDialog.cancel(status);
                    };
                },
                template: require('./edit_modal.html'),
                parent: angular.element(document.body),
                targetEvent: event,
                clickOutsideToClose:true,
                fullscreen: true
            })
                .then(function(answer) {
                    if(answer)
                    {
                        $state.reload();
                    }
                }, function(status) {
                    if(status) {
                        $scope.sr.results[index].status = status;
                    }
                });
        };

        (function initController() {
        })();
    };
})();
