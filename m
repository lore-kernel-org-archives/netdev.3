Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600288;
	b=sVZAA0HKYJ2GolqZNU4IDS38fgaJh6FskLncS1sZbicrQNIJJyN/q7iUgbX4T6zcjfUJ
	 zQI3m/oCNXBeJFNrslqCWDFvv35P6nh0GBurnghh8fpc6L2FxWcZ8AZZUqgdot3fiQOEV
	 bCzWrrdUpoVoLxjHAAN8vaWJMMH+VI0dXfjUVHpczlCpyNWcnfQPhG6samhcBryKTWoIe
	 BnyJNe3AXIxtI0gGdIEMjjRXDz42OP0/Y0pfW9CDniIl4YhxSEoYyTFBmeTRL5F1gQAbc
	 SyRUzyWcY30bkJIobBZFeU+a2GxyHCMP6/NQvAwW52AwQsYzx80N6N6MnlKNDknbqQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600288;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0Vt+zSolYIXa9QeetjlzfABV8gG9atqyNEyLr81JJfE=;
	b=VoABtqa7n9Gql42p5t/xLR5Ilfgs9t7wJyGVBNZGPg+9GCuacN/w18hTHeouZs9ardDu
	 a1f2iZeHH/4MAYk2PcUyEaH+3kiq6J9QOezUgxML9MVg6+GzycO+TGlswQHzFOZKikJiR
	 HuSf8XcURzVNQ1hbOG4339bLSvdh6tEXIeyrwASKq3RIElWw5LluMKL/eOk2+/05wlguE
	 f9Ih/uIsZKznWCqtrRlRu+LFdcNbFw6N0H6dDtv7tjvJdaaUI27rvY6289IUUHaxzLkne
	 IZe/mHNRQQ7ljI8CqAR8tEb2BEdwmWR71pIBnkF81aAbcCINn7btG/hvhsuWcAqvbKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jh7RBKPH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EFC606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jh7RBKPH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B3B1F000C6
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792600287;
	bh=0Vt+zSolYIXa9QeetjlzfABV8gG9atqyNEyLr81JJfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jh7RBKPHkrsBkWxCk/FMuWpO9FBnqM5wLp6AHZzREmqRmJfan5HPVyfCUpqI7fxSZ
	 FqfKbQlYmg5Rbdythkc9V4d3S4rOyjlApiYRIwwdk8ot2PlpYukslBVPMeqXmlSXNH
	 sPVJKsDQv4PIs4mijX8Jbj/eQexj0vWtNe5QkKTH3b8upy0JrzTCjTO9ktPKJOV6MQ
	 yBNTEXCQJU79VP0tkqAQWsHwmrUbsu0otc81SYWNcTyHUWtlPmT4npPgoWmbOQBvLJ
	 sc7rSZY4BC1dr/P0UwnrbpNdaf4BcGF56q5lrfp2BDtRlQdt3biHXmWKVx2A0YcXND
	 HUDdhtwtWoshA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6de1fd5f572so404284eaf.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:31:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwak9tkh90QSNo3ECOeDcQT7Djug7q4Wg7LlCESKrQJBit5fANCuTipmDPTdsRz2MsPYIg8uBE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUuau0dMaqXsWG4Lm40dm5rbD5DStcU0NZoX+hEFCHxYyQWtkj
	H4i2qDwoijIC8bSUecS9RuLcqhixlVu49UGiEFRX+7ItloyVtvu69/hLXisGneUAdCHKefjoAyp
	aSjqVASJiSYt3aOopANE7HBSYjmMEZX4=
X-Received: by 2002:a05:6820:7084:20b0:6dc:e1c3:b2a8 with SMTP id
 006d021491bc7-70a3ef29282mr317542eaf.60.1792600286733; Wed, 21 Oct 2026
 09:31:26 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021023608.55867-1-qingfang.deng@linux.dev>
 <179255036282.3290.8488375760281728576@kernel.org> <c0f348bf-0e13-4cb1-8014-cd9b7787bfe6@linux.dev>
 <CAL4WiirRPnbSBgcoh8Aiq8zGVzsy34w9uaqAgSKQwpgJ0ht7aA@mail.gmail.com> <315a8794-db40-4d0f-9e4c-0cad66174bff@linux.dev>
