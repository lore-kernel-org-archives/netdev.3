Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC53AF640;
	Thu, 10 Sep 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789036221; cv=none; b=kpCx36hWnnW+IA0JcGn/qcE3gcTw/SygHtmNAM18WP3y4NjKIvniY5qm0yVW0dAvwMD45huZh+z0p6QcpVC6OI08amSJmH0z/CAB5iKOIfrX1Ll7tTP0VPYeOamM6rUerBe/Vk1UnHX4qRgiH2LGAWoHBQ9+0/dAy4lapYGiM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789036221; c=relaxed/simple;
	bh=Kj2RTgbjKPC8wB/HcMEFuw5G/Ji5Whd3ExbUlMEZwEk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5sM66qiTeCun+ox37H3L8svfcS+/BFPLbvgrx5xAp4tx5NSMNJUq75nF+Me8BknQJqO0xJICOLEZG6GyDPEvbq603papmfi5mHpl1DwB1J89pQ5vIrLw+a9j5WTNC7hOK8FyNpCtfBp+/kRAF+JQ0LoMqN7WCUoXUVsbUGnJ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGIuAwX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGIuAwX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD2B1F000FF;
	Thu, 10 Sep 2026 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789036213;
	bh=xYuK7QoWI4VcUdxH9EeegsHeKzBVtBmJlcO4ty2/UFM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DGIuAwX9EoM9lcWFMXWP+cf7L9MLYmWQrH6GJz4Koaj8SwDtikDp1q3vxpZlp0hZj
	 W6wi0sc3tqqLOkCiewMFyKYO5C/jV0eclp6CHdeCScvx0hNpWi73RKe1V3JtMa7mwW
	 VUx48vztI7/Gr7LQZpRXxhrQdqht71RIU5PM4xHUu8mmIFD/QUerCxudtodHacTCLJ
	 6G/KdqtGP6grLEtXuHJ96OnqVpkS0q9qKE9buV8XYtEwbWPlpPkKJh/eSTLz4+nTn/
	 qmvIxmwE4YJ5105B5nx6EMmAh2RtPuSgn7Dyrk/YKk9iIkzwEQRliWCOikumxPTBOH
	 cVdgz5xUzAabQ==
Subject: Re: [PATCH net-next v3 01/10] net: dsa: microchip: add the number of
 pins to chip infos
From: netdev-bot+sashiko@kernel.org
To: bastien.curutchet@bootlin.com
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 10:30:12 +0000
Message-ID: <178903621218.219967.2622838231365800209@kernel.org>
In-Reply-To: <20260908-ksz-perout-v3-1-6722a3f1ca75@bootlin.com>
References: <20260908-ksz-perout-v3-1-6722a3f1ca75@bootlin.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] In ksz_ptp_clock_register()
  (drivers/net/dsa/microchip/ksz_ptp.c:1053,1060) both caps.n_pins and…
- [Low] The KSZ8463 entry in ksz_switch_chips[]
  (drivers/net/dsa/microchip/ksz_common.c, [KSZ8463] block around line…

--

net: dsa: microchip: add the number of pins to chip infos

This adds an n_pins field to struct ksz_chip_data and sets it to 2 for
every PTP-capable switch, replacing the hardcoded KSZ_PTP_N_GPIO used by
ksz_ptp_clock_register() for caps.n_pins and for the pin_config[]
initialization loop.

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

[Severity: Low]
The commit message says ".n_pins" is set "for all the PTP-capable
switches", but the KSZ8463 entry in ksz_switch_chips[] does not get an
.n_pins value here, so it stays 0.

Is that intentional?  KSZ8463 does register a PTP clock, and the call is
not gated on info->ptp_capable:

drivers/net/dsa/microchip/ksz8.c:ksz8463_setup() {
	...
	if (dev->irq > 0) {
		...
		ret = ksz_ptp_clock_register(ds);
	...
}

With caps.n_pins coming from dev->info->n_pins, KSZ8463 goes from
advertising two PTP pins to advertising none: no ptp_pin_desc is
initialized, the pins directory of the PTP device disappears,
PTP_PIN_SETFUNC fails, and ptp_find_pin() in ksz_ptp_enable_perout()
can no longer match a pin:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_ptp_enable_perout() {
	...
	pin = ptp_find_pin(ptp_data->clock, PTP_PF_PEROUT, request->index);
	if (pin < 0)
		return -EINVAL;
	...
}

The last patch of the series does give KSZ8463 ".n_pins = 12", so this
only affects the intermediate commits, but would it be better to set
KSZ8463 here as well so no commit in the series shrinks the pin
interface?

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
>  
>  struct ksz_irq {
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

[Severity: Low]
Can this loop overflow ksz_ptp_data.pin_config[]?  The bound is now the
per-chip n_pins, while the destination array is still sized by the
compile-time constant:

drivers/net/dsa/microchip/ksz_ptp.h
#define KSZ_PTP_N_GPIO		2

struct ksz_ptp_data {
	...
	struct ptp_pin_desc pin_config[KSZ_PTP_N_GPIO];
	/* Serializes all operations on the PTP hardware clock */
	struct mutex lock;
	...
};

After this change nothing ties n_pins to ARRAY_SIZE(pin_config): there
is no clamp, no min(), and no BUILD_BUG_ON.  A chip entry with n_pins
larger than KSZ_PTP_N_GPIO would write past pin_config[] into lock,
clock_lock, clock_time and the perout state of struct ksz_device, and
would also hand the PTP core an n_pins larger than the array it indexes
from PTP_PIN_GETFUNC, PTP_PIN_SETFUNC, ptp_populate_pin_groups() and
ptp_find_pin().

Every n_pins initializer in this commit is 2, and the later commit that
raises KSZ8463 to 12 also changes KSZ_PTP_N_GPIO to 12 in the same diff,
so no commit in the series can trigger this today.  Would it still be
worth sizing pin_config[] from a maximum constant and adding a
BUILD_BUG_ON(dev->info->n_pins > ARRAY_SIZE(ptp_data->pin_config))
style check, so the two values cannot drift apart?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-ksz-perout-v3-0-6722a3f1ca75%40bootlin.com
