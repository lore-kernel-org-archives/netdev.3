Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672932;
	b=1joMdupl0KQnbvDjiw7gRHORfHXv7K3goD0kUaxGZkMooI0yiC1h1ruSnuW4zIGFLH5L
	 jvTtwBmw2ORgH1tYckYOFXZz9YMnWov25IfZZvU3ARxGpu+YME2VdMKrlZqmHHgK6QAF7
	 qNGF+uc9pNbghD0lLzsuU9u8buyhtJs/hQQfCubpPO1iwR+zIBCINhiz3hZAI8rHWuF1U
	 JL8FExiUZW7+pbHbTSK3qPOkNxeaBqaxiThreiYATwrINzaM5fUtJVjm0DMv6LQvvVkjf
	 C/XnNf3zPt7327g33Nnjaz+S+jnNRJupfnvGiV/dyPkTt2BFdImalA2/qbuorqg7rjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672932;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=E+PueQRw3LXmq/KAZXUuB8w4RjwHTCemS7p7oseT8Jo=;
	b=MOER2paXNkKbeg1qSfSA0gp3RA8Sv1+kKxx8VE88wBzZqLZx5ALZAq8mI6cB6e8nSLU7
	 3brzHyvHboFDvVsZH6CoxbK+3Z7vMSJx9Zk3xiIDUmtimX6WwyolRNjOa/i5SlgBP+D1Q
	 9wWS0PSQHxlP3gAKMd/l4eCGEyKO3vtvL8DMfA+uLC54slieZlT9/5Rpa2MKg2gCZBDqy
	 ZkV2KUWKTFjPbUy0jMRqbvyguPGtvjETLV14MenZSFPud0tWIFh5L5eOop9Zzr4MZfpBr
	 5VO+S9J5RFHWELWp3o6G+SSTwJuCrhFXcXj8HPgRMrnaNeuIDzBhJWpZCppg0JbFcfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="JkUeBzF/";
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603E6606A32C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 603E6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=JkUeBzF/
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53cd0c8614eso28049941cf.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672931; x=1794277731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E+PueQRw3LXmq/KAZXUuB8w4RjwHTCemS7p7oseT8Jo=;
        b=JkUeBzF/Q3tAJacdXFkozZpm16Mu8A2cjoTbWAGPZnM65qp8fwXkiGggoNsE/CPpBZ
         oKePVtWk1PFRmNvcgYHSGO9H2Yyn/YNYCnTl48g6DMUTnM9hwZNB3xf5qc4SC5FCkTTN
         BIkkx3SibFGUamd3jXH2QyOWvcVpFlwV1CKv2W+KKFym8rwM+90gbLt7k/myTmYKS/S2
         SxxGHTXQD1IRqesbx2WL0HJi2uV2AymftT7usa4iMjotSwO8hKJYgIwNdOnmDpGru0KU
         5cMMHEqaue4NHdtR6zUzAqMC4bUt6hi0x8ieXW4JIoji/QEgP9+8Ie2oDgN6IhKrLBOr
         rptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672931; x=1794277731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E+PueQRw3LXmq/KAZXUuB8w4RjwHTCemS7p7oseT8Jo=;
        b=0PHOf/mdH6Ir+HXllYxojkYZNKm2kbLW3WM/btAVzDvbeFpQz+vhk3jiJLiQvkNXVH
         WS4eimkqqT33w0VHy3mXhiT9k0Yp04LuQ7mi7+l85CASfwjZlMTiylzJxdRdjJVQ1Gc2
         c1awKJ7UrV17TtaoJF9LNAZ5OR9i2vSiRotYDIdgOvkAnAMofFRtMtBdCH1kUi2qmzz4
         03PzCAJyCc3Vd8+eXFQjuy1iucmZnaZThqNyLqZq+KNvqrcwJFkwtVD33qziFvoKvln5
         HSGHyUDgZFSKlyUjMWRM7gGOztRfDvppLq88nOs7gUpozU0GjlP1dBsEGt4SU91WvEaW
         nVfg==
