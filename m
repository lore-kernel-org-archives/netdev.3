Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829748CD41
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332414; cv=none; b=RPIrX7pUjetMMg0DrZ7z1QhRkppjgBVymAYu43fkVM04q3tXmLsvvbl5mQU9wjLvVSsod7QzVtuH/EBDE41zttuFwh57BNAZnrwLR8m0Kf4uavscWjXsXu+Rnon8ANfynqiaxganX3YuDWykhhsWmOrxV2DRi/5jwLdAL1VVJa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332414; c=relaxed/simple;
	bh=e2tIaGgVHGhP3j3eLtFq+1aNsm6mfLdmYQYJaMFGXNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLcmjKTrfEpogxjWsZ4uPbHpK9EI4HxkFbbo9c3D//VOv55krFHJcrN8NdPphiHCeTpl25K/gBP5Nn3khX4H82ikUjNoETNcBTNdk917vk3tRmRHKo2T7Sg54ArQumfQgrvKjB+4ezVZbtE8No1Pf1RyzrCBuLP9SQaIYl+Tbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UEkTc1Ly; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UEkTc1Ly"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+nnrqKsH6oLfVM0LnjV0Dso3EeOFf849HKGhsOvMOYg=; b=UEkTc1Lycvj5h/ex2hAixLnn3W
	cStlcn95wsSjrIDrv/wrijSpxleWAo79XR/mQDviHmHzvXpQlo+u0wEe2XKZIjE3dYb71Ud5OtXqD
	h73IC+Y9GYY5tDEdenfTPF6BKULSVzUro7tGABXATlSXrhvkVk2lLqi5emZvXpnNbCDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp4Vl-00EpHQ-NJ; Wed, 29 Jul 2026 15:39:53 +0200
Date: Wed, 29 Jul 2026 15:39:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: xuanqiang.luo@linux.dev, richardcochran@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] net: phy: dp83640: fix per-bus clock lifetime
Message-ID: <73276f2b-9a0a-40d6-bf5f-9d23d2731c57@lunn.ch>
References: <20260724023532.14583-1-xuanqiang.luo@linux.dev>
 <20260728190340.780d3f63@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728190340.780d3f63@kernel.org>

On Tue, Jul 28, 2026 at 07:03:40PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Jul 2026 10:35:32 +0800 xuanqiang.luo@linux.dev wrote:
> > Commit 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver
> > removal handling") moved per-bus clock cleanup from module exit to the
> > remove path. This leaves two lifetime problems.
> 
> Isn't this sort of shared PHY resource problem supposed to be solved
> using the PHY package API?

Ah! Sorry, my reply was completely wrong, now that i have looked at
the patch.

We have clocks and we have clocks. To me, a clock is something which
uses the common clock framework, because it is a clock. clk_get,
clk_enable, clk_disable.

And then we have these PTP things, which some people call clocks, but
they are something else. And in this patch, we are talking about this
something else.

And you are correct, it does appear to be one of these PTP things
which is shared by a number of PHYs. So yes, the PHY package API
should be used here.

Xuanqiang please take a look at drivers/net/phy/phy_package.c, and the
PHYs which use it. It should help solve your lifetime problems.

    Andrew

---
pw-bot: cr

      
