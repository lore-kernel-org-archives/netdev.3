Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030373;
	b=PV7E4B2TZipWV1/tMv2J9v2VQV5WBfMonmPAnUnR5bEqtWRoURioqxuuPlGBMbLy4mtQ
	 RYxv/QMR5+Rq39iTi3GMCTSwbYQX972KZjElmGAgdgDxlYMaXKpy4XAsdyd1ZeRXlrSWz
	 buV+zFq1sUFbYRfwZPDkSi6/887l7sAgaoKhVWyLX9HaABd4bG4BpviINxoXMtNfOHkhc
	 KHyWvKhZZtvnN9B48Gt2SBMuSbm+WvWd4SpgYLegpVnw1RMN33/nr5TF8Mn4+7kKW4PdL
	 jVYN3vWcFMkOGOU9efyl7FttEZY5OsOhRpzJU6gbbuAvqesQWiGswAP7/6p5M/ppYXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030373;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=j9YpXEbp3fZTfnP+Vj8VaxG/wo2GYainD3WdqV+Bya8=;
	b=zJDE0v4rVQUoy5bTXc7eAa3qRPRUDeMmSQFWoRmXbu9EA9yh9AuBRFpUi+5S0a3zywRZ
	 NNqhh4X6imFT2aeZIsb5F6qhSjswFWGsw0RqzXLoG8H5JGkyNCQUQSkq1m0g3NIp9sYXE
	 WEXXCZhkh9U9S7eZo7lFbr+DovsttMzN/BEBThzBDIUkMzy4pisiuahFPQDVOi4oPzyuK
	 wcA5KlO4YNA4EF76EQ/MnkIXxP0Dd2Yub0JOjs1Zzjbp4roJdtVbofN3ECXnKz7Qbah0F
	 uVyetBPVeCs6Y6mzTH7T+U5bWJGbbgpC5jeUQOPKPeXyV/wdPbuWPOAO+6kVnkbZb5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORmFDI7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68F606A31F;
	Mon, 26 Oct 2026 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORmFDI7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FECF1F01825;
	Mon, 26 Oct 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030373;
	bh=j9YpXEbp3fZTfnP+Vj8VaxG/wo2GYainD3WdqV+Bya8=;
	h=From:To:Cc:Subject:Date;
	b=ORmFDI7iIVvOP8D9xvkgLlDafiiOLu6bWrWXvKSljeMKcHCPWy3KSGSa5ZTQ+AdAv
	 MSLY2QHoMo7d6rbZcpBOQzzSyR2XuyPQQyScnVG9xc95hj5nlwVySkAnvSUQkwqBzE
	 RZe5SHEj7FQVXLX02zGovVHalDrBT/wUcrECwTwkoKM3mZkki/OMKCFASTonkPwMjq
	 Z58oFgmgFeUFhFTmOKG4fOadWScZzobfwe0ypVcFLB6z0kvZ+hsR+7/iY9pPK9mmcM
	 ULuRf4jO97JOZjw24QPEA3V5j2loRsL3y5EFxJuAI00cE1ZcxFfqrEOMOkT2JEAM0t
	 AgORspyPazVoA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	linux-ppp@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Felix Fietkau <nbd@nbd.name>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v2 net] ppp: linearize and segment bridged packets when required
