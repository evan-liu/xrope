package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class HBoxLayout extends AbstractLayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function HBoxLayout(container:DisplayObjectContainer,
                                   x:Number = 0, y:Number = 0,
                                   width:Number = -1, height:Number = -1,
                                   align:String = "TL",
                                   horizontalGap:Number = 5,
                                   verticalGap:Number = 5,
                                   autoLayoutWhenAdd:Boolean = false,
                                   autoLayoutWhenChange:Boolean = true)
        {
            super(container, autoLayoutWhenAdd, autoLayoutWhenChange);
            _x = x;
            _y = y;
            _width = width;
            _height = height;
            _align = align;
            _horizontalGap = horizontalGap;
            _verticalGap = verticalGap;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  lineAlign
        //------------------------------
        private var _lineAlign:String = "TL";
        /**
         * Align of each line.
         */
        public function get lineAlign():String
        {
            return _lineAlign;
        }
        /**
         * @private
         */
        public function set lineAlign(value:String):void
        {
            if (value == _lineAlign)
            {
                return;
            }
            _lineAlign = value;
            isChanged = true;
            if (isLayouted && _autoLayoutWhenChange)
            {
                layout();
            }
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override protected function layoutElements():void
        {
            var currentWidth:Number = 0;
            var currentLine:HLineLayout = createLine();
            var lineList:Array = [currentLine];
            for each (var element:ILayoutElement in _elements)
            {
                var addWidth:Number = element.width;
                if (currentWidth != 0)
                {
                    addWidth += _horizontalGap;
                }
                var newWidth:Number = currentWidth + addWidth;
                if (newWidth > _width)
                {
                    currentLine = createLine();
                    lineList.push(currentLine);
                    currentWidth = element.width;
                }
                else
                {
                    currentWidth += addWidth;
                }
                currentLine.add(element);
            }
            var topLayout:VLineLayout = new VLineLayout(container, _x, _y, _width, _height, _align, _verticalGap);
            for each (var line:HLineLayout in lineList)
            {
                line.layout();
                topLayout.add(line);
            }
            topLayout.layout();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function createLine():HLineLayout
        {
            var line:HLineLayout = new HLineLayout(_container);
            line.align = _lineAlign;
            line.horizontalGap = _horizontalGap;
            return line;
        }
    }
}
