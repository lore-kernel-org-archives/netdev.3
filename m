Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089623BCD0E
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946083; cv=none; b=onDC+xhcyEjul/Y7YJLkwTlbUIG78ZxA4Bp7FQsqs39RCAMXr004yEswcP2p2vtFwGyOFBr4bxMD25yDroirNdHlabco410OVypj6H1Fr6LchFNqYLFiwagsBEie0LXIFXASo5FOWLOv1M5QHxZ8vcF+fLptL0yM5dBYkeVMhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946083; c=relaxed/simple;
	bh=TUsIBrw0Ju8+RjJrILn+oI6GLldSSvAvNsRznVu/BqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQPIBJSQFxnKJzpENi0IheuXSQYxhmDV3Onagb48UjVci+1bGsbZI5XxAWt1ql8KhFF3Ex1vEW2BtdwoKmIO1IRuWVMfBVt4D4ZLtObO++6uo0X/jIN4BdZUoPV+BRuyPcibHqKLgQybYTIMJ7WampJyZgOKy6iSqSdjyAFMwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IWW/tfMc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHsj9vBP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IWW/tfMc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHsj9vBP"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790946079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qta1ZbQ6s008u2X8pcZ2JzYHAdf+iNcha/r/EuBtIjM=;
	b=IWW/tfMcXqxWQhSwG0wGKSYAuXq3E+rScZyMFU6iidVOPO/ap1qmG2I07k0IDjcOlCOl8m
	e1fB8ZjfljTkHsHqO5Ine3dKDNB/yn/6EB5535jH1G3fgJV/BUevZQcS8Et+zPHoEUEhVx
	kmTMZ0C5TtcO1nUoWo7qnaiMluuvNDelF+6tYpDPL+jDZNhpWI/ian4iLAC7mQZ8DDaBYX
	sDNBmID/nldtbwJJl6ls2EOFjDjS4P/kKrYRYuixSPwBUrPiF5Ajm7HR8zfK2pfLm4VNxT
	zblNIB5csgXEDHnMp1DJxIglIMndQm3bKMipLZwWoL2ijqqIM85qCvFry3KOXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790946079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qta1ZbQ6s008u2X8pcZ2JzYHAdf+iNcha/r/EuBtIjM=;
	b=YHsj9vBPi9qNMdVu/qhzSHeiXyH30TLc+o9yAwHdv9pE6Vd55s9vebGJB8s0FOZXuw19Lw
	F3UvhfsD7d1p/WBw==
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
Subject: [PATCH net-next v8 2/8] hsr: Use skb_clone() while adding the HSR header
Date: Fri,  2 Oct 2026 15:01:08 +0200
Message-ID: <20261002-hsr_ptp-v8-2-60dabc07e554@linutronix.de>
In-Reply-To: <20261002-hsr_ptp-v8-0-60dabc07e554@linutronix.de>
References: <20261002-hsr_ptp-v8-0-60dabc07e554@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

hsr_create_tagged_frame() creates a new skb where the HSR header can be
prepended via __pskb_copy(). This does not copy the skb_shared_info part
of the original skb so any timestamp request is lost.

An alternative is to use skb_clone() where the skb_shared_info part is
shared and then skb_cow_head() to make the header part writeable. This
avoids touching manually the tx_flags and tskey members.
Using skb_clone() allows also return early (after the clone) in the
offloaded case so this can be unified a bit.

This is a prepartion for PTP handling where timestatmps are requested.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_forward.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 7734a521a96c2..6c0b1f467940d 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -342,33 +342,41 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fr=
ame_info *frame,
 		/* set the lane id properly */
 		hsr_set_path_id(frame, hsr_ethhdr, port);
 		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
-	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
-		return skb_clone(frame->skb_std, GFP_ATOMIC);
 	}
=20
-	/* Create the new skb with enough headroom to fit the HSR tag */
-	skb =3D __pskb_copy(frame->skb_std,
-			  skb_headroom(frame->skb_std) + HSR_HLEN, GFP_ATOMIC);
+	skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
 	if (!skb)
 		return NULL;
-	skb_reset_mac_header(skb);
=20
-	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
-		skb->csum_start +=3D HSR_HLEN;
+	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
+		return skb;
+
+	/* Ensure the cloned skb has enough headroom to fit the HSR tag */
+	if (skb_cow_head(skb, HSR_HLEN))
+		goto err;
=20
 	movelen =3D ETH_HLEN;
 	if (frame->is_vlan)
 		movelen +=3D VLAN_HLEN;
=20
+	/* The entire header area needs to be linear */
+	if (!pskb_may_pull(skb, movelen))
+		goto err;
+
 	src =3D skb_mac_header(skb);
 	dst =3D skb_push(skb, HSR_HLEN);
 	memmove(dst, src, movelen);
+	skb_set_network_header(skb, HSR_HLEN + movelen);
 	skb_reset_mac_header(skb);
+	skb_reset_mac_len(skb);
=20
 	/* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
 	 * that case
 	 */
 	return hsr_fill_tag(skb, frame, port, port->hsr->prot_version);
+err:
+	kfree_skb(skb);
+	return NULL;
 }
=20
 struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,

--=20
2.55.0

