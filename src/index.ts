import { readFileSync } from 'node:fs';
import * as Parser from './grammar.js';

window.addEventListener('DOMContentLoaded', () => {
    const editableArea = document.getElementById('editable') as HTMLTextAreaElement;
    const readonlyArea = document.getElementById('readonly') as HTMLTextAreaElement;
    const processBtn = document.getElementById('processBtn') as HTMLButtonElement;

    processBtn.addEventListener('click', () => {
        const inputData = editableArea.value.trim();

        try {
            const output = Parser.parse(inputData);
            readonlyArea.value = JSON.stringify(output, null, 2); 
        } catch (error) {
            readonlyArea.value = `Error: ${error.message}`;
        }
    });
});