Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C337F32F;
	Wed, 23 Sep 2026 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159061; cv=none; b=bA6GlzMOH0cbrIOYh9pKjD52TFYuWmY48TVl4UZ/B3CpwiRvSDasX1c/k2FLTiVnf6ZppudNpVdz6oxBB1uXVf6iKrA4zP9VKLCqtxZzicqiXS+DolF6e61O+quHuCbhkW9ofXpDqMd6elYGpK8fmAvWm9apgzTMJrkDAC6whWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159061; c=relaxed/simple;
	bh=S474P7HbP/fO8M0Y8lxNVQlbG1trsGbWHCqeuglkRL8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=QQTc4ecpnkDkPKQYUu0QCHdFYBmicHpfxVycoT7dWwaaAQiMx9mltkJYbZRNgzZ2K8ssb2Nt3nItuWy6QN8LQEb64C/iCGfgTJA7uAKHbbrGs1SAjrIDVi4v25fb+GjceZY7LCBA44tZbB3qVYEG9ucRv2OJl3xiPVZufWPHB5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=y6zvexnF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="y6zvexnF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 487EFA4A35;
	Wed, 23 Sep 2026 12:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790159043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OhyAe01gH5uSFkKcaGnj2dUBeWhWIdjzaBUO0Eskhcs=;
	b=y6zvexnFoi2qGiCGGSgpcHJcbAbdHIiCqfDN6N+9XclxpLvqlTgzU21xlQq2lgddEexm1B
	okqHdxAEPY4HS5cekCBnROeHBDVX4Sf6j5JW7s1vxrmufR0DWZ92mysMP4YD52UP/jX+hc
	Ea8psXAAUlfWk8tD0qu+g12YXQYcyAZpOeleLUxyoYuMWBDsmPQDPivlyCUecE+wo4yfW3
	mSvzXAVwI0z1sIGui/fp/TaZcFXrhzA733GUlCPhorr2jFhtw33Nht6RA721KXaJZgt51y
	3ygLsQV5dW9Clv+USyrFmNex2ocnBA7RPZ4DV5/ICICcqGd9OvV7Q/3B1EWR2A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Sep 2026 12:24:00 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 kory.maincent@bootlin.com, jjc@jclark.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethtool: let tsconfig reach a PHY-only timestamp
 provider
In-Reply-To: <179015820246.2160803.17295463468229392731@kernel.org>
References: <20260922070813.1458713-1-nb@tipi-net.de>
 <179015820246.2160803.17295463468229392731@kernel.org>
Message-ID: <7a817f1e561fb387b0e01784ac4632f8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 23.9.2026 12:10, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let 
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your 
> reply
> (one such reply per series is enough).
> 
> - [High] TSCONFIG_SET now reports success (bare ACK, ret 0) with no
>   ETHTOOL_MSG_TSCONFIG_SET_REPLY on devices that have no hardware…
> - [Medium] With ethnl_set_tsconfig_validate() gone, 
> ethnl_set_tsconfig()
>   is reachable on netdevs that implement neither ndo_hwtstamp_get nor…
> - [Medium] net: ethtool: TSCONFIG_SET provider switch fails on devices
>   lacking ndo_hwtstamp_set
> 
> Pre-existing issues:
> - [Medium] A struct hwtstamp_provider installed into dev->hwprov by
>   TSCONFIG_SET is never freed when the netdevice is unregistered/freed…
> 
> --
> 
> net: ethtool: let tsconfig reach a PHY-only timestamp provider
> 
> This drops the ndo_hwtstamp_get check in tsconfig_prepare_data() and 
> the
> whole ethnl_set_tsconfig_validate() gate so that TSCONFIG_GET/SET can 
> be
> served by a PHY on a MAC that implements no hwtstamp NDO. A guard is 
> added
> in dev_get_hwtstamp_phylib() before calling ndo_hwtstamp_get.
> 
> Related discussion for the ioctl side:
> https://lore.kernel.org/netdev/20260918095540.34286-1-nb@tipi-net.de/
> 
>> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
>> index 164643140a523..f6029f60c1dc9 100644
>> --- a/net/core/dev_ioctl.c
>> +++ b/net/core/dev_ioctl.c
>> @@ -267,7 +267,8 @@ int dev_get_hwtstamp_phylib(struct net_device 
>> *dev,
>>  		    hwprov->phydev)
>>  			return phy_hwtstamp_get(hwprov->phydev, cfg);
>> 
>> -		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV)
>> +		if (hwprov->source == HWTSTAMP_SOURCE_NETDEV &&
>> +		    dev->netdev_ops->ndo_hwtstamp_get)
>>  			return dev->netdev_ops->ndo_hwtstamp_get(dev, cfg);
>> 
>>  		return -EOPNOTSUPP;
> 
> [Severity: Medium]
> This guard makes the read side safe, but can the install side now latch 
> a
> HWTSTAMP_SOURCE_NETDEV provider on a device that has no hwtstamp NDOs 
> at
> all, with no way back?

Ack, I will guard the install path in v2.

> [...]

> [Severity: Medium]
> With ethnl_set_tsconfig_validate() gone, a TSCONFIG_SET that selects
> the PHY provider now reaches ethnl_set_tsconfig() on a MAC without
> hwtstamp NDOs. Does the provider switch itself ever succeed there
> unless the PHY happens to be the default timestamper?

Will add a check in v2.

> [...]

> [Severity: High]
> Does removing this gate turn TSCONFIG_SET into a silent success on 
> devices
> that have no timestamp provider at all?

Ack, this is an ungly regression and would be the opposite of what 
e8ab231782e9
had fixed. I will narrow down the gate.

> [...]

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the dev->hwprov lifetime
> looks unbalanced and dropping .set_validate widens the set of devices 
> that
> can reach the install path.

Agree on the issue, but would probably fix this in a separate patch.

> [...]

pw-bot: cr
