Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92B305674;
	Mon,  5 Oct 2026 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220051; cv=none; b=rZ5w1FdTSIVZl/i95T6aZHTf3rDwjKPfTmQDeG0NqZN9Z5gNwNsoXFYmBxBMl3r3xXHS9SaujdnJ1dPSWVhUv17hKoXU/RoP/Irb7yVmM/5j/IyY3h2mgl1TcE3AGTCgr+s2LzcxsC9r3EmF4mr33j4ijCz9kBAR8VeUlYuUZRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220051; c=relaxed/simple;
	bh=NKPat69VdyRRxeucmul7oD2+f5c+2rs8coJTsYSLt8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5fqnZZ9t5bTA9Zi/Nv0i6jlECn/YWQJa6F3qq/2St2uwtKJVZ32IJQxWuKNvtLmt/LLI+IWWKIhNCbeiRwz3C3R9RsBAtAR75556LBJBLxjXVGabTapJh0wK5Ag/Eww448FgqNYF7PkpmlFzccvXoQaP4tyQrt0w7LyL2DhSJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3qUwBt81; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3qUwBt81"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KNYKyPv1ZJsDcW5BAzMAF1YFbZZMWHKFPAkA22JHz1Q=; b=3qUwBt81UYgQwJWeFeYX3i2Jli
	8ZC17yIKjGn/1FABubeh9UOCqaU7A7ukF2wmNjbcYsHagApVjPryzrznBa5gMf0ZDYlEvr3JVxwBu
	ZLBlP2r44wLOMzdLJXtnZmfvC5s9FNptDWjjWL8TMBT59tA3chS95kv3O6rgdqSZKDH0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDm9s-0095ey-Uv; Mon, 05 Oct 2026 19:07:24 +0200
Date: Mon, 5 Oct 2026 19:07:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: dsa: qca8k: fail mgmt Ethernet MDIO
 access on busy wait errors
Message-ID: <acbcea38-30e5-4aba-908a-7ff986bc4da0@lunn.ch>
References: <20261003172405.342-1-yongzhao.derek@gmail.com>
 <20261003172405.342-4-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003172405.342-4-yongzhao.derek@gmail.com>

On Sat, Oct 03, 2026 at 07:24:04PM +0200, Yongzhao Chen wrote:
> qca8k_phy_eth_command() polls MASTER_CTRL over management Ethernet until
> BUSY clears, but only bails out when the poll timed out and the last
> poll request also failed. If every request succeeds while BUSY stays
> set, the -ETIMEDOUT is dropped. A read then returns MASTER_CTRL data
> from a transaction that has not completed, and
> qca8k_internal_mdio_read() does not fall back to the MDIO bus.
> 
> A failed poll request does not stop the loop either.
> qca8k_phy_eth_busy_wait() leaves the value unchanged on failure, so the
> BUSY test then uses the previous value, or an uninitialized one if the
> first request fails.
> 
> Stop polling when a request fails and return the poll error or timeout.
> The poll-error path also leaked read_skb, which is only consumed when the
> read request is sent; free it on this path.
> 
> The Sashiko review of v1 identified the dropped timeout. A userspace
> model of the driver's functions reproduces it and the poll-error path
> with scripted BUSY responses and failed poll requests; these cases pass
> after this change.
> 
> The polling loop comes from commit 2cd548566384 ("net: dsa: qca8k: add
> support for phy read/write with mgmt Ethernet").
> 
> Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
