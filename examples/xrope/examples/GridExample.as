package xrope.examples
{
    import xface.XFace;

    import xrope.GridLayout;
    import xrope.LayoutAlign;
    import xrope.examples.helper.ExampleHelpler;

    import com.bit101.components.RadioButton;

    import flash.events.MouseEvent;

    public class GridExample
    {
        private var gridLayout:GridLayout;

        [Test]
        public function test():void
        {
            const MARGIN:Number = 10;
            const BOX_Y:Number = 25;
            const BOX_WIDTH:Number = 380;
            const BOX_HEIGHT:Number = 350;
            const TILE_WIDTH:Number = 40;
            const TILE_HEIGHT:Number = 40;
            gridLayout = new GridLayout(XFace.container, BOX_WIDTH, BOX_HEIGHT, TILE_WIDTH, TILE_HEIGHT, MARGIN, BOX_Y);
            gridLayout.useBounds = true;
            for (var i:int = 0; i < 30; i++)
            {
                gridLayout.add(ExampleHelpler.getShape());
            }
            gridLayout.layout();
            drawGroups();

            XFace.addLabel("Box Align:");
            for each (var boxAlign:String in ExampleHelpler.ALL_ALIGNS)
            {
                XFace.addRadioButton(boxAlign, boxAlignSelector_clickHandler,
                                     boxAlign == LayoutAlign.TOP_LEFT, "boxAlign");
            }
            XFace.addLabelToBottom("Tile Align:");
            for each (var tileAlign:String in ExampleHelpler.ALL_ALIGNS)
            {
                XFace.addRadioButtonToBottom(tileAlign, tileAlignSelector_clickHandler,
                                             boxAlign == LayoutAlign.TOP_LEFT, "tileAlign");
            }
        }

        private function drawGroups():void
        {
            ExampleHelpler.clearGroupGraphics(gridLayout);
            ExampleHelpler.fillGroup(gridLayout);
            ExampleHelpler.drawElementsRim(gridLayout);
        }

        private function boxAlignSelector_clickHandler(event:MouseEvent):void
        {
            gridLayout.align = RadioButton(event.target).label;
            drawGroups();
        }
        private function tileAlignSelector_clickHandler(event:MouseEvent):void
        {
            gridLayout.tileAlign = RadioButton(event.target).label;
        }
    }
}