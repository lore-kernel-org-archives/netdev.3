Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C73546CB
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063787; cv=none; b=hN8p1Znugn2l0r7oFP/oRqVHPdk6twhsBscIIGpPKh0JXhqrgbMCL4Gb4WA4dPWONefXkeshWk0CKUFr5zwzLEj0mB+DCAVvPZ07+XDLs1TyUXKQXQvTgepAtT7xW9wOUOxhun/1kdhBSDoJx0AEf81u5FllTyg6Hh/jCi8nN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063787; c=relaxed/simple;
	bh=6PBOPsqWE1sG+bif+HMfRbzq1/+2yhRA2YSURmJvnco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i21WXX9Dpe3t9qFAZxzfoLsX8y0Wb1sseyjUK1FVh8cWs8EguRc/25U85FvfdJNRERxJS+eyit5PAgV52nlwM76+YbSePrett7Acaqhz5rubNTXQ/NwSu/IobZoGU/zGfOHzE9XeW5L1H05wX6FlMao2XmDnB/3PspsdvCXkzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vQhrBIiu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vQhrBIiu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 11DCEC49F49;
	Fri,  3 Jul 2026 07:29:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 579FA60300;
	Fri,  3 Jul 2026 07:29:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19C4C104C8399;
	Fri,  3 Jul 2026 09:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783063781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cSZ/xQ3jdLNEzAhovYV6wMXxKB3N/2vb+tOcH1bKHWQ=;
	b=vQhrBIiu90ze/KSbq2jZmN6ymjPqGrbJeI3A+pJsISSPMw2cO/Z0n7hfy96sME6LQ0/iPz
	npePBKehuvxy/c+dSTSiif6kES1VEfrYtrzHuRm5qliy9DbCpn4u1udoGoE+2WMXzj9KDT
	y6RCHafMnaiADSk2dVt2m568CuR3wGXwaY1JKaHlu06eWbDG5VT1olCEdciW3RlFrr3Dkb
	dM0baZYJ6OawEzHmRRIRzuIS0rCFCJ2LypXDbft3yVgT0zg8xzw3U4fMozEKQFPvRq1VDq
	BqsMjeRQ2CI8VRl9ktkUzFiG6sSBAb8uaubStH6F5pcZGx1MWFTvivVZt7hb4Q==
Message-ID: <e4e1d392-2430-4403-91b1-5be59d6a9895@bootlin.com>
Date: Fri, 3 Jul 2026 09:29:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: Johan Alvarado <contact@c127.dev>, linusw@kernel.org,
 alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk
Cc: luizluca@gmail.com, namiltd@yahoo.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260702204648.276112-1-contact@c127.dev>
 <0100019f2496091c-0bf7417f-aa27-4465-972b-f9a9b156506a-000000@email.amazonses.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <0100019f2496091c-0bf7417f-aa27-4465-972b-f9a9b156506a-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Johan,

On 7/2/26 22:47, Johan Alvarado wrote:
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
>  - Program the SerDes pause controls in SDS_MISC from the resolved
>    pause modes when forcing the MAC external interface in mac_link_up,
>    as the vendor driver does, rather than leaving whatever state the
>    boot firmware left there. This is done in the MAC layer because
>    pcs_link_up() carries no pause information.
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

Ah nice conversion to phylink PCS :) I have a few comments below

> 
> Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Suggested-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Johan Alvarado <contact@c127.dev>
> ---

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
> +	/* This driver does not implement SGMII in-band autonegotiation yet, so
> +	 * the link parameters are forced from rtl8365mb_pcs_link_up() instead.
> +	 * rtl8365mb_pcs_inband_caps() reports this to phylink, which should
> +	 * therefore never select an in-band-enabled negotiation mode.
> +	 */
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +		return -EOPNOTSUPP;

As you implement the .pcs_inband_caps() method, phylink will pass you a valid
mode, no need for that check :)

[...]
> @@ -1218,14 +1680,46 @@ static void rtl8365mb_phylink_mac_link_up(struct phylink_config *config,
>  	p = &mb->ports[port];
>  	schedule_delayed_work(&p->mib_work, 0);
>  
> -	if (phy_interface_mode_is_rgmii(interface)) {
> +	/* The SerDes forced link state is programmed by the PCS in
> +	 * rtl8365mb_pcs_link_up(); here only the MAC external interface force
> +	 * is configured, for both RGMII and SerDes.
> +	 */
> +	if (phy_interface_mode_is_rgmii(interface) ||
> +	    rtl8365mb_interface_is_serdes(interface)) {
>  		ret = rtl8365mb_ext_config_forcemode(priv, port, true, speed,
>  						     duplex, tx_pause,
>  						     rx_pause);
> -		if (ret)
> +		if (ret) {
>  			dev_err(priv->dev,
>  				"failed to force mode on port %d: %pe\n", port,
>  				ERR_PTR(ret));
> +			return;
> +		}
> +
> +		/* The SerDes has its own pause controls; program them from
> +		 * the resolved pause modes, as the vendor driver does when
> +		 * forcing the link on a SerDes external interface. This is
> +		 * done here rather than in rtl8365mb_pcs_link_up() because
> +		 * pcs_link_up() carries no pause information.
> +		 */
> +		if (rtl8365mb_interface_is_serdes(interface)) {
> +			u32 val = 0;
> +
> +			if (tx_pause)
> +				val |= RTL8365MB_SDS_MISC_SGMII_TXFC_MASK;
> +			if (rx_pause)
> +				val |= RTL8365MB_SDS_MISC_SGMII_RXFC_MASK;

Do you know what this does in HW ? Is this so that the PCS lets the Pause frames through
in either directions ?

I suspect this is something that would be only used for inband advertising
of pause settings (in such case, you don't even need that), but ofc I'm not sure :)

You already configure the MAC pause settings, can you test that these bits actually do
anything by exercising a bit flow control and checking if these registers are used ?

Otherwise, this is looking pretty good :)

Maxime
