//  Slider Model
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(
      {required this.title, required this.subTitle, required this.image});
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

//  login Model
class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class Service {
  int id;

  String title;

  String image;

  Service(this.id, this.title, this.image);
}

class Banners {
  int id;

  String title;

  String image;
  String link;

  Banners(this.id, this.title, this.image, this.link);
}

class Store {
  int id;

  String title;

  String image;

  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;

  List<Banners> banners;

  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class Home {
  HomeData data;

  Home(this.data);
}
