Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DDA3BCD39
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 22:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440118; cv=none; b=WZRDFHyBPZAIdIqlhmhJBf8q9kIqDUzlT1BfGVF08GFvfYRvzw2rp1UdU4/ZGFVYP9sEkMkHdlZ61TJ5eIXYtKqY+DmMjHzY/C/kmQJmXsNm9fQ5SwLBvE69BD5vmVmHbuPp8gwGDtrUDPmlihzVaQXY0+SzzodMwuo1zprMXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440118; c=relaxed/simple;
	bh=wlvyAn0FFsjuVYzTWjyCFdrg+h7jI7ByrF28sephigI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InkDyhyUheryPEqeicG7ZgUBGwgc0gsOlyaRSJCgJ+QUPe0ZYBHJT85xcMRfd7n8y+/U80I61UD2TcGRRrYhh3W75jm3uNAB6GjrUtwNMoWxhVqgzfYOSahfezjYTBrr+wyFhFn9QGlWGXExOi1w7nCygpNkT7nk1vbW07hpCOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfR0ZFIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfR0ZFIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6751F00893;
	Tue,  2 Jun 2026 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780440117;
	bh=EQ6xFPgJyBVnCO7NVWSGX+1jlV4I7jA0Mtur9xHw6go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jfR0ZFIisq9Woxa/pXZmuAZHQHODdJqBttSKN75VjaLiWT5SUJrpOdtUspMYeoAyN
	 p1KDod8Nyd9vZ+sIxRbtbAoPkkELNYyg+1Aoe0SwUnnrDzY0lLKLhXKwaBKNMnVqOg
	 PiT2EfYTFsex0Ac2rk6BNF6CZcbSf/Z/gBt0H5gQmn21q/9fyauCeFxS4J2Q6HjSBp
	 sboPqmjimgkW07zNAhFeOyNNW1aSNJV2+miY4+vLzrK/VjpUE9/hXWSKyboc05DdGL
	 8ZyiYZk/EiU5nlMFOqSDQ47r9/sfV0kAlXOd/JTegqq80F7NuPdB6E3DaiPx1WcQLA
	 jpfOc5p/Lk+Pw==
Date: Tue, 2 Jun 2026 15:41:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 joshwash@google.com, tariqt@nvidia.com, haiyangz@microsoft.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com, willemb@google.com,
 ernis@linux.microsoft.com, sdf.kernel@gmail.com, kory.maincent@bootlin.com,
 danieller@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next 02/14] net: ethtool: make sure
 __ethtool_get_link_ksettings() is ops-locked
Message-ID: <20260602154155.09eb2658@kernel.org>
In-Reply-To: <874ijl5g56.fsf@cloudflare.com>
References: <20260528231637.251822-1-kuba@kernel.org>
	<20260528231637.251822-3-kuba@kernel.org>
	<878q8x5mip.fsf@cloudflare.com>
	<34fad14a092e28c3512f2405f0869133@tipi-net.de>
	<874ijl5g56.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jun 2026 13:35:33 +0200 Jakub Sitnicki wrote:
> On Tue, Jun 02, 2026 at 01:20 PM +02, Nicolai Buchwitz wrote:
> >> Not sure why we're using the "compat" assertion here, which falls back
> >> to check if RTNL is held, instead of the newly introduced
> >> netdev_assert_locked_if_ops().
> >> The contract here is that all callers are expected to hold the
> >> netdev lock (if needed), IIUC.
> >> [...]  
> >
> > AFAIU that's on purpose: the original helper had ASSERT_RTNL(), and
> > legacy callers still enter with rtnl_lock via the wrapper. _if_ops
> > would silently pass for them if rtnl ever went missing.  
> 
> But the legacy callers continue using __ethtool_get_link_ksettings(),
> which has an explicit ASSERT_RTNL(), so I still don't get it:
> 
> | +/* Convenience helper for callers that hold only rtnl_lock(). */
> | +int __ethtool_get_link_ksettings(struct net_device *dev,
> | +				 struct ethtool_link_ksettings *link_ksettings)
> | +{
> | +	int ret;
> | +
> | +	ASSERT_RTNL();
> | +
> | +	netdev_lock_ops(dev);
> | +	ret = ethtool_get_link_ksettings_locked(dev, link_ksettings);
> | +	netdev_unlock_ops(dev);
> | +	return ret;
> | +}
> |  EXPORT_SYMBOL(__ethtool_get_link_ksettings);
> 
> Anyway, no sense speculating. Let's wait for Jakub.

You're right, I probably didn't use the .._if_ops.. because the
spelling was kinda unusual. Looking at my local tree now I seem
to have switched to the _compat helper like you are suggesting
when renaming things.

I also renamed the new helper to netif_get_link_ksettings()
since that's the naming scheme we followed elsewhere (the netif_ 
prefix for helpers called with ops lock already held).

I've been digging thru the drivers calling
__ethtool_get_link_ksettings() since yesterday. Turns out I was quite
optimistic on none of them holding the ops lock :( Hopefully I'm
getting close to posting the first chunk of v2 (patches 1+2 from here
plus all the driver adjustments needed).
