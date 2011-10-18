package xrope
{
    import flash.display.DisplayObjectContainer;
    /**
     * Interface for layout groups.
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
         * All layout elements in this group.
         */
        function get elements():Vector.<ILayoutElement>;
        //------------------------------
        //  align
        //------------------------------
        /**
         * Align of this layout group.
         */
        function get align():String;
        /** @private */
        function set align(value:String):void;
        //------------------------------
        //  horizontalGap
        //------------------------------
        /**
         * Horizontal gap of this layout group.
         */
        function get horizontalGap():Number;
        /** @private */
        function set horizontalGap(value:Number):void;
        //------------------------------
        //  verticalGap
        //------------------------------
        /**
         * Vertical gap of this layout group.
         */
        function get verticalGap():Number;
        /** @private */
        function set verticalGap(value:Number):void;
        //------------------------------
        //  autoLayoutWhenChange
        //------------------------------
        /**
         * If auto layout when changed.
         */
        function get autoLayoutWhenChange():Boolean;
        /** @private */
        function set autoLayoutWhenChange(value:Boolean):void;
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Add elements to the group.
         */
        function add(...targets):void;
        /**
         * Remove elements from the group.
         */
        function remove(...targets):void;
        /**
         * Remove all elements.
         */
        function removeAll():void;
        /**
         * Check if an element is in the group.
         */
        function has(element:*):Boolean;
        /**
         * Layout all the elements in the group.
         */
        function layout():void;
        /**
         * Layout all children in the container.
         */
        function layoutContainer():void;
        /**
         * Remove all elements and reset all property to default value.
         */
        function reset():void;
    }
}