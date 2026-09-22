Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B11A6838
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036605; cv=none; b=pNFv2q3DGzOW3POlMI/NkQnjWW8+1LJWuvS0Ddd63xRYgY/0r/Q/UiAqzvlQk9G08tnmV6bfR+TLCsNcT1wD3qoVmpkDgTJCFZ9KncsRkbeDkJbeLlPL9ICrMGJStDZ2EdFgW0y8inFYoZ0ufRHArVaWoyi6BsJ4GS0CS/Awe9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036605; c=relaxed/simple;
	bh=HFcrsUWyZ6KWdWBfjuzfuKv2iEmsrReA5jU2H9HIctw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To; b=I3/AqzXqaqTZ1dm4H/R2QW0jRsIYaghD9/nzniPh2X8ONPc9MTuZvwhUEOi1oHQRa7FjGZzLBN9KAC3oHOKj4g0LuMvVDKwEbJoFqY6QskMTGEls9A7L7z1/yQnQyHUIPI2DFwijVTxL55qX5lkIQiyjmJwkl+xhj6stQciCTDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=XDCKdSL5; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XDCKdSL5"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-39682983a0fso1233893a91.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790036603; x=1790641403;
        h=user-agent:in-reply-to:content-disposition:content-type:references
         :message-id:subject:cc:to:from:date:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jb2g+Y57oxCad34/2smmjYzFI5NjD86QRYnClytZfXk=;
        b=hENpzA3SMW4BzQgfzr5rZ1blU79h4aQ3R8++I6cacR3R1OICS2/4YNiV0pYRmLp+YB
         TVcN+0c2WWCP0OySxmHee9wCJZKxNFuUiyedO+3+o8XqX6SEXQnutsaDdKYbeNoSAYzA
         WLSh/avS68/GHVv19Fvang89EvH6tTRF7Nctm52tzS4i9S96xBOWn7PrUBehU3T4KWQA
         RO6Iqfvdk+l74hpvefWvtg6EIwd0zkleUtgQxIU5BOgBDCSyCGB6Bgew4a3+CDcemaV/
         hHvx+u1hXG5YG7a0KfH7SZjwSGzGwC7X0vmPTOjgM22OVBBKeAgYR/MTxU9qRpPi0lqX
         JyiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDwme3Rnt3MNjjMzhLRUj4z9aVI7NvrYUqv2SWAXKEf47gS368LYt3Q4BkuUIQ4nUGKSood58=@vger.kernel.org
X-Gm-Message-State: AFuF++m7K70S/4+z0oYEW9uuYsiqK7q+di7BpwxLySO+15HQfXCCkpk4
	8MxhMui1e0KDWYscSSQKswf/8E78daQAn41IYdmSz3N0kRZYs5e9gXcLXgdoatywnm4HcugRL5H
	C5Svg9AvMUJ7uXT9LOeKBEQG2WIgoA6KkYw==
X-Gm-Gg: AYBFou1a+k56WlCc6FUqdxQU9oP5dT7SQBNQwWCbp5NfVlU4mEKlMVjRH6u9YM++Zk/
	YcPqZ33Zt7J1Ffv6BgMBy8K+n0SqYQo6wL27o1GjZdhTjFPjZG5hpOzIobjZao9CDtTmctZmVAk
	xeBmu5h8KlGymkEu7SNwTME37etJ1lPAvdwqsMHg5liKjpaL/iHECEOCV50n7iy2bkZE7G49VNW
	KRJtLIXkCR/j6sDhmMa5aumP287Ksr47BNwZ/T+xGifDLA3eAjo+5juELEv6lNMTgvlshnQkiNR
	YwwexZ8Zr8hTzRGmvt10KNhA6+4clxGu9EjT9xKaHmH/zAkT98P1jOvJA51N9d6nbDZ9FeTkGVN
	U5OooSiT2+NcPol2Vx/LlXc3XE38Ccg8=
