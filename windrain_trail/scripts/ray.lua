
local function new( ray )
	if (type(ray) ~= "userdata") then error("ray expected") end

	local getOrg	=	function()
							return vec.new(ray:get_org())
						end
	local setOrg	=	function(v)
							if (type(v) ~= "table") then error("vec expected") end
							ray:set_org(v.x,v.y,v.z)
						end
	local getDir	=	function()
							return vec.new(ray:get_dir())
						end
	local setDir	=	function(v)
							if (type(v) ~= "table") then error("vec expected") end
							ray:set_dir(v.x,v.y,v.z)
						end

	local r=_new_udhead_tb(ray)

	r.getOrg=getOrg
	r.setOrg=setOrg
	r.getDir=getDir
	r.setDir=setDir

	return r
end

-- export ----
_new_ray_tb=new



ray	=	{
	new	=	function(handle) --handle��������ǿ�����ray table�У�����handle����Ϊ�ա� 
				return _new_ray_tb( _new_ray_ud(handle) )
			end,
}
