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
        //  lines
        //------------------------------
        /** @private */
        protected var _lines:Array = [];
        /** @inheritDoc */
        public function get lines():Array
        {
            return _lines.concat();
        }
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
            var newAlign:String = fixLineAlign(value);
            if (newAlign == _lineAlign)
            {
                return;
            }
            _lineAlign = newAlign;
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
            var oldLines:Array = _lines;
            var currentLine:ILayoutGroup = createLine(oldLines);
            _lines = [currentLine];
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
                    currentLine = createLine(oldLines);
                    _lines.push(currentLine);
                    currentValue = element[valueKey];
                }
                else
                {
                    currentValue += addValue;
                }
                currentLine.add(element);
            }
            var topLayout:ILayoutGroup = createTopLayout();
            for each (var line:ILayoutGroup in _lines)
            {
                line.layout();
                topLayout.add(line);
            }
            topLayout.layout();
        }
        /** @private */
        protected function createLine(oldLines:Array):ILayoutGroup
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
        /** @private */
        protected function fixLineAlign(value:String):String
        {
            return value;
        }
    }
}