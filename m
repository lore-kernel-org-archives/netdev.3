Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF34399EA
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381986; cv=none; b=Yx+hTbcYRJPDMDRv0DAD05E0O2x/4Uco+kHIJQYgebjhXzfPegGZXjHqzvLwP2tB63DOEsFGs6IIVmu1tL+RdATTDGCQhYcbNBpRNF3F0E0M/TcyqqfFYYMUieTtHAq5QFEMobvG40buKLIHahib2XCrHbHsJFceBw1/ZsO+A2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381986; c=relaxed/simple;
	bh=juJu5FCOJxyBAlDOPkG6lD3WN0bVDtEpNswfiIj1q+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWh/QhBd/6Va10ocqUCiJVScvStCPz7jDLpvhLAfrInMR2MrhwHnAUPYw4/x6/7WUFZW3F2BB0nmsYELA0Mkj9CVuexNl18HLJcpLzyreUVBb7vYP9moj5pLAp6Zp5VTZ/H9/A1JXjJk4NaNuW35eLSuND3lfMkORdsoXqXzYlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6R/IwRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6R/IwRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC91F000FF;
	Mon, 14 Sep 2026 10:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789381984;
	bh=mhvePZJO7ayro+OPd/KJeNukWqRFoSklm+Q9YmvZPek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j6R/IwRbldc5M12Q4gR8fpqtCZ5dJ90/mTYuWHRGZrmgXsYZCIO2jbII9ZLMxosGk
	 6NyD1oQc1W1xBsmzopAeIQOeQUFYXUyX71OeEbGSLh9gPXpfgIImQ9OCNzK+fTlCmJ
	 ylVqkS9YyBZilk8nGFSLjzK7k11KhyClBVPdJaS/HNUUTtfHIRrOQYs9fiRbkgGv10
	 IRKl3dQDa5mkCzP96xSBlkwEpkjg4ybG/EEu1haIYXXC/hcO8QWTl+/EpVj9qZd6bT
	 nQZJDqUSR5KGqY6eEcTfOX7BAfW4DASgxML4WjF07sQcVxO92KuPhk3Q0X+7xup8Xm
	 8JYVxSKbDHE6g==
Date: Mon, 14 Sep 2026 11:33:00 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com,
	mitch@sfgoth.com, 3chas3@gmail.com, qingfang.deng@linux.dev
Subject: Re: [PATCH v2 net] pppoatm: ensure a writable skb header and linear
 data
Message-ID: <20260914103300.GQ48209@horms.kernel.org>
References: <20260912233048.3977192-1-edumazet@google.com>
 <178934237420.22033.12474248772012953233@kernel.org>
 <CANn89iJGzZY3HYpUjZxJFPgWOUs7RJDJnACTBwcGhjcb7AvyAQ@mail.gmail.com>
 <CANn89i+62D2BTLWHZHPzM6N8ALwr9mGoZiK0YxGXs29Mar01eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+62D2BTLWHZHPzM6N8ALwr9mGoZiK0YxGXs29Mar01eA@mail.gmail.com>

On Sun, Sep 13, 2026 at 04:58:47PM -0700, Eric Dumazet wrote:
> On Sun, Sep 13, 2026 at 4:49 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Sun, Sep 13, 2026 at 4:32 PM <netdev-bot+sashiko@kernel.org> wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue(s) to consider:
> > >
> > > Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)
> > >
> > > - [High] pppoatm_send() does not make the frame linear, although the
> > >   commit subject claims to "ensure a writable skb header and linear…
> > >
> > > Pre-existing issues:
> > > - [Low] net/atm/pppoatm.c never initialises pvcc->chan.hdrlen although
> > >   the channel requires LLC_LEN (4) bytes of headroom for e_llc…
> > >
> > > --
> > >
> > > pppoatm: ensure a writable skb header and linear data
> > >
> > > pppoatm_send() now uses skb_cow_head() to get a writable header with room
> > > for the LLC header, adds a pskb_may_pull(skb, 1) before looking at
> > > skb->data[0], and defers the SC_COMP_PROT pull plus the LLC push until
> > > after pppoatm_may_send() has succeeded, dropping the old "undo" heuristic.
> > >
> > > A couple of questions about the linearity claim and about the channel
> > > headroom hint.
> > >
> > > > diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
> > > > index 6da52d12df68e..5214786e61d11 100644
> > > > --- a/net/atm/pppoatm.c
> > > > +++ b/net/atm/pppoatm.c
> > > > @@ -292,10 +292,13 @@ static int pppoatm_send(struct ppp_channel *chan, struct sk_buff *skb)
> > > >       struct atm_vcc *vcc;
> > > >       int ret;
> > > >
> > > > +     if (!pskb_may_pull(skb, 1)) {
> > > > +             kfree_skb(skb);
> > > > +             return DROP_PACKET;
> > > > +     }
> > > > +
> > >
> > > [Severity: High]
> > > The subject says "linear data" and the changelog says this pull is there
> > > "to prevent out-of-bounds reads on zero-length or non-linear frames
> > > (e.g. from bridging)", but does this pull actually make the frame linear?
> > > pskb_may_pull(skb, 1) only guarantees the single byte read as
> > > skb->data[0]; skb_cow_head() -> __skb_cow() -> pskb_expand_head()
> > > unshares and grows the head but leaves the paged fragments in place.
> > >
> >
> >
> > Linear' as in : make sure the first byte is in skb->head, before
> > reading skb->data[0]
> 
> I guess I need to invent a new term : 1-byte-linear
> 
> Perhaps this will please/silence our AI friends.

It's the brave new world that we live in.

Reviewed-by: Simon Horman <horms@kernel.org>

