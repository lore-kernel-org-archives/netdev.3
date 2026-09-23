Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71734BF921
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165667; cv=none; b=Z3yYS94aNsU9M4jyeOvQMlXBzXcBogenh4Htv5xFrnl4OnJ7H9zAg4t/+nqar+wK6zH+9bwfx4ABOOC73obic65DLXYLcUicxU5/rfAk4BfuMPM30pazgIR87e+4bzNevGl1leIHqsn+EwN95ihiZLmzpPpbYGRQhS2B7cxK6jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165667; c=relaxed/simple;
	bh=yUI24dsJTcOzNhL7yBwZ0yFj/blcVffdmtjMnIT5ALI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cu8lOQnsqDSflV9e8ShNKHPEmqPCaCwlpylwPn/yBHuNQwTJOSSXFUZz8U9U1+MZEh8oydDg3sS+FPizB+WZzEEeJhz1yrWBTf0uKiyNkukXQ4tIJM4iKrMsrmX5siYLp4BNrqlz19hRwmiymVNUL6BO6Dk10gqajIaW247FV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJOohjj7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DmLJWBpG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJOohjj7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DmLJWBpG"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790165657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwUP8zdo8m/HjLJIDsRUqA+6slTXBL8anX03zWoT+vo=;
	b=tJOohjj7q9U6cwiGPJx9c1zZ781GNuDWFDlDrODAYEqBu8LVqA92JUtTScsAwjThgZ36DW
	3x2ZlyYLSPp2Lpgr80Szx2djJnwGBqJ8UfvohF3nnQX5IKCaiarMq2s2CmMoJkrVlX3D3T
	/a3KvrwWK/l0BtltSseg600JdIOed54PquTDX9+aemE78cYuPtrZ7WHSx4nG4TPSAo0Rnq
	v5JQyPEE5+N7Ylb6WJ2MijpH/+bYOs4qGjfEM5d+xVYfT8vNEaJIhMynqRsk8L/q/+WL3n
	FjeHsT790bzhAygf7tJv9C3IpBzZleym2q0dk0jslAps1e2sAMB6Mmu6p+xwIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790165657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwUP8zdo8m/HjLJIDsRUqA+6slTXBL8anX03zWoT+vo=;
	b=DmLJWBpG92eZ5a7Z7128qEQceP6YkPZdB0BJm+LpoETXCbOyuhk4vWIRAKmllCoBI62zsz
	70f5kwr42MtZnRDw==
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
Subject: [PATCH net-next v6 4/8] hsr: Drop received PTP packets
Date: Wed, 23 Sep 2026 14:14:05 +0200
Message-ID: <20260923-hsr_ptp-v6-4-6ea07b3fb8a8@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_slave.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 5274ba6dd36e6..7c99f7e072763 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -44,8 +44,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buf=
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
@@ -64,10 +63,8 @@ static rx_handler_result_t hsr_handle_frame(struct sk_bu=
ff **pskb)
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
@@ -81,10 +78,32 @@ static rx_handler_result_t hsr_handle_frame(struct sk_b=
uff **pskb)
 		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
 		spin_unlock_bh(&hsr->seqnr_lock);
 	} else {
+		struct hsr_ethhdr *hsr_ethhdr;
+
+		/* PTP packets are not supposed to be forwarded via HSR as-is.
+		 * The latency introduced by forwarding renders the time
+		 * information useless. Userland needs to capture the packet on
+		 * the original interface instead of hsr.
+		 */
+		if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
+		    protocol =3D=3D htons(ETH_P_HSR)) {
+			/* HSR */
+			hsr_ethhdr =3D (struct hsr_ethhdr *)skb_mac_header(skb);
+			if (hsr_ethhdr->hsr_tag.encap_proto =3D=3D htons(ETH_P_1588))
+				goto finish_free_consume;
+		} else {
+			/* PRP */
+			if (protocol =3D=3D htons(ETH_P_1588))
+				goto finish_free_consume;
+		}
+
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

