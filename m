Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2C3E1729
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492808; cv=none; b=EywNyNE2OOoP36HCYuTr7DpKXgPAGd/2czgO7ct/KTdd/4/vZliMvQr16/h04iJTBA2GhVEU5l/r+VWmZqmcA0s35uemuoAmHjZwf2b2UBS9FdPdUJkEROA6xALjYtuz8EJYgS1EGfQBIpgW2OoosEXS024jZJg7oaX1m1yC1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492808; c=relaxed/simple;
	bh=869HNCfp+r1RYyh03dhFh8Ehn4/mRguRJHaV6q+2I8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUJzppqJgdItVp7aPAsu9afqQaSIZMiZNMQSGwca/svfBBlTl2ASprwa9mPoV3rA+dN6oWqsa4nYcf9mwDqO40X4azCYq5IP1cuuXAWSvuEFtHOolumldsx+fzL5MfDswHKkuAtSMG+JATiqASYc26D7X24JuHvBH25axqZStP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yLwMA7iy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yLwMA7iy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E30051A1353;
	Fri, 31 Jul 2026 10:12:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD7BC6039A;
	Fri, 31 Jul 2026 10:12:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3DC511C1668F;
	Fri, 31 Jul 2026 12:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785492774; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LaN13+7CpsbYTP/3/mBgmUw3PgfcWiL1ZfNR8mI434I=;
	b=yLwMA7iyqgonpMGSYH9xJ1iK6F3trUXsGDkd3e6REYkL8WnvFAeIBRbV2K9utGY6DEuswU
	a7qd/1sqgHCq+g9j0SRtnR+XcmSXkmbQEA7GLutHqCRoRagCh2EydQ+lVHP3C2hcOwo3rP
	P2Kb07JyIxdwNY0gNhyuTHoBTaSKH/u0y+cjz772tYObuiou1HlkFpuQYd/PpMR2qBRAuO
	MXHyermOE355ZIS78NJ3U889fdJPMLiuwh4+3V0WZzslfwifs+Mh6adZQEo9Xg10IceBRU
	PgsP23Kw0BdsoswPmrRrTeJ5vLdv+QDR8VFFqnu5BEHO0SIA3FL5D20hVEJq/Q==
Message-ID: <a31ca086-5feb-4602-9c5b-f0e74487c094@bootlin.com>
Date: Fri, 31 Jul 2026 12:12:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: resume PHY before hardware setup when
 opening the interface
To: Stefan Agner <stefan@agner.ch>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
References: <message-id-of-your-v1-mail>
 <20260707195425.405989-1-stefan@agner.ch>
 <c8cbf359-e224-44c6-8692-9e1d1527ae0c@bootlin.com>
 <2946c0f7-1c79-4890-a4b3-94141f42bc1a@redhat.com>
 <2f7fc28f777ce870e30e400640418c71@agner.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <2f7fc28f777ce870e30e400640418c71@agner.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/31/26 12:03, Stefan Agner wrote:
> Hi Paolo, hi Maxime,
> 
> On 2026-07-21 10:12, Paolo Abeni wrote:
>> Hi,
>>
>> On 7/8/26 11:16 AM, Maxime Chevallier wrote:
>>> On 7/7/26 21:54, Stefan Agner wrote:
>>>> Since the referenced commit, changing the MTU on a running interface no
>>>> longer disconnects and reconnects the PHY; __stmmac_release() merely
>>>> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
>>>> is not enabled. __stmmac_open() then performs the DMA software reset in
>>>> stmmac_hw_setup() before phylink_start() resumes the PHY again.
>>>>
>>>> IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
>>>> powered down, and stmmac requires a running receive clock for the DMA
>>>> software reset to complete (the phylink config sets mac_requires_rxc).
>>>> On such setups, e.g. the RK3566-based Home Assistant Green with an
>>>> RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
>>>> leaves the interface dead:
>>>>
>>>>   rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
>>>>   rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initialization failed
>>>>   rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
>>>>   rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface after MTU change
>>>>
>>>> In the field this is triggered by NetworkManager applying an MTU while
>>>> activating the connection, breaking networking entirely.
>>>>
>>>> Resume the PHY in __stmmac_open() before the hardware setup, making it
>>>> the counterpart of the phylink_stop() in __stmmac_release(), like
>>>> stmmac_resume() already does for the same reason. phylink_start() also
>>>> resumes the PHY, but only after stmmac_hw_setup(), and it cannot be
>>>> moved before the hardware setup since it may bring the link up
>>>> immediately from a workqueue, racing with the initialization (see the
>>>> comment in stmmac_resume()). For the regular ndo_open path the PHY has
>>>> just been attached and is not suspended, in which case
>>>> phylink_prepare_resume() does nothing.
>>>>
>>>> Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open()/release()")
>>>> Link: https://github.com/home-assistant/operating-system/issues/4858
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>
>>> I was able to reproduce the issue on imx8mp and socfpga. Adding this case to
>>> my periodic test list...
>>>
>>> Indeed the assymetry isn't very nice, OTOH there's not phylink counterpart
>>> for phylink_prepare_resume(). This helper was added for the suspend/resume
>>> case, and only for it as the doc states, it just happens to do exactly
>>> what we need to fix the issue :
>>>
>>> /**
>>>  * phylink_prepare_resume() - prepare to resume a network device
>>>  * @pl: a pointer to a &struct phylink returned from phylink_create()
>>>  *
>>>  * Optional, but if called must be called prior to phylink_resume().
>>>  *
>>>  * Prepare to resume a network device, preparing the PHY as necessary.
>>>  */
>>> void phylink_prepare_resume(struct phylink *pl)
>>>
>>> I think this helper should be renamed and the doc updated, stmmac is the
>>> sole user, and it's really about controlling that rxc and not about
>>> suspend / resume. Resuming from suspend is just one of the cases where we
>>> need that RXC early on.
>>>
>>> So either something like 'phylink_prepare_start_or_resume' but it's long,
>>> or maybe we can be more explicit about it and simply call it:
>>>
>>> phylink_start_rxc(pl)
>>>
>>> (without a corresponding stop)
>> I read the above as a possible follow-up more than actual changes
>> requested to this patch, am I correct?
> 
> Since this fixes a bug, I'd prefer to keep the patch minimal to make it
> easier to backport. Therefor I would prefer to do make such structural
> changes as a follow-up change rather than part of this patch.
> 
> Does that work for you, Maxime?

That works for me yeah, I agree we need that fixed.

Thanks Stefan,

Maxime

