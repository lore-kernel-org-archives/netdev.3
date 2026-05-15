Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409D46AED7;
	Fri, 15 May 2026 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846332; cv=none; b=GhAq1R6tJAB4pMbrHp/g0irci3ROlX0b9wKHHOhPQ308sp3jKB12Wtz7w3c2tPcFr/B8v+CQk1+Y+2i6TFvzwUjEZKbOCNFZU5Y5vfoBoCRiLAANB1bbkdR3JSc6abGf1Mu4f0KL6VkZz7OEyGFIvvWnsGkaw2uiUMWWRbnI74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846332; c=relaxed/simple;
	bh=oLmBSNOfIkDmPgapk2694FIdy9WMHOyezDfDMzK8p8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOrIDnvCL5X/gDGX2k+Adbl742Y6/6ERO7dFUoKEmMoWIp8YfQzPzXy1agpdmesDjxJMlbKZLiT1+PKg2faqCXnD5qZqZAkm5RRW8G6g/pWqxAG85lv218MPIILqQl44d8tvLXBMqEem/t9JM+nr0+jMDNu5u31Kok8Ldu8HxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rasTR9ev; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rasTR9ev"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tED5dwnj315XjkrIWNQbx34834+SR14pbuCDCqP1fp8=; b=rasTR9evdB4dfCLMjM38qWDGj1
	bT02YPoZDRO6VV6bIgLy6E+0pxgrHtxk0XFhjeOvm0mDijBy5NmECTkswXzikpfGF5hFus2dCAm+p
	fzVRL5e28EtFNXn4PQCYbTkPlQBmN1TKXSctPr1rc/ejXk/4VQphRvbiaVwu8AZosntg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNrBO-0033c2-Pz; Fri, 15 May 2026 13:58:22 +0200
Date: Fri, 15 May 2026 13:58:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ding Hui <dinghui1111@163.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, dinghui@lixiang.com,
	xiasanbo@lixiang.com, yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: Re: [PATCH] net: stmmac: fix fatal bus error on resume by
 reinitializing RX buffers
Message-ID: <e731631e-53f3-484b-994d-4b551f241d05@lunn.ch>
References: <20260515053856.2310369-1-dinghui1111@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515053856.2310369-1-dinghui1111@163.com>

> Fix this by treating the RX ring the same way as on close/open around
> a PM transition:
> 
>  - In stmmac_suspend(), after stmmac_stop_all_dma(), walk every RX
>    queue and free its buffers via dma_free_rx_xskbufs() when an XSK
>    pool is attached or dma_free_rx_skbufs() otherwise, then reset
>    rx_q->buf_alloc_num and clear rx_q->xsk_pool so the queue state
>    matches a freshly closed queue.
> 
>  - In stmmac_resume(), call init_dma_rx_desc_rings() before
>    stmmac_reset_queues_param() so RX buffers are re-allocated and
>    the descriptor buffer-address fields are properly repopulated
>    before the DMA is restarted.

The problem with this is, if the system is under memory pressure, it
might not be able to allocate the new RX buffers. So on resume, your
network interface dies.

For configuration changes which require buffers to be change, like
ethtool --set-ring, sometimes changing the MTU, you first allocate the
new buffers, and only if successful do you free the old buffers, so
that you can gracefully fail.

That free and then release idea does not work for resume.

So, can you live with the buffers you have, and just reset the
descriptors?

	Andrew
