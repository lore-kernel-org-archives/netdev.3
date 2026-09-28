Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15749D5A7;
	Mon, 28 Sep 2026 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591964; cv=none; b=XDzM2gOfgSoub8kalYzWAKO3wSxclJBdQxbWCSRjsgYiB1I9FJa/B9IKmKeC8u3VW1rPsuv5QwKySMPvRC4tIMeOp6lQrjtdQ7vEzQrLnmzOcu9syh2+WrP1tKH4A6j4QCnFLz9Z4ZyazeZp4PGOPy/2mi812sMgjjoHBAufzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591964; c=relaxed/simple;
	bh=meuhmbwarLEtY6aloDViCu9YlD2eMFUfgaF7LGyQbUc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TvxfekoHYef0lnJZ6Vo08Ku/3xCiTSU8H8SnHLYqQ82WcgejO1/AL0uJnKE9I2/mrGayNoeZftck3yvF4Xx1Na8/A48cTVlW1IpTfdDESPCmLnrsrp3hMMW+tlOtMLIs7fn0VKDU9a7qTFQnLga52+ECna5yX2PTHmkpTNWalfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho8o9yAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho8o9yAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8511F00893;
	Mon, 28 Sep 2026 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790591962;
	bh=YHvfFdcCegCpoL6Oql48zsa9QXgwYshczTlXOLMUQOU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ho8o9yAKnPrptvgGaNwAIxIUUxlxq4WO51D9HMcAXe62+46E4GGGl+liIzKBusofZ
	 OGCg/ya1xZZPhN5g0kUERxDSKJ63u9TB7JeqeNZi87DsUnWIUmT+3QVyAnAAlLrQQz
	 As37QxrhlOUZVbakxLF5WrbHqFxzIu129RdewCcxJSMoUGlcf/xL8qcKRBoMP67UFL
	 OWHGK8IWJP4kkLI4U2KYZKz2SM92a8Vg7f4pjm1oqs+G1DjwNuG6fAonZw5lVjSryr
	 h4YsE2LYtH6ej66CKxQjeFHEiq7ZRGHkxJYtCuyq2cewq8szzw3vASNbCgZG1Ig+vK
	 AziKlwL6+otmg==
Subject: Re: [PATCH net-next v9 5/7] net: dsa: motorcomm: move mib stop from
 remove() to teardown()
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 28 Sep 2026 10:39:21 +0000
Message-ID: <179059196102.3145.17980521893281897493@kernel.org>
In-Reply-To: <20260924094146.4128703-6-kyle.switch@motor-comm.com>
References: <20260924094146.4128703-6-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Build failure when CONFIG_NET_DSA_YT921X_LEDS is off.

--

net: dsa: motorcomm: move mib stop from remove() to teardown()

This commit moves the loop that disables the per-port mib_read delayed
work out of yt921x_mdio_remove() and into yt921x_dsa_teardown(). The goal
is to match the MIB start, which already happens in setup().

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index d9d73bb7cb23..46f7b94469ea 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4233,6 +4233,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
>  
>  	yt921x_leds_remove(priv);
>  #endif
> +	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		disable_delayed_work_sync(&pp->mib_read);
> +	}
>  }

[Severity: Medium]
Does this build when CONFIG_NET_DSA_YT921X_LEDS is disabled?

In yt921x_dsa_teardown(), priv is only declared inside the conditional
block:

static void yt921x_dsa_teardown(struct dsa_switch *ds)
{
#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
	struct yt921x_priv *priv = to_yt921x_priv(ds);

	yt921x_leds_remove(priv);
#endif
	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
	...

The new loop comes after the #endif and uses priv in both
ARRAY_SIZE(priv->ports) and &priv->ports[i]. With LEDS=n, priv is not
declared, so this looks like it fails with "'priv' undeclared".

NET_DSA_YT921X_LEDS is an optional bool in
drivers/net/dsa/motorcomm/Kconfig:

config NET_DSA_YT921X_LEDS
	bool "LED support for Motorcomm YT9215"
	default y
	depends on NET_DSA_YT921X
	depends on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_YT921X

So it is off when LEDS_CLASS=n, when LEDS_CLASS=m with NET_DSA_YT921X=y,
or when a user turns it off. allmodconfig and allyesconfig still enable
it, so they would not catch this. Randconfig or minimal configs could.

The teardown code is still the same at the end of the series, in "net:
dsa: motorcomm: Add support for Motorcomm YT922x".

Could priv be declared before the #if, with only the yt921x_leds_remove()
call kept inside the conditional?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924094146.4128703-1-kyle.switch%40motor-comm.com
