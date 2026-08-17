Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BF3B27C9;
	Mon, 17 Aug 2026 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997456; cv=none; b=RSwqiT2wAFAW4dyzSItZ/2+2dHVOL/gkWoUFfKWSUfMILkzSZWNALx0Mh/j3AHyQU+qt9G1Y6x3pQoFrFyC0RaH+hjLY/crkjkztoQOJRLMaF/cMWt+EB+4+G40ORxr54jTHaXQCWGPTS0wLJp+0a6gCvSfY4ZzbE49RGOa3gv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997456; c=relaxed/simple;
	bh=z6a1/MR5DhunH0cIZtqwgJYyCJ+yEXbdZ1HqnYXrAC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBKnqJS8GReXwdc5X8YVzA33CK5gkxfs0l7ooC2lJm0V9YIMgFZ3VXdPekuuCLAUzoXANRVpysoKfTW6ZSCiN8Y/ALFoaOubmMCcdwH+QMoah1H1tsYoX5cA/21Id+FZ3HJgcL6EJ6ei+cvvv9eom+G//6d6eBDQPNw/fnp7r5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NsLqkYiZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NsLqkYiZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wbbnnqPzPSon7hjW5cAZLR61I40lQjjTdhGFBpNoT/w=; b=NsLqkYiZhCZyihNwrnbmfuz9r5
	lTd8U+IxyXqX2L+cT6fkfCT91PJETcS+fZes2GQSAwguyXboZd3Jr3bD8IDEbe10dZvEQt3PP6s/x
	inVE28O8Fk4t6WMT2HqnUl/Sjwkj6tO9aeq99L7F3S5sz1UtoUJ4xt9zFnaL4KIjZV+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww3fE-000Md9-1q; Mon, 17 Aug 2026 22:10:32 +0200
Date: Mon, 17 Aug 2026 22:10:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up
 C22 and C45 space in parallel
Message-ID: <2fd17092-753a-4a80-bdf4-72801eca8d0a@lunn.ch>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
 <20260817162632.1208891-11-markus.stockhausen@gmx.de>
 <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch>
 <070901dd2e6d$f5b70c30$e1252490$@gmx.de>
 <0a125ab4-2453-4d32-b158-8bdaaca16674@lunn.ch>
 <089001dd2e83$b8957920$29c06b60$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089001dd2e83$b8957920$29c06b60$@gmx.de>

> All downstream 1G PHY drivers for that platform use dedicated 
> read_mmd/write_mmd callbacks that run __mdiobus_c45_read/write().
> So no warnings during bootup.

O.K.

In Mainline, please think about how you make that work. Are these PHYs
also used with MDIO busses which have working C45 over C22? And no
C45?

	Andrew
