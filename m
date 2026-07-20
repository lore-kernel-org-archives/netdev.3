Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8E382F2C
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561693; cv=none; b=RZQ/ONgt2x4UKtXMIeAtNZ4l74i8r1ma/Y21vvIZFngIsmBrVXfDw9hbtYyO5/LwrOyqFkjsEqwVVqV3kH0+oPGKkB2gFcBPAW8l70bTCzTggBrUNtVv1cj7695hvs/P3I6TJnI7xB2b2+TplvoKANZAVNNrmfLz3HudUbrWuF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561693; c=relaxed/simple;
	bh=RuQGmysVIoZEuAgJBpIE/unw+T6K4JJ5BgeBttSDo6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDHVUg0ixroswwlgM0fTDa0wTZtCufb5KllWruNXcxYZCqjCd+ipZdpDQ4T9YpBoHaFikpvILqL6fo6q0A1NnTPcmiGc5Y23LOmoS9arXRyHCmKGklc+bIYDJR40ksydjV1uqDoqIGMyezJBSEqX8VEYypGBq5wluKP4k7O2vj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hcNTniRr; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hcNTniRr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 613191A10FA;
	Mon, 20 Jul 2026 15:34:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 334AC60360;
	Mon, 20 Jul 2026 15:34:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A645B11BD139F;
	Mon, 20 Jul 2026 17:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784561682; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KqnS+kinSSM1++7MEfwgiazgYykeqv6efBfhW6wae/I=;
	b=hcNTniRrw4osJTyHVdmw0MYzi9gaIS+gGWqpr+bhLisCVQZhevOsNbBBwY173dPNxcLuzy
	3wqOglTOmbz9NDNuIH5OMvYHgcn8XJhm+3pRMwve2ubvdJrwEEowHcoHFcP6RJnBasNsoy
	srnw3d3NV/LDZw8y2iCKnZxbpqBcwnNS4XW15vgBBYSOYNhLex5DYgxvGIXmX6PcWfti3j
	isZtrHfBJSpxaE4f3Bfs4wdq1gdpgouab9idM+MmcSHigaf4F2pjWZ4yN7XyZImLs1zm4i
	bIBuFJQWtZdhcnqcmSTQCFPEi5PEWl+89F0Q2EcCFFX6lKmVYKBCu+IV3POd7A==
Message-ID: <5bc01e62-95c6-458b-9789-1f34791f7b75@bootlin.com>
Date: Mon, 20 Jul 2026 17:34:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
 <ae82997f-537e-4a2d-abce-d163fcf9d868@lunn.ch>
 <6ac12388-60de-45aa-a8d0-62fcfaf7bea2@linux.dev>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <6ac12388-60de-45aa-a8d0-62fcfaf7bea2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 7/20/26 17:17, Vadim Fedorenko wrote:
> On 19.07.2026 17:13, Andrew Lunn wrote:
>>> Looking at this, I'm wondering if we can't just get rid of SIOCSHWTSTAMP
>>> handling in phy_mii_ioctl(). Looks like we can ?
>>
>> I'm not sure about that. We need Richards input.
>>
>> The code in phy_mii_ioctl() allows the MAC to be bypassed, it goes
>> straight to a PHY based stamper. It could be the MAC has no idea the
>> PHY has this capability, so it has not implemented the .ndo?

Indeed, but even then the SIOCxHWTSTAMP aren't reaching the ndo_ioctl.

Maybe the thing to change (unrelated to the icotl though) is in
dev_set_hwtstamp :

	if (!ops->ndo_hwtstamp_set)
		return -EOPNOTSUPP;

	if (!netif_device_present(dev))
		return -ENODEV;

	netdev_lock_ops(dev);
	err = dev_set_hwtstamp_phylib(dev, &kernel_cfg, &extack);
	netdev_unlock_ops(dev);

We don't try to configure the PHY timestamping if the MAC doesn't support the
.ndo, maybe we should allow that ?

>>
>> It might be we need to hoist the code from phy_mii_ioctl() into
>> dev_{sg}et_hwtstamp()?
> 
> Hi Andrew!
> 
> I think I've converted all phy drivers while removing support for
> SIOCSHWTSTAMP/SIOCGHWTSTAMP from netdev ioctl. I believe it's impossible right
> now to reach SIOCSHWTSTAMP path of phy_mii_ioctl via ioctl on net device.

That was also my understanding indeed.
> Is it possible to have ioctl on phy device directly without involving netdev?

Unless there's an obscure mechanism I don't know about, there shouldn't be a way.

SIOCSHWTSTAMP/SIOCGHWTSTAMP don't seem to reach netdev anymore with the (great !) work
you've done, so they won't reach the PHY either indeed.

The SIOC ioctls can't reach PHYs without a netdev, neither can the ethnl ones.
Even when we have multiple PHYs and we use netlink, we can only reach the ones
behind a netdevice.

There is still sysfs entries for standalone PHYs, but I don't think we can use
any of that for ioctl.

Maxime
