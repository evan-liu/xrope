package xrope.examples
{
    import com.bit101.components.CheckBox;
    import xface.XFace;

    import xrope.GridLayout;
    import xrope.LayoutAlign;
    import xrope.examples.helper.ExampleHelpler;

    import com.bit101.components.ComboBox;
    import com.bit101.components.RadioButton;

    import flash.events.Event;
    import flash.events.MouseEvent;

    public class GridExample
    {
        private var gridLayout:GridLayout;
        private var drawTileSelector:CheckBox;

        [Test]
        public function test():void
        {
            const MARGIN:Number = 10;
            const BOX_Y:Number = 75;
            const BOX_WIDTH:Number = 380;
            const BOX_HEIGHT:Number = 305;
            const TILE_WIDTH:Number = 40;
            const TILE_HEIGHT:Number = 40;
            gridLayout = new GridLayout(XFace.container, BOX_WIDTH, BOX_HEIGHT, TILE_WIDTH, TILE_HEIGHT, MARGIN, BOX_Y);
            gridLayout.useBounds = true;
            for (var i:int = 0; i < 25; i++)
            {
                gridLayout.add(ExampleHelpler.getShape());
            }
            gridLayout.layout();

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
                                             tileAlign == LayoutAlign.TOP_LEFT, "tileAlign");
            }

            XFace.newLineForControls();
            XFace.addLabel("Tile width");
            XFace.addComboBox("40", [35, 40, 45], function (event:Event):void {
                gridLayout.tileWidth = Number(ComboBox(event.target).selectedItem);
                drawGroups();
            });

            XFace.addSpace();
            XFace.addLabel("Tile height");
            XFace.addComboBox("40", [35, 40, 45], function (event:Event):void {
                gridLayout.tileHeight = Number(ComboBox(event.target).selectedItem);
                drawGroups();
            });

            XFace.newLineForControls();
            XFace.addLabel("Horizontal gap:");
            XFace.addComboBox("5", [5, 10, 15], function (event:Event):void {
                gridLayout.horizontalGap = Number(ComboBox(event.target).selectedItem);
                drawGroups();
            });

            XFace.addSpace();
            XFace.addLabel("Vertical gap:");
            XFace.addComboBox("5", [5, 10, 15], function (event:Event):void {
                gridLayout.verticalGap = Number(ComboBox(event.target).selectedItem);
                drawGroups();
            });

            XFace.addSpaceToBottom();
            drawTileSelector = XFace.addCheckBoxToBottom("Draw tile rim", function (event:Event):void {
                drawGroups();
            }, true);

            drawGroups();
        }

        private function drawGroups():void
        {
            ExampleHelpler.clearGroupGraphics(gridLayout);
            ExampleHelpler.fillGroup(gridLayout);
            if (drawTileSelector.selected)
            {
                ExampleHelpler.drawElementsRim(gridLayout);
            }
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