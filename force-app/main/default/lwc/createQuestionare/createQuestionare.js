/**
 * Created by ynurazkhan on 12.07.2022.
 */
import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue, createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

import USER_ID from '@salesforce/user/Id';
import USER_NAME from '@salesforce/schema/User.Name';
import WEBINAR_STATUS from '@salesforce/schema/Webinar__c.Status__c';
import QUESTIONNAIRE_OBJECT from '@salesforce/schema/Questionnaire__c';


export default class CreateQuestionnaire extends NavigationMixin(LightningElement) {
    @api toastMessage;
    @api recordId;
    @api title;
    @api wouldRecommendNo;
    questionnaireId;
    error;

    @wire(getRecord, {recordId : USER_ID, fields : [USER_NAME]})
    userData({error, data}) {
        if (error){
            this.error = error;
        } else if (data) {
            this.title = 'Hi ' + data.fields.Name.value + '! Share your feedback with us!';
        }
    }

    handleRecommendChange(event){
        if (event.detail.value == 'No'){
            this.wouldRecommendNo = true;
        }else {
            this.wouldRecommendNo = false;
        }
    }
    handleSuccess(){
        const evt = new ShowToastEvent({
           title: 'Questionnaire created!',
           message: this.toastMessage,
           variant: 'success',
        });
        this.dispatchEvent(evt);
        this.navigateToQuestionnaire();
    }

    handleSave(event) {
        const fields = event.detail.fields;
        const newQuest = {
            "apiName": "Questionnaire__c",
            "fields": {
                "Is_Attending__c": fields.Is_Attending__c,
                "User_Age__c": fields.User_Age__c,
                "Score__c": fields.Score__c,
                "Feedback_Comments__c": fields.Feedback_Comments__c,
                "Would_you_recommend__c": fields.Would_you_recommend__c,
                "Why_Not_Recommended__c": fields.Why_Not_Recommended__c,
                "Related_Webinar__c":this.recordId
            }
        };
        createRecord(newQuest).then(questionnaire =>{
            this.questionnaireId = questionnaire.id;
            this.handleSuccess();
        }).catch(error =>{
            console.error(error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error creating record',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
    }

    navigateToQuestionnaire(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.questionnaireId,
                objectApiName: QUESTIONNAIRE_OBJECT.objectApiName,
                actionName: 'view'
            }
        });
    }
}