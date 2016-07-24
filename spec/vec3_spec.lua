local vec3        = require "modules.vec3"
local DBL_EPSILON = require("modules.constants").DBL_EPSILON
local abs, sqrt   = math.abs, math.sqrt

describe("vec3:", function()
	it("creates an empty vector", function()
		local a = vec3()
		assert.is.equal(0, a.x)
		assert.is.equal(0, a.y)
		assert.is.equal(0, a.z)
		assert.is_true(a:is_vec3())
		assert.is_true(a:is_zero())
	end)

	it("creates a vector from numbers", function()
		local a = vec3(3, 5, 7)
		assert.is.equal(3, a.x)
		assert.is.equal(5, a.y)
		assert.is.equal(7, a.z)
	end)

	it("creates a vector from a list", function()
		local a = vec3 { 3, 5, 7 }
		assert.is.equal(3, a.x)
		assert.is.equal(5, a.y)
		assert.is.equal(7, a.z)
	end)

	it("creates a vector from a record", function()
		local a = vec3 { x=3, y=5, z=7 }
		assert.is.equal(3, a.x)
		assert.is.equal(5, a.y)
		assert.is.equal(7, a.z)
	end)

	it("clones a vector", function()
		local a = vec3(3, 5, 7)
		local b = a:clone()
		assert.is.equal(a, b)
	end)

	it("adds a vector to another", function()
		local a = vec3(3, 5, 7)
		local b = vec3(7, 4, 1)
		local c = vec3():add(a, b)
		local d = a + b
		assert.is.equal(10, c.x)
		assert.is.equal(9,  c.y)
		assert.is.equal(8,  c.z)
		assert.is.equal(c,  d)
	end)

	it("subracts a vector from another", function()
		local a = vec3(3, 5, 7)
		local b = vec3(7, 4, 1)
		local c = vec3():sub(a, b)
		local d = a - b
		assert.is.equal(-4, c.x)
		assert.is.equal( 1, c.y)
		assert.is.equal( 6, c.z)
		assert.is.equal( c, d)
	end)

	it("multiplies a vector by a scale factor", function()
		local a = vec3(3, 5, 7)
		local s = 2
		local c = vec3():mul(a, s)
		local d = a * s
		assert.is.equal(6,  c.x)
		assert.is.equal(10, c.y)
		assert.is.equal(14, c.z)
		assert.is.equal(c,  d)
	end)

	it("divides a vector by a scale factor", function()
		local a = vec3(3, 5, 7)
		local s = 2
		local c = vec3():div(a, s)
		local d = a / s
		assert.is.equal(1.5, c.x)
		assert.is.equal(2.5, c.y)
		assert.is.equal(3.5, c.z)
		assert.is.equal(c,   d)
	end)

	it("inverts a vector", function()
		local a = vec3(3, -5, 7)
		local b = -a
		assert.is.equal(-a.x, b.x)
		assert.is.equal(-a.y, b.y)
		assert.is.equal(-a.z, b.z)
	end)

	it("gets the length of a vector", function()
		local a = vec3(3, 5, 7)
		assert.is.equal(sqrt(83), a:len())
		end)

	it("gets the square length of a vector", function()
		local a = vec3(3, 5, 7)
		assert.is.equal(83, a:len2())
	end)

	it("normalizes a vector", function()
		local a = vec3(3, 5, 7)
		local b = vec3():normalize(a)
		assert.is_true(abs(b:len()-1) < DBL_EPSILON)
		end)

	it("trims the length of a vector", function()
		local a = vec3(3, 5, 7)
		local b = vec3():trim(a, 0.5)
		assert.is_true(abs(b:len()-0.5) < DBL_EPSILON)
	end)

	it("gets the distance between two vectors", function()
		local a = vec3(3, 5, 7)
		local b = vec3(7, 4, 1)
		local c = a:dist(b)
		assert.is.equal(sqrt(53), c)
	end)

	it("gets the square distance between two vectors", function()
		local a = vec3(3, 5, 7)
		local b = vec3(7, 4, 1)
		local c = a:dist2(b)
		assert.is.equal(53, c)
	end)

	it("crosses two vectors", function()
		local a = vec3(3, 5, 7)
		local b = vec3(7, 4, 1)
		local c = vec3():cross(a, b)
		assert.is.equal(-23, c.x)
		assert.is.equal( 46, c.y)
		assert.is.equal(-23, c.z)
	end)

	it("dots two vectors", function()
		local a = vec3(3, 5, 7)
		local b = vec3(7, 4, 1)
		local c = a:dot(b)
		assert.is.equal(48, c)
	end)

	it("interpolates between two vectors", function()
		local a = vec3(3, 5, 7)
		local b = vec3(7, 4, 1)
		local s = 0.1
		local c = vec3():lerp(a, b, s)
		assert.is.equal(3.4, c.x)
		assert.is.equal(4.9, c.y)
		assert.is.equal(6.4, c.z)
	end)

	it("unpacks a vector", function()
		local a       = vec3(3, 5, 7)
		local x, y, z = a:unpack()
		assert.is.equal(3, x)
		assert.is.equal(5, y)
		assert.is.equal(7, z)
	end)

	it("rotates a vector", function()
		local a = vec3(3, 5, 7)
		local b = vec3():rotate(a,  math.pi, vec3.unit_z)
		local c = vec3():rotate(b, -math.pi, vec3.unit_z)

		assert.is_not.equal(3, b.x)
		assert.is_not.equal(5, b.y)

		assert.is.equal(7, b.z)
		assert.is.equal(3, c.x)
		assert.is.equal(5, c.y)
		assert.is.equal(7, c.z)
	end)

	it("gets a perpendicular vector", function()
		local a = vec3(3, 5, 7)
		local b = vec3():perpendicular(a)
		assert.is.equal(-5, b.x)
		assert.is.equal( 3, b.y)
		assert.is.equal( 0, b.z)
	end)
end)
