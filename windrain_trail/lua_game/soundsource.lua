-- soundsource.lua
require 'gameutil'

local function _new( list )
	list = list or {}

	local txtDesc = '' -- ��Դ����
	local disable = false --�ر���Դ

	local position = nil			-- 3d�ռ�λ�ã���Ϊnil�����κ�λ�ö�����
	local range = 999			-- ��Χ
	local timeIntervalMin = 3		-- ����ʱ����
	local timeIntervalMax = 6
	local soundlist = list	-- �����б�
	local volumescaleMin	= 1 -- ��������
	local volumescaleMax	= 1 -- ��������


	local sndtime = timeIntervalMin + (timeIntervalMax - timeIntervalMin) * math.random()

	local function frameMove( timed )
		
		if disable then return end
		sndtime = sndtime - timed
		if sndtime>0 then return end
		sndtime = timeIntervalMin + (timeIntervalMax - timeIntervalMin) * math.random()

		local dis = 0
		if position then
			dis = (camera.getPosition() - position).length()
		end

		if dis > range then return end
		local vs = 1 - dis / range
		vs = vs * (volumescaleMin+ (volumescaleMax-volumescaleMin)*math.random())
		if vs<0 then vs=0 end
		if vs>1 then vs=1 end
		local vol = (1-vs) * -7000
		
		local soundnum = #soundlist
		if soundnum>0 then
			PlaySound( soundlist[ math.random(1,soundnum) ], vol )
		end
	end

	local function getDesc()
		return txtDesc
	end

	local function setDesc( desc )
		txtDesc = desc
	end

	local function isDisable()
		return  disable
	end

	local function disable( dis )
		disable = dis
	end

	local function getPosition()
		return position
	end

	local function setPosition(pos)
		position = pos
	end
	
	local function getRange()
		return range
	end

	local function setRange( r )
		range = r
	end

	local function getTimeInterval()
		return timeIntervalMin, timeIntervalMax
	end

	local function setTimeInterval( tmin, tmax )
		tmax = tmax or tmin
		timeIntervalMin = tmin
		timeIntervalMax = tmax
		sndtime = timeIntervalMin + (timeIntervalMax - timeIntervalMin) * math.random()
	end

	local function getVolumeScale()
		return volumescaleMin,volumescaleMax
	end

	local function setVolumeScale( vmin, vmax)
		vmax = vmax or vmin
		volumescaleMin = vmin
		volumescaleMax = vmax
	end

	local function addSound( snd )
		add_to_list(soundlist, snd)
	end

	local function delSound( snd )
		remove_from_list(soundlist, snd)
	end

	local it={}

	it.frameMove = frameMove
	it.getDesc = getDesc
	it.setDesc = setDesc
	it.isDisable = isDisable
	it.disable = disable
	it.getPosition = getPosition
	it.setPosition = setPosition
	it.getRange = getRange
	it.setRange = setRange
	it.getTimeInterval = getTimeInterval
	it.setTimeInterval = setTimeInterval
	it.getVolumeScale = getVolumeScale
	it.setVolumeScale = setVolumeScale
	it.addSound = addSound
	it.delSound = delSound
	return it

end

-- export ----
soundsource	=	{
	new	= _new
}