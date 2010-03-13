package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class AbstractMultiLayoutGroup extends AbstractLayoutGroup implements IMultiLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function AbstractMultiLayoutGroup(container:DisplayObjectContainer,
                                                 width:Number, height:Number,
                                                 x:Number = 0, y:Number = 0,
                                                 align:String = "TL",
                                                 horizontalGap:Number = 5,
                                                 verticalGap:Number = 5,
                                                 autoLayoutWhenAdd:Boolean = false,
                                                 autoLayoutWhenChange:Boolean = true)
        {
            super(container, autoLayoutWhenAdd, autoLayoutWhenChange);
            _width = width;
            _height = height;
            _x = x;
            _y = y;
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
        protected var _lineAlign:String = "TL";
        public function get lineAlign():String
        {
            return _lineAlign;
        }
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
        //  Protected methods
        //======================================================================
        protected function layoutAsLines(valueKey:String, gap:Number):void
        {
            var currentValue:Number = 0;
            var currentLine:ILayoutGroup = createLine();
            var lineList:Array = [currentLine];
            for each (var element:ILayoutElement in _elements)
            {
                var addValue:Number = element[valueKey];
                if (currentValue != 0)
                {
                    addValue += gap;
                }
                var newValue:Number = currentValue + addValue;
                if (newValue > this[valueKey])
                {
                    currentLine = createLine();
                    lineList.push(currentLine);
                    currentValue = element[valueKey];
                }
                else
                {
                    currentValue += addValue;
                }
                currentLine.add(element);
            }
            var topLayout:ILayoutGroup = createTopLayout();
            for each (var line:ILayoutGroup in lineList)
            {
                line.layout();
                topLayout.add(line);
            }
            topLayout.layout();
        }
        protected function createLine():ILayoutGroup
        {
            // Tobe overridden by subclasses.
            return null;
        }
        protected function createTopLayout():ILayoutGroup
        {
            // Tobe overridden by subclasses.
            return null;
        }
    }
}