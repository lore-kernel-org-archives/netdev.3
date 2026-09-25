Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2547A0C4;
	Fri, 25 Sep 2026 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329924; cv=none; b=VgSFRscoPfAX8KC8/xFm+5PI4Z9TqXPrRCKf/tp3k0LK5Vd0u2gEhFe6sXwKDUr0ptvlrBwfYfe+coC3aRfQzJyzWojR89lqEfxIe2Ppb4jsCs/+7Y2ohp722n/OrkoK7DISgEZp7YOf4mL4JK6umAG+p1ZeAvJYzpcm6iO9FVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329924; c=relaxed/simple;
	bh=fg6c6P0/fMma64VSqM6W0bcXy6oK5l6e028sdtXnnxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iheaWD73HCx7uVoSClVhRvYqu7/1I/TVH7Q7I5q+wAfXx2pcl9+S4Vvth4tM7qI3PS77l6SD0mtAThPGszit9ZSZ7tdu8X5D1pTahbIs/vvHLbawcCkxUr8875hxlqdo72eheFjiSn4vHwTpwUOyrO7eN2NhahPvCdnSWTEzR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=KVWVybj9; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="KVWVybj9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=5xfEJH+6O2A299+Q6ks5W8v7WUawHM5WLwZmhR3IQ4M=; b=KVWVybj9ZK9Rf8m552n+A+cEMP
	/1CB7Ch8LmpHLFdDgnjNTU84vozopg8SuKhm7XMzQ11AAaYuoiSPQxy0G+9BEIyHC62H+02MrSOOA
	cXDCVAKgLYMl6NKBpVh/Ney9sHnGYUQa8jJYIWLKIGiKDvP82Wikwef7P48HJ8vOz2XIPsBNKGCj2
	1pitq/yRkdgsabshmJClb+y6Xb2twQU7PZIhFnILJSWQgVP4Ix2CeQVWOQiYLrYyUfw/pZvv8V34I
	dcR7PR5wboQ3R35uzWGguxnYJxTV+Q8ZOwEdXYX+pWSCxbKrj6HyU0MmJTMwPtB+l20bApfsKXK6G
	NLY5Dm/w==;
Received: from [151.115.150.205] (port=55806 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xA2av-0000000EqYZ-3i7v;
	Fri, 25 Sep 2026 11:51:53 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] xfrm: esp4: use current ESN high bits for IV and AAD
Date: Fri, 25 Sep 2026 09:51:29 +0000
Message-ID: <20260925095128.446450-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

esp_xmit() saves the low half of the current packet sequence number
before advancing the GSO sequence state, but builds esp.seqno with the
high half after the advance. When the low half wraps, the packet whose
transmitted sequence number is 0xffffffff is encrypted as though it
belonged to the next sequence-number cycle. With AES-GCM, this assigns
the boundary packet the same nonce as the packet sent one complete
32-bit sequence-number cycle later. esp_output_set_extra() also reads
the advanced high half when constructing the associated data, so the
two packets use identical associated data.

Because GCM uses CTR mode for encryption, known plaintext from either
record reveals the corresponding plaintext in the other. More
importantly, reusing the nonce makes the GHASH authentication key
recoverable, allowing an attacker to forge valid tags for arbitrary
ciphertexts under that nonce and key.

Starting from sequence number zero, reaching the faulty packet requires
2^32 - 1 outbound ESP packet sequence increments. Reusing its nonce
requires another 2^32 increments under the same AES-GCM key, for
2^33 - 1 increments in total.

Snapshot both halves of the current sequence before changing the GSO
state. Derive the authenticated high half from that same immutable
sequence value so the IV and associated data cannot diverge.

Fixes: 4b549ccce941 ("xfrm: replay: Fix ESN wrap around for GSO")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ipv4/esp4.c         | 13 ++++---------
 net/ipv4/esp4_offload.c |  6 ++++--
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index e76db5817e78..04f27c41ea50 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -271,20 +271,15 @@ static void esp_output_restore_header(struct sk_buff *skb)
 static struct ip_esp_hdr *esp_output_set_extra(struct sk_buff *skb,
 					       struct xfrm_state *x,
 					       struct ip_esp_hdr *esph,
-					       struct esp_output_extra *extra)
+					       struct esp_output_extra *extra,
+					       __be64 seqno)
 {
 	/* For ESN we move the header forward by 4 bytes to
 	 * accommodate the high bits.  We will move it back after
 	 * encryption.
 	 */
 	if ((x->props.flags & XFRM_STATE_ESN)) {
-		__u32 seqhi;
-		struct xfrm_offload *xo = xfrm_offload(skb);
-
-		if (xo)
-			seqhi = xo->seq.hi;
-		else
-			seqhi = XFRM_SKB_CB(skb)->seq.output.hi;
+		__u32 seqhi = upper_32_bits(be64_to_cpu(seqno));
 
 		extra->esphoff = (unsigned char *)esph -
 				 skb_transport_header(skb);
@@ -543,7 +538,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 	else
 		dsg = &sg[esp->nfrags];
 
-	esph = esp_output_set_extra(skb, x, esp->esph, extra);
+	esph = esp_output_set_extra(skb, x, esp->esph, extra, esp->seqno);
 	esp->esph = esph;
 
 	sg_init_table(sg, esp->nfrags);
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f5e7..79f7d08325c5 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -272,7 +272,7 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 	struct crypto_aead *aead;
 	struct esp_info esp;
 	bool hw_offload = true;
-	__u32 seq;
+	__u32 seq, seq_hi;
 	int encap_type = 0;
 
 	esp.inplace = true;
@@ -315,7 +315,9 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 			return esp.nfrags;
 	}
 
+	/* Keep the sequence used by this packet before advancing GSO state. */
 	seq = xo->seq.low;
+	seq_hi = xo->seq.hi;
 
 	esph = esp.esph;
 	esph->spi = x->id.spi;
@@ -334,7 +336,7 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 	if (xo->seq.low < seq)
 		xo->seq.hi++;
 
-	esp.seqno = cpu_to_be64(seq + ((u64)xo->seq.hi << 32));
+	esp.seqno = cpu_to_be64(seq + ((u64)seq_hi << 32));
 
 	if (hw_offload && encap_type == UDP_ENCAP_ESPINUDP) {
 		/* In the XFRM stack, the encapsulation protocol is set to iphdr->protocol by
-- 
2.47.3

