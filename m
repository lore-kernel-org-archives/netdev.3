Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D545FFBB;
	Mon, 21 Sep 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983329; cv=none; b=tNgy96uAJU/Fywd2w0G/xCtL1M9oDyewYrxUBzP29y5RXj5kCwuVr04UIvphGjsLN0zaVgkgTcG/8VLKd1ee2pcEdIpC214893ur5GLZzyvUWm0SM78LLH/dvIxX1sQLGFWTiLiDvMoKKFRohayl7a8UZl6MzC5TvO1jyHVWgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983329; c=relaxed/simple;
	bh=foLcCqnRWv6kRnR/TqwlI71c4jkBeGIRefv+95oWOkU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYbLMX/ELz86lWdiaSbvnQYtzCMLvJJop/qQ/2RdNYchpEJJ7eRsH1+8ZbN2q2s+Agjp/kCj1OeYvNjBWWmtk2TYBI/S57QxEsfUFgvbBab5UOMiVm5GhGPUJgqabaAwvf1PKTy8kqzt+3WGBmtWuaMQfQs6OvqIVNqCtiMyq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnOBSYLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnOBSYLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18281F00893;
	Mon, 21 Sep 2026 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983327;
	bh=SSzDrzYniilzCO1E29hD8FQCgjbslPxGsBns/I2qd4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QnOBSYLNnyV1QmaVO7LbBWN/+Kl8e23aXmi0xSKYMeRpVaCTRXEV/8jIv5LfWiJWs
	 RzT5rqJy6TESR/KJA3nor85UVhT3kJbQWt366vN0QqXmN1CSQXp8xIbcW/2V7787Cf
	 W3BBh07xLFyONNXKxJInZKw76QO05OtKOtMozqcKPOKw0x0y/lLyvYpxJX/JYRQ+7O
	 o4px6QFuXn7+5b9EY2pdeikBCIrOCtHw0rSW873w+ksxaTIUqsplU7xZeeiEx1rqSa
	 kbE8JwpBZjsUbkFV2YXVtGouVxohOR0+T/DD2qVVxdFUh8UV95QP2t306+czDTEMP3
	 na8LxY//lTNqQ==
Subject: Re: [PATCH net-next v8 2/6] net: dsa: motorcomm: use max_ports in
 series for port bounds checking
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 21 Sep 2026 09:35:26 +0000
Message-ID: <178998332620.2160803.14693797109344103505@kernel.org>
In-Reply-To: <20260917082236.3427168-3-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-3-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] yt921x_mbus_int_read()/yt921x_mbus_int_write() (chip.c:360 and
  chip.c:378) now validate internal-MDIO addresses against…

Pre-existing issues:
- [Low] Claim of an inconsistency between the runtime per-series bound
  (ds->num_ports = priv->series->max_ports at chip.c:4734, and now the…

--

net: dsa: motorcomm: use max_ports in series for port bounds checking

This patch replaces YT921X_PORT_NUM with priv->series->max_ports in the
internal MDIO bus read/write address checks and in the phy_mask
computation in yt921x_mbus_int_init().  The commit message states there
is no functional change for existing YT921X devices.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 564e45ece22cb..2156230a78aad 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -357,7 +357,7 @@ static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
>  	u16 val;
>  	int res;
>  
> -	if (port >= YT921X_PORT_NUM)
> +	if (port >= priv->series->max_ports)
>  		return U16_MAX;
>  
>  	mutex_lock(&priv->reg_lock);
> @@ -375,7 +375,7 @@ yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
>  	struct yt921x_priv *priv = mbus->priv;
>  	int res;
>  
> -	if (port >= YT921X_PORT_NUM)
> +	if (port >= priv->series->max_ports)
>  		return -ENODEV;

[Severity: Low]
Is max_ports the right quantity for these two checks?  The address passed
to yt921x_mbus_int_read()/yt921x_mbus_int_write() ends up in the
YT921X_INT_MBUS_CTRL PORT field, which selects one of the integral GbE
PHYs, whereas max_ports is the total DSA port count including the
external MAC ports and the MCU port.

The driver keeps those as separate quantities:

drivers/net/dsa/motorcomm/chip.h:
	/* 8 internal + 2 external + 1 mcu */
	#define YT921X_PORT_NUM			11
	...
	#define yt921x_port_is_internal(port) ((port) < 8)
	#define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)

and struct yt921x_info carries:

	/* Ports with integral GbE PHYs, not including MCU Port 10 */
	u16 internal_mask;

With max_ports == 11 the guard now accepts internal-bus transactions for
ports 8 and 9 (external MACs) and port 10 (MCU), none of which have an
integral PHY.  For a series whose integral PHYs are not the lowest port
indices, the accepted set diverges further: the YT922x entry added later
in this series sets max_ports = 9 while its integral UTP PHYs are only
ports 4..7, so ports 0..3 and 8 would also be accepted.

The effect is bounded: these callbacks only see addresses phylib has
bound from the "mdio" child node, so a DT would have to list a PHY at
such an address.  When it does, the driver runs a real INT_MBUS cycle
against a nonexistent PHY index, and yt921x_intif_read() already has a
dev_info() for the resulting unexpected read data.

Would keying the check off the integral-PHY count or mask (the
internal_mask / yt921x_port_is_internal equivalent) rather than
max_ports, which DSA consumes as ds->num_ports, match the hardware
field being programmed?

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

[Severity: Low]
This isn't a bug introduced by this patch, but now that the runtime bound
comes from priv->series->max_ports, is it worth tying that value to the
compile-time array size?

yt92xx_register_switch() already does:

	ds->num_ports = priv->series->max_ports;

while the per-port state stays fixed size in chip.h:

	struct yt921x_port ports[YT921X_PORT_NUM];

and several helpers still loop on the old constant, for example in
yt921x_chip_setup_dsa():

	for (int i = 0; i < YT921X_PORT_NUM; i++)
		ctrl |= YT921X_ACT_UNK_ACTn_TRAP(i);

Nothing is broken today: the only two series entries are max_ports == 11
(YT921x) and max_ports == 9 (YT922x), both within ARRAY_SIZE(priv->ports),
and the remaining YT921X_PORT_NUM loops live in helpers reachable only
through yt921x_dsa_switch_ops, i.e. only when max_ports == 11.  A
BUILD_BUG_ON() relating max_ports to ARRAY_SIZE(priv->ports), or
converting those loops to max_ports, would make the invariant explicit
for the next series added.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917082236.3427168-1-kyle.switch%40motor-comm.com
