Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793742632;
	b=SyiNoSmpAxp4epSQy5nZ3WYOmRvqOTw9E+gZbMJTOdMGUw7p+9eRzL/3znwzNGsiCwd2
	 afJYlIvEPmYiZBjOdMVG8MAO3lx0BzWgUeNp+VBi6wdCvLMeZsRrMoyzOLQ25PNy4v2pb
	 gr4p2MZk+jYjXx0bRH8HgzBFqiBWbLAj26KEKlT1vm/MFDq3ra/SNw4PMAqKNMQdxKE5w
	 oiekoDzMxXoqld3WuRYC1hxaOGSK0zUNVqZgccjNLvIJQZadHPUIovkmlXUU3aVXLkoEN
	 xeHEEccTRvscT5mHCKwnPiSk6sdzhy6/O9z4hKVXrPxtHS9gF31HlX2aeqomE+D8iXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793742632;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AN9lkxTO0dSLRNWEFhW0mG6iiKOGycWtBNHavy3ds1Q=;
	b=v0FJpSvLDJRr4bkM0hwHZVook5xt8Em0fluSHn+5pfzCfF3d5HAcS1n3Pwg4w/e8K6pt
	 RxX+GYw/9uoI6vyrslzAuVDbiQY++txbvWzvNrpmkZwY7Sj7jZq28c+YM69l68ADPExpv
	 GDtVOfu0RvWgHMr8QNvI15ksSpAQpL3DQWd2/ezRtwQA+4O4LedMsxHvq5vQ5wamqkFS0
	 1JyDYV9lGBH+89rL7FQNPyYxRanS/KwBNJsWG99Nli+em39BlMLsbD2/bjvX+g/Wa3Pa8
	 KVIMqENxaig0EOHYHx6xW1y8hqSM7EpE/f6uynj4AYw+NDNzmT9VQAv7VOGcR0UdjMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H7kjt4Cx;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=arRY8+oN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785EC606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 21:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 785EC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H7kjt4Cx;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=arRY8+oN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793742630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AN9lkxTO0dSLRNWEFhW0mG6iiKOGycWtBNHavy3ds1Q=;
	b=H7kjt4CxexbgYUQg3/gPkDu9y/18L2J8cByaBMi6RI5mjbGYS6dJPQt/TlCYcXDDHlK2IH
	XEg09Uq3Vy/TvIFv6ZF7mL5VeMkGp6wE8W+8G/2IbTE9DcaW9lUWNq2QhSeuS0cVbckAV1
	hDow4NjdJ6Xp75ORwqcMcbD7xL7MjZY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-sWQyraSONrKhWmIVBVxHkQ-1; Tue, 03 Nov 2026 16:50:29 -0500
X-MC-Unique: sWQyraSONrKhWmIVBVxHkQ-1
X-Mimecast-MFC-AGG-ID: sWQyraSONrKhWmIVBVxHkQ_1793742628
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so31581f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 13:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793742628; x=1794347428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AN9lkxTO0dSLRNWEFhW0mG6iiKOGycWtBNHavy3ds1Q=;
        b=arRY8+oN62FwP+Y34/3dMbi5VZKyjnWCJ0WpH5/rTaGj3sMbqem2EyAFMXwfXEwiUG
         +2PjXVeZbPu2kjDz3xYIhj7B3wM/HPND2HQIAZKeB51pFjz3uvSdgPGC7e4cCkmURPky
         kmhxRLZWQigtNkvddZiYUZz/fUYIHmZInMP+2nIVRRcrq2p6bMKRy/EQAe7k9GBcKsc8
         qym9xHYlYLmkauKMVrFzIR4wxWWbekGMfaNDIIvHapR4Dbqpixc2nougD3BeW+XfoGQp
         hNzhbKlAUm6dhzmKWbKnISmbsbV1Ezqz8G1I4R6CPMOS7VT2oiHloh/F9U73sokR3ZoD
         nzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793742628; x=1794347428;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AN9lkxTO0dSLRNWEFhW0mG6iiKOGycWtBNHavy3ds1Q=;
        b=N4LkwHyAbeY3Sl3Bb7C7fCA+ghzOtqLF9fkkRyiz1e4nn57Us4r52McPYuPuNGaTqU
         RAkPOaBQC4YruZHnWtyvhBKijtq7DQz+o8QBdXqqdUVhTk44BKjON6UuJd9mRmwmuWmS
         xwOIA1NEwXRMiohOYgmf6yqHT0qyQvCDIPgklxt8HA/S/6i/GmbeWRppS0RC7Y+KIVGN
         dpOKk89c0wsby/kw2kihgqvyh/+3Ro/wK9bx4lZaYDWoRRHt0cZVbx8tUeBmwDVAhtQ8
         MYKk467M/kkTKDrN8PfdmzRekXaOcRhtqoqHTa06J+dDcDWxirvRUlhighcAZpNz0VBl
         oMtw==
