Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFB4AA3F3;
	Wed,  2 Sep 2026 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366426; cv=none; b=TT/9aMwZbhu5cK7Hzp7Epw0ANZXw7K9a+8vilxLpnbPs5bqUbJ/A6q9uL18gthsTSCKqMf6VTqG9Pa9YpsgYjPfvLL0UUnD1DEcyCWMUXRjieN/PNPj2QIvelS7pnsRzdlbZn9tkqzdpJCxsh0tSe2zjPzhw+FPAUA6ETeQ4Kv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366426; c=relaxed/simple;
	bh=umyJLcL14Shx/+NZBfmpYtHsUeR2BWwEMwHQ7vli0BI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLyTXAPjHemHRObUGeFc3eg+b2qxzBZkGRhP1Fj5Lzv8GdJJK9H9S8EdnPRP+Ma6ADAQAfrkxvYOVO9QZvDZpo4dFwlW0krbHtAw3UKVTs5/TSkFKRUzYwj/C7wBfKwhKofSjuDQZbW1RmyWZJg+/P1gYZFOW7OLk24Ad4bdB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5q+J2z9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5q+J2z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F011F00A3A;
	Wed,  2 Sep 2026 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366424;
	bh=MeCW7fxUQYwKuQQzebYWWaLWME7eZmPCUbVbCe8xUko=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H5q+J2z9fSfrMV4k8jvFdzahDuExX8y0lQTjHM2WPsp7TbnmIirdpXuwyhzhuKd54
	 RQvJBJKuQUgUE5BIwcpJ/ZJM2+eecTbkYsR6VLMQ+1AUCY9lNjQNwfBiTs2ikxMQEy
	 1Zcy+a6K3X38CFXeK3nVqnlEYg5uVbHprYRj0qqW98JhjRpEbsNa6B8Hk/Xs8iACdo
	 tW+ApNuKOSqo1DYZwOXYbSArCNxMSpH9elMS2C8mLK0F1Hd5+9YUexa/JLp9np2qH3
	 NV2NjsZQJsEnCyoxNsyFpIHjFoaXETshurApXJaHnLL8k8kdwIcvOweiKQo5MOBV9T
	 evMaMdjLv/jqA==
Subject: Re: [net-next,02/10] net: dsa: microchip: add the number of periodic
 signals to chip infos
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Sep 2026 16:27:03 +0000
Message-ID: <178836642304.3394541.327314760404034905@kernel.org>
In-Reply-To: <20260831-ksz-perout-v1-2-14202db763b3@bootlin.com>
References: <20260831-ksz-perout-v1-2-14202db763b3@bootlin.com>
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

- [High] Functional regression: `ksz_ptp_clock_register()` now advertises
  `caps.n_per_out = dev->info->n_per_out`…

--

net: dsa: microchip: add the number of periodic signals to chip infos

This adds an n_per_out field to struct ksz_chip_data and makes
ksz_ptp_clock_register() take the number of periodic outputs from the
chip info instead of the hardcoded value 3.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 55d1e3e3c5299..194c88cdd00bc 100644
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

[Severity: High]
Does this drop periodic output support on the other PTP capable chips?

Only the KSZ8563 entry of ksz_switch_chips[] gets .n_per_out in this patch.
A grep of ksz_common.c at this commit shows one n_per_out initializer, while
there are ten entries with .ptp_capable = true (KSZ8563, KSZ9477, KSZ9563,
KSZ8567, KSZ9567 and LAN9370/9371/9372/9373/9374).

Since the remaining entries use designated initializers, the new member is
zero-filled for them, so ksz_ptp_clock_register() registers those clocks with
caps.n_per_out = 0 where it previously advertised 3.

The PTP core then refuses the feature outright, for example in
drivers/ptp/ptp_chardev.c:

	ptp_ioctl():
		if (perout->index >= ops->n_per_out)
			return -EINVAL;

	ptp_set_pinfunc():
	case PTP_PF_PEROUT:
		if (chan >= info->n_per_out)
			return -EINVAL;

so every PTP_PEROUT_REQUEST and every PTP_PF_PEROUT pin assignment on those
switches would now fail with -EINVAL, and PTP_CLOCK_GETCAPS would report zero
periodic channels. The generic back end (ksz_ptp_enable_perout() and
ksz_ptp_tou_start()) is still present for these parts, so this looks like a
user visible behaviour change rather than a pure configurability refactor.

Would it make sense to add .n_per_out to every ptp_capable entry, or to fall
back to the previous value when the field is zero?

The same question applies to the preceding commit "net: dsa: microchip: add
the number of pins to chip infos": .n_pins is only set for KSZ8563 there as
well, which additionally turns the

	for (i = 0; i < dev->info->n_pins; i++)

pin descriptor loop in ksz_ptp_clock_register() into a no-op for those chips.

This also still holds at the end of the series (c35b1061), where
ksz_ptp_set_caps() copies the same zero valued fields and ksz_common.c has
only the KSZ8463 and KSZ8563 n_per_out initializers.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831-ksz-perout-v1-0-14202db763b3%40bootlin.com
