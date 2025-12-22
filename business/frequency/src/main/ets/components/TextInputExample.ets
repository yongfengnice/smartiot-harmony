// xxx.ets
@Component
export struct TextInputExample {
  @State text: string = '';
  // index：光标所在位置的索引值
  // x：光标相对输入框的x坐标位值，单位px
  // y：光标相对输入框的y坐标位值，单位px
  controller: TextInputController = new TextInputController();

  build() {
    Column() {
      TextInput({ text: this.text!!, placeholder: 'input your word...', controller: this.controller })
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .caretColor(Color.Blue)
        .width('95%')
        .height(40)
        .margin(20)
        .fontSize(14)
        .fontColor(Color.Black)
        .inputFilter('[a-z]', (e) => {
          console.info(JSON.stringify(e));
        })
      Text(this.text)
    }.width('100%')
  }
}