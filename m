Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FE1ACED5
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219352; cv=pass; b=F3CtUw2uJIJMX6W3mRGFHXUnqJUF/0ZHa1mAy00LsvYq6AURYoGt3K6PfU55YYOF2YegNpUHNAAD88HdUXqg35K2p93Cu1OfChA9kzZzgjID5MnNRXVN63AauVfVSlZpFCnwyDGtevbx8wY4mSdFoaR9RiBGlc94k2sMIEmS6lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219352; c=relaxed/simple;
	bh=CNQmOREMhiCV0Sgy6tQO8T/iFCgTi+A2CAHpn9XKLqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixuKZ4e3o13oTRa4lGGJeC+QiI/r5qfCt7i88Eyv9cZGIJsEGcuqCt3b/5Wl179ugYhb4U7BUpDXaGAGBP8MilaJOm9CUaKk5dbiDJph2Tb6MM5NBUVeawgS2JUdFrusI4q1QNYB9r1e9ROEAcNfFzom8wb7dxgLBkrgvsfxfe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=gDfVoG6q; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="gDfVoG6q"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-caf707e3a70so359453a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784219350; cv=none;
        d=google.com; s=arc-20260327;
        b=Lw47KXJI2rzNLrY7D3lA9LDYNwNqGRdR30B6BvKWuYSPhIPeuP7WHaRdU8HA0vZYPk
         dk3Ae+qvJuLchRWApGKuQKU2MSspaPH/B457zwrcelm+tqYeqov2TwDRg1WQ1lKxPazN
         CMdGc0P78GDWl4R0bxEXZUU4fBOOvmNMOWiiAWC1wpRIIGeg1KSIeVApRG4tFGqtSFqz
         +LBlEUSINKF4GRfJPdTT2akJKhtMuo93SKXRKb7vPjtQEsrZfO2Iso4I0DQ6Q/JZILTI
         nrS2ZJxpYuq9mBnmUHrBm8Lcr3xVLU+T2q4tl/ssHtMh6j5sBJf5iRnh6RfgKJGRzk0l
         e1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jk6XGlZ6hLQ/zIkh/aUHb8SXMrvQTVsRNpCk7cwuaxo=;
        fh=YIQrZh+laFkKiWy4yQLSlmNuUjVRHmbSjxqW4DWev4Y=;
        b=mLGNyI1MXhUovVQmlhlGuCP9ZmIjdVSaWIfS6cNhMLVE90QKbT0ieVVlGnvyUpo+MV
         7o5AV0fpYAM8pzxEfYbqZMeu0uPw3f+Q7CdHilrPcx4wXjWuzwZnppANlS+qNn31/1Tj
         QMSpmjwKXWZLsFE9rLt7QBVE9BoE2g6+vaMeFeqVBD3zxuBuOol7QS8CzgFEGwEO/aB9
         0T57v9rfqw/sLVleX0e6qa8eD3xrYodonWy4cqU2YD2OLznA97dsmUwbTJcyM5y2UZR8
         GDmw5ZTg+lr4AN1PB2ITq/jIWaBOL9vdqYIwuNYcEXrxBpkl1C2JEIh5q57/pHCUsl9K
         vj+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1784219350; x=1784824150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jk6XGlZ6hLQ/zIkh/aUHb8SXMrvQTVsRNpCk7cwuaxo=;
        b=gDfVoG6qLUllKhH9gBFsvTi7pUR8ZJhFFnOjL4FM2Ij3gEZm/5DNtFbHQwx+e9n7CA
         tmM5Jo4UzcyLaetOKb4fyaAwwgdZ2Y3CyxxKwtLd5LH1QEn5oRBHRuTl7ulhN+efs4Uf
         eFxwKrMyYhRnQwEeYkZO01kpL18v1n7kM1NUf7yr2enwys26xWtOn5t1SQLYJ24ccdsZ
         O83dgdgnq2/XVoYdLB9jFX7QBl6+NKopYTLGLFd0Mdxj6M1rAkZ0IpgM/LZqqgdwlSYJ
         x38gYHidzTd0ftPhDORktSOegUPrN8N8W8UAO4v1Q4EWZWsLark7M1dkyS1pKFAzlb4L
         Av2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784219350; x=1784824150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jk6XGlZ6hLQ/zIkh/aUHb8SXMrvQTVsRNpCk7cwuaxo=;
        b=fYVmRjAXRi2JiKflH04xIVBGL83dXLYS4830rRG52Sgh8/YVYopFB71sDnoV3w9c36
         u+Z0dWGOrjA5BKLjlAc97odT2QKi6L2OCZDmjbaMEn5oXN2RLtQWjtS2rL+45KpxNFPx
         3GaigtfDBxPUVIkC3o3u+/RWxrgL+k4v/fU9u1AUEqT9lpuZHRZpeJjORMbSSZ9dB+xc
         m4mj5K5QOwPgEG9imO4GXB1Y3zohdO8trNP4qNviPcsFOM9E7spP/4QqOtq8+TAW3qMz
         z4iR2IPV+kVTmoEkTH3XPbdjU6HdiBIa6TTcK4YH14OwtFk1DllTlqdMyQUiGO/bl8Q6
         3VxA==
