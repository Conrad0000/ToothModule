/**
 * @Author: Dana Buehre <creaturesurvive>
 * @Date:   15-09-2017 12:27:00
 * @Email:  dbuehre@me.com
 * @Filename: CSPHeaderView.h
 * @Last modified by:   creaturesurvive
 * @Last modified time: 15-09-2017 3:19:18
 * @Copyright: Copyright © 2014-2017 CreatureSurvive
 */
#include <Preferences/PSSpecifier.h>

@interface CSPHeaderView : UIView

@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) NSString *headerString;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, strong) UIColor *primaryColor;
@property (nonatomic, strong) UIColor *secondaryColor;
@property (nonatomic) CGFloat primaryFontSize;
@property (nonatomic) CGFloat secondaryFontSize;

- (CSPHeaderView *)initWithSpecifier:(PSSpecifier *)specifier tableWidth:(CGFloat)tableWidth;
// - (void)setHeaderColor:(UIColor *)headerColor secondaryColor:(UIColor *)secondaryColor;

@end
