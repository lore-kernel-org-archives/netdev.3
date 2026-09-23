Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15494FE2E0
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165664; cv=none; b=UjQmh2cfix4w5TgDZ0jBpQfT0IWRGAr3bvHk6ZSL8u95es4FaICyTnm81+98WN5//jBKY7R0fPiYzBT4NHrGNSaZ9JP5NbEkVgvOlbH8eSiChf1TKtvuzvTSjMIkf//kA8iHUiRq87b901B6kd0RkZsN+sD1JAZCvBvIsNwhJhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165664; c=relaxed/simple;
	bh=8NIt/HEltpMWb3E1EcZKrEWbGw6Dztgz1xdHZeM2pzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PI4NYanMmo8OtriHfYJNpXHbpWH5tFeS/9TFzvhcevt3jZS+aZK8mMorNtFbvxeD+2N0Bj4uSq3JaKrahyfsJOv/EqMCVgUINiyJwMSem0b1C7D7Qk6zu/indB/pa4C2AtK51bqsXI7HJXY7ujzAhz/bjAVAAWBd0T5J8szzwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HrRAd8hv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qqYtD8nk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HrRAd8hv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qqYtD8nk"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790165655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQsgAfO3G0xrwQQrmV/dYFruxkkucXiLMW7rcLFNAnc=;
	b=HrRAd8hv/FcoJ+Mnh1dBmZOkQfstGcQqwzLE+IlXrvJDcFpU1woXxNURgRbnvhkPHy4kCb
	S3uAjroeGPPDOLXalC2pRNdq/UpluJrEXs8QxUg38oeiPky2/HeM5EqQc3rmn/kOPoe7IK
	jnJIC+f3/i/LkvPcu0hZfXmct4U1+7d9qcnSq3XJHQOd0McB3Yd39Jw/Wpy67LZtiY7QVb
	RkpSlQ76q0y6xDYoI5UbA8sY8wGfr4WFMqHuX1d7u6iMY1bG3xUUq4Y77/P92OvCE/M9kL
	gag0ZNJ0mNlPDUtV85VQ2HM9+OOypbemVw2T29+1mk4UWEaPc92dtobQTxuYGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790165655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQsgAfO3G0xrwQQrmV/dYFruxkkucXiLMW7rcLFNAnc=;
	b=qqYtD8nk77zdzPKtBr3KCVThXlSj1EaDHa7R6lJr2kqX4vmN3FSVNL/q+tSR521Kf1IqUu
	82Qt3wBmjfF9LJBg==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v6 3/8] hsr: Add a magic header for sending PTP packets
Date: Wed, 23 Sep 2026 14:14:04 +0200
Message-ID: <20260923-hsr_ptp-v6-3-6ea07b3fb8a8@linutronix.de>
In-Reply-To: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
References: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
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
and can be accessed.

The two retrieved parameters are passed to hsr_forward_skb() and will be
used later.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/if_hsr.h | 11 +++++++++
 net/hsr/hsr_device.c   | 66 +++++++++++++++++++++++++++++++++++++++++-----=
----
 net/hsr/hsr_forward.c  |  3 ++-
 net/hsr/hsr_forward.h  |  3 ++-
 net/hsr/hsr_slave.c    |  4 +--
 5 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index f4cf2dd36d193..1db1bd0fa181d 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -3,6 +3,7 @@
 #define _LINUX_IF_HSR_H_
=20
 #include <linux/types.h>
+#include <linux/skbuff.h>
=20
 struct net_device;
=20
@@ -22,6 +23,16 @@ enum hsr_port_type {
 	HSR_PT_PORTS,	/* This must be the last item in the enum */
 };
=20
+#define HSR_INLINE_HDR	0xaf485352
+struct hsr_inline_header {
+	uint8_t tx_port;
+	uint8_t hsr_hdr;
+	uint8_t __pad0[4];
+	__be32 magic;
+	uint8_t __pad1[2];
+	__be16 eth_type;
+} __packed;
+
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype =3D 0=
x88FB,
  * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
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
index 0c16fbf8fd14f..7cae91dd3fc6b 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -776,7 +776,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
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

