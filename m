Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA69386C12
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324425; cv=none; b=arVBTFC8OwB9hOs0BoriwedfirBeesKBAN2wBFbpuJefswSXdgoMIt4w7KpS20Ds5RjWcbQGLkDlDfTO7lY5VgI5pezL3u+6zXi5SB3o5Pc/LT/MOEHRwwqh1f+xXxB+mmcu65D4wXqQcOx8Z8xi3nA3B96K9cSjbYzU25G0Q88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324425; c=relaxed/simple;
	bh=oLowqW4kTT1TNYX2A/gZw2hQoXAMth+pOFnbIsMCdaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU1POd4zZC4oGYVTUbiG3EbCfc5oO18qHndoYhqwftrSsXaAxbD2r7IRd3oZdqqNO8X1DwVKDuqc3sr/MhoyFXPMJVtq0nI4ZyeJx+nmPAAyJdZE1Lw4RZffC8D9aE/xXlWPp7EKt+BsnhEPEjJL27zkdVXSJOcWvLjXxYxvNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG54vHzI; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG54vHzI"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3a854dffb5dso509948a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324423; x=1791929223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OGTI2frF8RrBIeT4/ePn5rUSGsgZXEb1V8OC+n96/mk=;
        b=IG54vHzImmmbr4Y8m8Xp5wLUFkdbL5HQMXRvk5+2kzRzDWQ1XYvbucB8zomHoFZEyN
         2cxY0CzNuGA/CTE7qWYzflmyq43AaCW+NGmUJZEjahy8uJX4DMn8yRL02+S1WCj6I29r
         oCH0qxtCxvtbPBEGASxKTFqOnVuvtZKE060GVzbEkHeV7XMKByEcSA7yhChHP7mausVe
         mMcE9lLNvuBbc8q4bFyH9hcPnOlH3iDPtcPDk27UpjAFoGu5qhCt7bdUmkq5bW0tPUoe
         de40QR6/vQG6nelaYJ7WdooNLi+cI4AV7wpOmmvqApwCeteBDHcWTV7iX6Nydt+h4y6F
         n8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324423; x=1791929223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OGTI2frF8RrBIeT4/ePn5rUSGsgZXEb1V8OC+n96/mk=;
        b=ykzxXbff0jse8S8++vJrjdhOmFA0Ji2KqmHMxUSA4VC2OneAUewpR176sGTNU2+WCl
         u1kkqpnx8A6hHWWG1EQIgN3a52Lz+QtRJePb25YOkpEsPxoN7LjPl614NfLeJVl2zQ8V
         ZzWPjU0Bgphv3wbuhGmfTHPgqXsr5H0RUvWGOu0bKbThQwriCJOD72vYfvjdSfqerbR9
         ktSaQ90Z5RYAioW710FUhAWr6tl/QIGKokqNeMgxopjYtbQkbCmY2HwDR8npGfVV1HbI
         S7RMZeemdwXNTaNPKZN4aVoecVeu9YPvgXhOcFsmiTSn2a0A2PgKjzgI6nLwgUXEtHXV
         1UGg==
X-Gm-Message-State: AFq9FYKUwniX3Mksg6Q5WW1NeFMoRC0VAVX1e53hF2ZNKMRfBfbh1mHH
	L9DunUchRJbROm6m58D5Dp+kzYTorAPqogwyDWUo4htVaZ7ghyk6nZrc
X-Gm-Gg: AYBFou2D8L3Dz6yS4YpLZBLfNCCX22BHiel2nJyLiEjCyn+x00c9J4aPbVXF0buN9+m
	U26RMwxS/YlL1OcOffnTdkY0fba60hNjg+GfB7pQ9kHgWWu4jTMdhIPO1inBneOsWh09BFrj8Y3
	5ckFfL4Uu9wcti9CPkfIu+E4poC1itREH/tVTDXhnkX7tDKcAjq8CjLp3y0or/ZiiMmxv2u+YWD
	mxA17qr96LtiAsSSKmeMrFSVUO+H3FnBkJgCP/02pcxRG203GXpmHNuJ/lzKyade5OlOdUxgZzp
	kxqSFGnSD9VRJljdNYoDx6UMmf80LfX4TkNYAZRP8ClE83s5sTpegcf4Ni9RDa3TFhmcbGmI+MW
	uAKKtIlNIIEQYbBQW2JK2kmMf516WJ1l4BvOrgoE/4ohBGN0FEPBvdQw5Fywnw6tWLHcaHRYdum
	3c8zs7h4wxCJo9Vod7XPfg8s3enYPkKxo/P4ZYbWPItJhP/ZR3oBEXFJ/oCCmbENTh
X-Received: by 2002:a17:90b:1c0a:b0:3a0:42a9:9c75 with SMTP id 98e67ed59e1d1-3a8a1b5d361mr332289a91.43.1791324422809;
        Tue, 06 Oct 2026 15:07:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89d5ced5asm504062a91.0.2026.10.06.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:01 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:02:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Luigi Rizzo <lrizzo@google.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v1 2/2] docs: netmem: document netmem and memory
 provider design principles
