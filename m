Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578474;
	b=wd4Rax9WlQASIz9ZucntOWRD6PsyD+ldtram4ZmDuEslKFJ8C5FQfX0ihiCbSq70kO+H
	 wdr0pHCh0wW7sOHhrhpAecuvAJAtP+16wHjvzQyNSWhf82JLFgIkNsgW6IHvnbTj2XU9y
	 BRbVW7Kq9RbVdZk6H6XxnJG7131OWG2ZSwetoSpojeRaPcbY8kwiGwnDlfJ1Phzw1YdNW
	 FFLjDWoNAz+0kZOC+Nt9ZQ/q0TBHY+OEy2X28PmvUsdtc6tuTAJkCczPsiKRhyrL9vzqx
	 AHHhacqaE00WvRj6arwgstRBmoIzYOajlYAeLOpA6ZvFVW+bx842xpS4iLvwj4NFqyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578474;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dLKJpTfaxtLERayiN2nEferBpV2oDnDfD72mIJg0vcA=;
	b=Y9PZYhYKss9h9D2AkVl12tlcJOUMRXkrkSzpwQWc6yIoiNVbnrGG/tCnAxy50zNLTB/G
	 LjfpPbbHNC2dxkqhkAEBftC/t4ReLaaang3Jst7lKun+qOKEFgN3zCfFqEdIbXL6bXbNY
	 JTBhB1FHE7mhYWLzZSoxDz3ji7HB6Vl53dy/pKHNrhL3szpY4h06g3ZMqQxfFJh9FobEa
	 hZaUIuSdVPZoGhz7SpqfNDZTd20QydrFaTdLNq3mZz45iEM7+M4SnnlZuy7sZcs39cFSV
	 Is4IXpuJc8x3/vfzL3mqXxr4qNqaT41kJDq/wfui6EYQPldmBCHXJ5sk53p4In6eytA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BA1UEjlG;
	arc=none smtp.remote-ip=91.218.175.128
Received: from mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48180606A326
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 10:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48180606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BA1UEjlG
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yEusfg4qIgtMgZ0hwnnk4ZJYnBDrsm10dToYRC22Mm0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792578470; v=1; x=1793183270;
 b=BA1UEjlGwC9nK2Ut19aMxqcmYaO0G/N7YBj7/8b8nB4BdCrQspZvECE2O1YICIFYfv3KIw8H
 odMuhxEwRN95vPGhIbxkrS+NrC6r5HjMOTw3Gqb8vp4HRSenzlJcPyxw62KWJgJoDsXKOVa3Nyk
 alGciyDfVOnZhu3ixUJqosAE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6eb127304f5e06c1;
	Wed, 21 Oct 2026 10:27:50 +0000
X-Mizu-Trace-ID: 6eb127304f5e06c1
X-Migadu-Flow: FLOW_OUT
Message-ID: <315a8794-db40-4d0f-9e4c-0cad66174bff@linux.dev>
Date: Wed, 21 Oct 2026 18:27:40 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ppp: linearize bridged packets when required
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>,
 Kees Cook <kees@kernel.org>, Taegu Ha <hataegu0826@gmail.com>,
 Tom Parkin <tparkin@katalix.com>, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 James Chapman <jchapman@katalix.com>, Sashiko <sashiko-bot@kernel.org>,
 Felix Fietkau <nbd@nbd.name>, Pablo Neira Ayuso <pablo@netfilter.org>
