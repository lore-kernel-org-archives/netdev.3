Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28F3AFCEC;
	Mon, 21 Sep 2026 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019854; cv=none; b=c24Zl2EMH43LT+f3u3noWWBOt2MJns1WxDZQ0ngonlDsPSEMZIMOmVwitt1ZeUdJHCgqUqEVMauQU//m4vR0/ZwQ+zpGT/7QKlQ05BqheOXn6vo7U4jCL6L6QtPwyiPwh9EI2yaJv5zSmZtz4ynLUEUHqfC+KX1ynUE8NGaIgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019854; c=relaxed/simple;
	bh=iLU+T4dsvu0FgybBcA0IX3oa9P9+HMULBx/wVylofiI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hx2Th8607UofVi/M7h+YCJJy3bj9gscaXK8u4svwRKnn3IyDlx4jcrbI5euX3n1ql9b+FimJGuqIBkGt41cDTllCoWn47LPgQrcA+PTiLn17DATkq9WI7EROy7cZj+OcnAbQEeBSq9bOPNLHXrmauG8MW9r2VFbAUSnnMScmmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn2cY2yh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn2cY2yh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA361F000FF;
	Mon, 21 Sep 2026 19:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790019852;
	bh=XLCkND4IduTpuyRUPB3YnBAfzMrdpMsjQcaALhgXvs4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hn2cY2yhJ6Cyaoz6UxCVhhqDm6FVOkHbNmTu0Fsp4zLKVODJhD3gQ321Dbvvv8ahB
	 rLHVyXST66B+80bwuI8DfNMYQsMKi55kNeKOaujUOUoam10RJbQZqFH6ddejjvh9gb
	 z6A0e8GqggI5mwn3ApRkV+Gkb6fi6/y/9a/GE5gaZzh79sj4L3Mb9IsNA5Ye+Hpb6L
	 bk0GqqEuM1l+oUUtCgUIqtVHaFPbK+Yww3UmSNoQ+K8NEm1pVHtWwl3XJJS/QqAWlq
	 lndfTB1ydXPdnASza2s2niBYpx0rdn8t39Y7azJQPDcyqurQzPLnlkIhPSGRLtSnIu
	 rUSCWDL72pH7Q==
Subject: Re: [PATCH net-next v3 3/8] net: dsa: motorcomm: Check port type with
 runtime info
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 19:44:11 +0000
Message-ID: <179001985166.2160803.9562894284788810196@kernel.org>
In-Reply-To: <20260917185010.3189199-4-mmyangfl@gmail.com>
References: <20260917185010.3189199-4-mmyangfl@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] yt921x_port_up() (drivers/net/dsa/motorcomm/chip.c) selects
  between the SerDes register block and the xMII register block solely…
- [Low] Concern (not confirmed as a defect): the patch carries no Fixes:
  tag and does not name the chip/port failure it corrects, although the…

--

net: dsa: motorcomm: Check port type with runtime info

This drops the yt921x_port_is_internal/external() macros, which hardcoded
ports 8 and 9 as external on every chip, and instead derives the port type
from the per-chip masks in struct yt921x_info plus a new per-port pp->serdes
flag set by yt921x_port_config().

A couple of questions below about the new pp->serdes flag and about the
missing Fixes: tag.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index b527a9cfd3e86..bcc9542370c2f 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
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

[Severity: High]
Here the teardown is gated on info->xmii_mask, but yt921x_port_up() below
picks the xMII branch based on pp->serdes instead.  Can the two disagree?

For port 8 of YT9215SC/YT9215S/YT9214NB the yt921x_infos entries have the
port in serdes_mask but not in xmii_mask:

	{ "YT9215S", YT9215_MAJOR, 2, 0, GENMASK(4, 0), BIT(9), BIT(8), },

If yt921x_port_up() takes the else branch for such a port it sets
YT921X_XMII_LINK on YT921X_XMIIn(port), and yt921x_port_down() will then
never clear it again because BIT(port) & info->xmii_mask is zero.

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

[Severity: High]
The capability gate above accepts a port that is only in serdes_mask, and
after that the register block is chosen purely from pp->serdes, not from
info->xmii_mask.  Is "!pp->serdes" equivalent to "this port has an xMII
block"?

That looks like the same hardcoded-layout assumption the changelog sets out
to remove, only expressed through a flag rather than a port number.

