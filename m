Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D0375F62
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781380727; cv=pass; b=ZVBVKj0a5J644IWhA4wAFOlAhTxbczZhxCf/Xju/4VP/6QMEC2taW5uE+2I80AQlC3FoqFhaX6AKKrYsc8ej7JENS5ODQiH+4Z2wjSZNhPkcdTs3AjExktvnQa2NAkd/Q9bG8J5sa3XWzdrxC/N40WCOyUDLZDR1n6zhp47xrFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781380727; c=relaxed/simple;
	bh=vcpUB+UXUqaVSZsYcoxe54DMhAV6MrxWp2jCTPbpzjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRqDhLnA7//dtHFfhcw6xRmamcutsalRYsieRnUwcxzg6p4Z2PIdGoyezLW4oq1im/zSS+OJaPb8xHRYeq4/sSQIBOup9rC7kzjPLCD6vNWyjkyAc4FRMQCUfm+0HCKSj0+1oZOD3XbehND+wBR32RaPYiHZe2/ISSXgVCRU9b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=eNEnGG52; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="eNEnGG52"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85a2ca7bf7so835091a12.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 12:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781380724; cv=none;
        d=google.com; s=arc-20240605;
        b=JvmUU+Anp9MAlmVT+Sy5Td6ebbs9IJejXrCh7PVhKzdg0CutAPzJqixlKIp/7uyRCk
         nZzieqBagmLxbxIxeGE9lwQKxDLFom5C4zjGAjMgW7e7MX7aISNOFz3X/RXEwDSWcBco
         MqCMj5LEBfBcPh+s1KyIXiXDTbRYfVfPdSj8GadLAMoHkYaK3GSeKwc0iL5VV6Fyn+XD
         o9Mm72I1U7cP36BbsFIBSkrWO/qhF2AFntNrBlHi+O4Wbm0dCVIKL/AT3CiQsMnbw+Ge
         DrZgQUdZsLb5XiO2LhMkg0JdMbC/R57O8eqyj4AHCovmwF7zTc/rJHFd6BANoQn7dq8f
         8nQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6JX6O4kgybRuajdLMH1asbB2r9iU+gz24puMLkaqEak=;
        fh=4wPiClYQ/UWP0YbMGGVCKYvBv55DDG77AjeCOatmeAU=;
        b=Me161IngyiDF28nxrK7AEZbNx6+m0yY0yNw5H/yr9mMjlkGmV0YWI1tKz9WklaXeU5
         z6ASw7ZTtEV/bzKhK1CDlCX+axBH+iIldctvURwjaYBWHPkp1kT4T7qzMWG2ad4gEdVP
         oEY1augXcJFslnRRE9vl4SYwKrXurpSSj6TnU5zs/E/1p/kiKkIdvAKGmE69+G1Nmryz
         wDhLJb9KU5QJ72Qzt6Dngj9Ag30iJbYQzXehRHlPXthuR5Xq1TEDUCe4I1qgAhg61Tkx
         VUD2tm9YrbOnb9XDqlAD5emBI5rhbolVkcfcyJNia4W4pcQRsG5OTmVAuTZ2fZlkZio2
         XMFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781380724; x=1781985524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JX6O4kgybRuajdLMH1asbB2r9iU+gz24puMLkaqEak=;
        b=eNEnGG52A62PUcr/nNnAqRQJJmxelKjifmO51I35H95rkAD78SPF84X4YDtQkSHjOG
         5mXXHEJET3Wk5end3PHSuPq6Tpaoj5BTipjpBkgYeoOt50qo7SNjalv6Uwn/94mMPixj
         DuqaNwoSRPXdPA42ePllU77Qw8YdF1Qork71Vd5LDT0Ov3rtkPIxdwxNnBhXMQmJHPTB
         D9J4dmldLcKgS7Xfsh4ZeHmrzB46zVE6tyS3eEpsDVYaNepbB+VW8PHrIfxah2W6ZHBv
         YZSbIgnvkOtEzR+JQuc7Q4LdIuvrbQySdjYD9WJSFsYXeidEm7MuljFGOyrZlsLA90Cv
         +01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781380724; x=1781985524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6JX6O4kgybRuajdLMH1asbB2r9iU+gz24puMLkaqEak=;
        b=nqKRbxQLe3ecRZnmq2ooFcZmCHvbFFxn2mQWWZfkOYNrMjGY3wJhKDFvT93LX/O7XE
         Md58/Z1WFSDfRZRphEdYwttTbnyEPxBmldJ28c9JjDObL8ZN2bkGdPOA6rUKqbEkXQnk
         uTazVe7k9DPQZHKpDLsmL8g7v18M8GTY2IDBevCDvL39sbBtL8t4xi5ZsOa6TbLtoa9D
         GC6xjzv6QCubfeghljdqQqr6T6IhFLBSalZk5MDaNYXZYNSsiv0Wl3Q/96HrqMDmuiIq
         /ev749Gw+OY/erPWmmZxA5/fPfE92lVXrdWat5TDwo3arJgbN6KcH8z5rQq++TQ8IKxt
         843A==