References: <20261021023608.55867-1-qingfang.deng@linux.dev>
 <179255036282.3290.8488375760281728576@kernel.org>
 <c0f348bf-0e13-4cb1-8014-cd9b7787bfe6@linux.dev>
 <CAL4WiirRPnbSBgcoh8Aiq8zGVzsy34w9uaqAgSKQwpgJ0ht7aA@mail.gmail.com>
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <CAL4WiirRPnbSBgcoh8Aiq8zGVzsy34w9uaqAgSKQwpgJ0ht7aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026/10/21 17:24, Eric Dumazet wrote:
> OK, but I think GRO/GSO is still in the way (because of 55a5d8fca836
> ("net: pppoe: implement GRO/GSO support")).
> I guess Sashiko will find out.
>
> We should GSO segment first, then linearize the small segments
> (instead of 64KB packets)
>
> I was working on the GSO part yesterday, so what about this:
>
> commit 5e8cbf87e1aea072b9bdb52ca5c7a5f523186934
> Author: Eric Dumazet <edumazet@kernel.org>
> Date:   Wed Oct 21 10:04:45 2026 +0200
>
>      ppp: linearize and segment bridged packets when required
>
>      PPP channel bridging is commonly used for PPPoE relaying or forwarding
>      from PPPoE to PPPoL2TP. Both destination channel types handle non-linear
>      packets, but other channels, such as PPP Async, require linear packets.
>
>      Ethernet drivers can pass non-linear packets to PPPoE. If one is bridged
>      to PPP Async, ppp_async_encode() accesses the entire packet through
>      skb->data, assuming that it is linear. This can read beyond the linear
>      buffer and transmit unrelated memory over the serial interface.
>
>      Since commit 55a5d8fca836 ("net: pppoe: implement GRO/GSO support"),
>      these packets can also be GSO packets. Packets can also be in
>      CHECKSUM_PARTIAL state, for instance when injected by a tap device or
>      a packet socket using a virtio_net_hdr. The regular transmit path never
>      sees such packets, because the ppp device does not advertise GSO or
>      checksum offload features. Most PPP channels are not prepared for them:
>
>      - PPP Async and PPP Sync send a GSO packet as a single frame, up to
>        64KB, far above the peer MRU. They also send CHECKSUM_PARTIAL packets
>        with an unfinished L4 checksum.
>      - PPTP pushes GRE and IP headers in front of a TCP GSO packet, which
>        gre_gso_segment() refuses because skb->encapsulation is not set. It
>        also sets CHECKSUM_NONE without finishing a pending checksum.
>      - L2TP pushes UDP and L2TP headers in front of a TCP GSO packet, which
>        udp4_ufo_fragment() refuses. A TSO capable device could also be
>        handed a TCP GSO packet whose transport header is a UDP header.
>
>      Only PPPoE handles them correctly, as pppoe_xmit() uses
>      dev_queue_xmit(), which can segment GSO packets with
>      pppoe_gso_segment() and finish checksums, or offload them to the
>      device.
>
>      Add a xmit_offload flag to struct ppp_channel, telling that the channel
>      accepts GSO and CHECKSUM_PARTIAL packets, and set it for PPPoE.
>
>      For other bridged channels, segment GSO packets in software. The PPP
>      protocol field in front of the IP header is used as the L2 header, and
>      is replicated in front of each segment. Then finish CHECKSUM_PARTIAL
>      checksums with skb_checksum_help(). For channels without direct_xmit,
>      also linearize each packet, as ppp_push() does for the regular transmit
>      path. Packets are dropped if any of these steps fails.
>
>      The bridge path still has no transmit queue, so a channel that is
>      busy (for example a full tty) drops the segments it refuses, as it
>      already did for regular packets.
>
>      Non-linear packets were reproduced in a VM, with a TAP interface using
>      IFF_NAPI_FRAGS feeding PPPoE, bridged to PPP Async on a PTY: the
>      packets sent to the PTY contained garbage data.
>
>      GSO and CHECKSUM_PARTIAL packets were reproduced by bridging a PPPoE
>      channel on a veth device to PPP Async on a PTY. With GRO enabled, a
>      burst of 8 TCP segments was sent as a single 8040 byte frame with a
>      bad TCP checksum, and is now sent as 8 valid frames, for both IPv4 and
>      IPv6. A CHECKSUM_PARTIAL packet sent through a packet socket with
>      PACKET_VNET_HDR was sent with a bad TCP checksum, and now has a valid
>      one. When bridging to a second PPPoE channel, GSO packets are passed
>      unchanged to the PPPoE device, and are correctly segmented by
>      pppoe_gso_segment() when the device does not offload them.
>
>      Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and
> PPPIOCUNBRIDGECHAN ioctls")
>      Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
>      Reported-by: Sashiko <sashiko-bot@kernel.org>
>      Closes: https://sashiko.dev/#/patchset/20260908072135.877364-1-qingfang.deng@linux.dev
>      Co-developed-by: Qingfang Deng <qingfang.deng@linux.dev>
>      Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
>      Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>      Cc: Felix Fietkau <nbd@nbd.name>
>      Cc: Pablo Neira Ayuso <pablo@netfilter.org>

LGTM, thanks. Nits below:

> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index 1a610a18893ba94b5ff3f69f8e25dcd944ef01a8..2b27ec36c8cef829e3bc9238036c68967aceea1e
> 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -45,6 +45,7 @@
>   #include <linux/slab.h>
>   #include <linux/file.h>
>   #include <linux/unaligned.h>
> +#include <net/gso.h>
>   #include <net/netdev_lock.h>
>   #include <net/slhc_vj.h>
>   #include <linux/atomic.h>
> @@ -2278,6 +2279,58 @@ static bool ppp_decompress_proto(struct sk_buff *skb)
>          return pskb_may_pull(skb, 2);
>   }
>
> +/* Segment a GSO packet (built by PPPoE GRO) before sending it to a
> + * bridged channel that does not accept GSO packets.
> + * skb->data points to the PPP protocol field, which is replicated
> + * in front of each segment.
> + * Returns a list of segments, or NULL if the packet was dropped.
> + */
> +static struct sk_buff *ppp_bridge_gso_segment(struct sk_buff *skb)
> +{
> +       struct sk_buff *segs;
> +
> +       if (!pskb_may_pull(skb, PPP_PROTO_LEN))
> +               goto drop;
> +
> +       switch (get_unaligned_be16(skb->data)) {

skb->data should be already 2-byte aligned here. You can avoid the 
get_unaligned and runtime byte-swapping.

> +       case PPP_IP:
> +               skb->protocol = htons(ETH_P_IP);
> +               break;
> +       case PPP_IPV6:
> +               skb->protocol = htons(ETH_P_IPV6);
> +               break;
> +       default:
> +               goto drop;
> +       }
> +       skb_set_network_header(skb, PPP_PROTO_LEN);
> +
> +       segs = skb_gso_segment(skb, 0);

Passing zero features to skb_gso_segment will linearize every segment 
prematurely.

> +       if (IS_ERR_OR_NULL(segs))
> +               goto drop;
> +
> +       consume_skb(skb);
> +       return segs;
> +
> +drop:
> +       kfree_skb(skb);
> +       return NULL;
> +}
> +
> +static void ppp_bridge_xmit(struct ppp_channel *chan, struct sk_buff *skb)
> +{
> +       if (!chan->direct_xmit && skb_linearize(skb))
> +               goto drop;
> +
> +       if (!chan->xmit_offload && skb->ip_summed == CHECKSUM_PARTIAL &&
> +           skb_checksum_help(skb))
> +               goto drop;
> +
> +       if (chan->ops->start_xmit(chan, skb))
> +               return;
> +drop:
> +       kfree_skb(skb);
> +}
> +
>   /* Attempt to handle a frame via. a bridged channel, if one exists.
>    * If the channel is bridged, the frame is consumed by the bridge.
>    * If not, the caller must handle the frame by normal recv mechanisms.
> @@ -2285,6 +2338,8 @@ static bool ppp_decompress_proto(struct sk_buff *skb)
>    */
>   static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
>   {
> +       struct sk_buff *segs, *next;
> +       struct ppp_channel *chan;
>          struct channel *pchb;
>
>          rcu_read_lock();
> @@ -2300,8 +2355,17 @@ static bool ppp_channel_bridge_input(struct
> channel *pch, struct sk_buff *skb)
>          }
>
>          skb_scrub_packet(skb, !net_eq(pch->chan_net, pchb->chan_net));
> -       if (!pchb->chan->ops->start_xmit(pchb->chan, skb))
> -               kfree_skb(skb);
> +
> +       chan = pchb->chan;
> +       if (!chan->xmit_offload && skb_is_gso(skb)) {
> +               segs = ppp_bridge_gso_segment(skb);
> +               skb_list_walk_safe(segs, skb, next) {
> +                       skb_mark_not_on_list(skb);
> +                       ppp_bridge_xmit(chan, skb);
> +               }
> +       } else {
> +               ppp_bridge_xmit(chan, skb);
> +       }
>
>   outl:
>          spin_unlock_bh(&pchb->downl);
> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index bf7414b46a26068d1773ec79055167956dde7183..f22087d76874ce524f66003ae00d1528a0e0b898
> 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -669,6 +669,7 @@ static int pppoe_connect(struct socket *sock,
> struct sockaddr_unsized *uservaddr
>                  po->chan.private = sk;
>                  po->chan.ops = &pppoe_chan_ops;
>                  po->chan.direct_xmit = true;
> +               po->chan.xmit_offload = true;
>
>                  error = ppp_register_net_channel(dev_net(dev), &po->chan);
>                  if (error) {
> diff --git a/include/linux/ppp_channel.h b/include/linux/ppp_channel.h
> index 2f63e9a6cc88984c075792dcbd6c832ff45acd51..15bc3aa4f1715c265a5808fcc1cc2b93cc44c519
> 100644
> --- a/include/linux/ppp_channel.h
> +++ b/include/linux/ppp_channel.h
> @@ -43,6 +43,7 @@ struct ppp_channel {
>          void            *ppp;           /* opaque to channel */
>          int             speed;          /* transfer rate (bytes/second) */
>          bool            direct_xmit;    /* no qdisc, xmit directly */
> +       bool            xmit_offload;   /* accepts GSO and
> CHECKSUM_PARTIAL skbs */
>   };
>
>   #ifdef __KERNEL__
