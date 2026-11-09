Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214366;
	b=fJ8C6B3gVF8xKU7rtDO+daBOozCVLbb5bkIonf6Xpung/U2hxBYgs9xRhB4CrX1IiH3t
	 6eOMBo7pWXtFiMxWmNCXgGdAookChNKALiSKwekOFLBD4zPvAMNTEsKDDzKUGdce92ggA
	 pd4enEfn4Wx/fVS3PASQIb82m4BHh93Itkpp5EkLd4ttqs0puEbmg6NGm7c6gCMMxGCcG
	 pGkJG+pg2faW6u0P3AACf+NcERdxEDyC2THiQrsx45YhkaAoY2DWN+7brKqb+JXg+qxO0
	 49waLJoDxW8+DdlsomSnt21BZNCR3XOMRopTUSxD4uCwhlof6Fq44E+eMxOeUNbKI7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214366;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=S+gPk6smiHphLVQhupXpYOXwHrOzpls7/r1mEhsRfFE=;
	b=dB9IAvYAQH80K8Ska/Kve2J0C8LNmKzhGFjtAkRbG8MkvSZP0Xficr9Jb1gXVVbdJEVL
	 wqn+OQ/UKhWvc4HHb9/R55y9KNJKU0K8OQ0Ov4k8CtUfeeJXeoY0t4xa9NZgrb3YDvdGZ
	 gSx7Xf5v1CQqd7vPbfH+DmnseeVltyG96l0cN/KNNnBhvSt9EiCs2akTLtmQPIdPoHuc9
	 q8VHUjRwMwEESG8DHOJloRojPCU8FEJiAV4ROw/L9bOE0EZPoG75v8MzHRXiJOux4b+r+
	 7hyqBGPa3RCPw5/XikwhTrc76gKpSg0o/KGQM9UvPMgmBg7z+ZVydNVOZe44dvHnPVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KeXTwOcc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E466082BD5;
	Mon,  9 Nov 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KeXTwOcc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F0F1F0089F;
	Mon,  9 Nov 2026 08:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794214366;
	bh=S+gPk6smiHphLVQhupXpYOXwHrOzpls7/r1mEhsRfFE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KeXTwOccgEqYoUnzl8AuHfamPUX5jt7n9Wnefk/EHdYBqQM/Fy7RTsVNf7xjHJSFm
	 KwyGKUosbs+9vy7y535s+TOIfFK+QLP5AJHZ8jQHDoZR/atEy9x5NEAd3QV19mmr/F
	 M4Tt28SwELpRcds3x+CAunBbpgEP0idnL7pCjn5Yl87MvUSngAdDd9a0hQFC30xC+e
	 07/KPeEfqrb1zEp71ppGyWVPv5qfEM8JKG5uRSU9YNg9Hc/zE+XYpChcUhtPm139F3
	 qdCXy3szyistHcgXlsvUsidmOs8+hHIcje10QLCeJIOUImoS1BX5C5bhcuPJDX4p23
	 omiSdJIS5SxMg==
Subject: Re: [PATCH net-next v9 07/11] net: dsa: realtek: rtl8365mb: add
 family D SDS13 PCS support
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alvin.sipraga@analog.com, gusfmora@gmail.com, kuncy7@gmail.com,
 fabianotassotti@gmail.com, gabonpivovich@gmail.com, contact@c127.dev
Date: Mon, 09 Nov 2026 08:52:44 +0000
Message-ID: <179421436480.994134.17527876379511324629@kernel.org>
In-Reply-To: <7845f6c0-4b8e-48e6-a5e6-b0b3dd8a182b@yahoo.com>
References: <7845f6c0-4b8e-48e6-a5e6-b0b3dd8a182b@yahoo.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Family D SGMII at 10/100 Mbit/s: phylink is told port 6
  supports those speeds, but the driver never gives the SDS13 SerDes a…

--

net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support

This commit extends the RTL8367S SGMII/HSGMII PCS code to family D
switches. Their CPU SerDes is reached through the indexed SDS13 window,
and their SDS_MISC layout differs from family C. The patch adds family D
tuning tables and SDS_MISC mux/mode values, always sets sds_supported on
family D, and skips the family C SerDes link-force programming in
pcs_link_up() and mac_link_up().

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index a87253b9c2700..86194d555fd6a 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1660,6 +1783,12 @@ static void rtl8365mb_pcs_link_up(struct phylink_pcs *pcs,
>  	u32 r_speed;
>  	int ret;
>  
> +	/* Family D forces the external MAC ability from mac_link_up(); its
> +	 * SDS_MISC fields do not share the family C link-force layout.
> +	 */
> +	if (rtl8365mb_is_d(priv))
> +		return;
> +

[Severity: Medium]
On family D, does port 6 work with SGMII at 10 or 100 Mbit/s?

rtl8365mb_sds_probe_option() now always sets mb->sds_supported on family
D. So rtl8365mb_phylink_get_caps() advertises SGMII on port 6 along with
10/100:

    config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
                               MAC_10 | MAC_100 | MAC_1000FD;
    ...
    if (extint->supported_interfaces & RTL8365MB_PHY_INTERFACE_MODE_SGMII &&
        mb->sds_supported)
            __set_bit(PHY_INTERFACE_MODE_SGMII,
                      config->supported_interfaces);

The RTL8367S-VB entry added later in the series gives port 6
PHY_INTF(SGMII) | PHY_INTF(HSGMII).

On family C, rtl8365mb_pcs_link_up() is the only place that programs the
SerDes SGMII_SPD field for 10/100/1000. With this early return, no family
D path appears to give the SDS13 SerDes a rate:

  - rtl8365mb_pcs_config() writes only PA33PC_EN | PA12PC_EN |
    MAC6_SEL_SDS0 | sds_mode into SDS_MISC. It also clears NWAY_EN, and
    pcs_inband_caps() returns LINK_INBAND_DISABLE, so the SerDes cannot
    learn the speed from in-band AN either.
  - rtl8365mb_phylink_mac_link_up() skips the SDS_MISC write on family D.
  - rtl8365mb_ext_config_forcemode() writes only the MAC-side
    RTL8365MB_D_DIGITAL_INTERFACE_FORCE_REG(port) fields.

Suppose an SGMII PHY or an SGMII fixed-link on port 6 resolves to 100 or
10 Mbit/s. The MAC is forced to that speed, but the PCS has no programmed
rate. If family D hardware does not derive the SerDes rate from the MAC
force register, could the link report up and still pass no valid
traffic?

The family D SGMII branch of rtl8365mb_pcs_get_state() also does not read
the speed back from the SerDes. It keeps what phylink passed in and falls
back to 1000/full:

    if (state->speed == SPEED_UNKNOWN)
            state->speed = SPEED_1000;
    if (state->duplex == DUPLEX_UNKNOWN)
            state->duplex = DUPLEX_FULL;

No later patch in the series seems to add family D SerDes speed
programming or to limit family D SGMII to MAC_1000FD. Should family D
SGMII advertise only MAC_1000FD, or should the SerDes rate be programmed
for 10/100?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/9b73858d-fc09-4988-8bab-fd7b88db9412%40yahoo.com
