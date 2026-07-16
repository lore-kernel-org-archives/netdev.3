Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A242D756
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215158; cv=pass; b=EZxcToAU5lsjB0/5VsSYf2jeG5gAarp1yZCDC+aRpq6qQ/WpV+QGUh53++/Se/mxgzt+slbJrFaaYEyQF2bk0A/Rm0MYhF5NV3Y8XtQqpjb48cS9DN+T7M4YcVFYRKe7qAHWrdYa7mHtMQgd2aufsSrGXs8M6jD+J1tTss3srp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215158; c=relaxed/simple;
	bh=T1AEnJuGy4nVpoZpv1xMYlVxAtlpBLoL5ZAgWCCXi+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6K8CeLuFVjW5hz7BZyJrvZCCCsr/V2c+9NNQEqpoPfI7eSm/bsHSCTyoHee69uX+CTW8+556ZpzrKOnmMm/keSC9DgRfI/evOLOOPM/oqinnm5h9YGoTGCUhhs2zJp6SlVfpTBWox7sDd3JJbXavcI688lvafgMkFznyiR6pF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=KV83OUOr; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KV83OUOr"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so2143665a12.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 08:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784215156; cv=none;
        d=google.com; s=arc-20260327;
        b=NrVKkqdDioOYmEKG571AAjKsHlI0cYEHChJCiDJ0bsTAewD3VShkYew7tpjQN358Rg
         Pd/QKzYTEAM5/2jfPcTJL96K9Tg7aTbdBSNyEU1epfYRoF8KdFp1bHiR7JYMiw+hAYii
         ABr0vkl9550lHgB8X8kOVF3coct1uizLPqB2Gi6oda+N8T7pFXMP+airrdM7VY8cpZes
         cmQrXWnqPmBSCnYykw6REGV2eC0C92PRK4IO5jdkWxHi03unzRcabTBCdtyww0BP4tr1
         r/eBFURI5dlnfJ60ZqzCKdcj2JLhLxZvWfXtk8Ip7yejLI6gOkhwYA48+7S9MaWKryYf
         FpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z5trzueYnkE4Puf7wGwqy/bs3NTjyZkVBm+zHTnyaro=;
        fh=Whn4ktXYwgbOILQq8V4dNCKplXKpzJiGW/61nNDfe/g=;
        b=QPhhSdH3X09W4N9Lre5q2PIe0aWsDbMZWxth4zZLZzhKcQgRJ4DOqfk0+kqdY7bVuA
         Cr7bbmAYU8j66azP+9b4VWweCUItzPpqqa+b/gZtej4ws/w+aNXR0qaxSJJT+Vt9tUMI
         i1l1eKOo0Zn2QSF1+Sk4KCYLVIAh2hoacHRs6a5srZjwsWbv0F32STG1eq4sWApDRRF1
         9raYWeAxu9+VBpcFtJDK0ogiV7xbYgbcSFVqhKl3PFN+3TvWI5AxEDYs3/1huaLZCXLs
         ItmrwyaWfEAE68L2OZiv5K8Xt5EUiLL6N90RXzt93cx7eAn1Xu+CM1zHUL5oWMxxmH1N
         mX+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1784215156; x=1784819956; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z5trzueYnkE4Puf7wGwqy/bs3NTjyZkVBm+zHTnyaro=;
        b=KV83OUOr6O+cXa9ij/nOp/iWRpIptd2EMYi3m3ZUkH/GBFWCaCIq+BgDxpyOXnsai5
         NOWv06iGH0ZsRiXi8/aXL4M/1eP+DAVxMM2anE6/fXRn7bEKa3QzMYCxc1vbyqwpFiCL
         Z3e4F3iKVK+pqQvzHwz5vbzhDJtCc+UhchjGjUuuhUQD72ja32bD0OT/rVyJ8gES7ttQ
         dakvp1/9A+BuAkJZP/gwX0Cxlec7uQioHu2B5IBJpOHxiSeekE5kOX5zwaZauW/as8Xz
         GdJS+u7qx+e3+kAt4pH8ORQbbnIOc+tpzuQGLHAsYyamz+8vMHdo624VhSEK7Yif4bcX
         yAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784215156; x=1784819956;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z5trzueYnkE4Puf7wGwqy/bs3NTjyZkVBm+zHTnyaro=;
        b=gJlLcS1yuwwB4MD9MYwCwwcVDVLH/isl3jQVWE5Ra1N6mHoCsGbTt32BnB97ZZX5mJ
         N7a/Z2wSEEUjMyJWVSz9GWUnGio7RRqUhTw2S0857LzLWvh4smFLO5mmbbws2FhAODUI
         3ZGjQRmE6FNZw7JnRO81lL5X7lMgHVJyI73v6OSglcAG0GegsIbnPmbOg2NB3kJOOs/h
         CiUtD7PVlEup8uHtKimxPgxm0zaZo73gl6+8GGJ+m5s1reMKuXP4jC1gOZlcG8aKeeeZ
         lBWJ9vvGwkvxd9VKobvQgs5Hd3P7gcVNNXFyU6fF0E45zhy2/rpFvAVamjuK1jv2sR1N
         uU+w==
