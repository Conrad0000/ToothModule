/**
 * @Author: Dana Buehre <creaturesurvive>
 * @Date:   15-09-2017 12:21:47
 * @Email:  dbuehre@me.com
 * @Filename: CSPHeaderView.m
 * @Last modified by:   creaturesurvive
 * @Last modified time: 15-09-2017 3:38:25
 * @Copyright: Copyright © 2014-2017 CreatureSurvive
 */
#include "CSPHeaderView.h"
#include <UIColor+ColorFromHex.h>

@implementation CSPHeaderView

- (CSPHeaderView *)initWithSpecifier:(PSSpecifier *)specifier tableWidth:(CGFloat)tableWidth {
    if ((self = [[CSPHeaderView alloc] init])) {
        _headerString = [[specifier propertyForKey:@"headerString"] stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
        if (!_headerString) return nil;

        _fontName = [specifier propertyForKey:@"fontName"];
        _primaryFontSize = [specifier propertyForKey:@"primaryFontSize"] ? [[specifier propertyForKey:@"primaryFontSize"] floatValue] : 36.0f;
        _secondaryFontSize = [specifier propertyForKey:@"secondaryFontSize"] ? [[specifier propertyForKey:@"secondaryFontSize"] floatValue] : 17.0f;
        _primaryColor = [specifier propertyForKey:@"primaryColor"] ? [UIColor colorFromHexString:[specifier propertyForKey:@"primaryColor"]] : [UIColor darkTextColor];
        _secondaryColor = [specifier propertyForKey:@"secondaryColor"] ? [UIColor colorFromHexString:[specifier propertyForKey:@"secondaryColor"]] : [[UIColor darkTextColor] colorWithAlphaComponent:0.6f];


        NSMutableParagraphStyle *attributedStringParagraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        attributedStringParagraphStyle.alignment = NSTextAlignmentCenter;
        attributedStringParagraphStyle.lineSpacing = 2.0;

        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_headerString];
        NSArray *lines = [_headerString componentsSeparatedByString:@"\n"];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:attributedStringParagraphStyle range:NSMakeRange(0, _headerString.length - 1)];
        for (NSString *line in lines) {
            if (line == lines[0]) {
                [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_fontName size:_primaryFontSize] range:[_headerString rangeOfString:line]];
                [attributedString addAttribute:NSForegroundColorAttributeName value:_primaryColor range:[_headerString rangeOfString:line]];
            } else {
                [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:_fontName size:_secondaryFontSize] range:[_headerString rangeOfString:line]];
                [attributedString addAttribute:NSForegroundColorAttributeName value:_secondaryColor range:[_headerString rangeOfString:line]];
            }
        }

        _headerLabel = [[UILabel alloc] init];
        _headerLabel.attributedText = attributedString;
        _headerLabel.backgroundColor = [UIColor clearColor];
        _headerLabel.numberOfLines = 0;
        _headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_headerLabel sizeToFit];
        [self addSubview:_headerLabel];
        [self setFrame:CGRectMake(0, 0, tableWidth, _headerLabel.bounds.size.height + 40)];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_headerLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headerLabel)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_headerLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    }

    return self;
}

@end
