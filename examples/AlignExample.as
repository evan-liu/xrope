package
{
    import xrope.AlignLayout;
    import xrope.LayoutAlign;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.text.TextField;
    [SWF(width="300", height="200", backgroundColor="0xFFFFFF", frameRate="30")]
    /**
     * @author eidiot
     */
    public class AlignExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function AlignExample()
        {
            const MARGIN:int = 10;
            var group:AlignLayout = new AlignLayout(this, MARGIN, MARGIN,
                                                    stage.stageWidth - MARGIN * 2,
                                                    stage.stageHeight - MARGIN * 2);
            group.addTo(getLabel("Name"), LayoutAlign.TOP_LEFT);
            group.addTo(getLabel("Logo"), LayoutAlign.TOP_LEFT);
            group.addTo(getLabel("Navigator 2"), LayoutAlign.TOP_RIGHT);
            group.addTo(getLabel("Navigator 1"), LayoutAlign.TOP_RIGHT);
            group.addTo(getLabel("Content"), LayoutAlign.CENTER);
            group.addTo(getLabel("Footer"), LayoutAlign.BOTTOM);
            group.addTo(getLabel("Copy Right"), LayoutAlign.BOTTOM_RIGHT);
            group.layout();
        }
        //======================================================================
        //  Private methods
        //======================================================================
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
