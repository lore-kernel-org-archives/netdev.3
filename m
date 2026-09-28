Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32E04AA3EA;
	Mon, 28 Sep 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595357; cv=none; b=kOyufqjMl6gCutchv34PU7t7vAKBT1VrO8noz8U7TmVkDwjoCa/ICynaQoItDbnyyC7aSNGM/8sylzPWL39v96auLO7pjLBVYY8NWeRO0cIkK80TYB9S9VnhHRAkYLWJ6EAOB1kK2fbb48kDIlhTbbrV33X8ouljHt28BefU1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595357; c=relaxed/simple;
	bh=K9oarBLTsz3tYju3/iKUDoMfwg9+PAPFny7q0FdzE7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM0bCo1MErznhf+DWpLvnkFK7hNcXVnh/w/8Jphd4lohKdHY/Chwvy9AEH0wtLnX4goFzKqFpQHpMyJqI9Lor1XugW38jhWGszceWjbfHSziBYuWZ9LYXQ12cVE+Tgh9Z8fKHQI+9wOOp+nNUGQRCIGPJFGA7qhkxwVvkwPp6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=QZTNH+rg; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="QZTNH+rg"
Received: from L30177.local (unknown [78.240.193.235])
	(Authenticated sender: vjardin@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 88DBE19F58A;
	Mon, 28 Sep 2026 13:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790595353;
	bh=K9oarBLTsz3tYju3/iKUDoMfwg9+PAPFny7q0FdzE7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZTNH+rgUbNtC3/+lctt8Fa3/C7FNRx8swV8HJBZI54aQvJ3mvmolxMBFru3nOrgB
	 /8cyKK3PdE9V6EI6NpVYAb9XLNETF/yxo75FbqPRNWpCePhP7wfXH7rHG39Dk8GVlt
	 F4gvyUP9Lr3lb3CEPvlxTOuHIxozUzdbppjY4rU5q45ClPPvqDIUI+HIsHZRBXf1OE
	 vwAhwdLgI/eyTAZPor44lo1LEKVz7+aPbquR+dnXzF5Q/09VdPYBu5zLrfOG1TtDs7
	 1i7zQ1ykTuzuKXbYwGp15qbQSPxGfG30gNWpbOdrM5rGcsfnzBsrZ7VOCg117+KoiR
	 vrJEKOZoO6paw==
Date: Mon, 28 Sep 2026 13:35:41 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] dpaa2-eth: DPNIs without a DPMAC should be
 virtual devlink ports
Message-ID: <arpRDebOwAe08pc9@L30177.local>
References: <20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00@free.fr>
 <20260923-for-upstream-dpaa2_ports-v1-2-b59c865edd00@free.fr>
 <hh6bjsyoe4hidiiyl3bt6tsmizfpf5p4h3gpbflcnsakcpgwjr@2pi6r22dpor2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hh6bjsyoe4hidiiyl3bt6tsmizfpf5p4h3gpbflcnsakcpgwjr@2pi6r22dpor2>

Hi Ioana,

> > A DPNI whose endpoint is not a DPMAC has no physical connector: it
> > may have no endpoint at all, or be connected to another DPNI or to a
> > DPSW port. It is still registered as a physical devlink port, number 0,
> > so userspace sees a physical port that does not exist.
> 
> Reword this so that it's clear that you are describing the state before
> the patch.

Done, see v2

> > A virtual port has no phys_port_name, so only the DPNIs that serve a
> > DPMAC report one, and "p<dpmac id>" never collides.
> 
> Reword this as well and mention directly what you are changing.

Done,

> 
> I would also suggest a change in the subject title:
>  dpaa2-eth: mark DPNIs without a DPMAC as virtual devlink ports

OK, thanks for the suggestion

> >  void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv)
> >  {
> > -	u32 registered = priv->devlink_port.attrs.phys.port_number;
> > +	const struct devlink_port_attrs *attrs = &priv->devlink_port.attrs;
> >  	u32 current_number = dpaa2_eth_dl_port_number(priv);
> > +	u32 registered = 0;
> 
> Move these changes to patch 1/2.


ok, done

Thanks for the comments,
  Vincent
