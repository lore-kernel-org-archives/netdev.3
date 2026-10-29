Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295587;
	b=uugd1F+qi0549IsJKbUvHo4vnDUj+uVJmnTJMR3rca68HIyNyPbK1pVxVqu+BN2I8f0I
	 M6IS8bmc75VXTncZHPegA8omrWjlZ1Rt2D5GSZBbX0/RkMB0aDX4mUH6CWFV5fZZ6eIDD
	 00NHGmgA3UZN/oy7LzY0P222vwzqQqSkVTjt6q1xDlmDTKu6wdub2YV2iLUdpyQ26UXwR
	 qNCRVngQZtkDXS3G28y33Fh03ukX0LfpQbKQvL5dpMCwuGDIQey2nFWaKjKkoGdlSrkqT
	 LgiKinKiO63Tg3O4q/a50lwFyUO7L+f2SFXGllPQL271+97jL01HzS/FPiB7DNzP4hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2KFGBRNvis/xUmUAvIOrrCN5aEDyUWLLVbvBnaXFBhc=;
	b=BWlv494iwAuYo7iXV975BtYYXfxwW4dy7FviH/re5xtFhqvLKQCh+A0FHjs4ShRyGte7
	 nqpqfakAD7EMWg49DBEkZp5E0w/jEbiOIwdMHukm80UKNyIdV6dwa7xAEMNvt7dm687BX
	 mQ/kIqvA9sJD5yRkFP+gBECmPMTmJawkJDSNWYaZK4/fdSUwHGEw7+WGW6tgXuFM9iZeo
	 3gg8yEHwPutM6JH8FQhgxVjMYtht8e6ucU8HxrfkD9A04dlPGec3sx0cnEOsFloS4IPi+
	 xAoQUUQsArazo5yhgtaDhH92GL2JJwJY30iSPywNdzcMJpQKr6M3NsqGIukTL8TEoEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bTChIusW;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA0606A323
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CA0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bTChIusW
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35b2c599f43so5147143eec.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295585; x=1793900385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2KFGBRNvis/xUmUAvIOrrCN5aEDyUWLLVbvBnaXFBhc=;
        b=bTChIusWhmWDjhb/gvsYidbtfMSN8BhAoQoTqV2awLxnaSpbKivz/o6b+oh5WEv2HO
         fXSD9C1lB5FdUuy01Wwl7F4l/wA7GtF/eMIu1FURCn9XG6GFw+3B+0BMuEB5Ofb0Hgpt
         JXvYvCCAq6uQjhzOW84vuyN+2p15bZg3AOiaVy6a0Idg+p2/IKXPIQQJ1sAeeLMUk7e0
         HcYcfakIPQX5L9DNef0xqdonwWllXEziBRvF9j2Xks6eWacdkElomVKlvzeM5oNhOebM
         X0Fw1yBMk3BpWIHLcRFcDueDeMD3tRdPQDZCCfE8WeSQkqFImM7EuhJ/oY4Nqn5XSzk6
         i3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295585; x=1793900385;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KFGBRNvis/xUmUAvIOrrCN5aEDyUWLLVbvBnaXFBhc=;
        b=OMrG6Srn4aXDWyEHqvy5bzPPnft8fhyWNq/6SvFU30lVF4topTeXQMV9Q9JMs0MFLH
         xFDBscuZs3Xhoiac2HnCJ+ayNA2L6Fhu6gussfVFEt2L3UDNLsaQYzO3H9aiR/e33un4
         nUBMlhvGT/TfwKS+2vCBauNyA36xQRZdJNyzfwsYRLbAtxPPOCHCJCsA0ytKYCgMg0YD
         vGsKWTZEu7ZGOQynaW619bIK/fRiZLUNIxj5lcnf6pnEE3VBkRS1ZyYNJOb+RvBtFwUe
         FaZcEobLKKLw/dIl2YVmpyTz9pm5Hg4n3IOdWK7uBFE7Vf8DBmtru7QTCkLt+JZ6GrhN
         s+Qg==
X-Gm-Message-State: AFq9FYKMwf/L5GY7+aSDY1w8IqFpw8Lkw7ma66FjFbcuWcAzXR/VaQ+X
	lZE5vQLbqV+v39pym8dTBh/Y8OmhtbaWMluNAtHBkHPrfB1ZOiVY4aY2
X-Gm-Gg: AYBFou3NhbMojEach4GP++aBwqiyNfbZgFnHw2iUF3J1cu4cRx0QfvIBvR66FLMzpbb
	4KudK6pq+bqRbqbGymJhimcc63y2q5i/JpDACBf5KefHjGyL1IlwjFoKracSpakvUISeiiX+iyw
	E8hfSORt4y9FWJsC5dRrqPvKP+YedXCof5LVUEk5+tgEHH+awFI/PDLUN2bif3yDXUaGyFMy8eT
	vVZvNGbsiSZpoTJ54fTtpeM4Y/b1lKvhij7rDQeyX5pw/IE3OHc8QuLNhcCbTe97hhQScTrHnSB
	PJ35Ki5vwc0zI9rFqzbyFncImEMAU792H/eY70JuJ1TWWD0IIwKhCqYPxsklQQOjDGGHI0aC4ip
	EY4MkbkktjZ2q5cV4kp4CCZ2QyClo060svqzi/Ft47ARZpkmWWyZCdhXO3MnsF44ewb0m8SrzY/
	o3AhsRYYmDSUIRYX0g1zyhfgse3mwOFGoWHlRMIxGR9expKiPQBnkhrVj/DdNvKxqF7AGOwo4Qv
	wUkjQkDURe73rfDkYtTfBPgAMIruMFitAO7OiUmQPYC+ptsKnPVwHWpqddbxYeq/Fv28F7vEOWS
	5EpCUuR/5fEjo/SuwuPNNK6zqD8+RFWim+FBWnzyhOyUv6BsF905uQIP
