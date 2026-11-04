Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805054;
	b=B+ksOeQ0g7ZvD5G6sTrFGdkFAYloO596h9gRXrjJGTs413OczuJmIlPMwOsMY5xtBieU
	 h0A5K4/GVj6fwfvWq9MqEAGrFJcb4WLpd3u78T14TC2zSBEvnMpXqFtS+hy//DMjWmg8M
	 UufH+Qq+T2EwaMUymtl73cvglM1ob9e6jbFo6m95WflpyB4p4jgbn9VX+JGLc7lVpCW8H
	 Fkf9cnOXwYvrGbfo15MP6/Ulkj9n4H4RJoCqiy8HqNeyppxPjbC6aFan1ILhCSQbw1fun
	 kjx2woActpfPy/RhG8jKWG1EEttJmXcKNKPNRHH4NOezaV8Dh5Sph3rPw8Dza4BtUyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805054;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7E9yjvkq5m30Z1wccCFeP/Oh2Z/BELtqT0Znb3jqqGE=;
	b=BDYZWBzvNLortBEwT+J51/3MHUjI2F6BEoftkyPeC0lhDxWJv23ooNeMNGe/qbNln98Z
	 ecz+sT4muBkqz6utSgropovlQTPKl1mdEN9KjDVRkmsQ0skRnzNxrBPY+w8MIfKyWKvkb
	 1LzF69XT6NdU9UQ85M5aGvsbFWm9vfYCW/nw6X/37WddySkWhn359cYyHKGVWPOdyfY7B
	 7Des3JmvMph38gJDyVXnhtXcsHCtYk3M9D7c8MpijqjvQ4MrJYSfJC47WZn106xM3iA/9
	 ul1RQNl0tMep/8TWSVa28Ufw3mAQKezaoxunTbCAT3CJQhJ1ChEfqgqJQlUqqQL8LBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=B0RNAbHa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=NKRjjp1J;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CF606A33E
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B73CF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=B0RNAbHa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=NKRjjp1J
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793805052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7E9yjvkq5m30Z1wccCFeP/Oh2Z/BELtqT0Znb3jqqGE=;
	b=B0RNAbHaXy2PAbiarr62u5g8fYf4gC51Dpljd/SjZWm94FxGvpsRs33//Yf9YDy9Z9IMvm
	NHbFNUor6RMyAkUbpKWzMUBllibCeSxdLMniY9UGyTyxA+A8b6hSb3VIqyVNcre628ahdn
	NttKObxkv4ecWQyHLrNjSxCC/z5khl3GihjsHRyvqIwNU8fSHqwNrkgFj4pLyJxUmCnPVt
	uPpHD6WyirvAqapl4ge29eJw8qmwJz//zwvpWgtsTaO/o7c566HUCZj0Kq0g3t91+ZSqH6
	eNdDN7hapqlEd2ZTqV2ropl/vu4o6KXo+9SVT/gJUMxbyjBBuhRlxQtcoLsAsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793805052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7E9yjvkq5m30Z1wccCFeP/Oh2Z/BELtqT0Znb3jqqGE=;
	b=NKRjjp1J8cmlUKNJcOxr49eqLKwa9cSZY43NJkx29bnZIf6ILBR9g9qvVY37dxPUfLEhu1
	F2zHfLxtf2skeWCg==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net-next v10 3/8] hsr: Add a magic header for sending PTP packets
Date: Wed,  4 Nov 2026 16:10:39 +0100
Message-ID: <20261104-hsr_ptp-v10-3-2c4a38ad973c@linutronix.de>
In-Reply-To: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
References: <20261104-hsr_ptp-v10-0-2c4a38ad973c@linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sending PTP packets (ETH_P_1588) via the HSR stack is pointless in its
current shape because the requested PTP timestamp is not routed to the
sender. It also needs to be distinguished on which port the message
should be sent and whether or not a HSR header should be attached.

To pass this information, a custom header (struct hsr_inline_header) is
introduced. This header is expected and mandatory if the ether type is
ETH_P_1588. To avoid any wrong usage, there is a magic field to ensure
it really is the header.

The inline header is just prepended containing the port and header
parameter. After the header, a regular packet follows. It is ensured that
the inline header and the following ethernet or HSR header is linear
and can be accessed. Given that this information is important for how
PTP is used, PTP packets missing this information will be dropped.

The two retrieved parameters are passed to hsr_forward_skb() and will be
used later.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 MAINTAINERS                  |  1 +
 include/linux/if_hsr.h       |  1 +
 include/uapi/linux/hsr_ptp.h | 20 +++++++++++++
 net/hsr/hsr_device.c         | 71 ++++++++++++++++++++++++++++++++++++----=
----
 net/hsr/hsr_forward.c        |  3 +-
 net/hsr/hsr_forward.h        |  3 +-
 net/hsr/hsr_slave.c          |  4 +--
 7 files changed, 87 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065d..bd8f678710153 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12306,6 +12306,7 @@ F:	drivers/net/usb/hso.c
 HSR NETWORK PROTOCOL
 L:	netdev@vger.kernel.org
 S:	Orphan
+F:	include/uapi/linux/hsr_ptp.h
 F:	net/hsr/
 F:	tools/testing/selftests/net/hsr/
=20
diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index f4cf2dd36d193..7b6b60ef592db 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -3,6 +3,7 @@
 #define _LINUX_IF_HSR_H_
=20
 #include <linux/types.h>
+#include <uapi/linux/hsr_ptp.h>
=20
 struct net_device;