In-Reply-To: <315a8794-db40-4d0f-9e4c-0cad66174bff@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 18:31:15 +0200
X-Gmail-Original-Message-ID: <CAL4WiiouaJ5QU24uKt=CuxpfgHmWHS5oxoE2E_C6KFCLbDh0+w@mail.gmail.com>
X-Gm-Features: AclHuK8jqYZwNdk3fj0bFRGHgep4ALpd2Q573nuFe4FR8cYs_gOOctngTXebl8o
Message-ID: <CAL4WiiouaJ5QU24uKt=CuxpfgHmWHS5oxoE2E_C6KFCLbDh0+w@mail.gmail.com>
Subject: Re: [PATCH net] ppp: linearize bridged packets when required
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev-bot+sinfo@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>, Taegu Ha <hataegu0826@gmail.com>, 
	Tom Parkin <tparkin@katalix.com>, linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Chapman <jchapman@katalix.com>, 
	Sashiko <sashiko-bot@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 12:27, Qingfang Deng <qingfang.deng@linux.dev> =
a =C3=A9crit :
>
> On 2026/10/21 17:24, Eric Dumazet wrote:
> > OK, but I think GRO/GSO is still in the way (because of 55a5d8fca836
> > ("net: pppoe: implement GRO/GSO support")).
> > I guess Sashiko will find out.
> >
> > We should GSO segment first, then linearize the small segments
> > (instead of 64KB packets)
> >
> > I was working on the GSO part yesterday, so what about this:
> >
> > commit 5e8cbf87e1aea072b9bdb52ca5c7a5f523186934
> > Author: Eric Dumazet <edumazet@kernel.org>
> > Date:   Wed Oct 21 10:04:45 2026 +0200
> >
> >      ppp: linearize and segment bridged packets when required
> >
> >      PPP channel bridging is commonly used for PPPoE relaying or forwar=
ding
> >      from PPPoE to PPPoL2TP. Both destination channel types handle non-=
linear
> >      packets, but other channels, such as PPP Async, require linear pac=
kets.
> >
> >      Ethernet drivers can pass non-linear packets to PPPoE. If one is b=
ridged
> >      to PPP Async, ppp_async_encode() accesses the entire packet throug=
h
> >      skb->data, assuming that it is linear. This can read beyond the li=
near
> >      buffer and transmit unrelated memory over the serial interface.
> >
> >      Since commit 55a5d8fca836 ("net: pppoe: implement GRO/GSO support"=
),
> >      these packets can also be GSO packets. Packets can also be in
> >      CHECKSUM_PARTIAL state, for instance when injected by a tap device=
 or
> >      a packet socket using a virtio_net_hdr. The regular transmit path =
never
> >      sees such packets, because the ppp device does not advertise GSO o=
r
> >      checksum offload features. Most PPP channels are not prepared for =
them:
> >
> >      - PPP Async and PPP Sync send a GSO packet as a single frame, up t=
o
> >        64KB, far above the peer MRU. They also send CHECKSUM_PARTIAL pa=
ckets
> >        with an unfinished L4 checksum.
> >      - PPTP pushes GRE and IP headers in front of a TCP GSO packet, whi=
ch
> >        gre_gso_segment() refuses because skb->encapsulation is not set.=
 It
> >        also sets CHECKSUM_NONE without finishing a pending checksum.
> >      - L2TP pushes UDP and L2TP headers in front of a TCP GSO packet, w=
hich
> >        udp4_ufo_fragment() refuses. A TSO capable device could also be
> >        handed a TCP GSO packet whose transport header is a UDP header.
> >
> >      Only PPPoE handles them correctly, as pppoe_xmit() uses
> >      dev_queue_xmit(), which can segment GSO packets with
> >      pppoe_gso_segment() and finish checksums, or offload them to the
> >      device.
> >
> >      Add a xmit_offload flag to struct ppp_channel, telling that the ch=
annel
> >      accepts GSO and CHECKSUM_PARTIAL packets, and set it for PPPoE.
> >
> >      For other bridged channels, segment GSO packets in software. The P=
PP
> >      protocol field in front of the IP header is used as the L2 header,=
 and
