Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8D48A8DC
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785331386; cv=none; b=Ug8B5RXpAYSxOWMH1JmjQ/x2rjUnOQAAt9bPmn7bxiE31ZZONIOgzsnbPMA903xGwXatOMtmw37iBIL1PSU/QYr7tOzGfkexUEOGLCn3NIGcTDLmZcmt5orR1UifhZGj3mLWi3HMQ7AAV736Qzxv1GFeBL+lDO5do5h9LcKU3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785331386; c=relaxed/simple;
	bh=1y0ABlCv/10b5bJ86x6rJlPFrXri6JkLh2ZSQkay5EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvyLTxshvo7QhQm7cdtAGsfjDWTHVpzW26Z8QFIR8MRFJTGvKywxP2mnCPN5iaw9tB/D6ufE0Sa9pjPqt1YonpQswp+J69IHaIEInv6xaCn3LzT22vwNXqp0lGC/mDbC2/FUJ9aGuqj4aoLBmMDMO1VKri/rBouS1PgiVvD0gYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YxmX+9dQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YxmX+9dQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1ZHUMp+gyidBrBzFAoavntEbN+FGo6iEcMbG99ywxsE=; b=YxmX+9dQ1UiNCPFMFqfE/o4ZQA
	TsMC9YDwu1JTcew8FwugAEOZnOyYDitDnNQlJgI2nx8528OBjmxJY++EVoz0WqY54qCTSGiGNsUjk
	Si8hqLJnUsR4nu+Lqoc9v7yFb70UlQQ7elpW0QBF52vTfW3+uTI2izZfSqIfvDtMz+p8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wp4FB-00EpB8-Pj; Wed, 29 Jul 2026 15:22:45 +0200
Date: Wed, 29 Jul 2026 15:22:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: xuanqiang.luo@linux.dev, richardcochran@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] net: phy: dp83640: fix per-bus clock lifetime
Message-ID: <07553e2a-3475-45a3-b57d-3d74abea6c95@lunn.ch>
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

I don't see anything in the description about it being shared by
multiple PHYs in one package. PHY Packages are about quad PHYs, where
the 4 PHYs share some additional registers, either in one of the PHYs
address space, or in a totally different address space.

Linux clocks are nice in that they are reference counted for enable
and start operations. So they natural share when there are multiple
consumers.

This patch is about something else. It was on my TODO list to take a
better look because it seemed overly complex to me.

       Andrew
