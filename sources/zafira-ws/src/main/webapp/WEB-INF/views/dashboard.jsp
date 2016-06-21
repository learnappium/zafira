<%@ page 
    language="java"
    contentType="text/html; charset=UTF-8"
    trimDirectiveWhitespaces="true"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/fragments/taglibs.jsp" %>

<div data-ng-controller="DashboardCtrl">
	<div class="row">
         <div class="col-lg-12">
         	<h2>Dashboard</h2>
			<hr/>
         </div>
    </div>
	<div class="row">
		<div class="col-lg-12">
			<div class="input-group custom-search-form search" data-ng-show="testRunId == null">
                <input type="text" class="form-control" data-ng-model="uidFilter" placeholder="Test run filter">
                <span class="input-group-btn">
	                <button class="btn btn-default" type="button" disabled>
	                    <i class="fa fa-search"></i>
	                </button>
	            </span>
            </div>
            <div class="run_result row" align="center" data-ng-show="showLoading && totalTestRuns == 0">
            	<div class="col-lg-12"><i class="fa fa-clock-o fa-lg" aria-hidden="true"></i> Loading data...</div>
            </div>
            <div class="run_result row" align="center" data-ng-show="!showLoading && totalTestRuns == 0">
            	<div class="col-lg-12">No results yet</div>
            </div>
			<div class="run_result row" data-ng-class="'result_' + testRun.status" data-ng-repeat="(id, testRun) in testRuns | orderObjectBy:'createdAt':true | filter:{UID:uidFilter}:false track by $index" context-menu="menuOptions">
				<div class="col-lg-9">
					<input type="checkbox"
							data-ng-model="isChecked"
							data-ng-true-value="true"
							data-ng-false-value="false"
							data-ng-change="selectTestRun(testRun.id, isChecked)"
							value="{{testRun.id}}" 
							name="{{testRun.id}}"
							data-ng-show="testRun.status != 'IN_PROGRESS' && testRunId == null" onclick="event.cancelBubble=true;"/>
					<img data-ng-if="testRun.status == 'IN_PROGRESS'" src="<c:url value="/resources/img/pending.gif" />" class="pending"/>
				  	<b>{{UtilService.truncate(testRun.testSuite.name, 50)}}</b>
					<a href="{{testRun.jenkinsURL}}">{{UtilService.truncate(testRun.jenkinsURL, 40)}}</a>
					<b>{{getArgValue(testRun.configXML, 'env')}}</b>
				</div>
				<div  class="col-lg-3">
					<div class="float_right">
						<span class="time">{{testRun.createdAt | date:'MMM dd HH:mm'}}</span>
						&nbsp;
						<span class="label arrowed arrowed-in-right label-success-border" data-ng-class="{'label-success-empty': testRunResults[testRun.id].passed == 0, 'label-success': testRunResults[testRun.id].passed > 0}">{{testRunResults[testRun.id].passed}}</span>
						<span class="label arrowed arrowed-in-right label-danger-border" data-ng-class="{'label-danger-empty': testRunResults[testRun.id].failed == 0, 'label-danger': testRunResults[testRun.id].failed > 0}">{{testRunResults[testRun.id].failed}}</span>
						<span class="label arrowed arrowed-in-right label-warning-border" data-ng-class="{'label-warning-empty': testRunResults[testRun.id].skipped == 0, 'label-warning': testRunResults[testRun.id].skipped > 0}">{{testRunResults[testRun.id].skipped}}</span>
						&nbsp;
						<i data-ng-class="{'fa fa-lg fa-sort-desc': testRun.showDetails == false, 'fa fa-lg fa-sort-asc': testRun.showDetails == true}" aria-hidden="true" data-ng-click="testRun.showDetails = !testRun.showDetails"></i>
					</div>
				</div>
				<div class="col-lg-12" data-ng-show="testRun.showDetails == true" style="margin-top: 20px;">
                    <div class="row test_result" data-ng-class="tests[testId].status" data-ng-repeat="testId in testRunsTestIds[testRun.id] | orderBy:'testId':false">
                    	<div class="col-lg-10">
                    		<div><img data-ng-if="tests[testId].status == 'IN_PROGRESS'" src="<c:url value="/resources/img/pending.gif" />" class="pending"/> {{tests[testId].name}}</div>
                            <div class="result_error wrap" data-ng-if="tests[testId].message">{{tests[testId].message}}</div>
                    	</div>
                    	<div class="col-lg-2">
                    		<div class="float_right" data-ng-if="tests[testId].status != STARTED">
                            	<span class="time">{{tests[testId].finishTime | date:'hh:mm'}}</span>
                            	&nbsp;
                            	<a data-ng-if="tests[testId].logURL && testRun.status != 'IN_PROGRESS'" href="{{tests[testId].logURL}}" target="blank">Log</a> <span data-ng-if="tests[testId].demoURL && testRun.status != 'IN_PROGRESS'">| <a href="{{tests[testId].demoURL}}" target="blank">Demo</a></span>
                       		</div>
                    	</div>
	                 </div>
				</div>
			</div>
			<div style="padding: 5px 15px;">
				<a href="#/tests/runs/{{compareQueryString}}/compare" class="float_left" data-ng-show="testRunsToCompare.length > 1" target="blank">Compare</a>
				<a href="" data-ng-click="loadTestRuns(testRunSearchCriteria.page + 1)" class="float_right" data-ng-show="(testRunSearchCriteria.page * testRunSearchCriteria.pageSize) < totalResults && testRunId == null">Show more</a>
			</div>
			<br/>
		</div>
	</div>
</div>

              