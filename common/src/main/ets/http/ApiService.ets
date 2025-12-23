import { LoginRequest, LoginResponse } from '../bean/Login';
import axiosClient from './AxiosClient';


let baseUrl = "http://app-api.jinpengtech.com:8888/smarthome_api"

export class ApiService {
  //用户登录 post
  static userLogin(loginRequest: LoginRequest) {
    return axiosClient.post<LoginResponse>({
      url: baseUrl + "/v1/user/login",
      data: loginRequest,
    })
  }
}

