Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9145D1BA;
	Mon, 14 Sep 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388540; cv=none; b=RgoU3iUZ+PICPQsIt7RZnKwMCcAJCuzR3nHxLHz5r8TzUBk1eBn+1JDrl9VgLG4wt49QQaS7y2rkvFr9a+0kxLh6sRKyPnzMoC38pQNV4AGmkl//pa1tKet4qST/1B8I1cSD7CUmRBVbVFFBTwwAqFvwTyxGA1hfNaSgr7ZKcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388540; c=relaxed/simple;
	bh=qPdShSfgkq+3KTJ7gNXeOatTyXVm7bxrm6oXcd5oiMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df7w1ROwOz9R2AHwK1mTB8By/J4MLbUgNrmfPjyCXkEBi8ukvcv/Sx+JBIchHMwjTZUPXhxXFdgk80VzCh27kLI1Y/Qiv5RMtIOT6QSm5+3rT1H/zR8b+Ih9m0Y9v6ja1pBlBAGNNdiDew3cnVWgxkaFX5v3f3vxkF+zintndWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UXDy1+D1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UXDy1+D1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ghvLGta+3GTM+e87e0RgPt/+FFq592HJXi13+wuZtOM=; b=UXDy1+D1znG15l59XpNgmbZIrg
	8etl6+dPClUOleXk06VEnIjerZ1lm4C3le8B4kmxdEmrp2501IMrvumh7vLudf9N/G+1A5luBrjVk
	EHpDtxBzH0tkelYH3V5479kHFBTccg24r2uSCeTUE1FVGMh4BNbtQIvJp1nF+1fyrLUU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x65hE-0054oF-3Q; Mon, 14 Sep 2026 14:22:04 +0200
Date: Mon, 14 Sep 2026 14:22:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Fix device_set_wakeup_enable()
 reference in kernel-doc
Message-ID: <491b39c3-e6d0-44a3-8ba9-516fbe9919c0@lunn.ch>
References: <20260911204201.95270-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911204201.95270-1-kmehltretter@gmail.com>

On Fri, Sep 11, 2026 at 10:42:01PM +0200, Karl Mehltretter wrote:
> The phy_may_wakeup() documentation refers to
> device_set_wakeup_enabled(), but the function is named
> device_set_wakeup_enable(). Correct the reference.
> 
> The typo was introduced by commit b344bfacf1de ("net: phy: add
> phy_may_wakeup()").
> 
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Please could you add a Fixes: tag and target net. Developers often
work on dead stable kernels, before rebasing to net-next for merging,
so fixing documentation in stable can be useful.

    Andrew

---
pw-bot: cr
