Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B21C2AA
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777440650; cv=none; b=hBSOwGJONzatHL+EChkDOBepdoERw7pDkXZfQzjQv8Lgwka2MxDERzKeZe4AlHeUnQFoUtunZpP4ulvEpMfPhlexB9KBkf4MWgm97Eio09UHIFYrOouJbT9zkdDmgJWnbwFSVCv6L9g1Uqjr+vxH5lvYZ2QfRTumX+Czp4MzDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777440650; c=relaxed/simple;
	bh=5tKywtATYjWJcbXzwBYNzPLdoHBHSKQwaDNeyi+EQ9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPVSsTw8VUqkgS7Ti4qP0O3+rys7hvmzLueVKu7/Ac++Wsaj483+F3rZY6r8LPjf8MQvBvyCXv3aH4e8EqVTFtvPKWqhK3Aybtls6NrPlcX5R/bm1BNBR7jNaJ49CFhxtKEupZ41kij2VioWv084Ao2u2VEkX+WpkDev2AzX+9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgJB0JHo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgJB0JHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777440649; x=1808976649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5tKywtATYjWJcbXzwBYNzPLdoHBHSKQwaDNeyi+EQ9I=;
  b=HgJB0JHocxJbcLgQnCntgI+9lpVF7Xi9l2ZIOcXj8XWf5/CXJ4PNHTAY
   /4wDpBP+MxkgQ+yoxqQ0yyisAPQl7THPTIDSoMAeYA1T3yakQgHojiOrv
   YEPQj58ukrWLzfy3h6JRubdlWVrXm+L7DTv5OSZzA785M7yTm3VD08hnM
   eTekxCGO4w/bXlrK8E5HCqxjUvc7L4G7/vPWUlClqFryqmZA31Td0vv1/
   2ZWrshnS2oxyHi29L3mjOSII/n1Urz8tXEkPLoznnrzgYMLSBgLlVh6R+
   MC5Tt8fOml4cQvF3kZ6CNqa6K64zDId9HtrhO0K8KxWaUe+PCssj3irMq
   Q==;
X-CSE-ConnectionGUID: W33XvOeRSbKbFYbGZp84TQ==
X-CSE-MsgGUID: 2kWxsKbBRgSDLqLOe0e64g==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77391461"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="77391461"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 22:30:49 -0700
X-CSE-ConnectionGUID: bbzv0Bf8RKygGMsXVcGmaQ==
X-CSE-MsgGUID: 6/j6gCBlSp6ONFioDH1q0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="234027944"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 28 Apr 2026 22:30:47 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 3203A95; Wed, 29 Apr 2026 07:30:46 +0200 (CEST)
Date: Wed, 29 Apr 2026 07:30:46 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH 1/2] net: thunderbolt: Call tbnet_stop() upon shutdown
Message-ID: <20260429053046.GZ557136@black.igk.intel.com>
References: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
 <20260429011224.1505785-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429011224.1505785-1-kuba@kernel.org>

On Tue, Apr 28, 2026 at 06:12:24PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: thunderbolt: Call tbnet_stop() upon shutdown
>     
> This commit updates the shutdown callback for the Thunderbolt network service
> driver to call tbnet_stop() if the interface is running. This ensures the
> service drivers release the rings upon shutdown.
> 
> > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> > index 7aae5d915a1e..631af237998d 100644
> > --- a/drivers/net/thunderbolt/main.c
> > +++ b/drivers/net/thunderbolt/main.c
> > @@ -1417,7 +1417,10 @@ static void tbnet_remove(struct tb_service *svc)
> >  
> >  static void tbnet_shutdown(struct tb_service *svc)
> >  {
> > -	tbnet_tear_down(tb_service_get_drvdata(svc), true);
> > +	struct tbnet *net = tb_service_get_drvdata(svc);
> > +
> > +	if (netif_running(net->dev))
> > +		tbnet_stop(net->dev);
> 
> Does calling tbnet_stop() directly bypass the network stack teardown sequence?

This is called when the machine is rebooted or shut down to quiesce the
device. I don't think the network stack has anything similar?

> tbnet_stop() appears to be the driver's ndo_stop callback. By bypassing
> dev_close(), netif_tx_disable() is not called and the device's transmit queues
> remain active.

tbnet_stop() calls tbnet_tear_down() that calls netif_stop_queue() which
should stop the queue.

> tbnet_stop() destroys the DMA rings and explicitly sets net->tx_ring.ring
> to NULL:
> 
> drivers/net/thunderbolt/main.c:tbnet_stop() {
>     ...
>     tb_ring_free(net->tx_ring.ring);
>     net->tx_ring.ring = NULL;
>     ...
> }
> 
> If a concurrent transmission occurs, will tbnet_start_xmit() access the null
> pointer and cause a crash?

It should not happen see above.

> Additionally, since this does not hold the rtnl_lock(), could this race
> with concurrent administrative state changes (like 'ip link set dev down')
> and lead to a double-execution of tbnet_stop()?

As far as I can tell no because when these hooks are called userspace is
not running anymore (we are rebooting or shutting down).
