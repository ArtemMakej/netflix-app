//
//  ThemeChangerSwitchPresenter.swift
//  Netflix App
//
//  Created by Ivan Glushko on 14.04.2024.
//

import Foundation

/// Горизонтальная позиция
enum HorizontalPosition {
    case left
    case right
}

/// Протокол позволяет закрыть зависимость абстракцией
/// Буква `D` из принципов `S.O.L.I.D` - Dependency Inversion Principle (Принцип инверсии зависимостей)
///
/// Это позволит нам внедрять в презентер разные реализации
/// А также позволяет тестировать данный презентер
///
/// Под этот протокол мы подпишем класс `UIApplication` - и в нем реализуем его
protocol InterfaceStyleOverrider {
    func change(theme: InterfaceTheme)
    
    /// Получаем текущую тему интерфейса
    func currentTheme() -> InterfaceTheme
}

/// Протокол описывающий презентер
protocol IThemeChangerSwitchPresenter {
    
    /// Обработка изменения значения позиции свитча
    func switchMovedTo(position: HorizontalPosition)
    
    /// Обработка первой отрисовки вью
    func viewLayoutSubviews()
}

/// Обрабатывает события посылаемые с SwitchView
final class ThemeChangerSwitchPresenter: IThemeChangerSwitchPresenter {
    
    weak var view: IThemeChangerSwitchView?
    
    /// Зависимость которая умеет менять тему
    private let interfaceStyleOverrider: InterfaceStyleOverrider
    
    init(interfaceStyleOverrider: InterfaceStyleOverrider) {
        self.interfaceStyleOverrider = interfaceStyleOverrider
    }
    
    /// Обработка события отрисовки свитча (тут мы можем понять что вью отобразится скоро)
    /// Первым делом устанавливаем значение свитча равное текущей теме
    func viewLayoutSubviews() {
        let currentTheme = interfaceStyleOverrider.currentTheme()
        let position: HorizontalPosition = (currentTheme == .light) ? .left : .right
        view?.set(position: position)
    }
    
    /// Данный метод будет вызван из Свитча когда у нас изменится его значение
    func switchMovedTo(position: HorizontalPosition) {
        let theme: InterfaceTheme = (position == .left) ? .light : .dark
        interfaceStyleOverrider.change(theme: theme)
    }
}
