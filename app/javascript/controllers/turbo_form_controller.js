import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submit(event) {
    try {
      const form = event.target.closest("form")
      if (!form) throw new Error("No form found")
      form.requestSubmit()
    } catch (error) {
      console.error("Form submission error:", error)
    }
  }
}
