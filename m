Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332095;
	b=HOGa17pbNAYTkbuYsBxHT3w4LCB9j9aqk+lWg/jc7it28sZ6GXcSgKteVz4Wu6/mX9eU
	 NRoehYUjpDavr/isHvuUzYPWUn1Oe2LmtVTgP2vs6qKzIezvnBO+k4HKYYy1X5Znn+0c6
	 XeS4nRl3oQlwqqf5AIVbBFawYqr63EKgXBSIZAGoFOaXCVK+8kR+AgrDxlhS6iZErcUIM
	 9Zl46OME01amLlmFtHhCfdvt6uFxkeQIZ4vNfbf4hfuJzOvGY6xMiBmNrZw9gpQ+dGq/9
	 BKLOLHLK0Iy6lfN/JX8zyq6tene6mlc7fsnY8pkxMFQhHHiaFUMqQdHSA6MI2T0B0kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332095;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+iPcVCzOdzWYAklZOZ8EPAJj2hSwYxufYswjGVp4fuI=;
	b=B6Jt4KNlSYiQ3diDRY2Cyh845wrxM7NErsxe5OPEFkfrDsVJXbYAM2IXrnbJfbEKrDGL
	 hDiu90u7nN1muegE1aiKFhp35YVGSe3ejU1T8z1dEw18neKgFMFM8jzkz0rY9JPSAa5vb
	 7tA3C2+Dtg2953j/gzGCuDuIAg372vi3/UU3oGpLYUlAAYpcTvJ6b/TJ/d0FxEHTDyAlN
	 Qh0f72yaGX/Cd9T4I9Vr72/ha+ql8NfqAUj8fVWFcxwvRJrnuszkgBS85BqyJmi/EMzNV
	 nxxjaek1bdhaeKSREpguHnb2A4GInMfA5NmZxDo59zGXUGK9QI5EP6xS/zwgvNk4OXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiuvTI1G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129F606A334
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiuvTI1G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C751F00900
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794332094;
	bh=+iPcVCzOdzWYAklZOZ8EPAJj2hSwYxufYswjGVp4fuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eiuvTI1GjsYrSk9wGol0m1zALZuMmvyIunQpNCqiyPcShcizAmPH7zk2SzRrkODXX
	 J1qn6RlLilxkyZHoAl2m2YkWDbDcel6oSHQn8cFJ+CIfUxkfv/zhCr0K+PNijQNDpt
	 /BNOw/xuGcEE35tMKlAlwfDGk/LTJPHtJW5v3XhS1mdjGLSXFVnVhNG0yt0nGIKpFL
	 eefSlF6x6GRyvdpglTODfFVR2M49jWKkuICv3Isdgnt2DYFkZVnLzXoBac+E66ibQQ
	 lUz8Lmxz+YEFAAdXEHBH5VZtVyX+7/ph9s10ZV+2Te2gq1R733UbF9BKnolD3vvLDM
	 htLbeJOON5v6g==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8451a619da7so1429778a34.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:34:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG6M2A+uqC9lOE1Lu8gofIt7heW31ZgtlM9L+/ODU1e04NPk+SjN0Ba8xdp46UZMqMokWD8ksw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QG/FOr5i0ZViH2puJijbYQ7XS0m8ICa3sL1eLRK3OAhIYDyKm
	ZgTBlE515X4VpYc7mTepwEFqywu7RD13v8mvtVmJ4NUgG14zeyTOgRKJC8CrUMTirQiL5yEu71g
	42hTGfGTTbNdRS9qigi7wwNBeFYb/dTA=
X-Received: by 2002:a05:6808:11d0:b0:4e6:b6a1:5af2 with SMTP id
 5614622812f47-5683cd85d88mr2557697b6e.51.1794332093416; Tue, 10 Nov 2026
 09:34:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106141727.2303218-1-edumazet@kernel.org> <179432129763.994134.12930210895338778196@kernel.org>
