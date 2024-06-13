import { Controller } from "@hotwired/stimulus"
import Tagify from '@yaireo/tagify'

// Connects to data-controller="tagify"
export default class extends Controller {
  static targets = [ "tagify", "tagNames" ]
  connect() {
    this.tagify = new Tagify(this.tagifyTarget, {
      maxTags: 5,
      originalInputValueFormat: valuesArr => valuesArr.map(item => item.value).join(',')
    })
    const tagNamesStr = this.tagNamesTarget.value
    if (tagNamesStr.length > 0) {
      this.tagify.addTags(tagNamesStr.split(','))
    }
  }
}
