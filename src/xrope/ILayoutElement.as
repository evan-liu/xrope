package xrope
{
    /**
     * Interface for a layout element.
     *
     * @author eidiot
     */
    public interface ILayoutElement
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  x
        //------------------------------
        /**
         * X of the layout element.
         */
        function get x():Number;
        /**
         * @private
         */
        function set x(value:Number):void;
        //------------------------------
        //  y
        //------------------------------
        /**
         * Y of the layout element.
         */
        function get y():Number;
        /**
         * @private
         */
        function set y(value:Number):void;
        //------------------------------
        //  width
        //------------------------------
        /**
         * Width of the layout element.
         */
        function get width():Number;
        /**
         * @private
         */
        function set width(value:Number):void;
        //------------------------------
        //  height
        //------------------------------
        /**
         * Height of the layout element.
         */
        function get height():Number;
        /**
         * @private
         */
        function set height(value:Number):void;
    }
}