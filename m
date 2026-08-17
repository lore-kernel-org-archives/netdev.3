Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DB0282F29;
	Mon, 17 Aug 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995334; cv=none; b=ls4Xw7XuIEKUwEZNRScyO0yaoemAsEahpAAHh5wC6JeKyp70oR1FrOi0dpgMdJ55q7DhgPe7hh+NVfw0LSHNJXAuOGghqKOF7pYewv/APMYB7oN2l1KDtjgU4e/Y2fIMU4ipmiY71bGxfB+5yeAT1DJHvPRNW1HVwfZdSb1IMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995334; c=relaxed/simple;
	bh=x8EQe+VTaFjcq2kbztMMduWBWRrAjuSoWrsZJHjIYhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frFSdLhDAVgwWD9Q2M/8SdXiWyD71SguLUL7DwXxSBu3lqUya0rOm8iLCJZV/Luz16G1k/1Kt8+MG9r9jG7tGu/cFrU9+fLj7/ioyxwOSITvoX8nCNcNTlSTlaM3b2pGzCTdvM20WcyZ4katxAWuK3hfGiMG84D49dcAzaBOyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VRZw3bgz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VRZw3bgz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+hf5KBZ2hL7pA3yMzWnedAa+BWK+LSABJ+zP+GioG7M=; b=VRZw3bgza/mAM2V5N3ng54hALk
	iioqaxHOIITygoTy2EYwyjIBXfWIWYR/OH1wo42Uoja03Yfs/MXrcbxhl6+Qj3DrJUpwHfGMjImEX
	mt1GXSezSR0+5SBr7MQQXDNpEFkgGkZIYZSiC3O3PA2Hp6bIN4zEQAAxE4Q/Kf3AxmKo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww371-000MNP-2S; Mon, 17 Aug 2026 21:35:11 +0200
Date: Mon, 17 Aug 2026 21:35:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up
 C22 and C45 space in parallel
Message-ID: <0a125ab4-2453-4d32-b158-8bdaaca16674@lunn.ch>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
 <20260817162632.1208891-11-markus.stockhausen@gmx.de>
 <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch>
 <070901dd2e6d$f5b70c30$e1252490$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <070901dd2e6d$f5b70c30$e1252490$@gmx.de>

On Mon, Aug 17, 2026 at 07:29:25PM +0200, Markus Stockhausen wrote:
> Hi Andrew,
> 
> > Von: Andrew Lunn <andrew@lunn.ch> 
> > Gesendet: Montag, 17. August 2026 19:04
> > An: Markus Stockhausen <markus.stockhausen@gmx.de>
> > Betreff: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open
> up C22 and C45 space in parallel
> > 
> > ...
> > 
> > And I really think you need to block C45 over C22, since we know it
> > will go horribly wrong.
> 
> as per your guidance I Included that as patch 3 of this v14 series
> 
> https://lore.kernel.org/netdev/20260817162632.1208891-4-markus.stockhausen@g
> mx.de/T/#u

Ah, great.

Have you seen these fire? I would expect EEE, on a PHY discovered via
C22, to trigger these.

    Andrew
