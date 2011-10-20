package xrope.examples.boxLayouts
{
    import xface.XFace;

    import xrope.LayoutAlign;
    import xrope.VBoxLayout;
    import xrope.examples.helper.ExampleHelpler;

    import com.bit101.components.RadioButton;

    import flash.events.MouseEvent;

    /**
     * @author eidiot
     */
    public class VBoxExample
    {
        private var boxLayout:VBoxLayout;

        [Test]
        public function test():void
        {
            const MARGIN:Number = 10;
            const BOX_Y:Number = 25;
            const BOX_WIDTH:Number = 380;
            const BOX_HEIGHT:Number = 350;
            boxLayout = new VBoxLayout(XFace.container, BOX_WIDTH, BOX_HEIGHT, MARGIN, BOX_Y);
            boxLayout.useBounds = true;
            for (var i:int = 0; i < 40; i++)
            {
                boxLayout.add(ExampleHelpler.getShape());
            }
            boxLayout.layout();
            ExampleHelpler.fillGroup(boxLayout);

            //-- Controls
            XFace.addLabel("Box Align:");
            for each (var boxAlign:String in ExampleHelpler.ALL_ALIGNS)
            {
                XFace.addRadioButton(boxAlign, boxAlignSelector_clickHandler,
                                     boxAlign == ExampleHelpler.ALL_ALIGNS[0], "boxAlign");
            }
            XFace.addLabelToBottom("Line Align:");
            var lineAligns:Array = [LayoutAlign.LEFT, LayoutAlign.CENTER, LayoutAlign.RIGHT];
            for each (var lineAlign:String in lineAligns)
            {
                XFace.addRadioButtonToBottom(lineAlign, lineAlignSelector_clickHandler,
                                             lineAlign == lineAligns[0], "lineAlign");
            }
        }
        private function boxAlignSelector_clickHandler(event:MouseEvent):void
        {
            boxLayout.align = RadioButton(event.target).label;
        }
        private function lineAlignSelector_clickHandler(event:MouseEvent):void
        {
            boxLayout.lineAlign = RadioButton(event.target).label;
        }
    }
}