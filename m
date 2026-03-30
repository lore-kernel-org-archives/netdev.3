Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239F3CAE7C
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873636; cv=none; b=JazmOORk57xDfj8QcyBsa7UY6ERPNTUaKkJxaEgxI6GQOwgRAT+VAks78tA9VenxB6Cl0zRBrW+dGs5eOqlDIS8qlLy3t5Ll9th1Hs1FI5kjLNB2Lr2OHa2HOHuvU/hu8LNAwgtw+6UTtLELjUNdSt5xE9xg13KGdfULGFmyl8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873636; c=relaxed/simple;
	bh=llJznkRYrMjQ2g8AZalOG8AxrTe4w2O9WpmyW53WKxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuQn3Nk2NKMyOg3dzmyh937FrDjyHg4AeGt0S5HULr29cPImGLvvXWsnihEFJl3DXQ2s4OX3IccHtl/c8NqoludffcObyBh6x/+Ab+LONr9GILfW3wiu+k31Ymppe8/g7RVbThOSZ1NHndcoKBQpIQHCFpiMXzqf1LZCl2gABTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=auSz9rJ9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="auSz9rJ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZloaSKpGUzTDvSvNkKJvXGWiuMQ2BtRRtHd9Y3h/ZYI=; b=auSz9rJ9sMa6GLQVUFg4Jl2EFo
	XnX55W0roCH4ZPx4MiCqFoelj0sTGWLg7tclkDdEDi7MPrVQMQJbjPiCqkbRuB1dN9uz0YycvrWDT
	k3GhkpSF4hNO07gAd6xteTN6W2kUYtWCURsh8sEx2gy0UQJnqIPhuQLENLGc10OVvj/w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7Bhq-00E1sM-Od; Mon, 30 Mar 2026 14:26:58 +0200
Date: Mon, 30 Mar 2026 14:26:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net-next] net: phylink: allow PHYs to be attached in
 802.3z inband mode
Message-ID: <30a2cad9-fa2c-4abe-ad51-983d70564c7c@lunn.ch>
References: <E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk>
 <a5d7aedb-9770-492f-b528-0a28a652279b@bootlin.com>
 <acatrPb1DdHuyVoL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acatrPb1DdHuyVoL@shell.armlinux.org.uk>

> As I've recently said, I think we're more or less boxed in between a
> rock and a hard place because of the hacks that qcom-ethqos introduced
> with its PCS support. At the moment, I am failing to see any path where
> the stmmac PCS can be programmed for inband according to phylink's
> wishes and qcom-ethqos can be made to work without its hacks.
> 
> This all ultimately comes back to the half-hearted phylink conversion
> of stmmac that was done behind my back without my review. Had the
> conversion been done fully, and kept up with the phylink changes for
> PCS support, then we probably wouldn't be in this situation today.
> 
> Unfortunately, the driver is going to keep breaking all the time that
> it abuses phylink, and at the moment I see no way to stop this sodding
> driver abusing phylink.

"The needs of the many outweigh the needs of the few"

The MAC driver is used by a lot of different SoCs. If qcom-ethqos
caused this problem, should we consider breaking backwards
compatibility for it, if that opens up a path for getting clean
phylink integration for all the other variants?

	Andrew
