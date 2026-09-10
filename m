Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91123EFFD7;
	Thu, 10 Sep 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036221; cv=none; b=aWUOkO4b352mqyLojAHZLLp6CrS77g9oc8DXhgotNHuRMs7d6DZrjBrLnBhr4Gm7UnB50xoJibiUsRkdetv9ZgLxd1aXUzWLQz7t0QFNtAT7NNn2X65FQOo1vuhjZ+ZGQ5mTOwXepgIia0jrw10K35ISA6Bd1ANf7KDXq8gaPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036221; c=relaxed/simple;
	bh=eMjHimPTTEaDtj3FX+1Pi7l0vMStrrUMaxnKZzM6d4c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PhA5P/M9pHDHUhRxcG1fI2D4RcFXSsUy/pVVXKi3K8CDaaKAm8zTU/aZ9IdLJnzL7jXgKeLgDakC1mymIzGsV62L7AIULQ1P13VuD7ncy/TLhUnhfT+bmXolG2+YoM+S+emgax/GwcXWssKsXdPovc99Bi+iWQg9QnhCePo+TWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYIdVOWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYIdVOWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F391F00893;
	Thu, 10 Sep 2026 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036214;
	bh=ftufo9zwnynoh9PQBoUuCZp3Kb1RvnT0jnvcavy7+LU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oYIdVOWCGGu+QTFHfJB4//FUYs/TjMm9EbM4hfqAFNHzC3gFYot5IQL2gmGBgq6HG
	 +UbqS/2BA/z8StGOzJnlJB6rTQi0qvDAHFA+TODCC0ybUjs9BUTE7+dR4IAToZed4g
	 +KMazE4hqS7oK8YpJTOMjRbuC0wunvz3bIaA5Fw/qkMHjIqNJcoM4w6EtAIcvPo0yY
	 /p0JQ9sINqHpV2OkVHzdnOUJoDoQLW/9/dOgYmg2eXzOyAQS2EsuLDBTzSrBYGjeS1
	 /ld4OfTZEFsaH9WpxZcIkF05E1nsITIRyEPkfL0RiBfwKew8M0+fPdqBdIg5POMNcN
	 52KL7d/aam5WA==
Subject: Re: [PATCH net-next v3 02/10] net: dsa: microchip: add the number of
 periodic signals to chip infos
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 10:30:13 +0000
Message-ID: <178903621352.219967.8775079283945133853@kernel.org>
In-Reply-To: <20260908-ksz-perout-v3-2-6722a3f1ca75@bootlin.com>
References: <20260908-ksz-perout-v3-2-6722a3f1ca75@bootlin.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1

