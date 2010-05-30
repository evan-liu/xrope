package xrope
{
    import flash.display.DisplayObjectContainer;
    import flash.utils.Dictionary;
    /**
     * Composite layout use align positions.
     * @author eidiot
     */
    public class AlignLayout extends AbstractLayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>AlignLayout</code>.
         * @param container             Container of the layout group.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function AlignLayout(container:DisplayObjectContainer,
                                    width:Number, height:Number,
                                    x:Number = 0, y:Number = 0,
                                    useBounds:Boolean = false,
                                    autoLayoutWhenAdd:Boolean = false,
                                    autoLayoutWhenChange:Boolean = true)
        {
            super(container, useBounds, autoLayoutWhenAdd, autoLayoutWhenChange);
            _x = x;
            _y = y;
            _width = width;
            _height = height;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var alignMap:Dictionary = new Dictionary();
        //======================================================================
        //  Overridden properties
        //======================================================================
        override public function set width(value:Number):void
        {
            if (value == _width)
            {
                return;
            }
            _width = value;
            for each (var element:ILayoutElement in alignMap)
            {
                element.width = _width;
            }
        }
        override public function set height(value:Number):void
        {
            if (value == _height)
            {
                return;
            }
            _height = value;
            for each (var element:ILayoutElement in alignMap)
            {
                element.height = _height;
            }
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  defaultAlign
        //------------------------------
        private var _defaultAlign:String = "TL";
        /**
         * Default align group when call add().
         */
        public function get defaultAlign():String
        {
            return _defaultAlign;
        }
        /** @private */
        public function set defaultAlign(value:String):void
        {
            _defaultAlign = value;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override public function add(...elements):void
        {
            for each (var element:* in elements)
            {
                addTo(element, _defaultAlign);
            }
        }
        /** @private */
        override public function layout():void
        {
            for each (var alignGroup:ILayoutGroup in alignMap)
            {
                alignGroup.layout();
            }
        }
        /** @private */
        override public function layoutContainer():void
        {
            reset();
            const N:int = _container.numChildren;
            if (N == 0)
            {
                return;
            }
            for (var i:int = 0;i < N;i++)
            {
                add(_container.getChildAt(i));
            }
            layout();
        }
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Add an element to an align position.
         * @param element   Element to be added.
         * @param align     Align position to be added to.
         */
        public function addTo(element:*, align:String):void
        {
            getAlignGroup(align).add(element);
        }
        /**
         * Set layout for a align position.
         * @param align     Align position.
         * @param layout    Layout group for the align postion.
         */
        public function setAlign(align:String, layout:ILayoutGroup):void
        {
            if (!alignMap[align])
            {
                alignMap[align] = layout;
                _elements.push(layout);
            }
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getAlignGroup(align:String):ILayoutGroup
        {
            if (!alignMap[align])
            {
                alignMap[align] = new HLineLayout(_container, _x, _y,
                                      _width, _height, align,
                                      _horizontalGap, _useBounds, _autoLayoutWhenAdd,
                                      _autoLayoutWhenChange);
            }
            return alignMap[align];
        }
    }
}