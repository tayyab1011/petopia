class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(description: "Select the best food for your pet\n Delicious, nutritious food to fuel\n your pet's adventures ", image: 'images/screen1.png', title: 'Select from our\n  Best Menu'),
  UnboardingContent(description: 'You can pay cash on Delivery and\n Card payment is also available', image: 'images/screen2.png', title: 'Easy and Online Payment'),
  UnboardingContent(description: 'Fresh, never frozen, pet food delivered to your\n Doorstep', image: 'images/screen3.png', title: 'Quick Delivery at\n Your Doorstep')
];
