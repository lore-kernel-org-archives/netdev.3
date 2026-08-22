Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0731367280;
	Sat, 22 Aug 2026 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428611; cv=none; b=G70C409nPyVYan/O5XMX709+N3jIPGsqMNXQl1gnXhvq8oZcasrFKP0ZHeXxQe16aa0rF2Rk+ucmZ079vs5iULiQnJr20R6Ojusth39MD7cwy34jORWLWBq64TCvNHuYbmoVZBq2VtSi4R2wPWiQsyMJAa8V5f4E4MiLu4t45IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428611; c=relaxed/simple;
	bh=Tbyf3dUCym/F3j9U7P8k+Kua7GYlhPRIrqrTOlMq/1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7rzODIgqwuBMrjgnqrVpqWvJ4JZnNukL0RZ1st7yDgCMlatqDVSWkwPpNoE8l9XG3IuztgRGbwquzF459ZtYBuzceTxbQErzakTD8WVT/vtus1kMfLHbPFSvT/gEASKUSgA9ebMs6jccr/KjvEjORgsMSyLQoxYlx44I+iea1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AlWzgNpk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AlWzgNpk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sM3VSbszbYID+mAi53gO1CTblzm0fmSPiNawdrlLIS4=; b=AlWzgNpkzHrzt6qn9k58srU/yj
	dLPS9xTGefzUq2gZV1UE4azKRFaGq6n2g8FL0FNoToFSQWwxzyn2ENFXqXgdyk5fYgRa82nKKlj8a
	GrqHR4WSlR4E6QHDCoTXHUygrCdS3F/Sg/lLm0W9cFwzFH46i3bO+j0rMC4AempT6iDs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxrpW-0013cm-Pa; Sat, 22 Aug 2026 21:56:38 +0200
Date: Sat, 22 Aug 2026 21:56:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
Subject: Re: [PATCH net] net: stmmac: selftests: Pass the IP proto mask in
 the TC selftest
Message-ID: <c7dcc194-7d30-4ac8-98cc-9d3a25cbc411@lunn.ch>
References: <20260822153245.423259-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822153245.423259-1-maxime.chevallier@bootlin.com>

On Sat, Aug 22, 2026 at 05:32:43PM +0200, Maxime Chevallier wrote:
> The stmmac TC filtering rules have recently gained sanity checks to make
> sure the passed keys and their respective masks are aligned with the HW
> filtering abilities.
> 
> The stmmac selftests failed to pass the mask in the match data for L4
> filtering tests, and are now failing consistently with -EINVAL :
> 
> $ ethtool -t eth1
> [...]
> 23. L4 DA TCP Filtering          -22
> 24. L4 SA TCP Filtering          -22
> 25. L4 DA UDP Filtering          -22
> 26. L4 SA UDP Filtering          -22
> 
> Let's pass the ip_proto mask in the l4 filtering tests match data. Found
> on imx8mp, which now have passing L4 tests :
> 
> $ ethtool -t eth1
> [...]
> 23. L4 DA TCP Filtering          0
> 24. L4 SA TCP Filtering          0
> 25. L4 DA UDP Filtering          0
> 26. L4 SA UDP Filtering          0
> 
> Fixes: 5536d7c84363 ("net: stmmac: fix l3l4 filter rejecting unsupported offload requests")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
