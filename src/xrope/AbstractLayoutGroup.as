package xrope
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.utils.Dictionary;
    /**
     * Abstract class for layout group.
     * @author eidiot
     */
    public class AbstractLayoutGroup implements ILayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>AbstractLayoutGroup</code>.
         * @param container             Container of the layout group.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function AbstractLayoutGroup(container:DisplayObjectContainer,
                                            useBounds:Boolean = false,
                                            autoLayoutWhenAdd:Boolean = false,
                                            autoLayoutWhenChange:Boolean = true)
        {
            _container = container;
            _useBounds = useBounds;
            _autoLayoutWhenAdd = autoLayoutWhenAdd;
            _autoLayoutWhenChange = autoLayoutWhenChange;
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        /** @private */
        protected var atomMap:Dictionary = new Dictionary();
        /** @private */
        protected var isLayouted:Boolean = false;
        /** @private */
        protected var isChanged:Boolean = false;
        //======================================================================
        //  Properties: IXLayoutGroup
        //======================================================================
        //------------------------------
        //  container
        //------------------------------
        /** @private */
        protected var _container:DisplayObjectContainer;
        /** @inheritDoc */
        public function get container():DisplayObjectContainer
        {
            return _container;
        }
        //------------------------------
        //  elements
        //------------------------------
        /** @private */
        protected var _elements:Array = [];
        /** @inheritDoc */
        public function get elements():Array
        {
            return _elements.concat();
        }
        //------------------------------
        //  x
        //------------------------------
        /** @private */
        protected var _x:Number = 0;
        /** @inheritDoc */
        public function get x():Number
        {
            return _x;
        }
        /** @private */
        public function set x(value:Number):void
        {
            if (value == _x)
            {
                return;
            }
            if (isLayouted)
            {
                if (_autoLayoutWhenChange)
                {
                    var change:Number = value - _x;
                    for each (var element:ILayoutElement in _elements)
                    {
                        element.x += change;
                    }
                }
                else
                {
                    isLayouted = true;
                }
            }
            _x = value;
        }
        //------------------------------
        //  y
        //------------------------------
        /** @private */
        protected var _y:Number = 0;
        /** @inheritDoc */
        public function get y():Number
        {
            return _y;
        }
        /** @private */
        public function set y(value:Number):void
        {
            if (value == _y)
            {
                return;
            }
            if (isLayouted)
            {
                if (_autoLayoutWhenChange)
                {
                    var change:Number = value - _y;
                    for each (var element:ILayoutElement in _elements)
                    {
                        element.y += change;
                    }
                }
                else
                {
                    isLayouted = true;
                }
            }
            _y = value;
        }
        //------------------------------
        //  width
        //------------------------------
        /** @private */
        protected var _width:Number = 0;
        /** @inheritDoc */
        public function get width():Number
        {
            return _width;
        }
        /** @private */
        public function set width(value:Number):void
        {
            if (value == _width)
            {
                return;
            }
            _width = value;
            isChanged = true;
            checkLayoutAfterChange();
        }
        //------------------------------
        //  height
        //------------------------------
        /** @private */
        protected var _height:Number = 0;
        /** @inheritDoc */
        public function get height():Number
        {
            return _height;
        }
        /** @private */
        public function set height(value:Number):void
        {
            if (value == _height)
            {
                return;
            }
            _height = value;
            isChanged = true;
            checkLayoutAfterChange();
        }
        //------------------------------
        //  useBounds
        //------------------------------
        /** @private */
        protected var _useBounds:Boolean = false;
        /** @inheritDoc */
        public function get useBounds():Boolean
        {
            return _useBounds;
        }
        /** @private */
        public function set useBounds(value:Boolean):void
        {
            if (value == _useBounds)
            {
                return;
            }
            _useBounds = value;
            for each (var element:ILayoutElement in _elements)
            {
                element.useBounds = _useBounds;
            }
        }
        //------------------------------
        //  align
        //------------------------------
        /** @private */
        protected var _align:String = "TL";
        /** @inheritDoc */
        public function get align():String
        {
            return _align;
        }
        /** @private */
        public function set align(value:String):void
        {
            if (value == _align)
            {
                return;
            }
            _align = value;
            isChanged = true;
            checkLayoutAfterChange();
        }
        //------------------------------
        //  horizontalGap
        //------------------------------
        /** @private */
        protected var _horizontalGap:Number = 5;
        /** @inheritDoc */
        public function get horizontalGap():Number
        {
            return _horizontalGap;
        }
        /** @private */
        public function set horizontalGap(value:Number):void
        {
            if (value == _horizontalGap)
            {
                return;
            }
            _horizontalGap = value;
            isChanged = true;
            checkLayoutAfterChange();
        }
        //------------------------------
        //  verticalGap
        //------------------------------
        /** @private */
        protected var _verticalGap:Number = 5;
        /** @inheritDoc */
        public function get verticalGap():Number
        {
            return _verticalGap;
        }
        /** @private */
        public function set verticalGap(value:Number):void
        {
            if (value == _verticalGap)
            {
                return;
            }
            _verticalGap = value;
            isChanged = true;
            checkLayoutAfterChange();
        }
        //------------------------------
        //  autoLayoutWhenAdd
        //------------------------------
        /** @private */
        protected var _autoLayoutWhenAdd:Boolean = false;
        /** @inheritDoc */
        public function get autoLayoutWhenAdd():Boolean
        {
            return _autoLayoutWhenAdd;
        }
        /** @private */
        public function set autoLayoutWhenAdd(value:Boolean):void
        {
            _autoLayoutWhenAdd = value;
        }
        //------------------------------
        //  autoLayoutWhenChange
        //------------------------------
        /** @private */
        protected var _autoLayoutWhenChange:Boolean = false;
        /** @inheritDoc */
        public function get autoLayoutWhenChange():Boolean
        {
            return _autoLayoutWhenChange;
        }
        /** @private */
        public function set autoLayoutWhenChange(value:Boolean):void
        {
            _autoLayoutWhenChange = value;
        }
        //======================================================================
        //  Public methods: IXLayoutGroup
        //======================================================================
        /** @inheritDoc */
        public function add(...elements):void
        {
            while (elements.length == 1 && elements[0] is Array)
            {
                elements = elements[0];
            }
            for each (var element:* in elements)
            {
                addOne(element);
            }
            isChanged = true;
            checkLayoutAfterChange();
        }
        /** @inheritDoc */
        public function remove(...elements):void
        {
            while (elements.length == 1 && elements[0] is Array)
            {
                elements = elements[0];
            }
            for each (var element:* in elements)
            {
                removeOne(element);
            }
            isChanged = true;
            checkLayoutAfterChange();
        }
        /** @inheritDoc */
        public function removeAll():void
        {
            _elements = [];
            atomMap = new Dictionary();
            isLayouted = false;
            isChanged = false;
        }
        /** @inheritDoc */
        public function has(element:*):Boolean
        {
            if (_elements.length == 0)
            {
                return false;
            }
            if (element is ILayoutElement)
            {
                return _elements.indexOf(element) != -1;
            }
            if (element is DisplayObject)
            {
                return atomMap[element] != null;
            }
            return false;
        }
        /** @inheritDoc */
        public function layout():void
        {
            if (_elements.length > 0)
            {
                layoutElements();
            }
            isLayouted = true;
            isChanged = false;
        }
        /** @inheritDoc */
        public function layoutContainer():void
        {
            removeAll();
            const N:int = _container.numChildren;
            if (N == 0)
            {
                return;
            }
            for (var i:int = 0;i < N;i++)
            {
                addAtom(_container.getChildAt(i));
            }
            layoutElements();
            isLayouted = true;
            isChanged = false;
        }
        /** @inheritDoc */
        public function reset():void
        {
            removeAll();
            _x = 0;
            _y = 0;
            _width = 0;
            _height = 0;
            _align = "TL";
            _useBounds = false;
            _horizontalGap = 5;
            _verticalGap = 5;
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        /** @private */
        protected function addOne(element:*):void
        {
            if (has(element))
            {
                return;
            }
            if (element is ILayoutElement)
            {
                _elements.push(element);
            }
            else if (element is DisplayObject)
            {
                addAtom(element);
            }
        }
        /** @private */
        protected function addAtom(element:DisplayObject):void
        {
            if (element.parent != _container)
            {
                _container.addChild(element);
            }
            if (atomMap[element])
            {
                return;
            }
            var atom:ILayoutElement = createAtom(element);
            atomMap[element] = atom;
            _elements.push(atom);
        }
        /** @private */
        protected function createAtom(element:DisplayObject):ILayoutElement
        {
            return new AtomLayout(element, _useBounds);
        }
        /** @private */
        protected function removeOne(element:*):void
        {
            if (element is ILayoutElement)
            {
                var index:int = _elements.indexOf(element);
                if (index != -1)
                {
                    _elements.splice(index, 1);
                }
                return;
            }
            if (element is DisplayObject && atomMap[element])
            {
                removeOne(atomMap[element]);
                delete atomMap[element];
            }
        }
        /** @private */
        protected function checkLayoutAfterChange():void
        {
            if (isLayouted && _autoLayoutWhenChange)
            {
                layout();
            }
        }
        /** @private */
        protected function layoutElements():void
        {
            // Tobe overridden by subclasses
        }
    }
}