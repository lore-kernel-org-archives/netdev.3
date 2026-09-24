Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE428361944
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258651; cv=none; b=ODWkeDVPkkRxI2Bp3AngrpA7zRc4MF5tlqelqLiyMMj4i0yVfhcdpkhVSiuypNXWuUVzXb4z/LlN7NzwGY1VKPpJUD2Q6yR+y7i6bz18Fo7KFF3BkJBGBewNHZRGR4vOvDQCda3MV718wIVxrxHQu7QGuL44b6RrErj7Jb1Uh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258651; c=relaxed/simple;
	bh=Jx/FoS3YQ3sSRmpcfu8IXCU6XB27SkLhCaIXwR6fTF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5XeFBfNSXj5VGNoq0zpFgDzhxh2ak0AiXfIuYEZZKb+hCpCVQF0fcJcpw51VHqcBaDelK7ldsfPofnQOf1UoSxXEOx2vCz5KIXjbxtdCCAqrhY4uIop1K4tGUqNJHIEQy9Q+rGyXCERXppYSMIzx2eB+ZE50kVbvXYrh63gThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QugIOZP/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QugIOZP/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 192894E4105D;
	Thu, 24 Sep 2026 14:04:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E0E0160341;
	Thu, 24 Sep 2026 14:04:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4DF610328D17;
	Thu, 24 Sep 2026 16:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790258642; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ihni7hhtCrz44oxSik4WfQd3qi/mucvdq3PDuzw6vGs=;
	b=QugIOZP/X+VQ1P8ND6584ZIN7DkI7/Eqb7iXWwDZHA/TcNLZy4RGDKJnBgZq7N5d8f4/5f
	y2IKyUruGCk8cczG8bHeg2I191/icbBDRd4xCBlBt1iAdv1sIYNQlWVGU0kGuJKme2RfJM
	byuF4PWBHBPucKrHmwVQ4nY0KjXBlF7WVI1UzJAr0xQJsjfkZ+R6JMdpjsiAzZE+MG1zu6
	9CFRoaF5gXgj5Yw+n1qqvF5mAXaxIJSFY/S7KxFiFLj135fwMMUSV2vL9+ju2vYTKGGl7p
	krljcxGEXZCwW49Huk8vPa9p36eo/QSpB1kSbfo0epAuMOQ3VQFv39yP8YYRXA==
Message-ID: <c0528db8-9627-4533-b636-a7b37186c165@bootlin.com>
Date: Thu, 24 Sep 2026 16:03:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] selftests: drv-net: pause: Validate the
 pause autonegotiation with a partner
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
 <20260920164732.349744-4-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260920164732.349744-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/20/26 18:47, Maxime Chevallier (Netdev Foundation) wrote:
> Pause autonegotiation behaves differently than the regular link params
> autonegotiation, in that the user intention may differ from the
> negotiated pause parameters.
> 
> Introduce a test that validates we're correctly resolving pause
> parameters according to 802.3.
> 
> The validation is done based on what the local interface reports in
> terms of advertised and lp_advertised linkmodes.
> 
> If the remote can express what it sees in terms of its own advertised
> and lp_advertised modes, validate the autoneg results on the peer as
> well.
> 
> Signed-off-by: Maxime Chevallier (Netdev Foundation) <maxime.chevallier@bootlin.com>
Dammit, this patch is duplicate, stale one from 2 format-patch sessions in
the same -o folder :(

sorry about that :(

Maxime
