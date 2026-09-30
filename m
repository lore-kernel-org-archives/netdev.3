Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEF30C147;
	Wed, 30 Sep 2026 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746862; cv=none; b=SkZpgAuj6YVHZCdIuyhDVTVZURkdSY+2d7RG9GlWTVblzu8JYov+VlfTe+Zk5s+XdVYpsc7x54gepoBAeS395aaDtHLbYlArdJgq14XQb7fDVATClnXrAPyn/V27ukHeOWdJ1d6RQrl2gsvu5kOQIcnMgzOqdn638+tLdYppoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746862; c=relaxed/simple;
	bh=wxe/DM7r2GKzQHbMz5VnZ0DQNy8nUUAohTi8urqGk9E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmYIZRXME5Trg6EGt9wIVHsQWd/Vp9sg4Q8oi0Zs7HijlZ4u4vW9NSRzpN+lIWA6mZoGR1uUTw5K2vLN5ytRQxMfOL4Fu5b+yjY5QveTxsf7XKDeQyMKEUbrzqm645e4pur8HCTaNfzBUfiHki/dIAHD9cOEwFHACApGKuEIIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LZnmuAk1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LZnmuAk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790746861; x=1822282861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wxe/DM7r2GKzQHbMz5VnZ0DQNy8nUUAohTi8urqGk9E=;
  b=LZnmuAk1f4qn6UIohD/IUj4OZgkrfCsBNE8sU0cJjfJve7t3HWI/7M5O
   DzrWZmexYVKMCVAGcmWAIDInj9dEBw+NiMP8dFA3nOjag9XLDLOrNhodl
   QquUDSvbH97RybjxTuIwX8ja5DzX5jZvAvAAIQVvs4/71SAlRELxbH6xj
   RNujuXExe47trGVNGfsODONPsv6Ncg2/4cFg0080f4t7Wr2a81PpMRd3L
   xVhY4AGBU6PPb1Hm6h2mVbJngb84w9ZbsHIV9CbDFsaB+D6z19vyWCZSS
   b1gKGii0osQvFXrlnzT1Iwk+NHm/729KoKiiYrHTrwY3tuJzZKRNuK3xP
   w==;
X-CSE-ConnectionGUID: r6MIbcMDTVezUi7qzOnxbQ==
X-CSE-MsgGUID: RjhBc48MSSqW9sF5CWAFqg==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="64358277"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2026 22:40:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 29 Sep 2026 22:40:53 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 29 Sep 2026 22:40:51 -0700
Date: Wed, 30 Sep 2026 07:40:50 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Quentin Freimanis <quentin@q-lab.dev>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: start the domain 0 TOD counter on
 non-PTP lan969x variants
Message-ID: <20260930054050.hrvaydgdczkizuqt@DEN-DL-M70577.microsemi.net>
References: <20260928044955.29647-1-quentin@q-lab.dev>
 <20260928151453.fzch356vrp3ergy7@DEN-DL-M70577>
 <4e1ef527-e843-4f1b-9f7f-cf2400fa443e@q-lab.dev>
 <20260929120900.zld2c3h4keqcnmcj@DEN-DL-M70577.microsemi.net>
 <09daa7d0-16a8-40be-999b-9cc608e700db@q-lab.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <09daa7d0-16a8-40be-999b-9cc608e700db@q-lab.dev>

> > > > Ack. Not initializing the TOD domains on certain variants is a problem.
> > > > 
> > > > However, TOD domains shouldn't affect basic forwarding. I tried it on my board
> > > > with PTP forced off - no forwarding issues.
> > > > 
> > > > Certain TSN features do require TOD domains to be configured, though. How did
> > > > you test this, and what exactly did you see fail?
> > > 
 > > > > Fix by moving the TOD counter start code into a helper and calling it in
