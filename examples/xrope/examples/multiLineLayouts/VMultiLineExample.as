package xrope.examples.multiLineLayouts
{
    import xface.XFace;

    import xrope.ILayoutGroup;
    import xrope.LayoutAlign;
    import xrope.VMultiLineLayout;
    import xrope.examples.helper.ExampleHelpler;

    import com.bit101.components.RadioButton;

    import flash.events.MouseEvent;

    /**
     * @author eidiot
     */
    public class VMultiLineExample
    {
        private var multiLineLayout:VMultiLineLayout;

        [Test]
        public function test():void
        {
            const MARGIN:Number = 10;
            const BOX_Y:Number = 25;
            const BOX_WIDTH:Number = 380;
            const BOX_HEIGHT:Number = 350;
            const LINE_WIDTH:Number = 50;
            multiLineLayout = new VMultiLineLayout(XFace.container, BOX_WIDTH, BOX_HEIGHT, LINE_WIDTH, MARGIN, BOX_Y);
            multiLineLayout.useBounds = true;
            for (var i:int = 0; i < 50; i++)
            {
                multiLineLayout.add(ExampleHelpler.getShape());
            }
            multiLineLayout.layout();
            drawGroups();

            XFace.addLabel("Top Align:");
            for each (var topAlign:String in ExampleHelpler.ALL_ALIGNS)
            {
                XFace.addRadioButton(topAlign, topAlignSelector_clickHandler,
                                     topAlign == ExampleHelpler.ALL_ALIGNS[0], "topAlign");
            }

            XFace.addLabelToBottom("Line Align:");
            var lineAligns:Array = [LayoutAlign.LEFT, LayoutAlign.CENTER, LayoutAlign.RIGHT];
            for each (var lineAlign:String in lineAligns)
            {
                XFace.addRadioButtonToBottom(lineAlign, lineAlignSelector_clickHandler,
                                             lineAlign == lineAligns[0], "lineAlign");
            }
        }

        private function drawGroups():void
        {
            ExampleHelpler.clearGroupGraphics(multiLineLayout);
            ExampleHelpler.fillGroup(multiLineLayout);
            for each (var line:ILayoutGroup in multiLineLayout.lines)
            {
                ExampleHelpler.drawGroupRim(line);
            }
        }

        private function topAlignSelector_clickHandler(event:MouseEvent):void
        {
            multiLineLayout.align = RadioButton(event.target).label;
            drawGroups();
        }
        private function lineAlignSelector_clickHandler(event:MouseEvent):void
        {
            multiLineLayout.lineAlign = RadioButton(event.target).label;
        }
    }
}