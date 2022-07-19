/*
 * Created by ynurazkhan on 11.07.2022.
 */

({
    handleClick : function(component, event, helper){
        var Approval_Status = component.get('v.Approval_Status');
        var types = component.get('v.Type');
        var action = component.get('c.searchForWebinars');
        var actions = [{label: 'Register', name: 'Register'}];
        action.setParams({approvalStatus: Approval_Status, type: types});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var ids = response.getReturnValue();
                console.log(ids);
            }
            component.set("v.webinars",response.getReturnValue());
            component.set('v.wHeader', [
                         {label: 'Cost ', fieldName: 'Cost__c', type: 'Currency'},
                         {label: 'Status ', fieldName: 'Status__c', type: 'text'},
                         {label: 'Webinar name', fieldName: 'Name', type: 'text'},
                         {label: 'action', type: 'action',
                           typeAttributes: {rowActions: actions}
                         }
                         ]);
        });
        $A.enqueueAction(action);
    },

    registrationOfUser : function(component, event, helper) {
        var userIds = $A.get('$SObjectType.CurrentUser.Id');
        var returnStatus = event.getParam('action');
        var row = event.getParam('row');
        var webId = row.Id;
        var action = component.get('c.registerUser');

        action.setCallback(this, function(){});
        action.setParams({webinarId: webId, userId: userIds});
        $A.enqueueAction(action);

    }
});