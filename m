Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A43A5422;
	Wed, 14 Oct 2026 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968206; cv=none; b=ic2UHicYpOVonHza1GwCRP1GcNrVpUrL4q4wX9JCzq9aA9Z02YuZrBGhP8OiSL7Zcv7JGblRB/VyEPTFS5ww+hJcGQdR2TyYF3TliceCTVSgZlRPgnwtq2T1ZJH5lczpJKXMRnGOXTfa34d6vB7JmEtllQf149+4dz9EtERCv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968206; c=relaxed/simple;
	bh=DdobtFWUj8oH1w4ewoHaOH+xf8a6lXJJxyba1EXiZYQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=toOLISEeoDZAcEBFfW6hsoMV37Q11S6mp+KdNiRGHMUErCg8FAk3VosnlSbrLRvB4ENhuxN06vvZXeqH+GURBl7y3qBzdMsNwqCpWngHahoi5ZVmLw7Ihp22dSLiNCpjKoxMKYkkjIpwATmzf5UZpdYZu8odP+5prnCSx4UJa50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luBrs7UO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luBrs7UO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD771F000FF;
	Wed, 14 Oct 2026 08:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968203;
	bh=xztNzQ9/A0bOHND9JAVgt7qP89tokxBZ8olp6TrdoVU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=luBrs7UO+NKWkTEPNgmRxqxObwmQ6d1lfG+A8fu4Gp7UXbWH3zIYp6ZiW9RHvXS2o
	 HjII2Ek0xNA664IrzZYJkr+EvG2kTM3UPLNHX+4BHcc2lb4kmccFE7nUVnFENGUuhL
	 r9M0TAO+Hp8zicEJZw4J7YUJck/tzrJSAD6auQ+5LC8vP5U/EBTZ4kB4uE98weJ0VX
	 eyhoaUy5H/IRcd29Xmybu9PQdy5r368ggdOWO+L4ZJOQyNFZXlkxn/cxRUeb7XNHAf
	 k0xIC4LAseqc44DVObK8G024RT4yjf/xw6RjpDsdOlXpO3Ajzd/67OVxSP8k08mErE
	 DUgUwzuL3khvw==
Subject: Re: [PATCH net-next v5 4/9] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 08:56:42 +0000
Message-ID: <179196820243.434549.6149690015527532487@kernel.org>
In-Reply-To: <3e67227c-9427-4c0c-964e-b6e72d906f13@yahoo.com>
References: <3e67227c-9427-4c0c-964e-b6e72d906f13@yahoo.com>
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

- [Medium] On family D, rtl8365mb_ext_config_rgmii() reads TOP_CON0 and
  returns -EBUSY for extint id 1 when RTL8365MB_D_MAC4_SEL_EXT1_MASK…
- [Low] The concern: in rtl8365mb_ext_config_rgmii(), family D EXT1 is
  switched to RGMII in DIGITAL_INTERFACE_SELECT before EXT_TXC_DLY[5:3]…

--

net: dsa: realtek: rtl8365mb: set RGMII mode for family D

On family D, this commit clears the EXT1 RGMII TX clock delay field in
EXT_TXC_DLY and binds the RGMII/MII pins to MAC7 in TOP_CON0. It also
disables SerDes 1 when RGMII is configured on extension interface 1. If
MAC4 already owns extension 1, it returns -EBUSY before touching any EXT1
register.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 2dabc4da861f4..ff9d9d1c2bc0c 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1201,12 +1221,26 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
>  	struct dsa_port *dp;
>  	int tx_delay = 0;
>  	int rx_delay = 0;
> +	u32 data;
>  	u32 val;
>  	int ret;
>  
>  	if (!extint)
>  		return -ENODEV;
>  
> +	/* On family D the EXT1 pins are shared with MAC4 (UTP port 4). If
> +	 * MAC4 owns them, RGMII on this port cannot work, so do not touch
> +	 * any EXT1 register.
> +	 */
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> +	    extint->id == 1) {
> +		ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
> +		if (ret)
> +			return ret;
> +		if (data & RTL8365MB_D_MAC4_SEL_EXT1_MASK)
> +			return -EBUSY;
> +	}

