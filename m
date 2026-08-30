Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C23A1A3C;
	Sun, 30 Aug 2026 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788098808; cv=none; b=awfsKG2Ek99RRIs7suolTyhNXY/6Z3flugWeCxjcYgUhbXtYWtGj6gbC5+63c7CuKda+GgD/B2NqObVUQsns9j56FV+xVOGOHeg6ui1gBoDvPZU1I3tf+3fBMotACLrkhRrwekZgPl7Klg6oqxyICrexsWf4blt0qcaygrsuFHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788098808; c=relaxed/simple;
	bh=Zg44DWgue4MpHWcseIC+aRio/uktHGR+ef0J11c2kA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PV1W7t/SpDPb9yUU3KRQj8/RSJ4H+UrYDSpkNS/BLr1U5ILLiYj8KZKyaxA6Ca3szLyUs02/M0Ct6s/evohpjsdU2fv09l3F6tj68EHrCPRLhkhdR/lXwxmfgX2jvq7/s8oO0Afmt3XnhEeTkeiP5AhWQXAo/c4/7ZEkwxY6F2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nJLiEjjv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nJLiEjjv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1Cfz+1UkqRDYEv0PlJFOZYosCDiCp7c2SrUMBJNre10=; b=nJLiEjjv8xBWCk/ZKFt3H8roOr
	aVESBEaLF85CGrAkarjFO1+vSq6tis5whSrXxe0+yuYs8S7i2fwvMbB2Qw7oQHx/sgcFgoezQECxD
	z6fiDtLEgXK3Dp1AH67FdrKGhD47xfW5G2iXVZH6VA8eJaXSH9a/Ro0a2htwJl0qEEHI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x0gAq-0022VI-Jj; Sun, 30 Aug 2026 16:06:16 +0200
Date: Sun, 30 Aug 2026 16:06:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ding Hui <dinghui1111@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, dinghui@lixiang.com,
	xiasanbo@lixiang.com, yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: Re: [PATCH] net: stmmac: fix NULL pointer dereference in tx/rx
 resource cleanup
Message-ID: <3fd3506f-f254-4bff-a7ee-1063bf413919@lunn.ch>
References: <20260830040610.1156008-1-dinghui1111@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830040610.1156008-1-dinghui1111@163.com>

On Sun, Aug 30, 2026 at 12:06:08PM +0800, Ding Hui wrote:
> From: Ding Hui <dinghui@lixiang.com>
> 
> The DMA descriptor ring allocation in __init_dma_rx_desc_rings() and
> __alloc_dma_tx_desc_resources() is split into multiple steps, each of
> which may fail and return early while the per-queue cleanup paths still
> call the free helpers for the partially-initialized queue.

"and return early", is the real problem here. When a function returns
an error, it should first undo what it has done, up to the point of
the error.

Rather than add extra NULL checks, please work on
__init_dma_rx_desc_rings() and __alloc_dma_tx_desc_resources() and
make them cleanup on error.

I would say the problem you are trying to fix does not bother anybody,
so is not for stable. So i aim the patches for net-next.

	 Andrew
