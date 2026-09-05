Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86333D6D5;
	Sat,  5 Sep 2026 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573325; cv=none; b=pbBBjN+UPoCczYCo3E/8+hCJBRndYrNNCl56SDK3IQuu4VCrrPkj/0SqmWnClNDUV1WaulD5b29sLKdFxNg9EBzXwXsB1DFNZwQ99ZY3EVnQABOl9UX7PCKVyGcBV6TkOUDr1T5y1xwCiJ9eQE668E8vV+enf2+6XWv2wwhjzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573325; c=relaxed/simple;
	bh=ByG5P7zpz5OiywzwozxpHFc2VfRLDF5KWqmhU3aoOoI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sf7Ard0aocJBz2jpF/0rB7Zuu726k32sk42yExNeWCvn5uQV5a4F4mXpvjONkt+Pot1yjd82+WgCaWOT6IdUjqKkQczQxEwvIjWNxn1asMEjKo9UPz+u2t19IU0gLLn/lLmyONP2XWCTICVNcFxsjy89Ss/ayTb6ZdwxUPRLmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZEz0OYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZEz0OYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE6B1F00A3E;
	Sat,  5 Sep 2026 01:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788573323;
	bh=Fr11NjnJVVQfzGouHabD2M2yd5DSZ4XdF7Updqjh2aY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jZEz0OYoaXPNkD7H0dSjyUptK9q5sTK+Xud5QEnwBYzh0NS4DUbcDMaEh7RDtaDeJ
	 uAr5KDd2vjY2s3MCPtRWc3ZJFva7SVWkRh3RYIHC+UkhU1iYUBAKWsfOPRJquzwyMo
	 i1ZaQU+C8a1AlAikABJBkFpCAG1EjcE+qlD5X9Ay1i0ZDQb0euVX6M158CBOc4ecO6
	 rYLSScYkw9g6Ac/w279AiHzvZMo44TR81QcXTtVk1q2RVEGZjIyIvT+JXjIYip7Yfs
	 HehkPv5eEbeNtDQTxY7fQcrUfPkjqYHUHCUrC+p3+IaZomNXn7gS4LubVdsv6WAgXr
	 xgxoQbFivY92g==
Subject: Re: [PATCH net-next v2 02/10] net: dsa: microchip: add the number of
 periodic signals to chip infos
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 05 Sep 2026 01:55:22 +0000
Message-ID: <178857332257.219967.393836021052995350@kernel.org>
In-Reply-To: <20260902-ksz-perout-v2-2-6f277fcc9e68@bootlin.com>
References: <20260902-ksz-perout-v2-2-6f277fcc9e68@bootlin.com>
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

Critical: 0 · High: 0 · Medium: 0 (1) · Low: 1 (1)

- [Low] Incomplete conversion for KSZ8463: `ksz_ptp_clock_register()`
  (drivers/net/dsa/microchip/ksz_ptp.c:1054) now takes the advertised…

Pre-existing issues:
- [Medium] The driver advertises `n_per_out` periodic-output channels (3
  for every PTP-capable chip, now sourced from chip data) but keeps only…
- [Low] In `ksz_ptp_tou_reset()`
  (drivers/net/dsa/microchip/ksz_ptp.c:66-88, the TRIG_RESET write at…

--

net: dsa: microchip: add the number of periodic signals to chip infos

This adds an n_per_out field to struct ksz_chip_data and uses it in
ksz_ptp_clock_register() instead of the hardcoded value 3.  The field is
populated with 3 for every chip entry carrying .ptp_capable = true.

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

[Severity: Low]
Should the KSZ8463 entry get an n_per_out value too?

The commit message says "Set it to 3 for all the PTP-capable switches", which
matches the .ptp_capable chip-data flag, but KSZ8463 registers a PTP clock
without that flag:

drivers/net/dsa/microchip/ksz8.c:ksz8463_setup() {
	...
	if (dev->irq > 0) {
		...
		ret = ksz_ptp_clock_register(ds);
		if (ret) {
			dev_err(dev->dev, "Failed to register PTP clock: %d\n", ret);
	...
}

The [KSZ8463] initializer in ksz_switch_chips[] sets neither .n_pins (added
by the preceding patch) nor .n_per_out, so both stay 0 in this static const
table.  Does that mean the KSZ8463 clock now advertises n_per_out = 0
(previously 3) and n_pins = 0 (previously KSZ_PTP_N_GPIO), making the PTP
core reject every PTP_PEROUT_REQUEST with -EINVAL and leaving
ptp_find_pin() with no descriptors?

No working output is actually lost at this commit, since the only perout
implementation here is ksz_ptp_enable_perout(), which programs ksz9477-only
registers, and the later patch "net: dsa: microchip: add periodic output
support for the KSZ8463" does set .n_pins = 12 and .n_per_out = 12 on that
entry.  Would it be cleaner to set the KSZ8463 values in this patch so no
intermediate commit advertises zero channels or pins?

[ ... remaining ksz_common.c chip entries and the ksz_common.h hunk snipped ... ]

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

[Severity: Medium]
This isn't a bug introduced by this patch, but now that the advertised
number of periodic outputs becomes per-chip data, is the driver's shadow
state able to describe more than one trigger unit?

ksz_ptp_enable_perout() programs the unit selected by the request index:

	data32 = FIELD_PREP(PTP_GPIO_INDEX, pin) |
		 FIELD_PREP(PTP_TOU_INDEX, request->index);

but only one tou_mode, one perout_period and one perout_target_time_first
are stored, and the re-arm path hardcodes unit 0:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_restart_perout() {
	...
	request.period.nsec = ptp_data->perout_period.tv_nsec;
	request.index = 0;
	request.flags = 0;

	return ksz_ptp_enable_perout(dev, &request, 1);
}

If userspace arms channel 1 or 2 (the -EBUSY guard only compares tou_mode,
never the unit index), does a later settime/adjtime leave hardware unit 1
or 2 still TRIG_ENABLE'd with a target time in the old timebase while the
driver re-arms idle unit 0?

There is a second effect on the same path: ksz_ptp_enable_perout() starts
with ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index).  With a
pin assigned only to channel 1, the lookup for index 0 fails, so
ksz_ptp_settime()/ksz_ptp_adjtime() return -EINVAL after the RTC has
already been written and before ptp_data->clock_time is refreshed under
clock_lock.  Does that leave the software clock shadow stale and skew
timestamp reconstruction?

This is still the case at the end of the series, where KSZ8463 additionally
advertises 12 channels against the same single-unit shadow state.

[Severity: Low]
This is a pre-existing issue and the patch does not touch this function,
but the TRIG_RESET write result in ksz_ptp_tou_reset() is discarded:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_tou_reset() {
	/* Reset trigger unit (clears TRIGGER_EN, but not GPIOSTATx) */
	ret = ksz_rmw32(dev, REG_PTP_CTRL_STAT__4, TRIG_RESET, TRIG_RESET);

	data = FIELD_PREP(TRIG_DONE_M, BIT(unit));
	ret = ksz_write32(dev, REG_PTP_TRIG_STATUS__4, data);
	if (ret)
		return ret;
	...
}

ret is overwritten before it is tested.  If the read-modify-write fails but
the following write succeeds, can the helper return 0 with the trigger unit
never put into reset, so ksz_ptp_enable_perout() rewrites TRIG_CTRL, cycle
width, cycle count, pulse width and target time on a still-enabled unit?
On the !on path, tou_mode is also set to KSZ_PTP_TOU_IDLE while the unit may
remain armed.

This is unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902-ksz-perout-v2-0-6f277fcc9e68%40bootlin.com
