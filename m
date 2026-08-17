Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E45345EA2;
	Mon, 17 Aug 2026 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786998723; cv=none; b=bb6zwQ5NZgN9G9Vl49Br6o72fEL7ckMIPaufhcjKuj77jOcunA2cuGPWvLFOh3/Ytapi11tp9eAnwvVhdVTjEcf2zgnMkWmcHGhSTehc2RsT0TzbzxKThCaGM7I1c/jFlRaqZT8xZ5XrNKRPLT2+WFEi3K7PtY5KFXzgC3mJXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786998723; c=relaxed/simple;
	bh=QSLrLtF68zvdxOdw9Ib0nMqLWr9+gn5LCD9GpDXqnbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9TcuStSQsJjDMPNgUH3t3pVv7vNNyEDCNagbEExHaURheC138uGKXv5VrL68MSv9gFjc9QZOIwhoOOP9AsMPkaXgU8g0God2tKQzTt3w4DQziC2qFgjzc0T50CE1HkvA6otqBeHIdkBBlQB/riBE5bVGknOLYihzTeVHu8FGNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1f5MlIho; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1f5MlIho"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ql2SwFL8AOLO9GjGj9vFg1kfZiRMR6tKwQm/O1U1c2w=; b=1f5MlIhoaL6iKamdjQk/oMscdq
	UTOageIwE91WIfGSI02SQM+C2iRYl82X6DyWq9WmKar0/yX5SWXPbuW1LgJJzjlxZYPGntn/yh9FI
	eB6pQYrSm4smfzlfclTO/PudVdeCqh8fcdy9jQTahVIJ8BLgsOCnlUsSLjGBz4qE5KzY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww3zl-000Mkv-SN; Mon, 17 Aug 2026 22:31:45 +0200
Date: Mon, 17 Aug 2026 22:31:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up
 C22 and C45 space in parallel
Message-ID: <ecc68c5f-02cb-4249-9f09-f161cc97a989@lunn.ch>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
 <20260817162632.1208891-11-markus.stockhausen@gmx.de>
 <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch>
 <070901dd2e6d$f5b70c30$e1252490$@gmx.de>
 <0a125ab4-2453-4d32-b158-8bdaaca16674@lunn.ch>
 <089001dd2e83$b8957920$29c06b60$@gmx.de>
 <2fd17092-753a-4a80-bdf4-72801eca8d0a@lunn.ch>
 <08e501dd2e86$98e9fdf0$cabdf9d0$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e501dd2e86$98e9fdf0$cabdf9d0$@gmx.de>

On Mon, Aug 17, 2026 at 10:25:47PM +0200, Markus Stockhausen wrote:
> > Von: Andrew Lunn <andrew@lunn.ch> 
> > Gesendet: Montag, 17. August 2026 22:11
> > An: Markus Stockhausen <markus.stockhausen@gmx.de>
> > Betreff: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open
> up C22 and C45 space in parallel
> >
> > > All downstream 1G PHY drivers for that platform use dedicated 
> > > read_mmd/write_mmd callbacks that run __mdiobus_c45_read/write().
> > > So no warnings during bootup.
> >
> > O.K.
> >
> > In Mainline, please think about how you make that work. Are these PHYs
> > also used with MDIO busses which have working C45 over C22? And no
> > C45?
> 
> Until now we never encountered any of these PHYs in scope 
> (RTL8218x octa port) outside of the Realtek RTL83xx/RTL93xx 
> ecosystem.

Is the ID in registers 2 and 2 specific to the RTL83xx/RTL93xx ?  That
would make thinks simple.

   Andrew
