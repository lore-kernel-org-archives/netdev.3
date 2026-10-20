Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460490;
	b=vv858ZREanOa9H7baTtozRhPjnyrdbZ1x5qBgQgpzQp/Utoc+e/H1vnQhlnMKeuHD2jE
	 9MLx/V7gC7rmllA/DGLCLmw51A4r/eWF3mauME67oef/pvV1vxf7ZeyoJoP3oG3CzaOyI
	 WGgz+h7OZd3zODibwJDQ9ITQ3PrOPxCtGr+wrdnH5RB6vfDCWCUYvfMeF87y5+aZM4ZYL
	 AYsAGHEudGa6hfnVHrpb0kgD6o4hF/NM9P/A8JUSwHeXPm3t2/6KBV/bWSMmK2WD9ep+g
	 fVNuI6SaMry979v0/BvrJH0UFLNYKdBrypCDQJxMx7V3GXEXGEb+YLA9QR+bf0mTMLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460490;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JaW0Sa8+8s9JtpmJ9NEF3RVrWWI4PzMiemCJ0QAXzTs=;
	b=OaJPXdoE+rgDGq0+ReywebjPNqtYD8Kd1Hpl2eHYcrBmraPLFJUUlM2JbmdYo31oyiT3
	 ZD1KkhRToacX7nfVfDpQEVS6pwxegIzmy72gg2wDIvURVN4dRJxxA1ru8l6MzB9VVHNqI
	 rvT/3/E6Dd/+PdfecXcYp3rPb0GQel/W0MCqbM+k9C/7+N3mAtI80U33isVmOprN9lD0r
	 Qzqw2fUvhJpjbwfL6oGnMlKM8jOuDYGa6GbBxVC/x1fQCJWx++KDEh05c3Isl2rmaH42h
	 2By3rOYhZPWCYO1T7r8t9SRT8MVD0EvIWc3JjI/1VLIL0L/aOHAxrpCKI7pq7jaEuvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjS7SNfG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B4606A322;
	Tue, 20 Oct 2026 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CjS7SNfG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5673B1F000C7;
	Tue, 20 Oct 2026 01:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460490;
	bh=JaW0Sa8+8s9JtpmJ9NEF3RVrWWI4PzMiemCJ0QAXzTs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CjS7SNfGzaX1jzv0AndZ/y/gG80ag9G1GsNOFqMZlm9ZV4/kJt2S9/GztILFnRjpw
	 dVJR1Q/L5DMWKApZHRIxtzTDZ0C2jUJei/4FXn369zr+gcyw4blVnxReWGgqxp751u
	 9/I8ilzM/kZ56GhGjk0n1baq2vY23n2kJizTE+WHP0sRnRhM5jlsFmoPBtAQPWTPza
	 4dPQS8pywGU4hmEylQAg81TyZP1f0yIe7rUnE1Hk1UBE8QyOwHJTMeoKSeH4a9LPQK
	 f8VbhD7kq0/eBYqrTm16Qm/0cwZoOnzfjxEb1mWSfFVx2ZetH7W4/3FrawvBtMKukp
	 Z86l0phZiZ2GA==
Subject: Re: [PATCH net-next v6 4/9] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 01:41:28 +0000
Message-ID: <179246048886.3135.6585155779624882591@kernel.org>
In-Reply-To: <aca905a9-9cc2-456d-ba5f-2d9425f1b5c1@yahoo.com>
References: <aca905a9-9cc2-456d-ba5f-2d9425f1b5c1@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] rtl8365mb_phylink_get_caps() drops RGMII without logging anything
  when TOP_CON0.MAC4_SEL_EXT1 (BIT(12) of 0x1d70) is set on family D…
- [Low] At this commit the two parts of the code describe EXT1
  differently.
- [Low] On family D EXT1, rtl8365mb_ext_config_rgmii() writes in this
  order: RGMXF delays, DIGITAL_INTERFACE_SELECT = RGMII, clear…

--

net: dsa: realtek: rtl8365mb: set RGMII mode for family D