Date: Mon, 26 Oct 2026 16:59:27 +0100
Message-ID: <20261026155927.707655-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PPP channel bridging hands packets received on one channel directly to
the start_xmit() of another. Packets received by PPPoE can be
non-linear, GSO since commit 55a5d8fca836 ("net: pppoe: implement
GRO/GSO support"), or CHECKSUM_PARTIAL when injected with a
virtio_net_hdr. The regular transmit path never sees such packets, and
only PPPoE, which uses dev_queue_xmit(), handles them:

- PPP Async reads the whole packet through skb->data, transmitting
  unrelated memory for non-linear packets.
- PPP Async and Sync send GSO packets as single frames of up to 64KB,
  and CHECKSUM_PARTIAL packets with a bad L4 checksum.
- PPTP and L2TP cannot segment a TCP GSO packet once their GRE or UDP
  header is pushed, and do not finish pending checksums.

Add a xmit_offload flag to struct ppp_channel, set for PPPoE. For other
channels, segment GSO packets in software, using the PPP protocol field
as the L2 header, finish CHECKSUM_PARTIAL checksums (including SCTP
CRC32c), and linearize packets for channels without direct_xmit, as
ppp_push() does. Packets are dropped if any step fails, or if the
channel is busy, as before.

skb->dev is NULL at this point for PPPoE (cleared by __sk_receive_skb()),
and tunnel and IPv6 UFO GSO handlers dereference it: only TCP, UDP L4
and fraglist GSO packets without encapsulation are segmented, others
are dropped.

Receive paths like L2TP pull headers without updating the checksum
state, possibly leaving a CHECKSUM_PARTIAL state with csum_start before
skb->data. Reset it to CHECKSUM_NONE, as skb_postpull_rcsum() does, so
that skb_checksum_help() does not warn, and so that PPPoE does not
offload a checksum at a wrong offset.

Tested in a VM by bridging PPPoE (on a TAP with IFF_NAPI_FRAGS, or on
veth) to PPP Async on a PTY, PPPoL2TP and PPPoE: non-linear packets no
longer leak garbage, GSO packets (including fraglist GRO) are sent as
valid segments for IPv4 and IPv6, CHECKSUM_PARTIAL packets get a valid
checksum, and PPPoE still receives GSO packets unchanged.

Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls")
Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260908072135.877364-1-qingfang.deng@linux.dev
Co-developed-by: Qingfang Deng <qingfang.deng@linux.dev>
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: addressed Sashiko feedback
 - Only segment TCP, UDP_L4 and fraglist GSO skbs without encapsulation,
   skb->dev is NULL here.
 - Reset stale CHECKSUM_PARTIAL state with csum_start before skb->data.
 - Use skb_csum_hwoffload_help(skb, 0) to handle SCTP CRC32c.
v1: https://lore.kernel.org/netdev/20261022111039.85112-1-edumazet@kernel.org/

 drivers/net/ppp/ppp_generic.c | 95 ++++++++++++++++++++++++++++++++++-
 drivers/net/ppp/pppoe.c       |  1 +
 include/linux/ppp_channel.h   |  1 +
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893ba94b5ff3f69f8e25dcd944ef01a8..82a1b7a7300ea9b17e28c6f6c8a3a0da7608f4f2 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -45,6 +45,7 @@
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/unaligned.h>
+#include <net/gso.h>
 #include <net/netdev_lock.h>
 #include <net/slhc_vj.h>
 #include <linux/atomic.h>
@@ -2278,6 +2279,73 @@ static bool ppp_decompress_proto(struct sk_buff *skb)
 	return pskb_may_pull(skb, 2);
 }
 
