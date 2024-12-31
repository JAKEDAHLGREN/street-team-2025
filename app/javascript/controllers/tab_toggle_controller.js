import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["allAssignments", "myAssignments", "allAssignmentsTab", "myAssignmentsTab"];

  connect(){
    console.log("TAB CONTROLLER IS CONNECTED!")
  }
  showTab(event) {
    const tab = event.currentTarget.dataset.tab;

    if (tab === 'all') {
      this.allAssignmentsTarget.classList.remove('hidden');
      this.myAssignmentsTarget.classList.add('hidden');
      this.allAssignmentsTabTarget.classList.add('active', 'bg-gray-200');
      this.myAssignmentsTabTarget.classList.remove('active', 'bg-gray-200');
    } else {
      this.allAssignmentsTarget.classList.add('hidden');
      this.myAssignmentsTarget.classList.remove('hidden');
      this.allAssignmentsTabTarget.classList.remove('active', 'bg-gray-200');
      this.myAssignmentsTabTarget.classList.add('active', 'bg-gray-200');
    }
  }
}
