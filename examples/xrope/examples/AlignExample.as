package xrope.examples
{
    import xface.XFace;

    import xrope.AlignLayout;
    import xrope.LayoutAlign;
    import xrope.examples.helper.ExampleHelpler;

    import flash.display.DisplayObject;
    import flash.text.TextField;

    public class AlignExample
    {
        [Test]
        public function test():void
        {
            var group:AlignLayout = new AlignLayout(XFace.container, 380, 380, 10, 10);
            group.addTo(getLabel("Name"), LayoutAlign.TOP_LEFT);
            group.addTo(getLabel("Logo"), LayoutAlign.TOP_LEFT);
            group.addTo(getLabel("Navigator 2"), LayoutAlign.TOP_RIGHT);
            group.addTo(getLabel("Navigator 1"), LayoutAlign.TOP_RIGHT);
            group.addTo(getLabel("Content"), LayoutAlign.CENTER);
            group.addTo(getLabel("Footer"), LayoutAlign.BOTTOM);
            group.addTo(getLabel("Copy Right"), LayoutAlign.BOTTOM_RIGHT);
            group.layout();

            ExampleHelpler.fillGroup(group);
        }
        private function getLabel(text:String, w:Number = -1):DisplayObject
        {
            var tf:TextField = new TextField();
            tf.text = text;
            tf.width = w > 0 ? w : tf.textWidth + 4;
            tf.height = tf.textHeight + 4;
            tf.mouseEnabled = false;
            return tf;
        }
    }
}