X-Forwarded-Encrypted: i=1; AKwUvBzpQwrfuAlSdlv4zx8LLgV78UFXGN6ZPDAfgMZBH2Ae7oo6aI373JCmAh+rb6o6T4RAYXrrPpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WpX6iAiC7+W2nPiVtKjo+B+0FCHM6BDBqdnx/FMRRmwUeKH1i
	VkHq6egQWwmjW7+y76/rS5/QN7nqwVEx4p7/ucutZzXTpTKkoB+z5IkfWpHHmDZbvFQ=
X-Gm-Gg: AYBFou0eokUXZxwyLBdwRr4/bVaAP95ip7mxb+X52mVgdhjphkrg7yyHeWK5cXbVMwb
	5fOz9NpYQR/wVCwL+t7QCWW91gjAOiMMm6Yr5iBTpzwqXbCcxmpw4YBTzLOJ/jNPliBxN1+pzVO
	6h9nCx0bmEz1x/jucse2hrHcHI0J2G8XN4qyG1CAisX5LSQ68VOshpQnvRD5aR84iyQQZliUDEe
	NiTpWmmjZcbeU1/1VLtcZMLqSMDwOwq41ExmC0Yy3VHTfegoD6WkTwHiWUnWjnUg06qFBE+fM91
	TJXARlZ8ztPGH5OZBlYJw/BE882hlTPmgL1Ypgv8dnY2oa3cfhZkZM2NkuAldJoRcyakRB1Fu3P
	0UEeQ34DEML7YVm366VIW2JE2ee5HIwHA8wSH/OPA6M5bqj8QK49vhzaP2HmclOVQS45qPyCscJ
	OoT09EFojKYhDIxpSdUScs9zsBlvOsuYS1vAiV8MW4kh8KzvOlCdbWCI/QWIeWPrjcNEYVGU/bG
	EfYnZJ7aec16FIW1b1d1wxGdqlvxVnZ7LLSLVwhCtiU6G5Sbry5qTLtLfRXmvcEGayaPUp2eywG
	cPUCW+L5uxLXnwhj8DvSTNHSbhizZLH60uWVAI9k8UnFqA==
X-Received: by 2002:a05:622a:1c17:b0:536:622d:6932 with SMTP id d75a77b69052e-542b62a4588mr193623181cf.23.1793672931108;
        Mon, 02 Nov 2026 18:28:51 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce1dsm13809921cf.5.2026.11.02.18.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:28:50 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:29 +0000
Subject: [PATCH net-next v3 03/15] net: skbuff: fail checksum validation
 when the skb can't be checksummed
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-3-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672922; l=5641;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ljkKcEFWSleZcYbEYDqih3Hv4TBj+2u86MNLksCHbxQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCMEGKf9eY/JjLBx3uBpM1AvSdEnm9af1QuiTOeZWeeXF3LjhcUUm3ZNvs0Y8u3YMijw2VBPR/Y
 U7NAKuRMA3AQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__skb_checksum_complete() and __skb_gro_checksum_complete() verify a
packet with skb_checksum(), which returns 0 when the payload is in
unreadable frags or the skb's lengths don't add up.  Both add that 0 to
the pseudo-header sum, so they accept the packet whenever the
pseudo-header sum folds to 0xffff.  The sender controls that sum through
the addresses and the length.

Use skb_checksum_full() in both, and in __skb_checksum_complete_head(),
and report an skb that can't be checksummed as having a bad checksum.

Also take the skb off CHECKSUM_COMPLETE on that path.  nf_ip_checksum()
stores the pseudo-header sum in skb->csum before it calls
__skb_checksum_complete(), and conntrack doesn't drop a packet with a
bad checksum.  If the skb stayed CHECKSUM_COMPLETE,
__skb_checksum_validate_complete() would add the same pseudo-header sum
to skb->csum and accept the packet under the same condition.

A test module builds an skb that claims 50 more bytes than it holds,
with a pseudo-header sum of 0xffff.  Both functions accept that skb
before this patch and reject it after.

Found by the Sashiko AI review of the BUG_ON() series.

Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Link: https://lore.kernel.org/all/179273111951.3134.3452028799437573017@kernel.org/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/skbuff.h |  4 ++--
 net/core/gro.c         | 11 +++++++++--
 net/core/skbuff.c      | 27 +++++++++++++++++++++++----
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 608c1491597e..5a5354a6b6ba 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4892,7 +4892,7 @@ static inline void skb_checksum_complete_unset(struct sk_buff *skb)
  *   0: checksum is validated or try to in skb_checksum_complete. In the latter
  *	case the ip_summed will not be CHECKSUM_UNNECESSARY and the pseudo
  *	checksum is stored in skb->csum for use in __skb_checksum_complete
