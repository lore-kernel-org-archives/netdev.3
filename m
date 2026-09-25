Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782AF48822A;
	Fri, 25 Sep 2026 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331110; cv=none; b=JcubudcmrZ6WZJeSJipMt3goGZvzkyfQs2Syj97U4WGHmgzVeYik/cj/cIl4SAt4moCBr1Of3OBJBxTz5d4T95j9LBQl/vXQgGFZXnP3+wMV8RTJkV4BVjF1qx495Iki5UbXhUGHYPxHaCAJZW7+n2ruZtzP29E2cvP9oY+ikZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331110; c=relaxed/simple;
	bh=ZkUPvH353CDg6KGoCAXXyP9aDy1/Z8gD6ZP7KCreRFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdiyI8DyZ46K+3CL5KO9K37DQSomrZRYRUvef+AZCUH1y2phJSbUS6jay5A5KE4hu913PLdEyA0KfG9evDDty+fBhXycUGYyfwU+RC5lHy0oEYnQXxQNp4Wyr+vcaqfkNJQ/+X3rmnYNJIpL1ofDj2RETM0iGj9ACfFYddc5/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RQzmYIGU; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RQzmYIGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1790331099;
	bh=ZkUPvH353CDg6KGoCAXXyP9aDy1/Z8gD6ZP7KCreRFg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RQzmYIGUH7knqHB0yIBSwnF8gA1IgZg/lVfmxS0T7jBUAa4iGTUD4PN5JY7Z2AqDI
	 Ycrkq/z7b9amSYdEdwg/w88Cl8omGR5Vt/72MP20L8+DrDp8EHcBNSAUzhHwUctwnI
	 GqA6fjUhBIS4M9/jwRNXuB/lne/qYp7Gd8EMmo9P2re5pKKe0Zhzv6u57BCnPvpO4d
	 Nd8/vsml7K2bnRJw7nQk8fDLd+G7VrsYnXUJp3aaEPLEjJCBiZtlzXl4X7XtCkXW5r
	 842Kq1RV5rTuQPYWnu7NWKdkb9GVPo3dD64cwvoG0590A5XGGINcKXqDLJAtaOp5Ao
	 X/aV/yKk05Mvw==
Received: from squeak.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2CA9B6B8A3;
	Fri, 25 Sep 2026 18:11:38 +0800 (AWST)
Message-ID: <347e33249f14ca893a618868a61b4e8837bfba0d.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next] net: mctp: add MCTP_OPT_ROUTE_SRCADDR
 getsockopt
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Faizan Ali <faizana@nvidia.com>
Cc: Matt Johnston <matt@codeconstruct.com.au>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S .
 Miller"	 <davem@davemloft.net>, Simon Horman <horms@kernel.org>
Date: Fri, 25 Sep 2026 18:11:38 +0800
In-Reply-To: <20260923082726.2918670-1-faizana@nvidia.com>
References: 
	<e272f7d7556a59671db7e4c5503eb69efc27759c.camel@codeconstruct.com.au>
	 <20260923082726.2918670-1-faizana@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Faizan,

> > I'm not against the idea, we just need a fairly solidy justification
> > for adding user ABI that cannot be changed in future.
>=20
> In theory, yes - any incoming message destined to an active local EID
> should reach an application bound to that message type. That said, I
> still find these problems with simply picking any local EID:
>=20
> 1. It requires a snapshot of all available local EIDs first -
> =C2=A0=C2=A0 information the kernel already has internally via the routin=
g
> =C2=A0=C2=A0 table, but which applications can today only get via ad-hoc =
mctp
> =C2=A0=C2=A0 route/addr correlation.

That's mostly equivalent what you're adding here - a facility to extract
a local address from the kernel. The mctp addr command just uses a
netlink interface to do so, rather than a sockopt.

The important difference here is the addition of the routing calculation
to filter that set of addresses to a single one.

> 2. Not every local EID is reachable from every peer, even on the same
> =C2=A0=C2=A0 network. Example from our hardware:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 BMC --USB(EID 8)--> SMA(EID 20) --I3C--> GPU(EID=
 30)
> =C2=A0=C2=A0=C2=A0=C2=A0 BMC also has a separate mctpi2c0 (EID 9), unrela=
ted to the SMA.
>=20
> =C2=A0=C2=A0 Reaching the GPU is a gateway route (30 -> via 20 -> via 8),=
 which
> =C2=A0=C2=A0 mctp_route_lookup() already resolves correctly today for
> =C2=A0=C2=A0 sendmsg(). If PLDM instead picks "any" EID and gets 9, the G=
PU's
> =C2=A0=C2=A0 event notifications go out via I3C to the SMA - which has no
> =C2=A0=C2=A0 knowledge of EID 9 at all (it's on an unrelated bus). The pa=
cket is
> =C2=A0=C2=A0 undeliverable at the SMA itself, one hop before it would eve=
n reach
> =C2=A0=C2=A0 the BMC.

Is there any reason why the SMA can route to EID 8 but not 9?

> =C2=A0=C2=A0 I acknowledge this is implementation-specific, and additiona=
l
> =C2=A0=C2=A0 route provisioning on the bridge could help - but that still
> =C2=A0=C2=A0 requires out-of-band configuration to stay in sync with ever=
y
> =C2=A0=C2=A0 local EID. Separately, how device firmware handles Set Event
> =C2=A0=C2=A0 Receiver packets carrying an EID different from the one it s=
aw
> =C2=A0=C2=A0 during Set Endpoint ID discovery is also implementation-defi=
ned.

If there was any expected correlation between the Set Event Receiver and
the sender of Set Endpoint ID messages, we wouldn't need the concept of
Set Event Receiver at all.

I wouldn't think that there would be any requirement for the
current-level bus-owner to be the event receiver; it's valid for the
events to be going to any other MCTP endpoint.

> 3. A picked EID doesn't stay valid - interface teardown (hot unplug)
> =C2=A0=C2=A0 removes its local EID from the available routes, and Set Eve=
nt
> =C2=A0=C2=A0 Receiver is a one-shot registration with no way to detect th=
at
> =C2=A0=C2=A0 drift later. Further events would then be silently dropped b=
y the
> =C2=A0=C2=A0 kernel, since it has no route for the removed EID, and would=
 never
> =C2=A0=C2=A0 reach the application.

You have the same issues with this - the source EID returned by your
sockopt may become stale too. In fact, if we're interested in solving
that issue, the way to detect that would be to listen for local address
add/remove events, which would require netlink, so we may as well use
the existing netlink interface for the original query too.

The most compelling point here is (2) - if there are particular routing
requirements that would require a specific EID for Set Event Receiver.
But the only datapoint we have for that is that there is a device that -
for some reason - is making one specific assumption about the routing
topology. Can you expand on that maybe?

The other approach may be to implement something like IP_PKTINFO, where
we would have visibility on the local EID for a *received* message.
There is a bit more precedence for that design, but it may introduce an
unnecessary send/receive operation before the EID can be determined (but
it's likely we're doing initial PLDM messaging to the event source
anyway...).

Cheers,


Jeremy
