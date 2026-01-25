Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F29214A9B
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769380088; cv=none; b=mRbcyzD+StDrqT6fZoEx73etycgWZ/ld+1g/efaOoM6etI2OtNq4UexH65J1LYol+r2N4/VDln0sX8mwz78dtzxfDJIWJCvUq3ucymmC9M9lHHWF+gqErH6wjWvOhfrBpKblanQCrxXZfAT2w3KqTh2igwSmmXlHrYTnW1Uv5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769380088; c=relaxed/simple;
	bh=bk/yBbdn4jcVE2YTXD6hLC64kHfwBceGWZphYcz6lIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHQmNcnjHbtsSSdwxgmPF0vFXU+1atChw7woeFL0btCCg9SvuGu1czpInNGhqt5poAaBh2pSmyQ8fUpWqsaCIMAEgAY1DTNEf/KGW674ryNBCRctBTFS6NGxlDRnqceasXfMopvpw0t54BsTGatLRLG+v3cDBkHthlYfM90EPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EiMjt/g8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EiMjt/g8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L2X891Ez3ofU6acQZJKt3+66chDjYg1lXlCjzKU3OXs=; b=EiMjt/g8Z82n8WlxNZmZG5T5uv
	EpAjk6l6Np519Lwq+KkIQztvA05OO68xBvl4i4UH4rCD6tE/kWAlPtCG36okJQ90uoxrF0MKwI88Y
	auR0oGXM5QGKFUj/H3GZUNe1Gi+qBPj3kv3f7a1CLwJxhnz/K5cpA04j8U18MkO8MbjraI15eE+e7
	cghAlzquIBy4Fdx21Vr6RI3Nw1qzwneiiNp4eCth+mDWvwUWjra7Sgv/WbnvqMNgvMGgGVyM/l6ct
	I3TujEL3WSTM6cm2MgI5Qu1HKYwJKsEvIdoDxYGvvsuZd/4PYkPhr5aty+knLWa+LKs3+uCV/r80m
	Y4iR2Dyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32798)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vk8aI-0000000041d-2tWj;
	Sun, 25 Jan 2026 22:27:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vk8aE-000000004Ma-3W6u;
	Sun, 25 Jan 2026 22:27:50 +0000
Date: Sun, 25 Jan 2026 22:27:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, andrew@lunn.ch,
	davem@davemloft.net, alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	heiko@sntech.de, andrew+netdev@lunn.ch,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,18/21] net: stmmac: rk: rk3328: gmac2phy only supports
 RMII
Message-ID: <aXaY5nKGFdBhVsnb@shell.armlinux.org.uk>
References: <E1vjEvF-00000005ghI-3CYC@rmk-PC.armlinux.org.uk>
 <20260125221631.3396200-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125221631.3396200-1-kuba@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jan 25, 2026 at 02:16:31PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html

This, and all the other AI generated comments on subsequent patches
are repeats of patch 17.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
