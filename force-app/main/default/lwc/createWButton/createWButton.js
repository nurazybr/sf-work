/**
 * Created by ynurazkhan on 13.07.2022.
 */

import { LightningElement, api } from 'lwc';
import WEBINAR_OBJECT   from '@salesforce/schema/Webinar__c';
import APPROVAL_STATUS  from '@salesforce/schema/Webinar__c.Approval_Status__c';
import COST             from '@salesforce/schema/Webinar__c.Cost__c';
import DESCRIPTION      from '@salesforce/schema/Webinar__c.Description__c';
import END_DATE         from '@salesforce/schema/Webinar__c.End_Date__c';
import NAME             from '@salesforce/schema/Webinar__c.Name__c';
import PARTICIPANTS     from '@salesforce/schema/Webinar__c.Number_of_Participants__c';
import PRICE            from '@salesforce/schema/Webinar__c.Price_per_participant__c';
import REASON           from '@salesforce/schema/Webinar__c.Rejection_Reason__c';
import SCORE            from '@salesforce/schema/Webinar__c.Scoring__c';
import START_DATE       from '@salesforce/schema/Webinar__c.Start_Date__c';
import STATUS           from '@salesforce/schema/Webinar__c.Status__c';
import SEATS            from '@salesforce/schema/Webinar__c.Total_Number_of_seats__c';
import TYPE             from '@salesforce/schema/Webinar__c.Type__c';
import WEBINAR_NAME     from '@salesforce/schema/Webinar__c.Name__c';


import {CloseActionScreenEvent} from 'lightning/actions';

const fields = [
    APPROVAL_STATUS,
    COST,
    DESCRIPTION,
    END_DATE,
    NAME,
    PARTICIPANTS,
    PRICE,
    REASON,
    SCORE,
    START_DATE,
    STATUS,
    SEATS,
    TYPE,
    WEBINAR_NAME
]
export default class CreateWButton extends LightningElement {
    webinarObject = WEBINAR_OBJECT;
    fields = fields;

    closeWindow(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handleSave(event){
        event.preventDefault();
        let eventFields = event.detail.fields;
    }
}