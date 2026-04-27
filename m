Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8397322B9F
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257738; cv=none; b=Hs1mNw2v7jBzhMziu5qZ9mbAyp1Rr6bFKrc7+iIZYDhPh5nuM/U/EnQXIfK4h5xUPT+xyyivKsggYnLOuq/oo3NrGiJYknbdLiY++PeLsHDOIKXYcLBP94s8BCsu2f6r6MhTFKqZMdaPXy/ptnrylxdkfg0OT9kbd7TgRsFXciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257738; c=relaxed/simple;
	bh=5ua2JcWosTVKkNzB9NqYXl3fRmIL2IxVt/UYna4GV1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsVdfdJ85RiDoxm+hGqg/7gh0WCW7bLbWO8ko/VeUNt2ZpYcHQ++56f+QU5xasYHWMxYzPkgw3/lklsSIawg3EU9sfJ0JxcReEj5ogbASGbNfNJbHsT27mNmuof6VCVdYE/hpNWWGigDOtsu8x7S/EeN5D8EIN++csK6+z7mQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NJnTUfqx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NJnTUfqx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3OVF2BUymBWlqYh7NXS5h5bdBSS5bQwyZiYuQgK0Xs4=; b=NJnTUfqxHd/RsjmiZa1WLW70/1
	KfQ2JpwOcFWWsVL98ZeznURME7/oNhCqjG9mH962VCPn+0BtPaoi4r8nAbWi/3CVx73J/+LjfJEAb
	gg6GATrPcGJFCv5jaDQaHd3EhHOfq8CeN4+5qpd2nw1pQVqLubY5OH66ivp6l3QGpvTI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHBvJ-0005l1-7s; Mon, 27 Apr 2026 04:42:13 +0200
Date: Mon, 27 Apr 2026 04:42:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: kernelcoredev <sonionwhat@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: nixge: fix skb leak and missing bail on DMA mapping
 error
Message-ID: <220f0166-bc16-4769-92a0-be1bbcce45d1@lunn.ch>
References: <20260426213316.6164-1-sonionwhat@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426213316.6164-1-sonionwhat@gmail.com>

On Sun, Apr 26, 2026 at 05:33:16PM -0400, kernelcoredev wrote:
> When dma_mapping_error() fires during RX buffer refill in nixge_recv(),
> the skb allocated by netdev_alloc_skb_ip_align() is never freed, and
> execution continues writing a corrupt physical address into the hardware
> descriptor ring.
> 
> Fix by freeing the skb with dev_kfree_skb() and returning early.
> 
> Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
> 
> Signed-off-by: kernelcoredev <sonionwhat@gmail.com>

Please read

https://docs.kernel.org/process/submitting-patches.html

In particular:

https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1


    Andrew

---
pw-bot: cr
