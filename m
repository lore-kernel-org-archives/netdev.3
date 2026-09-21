Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963649503E
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992980; cv=none; b=TSH2u8KpfYzfqAG6G+pLlammCEvf2k72ZBptuPYy6F3la1Cozl2B5TAGI334WK5RRW+lLwjyiDJ6MPija2v6JaT7jWfp8N/KU/aALd4vJx1o8RxxnRNcsXnOZM95zukHyfUsjIOxJ9GZLzmaiY3ecZFixAWJU2Y3oVNkeKLN6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992980; c=relaxed/simple;
	bh=W2kAFUua18nUMBZkbJMUxNes+/tnXpRlO6KN5cxDabw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrRLNRb0BljPkDMNCuksqaibS/NQ0hVAZzOpAj8OPBHTc/GMNtiAmYffObzXYyMzWOuR7YWiIzfgjWwt/Cyr0ncOp85z389hIAjME8jtUzt9kbLp5osy+FM0FVrf3qWaI6HmRuaQuiYnXL7uuoNgFRIj70N1ZCxswtKw6ZYOoTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SSTOU77a; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SSTOU77a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6NISW1uVEkbeXJZQ4hwTRlWNL62orYNBCZ51Bnw51Mo=; b=SSTOU77agS5xjSEvQs8aIOxvVO
	c9qoZUS3IlTLmYRCMvQhLNLCtu/oAGOOwxftb9B/cRPclbsyJQ5e5/33bx4gx7feUbOBjHwa+q/v6
	6eoXqJ28j7q9GAuY+nlAFQ/i/0dQHhp2hI3AI9tkQX4PH7q77WpHJQOikWa3qtm/usJ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8cwA-006KLC-Jr; Mon, 21 Sep 2026 14:15:58 +0200
Date: Mon, 21 Sep 2026 14:15:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: phy: allow phy_detach() before netdev
 registration
Message-ID: <f1f795ed-0511-4a0a-a3e6-70c49d6735e2@lunn.ch>
References: <20260916021505.238990-1-chenguang.zhao@linux.dev>
 <d523dec3-7075-47d9-8ac2-6b3c9d6cec3d@lunn.ch>
 <20260917070559.GA85254@pc>
 <20980b7a-7076-46e7-bb7c-16d1f93502f4@lunn.ch>
 <20260921020343.GA130870@pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921020343.GA130870@pc>

> > Lets zoom out and look at the big picture....
> > 
> > Why is phy_detach() not symmetric with phy_attach()?
> > 
> > Why is phy_detach() touching dev->hwprov, when phy_attach() does not?
> > 
> > Where is dev->hwprov set and why is the mirror function not dealing
> > with this?

> The dev->hwprov is set by ETHTOOL_MSG_TSCONFIG_SET in
> ethnl_set_tsconfig(), which is the only writer besides phy_detach().

So this is the real problem. It does not fit the usual pattern of
setup and tairdown.

> phy_detach() clears hwprov only when the selected provider is this PHY,
> so skb_clone_tx_timestamp() / skb_defer_rx_timestamp() do not keep a
> dangling phydev pointer after the PHY is gone. That is not the reverse
> of phy_attach(); it is lifetime cleanup for a pointer that ethtool
> stashed in the netdev.

Can we make it fit the usual pattern?

https://elixir.bootlin.com/linux/v7.2.5/source/net/ethtool/tsconfig.c#L413

This sets the stamper to zero_config, via dev_set_hwtstamp_phylib().
Could that be done in phy_attach()?  phy_detach() would then have the
opposite, call dev_clear_hwtstamp_phylib().

ethnl_set_tsconfig() then just replaces the setting?

I would put dev_clear_hwtstamp_phylib() next to
dev_set_hwtstamp_phylib() so it is obvious the locking is the same in
both.

	Andrew
