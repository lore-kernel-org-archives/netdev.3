Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B05452A0
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924904; cv=pass; b=ZKugScuZLO73cLe6d3Ju2bXCwEmhs9DAjIA5GHmCt7Dwt7SBpCvTuO0OiFgEsa1h1alm9vUgC4Kv2Ph5Y0HUcL9UOxsWgItgvnszs6ULEONNT9fGhADgoWixJOTFxsxuNsNHN6CxPYt0Qd7FO9aer9R8PsX08rYhx9q3TBcPTX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924904; c=relaxed/simple;
	bh=JZCuofIpeJapFWVfdF+8VkTikMT6xa5Y9R7i90xDuFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNLLvff/UueKZr+TyhCLklnG2Wa9V7TsTHQ//WAgrzLlnMaWvif1wAcipIpJ+sHjLBfjxqM7hapJL/SJprn9KjRH9PD0DRhR0J9aQA2PlAY2TZgcK+Iku8V0qNMtv2GyxESkUNA+385nZ6WcDMcU3aNrcAenO9q13FEZSZizvww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0dQtwNN; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0dQtwNN"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8aea7b7ca0cso23643107b3.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791924902; cv=none;
        d=google.com; s=arc-20260327;
        b=XUgf3G6WVPDDUXCVKrXKJPO83B06VHVTm67g1XpLaIvyZDXijxa4KBDnMgoOvrx9yp
         qNpr+iF6CtFRG1FYc9qv5I9WgnKCDHAUoiEAs3n5jrqqrM2APZj/E5nnryoIKlPTA/7j
         98JHCMj5QLkfD8HtWn5kysE/wvKbVOYUlbSfNYMi7TpnvM/caCobW5htqrrKy4WNqWeM
         r9sbRdIW8Q5GnQsy4S1+TTSoW7hVycKi3uOHCeLL0weBE/fnpZCuPin1JTOTVFCjvPS+
         NLtVae0NEpxx3HwsZvJ4sqpOBarbkQgu0VgTLS/hjDP8Y21EJAKLpuERM/vS+Ovg1dZ/
         cVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tDPPTDqcsXaSDPkJD9YhM9lPuiQdYmryZ8CiiWyAbR8=;
        fh=HxPzct++7aXUiynYwWtsVWc9Y4DMFpPNY/t6KxXE/TA=;
        b=dAB6mFtSetHpAKAdyJruFLhTd3cJbiQwENJDTIHpM0oWKTvXoLAnU3lfAi825QZi10
         AweiOxx2d1KGO+r8imSm+lE36/aV/4ZvKYmF0jdvSmBQ+Xp9SH/NkXclrEg8rB9kHYy2
         zKJ/EVaPYWt90inAihIX6bTbV6YG8K6CxxqXBPOkVGxAL4/MUxWzqw8PuQJjP81GhX1q
         atfCjB5hLrUJMx8N/p7qVEXqmsrA6FPVdnBBuHGt6ShjYQIsMuAULT+VtxOV1phpsxEZ
         IQXkto4BxLyw+B30aFT6tnTFX4dPxjHtAWA15R2vOZUAdykk2kUO18dmBczOp1PFZzxC
         phyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924902; x=1792529702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDPPTDqcsXaSDPkJD9YhM9lPuiQdYmryZ8CiiWyAbR8=;
        b=Y0dQtwNN6O98HKv1eGoR5z6xWXORtvpa6ez/LYvcvP0vuvSsPPUDiNKdYjntOM6BJC
         NGrn7kNWFi8LPZbJLE+x+PpSFzp0p7GB5O8bBdd90cEB1qBj1NQNaStw6pKqm3gM5oqr
         xE1Nh/Ql6G2CRcxOZspdghddoP3xd6LaRYN6jbsjnopPtCQ+3Vkt0TLyx/qmfHn2dlt8
         De0q7WIxQhFiYh8x6SMFTmPDFH6bdHqf9+UD4TVyWSEYwxUBFadArqu55YhSaC1I/QVw
         kI+F63k9PDcoYv/sFEcYM81vhT3tJeXWNBM5AvIYhEsxUm5WizJE8KfjnT5Z77DvZ8IZ
         Ui9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924902; x=1792529702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDPPTDqcsXaSDPkJD9YhM9lPuiQdYmryZ8CiiWyAbR8=;
        b=iVwdmeBHCvEg0iso4tEiE2u1E50b+eVkDwFpAUrWBEppm6hoc40jcqLu3UM0D342DW
         w7Li7Y1k4rjAYxx1Wlcww+/rDed77rsm4vWS2XsCkIUoeFTjR/kUTwgKDm+zoaBkFX73
         6LDRKKoZa8qfJDYBVws8VpnKJX3AIOozb6+qgZ/8X+8Qn/LTxNV65zw8GPUuhUhYBXwh
         yhIBSCTayD/bMo180vVWnKrEWiBVib8OvdRu56d9DXXw/6LW6Lh0sH4ABC0UVvb5MV8t
         m8IMYz6ttonbF60+E9LN8BaFmrqp1Opl+fKqQAf7kSDLsDcCQYeZgJsGDjWJhRWyASTw
         Le7g==
X-Forwarded-Encrypted: i=1; AKwUvBzYVPFfqW6OI25tZFv7EIbtIA1HTfEnbRjdfH0Hrz0HHRZuUc8o2eJCh+wBAA9MU3GtlGiBLsc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu+ElzTkntfnuFBwNVpMdvO1LQVtRa0ukUvdG/ZED1NdZwwr2u
	KwEKmdnbEATYNL09iq+ZpiYZfxBpZniL2AkcOpB3x/XmTnU1Hx0uj+4vg+zHxEeT5eUNOpWUym3
	S21sCro1OCF2YRU4cihNq/fdZLtFvDoE=
