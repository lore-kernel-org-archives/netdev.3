Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2DA3ADB89;
	Tue, 13 Oct 2026 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853715; cv=none; b=tApV/QmCGzol/hPgfERAaCDy0AyAKrSy77N/WYHSRNwxP4wA5oYbvvCeUARYks/GRmOgXjyWrGFwR8dMgyR6AEiQG6r9JFPn3uruiS9a3V8UBpYFYDeA9Tfyf3jK7OGcJsUEh36EB+hb4anQ1tbdmgW09PJELtPdN2kqheRph9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853715; c=relaxed/simple;
	bh=RVxkoMRI0nNxGtF3x5VqRnhKh8gTXv7NdtIRqLZw5Uc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YIpxSBop4HnboJ+1cVi4Ne67mSBbxvqV+FVfV9Jit3lHO51+SyY0E2UgePmBnW/oFBOzBh+/N4/Wq9ppvsOx7fDNx4j4ZruuAKzohlJRSnVJ1mVsJl/1WG9El9Uo+fJF7hvnV6/6wPxyGHNHVyNl655zw7s0a9UqIBqSBrUw3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQJsRv0G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQJsRv0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1957E1F0089B;
	Tue, 13 Oct 2026 01:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791853713;
	bh=bdIv5RzGauIF0e3O4a90RMg8JRdNk/EsGUqLFONIWeA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NQJsRv0GNlIX2eJhhCDWa9kSsEz74aels638w1Nevz7ni0GgUDSHTigCQH+VBVOK6
	 kORM3ZTWr1ZoAmRUuXdJgZqmma/Cd2Je0SifI+11yDnLr/bmI/oVfw0AM6WbaVQtnn
	 IfAWZM50N0KGSDQU2HNQWpRZ6TSwRfmI2vyAihHVvIGgn6HNqHmjscKQJpKKCfyZcP
	 pAZ0O84EEWwGCOVlfi/ojkNyRK7rGUTAaIWGkBGc50/n3jJlmEFBvV+D6vVYApuGt1
	 tMbK04NOU0xMN4CWJPOuXB/QaxnVlHY9L0Jokn2vVYgA5QIDfNhFb6XRUEm9baiPbg
	 mtPRnINT36Ygg==
Subject: Re: [PATCH net-next v4 7/9] net: dsa: realtek: rtl8365mb: add family
 D SDS13 PCS support
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 01:08:31 +0000
Message-ID: <179185371166.434549.13425173660738123098@kernel.org>
In-Reply-To: <c35734ea-9f72-4688-8fdf-9843b5f887b6@yahoo.com>
References: <c35734ea-9f72-4688-8fdf-9843b5f887b6@yahoo.com>
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

- [Low] The patch makes rtl8365mb_pcs_link_up() return immediately on
  family D, so on family D the SerDes link is forced only by…
- [Low] net: dsa: realtek: inadvertent clobbering of SDS1 RX disable bit
  in pcs_config

--

net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support

This patch extends the RTL8367S SGMII/HSGMII PCS code to cover family D
switches. On those parts the CPU SerDes is reached through the indexed
SDS13 window, and the SDS_MISC fields are laid out differently from
family C. It adds family D tuning tables and an index argument to the
SerDes read/write helpers, and it adds family D branches to the PCS and
phylink MAC callbacks.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index f31d72aa0b9a9..d23e80f1d745d 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1667,6 +1778,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
>  	u32 r_speed;
>  	int ret;
>  
> +	/* Family D forces the external MAC ability from mac_link_up(); its
> +	 * SDS_MISC fields do not share the family C link-force layout.
> +	 */
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
> +		return;
> +

[Severity: Low]
This isn't a bug, but with this early return rtl8365mb_pcs_link_up()
programs nothing on family D. On those parts the SerDes link is forced
only by rtl8365mb_phylink_mac_link_up()->rtl8365mb_ext_config_forcemode().

Should two comments that still credit pcs_link_up() be updated too?

The first is the comment ahead of the forcing code in
rtl8365mb_phylink_mac_link_up():

	/* The SerDes forced link state is programmed by the PCS in
	 * rtl8365mb_pcs_link_up(); here only the MAC external interface force
	 * is configured, for both RGMII and SerDes.
	 */

