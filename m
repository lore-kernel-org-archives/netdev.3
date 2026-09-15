Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC346F481;
	Tue, 15 Sep 2026 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468322; cv=none; b=Hdu6Px2qVUBd/8KCUtZn3ud23KmMHnIFX379Hdxb9Ax3V7o+n4hgN5Cnp7p71EtlDO9mjBdcEKfwn2KwHVaxiRHODER8qY7jn5Nx5EW2zpbbCpKRdwq3zM2jx+N4M9XfxuycLyExdsSFpKUiq1blirgwL4O+4+GjCPy8wn2ZoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468322; c=relaxed/simple;
	bh=f+acgDsCEUmeK2RsKjhHOYy9GBDMc6z7vxQ25njrSkg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QXpm1UgE5KYzSt3PNEWgJRFfxzBmKQ/EObSLt8aqmfH1pkyMSC8WRyuqsrsYsqyRziXDlAhyMHS++A+aCiMvVrzxuylF0zhu1zXtVT5TmmOczIaPqa78RcF9avzlBBwPwGewUkqA1h2iHRZ5IVq+mzqcZlRMaxUHovdPSwo24Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=NuDloAuk; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="NuDloAuk"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A7E1A91F1;
	Tue, 15 Sep 2026 12:31:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789468314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TdbzlQfgYrgDXZjn4XRhJQHZ0G7KtzwWRSeOrf0tJgs=;
	b=NuDloAukNTRdG8ohLD1Dkm0sivl/yU3OdUQXt4wj5f/Sc6QiyNd9R8+WnqmNCZTG3jyZUI
	2Au+6eNSDQvztzsawL6BXj15kpHMqICcu+CWLgXrqY60VzrjgYZcavqyMKNZOvAVs9SS5Y
	YdCXWgah2JW5jRPfOclNRV28JHPBc93CNBq0iRrBj2fwExQxw6l4KJivOO1WUurKL3RpkY
	ZZU0cs4kfRin1Nwi8BcMSB0ACmRSv0pw5m4iXRxBdlWm+gEp7zJGUbPHzbeW6BAPiaK7ug
	tJJcDYJ8LtO+2qzt3BJhp516kC45cO16fOQL6dcLqU3qiY6iB4RUQxSEQzphQg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 12:31:51 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, justin.chen@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: broadcom: enable jumbo frames on
 BCM54xx
In-Reply-To: <178946564204.22033.11365695579281446109@kernel.org>
References: <20260914094703.1093504-1-nb@tipi-net.de>
 <178946564204.22033.11365695579281446109@kernel.org>
Message-ID: <073f27830fa5e448448cb9cf9de132d3@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 15.9.2026 11:47, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] The new unconditional bcm_phy_enable_jumbo() call in
>   bcm54xx_config_init() (drivers/net/phy/broadcom.c:543) sets…
> 
> --
> 
> net: phy: broadcom: enable jumbo frames on BCM54xx
> 
> This adds an unconditional bcm_phy_enable_jumbo() call to
> bcm54xx_config_init(), which sets the extended packet length bit in the
> auxiliary control register and the PCS transmit FIFO elasticity bit in 
> the
> extended control register so that jumbo frames are not dropped at 100M.
> 
>> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
>> index d1a4edb34ad2e..b515e38755041 100644
>> --- a/drivers/net/phy/broadcom.c
>> +++ b/drivers/net/phy/broadcom.c
>> @@ -537,6 +537,13 @@ static int bcm54xx_config_init(struct phy_device 
>> *phydev)
>> 
>>  	bcm54xx_ptp_config_init(phydev);
>> 
>> +	/* Transmit is limited to 4.5 KB without it, see the BCM54210PE
>> +	 * datasheet section 5.4.12.14.
>> +	 */
>> +	err = bcm_phy_enable_jumbo(phydev);
>> +	if (err < 0)
>> +		return err;
>> +
> 
> [Severity: Medium]
> This lands directly after bcm54xx_ptp_config_init() has armed the
> TimeSync block on PTP-capable parts such as the BCM54210E, whose driver
> entry in broadcom_drivers uses this same .config_init.  How does the 
> added
> elastic FIFO delay interact with the PHY timestamping path?
> 
> bcm_phy_enable_jumbo() in drivers/net/phy/bcm-phy-lib.c ends with:
> 
> 	/* Enable the elastic FIFO for raising the transmission limit from
> 	 * 4.5KB to 10KB, at the expense of an additional 16 ns in propagation
> 	 * latency.
> 	 */
> 	return phy_set_bits(phydev, MII_BCM54XX_ECR, MII_BCM54XX_ECR_FIFOE);
> 
> If that FIFO sits in the copper PCS transmit path downstream of the 
> 1588
> egress capture point, would egress timestamps then be reported
> systematically early by that fixed delay?  A link where only one end 
> has
> MII_BCM54XX_ECR_FIFOE set would also become asymmetric.
> 
> Grepping drivers/net/phy/bcm-phy-ptp.c for latency or compensat returns 
> no
> matches, so there appears to be no TX/RX latency correction programmed
> anywhere in the PHY PTP driver that could absorb the new delay.
> 
> There is also no gating here: no MTU or jumbo condition, no device tree
> property and no ethtool knob, and the bit is re-armed on every
> config_init() and via bcm54xx_resume().  tg3 sets the same hardware bit
> only when tg3_flag(tp, JUMBO_CAPABLE) is set.
> 
> Would it make sense to gate the FIFO elasticity bit on an actual
> jumbo/large-MTU requirement, or to account for the extra delay in the 
> PTP
> path?

Regarding mtu guard:
tg3 gates on JUMBO_CAPABLE, a device capability rather than the 
configured MTU.

Also phylib does not have a MTU hook without any further changes. 
config_init()
runs on attach and resume, not on an MTU change. bcm7xxx.c enables it 
unconditionally
for the very same reason.

Regarding PTP compensation:
egress timestamping happens at the MDI, so the transmit FIFO sits ahead 
of the
capture point and its 16 ns does not end up in the timestamp. So AFAIU 
nothing
to compensate here.

> 
>>  	/* Acknowledge any left over interrupt and charge the device for
>>  	 * wake-up.
>>  	 */
> 
> Also, the changelog says the elasticity bit raises the transmit limit
> "from 4.5 KB to 9 KB", while the in-tree comment on the same register
> write in bcm_phy_enable_jumbo() says 4.5KB to 10KB.  Which figure is
> intended, and could the two be reconciled?

The datasheet gives 4.5 KB to 9 KB for the elasticity bit alone and 10 
KB
for copper mode with both bits set. The existing comment in
bcm_phy_enable_jumbo() attributes the 10 KB to that one bit.

I can send a separate patch for the existing comment if wanted?

Thanks,
Nicolai
