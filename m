Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757081;
	b=vlshY8Gcd8B/2IeKNEpoOmUHkb/bUTitT1vZ41kRCK2GkfRVAq0m+Wznu3zvWRTc7hap
	 ieS2ABHElqh1rTR6cOKiQBel2008crTQo1fxDysbXEKtFv0Y/1mQICIpZ3ehsa5azYfYg
	 zkOO8I/5deiHdxlLwYiAby6WSA8eyTmblC6W9Xd6gfhigGw88KJy/BdUaD7CcDTk/2ONj
	 FHo++goKgiOSHGx48D9OhurB1Rodj3A22H6eH6Zuf8uBoGUBhYqysGL9w4ZLxW83MnGn1
	 v/I0xFKMztcS+fNvTly7plAD3YFgJvX+UXTJXJuslAcAunPl3F+H3JvTHq9qe6gBQAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757081;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ycGpS7m1sazcu7mkgUYYOYML6LDBpyZoHUVl6pqsqzQ=;
	b=cgvOCywd8z35oJOrx6tU9TuUf3PIFqRn8tLZ+GSxeguuzgxJpDvBgtuB4t5bZU2HVMh7
	 YedIrdWwJsXhd9cKBr0rZs2BMBm4tQOibFCAJKjxtNAJfq6t0rCWEVVYxXyWmzKPOkZh+
	 12zxx9uEdU5muuZg4fiE07LQGH4cbhwtPth0WCKxnr0PmplmvsrXtPig9K10oUVuT6DoJ
	 CHtLrqsGJa38wCLlOiwVg+s2UnMKovp2Jaso64hsstr0F1CNJUCDIVxeO0RnSmgdh9HkX
	 +KhtPptnSEXe4Vuoan3O4QWAem+qvZspEpt37VkfaIC1vXfSZf+4HWLPMYyqosQpVBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=QJMUxINU;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851B606A31A;
	Fri, 23 Oct 2026 12:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B851B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=QJMUxINU
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC4E9A0956;
	Fri, 23 Oct 2026 14:04:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792757077; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ycGpS7m1sazcu7mkgUYYOYML6LDBpyZoHUVl6pqsqzQ=;
	b=QJMUxINU5RSW7wDNpwFRUl/HAYtKVfvyH7AG/PbbRicLGcGnnxeq6gKY1Y/ZbEPkhIJ1zE
	MG98EbZkza/JjxetgPrliEK4gsbzR17wp/PeEqle9ZKTpBviHMgIUrGGUDnOJkgsR+fAUc
	e/IkQnbBJ2GJ4azxfRHEThxAIcHvBTAclbw3laxeBXsfxjaCyi/ZPVO+kG50J9aj/Oc29n
	LT9qq0XhC84HuZva2n+SPS4jTjH9iPoX1DCrawmxsNrA61oYhSHkyD/qIrgco3Pwwl1iaL
	GPmDe31Abnk/C29UqOsAuzeN4vFXXsll0nY8TyHCT1tpFqgwCK+9rWtQY+3jHQ==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 23 Oct 2026 14:04:34 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, justin.chen@broadcom.com, f.fainelli@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: bcmgenet: recover from a failed resume
In-Reply-To: <179275652332.3134.3420351260504788140@kernel.org>
References: <20261022-nb-genet-fini-dma-net-v3-1-6e9fc89c0156@tipi-net.de>
 <179275652332.3134.3420351260504788140@kernel.org>
Message-ID: <7a86dc120223465e88cc265a6f597657@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 23.10.2026 13:55, netdev-bot+sashiko@kernel.org wrote:
> [...]

> [Severity: Medium]
> 
> After a failed non-WoL resume, can the next non-WoL suspend leave an
> external PHY powered up with its link active?
> 
> On the normal non-WoL path, bcmgenet_suspend() halts and suspends the
> PHY:
> 
> bcmgenet_netif_stop(dev, true)
>   phy_stop()
>     PHY_HALTED -> phy_suspend()   (BMCR power-down)
> 
> The failed resume has already done this before bcmgenet_init_dma()
> fails:
> 
> bcmgenet_resume()
>   phy_init_hw()          drv->soft_reset() clears BMCR_PDOWN and sets
>                          phydev->suspended = 0
>   genphy_config_aneg()   restarts autoneg
>   bcmgenet_init_dma()    fails -> return ret
>                          (phy_resume() is never reached)
> 
> This new early return then skips any PHY power-down. Calling phy_stop()
> here would not work either, because the PHY is still in PHY_HALTED.
> 
> Nothing else seems to power the PHY down. bcmgenet_mii_probe() sets
> mac_managed_pm = true, so mdio_bus_phy_suspend() returns early, and
> bcmgenet_suspend_noirq() only powers down an internal GPHY via
> GENET_POWER_PASSIVE.
> 
> So an external PHY whose driver has both .soft_reset and .suspend (for
> example genphy_soft_reset with genphy_suspend) would stay powered with
> its link up through system sleep.
> 
> This would not show up with the bcm54xx PHY on CM4, which has no
> .soft_reset, or with the Generic PHY driver.
> 
> Does the !priv->tx_cbs path need a phy_suspend() call (or similar) when
> WoL is not in use?
> 
>> 
>>  	netif_device_detach(dev);
>> 
>>  	if (device_may_wakeup(d) && priv->wolopts) {
> 
> [ ... ]

Same as in v2: pre-existing, phy_init_hw() powers it up in the failed
resume and nothing starts it again. Fair that it's reachable now, before
this series that suspend just hung. Nobody seems to have hit it either, 
it
needs a failed resume plus a PHY with soft_reset, so pretty much an edge
case, don't you think?

I'd rather not add a phy_suspend() I can't test ... the CM4's bcm54xx 
has
no soft_reset, so the PHY never gets powered up there anyway. The proper
fix is to stop leaving the half state behind, that's on my list after 
the
MTU series.

Thanks,
Nicolai
