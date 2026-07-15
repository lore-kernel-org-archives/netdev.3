Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9B4A2E2E
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137979; cv=none; b=oVAIUYaVZETf/KHbUnkX9d85qdl+dnrf3F3Ki5xANE1RhX6cxyMfYK2DcgR32/kuhMJCL0/tS00BGP7taNl6XLnV1VV/cewM51I1Jq8yls6DEDUIILUGmZW4Ce1h79DrUtPLJ+W5H6gjDUk4vpmW6zOtMvI878OJkJOXJVHSNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137979; c=relaxed/simple;
	bh=pJjCZIqzGdk61FXO03CeAdjfLCbtB4vQNBGIN7Sl2RM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMhzDHJZVJZ31QmyMnrZtsEnoiIvCjfUWBm/QWybYZLKtiTtAhL57obzhTDqJ91D7+opcHYpKfy5aM8wHsiHzAFESfz/BcJ1B1+Sq3F2Fn19kpmcfD619I8/S+sWyAM+WiUM11EAduQPR90Vbjb/9Sp96AtF22b93a2+bAMNt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TxGescD/; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TxGescD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784137977; x=1815673977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pJjCZIqzGdk61FXO03CeAdjfLCbtB4vQNBGIN7Sl2RM=;
  b=TxGescD/2zwmlTqpMpkN4GToMtKRJdKpAd1jZ4uGAgYWVXtLGMerK3Ej
   7BBTXcyVoe8HjEeUEgUugPw4Sn0aWMRz5CvhwEaYASN8uSR/AfD/q1Igl
   MxKks69Qzzi67HA4ofihRbc13rgAYZgGhX49x/Q58ZcDGPxaFGMxUPkJN
   IK6VckaMVp8OY9l2M1psxl4WJsEFbzSW3GNAzM9fdWYzE+YG39GuMAoGp
   TjeWvkG+C+sNQwM9PImJmwhMTVLLuMZ+YBsvqopYT1riCcd5AGNWcz4U/
   TRS4guHLq+8MI9wAC+Idp2UlYZn0aJqQ8nzFSLWC1uYwiaYg5InJfnY/+
   A==;
X-CSE-ConnectionGUID: 4nf2tcmZT0S0b/gSYKP8Rg==
X-CSE-MsgGUID: +ageaavSTJOAXZBGCpo9AA==
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="60995901"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 10:52:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 15 Jul 2026 10:52:50 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 15 Jul 2026 10:52:50 -0700
Date: Wed, 15 Jul 2026 10:52:49 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
Message-ID: <alfI8bXaaLXIDAzK@bby-cbu-swbuild03.eng.microchip.com>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <ale1VbrKF/ls5Zt4@bby-cbu-swbuild03.eng.microchip.com>
 <ab0883e3-fc15-41f7-a851-07bc4697aa42@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ab0883e3-fc15-41f7-a851-07bc4697aa42@pa.msu.edu>

On Wed, Jul 15, 2026 at 12:35:48PM -0400, Nathan Whitehorn wrote:
> 
> 
> On 7/15/26 12:29, Charles Perry wrote:
> > On Tue, Jul 14, 2026 at 04:09:04PM -0400, Nathan Whitehorn wrote:
> > > The current PCS code unconditionally uses SGMII autonegotiation, though
> > > the hardware supports both SGMII and 1000BASE-X modes. Decouple the
> > > choice of PCS enablement from use of the SGMII mode when running at
> > > gigabit rates and announce to phylink that 1000BASE-X is a supported
> > > operating mode. This enables direct attachment of the PCS to e.g. an
> > > SFP.
> > > 
> > > Tested and developed on Microchip Polarfire SoC hardware.
> > > 
> > > Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
> > > ---
> > >   drivers/net/ethernet/cadence/macb_main.c | 31 ++++++++++++++++++------
> > >   1 file changed, 24 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> > > index d394f1f43b68..284a3b03f8c7 100644
> > > --- a/drivers/net/ethernet/cadence/macb_main.c
> > > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > > @@ -583,7 +583,13 @@ static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> > >   static void macb_pcs_an_restart(struct phylink_pcs *pcs)
> > >   {
> > > -	/* Not supported */
> > > +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
> > > +	u32 old, new;
> > > +
> > > +	old = gem_readl(bp, PCSCNTRL);
> > > +	new = old | BMCR_ANRESTART;
> > > +	if (old != new)
> > > +		gem_writel(bp, PCSCNTRL, new);
> > This bit is self-clearing so I don't think the old != new check is
> > required.
> 
> Ah, OK, good to know.
> 
> > Also, can you comment on why AN restart is needed for this patch? Is it a
> > requirement for 1000base-x of is it because we now have sgmii and
> > 1000base-x?
> 
> Our equipment works well enough without this, and it is just here for
> completeness rather than an actual need. I am happy to drop it from the
> patch if you prefer.
> 

Well it does look like the ->pcs_an_restart() callback was made
specifically for 1000base-x because phylink_pcs_an_restart() in phylink.c
checks for phy_interface_mode_is_8023z():

https://elixir.bootlin.com/linux/v7.1.3/source/drivers/net/phy/phylink.c#L1028

Maybe you actually need this.

Thanks,
Charles

