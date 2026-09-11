Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C8377AA8;
	Fri, 11 Sep 2026 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128685; cv=none; b=fjpooV4DiKggIAPVPm2aqwWyT6F54KzqSLSsZ4auNeH/fwzfaaxWVVSOgUtSF+5nzexnupzCfQmEqZW8jWlxKFkcPF76+Dz9zXgxa79jftsKXOluU2YU5W95i1LV1oq8U4jN0VEoZn7NNRAcLuFR/t9sLChlPguxdr+GvIad/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128685; c=relaxed/simple;
	bh=qWvAj6q9qff1XmQhQodWtBa490kcfZfg8aWpElwKVg8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=r/VcBwQb7UmDWvj2Ll48gEV4CcYgCqTE9mrCRSWhxwnJXW3+R6NzY4ljwQ8UE38p3ESL/sTSk4eReHm+27XdDrTzA8+Xn/j/C6QrDoiiAaZQZZRkxhYJQKTBndX99po1H9uA2vWDy5jnMJZSMwBI8G9suAY8tiP5TMUYrrsX5Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jtAVBmD8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jtAVBmD8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87FD6A8F56;
	Fri, 11 Sep 2026 14:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789128680; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=q+wUGVC84NcfVhc1UyBgX5sHnxJ8szuBZMCoF16InyM=;
	b=jtAVBmD8siFhUXI+RrN57Qg6ElzrMbhxWmTemCn17cTimDy9qiBfCHtH/dwFMYJApeq9mF
	Hxe8PFsKjhhfV5DD1Niao2ZNrYsP+x61nnKMrRVvzavrmAJPpwOXOdZZfFF5UsBYzsJJh0
	W79oI6dmlGzrG1wye5l+062wmTaPol60QkDeKtRMO9yFz8NHEA67sWFDeB0zoVJsBT/DPU
	0CDS5htywcXHOwFBZS0dpQvboEfVheU5AbYuBKdE5ywOtiGQFsFmQ18jj6UFKkn1UuThMD
	eb5eK7LBPElB5J7baBgLiTqiB2bB00w1O306WRn32VPhRUonk10Ie9OzIzfu+A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 14:11:18 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Linus Walleij <linusw@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v12 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
In-Reply-To: <20260911-ks8995-to-ksz8-v12-3-5c3422d0d72e@kernel.org>
References: <20260911-ks8995-to-ksz8-v12-0-5c3422d0d72e@kernel.org>
 <20260911-ks8995-to-ksz8-v12-3-5c3422d0d72e@kernel.org>
Message-ID: <6fdac2ceffe33e0ee02b8a6768bf7492@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Linus

On 11.9.2026 11:09, Linus Walleij wrote:
> This adds support for the Microchip KSZ8995XA also known as the
> Micrel KS8995XA switch to the KSZ driver.
> 
> The KSZ8995XA shares family ID 0x95 and chip-ID nibble 0x0 with
> the KS8995MA, so hardware detection cannot distinguish them. The
> legacy "micrel,ks8995" compatible is therefore treated as KSZ8995XA.
> No KS8995MA users are known, and KS8995E has no documented SPI
> management interface. Neither MA nor E has been verified with this
> driver.
> 
> The helper macros are named ksz_is_ksz8995xa() to make it
> possible to add E and MA support in the future.
> 
> Wait for the self-clearing per-port PHY reset bits before continuing
> with switch setup. Poll each port for up to 600 ms and allow an
> additional millisecond for the PHYs to settle.
> 
> The KSZ8995XA has eight global TOS priority registers with one
> bit per DSCP code point, providing two internal priority levels.
> The registers are ordered in the opposite direction from the
> other KSZ8 switches. Describe the two priorities in the chip
> data, then augment the DCB helpers for this.
> 
> Practical testing also shows that its packet-size control bits use
> the same semantics as the other KSZ8 switches. The polarity in the
> manual appears to be wrong and makes the switch hang on big packets.
> 
> The legacy KS8995 driver also matches the Micrel compatibles for
> KSZ8864 and KSZ8795. Add these to the KSZ SPI driver here and use
> an exact tristate dependency to make the drivers mutually exclusive.
> This transfers ownership atomically, avoiding module probe races and
> gaps in driver coverage between patches.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---

> [...]

> diff --git a/drivers/net/dsa/microchip/ksz8.c 
> b/drivers/net/dsa/microchip/ksz8.c
> index 941ae9f66f70..4acce01ca063 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c

> [...]

> 
> +/*
> + * Restricted operations for KSZ8995XA, so many things are not 
> supported
> + * by this old switch that we need diet DSA operations.
> + */
> +const struct dsa_switch_ops ksz8995xa_switch_ops = {
> +	.get_tag_protocol	= ksz8995xa_get_tag_protocol,
> +	.setup			= ksz8_setup,
> +	.teardown		= ksz_teardown,
> +	.phy_read		= ksz8_phy_read16,
> +	.phy_write		= ksz8_phy_write16,
> +	.phylink_get_caps	= ksz8_phylink_get_caps,
> +	.port_setup		= ksz8_dsa_port_setup,
> +	.port_bridge_join	= ksz_port_bridge_join,
> +	.port_bridge_leave	= ksz_port_bridge_leave,
> +	.port_set_mac_address	= ksz_port_set_mac_address,
> +	.port_stp_state_set	= ksz_port_stp_state_set,
> +	.port_pre_bridge_flags	= ksz_port_pre_bridge_flags,
> +	.port_bridge_flags	= ksz_port_bridge_flags,
> +	.port_fast_age		= ksz8_flush_dyn_mac_table,


KSZ8995XA datasheet [1] (table 4-2) states fast-age enable as reg 0x03 
bit 1,
but ksz8_flush_dyn_mac_table() sets reg 0x02 bit 5. It needs an override
similar to the existing one for KSZ8463, but accounting for XA's 800 us
ageing time.

> +	.port_mirror_add	= ksz8_port_mirror_add,
> +	.port_mirror_del	= ksz8_port_mirror_del,
> +	.port_change_mtu	= ksz8995xa_change_mtu,
> +	.port_max_mtu		= ksz88xx_max_mtu,
> +	.port_get_default_prio	= ksz_port_get_default_prio,
> +	.port_set_default_prio	= ksz_port_set_default_prio,
> +	.port_get_dscp_prio	= ksz_port_get_dscp_prio,
> +	.port_add_dscp_prio	= ksz_port_add_dscp_prio,
> +	.port_del_dscp_prio	= ksz_port_del_dscp_prio,
> +	.port_get_apptrust	= ksz_port_get_apptrust,
> +	.port_set_apptrust	= ksz_port_set_apptrust,

If I read the datasheet correctly, PCP and DSCP priorities are or-ed,
but ksz_port_set_apptrust() accepts both to be set (with PCP taking 
precedence).
Not sure if this would break anything though ...

The other things look fine to me.

> +};
> +

> [...]

[1] 
https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ8995XA-Integrated-5-Port-10-100-QoS-Switch-DS00003677A.pdf

Thanks,
Nicolai
