Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505828;
	b=Toi59e5no87jBf4q7kYedrw8G6wbWM7Opv6qhHtRAkfUFjjEH+6p8GpQqu1e2HSQ9k20
	 UFaM2y76qg7ivQz11vgePaKM1dEcTr21wzKCBdXHbsVQbn/B31oTzeeWu3CIBtyk/OnYz
	 QRj8hg8IAR85P5pN4/Ruz6g5x7beKaLqowGhznUZC9CCKpFhXohuk69TrPRdXejLE3qt7
	 dbRcfmsy58kVP/bfDhak5ejSu7aYVAIfBorBhuqlLKl6RFIDmaijiErqT+7uHx/QYI6EM
	 np2NRAfD5zGJNpiUa1wz8hfKINqznxVokS2IOuO7zQuIVEUPSWf4VWlDqGkb+Lf1lng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505828;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=KzZBcixn1nkLMFly7L58yQXI8hYiFn4S/rL1DV8cbi4=;
	b=bAfbZ2+33EI5VVTWbL6xSlr5k7V4aiiMnFOmDjDjw3naugnQBp8cZl++Ps2B+Id/OKRO
	 NdLeAPd715qS7eoybUgBrHtyGg15to29sU1sJoOcsYPzwjFQrFGkuypZEPNzFy4YQ0so9
	 lHH5XL1M9EHYAXBLrmcdM2NUuPUoI4T1ajbY9T93T5MyOWgLn9YsPMZPZrpnBWVCMYoz4
	 D3Xx//fpSLfp1fLPNcpaLJ1VSi4xON40IaQAH7pmNGywkaM6OvjiWHNjQYhdxDISOT830
	 PIWtC47vl6Xunmi6eacaGRqQKVFyo3/GWmly6MxCb866BPk7s1mElYZJQgvB+lq5E5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3B606AA17;
	Tue, 20 Oct 2026 14:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13E3B606AA17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E970FA155F;
	Tue, 20 Oct 2026 16:16:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792505822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KzZBcixn1nkLMFly7L58yQXI8hYiFn4S/rL1DV8cbi4=;
	b=sbmiIeqgetFkGWxwyF4SF+wQINbgAf1J+fvOoUqZX6iVTHL0Ws1Y1S6DEN1iS5MRwHCNS3
	ci2DrF7iYoWVf35bpHKF2jWozxkylF8AYDSSxxXcddSyj1Xg1g9LlaP1Z31ZG7wM8XeWww
	bjs3/GKY1but/fFTEHmX0zzg2/+DS2DgCrgryH2e2yj9cRajF4u5eieCqTWn6m59bCYzd+
	YulF20Y4kp/rcA7S+YH+lGNH9GCXXqh6dLTjZE1ff3r+VhyT766Cmg8X82cU1uB7vFQYZK
	8jBnWbcW0g3EC2fwdVCIikwDa51vOJlZUT1Vg8qWwa586NduXd0d5nxhLhZSqA==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 16:16:59 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, justin.chen@broadcom.com
Subject: Re: [PATCH net v2 1/2] net: bcmgenet: recover from a failed resume
In-Reply-To: <179250090686.3135.17597197349680697960@kernel.org>
References: <20261019-nb-genet-fini-dma-net-v2-1-b85f6b92654a@tipi-net.de>
 <179250090686.3135.17597197349680697960@kernel.org>
Message-ID: <a033b1e2dd424000dc5669f88bed0c89@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 20.10.2026 14:55, netdev-bot+sashiko@kernel.org wrote:
> [...]

