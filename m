Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A34AA59E;
	Mon, 28 Sep 2026 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594871; cv=none; b=b+g4E84mCBuI6G+mMgj64At1wo8Pmw0nprazzlIx0BJYSIY0xVKoU6+9+B3cWa3L6RoqkwNJgNI4pIysBVIhhqMq3NKnO3S1yvqg9MYilotmfVZnT3fvz6kMqPEgtdBWRiscw9bK6d0I0J06msUFD3s2TPFl2o3knYhypQtm5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594871; c=relaxed/simple;
	bh=bLW5mwMWA1JAJLPk41sWDrxcZfou7gFNVRYc1LNgO1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4u5vyeAT4Uhf0sSl+QnjdO0pBON+F1HGFBJjj6hpMHdxhpjecqWdZMwwz43oFesepdxK2Tn21izsHPbzliAyiL5P9WkCjcZ5PrVCq6/stK7hkenRb3pJhNCIEv6jLq7eSvENzha0YM2eR8WWtxkP5q5IaGPdnWntlKkPTnnXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=jr7R5VHD; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="jr7R5VHD"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id CFF9EDF8A3E;
	Mon, 28 Sep 2026 13:27:35 +0200 (CEST)
Received: from L30177.local (unknown [78.240.193.235])
	(Authenticated sender: vjardin@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 39E3419F57B;
	Mon, 28 Sep 2026 13:27:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790594848;
	bh=bLW5mwMWA1JAJLPk41sWDrxcZfou7gFNVRYc1LNgO1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jr7R5VHDGj6WnceAeY849xziL7b+fWlOjb9rel0FOlRJATu1n+ZWROwH+37zaaFjo
	 ltVnJeUpPPtoAFKM6iU6Ysj5veR3RsExEHXL73KYUMSjn2nHo5GCH9g2p7nIB3DBgl
	 dc+GRbu8kauYpncKA88LZiI6Xt5LK2tY5l7+7nHyHynzURX7AmedWLz2AYT+v+7aOt
	 Q26XottpWlPYwy51v39jhIDdOBlrpGftuwMNJvrTL/eN7yH/7gXgOPUWBA8o4SZH5o
	 b824+6SJwRCKYc7K/Tu/M/ePTJ+d9+tageycSVieZoIHL8IMLPYzr2k4c/Wd3uG754
	 DaqA9F/9JQCcw==
Date: Mon, 28 Sep 2026 13:27:14 +0200
From: Vincent Jardin <vjardin@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
	vladimir.oltean@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dpaa2-eth: use the DPMAC id as the devlink
 physical port number
Message-ID: <arpPEiJiooITjwlK@L30177.local>
References: <20260923-for-upstream-dpaa2_ports-v1-1-b59c865edd00@free.fr>
 <179051506971.2160803.13967739532547877580@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179051506971.2160803.13967739532547877580@kernel.org>

Hi M. Bot,

See below

> > +void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv)
> > +{
> > +	u32 registered = priv->devlink_port.attrs.phys.port_number;
> > +	u32 current_number = dpaa2_eth_dl_port_number(priv);
> 
> [Severity: Low]
> Can this read of priv->devlink_port.attrs race with probe and remove?

Yes, see v2. I did add the port number in priv under mac_lock.

> [Severity: Low]
> Does the "current" value used by dpaa2_eth_dl_port_check() really
> reflect the firmware endpoint?

Yes, it does. The 0: non was missleading.

The prints is updated following the reiews and Iona's comments, see v2.

> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch, but
> the new dpaa2_eth_dl_port_check() call adds another priv access on this
> path. Can dpni_irq0_handler_thread() run after priv has been freed?

I could be, it was there before, so let's avoid unfocusing this serie.

Best regards,
  Vincent
