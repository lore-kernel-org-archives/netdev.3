Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE034D909;
	Wed, 28 Jan 2026 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606733; cv=none; b=uYy9uIRgEFGOqxsnXZ1VfTt6LgFdKpBKdOFQlMMuFQ1PjKRAKLIQTf6/Mumh80OCEDaFY/LalSy29qkt77uh2+cMXTLpxC5F5QyFrqmJuGgPf1w1fThlYSaUBpq1E11y7uZebojcY1X6Lnba37Ltn1mimhJtbuZ72pNOOCKpM58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606733; c=relaxed/simple;
	bh=+7Vp8kpSi3g2dgjRAKKDnBvk4jqFAapzxdv2VnU4GjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv7so/3Z2hkcU8cfwY1bc4RPPyUtxixsetKGt5yABiCkD6Oa1evJ4NLOgKfqrGRPvhn4+N+3Ye0ekmM8ApiZPiCNrKYtLQwYE7Iq9TvC6V4YG3iNVTqA2v25WOEsDaABzEmBkfWZjublUv0uHPYXzsmHEMn06apnPeELSgcDPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dVJpuq2L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dVJpuq2L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nufC/mh88Y4At9VbH5lBNeb92IFWvb06ShGo/VoQ85A=; b=dVJpuq2LOmmr7xEJ7soMUF63xV
	eAo9f/Y0Mibara4K6o5xkiOPaHuAyBWLvGQgcJ9J9kyGK263UsVK55TQPIjFCVRxceDMcIube3z14
	jpCpHAjD8qkFVQZwFYNnwwznqMBOeTnDRmN90cLeqK962dh0y5hC3rJ8DFs+2PsfzrWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vl5Xu-005BOe-Iw; Wed, 28 Jan 2026 14:25:22 +0100
Date: Wed, 28 Jan 2026 14:25:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Message-ID: <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128094644.302313-1-michael@amarulasolutions.com>

On Wed, Jan 28, 2026 at 10:46:41AM +0100, Michael Trimarchi wrote:
> The current implementation of phy_reset_after_clk_enable requires MAC drivers
> (like fec_main.c) to manually track PHY probing states and trigger resets
> at specific points in their clock management flow and was created just for a SoC
> vendor.

We try to keep workarounds for specific SoC vendors out of the core,
when possible. It just makes the core more complex for an edge case
which most people don't care about. It is better to hide the
complexity away in the driver which needs it.

> This leads to fragile code in the Ethernet driver, involving complex
> checks to see if the PHY device is bound.

Have you found an actual issue with the code in the driver?

     Andrew
