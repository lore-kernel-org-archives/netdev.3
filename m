Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780271;
	b=BU9f5dASnc87m92VxqjEZMLVCJ/pq7edy9us9TpGJ7JagaAjiTMNseHZC1yQCVkZdvdV
	 bO+xPInrADZmvvbYzwvcDNHfoi4bHi8EO6ZRHxdi97gHlf4+qC/nyoJkEH/Z2GQlbHrnI
	 8k+0hUmBGCFdkBQy60kSQoBNqnfsvKcB68Qg0OdDijwIxkMcYNHm9TcMXO6h0UDSp6cFD
	 TCM0vHXIZcfPVzg5qfs0n9H9UdpR73sk9vzwlFFLDqkNeC0UYbvlUoBdNbljJwaZwY4er
	 djTrnjVXLPijCUMePK5RXwDxp9WdEtSGr3/dLjJI3iLf0iCMJjvPcF0OTX5dSerhNgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780271;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=K/nYYK74vci+plE/oQJ2J9SpXnzUcJOZk2oNqaukYvI=;
	b=v3tX4kizHSiKKm9Hedu3duApdWPNH+1SWvthbgGA2Xii7D7SHxuzDVCqT8yNuUz7HAxy
	 WuRWfrPMI+Xyth4dIYnUJkC00HZzDqlibUMR+xMPWRRStURDgdfNr/UO9O+/58/yVpDeI
	 Rs0cM0pkSectxihlDWO3PMGEC+dLkI68RSR9imJEURwSQKlaW7j1kJpHkusGf2bPvth0a
	 DRAoQUJKBIg5OJRQT9oWSfJqyr5rHOFtmVFFUtDEeLxwdS5fuCEWh5HIunGbzpjiRYCuS
	 fDaHepDU0X7kjdIbUf+xK8xvwWn9Yc4s6wFcfc0qGVx30qQisBV3rOH50HtnHaIddQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aJAmg7sF;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SJ0mmoe0;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BA7606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42BA7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aJAmg7sF;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SJ0mmoe0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793780269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/nYYK74vci+plE/oQJ2J9SpXnzUcJOZk2oNqaukYvI=;
	b=aJAmg7sFfRmviV8ozFLyDHW6jxjYAi8otgMzQAGiDCzWC+5ZB5ruxUx4Tl+mTJj1vXrOVB
	ylKXX+WZks8/mri5qG0c0/e5a6cRnsat1WOhqInLYeEarh7rMmcaM8433ggSkM0jpX220I
	z5LyDKKP5/D4vkECFdtNLj+ZSoTYExs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-9QxJK4CtP1KmWpEF6VCBiA-1; Wed, 04 Nov 2026 03:17:48 -0500
X-MC-Unique: 9QxJK4CtP1KmWpEF6VCBiA-1
X-Mimecast-MFC-AGG-ID: 9QxJK4CtP1KmWpEF6VCBiA_1793780267
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df5b058ddso266281f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793780267; x=1794385067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/nYYK74vci+plE/oQJ2J9SpXnzUcJOZk2oNqaukYvI=;
        b=SJ0mmoe0PoMKN+0FCNr8fQgmTnfU/wzNSL2Qco7q1R/9Fk5591PAAFG7OZhXDbsPmJ
         Co0veKJcOC+DnULprKdRpLA9ZI7NGPVMkcEWxkdoytqim09bSncOJVQSM8zwS1DNC7Ln
         /ak7v9Wp+iFKknFGbJtCCvWDif1tyhCEPtgQKloGWTStSm7bfiGbtlzx6PKlXhGr3bUp
         mYzzHsZXGnbzoUPeRnnM86cuChXUxK6+AdEXgCCu/LtDlidWVONqvUsVFOo8DytruhvE
         LfpU81MHw1R+ehnJdmE7aNK7mn22WVTjhC49nhL60Rhu7r8rbs5qMX/T4q78jxVYiEQb
         HH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780267; x=1794385067;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/nYYK74vci+plE/oQJ2J9SpXnzUcJOZk2oNqaukYvI=;
        b=o9IsPnWhO4cbvh+IG6YLgt15U7KcA486Tvy3aNQPILcmkLS4Rbaw2jX7vcbCabvZkp
         df/teHlV7kMYZDGbPrHVihpthHGhIss4qQqjYF1hE5IF/W31yXtx66Kp+vVP5HlUBPf1
         DZiG+WstU9EcnMrdN6Dge3PqbHPD5epfW4Ld2qn1is+Vd54YUNKE7rA1g4KY65h5y9AA
         OAxQpDkowQPZeXDww/N6y8uaTtVF/iEVsZAjn7sx5xP0f/fTmknSSW+jCb5QIQui2Jkk
         ZUaC+WPHnQN+BiQNtXoehx7QGy4iXQ58IDJjL2fLXepSWsJe+MwG0qXgysn9lpI398N9
         bJNA==
