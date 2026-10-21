Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570879;
	b=Lo8E3KcPcjvanJ6FWcrKM2eSI4PkqBOhSFkDSo1EID80tfnGdFdsmbRKFzxMo+u322PX
	 xpvhgSrCl2IrWCP8oVrkdYVnUzCMesGuQP6fEkXq+GOqFklCt0q2xdk0kiaUv/qIGx8/H
	 fMzIvBbuGxVrrEvO5TQ9NN7qV6SG7kbdI8iJUWHo5y2EmiSXc2H+aJjFMG3RBobCi9amG
	 USAUuSBYtjoiLIEfQfiaAEJWdsYvXTdhoj61N7HufcNQVmfEeFDiC+IYbx1jWzzBZ8adp
	 WgpDaLzqKTVHhr2nLia054WSCIIj2tlgKAqORA5plqJw05H+Pst4fIVHuCat2aluX2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570879;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=0961khO16PkdzOShYW1kFf3MmaVSSQ4+4dmHU+OQtRA=;
	b=DG3RdizixaWaJcgr1zLrv5+6JttmWZuybumli30d4+2uJdGBUC/f9d5gBsEhhSdlnUFK
	 o7a6dFhzBtC/G3nnZfEYT5XRkABhfbNJ/6hqZZRCzx9ZfxUpHk2Yd3Uv46PQDno8Xr5fg
	 id5aEO1ndvSEzLaWcnBrUgbBxbMJHHMcGoeF6aqtNbRmgisSJtHyLDDwGoJ8lrrBVczLK
	 81hBquYEHJ42+vqZwZ/ui3EGrORXR3npwmFD1HzEJfLUrqrKYB5wtse7uTADKyCFfB+TI
	 5Ftea2otNnNBJnHcttjS5lQbbOd3+3WFTrg/5SDMLb8zp/up9HDjruS2M8rsWEl7/3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Qx+Ai6JE;
	arc=none smtp.remote-ip=220.197.31.7
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49039606A31A;
	Wed, 21 Oct 2026 08:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49039606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Qx+Ai6JE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=0961khO16PkdzOShYW1kFf3MmaVSSQ4+4dmHU+OQtRA=;
	b=Qx+Ai6JEFX2UmZU/hmO7oEhJBviTZLFFvJd5qi1XUfoF058nyoS8dF7anvcKif
	+f5Zd2MXQIcNp3/daxTw1pGmgbW7A5RYnZBPf8eqEaJmOx0w8mPfxyyAP8FzcdXL
	2KjTroJvNfwEagAjIg7mavn4ck5pNciHM541Re727hr0U=
Message-ID: <62b3a378-f911-4c2f-85c7-53aa3f51ee43@126.com>
Date: Wed, 21 Oct 2026 16:20:19 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: do not report success for a VF setting that
 was not applied
To: Jacob Keller <jacob.e.keller@intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261012082910.283229-1-xiaolinkui@126.com>
 <2b9f2117-1bc0-4d83-a30d-1c8f7b295ab2@intel.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <2b9f2117-1bc0-4d83-a30d-1c8f7b295ab2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3dyHDddhq9iGuBg--.32140S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1ktryrWr47trWrWr1UAwb_yoWrKr48pa
	93KFn0kr4DGrWIv342vr42vr1FkrWrKF43Jr15Gr90ywn8WrWIvF4rKr4qva48Aw4fG34a
	vFsxXw4DZrWDX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uuv38UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlARfNmrYdcT5nQAA3e

Hi Jacob,

thanks for the review. v2 follows your suggestion, with one adjustment.

