package xrope.examples.fillLineLayouts
{
    import flash.events.Event;
    import com.bit101.components.CheckBox;
    import com.bit101.components.RadioButton;
    import xface.XFace;

    import xrope.HFillLineLayout;
    import xrope.LayoutAlign;
    import xrope.examples.helper.ExampleHelpler;

    import flash.events.MouseEvent;
    public class HFillLineExample
    {
        private var fillLineLayout:HFillLineLayout;

        [Test]
        public function test():void
        {
            fillLineLayout = new HFillLineLayout(XFace.container, 380,  50, 10, 50);
            fillLineLayout.useBounds = true;
            for (var i:int = 0; i < 3; i++)
            {
                fillLineLayout.add(ExampleHelpler.getShape());
            }
            fillLineLayout.layout();
            ExampleHelpler.fillGroup(fillLineLayout);

            XFace.addLabel("Align:");
            var aligns:Array = [LayoutAlign.TOP, LayoutAlign.CENTER, LayoutAlign.BOTTOM];
            for each (var align:String in aligns)
            {
                XFace.addRadioButton(align, alignSelector_clickHandler,
                                     align == aligns[1], "align");
            }

            XFace.addSpace(50);
            XFace.addButton("Add", function(event:MouseEvent):void {
                fillLineLayout.add(ExampleHelpler.getShape());
            });
            XFace.addButton("Remove", function(event:MouseEvent):void {
                if (fillLineLayout.container.numChildren > 0)
                {
                    fillLineLayout.remove(fillLineLayout.container.getChildAt(0));
                }
            });

            XFace.addSpace(50);
            XFace.addCheckBox("Use margin", function(event:Event):void {
                fillLineLayout.useMargin = CheckBox(event.target).selected;
            }, true);
        }

        private function alignSelector_clickHandler(event:MouseEvent):void
        {
            fillLineLayout.align = RadioButton(event.target).label;
        }
    }
}