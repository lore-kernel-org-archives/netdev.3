Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A38497391
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591747; cv=none; b=DvQ9fUxyEJh9/6FXALz8pnVYHY6cXxexUZI1rS64WEzC5pOCXbuoNV2TJOOqi26UKzCUjNCCnk2o+EXbNi0Xqiy65OV8y0v0fyI8p7bzV96BkVzmh0Bx5/5sWwGQKZVNoRMqfgFULu12A6aU+avWLmexgv6iSssCgPLUnipzBqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591747; c=relaxed/simple;
	bh=pMqwTIXGFWQKPPMN08evRu/i/pjj2wRvSlScMm4IDmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ncV3m9rY/x64qlv5LgOYkKZG/h5dc/ymqLKOR6NPgN1OrdYtjAJLqquTjboGLZ92/g3FIHdUmCCdLybhb4EWC9zXsZkQRixqbya5hD98NsYkHuJQEOJA/eYPjNysMKA1FCEOH9ZO4H0k4C7xQ/TfWIsIal1CFZy/lt4quLd5uAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcKSdDvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcKSdDvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643421F0089C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790591745;
	bh=6u+CYfugwDwLiWIpv2RDMqA2Al4ixy4FX3eWOIaPPUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DcKSdDvCtGvBttS9+GPSy9UtvtioLXm5N/ibYuGIHhscf2X1hr6TdvCzCk8C/BwNG
	 UrkBTJrz5M2o/OW5yyskH1vE2Qqy/WOM3iKNeX73PMUnZ6dvS7ebZB3HekA5C47yY6
	 TTieY0utN8ov62Bvi0r7VsoLTMQbIKQZHTSdnkY6wRRcDCyMkq8KojRSu8bHHT2Wt6
	 rYxPN2lCimEDKWidFD0zp9nFM1YF3qu+jIJfaYHPLI28V8F/VffzSYCqZFnRp+2kDG
	 RLdrnYpB+Fn+5Xt1syYTaZaYj0yGQKtaDYzvkv7hmoNAh4GugSPlytpaisE1Sx6Tto
	 gWyI04JtQhCKg==
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2b71so2025369fac.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 03:35:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByMIhuDiV8ySW4jQDnypp8sQIKL+z98s0igXMqwvNjw5YXc+A/apnUOSIBqENRQ1UjJ0p7e/NI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXF7uf65oIGa7FWEgpwpekmqV+jTTh8UEqFQAT/0hTl3W3HkE5
	oNBQcfV586Ky67cHAxP/+kwLgma03vp8BiiPeu4xMmD4kp24+v0ytcptfOKhzeqEnG7f+WTD/Gj
	RSAeb+9peJA5sm3KQsfQZHaU1klCQi+s=
X-Received: by 2002:a05:6870:2414:b0:484:95af:60fb with SMTP id
 586e51a60fabf-491e4a3c473mr11469517fac.3.1790591744585; Mon, 28 Sep 2026
 03:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927195536.2489079-1-edumazet@google.com> <20260927212942-mutt-send-email-mst@kernel.org>
 <CAL4Wiio9juqXbKZ7gsv8G=siXsdCwHtn0pYRpx-74akkamJvdA@mail.gmail.com>
 <CAL4WiiqLV8GFDiUak5i8DyGR9b6PN3yy81iLcdmZAbkJxAHM1w@mail.gmail.com> <20260928032419-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260928032419-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 28 Sep 2026 12:35:33 +0200
X-Gmail-Original-Message-ID: <CAL4Wiip4ZPnu+Cq2YJMcOSav8XL9OLH4Jam8Y4ncr+FMSLW36Q@mail.gmail.com>
X-Gm-Features: AclHuK_1IwwAl_oFcNOQLx5fN2KyGXSJpVAF8jPRkzP-zPRkXcYLbCfPC6p6nIs
Message-ID: <CAL4Wiip4ZPnu+Cq2YJMcOSav8XL9OLH4Jam8Y4ncr+FMSLW36Q@mail.gmail.com>
Subject: Re: [PATCH net] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:10=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Sep 28, 2026 at 08:31:53AM +0200, Eric Dumazet wrote:
> > On Mon, Sep 28, 2026 at 8:22=E2=80=AFAM Eric Dumazet <edumazet@kernel.o=
rg> wrote:
> > >
> > > On Mon, Sep 28, 2026 at 3:31=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Sun, Sep 27, 2026 at 07:55:36PM +0000, Eric Dumazet wrote:
> > > > > Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
> > > > > validation") added a '&& skb->network_header' check before flow-d=
issecting
> > > > > GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
> > > > > __virtio_net_hdr_to_skb(), because some callers (such as tun_get_=
user(),
> > > > > tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) c=
alled
> > > > > virtio_net_hdr_*_to_skb() before initializing skb->network_header=
 and
