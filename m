Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAF548562
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989054; cv=none; b=MevmuAM+Ym97wcrgS6yNIdJLJf/VUWR3WHxqKww3Z7Ysz8mYfKBCnzlh4NXyJVB8KAIUg/dh0HHnxc2QH10zdu1MBeAYECaH6Gc5BQeuHGjm6aIQw6X4DgFOs5zGcHAwrkkQyv/WoUF6I5wJ3ZClx+PYbWn+w+GQAOQ2I1T+xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989054; c=relaxed/simple;
	bh=NWDD9/HBcZlan+7iDsY7WLsNVY180qvXfGnmZd28KJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vlrs0JQ7JjHS8Eki69yrigMsc39dTtRghDVKk5FpV2UHRMBQB5E+NzKnx3BK7YkDATO01KYSn//HtMGxVXghVK3ihKZlgbUS9QzUpaL7PBNnCg3ZPDpA2hae/5zhh9ru+POiGEGth3raux1flUfziYMUEMdZGuodTybtu563STY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qHJyQv9X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLJiZBph; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qHJyQv9X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLJiZBph"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791989047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz09Vw74WWRM4lngFu8aaLmkLNIthV4SzeyqQ1FGPk4=;
	b=qHJyQv9Xb/tkxzbWIcX97ip/hItMQjzbq0uOrxrJMsrCLLdft/RQFhXSCmRlPX86dsC4Vs
	IFIt8NsdnQ7GVOGNYz9L0FPC4eJaaCR2fKlHi+4rH89CohA3KSDITgVzNkHayv5kiZZlsT
	+Xi33WrsQFuQ2kfMg1N5AiPRJQluGFZge/KtFgOC6ke+BjdzWJ7WVbFXcuhKFI5qCGSq62
	Qdz58Q20NVRCq/sHGLJMIdBQK3eRxwEScGOKm5RVCtfreauI6UrSBGKFMAMckXU8iV8kqw
	Xt+XcW/QEeNo/esX4MqmgVQH77ZQEEBOLis21TzATUlMKpbYMuSQHhIByKqzbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791989047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz09Vw74WWRM4lngFu8aaLmkLNIthV4SzeyqQ1FGPk4=;
	b=hLJiZBphCgNMmtA944dZtwn4ECNmxnyST5sfHFgvScr0M4FOXYWlnkyER+7ZEhV+ljuNQV
	ZI6Bo+oD5vE0GZBQ==
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
Subject: [PATCH net-next v9 2/8] hsr: Use skb_clone() while adding the HSR header
Date: Wed, 14 Oct 2026 16:43:56 +0200
Message-ID: <20261014-hsr_ptp-v9-2-2d20a2a0f816@linutronix.de>
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

hsr_create_tagged_frame() creates a new skb where the HSR header can be
prepended via __pskb_copy(). This does not copy the skb_shared_info part
of the original skb so any timestamp request is lost.

An alternative is to use skb_clone() where the skb_shared_info part is
shared and then skb_cow_head() to make the header part writeable. This
avoids touching manually the tx_flags and tskey members.
Using skb_clone() allows also return early (after the clone) in the
offloaded case so this can be unified a bit. The clone also preserves
metadata so skb_postpush_data_move() is used instead of memmove().

This is a prepartion for PTP handling where timestatmps are requested.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_forward.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 7734a521a96c2..5862c05f52110 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -331,7 +331,6 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
 struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
 					struct hsr_port *port)
 {
-	unsigned char *dst, *src;
 	struct sk_buff *skb;
 	int movelen;
=20
@@ -342,33 +341,40 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fr=
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
-	src =3D skb_mac_header(skb);
-	dst =3D skb_push(skb, HSR_HLEN);
-	memmove(dst, src, movelen);
+	/* The entire header area needs to be linear */
+	if (!pskb_may_pull(skb, movelen))
+		goto err;
+
+	skb_push(skb, HSR_HLEN);
+	skb_postpush_data_move(skb, HSR_HLEN, movelen);
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