X-Forwarded-Encrypted: i=1; AHgh+RpX+Cx+mW0M99p1nThiWUNdjY7ADtMaBB1GRPiXhf/8H8DEl8tWQzqDRe3eCtOIjM5sdVtU6sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwULcPfWEZRryWDtv5tIrRfjFjTLtDH89pM2W77GEWAo1k76GAz
	67S0zfDR/sUnixVMGcrqeKXEOI5aPwGblmikmT8iP8sO33A9s/sRTAQgqMrY14Aa0JpdP6tpYAM
	4eK8smDYShd/UWDP2J5lEhlz8tICnRNxLMgYiGsj77Q==
X-Gm-Gg: AfdE7ckg5lwAiz1z5jmompKqBSsqG7pLZFpPIic9pz9cKmbW9QBnUdROM+l52sPZ5An
	QvsUjbEAAIuDRJs0Mwt7RcHq7fmlRq1ozJIHdgmZFs13ACQp71fRs5pk5b5ZpOuh3YTfS0z4Hxg
	LoU6UdidWX5flizSTpOu29x7BgwNtgkkxZVrd8gYjaDMFRSFpFi5/vuGE2WrmxhddNp70tcHb4Y
	24GlEvsQ4acjRhH0zdhnqcGUxQFxH2DleBS/JaPyrrCf5f4bTlqLbjqs+t6jZsDGgA0O9inl5YN
	XP2OYDNQLsbTab69ZtA3bmIfCpjlCQyFBCwO69EQXyVUlQ4+yLZDSHAPmOk=
X-Received: by 2002:a05:6a20:d52f:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3c38dc13d10mr4210219637.35.1784219349711; Thu, 16 Jul 2026
 09:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710134242.216538-3-alice.kernel@fastmail.im> <20260716144724.333095-2-horms@kernel.org>
In-Reply-To: <20260716144724.333095-2-horms@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Thu, 16 Jul 2026 19:28:53 +0300
X-Gm-Features: AUfX_mytYKnmCvRwXYEKWKRBtmer-yKJdyBuGUIokmW2S9P1i7jH3Ar1eSFPZR8
Message-ID: <CAD0BsJVXORyveLcNxCeOcL5xQhBX0c0Tyy3q_PSmmMhi1uZ9kg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/9] net: Enable BIG TCP with partial GSO
To: Simon Horman <horms@kernel.org>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lucien.xin@gmail.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org, 
	razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com, 
	andrew+netdev@lunn.ch, fw@strlen.de, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2026 at 17:47, Simon Horman <horms@kernel.org> wrote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [2]: [PATCH net-next v9 2/9] net: Enable BIG TCP with partial G=
