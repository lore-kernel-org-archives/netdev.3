Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396E4219F2
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925329; cv=none; b=OXi+RZ9dzotPb9GIXlX4sI+NRubYME1uEq4fZ+x+LQQj9O2Mt86+63+AsSYCclTP5CSL/kyogJBOL+uNolLAJHGev82o1OnxTQS9pRZNQ+lu5QIpCihkbUybhPFEAOt3R3c7bV1IUtVUeUxeQjQNBUKGBTKVyPCNCMecVMT985U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925329; c=relaxed/simple;
	bh=xr2kfpwn9Cebuf0mPIbDmidd7ze0BmkbrxB6d6ALjtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IooFOp1dCfBp1wBF6H3qGS2H737IeBmW/0BYbZdE/qRNeqm0F9evzT5lq4W9f4h8ti+veG1rnH1YVH7vhgDbW4oZ9hw5gAhNk039OHCeGwHS0p7x5hPWMB8DEfPyInFZWdC2nTSCctGeM7SdkQO2vMWBcG+Erw0NCDSPFQxi660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBa9VJSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBa9VJSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5CB1F00893
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790925325;
	bh=5t14N/f4KAorngihGsMpYBBFQPM1JZfe6Bu3cpc+4Zo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kBa9VJSfvFoqKplwIhTQvvoLNnQ61or1UKYSxPkCwyYGu9R0RlJcpT9fkyR3KT3qA
	 sMbAcmy81Nntr0L6d4fChNJ24USBkHQ5vupkeXEBFkP2G2JOaGR+MlcTaI2FHm+0Zl
	 MRvk46QzGe2Z0EMcrz2LQoSc1imUOuap4oNG2a+sYzQgIhCrhPOdJKcuvmK0afZ4fX
	 G6SJm5YilVPnsnVB3kiThelkyC3cd7TR7/H/LNSKdm9bXalAY3Uh+z0bpAMQeU1HWU
	 Wd/e95azCXRfZm3VKwd3tdQO3i05V4PlkDKHy3biLpr3Qhhwz5+p6AlKBDypZgzOOf
	 6MGUzWZf6Lleg==
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4f3d8882065so978103b6e.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 00:15:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzO/WfG6lJ+1rUL/7RFhp1kwIOKEwJ6xkdRzSkXPZPALjvV9c+THZsT4tDgqIWhDTwSzq+qAM0=@vger.kernel.org
X-Gm-Message-State: AFuF++k42VCdy/R1nOJLO0JW5J9f5UV7svpCocICxlGH3RYdiLdsyFKH
	G7ApmAYAPBXYQjRYdIJzoQR5TY03pkDtDZBJSsLijNEan9oSfAayfz74ixWNkkHR8JOSAovnr99
	9d9SUUiTWsZWwK9TmTuN4cWzdy5Q9KVY=
X-Received: by 2002:a05:6808:4709:b0:4d6:90f3:74a1 with SMTP id
 5614622812f47-4f52a576d1dmr1264061b6e.44.1790925324730; Fri, 02 Oct 2026
 00:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928183753.3550210-2-edumazet@kernel.org> <179092314828.434549.12977909355456421653@kernel.org>
In-Reply-To: <179092314828.434549.12977909355456421653@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 2 Oct 2026 09:15:13 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqL52kSNfZH7QVDKW4re-WyjqcPFdXjroQ6SHEbkLp_qw@mail.gmail.com>
X-Gm-Features: AclHuK918MvaDeym5uDrZy8hIY5qvA-iqlIreVMjMErtcMj2n8HlMbTW5jM3odI
Message-ID: <CAL4WiiqL52kSNfZH7QVDKW4re-WyjqcPFdXjroQ6SHEbkLp_qw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ieee802154: 6lowpan: look up the neighbour short
 address in lowpan_xmit()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	alex.aring@gmail.com, falemi@asu.edu, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 8:39=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] At this commit, lowpan_xmit() (net/ieee802154/6lowpan/tx.c:272)
>   resets skb->network_header to skb->data but leaves=E2=80=A6
>

Right, at this commit hard_header_len is still 40, so the
skb_reset_network_header() leaves the transport header probed for
AF_PACKET SOCK_RAW at the old offset. I will move the reset to patch 2,
where hard_header_len becomes 8 and the AF_PACKET offsets already match.

The Medium is the bug fixed by patch 2.

The truncated UDP header read in udp_compress() predates this series
and is also reachable from AF_INET6 raw sockets, I will send a separate fix=
.

pw-bot: cr

