Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793018069;
	b=caPR182O8miJj+CI4YVijlwDjMLklsGqtU91QmozDlEYSwGXQV5ZEReauQAVd1BZc7WH
	 /2jer52n8O71BbJuG4SGagRGdQyRt6bUSVyYY1bclVI5ICccy7XXCGN/3CdJ7VPNU64GH
	 AfUTdWey4mO2qsDvm5mnfPpNDoZNaNVNQupczYMFSdIP78gxXxfdfmmtscATlubTYMSLR
	 ZsrGpyXQ0n6OuvuGjkVvFvLeNblYmYWihq83IHLMamDIXWKjlnt3lOgnbrmDfXUjOidHa
	 icGG4NYy1sG34WjOS+uwHfaty8YW/GvocqOhrBja7yvKB0qvVJ9kVAoCNJBxBmkqkBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
	b=3t6l8X4ik9529YgXUpuMHPECwBqst7UDrJJpB5EUQitKVeRxV1Lbotzsn0KoKxrF2WW3
	 +ZVrumj0DM6ikZXuMamSKn0Jt7la9jKjUELCNQOMTg9CohS089vBVVpVSFnB0nqC/8B7A
	 otZ4v2evXVgBr4dcACM6J2NIQ50OUwLVuH+4ceIjZT4I5Kzd6nDhdYG5EEtqQKbY8aF6M
	 CkT0LL/dPhBfqan0VccgCC8AKDmuFNLOuCKaoZwX93tf1zcQR1IPgM2vfAtBq7E/90GNf
	 JBxtooY3wKFwjkqonlSysmqZZZ9AGxYTdwi1kEeADOJ3MBTlH/YnKQsIZQwZvlv71nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HdtFncM0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A16606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2A16606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HdtFncM0
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9d1114320so22003425ad.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018068; cv=none;
        d=google.com; s=arc-20260327;
        b=ikzpYvuKpu6AH/dFZbLmDrci1riBNll3uXdK1+etP6gdUOqQ2AgdcNRMy9B+3YMp/v
         yEZzjq8RU6NMUFG6wp1zjanJOi6rDxY7KSQVx1hlLjIpQq5pYpT518AIpOjOl/gcYQ9o
         KcH15nvd14y38p5FWmvvsDVwOXurFxpyO35Uozwj3OjjVqC+bOwV8ZxkTb0OYvb0t5kB
         /SV4hziW9fNhN59ULYkjDO4c17jRq2qW21E3u5M8hXG9f7CwvKPLGO3lquUJRH6iaO40
         GDMjL8qilJiXjEyNif9keA4YShxA/rpdTErL/3pYxo0NIFhu2R2rcRvw8h+Sq4xuOHJM
         mygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        fh=BSRHnD6dG6nvUW5N0XPnVFBjMllMooIBQPL/Jrzi+wk=;
        b=l50feZKoc6/7zhL9alyT0+PRDOzDfXbR21IhSIF0u9HsLz2e8NobzOGhZ37p9bdPpV
         I5L3Jlc1jTRMRgqTQLoPFekXID29JB+yoXAP4Cl68DcQHbX3VrIe4CuAhRH77IpS9KdA
         9nZ0MlLb4yWFpdDexBxKJq5XzbMHJFd/nOEwv5EG9ak71rfTBEPRiRnR0TMC+VF3x1op
         Q1cf2CGaDFnjr76Y/gINFSo78RFxy5Hl+0aHH2lhhZIA6P4Ien6hZeFbDCImu4lt8Y3N
         YjxCQZcprMR00GR4YUkc2gM1h1siKRMMZcOLgVYyAY1txIk7EU4+xIigerbSm8TNWQj+
         42rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018068; x=1793622868; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        b=HdtFncM04w4/76lIdgLfZLw/0vgYLnhbPuHclib1LzHCRj0B1KxFZekGEulO7gtq0i
         POQFwKjj3LXA2dcopzYhgWNgZVrCWwBJLkmFGbQaQmsO/c6Q1q4XO0ouSL8XC7x45/dG
         um54EGBS+m6o8La2GkzbOUNBl00ocendPMUC4FY8qPvHfiBE14TfsV8EHQymgVVUgUJ3
         rCQ0Q8nLVU2lfnQDMCfYtUF915/7YSDk499Rh45X2gFlBYLHwdKfTlBzUSIQrxjWe4tU
         Bnwlr+e+VjVQX273sUjj3mClGgrORgkouFyUX0sQzGugEhDMrQrX5xTow4oT9R47UA2T
         JfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018068; x=1793622868;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        b=0szlQW9lQfZwJFiHOIffoBncZVXfDVVTtFCJL0ALJlmHChacYxSSg30PGeJvYJL93T
         G8E+5HmYC2fDQa9bXR3tJ/XVEBpoc3wguYX8/cetAuk16OmpeDjR3rqDY3z1a1A0xWYP
         So2pU25LhBh3HnvVG7LQk7JT4JN7QUxZpbsKGTaHynheaUwb9wA2ncOarYKtWV1cW5Gk
         SNfFqGY0zz+QTe7jH+JZH+NPLl982otpJtaMsWZT8SwG3+d+1FWkt2RYKgeGK22tVW5b
         +ZXjwduCqyh84pnKJvNPFoFkL4004FkdDt9nAkcUMbbafHbbdVdix9urQ3k24lx89y34
         o2LQ==
