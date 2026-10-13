Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C74F3CFF6B
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900177; cv=none; b=VFHOVVkLzhaU13ZCd8v8uPUQv87fbpWsfe5eQudMbWuHqRYJ3q/+Ht2v5gwjZGKrbXuY1z2ywGrdcwPnUWiT9ab18eTXJG3Msl12hnOytbyJtxEzVuGxbaSa5Hqgn6HhrQKA777K4Tb8IqCMHwCZ/MIyDeXkAzlkQ/S+A/NwMkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900177; c=relaxed/simple;
	bh=Nug6e4TC91qUr2C8X/81qXdodr2nNa3/8f78LKwCbwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmC52dd+mU/M9/n0r6p/dGvlrnWTG/9btYLwe+czyxkQlawwIwJWigiFeHwuLbQB/qmrgHileZHdrMDme8OF41zj//4ZXZYLPNEYhfG6Wqm/RLnkpXlsXKBePBOJfR9cMAor3eKHXOoDYxZfMccBF91r91++JCwAiKz0/sgCLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DuKoYupv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DuKoYupv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0DE781A1207;
	Tue, 13 Oct 2026 14:02:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8DCC60362;
	Tue, 13 Oct 2026 14:02:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BABB811D70A44;
	Tue, 13 Oct 2026 16:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791900173; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dgP92IK09zmVub/U/y0FIkPvSsCMyVYTFsCcLH2HeNA=;
	b=DuKoYupvMBFQgyuVyATsmQCsnGF3BxyNMY+F3C7HNOzs0/CzIP9zSaTmhqFbHFVIlYswnu
	qioK4smPfwrnpEddNa+4kwdC/egIsC1YHDiE4BhEnriSErqt/gCSok/FxzSd32LGchllyz
	j+fy5Q6jekVKSGLVkbAbqGOH1NUUATVYPJW1Mi0vfmxrgrGqcVcLOxMe9GlzSiWfzHEGCP
	aZkMAhKjfV0JXj55ZeupwIMk0kQAxZcT+SBTX135+l9ejNNmrEyaV1pSeWRmqcbql68ggt
	jlRkISE4CXL0kNg0NAXWMsCYOZAt8VR35SeCCKc9YXXD+y1HZiB/7K+dy+s/QA==
Message-ID: <2a008b68-7f8f-4b30-8026-58d8a64ae5d1@bootlin.com>
Date: Tue, 13 Oct 2026 16:02:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] selftests: drv-net: pause: Validate the
 pause autonegotiation with a partner
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev-bot+sashiko@kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, hkallweit1@gmail.com, corbet@lwn.net,
 skhan@linuxfoundation.org, o.rempel@pengutronix.de, vladimir.oltean@nxp.com,
 f.fainelli@gmail.com, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260925182628.214667-3-maxime.chevallier@bootlin.com>
 <179065240018.434549.346139764454021625@kernel.org>
 <40f413f0-1dfb-4968-b483-f03aa2f1bdbb@bootlin.com>
 <45340f54-a53b-4d3a-a773-b51cfc88c939@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <45340f54-a53b-4d3a-a773-b51cfc88c939@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/13/26 14:37, Andrew Lunn wrote:
>>> Firmware-managed NICs such as ice also keep the link on close by default.
>>> In drivers/net/ethernet/intel/ice/ice_main.c, the PHY is only taken down
>>> on close when ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA is set:
>>>
>>> 	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags)) {
>>> 		int link_err = ice_phy_cfg(vsi, false);
>>>
>>> On this kind of hardware, a directly connected peer would be cached as
>>> cfg.lp_controllable = False. pause_aneg_resolution(), and the four later
>>> tests in the series, would then skip with "is not directly connected".
>>> That message points at cabling, when the real cause is that the PHY
>>> stayed powered.
>>>
>>> The new remote lp_advertising checks in pause_advertising_test() would
>>> also be skipped without any notice.
>>
>> Not much we can do if the peer doesn't behave as expected here. Not sure this
>> requires attention.
> 
> I sounds like anything with a BMC is going to hit this. So i doubt you
> will see it with your stmmac boards. Maybe sometime in the future we
> can query the NIC to see if it supports NCSI and change the test
> behaviour to fit?

Maybe the strategy is wrong then, the goal is to check that we're directly
connected to our test peer through a cable, or indirectly through a switch.

Link flapping seemed to me like the most generic solution, but maybe we can
do something entirely different ? Like for example trigger a re-negotiation
with ethtool -r and check for link flap, or maybe more reliably, ask the user
to pass a flag to the selftest command saying if yes or no we're directly
connected ?

Maxime

