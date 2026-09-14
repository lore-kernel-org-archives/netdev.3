Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A173D25AD;
	Mon, 14 Sep 2026 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385737; cv=none; b=kq5/yhWS0iva/zbr2AXf5Q02AlqRvAP73BHANMrqL7icXHBCNfHClzRBJaxaTa/aJOM9BviNp6uF1lZb0NRXKYs4VXP31v78ILL5VxYfhB10icODGaDLbWQ34HReF/IgcSNqd76JTi/8HazpxvpIDqh1qwD0AV71Stw4WdXIJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385737; c=relaxed/simple;
	bh=r2ho1BHf0pt795J8VWISmVds6s5SUqPMXVmMCr2S/r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnQR/n25bfeinYyRj5p5xp6nBQ/Mxj+1vKnuXWc+ridRRKp4C0dHoM5UzEr6WvEjYSJx7/D9CxbKmDrRxTu2rO7N5HpOPuFjiRB/JROMGDNCQ7QsRU5vo0BRNYCKVkmfFwf+oyqUJGxQSvuAghAf3We5lUJy5MssUOfdmY7NV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wWolx6Az; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wWolx6Az"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=quCwgyQJ3Y+wy/XMChHAffbSoSu3EiYKHZ4+c49SIM4=; b=wWolx6AzCTCa37S6b9H6pKmjK7
	Z/FfJJOYD9bpRbB03ZDidoVU7ZleT6Z6xnCADWHXeHQNQOEYtNWQp0wZ1jKOIdPOj4KtjLlxjrIH1
	eVYSmp01tuCUgEGo/2VSDtRJCK+Kd7tW/snXGPvyS3j2oy63/GnUbVSTtd4NWNTsnEGG0eBcRdj3T
	GZJxfIsdIUJUgPH+WlFGVJcgMgkZCB2dYoPNGqY4TiepKztu5/TNI6ACVvqcbZsLhLKRFRGD87gJh
	TICJ/O6wrG3LKgwqjUxnPbRrQvCTbraZYJqXuqvYqecH7yZCHiJJjacGRxA1zcDSSGz5kzqtEj1xJ
	F3VnL72w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x64y3-003aPU-2D;
	Mon, 14 Sep 2026 11:35:23 +0000
Date: Mon, 14 Sep 2026 04:35:18 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/2] net: add sockopt_expand_out()
Message-ID: <aqfIHVJEftl1_IZZ@gmail.com>
References: <20260910-getsockopt_phase6-v1-0-e681e102d5b8@debian.org>
 <20260910-getsockopt_phase6-v1-1-e681e102d5b8@debian.org>
 <aqQkImqiHPorszOY@devvm7509.cco0.facebook.com>
 <aqQnF9vWKVk3GkTp@gmail.com>
 <aqRvwUJ-ksUxrG-c@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqRvwUJ-ksUxrG-c@devvm7509.cco0.facebook.com>
X-Debian-User: leitao

On Fri, Sep 11, 2026 at 02:17:41PM -0700, Stanislav Fomichev wrote:
> On 09/11, Breno Leitao wrote:
> > On Fri, Sep 11, 2026 at 08:56:23AM -0700, Stanislav Fomichev wrote:
> > > On 09/10, Breno Leitao wrote:
> > > >
> > > > +	if (size <= iov_iter_count(&opt->iter_out))
> > > > +		return 0;
> > > > +
> > > > +	if (WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out)))
> > > > +		return -EINVAL;
> > > 
> > > nit: if you end up re-spinning for some reason, maybe swap these two?
> > 
> > I am not sure we want to swap these two. This is the reason:
> > 
> > 1) The first check (size <= iov_iter_count(&opt->iter_out)), check if we
> >    need the "hack" or not.
> > 
> >    a) If we don't need the tack, then we are fine and this could be called
> >       from user or kernel.
> >    
> >    b) for the hack (which happens in the next line -- iov_iter_ubuf()), it
> >       needs to be ubuf.
> > 
> > So, this force kernel callers to use the right optlen, avoiding hitting
> > the same issue as userspace.
> 
> Hmm, that feels a bit too magical :-/ Who are the kernel callers? Do we
> have any? Is it reachable via bpf or something else?

We don't have any kernel callers today, but this conversion will
enable kernel users to call it.

That said, the WARN_ON_ONCE() protects future kernel callers from
making the same mistake as userspace: not passing a large enough
optlen.

Once the whole conversion is done, BPF and io_uring will be able to
call these options.

So the WARN is an assert against a future in-kernel caller that gets
optlen wrong, not something reachable today.
