Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599774;
	b=eYmgrCB0+e5COo3+A5YpUUim/U06rw3Xon+7HmdvA/eLlLrVzPmUD6fYRFHWEBpe+Bzh
	 iFq1X6nxJj76N2sFszL0ycaJr3tvPC0u8nj0ORfJou8PfM1PniqUJeegb44V9w7ZZlY2v
	 GPszSJCjPnIcm/1JsycqDf/YMePkIRKPQgf/k3tOmqJdx3Ln3fdXKU+KEiQ2K3o70mBfw
	 8AYNC65RLa+sTs02b5QKKg0lkJDYmYTIWPlQBR4OvjyKqOMB7DBK9PAJbK3F8D/MpYTlp
	 /5WdZpRGUc5xmAA97/7sk4HGq76s5RnSWNXqRJ0s+AzNiegvkRgTf9AEcGSHW5mcTrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599774;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=C9JNMy87F5GjSumUJ/1eB0UMECSuf0ETEpR6hvHEzLQ=;
	b=is5i1KxEmcRjG1+IlE/Q+LzJ/hqPUtQJTB3ICpFV4xJNm3VEpy1CCV6RavVWo8ZRgDrm
	 OdHkW9LB53vJ8lba/W/ux7FMZW33Ao/MJXBnmES3bdJ+R2R4V/V45NL3dqzJTEYtnO82n
	 J6rjS2aU2yzsdr+JkM9A50qtltSCnB13wGdX9ZUevS+u5c6wda1ylVUmdGNjsUeAGmjAY
	 ugMgOm2oPdoMUPR1Tp66oC1Markcu8K5K4KZpZ3Ej+P4n7j4SySP6ssFX8FYHSy5ILDb/
	 tZ2mPg/vTJWzIixPQUkd/utjmhfVw5ikQmQs6eeMpmdjHk+5bXOhvG3GWjZZpdpWyzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckO1749W;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F81660A3833
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F81660A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ckO1749W
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-5384e381fbbso929887b6e.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599773; x=1795204573; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C9JNMy87F5GjSumUJ/1eB0UMECSuf0ETEpR6hvHEzLQ=;
        b=ckO1749Wthm18+XiK92CDr4J+NhK81Qi2q1wxsBKkPUn7X97ioC7nbx97lysB2vzVY
         q4cCLegItsqe2Jn6y6p6iguafYLpDBGygW/XKzgLKbCh0mUeaBtiKQjPPuD++Ye7OYhb
         7iut0+AduTAdwRkZCjKlO8bN+UDg/bk0FfVdhQcyT3qSZmqxdyzS86RkHk010bA/p0Xf
         X1j1Xbmxcd9jEsmLh31qpzBrs4liDLTovHUn1CDh1OcZag78dwogyFQWZXdTgds/4L2P
         j/MWF7E6WWmp/6La1tTn+YwovzhPpXGgZ0ec7I7O2CyvrDt+0/dlULszyIvXVuMwr2n0
         X7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599773; x=1795204573;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9JNMy87F5GjSumUJ/1eB0UMECSuf0ETEpR6hvHEzLQ=;
        b=WC+atvKHL7XsdZ52FyM2WQNDd5jczdfU+cnMVxP9LZBujBxyWH2MsxLWn4hHcCGaSJ
         F1FqEqq21BA7YvzgU7mmFq4t2gYpvUHpOLZuGfskfvXmVeeU+HuKrvIerOOjNqelTV0+
         hF8LCnRdBHjvMlTqZ2VEttPXCcIIR4+2pYfIHtzZTIQMW4/FUc9HPyaAOeKa30uQ7zmU
         jnPRbhBj3JwaIrUqEajD/pE7UyZd4K403VnHZL2/5D8+R3FyW609CyZnP0DDXSbkXZzN
         JnCHouo1ATyrjELAFhmNwBfQXujR9omt8cJ//dK/d1dD7Yr9T3WA+s9BB4YmeetHwMv2
         Hn1g==