The second is in rtl8365mb_phylink_mac_link_down():

	/* phylink has no pcs_link_down callback, so on the SerDes path only the
	 * MAC external interface force is reset here. Clearing the MAC force is
	 * enough to bring the link down; the SerDes keeps presenting its last
	 * forced state until the next pcs_link_up() reprograms it.
	 */

This patch updated the matching comments in rtl8365mb_pcs_config(),
rtl8365mb_pcs_get_state() and the pause block of
rtl8365mb_phylink_mac_link_up(). These two are still unchanged at the end
of the series.

[ ... ]

> @@ -1522,34 +1589,53 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  
>  	/* Tune the SerDes with vendor-prescribed parameters */
>  	for (i = 0; i < sds_jam_size; i++) {
> -		ret = rtl8365mb_sds_write(priv, sds_jam[i].reg,
> -					  sds_jam[i].val);
> +		ret = rtl8365mb_sds_write(priv, sds_index,
> +					  sds_jam[i].reg, sds_jam[i].val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Family-specific post-tuning configuration */
> +	if (is_d) {
> +		ret = regmap_update_bits(priv->map, RTL8365MB_D_FIBER_CFG2_REG,
> +					 RTL8365MB_D_FIBER_CFG2_RX_DISABLE_MASK,
> +					 RTL8365MB_D_FIBER_CFG2_RX_DISABLE_SDS0);
>  		if (ret)
>  			return ret;
> +
> +		misc_mask = RTL8365MB_D_SDS_MISC_CFG_MASK;
> +		misc_val  = RTL8365MB_D_SDS_MISC_PA33PC_EN |
> +			    RTL8365MB_D_SDS_MISC_PA12PC_EN |
> +			    RTL8365MB_D_SDS_MISC_MAC6_SEL_SDS0 | sds_mode;
> +	} else {
> +		/* Mux the SerDes to MAC8 in the requested mode */
> +		misc_mask = RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
> +			    RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK;
> +		misc_val  = (sds_mode == RTL8365MB_EXT_PORT_MODE_SGMII) ?
> +			    RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK :
> +			    RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK;
>  	}
>  
> -	/* Mux the SerDes to MAC8 in the requested mode */
>  	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> -				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
> -					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
> -				 mode == RTL8365MB_EXT_PORT_MODE_SGMII ?
> -					 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK :
> -					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK);
> +				 misc_mask, misc_val);
>  	if (ret)
>  		return ret;
>  
> -	val = mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
> -	ret = regmap_update_bits(priv->map,
> -				 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
> -				 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
> -				 val);
> -	if (ret)
> -		return ret;
> +	if (!is_d) {
> +		val = sds_mode << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
> +					 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
> +					 val);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* Take the SerDes out of reset. The vendor driver does this only
>  	 * after the SerDes mux and the interface mode are configured.
>  	 */
> -	ret = rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_RESET,
> +	ret = rtl8365mb_sds_write(priv, sds_index,
> +				  RTL8365MB_SDS_REG_RESET,
>  				  RTL8365MB_SDS_RESET_DEASSERT);
>  	if (ret)
>  		return ret;

[Severity: Low]
In rtl8365mb_pcs_config(), the family D branch updates
RTL8365MB_D_FIBER_CFG2_REG using RTL8365MB_D_FIBER_CFG2_RX_DISABLE_MASK
as the mask, which is GENMASK(7, 6), but the value written is only
RTL8365MB_D_FIBER_CFG2_RX_DISABLE_SDS0, i.e. BIT(6). So besides
setting bit 6, every call also clears bit 7 of that register.

Going by the field names, bit 7 is the RX disable bit for the second
SerDes (SDS1). Clearing it here re-enables the SDS1 fiber RX path as a
side effect of configuring the CPU SerDes. That happens regardless of
how SDS1 is actually used on the board.

rtl8365mb_ext_config_rgmii() goes out of its way to put SDS1 into the
disabled mode through RTL8365MB_D_REG_SDS1_MISC0 when ext1 is RGMII.
Dropping the SDS1 RX disable bit here seems at odds with that.

Is clearing bit 7 intentional, for example because the vendor RTL8367D
API writes the whole 2-bit field with 0x1? If so, a comment saying so
would help. If not, should the mask be limited to
RTL8365MB_D_FIBER_CFG2_RX_DISABLE_SDS0 so that only the SDS0 bit is
touched?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/38872e6f-1264-4a93-9f81-8212173e909d%40yahoo.com