X-Forwarded-Encrypted: i=1; AKwUvBxQEgMekXumj+lJRNyIsS7s2GKRH8LPjhA5tFkHtHH8kAV61sAcoYmrQCIwRwBXilIYPOp/i34=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZavLqeb4w7cZ8aPBwh8j0lC67/jrC8qATFEiDIzokM3CaWxXu
	ICf+qXeIKFiTKfaq4ZTzL3v3TkzPNn5bnZnNhg4ZLcNhaSF5qwYELOVgYbdBmPr26vYYgwBu0Vp
	o8ffA0onzPniip/b4+r6baSRT2Ib1mDioQZg+6Brbyp8bjlhmx+CrvMntcw==
X-Gm-Gg: AYBFou3mtI32ky4TS+4B/MQcM1FCklwxRQkdMcPAKl3YLZaQtv31ob7DOAc6xTgA+gB
	/0m2QeaUQwB6ORlxG0+wKhy0VVpLlfy+n04wiYP2AhDFAGKEFRATVPCq91Nx3fKeOZjpTeuIA/8
	HfpOctiy2xEtekhjLN+CMFt0sktj9UnoP2lWS0Hl/i5ZnW/8cjDO1gj+HF4Nn/UUoflRmVsGSZf
	eN6EWHtbAlbtRLEZ5F6Pkl3S+3PGjWYkk/XguZm3QiSalTBljeU+1TIlOXcWE384fPnOx/FHrM1
	hcNOmk3dM1kYkgdPhPUNYLuPSRvVNuA+2+n/bJxdSsccghj5EpiWl2VDnotxXMftnh8D+YxW9RI
	Mxu6lQJn0INEU6bFiZ24x788z3nk3/2YXTTPdnuknWQntMLgAl65AU+1gMBT4FGPmaQqbafUxVT
	f/UEeBrer2/9GJUIeJH79KJgVqX12LQar0IR+VhvsyqYc=
X-Received: by 2002:a05:6000:22c4:b0:48d:ff0b:9b52 with SMTP id ffacd0b85a97d-48e6e306ebamr37338759f8f.19.1793780266779;
        Wed, 04 Nov 2026 00:17:46 -0800 (PST)
X-Received: by 2002:a05:6000:22c4:b0:48d:ff0b:9b52 with SMTP id ffacd0b85a97d-48e6e306ebamr37338727f8f.19.1793780266288;
        Wed, 04 Nov 2026 00:17:46 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea180e7csm2500500f8f.5.2026.11.04.00.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:17:45 -0800 (PST)
Message-ID: <5178b7f6-6b2f-4dde-8ed4-d6912024f23e@redhat.com>
Date: Wed, 4 Nov 2026 09:17:44 +0100
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
Subject: Re: [PATCH net 3/3] ice: E825: perform a soft reset when starting the
 PHY timer
