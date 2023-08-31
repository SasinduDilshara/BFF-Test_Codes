import axios from 'axios';

export const getAPI = async ( url, config) => {
    try {
        const response = await axios.get(url, config);
        return response.data;
    } catch (error) {
        return error;
    }
}

export const postAPI = async ( url, data, config) => {
    try {
        console.log("Config token, ", config.token)
        const response = await axios.post(url, data, {
            headers: {"Authorization" : `Bearer ${config.token}`}
        });
        return {data: response.data, error: false};
    } catch (error) {
        throw {error: true, data: error};
    }
}
