class menuItems {
  String title;
  String img;
  String url;
  menuItems({required this.title, required this.img, required this.url});
}

final List<menuItems> items = [
  menuItems(title: 'Customer', img: 'assets/images/customer.png', url: ''),
  menuItems(
      title: 'Capacity Assessment', img: 'assets/images/capacity.png', url: ''),
  menuItems(
      title: 'Process Planning', img: 'assets/images/pattern.png', url: ''),
  menuItems(
      title: 'Pattern',
      img: 'assets/images/pattern.png',
      url: '/PressContainer'),
  menuItems(title: 'Shell', img: 'assets/images/shell.png', url: ''),
  menuItems(
      title: 'Melting & Pounding', img: 'assets/images/melting.png', url: ''),
  menuItems(title: 'Finishing', img: 'assets/images/finishing.png', url: ''),
  menuItems(title: 'Heat Treatment', img: 'assets/images/heat.png', url: ''),
  menuItems(
      title: 'Testing & Injection', img: 'assets/images/testing.png', url: ''),
  menuItems(title: 'Machining', img: 'assets/images/machning.png', url: ''),
  menuItems(title: 'Dispatch', img: 'assets/images/dispatch.png', url: ''),
  menuItems(title: 'Purchase', img: 'assets/images/purchase.png', url: '')
];
