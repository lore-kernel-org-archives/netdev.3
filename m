Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1A2DA768
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599193; cv=none; b=jv14M3wP0Pe53AW3Ip6SfGWN95QZEg0lPXTLkASsU3hBneEcmjSzrmO2ebN93cEFAsisF3ESKCEnTmp08CVTFyEuRi0hrF/08fj8ogIr4wg2x6puUNYA6olcLo4DbArdCnnj55a94N9IbmRb33ejBKo40UO9pZA19DgrCjzQ6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599193; c=relaxed/simple;
	bh=YVeq9CtY/IaVW6LPRQk0xQgmtLciO52L2ehFdDEMifU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZ3tQs5fgunvILK4Nh1rYsANHz1G6Bzg5Gy3iW1crJf9/x97z3kiF69OGtlqBYscblKpuRSaPja5mgiKrRkKkyuPO+LVxQY42J8cCIFNBGspggNzAo7UXplHDJTsexbO1HJ64mctxNiTHOB+GrRBUHxWC/oQLi7DpOzWh/1nawQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zlX14+Ns; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XlabYrFv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlX14+Ns";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XlabYrFv"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790599188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp8S297gjLRBoY1AkuXA4UPSh7LCU0vHr7SHgvujdj8=;
	b=zlX14+NsO4ho/O14FodpXBQcSYa4p6oSrl4ve52Nrlburi/d+SHqTC8x2N5HCTmcscGzbF
	d67dBOD6tZOs7E6ed1/cX9WEkYCoa+n/Bvo8sATnsGsgDdlwy9lMtHaZWQV8cL2frFvPMf
	/GUs5ezW5hEoWwdVPZeLjgdrFCDqKuAx/JellVVVQ8z6EttKJm1qe6wWrLHGJESLmQ1hH/
	6y7vQOOyOZnofZ5N1p5fwA/VV4SPYjXo7/zghtEUIXiECovHVqWfIR62QPi0nMGlA0LD4U
	HmTNjptKMNGC8ZFm3dF9r8l6DhoMnd9Vw9d1+pA1RlfHqio28ycW4Y3Vc2AQNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790599188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp8S297gjLRBoY1AkuXA4UPSh7LCU0vHr7SHgvujdj8=;
	b=XlabYrFvJk8FYYa+5wmsiC7qZehXU1UM0KtODAoHmIPYjI9YedlZGHJJYCMcdhIadS8SUu
	AvDCnDdVQ+alp0BA==
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
Subject: [PATCH net-next v7 4/8] hsr: Drop received PTP packets
Date: Mon, 28 Sep 2026 14:39:38 +0200
Message-ID: <20260928-hsr_ptp-v7-4-d55d304d9a7e@linutronix.de>
In-Reply-To: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
References: <20260928-hsr_ptp-v7-0-d55d304d9a7e@linutronix.de>
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
VLAN tagged packets are not considered.

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

