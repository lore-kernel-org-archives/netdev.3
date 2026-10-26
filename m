Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025819;
	b=R8R7rYLRPnnaXXxDqBY3vjjAZO6xp7/cpmGmUdAe9Mn9tzMPRyRtTCWldsu+b0Alir9e
	 mqy7Audqc+9aTkD/bkpNUgbieFxKGebdC3QZZecVUezl053Y/xshvve8ocAlpex6KZ/sy
	 XqSRhqiOa73dKZvXk0MDTwiFHfBpIl1tQqNuF78ewpB/JqkT3e2HHoNV3OOxsVG3BlaRu
	 etxLxsFcsT+Wwb5u058Ap/z2r29SPTlPuTJZWr0u4pzGo00viGIbjOXx3U2BspnBhLCp/
	 KatPbVL+JzglUdJV5qdw1m0w9jVf/Cx+GDKPwYFpl9y7MFFd/FzJfql0I035iKXUugw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025819;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EwbWlenn/aBmRRhJO0WkLWcDrW03s0A7cvVh5e4DKro=;
	b=DDUE1UacrDHAxlVnGiHx0W9GEmvBIfT4tNpkwdtMRmOpZZ9Er0BbwivKCwxcwCR2QVRt
	 iRe6qeC66I5+pVG+W/al1cppfrg499wqCm8/eKVp31eNMpgUtvW8ntSUZoLTS75oZvekx
	 Ouhaodp3WcD0KUImIm+fn5/pDMczYGCYkDygES7PW65VLkQ02YeWWnXsvC5RsaPm7Zqu1
	 YEE7bXOCpnPq/Mmb5ebA9n4Xhh8hwsNJ0HDBCpimyIGWOnjUvDl5a/Oqu88bUknr75f6P
	 jSWJU9IlwFQOXNStDND5Ohi/ueIt8KLG5LcBdA33g99jGSPpILyeETs5oK2xKJoX64A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejNbqxF0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E8606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejNbqxF0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7971F031E0
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793025818;
	bh=EwbWlenn/aBmRRhJO0WkLWcDrW03s0A7cvVh5e4DKro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ejNbqxF0DlBmr4DYQpdz0njI/7sqcuj20rjZz4yY7z9yPTwXv1vmYgbhppeOJ2HDA
	 U8zyhkXORZRkwcZmIi1WuoZ+LkyJy3qzZLIx+Iqd6VZjGbkAzxotYC9+uaW8vyv+3z
	 2bLFyRC5lvixFGv/cUiG3rHT4cLMXS2/mVXBpIcXXy7Q14h90W1YtVE9oHul+I0VOn
	 bauio8LgEb2lsvCpYQ0VEbWg12KVowJWlJ95kcPI2ORDUBeg7m1cdTO1/0JEPm0Mb3
	 JZ7bcsDDDJp3SwiI7Uj7nWkBb3lOylkTzmlJW8hJMU1xO0V5JOnFObJ/8VkTGOeRu/
	 Ifp+skg5prpVw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6dd059478dcso2205590eaf.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxhJuubXGi6ns4KP6JXszCquOCT9g7ySRV7TcTXVHj/pWr/h0qQ6cqEOr6dpa7Z27qTGvw1QH8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEdO3UDzkmgIrzkxybY6Gkmin3+DMn2Nl6IB9iPfuIJgta+3sf
	Tza/SdNNhZEXwigftBk+TLCCwhP82UUuKvn2Vnw0EMmNjL4HZjftxprutnc/1d799FGcG5/bVms
	ooFdSAbZ12G/tu245FZRCWZZ2GuIbPvo=
X-Received: by 2002:a05:6820:6fc3:b0:6d8:462d:2759 with SMTP id
 006d021491bc7-70ba0ff3d29mr2821350eaf.90.1793025817641; Mon, 26 Oct 2026
 07:43:37 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022111039.85112-1-edumazet@kernel.org> <179298077411.3134.13996743419397228298@kernel.org>
