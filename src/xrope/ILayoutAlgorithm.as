package xrope
{
    /**
     * Interface for the layout algorithms.
     * @author eidiot
     */
    public interface ILayoutAlgorithm
    {
        /**
         * Be ready  for the layout value calculation.
         * @param group         Layout group target.
         * @param valueKey      "x" or "y".
         * @param sizeKey       "width" or "height".
         * @param startValue    Value of the first element.
         * @param gap           Gap between the elements in the group.
         */
        function beReady(group:ILayoutGroup, valueKey:String, sizeKey:String,
                         startValue:Number, gap:Number):void;
        /**
         * Calculate the layout value.
         * @param currentElement    Current element in the calculation.
         * @param previousElement   Previous element in the group.
         */
        function calculate(currentElement:ILayoutElement,
                           previousElement:ILayoutElement = null):Number;
    }
}