Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C53630BE
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576568; cv=none; b=uF8kg8oEcsFxcmxiM/CjGKD+RahBP8zIwcEbgpgTb+LO4OaVpfna/NjqChwebmJxbm1ga7bxEJ4MZsykx8Tgzj9cIfpm5jJ+ovT3VY6PFKMUCJQk4ccjef3ivpegYFp8cKaRdN5ifX3OajIb0CgHuG58oHnvVZvcEMp9Od/4Ji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576568; c=relaxed/simple;
	bh=Dt+EX+e4nGqTXJakb2Fs2MC8JJA1ifzTUVgVFLr/ayI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXiMLsKb38MITT2l9hniw3WUlXG1nQBqJWO3XAPiGxfI9+cKVNLen60jEfQcP0+vZ4oT/kT4t3R2LpmB+TJz4kPNFzEqvl3dhNB5vIo+Cn1Ss1d3UB9AOCEG7asdTLiSJ/rZgtN8jgLuXlmJCgq+IX0StlSoAo3VlEmBA8199FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/FWGEH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/FWGEH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD811F00898
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790576566;
	bh=/AWAOLk4/R/HwJ7VZ02D+W6wyh7f/zJhaMPpS6WweOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I/FWGEH0aFz5R9BLlLZ9aIvA5AqC0V7x5OkdDAm136RcAi7ImuGvo4/g7SIQbdtFp
	 OyZXti43oDBhdrKISoMbUdCONwnkO4KYrlYCY2VIglu0FBFJtGoTmTX9/6FJESfi/u
	 5hYr9lReSylDEvEI8jf6Akfb9gZqMFAndogeu0mjBQdfJwPP4YWKYNOf0Qp6PoHlpp
	 a6F272IlkThjgfu0QYLkuvfbK0V1emtQG06e+5laAd1Otwqi9yzOHpm7t0sGx5tWgD
	 NsVA4cpaezie6F1ONx4rBgdsTlucArWPNp3mpgFpkoehQxkhCxb8+aXPaIPuUsrmZZ
	 9l7Ib5LSeyDtQ==
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d817a94755so175949eaf.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:22:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByOqGV38rtJO8l8AuIgFlWs+cwmGE7GxG0P8zXvOfbz1w4hwFIdh1liJAx05u6EaOKOnD+jnlM=@vger.kernel.org
X-Gm-Message-State: AFuF++kmxoWI0NgVsP5C8TB/oGjaWJbVafEzZbiU5lh+cOu3sWapgmZ8
	2YIE/di0feTAsHgm80ceKcT6S0zBG2wBuRm6L1YIBSglWLU1EpWQ6qeqoRwklNJ9QIrY+eVKn5I
	+t7ZM29SxsM0EWepFGYd5Qtyr3HcS39Q=
X-Received: by 2002:a05:6820:60f:b0:6d8:645d:5a0e with SMTP id
 006d021491bc7-6d8645d5d4emr3098594eaf.81.1790576565822; Sun, 27 Sep 2026
 23:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927195536.2489079-1-edumazet@google.com> <20260927212942-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260927212942-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 28 Sep 2026 08:22:34 +0200
X-Gmail-Original-Message-ID: <CAL4Wiio9juqXbKZ7gsv8G=siXsdCwHtn0pYRpx-74akkamJvdA@mail.gmail.com>
X-Gm-Features: AclHuK_g5o2HhQp0Fxf3lWp5DVfTwl5Iwqu2Ku6dHoz7RcQCgpvuBI9Q0aab22Y
Message-ID: <CAL4Wiio9juqXbKZ7gsv8G=siXsdCwHtn0pYRpx-74akkamJvdA@mail.gmail.com>
Subject: Re: [PATCH net] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:31=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Sep 27, 2026 at 07:55:36PM +0000, Eric Dumazet wrote:
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
> > However, skb->network_header is an offset from skb->head, not a boolean
> > flag. When skb_headroom(skb) is 0 on a device without L2 headers (for
> > instance packet_snd() or tpacket_snd() on a tunnel/pure-L3 device where
> > LL_RESERVED_SPACE_EX(dev, 0) =3D=3D 0),
>
> Hmm. I have:
>
> LL_RESERVED_SPACE_EX(dev, 0)
>         ((((hlen) + READ_ONCE((dev)->needed_headroom)) \
>           & ~(HH_DATA_MOD - 1)) + HH_DATA_MOD)
>
> #define HH_DATA_MOD     16
>
> So how can LL_RESERVED_SPACE_EX(dev, 0) =3D=3D 0 ?
>
>

