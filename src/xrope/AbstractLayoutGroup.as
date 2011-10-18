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
                                            autoLayoutWhenChange:Boolean = true)
        {
            _container = container;
            _useBounds = useBounds;
            _autoLayoutWhenChange = autoLayoutWhenChange;
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        /** @private */
        protected var atomMap:Dictionary = new Dictionary();
        /** @private */
        protected var isLayouted:Boolean = false;
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
        protected var _elements:Vector.<ILayoutElement> = new Vector.<ILayoutElement>();
        /** @inheritDoc */
        public function get elements():Vector.<ILayoutElement>
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
            if (isLayouted && _autoLayoutWhenChange)
            {
                var change:Number = value - _x;
                for each (var element:ILayoutElement in _elements)
                {
                    element.x += change;
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
            if (isLayouted && _autoLayoutWhenChange)
            {
                var change:Number = value - _y;
                for each (var element:ILayoutElement in _elements)
                {
                    element.y += change;
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
            checkLayoutAfterChange();
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
        public function add(...targets):void
        {
            while (targets.length == 1 && targets[0] is Array)
            {
                targets = targets[0];
            }
            if (targets.length == 0)
            {
                return;
            }
            for each (var target:* in targets)
            {
                addOne(target);
            }
            checkLayoutAfterChange();
        }
        /** @inheritDoc */
        public function remove(...targets):void
        {
            while (targets.length == 1 && targets[0] is Array)
            {
                targets = targets[0];
            }
            for each (var target:* in targets)
            {
                removeOne(target);
            }
            checkLayoutAfterChange();
        }
        /** @inheritDoc */
        public function removeAll():void
        {
            _elements = new Vector.<ILayoutElement>();
            atomMap = new Dictionary();
            isLayouted = false;
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
        protected function addOne(target:*):void
        {
            if (has(target))
            {
                return;
            }
            if (target is ILayoutElement)
            {
                _elements.push(target);
            }
            else if (target is DisplayObject)
            {
                addAtom(target);
            }
        }
        /** @private */
        protected function addAtom(target:DisplayObject):void
        {
            if (target.parent != _container)
            {
                _container.addChild(target);
            }
            if (atomMap[target])
            {
                return;
            }
            var atom:ILayoutElement = createAtom(target);
            atomMap[target] = atom;
            _elements.push(atom);
        }
        /** @private */
        protected function createAtom(target:DisplayObject):ILayoutElement
        {
            return new AtomLayout(target, _useBounds);
        }
        /** @private */
        protected function removeOne(target:*):void
        {
            if (target is ILayoutElement)
            {
                var index:int = _elements.indexOf(target);
                if (index != -1)
                {
                    _elements.splice(index, 1);
                }
                return;
            }
            if (target is DisplayObject && atomMap[target])
            {
                removeOne(atomMap[target]);
                delete atomMap[target];
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