> [Severity: Medium]
> 
> Does this return leave UMAC_CMD at the reset-default 10 Mb/s speed when 
> the
> next WoL suspend runs?
> 
> Earlier in bcmgenet_resume(), init_umac()->reset_umac() writes only
> CMD_SW_RESET to UMAC_CMD. That zeroes the speed field (CMD_SPEED_10 is 
> 0)
> and the duplex and pause bits.
> 
> On the WoL rebuild path, the new phy_stop() above also leads to
> phy_link_down()->bcmgenet_mii_setup() with the link down, which clears
> RGMII_LINK.
> 
> bcmgenet_mac_config() is the only code that restores the speed and 
> duplex
> bits and RGMII_LINK, and it runs only from the phylib adjust_link 
> callback.
> After this early return, bcmgenet_netif_start()/phy_start() never run, 
> so
> that callback never fires. Meanwhile phy_init_hw() and 
> genphy_config_aneg()
> have already restarted autonegotiation on the PHY, which is still 
> powered.
> 
> On the next WoL suspend, the new !priv->tx_cbs branch in 
> bcmgenet_suspend()
> returns 0. Then bcmgenet_suspend_noirq()->bcmgenet_wol_power_down_cfg()
> does this:
> 
> 	/* Can't suspend with WoL if MAC is still in reset */
> 	if (reg & CMD_SW_RESET)
> 		reg &= ~CMD_SW_RESET;
> 
> 	/* Receiver must be enabled for WOL MP detection */
> 	reg |= CMD_RX_EN;
> 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
> 
> None of this corrects the speed.
> 
> If the PHY links at 1000 or 100 Mb/s, can magic packet reception fail 
> even
> though WoL looks armed? Together with the HFB_CTRL write below, a 
> failed
> resume could leave GENET with no working wake source.

Yes, but IMHO pre-existing: the init resets UMAC_CMD to 10M and only
restored by adjust_link (which doesn't run anymore once init_dma() 
fails).
Without my patch the next suspend hangs in napi_disable(), so there is 
no
wake source either way. It makes the interface recoverable, not WoL 
work.

The real fix is probably to allocate before tearing the rings down...

> [...]

> [Severity: Medium]
> 
> Does writing 0 to HFB_CTRL here turn off WAKE_FILTER wake completely?
> 
> bcmgenet_wol_power_down_cfg() reads HFB_CTRL after this point. It 
> unmasks
> the filter wake interrupts only if RBUF_HFB_EN is still set:
> 
> 	reg = UMAC_IRQ_MPD_R;
> 	if (hfb_ctrl_reg & RBUF_HFB_EN)
> 		reg |=  UMAC_IRQ_HFB_SM | UMAC_IRQ_HFB_MM;
> 
> MPD is enabled only for WAKE_MAGIC/WAKE_MAGICSECURE. With wolopts set 
> to
> WAKE_FILTER only, the system would suspend with device_may_wakeup() 
> true
> and no GENET wake source.
> 
> A few lines below, the normal WoL path keeps only the RX_CLS_FLOW_WAKE
> filters armed:
> 
> 		if (priv->wolopts & WAKE_FILTER)
> 			list_for_each_entry(rule, &priv->rxnfc_list, list)
> 				if (rule->fs.ring_cookie == RX_CLS_FLOW_WAKE &&
> 				    rule->state == BCMGENET_RXNFC_STATE_ENABLED)
> 					hfb_enable |= 1 << rule->fs.location;
> 		...
> 		if (!hfb_enable)
> 			reg &= ~RBUF_HFB_EN;
> 
> Could this path use the same selection? Because tx_cbs is NULL, the
> following resume rebuilds the rings anyway. The device is detached 
> here,
> so the WoL setting can't be changed from ethtool (it returns -ENODEV).

Yes, keeping just the RX_CLS_FLOW_WAKE rules is better than my off.
Will do this in v3, together with the clock wording.

> [...]

> [Severity: Medium]
> 
> With WoL not in use, can this early return leave an external PHY 
> powered
> for the whole sleep?

Yes, but IMHO also pre-existing: phy_init_hw() in the failed resume 
powers
it up and it isn't started again. Before this patch suspend hung 
instead.
Not leaving the half state behind is arguably a better way.

> [...]

I really need to find a WOL capable genet board, so I can test these 
code paths too ....

Nicolai

--
pw-bot: cr
