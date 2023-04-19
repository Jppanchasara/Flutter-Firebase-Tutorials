import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool loading;
  const RoundButton({super.key,
  required this.title,
  required this.onPress,
  this.loading=false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        
        height: 50,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10)
    
        ),
        child: Center(child: loading ? 
        const CircularProgressIndicator(
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(Colors.purple),
          strokeWidth: 5,) 
        
        :  Text(this.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,),)),
      ),
    );
  }
}