X-Gm-Message-State: APuU4Z+KSVaF/KKWcSLd4fHGdhbmj+7PPtGMsuf7uPieErgz1jmDcTj9
	a0NLLM6+ZDuAnL8n6MWonrkYWAMSYdQIkcReULdBQRYZg8cB8lR+ylH6Q9NSZcUVoLMafptoPkV
	akgafOwGFUwcG2zsMCJ7o0K8f655i7cmQe9PW3i+s7pEWb5ZyprMIhGXAKtzOfoLPXbPrxp1KPT
	8Y4gDUEhLC6nQJYQthISKWDff3XzzY/3nEFIzsp7QpqOGPwg8=
X-Received: from iloo6-n1.prod.google.com ([2002:a05:6e02:6106:10b0:523:a008:3bb])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c40a:b0:53f:4cb6:cdc1 with SMTP id 5614622812f47-56e64f0c967mr2901751b6e.34.1794599772767;
 Fri, 13 Nov 2026 11:56:12 -0800 (PST)
Date: Fri, 13 Nov 2026 11:55:53 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261113195553.2220562-1-joshwash@google.com>
Subject: [PATCH net] gve: fix checksum state and gso_segs of HW-GRO packets
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Ankit Garg <nktgrg@google.com>, 
	Tim Hostetler <thostet@google.com>, Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

With HW-GRO enabled, gve_rx_complete_rsc() turns a coalesced packet into
a GSO skb by setting gso_size, gso_segs and gso_type, but leaves it
CHECKSUM_UNNECESSARY with th->check as the device wrote it. Unlike
tcp4_gro_complete() and tcp6_gro_complete() for a SW-GRO packet, it does
not seed th->check with the TCP pseudo-header checksum or set
CHECKSUM_PARTIAL.

