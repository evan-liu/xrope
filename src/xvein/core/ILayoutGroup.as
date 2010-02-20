package xvein.core
{
    import flash.display.DisplayObjectContainer;
    /**
     * Interface for layout groups.
     *
     * @author eidiot
     */
    public interface ILayoutGroup extends ILayoutElement
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  container
        //------------------------------
        /**
         * Container of the layout group.
         */
        function get container():DisplayObjectContainer;
        //------------------------------
        //  elements
        //------------------------------
        /**
         * All layout elements in the group.
         */
        function get elements():Array;
        //------------------------------
        //  align
        //------------------------------
        /**
         * Align of the layout group.
         */
        function get align():String;
        /**
         * @private
         */
        function set align(value:String):void;
        //------------------------------
        //  horizontalGap
        //------------------------------
        /**
         * Horizontal gap of the layout group.
         */
        function get horizontalGap():Number;
        /**
         * @inheritDoc
         */
        function set horizontalGap(value:Number):void;
        //------------------------------
        //  verticalGap
        //------------------------------
        /**
         * Vertical gap of the layout group.
         */
        function get verticalGap():Number;
        /**
         * @inheritDoc
         */
        function set verticalGap(value:Number):void;
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Add elements to the group.
         */
        function add(...elements):void;
        /**
         * Remove elements from the group.
         */
        function remove(...elements):void;
        /**
         * Check if an element is in the group.
         */
        function has(element:*):Boolean;
        /**
         * Layout all the elements in the group.
         */
        function layout():void;
    }
}