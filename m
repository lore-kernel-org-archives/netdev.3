Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CA4399F2;
	Wed, 23 Sep 2026 05:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142089; cv=none; b=DgqogTMDh3A2xlksh/Q7qXJTgSSZ9Ue0eX62sj9tUU3Gtv1fZzhRlmaOjFqXO4UtIEGJbr/8+OnCVB04vGEIvagpa3Dt+934WLm4UNkeawB6gWHjXxWFZmbMqNVr6fv++7jbhsck/Irit4g9OmBYzZRvh7ca2ZHEQfCqu51I7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142089; c=relaxed/simple;
	bh=eSvJdkusqH3MW1fUZuDUXVeBnN1E/YImKbhZxQ6S3AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FdDx7E9xzCLYbUk5jKjYTqBcboIpnemvkq7nxZApAYN0zPHg9FMyf3voK/YSOAfgonSLjObfCouXGWE+0axCENRuFvi8DVS1aXgvvyZ1sJL0xiJAHeLnccRWzLpc/Rw1ts+Otalf7azG8kfeO8awOwa9XBul16Ggfb8MTwVwgZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ryc0HCIj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ryc0HCIj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 852A04E41045;
	Wed, 23 Sep 2026 05:41:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5073660580;
	Wed, 23 Sep 2026 05:41:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8F611032927D;
	Wed, 23 Sep 2026 07:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790142082; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZpZCDlqUEb2SWrd5zVY2l2rTE4AF+AN3fDWZMuJ/UdI=;
	b=Ryc0HCIjIT+K5hW4vLbaj6V3LpVeU0rlxM05KqcuO6j6XPccnVZE4CwfA28ShGI9WxQ24y
	J/tuACNakOlD8gfzriPCP7oUn8NUSPkC4MxbgwyfAmBpozslQO+IobOYmSoQke9WDeFswP
	GFycukPqbi/41e8g6TQkzU5OjE8aITMzRLlsZQi4EekS54hLasgqGebQfArae9nueICTEX
	LqG42Mesdzneu7baTt/0yKQC7WoBrS2kpqyi90AR+kZUFMqkmxSfHEiLj++7C5uprEucM6
	oqmF5OW6NG7E3QFP+QhsaqmVsgrgB5Q2onz1LF/tvTpD2/8QyXytie3AW8BiPA==
Message-ID: <72bdfa09-34ea-43ab-88ad-b3c64c7e1f70@bootlin.com>
Date: Wed, 23 Sep 2026 07:41:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: Introduce a selftest for
 ethtool flow control
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
 <20260920164732.349744-2-maxime.chevallier@bootlin.com>
 <20260922194251.06e00e2e@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260922194251.06e00e2e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 9/23/26 04:42, Jakub Kicinski wrote:
> On Sun, 20 Sep 2026 18:47:27 +0200 Maxime Chevallier (Netdev
> Foundation) wrote:
>> Future ethtool selftests are expected to use the same, these helpers
>> are put in the net selftest lib.
> 
> Please resist the urge to create libraries.
> 
> If you're doing this I suspect you didn't even read the README and 
> you expect people to search around for libraries?

I did read the README and fought the urge, that was something Andrew
was asking for in the previous round :( I'm ok with either TBH.

> 
> Put the code in your test, the duplication doesn't matter.
> If you _absolutely have to_ you can create a local lib under
> tools/testing/selftests/drivers/net/hw/ but please think really 
> hard before you do.
> 
>> +    :param cfg: test config
> 
> If you have nothing to say - don't say anything 🤷️
> 
>> +    :returns: tuple containing :
>> +              - return code of the ethtool command,
>> +              - rx status,
>> +              - tx status,
>> +              - aneg status
> 
> Have you seen much code in netdev selftests using this style 
> of comments?

Hmm that's a leftover from the previous round that was pretty much only
coments, I can trim that down.

> 
>> +        defer(cmd, f"ethtool -s {cfg.ifname} autoneg on", fail=False)
> 
> Why are you putting fail=False on the defers? IIRC defer errors are
> logged and ignored. Is ethtool reporting an error when there's nothing
> to change?

IIRC I had the issue when running that on a USB dongle, it's likely this
is something I put there and actually forgot to remove after finding a
better solution :(

> 
> Those are just some things that immediately jump out :)
> Please also fix the pylint --disable=R issues?

Sure no problem,

Thanks a lot for taking a look,

Maxime
