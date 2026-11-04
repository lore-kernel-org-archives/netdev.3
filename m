Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805053;
	b=PCTrAllZ6V+ZIzfIdH3HJ0st2NyBLRMy4jhzQ7BzkbaDChBcZH6x8GAsdCfBqXTSeUrb
	 mCEU3yUoHPQc3ymA7AasEXf7TTfiJJUt1LARhuPZrhtkQRLhoZ8/x+B5m/G8ps/EbgPtx
	 rjxcxm6hPcYtrAjlHjL1RItUJObMcuFFqi2pyOINhR3QqDiw1Veu+iJOF/ZB+rNb+mLm9
	 R99oVtPEopfnY2HZ/VsJAXPwfSLdzqLQW58EIybGoUOhqe+317F3CZKPEaKNaIM+Ky5dX
	 i2G75/QQO+yv4uQ0tQHULoQDsZxcqppvcHdXo9TqgupdlfvgyonDmd5IiJBM9OUGy/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805053;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Pk7eIp3MYrwXSarqTn5cvtxQfD6X7+eKRfE/ltgZX2g=;
	b=KlTEQei3RNOwUvhhWC6Qm7ZaxBOwtFvsVfqKO5WTcPbsTP3Hiw4OE5H/PhcoRMCOTdL0
	 oRY0pHTy8elPjbPMtQWcaCJ8S3/ne8oU2kD6wRDmSOBEBaoEGfczmOo1c9CqqidcjHAHL
	 n8eZCxkYpP5hk/OPy7YABkVRGwFP7PyZbIzOqpjTSV3PhLeD+KYcNVAfbR4i2cH1wsXH5
	 08E7fgzS2exktUDlGEP9vxs7O9Dt9uwmYcrRzHrgCFjYojwGFQ89aOsk+0+3tBZwdzZdq
	 909/haZYkM6iIFuDowg4iccoJWmpc8PyjXGVXQzJXKLlPuC0mcRRcK5H/3M2fYd3v7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=bmpUn3VX;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5SqNw9ed;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E3C606A334
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E3C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=bmpUn3VX;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5SqNw9ed
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793805051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk7eIp3MYrwXSarqTn5cvtxQfD6X7+eKRfE/ltgZX2g=;
	b=bmpUn3VXKgaFqNDEQeN+r4ttmSh6ZAFc4+hSBTABOAEXdFr55z8UtID0AFlqzwQCGnkHwV
	3aE1X+E45arjDQxiV7vM3oJnQrRFL+iPjcNpQpwc19VrklfVdjHOAlmaNw5+1guwnkUi/l
	gVqFWTfc95iMZBpXJOJbPG4iu7JJqp5AU+veYDu/FWtj59njmC2/z8KdnMD6FVg8nIC1SN
	Lmy6hM0W8wo/e+CZwxlfZlKNpXJVM6pL6nXVWdjqV826yHHqiY3qgGzb4FhTWJR/72yxKG
	e45VLoDde7OtjOCpZ2MOWVAwUzQ5cn8e4gNxhHQpvXx5HHFoo5GY5badpGfGRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793805051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk7eIp3MYrwXSarqTn5cvtxQfD6X7+eKRfE/ltgZX2g=;
	b=5SqNw9ed4ZdRWpjk/lqUJiuGLo0SzM/VEg1c3hDZ94ZjJPzzBviY5FpaU83KX/qDpzSNwh
	tLehfQ1vQ/yeHGCA==
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
Subject: [PATCH net-next v10 2/8] hsr: Use skb_clone() while adding the HSR header
Date: Wed,  4 Nov 2026 16:10:38 +0100
Message-ID: <20261104-hsr_ptp-v10-2-2c4a38ad973c@linutronix.de>
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

hsr_create_tagged_frame() creates a new skb where the HSR header can be
prepended via __pskb_copy(). This does not copy the skb_shared_info part
of the original skb so any timestamp request is lost.

An alternative is to use skb_clone() where the skb_shared_info part is
shared and then skb_cow_head() to make the header part writeable. This
avoids touching manually the tx_flags and tskey members.
Using skb_clone() allows also return early (after the clone) in the
offloaded case so this can be unified a bit.
The clone case does not need manual adjustment of sk_buff::csum_start
because by using skb_cow_head() the head does not move relative to the
payload. Should the head need expansion then pskb_expand_head() will
move it and update sk_buff::csum_start accordingly. The clone also
preserves metadata (if available) so skb_postpush_data_move() is used
instead of memmove() to move both. Finally skb_reset_mac_len() is added
to set the new length of the header after expansion.

This is a preparation for PTP handling where timestamps are requested.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_forward.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 44f6d9c83180a..b183358207506 100644
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
+	if (skb_cow_head(skb, skb_metadata_len(skb) + HSR_HLEN))
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