> @@ -3836,7 +3843,7 @@ yt921x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
>  					     mask, ctrl);
>  		if (res)
>  			return res;
> -
> +	} else {
>  		mask = YT921X_XMII_LINK;
>  		res = yt921x_reg_set_bits(priv, YT921X_XMIIn(port), mask);
>  		if (res)

[Severity: High]
Can this else branch be reached with pp->serdes stale-false on a port that
was already muxed to SerDes in hardware?

yt921x_port_config() commits the mux first and only sets pp->serdes at the
very end of the SerDes case:

	mask = YT921X_SERDES_CTRL_PORTn(port);
	res = yt921x_reg_set_bits(priv, YT921X_SERDES_CTRL, mask);
	if (res)
		return res;
	...
		pp->serdes = true;

So if any register access between those two points fails (an SMI/MDIO
transfer error), yt921x_port_config() returns early with the port muxed to
SerDes while pp->serdes is still false.

yt921x_phylink_mac_config() is void and can only log it:

	res = yt921x_port_config(priv, port, mode, state->interface);
	mutex_unlock(&priv->reg_lock);

	if (res)
		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "config", port, res);

phylink only forces the link down when pl->major_config_failed is set, and
that flag comes from mac_select_pcs/mac_prepare/pcs_config/mac_finish
errors, not from mac_config:

drivers/net/phy/phylink.c:phylink_resolve() {
	...
	if (pl->major_config_failed)
		link_state.link = false;
	...
}

phylink then proceeds to mac_link_up() -> yt921x_port_up(), which passes
the serdes_mask|xmii_mask gate and takes this else branch: it writes
YT921X_XMII_LINK and YT921X_MDIO_POLLINGn(port) for a port that may have no
xMII block, and never asserts YT921X_SERDES_LINK or the SerDes
speed/duplex/pause fields, so the port stays down while the kernel reports
carrier up.

Nothing re-derives pp->serdes afterwards, since phylink re-runs the major
config only on interface change or forced reconfiguration.

Would gating the else branch on BIT(port) & info->xmii_mask, or deriving the
branch from the validated interface argument, avoid this?  Alternatively,
recording the mux selection as soon as YT921X_SERDES_CTRL is committed would
keep pp->serdes in sync with the hardware.

> @@ -3928,13 +3937,21 @@ yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
>  		if (res)
>  			return res;
>  
> +		/* The order is quite arbitrary - we can't return to a safe
> +		 * state on IO errors.
> +		 */
> +		pp->serdes = true;
>  		break;

[Severity: High]
This is the only writer of pp->serdes, and it runs after the mux writes
(YT921X_SERDES_CTRL set, YT921X_XMII_CTRL cleared) and after the SERDES mode
update, each of which returns on error.  The comment acknowledges that a
safe state cannot be restored, but the flag is later used to decide which
register block yt921x_port_up() touches.  Should the flag be set before the
fallible writes so that software and hardware do not end up disagreeing, or
should yt921x_port_up() not depend on it at all?

This was verified to still be the case at the end of the series (the
"net: dsa: motorcomm: Add SerDes PCS" commit keeps both the "if (pp->serdes)"
test and the late "pp->serdes = true"), so no later patch changes this.

> diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
> index 83e76cefbccd5..fd552f7dced4d 100644
> --- a/drivers/net/dsa/motorcomm/chip.h
> +++ b/drivers/net/dsa/motorcomm/chip.h
> @@ -858,9 +858,6 @@ enum yt921x_fdb_entry_status {
>  
>  #define YT921X_NAME	"yt921x"
>  
> -#define yt921x_port_is_internal(port) ((port) < 8)
> -#define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
> -

[Severity: Low]
This isn't a bug, but the changelog describes these macros as wrong while
the patch carries no Fixes: tag and does not name a chip or port that
misbehaves.  They were added in 186623f4aa724c and refined in f2596ce59b151b,
both recent enough for a tag.

As far as could be checked, the paths the changelog mentions are already
gated: yt921x_dsa_phylink_get_caps() advertises PHY_INTERFACE_MODE_INTERNAL
only for info->internal_mask ports and the SerDes modes only for
info->serdes_mask ports, and phylink_create() rejects an empty
supported_interfaces set:

	if (phy_interface_empty(config->supported_interfaces)) {
		dev_err(config->dev, "phylink: error: empty supported_interfaces\n");
		return ERR_PTR(-EINVAL);

so the dummy ports and xMII-only ports never reach these callbacks, and the
new "if (!(BIT(port) & info->serdes_mask)) goto err;" check rejects
something phylink would not request either.

Is this intended as a hardening/refactor step ahead of the SerDes PCS work,
or as a fix?  If the latter, could a Fixes: tag and the affected chip/port be
named?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917185010.3189199-1-mmyangfl%40gmail.com
