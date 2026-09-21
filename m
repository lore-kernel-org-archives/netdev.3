Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F97457E4D;
	Mon, 21 Sep 2026 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983328; cv=none; b=f68NZuR8U+UhfFP6mtCVdFRlNB3M1t4zdC5vLVePGLQh0Ga96XGWyfcRY2fPa3v7hzSRVIYUGsY3CV0l5GmGlUbSArLTBv5LZA8ncUFyfaQaovLMdQ38JI3X+yy6j48vx/x2afKgvHj9eEbJCbFAFHzQZO77+Xb6dxR21ywbt4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983328; c=relaxed/simple;
	bh=JF0kf7yPAsUNaWCZGHfckgGK+MrCki5BBMCcEMu6IJg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRszS/ByyGC5agh62RxUZmnf0bA7H4Na94RepJGKgWCIeQr3WIL3SWo7s7yK7/PsKCuOxBiBIC3hzAb48Q5IWJGt6C7bY7EFU0ZWi8AKITmys9OZJtWqHneE2G0O5P+WAAqf76nAv2CUUhlc69ZAw6xBkrKLw3a8g/XVBwDnOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXXg1Bqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXXg1Bqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1900A1F000FF;
	Mon, 21 Sep 2026 09:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983326;
	bh=9TGLApvjjaAlrtjchM+h0TYabCU0KzSONu63sREyAuc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nXXg1Bqc6GPsROTDiQdhSLDJ08ZAI8p5ORNv2iJz9e2vLlsLZMRvrKrMV3rq6HFhp
	 owDrFldAGM+bcNnyLC8j/SDDbvhIEEapU+/0In/tLi0Twl5uOxHQ6FpBVOKhjV2fe/
	 J/4QGqW6odpqc2o1WYHyx4Cl7xKbXAG6FruTVRCdUeUT4df3mWSEEIDJnMMmcK1gza
	 wyqeLV6BtC2xqpp8N6nwfioeCteeHJt1XeTrNxl4+tn3t+FQ9MQ5YMC6swYCluEsus
	 3YSTRUQKO0dOWWFm14exm3YGIYCFczbxN0QFPDcb5Sm6d3DkyollgjcVY2nEJnTelp
	 6ZknlK7Suwo0w==
Subject: Re: [PATCH net-next v8 1/6] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 21 Sep 2026 09:35:24 +0000
Message-ID: <178998332458.2160803.2420489002220802587@kernel.org>
In-Reply-To: <20260917082236.3427168-2-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-2-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] yt92xx_register_switch() (drivers/net/dsa/motorcomm/chip.c:4705)
  adds a live MDIO transaction and a new, completely silent probe abort…

--

net: dsa: motorcomm: initialize dsa_switch based on chipid

This adds a yt92xx_series table describing per-family dsa_switch
parameters, and a new yt92xx_register_switch() helper that reads the chip
ID and fills in ds fields from the matching table entry.  The previously
hardcoded assignments in yt921x_mdio_probe() are removed.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index d663af010f431..564e45ece22cb 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> +static int yt92xx_register_switch(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	const struct yt92xx_series *series;
> +	u32 chipid;
> +	u32 major;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res)
> +		return res;
> +
> +	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
> +	series = yt92xx_series_lookup(major);
> +	if (!series)
> +		return -ENODEV;

[Severity: Low]
Should this path print something when the chip ID is not recognised?

Before this patch the first register access happened later, in
yt921x_dsa_setup() -> yt921x_chip_detect(), which logs the value it read
before giving up:

drivers/net/dsa/motorcomm/chip.c:yt921x_chip_detect() {
	...
	if (!info->name) {
		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
		return -ENODEV;
	}
	...
}

Here yt92xx_register_switch() returns a bare -ENODEV when
yt92xx_series_lookup() does not match YT9215_MAJOR or YT9218_MAJOR, and a
bare bus errno when yt921x_reg_read() of YT921X_CHIP_ID fails.  Since
really_probe() only pr_debug()s an -ENODEV/-ENXIO return, a board with an
unsupported or non-responding switch would end up with no message in dmesg
explaining why the DSA switch never appeared.  Would a dev_err() with the
chipid here keep the previous diagnostics?

Related: the commit message says the change is about

    "replacing hardcoded logic in probe()"

which reads as a pure data-driven refactor.  Could it also mention that
probe() now performs an MDIO read of YT921X_CHIP_ID and can fail early
because of it?  That is a behavioural change for probe(), which previously
had no hardware dependency.

> +	priv->series = series;
> +
> +	ds->assisted_learning_on_cpu_port =
> +		priv->series->assisted_learning_on_cpu_port;
> +	ds->dscp_prio_mapping_is_global =
> +		priv->series->dscp_prio_mapping_is_global;
> +	ds->ageing_time_min = priv->series->ageing_time_min;
> +	ds->ageing_time_max = priv->series->ageing_time_max;
> +	ds->num_lag_ids = priv->series->num_lag_ids;
> +	ds->num_ports = priv->series->max_ports;
> +	ds->ops = priv->series->switch_ops;
> +	ds->phylink_mac_ops = priv->series->mac_ops;
> +
> +	return 0;
> +}

[ ... ]

> @@ -4754,15 +4812,10 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
>  
>  	ds = &priv->ds;
>  	ds->dev = dev;
> -	ds->assisted_learning_on_cpu_port = true;
> -	ds->dscp_prio_mapping_is_global = true;
>  	ds->priv = priv;
> -	ds->ops = &yt921x_dsa_switch_ops;
> -	ds->ageing_time_min = 1 * 5000;
> -	ds->ageing_time_max = U16_MAX * 5000;
> -	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
> -	ds->num_lag_ids = YT921X_LAG_NUM;
> -	ds->num_ports = YT921X_PORT_NUM;
> +	res = yt92xx_register_switch(ds);
> +	if (res)
> +		return res;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917082236.3427168-1-kyle.switch%40motor-comm.com
