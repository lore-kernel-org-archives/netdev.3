Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4EC8F0
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475557; cv=none; b=sBIlsyb9EUbKJpV6FQIJP0L8WYzqNSvlxnFRLKW/hVYrXItTlnBxaAFaHKpm14NMGHCEWYu444hEmZY8KOYN5PhXHROEB9M57oH8/5hNlwFIzGEtDzJowXWap1DW+eKP68QF5Pqnx8fX+GPy05Fd90f86e9WxfYKSBDGpdZIbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475557; c=relaxed/simple;
	bh=AtsAxCM/4ncC3th6u5NjDYLwN8cEPCQ9X120I4IC64c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRjYR+lMBRr/cIhgU5DYwZkhI2C+Kbhk7eGlcqTWoYi4V7t5AWKvoT8fXJypLKGTsUiym5HMnEOoPeczX+JTefgBuWAvu+EICFxG7U+ViBCLZVUP9QnduudEaBu3FuqYkaJVEJfyLhxRlzyj790p79Idre5adkBBRgmrX7pIBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XxqMU6so; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XxqMU6so"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UB3pHoZfhLuR5wYLQxTQQtxInkU8rpiKFH8WiyB2FiA=; b=XxqMU6so9wgx0Ob7CLD9I9koKl
	1bIuqOnsrKnirdPF6+IUlbbHkk5osLqE+abCrhyjGdoY7Gy6OHLWamp/T474HWewZmcVzLJd/868+
	hI6TLQKi54zIrHiZqusoZ0OvfZVePQtUFScEwHaZa0/zufsVSpVPD30186q/4gQX8n1RfsPIAb2jI
	20FG78TAy838yHXfa16Za4e33oHnnxyp46iJh6CXlAfC23YObXQNY0kPpsBvc7EXM9SFGoHALGkBl
	1opeldmTzfqeWnkDCWXWaFbe51TKc1PskJvPH1WZJdmLWHQdu0BnhNlEH1kZ/XYTGG/RzJyAR3qvK
	F93ep63g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44558)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkXQB-000000005UP-3uHt;
	Tue, 27 Jan 2026 00:59:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkXQ9-000000005R5-2z48;
	Tue, 27 Jan 2026 00:59:05 +0000
Date: Tue, 27 Jan 2026 00:59:05 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 06/22] net: stmmac: rk: add SoC specific
 ->init() method
Message-ID: <aXgN2UjiI_OxWHH-@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
 <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
 <aXd7aSk7KIxlQd5z@shell.armlinux.org.uk>
 <20260126165144.25055591@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126165144.25055591@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 26, 2026 at 04:51:44PM -0800, Jakub Kicinski wrote:
> On Mon, 26 Jan 2026 14:34:17 +0000 Russell King (Oracle) wrote:
> > On Mon, Jan 26, 2026 at 11:45:28AM +0000, Russell King (Oracle) wrote:
> > > Add a SoC specific init method.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>  
> > 
> > I see the AI review has identified that this patch has an issue, whereas
> > in the previous review, it was fine with this patch. I can't imagine what
> > it's problem with this patch is
> 
> I released the reviews for you, the first one looks legit, I haven't
> scanned the rest so YMMV.
> 
> > and there's no way to find out for about 9 hours (more like 19 hours
> > for me because of the timezone) as the AI reviews are not accessible
> > until then.
> 
> The patchwork checks are for maintainers. If someone wants to build
> a public CI for contributors that'd be great. We can even provide
> funds from the netdev foundation. But let us be clear that the current
> setup is until now maintained primarily by me for me on the weekends.
> Unless you make an effort to actually help I don't think it is in good
> taste to complain.

This sounds like my contributions to netdev aren't valued, and if that's
the case, I will stop.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
