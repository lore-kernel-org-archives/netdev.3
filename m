Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281A469842;
	Sun, 11 Oct 2026 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748290; cv=none; b=X+3/Kdci2UMJN8EVYENcj0agSeoaZZ8R1TIIenUlTccOUVlefvcirDjXp23rGWZ2gUXvzX0jyTTfHMdmO5J2lPXo8D/fgLEKB/cXtnrKjGua2nS4Pa2M8mpI7w3n4SoRDVHQxKdSShElCTfuZIC9pSugcuOndf+TeJsB8z/wNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748290; c=relaxed/simple;
	bh=3A58AOeIzlGZUCy0i922DP6jc7xGw5dOexr57GVQoGU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LohaS8/Y0zuk9HIbgDqNifgfNYZjGbkVM0aNEwkpAtkU7PU0PEr6dceHtvJ5VZEj+zO9OcuVpk3lmzijIqyL6Y1UWLBkqi/wrcfa7YXwFJrf7UYv13qD4jNHG2wbVuzH4niEqEPPP898nG7MrJUWVpiBWHRLMjvzVH03wtZ0Y2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RczqQ3Ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RczqQ3Ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B8D1F0089B;
	Sun, 11 Oct 2026 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748288;
	bh=Eo/N36p0ilcIwmDzB3tYqSupqdjuUykDGuocfXUKM98=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RczqQ3CeVcUKKMfe3HfdkiUBPU92KAYDHm/NYu1OBJ6zOJ6+SwUDo/tXPVOT6P8s9
	 LMUy7AgVZMTgTNzCYZKS95kdKaeAOn+6dwBQup1fzt1RCRmqg0yWAKR47NbqehUeol
	 ZN8GvHmJQjX9pdkxPcu8R+LmAisrXI3dPCKmMvSSnpX2K7UpcBdmY6H7P0JbNWdTPH
	 NoDrfSVsrYVZqBBA5DNqLnikY4txolHrSWFD8VHNRWnkYPwyTs9ObZ0mxdOwFRt3Pp
	 zFBhXmFpwThlJV2Lsb5VHIYUf1ow3Fix/Kyt/CmKhNV7mLLEG7lBApu6NwkzH7R/wv
	 ifFbUc6BCTA+w==
Subject: Re: [PATCH net-next v3 7/9] net: dsa: realtek: rtl8365mb: add family
 D SDS13 PCS support
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:51:27 +0000
Message-ID: <179174828775.434549.10987792477801998559@kernel.org>
In-Reply-To: <a982eb30-e977-4b8c-8526-16027c02a6c2@yahoo.com>
References: <a982eb30-e977-4b8c-8526-16027c02a6c2@yahoo.com>
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

- [Low] At this commit, every new family D branch is dead code.
- [Low] Several unconditional comments are wrong for family D after this
  patch: (a) rtl8365mb_pcs_config() line 1649 says "Keep SGMII in-band…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  rtl8365mb_pcs_ops has no .pcs_an_restart, and phylink calls that…

--

net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support

This patch extends the rtl8365mb SGMII/HSGMII PCS code to family D
switches, whose CPU SerDes is reached through the indexed SDS13 window.
It adds an index argument to the SDS indirect accessors, family D tuning
tables and SDS_MISC settings, and skips the family C link forcing in
pcs_link_up() and mac_link_up() on family D.

> Extend the existing RTL8367S SGMII/HSGMII PCS implementation in this
> driver for family D switches, whose CPU SerDes is reached through the
> indexed SDS13 window and whose SDS_MISC fields differ from family C.

[Severity: Low]
This isn't a bug, but at this commit every entry in rtl8365mb_chip_infos[]
is RTL8365MB_FAMILY_C. So rtl8365mb_get_family() never returns
RTL8365MB_FAMILY_D.

That makes all the new is_d branches unreachable for now:

  - rtl8365mb_pcs_config()
  - rtl8365mb_pcs_get_state()
  - rtl8365mb_pcs_link_up()
  - rtl8365mb_phylink_mac_link_up()
  - the family D early return in rtl8365mb_sds_probe_option()

They only become reachable with the later patch in the series, "net: dsa:
realtek: rtl8365mb: add support for RTL8367S-VB". That patch adds a
family D chip_info entry.

