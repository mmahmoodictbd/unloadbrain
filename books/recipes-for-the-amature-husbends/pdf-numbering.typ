#set heading(numbering: none)
// The book template puts chapter numbers in running headers even without numbered headings.
#set page(header: none)
#set enum(numbering: (..numbers) => {
  let digits = ("০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯")
  numbers.pos()
    .map(number => str(number).clusters().map(digit => digits.at(int(digit))).join(""))
    .join(".") + "."
})
