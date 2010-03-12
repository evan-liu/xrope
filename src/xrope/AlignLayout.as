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
        public function AlignLayout(container:DisplayObjectContainer,
                                    x:Number = 0, y:Number = 0,
                                    width:Number = -1, height:Number = -1,
                                    autoLayoutWhenAdd:Boolean = false,
                                    autoLayoutWhenChange:Boolean = true)
        {
            super(container, autoLayoutWhenAdd, autoLayoutWhenChange);
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
        /**
         * @private
         */
        public function set defaultAlign(value:String):void
        {
            _defaultAlign = value;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override public function add(...elements):void
        {
            for each (var element:* in elements)
            {
                addTo(element, _defaultAlign);
            }
        }
        override public function layout():void
        {
            for each (var alignGroup:ILayoutGroup in alignMap)
            {
                alignGroup.layout();
            }
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
                                      _horizontalGap, _autoLayoutWhenAdd,
                                      _autoLayoutWhenChange);
            }
            return alignMap[align];
        }
    }
}