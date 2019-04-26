import EBKUI
import Nimble
import Nimble_Snapshots
import Quick

class EBKAvatarViewTests: QuickSpec {
    override func spec() {
        describe("an EBKAvatarView") {
            it("can extract the initials form a name") {
                expect(InitialsExtractor.calculateInitialsFromName("")).to(equal(""))
                expect(InitialsExtractor.calculateInitialsFromName("Veronika")).to(equal("V"))
                expect(InitialsExtractor.calculateInitialsFromName("Veronika Mayer")).to(equal("VM"))
                expect(InitialsExtractor.calculateInitialsFromName("Veronika Lydia Mayer")).to(equal("VM"))
                expect(InitialsExtractor.calculateInitialsFromName("äbcde üxvf")).to(equal("ÄÜ"))
                expect(InitialsExtractor.calculateInitialsFromName("234 21354")).to(equal(""))
                expect(InitialsExtractor.calculateInitialsFromName("🐶")).to(equal(""))
                expect(InitialsExtractor.calculateInitialsFromName("Veronika ßayer")).to(equal("V"))
                expect(InitialsExtractor.calculateInitialsFromName("Veronika     Lydia Mayer     ")).to(equal("VM"))
            }
            it("render correctly") {
                let avatarView = EBKAvatarView(frame: CGRect.zero)
                let sizes = [20.0, 40.0, 80.0, 160.0, 320.0]
                let letters = ["A", "B", "C", "X", "M", "W", "I"]

                for size in sizes {
                    for letter in letters {
                        avatarView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
                        avatarView.setInitialsFromName("\(letter)bla")
                        expect(avatarView).to( haveValidSnapshot(named: String(format: "testRendering_%.f_%@", size, letter)))
                        avatarView.setInitialsFromName("\(letter)bla \(letter)foo")
                        expect(avatarView).to( haveValidSnapshot(named: String(format: "testRendering_%.f_%@%@", size, letter, letter)))
                    }
                }
                sizes.forEach { size  in
                    avatarView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
                    avatarView.usePlusSign()
                    expect(avatarView).to( haveValidSnapshot(named: String(format: "testRendering_%.f_plus", size )))
                }
            }

        }
    }
}
