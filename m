Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4BE288C2D;
	Sat,  5 Sep 2026 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573324; cv=none; b=JAL58y03LTEOYmD+V8hJzQcvLdx4qmnch5ANGwnpqaK38pdifg54MhB6YLDePslFl1rOSorh/PsvkrzzJ9OxzcWqZIgvrCzGdy6y1+16yQ1zs3r8/rBO7M8uNq1WselVfQTxHxwngvil5B0hc6y1GBvy5UxlIvuIPPF6omqN43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573324; c=relaxed/simple;
	bh=RLsk/qpbw+as7plH/oas9gGRNWIA7HQksqanl736C/Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9HIPL9KqXJJLQFtlqdBjG1Jq8cfeKRFbYFN55mjcTaiTUxNclwunZrqNogs1kCcgqhDZAiqFf58sKN6v7bPVaW8fGutkhOmWIElrz+862GfPaT066tW+5EerPnbnyeB/FaZvh5pP7oXimf4cORxjskr9TnmL5eYBkyJT1kViiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJIwzlA5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJIwzlA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A908D1F00A3D;
	Sat,  5 Sep 2026 01:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573322;
	bh=9iIf/4mmCi2SsX53pasxrrjtGzIXDnMl0KRbbb/4HeA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YJIwzlA5hhRhDcdUCwsa58lTh41bSytceTXVBsCSSicwaYl/g9aQMagwfoGnJNvA1
	 uKw9rRXV8B7WJlW+8gCwHcvL7i2vQfSRlBHewDJGCyJI+1h9hpeHAY0Rs8PI7t9DNm
	 MAoibj+fz8pl6gj8TXXBsCKVT8JVScWoQ5VJNOhjeW7dpBjIs7vGdLANzlSuletdzf
	 waAnkjd6OVfPGFoqgaatm2t31lSxjnreuT2SIjvp9o8qQMt1CgCOf1R0XgjNJlPr2r
	 yDO2v0hER62TDkPUNYfbvcV8gRGtVpmyjw0ePj09onR5Y6nJJ5iRRsS0HPyRaa8QcF
	 dgiVeaBOJOKeA==
Subject: Re: [PATCH net-next v2 01/10] net: dsa: microchip: add the number of
 pins to chip infos
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 05 Sep 2026 01:55:21 +0000
Message-ID: <178857332123.219967.12880426520973297422@kernel.org>
In-Reply-To: <20260902-ksz-perout-v2-1-6f277fcc9e68@bootlin.com>
References: <20260902-ksz-perout-v2-1-6f277fcc9e68@bootlin.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] KSZ8463 loses its two PTP pins in this commit:
  `ksz_ptp_clock_register()` (drivers/net/dsa/microchip/ksz_ptp.c:1053)…
- [Low] Decoupling of `ptp_data->caps.n_pins` / pin_config loop bound
  from the fixed-size array `struct ptp_pin_desc…

--

net: dsa: microchip: add the number of pins to chip infos

This patch adds an n_pins field to struct ksz_chip_data and uses it in
ksz_ptp_clock_register() instead of the hardcoded KSZ_PTP_N_GPIO, both for
ptp_data->caps.n_pins and for the pin_config[] initialization loop.  The
new field is set to 2 for the switches marked ptp_capable.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1a9d6f83a0232..d01fba253af57 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1194,6 +1194,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.ptp_capable = true,
>  		.wr_table = &ksz8563_register_set,
>  		.rd_table = &ksz8563_register_set,
> +		.n_pins = 2,
>  	},
>  
>  	[KSZ8795] = {

[ ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index cbe98494578c3..c678fc6597dc4 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -139,6 +139,7 @@ struct ksz_chip_data {
>  	u8 sgmii_port;
>  	const struct regmap_access_table *wr_table;
>  	const struct regmap_access_table *rd_table;
> +	const u8 n_pins;
>  };

[Severity: Low]
This isn't a bug today, but the new n_pins field has nothing tying it to
the capacity of the array it indexes.  ksz_ptp.h still declares:

drivers/net/dsa/microchip/ksz_ptp.h:
	#define KSZ_PTP_N_GPIO		2
	...
	struct ptp_pin_desc pin_config[KSZ_PTP_N_GPIO];
	/* Serializes all operations on the PTP hardware clock */
	struct mutex lock;
	spinlock_t clock_lock;

I checked all ten entries that get .n_pins here and they are all 2, and
the later commit that raises KSZ8463 to 12 bumps KSZ_PTP_N_GPIO to 12 in
the same patch, so no entry ever exceeds the array.  Would it be worth
adding a static_assert() or a
BUILD_BUG_ON(n_pins <= ARRAY_SIZE(ptp_data->pin_config)) so a future chip
entry with a larger n_pins cannot walk past pin_config[] into lock and
clock_lock?

Also, is the const qualifier on n_pins intentional?  The other scalar
members of struct ksz_chip_data (u8 sgmii_port, port_cnt, ...) are plain.

> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 39cc70d65900b..c92936bf78d3d 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -1050,14 +1050,14 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
>  	ptp_data->caps.do_aux_work	= ksz_ptp_do_aux_work;
>  	ptp_data->caps.enable		= ksz_ptp_enable;
>  	ptp_data->caps.verify		= ksz_ptp_verify_pin;
> -	ptp_data->caps.n_pins		= KSZ_PTP_N_GPIO;
> +	ptp_data->caps.n_pins		= dev->info->n_pins;
>  	ptp_data->caps.n_per_out	= 3;
>  
>  	ret = ksz_ptp_start_clock(dev);
>  	if (ret)
>  		return ret;
>  
> -	for (i = 0; i < KSZ_PTP_N_GPIO; i++) {
> +	for (i = 0; i < dev->info->n_pins; i++) {
>  		struct ptp_pin_desc *ptp_pin = &ptp_data->pin_config[i];
>  
>  		snprintf(ptp_pin->name,

[Severity: Medium]
Does this leave KSZ8463 with zero PTP pins at this commit?

The commit message says:

  "Set it to 2 for all the PTP-capable switches."

The .n_pins = 2 initializers are added only to the ten entries that carry
.ptp_capable = true (KSZ8563, KSZ9477, KSZ9563, KSZ8567, KSZ9567 and
LAN9370/71/72/73/74).  The [KSZ8463] entry in ksz_switch_chips[] does not
have .ptp_capable and does not get .n_pins, so dev->info->n_pins is 0 for
it.

KSZ8463 still reaches this function though, since ksz8463_setup() gates
the registration on the interrupt only:

drivers/net/dsa/microchip/ksz8.c:ksz8463_setup() {
	if (dev->irq > 0) {
		...
		ret = ksz8463_ptp_irq_setup(ds);
		...
		ret = ksz_ptp_clock_register(ds);

With caps.n_pins == 0 and the loop body never executed, no pin descriptor
is initialized, PTP_PIN_GETFUNC/PTP_PIN_SETFUNC reject every index, and

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_enable_perout() {
	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);
	if (pin < 0)
		return -EINVAL;

can never find a pin, so every PTP_PEROUT_REQUEST on a KSZ8463 with a
working interrupt returns -EINVAL, where two pins were advertised before
this patch.

The end of the series is fine: the later commit "net: dsa: microchip: add
periodic output support for the KSZ8463" adds .n_pins = 12 (and
.n_per_out = 12) to the [KSZ8463] entry.  Could the .n_pins value for
KSZ8463 be set in this patch instead, so that the intermediate commits of
the series do not regress periodic output on that chip?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-ksz-perout-v2-0-6f277fcc9e68%40bootlin.com