+#define PPP_BRIDGE_GSO_TYPES (SKB_GSO_TCPV4 | SKB_GSO_TCPV6 |		\
+			      SKB_GSO_TCP_ECN | SKB_GSO_TCP_ACCECN |	\
+			      SKB_GSO_TCP_FIXEDID | SKB_GSO_UDP_L4 |	\
+			      SKB_GSO_FRAGLIST | SKB_GSO_DODGY)
+
+/* Segment a GSO packet (built by PPPoE GRO, or injected with a
+ * virtio_net_hdr) before sending it to a bridged channel that does
+ * not accept GSO packets.
+ * skb->data points to the PPP protocol field, which is replicated
+ * in front of each segment.
+ * Returns a list of segments, or NULL if the packet was dropped.
+ */
+static struct sk_buff *ppp_bridge_gso_segment(struct sk_buff *skb,
+					      netdev_features_t features)
+{
+	struct sk_buff *segs;
+
+	/* skb->dev is NULL here (cleared by __sk_receive_skb() for PPPoE),
+	 * and some GSO handlers (tunnels, IPv6 UFO) dereference it.
+	 */
+	if (skb->encapsulation ||
+	    (skb_shinfo(skb)->gso_type & ~PPP_BRIDGE_GSO_TYPES))
+		goto drop;
+
+	if (!pskb_may_pull(skb, PPP_PROTO_LEN))
+		goto drop;
+
+	switch (get_unaligned((__be16 *)skb->data)) {
+	case htons(PPP_IP):
+		skb->protocol = htons(ETH_P_IP);
+		break;
+	case htons(PPP_IPV6):
+		skb->protocol = htons(ETH_P_IPV6);
+		break;
+	default:
+		goto drop;
+	}
+	skb_set_network_header(skb, PPP_PROTO_LEN);
+
+	/* No checksum offload: skb_segment() computes the checksums. */
+	segs = skb_gso_segment(skb, features);
+	if (IS_ERR_OR_NULL(segs))
+		goto drop;
+
+	consume_skb(skb);
+	return segs;
+
+drop:
+	kfree_skb(skb);
+	return NULL;
+}
+
+static void ppp_bridge_xmit(struct ppp_channel *chan, struct sk_buff *skb)
+{
+	if (!chan->direct_xmit && skb_linearize(skb))
+		goto drop;
+
+	if (!chan->xmit_offload && skb->ip_summed == CHECKSUM_PARTIAL &&
+	    skb_csum_hwoffload_help(skb, 0))
+		goto drop;
+
+	if (chan->ops->start_xmit(chan, skb))
+		return;
+drop:
+	kfree_skb(skb);
+}
+
 /* Attempt to handle a frame via. a bridged channel, if one exists.
  * If the channel is bridged, the frame is consumed by the bridge.
  * If not, the caller must handle the frame by normal recv mechanisms.
@@ -2285,6 +2353,8 @@ static bool ppp_decompress_proto(struct sk_buff *skb)
  */
 static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 {
+	struct sk_buff *segs, *next;
+	struct ppp_channel *chan;
 	struct channel *pchb;
 
 	rcu_read_lock();
@@ -2300,8 +2370,29 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 	}
 
 	skb_scrub_packet(skb, !net_eq(pch->chan_net, pchb->chan_net));
-	if (!pchb->chan->ops->start_xmit(pchb->chan, skb))
-		kfree_skb(skb);
+
+	/* Receive paths such as L2TP pull headers without updating
+	 * the checksum state: drop a stale CHECKSUM_PARTIAL state
+	 * pointing before skb->data, as skb_postpull_rcsum() does.
+	 */
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    skb_checksum_start_offset(skb) < 0)
+		skb->ip_summed = CHECKSUM_NONE;
+
+	chan = pchb->chan;
+	if (!chan->xmit_offload && skb_is_gso(skb)) {
+		/* Channels needing linear packets get linear segments,
+		 * others keep references to the original pages.
+		 */
+		segs = ppp_bridge_gso_segment(skb, chan->direct_xmit ?
+						   NETIF_F_SG : 0);
+		skb_list_walk_safe(segs, skb, next) {
+			skb_mark_not_on_list(skb);
+			ppp_bridge_xmit(chan, skb);
+		}
+	} else {
+		ppp_bridge_xmit(chan, skb);
+	}
 
 outl:
 	spin_unlock_bh(&pchb->downl);
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ee0e318d6a2a4f32f35231a412b59921b0cb6921..b54bd713cc096f7a33f07ab6a8371898aa69dd5b 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -664,6 +664,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 		po->chan.private = sk;
 		po->chan.ops = &pppoe_chan_ops;
 		po->chan.direct_xmit = true;
+		po->chan.xmit_offload = true;
 
 		error = ppp_register_net_channel(dev_net(dev), &po->chan);
 		if (error) {
diff --git a/include/linux/ppp_channel.h b/include/linux/ppp_channel.h
index 2f63e9a6cc88984c075792dcbd6c832ff45acd51..15bc3aa4f1715c265a5808fcc1cc2b93cc44c519 100644
--- a/include/linux/ppp_channel.h
+++ b/include/linux/ppp_channel.h
@@ -43,6 +43,7 @@ struct ppp_channel {
 	void		*ppp;		/* opaque to channel */
 	int		speed;		/* transfer rate (bytes/second) */
 	bool		direct_xmit;	/* no qdisc, xmit directly */
+	bool		xmit_offload;	/* accepts GSO and CHECKSUM_PARTIAL skbs */
 };
 
 #ifdef __KERNEL__
-- 
2.53.0

