Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC041F3B85;
	Wed, 14 Oct 2026 01:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791943166; cv=none; b=lPFaqfB86jgUYPBikXh9CfHehhFA0H0ZDjX4I3AtY41J7pYZfQGnM+v+Tc5zsXxADOLJUZDk9baPgXxr2g6ePVNZTW0ha2fkUydjjVjoiOerRLor1+ZrCG5O+NMvH73kcyRaeKf81bqGXIOg6VvmAVloQyM4gelPyI8Dgl/LwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791943166; c=relaxed/simple;
	bh=Y5GtmVET3+NFTCEWBkUJ+aEirpiJfUWuliFAJ2NKF1Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DYAiPfautsqBsWALJnlEFgFZsXQWDWNZl1u7aFTd6w7gc5R2XL7E2krKl1790zoCfqSumR2rnKOGvsTC++gGVgv4TuT7XIebocAOBLf6Td5FAYbyCgeUfEoP6e+JZf0Kp+0Od7/u/4xsi0Q9jY7yMwOFiWstl6C9IYe+3AZXEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlcG4XQI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlcG4XQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B8B1F000FF;
	Wed, 14 Oct 2026 01:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791943164;
	bh=qULQnIWG9lrfi6WVnEGLXzy5s480bJZPB1bOfIfaN0E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FlcG4XQI1o1jph/ftRhXymadLGhzg5CJOmmrOClu5bwHlixe9+evc66XPvHm5EVm3
	 xFg9aSg3QFpqimyXXfKzPZRtPbsA6L1HNFFZOzVDVDQO323L7lheO053FZKZUW+e/6
	 LvgyuI2Hx7eYYJ2nC/SNZvaqBmOdS2L9kNiM5BUvGbJfJrUPtwjuyJmICPeRqa4045
	 lqNBLLgGMS2oD+lf67Vjf7nmkL8/opWJp3oaCIUcL2nA+bz1JLZdWkm7WSdrXjrZ3U
	 gWAWNxXAAEBf49yJfzixyawZ5gm2l5MlWAXpRnep+EhdLuKugftIr8M4Bbn4XxYjE8
	 vPXtv3/0Vf6Dg==
Subject: Re: [PATCH net-next v14 1/5] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 14 Oct 2026 01:59:23 +0000
Message-ID: <179194316326.434549.8782299311927798585@kernel.org>
In-Reply-To: <20261013011122.1889766-2-kyle.switch@motor-comm.com>
References: <20261013011122.1889766-2-kyle.switch@motor-comm.com>
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

- [Low] In yt92xx_register_switch() (drivers/net/dsa/motorcomm/chip.c),
  when yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid) fails, the error…
- [Low] The commit message presents the change as a pure refactor
  ('Replace the hardcoded chip handling ... with a data-driven loopup').
- [Low] yt92xx_series_lookup() is an open-coded if-chain (`major ==
  YT9215_MAJOR || major == YT9218_MAJOR`), not a table lookup.
- [Low] Naming and typing nits in the new series abstraction.
- [Low] The commit message says it replaces 'the hardcoded chip handling
  in yt92xx_register_switch()'.
- [Low] At this commit, enum yt92xx_mode defines YT92XX_MODE_YT922X and
  YT92XX_MODE_MAX, but yt92xx_series_table[] is unsized and has only the…

--

net: dsa: motorcomm: initialize dsa_switch based on chipid

This patch moves the dsa_switch field setup out of yt921x_mdio_probe()
and into a new helper, yt92xx_register_switch(). The helper reads
YT921X_CHIP_ID at probe time, maps the major number to an entry in a
new struct yt92xx_series table, and copies that entry's ops and limits
into the dsa_switch.

> Replace the hardcoded chip handling in yt92xx_register_switch() with a
> data-driven loopup based on the chip ID.

[Severity: Low]
This isn't a bug, but yt92xx_register_switch() doesn't exist before
this patch. This patch adds it.

The hardcoded assignments being replaced were in yt921x_mdio_probe().
Should the message name yt921x_mdio_probe() instead?

There's also a typo: "loopup" should be "lookup".

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 91cc5647f2b66..d4c20658216a6 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4078,6 +4078,67 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
>  	.setup			= yt921x_dsa_setup,
>  };
>  
> +static const struct yt92xx_series yt92xx_series_table[] = {
> +	[YT92XX_MODE_YT921X] = {
> +		.name = "YT921x",
> +		.max_ports = YT921X_PORT_NUM,
> +		.num_lag_ids = YT921X_LAG_NUM,
> +		.ageing_time_min = 1 * 5000,
> +		.ageing_time_max = U16_MAX * 5000,
> +		.dscp_prio_mapping_is_global = true,
> +		.assisted_learning_on_cpu_port = true,
> +		.switch_ops = &yt921x_dsa_switch_ops,
> +		.mac_ops = &yt921x_phylink_mac_ops
> +	},
> +};

[Severity: Low]
This isn't a bug, but yt92xx_series_table[] has no explicit size and
only one entry, YT92XX_MODE_YT921X. enum yt92xx_mode already defines
YT92XX_MODE_YT922X and YT92XX_MODE_MAX, so indexing the table with
YT92XX_MODE_YT922X would read past the end.

