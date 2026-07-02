import { LightningElement } from 'lwc';
import signup from './signup.html';
import signin from './signin.html';
import testWebsiteSignup from './testWebsiteSignup.html';
export default class TestWebsiteSignup extends LightningElement {

    selectedbtn = '';
    handleClick(event){
        this.selectedbtn = event.target.label;
    }

    render(){
        return this.selectedbtn === 'Sign Up' ? signup : this.selectedbtn === 'Sign In' ? signin : testWebsiteSignup;
    }

    submitHandler(event){
        console.log(event.target.label + 'successfully');
    }
}