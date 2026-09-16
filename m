Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64972CCC6;
	Wed, 16 Sep 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576216; cv=none; b=RUjtvSD7HmQJPzBDLMk7b1a14nR1vDUnOWtChCPW2U8CvNplLyJWOq2Zpczw85fm8RKyrhLi0Wwv6hhs2jvXL4K9914Wrwu0DcegZ/PuebvxdlnqXBh0lsWfLgycrA7+IlhBhLa2TmHYcMkQJSE/yhgZhUd3vooDlq1Y7Mm3XkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576216; c=relaxed/simple;
	bh=sGiTelZ8OoI/amW+vQ4NIDYdQzpBlTZoEjy21unroFU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lvv6ir9fojkYxgttKZftUUjE/Agl1R5brVl90T/1+ZsA2oyWo1JazeLLds6iRQvC+x9WPeCtsSmLSy7Lr3R4XnCEDs8RCB8qQnXWDce26zKjcGvr1LefI9iAXuhbulSL1YMqS/9PltO3zgMFfdRHHqDgRflwn9TBrGNsc6ZAfHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFAMfHRO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFAMfHRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571E01F00898;
	Wed, 16 Sep 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576213;
	bh=c3/W4xtXPr5NZ3GUQS/5YoBtq53mM1hZAG3w+2jzQPM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UFAMfHROp7a6czLavnIeKJF9LICpkc1gLQVQsZv7CeVgTh9xzJ6ND3rG9tG6nvGOB
	 KrsO+A/JrYI27Ewkafq8bqENFNLhGnAm4GTIx0Ccm3A/7jH41l0jZv5zz1zvYCp166
	 xEoQibZJDvT1l1b9oZIMXc/GMr4A+5egnXX6wlbCBw3vZ/ZJxaFp7IznUPfly8z7Zk
	 IQhbfPCrNkNdF40y1YUHzJobI3EQNRl8wnSM8/+Y7gxpIGiO+mtZ99taMooxl6OCIj
	 VxWhhfSpWFZi//GxBGrCFHpTCm27F0Q6INmGUqFX32cTFXSN6z240bWtSGZYVRWEvX
	 41AQY4cSZnxjQ==
Subject: Re: [PATCH net-next v7 2/6] net: dsa: motorcomm: use max_ports in
 series for port bounds checking
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Wed, 16 Sep 2026 16:30:11 +0000
Message-ID: <178957621190.22033.8646286734982219326@kernel.org>
In-Reply-To: <20260914103009.3007019-3-kyle.switch@motor-comm.com>
References: <20260914103009.3007019-3-kyle.switch@motor-comm.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] yt92xx_register_switch()
  (drivers/net/dsa/motorcomm/chip.c:4707-4737) calls…

--

net: dsa: motorcomm: use max_ports in series for port bounds checking

This replaces the hardcoded YT921X_PORT_NUM in the internal MDIO bus port
checks and in the phy_mask computation with priv->series->max_ports, so the
common code no longer carries a family-specific port count.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 1f9c0c67ad4a6..4479bb1c3c2b1 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -390,6 +390,7 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
>  {
>  	struct device *dev = to_device(priv);
>  	struct mii_bus *mbus;
> +	u32 max_ports;
>  	int res;
>  
>  	mbus = devm_mdiobus_alloc(dev);
> @@ -402,7 +403,8 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
>  	mbus->read = yt921x_mbus_int_read;
>  	mbus->write = yt921x_mbus_int_write;
>  	mbus->parent = dev;
> -	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
> +	max_ports = priv->series->max_ports;
> +	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);

[Severity: Medium]

These new users of priv->series depend on the chip-ID read that fills it in,
and that read looks like it now runs without priv->reg_lock held.

In yt92xx_register_switch():

	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
	if (res)
		return res;

	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
	series = yt92xx_series_lookup(major);

and in drivers/net/dsa/motorcomm/smi.c:

	int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
	{
		lockdep_assert_held_once(&priv->reg_lock);

		return priv->reg_ops->read(priv->reg_ctx, reg, valp);
	}

Does this trip the lockdep assertion on every probe with
CONFIG_PROVE_LOCKING enabled?  The only caller is yt921x_mdio_probe(), which
does mutex_init(&priv->reg_lock) before yt92xx_register_switch(ds) but never
takes it, so the multi-transaction SMI access also runs outside the mutex
that chip.h describes as "protect the access to the switch registers".

Before this series the chip-ID read happened under the lock, via
yt921x_dsa_setup():

	mutex_lock(&priv->reg_lock);
	res = yt921x_chip_reset(priv);
	mutex_unlock(&priv->reg_lock);

which reached yt921x_chip_detect().  The move into the unlocked probe path
came with "net: dsa: motorcomm: initialize dsa_switch based on chipid", and
the end of the series still has no mutex_lock() in
yt92xx_register_switch().

Would wrapping the yt921x_reg_read() in yt92xx_register_switch() with
mutex_lock(&priv->reg_lock)/mutex_unlock(&priv->reg_lock) be the intended
fix here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914103009.3007019-1-kyle.switch%40motor-comm.com
