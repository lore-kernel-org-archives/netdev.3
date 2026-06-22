Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299B3BB12F;
	Mon, 22 Jun 2026 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138991; cv=none; b=UgTfkkysWYt38HykFIixBCAD5tuU+PDq20XQjyMW+et8Ibkkg/4r6ESuyWdrIiAEj5BthToieq82IQlSdehmF/K2DvgcB48qknKTHL7If2PUwXGTY2F39cA2sVbJOhFuOlPpssoqbtfyB0MJobHqzGL4Llynd1uDLATz7HiSIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138991; c=relaxed/simple;
	bh=8V+r7o9f9mLMvJdPxNQcN/zRq8X5zC905ubQq7A+eQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tf+yLXySKXn5BtyN3gTxQJJmDeUkuo19XFhyoU8Vzp4SgY1vodjsXW++uZ3oylAeYCQHVfybY+l4Sr62HbB30aJYij5+YyCfoyVBddCHJQW2SOgicIsnNGxv+ocTPfxjyEkQr52xC+3745lIJ7ButIhD9Aqlk+VPJdJdXLlRzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbBmxN7G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbBmxN7G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9384B1F000E9;
	Mon, 22 Jun 2026 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138987;
	bh=28EV9LXWWfRIeqveaIAAq2EXgIyyjKpY/8BzfJm0NKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EbBmxN7G9ryYk1igU1UYvb4DX8Emb69BhWsjeFhD14mP8FVF6YhWaEOa99Dsjv1Fu
	 glBnHA32FVqMDPSuUzYF4/MosUFDUn/chEyQIPPplEwPkZKEYElXPR6U4riEu+d7iz
	 whxqh27q8Xj9qWS0yjWi6OHCHKgC2HWemuHdA99vMFT0pVspn9hWAqDa3u7VRPhYZB
	 i9EIes3dts9oQm2mJZ8/qwZ179xRPXaxg3E4A0OatmYmmenGPZ+0hFM5JiMWLVaPj0
	 7L91GWE1uNvhcCSz5qKBTLig9SiCgobxX5g8MLhoTyGe3wuR+pKdz45RUH/xm/PDJK
	 NzWhclXUlwKVA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D715E808864; Mon, 22 Jun 2026 16:36:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Ralf Lici <ralf@mandelbit.com>
Cc: netdev@vger.kernel.org, Daniel =?utf-8?Q?Gr=C3=B6ber?=
 <dxld@darkboxed.org>, Antonio
 Quartulli <antonio@mandelbit.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
 <phil@nwl.cc>, Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: [RFC net-next 08/15] ipxlat: add translation engine and
 dispatch core
In-Reply-To: <20260622133452.432257-1-ralf@mandelbit.com>
References: <87tsr4gcag.fsf@toke.dk>
 <20260622133452.432257-1-ralf@mandelbit.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 22 Jun 2026 16:36:24 +0200
Message-ID: <87ik7aej6f.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[ skipping some of the netfilter-related context until we hear from the
netfilter devs ]