Nothing does that at this commit, because yt92xx_series_lookup() only
returns index 0. The last patch in the series also adds the
YT92XX_MODE_YT922X entry.

Would sizing the table as [YT92XX_MODE_MAX] make this clearer?

> +
> +static const struct yt92xx_series *yt92xx_series_lookup(u32 major)
> +{
> +	if (major == YT9215_MAJOR || major == YT9218_MAJOR)
> +		return &yt92xx_series_table[YT92XX_MODE_YT921X];
> +	else
> +		return NULL;
> +}

[Severity: Low]
This isn't a bug, but this if-chain classifies the major separately
from yt921x_infos[]. Those entries already carry .major, and
yt921x_chip_detect() walks them after reading YT921X_CHIP_ID a second
time:

drivers/net/dsa/motorcomm/chip.c:yt921x_chip_detect() {
    ...
	for (info = yt921x_infos; info->name; info++)
		if (info->major == major)
			break;
    ...
}

Every new chip variant has to be added in both places:

- If only yt921x_infos[] is updated, probe rejects the chip with
  -ENODEV.
- If only this if-chain is updated, probe accepts the chip and setup
  rejects it later.

The last patch in the series, "net: dsa: motorcomm: Add support for
Motorcomm YT922x", adds an "else if (major == YT9224_MAJOR)" here
instead of linking the series to the info table.

Could the series come from yt921x_infos[] instead, to match the
"data-driven lookup" in the commit message?

> +
> +static int yt92xx_register_switch(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
> +	struct device *dev = yt921x_priv_to_device(priv);
> +	const struct yt92xx_series *series;
> +	u32 chipid;
> +	u32 major;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
> +	mutex_unlock(&priv->reg_lock);
> +	if (res) {
> +		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
> +		return res;
> +	}
> +
> +	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
> +	series = yt92xx_series_lookup(major);
> +	if (!series) {
> +		dev_err(dev, "Undefined series info for the corresponding major\n");
> +		return -ENODEV;
> +	}

[Severity: Low]
Is chipid initialized when the first dev_err() runs?
yt921x_reg_mdio_read() only writes *valp after all four MDIO accesses
succeed:

drivers/net/dsa/motorcomm/chip.c:yt921x_reg_mdio_read() {
    ...
	res = __mdiobus_read(bus, addr, reg_data);
	if (res < 0)
		goto end;
	val = (val << 16) | (u16)res;

	*valp = val;
	res = 0;

end:
    ...
}

On an MDIO error, the log would show a stale stack value and describe
a bus failure as an unexpected chip ID.

The !series branch, where chipid is valid, doesn't print the ID at
all. Should the two messages be swapped, the way yt921x_chip_detect()
handles it?

The last patch in the series, "net: dsa: motorcomm: Add support for
Motorcomm YT922x", fixes this. The read-failure branch becomes a plain
return res, and the !series branch prints the chip ID. This
intermediate commit could still be hit during a bisect, so could the
fix be folded into this patch?

[ ... ]

> @@ -4146,15 +4208,10 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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

[Severity: Low]
The commit message describes this as a pure refactor. However,
yt921x_mdio_probe() now takes priv->reg_lock and does an MDIO read of
YT921X_CHIP_ID before dsa_register_switch().

Before this patch, probe only filled in static dsa_switch fields. The
first register access was yt921x_chip_detect(), reached via
yt921x_dsa_setup()->yt921x_chip_reset().

Now an MDIO error or an unknown major fails probe directly, rather
than failing in the .setup callback. The chip ID is also read twice:
once here and again in yt921x_chip_detect().

Could the commit message mention this change in behaviour?

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index 25ff77054de30..85174a51b72d6 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h
> @@ -841,9 +841,28 @@ static inline u16 yt921x_info_ports_mask(const struct yt921x_info *info)
>  	return info->internal_mask | info->xmii_mask | info->serdes_mask;
>  }
>  
> +enum yt92xx_mode {
> +	YT92XX_MODE_YT921X,
> +	YT92XX_MODE_YT922X,
> +	YT92XX_MODE_MAX,
> +};
> +
> +struct yt92xx_series {
> +	const char *name;
> +	unsigned int max_ports;
> +	unsigned int num_lag_ids;
> +	unsigned int ageing_time_min;
> +	unsigned int ageing_time_max;
> +	u32 dscp_prio_mapping_is_global;
> +	u32 assisted_learning_on_cpu_port;
> +	const struct dsa_switch_ops *switch_ops;
> +	const struct phylink_mac_ops *mac_ops;
> +};

[Severity: Low]
This isn't a bug, but a few small things about the new series
abstraction:

dscp_prio_mapping_is_global and assisted_learning_on_cpu_port are
boolean flags that get copied into bool fields of struct dsa_switch.
Should they be bool here as well?

The name field and YT92XX_MODE_MAX don't appear to be used anywhere,
either at this commit or at the end of the series.

yt92xx_register_switch() in chip.c doesn't register anything. It
reads the chip ID and fills in dsa_switch fields, and the actual
registration is the later dsa_register_switch() call in
yt921x_mdio_probe(). Would a name such as yt92xx_init_switch() fit
better?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013011122.1889766-1-kyle.switch%40motor-comm.com
