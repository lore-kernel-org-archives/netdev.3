Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D08455172
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147817; cv=none; b=RDuMQCo322WVa3fT1hy2mkvHUfgrMAY6qmP8k2eOyvq/KoAwhnFoskSMNW7Oz1vRx/zazZH6ogOdiZSnYHYO5/6zRAeYgyMOGl5yyVaAjL0M75Fxmf0f/8YS5WonwzpNUb3OKtKPqrZrKEBZMuJo4CEZDYsL6jzHAXLXvtxJvj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147817; c=relaxed/simple;
	bh=4yXOSI1xYZE/QyuCQn7XXiB9mUnCq6aa1epuBZcBTHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ca5yhp1/zD9pXVONRh+BSD1SNcge8sJtFr1LGJdy5E80iIu48T7djZYt11iE73Byl46sIwEqEINoj77cMkpy1D3T2mC/3/PRV4iXpWrjb7029fy3DJ9Ty3giq1qrls3bCdEYKFHifOREulXssfMqyZfGzddaQLY9x9QJSZ7K/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SYyYOLhX; arc=none smtp.client-ip=91.218.175.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SYyYOLhX"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4yXOSI1xYZE/QyuCQn7XXiB9mUnCq6aa1epuBZcBTHU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790147813; v=1; x=1790752613;
 b=SYyYOLhXs9n0QRD0N0TwCC8Wnv4uSxBrLpdFhjXfZqU43M3Kyvh6KfbzIo0eYUL2K1fw6jYX
 pDxSsAyToJ9eYiHUk6ZUCHqiTKTAUpwfT7jfCP0dR5SP/LpH1eTyvJ+8kEkhYbogNP75n1hxtJC
 8KfhUrsB+sk521dOv5zDDuC0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a309971d428c7050;
	Wed, 23 Sep 2026 07:16:53 +0000
X-Mizu-Trace-ID: a309971d428c7050
X-Migadu-Flow: FLOW_OUT
Date: Wed, 23 Sep 2026 15:16:56 +0800
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, Chenguang Zhao <zhaochenguang@kylinos.cn>,
	syzbot+694b49f41098a5df4fd7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: phy: allow phy_detach() before netdev
 registration
Message-ID: <20260923071656.GA323450@pc>
References: <20260916021505.238990-1-chenguang.zhao@linux.dev>
 <d523dec3-7075-47d9-8ac2-6b3c9d6cec3d@lunn.ch>
 <20260917070559.GA85254@pc>
 <20980b7a-7076-46e7-bb7c-16d1f93502f4@lunn.ch>
 <20260921020343.GA130870@pc>
 <f1f795ed-0511-4a0a-a3e6-70c49d6735e2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f795ed-0511-4a0a-a3e6-70c49d6735e2@lunn.ch>

On Mon, Sep 21, 2026 at 02:15:58PM +0200, Andrew Lunn wrote:
> > > Lets zoom out and look at the big picture....
> > > 
> > > Why is phy_detach() not symmetric with phy_attach()?
> > > 
> > > Why is phy_detach() touching dev->hwprov, when phy_attach() does not?
> > > 
> > > Where is dev->hwprov set and why is the mirror function not dealing
> > > with this?
> 
> > The dev->hwprov is set by ETHTOOL_MSG_TSCONFIG_SET in
> > ethnl_set_tsconfig(), which is the only writer besides phy_detach().
> 
> So this is the real problem. It does not fit the usual pattern of
> setup and tairdown.
> 
> > phy_detach() clears hwprov only when the selected provider is this PHY,
> > so skb_clone_tx_timestamp() / skb_defer_rx_timestamp() do not keep a
> > dangling phydev pointer after the PHY is gone. That is not the reverse
> > of phy_attach(); it is lifetime cleanup for a pointer that ethtool
> > stashed in the netdev.
> 
> Can we make it fit the usual pattern?
> 
> https://elixir.bootlin.com/linux/v7.2.5/source/net/ethtool/tsconfig.c#L413
> 
> This sets the stamper to zero_config, via dev_set_hwtstamp_phylib().
> Could that be done in phy_attach()?  phy_detach() would then have the
> opposite, call dev_clear_hwtstamp_phylib().
> 
> ethnl_set_tsconfig() then just replaces the setting?
> 
> I would put dev_clear_hwtstamp_phylib() next to
> dev_set_hwtstamp_phylib() so it is obvious the locking is the same in
> both.
> 
> 	Andrew

Hi Andrew,

I've just sent out v3, addressing your comments on the provider lifetime
asymmetry.

https://lore.kernel.org/all/20260923071132.908826-1-chenguang.zhao@linux.dev/

Happy to iterate further if anything still needs adjustment.

Thanks,
Chenguang
