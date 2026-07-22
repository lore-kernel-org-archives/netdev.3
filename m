Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6794BC025;
	Wed, 22 Jul 2026 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714498; cv=none; b=E8ZSCjmY3hh2BR/pb0uRgOYaOqeCjj0c41WbIc6K6fsbBOGuhxcuHp/a3WDoAzmbFksmWx30+9c6ukP+f5KPODPYXsrDDsSFFMJf1Ga6Ie2kNtFoBeto6zHGyghL7EHMhIiT4q02jJ3jRABnuyVLeTiZBieQo6IzuLnXiFi1XZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714498; c=relaxed/simple;
	bh=6bm8PH7GH2yuUTm2Nin0BgK/504XyJRUWtKBCoCfaZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuqEL/7ihsLOTts+EuBMvaylHaahYucXx8ET2SyNw6rOT2+uP/50tZ+zHW6jzPwJpPgyPoyWmto+rTTXBHFiDuXzVINhU4aGXaeRX9VzdMdX2eTEdsMx1kUUshJmtojVILtsIKPfBScLTgV5eTVBf/00Xbm2iX+u8dqWQTnA2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UHp49h4+; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UHp49h4+"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3E0D74E40EC3;
	Wed, 22 Jul 2026 10:01:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 10E5660388;
	Wed, 22 Jul 2026 10:01:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA74911BD3A98;
	Wed, 22 Jul 2026 12:01:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784714489; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6bm8PH7GH2yuUTm2Nin0BgK/504XyJRUWtKBCoCfaZI=;
	b=UHp49h4+lvg0lNLwl2N7SuhIaBJZ9aHkfrWQV3hmMyPc+4iaoC2LPsBH5XAo/lHxegk8Di
	oanY8YZxjVzDQ8B/SQNiEW3NXybt+CgYz9mmOoc++ZfudwXJ9+TTUp1Nz5haoGC/HVDv4o
	0NeH5kNhv59V8id4prDVT7UQMcdn9INldcBEFBkh7oWyeDACZt5gPaXphVc8T+QqsF6nCS
	M8FSNr5179HASOSKppOsIuwtd9ViHwKKMl1+VzrfUxS3n6Wb7CtdOX2Mf3bJDkW63jgI1X
	/jNPmJ8CqCsEmyxlDhtF5fVlMySxOOxtCHJFt5MyVcBCi8x50KuR1ZmVTCE/Tg==
Message-ID: <0972e0f2-4480-4668-8222-7a327a85f058@bootlin.com>
Date: Wed, 22 Jul 2026 12:01:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 09/10] net: ethtool: Introduce ethtool
 command to list ports
To: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>
References: <20260720174808.139573-1-maxime.chevallier@bootlin.com>
 <20260720174808.139573-10-maxime.chevallier@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260720174808.139573-10-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/20/26 19:48, Maxime Chevallier wrote:
> Expose the phy_port information to userspace, so that we can know how
> many ports are available on a given interface, as well as their
> capabilities. For MDI ports, we report the list of supported linkmodes
> based on what the PHY that drives this port says.
> For MII ports, i.e. empty SFP cages, we report the MII linkmodes that we
> can output on this port.

Sashiko points the rtnl assert will fail on ops-locked netdevs, that's
likely the case as I haven't tested on such a device.

I'll update for next round,

Maxime

