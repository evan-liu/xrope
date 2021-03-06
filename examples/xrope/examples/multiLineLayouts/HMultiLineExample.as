package xrope.examples.multiLineLayouts
{
    import xface.XFace;

    import xrope.HMultiLineLayout;
    import xrope.ILayoutGroup;
    import xrope.LayoutAlign;
    import xrope.examples.helper.ExampleHelpler;

    import com.bit101.components.CheckBox;
    import com.bit101.components.ComboBox;
    import com.bit101.components.RadioButton;

    import flash.events.Event;
    import flash.events.MouseEvent;
    /**
     * @author eidiot
     */
    public class HMultiLineExample
    {

        private var multiLineLayout:HMultiLineLayout;
        private var drawLineSelector:CheckBox;

        [Test]
        public function test():void
        {
            const MARGIN:Number = 10;
            const BOX_Y:Number = 50;
            const BOX_WIDTH:Number = 380;
            const BOX_HEIGHT:Number = 330;
            const LINE_HEIGHT:Number = 50;
            multiLineLayout = new HMultiLineLayout(XFace.container, BOX_WIDTH, BOX_HEIGHT, LINE_HEIGHT, MARGIN, BOX_Y);
            multiLineLayout.useBounds = true;
            for (var i:int = 0; i < 50; i++)
            {
                multiLineLayout.add(ExampleHelpler.getShape());
            }
            multiLineLayout.layout();

            XFace.addLabel("Top Align:");
            for each (var topAlign:String in ExampleHelpler.ALL_ALIGNS)
            {
                XFace.addRadioButton(topAlign, topAlignSelector_clickHandler,
                                     topAlign == ExampleHelpler.ALL_ALIGNS[0], "topAlign");
            }

            XFace.addLabelToBottom("Line Align:");
            var lineAligns:Array = [LayoutAlign.TOP, LayoutAlign.CENTER, LayoutAlign.BOTTOM];
            for each (var lineAlign:String in lineAligns)
            {
                XFace.addRadioButtonToBottom(lineAlign, lineAlignSelector_clickHandler,
                                             lineAlign == lineAligns[0], "lineAlign");
            }

            XFace.newLineForControls();
            XFace.addLabel("Line height:");
            XFace.addComboBox("50", [40, 50, 60], function (event:Event):void {
                multiLineLayout.lineHeight = Number(ComboBox(event.target).selectedItem);
                drawGroups();
            });

            XFace.addSpace();
            XFace.addLabel("Line gap:");
            XFace.addComboBox("5", [5, 10, 15], function (event:Event):void {
                multiLineLayout.verticalGap = Number(ComboBox(event.target).selectedItem);
                drawGroups();
            });

            XFace.addSpaceToBottom();
            drawLineSelector = XFace.addCheckBoxToBottom("Draw line rim", function():void {
                drawGroups();
            }, true);

            drawGroups();
        }

        private function drawGroups():void
        {
            ExampleHelpler.clearGroupGraphics(multiLineLayout);
            ExampleHelpler.fillGroup(multiLineLayout);

            if (drawLineSelector.selected)
            {
                for each (var line:ILayoutGroup in multiLineLayout.lines)
                {
                    ExampleHelpler.drawGroupRim(line);
                }
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