X-Forwarded-Encrypted: i=1; AHgh+RoewLJXwTpWKmvO24ti/awiTxu2iwC+VWUmi6Hyx63VDQxTyFF+VO2NbMWkN7DlwLIPaZfVYbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9bxnqXX/dMicYLiOnQUClmyduwOqpjVdPECveF3LXwVZ9yqxL
	vZwQUDOVRg73XpkgmERb/Cei4vNGa5bsTgXCb3RHsBUV4QBHVE7GSl4T+Asqhok4TekzW0ZbLS4
	YdQlQoWZ2lHKZBGL0AnpVd0GedrhA6CJCVTR11xoIDQ==
X-Gm-Gg: AfdE7cm1av3Bgf7teR3HFcxea8K/FQcYFv9uPkMKlH9ZJS09U3tecdtgQiy2dp2ovXG
	1GBYjqNMCiQZPA9L+VBa56nm/gPu8a9F9KS9IJN/GLyXBIK5lI5S0u5tzdYXE2Ejuzxt2um+v+C
	UC/zvOrOBmufsi4m7r4V4+JNErxalUsDVXAe1S67f4PJKpBcPI0l+Cx4szjXZLMW+gX/jfYO9H5
	0R10e9PbB+/a5a6cBNfhLoQEyXNYKnbVHE7LAsk5pr1kOVk8MwTgDCKJz/GbTFXwnsBIl4EvXfM
	Ur2apv2pvp4dTkjmtXImMSpJUZuxB+dGNBcfpqaG6joMo/6z
X-Received: by 2002:a05:6a21:9cc5:b0:3c3:9fc4:3ff5 with SMTP id
 adf61e73a8af0-3c39fc44511mr735197637.29.1784215156536; Thu, 16 Jul 2026
 08:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710134242.216538-2-alice.kernel@fastmail.im> <20260716144620.331419-2-horms@kernel.org>
In-Reply-To: <20260716144620.331419-2-horms@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Thu, 16 Jul 2026 18:18:59 +0300
X-Gm-Features: AUfX_my8N2VtchOPh5twLjix919IRYgQy0eDNXkeWXIS5Wq4RGXCpTW2Feq3h9o
Message-ID: <CAD0BsJWRPNsQrBT06QqCtB5atqjBQz4y8QWvGg-v2WZDqRiPRA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/9] net: Use helpers to get/set UDP len tree-wide
To: Simon Horman <horms@kernel.org>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lucien.xin@gmail.com, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, dsahern@kernel.org, 
	razor@blackwall.org, shuah@kernel.org, stfomichev@gmail.com, 
	andrew+netdev@lunn.ch, fw@strlen.de, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 at 17:47, Simon Horman <horms@kernel.org> wrote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> --- Patch [1]: [PATCH net-next v9 1/9] net: Use helpers to get/set UDP len tree-wide ---