Message-ID: <asVvzDm8rf5BMl3b@devvm7509.cco0.facebook.com>
References: <20261005004958.3603059-1-almasrymina@google.com>
 <20261005004958.3603059-3-almasrymina@google.com>
 <asPNJ2V8Tv2Z05n-@devvm7509.cco0.facebook.com>
 <CAHS8izOvea3eas4i09pMds2zzqbCtf8VL0Zdvo3fBT_+AM1TBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOvea3eas4i09pMds2zzqbCtf8VL0Zdvo3fBT_+AM1TBg@mail.gmail.com>

On 10/05, Mina Almasry wrote:
> On Mon, Oct 5, 2026 at 9:19 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 10/05, Mina Almasry wrote:
> > > Add a Design Principles section to Documentation/networking/netmem.rst
> > > covering the netmem_ref abstraction, the prohibition on direct
> > > downcasting in callers, decoupling memory providers from net_iov,
> > > decoupling net_iov from unreadability, delegating provider/type logic to
> > > memory_provider_ops and netmem helpers, and the homogeneous skb fragment
> > > memory type invariant.
> > >
> > > Cc: Luigi Rizzo <lrizzo@google.com>
> > > Cc: Björn Töpel <bjorn@kernel.org>
> > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > Cc: Pavel Begunkov <asml.silence@gmail.com>
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > ---
> > >  Documentation/networking/netmem.rst | 46 +++++++++++++++++++++++++++++
> > >  1 file changed, 46 insertions(+)
> > >
> > > diff --git a/Documentation/networking/netmem.rst b/Documentation/networking/netmem.rst
> > > index 217869d1108dd..57e52a947663d 100644
> > > --- a/Documentation/networking/netmem.rst
> > > +++ b/Documentation/networking/netmem.rst
> > > @@ -19,6 +19,52 @@ Benefits of Netmem :
> > >  * Simplified Development: Drivers interact with a consistent API,
> > >    regardless of the underlying memory implementation.
> > >
> > > +Design Principles
> > > +=================
> > > +
> > > +Memory providers (or the default ``page_pool`` allocator) allocate underlying
> > > +memory (``struct net_iov`` or ``struct page``), cast it to ``netmem_ref``, and
> > > +supply it to ``page_pool``. The ``page_pool``, drivers, and networking stack
> > > +operate on ``netmem_ref`` as the abstract type. Existing ``page_pool`` APIs
> > > +that allocate or free ``struct page`` are legacy compatibility wrappers for
> > > +drivers that do not yet support ``netmem_ref``. Code that is not yet
> > > +``netmem``-aware should be converted to ``netmem_ref`` unless it will never
> > > +need to support ``netmem``.
> > > +
> > > +1. **Operate on netmem_ref, do not downcast**: ``page_pool``, drivers, and the
> > > +   core networking stack should deal with ``netmem_ref`` rather than
> > > +   ``struct net_iov`` or ``struct page``. Downcasting ``netmem_ref`` to
> > > +   ``struct net_iov`` or ``struct page`` is not allowed unless a code path
> > > +   strictly cannot function without knowing the underlying memory type (for
> > > +   example, ``kmap_local_page()``). In those cases, to keep call sites simple,
> > > +   add a ``netmem`` helper that performs the operation on behalf of the caller,
> > > +   cleanly handles all ``net_iov`` and ``page`` cases, and returns an error if
> > > +   the ``netmem`` type cannot support the requested operation.
> >
> > [..]
> >
> > > +2. **Decouple memory providers from net_iov**: Memory providers are not limited
> > > +   to ``struct net_iov``. A memory provider that returns ``struct page``-backed
> > > +   ``netmem_ref``\ s to upper layers is allowed. Code must not assume that using
> > > +   a memory provider implies ``net_iov`` memory.
> > > +
> > > +3. **Decouple net_iov from unreadability**: ``struct net_iov`` is flexible and
> > > +   has no inherent restrictions. While current ``net_iov`` implementations are
> > > +   unreadable by the CPU, future readable ``net_iov`` implementations are
> > > +   allowed. Code must not assume ``net_iov`` is unreadable; check readability
> > > +   via ``netmem_address()`` or ``skb_frags_readable()`` instead.
> >
> > For these, idk, I do agree in principle, but it is not true right now? And
> > there needs to be a bunch of work to generalize?
> >
> 
> I may have misunderstood, but I think Bjorn is creating readable
> net_iovs for his work (patch 5). And I think that's great work and I
> plan to support the series. So this will become true very soon.
> 
> https://lore.kernel.org/netdev/20261002190018.696925-1-bjorn@kernel.org/
> 
> > Should we document where we are right now (mp return niov, niov == unreadable)
> > and where we wanna be (mp can return whatever, niov can imply readable or
> > unreadable). And when Bjorn's xsk work lands, he can update the mp section.
> > And sometime later maybe we'll lift niov == unreadable.
> 
> I think that's a good idea with 1 addendum. I'll say something like,
> "This is where we are right now, but new code should, as much as
> possible, update existing limitations to generalize and match the
> design principles.""I basically don't want LLMs lazily reward hacking
> and say "I'll just write code matching where we are right now and
> ignore the design principles." WDYT?

SGTM!
