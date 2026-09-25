Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C05260565;
	Fri, 25 Sep 2026 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790302787; cv=none; b=eYHWHV2OzTIbTnGYemCIQG4w8NRUV8dJOt8vxjkNpYHm/Ty0O5xjj1JlCkmlL+wvYj//6DyCmJlLj/EJCRy5z7ZR/Lz3rvN/LtmyAg7BcsF66QyL5AW+RVJyJoZRDMZ17Xxs1CFEGXbzen8Xx3IfcJeLchjJCSseSU6k9qmOt+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790302787; c=relaxed/simple;
	bh=FZLW6Z301vg9tosLGCcFV5OVEm4BXSyaoExMBsdLOqc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDmmIZe+arfef0vIRdiZ4+/Pm/oFk7Zc/1TOX64QILZZsLjpO10LouopEjoKBPEsQ4yAYP2iO1JFiEGyp0ha9b+a8r10y1L1FQS6hTrHJVxlufxDtHgDYQlP/wHSVNlwpQuHW0s+3h8wCjfvskPoWnDxsqDI8JXotO5ujiy6Nj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv6073YO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv6073YO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64E01F00893;
	Fri, 25 Sep 2026 02:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790302786;
	bh=QCBXTItV/Ej+9VMQJX+ydvpVTjj/i9whV6yiT8aq+Ek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zv6073YOLbzsKKOhuUrI5vL9TBuC9WKJvkFxF+ATc37oqwcxHthlshAmK4WQTmyT4
	 4fbX/PHu7PuBECz/vfjLDKOPcQd5GQvX7TQcnjFS6Zw6gOWIFr0vKh3U0L/glyqkJF
	 BsODHrKUthMALEvLDKmKkuWAuBHwozu0zlVSC2SOdcFIObEZAr79Zgtq/3HzGHnkC+
	 nN57Koy/Am15khWyUtefIinoiR9HBRteFPd3HDCeFRVg79AOG5a3kWmxC7AGIALYqJ
	 o+uUTcfLZwgB/6JzeSa4/iarapJ5Bo/l5pfhal7rum4MdDFJfTCSaK3+onYq7BHdZJ
	 ZVci/k5WfW9UA==
Subject: Re: [PATCH net-next v4 3/8] net: dsa: motorcomm: Identify port type
 at runtime
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 02:19:45 +0000
Message-ID: <179030278530.2160803.5892691162510957034@kernel.org>
In-Reply-To: <20260923021945.2203368-4-mmyangfl@gmail.com>
References: <20260923021945.2203368-4-mmyangfl@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "no behavior changes intended", but
  the patch changes which registers are programmed on SerDes link-up and…
- [Low] yt921x_port_up() chooses the XMII register block using only
  pp->serdes and never checks info->xmii_mask.

--

net: dsa: motorcomm: Identify port type at runtime

