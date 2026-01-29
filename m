Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316B7260A
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700113; cv=none; b=FH8R7XIwzpBxckZNgg9ZBIinPZYjJoF9coUk1uobwCo1CE5gSKDGTiWF526zjnZXEHYz5bahp0avIKtA7e0zmwchOt2G+5K5jUBZhv5S2DkuKGhzeYbFs4KLobJ7eDyrHaZ/vEugsrbJi4E/bSgM5fODnU+TtrlPiUtE9TFqwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700113; c=relaxed/simple;
	bh=2dyfr25RHgijtmXjtLcthhEDdtX7s2iyUyCgDvhpbiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd6VOxEXnKlhZ8HBCZq3exv8j0s6teO1hu9okqCmOUEg3bGe7ovU84XkFe/ejdQfv8gXLUkh/3rV+BUReB2+SzYSdpR5rAxSsVMzzkoTLuKzC4FfZe46S4AbzyGg8ct+IHlSf3oJTb08Ztv0iP3txPKkx7hsjV+5JWHFUspi8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fpwYxLe0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=veAeq8tM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fpwYxLe0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="veAeq8tM"
Date: Thu, 29 Jan 2026 16:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769700110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uE9UY8Mjwbf2g6NTBUnAaAdAKXXPrGJuEnJHXTQSBBw=;
	b=fpwYxLe01CUAbO88FCu2DtZCH+iPfkyTXMEKR9MVU90j6bvk7ePmHdGjub8E5MonpYG9ah
	TcFxjLVbDg5XBtNXlDeIIYRtdpMjLXMoIDxZ83SEFO2BZw/qKzVY8a5X5CjRRq7Oi1JqCI
	+bVscEvHQ5DcIbnX0ExS7qXtucAmDhwkQV6HD+8i9H5UkrmMVzKQHgJfAZhXHShyeBMhMr
	vMkmufG2afYAR6gM1Q6qHGigDaJkioPvj8zejd6pPwx7uaH8aX9w8+I98sKndRyGwCStVW
	ZRkFbiP0iM2WN3PxNk/OZpjD3+7mCFovhDc9GS4tizQ3+HvnOQUuYOyUNTJ8xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769700110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uE9UY8Mjwbf2g6NTBUnAaAdAKXXPrGJuEnJHXTQSBBw=;
	b=veAeq8tM1qm0Y3w/LYs31lcuh+2C4q22QOqy8THxopsXFClhNKL2KKsLkz++LYOhtZD9Y1
	NS/DvEdnNceohBBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <20260129152149.dKwN1yGM@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <b54f9225ae39d0d4bd9c8c1b0b98fe47fb7211eb.1769093335.git.fmaurer@redhat.com>
 <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aXthMlr6Hpas1LBt@thinkpad>

On 2026-01-29 14:31:30 [+0100], Felix Maurer wrote:
> On Thu, Jan 29, 2026 at 12:05:00PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-22 15:56:56 [+0100], Felix Maurer wrote:
> > > diff --git a/tools/testing/selftests/net/hsr/prp_ping.sh b/tools/test=
ing/selftests/net/hsr/prp_ping.sh
> > > new file mode 100755
> > > index 000000000000..fd2ba9f05d4c
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/net/hsr/prp_ping.sh
> > =E2=80=A6
> > > +	# MAC addresses will be copied from LAN A interface
> > > +	ip -net "$node1" link set address 00:11:22:00:00:01 dev vethA
> > > +	ip -net "$node2" link set address 00:11:22:00:00:02 dev vethA
> >
> > so I somehow started this (I think) but while browsing the spec it
> > somehow says that the same MAC address should be used on both ports.
> > Could it be?
> > It says that the two frames are identical except for the LAN field and
> > checksum. Also the duplication is defined on src-MAC + seq nr.
> > Having this requires to merge the two MACs for a node and we do this but
> > could this be a left over from an older version of the spec or a
> > behaviour that was not meant happen?
>=20
> Yes, for PRP it is required that both ports, A and B, of a node send
> with the same MAC. For us that means that the two ports need to be
> configured with the same MAC address. This used to be a common source of
> configuration errors. Therefore, b65999e7238e ("net: hsr: sync hw addr
> of slave2 according to slave1 hw addr on PRP") made it so that we are
> now copying the MAC from port A to port B.
>=20
> Therefore, I'm only setting the MAC of vethA on each node in the test.
> Even this is not strictly necessary but it turns out that debugging is a
> lot simpler, when it is obvious addresses belong to which node.

Looking at the hsr tests, those have two different macs=E2=80=A6 It should =
be
the same. It works because it merges the nodes and lookup works for
both=E2=80=A6

> Thanks,
>    Felix

Sebastian
