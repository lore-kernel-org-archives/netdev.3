Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABE2AD37;
	Sun,  2 Aug 2026 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785712583; cv=none; b=cG5unkStHMj6TFoYcVWtIOcGC9J5qd457wyzueEVBAbJFZrL+LNK3/56iza9YZ0zTnHvWwrl+Yc8HEtaJizrLriADHZk9JT8JuIBBvmbHRe74z6aVFcFo6+yF8nW5ko+5d2H78ca4mAcxW8xSNpAumdl+EkfmNTsi/clf90iKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785712583; c=relaxed/simple;
	bh=iGLj1XZqVWrqmmEUt748OXN+MzS3zioQzUotxPgTBRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNnfPuXejlW79RX7FaM8aBFFUexI0g5gQ0cCjuk05cdzVsu1k5uj4mlCGZWIIWaWZxIVaNa9f3rkPqbDAholNkiwwNhuZug9omPBVT+VQvnDbZ0nMHkUFvN/LN19U54Q29rNpfp0pmSTycUkZenhaUt8NQfCWCT5F/EWnYzgnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Lzfh8r0a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Lzfh8r0a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aWg4/vazTsGxm7MjgMLKjfveUvNnWZH6aqxiwnp7eGk=; b=Lzfh8r0a6LlxU/U2aPQug+b7m2
	iTJnmEJNDi2kQiMVPI88eu8xpLbqOKdBdpgjcCWA+xSkBfHpYGOPKZIEtE2QwcahmWekuP9zrVx3o
	qTI805nazCo7JlVNBcgWPjdel4pHxY9gFixZXWbD/RXsWt304s9BQInXI+5OBr/FWxpc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqfPZ-00FcrB-EB; Mon, 03 Aug 2026 01:16:05 +0200
Date: Mon, 3 Aug 2026 01:16:05 +0200
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
Subject: Re: [PATCH net-next 2/2] net: stmmac: ethtool: Address off-by-one
 when reading the coal rx-usecs
Message-ID: <1a4b6a74-de10-4d77-aa84-b32bae36daef@lunn.ch>
References: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
 <20260802114015.214212-3-maxime.chevallier@bootlin.com>
 <4e76d7c1-0052-4689-be7c-9c31dc24516a@lunn.ch>
 <5f2f0e3c-cc4e-4110-ad4c-180abba5356d@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2f0e3c-cc4e-4110-ad4c-180abba5356d@bootlin.com>

On Sun, Aug 02, 2026 at 10:29:22PM +0200, Maxime Chevallier wrote:
> Hi Andrew,
> 
> On 8/2/26 17:05, Andrew Lunn wrote:
> >> This does change the boundaries of accepted rx-usecs parameters, as the
> >> previously accepted values were in the 16-246 us range, and now fall
> >> into the 15-245 range on imx8mp.
> > 
> > With this change in place, what happens when trying to set 246?
> > EINVAL?
> 
> Yes indeed :
> 
> # ethtool -C eth1 rx-usecs 246
> netlink error: Invalid argument

I guess nobody will report a regression, but if they do, we can map
246 to 245. But until somebody does report it:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