This patch adds family D handling for RGMII on extension interface 1. It
clears the EXT1 RGMII TX delay field in EXT_TXC_DLY, binds the pins to
MAC7 through TOP_CON0, and disables SerDes 1. RGMII is also no longer
advertised for port 7 in rtl8365mb_phylink_get_caps() when TOP_CON0 shows
that MAC4 owns EXT1.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 2dabc4da861f4..f00c1c24014a0 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1270,6 +1290,33 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
>  	if (ret)
>  		return ret;
>  
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> +	    extint->id == 1) {

[Severity: Low]
At this point in the series, does this model of EXT1 disagree with the
existing SerDes comment and constants near the top of
rtl8365mb_main.c?

/* The embedded SerDes can only be muxed to external interface 1 (MAC8),
 * which is port 6.
 */
#define RTL8365MB_SDS_EXT_INTERFACE_ID		1
#define RTL8365MB_SDS_EXT_INTERFACE_PORT	6

Those apply to every family. The new family D code treats extint id 1 as
the RGMII interface of MAC7 and disables SerDes 1 on it.

Later patches in the series fix this. The comment is rewritten to say
family D has the SerDes on external interface 0 (MAC6), and
rtl8365mb_pcs_config() skips the EXT1 DIGITAL_INTERFACE_SELECT write on
family D. Family D also can't be reached until the last patch.

Could the comment be qualified in this patch so both descriptions agree
at every point in the series?

> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_EXT_TXC_DLY,
> +					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
> +		if (ret)
> +			return ret;
> +
> +		/* Bind the RGMII/MII pins to MAC7. MAC4 does not own them:
> +		 * RGMII is not advertised otherwise, see
> +		 * rtl8365mb_phylink_get_caps().
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
Is this write order intended? The TOP_CON0 pin mux and the SDS1_MISC0
SerDes 1 disable are written only after DIGITAL_INTERFACE_SELECT has
already been switched to RGMII just above.

Suppose SerDes 1 was active before mac_config (from strap or EEPROM, for
example), and the hardware drives the shared pins as soon as RGMII is
selected. Could RGMII and SerDes 1 then both be set up on the same pins
for a few SMI transactions?

Nothing is unwound if one of these writes fails partway through, either.
rtl8365mb_phylink_mac_config() only logs the error:

	ret = rtl8365mb_ext_config_rgmii(priv, port, state->interface);
	if (ret)
		dev_err(priv->dev,
			"failed to configure RGMII mode on port %d: %pe\n",
			port, ERR_PTR(ret));

After that, rtl8365mb_phylink_mac_link_up() can still force the MAC link
up through rtl8365mb_ext_config_forcemode(), with the mux or TX delay
only partly programmed.

The existing RGMXF and DIGITAL_INTERFACE_SELECT writes, and
rtl8365mb_pcs_config(), behave the same way. The concern also depends on
hardware behaviour that hasn't been confirmed.

Does the vendor RTL8367D code set the mux and disable SerDes 1 before it
selects RGMII mode?

[ ... ]

> @@ -1802,8 +1851,23 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
>  	 * which remain unimplemented.
>  	 */
>  
> -	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII)
> -		phy_interface_set_rgmii(config->supported_interfaces);
> +	if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_RGMII) {
> +		/* On family D the EXT1 pins are shared with MAC4 (UTP port 4).
> +		 * If MAC4 owns them, RGMII on this port cannot work.
> +		 */
> +		if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> +		    extint->id == 1) {
> +			ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
> +			if (ret)
> +				dev_warn(priv->dev,
> +					 "failed to read TOP_CON0, RGMII on port %d disabled: %pe\n",
> +					 port, ERR_PTR(ret));
> +			else if (!(data & RTL8365MB_D_MAC4_SEL_EXT1_MASK))
> +				phy_interface_set_rgmii(config->supported_interfaces);

[Severity: Low]
When MAC4_SEL_EXT1 is set, RGMII is dropped here with no message. Only
the regmap_read() failure branch warns.

The commit message says:

    If the internal MAC4 block occupies extension 1, do not advertise RGMII
    for port 7 in phylink_get_caps(), so the configuration is refused before
    any EXT1 register is touched.

How would a user find out why it was refused?

The last patch in the series adds the RTL8367S-VB entry, where port 7 is
{ 7, 1, MII|TMII|RMII|RGMII }. MII, TMII and RMII are still not
implemented in rtl8365mb_phylink_mac_config(), so supported_interfaces
ends up empty. phylink_create() then fails with only the generic message:

	if (phy_interface_empty(config->supported_interfaces)) {
		dev_err(config->dev,
			"phylink: error: empty supported_interfaces\n");
		return ERR_PTR(-EINVAL);
	}

If port 7 is the CPU port, DSA tree setup fails. Nothing in the log says
that MAC4 (UTP port 4) owns the EXT1 pins.

Could this branch print a dev_warn() that names the MAC4/EXT1 pin
conflict?

> +		} else {
> +			phy_interface_set_rgmii(config->supported_interfaces);
> +		}
> +	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/5a4715dd-89e0-4868-9ffb-c8fb73b18d04%40yahoo.com
