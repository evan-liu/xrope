package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * Abstract class for multi-line layout (and box layout).
     * @author eidiot
     */
    public class AbstractMultiLineLayout extends AbstractLayoutGroup implements IMultiLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>AbstractMultiLineLayout</code>.
         * @param container             Container of the layout group.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param align                 Align of the layout group.
         * @param horizontalGap         Horizontal gap value.
         * @param verticalGap           Vertical gap value.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function AbstractMultiLineLayout(container:DisplayObjectContainer,
                                                 width:Number, height:Number,
                                                 x:Number = 0, y:Number = 0,
                                                 align:String = "TL",
                                                 horizontalGap:Number = 5,
                                                 verticalGap:Number = 5,
                                                 useBounds:Boolean = false,
                                                 autoLayoutWhenAdd:Boolean = false,
                                                 autoLayoutWhenChange:Boolean = true)
        {
            super(container, useBounds, autoLayoutWhenAdd, autoLayoutWhenChange);
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
        /** @private */
        protected var _lineAlign:String = "TL";
        /**
         * align of each line.
         */
        public function get lineAlign():String
        {
            return _lineAlign;
        }
        /** @private */
        public function set lineAlign(value:String):void
        {
            if (value == _lineAlign)
            {
                return;
            }
            _lineAlign = value;
            isChanged = true;
            checkLayoutAfterChange();
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        /** @private */
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
        /** @private */
        protected function createLine():ILayoutGroup
        {
            // Tobe overridden by subclasses.
            return null;
        }
        /** @private */
        protected function createTopLayout():ILayoutGroup
        {
            // Tobe overridden by subclasses.
            return null;
        }
    }
}