Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D437F310
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994598; cv=none; b=qnFgborOEL9g+dI6E/zULnJWFZh3xp4v4r+VBzKnNK2jSzRxLscRawQT/RliXZk4hBIQZaoqYCJzSTZlYppn+IURwmMzxpr5gL/asbUKQkwjG7TOdM5eSBWmpM4ubcR5X/aFHsTg4BlgwDUa6/J9icwUBJARkzbPaM4q5e3vLkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994598; c=relaxed/simple;
	bh=yyoIBkkk6oDur4Gohs1UB4BaoazYovjG2/v7stAZy4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBz9nUfyiIUHkoM2Lbd5H5yzypM3s30j/xs1a+IMNwstxKyK3geuQpuYSs0pLp/VIX6POAsMGInut7TnoLprY1LStg70SP36ErqWMi2kz6FucAUeAo6uK2e4qYISkHfZ7Hzb2lraWuhiRAsctfAYjZBpVgcHlrKTmRa9zZkK5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AIO+Izgd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AIO+Izgd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=03NwNQ34hn+wFwef+v3bAUJFvXRssXwRSlVJLYq/qis=; b=AIO+Izgdl+UGEUsJ22XCM5wnJi
	MwmNuJOWht2hxXeYzwWid5KfcH28maergkzltjb3c1vRGiq3CT8DnZe63LhUUWKM6rmo94EuDl7E6
	Oc9tL7oRVSKpqwiywrC4yzdp+JB1j27iJcL+uu887omW/wjU3ESjCVtzL2gnYc6LYTBU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wned6-00E9r1-VN; Sat, 25 Jul 2026 17:49:36 +0200
Date: Sat, 25 Jul 2026 17:49:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Dietz <simon.dietz@plantwatch.de>
Cc: andrew+netdev@lunn.ch, dietz23838@hs-ansbach.de, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Message-ID: <4e09a943-d116-452f-93f3-93fb363b09f5@lunn.ch>
References: <22fa2ec2-7db9-48f0-b03a-47826239d07c@lunn.ch>
 <20260723182457.2670919-1-simon.dietz@plantwatch.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723182457.2670919-1-simon.dietz@plantwatch.de>

> When considering our 700m long train example, I think for sure. Because
> the range of 802.11p is roughly 500m, there can be a optimal inter-
> mediary, which is in range of the device at the start of the train but
> not in range of the device of the end of the train.

Many years ago i did some networking work on the Swiss local commuter
trains, think the Zurich S lines. They had Ethernet running the full
length of the train.

This then leads me to thinking about having two nodes, one on each
end, with an Ethernet link between them. Ethernet, or any cable based
medium, has different semantics. A broadcast is received by all. There
is no point rebroadcasting on the same interface.

So i think this needs to be thought about in the overall picture.

> > Does the standard say anything about multi-interface devices?
> 
> The standard is mostly written with cars in mind, so I don't think so.
> After all, there is not even an ITS-Type for trains, just one for trams

So maybe for the vehicle side of things, interface to interface
routing is not so important, until somebody pushes forward with train
use cases. But what about the fixed infrastructure? How often do you
see nodes along some sort of linear structure, connected together by
cable? Or a row of blind corners which is known for accidents, you
could put fixed infrastructure along the way and cable them together,
so the vehicles can "see" around the corners?

Sorry for all these questions, but i want to make sure we have an
architecture which works for the most number of scenarios, and is not
going to be a dead end for more complex setups.

    Andrew
