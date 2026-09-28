Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69C3C1963;
	Mon, 28 Sep 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591959; cv=none; b=mbLWcWN+0CG+T5bZJmavFUJ+DI+kykJOfauye/2X2Qp1BVQ/3mP4X9GasdYCDa9sP+YWPo4stdIHQPNN8LJ79OEDP9KAva6HthEB80Ng2Is+KFc3e1AtSHhVnpYp49PFYhjQY1aG9zdKsVNvLXuk8eRxtAZoPM0a8IoHfi7KGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591959; c=relaxed/simple;
	bh=ADPtp/Oc5lFEs5dMRUsEbgt+WzHkpAzmiaSLVBI1fv4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M3Dx7xdboDpA4EfDQ6XMvFMglNrXVi2QBmZ20Zg8V9+5q5T1Y2mBMLncvr7nW1uQJqZBoQvqgW+zcPFthL/runawUaUuL3of9lxBtDjPhJC4eubGx6htaCaAy9ZCoGd4MmksJkq84V5QnWVY5gAfxRGgY60Q2wVWy7kwdkd365M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZATl2RjT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZATl2RjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1301A1F000FF;
	Mon, 28 Sep 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790591957;
	bh=dU1fO+8ko1Hu02NqAiEeZAWbKqbgBCGb6F+NzyW7M9g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZATl2RjTwXvLcaTNOGWny+ArqZsNwW3PMO67MhIFMltO05ZZqqR9DMm+5YRkyCPJk
	 v4YpAT+LNa/WPTgYUnYB0nVzf7dwQpw01WCIJJGbvAvMe+4j+zsWHsBk6PHjqcdzQq
	 oq/LnHBErSu/QJQrCT37yuHQyoGH/a0V7D4pH9W6YKekRlZkfI/3dmA0imtPjXtawo
	 ZGm6zeeQhFDhdlf0svZAIR9EEHaxoGahBnoeHKF1TTbOVJ/hT6u88jH0rHCaV+vzvO
	 4YrKKr4lsdAusKJo31/iNM8Ct2GvLKcTa96wGkM91yeG8dUnQpiktbo+HO4iWjvgUD
	 6qlt62VaFBswQ==
Subject: Re: [PATCH net-next v9 1/7] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 28 Sep 2026 10:39:16 +0000
Message-ID: <179059195658.3145.7289429681974059958@kernel.org>
In-Reply-To: <20260924094146.4128703-2-kyle.switch@motor-comm.com>
References: <20260924094146.4128703-2-kyle.switch@motor-comm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] yt92xx_register_switch() in drivers/net/dsa/motorcomm/chip.c
  declares `u32 chipid;` with no initializer.
- [Low] The commit message does not match the patch.
- [Low] At this commit, enum yt92xx_mode declares YT92XX_MODE_YT922X and
  YT92XX_MODE_MAX, but yt92xx_series_table[] fills only…
- [Low] yt921x_mdio_probe() calls mutex_init(&priv->reg_lock)
  (chip.c:4806) and now returns early if yt92xx_register_switch() fails…

--

net: dsa: motorcomm: initialize dsa_switch based on chipid

This patch moves the dsa_switch setup out of yt921x_mdio_probe() into a
new yt92xx_register_switch() helper. The helper reads the chip ID at probe
time and fills in the dsa_switch fields from a per-series table entry.

> Replace the hardcoded chip handling in yt92xx_register_switch() with a
> data-driven loopup based on the chip ID.

[Severity: Low]
Is this description accurate? yt92xx_register_switch() is added by this
patch. The hardcoded ds-> assignments it removes were in
yt921x_mdio_probe().

There's also a typo: "loopup" should be "lookup".

The lookup is also not really data-driven. yt92xx_series_lookup() writes
the majors into an if-statement:

    if (major == YT9215_MAJOR || major == YT9218_MAJOR)
        return &yt92xx_series_table[YT92XX_MODE_YT921X];

yt921x_mdio_probe() now reads YT921X_CHIP_ID over MDIO. It can fail with
an I/O error or -ENODEV before dsa_register_switch() is reached. Before
this patch, the chip ID was only read later, from yt921x_chip_detect() in
the DSA setup path. Could the message mention this change?

It could also say this is groundwork for YT922X, since nothing in this
patch uses YT92XX_MODE_YT922X or YT92XX_MODE_MAX.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 8b0ac5fc8c8b..d4a565994940 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4679,6 +4679,68 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {

[ ... ]

> +static int yt92xx_register_switch(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
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

[Severity: Medium]
Can chipid be uninitialized when it is printed here? yt921x_reg_read()
ends up in yt921x_reg_mdio_read(), which stores to *valp only on success:

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

If any of the MDIO accesses fail, this prints leftover stack contents as
the chip ID, and a bus failure looks like an ID mismatch.

The message seems to come from yt921x_chip_detect(). There it is printed
only after a successful read with an unknown major:

drivers/net/dsa/motorcomm/chip.c:yt921x_chip_detect() {
    ...
	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
	if (res)
		return res;
    ...
	if (!info->name) {
		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
		return -ENODEV;
	}
    ...
}

Should the read failure get its own message? The chip ID could then be
printed in the unknown-major branch below, which currently leaves it out.

This code is unchanged at the end of the series, in "net: dsa: motorcomm:
Add support for Motorcomm YT922x".

> +		return res;
> +	}
> +
> +	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
> +	series = yt92xx_series_lookup(major);
> +	if (!series) {
> +		dev_err(dev, "Undefined series info for the corresponding major\n");
> +		return -ENODEV;
> +	}

[ ... ]

> @@ -4754,15 +4817,10 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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
This isn't a bug, but this new early return comes after
mutex_init(&priv->reg_lock) and skips mutex_destroy(). The only
mutex_destroy() call is in yt921x_mdio_remove(), which doesn't run when
probe fails.

Nothing leaks. priv is devm allocated, and mutex_destroy() only poisons
the magic field when CONFIG_DEBUG_MUTEXES is set. The existing
dsa_register_switch() failure path already skips it too.

Is it worth adding mutex_destroy() to the probe error paths for symmetry?

[ ... ]

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index 83cd454955dd..c446aea449ed 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h
> @@ -960,9 +960,29 @@ struct yt921x_reg_ops {
>  	int (*write)(void *context, u32 reg, u32 val);
>  };
>  
> +enum yt92xx_mode {
> +	YT92XX_MODE_YT921X,
> +	YT92XX_MODE_YT922X,
> +	YT92XX_MODE_MAX,
> +};
> +
> +struct yt92xx_series {
> +	enum yt92xx_mode mode;
> +	const char *name;

[Severity: Low]
At this commit, yt92xx_series_table[] fills only [YT92XX_MODE_YT921X].
There is no table entry for YT92XX_MODE_YT922X, and no BUILD_BUG_ON ties
the table size to YT92XX_MODE_MAX. The later patch "net: dsa: motorcomm:
Add support for Motorcomm YT922x" adds the YT922X entry, so this part is
resolved by the end of the series.

Are the mode and name fields needed? Nothing reads series->mode or
series->name, even at the end of the series. The name field also
duplicates yt921x_info.name, which is the name that gets printed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924094146.4128703-1-kyle.switch%40motor-comm.com
