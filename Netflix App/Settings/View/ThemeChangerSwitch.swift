//
//  ThemeChangerSwitch.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.04.2024.
//

import UIKit

/// Горизонтальная позиция
enum HorizontalPosition {
    case left
    case right
}

protocol IThemeChangerSwitchPresenter {
    
    /// Обработка изменения значения позиции свитча
    func switchMovedTo(position: HorizontalPosition)
}

/// Позволяет менять тему
///  
/// Меняется с градиентом с красного (справа) на синий (слева)
class ThemeChangerSwitch: UIView {
    
    private lazy var presenter: IThemeChangerSwitchPresenter = self
    /// Позволяет включить поведение доводки жеста
    private let snapsToSides = true
    /// Крайняя позиция слайдера
    private var position: HorizontalPosition = .left
    
    /// Определяет жест и место нажатия
    private let panGestureRecognizer = UIPanGestureRecognizer()
    /// Бэкграунд свитча для темной темы
    private let redView = UIView()
    /// Бэкграунд свитча для светлой темы
    private let blueView = UIView()
    /// Отображает наше колесико с которым юзер может взаимодействовать
    private let sliderImageView = UIImageView()
    /// Позволяет сделать вибрацию на какое либо событие
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Обработка жеста
    @objc func handlePanGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        /// Забираем значение координат точки GCPoint - x,y
        /// где по отношению к нашему свитчу происходит нажатие
        var location = panGestureRecognizer.location(in: self)
        /// Чтобы двигать слайдер не с левого края (origin.x) а по середени слайдер
        /// убираем у локации жеста половину ширины слайдера
        location.x -= (self.sliderImageView.frame.width / 2)
        
        /// Проверяем закончил ли юзер нажатие, и включен ли снаппинг (доводчик)
        if snapsToSides && sender.state == .ended {
            /// Узнаем в какую сторону нужно довести слайдер
            if location.x > frame.width / 2.5 {
                /// Доводим враво
                location.x = getSliderHorizontalMovingRange().upperBound
            } else {
                /// Доводим влево
                location.x = getSliderHorizontalMovingRange().lowerBound
            }
            
            /// Включаем анимацию чтобы изменение визуально выглядило плавно
            updateSliderPosition(location: location, animated: true)
        } else {
            /// Тут анимация не нужна ибо обновление мгновенные - идут за событиями жеста
            updateSliderPosition(location: location, animated: false)
        }
    }
    
    
    /// Обновляет позицию слайдера
    /// Уведомляет (в случае если позиция поменялась) презентер о произошедшем событии
    /// - Parameters:
    ///   - location: Точка нажатия - x,y
    ///   - animated: Позволяет включить анимированные изменения
    func updateSliderPosition(location: CGPoint, animated: Bool) {
        /// Ширина для передвижения колесика
        let movingWidth = getSliderHorizontalMovingWidth()
        
        /// Процент позиции слайдера (к максимальному значению)
        ///
        /// Зная его, мы можем менять альфу (прозрачность) у бекграунд вью - синей вью
        /// Так меняя альфу синего вью, нам становится виден нижний вью (красный) - и
        /// создается эффект анимации градиента
        ///
        /// location.x - позиция пальца нажатия по x координате
        /// movingRange - макс диапазон позиции слайдера (ширина)
        ///
        /// Пример: 10 / 100 = 0.1 (или 10 процентов)
        ///
        let sliderMovingPositionPercentange = location.x / movingWidth
        
        /// Если нажатие попадает в рамки диапозона движения колесика, то обрабатываем
        /// если нет - то выходим
        guard getSliderHorizontalMovingRange().contains(location.x) else { return }
        
        ///  Конвертируем значение процентов в позицию слайдера
        ///  меньше 0.5 значит что слайдер тянут влево и наборот
        let horizontalPosition: HorizontalPosition = sliderMovingPositionPercentange < 0.5 ? .left : .right
        
        /// Клоужер анимаций, вынесен в отдельный блок,
        /// чтобы не дублировать код (когда анимация не требуется)
        let animationsBlock = {
            /// Даем знать что скоро запустим вибрацию
            self.feedbackGenerator.prepare()
            /// Смещаем позицию слайдера - таким образом заставляем его
            /// следовать за пальцем в реальном времени
            self.sliderImageView.frame.origin.x = location.x
            
            /// Меняем прозрачность у синего вью
            /// Вычитаем от 1 значение пройденого процента
            ///
            self.blueView.alpha = 1 - sliderMovingPositionPercentange
        }
        
        /// Клоужер completion - будет вызван по окончанию анимации
        let onCompleteBlock = { [weak self] in
            guard let self = self else { return }
            // Сообщаем о событии презентеру только если позиция изменилась
            guard horizontalPosition != self.position else { return }
            
            guard sliderMovingPositionPercentange > 0.8 || sliderMovingPositionPercentange < 0.2 else { return }
            // Сохраняем новое значение позиции
            self.position = horizontalPosition
            // Включаем вибрацию (отдачу)
            self.feedbackGenerator.impactOccurred()
            self.presenter.switchMovedTo(position: horizontalPosition)
        }
        
        if animated {
            UIView.animate(
                withDuration: 0.2,
                animations: animationsBlock,
                completion: { _ in onCompleteBlock() }
            )
        } else {
            // Запускаем изменения сразу не используя анимацию
            animationsBlock()
            onCompleteBlock()
        }
    }
    
    /// `layoutSubviews` - вызывается в момент отрисовки subviews.
    ///
    /// На момент init() frame у свитча нулевой. Так как автолейаут еще не отрисовал свитч.
    /// Поэтому чтобы забрать значения фрейма, мы используем овверайд этого метода
    /// тут мы точно уверены что можем получить значение frame
    override func layoutSubviews() {
        super.layoutSubviews()
        redView.frame = self.bounds
        blueView.frame = self.bounds
    }
}

