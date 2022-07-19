({
    fetchWebinars : function (component,event,helper){
        var action = component.get("c.listWebinars");
        action.setCallback(this,function(response){
            component.set("v.webinars",response.getReturnValue());
            var actions = [{label: 'Approve', name: 'approve'},
                           {label: 'Reject',  name: 'reject' }]
            component.set('v.wHeader', [
                    {label: 'Cost ', fieldName: 'Cost__c', type: 'Currency'},
                    {label: 'Status ', fieldName: 'Status__c', type: 'text'},
                    {label: 'Webinar name', fieldName: 'Name', type: 'text'},
                    {label: 'Action', type: 'action',
                     typeAttributes: { rowActions: actions}
                    }]);
        })
    $A.enqueueAction(action);
    },

    approvedWebinar : function (component,event,helper){
            var returnStatus = event.getParam('action');
            var row = event.getParam('row');
            var webId = row.Id;
            console.log('Status :'+returnStatus.name+' id: '+webId);
            var action = component.get('c.changeStatus');
            console.log(action);
            action.setCallback(this,function(){
            })
            console.log('////')
            action.setParams({Id:webId, status:returnStatus.name});
            console.log('xxxx')
            $A.enqueueAction(action);

     }
});