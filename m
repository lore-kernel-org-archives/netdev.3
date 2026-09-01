Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4A47DFAF;
	Tue,  1 Sep 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265324; cv=none; b=UZH0YYlXdUuXRXrUjfBN00uzMZevQaMCcFccS8zZ/dSGYyoH1Uni3ibYQ9FiMz/TjGJxPmCs9zE8DOBBCc2l0PEw+sdXQgqiCdfdfFBwTJ5ne9owdykhdBqvlLJA7dTO9Qj/aRM/x6GxaztLZmVMsAzaWfa3bQ/aU9Jnf14B7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265324; c=relaxed/simple;
	bh=jguE+jBNVdn2uoYwoeLueg6h98XsLE2+XBGA/50gzoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmFd/Jh7mW3LMu27LEK6uy11EmEfu6y2+zHnG4T9VeqMFsoxAgDNCgYSBGm5DSv4gTqtTTJUBPluRWeEF6fc/2cysiwwnHqrR0sdse1eMJHiCMKDimMKHN0mrbyaRRRXXSEwG6kxx+jmZRJ0p53FZNufUr/YDCdIHMZttu/J6+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wIYwJysD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wIYwJysD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HdWnpN5iGKqOjiVIG1o47AbqSjEI69XYYtz2Z3ole4A=; b=wIYwJysDRjxZNe5mlKoAshLsC2
	PGC67MswfnqliG2iCZ95UIO8R4sNNbOsVYb46auguwyTiUI0Da3FoVY+EyrkoWI1XybrcrkBovnn0
	9DD6ZjySSPtjJpRsFLjXVEOFyD2MbWsA58IFoADS8g+uup2dUBBEHh6frpxKs2hss8h8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1NUu-002Lya-1S; Tue, 01 Sep 2026 14:21:52 +0200
Date: Tue, 1 Sep 2026 14:21:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac4: Use the full perfect
 filter ability for UC filter
Message-ID: <c7819431-d33d-4e9c-ab36-be55b94d29f4@lunn.ch>
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-3-maxime.chevallier@bootlin.com>
 <285c8969-2f0d-46de-b098-60ff10f30cf6@lunn.ch>
 <493afde2-8603-41e8-b6ce-f8e399c53275@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493afde2-8603-41e8-b6ce-f8e399c53275@bootlin.com>

On Tue, Sep 01, 2026 at 08:37:20AM +0200, Maxime Chevallier wrote:
> Hi,
> 
> On 9/1/26 02:12, Andrew Lunn wrote:
> > On Mon, Aug 31, 2026 at 09:01:20AM +0200, Maxime Chevallier wrote:
> >> Contrary to dwmac1000 that gets its number of perfect filter entries
> >> through the 'snps,perfect-filter-entries' property, dwmac4 allows
> >> reading the filter size from the HW features registers.
> > 
> > Does dwmac4 take any notice of "snps,perfect-filter-entries"? Should
> > it be marked deprecated?
> 
> It's only used on :
> 
>   "st,spear600-gmac"
>   "snps,dwmac-3.50a"
>   "snps,dwmac-3.70a"
>   "snps,dwmac-3.72a"
>   "snps,dwmac"
> 
> So, dwmac1000.
> 
> I'd say, we can definitely deprecate on IPs that don't match these.
> 
> Interestingly, there are _some_ dwmac4 devicetrees out there that use
> this property. It achieves nothing, and even worse, doesn't match what
> the HW reports :
> 
> In arch/riscv/boot/dts/starfive/jh7110.dtsi for example :
> 
> gmac1: ethernet@16040000 {                                            
> 	compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
> 	[...]
> 	snps,perfect-filter-entries = <256>;
> }

So another thing for the TODO list, extend the YAML description to
make properties conditional on the IP core version, so the validator
tools will pick this up.

	Andrew
