package xrope
{
    import flash.display.DisplayObjectContainer;

    public class AbstractFillLineLayout extends AbstractLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>AbstractFillLineLayout</code>.
         * @param sizeKey               Key of the size, "width" or "height".
         * @param container             Container of the layout group.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param align                 Align of the layout group.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function AbstractFillLineLayout(sizeKey:String,
                                               container:DisplayObjectContainer,
                                               x:Number, y:Number,
                                               width:Number, height:Number,
                                               align:String,
                                               useMargin:Boolean,
                                               useBounds:Boolean,
                                               autoLayoutWhenChange:Boolean)
        {
            super(container, useBounds, autoLayoutWhenChange);
            this.sizeKey = sizeKey;
            _useMargin = useMargin;
            _x = x;
            _y = y;
            _width = width;
            _height = height;
            _align = align;
        }
        //======================================================================
        //  Variables
        //======================================================================
        /** @private */
        protected var margin:Number = 0;
        /** @private */
        protected var sizeKey:String;
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  useMargin
        //------------------------------
        /** @private */
        protected var _useMargin:Boolean = true;
        /**
         * If use margin as well as spaces between elements.
         */
        public function get useMargin():Boolean
        {
            return _useMargin;
        }
        /** @private */
        public function set useMargin(value:Boolean):void
        {
            if (value == _useMargin)
            {
                return;
            }
            _useMargin = value;
            checkLayoutAfterChange();
        }
        //======================================================================
        //  Overridden methods
        // ======================================================================
        /** @private */
        override protected function layoutElements():void
        {
            const ELEMENTS_COUNT:int = _elements.length;
            if (ELEMENTS_COUNT == 0)
            {
                return;
            }
            if (ELEMENTS_COUNT == 1)
            {
                margin = (this[sizeKey] - _elements[0][sizeKey]) / 2;
            }
            else
            {
                var elementsHeight:Number = getElementsSize();
                const SPACE_COUNT:int = ELEMENTS_COUNT + (_useMargin ? 1 : -1);
                var gap:Number = (this[sizeKey] - elementsHeight) / SPACE_COUNT;
                margin = _useMargin ? gap : 0;
                _horizontalGap = _verticalGap = gap;
            }
            super.layoutElements();
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        /** @private */
        protected function getElementsSize():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element[sizeKey];
            }
            return result;
        }
    }
}