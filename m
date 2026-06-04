Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB53BBFC2;
	Thu,  4 Jun 2026 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780615992; cv=none; b=dd0PjXICkWtRssrJvXtQvkTMh+3Fu0hrnS5SqolRjd3nhi4kG/f8xeLCjWhesmMXlvyVtPjcfgSddPj1K4nEXL6xKxeGi7RdHGtAvG1XBhizG70+AP3uEbY0Q6w1u4ATEZ/59HBOLct0v/7ichr4elbw7eSmna891C/pbEp6r/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780615992; c=relaxed/simple;
	bh=SeSHst5AObDCIEIJg/xapZPuyCUk1WOpqtuRhwBDbxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibJBW3JgrtMUBSG7jSOutggt1pQxI4K0ysO7+srE+HUr+rlrJHCTd+onDjjhAKV6Bg2pDqP39z2JTO3O3x7siWxWNBmEkfog/e3P5mD0wt/hUgmrxKa+O8E9cg10w+tPBRImCXSyt67I4CvfqWio1s64m8133OMoCQ6XDy3Hyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hhv77/5y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hhv77/5y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RHweM4tMe7Hr7rVUXfnGEijnpsBKdn5XLPK7KmLWYjE=; b=Hhv77/5yUmupRzCaRFZymqBM3Q
	UYreH3/aZFjYC3+YQzg7lJ4WWkPxufoddkeKjNX/Kqzwh0yMoZ1MzFNkX1hMc5WlYrYhFGOikchTr
	B0kXClzUUqJTHrEhq9lN1kT77fBB2gdUXaLq7BNTVl6J7dPdojCDgeH4plbN77EIH6cE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVHYZ-0067ch-IZ; Fri, 05 Jun 2026 01:32:59 +0200
Date: Fri, 5 Jun 2026 01:32:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	vadim.fedorenko@linux.dev, horms@kernel.org,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v6 4/4] net: rnpgbe: Add link status handling
 support
Message-ID: <7d31ec15-07cc-479d-adce-c7d504eff284@lunn.ch>
References: <20260604112750.769215-1-dong100@mucse.com>
 <20260604112750.769215-5-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604112750.769215-5-dong100@mucse.com>

> +static int rnpgbe_process_link_event(struct mucse *mucse)
> +{
> +	struct net_device *netdev = mucse->netdev;
> +	struct mucse_hw *hw = &mucse->hw;
> +	unsigned long flags;
> +	bool link;
> +	int speed;
> +	u8 duplex;
> +
> +	/* lockless fast-path ,serv_task retry handles race */
> +	if (!(mucse->flags & M_FLAG_NEED_LINK_UPDATE))
> +		return hw->link;
> +
> +	spin_lock_irqsave(&mucse->link_lock, flags);
> +
> +	link = hw->link;
> +	speed = hw->speed;
> +	duplex = hw->duplex;
> +
> +	mucse->flags &= ~M_FLAG_NEED_LINK_UPDATE;
> +	spin_unlock_irqrestore(&mucse->link_lock, flags);
> +
> +	if (link) {
> +		netdev_info(netdev, "NIC Link is Up %d Mbps, %s Duplex\n",
> +			    speed,
> +			    duplex ? "Full" : "Half");
> +	}

I actually think down is more useful to report than up? Up is
generally the normal state, you don't care about that too
much. However if the link does down, you probably want to know so you
can figure out why.

> + * rnpgbe_link_is_down - Update netif_carrier status and
> + * print link down message
> + * @mucse: pointer to the private structure
> + **/
> +static void rnpgbe_link_is_down(struct mucse *mucse)
> +{
> +	struct net_device *netdev = mucse->netdev;
> +	struct mucse_hw *hw = &mucse->hw;
> +
> +	/* Only continue if link was up previously */
> +	if (!netif_carrier_ok(netdev))
> +		return;
> +	netdev_info(netdev, "NIC Link is Down\n");
> +	rnpgbe_set_link(hw, false);
> +	netif_carrier_off(netdev);

Why asymmetric behaviour.  Report up in one place down somewhere else?

	Andrew