- *   non-zero: value of invalid checksum
+ *   non-zero: value of invalid checksum, or 1 if the skb can't be checksummed
  *
  */
 static inline __sum16 __skb_checksum_validate_complete(struct sk_buff *skb,
@@ -4932,7 +4932,7 @@ static inline __wsum null_compute_pseudo(struct sk_buff *skb, int proto)
  *
  * Return values:
  *   0: checksum is validated or try to in skb_checksum_complete
- *   non-zero: value of invalid checksum
+ *   non-zero: value of invalid checksum, or 1 if the skb can't be checksummed
  */
 #define __skb_checksum_validate(skb, proto, complete,			\
 				zero_okay, check, compute_pseudo)	\
diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20d..e2e847c95270 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -798,10 +798,17 @@ EXPORT_SYMBOL(napi_gro_frags);
  */
 __sum16 __skb_gro_checksum_complete(struct sk_buff *skb)
 {
-	__wsum wsum;
+	__wsum wsum = 0;
 	__sum16 sum;
 
-	wsum = skb_checksum(skb, skb_gro_offset(skb), skb_gro_len(skb), 0);
+	/* If the data can't be checksummed it can't be valid either, and
+	 * NAPI_GRO_CB(skb)->csum only holds the pseudo checksum.
+	 */
+	if (skb_checksum_full(skb, skb_gro_offset(skb), skb_gro_len(skb),
+			      &wsum)) {
+		NAPI_GRO_CB(skb)->csum_valid = 0;
+		return (__force __sum16)1;
+	}
 
 	/* NAPI_GRO_CB(skb)->csum holds pseudo checksum */
 	sum = csum_fold(csum_add(NAPI_GRO_CB(skb)->csum, wsum));
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c5f8aca89221..0d3f0f09c7d1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3885,11 +3885,28 @@ u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
 EXPORT_SYMBOL(skb_crc32c);
 #endif /* CONFIG_NET_CRC32C */
 
+/* The data can't be checksummed, so it can't be valid either.  The caller has
+ * put the pseudo header's checksum in skb->csum, so don't leave the skb
+ * CHECKSUM_COMPLETE for a later validator to take that for the packet's.
+ */
+static __sum16 skb_checksum_complete_failed(struct sk_buff *skb)
+{
+	if (!skb_shared(skb)) {
+		skb_checksum_complete_unset(skb);
+		skb->csum_valid = 0;
+	}
+	return (__force __sum16)1;
+}
+
 __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
 {
+	__wsum csum = skb->csum;
 	__sum16 sum;
 
-	sum = csum_fold(skb_checksum(skb, 0, len, skb->csum));
+	if (skb_checksum_full(skb, 0, len, &csum))
+		return skb_checksum_complete_failed(skb);
+
+	sum = csum_fold(csum);
 	/* See comments in __skb_checksum_complete(). */
 	if (likely(!sum)) {
 		if (unlikely(skb->ip_summed == CHECKSUM_COMPLETE) &&
@@ -3909,14 +3926,16 @@ EXPORT_SYMBOL(__skb_checksum_complete_head);
  *
  * It returns non-zero if the recomputed checksum is still invalid, otherwise
  * zero. The new checksum is stored back into skb->csum unless the skb is
- * shared.
+ * shared. If the skb can't be checksummed it returns non-zero, skb->csum is
+ * left alone, and the skb is no longer CHECKSUM_COMPLETE unless it's shared.
  */
 __sum16 __skb_checksum_complete(struct sk_buff *skb)
 {
-	__wsum csum;
+	__wsum csum = 0;
 	__sum16 sum;
 
-	csum = skb_checksum(skb, 0, skb->len, 0);
+	if (skb_checksum_full(skb, 0, skb->len, &csum))
+		return skb_checksum_complete_failed(skb);
 
 	sum = csum_fold(csum_add(skb->csum, csum));
 	/* This check is inverted, because we already knew the hardware

-- 
2.55.0

