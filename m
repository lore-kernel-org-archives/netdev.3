Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D741B365;
	Fri, 24 Jul 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896858; cv=none; b=rqa3grAq3C3SvMbu0tomUQHidDc6KLl+ppZlieFGTy3Rz37T2KrQajx/rom3Z6/Txyr/Pr5vqA2TgE1ftDH4c1Wob7pqiwj5KBoEAKTLG7btvl4EZ+YGqeaq/7dQ9DZ+hcR8NNzUUUuiLGIGHGItb2O9e/qkrx2KXyJexxxouQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896858; c=relaxed/simple;
	bh=F+LA25uk8OP1YWWzkAaUW6d1IwhyJ1CARY4bKPSvC9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDi0vGcVBNTP2mHrlZXJLb2SwvT5YEdgUm9bGA6zUWkxF5D2tejkJXPiqM2VNu2f6rwhQmCnZ39m3vRNanqkLY7XhuEWGIImWeFnK5ELZuAvsP+oqFkIpDSAJ6Y/q9jvTeE9fNqoKIkIrF2mNp0zyWf6BTDmVQxhBh3o63PlPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=znTP3Sza; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="znTP3Sza"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0582C1A11EE;
	Fri, 24 Jul 2026 12:40:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CAB6260395;
	Fri, 24 Jul 2026 12:40:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3368311C11A92;
	Fri, 24 Jul 2026 14:40:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784896844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=15pY6w0jny73PRLczReeiniz/rgpD90LtPmuXEwAgDw=;
	b=znTP3Sza/P3Kk5ysFfCKIcFynPHzrzFQ/+geqRU/jiwIEqLacu3tSrSCrvgxe18vrVRg7B
	ho7LdVHJr85f1O9Ax9aK9h206GYUjg2Bk/ExZIxbDhPsmLEljFfhjGuUSmMSGHZnGab8fy
	G8Y6crlqNGjoNwzTEp6jInEZxCgWBfo+UFQLRh+p2Ga+64DtgyPqUtBltHyzU4gFKFn9yg
	0OucNv5cPhnDfLGZSNN++b4IrrLNV6dP/36kSu7YK6Ts7xwYh8iG57d9AmvP665Sv3ZcpX
	RVEACmFzNQW0BoA66DzFrFZ8VnYHLPyf+TMegtpjxBuGoVRr8I3wzX6wlar30A==
Message-ID: <5694e62a-c67b-458b-993d-43a09ca4459f@bootlin.com>
Date: Fri, 24 Jul 2026 14:40:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Skip PHY attach if custom PCS is in use
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Zxyan Zhu <zxyan0222@gmail.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Serge Semin <fancer.lancer@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Hariprasad Kelam <hkelam@marvell.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260722131918.685761-1-zxyan0222@gmail.com>
 <b8f125be-e91f-4b44-8664-5746edb28f33@bootlin.com>
 <amDKD/9aPYXctiWI@oss.qualcomm.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <amDKD/9aPYXctiWI@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/22/26 15:47, Mohd Ayaan Anwar wrote:
> On Wed, Jul 22, 2026 at 03:40:08PM +0200, Maxime Chevallier wrote:
>> Hi,
>>
>> +Mohd
>>
>> On 7/22/26 15:19, Zxyan Zhu wrote:
>>> When a platform provides a custom PCS via the pcs_init callback
>>> (e.g., for USXGMII with in-band autoneg), the MAC's phylink_pcs
>>> is already configured. In this case, phylink validates against
>>> the PCS's supported interfaces and manages link state through
>>> the PCS, so no traditional PHY device is needed.
>>>
>>> Without this, stmmac_init_phy() falls through to the
>>> no-phy-node path and errors out with "no phy found" when
>>> the DT has no phy-handle for such interfaces.
>>>
>>> Skip the PHY attach when priv->hw->phylink_pcs is already set
>>> and no phy-handle is specified in the device tree, allowing
>>> platform PCS implementations to handle the link autonomously.
>>
>> Hmpf this bug again...
>>
>> There have been multiple attempts at solving this, cf this thread :
>>
>> https://lore.kernel.org/netdev/E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk/
>>
>> Now, there wasn't any conclusion on that, but I _think_ the proper
>> solution is to re-apply Russell's original patch (the one in the link above)
>> and to add this current patch on top of it.
>>
>> Russell states that this may (will ?) break qcom-ethqos, but OTOH
>> we're in need for a solution here, and with the pace of PCS-related
>> work that impacts stmmac, there's going to be a point where we may
>> need to think about compatibility.
>>
>> TBF I don't understand the qcom-ethqos issue, maybe Mohd can help
>> with testing here ?
>>
> 
> Sure, I can help test out qcom-ethqos and see if and where it breaks.
> 
> We could not arrive at a conclusion the last time because I ran out of
> options to try and find a proper solution. So if it still breaks, I will
> spend some time and brainstorm qcom-ethqos's interaction with the
> integrated PCS, again.

Thanks :) Good to know you're here to test !

Zxyan Zhu, I think you can send a V2 Series with this current patch, as well as
this patch from Russell :

https://lore.kernel.org/netdev/E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk/

The combination of the two work on dwmac-socfpga, and it would be great to test
that on other stmmac variants

Maxime

