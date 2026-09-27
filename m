Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FB37B41F
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790547075; cv=pass; b=tB1IV9CY7QL4p3ywdWDqiXm+ICq8FPqnSq2uUVzQ4EIWTDusUKIC31HEaWRGC1+ahoegQbHOrQr8ZbckTcNQU6v/HDZFjzet1BfG0IcABXpV3/oCGrbfaWXyuG5rRL6ZcY/2ASlVjJ4lxbwe9Wax0iF9o5vnHhNbzWMPSejmMIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790547075; c=relaxed/simple;
	bh=Spj/bi+iqKojb1mglsus1Xkox32G0Umb7iuVM7UlJ1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+5onXJMyuOcY/OOyrsFK0+J2SE6XrQLjJg/BnZqEWGaNrjPaFW5XmBbCwvhrcWH/XIBSlh9omYxjZEKG4dBgPKzyXEYY0UlYs6ugktHYiGDKK6GHgr2rjnPrP21cPmdcFg4kgAlizMxWrz7ha09BWqllO6CEnCTtc+Dz/E3yl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMTbEUl0; arc=pass smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMTbEUl0"
Received: by mail-qk2-f40.google.com with SMTP id d75a77b69052e-5332b967eb4so11649551cf.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 15:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790547072; cv=none;
        d=google.com; s=arc-20260327;
        b=W8P5hrQt3LAD6Hy1KmOBGiO74SyGku9UoV1gp1Y/cmNs5TY98d3dtu456tw2oB42yH
         XTlMSFOzX73oz3AgDfyuuIoGuv53w6zdm9PHVv5vC7beYRCLMvfPw0/tk1UTe8AgUJy1
         EByMzH3FOQ7Yin4iItOzFxZiYNnvbiZnjDwNskop8LL6N8QeLs5vT/B5NWhYvwazxI0r
         XunZLTqsaha6sd5MzJOE4FnBKRr5GkaRfsKvo1STsPN+kcYhdb3dBZXK67Coz5k/sSZq
         egjio+gJ5h4FVse8rY9SH4n5Le6RI2RlJG5FpwpYmf2gvNEPfHpu4q5ZDWPaJf02QLg1
         qOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aIb1R/XjDfqcol8obrfyx2jImeChgbzK893p9+Squ5o=;
        fh=fapN28Y2xsTYcfhe2RKqNo/Q7NrrjTjiroDGfrbMmQg=;
        b=O6lPs+TcwK4iRs0uYw9zbCQBmiJI7aN9Yfuqd6nQJS1Bm01UeqQUStRcpyl/TnmX8l
         /W7dHMOqxjKiM9cRKirj7QKYnonP5rS0eIiNRHoeBshbpoYGC5EKg7e4D40ubP3QyGIS
         x40gbWKoTaiMOs7pE2CbOcc/goDZr4oho14sOMo5LRej45SpuMGayW2p5/QaZwjX/Xzq
         36/Gni/RpJWbjr1rF7juSIP7QHZSdvcsnHEpM/jDCbLdbluyipY7raFss3NF2XyjSodS
         /Q9pIW2hPPO4Gr95jayrEhu/Ty36LBM1TpaSj3pIfh72CPW3lcE+Ri5jSoELem0yXZKf
         vqCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790547072; x=1791151872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aIb1R/XjDfqcol8obrfyx2jImeChgbzK893p9+Squ5o=;
        b=PMTbEUl099ajPWrVaE+MKaSipwvIqlg5FjPiVV2TvTE0lOipCRMTR5j6eItc50woAg
         dge3s91l1Lc02IvCWyB0fCnYXhjFrO5zBsO9CfOZdcHao7bFxUtGUYlUYJaRKLnPXVh0
         ljDkVncximzaXMbt1cUGKfXqL8rXAQ7uch2B/yZuqC86K1ZFO3jZxJXV2xW45q81+lRA
         kjI0IKeNid6nuSIz+umAlk9c0gvzJcLVUwg6fJyBclbFULcLL4PN7e4cLsJdObH9NH+R
         CPx90HbSlV6jF884K3PhpeWIQjZ2ZID2nGLDtNeT+glK5emVExaOqj5I4DFWaagFwed8
         A3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790547072; x=1791151872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aIb1R/XjDfqcol8obrfyx2jImeChgbzK893p9+Squ5o=;
        b=sqzN5mgzEptyq2iC6pJiyirkBcV3Em9rqCloNd32hpKaouoPsk5lJpnY8Fztc0GUdS
         PGtnzQ/Idz0Ajp876+o7ktgkClhDr5kwx65HNWtzXxEnCqEE5oRMrKaoUA+Iu1Tnn2wd
         GHvhOqVBYlbEgOlN9IH6J1/senLwPupTH1l7IE01AsY6xwBXmYSmT4lCK9eUVTWeVME4
         3BPL7Oc6I1JymIH1fpy8cspLFJSgfvNEwwc03bGhC/lKYsJbfPk6zNnh54onn9D2dfT1
         gmns4bfG2oRlEiXccVzLXWZUjYuN9n+HQEA7rmDmmDh59hN6cOjjR6jyGqKBRZGLf5wv
         Kk1g==
