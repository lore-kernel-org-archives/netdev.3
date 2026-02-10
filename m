Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33D22D7B6
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733923; cv=none; b=VT+JVQ8DBHu+cG8FRL8eFqUyTtLIuDnNenAlV9t9N2nYJFOrRpuC0pLDuHQx+mYtGSX52jnrffAujxXFBLg5Sz1HConbJI/1QI4y+hTHVIPher0dDgwOOrw9fV841GSBYAvHukogNOOy6RXhGuGzK0VYokmCZhBlf/Hj7Sdi66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733923; c=relaxed/simple;
	bh=ohaP3f+gViFDezM3994yui/Gxiyd8URY9/WYP1iyMS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8tVlvfHro2aW6sre+3wGCD9Mp8EPf/nkPIqf7f8AyuNyOXvIV1UJu/111F5rRq9fxS0r6b+C7FyG1LZwO6JRZsgVZ3vuyXyqjRv2buvD5cbQv/RrWfCIy8KW+j7zbb3GvNZHdWqzJHlrnNoa0eLSJ1lUz+zrJKF/ZLHljtPKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LJyeDzAt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LJyeDzAt"
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 9DE41E47;
	Tue, 10 Feb 2026 15:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1770733872;
	bh=ohaP3f+gViFDezM3994yui/Gxiyd8URY9/WYP1iyMS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJyeDzAt0bLbhVjCL4vTlxiUHIIOka4k7W80G+K1eI/qEJnnw7IZsvmRkLS0IZ5eu
	 /P8P1k3ciHGtjc2cvrrwRYzYsLptM/BHmO+U0t/nt8mLaHFwUpw4QIFjfZAOIxdget
	 ihtxzCPs/wRtvB5QYVaBc+j8pypFa1LYi79R+674=
Date: Tue, 10 Feb 2026 16:31:57 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@denx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Heiko Schocher <hs@denx.de>,
	Jakub Kicinski <kuba@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Martyn Welch <martyn.welch@collabora.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Richard Hu <richard.hu@technexion.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Wei Fang <wei.fang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] net: stmmac: imx: Disable EEE
Message-ID: <20260210143157.GM2405149@killaraus.ideasonboard.com>
References: <20260209202155.2388099-1-laurent.pinchart@ideasonboard.com>
 <aYsj5IayQd3NRflL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYsj5IayQd3NRflL@shell.armlinux.org.uk>

On Tue, Feb 10, 2026 at 12:26:12PM +0000, Russell King (Oracle) wrote:
> On Mon, Feb 09, 2026 at 10:21:55PM +0200, Laurent Pinchart wrote:
> > The i.MX8MP suffers from an interrupt storm related to the stmmac and
> > EEE. A long and tedious analysis ([1]) concluded that the SoC wires the
> > stmmac lpi_intr_o signal to an OR gate along with the main dwmac
> > interrupts, which causes an interrupt storm for two reasons.
> > 
> > First, there's a race condition due to the interrupt deassertion being
> > synchronous to the RX clock domain:
> > 
> > - When the PHY exits LPI mode, it restarts generating the RX clock
> >   (clk_rx_i input signal to the GMAC).
> > - The MAC detects exit from LPI, and asserts lpi_intr_o. This triggers
> >   the ENET_EQOS interrupt.
> > - Before the CPU has time to process the interrupt, the PHY enters LPI
> >   mode again, and stops generating the RX clock.
> > - The CPU processes the interrupt and reads the GMAC4_LPI_CTRL_STATUS
> >   registers. This does not clear lpi_intr_o as there's no clk_rx_i.
> > 
> > An attempt was made to fixing the issue by not stopping RX_CLK in Rx LPI
> > state ([2]). This alleviates the symptoms but doesn't fix the issue.
> > Since lpi_intr_o takes four RX_CLK cycles to clear, an interrupt storm
> > can still occur during that window. In 1000T mode this is harder to
> > notice, but slower receive clocks cause hundreds to thousands of
> > spurious interrupts.
> > 
> > Fix the issue by disabling EEE completely on i.MX8MP.
> > 
> > [1] https://lore.kernel.org/all/20251026122905.29028-1-laurent.pinchart@ideasonboard.com/
> > [2] https://lore.kernel.org/all/20251123053518.8478-1-laurent.pinchart@ideasonboard.com/
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > This patch depends on https://lore.kernel.org/all/E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk/
> 
> ... and a few other patches as well. There is also a conflicting change
> in net-next:
> 
> commit dc6597fab3e3d291da9e0b4c6f7da01a5a863e80
> Author: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Date:   Tue Jan 20 21:30:04 2026 +0100
> 
>     net: stmmac: dwmac-imx: keep preamble before sfd on i.MX8MP
> 
> > base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> 
> This is v6.19
> 
> > prerequisite-patch-id: 9229185bf29c206923075a0450e763664af050bb
> > prerequisite-patch-id: e17c3f8a7cb2b18fc0c3c6250773a9680bdabdba
> > prerequisite-patch-id: a3c3f8b08fd66ee3ccce632aad3f4a3c21c92718
>
> I have no idea what these are. These don't exist in Linus', net, nor
> net-next trees. I'm not sure what generates these, but they are useless
> unless they also indicate the summary line for the commit in question,
> so that one can have some clue what change they're referring to.

The first two are mistakes, I had two unrelated DT changes at the base of my
branch that I needed for testing, and I forgot to rebase before running
git-format-patch. They can be ignored.

The last one is your patch
(https://lore.kernel.org/all/E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk/).
Note that the value is the patch-id, not the commit ID.

> While this is a fix, I think you previously suggested that this isn't
> a regression, which suggests it should be merged in net-next (currently
> closed due to the merge window) rather than net.

I think I was first notified of the issue more than a year ago, so I
would indeed not count it as a regression. net-next is fine with me.

> Also, referring to another patch doesn't get it applied - netdev
> workflow uses patchwork, and patches to be applied need to be there.
> If patches depend on each other, they need to be submitted as a
> series. So either I need to pick up your patch and send it along
> with mine, or you need to pick up my patch and send it with yours.
> We need to come to agreement on who is submitting it.

I'm happy to submit a series with both, rebased on top of net-next to
handle the conflict you pointed out. Is that fine with you ?

-- 
Regards,

Laurent Pinchart
