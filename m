Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E122236FD;
	Tue, 30 Jun 2026 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828184; cv=none; b=Ee8Eayrhk+lnBI0QxpBH0gtjm3rTxdIt/7ch7lTlfRKNNtDucdlVpuX0g3wb21xY/R4oZo7GWdiYj4gKTzedHzsTLAtT6bd4ctERBU+zfykC7hoOs3Dk3baGWljgoxrtJzwixFO11lnsDmt7UolWoCyRp8bp8lI1UZnKb5iJ4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828184; c=relaxed/simple;
	bh=RRSGBWEJGrWpLI4NZKGOrKYwU43b5K6pNyzZcJFNoeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd+sIDZAtic6BJXWiUv6ICcI/zJP8zz6EySg4lcgmgT+Ne6fWeHaRrMveM33V/yAQ3sT025BZwu2OVBw8Wcz2OAoT/pieqtjbv4XfvBMliJRjhigY8SyjQWlsahaP0eKf/wvgmtQGVa6kkKN2p2Zje7aXXNbXaIz97QVDRKrkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=duh0gbDG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="duh0gbDG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=u0GmV8HGMiBxPZojHC/TPgWc17DSdtLcrq8m1XBeG5k=; b=duh0gbDGUnCmyAvCUFlAJkhKWV
	iTyDb85hcDckWkn7WAkdUmluWcry2+GWkvIJ020qOXnJtQV130jn18fzVSkWbmk17qokRZEkIFbG6
	A7+wORvIdThNF7mYpvjN95NpgMsRolUW0byZAx3+OZjF27BkkMkR1h0bRcV1CVwOYxbk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weZ37-009zHK-Nm; Tue, 30 Jun 2026 16:02:53 +0200
Date: Tue, 30 Jun 2026 16:02:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com,
	rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
	robh@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
Message-ID: <4c285993-978c-4d9e-a8c5-c3b36baa6840@lunn.ch>
References: <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Tue, Jun 30, 2026 at 06:31:08AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Russell King's commit de696c63c1dc ("net: stmmac: socfpga: convert to
> use phy_interface") replaced mac_interface with phy_interface in
> socfpga_get_plat_phymode(), noting that no upstream DTS files set the
> "mac-mode" property, making the two values identical.
> 
> The Agilex5 SoCDK TSN Config2 board is an exception: its gmac1 TSN
> port uses GMII internally in the MAC while the PHY-side interface is
> RGMII, so mac-mode and phy-mode differ.

Maybe you need to represent the hardware block which magically
converts GMII to RGMII in DT?

	 Andrew
