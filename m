Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7941E6A6
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248421; cv=none; b=EZ1sRuMLS3rB346tvR9r1UolVqMCXTCw3PFBu7XIi+Tv5CwkvxI8/sXGXgPuBJlmMbJRf0WHcLdDGcxqF9895X4F8mfw7tfXW/G8keFKy3fVStao/Tpinom0oFES+YuVC3q/C49XtVW40B9mV1+hpO2s7mu3nVMm2nrYAqojYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248421; c=relaxed/simple;
	bh=0wKP7dKJQpfcvBrKKBSUdE4NqItsaqmzqBSpzCWhYYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4IdGfHOIW0XX+F/mVZGMhQm5WBeXmoxNwUlHJ8i6yO3cpQZg2RkH9u3NoaI7SlnWG4KcLzh1MDtapntHnhd86toYKQ7yCOl0du1CUhMSyTUi0Z5jnhbdp/LQnwFhyz7tYlXd13aIuaAirtBOs/ajrxWxcc885044oZUUqZ1MvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T5al6rMg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T5al6rMg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0c+qpm6b01v/cobRhYFLSHeK8Zdkv1FJKhFfWarwq04=; b=T5al6rMgjwL9T3wpVMJ7ZkqwUG
	VHh5ihnhHgGwZHMnUUi0p+sDuNiW4SoXqg7c6QLCPr/xG/LbWwp7AbBkubA0J2ivpSnRmQziJciMZ
	hrb+NYkOBCqKMtXWTsarRvMOohChSIMVGEh3y19NUH6ZSkGfz5AvT9hPIxh66EZZiY1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woif8-00EdpG-AM; Tue, 28 Jul 2026 16:20:06 +0200
Date: Tue, 28 Jul 2026 16:20:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Dietz <simon.dietz@plantwatch.de>
Cc: andrew+netdev@lunn.ch, dietz23838@hs-ansbach.de, netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v0.1 1/1] net: add GeoNetworking protocol
Message-ID: <f837b9c2-b2e4-44b5-8e05-6191505fea8c@lunn.ch>
References: <baa3f76d-ef8d-43bd-b72d-d9b67e33a738@lunn.ch>
 <20260728124146.1554385-1-simon.dietz@plantwatch.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728124146.1554385-1-simon.dietz@plantwatch.de>

On Tue, Jul 28, 2026 at 02:41:46PM +0200, Simon Dietz wrote:
> > Or a GSM link, or even GSM-R, etc.
> 
> > At minimum, the architecture work being done now should consider
> > it. I'm not saying we need to implement it, but we should have an
> > idea how it would be implemented, and ensure what is implemented now
> > will not block it, but make a good building block for multi interface
> > heterogeneous router node.
> 
> So you mean that two nodes could be connected, e.g. by GSM, ethernet,
> GSM-R or other means and exchange GeoNetworking relevant information
> over this other channel? Or even tunnel gn packets over that other
> channel?

So wording is important. Let frame this in IP/Ethernet/802.11 words,
where applicable, since they are better understood by everyone.

We have GN native flood mechanism, where it receives a broadcast on an
interface, and it rebroadcasts it, because it can see nodes the
original sender cannot. That is not a concept we have in traditional
IP/802.11 networks, because everything goes via the access point which
is in the middle of the network. When a hop happens, the TTL is
decremented, but the packet is otherwise unmodified, it keeps the same
L2 source and destination addresses. I would call this flooding an L2
mechanism.

For unicast, the flooding mechanism is first used to find a path from
the source to the destination, adding entries to the routing
tables. The sender then uses a L2 unicast destination to send it the
first node in the chain of hops. That node replaces the L2 destination
address with what it has in its table, decrements the TTL and sends
the packet on its way, so that eventually it reaches the
destination. Because this unicast process modifies the packet on every
hop, i would call this a L2.5 mechanism.

From what i have seen so far, the standard only talks about a single
interface, which probably covers most use cases. 

But how do we handle multiple interfaces?

For IP/Ethernet/802.11, we have 802.1 bridging. This takes a packet
from one interface and bridges it, unmodified, onto another
interface. Address learning is performed, where the bridge learns what
L2 destination addresses are on each interface. The basic assumption
is that an L2 destination address is only in one place because it
assume cable like semantics.

The GN flooding mechanism messes up the cable like semantics. An 802.1
bridge could see the same L2 destination address on both
interfaces. An L2 address might ping/pong between interfaces and maybe
you don't get a $OPTIMAL path, for some definition of optimal. Does an
802.1 bridge actually break and cause loops? Does STP get itself into
knots? This is something that needs considering. And the L2 food
mechanism and the L2.5 unicast mechanism, both need considering, and
the two might interact with each other?

You mention tunnel. A tunnel is when you take a packet, at the tunnel
entry point, add an additional outer header, and use that outer header
to make the packet appear at the other end of the tunnel, where the
additional header is removed, and you then process the inner packet as
normal. By normal, i mean you give it to an 802.1 bridge, or you IP
route it. All of the tunnels i know of in linux make the entry/exit
points act like interfaces. So you are back to the same basic problem,
how do you handle multiple interfaces. So i don't think thinking about
a tunnel actually helps.

Can the GN native mechanisms be used with multiple interface? For the
broadcast flooding, i assume there is some packet duplication
detection, and duplicates get dropped. Can you add on top of
interfaces a GN bridge, and have hierarchical duplication detection?
If the interface has seen the packet before it do not rebroadcast, it
just sends it up to the bridge. If the bridge has seen the packet
before drops it. Otherwise it floods it down to all other interfaces?
Does this work? Can it be bolted onto the Linux bridge code? Do we
need a GN specific bridge implementation, parallel to the Linux bridge
code? Does an interface which is taking part in GN need to inspect its
frames and direct them to the correct bridge?

For unicast, so long as the GN flood mechanism works, the path
discovery should work. But the routing table needs not only have the
next hop L2 address, but also the egress interface to reach that L2
address. We already talked about, is the routing table a property of
the interface or the node, and concluded that since interfaces can be
in different locations, the table is an interface property. So it
might require hierarchical tables, and the interface table just says
pass the frame to the global routing table, and the global routing
table then decides which egress interface to use?


So lots of questions here. What we need is an architect to sketch out
complete picture, describe in words and diagrams what a complete Linux
implementation could look like. We can then implement parts of it,
enough for a GN node with a single interface, knowing the rest can be
added later, we are not going down a dead end.

      Andrew
