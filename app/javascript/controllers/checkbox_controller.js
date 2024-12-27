// app/javascript/controllers/checkbox_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Checkbox controller connected")
  }

  toggle(event) {
    const checkbox = event.target
    const assignmentId = checkbox.dataset.assignmentId
    const wave = checkbox.dataset.wave
    const checked = checkbox.checked

    console.log("Sending update:", { assignmentId, wave, checked })

    fetch(`/assignments/${assignmentId}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        assignment: {
          [wave]: checked
        }
      })
    })
    .then(response => {
      if (!response.ok) {
        checkbox.checked = !checked
        throw new Error('Update failed')
      }
    })
    .catch(error => {
      console.error('Error:', error)
      checkbox.checked = !checked
    })
  }
}
