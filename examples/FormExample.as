package
{
    import xrope.HLineLayout;
    import xrope.ILayoutGroup;
    import xrope.LayoutAlign;
    import xrope.VLineLayout;

    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.text.TextField;

    [SWF(width="320", height="270", backgroundColor="0xFFFFFF", frameRate="30")]

    /**
     * @author eidiot
     */
    public class FormExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function FormExample()
        {
            super();
            demo();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function demo():void
        {
            var topGroup:VLineLayout = new VLineLayout(this, 10, 10);
            addLine(topGroup, getLabel("Name:", 40), getInput());
            addLine(topGroup, getLabel("Mail:", 40), getInput());
            addLine(topGroup, getLabel("Site:", 40), getInput());
            addLine(topGroup, getInput(300, 150));
            addLine(topGroup, getButton("Commit"), getButton("Discard"));
            topGroup.layout();
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
        private function getInput(w:Number = 200, h:Number = 20):DisplayObject
        {
            var result:Shape = new Shape();
            with (result.graphics)
            {
                beginFill(0xFFCDFF);
                drawRoundRect(0, 0, w, h, 10);
                endFill();
            }
            return result;
        }
        private function getButton(label:String):DisplayObject
        {
            var result:Sprite = new Sprite();
            with (result.graphics)
            {
                beginFill(0xFFCDFF);
                drawRoundRect(0, 0, 80, 20, 5);
                endFill();
            }
            var layout:HLineLayout = new HLineLayout(result, 0, 0, result.width, result.height, LayoutAlign.CENTER);
            layout.add(getLabel(label));
            layout.layout();
            return result;
        }
        private function addLine(group:ILayoutGroup, ...elements):HLineLayout
        {
            var result:HLineLayout = new HLineLayout(group.container,
                                                               0, 0,
                                                               group.width, -1,
                                                               LayoutAlign.CENTER);
            for each (var element:* in elements)
            {
                result.add(element);
            }
            result.layout();
            group.add(result);
            return result;
        }
    }
}