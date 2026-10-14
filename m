Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56954A7EC
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989055; cv=none; b=NWQE0tW5uG4x9H+kf5YAML9o0/1V6cgpolaHmxxdhplvZgNJ+nPw0G/sTsLEGNoteDadSiOr12lUHMxgDikwN3V9IUv6tmjMDus4VKCWhL41bc/GPDBinXvcKzHC3jMutgkk+SPhjzjVfrji+CSF8rw9QtJHCdkOrywh2sruNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989055; c=relaxed/simple;
	bh=EjxfDpZQfHyOHx3lwbaS7NjPz1Ha4LaOazWNHXxVTS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3Us14UR5dHF3Bfl6ObV8W8g3zFhXDS+cwrtBvJKXjNg88wTA4kZK3y7v7nnIM0IcTHRXG0PRcuh+a998mQzm8D3AnOxyBhd28hRN16PzmO8uPfBpn/WDpjg14unwIvmaZ3MPkE4nP1ec1oJWCfCiDFYolACmhbKXuPaJO4IPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyDeW6P4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iBAcs2IL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyDeW6P4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iBAcs2IL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791989047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2x/gTywWRdqwLCDLJymyFiAez2A0suR3hXCUpPQZeI=;
	b=AyDeW6P4//lEQlPOtvep3sJQwiSWOJFKs46K8aC78Ugo9V6l975DecpY9pkwuXUxmkYJqT
	54sxQLsqAwVLI9ApVr8+B/Xz+Ordc/gs13ywW/7TfGXvRiR6A1hZKDwOjpZrI71Bkp9BKO
	b40pRSZltmikeS+iIcaX85qUYRs7uCiFpGMgQAVkWwfw7Xe+fBqlEXQEr7rPJuzNyiSL5g
	EQ8qzv2fTlQlvxZQND6viOieITNKPxDMMEIxtjqFXMR6Cyb0MJTkw2zEFugdh2v/hzMB0b
	5uh+Cbb3bGHMlxItuMqqhdC6YD4eZH0Y73hV1mI7yKy+A3PMfzRIpqwrtSntXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791989047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2x/gTywWRdqwLCDLJymyFiAez2A0suR3hXCUpPQZeI=;
	b=iBAcs2ILV35K2FpXpXiTmgNL2gzws9uk7h/KgA2kPcX6Pg6OnBl8x2fVRy1FbQZ/CwXS2x
	z8hjls+LA/+SG7AA==
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
Subject: [PATCH net-next v9 3/8] hsr: Add a magic header for sending PTP packets
Date: Wed, 14 Oct 2026 16:43:57 +0200
Message-ID: <20261014-hsr_ptp-v9-3-2d20a2a0f816@linutronix.de>
In-Reply-To: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
References: <20261014-hsr_ptp-v9-0-2d20a2a0f816@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
 include/uapi/linux/hsr_ptp.h | 20 ++++++++++++++
 net/hsr/hsr_device.c         | 66 ++++++++++++++++++++++++++++++++++++----=
----
 net/hsr/hsr_forward.c        |  3 +-
 net/hsr/hsr_forward.h        |  3 +-
 net/hsr/hsr_slave.c          |  4 +--
 7 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8d3c1..5f8bed05ed6b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12023,6 +12023,7 @@ F:	drivers/net/usb/hso.c
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
index 0000000000000..a0b104a3df569
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
+	__u8 tx_port;
+	__u8 hsr_hdr;
+	__u8 __pad0[4];
+	__be32 magic;
+	__u8 __pad1[2];
+	__be16 eth_type;
+} __attribute__ ((packed));
+
+#endif
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 6d96bc4a12446..c5ea7ef0209db 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -223,24 +223,66 @@ static netdev_features_t hsr_fix_features(struct net_=
device *dev,
=20
 static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *de=
v)
 {
+	enum hsr_port_type tx_port =3D HSR_PT_NONE;
 	struct hsr_priv *hsr =3D netdev_priv(dev);
 	struct hsr_port *master;
+	bool has_header =3D false;
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
+		hsr_opt =3D (struct hsr_inline_header *)skb_mac_header(skb);
+		if (hsr_opt->magic !=3D htonl(HSR_INLINE_HDR))
+			goto drop;
+
+		has_header =3D hsr_opt->hsr_hdr;
+		tx_port =3D hsr_opt->tx_port;
+		if (tx_port !=3D HSR_PT_SLAVE_A && tx_port !=3D HSR_PT_SLAVE_B)
+			goto drop;
+
+		if (has_header)
+			hdr_len =3D ETH_HLEN + HSR_HLEN;
+		else
+			hdr_len =3D ETH_HLEN;
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
+	hsr_forward_skb(skb, master, tx_port, has_header);
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
@@ -362,7 +404,7 @@ static void send_hsr_supervision_frame(struct hsr_port =
*port,
 		return;
 	}
=20
-	hsr_forward_skb(skb, port);
+	hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 	spin_unlock_bh(&hsr->seqnr_lock);
 	return;
 }
@@ -430,7 +472,7 @@ static void send_prp_supervision_frame(struct hsr_port =
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
index 5862c05f52110..2b8ae9723bd7f 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -771,7 +771,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
 }
=20
 /* Must be called holding rcu read lock (because of the port parameter) */
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
+		     enum hsr_port_type tx_port, bool has_hsr_header)
 {
 	struct hsr_frame_info frame;
=20
diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
index 206636750b300..e64b0358907a9 100644
--- a/net/hsr/hsr_forward.h
+++ b/net/hsr/hsr_forward.h
@@ -13,7 +13,8 @@
 #include <linux/netdevice.h>
 #include "hsr_main.h"
=20
-void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
+void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
+		     enum hsr_port_type tx_port, bool has_hsr_header);
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

