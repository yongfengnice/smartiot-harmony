export interface HttpResponse<T> {
  resultCode: number,
  description: string,
  timestamp: number,
  response_obj: T
}