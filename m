Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DD28725B
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132959; cv=none; b=HTnsst6HlPcowX9zBOHEFwFgfvqpkRQ1kr3zoBOEAitLqyyWpiw3dz/usbldL+gTzF0VKiqpbOexFHWENnnMlLqMLHQv7UxAN7gAv0y/iaG0lAcr6YJK2fxmv6s99iQ02g5RIaFJOog6XsJHOeu3i+Frz9GWhCoYJsRtN5e0Vb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132959; c=relaxed/simple;
	bh=KcYpmkOnahfvH3HXm43KXtAQTgIwpHCenxWRQCoW7hw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr0izHyhu7dJgMVqf3NH4cGv/G5QDQehQvhyg6j17Q425M3eWrHYd6ObY8w4txHEoIVfxk70Lyb2cnmDRtEjb7Zrd8n31LOEcUvxpX3wl4XtQSxUReg4cBMrlzqTqupaY7tFzKWOmF726Xm+wzYuBptlWQDN15aQqjBC64550XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FN1qwVPI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FN1qwVPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784132961; x=1815668961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KcYpmkOnahfvH3HXm43KXtAQTgIwpHCenxWRQCoW7hw=;
  b=FN1qwVPIO9CAWWfLCJC863rL9jlzzCVpTv8ciadfZydY20VsFWDnVo+L
   GYPd8DXEAke4XOFfx/XbEs3IMM2ih/x6CjS141loHKDn72bmJoOVXkrOT
   X2IHdktKEDqw2FY9SHSn2WhHP6mt/tJugoh2cy4LFp9Wst0s5Wuiymnkg
   ojr9Ov0ZLTkeXkvubtgLtBar0VMSNHuWSjPqh/mI25MAJC/mVjyXX0YRR
   T6MkYIjHeB7ag9O21i09s+SBsTmDu9rdpvI/t/Of93SHgQ9l7m9QbqDlx
   Rz5Kdb/d9v0s4V+59/EL9hXcvaBhhJ1zb487cEHNJWp9xKoTWwsSlq7EC
   Q==;
X-CSE-ConnectionGUID: LV4wgWbBSV2TX3pevlqGtA==
X-CSE-MsgGUID: nIDXqcDKTQGLpM4pFW+HVQ==
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="60656246"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 09:29:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 15 Jul 2026 09:29:11 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 15 Jul 2026 09:29:11 -0700
Date: Wed, 15 Jul 2026 09:29:09 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
CC: <netdev@vger.kernel.org>, <charles.perry@microchip.com>
Subject: Re: [PATCH net-next] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
Message-ID: <ale1VbrKF/ls5Zt4@bby-cbu-swbuild03.eng.microchip.com>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>

On Tue, Jul 14, 2026 at 04:09:04PM -0400, Nathan Whitehorn wrote:
> The current PCS code unconditionally uses SGMII autonegotiation, though
> the hardware supports both SGMII and 1000BASE-X modes. Decouple the
> choice of PCS enablement from use of the SGMII mode when running at
> gigabit rates and announce to phylink that 1000BASE-X is a supported
> operating mode. This enables direct attachment of the PCS to e.g. an
> SFP.
> 
> Tested and developed on Microchip Polarfire SoC hardware.
> 
> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 31 ++++++++++++++++++------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index d394f1f43b68..284a3b03f8c7 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -583,7 +583,13 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>  
>  static void macb_pcs_an_restart(struct phylink_pcs *pcs)
>  {
> -	/* Not supported */
> +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
> +	u32 old, new;
> +
> +	old = gem_readl(bp, PCSCNTRL);
> +	new = old | BMCR_ANRESTART;
> +	if (old != new)
> +		gem_writel(bp, PCSCNTRL, new);

This bit is self-clearing so I don't think the old != new check is
required.

Also, can you comment on why AN restart is needed for this patch? Is it a
requirement for 1000base-x of is it because we now have sgmii and
1000base-x?

>  }
>  
>  static int macb_pcs_config(struct phylink_pcs *pcs,
> @@ -750,7 +756,9 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
>  		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
>  		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
>  
> -		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
> +		if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
> +			ctrl |= GEM_BIT(PCSSEL);
> +		} else if (state->interface == PHY_INTERFACE_MODE_SGMII) {
>  			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
>  		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
>  			ctrl |= GEM_BIT(PCSSEL);
> @@ -957,7 +965,8 @@ static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
>  
>  	if (interface == PHY_INTERFACE_MODE_10GBASER)
>  		return &bp->phylink_usx_pcs;
> -	else if (interface == PHY_INTERFACE_MODE_SGMII)
> +	else if (interface == PHY_INTERFACE_MODE_1000BASEX ||
> +	         interface == PHY_INTERFACE_MODE_SGMII)
>  		return &bp->phylink_sgmii_pcs;
>  	else
>  		return NULL;
> @@ -1025,13 +1034,15 @@ static int macb_mii_probe(struct net_device *dev)
>  	struct macb *bp = netdev_priv(dev);
>  
>  	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
> +	bp->phylink_sgmii_pcs.poll = true;

Why is this needed for 1000base-x?

Thanks,
Charles
