package
{
    import xrope.ILayoutGroup;
    import xrope.HLineLayout;
    import xrope.LayoutAlign;
    import xrope.VLineLayout;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.text.TextField;
    /**
     * @author eidiot
     */
    public class HLineExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function HLineExample()
        {
            super();
            demo();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function demo():void
        {
            const ALIGN_LIST:Array = [
                LayoutAlign.BOTTOM,
                LayoutAlign.BOTTOM_LEFT,
                LayoutAlign.BOTTOM_RIGHT,
                LayoutAlign.CENTER,
                LayoutAlign.LEFT,
                LayoutAlign.RIGHT,
                LayoutAlign.TOP,
                LayoutAlign.TOP_LEFT,
                LayoutAlign.TOP_RIGHT
            ];
            var topGroup:ILayoutGroup = new VLineLayout(this, 30, 0, stage.stageWidth - 30);
            for each (var align:String in ALIGN_LIST)
            {
                topGroup.add(new HLineLayout(this, 0, 0, topGroup.width, 40, align, 5, true));
            }
            topGroup.layout();
            for each (var subGroup:ILayoutGroup in topGroup.elements)
            {
                fillSubGroup(subGroup);
                drawSubGroup(subGroup);
                titleSubGroup(subGroup);
            }
        }
        private function fillSubGroup(target:ILayoutGroup):void
        {
            for (var i:int = 0;i < 3;i++)
            {
                target.add(getShape());
            }
            target.layout();
        }
        private function drawSubGroup(target:ILayoutGroup):void
        {
            with (graphics)
            {
                beginFill(0, 0.2);
                drawRect(target.x, target.y, target.width, target.height);
                endFill();
            }
        }
        private function titleSubGroup(target:ILayoutGroup):void
        {
            var alignTf:TextField = new TextField();
            alignTf.text = target.align;
            alignTf.width = alignTf.textWidth + 4;
            alignTf.height = alignTf.textHeight + 4;
            addChild(alignTf);
            alignTf.x = (target.x - alignTf.width) / 2;
            alignTf.y = target.y + (target.height - alignTf.height) / 2;
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
    }
}