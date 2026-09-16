Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72643991E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560762; cv=none; b=jfmPEsKBY9xmWOWi5OvEOCBVmkBL6rxEuMZNwLxOj9mg3qzcKzmMiQYVE25gRAGe5+JMm32kRLjxF6gTqi4A85MeYq0umMenZToAlqK8xNnxCl8E4lYMl6kS61yIgs3tWwYFdPaQE/JngVNYLt5HVlpsSI6Ruvr9CFp7X9mr4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560762; c=relaxed/simple;
	bh=QuVklk6h7RlwBiYgtPHREi1IR4OlT4VbHEnRt6N6zbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipm7ZMDPiJuUqtrobAQYRnvQJzi9lX7ywu/8FzXsF41kB1jgl1x+C5QuVQ8k2iUbEsi5BNCSww5J+Oxs7YwESG2kFrs5rvfmfl9i8XlCu2C16WlKBFVjTUN3FwN6QSkhEIAAoCidt8R5nA9cJRQlJbIfnOSXxnuQy53At0y+cCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xn/14asZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xn/14asZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9KWH8jb51AZm54xRTLBfB19fXZ9Q78YL/ET5sFilyak=; b=xn/14asZ8IysBapJh1XNaOCiep
	c5iU6+bixzZWe8XZTA42O2/zidm0HKBwU7qt3/7YFROTb/b59i5W4J34MKQJyAZ50P1p7YeizhBHi
	NcLUIjVdDvL+niS4wXjU6TrkizqFzYGuD03uwLL8mrzT4cdwu54c01SWMVgVA+wpq3Hs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6oV1-005TPe-Pj; Wed, 16 Sep 2026 14:12:27 +0200
Date: Wed, 16 Sep 2026 14:12:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: phy: allow phy_detach() before netdev
 registration
Message-ID: <d523dec3-7075-47d9-8ac2-6b3c9d6cec3d@lunn.ch>
References: <20260916021505.238990-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916021505.238990-1-chenguang.zhao@linux.dev>

On Wed, Sep 16, 2026 at 10:15:05AM +0800, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> phylink_connect_phy() may be called from probe without RTNL while the
> net_device is still NETREG_UNINITIALIZED. If PHY bring-up fails,
> phy_detach() uses rtnl_dereference(dev->hwprov) and lockdep reports
> suspicious RCU usage.

What do you mean by PHY bring-up?

     Andrew
