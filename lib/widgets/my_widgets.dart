import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rich_ex/style/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

abstract class BaseWidget extends StatelessWidget {
  final dynamic args;
  const BaseWidget({Key? key, this.args}) : super(key: key);
}

class MyButton extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;
  final String? text;
  final double? textSize;
  final Color? textColor;
  final Color? color;
  final BoxBorder? border;
  final dynamic round;
  final bool? gray;
  final Function()? onTap;
  final Color? gStart;
  final Color? gEnd;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;
  final Alignment? alignment;

  MyButton({
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.child,
    this.text,
    this.textSize,
    this.textColor,
    this.color,
    this.border,
    this.round,
    this.gray,
    this.onTap,
    this.gStart,
    this.gEnd,
    this.boxShadow,
    this.borderRadius,
    this.gradient,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    var width = this.width;
    var height = this.height;
    var padding = this.padding;
    var color = gray == true ? C.whiteGrey : this.color;
    var child = this.child;
    if (child == null) {
      if (padding == null) {
        if (width == null) padding = MyInsets(horizontal: 10);
        height ??= 50;
      }
      var textColor = this.textColor;
      textColor ??= color?.alpha == 0
          ? C.mainColor
          : (gray == true ? C.mainColor : C.mainColor);
      child = MyText(
        text ?? "",
        color: textColor,
        size: textSize ?? 14,
        bold: true,
        align: TextAlign.center,
      );
    }
    var border = () {
      if (this.border == null || this.border == false) return null;
      if (this.border is BoxBorder) return this.border;
    }();
    Widget v = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment ?? Alignment.center,
      child: child,
      decoration: BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius ?? () {
          var round = this.round;
          if (round == 0 || round == false) return null;
          if (round is BorderRadiusGeometry) return round;
          return BorderRadius.circular(
            round is double ? round : (round == null ? 5 : 999),
          );
        }(),
        gradient: gradient ?? () {
          if (color != null) return null;
          return LinearGradient(
            stops: [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [gStart ?? C.priColor, gEnd ?? C.priColor],
          );
        }(),
        boxShadow: boxShadow
      ),
    );
    if (onTap != null) {
      v = GestureDetector(
        behavior: HitTestBehavior.opaque,
        // onTap: debounceBtn(func: onTap),
        onTap: onTap,
        child: v,
        onDoubleTap: () {},
      );
    }
    return v;
  }
}

class MyAppBar extends AppBar {
  MyAppBar(String data,
      {VoidCallback? leftCallback,
        bool? leftShow = true,
        Widget? leftIc,
        Widget? centerTitle,
        Color? tC,
        Color? bC,
        bool? isCenter = false,
        bool? showDivider = false,
        List<Widget>? actions
      }) : super(
    centerTitle: isCenter,
    leading: InkWell(
      onTap: leftCallback ?? () {Get.back();},
      child: (leftShow == true )? leftIc ??  Container(
          height: 60.w,
          margin: MyInsets(left: 16.w),
          alignment: Alignment.centerLeft,
          child: Icon(Icons.arrow_back,size: 20,color: C.f131a22,)
      ): const SizedBox(),
    ),
    title: centerTitle ?? MyText(data,size: 17,color: tC ?? C.f131a22,bold: true,),
    titleSpacing: 0.w,
    backgroundColor: bC ?? C.white,
    shadowColor: showDivider == true ? null : Colors.transparent,
    actions: actions,
    elevation: showDivider == true ? 0.5 : 0,
  );
}

class MyText extends Text {
  MyText(
      String data, {
        double? size,
        Color? color,
        bool? bold,
        FontWeight? weight,
        TextOverflow? overflow = TextOverflow.ellipsis,
        TextAlign? align,
        double? lineHeight,
        int? maxLines,
        StrutStyle? strutStyle,
        TextDecoration decoration = TextDecoration.none,
      }) : super(
      data,
      overflow: overflow,
      textAlign: align,
      style: TextStyle(
        fontSize: size ?? 14.sp,
        color: color ?? C.f333,
        fontWeight: weight ?? (bold == true ? FontWeight.bold : null),
        height: lineHeight ?? 1.2,
        decoration: decoration
      ),
      maxLines: maxLines ?? 10,
      strutStyle: strutStyle,
  );
}

// 重复点击
Function() debounceBtn({Function()? func, Duration delay = const Duration(milliseconds: 1000),}) {
  Timer? timer;
  target() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(delay, () {
      func?.call();
    });
  }
  return target;
}

