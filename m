Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1DC50EBF6
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541071; cv=pass; b=pSaeNrsiXlWzc5CS+zwN+WmATVI1tu3ET3ai8xXt6D5Oo5Yb0RcoqGgL8syN+kyoy2wpAQrXOyh39mDVAiWud6EfGp9j7HpqieSsuID1BT6fkDrNIy2n5CTcimGn0y47UG/ZVM9fN21G+T3PxB0b2YIs8keAyWRqSIboKGjRr5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541071; c=relaxed/simple;
	bh=hV6kOg6zWKZP9yddTbXK3oMOzqjZ6tA2Hha56tL9piQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNcZmgCxOg72VW6IlvNRhCbdPePW1hJ82IJOPos+4DQVztM09evDbdkd8vLNz/ZxoHKVmhvO6ix/19R5t4SNrXeLMKkhliAPNPjVR2pS1WMEXK51+x7w4dkagpWHESvT4XNe/TVTShRkxQsO7Y3HvYsbuB8nE1t2yH5otcSOb50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRxEOg4D; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRxEOg4D"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a604843993so167133a12.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 09:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788541067; cv=none;
        d=google.com; s=arc-20260327;
        b=FURidxtZH+s9XTydjjuOGrePPPx8tnJF3LRxWtQqesrtApi2yPheyYNwS8cOZV4ter
         o2QD5mtckDlm72icFzBD0vhWy+tEkJzv6azBbYO3JYN5duvB0jvLPhlBr5HYvU8tU3BB
         jOSzye8rKbNwqlKV5gmt6A9WELqtoWHSR149DAJeiqOql7Dac/hMWWRjyYB8gVjXRKzL
         BZiNJpLXxsbaDKvQeaB4NwrFqlnmMaSPSGIFi2E0FNdNKqW+Jq8MIyd9vPzew6MlWt7A
         rwDiQvHBG9bAwmT3/qJlvCW9iSZ/ofAGhQZSRosWlUzOEU7zZzvGVN9XTFO7ZludoHqL
         YVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TziySW7X/IS3c2RpZSl6rmPafqI127D5Vp05uezXcE8=;
        fh=XfnLkJlapI548yAS4NmeGkzxvrPQoPqFWPaCjchjoTA=;
        b=Xgh2d3u8APjh/V/rZ/7eq4r+N+LYQJMV5/lZuY7Oiu1xA0rBXQ/0hdmg4bCyuOEyWx
         y3PPCvT9gtTEAE2Gy1lB73i8Yb39wE46zpQJtXn+ZzJhcY9ticGHAwRSumW2NzaT6jo2
         j1j8tPGYGZR+MJAKcupQskbgMzKH700fh1XmupUwP1J5h/nmYZ/OmnBlnRCKB+0rYUrV
         VjzVMBn2Ql2F8q/ouPcKPbfmrKsiyukS850sHjV1/bXsCnonLJcc8fl4FDQ8vtjrQ5H9
         0LAGAM9vsp2E7j2F2Dv2aMj9OyqykKP2pVxV9WO4n0PlZJn5ysJ5jb0MR+mS5t1mQ8mY
         nGsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788541067; x=1789145867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TziySW7X/IS3c2RpZSl6rmPafqI127D5Vp05uezXcE8=;
        b=PRxEOg4Dk2AEOabRFJTHcKSXiCZGNaV5o066hMCiiwnXEzhGpq+7sLoqwXTkEyWr3B
         Nimb4AvbH8vqJD4mhabrp9zMEV684gV9Ii7VOCD6MCzLrlQE5PIigNag5LLqGFasEUoR
         XQ9lArjmbkaKl5Smc7Oi7WQ+saNX5v9HVKO4MIwQLAvtZXabMLCfUmEnn3kNM6QRhg62
         iULRaYP/W6YaCJyp2tNu+iCX+mPhWJI6xdbDhppUWKFzm7ts0eAHdfjFwfmdyx9lkK7O
         ZPZssJvvmgiVSmdSMIduOQItuSNU2B+B2UIicm8mEnuvX7uoT/TQ1eUGaBXIRMnKmwKO
         AY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788541067; x=1789145867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TziySW7X/IS3c2RpZSl6rmPafqI127D5Vp05uezXcE8=;
        b=mTYgJfgY1klsiLLxVExAw7Ap3cvGe1OdKed7nl941R5fnUMr4VO9W2BGpQje5pASIX
         Uhp2LoW7R5f8gcYtAgZ+1/MkoJXV8w3lErrgzN97ijgvwrp+ufE7iF9ilqYnhn6QDM8q
         vTJ06RRpN4PrX4Pql68UgWg1FbGicRaZ9hbDlwib8A1BYa6K6p77Fts2pB+/wiUMMBlp
         sfNNQYOPBqOir1po3OGtmjvjwrgjmvPvRKfLLz5LOiz6RWjUEMyfQ37NWOE7TI8ORY9i
         XTEaGAzAQYXJDZazXc5dKoAd0a0cR8x1GHT760PLlTz8ZgRXpQCSCyWe1oAQrFNd+id1
         bRkw==
