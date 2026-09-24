Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803830B53F
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210580; cv=none; b=MVUFr+FjFNByLRXc91fl1QNhZXDX07ABBdgai812i626vuX3Ygr7b/1SHEV3Ronm8cGkT7/kP3q/33atEbODrLSivJYDYvGGQV2W9YTq7wBCOfR/Pbacw9UzneKpCLkvHlIq4UHq5b3iO1a1Am2n+BNw65ZML/ZWz9ZifHAdj/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210580; c=relaxed/simple;
	bh=CSrA6s6dsg//acaFjQElEr0t/A1j8m9XVhkzTW9FUTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=svSFOhnVcSIQv9670igpGKXwciMlEHQ7piG8UFNE+VW5r4ThUATqKL2ZzLDv71EX4fJ66tyYjj9WYBSZiL+ySIv1qs5fyMZNQnGDWxpexvsdb/LytOCJT3FRfIZ+jwyz8LkVrZC8qLkWWVbxI3b7Ob2SrSvlw5OSRlHna1CZ6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVTLg5mU; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVTLg5mU"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93918756165so261246485a.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790210578; x=1790815378; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UH5SpA5dAtTJWWhTciIv3w9Fixn/103PsifEhwkVpZM=;
        b=vVTLg5mUXJ3MuLD41Ff1rx0BaxScPe/wDUq4NhEuOCOQB6k5WxQ3y4bJBZv3GEfHkY
         XmehnCAEsXoaLjpXLg0dVnKVvn298pBe0EyExZWU5Kw4EIX01ayy7fiNnD/aZBUUQuiD
         bq9LZ7BsCH+sFqgU3IkGaoy/2J6RR/VB9DhF24+relXhZUXu2FKA/N3Tb2hz1NphwVjE
         nC+N4SvRzzzzkMrNh+K9jL59nqwAoTyPtGY7PY23NKEJfqAUWJhgFsRa4gfpzFH6yPMs
         9igSu/PqzE5y07kHXLeQYXo4H7x1XQnBikIFX8FN9Br+uVGfvUbcp97Wr1qOKLYe0g3s
         EKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790210578; x=1790815378;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UH5SpA5dAtTJWWhTciIv3w9Fixn/103PsifEhwkVpZM=;
        b=siseuINrFFFVs2kLzPb9UE8dqBbYWr6BPHYJ1huEviUG9zTVp+2Pn9MQbQSSS64Sh9
         a6YrbdD72LwOtFY5DoSV4lJrKNDtkELqIFH+IvensHr4FcZZ/divO6UJUxVblFBT+9dP
         Q0vCys3MtZZ3aYjbgH6eN8ob7H3m44cB83OLSFSUjjPle36ikUrbLXK/cOlBxhfBH948
         eRO5rb8y8oSpv3KynnG4+whuHBjWeYBjV6s0izGXXKDdM6XbtGZW0VvGdECVlsOT1m3S
         NWhiID/mYxiCcuEbJobjjjb5CadZWt3EhzfI618tkkgmhdvuAqNqVmuKB07Nr0ibmKK6
         dBjA==
X-Forwarded-Encrypted: i=1; AKwUvBz6A1FIO1+3Jua7VkEUtdqbJWqUfbsagZjOgYj2Xc7Vj9CAGFpijxrZq+aoT7zgasOLR8ecU9E=@vger.kernel.org
X-Gm-Message-State: AFuF++lSeRaJeJpLXpqibp6EibwAHucFVsRfrg1t25Gnrrxg8N3WWuzA
	z0kE7TF5xd1GocXajKArsQoj1wxMo1wTAYRVQwpCZQ609Xiq0LzRG/3/XByEC56jPXvL2TEtkXA
	JGQZKLZVGtWbBJg==