This commit removes the hardcoded yt921x_port_is_internal/external()
macros and checks the per-chip internal_mask, serdes_mask and xmii_mask
instead. It also adds a per-port serdes flag, set in yt921x_port_config(),
which decides which register block yt921x_port_up() programs.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 54881856b796a..ea4b29882b5cb 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -3746,12 +3747,13 @@ static int yt921x_port_down(struct yt921x_priv *priv, int port)
>  	if (res)
>  		return res;
>  
> -	if (yt921x_port_is_external(port)) {
> +	if (BIT(port) & info->serdes_mask) {
>  		mask = YT921X_SERDES_LINK;
>  		res = yt921x_reg_clear_bits(priv, YT921X_SERDESn(port), mask);
>  		if (res)
>  			return res;
> -
> +	}
> +	if (BIT(port) & info->xmii_mask) {
>  		mask = YT921X_XMII_LINK;
>  		res = yt921x_reg_clear_bits(priv, YT921X_XMIIn(port), mask);
>  		if (res)

[ ... ]

> @@ -3800,7 +3804,10 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
>  	if (res)
>  		return res;
>  
> -	if (yt921x_port_is_external(port)) {
> +	if (!(BIT(port) & (info->serdes_mask | info->xmii_mask)))
> +		return 0;
> +
> +	if (pp->serdes) {
>  		mask = YT921X_SERDES_SPEED_M;
>  		switch (speed) {
>  		case SPEED_10:

[ ... ]

> @@ -3836,7 +3843,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
>  					     mask, ctrl);
>  		if (res)
>  			return res;
> -
> +	} else {
>  		mask = YT921X_XMII_LINK;
>  		res = yt921x_reg_set_bits(priv, YT921X_XMIIn(port), mask);
>  		if (res)

[Severity: Medium]
The commit message says "no behavior changes intended". Doesn't this
change which registers get programmed on SerDes link up and link down?

Before this patch, yt921x_port_up() did all three of these on ports 8
and 9:

    update YT921X_SERDESn(port)
    set YT921X_XMII_LINK in YT921X_XMIIn(port)
    write link/speed/duplex to YT921X_MDIO_POLLINGn(port)

With the new if/else, the XMII_LINK set and the MDIO_POLLINGn write are
skipped once yt921x_port_config() has set pp->serdes.

The yt921x_port_down() hunk above changes in the same way:

    port 8 on YT9215SC, YT9215S and YT9214NB no longer gets XMII_LINK
    cleared

    ports 8 and 9 on YT9215RB no longer get SERDES_LINK cleared

Does a SerDes link really not need the XMIIn and MDIO_POLLINGn writes? If
it does need them, this looks like a regression on every SerDes-capable
chip. If those writes were wrong, could the commit message say so, so
that readers and backporters don't treat this as a pure refactor?

The split is still in place after the later "net: dsa: motorcomm: Add
SerDes PCS" patch in this series.

>  
> @@ -3876,17 +3883,16 @@ static int
>  yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
>  		   phy_interface_t interface)

[ ... ]

> @@ -3896,6 +3902,9 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
>  	case PHY_INTERFACE_MODE_100BASEX:
>  	case PHY_INTERFACE_MODE_1000BASEX:
>  	case PHY_INTERFACE_MODE_2500BASEX:
> +		if (!(BIT(port) & info->serdes_mask))
> +			goto err;
> +
>  		mask = YT921X_SERDES_CTRL_PORTn(port);
>  		res = yt921x_reg_set_bits(priv, YT921X_SERDES_CTRL, mask);
>  		if (res)
> @@ -3906,6 +3915,11 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
>  		if (res)
>  			return res;
>  
> +		/* The order is quite arbitrary - we can't return to a safe
> +		 * state on IO errors.
> +		 */
> +		pp->serdes = true;
> +

[Severity: Low]
What does yt921x_port_up() do if yt921x_port_config() returns before it
reaches this assignment?

Either of these writes can fail with an I/O error first:

	res = yt921x_reg_set_bits(priv, YT921X_SERDES_CTRL, mask);
	...
	res = yt921x_reg_clear_bits(priv, YT921X_XMII_CTRL, mask);

If one fails, pp->serdes keeps its devm_kzalloc() value of false. Because
yt921x_phylink_mac_config() only logs the error, phylink still calls
mac_link_up.

Port 8 on YT9215S, YT9214NB and YT9215SC is SerDes-only. On that port,
yt921x_port_up() gets past this check:

	if (!(BIT(port) & (info->serdes_mask | info->xmii_mask)))
		return 0;

It then goes into the bare else branch and writes YT921X_XMIIn(port) and
YT921X_MDIO_POLLINGn(port). SERDES_LINK is never set, the SerDes
speed/duplex is never programmed, and the function returns 0. If the
SERDES_CTRL write worked but the XMII_CTRL write failed, the SerDes lane
is already muxed in, yet link up programs the wrong block.

yt921x_port_down() only touches the XMII registers when info->xmii_mask
covers the port. Should the else branch in yt921x_port_up() check
info->xmii_mask as well?

The reverse can also happen. pp->serdes is set before the
YT921X_SERDESn MODE update below. If that update fails, link up forces
the SerDes link while the MODE field is still stale.

Before this patch both blocks were written, so a transient error here
could still end with a working link. The same logic is still there at
the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923021945.2203368-1-mmyangfl%40gmail.com