SO ---
> commit b8199f77774400021642eb53bd60ec1a062a54ef
> Author: Alice Mikityanska <alice@isovalent.com>
>
> net: Enable BIG TCP with partial GSO
>
> This commit removes the 65534-byte clamp on segment length in skb_segment
> for partial GSO. It stores the gso_by_frags flag early to allow BIG TCP
> packets to use larger lengths without accidental resegmentation.
>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 18dabb4e9cfa0..6ae4c2b205f2e 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
>
> [ ... ]
>
> > @@ -4852,9 +4853,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_=
skb,
> >               /* GSO partial only requires that we trim off any excess =
that
> >                * doesn't fit into an MSS sized block, so take care of t=
hat
> >                * now.
> > -              * Cap len to not accidentally hit GSO_BY_FRAGS.
> >                */
> > -             partial_segs =3D min(len, GSO_BY_FRAGS - 1) / mss;
> > +             partial_segs =3D len / mss;
>
> [Severity: High]
> When removing the clamp on partial GSO segments, mss is scaled up without=
 any
> upper bound. For BIG TCP packets, could this construct segments that exce=
ed
> MAX_SKB_FRAGS?
>
> If a 512KB packet is passed to skb_segment() for partial GSO, mss is scal=
ed
> up to the full packet length. When attempting to build this single large
> segment by flattening the frag_list into a new frags array, it appears it
> would hit the fragment limit and abort:
>
> net/core/skbuff.c:skb_segment() {
>     ...
>     if (unlikely(skb_shinfo(nskb)->nr_frags >=3D
>                  MAX_SKB_FRAGS)) {
>         net_warn_ratelimited(
>             "skb_segment: too many frags: %u %u\n",
>             pos, mss);
>         err =3D -EINVAL;
>         goto err;
>     }
>     ...
> }
>
> Does this deterministically drop BIG TCP traffic over tunnels that requir=
e
> partial GSO?

I already addressed this exact concern here:

https://lore.kernel.org/netdev/1cf2746f-f15b-406d-bb49-2c3f2dee1ec2@app.fas=
tmail.com/

Key points:

1. skb_segment can fail with "too many frags" before my changes, even
without BIG TCP. It's not a new bug that my patch adds.

2. tcp_sendmsg_locked doesn't build frag_list SKBs, and non-frag_list
SKBs never fail in skb_segment with "too many frags".

3. When sending a TCP stream, 32768-byte high order pages are
allocated, so even a 512 KB SKB can be represented without frag_list
(and if such high-order allocation fails, tcp_sendmsg_locked won't use
frag_list anyway).

4. The only scenario I can think of to get "too many frags" with
partial GSO is receiving traffic and forwarding it to a partial GSO
netdev. But again, then it easily hits "too many frags" even without
BIG TCP or my changes (see the repro by the link above).

There is definitely no "deterministic drop of BIG TCP" here, because
of #2, and the selftest shows that it works.

So, I'm open to discussion on how to make skb_segment more reliable (I
wrote one idea by the link above), but I don't think it should block
this series.

> [Severity: Medium]
> Can the partial_segs calculation exceed 65535 for malicious inputs and ca=
use
> a 16-bit truncation?
>
> If a crafted packet with a very small gso_size (for example, mss=3D1 via =
an
> untrusted packet socket) and a large payload is segmented, len / mss coul=
d
> produce a value greater than 65535.
>
> When this 32-bit value is later assigned to the 16-bit field in skb_segme=
nt():
>
> net/core/skbuff.c:skb_segment() {
>     ...
>     skb_shinfo(iter)->gso_segs =3D partial_segs;
>     ...
> }

I'll clamp partial_segs to GSO_MAX_SEGS=3D65535 to make sure that
gso_segs doesn't overflow. Worst case, in an extreme scenario of
gso_size=3D1, partial GSO will produce more than 2 output SKBs, but the
traffic should still flow =E2=80=94 this is how BIG TCP SKBs were handled b=
y
skb_segment before this change.

This overflow shouldn't be possible with TCP, because
TCP_MIN_GSO_SIZE=3D8, but AI suggests that virtio_net_hdr_to_skb can
accept any gso_size, even 1, which makes such overflow possible.

> Could this silent truncation corrupt hardware engine programming or Byte =
Queue
> Limits?
>
> >               if (partial_segs > 1)
> >                       mss *=3D partial_segs;
> >               else
>
> [ ... ]
