Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4C2EEE67;
	Mon, 19 Oct 2026 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379540; cv=none; b=PcONfrc7ttHAIzTbD3Vn5QWDiGAae5bvXdkga8xl/Dc0EhM4FpV7p6moFTlxk3SM/Pq3KaLEVHT4DuIJgCbG27JXbdDKULsc4YrDn5+jNvuJV8lkjdj4xPWGJ4t35aZEZlXnZEGlQThPjt7EWfdP4HQk7wWD6jXJ8AshmaXQzdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379540; c=relaxed/simple;
	bh=8fzWQVQm4UvuacagfDFHWl8FxmifjX9rVCs330ezpF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuohNLhmBz9ipHwrdx1NaLBAIghAQRBwJDogz8gkTezv1XR2nW5mhlnE1JpE/2KC/T/O0WdGfVh32JSq/sAwH6h04IMLumuPJD3FG6ZymizmQAfQh6F0rda8RCOcXme8iDmxTD+3MGtBewbooImXD10slhGNqzBzVO5XzI3YAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mhZuJndk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mhZuJndk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mSRmJHW3a0b5iLDlUnufz37AcIkvehKHV/YPNLlOUug=; b=mhZuJndk3rqGODgHC1luTRnQSg
	E7ypqYUF31ErSuUSbGFqbZy4WiSM6rCfsjK7zw7AESijwZDWxPbPAM3qgmnjiOMKWVTFjcMzgmrhJ
	nozAj40siryECUwzwOC8SmMmX/hfHTkfMdDk3C2L/zfTPIBvpHq1BVCYl0YjXc4sefBA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xIdnD-00BYMl-2N; Mon, 19 Oct 2026 05:12:07 +0200
Date: Mon, 19 Oct 2026 05:12:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: ag71xx: reallocate rx buffers when changing the
 MTU
Message-ID: <962f9ec3-ca7b-4b7b-98e5-7a2753e41a65@lunn.ch>
References: <20261019014438.199718-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019014438.199718-1-rosenp@gmail.com>

On Sun, Oct 18, 2026 at 06:44:38PM -0700, Rosen Penev wrote:
> The rx buffers are sized from the MTU in ag71xx_open(), but
> ag71xx_change_mtu() writes the new maximum frame length straight to
> the MAC while the interface is running. The rx descriptors carry no
> buffer length, so after raising the MTU the MAC accepts and DMAs
> frames larger than the mapped buffer, overwriting the skb_shared_info
> at the end of the fragment and whatever follows it.
> 
> This is reachable without user action: DSA raises the MTU of a
> running conduit to make room for the switch tag.
> 
> Restart the interface when the MTU changes while it is up, so the
> rings are refilled with buffers sized for the new MTU before the MAC
> is programmed with the new frame length.
> 
> Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/atheros/ag71xx.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
> index 8a3c689f6825..3c9de8c2ba64 100644
> --- a/drivers/net/ethernet/atheros/ag71xx.c
> +++ b/drivers/net/ethernet/atheros/ag71xx.c
> @@ -1761,11 +1761,19 @@ static irqreturn_t ag71xx_interrupt(int irq, void *dev_id)
>  
>  static int ag71xx_change_mtu(struct net_device *ndev, int new_mtu)
>  {
> -	struct ag71xx *ag = netdev_priv(ndev);
> +	bool running = netif_running(ndev);
> +
> +	/* The rx buffers are sized for the MTU at open time and the rx
> +	 * descriptors carry no buffer length, so a larger MTU must not
> +	 * reach the MAC before the rings have been refilled.
> +	 */
> +	if (running)
> +		ag71xx_stop(ndev);

This appears to free the rings.

>  
>  	WRITE_ONCE(ndev->mtu, new_mtu);
> -	ag71xx_wr(ag, AG71XX_REG_MAC_MFL,
> -		  ag71xx_max_frame_len(ndev->mtu));
> +
> +	if (running)
> +		return ag71xx_open(ndev);

And this tries to allocate them again. If this fails, there is no way
back, the interface is dead.

This is not how MTU change should work. If it fails, it should leave
the old MTU in place.

    Andrew

---
pw-bot: cr
