Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6075427FA6
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785959987; cv=none; b=mmnHmIucsgFCIKU5Ng0+3ox68JO3n8q2nU5ZxG7o2/VRzK6kYh3R5YIc20GQHkCh8LNLe9Pkgd0osWyJC7DIWt2thYFOr7nYtPhia3xBJn4A7Yb/5OiBIT4p4j0RRpFxl+c8MXbL16OFQQXooMHd3AECRbBO8Y3GWjSDW8sOrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785959987; c=relaxed/simple;
	bh=g+sXX8U83W7f0aSs8eVUYq4SGG4wUsMI9h5Y8aj8rzA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=T2t/QaK4kiYml19ktY+HPwq6RH856ts1gssJmv9KVxLvE1cOy3sbfvR99F7Uk3gh95/yPQH2+C6uz0hY4wb4agJWzuMaDGHOE1M9qRwn89QZRvmioCa2xeD/FBFOqm7ckbS82ocC0JlfIDumZLtGGWvpiFjhwuxtDj3zq6jQjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HmF/fYxZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HmF/fYxZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 51DD71A143C;
	Wed,  5 Aug 2026 19:59:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1DED1602AB;
	Wed,  5 Aug 2026 19:59:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D14411C352CE;
	Wed,  5 Aug 2026 21:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785959974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I7Gl1ofBFulIYHJDGqWQ0jAt3ABpBdQ0Cnx8yXAsJK8=;
	b=HmF/fYxZ3xdSVE/Gc6IilSH6/G9PlsisaMyZWCAIpZm1LYDIIWehuLW3egBUovPbMbFQ+3
	4lsKiVOYOaoyeQorstP0ujLBBR8pagZPOjnPyOLmLMq/8gKVrNbzYqoAHGX3lhsvq/LLCc
	fR2jjYk9Dr3OX/67PdGDgMkOY3rTS47VYTLEal68q+aPs6iALw8x1YBOdhC4RNG4M/Nd6O
	gxwGieVusGXp1tqBk4XIi6nfUbN1zrn4AMzk5HfWRVgKeETV67mnDWv0b1Ol7m5iBB3Xmu
	0BtucNAq8jBK2+mDDbqg2o/TiHBcy59TAw0aKzX6ERDF89+mstJacEUUqUFeKg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 21:59:31 +0200
Message-Id: <DKH9Z0IMH95B.3JWB4PXQC9SN5@bootlin.com>
Subject: Re: [PATCH net-next v3 2/2] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
Cc: <netdev@vger.kernel.org>, <conor.dooley@microchip.com>,
 <charles.perry@microchip.com>, <andrew@lunn.ch>
To: "Nathan Whitehorn" <nwhitehorn@pa.msu.edu>, "Paolo Abeni"
 <pabeni@redhat.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260729192748.6928-3-nwhitehorn@pa.msu.edu>
 <20260804083706.54487-1-pabeni@redhat.com>
 <db8e1771-8d93-4c18-b09b-5976e1f0c4c3@pa.msu.edu>
In-Reply-To: <db8e1771-8d93-4c18-b09b-5976e1f0c4c3@pa.msu.edu>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nathan,

