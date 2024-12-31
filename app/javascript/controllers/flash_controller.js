import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    autoClose: Number
  }

  connect() {
    const autoClose = this.autoCloseValue

    if (autoClose) {
      setTimeout(() => {
        this.dismiss()
      }, autoClose * 1000)
    }
  }

  dismiss() {;
    this.element.remove()
  }
}
