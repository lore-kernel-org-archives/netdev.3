Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534435975;
	Sun, 19 Jul 2026 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477639; cv=none; b=qqT3uElZwv3QuCN7f/wY09fLCpX/ZEgdoa89f8ZXqsoH/lCyBgr90hDfkeaiebMP2bTVQHZY3PLAmiMOjHHSfsqO+IlHTue4JMyLZt9QAzjZ4BM+0sbwkb8F7z+5oX+FxQSWX43giCZGXdI2tAmqCKKx0xNmZHoiKvcYTG9gweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477639; c=relaxed/simple;
	bh=yVnRBy4OnmqJW6eN/DkQv2GUcbJIqgy5DP6v6vz2czs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKDubcqOF9R4Ha1GtxEtkKrNJWNyXr+05PWHxs0Q927rSQcQx5IfdaRqS57r8hxP04rbUzuKBAQRA51Pod7iqBKp9mswoaH/fMZJfwyR5+JkhnJqUDpbmgUP7k/9H37A8JcANNDaACkJjz8uxZ3iiTWayxAsBadETw1oKJWtBZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IUnTmK2A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IUnTmK2A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=75qj38gUt9K8kC/h4fbdxHuyt0mz8emxnm7YZkvJPt8=; b=IUnTmK2AhPCSYk1gnkvX4O1kVm
	gfw+TWnesSzskcNAFGUgUbsqBZEwqQCQhZjn1APM4nmmxIspxizsk/kx0xtItzznFM6t3UEdk30nN
	S6qg60Fe/CaPVmDQZBrBQDvKO+NA/N0TUZA1WCFE9iiqlc3NRDxgTTsu64l1evggmBWs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlU9D-00D6hX-8z; Sun, 19 Jul 2026 18:13:47 +0200
Date: Sun, 19 Jul 2026 18:13:47 +0200
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
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
Message-ID: <ae82997f-537e-4a2d-abce-d163fcf9d868@lunn.ch>
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718143848.677531-1-maxime.chevallier@bootlin.com>

> Looking at this, I'm wondering if we can't just get rid of SIOCSHWTSTAMP
> handling in phy_mii_ioctl(). Looks like we can ?

I'm not sure about that. We need Richards input.

The code in phy_mii_ioctl() allows the MAC to be bypassed, it goes
straight to a PHY based stamper. It could be the MAC has no idea the
PHY has this capability, so it has not implemented the .ndo?

It might be we need to hoist the code from phy_mii_ioctl() into
dev_{sg}et_hwtstamp()?

	Andrew
