Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E2E37F8A6;
	Wed, 22 Apr 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874539; cv=none; b=cvQ2oqidW1Vplo5uYesawC4pzp8WLD35eGZE4376a64IQyILAJaujpTCyHhc9kDEOIH3NQdNOhgCVE5LSpPrpF0GfWHAJ7fZ0VaMZxlRKRBOmt0wcZoPpCdTKldm2Dtpgqwr2sdGZOui18wkS+PObRoBeNiZStzyFfdhqWmq03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874539; c=relaxed/simple;
	bh=s5b7+mdwioKCLtW03CRqm97/yQq5rIMl3h60W6HsUdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbFcb//MUO2ReRh6sd84mDk8zzBz6w6QDtLlxkXpAaMhK0JvvdkCXtde2mXRwcUlWwCkssJD6wFODJ29LMjIHU5DOVS7Jpm5pBQCapsaD26YZQnhInoId1ush7wiGvcs65syLdmr0XmaRHtZlTgKDkbT0dQ/Pzjl7TfQFbcVx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V/pOPKOW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V/pOPKOW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gYxyLvufwZHnbxYQy/qzz6gAcWR7dlYuMmEysLwxlSI=; b=V/pOPKOWSD5uiySVRNqp6A7iNB
	uT2OL2EmTUkjnqs5Kibj2+hMMuwMf+l5MG0yd6wuTSbZyDeKluuv+YbyZZC/m1FiYpV/8gr1W0CoR
	NfJjE+bCx+I+PEtmFdqvipRIXuelyDo0xOtXQvQX6t9x/wXAaOy2Hy1t9V5j1LdD3ihU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFaES-00H3Xk-Hr; Wed, 22 Apr 2026 18:15:20 +0200
Date: Wed, 22 Apr 2026 18:15:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] net/stmmac: Fix typos: 'tx_undeflow_irq' ->
 'tx_underflow_irq'
Message-ID: <52b06f0a-8283-4903-9d8a-2bbdf637dd5d@lunn.ch>
References: <CGME20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6@eucas1p1.samsung.com>
 <20260421115008.2690541-1-j.raczynski@samsung.com>
 <7eb9e4d4-909c-4203-833d-bd8b664fdfbc@lunn.ch>
 <aeiJ3zr4WJAm1UCk@AMDC4622.eu.corp.samsungelectronics.net>
 <f1d51362-ca8f-481a-b9c1-400ab6422686@lunn.ch>
 <aejYCYObZyFPpLat@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aejYCYObZyFPpLat@AMDC4622.eu.corp.samsungelectronics.net>

On Wed, Apr 22, 2026 at 04:15:37PM +0200, Jakub Raczynski wrote:
> On Wed, Apr 22, 2026 at 02:47:38PM +0200, Andrew Lunn wrote:
> > > I don't see anything wrong with it?
> > > - naming is correct, same as stmmac_extra_stats from common.h, as it
> > >   wouldn't compile otherwise
> > > - string length is ok, as max name length is ETH_GSTRING_LEN=32 and it is
> > >   not close
> > > - ethtool just polls data from driver and in my tests it is ok
> > > - all instances of 'undeflow' are changed
> > > - 'underflow' semantic is ok, 'undeflow' is just not correct
> > > 
> > > Please correct me if I am wrong, but imo no issues with this patch.
> > 
> > ABI
> > 
> > This name is published as part of the kAPI. You are changing its
> > name. User space could be looking for this name, even thought it has a
> > typo in it.
> > 
> >      Andrew
> >
> I don't think it is? This part of extra stats (struct stmmac_extra_stats) and
> is not part of standard ABI from
> Documentation/ABI/testing/sysfs-class-net-statistics
> nor is mentioned in
> Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst
> 
> These extra stats are specific to stmmac driver and most of these are more
> than standard
> https://www.kernel.org/doc/html/v7.0/networking/statistics.html#c.rtnl_link_stats64
> This name does not exist outside stmmac driver, so while some application may
> expect this (stmmac specific app), question is should this typo stick?

47dd7a540b8a0 drivers/net/stmmac/stmmac_ethtool.c                  (Giuseppe Cavallaro      2009-10-14 15:13:45 -0700   81)     STMMAC_STAT(tx_undeflow_irq),

It has been exposed to user space for 17 years. In that time, there
could well be stmmac specific apps using it.

Just because it is not documented as ABI does not make it not ABI.

     Andrew
