Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9943803C4;
	Tue, 17 Mar 2026 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773772119; cv=none; b=DUD1E+ZrOwk8fYMOo4KXFToR0kYjS8u1C/J7UaLplonMw0t+Aow19q4wglZS6lbF16HJILKjf/xSAcA/4pxupDKlYHE/LWomylOPEQD4FYikXDrWBpNi/F8nZ8u/cal2GfVyNtE7ACy87SbKn/LqhgNGpBI0AT4eavgLQK1hGKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773772119; c=relaxed/simple;
	bh=oJc9osQR9aycxWpXyvwQXWY1K38XH7reGRgZSsacmSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSqX+hZKmBxYbcMSunOEFinFX68Pzaut3gmfQtuR0kzf0UvtytO5AX9hY9P/+toNjG6UVO1GUmFw+xIifxrSLULIQAQBy6emUB4nTCcl/aBjnyLxANcXa5akquv5xtH2tnd1+D9/WNUs1rIg1Ieo+4uShosICqBC+2Q5OSjmuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mtdd/lMN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mtdd/lMN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ztPhBgdEcix9a9BAuvMmg8wy4eY4SaTBigXMf8tSCF4=; b=mtdd/lMNWLp5GnswJS/2puxV6Z
	Q281ZUeO7MU7/0FaU+jmh4weQPhv/cF/+iFVeJYNdLTLSIeiHAw6Vakzscam2jfIoQW6awyfLnfno
	s/3D7zQJ/JDwMKeTvu436gavdGnHVpoPaJdNlCzqRI5iYOX7L0cnE+oaHZuF+gjJgtWQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w2Z9V-00C4EN-De; Tue, 17 Mar 2026 19:28:25 +0100
Date: Tue, 17 Mar 2026 19:28:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: mxl-gpy: add PHY-level statistics
 via ethtool
Message-ID: <f5e4bad2-d80b-4be6-8d73-4a2451df9688@lunn.ch>
References: <0029a2fb29bfdcc26abff828d2e18400067b5c58.1773587924.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0029a2fb29bfdcc26abff828d2e18400067b5c58.1773587924.git.daniel@makrotopia.org>

On Sun, Mar 15, 2026 at 03:19:44PM +0000, Daniel Golle wrote:
> Report PCS receive error counts for all supported GPY115x, GPY2xx and
> MxL862xx PHYs.
> 
> Accumulate the vendor-specific PHY_ERRCNT read-clear counter
> (SEL=RXERR) in .update_stats() and expose it as both IEEE 802.3
> SymbolErrorDuringCarrier and generic rx_errors via
> .get_phy_stats().
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
