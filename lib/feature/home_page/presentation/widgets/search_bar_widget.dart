import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_helper.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getMargin(
          context: context,
          mobile: 16.0,
          tablet: 20.0,
          desktop: 24.0,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.getPadding(
          context: context,
          mobile: 16.0,
          tablet: 18.0,
          desktop: 20.0,
        ),
        vertical: ResponsiveHelper.getPadding(
          context: context,
          mobile: 12.0,
          tablet: 14.0,
          desktop: 16.0,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.getBorderRadius(
            context: context,
            mobile: 8.0,
            tablet: 10.0,
            desktop: 12.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context: context,
                  mobile: 14.0,
                  tablet: 16.0,
                  desktop: 18.0,
                ),
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Search food or restaurant here...',
                hintStyle: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context: context,
                    mobile: 14.0,
                    tablet: 16.0,
                    desktop: 18.0,
                  ),
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _performSearch(value);
                }
              },
              onChanged: (value) {
                // You can add real-time search functionality here
                // For now, we'll just handle the search on submit
              },
            ),
          ),
          if (_searchController.text.isNotEmpty) ...[
            SizedBox(
              width: ResponsiveHelper.getWidth(
                context: context,
                mobile: 8.0,
                tablet: 10.0,
                desktop: 12.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _focusNode.unfocus();
                setState(() {});
              },
              child: Icon(
                Icons.clear,
                color: Colors.grey[400],
                size: ResponsiveHelper.getIconSize(
                  context: context,
                  mobile: 18.0,
                  tablet: 20.0,
                  desktop: 22.0,
                ),
              ),
            ),
            SizedBox(
              width: ResponsiveHelper.getWidth(
                context: context,
                mobile: 8.0,
                tablet: 10.0,
                desktop: 12.0,
              ),
            ),
          ],
          Icon(
            Icons.search,
            color: Colors.grey[400],
            size: ResponsiveHelper.getIconSize(
              context: context,
              mobile: 20.0,
              tablet: 22.0,
              desktop: 24.0,
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch(String query) {
    // Implement search functionality here
    // You can call a search API or filter local data
    print('Searching for: $query');
    
    // Unfocus the text field after search
    _focusNode.unfocus();
    
    // You can add navigation to search results page or 
    // update the state to show search results
  }
}
