Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805055;
	b=XSqsd2EMXajn/lx67MjeibBoXwd45UK6WjmWeooj78yJAvvbsKukAdMbHinDVkHjUTz7
	 8vzd4yogBRhixxc+OCIANiFGRzY9LvVTITyKEfgbbzkgCbXxocxGPerve9+q8yNCiXKim
	 6RNGkUQm88TGjLcD78+Gv7eYsXpWgvkN9e5mtOBcVDBIh0KWur9mJ4iGSN0gNKV60tIsO
	 SYZIb7ayjvHt9/k6XNv8Azy99qWvI+IeIghsi6jEkGLW0b4MqjpCu9nu58eMlIeLlHxi1
	 YtKoVoKmcB3vUD2bhrMCDTpw0FTBSuWughlj2b9Q5aquhu/n1CyijhumIVuy1VVm0nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805055;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B3GJZaJfM7BaQoOKyyMag0j1vgRY7QSdAOOCj79Pwwg=;
	b=Y5N6l3ds56mrtp8uKa4UKMzd/rNjdqKDByLMjfBTLPlVJx8FxFhYMHxKPM2ZNa+90K8j
	 JIRGZpNc3ZWVOCjiBssnGTPzTTF/9r6OsfmC3JJuSzyTtRjA9R+AOrYdzH+ZXjx4wvM8r
	 Y6QCwS6HOayPVMQ3hOZLWft688QZGzfTzE3qGVXMe4CZ2NBm7LDf2RAGbcL7wIRlSF7am
	 2lCFdcpAn3ZYwkAw9HD0YaBRg0iFpXj9hec+3ayOYRc+Vpg1quPjXQw35xU7S2rK+0RYG
	 Dxv0WQNZ+ZdKWaF1+Mc39dsd4yZmHklTOr4cJnHXLq1L9ud5UaLkGi0U1QgDti4+6Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Pd69AWE9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZIj+z0Qc;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E8606D802
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B4E8606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Pd69AWE9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ZIj+z0Qc
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793805052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3GJZaJfM7BaQoOKyyMag0j1vgRY7QSdAOOCj79Pwwg=;
	b=Pd69AWE9lXhZW7tRh15AXww/np3Z/04F2bpLlLt+/36R/6ZcqB3BCOwJX4ixwYazVjhQ1R
	em7RsuDtmJNxKZLB/Iibuh75V3hQeo2/EXviheqxLjfBYxAmSVagyTte2CWAGtYlPDNdPE
	H0mHsqKtp/I0OwjdtZw8sfcPoRcz86E53L3aQBUA+d6MapE2CDZpJ5cHL0HWVXSbqXeoKG
	y0B4K2jpSv2E+82WWcICtBVP5xBeUUCqr9NReE6gCcCx5FWBGnr/DAgc1MhmLLNyOoTSgL
	8w4T1NxrSGnFrtj1EnUYhdVoNVw0W5w2V5BvxFFMWNLLnnLunPgcSs3KF1WB2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793805052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3GJZaJfM7BaQoOKyyMag0j1vgRY7QSdAOOCj79Pwwg=;
	b=ZIj+z0Qc+QRYMKys35dUCq4FlzB9/AiIgfzUu7BCaxVvUvHIN+c415OdujQfboXJJ6q+O9
	Hnd/0yLRafQBv9Bg==
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
Subject: [PATCH net-next v10 4/8] hsr: Drop received PTP packets
Date: Wed,  4 Nov 2026 16:10:40 +0100
Message-ID: <20261104-hsr_ptp-v10-4-2c4a38ad973c@linutronix.de>
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
received. The PTP packet is dropped with RX_HANDLER_CONSUMED meaning it
won't be visible by packet sockets bounded to protocol ETH_P_1588. It
works for sockets bound to ETH_P_ALL which is what linuxptp is doing.

L3 packets (PTP over UDP) is not considered because it is not part of
the HSR specification.

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

