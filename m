Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0628431327A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058880; cv=none; b=VZC2joqbAPMhIDwa62J/x0uFX/u8zN9Uk8wLDekTAPPoI88/CArDQtFGsajIhqbJa+KTR1W9KvmcgrurvXUY47j52R/5rv5QyqRFlLPnpOH+XSHBWMqwVbF1Rc5FXPg7thc/PBtJdvNLFIQzE0tsvH5aD5XQXW7CnBI78u8l2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058880; c=relaxed/simple;
	bh=8WJJ2/NT5y3r1SAk7C//O2YsvSemchrpEp9sC2MFYdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3eBszwq6s++cQ7zOw1NHIThTr6YAK7RSIrWjDeA7ftN12hH3V/0r0m9R0b0KnqIgZThUBhLWAohiwkUfVQPWXlmpNYvtqiCnd8cfSCTnrCFRdHbDDblVaruQLg/K0FiC7ZvyUSkMUEVBFZDJf7321RoQ1fEa1KtRIhv669Sch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlYB7k43; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlYB7k43"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787058877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lrRwtLNN82Z5FjIGBHsoP1GqKEzI7RTsTAciD+0vYk=;
	b=hlYB7k43b9lSfmnwu+gSmtuG67ZuBwITWQbpXVt2uekresOglFXkQKjHAPAGMP9Em2UAeg
	k2yb+IgB6t9XFiRH7+dF2pcXzulUUt3hB6Ups/rDWNJbzCC+mW2e8upmIVMgZ+0SOJ5Z9/
	W2tE9Li3OoRVdvb6QgJ4phw9P/NK/r0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-qQECQHvfP_eSUHcGQ7N6Jw-1; Tue,
 18 Aug 2026 09:14:34 -0400
X-MC-Unique: qQECQHvfP_eSUHcGQ7N6Jw-1
X-Mimecast-MFC-AGG-ID: qQECQHvfP_eSUHcGQ7N6Jw_1787058873
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F26E01801379;
	Tue, 18 Aug 2026 13:14:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 958FC30002E9;
	Tue, 18 Aug 2026 13:14:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: nwhitehorn@pa.msu.edu
Cc: netdev@vger.kernel.org,
	theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	charles.perry@microchip.com,
	andrew@lunn.ch,
	kuba@kernel.org
Subject: Re: [PATCH net-next v5 2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
Date: Tue, 18 Aug 2026 15:14:26 +0200
Message-ID: <20260818131426.191990-1-pabeni@redhat.com>
In-Reply-To: <20260813153705.23407-3-nwhitehorn@pa.msu.edu>
References: <20260813153705.23407-3-nwhitehorn@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: macb: add support for 1000BASE-X autonegotiation to PCS

This decouples PCS enablement from the SGMII mode selection, advertises
PHY_INTERFACE_MODE_1000BASEX to phylink when the controller has a PCS, and
adds an autonegotiation restart implementation plus a return of 1 from
pcs_config() when the advertisement changed.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index c15a9c7e69d37..9097ccb14c13b 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -1061,9 +1075,12 @@ static int macb_mii_probe(struct net_device *dev)
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

[Severity: Medium]

Advertising PHY_INTERFACE_MODE_1000BASEX here makes a device tree with
phy-mode = "1000base-x" acceptable on every PCS-capable GEM, including the
zynqmp, versal, mpfs and pic64hpsc configs whose .init hook is
init_reset_optional().  Should that hook also learn about 1000BASE-X?

It still gates the whole SerDes and firmware bring-up on SGMII only:

drivers/net/ethernet/cadence/macb_main.c:init_reset_optional() {
	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
		/* Ensure PHY device used in SGMII mode is ready */
		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
		...
		ret = phy_init(bp->phy);
		...
			ret = zynqmp_pm_set_gem_config(pm_info[1], GEM_CONFIG_FIXED, 0);
			...
			ret = zynqmp_pm_set_gem_config(pm_info[1], GEM_CONFIG_SGMII_MODE, 1);
	}

With phy-mode = "1000base-x" that branch is skipped, so bp->phy stays NULL,
phy_init() is never called on the PS-GTR lane, and GEM_SGMII_MODE is never
set in the ZynqMP GEM_CLK_CTRL register, which is what routes the MAC onto
the serial/PCS clock path.

Is the failure also silent?  macb_open() calls
phy_set_mode_ext(bp->phy, PHY_MODE_ETHERNET, bp->phy_interface) and
phy_power_on(bp->phy), and both return 0 immediately for a NULL phy in
drivers/phy/phy-core.c, so probe and open succeed with no diagnostic while
the link can never come up.

> @@ -4932,7 +4949,9 @@ static int macb_init_dflt(struct platform_device *pdev)
>  	/* Set MII management clock divider */
>  	val = macb_mdc_clk_div(bp);
>  	val |= macb_dbw(bp);
> -	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
> +	if (bp->phy_interface == PHY_INTERFACE_MODE_1000BASEX)
> +		val |= GEM_BIT(PCSSEL);
> +	else if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII)
>  		val |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
>  	macb_writel(bp, NCFGR, val);

[Severity: Medium]

macb_init_dflt() is reached from init_reset_optional() a few statements after
the SGMII-only branch above, and macb_mac_config() sets PCSSEL for
1000BASE-X too.  Does that leave NCFGR.PCSSEL enabled while the SerDes lane
and the firmware GEM clock mux were never programmed on those platforms?

Also, the binding in Documentation/devicetree/bindings/net/cdns,macb.yaml
documents phys with maxItems: 1 for the controller without tying it to
phy-mode = "sgmii", so can a 1000BASE-X board legitimately expect the driver
to initialize that SerDes?

One related asymmetry: for a board declaring phy-mode = "sgmii" with an SFP
attached, phylink may select 1000BASE-X for the PCS while macb_open() still
programs the SerDes submode from the device tree value in bp->phy_interface.
Should the submode follow the interface phylink actually selected?

Note this does not regress a previously working setup, since 1000BASE-X was
not in supported_interfaces before this patch.
-- 
This is an AI-generated review.

