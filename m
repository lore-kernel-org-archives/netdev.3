Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93B2459C5;
	Tue, 11 Aug 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462660; cv=none; b=op8izdsaLs5qfAR8Pkyx1HGeHqcH00JeaHU0W/G/Uryx/IxDgFgDk/jxDKM8aTcen/BLZ8vw2Sxsc4zGMJLGiFVYpGizNFfk0PW3fb1GESZufEuOgJ6L582T0xq72rLgYffausX3grdMviVdKoeYFB8iTPRo47TYtxnJibyALVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462660; c=relaxed/simple;
	bh=kF2Qq+H2SWCqmieeJCtFV53eFW64vmaClIb2w7AcbNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pT4IFzg9pO2IhhcuLqH72/rNGbihb6+YbfprszgmVchSvuu7/ZQ7mgJJ0yrV31YV9NQ/fi+QOWyhz63/dQ4ItaxGctNZpoltM4qpQVymYgv6krHPJk9AcjAbIoGIZ1mR+uTKNP2KAOWp38zsNnTJvMxlY+R7XSKIKX0u2tBu8so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlcxNaSY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlcxNaSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AE61F000E9;
	Tue, 11 Aug 2026 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462659;
	bh=TZm/MprMkO5itwhFcv/+IHSElxgB+W3AHKfrMKnTD8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RlcxNaSYxzihCXvlRJFD1h7/YomawIjyHa+MuhMDzO3g02/e6nlNjUap934J/4vyR
	 gMsovjv99MsNuoZXu46WvW4+lFP3qF8+Kx9ixpDbAjOfmXncfAQkcKaZ8AXr6LvKZ7
	 S+xjzFQKVoiV/GEFfE+rofpKBFJG+sRDaE5gIgVANRuME//+ZRXvikb29sc9nYd8pW
	 FNT+Qa89BHamFpYW5e1x5KhTEKMZGiPwz2yfJ5cOMhPibuIYa9IvMXM5Efy6083YXC
	 fef6UdFUf3EBrA2b/rcbJqduYRegWTSv/ykSWY7Q+Z5OnZNPLQdhUsPs1qlnJ78720
	 zUgn7zkllSpyw==
Date: Tue, 11 Aug 2026 08:37:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Sandeep Sondagar
 <sandeepsondagar@gmail.com>, Russell King <linux@armlinux.org.uk>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabor Juhos <j4g8y7@gmail.com>, Robert
 Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: phylink: treat PSGMII as an inband capable
 interface
Message-ID: <20260811083738.28075c33@kernel.org>
In-Reply-To: <a687331e-d077-48e0-9ae8-097c4f80dca9@lunn.ch>
References: <20260809-phylink-psgmii-v3-1-908dcd3a9e3d@gmail.com>
	<61dd4a2e-ef14-46b6-bfc5-c5b6463deb38@redhat.com>
	<a687331e-d077-48e0-9ae8-097c4f80dca9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 16:00:41 +0200 Andrew Lunn wrote:
> > > Fixes: 83b5f0253b1e ("net: phy: Introduce PSGMII PHY interface mode")
> > > Signed-off-by: Sandeep Sondagar <sandeepsondagar@gmail.com>  
> > Sashiko noted no in-tree driver is affected. At very least, this should
> > go via the net-next tree without any fixes tag, but I'm wondering if we
> > want it at all?  
> 
> I thought there was a device which needs this. Sandeep? Is it in tree?

FWIW quick grep yesterday did show a hit for PSGMII in the Qualcomm
driver in tree. I guess the question is whether that's dead code
upstream or not... ?