On 2026/10/21 03:10, Jacob Keller wrote:
> On 10/12/2026 1:29 AM, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> __ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan() all
>> check that the VF is ready for configuration, take vf->cfg_lock and then
>> call ice_reset_vf() to push the new setting into hardware. The result of
>> ice_reset_vf() is not looked at, and it could not be: it returns 0 both
>> when the reset ran and when it bailed out because the VF is disabled.
>>
>> The check runs before the lock is taken, so a reset can disable the VF
>> in between. ice_reset_all_vfs() raises ICE_VF_DIS in pf->state before it
>> walks the VF table, rebuilds every VSI and clears the bit again. An
>> ndo_set_vf_mac() that passed ice_check_vf_ready_for_cfg() just before
>> that then waits for cfg_lock, stores the new address in vf->dev_lan_addr
>> and vf->hw_lan_addr and calls ice_reset_vf(), which sees the VF
>> disabled, stops its queues and returns 0 without reprogramming anything.
>> __ice_set_vf_mac() reports success, so ip link and the devlink port
>> function now show a MAC address the hardware never got, and the switch
>> keeps enforcing the previous one until something else resets the VF.
>>
>> ice_set_vf_trust() and ice_set_vf_port_vlan() have the same shape: the
>> port VLAN lands in vf->port_vlan_info and the trust flag in vf->trusted
>> before the reset is skipped.
>>
>> Re-check ice_is_vf_disabled() once cfg_lock is held and fail with
>> -EINVAL, the same code ice_check_vf_ready_for_cfg() returns for a
>> disabled VF. The VF is being reset or removed at that point, so the
>> caller should retry rather than be told the setting is in place.
>> Changing what ice_reset_vf() returns on that path is not an option, too
>> many callers rely on it meaning "nothing to do".
>>
>> The race was found by code inspection of the ndo VF handlers, it was not
>> reproduced at runtime and no error message was observed.
>>
> Hm. My recollection is that we should set something on the PF side that
> stores the new address so that the VF would get that value when next
> configured.. But I guess that isn't how ice works.

It is how ice works, and that store is why one of the two interleavings 
is harmless. __ice_set_vf_mac() already keeps the address in 
vf->dev_lan_addr / vf->hw_lan_addr, and every rebuild replays it through 
ice_vf_rebuild_host_mac_cfg(). The bug needs a window where nothing 
configures the VF again: ice_reset_all_vfs() rebuilds VF n under its 
cfg_lock, drops the lock, moves on, and only clears ICE_VF_DIS after the 
last VF. If the ndo handler takes cfg_lock in that gap, it stores the 
setting, its own reset is skipped, and the PF-wide reset is already past 
this VF, so no rebuild ever replays it. If the handler instead wins the 
lock before the rebuild loop reaches this VF, the follow-up rebuild does 
replay the store. That is why v2 fails the request rather than trying to 
re-arm a reset of its own.

Worth noting the ICE_VF_STATE_INIT half is not what catches this window: 
ice_vf_set_initialized() has already run for the VF by then, only the 
PF-wide ICE_VF_DIS bit shows the reset is still in flight.

Two things I would like your opinion on:

-EINVAL is what ice_check_vf_ready_for_cfg() returns for a disabled VF, 
so v2 keeps it, but -EBUSY would say “retry” more clearly. Easy to 
switch if you prefer.

ice_repr_ethtool_reset() has the same shape and also reports success 
when the reset was skipped. It stores no setting, so I left it out of 
this patch, but happy to fold it in.
> 
> Why not just move ice_check_vf_ready_for_cfg() inside the mutex though?

v2 moves the flag tests inside cfg_lock, but not the sleeping half. 
ice_check_vf_ready_for_cfg() starts with ice_wait_on_vf_reset(), 40 x 20 
ms of msleep polling for ICE_VF_STATE_INIT, and the resets that clear 
that bit set it again from ice_vf_post_vsi_rebuild() with cfg_lock held. 
Under the lock the wait could never observe the transition, it would 
burn the full 800 ms and still return -EINVAL, while stalling the reset 
and the VF mailbox that ice_vc_process_vf_msg() serves under the same 
lock. So the wait stays outside, and the flag tests are repeated inside 
by ice_check_vf_ready_for_cfg_locked(), which replaces the three ad-hoc 
ice_is_vf_disabled() tests of v1.

v2 is posted as “[PATCH iwl-net v2] ice: do not report success for a VF 
setting that was not applied”, rebased on top of 0a01e1df137f (“ice: 
skip unnecessary VF reset when setting trust”):

https://lore.kernel.org/netdev/20261021081248.261762-1-xiaolinkui@126.com/

Thanks,
Linkui

