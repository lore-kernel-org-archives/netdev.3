Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB161CDFCA;
	Thu,  8 Oct 2026 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487066; cv=none; b=DKDeEvG7rnpt08n6ddES6QsAP+TcMze6ZPNoljx7xhcHj1Hg2LTeFQMxEAqIHR5pSTb276Dfil6afX7yQvMwlUqPk5QHju/8m4XsggmSaA7LM3TAXw3/TEfeOMUOl+ibzF32XZWR++vPpRm7abWccYhCFnbdcbG5LLsIy37ykJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487066; c=relaxed/simple;
	bh=PhnhG5jqPNzDIh7QSbe7Yv/nM1tX4TZ6ENysxDOYK6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFNPs9WMuSq0dpy1GKkmm8zWfs30ndccMv0ySi6RNgI1uIYBgHUxa475Sy7o/Yrewq797b0XYhR4srVPECGPWf+fh1TQgVs5kVR2PiEI1afhxrQXYzeP/XLHODzXygswmXPBTomYRUdMP/Fsvy7CMKcVkUDmfa44Z5LNxVErQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gMuW/h4G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gMuW/h4G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T1bCQEyejfzd+cGuOlFbGK6f33MYJZwjFBBWqmQ0jOQ=; b=gMuW/h4G73H9rDylNv0+T2wk5l
	oLg5jiZGYMBwo/N6l41Onr3oJWvfU6KOm/a63byzi1wuM+fnq/L2aQB9IwX5E6ZijIF7Yn7MqtlOi
	kgQ4votsH7aie9n8v5wtcGYIpuN8lZbRuCIjxurnAjc00os433X8WzV1AlLrD9hPJgUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEtcW-009gGS-7s; Thu, 08 Oct 2026 21:17:36 +0200
Date: Thu, 8 Oct 2026 21:17:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: winbond-840: release IRQ on alloc_ringdesc() error
 path
Message-ID: <76d4b791-4a93-4be1-9a3f-0dc1ae7684ea@lunn.ch>
References: <20261008162109.2678143-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008162109.2678143-1-vulab@iscas.ac.cn>

On Fri, Oct 09, 2026 at 12:21:09AM +0800, Haotian Zhang wrote:
> netdev_open() registers the shared IRQ with request_irq() and then calls
> alloc_ringdesc().  When alloc_ringdesc() fails, the error path jumps to
> out_err, which only calls netif_device_attach() and returns.  The IRQ
> handler stays registered forever: net/core/dev.c never calls ndo_stop
> when ndo_open fails, so netdev_close(), the only place that frees the
> IRQ, is never reached.  The leaked handler is also left enabled on an
> uninitialised device.
> 
> Add a separate out_err_free_irq label that releases the IRQ before
> returning the allocation error, mirroring the cleanup already used by
> the sibling de2104x driver.

Please set the subject line correctly:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

This obviously does not bother anybody, or it would of been fixed by
now. Please post this to net-next.

You might want to concentrate on drivers from the last decade?

    Andrew

---
pw-bot: cr