Could the commit message say that this patch is preparatory, and that the
code is enabled by the RTL8367S-VB patch?

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index c15b88ba7bb5c..0d3a2a385a204 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1565,14 +1650,16 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
>  	 * forced from rtl8365mb_pcs_link_up() instead.
>  	 */
> -	ret = rtl8365mb_sds_read(priv, RTL8365MB_SDS_REG_NWAY, &val);
> +	ret = rtl8365mb_sds_read(priv, sds_index,
> +				 RTL8365MB_SDS_REG_NWAY, &val);
>  	if (ret)
>  		return ret;

[Severity: Low]
This isn't a bug, but does this comment still hold for family D? With this
patch, rtl8365mb_pcs_link_up() returns right away on family D.

Several other comments that apply to both families have the same problem
after this change:

In rtl8365mb_pcs_get_state():

    /* In-band autonegotiation is not implemented, so the link parameters are
     * forced from rtl8365mb_pcs_link_up(). ...

The family D branch there hard-codes DUPLEX_FULL and takes the speed from
state->interface instead.

In rtl8365mb_phylink_mac_link_up():

    /* The SerDes forced link state is programmed by the PCS in
     * rtl8365mb_pcs_link_up(); ...

This is not true on family D.

Above RTL8365MB_SDS_EXT_INTERFACE_ID:

    /* The embedded SerDes can only be muxed to external interface 1 (MAC8),
     * which is port 6.
     */

The new family D defines (RTL8365MB_D_SDS_EXT0_INDEX and
RTL8365MB_D_SDS_MISC_MAC6_SEL_SDS0) put the SerDes on EXT0/MAC6. The
RTL8367S-VB chip_info added at the end of the series also uses extint
id 0.

The family D path in rtl8365mb_pcs_config() still applies
RTL8365MB_SDS_BYPASS_LINE_RATE_MASK, which is built from
RTL8365MB_SDS_EXT_INTERFACE_PORT. However, the BYPASS_LINE_RATE comment
says the port-to-bit mapping "only holds for the RTL8367C-style parts
this driver supports".

None of these comments change by the end of the series. Could they be
updated to cover family D?

[ ... ]

> @@ -1660,6 +1762,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
>  	u32 r_speed;
>  	int ret;
>  
> +	/* Family D forces the external MAC ability from mac_link_up(); its
> +	 * SDS_MISC fields do not share the family C link-force layout.
> +	 */
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
> +		return;
> +

[Severity: High]
This is a pre-existing issue, but rtl8365mb_pcs_ops has no .pcs_an_restart
callback:

static const struct phylink_pcs_ops rtl8365mb_pcs_ops = {
	.pcs_inband_caps = rtl8365mb_pcs_inband_caps,
	.pcs_config = rtl8365mb_pcs_config,
	.pcs_get_state = rtl8365mb_pcs_get_state,
	.pcs_link_up = rtl8365mb_pcs_link_up,
};

phylink calls that callback without a NULL check:

drivers/net/phy/phylink.c:phylink_pcs_an_restart() {
	if (pl->pcs && linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
					 pl->link_config.advertising) &&
	    phy_interface_mode_is_8023z(pl->link_config.interface) &&
	    phylink_autoneg_inband(pl->act_link_an_mode))
		pl->pcs->ops->pcs_an_restart(pl->pcs);
}

Suppose the DT gives port 6 phy-mode = "2500base-x" and
managed = "in-band-status":

  - phylink_parse_mode() sets Autoneg in the advertising mask.
  - pcs_inband_caps reports LINK_INBAND_DISABLE, so phylink_pcs_neg_mode()
    sets pcs_neg_mode to PHYLINK_PCS_NEG_INBAND_DISABLED.
  - act_link_an_mode still stays MLO_AN_INBAND.

Can this then oops during port setup through this path?

dsa_port_enable_rt()
  phylink_start()
    phylink_mac_initial_config(pl, true)
      phylink_major_config(..., restart = true)
        phylink_pcs_config()
          rtl8365mb_pcs_config()
        phylink_pcs_an_restart()
          pl->pcs->ops->pcs_an_restart(pl->pcs)   <-- NULL

rtl8365mb_phylink_mac_config() only logs an error for in-band mode.
There is no pcs_validate or mac_prepare to reject the configuration
earlier.

The same path already exists for family C (RTL8367S, RTL8367SB with
HSGMII). This patch adds family D (RTL8367S-VB at the end of the series)
as another way to reach it.

Should rtl8365mb_pcs_ops provide a .pcs_an_restart callback?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/e84d76ee-03df-49b0-8c9a-b289dfae8728%40yahoo.com