X-Received: from qkbi2.prod.google.com ([2002:a05:620a:5202:b0:93c:36d5:9f4b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4710:b0:939:bd4e:b2fd with SMTP id af79cd13be357-93c363c968dmr62187885a.43.1790210577421;
 Wed, 23 Sep 2026 17:42:57 -0700 (PDT)
Date: Thu, 24 Sep 2026 00:42:52 +0000
In-Reply-To: <20260924004252.1196328-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924004252.1196328-1-edumazet@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924004252.1196328-3-edumazet@google.com>
Subject: [PATCH net 2/2] gve: DQO: reject TSO packets with an out of range MSS
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Eddie Phillips <eddiephillips@google.com>, Ankit Garg <nktgrg@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Joshua Washington <joshwash@google.com>, 
	Willem de Bruijn <willemb@google.com>, edumazet@kernel.org, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

gve_prep_tso() notes that the device requires the MSS to be <= 9728,
but does not enforce it, assuming the 9K MTU enforced by the hypervisor
and the 64KB limit on TSO sizes are enough.

This does not hold for packets that were not generated locally.
A guest behind a tap, or any packet socket user, can provide an
arbitrary gso_size in virtio_net_hdr. Layer 2 forwarding does not check
the MTU for GSO packets (is_skb_forwardable()), and gso_features_check()
only bounds skb->len and gso_segs, never gso_size.

Such a packet reaches gve_tx_fill_tso_ctx_desc(), which puts gso_size
into the mss field of the TSO context descriptor. This field is 14 bits
wide, so a gso_size of 16384 is silently turned into an MSS of zero.

Drop these packets from gve_prep_tso(), and make sure that
gve_features_check_dqo() leaves their GSO bits alone: skb_segment()
splits at gso_size regardless of the MTU, so falling back to software
segmentation would give the device non TSO packets bigger than the
9728 bytes it supports.

Note that the device can still be given oversized non TSO packets when
the stack segments in software for other reasons, for instance after
TSO has been disabled with ethtool. This is a generic issue, because
the MTU check is skipped for GSO packets in the forwarding path, and
is addressed separately.

Fixes: a57e5de476be ("gve: DQO: Add TX path")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net/ethernet/google/gve/gve_desc_dqo.h    |  5 ++++
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  | 26 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_desc_dqo.h b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
index f7786b03c7444753fb8b71c7aaf5ed37719caa1f..d2c86c8eeae2a1025fac84f55e317d1fc5b7503c 100644
--- a/drivers/net/ethernet/google/gve/gve_desc_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
@@ -14,6 +14,11 @@
 #define GVE_TX_MAX_HDR_SIZE_DQO 255
 #define GVE_TX_MIN_TSO_MSS_DQO 88
 
+/* HW limit. This also has to fit in the 14 bits of the mss field of
+ * struct gve_tx_tso_context_desc_dqo.
+ */
+#define GVE_TX_MAX_TSO_MSS_DQO 9728
+
 #ifndef __LITTLE_ENDIAN_BITFIELD
 #error "Only little endian supported"
 #endif
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 19829b8e13de28df81bdec0c86e8356b25fe9537..3e0bed9ab94a0073a1298ee76de4230cee7e3ce3 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -577,6 +577,20 @@ static int gve_prep_tso(struct sk_buff *skb)
 	int header_len;
 	int err;
 
+	/* Note: HW requires the total length of the TSO to be <= 262143,
+	 * this is enforced by netif_set_tso_max_size().
+	 *
+	 * MSS (gso_size) can not be trusted: packets forwarded from a tap or
+	 * injected by a packet socket can carry an arbitrary value, while the
+	 * mss field of the TSO context descriptor is only 14 bits wide.
+	 *
+	 * A too big MSS is dropped here instead of being rejected from
+	 * gve_features_check_dqo(), because software segmentation would
+	 * produce packets larger than the device can send.
+	 */
+	if (unlikely(shinfo->gso_size > GVE_TX_MAX_TSO_MSS_DQO))
+		return -1;
+
 	/* Needed because we will modify header. */
 	err = skb_cow_head(skb, 0);
 	if (err < 0)
@@ -958,7 +972,17 @@ netdev_features_t gve_features_check_dqo(struct sk_buff *skb,
 					 struct net_device *dev,
 					 netdev_features_t features)
 {
-	if (skb_is_gso(skb) && !gve_can_send_tso(skb))
+	if (!skb_is_gso(skb))
+		return features;
+
+	/* Keep the GSO bits for a too big MSS, so that gve_prep_tso() drops
+	 * the packet: software segmentation would give packets larger than
+	 * the device can send.
+	 */
+	if (skb_shinfo(skb)->gso_size > GVE_TX_MAX_TSO_MSS_DQO)
+		return features;
+
+	if (!gve_can_send_tso(skb))
 		return features & ~NETIF_F_GSO_MASK;
 
 	return features;
-- 
2.56.0.rc1.310.g51773c2048-goog

