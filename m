Received: from sonic315-22.consmr.mail.ne1.yahoo.com (sonic315-22.consmr.mail.ne1.yahoo.com [66.163.190.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6755346A1D
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184065; cv=none; b=JhqCWdsYFKP67mrQGGQNMA6GJFg8ZcEnJCUn2FD1xuxKaUNyUc09t18v8scSllYbEuEzCllKJRR8e2ZhRFGI+IMpqRODzxT6bIVseyMR4WjEhVCwsSI92I7MP5vNx54AHmQXLABIxNapoh8QINQy7XewhI/IrsdgUEPmlneKpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184065; c=relaxed/simple;
	bh=g0uL4KAaG+AVYB3nB7584VzMLHgd6XnkrQ7svB2ZtNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1wFDsBrjg33GUjmrQ4wDL/Ii3x/ch6FUdTLDUhM3qbrtt7C/uZpXJDj02lxtZdaqcSwM1gLBYC6Ym5JSVgvs/l4KVZlHn7d+O/Y9XcLi0AcXk1SmWBn0qftdb5KwlILLk0lNoDKmHMY02ufI4LVS6YCTNDvIgLcUOO1y6WYg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RGqLEOyk; arc=none smtp.client-ip=66.163.190.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RGqLEOyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784184057; bh=heHYr7K5psryRR+29x6lSUZG52vPUAJSRX4RD7WOTMQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RGqLEOykOCVkdTMwXWpGX5mFjqdihbWlOaILpfH9HWtXicbpsFKo61P57TX8TRzPrTHD9uaTfr3UoSGOMInEPCML54RIy08DCpNQi694CZgN+fsI6qnIHx9hfw5q4PI4fmpub6klxTJv1LiM5ETZtqPcnvvKxJiYaNGYAX9yfj/A0Njgl0aFUrlTjgR0DuSDMMRwI/XZnDLMkldfN8P68W/9Nt87XsUJHStJ2SQ4ZTbpa/4GOBNrs2+im730KwaaklwEoB4BhR0JR+AKN1td4Ug0Va9cD9QnNJPX6D83RGfzaOr5Bo7Gb67t3zfQjPkZ6Z7Pz4ADHx0veHdDnyoR6Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1784184057; bh=0MQc4MiZh6PyjG4seSx5TMrF7vbCttl+KcsgOghg+1r=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oEfu877U1K8nGAsB3lambdevdIqLraRB2kUfEHHLiybcIdtBsgWeogUNWX3sTz8I7/4f8ggfc3Y2mNOyX+TTmU9BbdOx+rDbdjdumtrgkaL1N5pW0zShi5uFsAy+BpdCzMWkGNotc+/CN6UhJJiZWGphAsGU1iK9hkzqSuktt+dMTG243ieAjizbIT/x6FPiNWhMYOwnRkzjFxHEv3QLDLv7Uq2tSJZpP7K4oQ3lRQlapiNvag89NikqJrCZHRuugwIX4EcOpJ32x6jPEONYB7qH1mYqIUdDD+DGwoLPVpVmd1vy6auSNsaLEeyIroq24M77hUSlsNukmUmy5kIfTA==
X-YMail-OSG: n2lB.HIVM1kadogZUueLtTILN_SBIGN_hFsfWHD9wzfk9SEF1csAtvf1TZvU8XP
 BeEdSqMVJEvNfon_qnwKN.Ci64C4nQuDPX57iZX6cGcVC4JJ.ydQ.ClA.Ve03gRnRYFc3b7tt4AE
 z0mPMZBDinXoMXLL6_l38cb2Md0bKfJBsZXJ7kZD.RReom2HBuT4uN6IIAIw.7jZ6n_LGaPUh5eS
 0ggfctW3pKbinD1gLrs6PDtyLmiiHNemr0APNvD7UdgOyak2epVBwfzw4.I.Dv3egPcVer1bx6Ri
 0JNjJtfTu4jEbxke_GxJrsQkvxjyQVPb2BDP9wVmtrCfnYG7gPtTc3pKS9fiDf4fuKzdsHqcIXg4
 RgzdMdQnRTuD4RQzvMIenrcqBCZsLr_7zDNmMNMgoR0kXP.yZgKvHoXN4aeXxxUZ.M15RZN_M8Gu
 w04WfkuHppwAyA6EklG4OkiWKvW9NgpAFXE5O.VLq0TXBDNklHKYW3_JPLVF85QTmUTV_obGx_Do
 fC05WHQXrsDpuxmlrftCgflV09l9aVMfh2Wy2yTWZXbCSYnGhTfqQ0SujlXU494Nc4vRssGH1euJ
 tUduUeqiVJDJrk5EV_wp9QZM4pPz6i5TMwAQZidzFluX7Xb0egOkGXGZXjO6qyFOUy2g3svDoJV8
 TylAaqGDpIf0Q14pwd4fJsTd_DW8.80RXvTYxBoDzMStTovxQT5_c1a33ZLKBqOXf6mtqTPd_U7c
 3C77Yw.rEUJsapcZr_kAMQeiCRaN6V1mdDBPax9j82KRhKIon09wauB1AMPzoB1oxRrNrLk5DxdK
 AXdHb3U07s5BWigXCEzioigwIOX6E2UxgtJYT0ImgJmFLkKst9F5MkoC38L.vx.WSQOiNeYjFpIx
 R6dan6_aLCBGML7Fa2BNVutB9g4Axv81hrs_LM2v7ooGCpmBkH9sjqLDrglNj_K4AN9yHlSGVy_p
 gNZKEAM9IPnX37zhqvormCAQRY.HaM6f5fUwbHaaqlMAgaeVkjHNIATZCPKmIeZWNAGnVAmIIgaS
 NzaPDMyZZ4XcU9ulVQjQyIh1m7Stzu8A34kcl5DBmB329OjG.G29Dyj1jIMrRd2_r7Y8q9myJBrg
 XUoH0wuttgbw3Bfx2Ce46Pu.oQfjHxVojccxqy6UJB_QWw5dmnuSzxuhYarjPowY6GuTbKoyyKAe
 WKIrnKeSlmCNuOMO12t4oOJkPnq2aWua04JQCmkMnOMQCtBXNmmnv44o1WS7UPjz5YJ96Vt8lTV_
 x5gzISBDxUo1ccPGa4nyAI1DZv_Pmn16JVs49H3nmnjz.lnXlSCE7fuurYZeMhCK.IbKT8qXQWo9
 nkHbWw5_0xpC9eulNlX.92ahO9lybtG6YWVX4AUmCJBtU4EWUURgDA77le6btRQkNEEGcjqGgKT8
 Knotoh9o3fYJ_r_rOCVRzbXIEgp5MTsiUVOTmd0M94oV1ej5rXmcaNwW9ki1ZXkhwWBN3Ds.bYzG
 h_rPPNMRpjgP93SNeVZ.rGb0H2kqSqeq2L3afyeg50yWwSNYovyq9zUO3SNDTmh9rAzLFntTJIyl
 NJq8w1nD4XfH7qUr.Z9ErDXMdbr8FG7m1Fm6.1NCYt8qMBSyZP2UK0I8SWFpYi9xDr.U9rPqjIAN
 mpn9RMqtY94fzfjoUPPLI3dVuTZ3gNa9Y5QBpdmeQygz7ab4tWsYzLQ04juLuzW_4kPtDri4hLvM
 CQ1PsSZCnapOg2tZSe6AX8mexuccaCje9nhFQOU.VwcOz0qvL4bQCGURfsXx3AqEdh4Iyj5YpMXF
 YUiHXaHZpxkXylIOW1vR3xgBlnzXo4VQJpZCsEBFtVB8EFdEghUfM_iZ1hpf9yoR06J6j3V9l4L1
 xxnm4AEgknTq4RxPEXkKtOQn3zAx6K.jlCPt.QsfPDvlDcBJ7OO8zKMr.K0j3uEFyEZbt8VxX9sp
 g39eS0E9RpT_Jn7vo7bQs3MxrfKNECoga6NbYh34k3Dt3tSZ7DVCP5zF86yvS4i0UktrFT9RN00m
 pwrIBvxS01tyoiwgKURlL.fR2swwZyqizSJNaPm.ps1mOr9GdFgXlAaoVRt6jnLdkCGq3XFgyYTm
 9HCEN0J02g14sggwie.iw8c.XCTSbUATnnqx4I.LuTeECcntKmL6P4YjcUVa48LKPYJOruk7GY8I
 Sttv08f8NQEYB4YNENl5.LSsPz8p8wqJEIPhuruvWOIvzxD.X9GqkZbxMii0IJchGAXe1gSQD4l9
 v6mwSOwMkwm8dlDsBKLpgOCUApxm9A7U9aIJsQ4OwXKWT.GfEfKIwBlTC3nA7w95bbBaEp1JJAuR
 9SXHcuD6V
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: d766069e-047a-4469-a488-f02be7a3f9e9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Jul 2026 06:40:57 +0000
Received: by hermes--production-ir2-7b48fcd765-f9jxb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b815d7089658c3344616350b50b22c7d;
          Thu, 16 Jul 2026 06:40:54 +0000 (UTC)
Message-ID: <e252cb3c-bfb2-4d62-aec7-e04b9aafe223@yahoo.com>
Date: Thu, 16 Jul 2026 08:40:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: contact@c127.dev, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
 <20260711-rtl8367s-sgmii-v6-1-88f7944ddca7@c127.dev>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260711-rtl8367s-sgmii-v6-1-88f7944ddca7@c127.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26136 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Hi Johan

On 7/12/2026 6:31 AM, Johan Alvarado via B4 Relay wrote:
> From: Johan Alvarado <contact@c127.dev>
> 
> The RTL8367S can mux its embedded SerDes to external interface 1,
> which is typically used to connect the switch to a CPU port. The chip
> info table already declares SGMII as a supported interface mode for
> this chip, but the driver only implements RGMII so far.
> 
> Implement SGMII support as a phylink PCS, with the configuration
> sequence derived from the GPL-licensed Realtek rtl8367c vendor driver
> as distributed in the Mercusys MR80X GPL code drop:
> 
>  - Add accessors for the SerDes indirect access registers (SDS_INDACS),
>    through which the SerDes internal registers are reached.
> 
>  - Register a phylink_pcs for the SerDes, selected from mac_select_pcs
>    for the SGMII interface, so the SerDes handling lives in the PCS
>    operations rather than in the MAC operations.
> 
>  - Probe the SerDes tuning variant from the chip option register once
>    at setup. The vendor driver keeps two sets of SerDes tuning
>    parameters and selects between them based on this option; only the
>    variant for a non-zero option (which all RTL8367S parts seen so far
>    report) has been validated on hardware, so the SerDes interface
>    modes are only advertised in that case. An unsupported variant thus
>    fails at phylink validation time instead of at link configuration
>    time.
> 
>  - Keep the embedded DW8051 microcontroller in reset and disabled. The
>    vendor driver loads firmware into it to manage the SerDes link, but
>    analysis of that firmware shows it only duplicates the link
>    management phylink already performs: it polls the port status and
>    writes the external interface force registers behind the driver's
>    back.
> 
>  - Clear the line rate bypass bit for the external interface, tune the
>    SerDes with the vendor-prescribed parameters, mux the SerDes to MAC8
>    in SGMII mode and only then take the SerDes out of reset, as the
>    vendor driver does.
> 
>  - After deasserting the SerDes reset, reset the SerDes data path via
>    the SerDes BMCR register to flush the FIFOs and resync the PLL.
>    This mirrors what the vendor firmware does right after deasserting
>    the SerDes reset, and ensures a clean link state from cold boot.
> 
>  - Force the SGMII link parameters (link, speed, duplex) in the SDS_MISC
>    register from pcs_link_up(). SGMII in-band autonegotiation is not
>    implemented, so only fixed-link and conventional PHY setups are
>    supported, just like RGMII. This is reported to phylink through
>    pcs_inband_caps() returning LINK_INBAND_DISABLE, so phylink never
>    selects an in-band-enabled negotiation mode for this PCS.
> 
>  - Program the SerDes pause enables in SDS_MISC from the resolved
>    pause modes when forcing the MAC external interface in mac_link_up,
>    as the vendor driver does, rather than leaving whatever state the
>    boot firmware left there. Flow control testing shows these bits,
>    not the MAC force pause bits, gate pause on the SerDes external
>    interface. This is done in the MAC layer because pcs_link_up()
>    carries no pause information.
> 
>  - Implement pcs_get_state() by reading the link status from the
>    SerDes, with the forced speed and duplex read back from SDS_MISC.
>    Although the supported fixed-link and conventional PHY setups do not
>    use it, the PCS owns the SerDes link state, and phylink consults
>    pcs_get_state() to track the physical link when operating in in-band
>    mode with autonegotiation disabled. The SerDes has no link interrupt
>    wired up, so the PCS sets its poll flag.
> 
> Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
> the SoC over SGMII.
> 
> Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Suggested-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Johan Alvarado <contact@c127.dev>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 515 ++++++++++++++++++++++++++++++-
>  1 file changed, 511 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 5ac091bf93c9..ea03c42d0f1a 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[...]

> +static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				phy_interface_t interface,
> +				const unsigned long *advertising,
> +				bool permit_pause_to_mac)
> +{
> +	const int id = RTL8365MB_SDS_EXT_INTERFACE_ID;
> +	struct rtl8365mb *mb = pcs_to_rtl8365mb(pcs);
> +	struct realtek_priv *priv;
> +	u16 val;
> +	int ret;
> +	int i;
> +
> +	priv = mb->priv;
> +
> +	/* Hold the embedded DW8051 microcontroller in reset and keep it
> +	 * disabled. The vendor driver loads firmware into it to manage the
> +	 * SerDes link, but the firmware only duplicates work that phylink
> +	 * already does: it polls the port status and forces the external
> +	 * interface configuration in the very registers this driver manages.
> +	 * Letting it run would race with phylink.
> +	 */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_CHIP_RESET_REG,
> +				 RTL8365MB_CHIP_RESET_DW8051_MASK,
> +				 RTL8365MB_CHIP_RESET_DW8051_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->map, RTL8365MB_MISC_CFG0_REG,
> +				 RTL8365MB_MISC_CFG0_DW8051_EN_MASK, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* The vendor driver clears the line rate bypass for all interface
> +	 * modes except TMII.
> +	 */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_BYPASS_LINE_RATE_REG,
> +				 RTL8365MB_SDS_BYPASS_LINE_RATE_MASK, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Tune the SerDes with vendor-prescribed parameters */
> +	for (i = 0; i < ARRAY_SIZE(rtl8365mb_sds_jam_sgmii); i++) {
> +		ret = rtl8365mb_sds_write(priv,
> +					  rtl8365mb_sds_jam_sgmii[i].reg,
> +					  rtl8365mb_sds_jam_sgmii[i].val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Mux the SerDes to MAC8 in SGMII mode */
> +	ret = regmap_update_bits(priv->map, RTL8365MB_SDS_MISC_REG,
> +				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK |
> +					 RTL8365MB_SDS_MISC_MAC8_SEL_HSGMII_MASK,
> +				 RTL8365MB_SDS_MISC_MAC8_SEL_SGMII_MASK);
> +	if (ret)
> +		return ret;
> +
> +	val = RTL8365MB_EXT_PORT_MODE_SGMII
> +	      << RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_OFFSET(id);
> +	ret = regmap_update_bits(priv->map,
> +				 RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(id),
> +				 RTL8365MB_DIGITAL_INTERFACE_SELECT_MODE_MASK(id),
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	/* Take the SerDes out of reset. The vendor driver does this only
> +	 * after the SerDes mux and the interface mode are configured.
> +	 */
> +	ret = rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_RESET,
> +				  RTL8365MB_SDS_RESET_DEASSERT);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset the SerDes data path and resync its PLL, mirroring what the
> +	 * vendor firmware does right after deasserting the SerDes reset.
> +	 * This flushes the FIFOs and ensures a clean state for the link,
> +	 * preventing silent drops and CRC errors.
> +	 */
> +	ret = rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_BMCR,
> +				  RTL8365MB_SDS_BMCR_DPRST_PHASE1);
> +	if (ret)
> +		return ret;
> +
> +	ret = rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_BMCR,
> +				  RTL8365MB_SDS_BMCR_DPRST_PHASE2);
> +	if (ret)
> +		return ret;
> +
> +	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
> +	 * forced from rtl8365mb_pcs_link_up() instead.
> +	 */
> +	ret = rtl8365mb_sds_read(priv, RTL8365MB_SDS_REG_NWAY, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~RTL8365MB_SDS_NWAY_EN_MASK;
> +	val |= RTL8365MB_SDS_NWAY_RESTART_MASK;
> +
> +	return rtl8365mb_sds_write(priv, RTL8365MB_SDS_REG_NWAY, val);
> +}

For verification on real hardware:

The SGMII/HSGMII link on RTL8367S (and compatible RTL8365MB-VC) can be
intermittently unstable after cold boot, manifesting as egress stalls,
CRC errors or complete packet loss on the SerDes-attached CPU port.
This has been observed as a non-deterministic failure depending on the
PLL lock state at power-on.

Reverse-engineering of the vendor DW8051 firmware blob (Sgmii_Init[])
shows that the vendor driver performs two critical steps after the
SerDes data-path reset (BMCR DPRST_PHASE2) which were missing from the
Linux driver:

1. A ~98 ms delay to let the SerDes PLL fully lock before any further
   register access. The vendor firmware uses a timer interrupt to count
   this delay; without it the analog front-end may still be settling.

2. Writing a "Local Jam Table" calibration vector to internal ASIC
   registers 0x060C-0x060F (values 0x83, 0xAA, 0x7E, 0x80). These
   registers configure the SerDes analog equalizer and DC-offset and
   are not exposed through the normal SDS_INDACS window. Omitting them
   leaves the analog front-end in an uncalibrated state.

Add both steps to rtl8365mb_pcs_config(), immediately after the BMCR
phase-2 data-path reset and before the NWAY configuration. This mirrors
the exact vendor firmware bring-up sequence and eliminates the cold-boot
race.

The 98 ms delay matches the vendor firmware timeout constant
(SGMII_TIMEOUT_98MS). It is a one-time cost during interface bring-up
and ensures reliable link establishment regardless of the PLL state at
reset.

--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -95,6 +95,7 @@
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/phylink.h>
+#include <linux/delay.h>
 
 #include "realtek.h"
 #include "realtek-smi.h"
@@ -1235,6 +1236,21 @@ static int rtl8365mb_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 	if (ret)
 		return ret;
 
+	/* The vendor firmware waits ~98 ms here before writing the
+	 * calibration vector.
+	 */
+	usleep_range(98000, 98500);
+
+	/* Vendor firmware writes a "Local Jam Table" to internal ASIC
+	 * registers 0x060C-0x060F after the data path reset to calibrate
+	 * the SerDes analog front-end. Without this, the link can be
+	 * unstable after cold boot.
+	 */
+	regmap_write(priv->map, 0x060C, 0x0083);
+	regmap_write(priv->map, 0x060D, 0x00AA);
+	regmap_write(priv->map, 0x060E, 0x007E);
+	regmap_write(priv->map, 0x060F, 0x0080);
+
 	/* Keep SGMII in-band autonegotiation disabled: the link parameters are
 	 * forced from rtl8365mb_pcs_link_up() instead.
 	 */

