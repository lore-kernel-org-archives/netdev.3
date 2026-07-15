Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15FC3ADBB4
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134989; cv=none; b=vAZMIm9tywsalrudByKhibN5/g0RGRwzGIrMusKUnWD2VJNFIZP7JQMU0438hcgOGQDYPhbUPezBG1UdSR8ORH445lzH9pxigrPm/ZKMmzCSps3xRgvVLQ9FoSeyS631+CeFS+8a13xKG5N+kyQy/M3bv5WT2u/QQgI78T2odTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134989; c=relaxed/simple;
	bh=ska6s+vKwUlY3Yt6eSjfq5rFzplE/pDOsb+cR91HbP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhUxnQi+6TdsBoUkn5F6izCUqN9thzm3g+jPKGMR0wHZCzY8YDAQVTOboChocbetviQrlW6CNeMII6Ge12cGch8jc0CJxq4DGyPBl+SefYNlhwJ3dz9eWi8hZN+BqWZoYtzGZfUQ+5KwGx2iXHFMWMI6RxncC9K/hVUEY+YMdVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i1dejHaY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i1dejHaY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CLmTHJzl2RC79eARPtdanItSG6FUhyp9lTCBSKPCrMk=; b=i1dejHaYDMZmatftIacXh6E9s/
	PT7nagr+jsV9QdbRidIoZRC+GvRYfFL6tgNogXrVrD29DdJ/SlaoLfnYNNbssUUvA/IStJGhd+lIA
	8naquVRhYT4ZC8E2kIiA7jiikB9qgtSWD1Vh+wCnVv2GP8/4wUCN97Yn05pctm8/fJEo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wk30f-00COM9-ML; Wed, 15 Jul 2026 19:03:01 +0200
Date: Wed, 15 Jul 2026 19:03:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: add support for 1000BASE-X
 autonegotiation to PCS
Message-ID: <a060301e-24c4-4f83-8720-ddc3936a9352@lunn.ch>
References: <20260714200904.70428-1-nwhitehorn@pa.msu.edu>
 <ale1VbrKF/ls5Zt4@bby-cbu-swbuild03.eng.microchip.com>
 <ab0883e3-fc15-41f7-a851-07bc4697aa42@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0883e3-fc15-41f7-a851-07bc4697aa42@pa.msu.edu>

> > > @@ -1025,13 +1034,15 @@ static int macb_mii_probe(struct net_device *dev)
> > >   	struct macb *bp = netdev_priv(dev);
> > >   	bp->phylink_sgmii_pcs.ops = &macb_phylink_pcs_ops;
> > > +	bp->phylink_sgmii_pcs.poll = true;
> > Why is this needed for 1000base-x?
> 
> Without this, the hardware does not detect link state changes after
> initialization. I am assuming that in the normal SGMII use-case with an
> external onboard PHY etc., those state changes either don't have or are
> signaled by monitoring the PHY, so that support for this wasn't needed. With
> removable modules, fiber, etc., state changes are suddenly both possible and
> otherwise unsignaled. It is possible -- likely, actually -- that there is
> some better way to do this by properly monitoring an interrupt somewhere,
> but I am working without documentation so am not sure how to implement that
> and was trying to keep the patch short. Polling worked well enough as an
> alternative.

This does not sound quiet correct. A PCS has two options.

1) As you say, it implements interrupts, and calls
phylink_pcs_change() on each interrupt to let phylink know something
happened.

2) You set poll true, and phylink will poll the PCS every second.

A PHY generally only reports on its media side changing state. I also
don't think phylink will poll the PCS if the PHY changes state.

I don't see anywhere macb calls phylink_pcs_change(), so polling does
seem correct.

Please break this patch up. You can add polling in a patch of its own,
with the commit message explaining why it is needed.

     Andrew
