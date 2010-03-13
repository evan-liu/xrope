package
{
    import xrope.HBoxLayout;
    import xrope.HLineLayout;
    import xrope.ILayoutGroup;
    import xrope.LayoutAlign;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.utils.Dictionary;
    /**
     * @author eidiot
     */
    public class HBoxExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function HBoxExample()
        {
            super();
            demo();
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var selectedBoxAlign:Sprite;
        private var boxAlignBySelector:Dictionary = new Dictionary();
        private var selectedLineAlign:Sprite;
        private var lineAlignBySelector:Dictionary = new Dictionary();
        private var boxLayout:HBoxLayout;
        //======================================================================
        //  Private methods
        //======================================================================
        private function demo():void
        {
            addBoxLayout();
            addAlignSelectors();
            boxLayout.layout();
        }
        private function addBoxLayout():void
        {
            const MARGIN:Number = 10;
            const BOX_Y:Number = 50;
            const BOX_WIDTH:Number = stage.stageWidth - MARGIN * 2;
            const BOX_HEIGHT:Number = stage.stageHeight - BOX_Y - MARGIN;
            boxLayout = new HBoxLayout(this, MARGIN, BOX_Y, BOX_WIDTH, BOX_HEIGHT);
            for (var i:int = 0; i < 50; i++)
            {
                boxLayout.add(getShape());
            }
        }
        private function addAlignSelectors():void
        {
            var alignLayout:ILayoutGroup = new HLineLayout(this, 10, 10);
            alignLayout.add(createFiled("Box Align:"));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.TOP_LEFT));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.TOP));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.TOP_RIGHT));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.RIGHT));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.BOTTOM_RIGHT));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.BOTTOM));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.BOTTOM_LEFT));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.LEFT));
            alignLayout.add(createBoxAlignSelector(LayoutAlign.CENTER));
            alignLayout.add(createFiled("    Line Align:"));
            alignLayout.add(createLineAlignSelector(LayoutAlign.TOP));
            alignLayout.add(createLineAlignSelector(LayoutAlign.CENTER));
            alignLayout.add(createLineAlignSelector(LayoutAlign.BOTTOM));
            alignLayout.layout();
        }
        private function createFiled(text:String):TextField
        {
            var field:TextField = new TextField();
            field.text = text;
            field.width = field.textWidth + 4;
            field.height = field.textHeight + 4;
            field.mouseEnabled = false;
            return field;
        }
        private function createBoxAlignSelector(align:String):Sprite
        {
            var s:Sprite = createAlignSelector(align);
            boxAlignBySelector[s] = align;
            if (selectedBoxAlign)
            {
                unselectAlign(s);
            }
            else
            {
                selectBoxAlign(s);
            }
            s.addEventListener(MouseEvent.CLICK, boxAlignSelector_clickHandler);
            return s;
        }
        private function createLineAlignSelector(align:String):Sprite
        {
            var s:Sprite = createAlignSelector(align);
            lineAlignBySelector[s] = align;
            if (selectedLineAlign)
            {
                unselectAlign(s);
            }
            else
            {
                selectLineAlign(s);
            }
            s.addEventListener(MouseEvent.CLICK, lineAlignSelector_clickHandler);
            return s;
        }
        private function createAlignSelector(align:String):Sprite
        {
            var s:Sprite = new Sprite();
            s.addChild(createFiled(align));
            s.buttonMode = true;
            s.mouseChildren = false;
            return s;
        }
        private function unselectAlign(align:Sprite):void
        {
            align.mouseEnabled = true;
            with (align.graphics)
            {
                beginFill(0x999999);
                drawRoundRect(0, 0, align.width, align.height, 5);
                endFill();
            }
        }
        private function selectBoxAlign(align:Sprite):void
        {
            if (selectedBoxAlign)
            {
                unselectAlign(selectedBoxAlign);
            }
            selectedBoxAlign = align;
            selectedBoxAlign.graphics.clear();
            selectedBoxAlign.mouseEnabled = false;
            boxLayout.align = boxAlignBySelector[selectedBoxAlign];
        }
        private function selectLineAlign(align:Sprite):void
        {
            if (selectedLineAlign)
            {
                unselectAlign(selectedLineAlign);
            }
            selectedLineAlign = align;
            selectedLineAlign.graphics.clear();
            selectedLineAlign.mouseEnabled = false;
            boxLayout.lineAlign = lineAlignBySelector[selectedLineAlign];
        }
        private function getShape():Shape
        {
            var s:Shape = new Shape();
            with (s.graphics)
            {
                beginFill(Math.random() * 0xFFFFFF);
                var x:Number = 15 - Math.random() * 30;
                var y:Number = 15 - Math.random() * 30;
                var width:Number = 15 + Math.random() * 15;
                var height:Number = 15 + Math.random() * 15;
                drawRect(x, y, width, height);
                endFill();
            }
            return s;
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function boxAlignSelector_clickHandler(event:MouseEvent):void
        {
            selectBoxAlign(Sprite(event.target));
        }
        private function lineAlignSelector_clickHandler(event:MouseEvent):void
        {
            selectLineAlign(Sprite(event.target));
        }
    }
}