Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1233DD526;
	Sat, 10 Oct 2026 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609267; cv=none; b=YrSm5QvJsJjiTnBJHUqEGJckIHxMhkLkY3uu5Dot4C7MHdD7ypGLzlLkn3dmpTVEKEeSSgGcGCFtVLL7qRH9e0AK+xMwydBRXkUg0Alf1Kk7qeijTwASAfwZ3fdHc1YSSzXqISXh2K6+50zx6R60wCS+fGlpSbYv+qHBDuNb9jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609267; c=relaxed/simple;
	bh=fZcBkqQ+qS3CLr6EwqhCkC8bqyk9nniFwdq1bKliiKo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p2aC+Wj+JEql8CBuqlzvFsh9sioqf9+gdnm/MlzxzXySkwixOE+V+8zCYQwUsJEmwTVpmJcS8v+u4kP7E69KyTQijr6INo7h7DrKISAiS4dNgdFjdPOKHm1/OCuMPo4PoVACEw3j1P7zTobIU6caq9x2UoBFO31cbZyQjXHwx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOgvwLLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOgvwLLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E401F000FF;
	Sat, 10 Oct 2026 05:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791609260;
	bh=7MVmSJWCIXAEcg7ysfqbqXIBpphkfmUEAevkdZlc2Xk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QOgvwLLIEXrxaT3hSdU7aMbSkJYcxPSgwPXB8n7HMP+MRkcxJpN66B9Di1I16G2iL
	 7y97C5jMuS3isVJRXHsNoc6oNkYkY3l1IZpFnooQfIz/GyqaHXxKnfZBr9t6nbmTB6
	 j067Fh3dYTx8JwtPdf8Pyh2Bpp+c4di6VbIGktAp/X9Wc68bxZVg41+Hnrj5n6t1+P
	 IUoREEiLr1IUEE1K8bksUe3xci/AHDYvMNPYB5VtToiLxQtOqlBkxuzKfZSHOWkVxZ
	 SejKyZaCH2AkI8MThqY2OGmEKlFu1d9/oZUBh6IZlCAxmAvV4bovzhSi9Am1gSQfvc
	 t2im4vA1LIziw==
Subject: Re: [PATCH net-next v2 7/8] net: dsa: realtek: rtl8365mb: add family
 D SDS13 PCS support
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:14:19 +0000
Message-ID: <179160925945.434549.12881167125289499223@kernel.org>
In-Reply-To: <a45bbcfe-9436-4800-bf23-553d1d566716@yahoo.com>
References: <a45bbcfe-9436-4800-bf23-553d1d566716@yahoo.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On family D (RTL8367S-VB), the SerDes path skips every SerDes-
  side speed, duplex and pause step, but phylink is still told the port…
- [Medium] In this commit, the family D `rtl8365mb_pcs_config()` writes
  the SDS_MISC mode field (bits 4:0) straight to SGMII (0x02) or HSGMII…
- [Low] The `struct rtl8365mb` kernel-doc says `@sds_supported` means
  "SerDes tuning parameters match the chip option, so the SerDes…
- [Low] Several comments in the SerDes PCS/MAC path still say the SerDes
  link parameters are forced, or reprogrammed, in…

--

net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support

This commit extends the RTL8367S SGMII/HSGMII PCS code to family D
switches, whose CPU SerDes is reached through the indexed SDS13 window.
It adds family D tuning tables and SDS_MISC encodings. The family D path
is chosen from the chip-family metadata, and family C is left unchanged.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 3819a48386006..4cad90f5c0181 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1398,6 +1435,14 @@ static int rtl8365mb_sds_probe_option(struct realtek_priv *priv)
>  	int ret;
>  	int i;
>  
> +	/* Family D has a fixed SDS13 programming model and does not use the
> +	 * family C option register to select its tuning table.
> +	 */
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
> +		mb->sds_supported = true;
> +		return 0;
> +	}
> +
>  	/* Nothing to probe if no external interface is wired to the SerDes */
>  	for (i = 0; i < RTL8365MB_MAX_NUM_EXTINTS; i++) {
>  		extint = &mb->chip_info->extints[i];

[Severity: Low]
This isn't a bug, but this early return skips both the extint scan ("Nothing
to probe if no external interface is wired to the SerDes") and the option
register check. The kernel-doc for struct rtl8365mb still says:

 * @sds_supported: SerDes tuning parameters match the chip option, so the
 *                 SerDes interface modes can be advertised

Should the kernel-doc be updated for family D?

rtl8365mb_setup() also calls rtl8365mb_sds_raise_rate_limits() whenever
sds_supported is set. As a result, every family D chip gets its port 6
ingress and egress rate limits rewritten.

RTL8367S-VB does have an SGMII/HSGMII extint on port 6, so nothing changes
today. The commit message says this code can be reused by other family D
boards, though. Would it make sense to keep the extint scan ahead of the
family D shortcut?

[ ... ]

> @@ -1526,34 +1590,53 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
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

[ ... ]

>  	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> -				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
> -					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
> -				 mode == RTL8365MB_EXT_PORT_MODE_SGMII ?
> -					 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK :
> -					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK);
> +				 misc_mask, misc_val);
>  	if (ret)
>  		return ret;

