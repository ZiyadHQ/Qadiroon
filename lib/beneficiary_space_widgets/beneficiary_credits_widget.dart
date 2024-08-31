
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/styled%20widgets/styled_text.dart';

class BeneficiaryCreditsScreen extends StatelessWidget
{
  
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.blueGrey.shade200,
      body: ListView
    (
      children: 
      [
        Center(child: StyledText(text: 'قادرون', size: 48, color: Colors.black87, fontFamily: 'Amiri')),
        StyledText(text: '''

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus posuere purus non tellus volutpat congue. Proin nibh turpis, lacinia ut nisl vitae, lacinia egestas urna. Ut ut hendrerit metus. In iaculis consectetur mollis. Donec commodo ut dolor nec rutrum. Mauris dui odio, viverra a elit cursus, eleifend vulputate tortor. Suspendisse finibus maximus sapien, sit amet rutrum arcu dictum in. Donec et enim ac mauris suscipit bibendum.

Aenean sit amet elit ac enim porta auctor. Morbi fringilla nulla convallis, malesuada metus ut, interdum turpis. Fusce sed consequat tortor, id posuere lectus. In a eros in dui scelerisque fermentum. In ut nibh nisi. Nullam ut eros massa. Curabitur vehicula orci vehicula, aliquet nunc id, rutrum massa. Mauris auctor, lorem quis vestibulum fringilla, metus orci iaculis libero, at laoreet purus quam sit amet erat. Vivamus in facilisis ligula. Vivamus lacinia magna ex, nec mattis sapien viverra eu. Duis tempor suscipit nibh eu mollis. Aliquam vitae nibh a sapien consequat dignissim tempus vitae risus. Curabitur et dapibus lectus, nec imperdiet nisi. Etiam sit amet sagittis sapien. Curabitur dictum ornare nisi, sed finibus orci aliquet bibendum. Donec mattis eget urna sed mollis.

Sed finibus feugiat purus vitae egestas. Pellentesque lectus nibh, pellentesque at elit eu, maximus porta nibh. Vestibulum nec dictum ipsum. Nam quis ante a velit hendrerit malesuada. Cras non lacus justo. In dignissim aliquet turpis sit amet dapibus. Etiam et massa tincidunt, sagittis massa a, viverra libero. Fusce orci purus, volutpat in iaculis commodo, dignissim eget enim. Vestibulum rhoncus dictum sapien, a auctor nibh viverra id. Integer eu augue consectetur, rhoncus felis non, euismod tellus. In vitae volutpat leo, sed aliquet ipsum. Proin non dapibus nibh. Lorem ipsum dolor sit amet, consectetur adipiscing elit.

Aliquam dictum urna eget iaculis consectetur. Praesent accumsan sapien sed dui viverra, in congue lacus consequat. Fusce dui lorem, vehicula a leo a, venenatis eleifend sem. Praesent pretium purus et orci aliquet, ut viverra est gravida. Nulla consequat, leo in commodo euismod, risus felis egestas metus, ac facilisis libero metus non justo. Fusce auctor consequat mauris, eu aliquet eros placerat nec. Donec eu tincidunt tortor. Suspendisse condimentum et dui ac faucibus. Vivamus at tincidunt enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nisl nisl, venenatis nec nisi vel, ornare laoreet arcu. In vel nisl quis ex hendrerit tincidunt sed ac lacus. Donec convallis erat enim, id efficitur ante lobortis eleifend.

Nulla sit amet convallis mauris. Pellentesque eu enim orci. Morbi ac lacus mattis, tempor nibh vitae, ullamcorper lorem. Suspendisse potenti. Aenean ac luctus arcu. Donec rhoncus sit amet metus sed varius. Sed dictum libero lectus, eu ornare ligula suscipit eget. Mauris quam sem, pulvinar vel velit ac, tristique vestibulum elit. Duis pretium interdum tellus ac tempor. Duis id eros eu massa scelerisque gravida. Praesent dui lorem, porta a posuere vel, venenatis eu velit. Cras tincidunt sed libero sed euismod. Etiam vel magna eu justo euismod efficitur. ''', size: 24, color: Colors.black87, fontFamily: 'Amiri'),
        SizedBox(height: 96,)
      ],
    ),
    );
  }
  
}