=20
diff --git a/include/uapi/linux/hsr_ptp.h b/include/uapi/linux/hsr_ptp.h
new file mode 100644
index 0000000000000..95e905441ebdc
--- /dev/null
+++ b/include/uapi/linux/hsr_ptp.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef __UAPI_HSR_PTP_H
+#define __UAPI_HSR_PTP_H
+
+#include <linux/types.h>
+
+#define HSR_INLINE_HDR  0xaf485352
+#define HSR_INLINE_HDR_PORT_A	1
+#define HSR_INLINE_HDR_PORT_B	2
+
+struct hsr_inline_header {
+	__u8 req_tx_port;
+	__u8 has_hsr_header;
+	__be32 __pad0;
+	__be32 magic;
+	__be16 __pad1;
+	__be16 eth_type;
+} __attribute__ ((packed));
+
+#endif
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 59df647d2fd45..1cd871b1e8b37 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -223,24 +223,71 @@ static netdev_features_t hsr_fix_features(struct net_=
device *dev,
=20
 static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *de=
v)
 {
+	enum hsr_port_type req_tx_port =3D HSR_PT_NONE;
 	struct hsr_priv *hsr =3D netdev_priv(dev);
 	struct hsr_port *master;
+	bool has_hsr_header =3D false;
=20
 	rcu_read_lock();
 	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
-	if (master) {
-		skb->dev =3D master->dev;
-		skb_reset_mac_header(skb);
-		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
-	} else {
-		dev_core_stats_tx_dropped_inc(dev);
-		dev_kfree_skb_any(skb);
+	if (!master)
+		goto drop;
+
+	skb->dev =3D master->dev;
+	if (skb->protocol =3D=3D htons(ETH_P_1588)) {
+		struct hsr_inline_header *hsr_opt;
+		struct ethhdr *eth_hdr;
+		unsigned int hdr_len;
+
+		BUILD_BUG_ON(sizeof(struct hsr_inline_header) !=3D sizeof(struct ethhdr)=
);
+
+		/* need to access the magic header */
+		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
+			goto drop;
+
+		if (!skb_mac_header_was_set(skb))
+			skb_reset_mac_header(skb);
+
+		hsr_opt =3D (struct hsr_inline_header *)skb_mac_header(skb);
+		if (hsr_opt->magic !=3D htonl(HSR_INLINE_HDR))
+			goto drop;
+
+		has_hsr_header =3D hsr_opt->has_hsr_header;
+		req_tx_port =3D hsr_opt->req_tx_port;
+		if (req_tx_port !=3D HSR_PT_SLAVE_A && req_tx_port !=3D HSR_PT_SLAVE_B)
+			goto drop;
+
+		if (hsr_opt->__pad0 !=3D 0 || hsr_opt->__pad1 !=3D 0)
+			goto drop;
+
+		hdr_len =3D ETH_HLEN;
+		if (has_hsr_header)
+			hdr_len +=3D HSR_HLEN;
+
+		/* Ensure the real header after the stripped one can be
+		 * accessed
+		 */
+		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header) +
+				   hdr_len))
+			goto drop;
+
+		eth_hdr =3D skb_pull(skb, sizeof(struct hsr_inline_header));
+		skb_set_network_header(skb, hdr_len);
+		skb->protocol =3D eth_hdr->h_proto;
 	}
+
+	skb_reset_mac_header(skb);
+	skb_reset_mac_len(skb);
+	spin_lock_bh(&hsr->seqnr_lock);
+	hsr_forward_skb(skb, master, req_tx_port, has_hsr_header);
+	spin_unlock_bh(&hsr->seqnr_lock);
 	rcu_read_unlock();
=20
+	return NETDEV_TX_OK;
+drop:
+	rcu_read_unlock();
+	dev_core_stats_tx_dropped_inc(dev);
+	dev_kfree_skb_any(skb);
 	return NETDEV_TX_OK;
 }
=20
@@ -362,7 +409,7 @@ static void send_hsr_supervision_frame(struct hsr_port =
*port,
 		return;
 	}
=20
-	hsr_forward_skb(skb, port);
+	hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 	spin_unlock_bh(&hsr->seqnr_lock);
 	return;
 }
@@ -430,7 +477,7 @@ static void send_prp_supervision_frame(struct hsr_port =
*master,
 		return;
 	}
=20
-	hsr_forward_skb(skb, master);
+	hsr_forward_skb(skb, master, HSR_PT_NONE, false);
 	spin_unlock_bh(&hsr->seqnr_lock);
 }
=20
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index b183358207506..f49d962337f8b 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -771,7 +771,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 }
=20
 /* Must be called holding rcu read lock (because of the port parameter) */
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
+		     enum hsr_port_type req_tx_port, bool has_hsr_header)
 {
 	struct hsr_frame_info frame;
=20
diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
index 206636750b300..662dd369c7df2 100644
--- a/net/hsr/hsr_forward.h
+++ b/net/hsr/hsr_forward.h
@@ -13,7 +13,8 @@
 #include <linux/netdevice.h>
 #include "hsr_main.h"
=20
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
+		     enum hsr_port_type req_tx_port, bool has_hsr_header);
 struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
 					struct hsr_port *port);
 struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index a546f70f9cc8b..5274ba6dd36e6 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -78,10 +78,10 @@ static rx_handler_result_t hsr_handle_frame(struct sk_b=
uff **pskb)
 	 */
 	if (port->type =3D=3D HSR_PT_INTERLINK) {
 		spin_lock_bh(&hsr->seqnr_lock);
-		hsr_forward_skb(skb, port);
+		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
-		hsr_forward_skb(skb, port);
+		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 	}
=20
 finish_consume:

--=20
2.55.0