X-Forwarded-Encrypted: i=1; AKwUvBzySeLQBXshFbKLIuKNgZhh4yDHojH33ovHQdGFOC9Ld+pghEDsRjgpjnFa982/6JoOTHHNP2k=@vger.kernel.org
X-Gm-Message-State: AFuF++nIcP50rtfIBEiYwpijv5CS2+f4xMm45tDtRlvoaUBEKu0B7q8k
	9r+fJwL1zgfvti0LdnWJzPxwWySXlLNiL7DsoIQwD3bIQ7WfYIyR9ZCr57e+pZUD0U2JD7Z93Rx
	VbYFPBBbdIBut2CalrcIjGW4vJDfKd1M=
X-Gm-Gg: AYBFou14wSYMIRBUuCB2eojmc3b/o5+5TvPLDc22YR4laQJk3PB7X0XV6xAGTml+YCy
	i1Lb5DSAhcx9RJt+r9wCaA3muYgWFdTAKU0zyJxPUuguGd7yM7W9LudUvtLjon/sbAATuxkJs2n
	pUvz+PCSU5bjn5a4jRc4Bz1suLWt1idq/Qg2jYK39esT5qIl43CvPaITnWu1BScze7BfFDebeXH
	Ljrmq3vq9IGYJmuEkSx0iXomgxGmL5zvU8aMaDhx8QFgOvGRfovLfmP9+weRPwB5ejx2DX3lLGp
	BbHwoqdaXhWYE8Kh9luJBYPP9M54JpZUhohe4X+agvU+kZGmEzgG5DKTaDf7h5GQJ6i9KwDIkwI
	M62MxqJd9kyQ=
X-Received: by 2002:a05:6402:27cc:b0:6a6:3e9d:26c8 with SMTP id
 4fb4d7f45d1cf-6a7e90bb96fmr2542863a12.3.1788541066501; Fri, 04 Sep 2026
 09:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824111944.187200-1-nicoyip.dev@gmail.com> <20260825074142.GA1219299@shredder>