>> > My second concern is that the SIIT boundary would be a property of
>> > rule and hook placement. That gives flexibility, but it also means the
>> > translation point has to be constrained and documented very carefully
>> > to avoid ambiguous TTL/Hop Limit, PMTU/ICMP, and hook-order behavior.
>> > For this use case I would rather have the route that matches the
>> > translation prefix also be the object that says: leave this family
>> > here and continue in the other one.
>>
>> Yeah, with flexibility comes the ability to shoot yourself in the foot.
>> But that's not really different from much of the other functionality we
>> have in the kernel today, is it? For netfilter in particular it's
>> certainly possible to configure a broken NAT configuration that leads to
>> packet drops (or just invalid packets being sent out on a network
>> device).
>>
>
> True, misconfiguration is always possible and that alone is not an
> argument against the netfilter model. But what do we actually gain in
> capability from that flexibility? I agree on the UX argument (an admin
> would look in nft first), but in terms of what the feature can do, I
> can't yet see what the nft model unlocks. More on this just below.
>
>> > After looking at the available kernel mechanisms again, I think the
>> > better model is probably LWT: routes carry an ipxlat encap referencing a
>> > named translator domain configured over netlink. That should represent
>> > the stateless, prefix-based and symmetric nature of ipxlat.
>>
>> I think this description actually hits the nail on the head: What are we
>> implementing here? Is it a product feature, or a building block for one?
>> The properties you mention wrt consistency, symmetry etc are properties
>> of the high-level feature (which is also generally the level things are
>> specified in RFCs). Whereas other packet mangling features in the kernel
>> are more in the "building block" category, where it's possible to
>> configure things to implement a particular feature set / compliance with
>> a particular RFC, but it's also possible to do things that are outside
>> of that.
>>
>> I think this relates to the "mechanism, not policy" approach that we
>> take to most things in the kernel: implement the building blocks to do
>> something in the most general way we can, and then leave it up to
>> userspace to configure things in a way that results in a consistent
>> high-level system behaviour.
>>
>
> That's a good point, and I agree that we should not bake a high-level
> product policy into the kernel if what we need is a reusable mechanism
> (the LWT idea was my attempt at exactly that). What I am still trying to
> understand is whether there is a useful generic trigger for stateless
> cross-family translation beyond the route/prefix/policy-routing cases.
>
> Routes and policy routing already cover the selectors I can make
> coherent for a stateless, per-packet translator: destination/source
> prefix, iif/oif/VRF, mark, TOS/DSCP, and so on. nft can of course match
> much more than that, but the additional selectors that would materially
> change the translation decision seem to be selectors such as L4 fields,
> payload state, or conntrack state. Those are exactly the selectors I am
> struggling to make correct for a stateless translator:
>
> - non-first fragments carry no L4 header at all, yet the translator must
>   rewrite every fragment (an nft ... tcp dport trigger cannot fire on
>   them);
>
> - ICMP errors must be translated too, but the flow identity lives in the
>   quoted inner header (reversed), not in anything an L4/ct match on the
>   error packet can see and there is no conntrack to associate them,
>   since this is stateless.

True in principle, but if (say) you deploy this on a network that is
configured so it will never fragment packets, this won't be an issue in
practice.

I.e., you're quite right that arbitrary matching criteria cannot be
guaranteed to result in coherent translation. But I think that goes into
the "use it wrong, get wrong results" bin. E.g., if you match on
something that results in only a subset of the packets of a flow being
translated, well, only that subset of the packets will make it to the
destination. The SIIT translator itself should not try to fix this, but
neither should it prevent it; that's what I mean by "building block" -
it's up to the builder using the blocks to make sure the building
doesn't collapse, that's out of scope for the block manufacturer to
worry about :)

> So an L4-conditional trigger does not look like a good primitive for
> correct stateless SIIT unless the action also defragments/refragments or
> uses conntrack-like state. Those may be valid mechanisms, but they move
> the design away from the stateless per-packet SIIT boundary this RFC is
> trying to model.
>
> So my first question is: is there a useful nft configuration this should
> enable that is not naturally expressible as route selection, while still
> remaining stateless SIIT rather than a NAT64-like stateful feature?
> Maybe there is a real use case there, but I cannot construct one yet.

So the poster child for "match on arbitrary criteria" is of course BPF.
You can write BPF programs that match on arbitrary parts of the packet
header, custom encapsulation headers,or even on out of band things like
system state, phase of the moon, or what have you. And we should
certainly allow a BPF program to make the decision on whether to perform
the SIIT translation.

Which... maybe is an argument to keep it as a device like you do in this
RFC series? Redirecting to a device is trivially supported from TC-BPF,
which also makes it possible to use the translation mechanism without
going through the routing subsystem at all, saving a bit of overhead.
Whereas making it a route action ties it very closely to the routing
subsystem.

WDYT?

-Toke
