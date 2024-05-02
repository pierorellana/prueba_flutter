import 'package:animate_do/animate_do.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_flutter/modules/security/login/pages/login_page.dart';
import '../../env/theme/app_theme.dart';
import '../helpers/global_helpers.dart';
import '../provider/functional_provider.dart';
import 'alert_modal.dart';

class HomeLayoutWidget extends StatefulWidget {
  const HomeLayoutWidget({
    super.key,
    required this.child,
    this.requiredStack = true,
    this.keyDismiss,
    this.requiredBottonNavigatorBar = true,
    this.nameInterceptor,
    this.hasScrollBody = false,
  });
  final Widget child;
  final bool requiredStack;
  final GlobalKey<State<StatefulWidget>>? keyDismiss;
  final String? nameInterceptor;
  final bool? requiredBottonNavigatorBar;
  final bool hasScrollBody;

  @override
  State<HomeLayoutWidget> createState() => _HomeLayoutWidgetState();
}

class _HomeLayoutWidgetState extends State<HomeLayoutWidget> {
  ScrollController _scrollController = ScrollController();
  late FunctionalProvider fp;

  @override
  void initState() {
    BackButtonInterceptor.add(_backButton,
        name: widget.nameInterceptor, context: context);
    _scrollController = ScrollController();
    fp = Provider.of<FunctionalProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName(widget.nameInterceptor.toString());
    super.dispose();
  }

  Future<bool> _backButton(bool button, RouteInfo info) async {
    if (widget.nameInterceptor != null) {
      final fp = Provider.of<FunctionalProvider>(context, listen: false);
      if (mounted) {
        if (button) return false;
        if (fp.alertLoading.isNotEmpty ||
            (fp.alerts.last.key != widget.keyDismiss)) {
          return false;
        }
        fp.dismissAlert(key: widget.keyDismiss!);
      }
      return true;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                toolbarHeight: size.height * 0.08,
                backgroundColor: AppTheme.primaryColor,
                surfaceTintColor: AppTheme.primaryColor,
                centerTitle: true,
                leadingWidth: 80,
                title: Consumer<FunctionalProvider>(
                  builder: (context, auth, _) {
                    return auth.isAdmin || auth.isUser
                        ? Text(auth.isAdmin ? "Administrador" : "Usuario")
                        : const SizedBox.shrink();
                  },
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(35)),
                ),
                actions: [
                  if (fp.isAdmin || fp.isUser)
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      final loginKey = GlobalHelper.genKey();
                      fp.clearAllAlert();
                      fp.addPage(
                          key: loginKey,
                          content: LoginPage(
                            keyPage: loginKey,
                            key: loginKey,
                          ));
                    },
                  ),
                ],
              ),
              if (widget.requiredBottonNavigatorBar!)
                SliverFillRemaining(
                  hasScrollBody: widget.hasScrollBody,
                  child: BounceInUp(
                    delay: const Duration(milliseconds: 100),
                    child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: widget.child),
                  ),
                ),
            ],
          ),
          if (widget.requiredStack) const AlertModal(),
        ],
      ),
    );
  }
}