In-Reply-To: <179298077411.3134.13996743419397228298@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 15:43:25 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqP0Yf-zDpGBxHt9Pj3AVstmu2xdWRn7ryjNX8yyyPSzA@mail.gmail.com>
X-Gm-Features: AclHuK-If_uXECBifn-FjkzAONh23PqHLDOWKUN8GIeYA28CKgG6biIMeS2PzxA
Message-ID: <CAL4WiiqP0Yf-zDpGBxHt9Pj3AVstmu2xdWRn7ryjNX8yyyPSzA@mail.gmail.com>
Subject: Re: [PATCH net] ppp: linearize and segment bridged packets when required
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	sashiko-bot@kernel.org, qingfang.deng@linux.dev, nbd@nbd.name, 
	pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 03:12, <netdev-bot+sashiko@kernel.org> a =C3=A9=
crit :
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] ppp_bridge_gso_segment() in drivers/net/ppp/ppp_generic.c
>   calls skb_gso_segment() on PPPoE-received GSO skbs whose skb->dev is=E2=
=80=A6
> - [High] ppp: WARN_ONCE and packet drop in ppp_bridge_xmit() on negative
>   csum_start
> - [Medium] ppp_bridge_xmit() in drivers/net/ppp/ppp_generic.c finishes
>   every CHECKSUM_PARTIAL skb with skb_checksum_help(), which always=E2=80=
=A6
>
> --
>
> ppp: linearize and segment bridged packets when required
>
> This patch adds an xmit_offload flag to struct ppp_channel and sets it
> only for PPPoE. For bridged channels without the flag, the bridge now
> segments GSO packets in software and finishes CHECKSUM_PARTIAL checksums.
> Packets going to channels without direct_xmit are also linearized.
>
> > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generi=
c.c
> > index 1a610a18893ba..68e2ccfb17518 100644
> > --- a/drivers/net/ppp/ppp_generic.c
> > +++ b/drivers/net/ppp/ppp_generic.c
>
> [ ... ]
>
> > @@ -2278,6 +2279,61 @@ static bool ppp_decompress_proto(struct sk_buff =
*skb)
> >       return pskb_may_pull(skb, 2);
> >  }
> >
> > +/* Segment a GSO packet (built by PPPoE GRO, or injected with a
> > + * virtio_net_hdr) before sending it to a bridged channel that does
> > + * not accept GSO packets.
> > + * skb->data points to the PPP protocol field, which is replicated
> > + * in front of each segment.
> > + * Returns a list of segments, or NULL if the packet was dropped.
> > + */
> > +static struct sk_buff *ppp_bridge_gso_segment(struct sk_buff *skb,
> > +                                           netdev_features_t features)
> > +{
> > +     struct sk_buff *segs;
> > +
> > +     if (!pskb_may_pull(skb, PPP_PROTO_LEN))
> > +             goto drop;
> > +
> > +     switch (get_unaligned((__be16 *)skb->data)) {
> > +     case htons(PPP_IP):
> > +             skb->protocol =3D htons(ETH_P_IP);
> > +             break;
> > +     case htons(PPP_IPV6):
> > +             skb->protocol =3D htons(ETH_P_IPV6);
> > +             break;
> > +     default:
> > +             goto drop;
> > +     }
> > +     skb_set_network_header(skb, PPP_PROTO_LEN);
> > +
> > +     /* No checksum offload: skb_segment() computes the checksums. */
> > +     segs =3D skb_gso_segment(skb, features);
>
> [Severity: Critical]
>
> Can skb->dev be NULL at this point?
>
> On the PPPoE receive side, pppoe_rcv() passes the skb to
> __sk_receive_skb(), which clears the device before the backlog handler
> runs:
>
> net/core/sock.c:__sk_receive_skb() {
>     ...
>         skb->dev =3D NULL;
>     ...
> }
>
> The skb then gets here through:
>
> pppoe_rcv()->__sk_receive_skb()->sk_backlog_rcv()->pppoe_rcv_core()->
>   ppp_input()->ppp_channel_bridge_input()->ppp_bridge_gso_segment()
>
> Nothing on that path sets skb->dev again.
>
> For tunnelled GSO packets, the software GSO handlers dereference skb->dev
> with no NULL check. For IP-in-IP, ipip_gso_segment() calls the inner
> inet_gso_segment(), which does:
>
> net/ipv4/af_inet.c:inet_gso_segment() {
>     ...
>         if (encap)
>                 features &=3D skb->dev->hw_enc_features;
>     ...
> }
>
> gre_gso_segment(), __skb_udp_tunnel_segment() and ipv6_gso_segment()
> dereference skb->dev the same way.
>
> Remote traffic can build such skbs. pppoe_gro_receive() hands off to
> inet_gro_receive(), which can stack ipip_gro_receive() without any local
> tunnel device. ipip_gro_complete() then sets:
>
>         skb->encapsulation =3D 1;
>         skb_shinfo(skb)->gso_type |=3D SKB_GSO_IPXIP4;
>
> Before this patch, bridged GSO skbs went unchanged to start_xmit(). Only
> PPPoE segmented them, and it sets skb->dev before dev_queue_xmit().
>
> Take a LAC that bridges PPPoE to L2TP or PPTP with PPPIOCBRIDGECHAN.
> Could a remote PPPoE peer that sends GRO-merged IPIP-encapsulated TCP
> cause a NULL pointer dereference in softirq here, with pchb->downl held?
>
> Should this path either set skb->dev or reject skbs with
> skb->encapsulation or tunnel gso_type bits before calling
> skb_gso_segment()?

Right, skb->dev is NULL here. IPv6 UFO has the same issue
(udp6_ufo_fragment() uses dev_net(skb->dev)).

There is no device to use at this point, so v2 drops encapsulated
skbs, and only segments TCP, UDP_L4 and fraglist GSO types.

>
> > +     if (IS_ERR_OR_NULL(segs))
> > +             goto drop;
> > +
> > +     consume_skb(skb);
> > +     return segs;
> > +
> > +drop:
> > +     kfree_skb(skb);
> > +     return NULL;
> > +}
> > +
> > +static void ppp_bridge_xmit(struct ppp_channel *chan, struct sk_buff *=
skb)
> > +{
> > +     if (!chan->direct_xmit && skb_linearize(skb))
> > +             goto drop;
> > +
> > +     if (!chan->xmit_offload && skb->ip_summed =3D=3D CHECKSUM_PARTIAL=
 &&
> > +         skb_checksum_help(skb))
> > +             goto drop;
>
> [Severity: High]
> Can skb->ip_summed still be CHECKSUM_PARTIAL here while csum_start
> points before skb->data?
>
> Consider PPPoL2TP over UDP as the bridge source. Suppose the L2TP packet
> was generated locally and is received over veth, loopback or virtio-net
> with UDP checksum offload. It then arrives in udp_rcv() or udpv6_rcv()
> as CHECKSUM_PARTIAL, with csum_start at the outer UDP header.
> udp4_csum_init() and udp6_csum_init() see skb_csum_unnecessary() and
> leave ip_summed unchanged.
>
> The skb then gets here through:
>
> udp_queue_rcv_one_skb()->l2tp_udp_encap_recv()->l2tp_recv_common()->
>   pppol2tp_recv()->ppp_input()->ppp_channel_bridge_input()->
>   ppp_bridge_xmit()
>
> l2tp_udp_encap_recv() and l2tp_recv_common() strip the UDP and L2TP
> headers with __skb_pull(). pppol2tp_recv() strips the address and
> control bytes with skb_pull(). None of these update the checksum state,
> so skb_checksum_start_offset(skb) is negative by the time we get here.
>
> The non-bridged path handles this case in ppp_receive_nonmp_frame()
> through skb_pull_rcsum(). Its skb_postpull_rcsum() turns
> CHECKSUM_PARTIAL into CHECKSUM_NONE when the start offset goes
> negative. The bridge path never reaches that code.
>
> For a destination channel without xmit_offload, skb_checksum_help()
> then does:
>
> net/core/dev.c:skb_checksum_help() {
>     ...
>         offset =3D skb_checksum_start_offset(skb);
>         ret =3D -EINVAL;
>         if (unlikely(offset >=3D skb_headlen(skb))) {
>                 DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
>                 WARN_ONCE(true, "offset (%d) >=3D skb_headlen() (%u)\n",
>                           offset, skb_headlen(skb));
>                 goto out;
>         }
>     ...
> }
>
> The negative int offset is converted to unsigned int in the comparison.
> That fires the WARN_ONCE() and skb_dump(), and every such packet is
> dropped. With panic_on_warn this is a panic.
>
> Before this patch the skb went to start_xmit() unchanged. So bridging
> L2TP to PPP Async, Sync, PPTP or L2TP looks like a new regression
> here.
>
> PPPoE as the destination sets xmit_offload and skips this check, but
> the stale state remains. pppoe_xmit() then pushes the PPPoE and
> Ethernet headers, which can bring the start offset back to zero or
> above. Could the output device then write a checksum into the wrong
> bytes of the frame?
>
> Should ppp_channel_bridge_input() drop the stale state before the GSO
> and ppp_bridge_xmit() paths? It could reset ip_summed to CHECKSUM_NONE
> when skb_checksum_start_offset(skb) < 0, as skb_postpull_rcsum() does.

Yes, v2 does this right after skb_scrub_packet(), which also covers
the PPPoE destination case.

> Or should the L2TP receive path use the _rcsum pull helpers instead?
>
> [Severity: Medium]
>
> Are SCTP CRC32c requests handled correctly here?
>
> skb_checksum_help() always writes a 16-bit Internet checksum and then set=
s
> CHECKSUM_NONE. It does not check skb->csum_not_inet. The core dispatcher
> handles that case separately:
>
> net/core/dev.c:skb_csum_hwoffload_help() {
>     ...
>         if (unlikely(skb_csum_is_sctp(skb)))
>                 return !!(features & NETIF_F_SCTP_CRC) ? 0 :
>                         skb_crc32c_csum_help(skb);
>     ...
> }
>
> sctp_packet_pack() sets CHECKSUM_PARTIAL with csum_not_inet =3D 1 when th=
e
> route device has NETIF_F_SCTP_CRC, as veth does. Such a packet can be
> wrapped in PPPoE, for example with bpf_skb_change_head() in a tc program,
> which keeps ip_summed and csum_start. If PPPoE then receives it on the
> peer, neither PPPoE receive nor skb_scrub_packet() clears that state.
>
> If the packet is bridged to a channel without xmit_offload, a 16-bit
> Internet checksum is written into the 32-bit SCTP checksum field. The
> receiver will then drop the packet.
>
> Take L2TP over IPv4 with the default of no UDP checksum. Before this
> patch the skb kept CHECKSUM_PARTIAL and csum_not_inet, and
> validate_xmit_skb()->skb_csum_hwoffload_help() on the output device
> computed a correct CRC32c. So this looks like a regression for that
> setup. It also does not match the commit message, which says the patch
> will "finish CHECKSUM_PARTIAL checksums".
>
> Would skb_csum_hwoffload_help(skb, 0) work better here?


Indeed, v2 uses skb_csum_hwoffload_help(skb, 0).

Thanks!

pw-bot: cr

>
> > +
> > +     if (chan->ops->start_xmit(chan, skb))
> > +             return;
> > +drop:
> > +     kfree_skb(skb);
> > +}
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261022111039.85112-1-edumazet%40kernel.org
