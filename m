Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1234266B2;
	Wed, 23 Sep 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189747; cv=none; b=eBpcDyL0jesU7kN7sfMvJdrKo2+M84OKtYj4rfKs3fNbKnari0/k3dWPC4s3Jw5h/cuMv6Uq1fPCSUiyQ1K+F9hJB0vovTUeIe+08l5aclcfbrwQ5vB1ahGuiGwrKyP/nB++s9NvdHzXZ5AuzYSRe+PIvU+cjFPgc5JZXGV0PSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189747; c=relaxed/simple;
	bh=Rvm0Z5qWL6QK1cIHCWUfahf4qoEdET4G0nkib51eTqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UngBaE1/Z951ujAOl+ZNb3ajdKAXdOGdPkubGbVebAw+IrYAHzs7ER3fEesAMKfbtdwGDMXNnBCwhI+WsZnXmok+sqV1qoF6WFooDsP3bCyErvT5BF8VBaPrI/Tf58rSPP4Yl7FcQvd4+SOAik5aVZSDU41niogW1N9BYjcFWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zZ5uBgZQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zZ5uBgZQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YAqD79GNVyUpTesDe5713HZbBsCiNT7LXqES/cAv4Fk=; b=zZ5uBgZQMntNm1XebHYJxD4rzg
	hcGHnezCa/4iVu1p2MoJ4u+SefOFn+9rakT3HpI/vKtOTVXEjcB2Wj+F4HcqPOSPq3sZ+z/VlwbUn
	qzGqDPeKOUXtXt6nZw6YFFZVhwgNabCzoK0I+2FqrFX95BzshbkHnV4NxVHhTcIo5CMM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9S7y-006rUF-Hw; Wed, 23 Sep 2026 20:55:34 +0200
Date: Wed, 23 Sep 2026 20:55:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ginger Li <ginger.jzllee@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dm9000: Fix a recursive lockup in the TX
 timeout path
Message-ID: <2daa63fc-84a3-457b-b7b8-4cb268bad7d3@lunn.ch>
References: <20260923084055.65091-1-ginger.jzllee@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923084055.65091-1-ginger.jzllee@gmail.com>

On Wed, Sep 23, 2026 at 04:40:55PM +0800, Ginger Li wrote:
> dm9000_timeout() takes db->lock with interrupts disabled and then calls
> dm9000_init_dm9000(), which expects the caller to hold that lock and accesses
> the chip registers directly.  For DM9000B devices dm9000_init_dm9000() also
> calls dm9000_phy_write(), and that function takes db->lock again, so the TX
> timeout path deadlocks on the same CPU.
> 
> dm9000_phy_write() already skips db->addr_lock when db->in_timeout is set,
> because in that case the caller holds db->lock and sleeping is not allowed
> either.  Skip db->lock as well then, so that the nested call from
> dm9000_init_dm9000() works as intended.
> 
> Fixes: 6741f40 ("DM9000B: driver initialization upgrade")
> Signed-off-by: Ginger Li <ginger.jzllee@gmail.com>
> ---
>  drivers/net/ethernet/davicom/dm9000.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
> --- a/drivers/net/ethernet/davicom/dm9000.c
> +++ b/drivers/net/ethernet/davicom/dm9000.c
> @@ -325,10 +325,10 @@ dm9000_phy_write(struct net_device *dev,
>  	unsigned long reg_save;
>  
>  	dm9000_dbg(db, 5, "phy_write[%02x] = %04x\n", reg, value);
> -	if (!db->in_timeout)
> +	if (!db->in_timeout) {
>  		mutex_lock(&db->addr_lock);
> -
> -	spin_lock_irqsave(&db->lock, flags);
> +		spin_lock_irqsave(&db->lock, flags);
> +	}

This is ugly.

Is it possible to pull the locking out of dm9000_phy_write() to give a
version which tests the lock is taken using lockdep_assert_held(). Put
a wrapper around it which takes the lock for the normal case.

I would also take a look at dm9000_phy_read() and understand why its
locking is different.

Ideally you want to remove db->in_timeout, and make sure locked or
unlocked functions are called as needed. I assume you have the
hardware, and can trigger a timeout? So you can do a bigger refactor
like this?

     Andrew
