package xrope
{
    import xrope.algorithms.ForwardAlgorithm;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class AbstractLineLayout extends AbstractLayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XLineLayout</code>.
         */
        public function AbstractLineLayout(container:DisplayObjectContainer,
                                            autoLayoutWhenAdd:Boolean = false,
                                            autoLayoutWhenChange:Boolean = true)
        {
            super(container, autoLayoutWhenAdd, autoLayoutWhenChange);
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override protected function layoutElements():void
        {
            fixSize();
            var xAlgorithm:ILayoutAlgorithm = getXAlgorithm();
            xAlgorithm.beReady(this, "x", "width", getStartX(), _horizontalGap);
            var yAlgorithm:ILayoutAlgorithm = getYAlgorithm();
            yAlgorithm.beReady(this, "y", "height", getStartY(), _verticalGap);
            var previousElement:ILayoutElement;
            for each (var element:ILayoutElement in _elements)
            {
                element.x = xAlgorithm.calculate(element, previousElement);
                element.y = yAlgorithm.calculate(element, previousElement);
                previousElement = element;
            }
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected function fixSize():void
        {
            if (_width <= 0)
            {
                fixWidth();
            }
            if (_height <= 0)
            {
                fixHeight();
            }
        }
        protected function fixWidth():void
        {
            _width = getTotalWidth() + _horizontalGap * (_elements.length - 1);
        }
        protected function fixHeight():void
        {
            _height = getTotalHeight() + _verticalGap * (_elements.length - 1);
        }
        protected function getStartX():Number
        {
            return _x;
        }
        protected function getStartY():Number
        {
            return _y;
        }
        protected function getXAlgorithm():ILayoutAlgorithm
        {
            return new ForwardAlgorithm();
        }
        protected function getYAlgorithm():ILayoutAlgorithm
        {
            return new ForwardAlgorithm();
        }
        protected function getTotalWidth():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element.width;
            }
            return result;
        }
        protected function getTotalHeight():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element.height;
            }
            return result;
        }
        protected function getMaxWidth():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                if (element.width > result)
                {
                    result = element.width;
                }
            }
            return result;
        }
        protected function getMaxHeight():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                if (element.height > result)
                {
                    result = element.height;
                }
            }
            return result;
        }
    }
}