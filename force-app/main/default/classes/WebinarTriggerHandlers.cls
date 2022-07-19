public with sharing class WebinarTriggerHandlers {
    public static void handleCostCheck(List<Webinar__c> newList) {
        automaticCostCheck(newList);
    }

    public static void handleRejectedWebinar(List<Webinar__c> newList) {
        automaticRejectionCheck(newList);
    }

    public static void handleNumberOfSeats(List<Webinar__c> newList) {
        numberOfSeatsCheck(newList);
    }

    public static void handlePriceForMember(List<Webinar__c> newList) {
        System.debug('reached handler public method');
        automaticCostCounter(newList);
    }

    public static void handleEventCreation(List<Webinar__c> newList) {
        automaticEventCreation(newList);
    }

    // *** Logic ***

    private static void automaticCostCheck(List<Webinar__c> webinars) {
        for (Webinar__c webinar : webinars) {
            if (webinar.Cost__c < 100) {
                webinar.Approval_Status__c = 'Approved';
                System.debug(webinar.Cost__c);
            }
        }
    }

    private static void automaticRejectionCheck(List<Webinar__c> webinars) {
        for (Webinar__c webinar : webinars) {
            if (webinar.Approval_Status__c == 'Rejected') {
                webinar.Status__c = 'Cancelled';
            }
        }
    }

    private static void numberOfSeatsCheck(List<Webinar__c> webinars) {
        for (Webinar__c webinar : webinars) {
            if (webinar.Number_of_Participants__c > webinar.Total_Number_of_seats__c) {
                webinar.addError('number of participants cant exceed number of seats!');
            }
        }
    }

    private static void automaticCostCounter(List<Webinar__c> webinars) {
        for (Webinar__c webinar : webinars) {
            if (webinar.Price_per_participant__c == null || webinar.Price_per_participant__c == 0) {
                webinar.Price_per_participant__c = webinar.Cost__c / webinar.Number_of_Participants__c;
            }
        }
    }

    private static void automaticEventCreation(List<Webinar__c> webinars){
        List<Webinar_Event__e> webinarEvents = new List<Webinar_Event__e>();
        for (Webinar__c webinar : webinars ){
            webinarEvents.add(new Webinar_Event__e(salesforce_id__c = webinar.Id));
        }
        List<Database.SaveResult> result = EventBus.publish(webinarEvents);

        for (Database.SaveResult sr : result) {
            if (sr.success){
                System.debug('Success');
            } else {
                for (Database.Error err : sr.getErrors() ){
                    System.debug('Some error');
                }
            }
        }

    }
}