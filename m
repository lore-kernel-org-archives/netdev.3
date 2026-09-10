Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E645C713;
	Thu, 10 Sep 2026 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070524; cv=none; b=QDsX3pPNrEiV18n3NLNHOPli0T3ndIm8yfUDlh62XMNpsKPOaegfOy+lRGN8Hg7YuTvvgHVlcfIIG3ixeoFQ22NIjmES9PjL6UuyQHN1hJZcz/Rq2p3mTAjmXkHvINyhK2m56UFcI28fpncCRAAI9L5d6iep6TFjR2l7AYZfnrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070524; c=relaxed/simple;
	bh=HtjrXdyNkpvem2ZpUhKD2iFTZ/8L2twekgn7O/0MeZw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QVyig2UWQg2lY6qeZPj0+nuTOuHwC7BpX6tRYawS0LpDW4ZH4OPSoFjO5PKN7d4e1DE0+AvlEoTwTRCFKa0J3afRC5caixV7BHF0YxgozYB/Q7tPnYwIK8wdjmpgG9WLIbIjyDxUYOhMSy/bDw1XGm1mk3M0z8jggKonF125FjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKe+KBFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKe+KBFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C9B1F000FF;
	Thu, 10 Sep 2026 20:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070522;
	bh=DBYBIClnl3PxAyfMv0kDKPPGmIJDXRMEeddFsM0mNyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FKe+KBFP2fVa7PeOsMNi3RCsTalo3HFSH6p97xZWa+cGP1/IFoCceZdOZa7E7QpXe
	 hH7rlhEy7QtfdlogTnHnm2+FNWS33bLuiOw0Nj6STqZucPr5JBxjbfppCz7hRt6MfH
	 sCwaNG9/rmg1JWl3My+47xBDQu21s6sw3MBVaJtZFs39ifBI+tjPUTrGWaljL+KBfi
	 MB4slVu1Hw97Cmiqu72hF+YRpzkME3I3jSgeIZCob2YX3YkdCkmZ9ewOpjrFRSw108
	 Oilm/isZQg4csU2SNnIWF0XwK0woyf13gDzu+3wR6D405ZEEc4JtnE5zEmPt2woREz
	 gYwmfEDWczVUQ==
Subject: Re: [PATCH net-next v11 3/4] net: dsa: microchip: Support Microchip
 KSZ8995XA / KS8995XA
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 10 Sep 2026 20:02:01 +0000
Message-ID: <178907052148.219967.6703395266184682965@kernel.org>
In-Reply-To: <20260909-ks8995-to-ksz8-v11-3-0e04411a559d@kernel.org>
References: <20260909-ks8995-to-ksz8-v11-3-0e04411a559d@kernel.org>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] ksz8_reset_switch() (drivers/net/dsa/microchip/ksz8.c:266 and
  :275) iterates `port < dev->info->port_cnt` (5 for KSZ8995XA) for both…
- [Medium] In ksz8_port_setup()
  (drivers/net/dsa/microchip/ksz8.c:2140-2153) the new KSZ8995XA block…

--

net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA

Adds KSZ8995XA (Micrel KS8995XA) support to the KSZ driver with a reduced
set of dev/switch ops, a per-port PHY reset with poll, header-tag handling
instead of tail tags, and a KSZ8995XA-specific DSCP register layout in the
DCB helpers. The legacy KS8995 driver is made mutually exclusive via
Kconfig and the Micrel compatibles are moved to the KSZ SPI driver.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 941ae9f66f70..c3871d5d6d36 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c

[ ... ]

