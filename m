Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280069;
	b=fXJAkvFwmIMGVIEA7C5VuUzfkZ39PfoDfmAX76pCMYJvjavZoMam6XbAikOqxY7dUdYk
	 fKASRCsH98o46/Kh/BIqCJVqnY0cVQVj6R03IEM/cyiB2LUibUfaqIOtZakw3o/h4LYtN
	 ifkFWMzi39Hf5LTn9wsfSWwxN8UY+Efv7YkSDB8oz68Fv9ZkB4K6mAOZJPtRL66UVcAsW
	 GLbdXofOUstayvZ3Rt5hQe0EWnd0t9ey/q47njb0E3ctgeH/IXvI+7YML2J2I1SzcWr52
	 qEUxtrSPMEBhwzHgpAoPjh4uhUJtJCs1V+f9g2CJdbaX8/gqFfd5/TQByqw/jauDSLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280069;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Lp2fs7ZbOlVXklezlvUcMAOoy4OS8c7SUAwJ7l9dS4U=;
	b=gePRLV5VmS4l2PfZ1qcgJkl7UrbfnlKPWMNIXrvmovSWcPtTE4c6cxEUvvjDb1VQdNuz
	 rimJ9e9pQDKk5iRgfn+elpI9KiaYKi7IHTfckykPyMkYbEkWLuIbiiYSFMLME/lSQGzA6
	 Re1kMB3dDwwmrRPynT8mOJfrTw/Rm99Ec3rSgSA7AqGrTHppxEQzmOR3SCtye7FxWY28u
	 iiYx/hHE5Z+Ks7UxQYRVCXV/ZpYu6l+5wbvLQjBkml3cxYvYh4tmNghth54K3vkJZuKXO
	 qL00WgExmjfhoJVEEVXi9MRJ4MR5CGMVmrw/SGDLHcHJth5UPzT7zkF0ZGdFRZZSA7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=leGq8Tf0;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072B606A31A;
	Thu, 29 Oct 2026 13:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E072B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=leGq8Tf0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Lp2fs7ZbOlVXklezlvUcMAOoy4OS8c7SUAwJ7l9dS4U=; b=leGq8Tf09kTUwEEAi91ZrEPch7
	ZGhH+SiiG9cZe30J9nFJiyUGEnHOhLDZiKuXiGXNCsGhCaWcU4hS9NvsmfXu0xmaLUWnU40ivacZ8
	zwoV3cId8aLBbJw3aqyTZ7gMKBUne4RLvf29dC74W0MJi8VOITEiXubvKfgG+EXmu9Bw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMQ3s-00DFRE-7P; Thu, 29 Oct 2026 14:20:56 +0100
Date: Thu, 29 Oct 2026 14:20:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: pcs: xpcs: make supported_interfaces
 authoritative
Message-ID: <20fb8d2d-a20e-472b-8f32-3fe2fec9a425@lunn.ch>
References: <20261029102728.3189359-2-coiaprant@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029102728.3189359-2-coiaprant@gmail.com>

On Thu, Oct 29, 2026 at 06:27:29PM +0800, Coia Prant wrote:
> pcs.supported_interfaces is the mask of interfaces a given xpcs
> instance actually supports. The compat table describes what the
> Synopsys IP can do in general, but a specific integration may support
> a different subset: the RK3568 XPCS supports 1000BASE-X, SGMII and
> QSGMII in hardware, but does not implement the C73 10G or 2500BASE-X
> modes that the Synopsys compat table advertises.
> 
> The Rockchip glue currently advertises only SGMII, since that is what
> the RK3568 MAC side supports today. 1000BASE-X and QSGMII can be added
> later when the MAC side gains support.
> 
> Without narrowing the mask, stmmac_phylink_setup() merges the PCS
> supported_interfaces into the MAC mask with phy_interface_or(), so the
> XPCS would contribute 1000BASE-X, 2500BASE-X, USXGMII and the 10G/25G
> modes to the combined set. The MAC side forces the phy modes and
> phylink start passes the mode explicitly, so this does not currently
> make phylink switch to an unsupported mode, but the combined mask still
> advertises interfaces the SoC cannot use.

I don't know this code too well, but something does not feel right
here. It might be due to the way stmmac does PCS with phylink, which
is often considered broken.

What i would expect to happen is that each piece of hardware indicates
what it can do, and then phylink finds the common modes.

So maybe stmmac_phylink_setup() is wrong when it ORs them together?

Maybe look at other MAC drivers using pcs and phylink.

      Andrew
