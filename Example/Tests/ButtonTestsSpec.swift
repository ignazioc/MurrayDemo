// https://github.com/Quick/Quick

import EBKUI
import Nimble
import Nimble_Snapshots
import Quick

class ButtonTestsSpec: QuickSpec {
    override func spec() {
        describe("the EBK app") {

            it("has green buttons") {
                let button = EBKButtonStandardGreen(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
                button.setTitle("Click me!", for: .normal)
                expect(button).to( haveValidSnapshot())
            }

            it("has a button with green border") {
                let button = EBKButtonGreenBorder(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
                button.setTitle("Click me!", for: .normal)
                expect(button).to( haveValidSnapshot())
            }
            it("has a button for Treebay") {
                let button = EBKButtonTreeBay(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
                button.setTitle("Click me!", for: .normal)
                expect(button).to( haveValidSnapshot())
            }
            it("has a button for ContactUS") {
                let button = EBKButtonContactUS(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
                button.setTitle("Click me!", for: .normal)
                expect(button).to( haveValidSnapshot())
            }
            it("has a button with a chevron") {
                let button = EBKButtonWithChevron(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
                button.setTitle("Click me!", for: .normal)
                expect(button).to( haveValidSnapshot())
            }

            it("has a button for Gray Out") {
                let button = EBKAutoGrayOutButton(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
                button.setTitle("Click me!", for: .normal)
                expect(button).to( haveValidSnapshot())
            }
            it("has a button for Message") {
                let button = EBKMessageButton(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
                button.setTitle("Click me!", for: .normal)
                expect(button).to( haveValidSnapshot())
            }
            it("has a button Base") {
                let button = EBKBaseButton(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
                button.setTitle("Click me!", for: .normal)
                expect(button).to( haveValidSnapshot())
            }
        }
    }
}
