Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFAC3B27C5;
	Mon, 20 Jul 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555979; cv=none; b=PvuCEl/OpDaD0c+uA7ksZXTfRRFudk+oOg63i4JagpPnGZOq+lgGsuYPRzciop4i3oHnnGDdI6ASfET35dLWrbrSu1yWb2/bMAWt86r1Iyko8Muq0rDkOmXbU7moLr456Cr2ska5fmZrmDL5Md4+tqwlNNvRAcpzM5i08TRapmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555979; c=relaxed/simple;
	bh=NZOjSs5lTJ7IjJippUBX3YaC0mwiEao9Vq8nmA4PQEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWBVmnjZPOClHsebC3GDfKtJQCu5GLhxR6AkPLnreSpyQfR4yUt7yHKku8dmDmNUNfA3BG6SqhhpDMXoRI7QeuB/wnfGKV4ahYQCIMpzNye+N6yy3aas+l1auNDXvuOyd8JKYiAw5e4qU/coyGdeGmgzelQSS5qIBstbg3Ez7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QPmmlsbF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QPmmlsbF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KlzD1oIWZcgqtlHJyvOYZyeovWx8boVI5GczyJJmdNM=; b=QPmmlsbFhv1s2zDpi8igvIlVz5
	3eXsV4saOEzxsP73iUczhxXkV5au9ja7cmSo5yrAjWcStbd7cnHBVoGGUxir3Yws5lS2F1spLuq8Y
	7xtnJg1oAfG8b9J1m+el0HRagWrsSzWcPMOfdGpDgT/+m0RhV4Jd+XCE7FuJpRdjFBkw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wloWd-00DGmj-Np; Mon, 20 Jul 2026 15:59:19 +0200
Date: Mon, 20 Jul 2026 15:59:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luis Lang <luis.la@mail.de>
Cc: netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Rohan G Thomas <rohan.g.thomas@altera.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: stmmac: dwmac4: mask interrupts when
 stopping DMA in suspend
Message-ID: <e390ad2f-b789-41e6-90cd-c8065ff007fa@lunn.ch>
References: <20260720111534.163416-1-luis.la@mail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720111534.163416-1-luis.la@mail.de>

On Mon, Jul 20, 2026 at 01:15:29PM +0200, Luis Lang wrote:
> Since commit 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU
> interrupts"), suspending causes an interrupt storm from the RPS
> interrupt.
> Fix this by adding a deinit_chan() op to stmmac_dma_ops, which
> masks all default dma channel interrupts. This is called from
> stmmac_stop_all_dma(), so interrupts don't trigger while suspending.
> 
> Fixes: 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU interrupts")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Luis Lang <luis.la@mail.de>

Nice. Thanks for working on this.

These are the sort of patches i like to see. We see a lot of AI driven
patches fixing theoretical issues which nobody really cares about. The
submitter does not appear to understand what they are doing, maybe
compile tests it, but never boot it on real hardware.

You have built and booted lots of kernels, done git bisects, sent a
good bug report, done the work of actually fixing the problem with a
little help from us, and pretty much got the processes correct first
time. You have the basics for being a real kernel hacker. I would be
happy to receive more patches from you.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks

    Andrew