X-Received: by 2002:a17:90b:4fc9:b0:39d:f253:5fc4 with SMTP id 98e67ed59e1d1-3a06ae1fe20mr651639a91.17.1790036602279;
        Mon, 21 Sep 2026 17:23:22 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx1.aristanetworks.com. [74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a066cbc29asm580682a91.5.2026.09.21.17.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:23:22 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1790036600;
	bh=Jb2g+Y57oxCad34/2smmjYzFI5NjD86QRYnClytZfXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDCKdSL5HclnKuYD6vvovWla5x3ysQwzgFIrBLk/UOtY7EqWYAFdI/cGh4IDl2jkO
	 IImUMPXnRGR73j+xDvMw4/of1ySztUZ2ng54YzHgj753CTFnoiPSKlD+ayJhBMmoJ7
	 yTtcVbD8y+Eu5AWQoOU4ID17sw7Mj/UCLsHS5CpXBrZc2q8P6mAWdAzcQFrq6pa9T3
	 7rqNiKj1MLKONZuBBu8XASbtykjMCcpCfjBXotx+Skc1QvUYDKWbjNk+jeM3ZhyzT6
	 zAduB1z2J/duHRdq/7k4vlJaVochrtrbEa21KIXhAm2BRoK9DT6jhp+xDud0u4L7ks
	 J5dXCWs1nXc7g==
Received: from visor (unknown [10.95.69.250])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id A0C10100423;
	Tue, 22 Sep 2026 00:23:20 +0000 (UTC)
Date: Mon, 21 Sep 2026 17:23:19 -0700
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: netdev-bot+sashiko@kernel.org, pavan.chebbi@broadcom.com
Cc: kuba@kernel.org, michael.chan@broadcom.com, netdev@vger.kernel.org,
	atharvatiwarilinuxdev@gmail.com
Subject: Re: [PATCH net v3] tg3: use random MAC address when
 tg3_get_device_address fails
Message-ID: <20260922002319.GB22324@visor>
References: <20260917223416.GA245819@visor>
 <179003423707.2160803.15146112639455736653@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179003423707.2160803.15146112639455736653@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

There is v4 at https://lore.kernel.org/r/20260918224715.GA654128@visor
by the way, which hopefully addresses what Andrew had in mind.

On Mon, Sep 21, 2026 at 11:43:57PM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Can this randomize the address on a system that does have a MAC available
> through the generic provider infrastructure?

This point still stands in v4, and I can make that change inside
tg3_get_device_address, but what do you think Pavan? It sounded
like from the v1 discussion that you preferred we avoid changing
and cleaning up tg3_get_device_address much further.

Thanks a lot,

> The tail of tg3_get_device_address() looks like this:
> 
> 	if (!is_valid_ether_addr(addr))
> 		return -EINVAL;
> 
> 	if (tg3_is_default_mac_address(addr))
> 		return device_get_mac_address(&tp->pdev->dev, addr);
> 
> 	return 0;
> 
> So the -EINVAL return happens before the only device_get_mac_address()
> call in the driver. If the SRAM mailbox has no 0x484b signature (or
> reports the zero address the comment in that function mentions as "Some
> old bootcode may report a 0 MAC address in SRAM"), and NVRAM plus
> MAC_ADDR_0_HIGH/MAC_ADDR_0_LOW also yield an invalid address, the
> function returns -EINVAL and the fwnode "mac-address"/"local-mac-address"/
> "address" properties and the nvmem "mac-address" cell are never consulted.
> 
> tg3_init_one() then skips the new err == -EPROBE_DEFER test and calls
> eth_hw_addr_random(), so the device binds with NET_ADDR_RANDOM and only a
> dev_warn, even when device_get_mac_address() would have supplied the real
> address - or would have returned -EPROBE_DEFER because the nvmem provider
> is not registered yet.
> 
> Does the earlier call in tg3_get_device_address() cover that case?
> 
> 	if (!eth_platform_get_mac_address(&tp->pdev->dev, addr))
> 		return 0;
> 
> eth_platform_get_mac_address() in net/ethernet/eth.c only looks at
> dev->of_node and arch_get_platform_mac_address(), and folds every failure
> into -ENODEV:
> 
> 	ret = of_get_mac_address(dev->of_node, mac_addr);
> 	if (!ret)
> 		return 0;
> 
> 	addr = arch_get_platform_mac_address();
> 	if (!addr)
> 		return -ENODEV;
> 
> while device_get_mac_address() is the one that reaches the non-OF fwnode
> properties and the device level nvmem cell:
> 
> 	if (!fwnode_get_mac_address(dev_fwnode(dev), addr))
> 		return 0;
> 
> 	return nvmem_get_mac_address(dev, addr);
> 
> Would it make sense to query device_get_mac_address() on the invalid
> address path too, before falling back to eth_hw_addr_random(), so that a
> firmware supplied MAC and a genuine -EPROBE_DEFER are not lost?

-- 
Ivan Delalande - Arista Networks
