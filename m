Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F963E7BCE
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292053; cv=none; b=Q5N0ctR1zPiPSiI0x0TcyMZJxYayXULqh1W2CGjoCChXQhrKGOz+kWZJ9bBQdovPwu489yrp20IH1N5O4vxbjfgO0zUfp3M3jjsr53o/QbFgIaAQwIBhigIRgBuO5guq41Vmgq0ieUoy/w/KyzdxOStt90hFaJnbX6INmjWSgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292053; c=relaxed/simple;
	bh=VnXu5laklvONpIDmvyx+NDrgZX9TlzIFbJ44daU1aTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjZ6dAJTJWsnWyP1GLbcGwmkXC1YWolitFbT+oLKX+6RFVteMWUZQRMGFlcNVF9lPWJAt51unzGw1dKwc6oI9BgT5oLE/u0UIEiq25I2RG/i2TwvKqkA8yTcCaTKFamtNNhHbTn7IwDAaHSEPpPW8Uj++zqTeooLELaQVdTwE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyqhX68u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyqhX68u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246861F000E9;
	Fri, 17 Jul 2026 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784292052;
	bh=PcJsUYlTZPvxdXbenQwvfhTb+JKVERtYtonScuf6C14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NyqhX68uFLI4udh3Qvxnp8pjjDJT2wGwg1Sh+GJzlt1oNsFgBvfjPnNiuYGt8tsC9
	 eAquT1NhCIfq+KHqM600dauLtUeu6gdBuUGZJBmO3lCQXXwqFnv3oKN+sqN4PdU0ql
	 zkkhXpyeyVCYvcURfluK/yohNE4jGElAOOdyzSUSpsRTF1xKv/A3e8278EiAkNMhEi
	 rzELy7iOA11oa7/CpoiLI/7M4G1kL3rkMIdQ4wHnHCng0+UV8L3mUC8F5xHrJDNeWm
	 3vSewMoMCn3EKvnTLyzi2TplMzxGNYBaF1H1td2nYRquDoSSAMgn7gsH/G4NAAakzU
	 5dkKQ2Rowbq5Q==
Date: Fri, 17 Jul 2026 13:40:46 +0100
From: Simon Horman <horms@kernel.org>
To: Alice Mikityanska <alice@isovalent.com>
Cc: alice.kernel@fastmail.im, daniel@iogearbox.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	lucien.xin@gmail.com, willemdebruijn.kernel@gmail.com,
	willemb@google.com, dsahern@kernel.org, razor@blackwall.org,
	shuah@kernel.org, stfomichev@gmail.com, andrew+netdev@lunn.ch,
	fw@strlen.de, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 1/9] net: Use helpers to get/set UDP len
 tree-wide
Message-ID: <20260717124046.GO95246@horms.kernel.org>
References: <20260710134242.216538-2-alice.kernel@fastmail.im>
 <20260716144620.331419-2-horms@kernel.org>
 <CAD0BsJWRPNsQrBT06QqCtB5atqjBQz4y8QWvGg-v2WZDqRiPRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD0BsJWRPNsQrBT06QqCtB5atqjBQz4y8QWvGg-v2WZDqRiPRA@mail.gmail.com>

On Thu, Jul 16, 2026 at 06:18:59PM +0300, Alice Mikityanska wrote:
> On Thu, 16 Jul 2026 at 17:47, Simon Horman <horms@kernel.org> wrote:
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > --- Patch [1]: [PATCH net-next v9 1/9] net: Use helpers to get/set UDP len tree-wide ---
> > commit 113d28557bcedccc492f330fafdaaf1377eb2e79
> > Author: Alice Mikityanska <alice@isovalent.com>
> >
> > net: Use helpers to get/set UDP len tree-wide
> >
> > This commit introduces helpers for setting and getting the UDP header length
> > tree-wide. It prepares the codebase to support BIG TCP for UDP tunnels by
> > explicitly handling cases where UDP length might be 0 for packets larger
> > than 65535 bytes.
> >
> > > diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
> > > index 0a506c77283dd..ed4227e6db744 100644
> > > --- a/net/6lowpan/nhc_udp.c
> > > +++ b/net/6lowpan/nhc_udp.c
> > > @@ -88,16 +88,16 @@ static int udp_uncompress(struct sk_buff *skb, size_t needed)
> > >       switch (lowpan_dev(skb->dev)->lltype) {
> > >       case LOWPAN_LLTYPE_IEEE802154:
> > >               if (lowpan_802154_cb(skb)->d_size)
> > > -                     uh.len = htons(lowpan_802154_cb(skb)->d_size -
> > > -                                    sizeof(struct ipv6hdr));
> > > +                     udp_set_len_short(&uh, lowpan_802154_cb(skb)->d_size -
> > > +                                       sizeof(struct ipv6hdr));
> >
> > [Severity: High]
> > If a crafted packet specifies a datagram size smaller than
> > sizeof(struct ipv6hdr), won't this subtraction underflow?
> 
> First, I'd like to emphasize that I'm merely converting direct uh.len
> access to the new helper. If there is an existing bug with underflow,
> my new helper will expose it with a WARN, which is good. But should
> such bugs exist before this refactoring, I don't think that fixing all
> of them is in scope of this series.

Yes, point taken.

...

> > [Severity: High]
> > If gro_max_size is configured larger than 65535 (which is supported and used
> > for BIG TCP), can't UDP GRO aggregate packets such that newlen > 65535?
> 
> This is the first patch that just converted direct access to helpers.
> Patch 4 "udp: Support gro_ipv4_max_size > 65536" explicitly enables
> len > 64k and replaces this line with udp_set_len. This comment on
> patch 1 is irrelevant because it assumes that functionality added in a
> later patch should work in a prior patch.

Agreed, the AI-generated review seems wide of the mark here.

...

> > [Severity: High]
> > When transmitting a TCP BIG TCP packet (which can be > 64K) over a UDP
> > tunnel like VXLAN, skb->len will exceed 65535.
> >
> > Does using udp_set_len_short() here incorrectly trigger the warning for
> > valid large GSO payloads?
> 
> Same here. This is replaced by udp_set_len, which supports len > 64k,
> in the patch that actually enables len > 64k.
> 
> > > [ ... ]
> > > diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
> > > index 9adb5775487fa..dcff7fb16ff64 100644
> > > --- a/net/ipv6/ip6_udp_tunnel.c
> > > +++ b/net/ipv6/ip6_udp_tunnel.c
> > > @@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
> > >       uh->dest = dst_port;
> > >       uh->source = src_port;
> > >
> > > -     uh->len = htons(skb->len);
> > > +     udp_set_len_short(uh, skb->len);
> >
> > [Severity: High]
> > This appears to have the same issue as IPv4 tunnels. If a large GSO payload
> > is sent through an IPv6 UDP tunnel, won't skb->len exceed 65535 and trigger
> > the warning?
> 
> Same here.
> 
> I'm sorry, but I highly doubt that these AI review comments were validated.

Clearly my validation was insufficient.
Sorry about that.
