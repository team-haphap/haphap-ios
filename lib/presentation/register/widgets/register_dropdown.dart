import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';
import '../../../data/model/register/register_dropdown_item_model.dart';
import '../type/register_dropdown_item_type.dart';

const _maxVisibleItems = 4;
const _itemHeight = 50.0;

/// Android `RegisterDropDown.kt`에 대응.
class RegisterDropDown extends StatefulWidget {
  const RegisterDropDown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.placeholder,
  });

  final List<RegisterDropDownItemModel> items;
  final RegisterDropDownItemModel? selectedItem;
  final ValueChanged<RegisterDropDownItemModel> onItemSelected;
  final String placeholder;

  @override
  State<RegisterDropDown> createState() => _RegisterDropDownState();
}

class _RegisterDropDownState extends State<RegisterDropDown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final selected = widget.selectedItem;
    final triggerBackground = selected != null
        ? AppColors.sub100
        : AppColors.gray100;
    final triggerTextColor = selected != null
        ? AppColors.primary500
        : AppColors.gray600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NoRippleClickable(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: triggerBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selected?.text ?? widget.placeholder,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySemiBold14.copyWith(
                      color: triggerTextColor,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  _isExpanded
                      ? 'assets/icons/register/icn_dropdown_up_30.svg'
                      : 'assets/icons/register/icn_dropdown_down_30.svg',
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                    AppColors.gray600,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height:
                _itemHeight * widget.items.length.clamp(0, _maxVisibleItems) +
                12,
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.separated(
              itemCount: widget.items.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final isSelected = item.id == selected?.id;
                final style = (isSelected
                        ? RegisterDropDownItemType.selected
                        : RegisterDropDownItemType.unselected)
                    .toStyle();

                return NoRippleClickable(
                  onTap: () {
                    widget.onItemSelected(item);
                    setState(() => _isExpanded = false);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: style.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySemiBold14.copyWith(
                        color: style.textColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
