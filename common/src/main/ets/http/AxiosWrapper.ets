import axios, {
  AxiosHeaders,
  AxiosInstance,
  AxiosRequestConfig,
  AxiosResponse,
  InternalAxiosRequestConfig
} from '@ohos/axios';
import { Logger } from 'base';

export class AxiosWrapper {
  axiosInstance: AxiosInstance
  interceptorHooks?: InterceptorHooks;
  commonHeader: AxiosHeaders = new AxiosHeaders()

  constructor(options: HttpRequestConfig) {
    this.interceptorHooks = options.interceptorHooks;
    this.axiosInstance = axios.create(options)
    this.initInterceptor()
  }

  initInterceptor(): void {
    //这里主要是高版本的axios中设置拦截器的时候里面的Config属性必须是InternalAxiosRequestConfig，
    // 但是InternalAxiosRequestConfig里面的headers是必传，所以在实现的子类我设置成非必传会报错，加了个忽略注解
    this.axiosInstance.interceptors.request.use(
      this.interceptorHooks?.requestInterceptor,
    );
    this.axiosInstance.interceptors.response.use(
      this.interceptorHooks?.responseInterceptor,
    );
  }

  // 类型参数的作用，T决定AxiosResponse实例中data的类型
  request<T>(config: HttpRequestConfig): Promise<T> {
    return new Promise<T>((resolve, reject) => {
      this.axiosInstance
        .request<object, T>(config)
        .then(res => {
          resolve(res);
        })
        .catch((err: object) => {
          Logger.error("网络请求Request异常：", err.toString())
          if (err) {
            reject(err);
          }
        });
    });
  }

  post<T>(config: AxiosRequestConfig): Promise<T> {
    let httpConfig = {
      url: config.url,
      data: config.params,
      method: 'POST',
      headers: config.headers ?? this.commonHeader
    } as HttpRequestConfig
    return this.request(httpConfig)
  }



  // // 类型参数的作用，T决定AxiosResponse实例中data的类型
  // request<T = CommonType>(config: HttpRequestConfig): Promise<T> {
  //   return new Promise<T>((resolve, reject) => {
  //     this.axiosInstance
  //       .request<CommonType, T>(config)
  //       .then(res => {
  //         resolve(res);
  //       })
  //       .catch((err: CommonType) => {
  //         Logger.error("网络请求Request异常：", err.toString())
  //         if (err) {
  //           reject(err);
  //         }
  //       });
  //   });
  // }
  //
  // post<T = CommonType>(config: AxiosRequestConfig): Promise<T> {
  //   let httpConfig = {
  //     url: config.url,
  //     data: config.params,
  //     method: 'POST',
  //     headers: config.headers ?? this.commonHeader
  //   } as HttpRequestConfig
  //   return this.request(httpConfig)
  // }
}

//通用数据类型
//export type CommonType = number | string | boolean | Array<number> | Array<string> | Array<boolean> | object | Object | ArrayBuffer

interface InterceptorHooks {
  requestInterceptor?: (config: HttpRequestConfig) => Promise<HttpRequestConfig>;
  responseInterceptor?: (response: AxiosResponse) => AxiosResponse | Promise<AxiosResponse>;
}

export interface HttpRequestConfig extends InternalAxiosRequestConfig {
  checkLoginState?: boolean //校验用户登陆状态
  interceptorHooks?: InterceptorHooks
}