Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80635950;
	Tue,  1 Sep 2026 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222402; cv=none; b=oZ/nkal47l7YO/i8jLCJc0l0dK8wPpRkGSC/ufE8JNb4tP2SsXp+jEguvCTYfYp8Poh+//dR75OuYDRe+0Ks4roxNwl4w1izkInDBmfnUBp+97ZtSfVcUmJr8n/ZcdCPTiQBycg0GdgxpmdXyAVkQfv80NgXZKSMcvrjKk0U0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222402; c=relaxed/simple;
	bh=AIKIlNTVTVm8boLe1yiEkqMXQ6yNcvvz5QuRoLqmndc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx+ZFepBxEjJ/Bcdslwgqm42pbqUCT2bdyERxgyQV2aMNCMw7Y1Znl2qem/wOsdkAGWLgg1ZmcfGNjweyufnogjfbtcky/J9kSF2JM1aziD0vVXA+1PiKuRLBpeJ46pm0hHpYmPA5AYs1oLsqxfXDyCZ/SQxtGZvzQe9xN4Ji5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d1x5Uc3V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d1x5Uc3V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sWzcDxcK5KHl/AoklH17Lv+StaJJHsmm0a/OqQGdPUY=; b=d1x5Uc3VR4Yn9rjdeQJ21p1Jg1
	SPogErl/w5tumNkDDhGyYmcDUMTe882WPRTkK3hIMoT0ZQy28FRpsfzNJcWyI6QyZi5d+BlnkmZ2V
	S09btPQQjLmxqQPADojha0SaNYzIbrhospnJOIhvOKtQaE9fkhRZdPA3IrXfojx6ngOw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1CKY-002HFd-O9; Tue, 01 Sep 2026 02:26:26 +0200
Date: Tue, 1 Sep 2026 02:26:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 1/2] net: stmmac: dwmac4: Read the UC filter
 size from hardware capabilities
Message-ID: <b2fbcec7-90ee-4a6f-bd15-32e4e1ff1a47@lunn.ch>
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-2-maxime.chevallier@bootlin.com>
 <2631c832d5aebc56e152628132494545@tipi-net.de>
 <480f15e2-e045-46b7-89af-1fbcefd3c4eb@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480f15e2-e045-46b7-89af-1fbcefd3c4eb@bootlin.com>

> Yeah but dwmac4 has a hash filter, but same as the UC filter it's just not plumbed
> in :/
> 
> Let's leave this flag here, hash filter addition for MC filtering is coming-up, so let's not
> drop it now only to re-enable it after, one of the other wonderful discoveries found by
> running the selftests...

I assume you can put a MC address in a perfect match filter? You can
perfectly match a multicast address just as well as a unicast address.

The hash filter is less accurate, but again can be used to match a
unicast or multicast address, and then you need additional filtering
in software, which Linux will do.

So it seems to me, you should use a perfect match filters if you have
one available, independent of unicast or multicast, and only use a
hash filter if you have run out of perfect match filters.

A IPv6 interface will be listening on a multicast address for
Neighbour discovery. It would be good to do a perfect match on it...

	  Andrew

