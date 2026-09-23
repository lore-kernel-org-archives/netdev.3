Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12044F85B1
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165664; cv=none; b=WW/kkWGqo41eYInwNoUuVTSfZt4HFNQjR7PSrOmIwpsN6PChMKSnTy/hnDJmcozlFdSVZQkmPx6IFI/9w6W1i+ClOIOU+jxfBuej1h8CrLPb/5JQiKMcLs9+wFN0NCHaSgvHvzDU6Qjc2dsIP/0nR62Q3dl2C06bgxdgQig5ay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165664; c=relaxed/simple;
	bh=vp9bwltteOaAq8F5Tv+4lkjfCVzKZ1KGxK8p32vNZKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gp3EGKJhUWOX8u6VrktE0E+u6ooori7ZAPyZOZBKNFo8w3pqI8zppignB8UqsiHpvhXFCiDGa41dqG/hNCAgQlZ46hbliLXM4qRDhfbOITIMfnCdi4uIsIOAz4pSkMbGSsfLcI2pkcGJG9+lZDF8bo3SvOmyLYr/QP5ZXG53DMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DdVwexkc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S/DikC4i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DdVwexkc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S/DikC4i"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790165654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcJYgF3GbLGd0/c7QPeFFjZWZnRVamQQyWnVqAj2etE=;
	b=DdVwexkc1fXh6l+3n1kpEpQWjlUv4qQKxh03AJPelP+h3WCPJnhjW9iQNlzf+LKUGrRoA2
	x4vFzwc8ACaMOCyCWs2s/u+vsdq7H9AR9v5NFpkTk4kUHtMyy5YuEI2U7xskCREDh13qB3
	IQ7klaWOFNxmkAA6tkcp9H2OVXGaKrIkQbNhr2cCZJJmbELwD7fPIo7NUiUJpnHnmxnKI1
	jOxYnI3PRxDTmYgskcs+QfvWF8aGj4GzJKHf1FBuKmKz0nlAOJX8aO0rEBWKSZp4iKvfJL
	0D9nxKi1zKrL/RlQ7ZMy07Cug5Ev7NxPvUelfLMLYvpHysFqQs4er9KhohbADQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790165654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcJYgF3GbLGd0/c7QPeFFjZWZnRVamQQyWnVqAj2etE=;
	b=S/DikC4i3zL4thEkNzbJfmwoN1sVnC00eqyu0yj3N/jivIROMtroJTcXNvyfs0kbyW69ZB
	R1CRbNe5BsCXnqAw==
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
Subject: [PATCH net-next v6 2/8] hsr: Use skb_clone() while adding the HSR header
Date: Wed, 23 Sep 2026 14:14:03 +0200
Message-ID: <20260923-hsr_ptp-v6-2-6ea07b3fb8a8@linutronix.de>
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
 net/hsr/hsr_forward.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 7734a521a96c2..0c16fbf8fd14f 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -342,16 +342,18 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fr=
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
+
+	if (port->dev->features & NETIF_F_HW_HSR_TAG_INS)
+		return skb;
+
+	/* Ensure the cloned skb has enough headroom to fit the HSR tag */
+	if (skb_cow_head(skb, HSR_HLEN))
+		goto err;
=20
 	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
 		skb->csum_start +=3D HSR_HLEN;
@@ -360,15 +362,24 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_fr=
ame_info *frame,
 	if (frame->is_vlan)
 		movelen +=3D VLAN_HLEN;
=20
+	/* The entire header area needs to be linear */
+	if (!pskb_may_pull(skb, HSR_HLEN + movelen))
+		goto err;
+
 	src =3D skb_mac_header(skb);
 	dst =3D skb_push(skb, HSR_HLEN);
 	memmove(dst, src, movelen);
+	skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
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

