# README

Celem zadania jest stworzenie aplikacji Ruby on Rails umożliwiającej rejestrację użytkowników przy pomocy rozbudowanego formularza.
Formularz powinien posiadać następujące pola:
● First name
● Last name
● Email address
● Date of birth
● Phone number

● Address
    ○ Street
    ○ City
    ○ Zip code
    ○ Country
    
● Company
    ○ Name
    ○ Address
        ■ Street
        ■ City
        ■ Zip code
        ■ Country
        
        
Reguły walidacji:
● Pole ​First name​ jest obowiązkowe
● Pole ​First name​ nie może zawierać więcej niż 100 znaków
● Pole ​Last name​ jest obowiązkowe
● Pole ​Last name​ nie może zawierać więcej niż 100 znaków
● Pole ​Email address​ jest obowiązkowe
● Pole ​Email address​ musi zawierać poprawny adres e-mail
● Pole ​Date of birth​ jest opcjonalne
● Pole ​Date of birth​, jeżeli zostało wypełnione, musi zawierać poprawną datę
● Pole ​Date of birth​, jeżeli zostało wypełnione, musi zawierać datę w przeszłości
● Pole ​Phone number​ jest opcjonalne
● Pole ​Phone number​, jeżeli zostało wypełnione, musi zawierać numer telefonu w
formacie kraju określonym poprzez pole ​Country
● Pole ​Street​ wewnątrz ​Address​ jest obowiązkowe
● Pole ​City​ wewnątrz ​Address​ jest obowiązkowe
● Pole ​Zip code​ wewnątrz ​Address​ jest obowiązkowe
● Pole ​Zip code​ wewnątrz ​Address​ musi zawierać kod pocztowy w formacie kraju
określonym poprzez pole ​Country
● Pole ​Country​ wewnątrz ​Address​ jest obowiązkowe
● Pole ​Country​ wewnątrz ​Address​ musi zawierać kod kraju w formacie
ISO 3166-1 alfa-2
● Pole ​Name​ wewnątrz ​Company​ jest opcjonalne
● Pole ​Name​ wewnątrz ​Company​, jeżeli zostało wypełnione, nie może zawierać więcej
niż 200 znaków

● Pole ​Street​ wewnątrz ​Address​ wewnątrz ​Company​ jest opcjonalne
● Pole ​City​ wewnątrz ​Address​ wewnątrz ​Company​ jest opcjonalne
● Pole ​Zip code​ wewnątrz ​Address​ wewnątrz ​Company​ jest opcjonalne
● Pole ​Zip code​ wewnątrz ​Address​ wewnątrz ​Company​, jeżeli zostało wypełnione,
musi zawierać kod pocztowy w formacie kraju określonym poprzez pole ​Country
wewnątrz ​Address​ wewnątrz ​Company
● Pole ​Country​ wewnątrz ​Address​ wewnątrz ​Company​ jest obowiązkowe
● Pole ​Country​ wewnątrz ​Address​ wewnątrz ​Company​ musi zawierać kod kraju w
formacie ISO 3166-1 alfa-2
Po wysłaniu formularza dane powinny zostać zwalidowane i zapisane w bazie danych.
Struktura bazy danych powinna uwzględniać oddzielne tabele dla użytkowników, firm oraz adresów.
Podczas oceny zdania ważnym kryterium będzie czytelność kodu oraz obecność testów. Zalecane jest wykorzystanie zewnętrznych bibliotek (gemów).