> > > > > skb->dev.
> > > > >
> > > > > However, skb->network_header is an offset from skb->head, not a b=
oolean
> > > > > flag. When skb_headroom(skb) is 0 on a device without L2 headers =
(for
> > > > > instance packet_snd() or tpacket_snd() on a tunnel/pure-L3 device=
 where
> > > > > LL_RESERVED_SPACE_EX(dev, 0) =3D=3D 0),
> > > >
> > > > Hmm. I have:
> > > >
> > > > LL_RESERVED_SPACE_EX(dev, 0)
> > > >         ((((hlen) + READ_ONCE((dev)->needed_headroom)) \
> > > >           & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
> > > >
> > > > #define HH_DATA_MOD     16
> > > >
> > > > So how can LL_RESERVED_SPACE_EX(dev, 0) =3D=3D 0 ?
> > > >
> > > >
> > >
> > > In practice, skb->network_header was 0 on tun_get_user() (including t=
he
> > > reported reproducer), tun_xdp_one(), virtnet_receive_done(), and
> > > raw_verify_header() because __alloc_skb() / __build_skb_around()
> > > zero-initializes skb->network_header to 0 (unlike mac_header and
> > > transport_header which are initialized to ~0U), and those callers inv=
oked
> > > virtio_net_hdr_*_to_skb() before setting skb->network_header.
> > >
> > > More generally, because 0 is both the initial value from alloc_skb() =
and a
> > > valid offset whenever skb_headroom(skb) =3D=3D 0, skb->network_header=
 cannot
> > > be used as a boolean to test whether the network header was initializ=
ed.
> > >
> > > I can send a v2 with the corrected commit message if preferred, the
> > > patch stays the same.
> >
> > Revised changelog would look like this, let me know if it looks ok this=
 time.
> >
> > net: always dissect GSO packets in __virtio_net_hdr_to_skb()
> >
> > Commit 9e8db5913264 ("net: avoid false positives in untrusted gso
> > validation") added a '&& skb->network_header' check before flow-dissect=
ing
> > GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM in
> > __virtio_net_hdr_to_skb(), because some callers (such as tun_get_user()=
,
> > tun_xdp_one(), virtnet_receive_done(), and raw_verify_header()) called
> > virtio_net_hdr_*_to_skb() before initializing skb->network_header and
> > skb->dev.
> >
> > Because __alloc_skb() and __build_skb_around() zero-initialize
> > skb->network_header to 0 (unlike mac_header and transport_header which
> > are initialized to ~0U), those four callers always had
> > skb->network_header =3D=3D 0 and bypassed flow dissection in
> > __virtio_net_hdr_to_skb(). More generally, skb->network_header is an
> > offset from skb->head (where 0 is also a valid offset whenever
> > skb_headroom(skb) is 0), not a boolean flag.
> >
> > Whenever the 'if (gso_type && skb->network_header)' branch was skipped,
> > the fallback 'else if (gso_type)' only pulled nh_min_len + thlen (40 by=
tes
> > for TCPv4) without dissecting the packet, without validating ip_proto o=
r
> > n_proto, and without setting skb->transport_header.
> >
> > If the packet has a malformed network header, it is not rejected and a
> > subsequent skb_probe_transport_header() also fails, leaving
> > skb->transport_header at ~0U (0xffff). Similarly, if an IPv4 packet
> > carries IP options (ihl > 5) or an IPv6 packet carries extension header=
s,
> > pulling only nh_min_len + thlen can leave the TCP header outside
> > skb->head. In both cases, tcp_hdrlen(skb) in skb_gso_transport_seglen()
> > reads out-of-bounds:
> >
> >   BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen
> >   Read of size 2 by task poc/133
> >   skb_gso_transport_seglen (net/core/gso.c:155)
> >   skb_gso_validate_mac_len (net/core/gso.c:270)
> >   tbf_enqueue (net/sched/sch_tbf.c:260)
> >   dev_qdisc_enqueue (net/core/dev.c:4227)
> >   __dev_queue_xmit (net/core/dev.c:4884)
> >
> > In addition, when skb->protocol is pre-set by a caller before
> > __virtio_net_hdr_to_skb(), 'if (!skb->protocol)' is skipped and
> > virtio_net_hdr_match_proto() was not checked.
> >
> > Fix this by:
> > 1. Initializing skb->dev and skb->network_header (plus skb->protocol fo=
r
> >    IFF_TUN) before virtio_net_hdr_*_to_skb() in tun_get_user(),
> >    tun_xdp_one(), virtnet_receive_done(), and raw_verify_header(). In
> >    tun_get_user(), drop the redundant skb_reset_mac_header(skb) in the
> >    IFF_TUN case since __virtio_net_hdr_to_skb() unconditionally resets
> >    mac_header.
> > 2. Removing '&& skb->network_header' and the unvalidated
> >    'else if (gso_type)' fallback in __virtio_net_hdr_to_skb() so all GS=
O
> >    packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are flow-dissected, have
> >    their transport header pulled into linear data, and have
> >    skb->transport_header set.
> > 3. Validating virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_ty=
pe)
> >    after skb_flow_dissect_flow_keys_basic().
>
> I'm travelling for a week, if possible I'd like a bit of time to review t=
his.
>
> For now, I also asked Claude to find cases where this patch causes any
> UAPI change (because if it does, there's a risk it will break some
> userspace, right?).
> It wrote the below test, which accepts a packet
> without your patch and fails with, and claims this packet is valid and
> was previously accepted. I tested it quickly and it seems to be true but =
I can't
> analyze it now as I'm sleep deprived due to travel)

Thanks for the reproducer!

For a VLAN-tagged Ethernet frame, dev_parse_header_protocol(skb) returns
the outer VLAN EtherType (ETH_P_8021Q / ETH_P_8021AD), not the inner L3
protocol.

Because virtio_net_hdr_match_proto() only matches ETH_P_IP and
ETH_P_IPV6, checking virtio_net_hdr_match_proto(protocol, hdr_gso_type)
before skb_flow_dissect_flow_keys_basic() rejects VLAN-tagged GSO
packets without NEEDS_CSUM whenever skb->protocol is not pre-set.

Previously, tun_get_user() (IFF_TAP) only avoided this check because
skb->network_header was 0 and the whole flow-dissection block was
_skipped_, exposing our stack to a variety of malicious packets.

Since the patch already validates
virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_type) after
skb_flow_dissect_flow_keys_basic() (where keys.basic.n_proto holds the
inner L3 protocol after dissecting any 802.1Q / 802.1AD headers), we
should drop the pre-dissection virtio_net_hdr_match_proto() check:

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 8902d5a5c418c46af0a6e7b26ae89948c20b0b54..d6466f96cdd00cdf059d4fa8842=
ba1672780e556
100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -118,15 +118,9 @@ static inline int __virtio_net_hdr_to_skb(struct
sk_buff *skb,
                struct flow_keys_basic keys;

                if (!skb->protocol) {
-                       __be16 protocol =3D dev_parse_header_protocol(skb);
-
-                       if (!protocol)
+                       skb->protocol =3D dev_parse_header_protocol(skb);
+                       if (!skb->protocol)
                                virtio_net_hdr_set_proto(skb, hdr);
-                       else if (!virtio_net_hdr_match_proto(protocol,
-                                                            hdr_gso_type))
-                               return -EINVAL;
-                       else
-                               skb->protocol =3D protocol;
                }
 retry:
                if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,

I will fold this into v2, and  add your repro in a new case in
tools/testing/selftests/net/tun.c
