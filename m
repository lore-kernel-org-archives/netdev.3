Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4A84AA405;
	Wed,  2 Sep 2026 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366427; cv=none; b=RZkC3Ugn3RcvAYvmNaOfqWIuydkzQOfIIWlATGnLr0D5fJHFgDd1yut5v9z9HbIlLpWTYgPWWlmHaKbV+atWpMfb2g8fTyybJO17HmCeIQR9JfX7GrzfNaQBoYPo2lFBsn3ujmvG7MxJH/KtZKlep19CoOghlTJarQiEWDwcas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366427; c=relaxed/simple;
	bh=LbJkjMc9OWu8NEWCkTSK4PK2J88EHPokD0KOkxcdtqI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNQ+9fcIGenR6/q8eUoP2Qw0xss0aoBeOYpCI61vBLLtk0+TyDX1UjrFuyP9LcgvbHmvLT8w5DeaS3+H49WsR5IqtDIf66fQ5Me0Mfepg78Fv2FvYBzbIO5sBbeeBdj7L/a/f0QPnb+fFyoUwjXIPex1qcODCnHR95BIhyoSpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5H5CkK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5H5CkK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D901F000E9;
	Wed,  2 Sep 2026 16:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366425;
	bh=FNU6wx2t8Q/gdmEZLPAAB2H/l4yYPB5/4pAKLx1yL0E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I5H5CkK+qLh3rD6mWGn3MlZ4MBRcM+JGewZ8NedprDNKjaOGUBDo1kRRkjo4MEL+A
	 3LVb44U5rOHSPVH9e9J0/qi218J8EGuuwmeYS6/0zx+prxghFrWMre69hmV0ukwqxz
	 QIZ/d5C6cE0jCr4gvpDFl+94TS+qMsDUza3fACfOUbMXrZFbY/R5GDWSidpL6zSBC3
	 J+qJZxzGj+E7tULV4SpINQoxgf8TniEwshYiVPYASlnnN9uzjPb8yZ59hFGdBJsQ4w
	 zHIIoeTrrbtsSBt4mC8hUjM37kmlQxT9AN0nFtx1MxduB/xsbW0+hlRMeJ61PaoXfj
	 ayUK9G6VYRexQ==
Subject: Re: [net-next,04/10] net: dsa: microchip: extract PTP callbacks
 configuration from PTP registration
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 16:27:04 +0000
Message-ID: <178836642457.3394541.16128103885196286846@kernel.org>
In-Reply-To: <20260831-ksz-perout-v1-4-14202db763b3@bootlin.com>
References: <20260831-ksz-perout-v1-4-14202db763b3@bootlin.com>
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

- [High] Per-chip PTP capability fields `n_pins`/`n_per_out` are only
  populated for KSZ8563 (and, at the end of the series, KSZ8463), so…

--

net: dsa: microchip: extract PTP callbacks configuration from PTP registration

This moves the ptp_clock_info fields assignment out of
ksz_ptp_clock_register() into a new ksz_ptp_set_caps(), and calls the new
helper from each of the ksz8463/ksz8/ksz9477/lan937x setup paths before
registering the PTP clock.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 7bf83e0b59185..ea22601f6b26b 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -1028,17 +1028,12 @@ static int ksz_ptp_start_clock(struct ksz_device *dev)
>  	return 0;
>  }
>  
> -int ksz_ptp_clock_register(struct dsa_switch *ds)
> +void ksz_ptp_set_caps(struct dsa_switch *ds)
>  {
>  	struct ksz_device *dev = ds->priv;
> -	const u16 *regs = dev->info->regs;
>  	struct ksz_ptp_data *ptp_data;
> -	int ret;
> -	u8 i;
>  
>  	ptp_data = &dev->ptp_data;
> -	mutex_init(&ptp_data->lock);
> -	spin_lock_init(&ptp_data->clock_lock);
>  
>  	ptp_data->caps.owner		= THIS_MODULE;
>  	snprintf(ptp_data->caps.name, 16, "Microchip Clock");
> @@ -1052,6 +1047,19 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
>  	ptp_data->caps.verify		= ksz_ptp_verify_pin;
>  	ptp_data->caps.n_pins		= dev->info->n_pins;
>  	ptp_data->caps.n_per_out	= dev->info->n_per_out;

[Severity: High]
Are the per-chip n_pins and n_per_out values actually populated for all
PTP capable switches?  ksz_ptp_set_caps() publishes dev->info->n_pins and
dev->info->n_per_out directly, but in ksz_common.c only the [KSZ8563]
entry initializes them:

	[KSZ8563] = {
		...
		.ptp_capable = true,
		...
		.n_pins = 2,
		.n_per_out = 3,

The other .ptp_capable = true entries ([KSZ9477], [KSZ9563], [KSZ8567],
[KSZ9567], [LAN9370], [LAN9371], [LAN9372], [LAN9373], [LAN9374]) leave
both fields at 0.

Before this rework the code hardcoded caps.n_pins = KSZ_PTP_N_GPIO (2) and
caps.n_per_out = 3 for every one of these chips, so does this leave them
advertising zero pins and zero periodic output channels?

With n_per_out == 0, ptp_chardev.c rejects every request:

	if (perout->index >= ops->n_per_out)
		return -EINVAL;

and with n_pins == 0 both PTP_PIN_SETFUNC and PTP_PIN_GETFUNC take the
same path:

	if (pd.index >= ops->n_pins)
		return -EINVAL;

> +}
> +
> +int ksz_ptp_clock_register(struct dsa_switch *ds)
> +{
> +	struct ksz_device *dev = ds->priv;
> +	const u16 *regs = dev->info->regs;
> +	struct ksz_ptp_data *ptp_data;
> +	int ret;
> +	u8 i;
> +
> +	ptp_data = &dev->ptp_data;
> +	mutex_init(&ptp_data->lock);
> +	spin_lock_init(&ptp_data->clock_lock);
>  
>  	ret = ksz_ptp_start_clock(dev);
>  	if (ret)

Related to the same question: the pin descriptor loop later in
ksz_ptp_clock_register() is bounded by dev->info->n_pins, so for the chips
above no ptp_pin_desc entry gets a name, index or func at all:

	for (i = 0; i < dev->info->n_pins; i++) {
		struct ptp_pin_desc *ptp_pin = &ptp_data->pin_config[i];

		snprintf(ptp_pin->name,
			 sizeof(ptp_pin->name), "ksz_ptp_pin_%02d", i);
		ptp_pin->index = i;
		ptp_pin->func = PTP_PF_NONE;
	}

> diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
> index 86ce3a86705f9..3a209122fc7dc 100644
> --- a/drivers/net/dsa/microchip/lan937x_main.c
> +++ b/drivers/net/dsa/microchip/lan937x_main.c
> @@ -867,6 +867,7 @@ static int lan937x_setup(struct dsa_switch *ds)
>  		}
>  	}
>  
> +	ksz_ptp_set_caps(ds);
>  	ret = ksz_ptp_clock_register(ds);
>  	if (ret) {
>  		dev_err(dev->dev, "Failed to register PTP clock: %d\n",

[Severity: High]
lan937x_setup() registers the PTP clock unconditionally, so does every
LAN9370-LAN9374 device end up registering with n_pins = 0 and
n_per_out = 0 here?

Reading ksz_common.c at the end of the series (c35b1061) the initializers
are still only present for [KSZ8463] and [KSZ8563], so nothing later
appears to restore the values for the remaining chips.  Should the
.n_pins / .n_per_out initializers be added to the other .ptp_capable
entries?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ksz-perout-v1-0-14202db763b3%40bootlin.com