The GRO stack completes a HW-GRO skb itself only if it holds the skb for
merging (since commit 5eddb24901ee ("gro: add support of (hw)gro packets
to gro stack")). Otherwise the skb is delivered as is, e.g. with rx-gro
off or for a packet that is flushed immediately (e.g. with PSH set). If
such an skb is forwarded out of a TSO-capable device, netif_needs_gso()
accepts it as CHECKSUM_UNNECESSARY and the device segments it with a
bogus checksum seed, so every segment is dropped by the receiver. This
blackholes forwarded TCP traffic on VMs acting as routers or NAT
gateways and was observed on VMs in real use.

Fix it in a manner consistent with other drivers with HW-GRO: set the
network and transport headers and, for packets whose checksum the device
verified, seed th->check with the pseudo-header checksum and call
tcp_gro_complete(), passing gso_segs through NAPI_GRO_CB(skb)->count.
skb->data points at the Ethernet header on the napi_gro_frags() path and
at the IP header on the header-split and copybreak paths, so account for
that when setting the network header. Since the header layout now
matters, tell IPv4 from IPv6 by the EtherType, as qede and bnx2x do,
rather than by the packet type.

Also compute gso_segs from the TCP payload length. It was computed from
skb->data_len, which is 0 for a packet that rx_copybreak copied whole
into the linear part, leaving such packets with gso_segs 0 and a
non-zero gso_size.

Fixes: e637c244b954 ("gve: Advertise NETIF_F_GRO_HW instead of NETIF_F_LRO")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 69 +++++++++++++++-----
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 82ed5e48b00a..58696d26c698 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -13,6 +13,7 @@
 #include <linux/ipv6.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
+#include <net/gro.h>
 #include <net/ip6_checksum.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
@@ -1000,13 +1001,34 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	return -ENOMEM;
 }
 
+/* Prepare a HW-GRO packet the way tcp4/6_gro_complete() prepare a SW-GRO
+ * packet, so that it can be resegmented by GSO or TSO if it is forwarded:
+ * seed th->check with the TCP pseudo-header checksum and set CHECKSUM_PARTIAL.
+ */
+static void gve_rx_fixup_gro_checksum(struct sk_buff *skb)
+{
+	int len = skb->len - skb_transport_offset(skb);
+	struct tcphdr *th = tcp_hdr(skb);
+
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+		th->check = ~tcp_v4_check(len, ip_hdr(skb)->saddr,
+					  ip_hdr(skb)->daddr, 0);
+	else
+		th->check = ~tcp_v6_check(len, &ipv6_hdr(skb)->saddr,
+					  &ipv6_hdr(skb)->daddr, 0);
+
+	NAPI_GRO_CB(skb)->count = skb_shinfo(skb)->gso_segs;
+	tcp_gro_complete(skb);
+}
+
 static int gve_rx_complete_rsc(struct sk_buff *skb,
 			       const struct gve_rx_compl_desc_dqo *desc,
 			       struct gve_ptype ptype)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
-	int rsc_segments, rsc_seg_len, hdr_len;
+	int rsc_seg_len, hdr_len, nhoff, thoff;
 	skb_frag_t *frag;
+	__be16 proto;
 	void *va;
 
 	/* HW-GRO only coalesces TCP. */
@@ -1017,20 +1039,11 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 	if (!rsc_seg_len)
 		return 0;
 
-	switch (ptype.l3_type) {
-	case GVE_L3_TYPE_IPV4:
-		shinfo->gso_type = SKB_GSO_TCPV4;
-		break;
-	case GVE_L3_TYPE_IPV6:
-		shinfo->gso_type = SKB_GSO_TCPV6;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	if (skb_headlen(skb)) {
-		/* With header-split, payload is in the non-linear part */
-		rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
+		/* With header-split or copybreak, eth_type_trans() has already
+		 * pulled the Ethernet header.
+		 */
+		nhoff = 0;
 	} else {
 		/* HW-GRO packets are guaranteed to have complete TCP/IP
 		 * headers in frag[0] when header-split is not enabled.
@@ -1039,7 +1052,6 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 		va = skb_frag_address(frag);
 		hdr_len =
 			eth_get_headlen(skb->dev, va, skb_frag_size(frag));
-		rsc_segments = DIV_ROUND_UP(skb->len - hdr_len, rsc_seg_len);
 		skb_copy_to_linear_data(skb, va, hdr_len);
 		skb_frag_size_sub(frag, hdr_len);
 		/* Verify we didn't empty the fragment completely as that could
@@ -1049,10 +1061,35 @@ static int gve_rx_complete_rsc(struct sk_buff *skb,
 		skb_frag_off_add(frag, hdr_len);
 		skb->data_len -= hdr_len;
 		skb->tail += hdr_len;
+		/* napi_gro_frags() pulls the Ethernet header later. */
+		nhoff = ETH_HLEN;
 	}
+
+	skb_set_network_header(skb, nhoff);
+	proto = nhoff ? ((struct ethhdr *)skb->data)->h_proto : skb->protocol;
+	switch (proto) {
+	case htons(ETH_P_IP):
+		shinfo->gso_type = SKB_GSO_TCPV4;
+		thoff = nhoff + ip_hdrlen(skb);
+		break;
+	case htons(ETH_P_IPV6):
+		shinfo->gso_type = SKB_GSO_TCPV6;
+		thoff = nhoff + sizeof(struct ipv6hdr);
+		break;
+	default:
+		return -EINVAL;
+	}
+	skb_set_transport_header(skb, thoff);
+
 	shinfo->gso_size = rsc_seg_len;
-	shinfo->gso_segs = rsc_segments;
+	shinfo->gso_segs = DIV_ROUND_UP(skb->len - thoff - tcp_hdrlen(skb),
+					rsc_seg_len);
+
+	if (!IS_ENABLED(CONFIG_INET) ||
+	    unlikely(skb->ip_summed != CHECKSUM_UNNECESSARY))
+		return 0;
 
+	gve_rx_fixup_gro_checksum(skb);
 	return 0;
 }
 

base-commit: dee3429e94d8089713645706df678ec54a049e13
-- 
2.56.0.611.g1030f0b940-goog

