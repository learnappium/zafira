<%@ page
        language="java"
        contentType="text/html; charset=UTF-8"
        trimDirectiveWhitespaces="true"
        pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fragments/taglibs.jsp" %>

<div class="modal-header">
    <i class="fa fa-times cancel-button" aria-hidden="true" data-ng-click="cancel()"></i>
    <h3>User groups

    </h3>
</div>
<div class="modal-body">
    <form name="userGroupForm">
        <div class="form-group">
            <label>Name</label>
            <input type="text" class="form-control" data-ng-model="group.name" required/>
        </div>
        <div class="form-group">
            <label>Role</label>
            <select class="form-control icon-menu" data-ng-model="group.role">
                <option data-ng-repeat="role in roles" data-ng-value="role">{{role}}</option>
            </select>
        </div>
    </form>
    <div class="form-group">
        <label>Groups({{count}})</label>
        <div data-ng-hide="groups.length == 0" class="modal-body ng-scope" style="overflow-y: scroll; height: 200px;">
            <div class="row ng-scope" data-ng-repeat="group in groups | orderBy:'name'">
                <div class="col-lg-12">
                    <b class="ng-binding">{{group.name}}</b>
                    ({{group.role}})
                    <button type="button" class="btn btn-default btn-circle red" data-ng-click="deleteGroup(group.id)" style="float: right">
                        <i class="fa fa-trash"></i>
                    </button>
                </div>
                <div class="col-lg-12">
                    <md-contact-chips
                            data-ng-model="users"
                            md-search-text="searchText"
                            md-items="user in querySearch(searchText)"
                            md-contacts="delayedUsersSearch($query)"
                            md-contact-name="userName"
                            md-contact-email="email"
                            md-require-match="true"
                            md-highlight-flags="i"
                            filter-selected="true"
                            placeholder="add user">
                    </md-contact-chips>
                </div>
                <hr>
            </div>
        </div>
    </div>
    <div data-ng-show="groups.length == 0" class="ng-hide" align="center">No groups created</div>
</div>
<div class="modal-footer">
    <button data-ng-if="group.id" class="btn btn-danger" data-ng-really-message="Do you really want to delete group?" data-ng-really-click="deleteGroup(group.id)">Delete</button>
    <button class="btn btn-success" data-ng-click="createGroup(group)"  data-ng-disabled="userGroupForm.$invalid">
        Create
    </button>
    <button data-ng-if="group.id" class="btn btn-success" data-ng-click="updateGroup(group)"  data-ng-disabled="userGroupForm.$invalid">
        Save
    </button>
</div>