In-Reply-To: <179432129763.994134.12930210895338778196@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 10 Nov 2026 18:34:42 +0100
X-Gmail-Original-Message-ID: <CAL4WiiosXDP59O4=DR8h4rtGX4HvbG_m5UyNfmEb2U7x+STWQw@mail.gmail.com>
X-Gm-Features: AclHuK_s0HfeDGXL8muvyQkQ0GuEMzoRMA7uNrwsPu4hkDtfrjC8DKl8lAnNSWA
Message-ID: <CAL4WiiosXDP59O4=DR8h4rtGX4HvbG_m5UyNfmEb2U7x+STWQw@mail.gmail.com>
Subject: Re: [PATCH net] udp: check frag_list IP family before using skb_segment_list()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	kylebot@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 10 nov. 2026 =C3=A0 15:34, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix in net/ipv4/udp_offload.c:__udp_gso_segment() is
>   incomplete.
> - [Low] The comment added in net/ipv4/udp_offload.c:__udp_gso_segment()
>   (lines 517-521) says the code makes sure "the frag_list skbs still=E2=
=80=A6
>
> --
>
> udp: check frag_list IP family before using skb_segment_list()
>
> This patch adds a check to __udp_gso_segment(). The fraglist fast path,
> __udp_gso_segment_list(), is now taken only when the IP version of the
> first frag_list skb matches the family being segmented. On a mismatch
> the code falls back to __skb_linearize() and skb_segment(), so that
> __udpv6_gso_segment_list_csum() does not treat an IPv4 header as a
> struct ipv6hdr.
>
> > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > index cf07c3c6611a2..802365b4780fd 100644
> > --- a/net/ipv4/udp_offload.c
> > +++ b/net/ipv4/udp_offload.c
> > @@ -514,9 +514,14 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *=
gso_skb,
> >       }
> >
> >       if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
> > -              /* Detect modified geometry and pass those to skb_segmen=
t. */
> > +             /* Detect modified geometry and pass those to skb_segment=
.
> > +              * SKB_GSO_UDP_L4 is used by both IPv4 and IPv6: also mak=
e sure
> > +              * the frag_list skbs still have the IP family we segment=
 for,
> > +              * as their network headers are not rebuilt.
> > +              */
>
> [Severity: Low]
> This isn't a bug, but the comment says the code makes sure "the frag_list
> skbs still have the IP family we segment for". The condition below only
> looks at skb_shinfo(gso_skb)->frag_list, which is the first member.
>
> The idea that every member has the same family as the first one is only
> stated in the changelog. Could the comment say that only the first
> frag_list skb is checked, and why that is enough?
>
> >               if ((skb_pagelen(gso_skb) - sizeof(*uh) =3D=3D skb_shinfo=
(gso_skb)->gso_size) &&
> > -                 !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY))
> > +                 !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY) &&
> > +                 ip_hdr(skb_shinfo(gso_skb)->frag_list)->version =3D=
=3D (is_ipv6 ? 6 : 4))
> >                       return __udp_gso_segment_list(gso_skb, features, =
is_ipv6);
>
> [Severity: High]
> Is it enough to check only the first frag_list skb here? The changelog
> says "All skbs in the list belong to the same flow, so they share the
> same IP family". On devices with hard_header_len =3D=3D 0, though, GRO se=
ems
> able to append an IPv4 skb to an IPv6 head.
>
> In gro_list_prepare(), maclen comes from skb->dev->hard_header_len. For
> tun in IFF_TUN mode and for wireguard this is 0, so the memcmp() compares
> nothing. skb->protocol is never compared:
>
> net/core/gro.c:gro_list_prepare() {
>     unsigned int maclen =3D skb->dev->hard_header_len;
>     ...
>                 else if (!diffs)
>                         diffs =3D memcmp(skb_mac_header(p),
>                                        skb_mac_header(skb),
>                                        maclen);
>     ...
> }
>
> inet_gro_receive() then checks only the version of the new skb. When p
> is an IPv6 skb, it reads p at IPv4 offsets and never checks
> iph2->version:
>
> net/ipv4/af_inet.c:inet_gro_receive() {
>     ...
>                 iph2 =3D (struct iphdr *)(p->data + off);
>     ...
>                 if ((iph->protocol ^ iph2->protocol) |
>                     ((__force u32)iph->saddr ^ (__force u32)iph2->saddr) =
|
>                     ((__force u32)iph->daddr ^ (__force u32)iph2->daddr))=
 {
>     ...
> }
>
> On an IPv6 head these bytes are saddr[1] and saddr[4..11], and the
> sender chooses them. The reverse direction is blocked, because
> ipv6_gro_receive() masks first_word with 0xF00FFFFF, and that mask
> covers the version nibble.
>
> udp_gro_receive_segment() checks ports, is_flist, ip_summed/csum_level
> and gro_receive_network_flush(). It then calls skb_gro_receive_list(p,
> skb), which does not check the family.
>
> So an IPv6 head A could end up with frag_list =3D [B (IPv6), C (IPv4)].
> The new check passes because B is version 6. skb_segment_list() keeps
> C's own 20 byte IPv4 header and only adjusts the transport header.
>
> If the head's addresses or ports were changed, for example by NAT66, tc
> pedit or BPF, the early return in __udpv6_gso_segment_list_csum() is not
> taken. The loop then treats C as IPv6:
>
> net/ipv4/udp_offload.c:__udpv6_gso_segment_list_csum() {
>     ...
>         while ((seg =3D seg->next)) {
>                 uh2 =3D udp_hdr(seg);
>                 iph2 =3D ipv6_hdr(seg);
>
>                 __udpv6_gso_segment_csum(seg, &iph2->saddr, &iph->saddr,
>                                          &uh2->source, uh->source);
>                 __udpv6_gso_segment_csum(seg, &iph2->daddr, &iph->daddr,
>                                          &uh2->dest, uh->dest);
>         }
>     ...
> }
>
> The *oldip =3D *newip stores in __udpv6_gso_segment_csum() write offsets
> 8-23 and 24-39 of C's network header. pskb_may_pull(skb,
> skb_gro_offset(skb)) only guarantees 28 bytes are linear, up to the end
> of the UDP header. That allows a write of up to 12 bytes past the linear
> part, into tailroom or skb_shared_info.
>
> With rx-gro-list enabled, a tun device in an unprivileged user namespace
> appears to be enough to reach this path. Remote peers on wireguard or
> point-to-point tunnels may also be able to send such packets.
>
> Isn't this the same write past the linear part that the patch is meant
> to fix? Would it be better to check every frag_list member here? Another
> option is to block cross-family merges in GRO, for example by checking
> p's IP version in inet_gro_receive().
>
> >
> >               ret =3D __skb_linearize(gso_skb);
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261106141727.2303218-1-edumazet%40kernel.org

The cross-family merge you describe is a GRO issue on devices with
hard_header_len =3D=3D 0 (L3 GRE, tun in IFF_TUN mode, wireguard). It is
addressed separately by:

https://lore.kernel.org/netdev/20261109164540.3104392-1-edumazet@kernel.org=
/
("net: gro: compare skb->protocol in gro_list_prepare()")

With it, a held packet and an incoming one must share skb->protocol.
ipv6_gro_receive() also compares the version nibble with the held
packet, so all frag_list members share the IP version of the first
one, which is what this patch relies on.