X-Gm-Gg: AYBFou2nP8zAQ6r96lEiy/EWfbNvv8s33LhCKYhKIPhL80NFkaXHO9Nu3ePABdsruon
	pCOnMg4+4TlnA3nd9d7TRixRGZHOf5Lb+1+cgtvEIDPx3Cf+YlAnbAIURZROLneYhsHi/MeFoN7
	GwOvsFtvrYZfHCQquG1pBHfsRLQfYBZ9JcO+/BeumQsTIwBh8D+x8dj7lpeU0FBVEkHUa5AjPKo
	sE1AUJ5Xc+uOWzAIdIqKCUgmtuX7KVqivWFepAeM/9CiIIDXQyfPIf6uFK0RSiBoLYsBpoQPJSx
	81TQKsjGM2pwZfV40brmECBB4kqmkcSaJz3m7pR+gdB0upmM4sy/XoEH94Z5N3qCekvMd2myXE+
	BBrwvqBb0bT5ZouH4q5xUzg1KSQ1buqEjf20KwVLC
X-Received: by 2002:a05:690e:bc5:b0:677:d79c:f6b7 with SMTP id
 956f58d0204a3-67935f17bf1mr3978437d50.6.1791924901762; Tue, 13 Oct 2026
 13:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791887415.git.mst@redhat.com> <CAF=yD-JhTbmYmHUkkruPcyvSWv0QhVeGWC=K=ZvvpMdkzA-jig@mail.gmail.com>
 <20261013143716-mutt-send-email-mst@kernel.org> <CAF=yD-LLNm1K5r37-y2thyvLJN58ruffUUHy-6BUh1CGVmep0Q@mail.gmail.com>
 <20261013163109-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261013163109-mutt-send-email-mst@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Oct 2026 14:54:24 -0600
X-Gm-Features: AclHuK8U1HzJlOl1AX2NjtB_mdQuaMcoNZfkwLnR19agOuqNwgvKv4h_E94K76U
Message-ID: <CAF=yD-LtGVWrGzs2shhfxzDdwfid=1=TYBcOVQ8Nt10gAHpjWQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] more virtio-net csum hardening
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, Max Krasnyansky <maxk@qualcomm.com>, 
	Paulos Yibelo <habte.yibelo@gmail.com>, Chris Arges <carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 2:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 13, 2026 at 02:29:53PM -0600, Willem de Bruijn wrote:
> > On Tue, Oct 13, 2026 at 12:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Oct 13, 2026 at 08:41:19AM -0600, Willem de Bruijn wrote:
> > > > On Tue, Oct 13, 2026 at 4:58=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > Allowing untrusted hardware to specify csum start/offset for
> > > > > CHECKSUM_PARTIAL was not a good idea, because, if it edits the pa=
cket
> > > > > outside the actual checksum, and depending on the setup, the netw=
orking
> > > > > stack could be looking at the packet both before and after the ed=
it, and
> > > > > seeing different results.
> > > > >
> > > > > Previously, commit 6785011f8b16 ("ipv4: validate checksum_start b=
efore
> > > > > completing checksum") validated all known instances where this
> > > > > causes the most grief, but the real fix is to make sure
> > > > > that either only actual checksum fields are ever edited,
> > > > > or the checksum is completed before the net stack looks at it,
> > > > > so it is always consistent.
> > > >
> > > > +1 on the general approach of performing the checksum offload at
> > > > input, unless the input can easily be validated to be one of a few
> > > > common protocols. That greatly reduces the risk vs my previous atte=
mpt
> > > > at trying to drop.
> > > >
> > > > Since we do not know the full extent of grief, I think this too sho=
uld
> > > > go to net and stable.
> > >
> > > I think it needs a bit more testing to be frank, I do not see it
> > > wait months out of the tree. So if this lands in next before the
> > > merge window, we are good I think. If we miss that I will target net.
> > >
> > >
> > > > That would mean initially a single patch that
> > > > touches as few files as possible. The helper function in
> > > > include/linux/ip.h and conversion of existing open coded parsers to
> > > > use that can follow up later in net-next.
> > >
> > > I don't see the value to be frank.
> > > What moving code between files accomplishes, I donnu.
> > > Squashing things surely makes review harder?
> > > Does your backporting system really struggle with trivial
> > > dependencies like this?
> > >
> > > I can drop patch 2 and will if I am targeting net.
> >
> > Good. This is not about "my" backporting, but upstream stable.
> > Refactor patches do not belong there.
> >
> > Since patch 3 might have to be backported in the future if a serious
> > abuse surfaces, even if you now land it in net-next, it is better to
> > not depend on other patches.
>
> Right. While this is targeting next, I will reorder it last in series so
> it's obvious for people it can be dropped.
>
> Thanks a lot for the review!

Of course. Thanks for the fixes!

I would open-code ip4_parse directly in "net: resolve uncommon partial
checksums at ingress". It's not a lot of code. Then that patch stands
on its own.

And then optionally squash patches 1 and 2 and place them at the end
of this series as one dedup patch, or send that separately later.
Personally I would drop that entirely and leave the existing code as
is. But either way.

>
> > > >
> > > > > This basically does this: checksum at ingress, except in a narrow=
 list
> > > > > of specified known good cases.
> > > > >
> > > > > Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
> > > > >
> > > > > Michael S. Tsirkin (4):
> > > > >   net: add ip4_parse()
> > > > >   net: use ip4_parse() in receive validation
> > > > >   net: resolve uncommon partial checksums at ingress
> > > > >   net: account for ingress-resolved virtio net hdr state
> > >
>
