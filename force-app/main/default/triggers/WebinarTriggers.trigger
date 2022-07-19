trigger WebinarTriggers on Webinar__c (before insert, before update, after insert ) {
    if (Trigger.isBefore && Trigger.isInsert) {
        WebinarTriggerHandlers.handleCostCheck(Trigger.new);
        WebinarTriggerHandlers.handleNumberOfSeats(Trigger.new);
        WebinarTriggerHandlers.handlePriceForMember(Trigger.new);
    }

    else if (Trigger.isBefore && Trigger.isUpdate) {
        WebinarTriggerHandlers.handleRejectedWebinar(Trigger.new);
        WebinarTriggerHandlers.handleNumberOfSeats(Trigger.new);
        WebinarTriggerHandlers.handlePriceForMember(Trigger.new);
    }
    else if (Trigger.isAfter && Trigger.isInsert) {
        WebinarTriggerHandlers.handleEventCreation(Trigger.new);
    }

}