package xrope
{
    import xrope.algorithms.BackwardAlgorithm;
    import xrope.algorithms.CenterAlgorithm;
    import xrope.algorithms.ForwardAlgorithm;
    import xrope.algorithms.MaxAlgorithm;
    import xrope.algorithms.MinAlgorithm;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class HLineLayout extends AbstractLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>HorizontalLayout</code>.
         * @param container     Container of the layout group.
         * @param align         Align of the layout group.
         * @param gap           Space of the layout elements in the group.
         */
        public function HLineLayout(container:DisplayObjectContainer,
                                    x:Number = 0, y:Number = 0,
                                    width:Number = -1, height:Number = -1,
                                    align:String = "TL", gap:Number = 5,
                                    autoLayoutWhenAdd:Boolean = false,
                                    autoLayoutWhenChange:Boolean = true)
        {
            super(container, autoLayoutWhenAdd, autoLayoutWhenChange);
            _x = x;
            _y = y;
            _width = width;
            _height = height;
            _align = align;
            _horizontalGap = gap;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override protected function fixWidth():void
        {
            _width = getElementsAndGapsWidth();
        }
        override protected function fixHeight():void
        {
            _height = getMaxHeight();
        }
        override protected function getStartX():Number
        {
            switch (_align)
            {
                case LayoutAlign.RIGHT:
                case LayoutAlign.TOP_RIGHT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return _x + _width;
                case LayoutAlign.CENTER:
                case LayoutAlign.TOP:
                case LayoutAlign.BOTTOM:
                    return _x + (_width - getElementsAndGapsWidth()) / 2;
            }
            return _x;
        }
        override protected function getXAlgorithm():ILayoutAlgorithm
        {
            switch (_align)
            {
                case LayoutAlign.RIGHT:
                case LayoutAlign.TOP_RIGHT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new BackwardAlgorithm();
            }
            return new ForwardAlgorithm();
        }
        override protected function getYAlgorithm():ILayoutAlgorithm
        {
            switch (_align)
            {
                case LayoutAlign.TOP:
                case LayoutAlign.TOP_LEFT:
                case LayoutAlign.TOP_RIGHT:
                    return new MinAlgorithm();
                case LayoutAlign.BOTTOM:
                case LayoutAlign.BOTTOM_LEFT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new MaxAlgorithm();
            }
            return new CenterAlgorithm();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getMaxHeight():Number
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
        private function getElementsWidth():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element.width;
            }
            return result;
        }
        private function getGapsWidth():Number
        {
            return _horizontalGap * (_elements.length - 1);
        }
        private function getElementsAndGapsWidth():Number
        {
            return getElementsWidth() + getGapsWidth();
        }
    }
}