Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD334AA3EE;
	Wed,  2 Sep 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366424; cv=none; b=EiLWjh3X7g5jnpOkxj3Vn3lVKPjmJEZTimpQnOTGel13+LaHxFBaj4MEWtNVCMem8lOHDytoEZ448sRDi88tdMc+4hxA7lxXycQOj8LqjFISMgKO31rotO+bdAKD+j13R//daYLUEdjuXf+xMbdpksqEqiJGCO3A3WvewFG7bn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366424; c=relaxed/simple;
	bh=/W+HCXUAYcEaIUTD7JbFlsq8cAool1Pwqm3670xJMKM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gSdSd2dp4suRCgcn7lt8Vk3hBdegTueyZjEc6bS9k9P+1EuWHSiAq6tKf2dSY+iYF+O3p/S8S007is6WLr1KEBmYVe3aEw/GPM/3RiLiabQbbLmlQ6VHYdcp61JdBDyf0eeJl3TtWtl4MryKTcIVv2uVCjlwJHxT5ei79869GBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfJiS+QB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfJiS+QB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2407F1F000E9;
	Wed,  2 Sep 2026 16:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366422;
	bh=yUN3KA2WI6l9BTUSZf8yukqFe3MKyTp4uxfSCtWpU2s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mfJiS+QBeWKoQbJoRUfpPS9bVwsW5UBgWX5OU1BDonPTGEWeD23OViX4jodAdSiPy
	 QOQZw8+/s+AS4DtLK3DkEkNgffVQT/yaYe/NP0OBemOsMlhBjcDE10dYCl+O9n9OL7
	 VM27ny665KsRYCt48KJEKvAJ2Abza2QB/FW6sAIFgg0SgDxErQDg6DhzofKhYGqFXo
	 0qAONqbL/rE94QWtj9tnmTzOyIRY2/URfv22DMfLZ7KWQ15TLA6v8+6HqTqms+N2Sw
	 JQRJqr8uYg780SWreKFXuFpGMl1nfmnRrOESn+7fKX8rfLBLlEV9aT4LKMi50W3lNZ
	 THtp7u9ERitmg==
Subject: Re: [net-next,01/10] net: dsa: microchip: add the number of pins to
 chip infos
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 16:27:01 +0000
Message-ID: <178836642168.3394541.11659278736400588749@kernel.org>
In-Reply-To: <20260831-ksz-perout-v1-1-14202db763b3@bootlin.com>
References: <20260831-ksz-perout-v1-1-14202db763b3@bootlin.com>
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

- [High] Incomplete conversion of the PTP pin count to per-chip data
  silently disables PTP pin/periodic-output support on every PTP-capable…

--

net: dsa: microchip: add the number of pins to chip infos

This adds an n_pins field to struct ksz_chip_data and makes
ksz_ptp_clock_register() take the PTP pin count from the per-chip info
instead of the KSZ_PTP_N_GPIO constant.  Only the KSZ8563 entry in
ksz_switch_chips[] is given an .n_pins value.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 1a9d6f83a0232..55d1e3e3c5299 100644
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

[Severity: High]
Is KSZ8563 the only entry that needs .n_pins?  Grepping ksz_switch_chips[]
at this commit, KSZ8563 is the only entry carrying the new field, while
these other entries also have .ptp_capable = true and no .n_pins:

  KSZ9477, KSZ9563, KSZ8567, KSZ9567, LAN9370, LAN9371, LAN9372,
  LAN9373, LAN9374

For those entries the designated initializers leave n_pins at 0, so
ksz_ptp_clock_register() now advertises caps.n_pins = 0 where it
previously advertised KSZ_PTP_N_GPIO (2) and filled in 2 pin
descriptors.  Does this drop PTP pin and periodic output support on
those switches?

The KSZ8463 entry also has no .n_pins here, and ksz8463_setup() in
ksz8.c reaches ksz_ptp_clock_register() when dev->irq > 0:

drivers/net/dsa/microchip/ksz8.c:ksz8463_setup() {
	...
		ret = ksz8463_ptp_irq_setup(ds);
		if (ret)
			goto free_girq;

		ret = ksz_ptp_clock_register(ds);
	...
}

The commit message says KSZ8463 "has 12 pins that can be used as
periodic outputs", but this commit gives that entry n_pins == 0 rather
than 12.  Was the KSZ8463 initializer meant to be part of this patch?

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

[Severity: High]
When dev->info->n_pins is 0, does this silently register a clock with no
usable pins?  The loop body never runs, so pin_config[] stays empty, and
the PTP core takes an early return instead of reporting an error:

drivers/ptp/ptp_sysfs.c:ptp_populate_pin_groups() {
	...
	if (!n_pins)
		return 0;
	...
}

That removes the pinN sysfs files and PTP_PIN_GETFUNC/PTP_PIN_SETFUNC
support, and ptp_find_pin() iterates over info->n_pins so it can only
return -1:

drivers/ptp/ptp_clock.c:ptp_find_pin() {
	...
	for (i = 0; i < ptp->info->n_pins; i++) {
	...
}

which makes every periodic output request fail here:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_enable_perout() {
	...
	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);
	if (pin < 0)
		return -EINVAL;
	...
}

so REG_PTP_UNIT_INDEX__4 is never programmed on those chips.  Meanwhile
caps.n_per_out is still hardcoded to 3, advertising three periodic
outputs with zero pins.

Checking the end of the series (c35b10618e5929c5a72f7e06b0bad4a4027caf11),
only KSZ8463 (.n_pins = 12) and KSZ8563 (.n_pins = 2) are initialized;
KSZ9477, KSZ9563, KSZ8567, KSZ9567 and LAN9370..LAN9374 still leave
n_pins at 0, and after "net: dsa: microchip: add the number of periodic
signals to chip infos" they get n_per_out == 0 as well, so this is not
picked up later in the series.

Would it work to initialize .n_pins for every ptp_capable entry, or to
fall back to 2 in ksz_ptp_clock_register() when the field is 0?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ksz-perout-v1-0-14202db763b3%40bootlin.com
