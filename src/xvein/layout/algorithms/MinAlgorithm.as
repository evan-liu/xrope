package xvein.layout.algorithms
{
    import xvein.core.ILayoutElement;
    /**
     * Algorithm for min element value.
     * @author eidiot
     */
    public class MinAlgorithm extends AbstractLayoutAlgorithm
    {
        //======================================================================
        //  Overridden methods
        //======================================================================
        /**
         * @inheritDoc
         */
        override public function calculate(currentElement:ILayoutElement,
                                           previousElement:ILayoutElement = null):Number
        {
            return valueOf(group);
        }
    }
}