> Pre-existing issues:
> - [Medium] At this commit, AF_PACKET SOCK_RAW senders reach lowpan_xmit()
>   without dev_hard_header() ever being called.
>
> --
>
> ieee802154: 6lowpan: look up the neighbour short address in lowpan_xmit()
>
> This commit moves the neighbour short address lookup from
> lowpan_header_create() to lowpan_header(). The lookup then runs after the
> IPv6 header has been copied into the skb. lowpan_xmit() now pulls the IPv=
6
> header into the linear area and resets the network header to skb->data.
>
> > diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
> > index 4df76ff50699..2d83a810e610 100644
> > --- a/net/ieee802154/6lowpan/tx.c
> > +++ b/net/ieee802154/6lowpan/tx.c
>
> [ ... ]
>
> > @@ -230,6 +236,9 @@ static int lowpan_header(struct sk_buff *skb, struc=
t net_device *ldev,
> >
> >       memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
> >
> > +     if (info.daddr.mode =3D=3D IEEE802154_ADDR_LONG)
> > +             lowpan_neigh_short_addr(skb, ldev, &info.daddr);
>
> [Severity: Medium]
> This issue was not introduced by this patch, but is info.daddr.mode ever
> initialized here for AF_PACKET SOCK_RAW senders?
>
> packet_snd() and tpacket_fill_skb() only call dev_hard_header() for
> SOCK_DGRAM:
>
> net/packet/af_packet.c:packet_snd() {
>     ...
>         if (sock->type =3D=3D SOCK_DGRAM) {
>                 offset =3D dev_hard_header(skb, dev, ntohs(proto), addr, =
NULL, len);
>     ...
> }
>
> So for SOCK_RAW, lowpan_header_create() never writes the struct
> lowpan_addr_info at lowpan_skb_priv(skb). That headroom is memory from
> sock_alloc_send_pskb() that has not been zeroed.
>
> The memcpy() above copies it into info, and the new check branches on the
> uninitialized daddr.mode. As before this patch, the rest of the
> uninitialized daddr/saddr still reaches lowpan_header_compress(), the
> ackreq decision and wpan_dev_hard_header().
>
> The next patch in the series, "6lowpan: fix warning in
> lowpan_compress_addr_64()", appears to fix this. It removes
> lowpan_skb_priv() and builds daddr/saddr from the pushed pseudo header an=
d
> wpan_dev.
>
> [ ... ]
>
> > @@ -255,10 +264,12 @@ netdev_tx_t lowpan_xmit(struct sk_buff *skb, stru=
ct net_device *ldev)
> >
> >       pr_debug("package xmit\n");
> >
> > -     if (skb->protocol !=3D htons(ETH_P_IPV6)) {
> > +     if (skb->protocol !=3D htons(ETH_P_IPV6) ||
> > +         !pskb_may_pull(skb, sizeof(struct ipv6hdr))) {
> >               kfree_skb(skb);
> >               return NET_XMIT_DROP;
> >       }
> > +     skb_reset_network_header(skb);
>
> [Severity: High]
> This resets only the network header. Can skb->transport_header go stale
> for AF_PACKET SOCK_RAW senders as a result?
>
> At this commit ldev->hard_header_len is sizeof(struct ipv6hdr). For
> SOCK_RAW with len >=3D 80, packet_snd() therefore leaves the network head=
er
> at data + 40:
>
>         } else if (reserve) {
>                 skb_reserve(skb, -reserve);
>                 if (len < reserve + sizeof(struct ipv6hdr) &&
>                     dev->min_header_len !=3D hard_header_len)
>                         skb_reset_network_header(skb);
>         }
>
> packet_parse_headers()->skb_probe_transport_header() then parses bytes
> 40..79 as the IPv6 header. transport_header ends up around data + 80, or
> stays unset (0xffff) if parsing fails. tpacket_fill_skb() on the TX ring
> path also places the network header hard_header_len bytes after skb->data=
.
>
> After this reset the network header is at data + 0. If byte 6 (nexthdr) i=
s
> IPPROTO_UDP, lowpan_header_compress()->lowpan_nhc_do_compression() only
> fixes the transport header when the two offsets are equal:
>
> net/6lowpan/nhc.c:lowpan_nhc_do_compression() {
>     ...
>         if (skb->transport_header =3D=3D skb->network_header)
>                 skb_set_transport_header(skb, sizeof(struct ipv6hdr));
>     ...
> }
>
> That check no longer holds, so udp_compress() does:
>
>         const struct udphdr *uh =3D udp_hdr(skb);
>
> at the stale offset. That is bytes 80..87, or skb->head + 0xffff if the
> transport header was never set.
>
> Can this read out of bounds, and can the bytes it reads go into the
> transmitted 802.15.4 frame as the UDP ports and checksum?
>
> Only this intermediate commit seems to be affected. The next patch in the
> series, "6lowpan: fix warning in lowpan_compress_addr_64()", sets
> hard_header_len to LOWPAN_PSEUDO_HDR_LEN. It also calls __skb_pull() on t=
he
> pseudo header before skb_reset_network_header(). The reset network header
> then matches where AF_PACKET put it.
>
> Could the two changes be reordered or combined so that this commit is saf=
e
> to bisect?
>
> A separate part of this was not introduced by this patch and is still
> present at the end of the series. pskb_may_pull() only guarantees the IPv=
6
> header in the linear area (8 + 40 bytes after the next patch). If nexthdr
> is UDP and the payload is shorter than 8 bytes, can udp_compress() read u=
p
> to 8 bytes past skb->tail?
>
> >
> >       WARN_ON_ONCE(skb->len > IPV6_MIN_MTU);
> >
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260928183753.3550210-1-edumazet%40kernel.org