On Tue Aug 4, 2026 at 5:08 PM CEST, Nathan Whitehorn wrote:
>
>
> On 8/4/26 04:37, Paolo Abeni wrote:
>> From: AI Reviewer <ai@example.com>
>>
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> Full review at: https://sashiko.dev/
>> ---
>> --- Patch [2]: [PATCH net-next v3 2/2] net: macb: add support for 1000BA=
SE-X autonegotiation to PCS ---
>> commit 3a10158740d1fea523a081adf59e6bcdf1cd55d1
>> Author: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
>>
>>      net: macb: add support for 1000BASE-X autonegotiation to PCS
>>     =20
>>      The current PCS code unconditionally uses SGMII autonegotiation, th=
ough
>>      the hardware supports both SGMII and 1000BASE-X modes. Decouple the
>>      choice of PCS enablement from use of the SGMII mode when running at
>>      gigabit rates and announce to phylink that 1000BASE-X is a supporte=
d
>>      operating mode. This enables direct attachment of the PCS to e.g. a=
n
>>      SFP.
>>     =20
>>      The 1000BASE-X code in phylink also sometimes calls the autonegotia=
tion
>>      restart method, so add an implementation of autonegotiation restart=
.
>>
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/eth=
ernet/cadence/macb_main.c
>>> index c15a9c7e69d37..310ad8eac21fc 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -583,7 +583,12 @@ static void macb_pcs_get_state(struct phylink_pcs =
*pcs, unsigned int neg_mode,
>>>  =20
>>>   static void macb_pcs_an_restart(struct phylink_pcs *pcs)
>>>   {
>>> -	/* Not supported */
>>> +	struct macb *bp =3D container_of(pcs, struct macb, phylink_sgmii_pcs)=
;
>>> +	u32 old, new;
>>> +
>>> +	old =3D gem_readl(bp, PCSCNTRL);
>>> +	new =3D old | BMCR_ANRESTART;
>>> +	gem_writel(bp, PCSCNTRL, new);
>>>   }
>> [Severity: Medium]
>> Since 1000BASE-X utilizes base page advertisements that can dynamically =
change,
>> should the adjacent macb_pcs_config() function be updated to return 1 wh=
en
>> changes are made?
>>
>> Looking at macb_pcs_config():
>>
>> static int macb_pcs_config(...)
>> {
>> ...
>> 	if (old !=3D new)
>> 		gem_writel(bp, PCSCNTRL, new);
>>
>> 	return 0;
>> }
>>
>> Returning 0 unconditionally appears to prevent phylink from restarting
>> autonegotiation when the advertisement changes (like flow control or PAU=
SE
>> settings), meaning the new configuration will not take effect until the =
link
>> is bounced.
>>
>> [ ... ]
>
> Thank you! This is a good catch of a pre-existing bug in=20
> macb_pcs_config() that matters a lot more with removable transceivers=20
> and I will fix it in an updated patch.
>
>>
>>> @@ -750,7 +755,9 @@ static void macb_mac_config(struct phylink_config *=
config, unsigned int mode,
>>>   		ctrl &=3D ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
>>>   		ncr &=3D ~GEM_BIT(ENABLE_HS_MAC);
>>>  =20
>>> -		if (state->interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
>>> +		if (state->interface =3D=3D PHY_INTERFACE_MODE_1000BASEX) {
>>> +			ctrl |=3D GEM_BIT(PCSSEL);
>>> +		} else if (state->interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
>>>   			ctrl |=3D GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
>> [Severity: High]
>> This is a pre-existing issue, but could macb_mac_config() race with
>> macb_set_rx_mode() over the NCFGR register?
>>
>> macb_mac_config() modifies NCFGR while holding bp->lock:
>>
>> 	spin_lock_irqsave(&bp->lock, flags);
>> 	old_ctrl =3D ctrl =3D macb_or_gem_readl(bp, NCFGR);
>> 	...
>> 	if (old_ctrl ^ ctrl)
>> 		macb_or_gem_writel(bp, NCFGR, ctrl);
>>
>> However, macb_set_rx_mode() performs a lockless read-modify-write on NCF=
GR
>> protected only by netif_addr_lock_bh:
>>
>> 	cfg =3D macb_readl(bp, NCFGR);
>> 	if (dev->flags & IFF_PROMISC) {
>> 	...
>>
>> Could this concurrent modification lead to lost configuration updates, s=
uch as
>> overwriting PCSSEL/SGMIIEN bits or dropping promiscuous/multicast flags?
>>
>> [ ... ]
>
> It probably could. I am a bit hesitant to fix this as part of this patch=
=20
> series for scope reasons, though, and would like to defer to the driver=
=20
> maintainers on the proper fix for this one. I don't think things are any=
=20
> worse with this patch than they were (1000BASE-X vs. SGMII=20
> autonegotiation modes are essentially static, except on physical SFP=20
> replacement, unlike promiscuous/multicast).

Sashiko loves raising such pre-existing issues! macb_set_rx_mode() is at
fault and you have no relation to it, so don't feel obliged to address
that finding.

Also, it does no distinction on the frequency of the codepaths (here two
functions called approx once per boot). It would be a proper severity
high if it was phylink_get_state versus IRQ for example...

Fix only if you want.

>>> @@ -1061,9 +1070,12 @@ static int macb_mii_probe(struct net_device *dev=
)
>>>   			  bp->phylink_config.supported_interfaces);
>>>   		phy_interface_set_rgmii(bp->phylink_config.supported_interfaces);
>>>  =20
>>> -		if (bp->caps & MACB_CAPS_PCS)
>>> +		if (bp->caps & MACB_CAPS_PCS) {
>>> +			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
>>> +				  bp->phylink_config.supported_interfaces);
>>>   			__set_bit(PHY_INTERFACE_MODE_SGMII,
>>>   				  bp->phylink_config.supported_interfaces);
>>> +		}
>> [Severity: High]
>> With the addition of 1000BASE-X support here, does the init_reset_option=
al()
>> function also need updating to prevent a regression on platforms using a=
 SerDes?
>>
>> Looking at init_reset_optional() later in the file:
>>
>> 	if (bp->phy_interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
>> 		/* Ensure PHY device used in SGMII mode is ready */
>> 		bp->phy =3D devm_phy_optional_get(&pdev->dev, NULL);
>>
>> Since this explicitly checks only for SGMII mode, won't the hardware
>> initialization for the SerDes lane fail when the MAC is configured for
>> 1000BASE-X, leaving the generic PHY uninitialized and preventing the har=
dware
>> from linking up?
>
> This block of code is specific to an onboard PHY -- which does not=20
> generally (ever?) exist in 1000BASE-X mode -- and what looks like some=20
> kind of Xilinx Zynq-specific quirks that I don't know enough details=20
> about to understand whether it is relevant in this case or test. As=20
> such, I had decided not to touch this code in this patch, but would=20
> welcome any feedback from people more familiar with the Xilinx case than=
=20
> I am and am happy to make changes if appropriate.

Agreed with you. It's ZyncMQ quirks, and if it was done that way most
likely the HW only supports SGMII and they have two-three wrapper
registers that must be written.

I asked an LLM to make a scan and upstream devicetrees seem to confirm,
with only RGMII or SGMII PHYs.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

