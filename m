Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458C4D5978
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646719; cv=none; b=Bd+cChAvpKhSL9ubu9wG7pQIyrEMH9mhCjcy8m5bQrNw+hvV0nOqih3/cQbgaMfE8YQythLcwMLSKHP16nYQGQSW5ZWxCODuxCLI+U/gVtY9dV/e98m2K0H9CZkbV75tLHqfyr4ElGMuTZfLza3lNX8+aPadWxCLEI9c+u4CWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646719; c=relaxed/simple;
	bh=aL1TXjKT7OgSEOA2sXOhkLZ237cr35l311mpkZv6VDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFYW35ytB+dMkhQkU0ny0vkxNUuVyxF3+XlL61Wosb19k3Oq+VehOS/Yc6TXvIvMms/9kARUVuIZ5P92r226nB36+e79iCpZteQSOuVyiUTNCRCvem7uIVSePN//Levf4ZRa508tysPc1gGla7dzdOQ1sBHSN1kaTG9lNQ8rCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rHhu6lXM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rHhu6lXM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cuaMvaud2oNe86oe51jqV4FImvoU0ZaFYwgB/i0yYlc=; b=rHhu6lXMuYGVNmK1oYHS2KhAGH
	Ija3g5kfbk6RcZ/Hhn5pqQnrHSJYbDBeRr2PCHj4YKOIRkBHRdtlOWW3idGSXd31hX5E30ajUt3Fx
	xKUCo1X4VFzMnBMxN4Ss3rsia9l7BIOSB5JLf4tqqEXuhFhKnld/TtdnNiIXlYAJStsw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7ArD-005fMt-U0; Thu, 17 Sep 2026 14:04:51 +0200
Date: Thu, 17 Sep 2026 14:04:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: phy: allow phy_detach() before netdev
 registration
Message-ID: <20980b7a-7076-46e7-bb7c-16d1f93502f4@lunn.ch>
References: <20260916021505.238990-1-chenguang.zhao@linux.dev>
 <d523dec3-7075-47d9-8ac2-6b3c9d6cec3d@lunn.ch>
 <20260917070559.GA85254@pc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917070559.GA85254@pc>

On Thu, Sep 17, 2026 at 03:06:46PM +0800, Chenguang Zhao wrote:
> On Wed, Sep 16, 2026 at 02:12:27PM +0200, Andrew Lunn wrote:
> > On Wed, Sep 16, 2026 at 10:15:05AM +0800, Chenguang Zhao wrote:
> > > From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > > 
> > > phylink_connect_phy() may be called from probe without RTNL while the
> > > net_device is still NETREG_UNINITIALIZED. If PHY bring-up fails,
> > > phy_detach() uses rtnl_dereference(dev->hwprov) and lockdep reports
> > > suspicious RCU usage.
> > 
> > What do you mean by PHY bring-up?
> > 
> >      Andrew
> Hi Andrew
> 
> PHY bring-up refers to phylink_bringup_phy(). The call chain is as follows:
> 
> usbnet_probe
>   -> ax88772_bind
>        -> ax88772_init_phy
>             -> phylink_connect_phy
>                  -> phylink_attach_phy / phy_attach_direct   // suceess 
>                  -> phylink_bringup_phy                      // fail 
>                  -> phy_detach                               // No RTNL
>                       -> rtnl_dereference(dev->hwprov)       // lockdep warning
> 
> Because RTNL is not held when phy_detach() is called, rtnl_dereference() triggers a lockdep warning.

Lets zoom out and look at the big picture....

Why is phy_detach() not symmetric with phy_attach()?

Why is phy_detach() touching dev->hwprov, when phy_attach() does not?

Where is dev->hwprov set and why is the mirror function not dealing
with this?

     Andrew
