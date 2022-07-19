public with sharing class Merger {
    public SObject MergeTwoInstances(SObject master, SObject slave) {
        if (master.getSObjectType() != slave.getSObjectType()) {
            throw new DifferentTypesException('The provided instances are not same!');
        }
        String sObjectType = master.getSObjectType().getDescribe().getName();
        Map<String, SObjectField> masterFields = Schema.getGlobalDescribe().get(sObjectType).getDescribe().fields.getMap();
        try {
            for (String str : masterFields.keySet()) {
                if (master.get(str) == null) {
                    if (slave.get(str) != null) {
                        master.put(str, slave.get(str));
                    }
                }
            }
        } catch (Exception ex) {
            System.debug(ex.getMessage());
        }
        return master;
    }
    public class DifferentTypesException extends Exception{}
}