> > > > > sparx5_ptp_init(). Non-PTP capable lan969x parts now start the domain 0
> > > > > counter, and PTP-capable parts start all three, as they used to. A similar
> > > > > workaround that starts all three and registers the PHC clocks is
> > > > > implemented in the vendor BSP 6.18 kernel [1].
> > > > 
> > > > What we do downstream, is to ensure that all domains and PHC's are configured
> > > > and registered on all variants, with a very simple is_sparx5() check.
> > > 
> > > My reasoning for only enabling the first counter and not registering the
> > > clocks is that the part does not have SPX5_FEATURE_PTP, so it should not
> > > expose any PTP features to userspace.
> > > 
> > 
> > I acknowledge the problem, and I agree that the PHCs should not be registered.
> > As for the solution, downstream we always start all three TOD domains, including
> > on sparx5. If you take the same approach here, you don't need the new helper.
> > Just move the existing TOD start sequence above the if (!sparx5->ptp) early
> > return, so the counters are always started, while the PHC registration below it
> > is still skipped on the non-PTP variants.
> > 
> 
> ok, in v2 I'll drop the helper and always enable all 3 counters.
> 
> pw-bot: cr

Thanks. Please also fix the small nit below:

> > > > >    int sparx5_ptp_init(struct sparx5 *sparx5)
> > > > >    {
> > > > > -       u64 tod_adj = sparx5_ptp_get_nominal_value(sparx5);
> > > > >           const struct sparx5_ops *ops = sparx5->data->ops;
> > > > >           struct sparx5_port *port;
> > > > >           int err, i;
> > > > > @@ -622,8 +657,17 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
> > > > >                   sparx5->ptp = 1;
> > > > >           }
> > > > > 
> > > > > -       if (!sparx5->ptp)
> > > > > +       if (!sparx5->ptp) {
> > > > > +               if (!is_sparx5(sparx5)) {
> > > > > +                       /* the base, non-ptp-capable lan969x variants need the first tod counter
> > > > 
> > > > Nit: s/the/The
> > > > 
> > > > > +                        * running to forward frames.
> > > > > +                        */
> > > > > +                       err = sparx5_ptp_tod_start(sparx5, BIT(0));
> > > > > +                       if (err)
> > > > > +                               return err;
> > > > > +               }
> > > > >                   return 0;
> > > > > +       }
> > > > > 
> > > > >           for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
> > > > >                   err = sparx5_ptp_phc_init(sparx5, i, &sparx5_ptp_clock_info);
> > > > > @@ -635,27 +679,9 @@ int sparx5_ptp_init(struct sparx5 *sparx5)
> > > > >           spin_lock_init(&sparx5->ptp_ts_id_lock);
> > > > >           mutex_init(&sparx5->ptp_lock);
> > > > > 
> > > > > -       /* Disable master counters */
> > > > > -       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0), sparx5, PTP_PTP_DOM_CFG);
> > > > > -
> > > > > -       /* Configure the nominal TOD increment per clock cycle */
> > > > > -       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0x7),
> > > > > -                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> > > > > -                sparx5, PTP_PTP_DOM_CFG);
> > > > > -
> > > > > -       for (i = 0; i < SPARX5_PHC_COUNT; ++i) {
> > > > > -               spx5_wr((u32)tod_adj & 0xFFFFFFFF, sparx5,
> > > > > -                       PTP_CLK_PER_CFG(i, 0));
> > > > > -               spx5_wr((u32)(tod_adj >> 32), sparx5,
> > > > > -                       PTP_CLK_PER_CFG(i, 1));
> > > > > -       }
> > > > > -
> > > > > -       spx5_rmw(PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS_SET(0),
> > > > > -                PTP_PTP_DOM_CFG_PTP_CLKCFG_DIS,
> > > > > -                sparx5, PTP_PTP_DOM_CFG);
> > > > > -
> > > > > -       /* Enable master counters */
> > > > > -       spx5_wr(PTP_PTP_DOM_CFG_PTP_ENA_SET(0x7), sparx5, PTP_PTP_DOM_CFG);
> > > > > +       err = sparx5_ptp_tod_start(sparx5, GENMASK(SPARX5_PHC_COUNT - 1, 0));
> > > > > +       if (err)
> > > > > +               return err;
> > > > > 
> > > > >           for (i = 0; i < sparx5->data->consts->n_ports; i++) {
> > > > >                   port = sparx5->ports[i];
> > > > > --
> > > > > 2.55.0

/Daniel