In-Reply-To: <20260825074142.GA1219299@shredder>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 5 Sep 2026 00:57:34 +0800
X-Gm-Features: AcwNN1VYA5hma0drT0n0q8WaxvJsAOmVpoAsm4u-Dfpg0eTyaeRN9kP4-mILk3I
Message-ID: <CAAo+4rU89t_LMCHbdxk=BAfOoqUMC71SbudBMpHrnB8-ZrkYiQ@mail.gmail.com>
Subject: Re: [PATCH net v3] ip_tunnel: reserve FOU/GUE headroom before encapsulation
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xin Long <lucien.xin@gmail.com>, William Tu <u9012063@gmail.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:41=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Aug 24, 2026 at 07:19:44PM +0800, Chengfeng Ye wrote:
> > ip_tunnel_encap() expects its callers to reserve headroom based on
> > ip_encap_hlen(). Unlike the IPv6 tunnel transmit paths, the IPv4
> > ip_tunnel_xmit() and ip_md_tunnel_xmit() push FOU and GUE headers
> > before they grow the skb headroom.
> >
> > That becomes visible when ipgre_changelink() publishes UDP
> > encapsulation before it updates the device headroom. The transmit path
> > does not serialize with RTNL, so it can interleave as follows:
> >
> >   CPU 0 (ipgre_changelink)        CPU 1 (ipgre_xmit)
> >   install GUE encapsulation
> >                                   reserve the old needed_headroom
> >   publish larger GRE flags
> >   update tunnel->tun_hlen
> >                                   push the larger GRE header
> >                                   push the GUE and UDP headers
> >   update dev->needed_headroom
> >
> > With REMCSUM, the new layout can push 16 bytes of GRE and 20 bytes of
> > GUE/UDP headers into an skb with only 32 bytes of actual headroom. The
> > final UDP push writes four bytes before skb->head.
> >
> > With the update window widened, the kernel reported:
> >
> >   skbuff: skb_under_panic: ... len:128 put:8 ... dev:gre0poc
> >   kernel BUG at net/core/skbuff.c:214!
> >   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> >   Call Trace:
> >    skb_push
> >    fou_build_udp
> >    gue_build_header
> >    ip_tunnel_xmit
> >    __gre_xmit
> >    ipgre_xmit
> >
> > Use ip_encap_hlen() up front, route and perform PMTU handling first,
> > then reserve the final headroom before ip_tunnel_encap() builds the
> > UDP tunnel headers. This matches the existing IPv6 pattern and keeps
> > ip_tunnel_encap() as a pure header builder.
>
> Mention in the commit message that the IPv6 fix [1] is still WIP.
> Otherwise, I'm pretty sure that Sashiko will complain about it.
>
> [1] https://lore.kernel.org/netdev/b58876297f7d45de008f2e94b6ecab8b2ed84d=
21.1786088695.git.petalzu987@gmail.com/
>
> >
> > Fixes: dd9d598c6657 ("ip_gre: add the support for i/o_flags update via =
netlink")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> > Changes in v3:
> > - Move the headroom reservation into ip_tunnel_xmit() and
> >   ip_md_tunnel_xmit() instead of growing the skb inside the FOU/GUE
> >   builders.
> > - Use ip_encap_hlen() to reserve the final caller-side headroom before
> >   ip_tunnel_encap(), matching the existing IPv6 transmit pattern.
> > - Drop the IPv4 raw-pointer refreshes that were only needed when
> >   skb_cow_head() could run inside the encapsulation builders.
> >
> > Link: https://lore.kernel.org/netdev/20260808005956.3761487-1-nicoyip.d=
ev@gmail.com/ [v2]
> > Link: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.d=
ev@gmail.com/ [v1]
> > ---
> >  net/ipv4/ip_tunnel.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > index 9d114bd575f9..5d5e7db11b3d 100644
> > --- a/net/ipv4/ip_tunnel.c
> > +++ b/net/ipv4/ip_tunnel.c
> > @@ -578,6 +578,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct =
net_device *dev,
> >       const struct iphdr *inner_iph;
> >       struct rtable *rt =3D NULL;
> >       struct flowi4 fl4;
> > +     int encap_hlen;
> >       __be16 df =3D 0;
> >       u8 tos, ttl;
> >       bool use_cache;
> > @@ -601,11 +602,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struc=
t net_device *dev,
> >                           tos & INET_DSCP_MASK, tunnel->net, 0, skb->ma=
rk,
> >                           skb_get_hash(skb), key->flow_flags);
> >
> > -     if (!tunnel_hlen)
> > -             tunnel_hlen =3D ip_encap_hlen(&tun_info->encap);
> > -
> > -     if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
> > +     encap_hlen =3D ip_encap_hlen(&tun_info->encap);
> > +     if (encap_hlen < 0)
> >               goto tx_error;
> > +     if (!tunnel_hlen)
> > +             tunnel_hlen =3D encap_hlen;
> >
> >       use_cache =3D ip_tunnel_dst_cache_usable(skb, tun_info);
> >       if (use_cache)
> > @@ -645,7 +646,8 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct =
net_device *dev,
> >                       ttl =3D ip4_dst_hoplimit(&rt->dst);
> >       }
> >
> > -     headroom +=3D LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len=
;
> > +     headroom +=3D encap_hlen + LL_RESERVED_SPACE(rt->dst.dev) +
> > +                 rt->dst.header_len;
> >       if (skb_cow_head(skb, headroom)) {
> >               ip_rt_put(rt);
> >               goto tx_dropped;
> > @@ -653,6 +655,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct=
 net_device *dev,
> >
> >       ip_tunnel_adj_headroom(dev, headroom);
> >
> > +     if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0) {
> > +             ip_rt_put(rt);
> > +             goto tx_error;
> > +     }
> > +
> >       iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, tt=
l,
> >                     df, !net_eq(tunnel->net, dev_net(dev)), 0);
> >       return;
>
> I don't think we need to change ip_md_tunnel_xmit(). It's not deriving
> the FOU/GUE encapsulation info from the device's configuration, so it's
> not exposed to the race described in the commit message. Instead, the
> encapsulation information is set by the bpf_skb_set_fou_encap() kfunc on
> the metadata dst attached to the skb.
>
> Mention this in the commit message, so that it's clear why only
> ip_tunnel_xmit() is patched.
>
> > @@ -677,6 +684,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net=
_device *dev,
> >       __be16 payload_protocol;
> >       bool use_cache =3D false;
> >       struct flowi4 fl4;
> > +     int encap_hlen;
>
> Move this further down to maintain reverse xmas tree [2].
>
> [2] https://docs.kernel.org/next/process/maintainer-netdev.html#local-var=
iable-ordering-reverse-xmas-tree-rcs
>
> >       bool md =3D false;
> >       bool connected;
> >       int err_count;
> > @@ -765,7 +773,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net=
_device *dev,
> >                           tunnel->net, READ_ONCE(tunnel->parms.link),
> >                           tunnel->fwmark, skb_get_hash(skb), 0);
> >
> > -     if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
> > +     encap_hlen =3D ip_encap_hlen(&tunnel->encap);
>
> This doesn't completely close the race. 'tunnel->encap' is still read
> twice. Here and in the call to ip_tunnel_encap() below. That's why the
> IPv6 fix takes a snapshot:
>
> ipencap =3D data_race(t->encap);
>
> And then continues to use 'ipencap' instead of 't->encap'.
>
> > +     if (encap_hlen < 0)
> >               goto tx_error;
> >
> >       if (connected && md) {
> > @@ -834,7 +843,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net=
_device *dev,
> >       }
> >
> >       max_headroom =3D LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct i=
phdr)
> > -                     + rt->dst.header_len + ip_encap_hlen(&tunnel->enc=
ap);
> > +                     + rt->dst.header_len + encap_hlen;
> >
> >       if (skb_cow_head(skb, max_headroom)) {
> >               ip_rt_put(rt);
> > @@ -845,6 +854,11 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct ne=
t_device *dev,
> >
> >       ip_tunnel_adj_headroom(dev, max_headroom);
> >
> > +     if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
> > +             ip_rt_put(rt);
> > +             goto tx_error;
> > +     }
>
> tnl_update_pmtu() is calculating the size of the inner packet:
>
> pkt_size =3D skb->len - tunnel_hlen;
>
> And 'tunnel_hlen' includes the length of the encapsulation header which
> is no longer reflected in 'skb->len'. You need to pass the length of the
> encapsulation header as an argument to tnl_update_pmtu() and do:
>
> pkt_size =3D skb->len + encap_hlen - tunnel_hlen;
>
> Pass 0 from ip_md_tunnel_xmit() as there tnl_update_pmtu() is still
> called after ip_tunnel_encap().
>
> > +
> >       iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos,=
 ttl,
> >                     df, !net_eq(tunnel->net, dev_net(dev)), 0);
> >       return;
> > --
> > 2.43.0
> >

Sorry for the late response and thanks for the detailed guide on how
to fix, a v4 patch is just sent.

Best regards,
Chengfeng