> >      is replicated in front of each segment. Then finish CHECKSUM_PARTI=
AL
> >      checksums with skb_checksum_help(). For channels without direct_xm=
it,
> >      also linearize each packet, as ppp_push() does for the regular tra=
nsmit
> >      path. Packets are dropped if any of these steps fails.
> >
> >      The bridge path still has no transmit queue, so a channel that is
> >      busy (for example a full tty) drops the segments it refuses, as it
> >      already did for regular packets.
> >
> >      Non-linear packets were reproduced in a VM, with a TAP interface u=
sing
> >      IFF_NAPI_FRAGS feeding PPPoE, bridged to PPP Async on a PTY: the
> >      packets sent to the PTY contained garbage data.
> >
> >      GSO and CHECKSUM_PARTIAL packets were reproduced by bridging a PPP=
oE
> >      channel on a veth device to PPP Async on a PTY. With GRO enabled, =
a
> >      burst of 8 TCP segments was sent as a single 8040 byte frame with =
a
> >      bad TCP checksum, and is now sent as 8 valid frames, for both IPv4=
 and
> >      IPv6. A CHECKSUM_PARTIAL packet sent through a packet socket with
> >      PACKET_VNET_HDR was sent with a bad TCP checksum, and now has a va=
lid
> >      one. When bridging to a second PPPoE channel, GSO packets are pass=
ed
> >      unchanged to the PPPoE device, and are correctly segmented by
> >      pppoe_gso_segment() when the device does not offload them.
> >
> >      Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and
> > PPPIOCUNBRIDGECHAN ioctls")
> >      Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
> >      Reported-by: Sashiko <sashiko-bot@kernel.org>
> >      Closes: https://sashiko.dev/#/patchset/20260908072135.877364-1-qin=
gfang.deng@linux.dev
> >      Co-developed-by: Qingfang Deng <qingfang.deng@linux.dev>
> >      Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> >      Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> >      Cc: Felix Fietkau <nbd@nbd.name>
> >      Cc: Pablo Neira Ayuso <pablo@netfilter.org>
>
> LGTM, thanks. Nits below:
>
> > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generi=
c.c
> > index 1a610a18893ba94b5ff3f69f8e25dcd944ef01a8..2b27ec36c8cef829e3bc923=
8036c68967aceea1e
> > 100644
> > --- a/drivers/net/ppp/ppp_generic.c
> > +++ b/drivers/net/ppp/ppp_generic.c
> > @@ -45,6 +45,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/file.h>
> >   #include <linux/unaligned.h>
> > +#include <net/gso.h>
> >   #include <net/netdev_lock.h>
> >   #include <net/slhc_vj.h>
> >   #include <linux/atomic.h>
> > @@ -2278,6 +2279,58 @@ static bool ppp_decompress_proto(struct sk_buff =
*skb)
> >          return pskb_may_pull(skb, 2);
> >   }
> >
> > +/* Segment a GSO packet (built by PPPoE GRO) before sending it to a
> > + * bridged channel that does not accept GSO packets.
> > + * skb->data points to the PPP protocol field, which is replicated
> > + * in front of each segment.
> > + * Returns a list of segments, or NULL if the packet was dropped.
> > + */
> > +static struct sk_buff *ppp_bridge_gso_segment(struct sk_buff *skb)
> > +{
> > +       struct sk_buff *segs;
> > +
> > +       if (!pskb_may_pull(skb, PPP_PROTO_LEN))
> > +               goto drop;
> > +
> > +       switch (get_unaligned_be16(skb->data)) {
>
> skb->data should be already 2-byte aligned here. You can avoid the
> get_unaligned and runtime byte-swapping.

Right, I can switch to *(__be16 *)skb->data and htons() constants.

>
> > +       case PPP_IP:
> > +               skb->protocol =3D htons(ETH_P_IP);
> > +               break;
> > +       case PPP_IPV6:
> > +               skb->protocol =3D htons(ETH_P_IPV6);
> > +               break;
> > +       default:
> > +               goto drop;
> > +       }
> > +       skb_set_network_header(skb, PPP_PROTO_LEN);
> > +
> > +       segs =3D skb_gso_segment(skb, 0);
>
> Passing zero features to skb_gso_segment will linearize every segment
> prematurely.

Good point, PPTP and L2TP do not need linear packets.
I will pass NETIF_F_SG: checksums are still computed in software by
skb_segment(), as openvswitch does, and ppp_bridge_xmit() linearizes
segments only for channels without direct_xmit.

>
> > +       if (IS_ERR_OR_NULL(segs))
> > +               goto drop;
> > +
> > +       consume_skb(skb);
> > +       return segs;
> > +
> > +drop:
> > +       kfree_skb(skb);
> > +       return NULL;
> > +}
> > +
> > +static void ppp_bridge_xmit(struct ppp_channel *chan, struct sk_buff *=
skb)
> > +{
> > +       if (!chan->direct_xmit && skb_linearize(skb))
> > +               goto drop;
> > +
> > +       if (!chan->xmit_offload && skb->ip_summed =3D=3D CHECKSUM_PARTI=
AL &&
> > +           skb_checksum_help(skb))
> > +               goto drop;
> > +
> > +       if (chan->ops->start_xmit(chan, skb))
> > +               return;
> > +drop:
> > +       kfree_skb(skb);
> > +}
> > +
> >   /* Attempt to handle a frame via. a bridged channel, if one exists.
> >    * If the channel is bridged, the frame is consumed by the bridge.
> >    * If not, the caller must handle the frame by normal recv mechanisms=
.
> > @@ -2285,6 +2338,8 @@ static bool ppp_decompress_proto(struct sk_buff *=
skb)
> >    */
> >   static bool ppp_channel_bridge_input(struct channel *pch, struct sk_b=
uff *skb)
> >   {
> > +       struct sk_buff *segs, *next;
> > +       struct ppp_channel *chan;
> >          struct channel *pchb;
> >
> >          rcu_read_lock();
> > @@ -2300,8 +2355,17 @@ static bool ppp_channel_bridge_input(struct
> > channel *pch, struct sk_buff *skb)
> >          }
> >
> >          skb_scrub_packet(skb, !net_eq(pch->chan_net, pchb->chan_net));
> > -       if (!pchb->chan->ops->start_xmit(pchb->chan, skb))
> > -               kfree_skb(skb);
> > +
> > +       chan =3D pchb->chan;
> > +       if (!chan->xmit_offload && skb_is_gso(skb)) {
> > +               segs =3D ppp_bridge_gso_segment(skb);
> > +               skb_list_walk_safe(segs, skb, next) {
> > +                       skb_mark_not_on_list(skb);
> > +                       ppp_bridge_xmit(chan, skb);
> > +               }
> > +       } else {
> > +               ppp_bridge_xmit(chan, skb);
> > +       }
> >
> >   outl:
> >          spin_unlock_bh(&pchb->downl);
> > diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> > index bf7414b46a26068d1773ec79055167956dde7183..f22087d76874ce524f66003=
ae00d1528a0e0b898
> > 100644
> > --- a/drivers/net/ppp/pppoe.c
> > +++ b/drivers/net/ppp/pppoe.c
> > @@ -669,6 +669,7 @@ static int pppoe_connect(struct socket *sock,
> > struct sockaddr_unsized *uservaddr
> >                  po->chan.private =3D sk;
> >                  po->chan.ops =3D &pppoe_chan_ops;
> >                  po->chan.direct_xmit =3D true;
> > +               po->chan.xmit_offload =3D true;
> >
> >                  error =3D ppp_register_net_channel(dev_net(dev), &po->=
chan);
> >                  if (error) {
> > diff --git a/include/linux/ppp_channel.h b/include/linux/ppp_channel.h
> > index 2f63e9a6cc88984c075792dcbd6c832ff45acd51..15bc3aa4f1715c265a5808f=
cc1cc2b93cc44c519
> > 100644
> > --- a/include/linux/ppp_channel.h
> > +++ b/include/linux/ppp_channel.h
> > @@ -43,6 +43,7 @@ struct ppp_channel {
> >          void            *ppp;           /* opaque to channel */
> >          int             speed;          /* transfer rate (bytes/second=
) */
> >          bool            direct_xmit;    /* no qdisc, xmit directly */
> > +       bool            xmit_offload;   /* accepts GSO and
> > CHECKSUM_PARTIAL skbs */
> >   };
> >
> >   #ifdef __KERNEL__