X-Forwarded-Encrypted: i=1; AKwUvBwhiQihxAZ8Ad1Jf8G1PFFFrCyhq4DYnEf7MpuKrLxTEDRzNWVTqOTOz1onVRHpcK/iJ/FEtDs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/W9soPdENhZ3qF5/XnSiCO/t8NYrufvLURztJ7DJVx2P2uRWu1
	kNUjZ48qtqzroYZNqzX51sFNaQDuyFNE0sz+vK2gzSxXROytmWWnUWo2OFP+kQdHd10eCEMNDd6
	1BzI3Gu7OrJ3y7TmpyDXwyxgo5ZP7GHw+whmAxLOymY1B29wpizZ/8LIsrA==
X-Gm-Gg: AYBFou0fEH8C7gFSmcrOWC2OfCuJtpcwuYLsiHehq17zAJNWz8Czq8SpkTiiD3BT9UB
	d7xQIJ3/jdloYweiBk6w7K8C3l/BLE70Y4e54PEtnbOQbU/1BQUhQMkCOT9slUUI5B5j67RpEHg
	mhOAnKTIpHxkVTvGXOC82wcYrpXmE/+EIIPveUgVtpHTM/fC+kGIThwaYHcZDFJYlLky8szrHqn
	SebmZxvZ886XUdWhi+1pQ7umiTrKcXUktMfOFnFNg3z3eyxnSUEHWp5Jt/QkPAFe8O8USZLkbHX
	nooBzbqqNm6Ejv5NIMtSEzoFZFo8KDUYzxZN3iCX7HnLs49YYUshMLfaZkCjiNr10iNScvbsVt5
	WTmOJVc7fxIuY5iPGTa8o6X1VRK/xAe0TCtXF/GgVguwAnqI4BEosCMZwnOrN1LcWeBJ81tX2zW
	qJ6nDUogM9zIOgvTSoSXsTdIehFAVYFeXGROpUS74HiUs=
X-Received: by 2002:a5d:64e7:0:b0:48e:17d1:16c9 with SMTP id ffacd0b85a97d-48e6e4f5652mr30403943f8f.40.1793742627950;
        Tue, 03 Nov 2026 13:50:27 -0800 (PST)
X-Received: by 2002:a5d:64e7:0:b0:48e:17d1:16c9 with SMTP id ffacd0b85a97d-48e6e4f5652mr30403885f8f.40.1793742627501;
        Tue, 03 Nov 2026 13:50:27 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac2772sm214421f8f.18.2026.11.03.13.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 13:50:27 -0800 (PST)
Message-ID: <0315bf5d-582e-4e8b-8630-9c83be2c7bb4@redhat.com>
Date: Tue, 3 Nov 2026 22:50:24 +0100
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
Subject: Re: [PATCH net 2/3] ice: E825: clear PHY_TSTAMP memory prior to soft
 reset
To: Jacob Keller <jacob.e.keller@intel.com>, netdev-bot+sashiko@kernel.org
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
References: <20261029-jk-e825c-critical-timestamping-fixes-v1-2-72128d1dd928@intel.com>
 <179339643733.3131.11053424586570802270@kernel.org>
 <4239c9d0-734a-4a58-82b3-6663ba90123a@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4239c9d0-734a-4a58-82b3-6663ba90123a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/26 01:54, Jacob Keller wrote:
> On 10/30/2026 2:40 PM, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found more severe
>> issue(s) in other patches of this series. This mail is only an FYI, in case
>> you want to address the nit picks below when you respin.
>>
>> Low priority / nit picks for your consideration:
>>
>> - [Low] The loop in ice_ptp_clear_tx_memory_status_eth56g() (`for (idx =
>>    0; idx < INDEX_PER_PORT; idx++)`, INDEX_PER_PORT = 64) only counts…
>>
>> --
>>
>> ice: E825: clear PHY_TSTAMP memory prior to soft reset
>>
>> This commit replaces the E825 timestamp memory reset with a sweep. The old
>> code wrote zeros to PHY_REG_TX_MEMORY_STATUS. The new code reads every
>> PHY_TSTAMP index on the port, and the sweep only runs from within
>> ice_ptp_phy_soft_reset_eth56g(), so the soft reset puts the internal counter
>> and ready bitmap back in a consistent state. Read failures during the sweep
>> are counted and reported with a warning but are not treated as fatal.
>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>> index 07b55fbb88dde..ef59b34ba52dc 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>>
>> [ ... ]
>>
>>> +static void ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
>>> +{
>>> +	int err, failed = 0;
>>> +	u8 idx;
>>> +
>>> +	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
>>> +		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
>>> +		if (err)
>>> +			failed++;
>>>   	}
>>> +
>>> +	if (failed)
>>> +		dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY timestamp registers for port %u\n",
>>> +			 failed, port);
>>>   }
>>
>> [ ... ]
>>
>>> @@ -2311,6 +2320,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
>>>   	u32 global_val;
>>>   	int err;
>>>   
>>> +	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
>>> +
>>>   	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
>>>   	if (err) {
>>
>> [Severity: Low]
>> What happens here if the sideband queue fails persistently instead of
>> transiently?
>>
> 
> On a previous version I got asked to change to this method because of
> possible transient failures. I think this is best since these reads and
> side effects aren't entirely critical to functional device.
> 
> I would rather leave this as-is and not waffle back and forth about such
> read/write failures that are entirely unexpected in practice.
> 
>> The loop in ice_ptp_clear_tx_memory_status_eth56g() runs for all 64
>> INDEX_PER_PORT entries. It counts failures and never stops early. It also
>> runs before the PHY_REG_GLOBAL read, and that read is the first access in
>> ice_ptp_phy_soft_reset_eth56g() that would catch an unreachable PHY.
>>
>> Each index takes this path:
>>
>> ice_clear_ptp_tstamp_eth56g()
>>    ice_read_ptp_tstamp_eth56g()
>>      ice_read_port_mem_eth56g()
>>        ice_read_phy_eth56g()
>>          ice_sbq_rw_reg()
>>            ice_sq_send_cmd()
>>              ice_sq_done()
>>
>> ice_sq_done() polls with ICE_CTL_Q_SQ_CMD_TIMEOUT, which is USEC_PER_SEC.
>>
>> If the sideband queue head stops advancing, each low read waits the full
>> 1 second and then returns an error. A failed low read skips the high read,
>> so this costs one timeout per index. Fast -ENOSPC failures only start once
>> the 64 entry ring (ICE_SBQ_LEN) fills up.
>>
>> That could mean about a minute of stall in the sweep before the
>> PHY_REG_GLOBAL read fails and the error is returned. Before this patch, the
>> same condition was caught after a single timeout on PHY_REG_GLOBAL.
>>
>> ice_ptp_init_phc_e825c() calls ice_ptp_phy_soft_reset_eth56g(). That makes
>> this reachable from both ice_ptp_init_owner() during probe and
>> ice_ptp_rebuild_owner() during reset rebuild.
>>
>> After the later commit in this series, "ice: E825: perform a soft reset
>> when starting the PHY timer", it is also reachable from
>> ice_start_phy_timer_eth56g() via ice_ptp_port_phy_restart(), which holds
>> ptp_port->ps_lock.
>>
>> Because the sweep runs before PHY_REG_GLOBAL is checked, its read side
>> effects can also land on a port whose soft reset then fails. The new kdoc
>> does tell callers to treat a soft reset failure as a non-functional
>> timestamp block.
>>
>> Would it make sense to stop the sweep after consecutive failures, or on a
>> timeout class error? Another option is to read PHY_REG_GLOBAL before
>> starting the sweep.
> 
> I will change this if the maintainers demand, but otherwise I would much
> rather see my actual issues fixed than continue to be stalled endlessly
> by this AI looping me between different versions.
I haven't parsed the walls of text completely, but so far the saskiko
feedback does not look blocking.

Somewhat related: I think all the changes here could/should be redirected
to net-next as per Linus guidance. Would that be ok for you?

Thanks,

Paolo

