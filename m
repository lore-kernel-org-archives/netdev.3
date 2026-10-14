Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5471A54B1C5
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989054; cv=none; b=kOWVToHPn3vKf6XukBB0xKHdP6l8cAHFws6CgiEtUiuzVhmOcBVB1kmNvR93Nj5XpFwmBIwoeyvNNJRTLHcqHaHDm7U3OsyLbqFx8ADWGZEJ8ZPtJZsC+lNgvwIBgPE61pAHDWMGKFQXjNyq2BNg02RM0Y4REry6AzCNrtF8xMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989054; c=relaxed/simple;
	bh=ItHZWa8f9H6c4EcHSDVx7iABp/1/RYlL9cKJ1ujkKAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oil6mBnOlDuwF4SDTHXLV4p6cujaULodIhkdqFKXAaySf6IXFxr3TV8NZI6H0hFnXadFa/gFC5uzsnJ3PIJZc0DXWNq/yvi+MFdWSQmGIskDAYiaVMAE3CtlP1Y5N/ky6Wqq+VxrtatZ/VYwuUcM4dTxWYoS68OkzzcwbxrvgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KHi8YSbd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pigbROkG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KHi8YSbd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pigbROkG"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791989048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsPJvjOHxsnXO3qbskSb575mE9fZ07WzDedy1v2sTnA=;
	b=KHi8YSbdumTXgQk0sKRboABGZwEyV+bhybKdPt0HhFmLLT/kl2Bnjhx8xItNWQNdVtf0Co
	Z4Ym2xb+O3UmzwqrsJcfl63x/xZ+te7XGqkvIDZNBM/Ai4XB84guyE6V7Ui44uCC4irE0P
	pBawCa95BdF2DYJn3u4q7QTaPSQWni6SaveGK6Ows+vbzT9HR0uXlFtf18Bs4z+XIVAsRs
	jQ6UAH+u+SPutQqu3dl/M54Q5iQ4G38tZ5C8/UF0hOxzbdsk0VlWLZb/giBvlUjE9gWQhm
	tJ6Av/JHfRElSdDb7R8HYLdfGSiQP26p/f7KJkNQRYGLB6QTI5jp22VzoNoPlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791989048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsPJvjOHxsnXO3qbskSb575mE9fZ07WzDedy1v2sTnA=;
	b=pigbROkGYkiXScIjPa4sDthg4+my7I7Yu8Flx1n3fKk5+l+jijj1Xn+4peg5U6V514T6/9
	zu1CBIkeZ5jSrIDA==
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
Subject: [PATCH net-next v9 4/8] hsr: Drop received PTP packets
Date: Wed, 14 Oct 2026 16:43:58 +0200
Message-ID: <20261014-hsr_ptp-v9-4-2d20a2a0f816@linutronix.de>
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

Receiving PTP packets via the HSR interface does not make sense. The HSR
stack will forward one copy to the user and ignore the duplicate from
the other port. The PTP stack is however interested in both copies since
they will have different content (due to different processing times
within the HSR ring) and different timestamp information which is not
forwarded at all.

Forwarding a PTP packet by the HSR stack is undesired because the
forwarding takes time, it is not accounted in the packet and this makes
the outgoing PTP packet inaccurate and therefore useless.

Drop all received PTP packets. For the PRP configuration it is the
ether type, for HSR configuration it is the encapsulated protocol, that
is checked. A PTP stack that is doing PTP over a HSR network needs to
retrieve the PTP packet on the original slave interface where it was
received.
VLAN tagged packets are not considered. L3 packets (PTP over UDP) is not
considered because it is not part of the HSR specification.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_slave.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 5274ba6dd36e6..a5b47f016abd7 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -23,6 +23,7 @@ bool hsr_invalid_dan_ingress_frame(__be16 protocol)
=20
 static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 {
+	struct hsr_ethhdr *hsr_ethhdr;
 	struct sk_buff *skb =3D *pskb;
 	struct hsr_port *port;
 	struct hsr_priv *hsr;
@@ -44,8 +45,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buf=
f **pskb)
=20
 	if (hsr_addr_is_self(port->hsr, eth_hdr(skb)->h_source)) {
 		/* Directly kill frames sent by ourselves */
-		kfree_skb(skb);
-		goto finish_consume;
+		goto finish_free_consume;
 	}
=20
 	/* For HSR, only tagged frames are expected (unless the device offloads
@@ -64,15 +64,28 @@ static rx_handler_result_t hsr_handle_frame(struct sk_b=
uff **pskb)
 	skb_reset_mac_header(skb);
 	if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
 	    protocol =3D=3D htons(ETH_P_HSR)) {
-		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN)) {
-			kfree_skb(skb);
-			goto finish_consume;
-		}
+		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN))
+			goto finish_free_consume;
=20
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
 	}
 	skb_reset_mac_len(skb);
=20
+	/* PTP packets are not supposed to be forwarded via HSR as-is. The
+	 * latency introduced by forwarding renders the time information
+	 * useless. Userland needs to capture the packet on the original
+	 * interface instead of hsr.
+	 */
+	if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
+	    protocol =3D=3D htons(ETH_P_HSR)) {
+		hsr_ethhdr =3D (struct hsr_ethhdr *)skb_mac_header(skb);
+		if (hsr_ethhdr->hsr_tag.encap_proto =3D=3D htons(ETH_P_1588))
+			goto finish_free_consume;
+	} else {
+		if (protocol =3D=3D htons(ETH_P_1588))
+			goto finish_free_consume;
+	}
+
 	/* Only the frames received over the interlink port will assign a
 	 * sequence number and require synchronisation vs other sender.
 	 */
@@ -84,7 +97,10 @@ static rx_handler_result_t hsr_handle_frame(struct sk_bu=
ff **pskb)
 		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 	}
=20
-finish_consume:
+	return RX_HANDLER_CONSUMED;
+
+finish_free_consume:
+	kfree_skb(skb);
 	return RX_HANDLER_CONSUMED;
=20
 finish_pass:

--=20
2.55.0

