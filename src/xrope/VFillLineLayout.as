package xrope
{
    import flash.display.DisplayObjectContainer;
    import xrope.algorithms.AlgorithmFactory;


    public class VFillLineLayout extends AbstractFillLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>VFillLineLayout</code>.
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
        public function VFillLineLayout(container:DisplayObjectContainer,
                                        width:Number, height:Number,
                                        x:Number = 0, y:Number = 0,
                                        align:String = "C",
                                        useMargin:Boolean = true,
                                        useBounds:Boolean = false,
                                        autoLayoutWhenChange:Boolean = true)
        {
            super("height", container, x, y, width, height, align, useMargin, useBounds, autoLayoutWhenChange);
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function getStartY():Number
        {
            return _y + margin;
        }
        /** @private */
        override protected function getXAlgorithm():ILayoutAlgorithm
        {
            return AlgorithmFactory.getXAlgorithmForVLayout(_align);
        }
        /** @private */
        override protected function getYAlgorithm():ILayoutAlgorithm
        {
            return AlgorithmFactory.getYAlgorithmForVLayout(_align);
        }
    }
}
