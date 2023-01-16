import Spinner from 'ora';

export const createSpinner = (msg) => Spinner(msg);

export const start = (spinner) => () => {
    spinner.start();
    return spinner; 
}

export const stop = (spinner) => () => spinner.stop();