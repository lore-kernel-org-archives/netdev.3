Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1C3CA481
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876055; cv=none; b=PO8irghWsd9TbmRilqop8wBGON7793i0L5EcR/XsQeZOW5HRJhZoGTG0PORO7g54sPAEO6/F83s563kChmKxrs6eS+mRWK89gIG0LgeO747QOfYPpIZHLQ3C3h2cEcBXCT+ixD5FbqvSVAi1zbR+Ry2yP3v2w4/RQGKpNtnb2CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876055; c=relaxed/simple;
	bh=C8NNL7hwaTk7W11gVRZRwpeVV5rtR8at0YoB5aRdk3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M35V50aS6KLw/+RoMQLIcKqsmt25tl5cge4IL951tPS1pInLVZGmJIl3lc77rBxnEz1eIwaeFoesJuZ4mone8YgN5nKzy06YmPmeJs01ax78Qqh947k7k7nIuQRZfsBUPfQgiCX3plDNgiqp+PvJRNmI+YpOw2QmikAEezPUTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y7BTAk1f; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y7BTAk1f"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D05204E42869;
	Mon, 30 Mar 2026 13:07:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9CC785FFA8;
	Mon, 30 Mar 2026 13:07:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A46CB10450083;
	Mon, 30 Mar 2026 15:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774876049; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kxvWlb22Njz2egFEf3cDrys6xgKK//DxYUkt6sa1KI4=;
	b=Y7BTAk1fzkpu2QGNVyq1Qe1qk+fNedxyKVoun+GAZkv9jy8TC41cR5t7Gk1hp65n41i6b5
	DHCiNw5f91uhU0tPoejTqfyw9+bFg8lE5Q0tvWGesrMwCZKim3ja6Z/8rCYXlHB9qDmYKs
	18qZ3GYLQYDbyoiZyXEbYH0nh98WrEXiED59vrMUuWcEye/9mpRNMwdLm9BLIpfFF3OlKb
	Q5aJbod/01ojURy9JaudHfw+RCdcISTuMB5Pw1PoMASvXVJuTG2IHG3AYV89I3WW6sp5v3
	QezCAQXmgp4cJ2T9VQmq5zu7BW79lJaTjYOmIkWhAMouCsg+X4BDnzzhClYHbA==
Message-ID: <20b8349c-932d-4138-a155-5359cc3a10b2@bootlin.com>
Date: Mon, 30 Mar 2026 15:07:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phylink: allow PHYs to be attached in
 802.3z inband mode
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>
References: <E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk>
 <a5d7aedb-9770-492f-b528-0a28a652279b@bootlin.com>
 <acatrPb1DdHuyVoL@shell.armlinux.org.uk>
 <30a2cad9-fa2c-4abe-ad51-983d70564c7c@lunn.ch>
 <acptbbfTt_FJgms6@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <acptbbfTt_FJgms6@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 30/03/2026 14:32, Russell King (Oracle) wrote:
> On Mon, Mar 30, 2026 at 02:26:58PM +0200, Andrew Lunn wrote:
>>> As I've recently said, I think we're more or less boxed in between a
>>> rock and a hard place because of the hacks that qcom-ethqos introduced
>>> with its PCS support. At the moment, I am failing to see any path where
>>> the stmmac PCS can be programmed for inband according to phylink's
>>> wishes and qcom-ethqos can be made to work without its hacks.
>>>
>>> This all ultimately comes back to the half-hearted phylink conversion
>>> of stmmac that was done behind my back without my review. Had the
>>> conversion been done fully, and kept up with the phylink changes for
>>> PCS support, then we probably wouldn't be in this situation today.
>>>
>>> Unfortunately, the driver is going to keep breaking all the time that
>>> it abuses phylink, and at the moment I see no way to stop this sodding
>>> driver abusing phylink.
>>
>> "The needs of the many outweigh the needs of the few"
>>
>> The MAC driver is used by a lot of different SoCs. If qcom-ethqos
>> caused this problem, should we consider breaking backwards
>> compatibility for it, if that opens up a path for getting clean
>> phylink integration for all the other variants?
> 
> Consider something like mvneta (which supports 2.5G speeds) connected
> to a 2.5G PHY that uses 2500BASE-X for 2.5G speeds, and SGMII for
> slower speeds with inband.
> 
> How should this be described in DT?
> 
> 	phy-mode = "2500base-x";
> 	managed = "in-band-status";
> 
> will fail today, as these tests will refuse to attach a PHY in that
> setup, and without a PHY attached, we will never know if it switches
> to SGMII mode.
> 
> This patch makes phylink more flexible and permissive.

You're patch is clearly correct IMO

> However, as has been found, this patch causes problems for stmmac,
> so it needs a different approach, because stmmac interprets an
> optional PHY as "we must have a PHY if we don't we fail" at the
> moment.

What would be the consequences of changing stmmac's stmmac_init_phy so
that it doesn't error-out when no PHY is found AND we have a PCS AND
we're using any of the SGMII/1000BaseX/SFP-compatible modes ?

I don't think it would break current setups that work, but I may be
wrong here, especially as I don't have a good understanding on the
problem caused by qcom-ethqos here :(

Maxime