X-Received: by 2002:a05:7301:7306:b0:366:dbf9:32bd with SMTP id 5a478bee46e88-36a4235f4a1mr105133eec.9.1793295584796;
        Thu, 29 Oct 2026 10:39:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a4294419dsm51546eec.18.2026.10.29.10.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 10:39:43 -0700 (PDT)
Message-ID: <86ae31a1-381a-4f38-89fb-a19b35d06d5f@gmail.com>
Date: Thu, 29 Oct 2026 10:39:38 -0700
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
Subject: Re: [PATCH net 10/11] net: au1000: keep the MAC stopped until the PHY
 link is ready
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, shaojijie@huawei.com,
 horms@kernel.org, runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org,
 jeff@garzik.org, danny.kukawka@bisect.de, mugunthanvnm@ti.com,
 sebastian.hesselbarth@gmail.com, linux-kernel@vger.kernel.org,
 manuel.lauss@gmail.com
References: <20261027223140.3774570-11-f.fainelli@gmail.com>
 <179329052077.3134.10233975410162013013@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <179329052077.3134.10233975410162013013@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/26 09:15, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] au1000_open() now calls phy_start() before au1000_init().
> - [Medium] Reopening the interface after a PHY status read that changed
>    phydev->link and then failed can leave MAC RX/TX disabled for good…
> - [Low] The new au1000_hard_stop() call in the link-down branch of
>    au1000_adjust_link() runs inside spin_lock_irqsave(&aup->lock).
> 
> --
> 
> net: au1000: keep the MAC stopped until the PHY link is ready
> 
> The patch moves phy_start() ahead of au1000_init() in au1000_open(). It
> also leaves MAC RX/TX disabled in au1000_init() while the PHY reports no
> link, and stops the MAC in the link-down branch of au1000_adjust_link().
> If au1000_init() fails, the PHY is now stopped.
> 
>> diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
>> index 8c2dbf72652e9..c616ce616541f 100644
>> --- a/drivers/net/ethernet/amd/au1000_eth.c
>> +++ b/drivers/net/ethernet/amd/au1000_eth.c
>> @@ -458,7 +458,8 @@ au1000_adjust_link(struct net_device *dev)
>>   		/* link state changed */
>>   
>>   		if (!phydev->link) {
>> -			/* link went down */
>> +			/* Stop the MAC before the PHY can remove its clocks. */
>> +			au1000_hard_stop(dev);
> 
> [Severity: Low]
> 
> au1000_adjust_link() holds spin_lock_irqsave(&aup->lock) at this point,
> and au1000_hard_stop() ends with:
> 
> 	wmb(); /* drain writebuffer */
> 	mdelay(10);
> 
> So each link-down now busy-waits 10 ms with interrupts off.
> 
> On close, the sequence looks like this:
> 
> au1000_close()
>    phy_stop()
>      -> au1000_adjust_link() -> au1000_hard_stop()   /* 10 ms */
>    spin_lock_irqsave(&aup->lock, flags)
>    au1000_reset_mac_unlocked()
>      au1000_hard_stop()                              /* 10 ms again */
>      two mdelay(2) for the reset                     /* 4 ms */
> 
> That is roughly 24 ms per close with interrupts off. The duplex branch
> already does something similar on link-up.
> 
> Is the second au1000_hard_stop() in au1000_reset_mac_unlocked() still
> needed now that the link-down callback stops the MAC?
> 
>>   			aup->old_speed = 0;
>>   			aup->old_duplex = -1;
>>   		}
> 
> [ ... ]
> 
>> @@ -740,6 +741,10 @@ static int au1000_init(struct net_device *dev)
>>   		control |= MAC_FULL_DUPLEX;
>>   	}
>>   
>> +	/* The PHY may still be restoring its MII clocks after resume. */
>> +	if (!dev->phydev || dev->phydev->link)
>> +		control |= MAC_RX_ENABLE | MAC_TX_ENABLE;
>> +
> 
> [Severity: Medium]
> 
> Can the MAC stay stopped after a reopen if old_link and old_duplex are
> stale?
> 
> With this change, RX/TX get turned back on after open only through
> au1000_adjust_link(). It calls au1000_enable_rx_tx() in just one place,
> the duplex branch:
> 
> 	if (phydev->link && (aup->old_duplex != phydev->duplex)) {
> 		...
> 		au1000_enable_rx_tx(dev);
> 
> Neither au1000_close() nor au1000_reset_mac_unlocked() resets old_link,
> old_speed or old_duplex.
> 
> Here is one sequence that could leave them stale. Assume autoneg is
> disabled and the link is up at 100/Full:
> 
> genphy_read_status()
>    genphy_update_link()        /* BMSR says link down, phydev->link = 0 */
>    genphy_read_status_fixed()  /* BMCR read fails with -ETIMEDOUT */
> phy_check_link_status()
>    returns the error before phy_link_down()
> 
> MDIO timeouts reach phylib since "net: au1000: report MDIO transaction
> timeouts". The PHY_ERROR handling, and a later phy_stop() into
> PHY_HALTED, call phy_link_down() only if phydev->link is still set.
> au1000_adjust_link() therefore never sees the link drop, so old_link
> stays 1 and old_duplex stays DUPLEX_FULL.
> 
> On the next open, au1000_init() leaves RX/TX disabled because
> phydev->link is 0. When the link comes back at the same speed and
> duplex, au1000_adjust_link() skips all three branches. The MAC stays
> stopped while carrier is reported up.
> 
> Before this patch, au1000_init() always set MAC_RX_ENABLE |
> MAC_TX_ENABLE, so this case recovered on reopen. Would resetting
> old_link, old_speed and old_duplex in the open or close path avoid it?
> 
>>   	writel(control, &aup->mac->control);
>>   	writel(0x8100, &aup->mac->vlan1_tag); /* activate vlan support */
>>   	wmb(); /* drain writebuffer */
>> @@ -928,16 +933,18 @@ static int au1000_open(struct net_device *dev)
>>   		return retval;
>>   	}
>>   
>> +	if (dev->phydev)
>> +		phy_start(dev->phydev);
>> +
>>   	retval = au1000_init(dev);
> 
> [Severity: Medium]
> 
> Is it safe to start the PHY before the MAC is initialized?
> Documentation/networking/phy.rst says:
> 
>    Lastly, once the controller is ready to handle network traffic, you call
>    phy_start(phydev).
> 
> The commit message says "Start the PHY before initializing the MAC" but
> doesn't explain why the order has to change.
> 
> phy_start() resumes the PHY over MDIO:
> 
> au1000_mdiobus_read() / au1000_mdiobus_write()
>    au1000_enable_mac(dev, 0)
> 
> mac_enabled is 0 after probe or close, so this takes the MAC out of reset
> before au1000_init() runs. That contradicts the comment above
> au1000_init():
> 
>   * conserve power. Thus, whenever au1000_init() is called,
>   * the device should already be in reset state.
> 
> phy_start() then queues the state machine with zero delay, and
> au1000_init() does:
> 
> 	/* bring the device out of reset */
> 	au1000_enable_mac(dev, 1);
> 
> With force_reset set, this holds the MAC block in reset for about 2 ms,
> including mii_control and mii_data. It takes only aup->lock, not the
> mii_bus lock. au1000_mdio_read() and au1000_mdio_write() program
> mii_control, poll with mdelay(1) and read mii_data without any driver
> lock.
> 
> Could that forced reset land in the middle of an MDIO transaction from
> the phylib worker, for example on a preemptible UP kernel? A read could
> then return a reset value, a BMCR or advertisement write could be lost,
> or -ETIMEDOUT could put the PHY into PHY_ERROR.
> 
> If the worker runs first and already sees link up, au1000_adjust_link()
> takes the duplex branch (old_duplex == -1) and calls
> au1000_enable_rx_tx(). That happens before the MAC address and RX
> descriptors are programmed. au1000_init() then force-resets a MAC with
> RX/TX enabled.
> 
> There is also a problem with the new check in au1000_init(). It reads
> phydev->link under aup->lock, while phylib updates it under
> phydev->lock:
> 
> 	if (!dev->phydev || dev->phydev->link)
> 		control |= MAC_RX_ENABLE | MAC_TX_ENABLE;
> 
> genphy_update_link() can set link to 1 for a moment and then clear it:
> 
> 	phydev->link = status & BMSR_LSTATUS ? 1 : 0;
> 	...
> 	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
> 		phydev->link = 0;
> 
> If au1000_init() reads that brief 1, RX/TX get enabled. The link-down
> callback never runs afterwards, because phydev->link still equals
> old_link.
> 
> Wouldn't that leave the MAC running with no link, which is the state
> this patch is meant to prevent?
> 
>>   	if (retval) {
>>   		netdev_err(dev, "error in au1000_init\n");
>> +		if (dev->phydev)
>> +			phy_stop(dev->phydev);
>>   		free_irq(dev->irq, dev);
>>   		return retval;
>>   	}
> 
> [ ... ]
> 

Agreed on both medium findings. I’ll initialize the MAC before starting 
the PHY, clear the cached link state on open, and use the driver’s 
acknowledged link state during initialization.

I’ll retain the reset-time hard stop because watchdog recovery and other 
reset paths do not guarantee a preceding link-down callback. Reducing 
the IRQ-off delays needs separate work.

pw-bot: cr
-- 
Florian