> @@ -253,7 +255,35 @@ static int ksz8463_reset_switch(struct ksz_device *dev)
>  
>  static int ksz8_reset_switch(struct ksz_device *dev)
>  {
> -	if (ksz_is_ksz88x3(dev)) {
> +	if (ksz_is_ksz8995xa(dev)) {
> +		unsigned int port, reg, val;
> +		int ret;
> +
> +		/* The KSZ8995XA switch itself cannot be reset by software, but
> +		 * often boot loaders have fun with ports, so reset them. This
> +		 * reset bit is self-clearing.
> +		 */
> +		for (port = 0; port < dev->info->port_cnt; port++) {
> +			ret = ksz_prmw8(dev, port, REG_PORT_STATUS_3,
> +					PORT_PHY_SOFT_RESET,
> +					PORT_PHY_SOFT_RESET);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/* IEEE 802.3 allows up to 500 ms for a PHY reset. */
> +		for (port = 0; port < dev->info->port_cnt; port++) {
> +			reg = dev->dev_ops->get_port_addr(port, REG_PORT_STATUS_3);
> +			ret = regmap_read_poll_timeout(ksz_regmap_8(dev), reg, val,
> +						       !(val & PORT_PHY_SOFT_RESET),
> +						       1000, 600000);
> +			if (ret)
> +				return ret;
> +		}

[Severity: Medium]

Should these two loops be bounded by dev->phy_port_cnt instead of
dev->info->port_cnt?

port_cnt is 5 for KSZ8995XA, so port index 4 is included, and the chip
data added by this patch declares that port as having no internal PHY:

	[KSZ8995XA] = {
		...
		.port_cnt = 5,		/* total cpu and user ports */
		...
		.internal_phy = {true, true, true, true, false},

ksz8_get_port_addr(4, REG_PORT_STATUS_3) lands on register 0x5F, and
ksz8_reg.h only defines PHY Status 3 for the four PHY ports:

	#define REG_PORT_1_STATUS_3		0x1F
	#define REG_PORT_2_STATUS_3		0x2F
	#define REG_PORT_3_STATUS_3		0x3F
	#define REG_PORT_4_STATUS_3		0x4F

The first loop therefore does a read-modify-write of bit 4 in the MII/CPU
port bank where no PHY reset is documented.

The second loop has no per-port skip and its only success condition is
!(val & PORT_PHY_SOFT_RESET). If that bit at 0x5F is a plain writable or
reserved bit that never self-clears, does probe fail here?

	ksz_switch_register() -> dsa_register_switch() -> ksz8_setup()
		-> ksz8_reset_switch()

regmap_read_poll_timeout() would return -ETIMEDOUT after 600 ms, and
ksz8_setup() propagates that after printing "failed to reset switch".
Every other per-PHY loop in this file uses dev->phy_port_cnt, for example
ksz8_config_cpu_port():

	for (i = 0; i < dev->phy_port_cnt; i++) {

> +
> +		/* Some PHYs need additional settling time after reset. */
> +		usleep_range(1000, 2000);
> +	} else if (ksz_is_ksz88x3(dev)) {
>  		/* reset switch */
>  		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
>  			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);

[ ... ]

> @@ -2057,6 +2137,21 @@ static void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
>  
>  	ksz8_cfg_port_member(dev, port, member);
>  
> +	if (ksz_is_ksz8995xa(dev)) {
> +		/* Use VID 0 to identify untagged frames in the special tag */
> +		ksz_pwrite16(dev, port, REG_PORT_CTRL_VID, 0);
> +
> +		/* The KSZ8995XA has a special tag format in the front of the frame
> +		 * that need to be inserted by the CPU and then removed by each
> +		 * port. PORT_REMOVE_TAG simply means "remove tags coming from the
> +		 * CPU port" it does not affect ingress packets.
> +		 */
> +		if (cpu_port)
> +			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_INSERT_TAG, true);
> +		else
> +			ksz_port_cfg(dev, port, REG_PORT_CTRL_0, PORT_REMOVE_TAG, true);
> +	}

[Severity: Medium]

Can the opposite tag bit stay set here?  Both bits live in
REG_PORT_CTRL_0:

	#define PORT_INSERT_TAG			BIT(2)
	#define PORT_REMOVE_TAG			BIT(1)

and ksz_port_cfg(..., true) can only set bits, never clear them:

	static void ksz_port_cfg(struct ksz_device *dev, int port, int offset,
				 u8 bits, bool set)
	{
		ksz_rmw8(dev, dev->dev_ops->get_port_addr(port, offset), bits,
			 set ? bits : 0);
	}

So a user port that comes up with PORT_INSERT_TAG already set keeps it,
and a CPU port that comes up with PORT_REMOVE_TAG already set keeps that.

For this chip ksz8_reset_switch() intentionally performs no global reset,
and its own comment says the prior state cannot be trusted:

	/* The KSZ8995XA switch itself cannot be reset by software, but
	 * often boot loaders have fun with ports, so reset them. This
	 * reset bit is self-clearing.
	 */

No other path clears these bits for KSZ8995XA either: the VLAN writer
ksz_port_cfg(dev, port, P_TAG_CTRL, PORT_REMOVE_TAG, untagged) is not
reachable through ksz8995xa_switch_ops, and ksz8_port_queue_split() masks
only KSZ8795_PORT_2QUEUE_SPLIT_EN.

Would a single read-modify-write with mask PORT_INSERT_TAG |
PORT_REMOVE_TAG, setting one and clearing the other, be more robust?  As
written, a stale PORT_INSERT_TAG on a user port emits the private tag onto
the wire, and a stale PORT_REMOVE_TAG on the CPU port strips the tag that
tag_ks8995 expects on receive, both without any error being reported.

>  	/* Disable all WoL options by default. Otherwise
>  	 * ksz_switch_macaddr_get/put logic will not work properly.
>  	 * CPU port 4 has no WoL functionality.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-ks8995-to-ksz8-v11-0-0e04411a559d%40kernel.org
