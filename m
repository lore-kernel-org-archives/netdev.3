Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCF4A3F24
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401338; cv=none; b=up+4npUPcGkxavZys7bqUJPvoH6rpiK8MdhMoomTD1QTz9rzJn0l0xFQzX5mRGCDxCOM6+D8VYjZuAedz/pOjqKDqwX1lgx5+VLVBwp/6UxFsDvgrjiTA95Ouoz/bD2BrpH1RmvbgT9nT+3bP6uybHCL3F4RXc55S5eyxpgZ8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401338; c=relaxed/simple;
	bh=9FvCvb7ngah8XSXTDgtDxUBlBBsRFmZktcpCkJlQ0+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkP0rIKeKss3fO3MjynWBSEBJosFUiUBQVco0Uns6OAIkziJuMlIOUZswKYi5LEKk5cMxu0Ch3NxE1eVxRxhUhQ07SrcWimE3/oryiurjiQa1S0gWDklSLuayi19eKMzke5a02t/xCEb4OCqLQmzXywZR6hgCY3EGtswyx6SpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PmAtVGck; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PmAtVGck"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792401337; x=1823937337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FvCvb7ngah8XSXTDgtDxUBlBBsRFmZktcpCkJlQ0+4=;
  b=PmAtVGckaJTkYnfQ/UL+ZpC53xUyfX0d9nPNN1jI7osNwLtTE4AJahvh
   Sc82uKXioTK7LfRmmx02aeC47hCE/J8YwO6Q1kBtVUqEfMw2G6yi+9PU8
   iDpPgoxt3xB9/Xzu65jlKr8dqjHjejstKt6ydZ0TuLg7v1G8AFuelTdhc
   KXByUQHVncFsIZwfSaeqms2DjZq360QY1C+S+89XjAC7rV8/8cu8ZXL51
   4B6ffN0lpdQUgp74nLesxHlrcPYiwAIos6MIrkxC7V/Qc4FEqG0wMp6ah
   jIBGaQQcR9yDfXcA66+OOe3mHTuIJTSETSmd3JF26jcXDsRfhgoDN2ZlH
   w==;
X-CSE-ConnectionGUID: 7LbDGSXEQQO191iszco7RQ==
X-CSE-MsgGUID: TTYIOqJFTYiQXS9LFmi8Ow==
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="65240827"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:15:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Mon, 19 Oct 2026 02:15:29 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 19 Oct 2026 02:15:26 -0700
Date: Mon, 19 Oct 2026 11:15:20 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <netdev@vger.kernel.org>, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Chintan Vankar <c-vankar@ti.com>, Danish
 Anwar <danishanwar@ti.com>, Daolin Qiu <d-qiu@ti.com>, "David S. Miller"
	<davem@davemloft.net>, Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Neelima Muralidharan <neelima@ti.com>, Paolo Abeni
	<pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>, Pratheesh Gangadhar
 TK <pratheesh@ti.com>, Richard Cochran <richardcochran@gmail.com>, Simon
 Horman <horms@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Subject: Re: [PATCH net-next v9 7/8] hsr: Move struct hsr_ethhdr to a global
 header
Message-ID: <20261019091520.wpi5v2zrkrvfwe4l@DEN-DL-M70577>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
 <20261014-hsr_ptp-v9-7-2d20a2a0f816@linutronix.de>
 <20261016093853.jugkxkcvzxsm2kgx@DEN-DL-M70577.microsemi.net>
 <20261016100749.52Kn_i9J@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016100749.52Kn_i9J@linutronix.de>

> On 2026-10-16 11:38:53 [+0200], Daniel Machon wrote:
> > > In the offloading case the network driver needs to inspect the HSR
> > > header to find out if the encapsulated type is a PTP packet where it
> > > needs suppress offloading of the packet.
> > >
> > > Move the header so it can be included the driver.
> >
> > nits:
> >
> > s/needs suppress/needs to suppress/
> > s/included the driver/included by the driver/
> >
> > This is the header that drivers needs to poke into, to find out if they should
> > steer the frame and add a header or not, right? Would it make sense to add a few
> > helpers here?
> 
> This is correct. Could we talk about the helper once we have the first
> driver using them so there is an idea how a helper could look like?

Yes, sounds reasonable.

> 
> In icssg, for PRP I have just
>         "eth_hdr(skb)->h_proto != htons(ETH_P_1588"
> 
> as a check among a handful driver internal checks to figure out if
> offloading here applies (so no header, no sending on both ports).
> For HSR I have this:
> 
> |                       /*
> |                        * On HSR:
> |                        * - all packets except HSR including PTP get a
> |                        *   header added
> |                        * - HSR including a PTP frame or PTP frames are not
> |                        *   sent on both ports, everything else is.
> |                        */
> |                       is_P_1588 = skb->protocol == htons(ETH_P_1588);
> |                       is_P_HSR = skb->protocol == htons(ETH_P_HSR);
> |                       if (is_P_HSR) {
> |                               struct hsr_ethhdr *hsr_hdr;
> |
> |                               hsr_hdr = (struct hsr_ethhdr *)skb_mac_header(skb);
> |                               if (hsr_hdr->hsr_tag.encap_proto == htons(ETH_P_1588))
> |                                       inner_is_P_1588 = true;
> |                       }
> 
> so it could get this logic and have is_P_1588 + is_P_HSR as returned/
> set arguments in the driver logic, that follows.
> 
> > /Daniel
> 
> Sebastian

/Daniel
