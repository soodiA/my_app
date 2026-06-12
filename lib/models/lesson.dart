class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final bool isUnlocked;
  final bool isCompleted;
  final int stars; // 0 to 3

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    this.isUnlocked = false,
    this.isCompleted = false,
    this.stars = 0,
  });
}

// 32 مراحل - فقط اولی باز
final List<Lesson> lessons = List.generate(32, (index) {
  final letters = [
    'آ', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ح',
    'خ', 'د', 'ذ', 'ر', 'ز', 'ژ', 'س', 'ش',
    'ص', 'ض', 'ط', 'ظ', 'ع', 'غ', 'ف', 'ق',
    'ک', 'گ', 'ل', 'م', 'ن', 'و', 'ه', 'ی'
  ];

  final words = [
    'آفتاب', 'بابا', 'پنجره', 'توت‌فرنگی', 'ثروت', 'جنگل', 'چراغ', 'حوض',
    'خورشید', 'درخت', 'ذرت', 'رودخانه', 'زرافه', 'ژاله', 'سبد', 'شیر',
    'صندلی', 'ضابطه', 'طاووس', 'ظرف', 'عنکبوت', 'غروب', 'فیل', 'قیچی',
    'کتاب', 'گل', 'لاله', 'ماه', 'نخل', 'ورزش', 'هلو', 'یزدان'
  ];

  return Lesson(
    id: '${index + 1}',
    title: letters[index],
    subtitle: words[index],
    isUnlocked: index == 0, // فقط اولی باز
    isCompleted: false,
    stars: 0,
  );
});
