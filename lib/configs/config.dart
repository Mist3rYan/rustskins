//https://steamcommunity.com/profiles/76561197994719101/inventory/#252490
//https://api.steampowered.com/IInventoryService/GetInventory/v1/?appid=252490&steamid=76561197994719101&key=8EBAEF7DA5E71DA6D942BA6E26D26A00&format=xml
//https://steamcommunity.com/inventory/76561197994719101/252490/2  Page de l'inventaire
//https://steamcommunity.com/market/listings/252490/*****  Page de l'item sur le store "market_name" pour acceder à la page
// https://community.akamai.steamstatic.com/economy/image/*****  Pour les images "icon_url" ou "icon_url_large" pour les images
//  var playerId = "76561197994719101"; pasyan
//https://steamcommunity.com/market/priceoverview/?appid=252490&currency=3&market_hash_name=Caution%20Crate
//'https://steamcommunity.com/market/priceoverview/?appid=252490&currency=3&market_hash_name=${marketNames[index]}',
//https://www.steamwebapi.com/steam/api/inventory?key=8RGOUGVG9HSCGCIV&steam_id=76561197994719101&game=rust

import 'package:flutter/material.dart';

class ConfigApp {
  static final colors = _Color();
  static const apiKey = 'DEB67FCF7320B43B63500F664CDBC648';
  static const steamWebApiKey =
      '8RGOUGVG9HSCGCIV'; //https://www.steamwebapi.com/dashboard
}

class _Color {
  final primaryColor = const Color(0xFF000000);
  final primaryTextColor = const Color(0xFFFFFFFF);
  final accentTextColor = const Color(0xFFbf8700);
  final accentColor = const Color.fromARGB(255, 26, 110, 143);
}