In practice, skb->network_header was 0 on tun_get_user() (including the
reported reproducer), tun_xdp_one(), virtnet_receive_done(), and
raw_verify_header() because __alloc_skb() / __build_skb_around()
zero-initializes skb->network_header to 0 (unlike mac_header and
transport_header which are initialized to ~0U), and those callers invoked
virtio_net_hdr_*_to_skb() before setting skb->network_header.

More generally, because 0 is both the initial value from alloc_skb() and a
valid offset whenever skb_headroom(skb) =3D=3D 0, skb->network_header canno=
t
be used as a boolean to test whether the network header was initialized.

I can send a v2 with the corrected commit message if preferred, the
patch stays the same.


> > skb_reset_network_header(skb)
> > legitimately sets skb->network_header to 0.
> >
> > Whenever the 'if (gso_type && skb->network_header)' branch was skipped,
> > the fallback 'else if (gso_type)' only pulled nh_min_len + thlen (40 by=
tes
> > for TCPv4) without dissecting the packet, without validating ip_proto o=
r
> > n_proto, and without setting skb->transport_header. If an IPv4 packet
> > carries IP options (ihl > 5, up to 60 bytes) or an IPv6 packet carries
> > extension headers, pulling only nh_min_len + thlen leaves the TCP heade=
r
> > outside skb->head, causing tcp_hdrlen(skb) in skb_gso_transport_seglen(=
)
> > to read out-of-bounds:
> >
> >   BUG: KASAN: slab-out-of-bounds in skb_gso_transport_seglen+0x173/0x20=
0 net/core/skbuff.c:5503
> >   Read of size 1 at addr ffff888103c7ec4d by task repro/5718
> >   Call Trace:
> >    <TASK>
> >    skb_gso_transport_seglen+0x173/0x200 net/core/skbuff.c:5503
> >    skb_gso_network_seglen include/linux/skbuff.h:4718 [inline]
> >    skb_gso_validate_network_len+0x92/0x1a0 net/core/skbuff.c:5566
> >    ip_finish_output_gso net/ipv4/ip_output.c:285 [inline]
> >    __ip_finish_output+0x28b/0x4a0 net/ipv4/ip_output.c:316
> >
> > In addition, when skb->protocol is pre-set by a caller before
> > __virtio_net_hdr_to_skb(), 'if (!skb->protocol)' is skipped and
> > virtio_net_hdr_match_proto() was not checked.
> >
> > Fix this by:
> > 1. Initializing skb->dev and skb->network_header (plus skb->protocol fo=
r
> >    IFF_TUN) before virtio_net_hdr_*_to_skb() in tun_get_user(),
> >    tun_xdp_one(), virtnet_receive_done(), and raw_verify_header().
> > 2. Removing '&& skb->network_header' and the unvalidated
> >    'else if (gso_type)' fallback in __virtio_net_hdr_to_skb() so all GS=
O
> >    packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are flow-dissected, have
> >    their transport header pulled into linear data, and have
> >    skb->transport_header set.
> > 3. Validating virtio_net_hdr_match_proto(keys.basic.n_proto, hdr_gso_ty=
pe)
> >    after skb_flow_dissect_flow_keys_basic().
> >
> > Fixes: 9e8db5913264 ("net: avoid false positives in untrusted gso valid=
ation")
> > Fixes: d5be7f632bad ("net: validate untrusted gso packets without csum =
offload")
> > Fixes: 924a9bc362a5 ("net: check if protocol extracted by virtio_net_hd=
r_set_proto is correct")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Closes: https://lore.kernel.org/netdev/20260927163117.746432-2-bestswng=
s@gmail.com/
> > Assisted-by: LLM
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  arch/um/drivers/vector_transports.c |  1 +
> >  drivers/net/tun.c                   | 23 ++++++----
> >  drivers/net/virtio_net.c            |  2 +
> >  include/linux/virtio_net.h          | 66 ++++++++++++++---------------
> >  4 files changed, 48 insertions(+), 44 deletions(-)
> >
> > diff --git a/arch/um/drivers/vector_transports.c b/arch/um/drivers/vect=
or_transports.c
> > index ddd127ee96785daa4c485b2a06f078686efd2046..e1fb2a76fdff59ef3032d09=
1be06a06fa58046cc 100644
> > --- a/arch/um/drivers/vector_transports.c
> > +++ b/arch/um/drivers/vector_transports.c
> > @@ -209,6 +209,7 @@ static int raw_verify_header(
> >       if ((vheader->flags & VIRTIO_NET_HDR_F_DATA_VALID) > 0)
> >               return 1;
> >
> > +     skb_set_network_header(skb, ETH_HLEN);
> >       virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endia=
n());
> >       return 0;
> >  }
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 5a302709a68aa3308b0c850b4a2957df3260b352..242899f7fd0711c5c59ff85=
accbf5bd1be9c6f39 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1897,12 +1897,7 @@ static ssize_t tun_get_user(struct tun_struct *t=
un, struct tun_file *tfile,
> >               }
> >       }
> >
> > -     if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > -             atomic_long_inc(&tun->rx_frame_errors);
> > -             err =3D -EINVAL;
> > -             goto free_skb;
> > -     }
> > -
> > +     skb->dev =3D tun->dev;
> >       switch (tun->flags & TUN_TYPE_MASK) {
> >       case IFF_TUN:
> >               if (tun->flags & IFF_NO_PI) {
> > @@ -1927,9 +1922,8 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
> >                       }
> >               }
> >
> > -             skb_reset_mac_header(skb);
> > +             skb_reset_network_header(skb);
> >               skb->protocol =3D pi.proto;
> > -             skb->dev =3D tun->dev;
> >               break;
> >       case IFF_TAP:
> >               if (!pskb_may_pull(skb, ETH_HLEN)) {
> > @@ -1937,10 +1931,19 @@ static ssize_t tun_get_user(struct tun_struct *=
tun, struct tun_file *tfile,
> >                       drop_reason =3D SKB_DROP_REASON_HDR_TRUNC;
> >                       goto drop;
> >               }
> > -             skb->protocol =3D eth_type_trans(skb, tun->dev);
> > +             skb_set_network_header(skb, ETH_HLEN);
> >               break;
> >       }
> >
> > +     if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > +             atomic_long_inc(&tun->rx_frame_errors);
> > +             err =3D -EINVAL;
> > +             goto free_skb;
> > +     }
> > +
> > +     if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
> > +             skb->protocol =3D eth_type_trans(skb, tun->dev);
> > +
> >       /* copy skb_ubuf_info for callback when skb has no error */
> >       if (zerocopy) {
> >               skb_zcopy_init(skb, msg_control);
> > @@ -2600,6 +2603,8 @@ static int tun_xdp_one(struct tun_struct *tun,
> >
> >       features =3D tun_vnet_hdr_guest_features(READ_ONCE(tun->vnet_hdr_=
sz));
> >       tnl_hdr =3D (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> > +     skb->dev =3D tun->dev;
> > +     skb_set_network_header(skb, ETH_HLEN);
> >       if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) =
{
> >               atomic_long_inc(&tun->rx_frame_errors);
> >               kfree_skb(skb);
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index bf82ef9874abb4094931496fb6064a12ee75b789..daab43ac92ce4276b0f8f88=
684991e3993022ce6 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2515,6 +2515,8 @@ static void virtnet_receive_done(struct virtnet_i=
nfo *vi, struct receive_queue *
> >               goto frame_err;
> >       }
> >
> > +     skb->dev =3D dev;
> > +     skb_set_network_header(skb, ETH_HLEN);
> >       if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> >                                     vi->rx_tnl_csum,
> >                                     virtio_is_little_endian(vi->vdev)))=
 {
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index c381b916c1b54afacba5473888af589a24fe087c..8902d5a5c418c46af0a6e7b=
26ae89948c20b0b54 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -111,48 +111,44 @@ static inline int __virtio_net_hdr_to_skb(struct =
sk_buff *skb,
> >               p_off =3D nh_min_len + thlen;
> >               if (!pskb_may_pull(skb, p_off))
> >                       return -EINVAL;
> > -     } else {
> > +     } else if (gso_type) {
> >               /* gso packets without NEEDS_CSUM do not set transport_of=
fset.
> >                * probe and drop if does not match one of the above type=
s.
> >                */
> > -             if (gso_type && skb->network_header) {
> > -                     struct flow_keys_basic keys;
> > -
> > -                     if (!skb->protocol) {
> > -                             __be16 protocol =3D dev_parse_header_prot=
ocol(skb);
> > -
> > -                             if (!protocol)
> > -                                     virtio_net_hdr_set_proto(skb, hdr=
);
> > -                             else if (!virtio_net_hdr_match_proto(prot=
ocol,
> > -                                                              hdr_gso_=
type))
> > -                                     return -EINVAL;
> > -                             else
> > -                                     skb->protocol =3D protocol;
> > -                     }
> > -retry:
> > -                     if (!skb_flow_dissect_flow_keys_basic(NULL, skb, =
&keys,
> > -                                                           NULL, 0, 0,=
 0,
> > -                                                           0)) {
> > -                             /* UFO does not specify ipv4 or 6: try bo=
th */
> > -                             if (gso_type & SKB_GSO_UDP &&
> > -                                 skb->protocol =3D=3D htons(ETH_P_IP))=
 {
> > -                                     skb->protocol =3D htons(ETH_P_IPV=
6);
> > -                                     goto retry;
> > -                             }
> > -                             return -EINVAL;
> > -                     }
> > +             struct flow_keys_basic keys;
> >
> > -                     p_off =3D keys.control.thoff + thlen;
> > -                     if (!pskb_may_pull(skb, p_off) ||
> > -                         keys.basic.ip_proto !=3D ip_proto)
> > -                             return -EINVAL;
> > +             if (!skb->protocol) {
> > +                     __be16 protocol =3D dev_parse_header_protocol(skb=
);
> >
> > -                     skb_set_transport_header(skb, keys.control.thoff)=
;
> > -             } else if (gso_type) {
> > -                     p_off =3D nh_min_len + thlen;
> > -                     if (!pskb_may_pull(skb, p_off))
> > +                     if (!protocol)
> > +                             virtio_net_hdr_set_proto(skb, hdr);
> > +                     else if (!virtio_net_hdr_match_proto(protocol,
> > +                                                          hdr_gso_type=
))
> >                               return -EINVAL;
> > +                     else
> > +                             skb->protocol =3D protocol;
> >               }
> > +retry:
> > +             if (!skb_flow_dissect_flow_keys_basic(NULL, skb, &keys,
> > +                                                   NULL, 0, 0, 0,
> > +                                                   0)) {
> > +                     /* UFO does not specify ipv4 or 6: try both */
> > +                     if (gso_type & SKB_GSO_UDP &&
> > +                         skb->protocol =3D=3D htons(ETH_P_IP)) {
> > +                             skb->protocol =3D htons(ETH_P_IPV6);
> > +                             goto retry;
> > +                     }
> > +                     return -EINVAL;
> > +             }
> > +
> > +             p_off =3D keys.control.thoff + thlen;
> > +             if (!pskb_may_pull(skb, p_off) ||
> > +                 keys.basic.ip_proto !=3D ip_proto ||
> > +                 !virtio_net_hdr_match_proto(keys.basic.n_proto,
> > +                                             hdr_gso_type))
> > +                     return -EINVAL;
> > +
> > +             skb_set_transport_header(skb, keys.control.thoff);
> >       }
> >
> >       if (hdr_gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
> > --
> > 2.56.0.rc1.315.gc6ed9934b7-goog
>