extension ThemeChangerSwitch {
    
    /// Отступ слайдера от основного вью
    private static let sliderInset: CGFloat = 1.5
    
    /// Минимальная позиция слайдера по горизонтали - слева (начало колесика - слайдера)
    private func getSliderMininimumX() -> CGFloat {
        /// Ноль это начало позиции + отступ слева, чтобы колесико не липло к краю (по дизайну)
        0 + Self.sliderInset
    }
    
    /// Максимальная позиция слайдера по горизонтали - справа (конец колесика - слайдера)
    private func getSliderMaximumX() -> CGFloat {
        /*
         1. Берем всю ширину свитча
         2. Вычитаем из нее ширину самого колесика
         3. И вычитаем 1.5 (подобрали значение) - так чтобы выглядило как в дизайне,
            чтобы колесо не доходило до конца свитча
        */
        self.frame.width - sliderImageView.frame.width - 1.5
    }
    
    /// Просчитываем сколько у нас есть свободного места
    /// для движения колесика (ширина воображаемой линии)
    private func getSliderHorizontalMovingWidth() -> CGFloat {
        getSliderMaximumX() - getSliderMininimumX()
    }
    
    /// Диапозон свободного места для передвижения колесика
    /// Относительно фрейма всего свитча
    private func getSliderHorizontalMovingRange() -> ClosedRange<CGFloat> {
        getSliderMininimumX()...getSliderMaximumX()
    }
}

extension ThemeChangerSwitch {
    
    /// Настройка интерфейса
    private func setupViews() {
        self.backgroundColor = .brown
        self.clipsToBounds = true
        panGestureRecognizer.addTarget(self, action: #selector(handlePanGestureRecognizer))
        sliderImageView.addGestureRecognizer(panGestureRecognizer)
        self.addSubview(redView)
        self.addSubview(blueView)
        self.addSubview(sliderImageView)
        redView.backgroundColor = UIColor(red: 255/255, green: 69/255, blue: 58/255, alpha: 1)
        blueView.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        sliderImageView.backgroundColor = .white
        sliderImageView.image = UIImage(named: "switch-slider")!
        sliderImageView.contentMode = .scaleAspectFill
        sliderImageView.isUserInteractionEnabled = true
        sliderImageView.clipsToBounds = true
        let sliderSize = 30 as CGFloat
        sliderImageView.frame = CGRect(x: Self.sliderInset, y: Self.sliderInset, width: sliderSize, height: sliderSize)
        // получим 30 / 2 = 15 чтобы сделать полностью круглым вью
        sliderImageView.layer.cornerRadius = sliderSize / 2
    }
}

extension ThemeChangerSwitch: IThemeChangerSwitchPresenter {
    
    /// Меняем тему
    func switchMovedTo(position: HorizontalPosition) {
        let theme: InterfaceTheme = (position == .left) ? .light : .dark
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.overrideUserInterfaceStyle = (theme == .light) ? .light : .dark
    }
}
