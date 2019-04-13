_G.math.vect2 = {

    New = function(x,y)
        local vect2 = {}

        vect2.x = x or 0
        vect2.y = y or 0

        function vect2:Set(v)
            self.x = v
            self.y = v
        end

        function vect2:Add(v)
            self.x = self.x + v.x
            self.y = self.y + v.y
        end

        function vect2:Mul(v)
            self.x = self.x * v.x
            self.y = self.y * v.y
        end

        return vect2
    end
}