X-Forwarded-Encrypted: i=1; AKwUvByTHHglQ57rPVIk9bwqxDMOI9oIed30tB4ExwJM/OUzGjyAUVu+0QCXiVKuHswuXuIz+vZ3FSo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo5S7nM9WYCpbM2acfSzYlQwNV7f0MWGifSC3WZQRhZfj2kqGG
	GDtlY10o15NYA/aDupxsxORjiJ6EJ7133wRRwzMV1OLu6/pcTMlbXoAVxBUGt+jhXF+GMPu/eVz
	AGLD+fYJSkznrxOmcDK0PmbDLulAxDE0=
X-Gm-Gg: AYBFou102tp98AAtI0D9ANJwWAcT4JO9OPIVjvGdQj74qUnkOWWqRtaIKAoMIdVsZBY
	zUjXeOPS259HKirGvM1zkezVse2N482NuL6AlHJ4dsLZqt6aFE/GNiM1mF5oaKIh+XhwMjGcB+b
	mi5CpRJ/tY3jY5dB3CawxSEsDaMBqe1xVL+vyZ3ZASaqYEQdrf+42dragAun37NWrLsPtAepGxw
	uUgFQBxw4CVfv5SqokH6XhrlwhcjEAlDSYr6MvUXGUGD8BPO/YhjoPuKWdAXfO26b9x1yBxEOdD
	UGdiRDKQtl8G/hkvY3FYcduIli8kYeecno7wKNvR+997GUVaaYms5KLMx4vwRlxiUSlPy9dZ9Ib
	9hs2FzNjZ4WBn4526/LcfkWCU815CS013fmq//J4=
X-Received: by 2002:a17:903:3ba5:b0:2ea:33eb:7375 with SMTP id
 d9443c01a7336-2ea9c7fb26fmr60059095ad.45.1793018067828; Mon, 26 Oct 2026
 05:34:27 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer>
In-Reply-To: <at82NLzM7g8HGgum@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 26 Oct 2026 14:34:15 +0200
X-Gm-Features: AclHuK86Nf4MoOy1SZ-DK_sdM59j4Q0Ek644A1GPV_2QYD872VpQvocWDHsm21I
Message-ID: <CAJ8uoz0bU0ETmEp0Nv9V4Q-H272D9dmyuK8vFj+B_un-rA4VoA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Rongzheng Wang <testwrzwrz@gmail.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 13:32, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, Oct 24, 2026 at 10:11:56PM +0800, Rongzheng Wang wrote:
> > When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> > calls skb_checksum_help() while only the first descriptor has been added to
> > the skb. The checksum therefore covers just the first fragment, and
> > skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> > fragments are never included in the checksum.
> >
> > Move the software checksum calculation to the point where the last
> > descriptor has been added to the skb.
> >
> > On a checksum failure the packet is now dropped instead of being returned
> > to the application for a retry. This path is not reachable with the
> > existing metadata validation, but the behavior change is intentional.
> >
> > Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> > ---
> >  net/xdp/xsk.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 33475b180ea6..65be2a368325 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >               skb->csum_start = hr + csum_start;
> >               skb->csum_offset = csum_offset;
> >               skb->ip_summed = CHECKSUM_PARTIAL;
> > -
> > -             if (unlikely(pool->tx_sw_csum)) {
> > -                     int err;
> > -
> > -                     err = skb_checksum_help(skb);
> > -                     if (err)
> > -                             return err;
> > -             }
> >       }
> >
> >       if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> > @@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >       return 0;
> >  }
> >
> > +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
> > +{
> > +     if (!pool->tx_sw_csum || skb->ip_summed != CHECKSUM_PARTIAL)
>
> If i am reading this right check against ip_summed is a way to tell that
> first frag had XDP_TXMD_FLAGS_CHECKSUM flag set.
>
> Agreed with Jason to preserve unlikely() when checking pool->tx_sw_csum.
>
> Regarding skb drop, I am leaning towards this, I don't see much sense in
> retry when packet is malformed? Not sure how this could be communicated up
> to user space.

Do we need a new error statistics counter, e.g. tx_malformed_packet or
tx_invalid_packet? We do have one for invalid descriptors, but that
does not really apply here.

> > +             return 0;
> > +
> > +     return skb_checksum_help(skb);
> > +}
> > +
> >  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >                                             struct xdp_desc *desc)
> >  {
> > @@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
> >               if (xp_mb_desc(&desc)) {
> >                       xs->skb = skb;
> >                       continue;
> > +             } else {
> > +                     err = xsk_skb_sw_csum(skb, xs->pool);
> > +                     if (unlikely(err)) {
> > +                             xsk_drop_skb(skb);
> > +                             goto out;
> > +                     }
> >               }
> >
> >               err = __dev_direct_xmit(skb, xs->queue_id);
> > --
> > 2.39.5 (Apple Git-154)
> >
>
