package xvein.layout
{
    import xvein.core.ILayoutAlgorithm;
    import xvein.layout.algorithms.BackwardAlgorithm;
    import xvein.layout.algorithms.CenterAlgorithm;
    import xvein.layout.algorithms.ForwardAlgorithm;
    import xvein.layout.algorithms.MaxAlgorithm;
    import xvein.layout.algorithms.MinAlgorithm;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class HorizontalLayout extends AbstractLayoutGroup
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
        public function HorizontalLayout(container:DisplayObjectContainer,
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
                    var totalGap:Number = _horizontalGap * (_elements.length- 1);
                    return _x + (_width - getTotalWidth() - totalGap) / 2;
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
    }
}