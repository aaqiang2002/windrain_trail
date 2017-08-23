require('gameutil')

local function _new()
	local fAttackSpaceTime=0.3 --�������ʱ��
	local timedFromLastAttack=999999 --��һ�ι��������ڵ�ʱ��

	local getType = function()	-- ������븲�����������������������
		print('weapon.getType: error weapon class')
	end

	local takeoff = function()
		print('weapon.takeoff: error weapon class') -- ������븲�����������ж������
	end

	local frameMove	=	function(timed)
							timedFromLastAttack=timedFromLastAttack+timed; --��һ�ι��������ڵ�ʱ��
						end

	local attack		=	function()
							if (timedFromLastAttack<fAttackSpaceTime) then return false; end --���ι���ʱ����̫��
							timedFromLastAttack=0;
							return true
						end

	local getAttackSpaceTime =	function()
									return fAttackSpaceTime
								end
	local setAttackSpaceTime =	function( stime )
									fAttackSpaceTime=stime
								end

	local getTimeFromLastAttack = function() return timedFromLastAttack end


	return {
				getType = getType,
				frameMove=frameMove,
				attack=attack,
				getAttackSpaceTime=getAttackSpaceTime,
				setAttackSpaceTime=setAttackSpaceTime,
				getTimeFromLastAttack=getTimeFromLastAttack,

			}
end

-- export ----
weapon	=	{
	new	= _new
}
