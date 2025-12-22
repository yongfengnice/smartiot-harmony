import { AxiosRequestHeaders, AxiosResponse } from '@ohos/axios';
import { Logger } from 'base';
import { AxiosWrapper } from './AxiosWrapper';

const axiosClient = new AxiosWrapper({
  headers: {
    'Content-Type': 'application/json'
  } as AxiosRequestHeaders,

  interceptorHooks: {
    requestInterceptor: async (config) => {
      return config
    },
    responseInterceptor: (response: AxiosResponse) => {
      Logger.debug('网络请求响应Response:', `\n${JSON.stringify(response.data)}`);
      if (response.status === 200) {
        //let config = response.config as HttpRequestConfig // ???
        return Promise.resolve(response.data);
      } else {
        return Promise.reject(response);
      }
    }
  },

})

export default axiosClient