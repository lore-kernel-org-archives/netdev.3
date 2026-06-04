Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C93D25BB;
	Thu,  4 Jun 2026 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560804; cv=none; b=o1/8PUsevrg1tJR08PBS+axOTKLYzVUbsvxFkV6FapRte+oDMMOGTVNPCxja7PcDoCZblcu0PFvy/wS8ZSQWfbhBXYthUMF2xslpumtxr1O4/5y/krG3lYeeEDaKskFk1Y5Zo3oOg+Hv7IT2NaDw6keFbIw3DuJvXVS0R3mBUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560804; c=relaxed/simple;
	bh=0c8b3RhogpqVMxpZhHRwa8Y5/c/DPC9LiXafeJ6nGes=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=i3vMoXCc7rDzQPcmCuDBXcGBRePtRBKB4FW2tb7Yg7Fb6/tuL5yhN1B6dB4eDSgCOsIttwmlqSVXsXZKC+OEBluF7oiCkyq1gvy0lzsGLwnMzhjY7ToqQhZtH6FdtyZSiSI335a9QFM2iuAA6nivdUoeC+asIljtGFkfNkEhl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=h4gfB+Je; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="h4gfB+Je"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2294A0968;
	Thu,  4 Jun 2026 10:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780560794; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DhXlPTQU3U80UBpGm6zhk9Q1hWLTJ6kBqPz2+9kQOKs=;
	b=h4gfB+JeXGH2/kgfqwALh+sG/qNcHxsZ5zKK35XN9CMhMSjKe3aFoV+TYJEMwKKroHoOEd
	6+RZYPX7Y2hGpnPbmiV9vrptLlQBVImUunt3JMZqsgaSamH7s+MP3+PaKnzKDN8/Ez8biK
	9AMSOH2+6FNV31bh2J50Co5zB3kufhv+ssLIxgkKqIX3tSm5Ww2nlUzEgVDnhdxLfu11f+
	TUogfGQKG2I5dAZ0c1G3w6U1emeOa92sW8BSffnusl8ur3NqA0xY9vURPjRIvk9dniMQgU
	AmMWH1l2Qvppr5CStJrp+XN6N/pZI3Di1F/cT83hHWLzx/ym1jhvqzv98p33hA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 10:13:12 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net v2 2/3] net: phy: remove phy ports upon probe failure
In-Reply-To: <5d0a38d0-44ab-4689-a243-8c9aed057d93@bootlin.com>
References: <20260601084029.815461-1-maxime.chevallier@bootlin.com>
 <20260601084029.815461-3-maxime.chevallier@bootlin.com>
 <2823b00cb2aa211d8f4f392a37537351@tipi-net.de>
 <5d0a38d0-44ab-4689-a243-8c9aed057d93@bootlin.com>
Message-ID: <4aba06e51f06e2555e4abc97f22025ee@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 4.6.2026 10:02, Maxime Chevallier wrote:
> Hi Nicolai,
> 
> On 6/1/26 11:31, Nicolai Buchwitz wrote:
>> On 1.6.2026 10:40, Maxime Chevallier wrote:
>>> When phy_probe fails, let's clean the phy_ports that were 
>>> successfully
>>> added already.
>>> 
>>> Suggested-by: Nicolai Buchwitz <nb@tipi-net.de>
>>> Fixes: 589e934d2735 ("net: phy: Introduce PHY ports representation")
>>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>>> ---
>>>  drivers/net/phy/phy_device.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/drivers/net/phy/phy_device.c 
>>> b/drivers/net/phy/phy_device.c
>>> index 6ccbfacf7d1d..a171cbe2a74a 100644
>>> --- a/drivers/net/phy/phy_device.c
>>> +++ b/drivers/net/phy/phy_device.c
>>> @@ -3778,6 +3778,8 @@ static int phy_probe(struct device *dev)
>>>      return 0;
>>> 
>>>  out:
>>> +    phy_cleanup_ports(phydev);
>>> +
>>>      sfp_bus_del_upstream(phydev->sfp_bus);
>>>      phydev->sfp_bus = NULL;
>> 
>> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> I'll be moving phy_cleanup_ports(phydev); after the sfp cleanup,
> can I keep your review tag ?

Sure.

Thanks,
Nicolai

> [...]
