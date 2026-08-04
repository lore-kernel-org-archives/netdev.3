Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702C3D3CE3
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832642; cv=none; b=WF7RmO2pAlYHavH3dCsbgeQ5bHtkgya9roMlny3ONdfnBQ9AEvzwGVqcEO6fg2yaQysz68iKLCL/D23T7r6H+Jy0LcObLruYG1wLVan6Ea6N9JtpDDw8WLOeIMiwZtGVube02n+F+CAuZGWdSKOPnYmZHg7CZ9QIVXCxlcaZZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832642; c=relaxed/simple;
	bh=cNeHCKK2m+13CFxtzefGAi3XqD6VCs+j+kuEyunfMXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBtD5CpMc9cVWOkyEBvtxSHswitkNmHkQ9/Ee4VZ2k45cyKBUwXZm971FR5csnpK30OYKt9rtfmn/4QWillpa5ld7Icj+JJahvj63hs6Ack10g1jI5PdAd3Od4mE/lm2ShbLU9J7nxu+ujQeSac5VxP8EbBVkMD43sArG3jIUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KI4qRw2/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI4qRw2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785832639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8DBy4RYRyG5FEZuvXxoILMH2zThCO5HDcKQwwL5bLU=;
	b=KI4qRw2/HFcem16oVrRzFteVzo6eFu9O33VHaBkc9tWfhU1IoRET7OJQyFa73iVO2CNvU3
	rSQMhtU+/VUj8xz82X/71Z2SZC2c92Vcpx2JqXS0Bx0DOpADUCUUDFmn9khwbXeO7KNQpU
	PXWEPi56/TqjaEA87SmrHnsJzpBvtSg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-hXrZRIWLNby3qNSra-oZuA-1; Tue,
 04 Aug 2026 04:37:15 -0400
X-MC-Unique: hXrZRIWLNby3qNSra-oZuA-1
X-Mimecast-MFC-AGG-ID: hXrZRIWLNby3qNSra-oZuA_1785832634
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EC0C18002E2;
	Tue,  4 Aug 2026 08:37:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.234])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14A961956087;
	Tue,  4 Aug 2026 08:37:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: nwhitehorn@pa.msu.edu
Cc: netdev@vger.kernel.org,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch
Subject: Re: [PATCH net-next v3 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Tue,  4 Aug 2026 10:37:06 +0200
Message-ID: <20260804083706.54487-1-pabeni@redhat.com>
In-Reply-To: <20260729192748.6928-3-nwhitehorn@pa.msu.edu>
References: <20260729192748.6928-3-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
--- Patch [2]: [PATCH net-next v3 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS ---
commit 3a10158740d1fea523a081adf59e6bcdf1cd55d1
Author: Nathan Whitehorn <nwhitehorn@pa.msu.edu>

    net: macb: add support for 1000BASE-X autonegotiation to PCS
    
    The current PCS code unconditionally uses SGMII autonegotiation, though
    the hardware supports both SGMII and 1000BASE-X modes. Decouple the
    choice of PCS enablement from use of the SGMII mode when running at
    gigabit rates and announce to phylink that 1000BASE-X is a supported
    operating mode. This enables direct attachment of the PCS to e.g. an
    SFP.
    
    The 1000BASE-X code in phylink also sometimes calls the autonegotiation
    restart method, so add an implementation of autonegotiation restart.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index c15a9c7e69d37..310ad8eac21fc 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -583,7 +583,12 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>  
>  static void macb_pcs_an_restart(struct phylink_pcs *pcs)
>  {
> -	/* Not supported */
> +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
> +	u32 old, new;
> +
> +	old = gem_readl(bp, PCSCNTRL);
> +	new = old | BMCR_ANRESTART;
> +	gem_writel(bp, PCSCNTRL, new);
>  }

[Severity: Medium]
Since 1000BASE-X utilizes base page advertisements that can dynamically change,
should the adjacent macb_pcs_config() function be updated to return 1 when
changes are made?

Looking at macb_pcs_config():

static int macb_pcs_config(...)
{
...
	if (old != new)
		gem_writel(bp, PCSCNTRL, new);

	return 0;
}

Returning 0 unconditionally appears to prevent phylink from restarting
autonegotiation when the advertisement changes (like flow control or PAUSE
settings), meaning the new configuration will not take effect until the link
is bounced.

[ ... ]

> @@ -750,7 +755,9 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
>  		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
>  		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
>  
> -		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
> +		if (state->interface == PHY_INTERFACE_MODE_1000BASEX) {
> +			ctrl |= GEM_BIT(PCSSEL);
> +		} else if (state->interface == PHY_INTERFACE_MODE_SGMII) {
>  			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);

[Severity: High]
This is a pre-existing issue, but could macb_mac_config() race with
macb_set_rx_mode() over the NCFGR register?

macb_mac_config() modifies NCFGR while holding bp->lock:

	spin_lock_irqsave(&bp->lock, flags);
	old_ctrl = ctrl = macb_or_gem_readl(bp, NCFGR);
	...
	if (old_ctrl ^ ctrl)
		macb_or_gem_writel(bp, NCFGR, ctrl);

However, macb_set_rx_mode() performs a lockless read-modify-write on NCFGR
protected only by netif_addr_lock_bh:

	cfg = macb_readl(bp, NCFGR);
	if (dev->flags & IFF_PROMISC) {
	...

Could this concurrent modification lead to lost configuration updates, such as
overwriting PCSSEL/SGMIIEN bits or dropping promiscuous/multicast flags?

[ ... ]

> @@ -1061,9 +1070,12 @@ static int macb_mii_probe(struct net_device *dev)
>  			  bp->phylink_config.supported_interfaces);
>  		phy_interface_set_rgmii(bp->phylink_config.supported_interfaces);
>  
> -		if (bp->caps & MACB_CAPS_PCS)
> +		if (bp->caps & MACB_CAPS_PCS) {
> +			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> +				  bp->phylink_config.supported_interfaces);
>  			__set_bit(PHY_INTERFACE_MODE_SGMII,
>  				  bp->phylink_config.supported_interfaces);
> +		}

[Severity: High]
With the addition of 1000BASE-X support here, does the init_reset_optional()
function also need updating to prevent a regression on platforms using a SerDes?

Looking at init_reset_optional() later in the file:

	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
		/* Ensure PHY device used in SGMII mode is ready */
		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);

Since this explicitly checks only for SGMII mode, won't the hardware
initialization for the SerDes lane fail when the MAC is configured for
1000BASE-X, leaving the generic PHY uninitialized and preventing the hardware
from linking up?
-- 
This is an AI-generated review.

