package
{
    import xrope.AlignLayout;
    import xrope.LayoutAlign;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
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
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            layout();
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var group:AlignLayout;
        //======================================================================
        //  Private methods
        //======================================================================
        private function layout():void
        {
            group = new AlignLayout(this, stage.stageWidth - 20,
                                    stage.stageHeight - 20, 10, 10);
            group.addTo(getLabel("Name"), LayoutAlign.TOP_LEFT);
            group.addTo(getLabel("Logo"), LayoutAlign.TOP_LEFT);
            group.addTo(getLabel("Navigator 2"), LayoutAlign.TOP_RIGHT);
            group.addTo(getLabel("Navigator 1"), LayoutAlign.TOP_RIGHT);
            group.addTo(getLabel("Content"), LayoutAlign.CENTER);
            group.addTo(getLabel("Footer"), LayoutAlign.BOTTOM);
            group.addTo(getLabel("Copy Right"), LayoutAlign.BOTTOM_RIGHT);
            group.layout();
            //
            stage.addEventListener(Event.RESIZE, stage_resizeHandler);
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
        //======================================================================
        //  Event handlers
        //======================================================================
        private function stage_resizeHandler(event:Event):void
        {
            group.width = stage.stageWidth - 20;
            group.height = stage.stageHeight - 20;
        }
    }
}