X-Forwarded-Encrypted: i=1; AKwUvBwcP3qJasq1DX8QJZgxnFx/rDwpAnY+lfc/25FgfKkjJiXcga32JiIKtVc0J0PqJzUMvtjDofc=@vger.kernel.org
X-Gm-Message-State: AFuF++knj1S2BFp+YNMJiIdAMS23gVd6C0199rFYKlNVJuYXO99ixD5d
	kkP+MlqF5gqjzgcz687dQdvP3zv67E6KYu6UfuRmrA74/eBOKE5YF2pZvh33mvOhibSmH/VRTu3
	/DwfoDuZ4UNaaevV9xIF2lFPCT6Z5DdWKpPssFMxo
X-Gm-Gg: AYBFou1VC6bC3zo8XYXAreAfkflFMY65J+zMYQLBCo+mjkDWybnPh0PVWQ9bt+UOsm+
	tA4TBys4hQFow7Hwrrb0VSSpv3jS5NrIDqPm26kCe4O6BWjprQXyPQdBRkr0vdONNawdswpHQ/y
	4Q5BPs9UMQ3k0jpDfo9OoM9gNvDQn7VePrjupU5ij/xIf3037GVVJz5Sn/9MAoEwhdzWIXOfrqg
	1AFlNL+WiDJEkNVQ3N6AJZg9n6Awc98ZN66KKmjBEiQmX9aCO/WBXCB/snC5ccJVzhOM1+0i+OH
	UAta0jzGAS55uI5mHqyn6+HsJ+xq2qGMjtq4SXf+zt1Gh8w/QDJGufSwHyRwmrdlYUpRMGZ5TX4
	xebGsgnzDHXAMV04s5aSc7onruRFEXy+f1Xvo+3pyoiUTjVfOsIZG1gEiiCqYJ9Gbryjw
X-Received: by 2002:ac8:5f8f:0:b0:533:3da5:2730 with SMTP id
 d75a77b69052e-5333da52a72mr45855771cf.20.1790547071641; Sun, 27 Sep 2026
 15:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927195536.2489079-1-edumazet@google.com> <20260927160750-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260927160750-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Sep 2026 00:11:00 +0200
X-Gm-Features: AclHuK_rRImJ3oNytOiIBg-u-MGlqmJzZwqFQAKsbnE3kv3syxqvTTJ8lFUn0fU
Message-ID: <CANn89iLy8FhURktyBSewu+qvSpSYTTLO4f0ST9dTeZYMNg8r8A@mail.gmail.com>
Subject: Re: [PATCH net] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	edumazet@kernel.org, Weiming Shi <bestswngs@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 10:33=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
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
> > LL_RESERVED_SPACE_EX(dev, 0) =3D=3D 0), skb_reset_network_header(skb)
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
>
>
> Could you explain why is this being removed?
> What sets the mac header then?
> Thanks!

Hi Michael

tun_get_user() uncondittionally call tun_vnet_hdr_tnl_to_skb() right
after the switch statement (even when IFF_VNET_HDR is not set, with a
zeroed hdr), which calls __virtio_net_hdr_to_skb().

__virtio_net_hdr_to_skb() unconditionally calls skb_reset_mac_header(skb)
(since commit 61431a5907fc ("net: ensure mac header is set in
virtio_net_hdr_to_skb()")).

Before this patch, tun_get_user() called tun_vnet_hdr_tnl_to_skb()
before the switch statement (which already reset mac_header, but left
network_header unset during __virtio_net_hdr_to_skb()), and then reset
mac_header a second time in the IFF_TUN case.

Thanks.

>
>
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
>
>
>
>
> > +                     return -EINVAL;
> > +
> > +             skb_set_transport_header(skb, keys.control.thoff);
> >       }
> >
> >       if (hdr_gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
> > --
> > 2.56.0.rc1.315.gc6ed9934b7-goog
>
