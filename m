Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640D43DEAD2;
	Mon, 10 Aug 2026 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385008; cv=none; b=tM7Fo5dyJGOj3Qk62Ts1DQBrratGdpxyXNuzQYmyCKUSvW+bnyeHUfHRZDf+icRCEjShatbsBNlMiWq3OjKOE4a0Kq6AMAIFlWa8pCBsFvN6RjBJvCLPmgN8NcIacodRlgve8J7vgzMRNxplj5N9BokwoS1d98z3Z+2UUAI0LKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385008; c=relaxed/simple;
	bh=aau2JbmbqI4POU+jcJwxQL4ZmAPvr3uK5Z4vSyBv9KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1Jl/IhR+Q9tTbDZRR6y1nWGf2+yjYsywYxyRzQlNi6cr9eicnPKNMTItBlTn3IBTuw4FnBohSbD8Jh45pPXkgV1xyWCU/W4P+5sb0IRDtEkDoj5I9p/vw92azImoMPOuBe4sEtPYDd2jDkae4Te/PeIiSZdaxrpYDyvSo5Fp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CxepX+QQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CxepX+QQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gqy8bFAdRc5tA53S/q2so8gy5IUZwXdGNR4ByzEtuh8=; b=CxepX+QQ7WJkbjNa+fxbrsVIkD
	DsWSHW3k4jKTx0wb0Ja/2v1sm7kDRnm7lzEXUkPbqsDLCsns2cAxlkFDW7qjNZUnAJsachkWhw6f1
	AFxsJOhMF6gvU2UzAw2D1C5owlNca+1vXNPuS07+hTMNigaGt29VeYVJx7Zyaq5YG5/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtULJ-00Gxsg-At; Mon, 10 Aug 2026 20:03:21 +0200
Date: Mon, 10 Aug 2026 20:03:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
	nic_swsd@realtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, edumazet@google.com, bjorn@mork.no,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] r8152: use GFP_NOIO during system suspend
Message-ID: <918676ef-efcc-4524-a779-62eb2c3eb608@lunn.ch>
References: <20260810065741.4019-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810065741.4019-1-nic_swsd@realtek.com>

On Mon, Aug 10, 2026 at 02:57:41PM +0800, Chih Kai Hsu wrote:
> During system suspend, memory allocation with GFP_KERNEL can block
> waiting for I/O to complete. If that I/O depends on a device that is
> itself suspended, a deadlock results.
> 
> Introduce RTL8152_SYSTEM_SUSPEND flag to track when the driver is
> operating in the system suspend/resume context. Set the flag at the
> start of rtl8152_system_suspend() and clear it at the end of
> rtl8152_system_resume(), following the same pattern used by
> SELECTIVE_SUSPEND for runtime suspend.
> 
> In get_registers() and set_registers(), select GFP_NOIO when the flag
> is set so that the kmalloc and kmemdup calls in those paths do not
> trigger I/O reclaim.

Do you have a reproducer for this? Or is it theoretical?

> @@ -8693,6 +8700,9 @@ static int rtl8152_system_resume(struct r8152 *tp)
>  		usb_submit_urb(tp->intr_urb, GFP_NOIO);
>  	}
>  
> +	clear_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> +	smp_mb__after_atomic();
> +
>  	return 0;
>  }
>  
> @@ -8758,6 +8768,9 @@ static int rtl8152_system_suspend(struct r8152 *tp)
>  {
>  	struct net_device *netdev = tp->netdev;
>  
> +	set_bit(RTL8152_SYSTEM_SUSPEND, &tp->flags);
> +	smp_mb__after_atomic();
> +
>  	netif_device_detach(netdev);
>  
>  	if (netif_running(netdev) && test_bit(WORK_ENABLE, &tp->flags)) {

It seems odd to me that every driver needs to track if it is in
suspend/resume or not. Doesn't the struct device tell you? Is there no
global state somewhere?

       Andrew
