Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1AF4F1;
	Wed,  5 Aug 2026 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963477; cv=none; b=VkmkD6gO0cR50w4vsEKPzTbObsXEkmlOPKvyDc5xp1q4ToHDkyLrWmrLVZP2RVXyUFtnNiKF2aVtNuaJvFxcp0Hr5g44/ajITt+3gNM6bjOYsi0m85k+vhYpcthyUtU+NT6Xw85KLV8hlRty2UJbVZARyh3wOp1bcg0cjtLu25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963477; c=relaxed/simple;
	bh=wTPV/gz4ds+t1PfT36WfQEB9gHGJR8JiU761sqC6ews=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmImWHOZHcrZYMpdy6BdyVsSMcAve+Kf4HTJz8KrDumYMKQWT/DDo1tPnr/2//XizhjiSIsewul0V+QUgwnDKQ7TZRprEn4KeSl6z7A53MBp/qrx5Lsax/kig4NAwEA+sc/V9umZ0mAODIqzM+d+/EI4WkE7plo7BA6TGFo4J0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yOFjryBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yOFjryBm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=67FkVR7zlxPkd3JcEtzFf+ZKSYXXSY0vO0kegPJBHJw=; b=yOFjryBmU79qP3ZIqXABhJZL7i
	cJ53egEN+dQXvgUQXHwrWztDNzYXy7szzTXQLublurjx1D7vRLm0bgdOn7PBktWuO8DFODU9D/kvN
	tMQ5cY3tEWSn1lpn0fkc4d+Yi2Lv6mSGM4w6fy0Io9d5ol8PVhhT1ubGtYStPxCg19YU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrigF-00GFkk-O9; Wed, 05 Aug 2026 22:57:39 +0200
Date: Wed, 5 Aug 2026 22:57:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Polak, Leszek" <LPolak@arri.de>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: macb: fix stale data returned by MDIO reads
Message-ID: <970df4d9-6199-4148-840a-ed1897ff27eb@lunn.ch>
References: <PA1PR03MB11059B8723E1C212E5801A52DC8D32@PA1PR03MB11059.eurprd03.prod.outlook.com>
 <DKH3AOWRPUDD.1IOVFERUUNC1J@bootlin.com>
 <DKH3G9J1MI8G.24Q6WY2SU93I9@bootlin.com>
 <DKH3PSLM2LJ8.1S1B51A95T75M@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKH3PSLM2LJ8.1S1B51A95T75M@bootlin.com>

> A proper solution would use the IRQ as detection source rather than
> sleep-polling. See BIT 0, called MFD in driver.

Maybe.

The FEC driver used to use interrupts for its MDIO bus. But interrupts
add a lot of overhead. I swapped the FEC to polling and got a
significant speed improvement.

A lot depends on what you have actually doing with the bus. I was
using it in combination with Marvell PHYs, which can give the raw
cable test values, which is a big data set. So the speed up was
welcome. But if all the bus is used for is once per second polls for
link change, a slower bus probably does not matter.

       Andrew