X-Forwarded-Encrypted: i=1; AFNElJ+7Dk00zJBK+DgupA1egZY8jsmXfzEUgbWh0Sl5xDVhyaxrYu6B1ZZH/86LizJOMkW3Wini4mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1eUvf36OPJYlO6W7EtW7TyegCs95+Zv+LNHVRQKklj9/BYASZ
	Tc+qoHMb/bEP0Vw57EME30eU+ZS5f23cnSViTOeyoGLXkW0SrObcOTgbEnoapdC8FOL4hNZWln/
	1Jw7ko97b2Nr1jab4BvMV+RiO8jsGp5gXTc537kIA
X-Gm-Gg: Acq92OEHbsHUT4lBKTt/1TC6BkmIVujdAbMhR2BVI36yxVwIc6NXk+DsM5F6PIQm9gS
	vvITgtEIdh/J8olSLw1M9cIzDRZVEAWQCGafiFUw+JMqI0lhjTLeV3/QtQXcRY8769LBN6Jjb+g
	/5wGgykDik76YYXl+gth+2tkOFK7ov6EhSuDHlJT7QR3ZvXPyBmU+fEETUEftnjPmsbUaDkh6RL
	hbPwJllQEcBBzNUdgdBNMTHyJo3h/tXruC9eVKyoP50U8eSzGh5DptHQpHMRhd5PpzT+sbK6sxO
	fGD+nw4pm9aVJLE86aOAKjyRAaOUM7fVkRxIrxc=
X-Received: by 2002:a05:6a21:3983:b0:3b4:e4f0:94e1 with SMTP id
 adf61e73a8af0-3b78406e4f9mr9203454637.39.1781380724410; Sat, 13 Jun 2026
 12:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610221606.1091465-1-xmei5@asu.edu> <20260611104836.469610b0@pumpkin>
In-Reply-To: <20260611104836.469610b0@pumpkin>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 13 Jun 2026 12:58:33 -0700
X-Gm-Features: AVVi8CcFpMU5NBtrCka8keKaTwzvxnEfo3CKDV-XtrGtxvmDOmvEfxSqN8pA_vc
Message-ID: <CAPpSM+TN8Av-1_JxkRqiZp-u2rjzjsU+m6dmHw7rQr3WU5+7dg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
To: David Laight <david.laight.linux@gmail.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 2:48=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 10 Jun 2026 15:16:06 -0700
> Xiang Mei <xmei5@asu.edu> wrote:
>
> > receive_big() bounds the device-announced length by
> > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> > add_recvbuf_big() sets sg[1] to start at offset
> > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> > check allows for the common hdr_len =3D=3D 12 case.
> >
> > A malicious virtio backend can announce a len in that gap.  page_to_skb=
()
> > then walks one frag past the page chain, storing a NULL page->private
> > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> > write past the static frag array and a NULL frag handed up the rx path.
> >
> > Bound len by the size add_recvbuf_big() actually advertised.
> >
> > Fixes: 0c716703965f ("virtio-net: fix received length check in big pack=
ets")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  drivers/net/virtio_net.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..afe73eda1491 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_d=
evice *dev,
> >                                  struct virtnet_rq_stats *stats)
> >  {
> >       struct page *page =3D buf;
> > +     unsigned long max_len;
> >       struct sk_buff *skb;
> >
> >       /* Make sure that len does not exceed the size allocated in
> >        * add_recvbuf_big.
> >        */
> > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
> > +     max_len =3D vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_=
hdr)) +
> > +               vi->big_packets_num_skbfrags * PAGE_SIZE;
>
> That looks like a constant (for the vi).
Thanks, agreed it's a per-device constant, so the expression never
changes after setup.

> Probably worth saving rather than recalculating all the time.
>

I thought about caching it in a vi->big_packets_max_len field computed
once after virtnet_set_big_packets(). My only concern is that the
saving is marginal here: receive_big() is only reached when
mergeable_rx_bufs is off (the "else if (vi->big_packets)" branch). Any
backend that negotiates VIRTIO_NET_F_MRG_RXBUF takes the
receive_mergeable() path for all RX, so receive_big() is never hit
there at all. And the bound has exactly one consumer.

So it's trading a 4-byte field (probably free in existing padding)
against one cache-hit load plus a shift, and two adds, on a path
that's effectively cold on modern setups. I mainly work on security
issues, so I would like to listen to your idea.


Xiang
> -- David
>
> > +     if (unlikely(len > max_len)) {
> >               pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> > -                      dev->name, len,
> > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +                      dev->name, len, max_len);
> >               goto err;
> >       }
> >
>