[Severity: Medium]
Is the RGMII configuration actually refused here? The commit message says:

  "If the internal MAC4 block occupies extension 1, refuse the RGMII
  configuration with -EBUSY before any EXT1 register is touched."

The only caller is the void phylink callback rtl8365mb_phylink_mac_config(),
which just logs the error and returns:

    if (phy_interface_mode_is_rgmii(state->interface)) {
        ret = rtl8365mb_ext_config_rgmii(priv, port, state->interface);
        if (ret)
            dev_err(priv->dev,
                "failed to configure RGMII mode on port %d: %pe\n",
                port, ERR_PTR(ret));

The driver has no mac_prepare or mac_finish, and mac_select_pcs returns
NULL for RGMII. So phylink never sets major_config_failed, and
phylink_resolve() goes on to bring the link up:

phylink_resolve()->phylink_link_up()->rtl8365mb_phylink_mac_link_up()

rtl8365mb_phylink_mac_link_up() then forces the port up for any RGMII
interface without checking TOP_CON0 again:

    if (phy_interface_mode_is_rgmii(interface) ||
        rtl8365mb_interface_is_serdes(interface)) {
        ret = rtl8365mb_ext_config_forcemode(priv, port, true, speed,
                                             duplex, tx_pause,
                                             rx_pause);

On family D, rtl8365mb_ext_config_forcemode() writes
RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG(port) with link set. It also sets
RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG_EN(port) to
RTL8365MB_D_DIGITAL_INTERFACE_FORCE_EN_ALL_MASK.

Take an RTL8367S-VB with extint {7, 1, RGMII}, where TOP_CON0 bit 12 is
set and DT describes port 7 as an RGMII fixed-link CPU port. Wouldn't
phylink and DSA report port 7 as configured and link-up while its traffic
is silently lost? The only sign would be the dev_err(), repeated on every
major reconfiguration.

The check does stop MAC7_SEL_EXT1 from being written, so MAC4 keeps its
pins. Would it be better to return the error through a hook phylink
honours, such as mac_prepare? Another option is to leave RGMII out of
supported_interfaces in rtl8365mb_phylink_get_caps() when TOP_CON0 bit 12
is set. At a minimum, the force in mac_link_up could be skipped.

> +
>  	dp = dsa_to_port(ds, port);
>  	dn = dp->dn;
>  

[ ... ]

> @@ -1270,6 +1304,32 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
>  	if (ret)
>  		return ret;
>  
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> +	    extint->id == 1) {
> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_EXT_TXC_DLY,
> +					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
> +		if (ret)
> +			return ret;
> +
> +		/* Bind the RGMII/MII pins to MAC7; MAC4 does not own them,
> +		 * see the check at the top of the function.
> +		 */
> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_TOP_CON0,
> +					 RTL8365MB_D_MAC7_SEL_EXT1_MASK,
> +					 RTL8365MB_D_MAC7_SEL_EXT1_MASK);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_SDS1_MISC0,
> +					 RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK,
> +					 RTL8365MB_D_PORT_SDS_MODE_DISABLE);
> +		if (ret)
> +			return ret;
> +	}

[Severity: Low]
This is a minor question about ordering. EXT1 is switched to RGMII in
RTL8365MB_DIGITAL_INTERFACE_SELECT_REG() just above this block. Only after
that does the code clear EXT_TXC_DLY[5:3], set MAC7_SEL_EXT1 in TOP_CON0,
and disable SerDes 1 in SDS1_MISC0.

phylink only calls mac_config with the link down, so no traffic should
cross the pins during this window. The existing comment's constraint (delays
programmed before the forcing in mac_link_up) also holds.

Does the vendor sequence set the pin mux and disable SerDes 1 before
selecting RGMII mode? If one of these regmap writes fails partway through,
the shared EXT1 pins are left half-configured and nothing rolls them back.
Is that acceptable here?

>  	return 0;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4%40yahoo.com
