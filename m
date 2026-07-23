Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD02397699
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829271; cv=none; b=UIlpi/hEQmZ+3X2n9MLxqX40nsizB37ONFZexNZ42WR8dfUpgM+Nfu5cXrSURHvgqyuJCKXu49/9PrCRS4M8WrnWO1YhpSFQLqiPE/kjEK+Nhf6wmNpwBC9TnQb/SPbi64OykQ3jmFNN/Xkm5mmGVE+soD2ZftYIAqLSlqS5ZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829271; c=relaxed/simple;
	bh=aXbFVMwbsy89WMJi4M6ofrvLQhU/Sd6HhEuV0TUJxtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGy2tz3PV3+uRUoZprS+FXF+g64Idlb/LFlKSOkkoyb8za7QBRz5Vqf5k9pzZaAL4/mmnqeQjdUE2QQV02sJB9/KdNIaUQwkmcui31lKGMw7wZ4feRlCBMqyjU0ndOluavbgHofy3qGtLPUv5eXz0dNUbY/2l+pKjnX2DyDopDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ngEpsH8u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ngEpsH8u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZbzbnSKfemHGxXgudekc1cG/2HLRqNyx/mDK7R4rdHY=; b=ngEpsH8uxChwdbLyIAjF5uiSS/
	X9CziBL2JGRO5KgyntOehmIzJA5QL9+5sdGW8jyI2NyDN3mdrf8hT12c/dOM6T3L3Om2pfNnbSFlv
	WwDo94xq7Zh2ZjzTyFBzsDfK2YBYitZeOooiBEK012v38s1RB/T7ZJw4FPWziBXZMK0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmxcn-00Drnt-Bn; Thu, 23 Jul 2026 19:54:25 +0200
Date: Thu, 23 Jul 2026 19:54:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Dietz <simon.dietz@plantwatch.de>
Cc: andrew+netdev@lunn.ch, netdev@vger.kernel.org, dietz23838@hs-ansbach.de
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Message-ID: <22fa2ec2-7db9-48f0-b03a-47826239d07c@lunn.ch>
References: <88182be4-f7c2-4012-8661-881415124a15@lunn.ch>
 <20260723171219.2293282-1-simon.dietz@plantwatch.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723171219.2293282-1-simon.dietz@plantwatch.de>

On Thu, Jul 23, 2026 at 07:12:19PM +0200, Simon Dietz wrote:
> > Passing a binary structure as a netlink attribute is not going to fly.
> 
> More like this (using generic netlink)?
> 
> static const struct nla_policy gn_coord_policy[GN_COORD_MAX + 1] = {
> 	[GN_COORD_LAT] = { .type = NLA_S32 },
> 	[GN_COORD_LON] = { .type = NLA_S32 },
> };

It would be good to add some documentation somewhere what this S32
represents. I normally see LAT and LOG represented as floating
points. I _think_ i read somewhere in the standard that over the air
messages user 1/10 of a degree?

> 
> static const struct nla_policy gn_genl_policy[GN_ATTR_MAX + 1] = {
> 	[GN_ATTR_COORD] = NLA_POLICY_NESTED(gn_coord_policy),
> };
> 
> static int gn_get_position(struct sk_buff *skb, struct genl_info *info)
> /* ... */
> 
>     nest = nla_nest_start(reply_skb, GN_ATTR_COORD);
> 	if (!nest) {
> 		nlmsg_free(reply_skb);
> 		return -EMSGSIZE;
> 	}
> 
> 	if (nla_put_s32(reply_skb, GN_COORD_LAT, val.lat) ||
> 	    nla_put_s32(reply_skb, GN_COORD_LON, val.lon)) {
> 		nlmsg_free(reply_skb);
> 		return -EMSGSIZE;
> 	}
> 	nla_nest_end(reply_skb, nest);

Is a nest needed? I'm not a netlink expert, but my understanding was
you use nests when you have lists, and each member of the list has a
collections of attributes. Do you have a list here, or is it just one
location.

> > This also does not feel correct. Why is location a property of an
> > interface? Can one machines interfaces be in different locations?
> 
> I would answer: Unfortunately, yes. Consider a 700m long train (which
> is the upper limit of train length in europe, in US there may be even
> longer ones). It is one vehicle, but may have at least two gn (wifi)
> devices, one at the front and one at the back. That is a niche use case
> but it is one.

O.K, makes sense. Although i would think it is more likely to be two
vehicles with some level of coupling.

> That of course would make the implementation a bit more difficult
> because if the position is saved for each device, then the gn address
> must be passed along with the position so that the kernel is able to
> map the via netlink passed position to the right device, which affects
> the kernel / user space interface.

This is the nice thing about netlink. You can additional attributes
later, the device the position is applied to. So at the moment you
walk all the interfaces and set their position. In the future, if the
ifindex attribute is included you only set that one device.

This however brings us back to the routing table. If the location is
strictly a property of the interface, the routing table is also a
property of an interface? Forwarding on the same interface, and
forwarding on a different interface are different operations? Does the
standard say anything about multi-interface devices?

	 Andrew
