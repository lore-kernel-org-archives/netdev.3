Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794072756;
	b=W7CLgAZ4aYznk6JDt9Otkne60YkhTzqRwiPnrwrD6zsKhNS0jc7doNCvbZQuB27BcObA
	 Gm9Bmke7oBxM7E9C/RQ7wkPUfPOTAji1hHnKEpVbG5krOw+qqMH1Avnl4aMgmCJ8dVEoL
	 IcJ3hDE3X1MGQZHUQkF7uemJHQaUX00fJN1qiDbRBgw5kjjpPgVlY0R9iUCwSNZ4iuv3S
	 GpD9dQRJQxvadeNW7qWpkQ5fqcsz7S/YtMP82cg5WgAmY6Zm7zVFMQGMWUXn00pFM+Yl7
	 DK290+gO998NSxTP1PfMsQHo2K+3Gjw5pgl9v1KlMShsacojW5Sa1n1WbDI6+KMxSqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794072756;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KzndXIafRq+J+vl6EzkbdZuWJbf/1tRHEtBvKVbMKMo=;
	b=yU3Hui34fJEi4p580LnN+mXK869npuORtWQi3wJH0rQJ6du37zxoVCWNgC6ILyMmBuJD
	 LzXM5/rlh4odGZGpIZn8tvWBd3VxbiXLi6l566spksEIb52oovTHQ4Hfl+jP9YNcbkgm2
	 GlEvKDvqnwlMd1QeYs7P8zsdKvaqELTYCpMJPPAEnu9fCU4vggjRdmq49Z0u+EYSXVGK4
	 nKtBWBw9ex0UAYME/P5fXAjbepkkcAihMGO1t0XVN5PnBpuIwj54f4WAx1WMqp1mTy/we
	 FsfDGgqgdgxglYJUPugAw189Ptclt49aceDy8cWTqReBEu/Pa82FlUkQ390PqWeTtgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=sjvthzk3;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE5606A326;
	Sat,  7 Nov 2026 17:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CAE5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=sjvthzk3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KzndXIafRq+J+vl6EzkbdZuWJbf/1tRHEtBvKVbMKMo=; b=sjvthzk3+L4LMRbXpwAo3mKNSI
	L4xDJB8dPTR7dPR85p1EuqZ531SO5llhau/gR4p9dZkAMMvOcfZIMrRnvO90605L7Jp+vGK9tJCuV
	Lkt/PDZxaI6dtdohCeeV+d+5KoPy9r230VvSyV14gDrjbkPKxT/FEdYh3LZR+D37vU80=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPkGr-00EzBL-J7; Sat, 07 Nov 2026 18:32:05 +0100
Date: Sat, 7 Nov 2026 18:32:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ali Tariq <alitariq45892@gmail.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@kernel.org>, Vivian Wang <wangruikang@iscas.ac.cn>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Tomas Hlavacek <tmshlvck@gmail.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: spacemit: Hold RTNL lock in emac_resume() and
 emac_suspend()
Message-ID: <12a95b3a-9c8b-4a2d-9b81-12b3839e64a9@lunn.ch>
References: <20261105123441.2524171-1-alitariq45892@gmail.com>
 <DMO13SWAGZAN.NYISGLGI7Y5A@linux.spacemit.com>
 <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c55c5878-d9c1-4863-bc55-99d334ba2ede@gmail.com>

On Fri, Nov 06, 2026 at 03:44:50PM +0500, Ali Tariq wrote:
> 
> 
> On 11/6/26 2:43 PM, Troy Mitchell wrote:
> > On Thu,  5 Nov 2026 17:34:37 +0500, Ali Tariq wrote:
> > > @@ -2056,7 +2059,9 @@ static int emac_suspend(struct device *dev)
> > >   		return 0;
> > >   	}
> > > +	rtnl_lock();
> > >   	emac_stop(ndev);
> > > +	rtnl_unlock();
> > >   	clk_disable_unprepare(priv->bus_clk);
> > >   	netif_device_detach(ndev);
> > This can deadlock. emac_stop() -> emac_down() calls
> > cancel_work_sync(&priv->tx_timeout_task) with RTNL now held, while
> > emac_tx_timeout_task() starts with rtnl_lock().
> > 
> 
> Thanks Troy, that makes sense.
> 
> For the deadlock, I think the correct function to call is rtnl_trylock()
> inside the emac_tx_timeout_task(), which would return if the lock is already
> held and will hold the lock if it is not.

rtnl_trylock() is generally a workaround needed for badly written
code. Please try to avoid it.

	Andrew
