Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F0386575
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384418; cv=none; b=oAera1PvqRkieHK8ZIr28ZjO7mlUHjc0ABCOtwfJwnSnK2LODCiOUyotogEs/BAMmU1l5dEvzuPTnIgWA/XLnLOIbS5eVc3V1c4jDYvndzBaA7a8uhQgV01xVKoHF4lFaRCVZXyo8LkWtOHRqigvvfeNtZgTl/ZAlgXTzGcLq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384418; c=relaxed/simple;
	bh=prs3IfJgCazKnxqNmCQWlVj7MvJ+L/Z/ihKYQf+1Lzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFDeXWLDsuH/MPYt4YndXLBvMddu026Nblf2Y5po0jDuet3olMXkvY+4tbxXox0kmhj7KyQBP8fMa2c6OI5lYodlg86t6T4f2GpQGPLs9kc7bN/r61ZecCel7oGBqKur9HStQn1bl8YFupOjx0y0IMidsXz6TwY9fSzJ5dPgyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RBW4i5q2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RBW4i5q2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9B083C5CD4E;
	Thu, 25 Jun 2026 10:47:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 373915FF03;
	Thu, 25 Jun 2026 10:46:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 46D70106F07D1;
	Thu, 25 Jun 2026 12:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782384413; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TTYQeL5JdttE+/EcvvZNRsJLIGDJuGnDB/de7RtHC2w=;
	b=RBW4i5q2N5/igzFxi+poDdM4ui/uFg8gISryIFXGS3lAPXlNOGBHuXx5GQ5xb3oHl3/Rnf
	qWamU7q6IAzS4FJ3HnrTZRTeV0Gwx3UIYkdvWeoYWYgSPrs5Mmgo9KdgdDoLE80hpEvAVF
	a9ztLle2pm0/wF30UUWrII9HLSKVm56G3weT3JNhHiNtktnEZxaEQpePy6nNIq4bg77+Lm
	J+a8nWsMZSnLaYTJhXZAL6OP/2D9ubzfCJSwAiSCkGoV+9WUCAUzD0cGylebeqs2TMcOCN
	K5+YR2imbFwh/DDqgu4vR2K37r0E9WTXjCGLsxF5kc+Z1y1rf751jdRg+8l6aw==
Message-ID: <7a88fee8-bbb3-480f-9c93-677b7270a940@bootlin.com>
Date: Thu, 25 Jun 2026 12:46:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <2293244a-c6a9-4642-a721-dada8a081dbc@lunn.ch>
 <adb69dee-2737-46ca-a92b-aae1ea7f5989@bootlin.com>
 <b7de216a-fd1a-42a0-8711-d822a1ad9319@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <b7de216a-fd1a-42a0-8711-d822a1ad9319@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 5/29/26 14:59, Andrew Lunn wrote:

(This discussion was a while ago, but this bit of context should be enough)

> But we also need to consider that for some APIs, we have decided that
> a configuration can be set now, which does not actually apply in our
> current conditions, but it will be stored away for when conditions
> change and it is applicable. The half duplex case could fit that. When
> the link is currently half duplex, you can configure pause, but you
> don't expect it to actually change the current behaviour. It only
> kicks in when the link renegotiates to full duplex sometime in the
> future. We have to also consider this the other way around. The link
> is full duplex and pause is configured by the user. Something happens
> with the LP and the link renegotiates to half duplex. The local end
> should not throw away the configuration, it simply cannot apply it
> given the current situation.

I'm writing the test description for HD with a better formatting, so the
HD test wouldn't be about "are we using pause stuff while in HD" as it
doesn't make sense, but rather "do we correctly store the pause settings
aside for later".

I'm realising that we don't really have an API to report the *true* in-use pause
settings. Taking HD as an example :

# ethtool -s eth2 duplex half

[588209.379363] mvpp2 f4000000.ethernet eth2: Link is Up - 100Mbps/Half - flow control off

# ethtool eth2
	[...]
	Supported pause frame use: Symmetric Receive-only
	Advertised pause frame use: Symmetric Receive-only
	Link partner advertised pause frame use: Symmetric Receive-only

# ethtool -a eth2
Autonegotiate:	on
RX:		off
TX:		off
RX negotiated: on
TX negotiated: on


Sure, pause and HD don't make sense, however what I find confusing to some
extent is that the only place we have information about the *actual* pause
settings is the "link is Up" log in dmesg.

Maybe the problem in the above situation is that whoever advertises
half-duplex only modes should also not advertise pause ?

Still, I'm wondering if we should even care about all that actually, HD and
Pause are incompatible, and that's it. If you have any thought on this, let
me know.

Maxime
