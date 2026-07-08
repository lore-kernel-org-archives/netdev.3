Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62393D668E
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 06:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492452; cv=none; b=illnqE+l3KZFm+lT0LCLDfchjeboxREsb9HlYg+SFM1Q6A5TonrWMXQAG4WHYOwxqbmiA6YBdM2IIUOkxOPm41ECA8Yvs13zqICMVzbUDU8zSFUT/CSCklP9Ng0D4xuEiijPYA8Z/37C3VbomGvk+/x7M60cbHmU0hF/rxU5egQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492452; c=relaxed/simple;
	bh=WUDb/PbkOBm48utwLBlifBSQYCzJbZQ2IPogvWOWeAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELwMeJh+FVkAetqE72qil70L17XW+gjb52P7NuDAsJo8AnqOcOMO/H/cmq83CesiLcyf66d5O1S0C6LwWeoB9x93FIB+5q2KkkwtQUMg7C/DyriwAX2/z7PtlwjFyWS4K7VWmkPhXZWcFxJ+UVWl4lGuSboyBNvjCRvi7QQEtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mGYs/BRd; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mGYs/BRd"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A2FB4E40CF0;
	Wed,  8 Jul 2026 06:34:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 567E960337;
	Wed,  8 Jul 2026 06:34:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26D1411BC25AD;
	Wed,  8 Jul 2026 08:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783492441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=2u9XNj54KnCKdzGWeON2Ik6EnoCNeLw8ko4IIpofdm0=;
	b=mGYs/BRdE2fIPEx8g1+Wf+oxYtf/ZzpxuhKuxAdrGKpGHPY/BamADVua1W4wlmVGbMPRsN
	gzMIt3Ici9zsHvtJZDTO4fjn0Xp3N1C9qzPFy2xO/hLt0msmSJiATxP3oCyC/tAR4JepTL
	FxfWJ6GEnTQnKT4YCHSzkRsM2IUnRpgSGDqTmihzaUi9hiBJrCnNb1idCjC52QdcN+dokF
	sU/zXT5/aM0u3sKOA8wutVcw+8xKiZigAm9dBoJYTeB5Vwh7ax/10pdw3FXvFbdTRB1wnT
	WgjgUcQ7L1B8tkifCKGpLxbV9CvqHOkqPxd/e/ED9OxaS+sTCBapXiPnhh650Q==
Message-ID: <dcb8f2ad-e09e-4f86-be06-7da39710e304@bootlin.com>
Date: Wed, 8 Jul 2026 08:33:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: Johan Alvarado <contact@c127.dev>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 luizluca@gmail.com, namiltd@yahoo.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <0100019f3f45ab47-bab143e1-1dee-49f0-9b38-16fd0d84175e-000000@email.amazonses.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <0100019f3f45ab47-bab143e1-1dee-49f0-9b38-16fd0d84175e-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/8/26 03:09, Johan Alvarado wrote:

> 
> [...]
> 
>>> +		/* The SerDes has its own pause controls; program them from
>>> +		 * the resolved pause modes, as the vendor driver does when
>>> +		 * forcing the link on a SerDes external interface. This is
>>> +		 * done here rather than in rtl8365mb_pcs_link_up() because
>>> +		 * pcs_link_up() carries no pause information.
>>> +		 */
>>> +		if (rtl8365mb_interface_is_serdes(interface)) {
>>> +			u32 val = 0;
>>> +
>>> +			if (tx_pause)
>>> +				val |= RTL8365MB_SDS_MISC_SGMII_TXFC_MASK;
>>> +			if (rx_pause)
>>> +				val |= RTL8365MB_SDS_MISC_SGMII_RXFC_MASK;
>>
>> Do you know what this does in HW ? Is this so that the PCS lets the Pause frames through
>> in either directions ?
>>
>> I suspect this is something that would be only used for inband advertising
>> of pause settings (in such case, you don't even need that), but ofc I'm not sure :)
>>
>> You already configure the MAC pause settings, can you test that these bits actually do
>> anything by exercising a bit flow control and checking if these registers are used ?
> 
> I tested it on the hardware, and it turns out these bits are the
> operative pause controls for the SerDes port: pause frames are only
> ever emitted when SDS_MISC_SGMII_TXFC is set, and the MAC force-mode
> pause bits alone have no observable effect on this port. They are not
> tied to in-band advertisement either - they act with the link fully
> forced.
> 
> For context, there is no public documentation for these bits, but in
> the vendor GPL code every write to them lives in
> rtl8367c_setAsicPortForceLinkExt(), the forced-link path, where they
> are programmed from the resolved tx/rx pause settings right alongside
> the MAC force-mode pause bits - never from the nway/in-band paths.
> 
> Test setup: RTL8367S (Mercusys MR80X), CPU port 6 on HSGMII,
> 2500base-x fixed link to an IPQ5018. I enabled regmap debugfs writes
> so I could flip the bits live, and forced congestion by L2-forwarding
> ~350 Mbit/s of SoC-generated UDP in through the CPU port and out of a
> 100M user port (~3.5x oversubscription, ~135 MB per run), watching the
> CPU port's dot3OutPauseFrames MIB counter:
> 
>   everything cleared (baseline):                 0 pause frames
>   MAC force pause only (DIGITAL_INTERFACE_FORCE
>       TXPAUSE|RXPAUSE, reg 0x1311):              0 pause frames
>   MAC force pause + SDS TXFC|RXFC:            2396 pause frames
>   SDS TXFC|RXFC only (MAC pause cleared):     2362 pause frames
>   SDS TXFC only:                              2934 pause frames
>   SDS RXFC only:                                 0 pause frames
> 
> RXFC did not influence pause emission, so by symmetry it presumably
> gates honouring received pause frames; I could not exercise that
> direction because the SoC MAC on this board never transmits pause.
> 
> So the write has to stay - without it flow control simply does not
> work on SGMII/HSGMII. I will expand the comment in v5 to say that
> these are the functional pause enables for the SerDes, rather than
> describing it as mirroring the vendor forced-link sequence.
> 

Thanks a lot for the investigation ! Ok so you do need to configure that
in the PCS. Maybe at some point we'll have to pass tx/rx negotiated pause
settings to the PCS, just like we to for the MAC, but it's strange as the
PCS isn't supposed to be the block handling pause :/

I'm ok leaving this as-is right now, you've added a nice comment on why
PCS regs are accessed in the MAC's link_up(). If we find other devices
that behave the same w.r.t. pause, we may have to pass these to the pcs_link_up,
but it's rather unusual I think.

Thanks :)

Maxime 