class MyTextField extends TextField {
  MyTextField(
      {Key? key,
        TextEditingController? controller,
        TextStyle? style,
        TextStyle? hintStyle,
        InputDecoration? decoration,
        String? hintText,
        int? maxLength,
        int? maxLines,
        int? minLines,
        ValueChanged<String>? onSubmitted,
        VoidCallback? onEditingComplete,
        VoidCallback? onTap,
        ValueChanged<String>? onChanged,
        bool? obscureText,
        bool? enabled,
        bool? autofocus,
        TextAlign? align,
        List<TextInputFormatter>? inputFormatter,
        TextInputType? keyboardType,
        Widget? suffixIcon,
        Widget? prefixIcon,
        BorderRadius? borderRadius,
        EdgeInsetsGeometry? contentPadding,
      })
      : super(
      key: key,
      style: style ?? const TextStyle(fontSize: 14, color: Colors.black),
      controller: controller,
      obscureText: obscureText ?? false,
      enabled: enabled ?? true,
      autofocus: autofocus ?? true,
      textAlign: align ?? TextAlign.start,
      keyboardType: keyboardType,
      decoration: decoration ??
          InputDecoration(
            contentPadding: contentPadding ?? EdgeInsets.zero,
            isCollapsed: true,
            hintStyle:hintStyle ?? TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5),),
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: C.ff6f6f6,width: 1),
              borderRadius: borderRadius ?? BorderRadius.circular(24),
            ),
            fillColor: C.ff6f6f6,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: C.ff6f6f6,width: 1),
              borderRadius: borderRadius ?? BorderRadius.circular(24),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: C.ff6f6f6,width: 1),
                borderRadius: borderRadius ?? BorderRadius.circular(24)
            ),
          ),
      inputFormatters: (inputFormatter !=null) ? inputFormatter : (maxLength ?? 0) == 0 ? [] : [LengthLimitingTextInputFormatter(maxLength)],
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textAlignVertical: TextAlignVertical.center,
      onEditingComplete: onEditingComplete,
  );
}

class CardView extends StatelessWidget {
  final double? width;
  final double? height;
  final String? icon;
  final String? label;
  final String? value;
  final bool? accent;
  final Widget? child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function()? onTap;
  final Color? bgColor;
  final Alignment? alignment;
  final double? offset;

  const CardView({
    Key? key,
    this.width,
    this.height,
    this.icon,
    this.label,
    this.value,
    this.accent,
    this.child,
    this.margin,
    this.padding,
    this.onTap,
    this.bgColor,
    this.alignment,
    this.offset
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = this.height;
    var margin = this.margin;
    var padding = this.padding;
    var child = this.child;
    child = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor ?? C.priColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: C.whiteBg,
              offset: Offset(0, offset ?? 3),
              blurRadius: 6
          )
        ],
//        boxShadow: <BoxShadow>[
//          BoxShadow(
//            color: const Color(0x33000000),
//            offset: Offset(0.0, 3.0),
//            blurRadius: 5.0,
//          ),
//        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
      alignment: alignment,
    );
    if (onTap != null) {
      child = GestureDetector(
        onTap: onTap,
        child: child,
        behavior: HitTestBehavior.opaque,
      );
    }
    return child;
  }
}

class MyInsets extends EdgeInsets {
  const MyInsets({
    double? all,
    double? vertical,
    double? horizontal,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) : super.only(
    left: left ?? horizontal ?? all ?? 0,
    top: top ?? vertical ?? all ?? 0,
    right: right ?? horizontal ?? all ?? 0,
    bottom: bottom ?? vertical ?? all ?? 0,
  );
}

class MyCard extends Container {
  MyCard({super.key, required Widget child,double? height,double? width,double radius = 10,
    EdgeInsetsGeometry? padding,EdgeInsetsGeometry? margin, Color? bg,AlignmentGeometry? alignment,
    GestureTapCallback? onTap,BoxBorder? border,
    }) : super(
    decoration: BoxDecoration(
        color: bg?? C.white,
        borderRadius: BorderRadius.circular(radius),
        border: border,
    ),
    height: height,
    width: width ?? double.infinity,
    alignment: alignment ?? Alignment.centerLeft,
    padding: padding ?? MyInsets(horizontal: 15.w,top: 15.h,bottom: 15.h),
    margin: margin,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    ),
  );
}

class MyGestureDetector extends GestureDetector {
  MyGestureDetector({super.key,required Function()? onTap,required Widget child,}) : super(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: child,
  );
}

class MyDefaultImg extends Container {
  MyDefaultImg({super.key,double? height,double? width,double radius = 0,}) : super(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: C.mainColor,
        borderRadius: BorderRadius.circular(radius)
    ),

  );
}