[Severity: Medium]
On family D, does this write give the SerDes receiver a mode edge to latch
on?

The mode field (bits 4:0) is written straight to SGMII (0x02) or HSGMII
(0x12). It is never parked at RTL8365MB_D_PORT_SDS_MODE_DISABLE (0x1f)
first.

The register may already hold the target value, either from the bootloader
or from an earlier pcs_config() with the same interface. In that case
regmap_update_bits() writes nothing. Even when the write does happen, it can
land before the far-end MAC is up.

At this point in the series, could the CPU-facing trunk then report link up
on both sides but pass no frames?

The later patch "net: dsa: realtek: rtl8365mb: re-latch the family D SerDes"
seems to fix this with rtl8365mb_sds_relatch_work(). That work parks
SDS_MISC at DISABLE, sleeps 20 ms, restores the target, and retries until
the link status bit is set. Could that logic be folded into this patch, so
this commit works on its own when bisecting?

[ ... ]

> @@ -1576,14 +1661,16 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
>  	 * forced from rtl8365mb_pcs_link_up() instead.
>  	 */
> -	ret = rtl8365mb_sds_read(priv, RTL8365MB_SDS_REG_NWAY, &val);
> +	ret = rtl8365mb_sds_read(priv, sds_index,
> +				 RTL8365MB_SDS_REG_NWAY, &val);

[Severity: Low]
This isn't a bug, but this comment is no longer accurate for family D,
because rtl8365mb_pcs_link_up() now returns right away there. Several other
comments say the same thing and are unchanged.

In rtl8365mb_pcs_get_state():

	/* In-band autonegotiation is not implemented, so the link parameters are
	 * forced from rtl8365mb_pcs_link_up(). ...

In rtl8365mb_phylink_mac_link_up():

	/* The SerDes forced link state is programmed by the PCS in
	 * rtl8365mb_pcs_link_up(); here only the MAC external interface force
	 * is configured, for both RGMII and SerDes.
	 */

In rtl8365mb_phylink_mac_link_down():

	 * enough to bring the link down; the SerDes keeps presenting its last
	 * forced state until the next pcs_link_up() reprograms it.

The comment above RTL8365MB_SDS_EXT_INTERFACE_ID also says:

/* The embedded SerDes can only be muxed to external interface 1 (MAC8),
 * which is port 6.
 */

However, the family D chip_info puts the SerDes on extint 0 (MAC6, through
SDS13).

Could these comments be updated to cover the family D path too?

[ ... ]

> @@ -1630,6 +1725,13 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
>  	if (!state->link)
>  		return;
>  
> +	if (is_d) {
> +		state->duplex = DUPLEX_FULL;
> +		state->speed = state->interface == PHY_INTERFACE_MODE_2500BASEX ?
> +				SPEED_2500 : SPEED_1000;
> +		return;
> +	}
> +
>  	/* The speed and duplex are forced; read them back from the values
>  	 * programmed into the SerDes MISC register.
>  	 */
> @@ -1671,6 +1773,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
>  	u32 r_speed;
>  	int ret;
>  
> +	/* Family D forces the external MAC ability from mac_link_up(); its
> +	 * SDS_MISC fields do not share the family C link-force layout.
> +	 */
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
> +		return;
> +

[Severity: Medium]
With this early return, does anything on family D program the SerDes for
10/100 or half duplex?

The family D SDS_MISC fields added here (PA33PC_EN, PA12PC_EN, MAC6_SEL_SDS0
and the 5-bit mode) have no speed or duplex field. pcs_config() also clears
NWAY, so no in-band code word carries the rate either. If the family D MAC
force register alone is enough for these modes, could a comment say so?

Pause has the same gap. The rtl8365mb_phylink_mac_link_up() hunk later in
this patch skips the SDS_MISC TXFC/RXFC write on family D:

	if (rtl8365mb_interface_is_serdes(interface) &&
	    rtl8365mb_get_family(priv) != RTL8365MB_FAMILY_D) {

Nothing replaces that write. The comment just above it says these SerDes
bits, "not the MAC force pause bits, gate pause on the SerDes external
interface".

The family D branch in rtl8365mb_pcs_get_state() above always reports
DUPLEX_FULL, plus SPEED_1000 or SPEED_2500.

When in-band AN is disabled, phylink_mac_pcs_get_state() fills in
state->speed and state->duplex from the forced link_config before it calls
pcs_get_state(). rtl8365mb_pcs_inband_caps() always returns
LINK_INBAND_DISABLE.

Take managed = "in-band-status" with 100/half forced through ethtool. Would
this branch replace those values with 1000/full? That would affect both what
ethtool reports and what the next mac_link_up() forces into the MAC.

Meanwhile, rtl8365mb_phylink_get_caps() still advertises:

	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
				   MAC_10 | MAC_100 | MAC_1000FD;

rtl8365mb_sds_probe_option() now sets sds_supported for every family D
chip. That means SGMII and 2500base-X are offered on the RTL8367S-VB port 6
extint.

Should the family D SerDes port limit its mac_capabilities to what this path
actually handles? Or should the commit message explain these limits? Right
now it only says the "SDS_MISC fields differ from family C", and this
appears unchanged at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/28382f3f-03c1-4606-9b11-86f118abeafe%40yahoo.com
