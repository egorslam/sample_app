#Фабрика для симуляции объектов модели User. 

FactoryGirl.define do
  factory :user do #Передавая символ :user команде factory, мы говорим Factory Girl что последующее определение предназначено для объекта модели User.
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
 end