- [Low] KSZ8463 chip descriptor is left without .n_per_out (and, from the
  preceding patch "net: dsa: microchip: add the number of pins to chip…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch is
  the enabling step for it: the number of advertised periodic-output…

--

net: dsa: microchip: add the number of periodic signals to chip infos

This adds an n_per_out field to struct ksz_chip_data and makes
ksz_ptp_clock_register() advertise dev->info->n_per_out instead of the
hardcoded value 3.  The field is set to 3 in the chip descriptors of the
switches marked ptp_capable.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index d01fba253af57..041bb4f963659 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1195,6 +1195,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.wr_table = &ksz8563_register_set,
>  		.rd_table = &ksz8563_register_set,
>  		.n_pins = 2,
> +		.n_per_out = 3,
>  	},
>  
>  	[KSZ8795] = {

[ ... remaining ksz_switch_chips[] hunks snipped ... ]

> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index c678fc6597dc4..1155b39350c2b 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -140,6 +140,7 @@ struct ksz_chip_data {
>  	const struct regmap_access_table *wr_table;
>  	const struct regmap_access_table *rd_table;
>  	const u8 n_pins;
> +	const u8 n_per_out;
>  };
>  
>  struct ksz_irq {
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index c92936bf78d3d..f80015250e5ab 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -1051,7 +1051,7 @@ int ksz_ptp_clock_register(struct dsa_switch *ds)
>  	ptp_data->caps.enable		= ksz_ptp_enable;
>  	ptp_data->caps.verify		= ksz_ptp_verify_pin;
>  	ptp_data->caps.n_pins		= dev->info->n_pins;
> -	ptp_data->caps.n_per_out	= 3;
> +	ptp_data->caps.n_per_out	= dev->info->n_per_out;

[Severity: Low]
Does this leave KSZ8463 advertising zero periodic outputs at this point in
the series?

The ksz_switch_chips[KSZ8463] descriptor sets neither .ptp_capable, .n_pins
nor .n_per_out, so both new fields are implicitly 0 here.  The commit message
says "Set it to 3 for all the PTP-capable switches", which is literally
consistent since KSZ8463 does not set .ptp_capable, but KSZ8463 still
registers a PHC:

drivers/net/dsa/microchip/ksz8.c:ksz8463_setup() {
	...
	if (dev->irq > 0) {
		...
		ret = ksz_ptp_clock_register(ds);
	...
}

Unlike ksz9477_setup()/ksz8_setup(), that call is gated only on dev->irq > 0
and not on dev->info->ptp_capable, so on KSZ8463 caps.n_per_out becomes 0
where the literal 3 was used before.  drivers/ptp/ptp_chardev.c then rejects
every request:

drivers/ptp/ptp_chardev.c:ptp_enable_perout() {
	...
	if (req.perout.index >= ops->n_per_out)
		return -EINVAL;
	...
}

PTP_PF_PEROUT pin assignment is refused the same way and ptp_sysfs.c hides
the period attribute.

The last patch of the series ("net: dsa: microchip: add periodic output
support for the KSZ8463") adds .n_pins = 12 and .n_per_out = 12 to that
descriptor, so only bisected intermediate trees see this.  Note also that in
this intermediate state caps.n_pins is 0 for KSZ8463 as well, so the perout
path there cannot resolve a pin anyway.  Would it be simpler to set the
KSZ8463 values in the same patch that introduces the field?

[Severity: Medium]
This isn't a bug introduced by this patch, but making the channel count a
per-chip property widens an existing mismatch: each perout index maps to a
distinct hardware Trigger Output Unit, while struct ksz_ptp_data keeps a
single tou_mode, perout_period and perout_target_time_first.

ksz_ptp_enable_perout() programs and starts the unit selected by the
request:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_enable_perout() {
	...
	data32 = FIELD_PREP(PTP_GPIO_INDEX, pin) |
		 FIELD_PREP(PTP_TOU_INDEX, request->index);
	...
	ptp_data->perout_period.tv_sec = request->period.sec;
	...
}

but the restart path after a clock step only ever touches unit 0:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_restart_perout() {
	...
	request.index = 0;
	request.flags = 0;

	return ksz_ptp_enable_perout(dev, &request, 1);
}

Can this leave units 1 and 2 armed with TRIG_TARGET_SEC/NANOSEC values
computed against the pre-step RTC after PTP_CLOCK_SETTIME or ADJTIME, so
their pulses fire immediately or far in the future?

There is a second effect when only a non-zero channel has a pin assigned:
ksz_ptp_settime() writes PTP_LOAD_TIME first, then
ksz_ptp_restart_perout() -> ksz_ptp_enable_perout() -> ptp_find_pin(clock,
PTP_PF_PEROUT, 0) returns -EINVAL, so settime() reports failure although the
RTC was already loaded.  ksz_ptp_verify_pin() accepts PTP_PF_PEROUT for any
pin and channel, so a user of /dev/ptpN can reach this by binding pin 0 to
PTP_PF_PEROUT channel 1 and issuing PTP_PEROUT_REQUEST with index 1.

The hardcoded index 0 is still present at the end of the series in the
extracted prepare/reset helper, while KSZ8463 then advertises 12 channels
with the same single-instance bookkeeping.  Should the driver track per
channel state, or restart all armed units?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ksz-perout-v3-0-6722a3f1ca75%40bootlin.com
