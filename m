Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C75326D62;
	Tue, 27 Jan 2026 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538527; cv=none; b=tWj8cFXez3annRqxf0vUYEjzTRy+Pscq92j6X1Rmtw78RQ0YJEVFaX+Lkc5O4KTwoV0a7OHhE+W+600U0K5RbiYnVazt/YydI+9GTtiSNWkj1XaO1qyzfyXZxWJoSZjRsGyPH+MHyWJ2ioV3+fzhrIpVlhO+Pbv+KKS2IjpgD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538527; c=relaxed/simple;
	bh=9a4V6BCbiETl2dvADV2PdcV2ulrJG2PXrdW9bD1lXtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnBkkKVbTpHRh2S27VcTfvjxIZ8GaxgkwBQCVzmvfgVzeEwVZu2YuIOdN4KizrfatGHI9ojCUIfSwpA5pUSHdZSmsX4pH0GctxWejpKNrqm1dZmDVrpTJQZwG9esCakHBDI3988AHT0Xk0lzGLvIWYyWx+Hafo+CQW/Moy0ZGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GFmUpiK8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GFmUpiK8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BAgAaKIEUyZedKtdSU1qveQIhBDQOhZR50BlZ8+IBDQ=; b=GFmUpiK8HYdUO9Hl2OoAdnPqly
	eCfMebd5vxbePIMPiSPy8sz0wug5a+v0hPGnp81pJHUi4plySPJj+e1jRR3eRVtENS/A8bQ9GC5HK
	VUIUe1Ar9sRxPtzJaOKkx6MQmsvNr2b/SeE4UaYInZ0B++cSxhG39jPpHStM9QWm4er4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vknne-00505V-IZ; Tue, 27 Jan 2026 19:28:26 +0100
Date: Tue, 27 Jan 2026 19:28:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v8 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <60e9939b-dae6-41d0-8008-3c38a4dd4030@lunn.ch>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
 <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
 <aXinOE7KIFIm5dUK@makrotopia.org>
 <5e7c2f9c-bf49-4564-91b3-a639ef1c97d8@lunn.ch>
 <aXjQKoXBIAkV06XE@makrotopia.org>
 <8f267321-25fc-447f-8ff3-5d5b2d844d30@lunn.ch>
 <aXjirjOsc5IJFHfH@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjirjOsc5IJFHfH@makrotopia.org>

> Some of the error values are useful, it *is* good to know whether eg. a
> bridge cannot be allocated because (for what ever reason) of resource
> exhaustion (-ENOMEM) or because of otherwise invalid settings (-EINVAL).

We need to be careful with these. POSIX defines ENOMEM and EINVAL, but
not their value. So you should add ZEPHYR_ENOMEM and ZEPHYR_EINVAL,
just to make the name spaces clear.

     Andrew