> commit 113d28557bcedccc492f330fafdaaf1377eb2e79
> Author: Alice Mikityanska <alice@isovalent.com>
>
> net: Use helpers to get/set UDP len tree-wide
>
> This commit introduces helpers for setting and getting the UDP header length
> tree-wide. It prepares the codebase to support BIG TCP for UDP tunnels by
> explicitly handling cases where UDP length might be 0 for packets larger
> than 65535 bytes.
>
> > diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
> > index 0a506c77283dd..ed4227e6db744 100644
> > --- a/net/6lowpan/nhc_udp.c
> > +++ b/net/6lowpan/nhc_udp.c
> > @@ -88,16 +88,16 @@ static int udp_uncompress(struct sk_buff *skb, size_t needed)
> >       switch (lowpan_dev(skb->dev)->lltype) {
> >       case LOWPAN_LLTYPE_IEEE802154:
> >               if (lowpan_802154_cb(skb)->d_size)
> > -                     uh.len = htons(lowpan_802154_cb(skb)->d_size -
> > -                                    sizeof(struct ipv6hdr));
> > +                     udp_set_len_short(&uh, lowpan_802154_cb(skb)->d_size -
> > +                                       sizeof(struct ipv6hdr));
>
> [Severity: High]
> If a crafted packet specifies a datagram size smaller than
> sizeof(struct ipv6hdr), won't this subtraction underflow?

First, I'd like to emphasize that I'm merely converting direct uh.len
access to the new helper. If there is an existing bug with underflow,
my new helper will expose it with a WARN, which is good. But should
such bugs exist before this refactoring, I don't think that fixing all
of them is in scope of this series.

Addressing the AI concern directly, my AI claims that such underflow
is not possible:

> For fragmented IEEE 802.15.4 packets:
> - d_size is decoded from the FRAG1 header in net/ieee802154/6lowpan/reassembly.c:259.
> - A FRAG1 packet with d_size < sizeof(struct ipv6hdr) is rejected at net/ieee802154/6lowpan/reassembly.c:270.
> - UDP/IPHC decompression is invoked only after that validation, at net/ieee802154/6lowpan/reassembly.c:296.
> - FRAGN packets do not invoke header decompression here; they are queued for reassembly.
> For an unfragmented packet, d_size is explicitly set to zero at net/ieee802154/6lowpan/rx.c:103, selecting the else branch and avoiding the subtraction entirely.

> The resulting massive unsigned value passed to udp_set_len_short() would
> then trigger the DEBUG_NET_WARN_ON_ONCE, potentially causing a panic if
> panic_on_warn is set.
>
> > [ ... ]
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index 29651b1a0bc70..493e2b9e16fbc 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > [ ... ]
> > @@ -915,12 +914,12 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
> >  int udp_gro_complete(struct sk_buff *skb, int nhoff,
> >                    udp_lookup_t lookup)
> >  {
> > -     __be16 newlen = htons(skb->len - nhoff);
> >       struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
> > +     unsigned int newlen = skb->len - nhoff;
> >       struct sock *sk;
> >       int err;
> >
> > -     uh->len = newlen;
> > +     udp_set_len_short(uh, newlen);
>
> [Severity: High]
> If gro_max_size is configured larger than 65535 (which is supported and used
> for BIG TCP), can't UDP GRO aggregate packets such that newlen > 65535?

This is the first patch that just converted direct access to helpers.
Patch 4 "udp: Support gro_ipv4_max_size > 65536" explicitly enables
len > 64k and replaces this line with udp_set_len. This comment on
patch 1 is irrelevant because it assumes that functionality added in a
later patch should work in a prior patch.

> This would instantly trigger the DEBUG_NET_WARN_ON_ONCE inside
> udp_set_len_short() for legitimate large packets.
>
> > [ ... ]
> > diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> > index 9ab3728f9630b..0fccb38f074d2 100644
> > --- a/net/ipv4/udp_tunnel_core.c
> > +++ b/net/ipv4/udp_tunnel_core.c
> > @@ -178,7 +178,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
> >
> >       uh->dest = dst_port;
> >       uh->source = src_port;
> > -     uh->len = htons(skb->len);
> > +     udp_set_len_short(uh, skb->len);
>
> [Severity: High]
> When transmitting a TCP BIG TCP packet (which can be > 64K) over a UDP
> tunnel like VXLAN, skb->len will exceed 65535.
>
> Does using udp_set_len_short() here incorrectly trigger the warning for
> valid large GSO payloads?

Same here. This is replaced by udp_set_len, which supports len > 64k,
in the patch that actually enables len > 64k.

> > [ ... ]
> > diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
> > index 9adb5775487fa..dcff7fb16ff64 100644
> > --- a/net/ipv6/ip6_udp_tunnel.c
> > +++ b/net/ipv6/ip6_udp_tunnel.c
> > @@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
> >       uh->dest = dst_port;
> >       uh->source = src_port;
> >
> > -     uh->len = htons(skb->len);
> > +     udp_set_len_short(uh, skb->len);
>
> [Severity: High]
> This appears to have the same issue as IPv4 tunnels. If a large GSO payload
> is sent through an IPv6 UDP tunnel, won't skb->len exceed 65535 and trigger
> the warning?

Same here.

I'm sorry, but I highly doubt that these AI review comments were validated.
