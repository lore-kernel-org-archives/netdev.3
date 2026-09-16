Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE054DAF6;
	Wed, 16 Sep 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576215; cv=none; b=GI5b7krg1HmW2mslj0CQFmXKT9xxFi7EJ2dBqGhXwRhaLcDfCEeDyNDBAjk5GUfivWhk69ik5vsnlCn6tEQ0utZFegxXuUPCjMcjWT/6lTC1tiDV7FRiArIe5frC1qM5JSRKLYL/YDHJyxTkFPYMkR+hDgf7wCxpz0PguFcLRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576215; c=relaxed/simple;
	bh=55d/pcyCcHF4gxk0xJ2LsmaxlyV0ABFiU+37I5hkB4M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uef0VNxeH9OdmIAi8KoV/9hV1nD3Xk4+MHsI1UJCchSAoiG5F4yYsxE4+MhtSB2IaDMHZ7+PBhQuLrDEDWDmoA/eEn+bfZN1RUjnttefKteaGac/2aGM7Yuv75FVw6REz3slu9oLB6N7bKKqCLeAgZCBNzrB8Fnbw93DBobE+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuAUAcFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuAUAcFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF351F000FF;
	Wed, 16 Sep 2026 16:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576211;
	bh=sKkdoauSjwbYK2sCszy712nKnIfOBGl5NL57FiBKlF0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XuAUAcFoisZ6tCLBdw5mow4dRoWkbE9f1H2CTaC4MzBFWPEhu9l5nUV/+s2pgv33P
	 5wF4SKxtB8peQ6V/aVhTs9/JIaaLaEgr2ZpO1iTvpV6JyIhLdXkXtvkyNWI7ZpmwRn
	 dNuTKAMcM9nXGVOu/t+0EkA2D4SDyLCecifKIMjkh0DGFvn9kdN3We3vdL5kpG7lKK
	 hNSxdqXWjQxMAogZhBlIPpORvLz/0x0OB0DyZRuJVH4LBv+6AVXDbc5XplfBgdkbCz
	 SPSfS2sQ/HqWrfwTCs0yOfPF67fDG0jDyLVb7BsqjLzxlet6O/BYghog+0rGCoYBf2
	 E1zqpjeHMVG3g==
Subject: Re: [PATCH net-next v7 1/6] net: dsa: motorcomm: initialize
 dsa_switch based on chipid
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 16 Sep 2026 16:30:10 +0000
Message-ID: <178957621044.22033.16572110500662086613@kernel.org>
In-Reply-To: <20260914103009.3007019-2-kyle.switch@motor-comm.com>
References: <20260914103009.3007019-2-kyle.switch@motor-comm.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] drivers/net/dsa/motorcomm/chip.c: the newly added
  yt92xx_register_switch() calls yt921x_reg_read(priv, YT921X_CHIP_ID,…

--

net: dsa: motorcomm: initialize dsa_switch based on chipid

This adds a yt92xx_series descriptor table and a new
yt92xx_register_switch() helper that reads the chip ID, looks up the
matching series and fills in the dsa_switch fields, replacing the
hardcoded assignments previously done in yt921x_mdio_probe().

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index d663af010f431..1f9c0c67ad4a6 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -4679,6 +4679,61 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
>  	.setup			= yt921x_dsa_setup,
>  };
>
> +static const struct yt92xx_series yt92xx_series_table[] = {

[ ... ]

> +static int yt92xx_register_switch(struct dsa_switch *ds)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	const struct yt92xx_series *series;
> +	u32 chipid;
> +	u32 major;
> +	int res;
> +
> +	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
> +	if (res)
> +		return res;

[Severity: High]

Should this read be done with priv->reg_lock held?

yt921x_reg_read() asserts the lock in drivers/net/dsa/motorcomm/smi.c:

int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
{
	lockdep_assert_held_once(&priv->reg_lock);

	return priv->reg_ops->read(priv->reg_ctx, reg, valp);
}

yt921x_mdio_probe() only calls mutex_init(&priv->reg_lock) before invoking
yt92xx_register_switch(), so the lock is never taken on this path.  With
CONFIG_PROVE_LOCKING enabled, doesn't that make every probe of this driver
emit a WARN_ON_ONCE splat (and panic when booted with panic_on_warn)?

Every other register access in the driver takes the mutex first, for
example yt921x_dsa_setup():

	mutex_lock(&priv->reg_lock);
	res = yt921x_chip_reset(priv);
	mutex_unlock(&priv->reg_lock);

and the comment on the field in chip.h describes it as protecting the
register access:

	/* protect the access to the switch registers */
	struct mutex reg_lock;

Since probe context can sleep, would wrapping the YT921X_CHIP_ID read in
mutex_lock()/mutex_unlock(&priv->reg_lock) be the intended fix?

> +
> +	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
> +	series = yt92xx_series_lookup(major);
> +	if (!series)
> +		return -ENODEV;
> +	priv->series = series;

[ ... ]

> @@ -4754,15 +4810,10 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
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
>
>  	mdiodev_set_drvdata(mdiodev, priv);

[ ... ]

One more note on this: checking the tip of the series (the commit adding
support for Motorcomm YT922x), yt92xx_register_switch() still performs the
chip ID read without taking priv->reg_lock and is still called from probe,
so this does not appear to be addressed by a later patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914103009.3007019-1-kyle.switch%40motor-comm.com