To: Jacob Keller <jacob.e.keller@intel.com>, netdev-bot+sashiko@kernel.org
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
References: <20261029-jk-e825c-critical-timestamping-fixes-v1-3-72128d1dd928@intel.com>
 <179339643889.3131.9026864983755179552@kernel.org>
 <b0f30a78-4f23-47c4-9ea1-dedc45abf2c5@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b0f30a78-4f23-47c4-9ea1-dedc45abf2c5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/26 02:01, Jacob Keller wrote:
> On 10/30/2026 2:40 PM, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 0 · Medium: 2 · Low: 0
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [Medium] In the E825 link-change restart path, the software Tx
>>    timestamp tracker is not flushed, yet the PHY timestamp memory it…
>> - [Medium] ice_ptp_phy_soft_reset_eth56g() now runs on every E825 PHY
>>    restart, including while Tx traffic is live, but in-flight timestamp…
>>
>> --
>>
> 
> I believe these remaining issues are not realistic, or minor and not
> something that should be holding us up from getting these fixes landed.
> I had originally tried to mitigate some of these but have gotten so many
> complaints and run in circles by Sashiko here. I do not know how to
> modify this so that it won't complain....
> 
> Trying to break things into smaller pieces seems to get complaints about
> the things that we had planned to fix with the full series. :\
> 
>> ice: E825: perform a soft reset when starting the PHY timer
>>
>> This commit adds a call to ice_ptp_phy_soft_reset_eth56g() in
>> ice_start_phy_timer_eth56g(), so the E825 PHY timer block starts in a
>> clean state. The soft reset sweeps the Tx timestamp memory and resets the
>> PHY timestamp counter before the PHY is programmed.
>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>> index ef59b34ba52dc..ee945ce08eb72 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>
>> [ ... ]
>>
>>> @@ -2150,6 +2152,10 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
>>>   	if (err)
>>>   		return err;
>>>   
>>> +	err = ice_ptp_phy_soft_reset_eth56g(hw, port);
>>> +	if (err)
>>> +		return err;
>>> +
>>
>> [Severity: Medium]
>>
>> On the link change path, should the software Tx timestamp tracker be
>> flushed before this runs?
>>
> 
> I tried that in a previous version and the AI pointed out all kinds of
> possible races that might occur then.
> 
>> ice_start_phy_timer_eth56g() is also called at runtime. The chain is
>> ice_link_event() or ice_up_complete() -> ice_ptp_link_change() ->
>> ice_ptp_port_phy_restart(). For E825, that path only marks the
>> outstanding entries as stale:
>>
>> drivers/net/ethernet/intel/ice/ice_ptp.c:ice_ptp_port_phy_restart() {
>>      ...
>> 	case ICE_MAC_GENERIC_3K_E825:
>> 		...
>> 		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
>>
>> 		err = ice_start_phy_timer_eth56g(hw, port);
>>      ...
>> }
>>
>> ice_ptp_mark_tx_tracker_stale() only ORs in_use into stale. Both in_use
>> and tstamps[idx].skb stay set.
>>
>> With this patch, ice_ptp_phy_soft_reset_eth56g() then calls
>> ice_ptp_clear_tx_memory_status_eth56g(). That function reads all 64
>> entries of the port, which clears their valid and ready bits. The soft
>> reset then clears the ready bitmap and the counter.
>>
>> Take an in_use index whose timestamp the PHY has already captured but the
>> IRQ thread has not yet read. Its ready bit is now gone, so
>> ice_ptp_process_tx_tstamp() skips that index on every pass:
>>
>> 	if (tx->has_ready_bitmap &&
>> 	    !(tstamp_ready & BIT_ULL(phy_idx))) {
>> 		if (drop_ts)
>> 			goto skip_ts_read;
>>
>> 		continue;
>> 	}
>>
>> This continues until the 2 second timeout fires, and the timeout also
>> increments pf->ptp.tx_hwtstamp_timeouts.
>>
> 
> Yes. This is the expected path in the current logic.
> 
>> Until then, ice_misc_intr_thread_fn() keeps re-arming the interrupt,
>> because ice_ptp_tx_tstamps_pending() sees a non-empty in_use. Each pass
>> does a sideband read of the ready bitmap. The skb reference taken in
>> ice_ptp_request_ts() is also held for that whole time.
>>
>> Before this patch, those entries stayed ready in hardware. They were read
>> and dropped right away through the stale bit, and were not counted as
>> timeouts.
>>
>> ice_ptp_rebuild_owner() already flushes the tracker before
>> ice_ptp_restart_all_phy():
>>
>> 	/* Flush software tracking of any outstanding timestamps since we're
>> 	 * about to flush the PHY timestamp block.
>> 	 */
>> 	ice_ptp_flush_all_tx_tracker(pf);
>>
> 
> Yes, but I am now certain that if we added this today it would get
> rejected because the flushing appears to be problematic at run time. In
> fact part of the other areas of the previous series was done to help
> prevent this, but was undergoing its own challenges.
> 
>> Does the link change path need the same flush? The timeout does
>> eventually release these entries, so the slots are not lost for good.
>>
>> [Severity: Medium]
>>
>> Could a timestamp captured during the soft reset window leave the PHY
>> counter and the timestamp memory out of sync?
>>
> 
> I do not believe that the hardware will actually perform timestamps
> while the soft reset is active.
> 
>> On E825, the Tx queues can be live when this runs. ice_up_complete()
>> starts the queues before it restarts the PHY:
>>
>> 	netif_tx_start_all_queues(vsi->netdev);
>> 	netif_carrier_on(vsi->netdev);
>> 	ice_ptp_link_change(pf, true);
>>
>> ice_link_event() also restarts on a speed change while the link stays up.
>>
>> ice_ptp_port_phy_restart() sets tx.disabled, but descriptors already
>> posted with ICE_TX_FLAGS_TSYN can still be sent.
>> ice_stop_phy_timer_eth56g() also leaves PHY_REG_TX_OFFSET_READY set, so
>> such a packet is captured as valid.
>>
>> Inside ice_ptp_phy_soft_reset_eth56g(), the memory sweep runs about 5 ms
>> before the reset is asserted, and the reset is deasserted about 5 ms
>> after that:
>>
>> 	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>> 	...
>> 	usleep_range(5000, 6000);
>>
>> 	global_val |= PHY_REG_GLOBAL_SOFT_RESET_M;
>>
>> Suppose a packet is captured after the sweep but before the reset is
>> deasserted. The kernel-doc of ice_ptp_clear_tx_memory_status_eth56g()
>> says "the soft reset does not clear the timestamp memory", so that valid
>> entry stays in memory. Meanwhile the reset zeroes the counter and the
>> ready bitmap.
>>
> 
> Again, this is working on the assumption that hardware will actually
> perform a timestamp while the soft reset is asserted.
> 
>> Only the 2 second timeout would free that software entry. The entry could
>> still be read, for example by a concurrent reader, or depending on how the
>> hardware handles reuse of an index that is already valid. Would that read
>> underflow the counter and stop Tx timestamp interrupts, as that kernel-doc
>> warns?
>>
>> Should in-flight timestamp requests be quiesced before the soft reset?
>> Packets captured after the reset but before ice_sync_phy_timer_eth56g()
>> look like they are dropped safely through the stale bitmap.
>>
> 
> We did have changes in the rest of the full series to address this by
> having the driver stop new requests while the timer was stopped, and
> marking things as stale ensures that the indexes won't get released. I
> had also tried to make sure that stale packets didn't increase the
> timeout counter unexpectedly, and to change so that the skb was freed
> earlier. Those were all delayed because of other issues on the full series.
I think this series can be merged as-is. I also think it's more suitable
for net-next that for net. Unless you disagree strongly I'll apply it there.

/P

