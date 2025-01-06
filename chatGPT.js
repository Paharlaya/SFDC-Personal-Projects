import { LightningElement, api } from 'lwc';

export default class LWCChatGPT extends LightningElement {
    @api question = "What is Chat GPT?";
    data;
    isLoaded = true;
    isChange = true;
    message = '';

    handleOnChange(event) {
        this.question = event.target.value;
        this.isChange = true;
    }

    handleOnClick() {
        if (this.isChange) {
            this.isLoaded = false;
            this.getChatData();
            this.isChange = false;
        }
    }

    async getChatData() {
        const endPoint = "https://api.openai.com/v1/chat/completions";
        const myHeaders = new Headers();
        myHeaders.append("Authorization", "Bearer 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");
        myHeaders.append("Content-type", "application/json");

        const raw = JSON.stringify({
            "model": "gpt-3.5-turbo",
            "messages": [
                {
                    "role": "user",
                    "content": this.question
                }]
        });

        const requestOptions = {
            method: 'POST',
            headers: myHeaders,
            body: raw,
            redirect: 'follow'
        };
        try {
            const response = await fetch(endPoint, requestOptions);
            const result_1 = await response.json();
            this.data = result_1;
            console.log(this.data);
            this.message = this.data.choices[0].content; // Use `this.data.choices[0].content` instead of `this.data.choices[0].message.content`
            this.isLoaded = true;
        } catch (error) {
            return console.log('error', error);
        }
    }
}