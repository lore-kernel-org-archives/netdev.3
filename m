Received: from mta1.migadu.com (out-161.mta1.migadu.com [95.215.58.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E448283142
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 02:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956222; cv=none; b=cY8dvPb8ADHKjnGSzenqRv7id6e1mgpLzSep8jAKhSXCjPcE4wa255yEj/+YSehBvZKEQzvalhHHgF1Icl25VNs1iysHb74NX8NumtbzzLA7FyzZ106CCKJoStk+mbWHmK2wQdwOcI0UV3krNRqBuF9zt4AwjrBxGQjo60VKCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956222; c=relaxed/simple;
	bh=0lqL+w/tdLXm8w9NqGC5TYVok8Nu+Orr6++Sza/BWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRSgBSDmpykZaDlJq1qEAIibXNLn2BTvFMafx/DcEpxpN9DhOjwD+hCrYpLg7cFc8PTGuqznOKw8JwnuIJv5PPeywgqRimnCXHUCwTzRVNFSI+qG3MDvak/V2UmEEScreftgpgHoSJv8oyBbKmurivNdySXe5FgX7neGU64E9dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pYq/bHh1; arc=none smtp.client-ip=95.215.58.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pYq/bHh1"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0lqL+w/tdLXm8w9NqGC5TYVok8Nu+Orr6++Sza/BWEA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789956217; v=1; x=1790561017;
 b=pYq/bHh1lN5kXUWZhKUJ2Xf59zrmmpraUIaMdPkog15QH/nXmSqyqXdMhwFnFqRbN+ryhMwi
 Wms3Wb+FiW6qnmxl/WuAAdShs6r5O95x1vXItsaaKb+7lqtaBwuZVM7CDjOuAej21gqsOvnnW3A
 ZSYwEZH9nmE+w70pnbQwX2YU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a5073eefe3589733;
	Mon, 21 Sep 2026 02:03:36 +0000
X-Mizu-Trace-ID: a5073eefe3589733
X-Migadu-Flow: FLOW_OUT
Date: Mon, 21 Sep 2026 10:03:43 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: phy: allow phy_detach() before netdev
 registration
Message-ID: <20260921020343.GA130870@pc>
References: <20260916021505.238990-1-chenguang.zhao@linux.dev>
 <d523dec3-7075-47d9-8ac2-6b3c9d6cec3d@lunn.ch>
 <20260917070559.GA85254@pc>
 <20980b7a-7076-46e7-bb7c-16d1f93502f4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20980b7a-7076-46e7-bb7c-16d1f93502f4@lunn.ch>

On Thu, Sep 17, 2026 at 02:04:51PM +0200, Andrew Lunn wrote:
> On Thu, Sep 17, 2026 at 03:06:46PM +0800, Chenguang Zhao wrote:
> > On Wed, Sep 16, 2026 at 02:12:27PM +0200, Andrew Lunn wrote:
> > > On Wed, Sep 16, 2026 at 10:15:05AM +0800, Chenguang Zhao wrote:
> > > > From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> > > > 
> > > > phylink_connect_phy() may be called from probe without RTNL while the
> > > > net_device is still NETREG_UNINITIALIZED. If PHY bring-up fails,
> > > > phy_detach() uses rtnl_dereference(dev->hwprov) and lockdep reports
> > > > suspicious RCU usage.
> > > 
> > > What do you mean by PHY bring-up?
> > > 
> > >      Andrew
> > Hi Andrew
> > 
> > PHY bring-up refers to phylink_bringup_phy(). The call chain is as follows:
> > 
> > usbnet_probe
> >   -> ax88772_bind
> >        -> ax88772_init_phy
> >             -> phylink_connect_phy
> >                  -> phylink_attach_phy / phy_attach_direct   // suceess 
> >                  -> phylink_bringup_phy                      // fail 
> >                  -> phy_detach                               // No RTNL
> >                       -> rtnl_dereference(dev->hwprov)       // lockdep warning
> > 
> > Because RTNL is not held when phy_detach() is called, rtnl_dereference() triggers a lockdep warning.
> 
> Lets zoom out and look at the big picture....
> 
> Why is phy_detach() not symmetric with phy_attach()?
> 
> Why is phy_detach() touching dev->hwprov, when phy_attach() does not?
> 
> Where is dev->hwprov set and why is the mirror function not dealing
> with this?
The dev->hwprov is set by ETHTOOL_MSG_TSCONFIG_SET in
ethnl_set_tsconfig(), which is the only writer besides phy_detach().

phy_detach() clears hwprov only when the selected provider is this PHY,
so skb_clone_tx_timestamp() / skb_defer_rx_timestamp() do not keep a
dangling phydev pointer after the PHY is gone. That is not the reverse
of phy_attach(); it is lifetime cleanup for a pointer that ethtool
stashed in the netdev.

Chenguang
Thanks
> 
>      Andrew
