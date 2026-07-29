Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD1362138;
	Wed, 29 Jul 2026 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320625; cv=none; b=IHCEhq2wfHm/NUh7he5O4fpF488aiMnl5k0ydrgAxN0gDFR8FxTeJwD7dwIOTdIKXYHolU/TnNsAa8DuD406yDWYbs8ji1TWPSYuR45EVjdNCJfRVpq8us7Ll3W7cG5kG5+qREGz6dVTsYT1SJKv2MIpqdXKCaPTSqotNZqkK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320625; c=relaxed/simple;
	bh=l8y+XPJUC1tQOFXx40rTjlBkSjrAZHGCkyOIHlfIba0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPl9mQuSElaqzWoSQpuF6D6AFyx+5osY/wq7HnSucRVkMS2gKmnx+yP0UrnpgsmGO3McN3Om0g0zaFWRs1Mm/OLpNheQ5AE7/EgeAWY6fer+8uDWsREKu0DpMFZUIr0abjt2ihCONX+ZniUv4m8fppz46YSu13PTRQjnknsyalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=N4EK9U7O; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="N4EK9U7O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=n4EL49jAhP/fLySTuTlorUfpEehwUP34DIPAWZQYhDY=; b=N4EK9U7O+L3K3VbMTIx2GgNFvX
	w9OqPOdexhkwwU/yg9G8dF95xAYn1E1Rsa4GdZC1TVyJVhwOVDHkviYa68I9B+Oojo9ZhuK5MNRsF
	8DY+YnXHgaHBfJqyhENF0PxddJHST1NU5ptT8n6lPcmjklENrppOaBD/PpzjlnARBZ31AcwBdUj3+
	l/VKuIzXd0Kag7KLuFajV/olm1dCtCsk8s8bj4V+vUmXbikg3D7CQKlchxfE5AVh19uYQpSc39ylQ
	1wC1dHlrJ2FKFHZ9l3ab47HgjIGyVDesp1D9lhGIY34uG0uYV6NAc//ONY7/TOA3dN7QAL7CcOQeD
	IojpcX7Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp1Rl-008NoJ-2R;
	Wed, 29 Jul 2026 10:23:34 +0000
Date: Wed, 29 Jul 2026 03:23:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asantostc@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next 4/9] netconsole: move netpoll_local_ip_unset()
 as netcons_local_ip_unset()
Message-ID: <amnSAs8Ot4fR3lhc@gmail.com>
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org>
 <20260724-netconsole_move_more_final-v1-4-a5f7691db81c@debian.org>
 <CAGSyskW6iqoWk8DpLZbi=8xoME1J8LaSnjBNvAbAg6+b8kszBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGSyskW6iqoWk8DpLZbi=8xoME1J8LaSnjBNvAbAg6+b8kszBg@mail.gmail.com>
X-Debian-User: leitao

On Tue, Jul 28, 2026 at 12:49:46AM +0100, Gustavo Luiz Duarte wrote:
> On Fri, Jul 24, 2026 at 4:05 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Move netpoll_local_ip_unset() from netpoll to netconsole and rename it
> > to netcons_local_ip_unset();
> >
> > The body is otherwise unchanged, only the comment's setup-function
> > reference is updated.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 19 ++++++++++++++++++-
> >  include/linux/netpoll.h  |  1 -
> >  net/core/netpoll.c       | 18 ------------------
> >  3 files changed, 18 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 3a7a2cafc6276..70f9c5bfb3720 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -351,6 +351,23 @@ static void netconsole_skb_pool_flush(struct netconsole_target *nt)
> >         skb_queue_purge_reason(&nt->skb_pool, SKB_CONSUMED);
> >  }
> >
> > +/*
> > + * Test whether the caller left np->local_ip unset, so that
> > + * netcons_netpoll_setup() should auto-populate it from the egress device.
> > + *
> > + * np->local_ip is a union of __be32 (IPv4) and struct in6_addr (IPv6),
> > + * so an IPv6 address whose first 4 bytes are zero (e.g. ::1, ::2,
> > + * IPv4-mapped ::ffff:a.b.c.d) must not be tested via the IPv4 arm —
> > + * doing so would misclassify a caller-supplied address as unset and
> > + * silently overwrite it with whatever address the device exposes.
> > + */
> > +static bool netcons_local_ip_unset(const struct netpoll *np)
> > +{
> > +       if (np->ipv6)
> > +               return ipv6_addr_any(&np->local_ip.in6);
> > +       return !np->local_ip.ip;
> > +}
>
>
> This whole checking if it is all zeroes in netcons_local_ip_unset()
> looks very cumbersome.
> Perhaps instead of storing 'bool ipv6' we could have something like
> 'u8 family', which would contain AF_INET for ipv4, AF_INET6 for ipv6,
> or AF_UNSPEC if unset.

Agree, an explicit state machine would clarify the three cases: IPv4,
IPv6, or unspecified (with netconsole deriving it from the device).

Now that the helper lives in netconsole, the awkwardness is more visible.

> But that would be another patch separate from this refactoring, so for
> this patch:

Thanks for the review. Would you be interested in pursuing that change
once this lands?
