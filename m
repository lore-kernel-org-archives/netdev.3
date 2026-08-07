Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106537DAAD
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128027; cv=none; b=KuExpjxViVtF5oy0C/bGJ0utMES+dBNNKzOMogT6uh60dzb0GcCqzKIcrk+mChBZbkgiUoTdYqRu2J1qZ2pMS3UUJKu0SJZpRbcVYJ7osz+A7qieVAI9Hpeyvt1jkPkUZOPP2XxDUXQRs5FuwR3O/YqVTdiHhA5QzTtucNilo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128027; c=relaxed/simple;
	bh=XGJVMqICkFsTKu5vBDLyxxbIBLOC6kISQIcLSVA7RiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qawL5z1BgOC/olMIfdwAFsTJtBjEB+UTk8wxW29LGRst47cg/sx949srJPn2m+FEWizAdn+fzMqQ3ANh/zlz0ZUPwiaETkuY72hvFuCK9qB5IOHu+mQ1WrBDRMQ/+2Kl2QhTJFxGEXcAj07kmYkA3qVYPTDr+RM8i+/N/C32s7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TJUqzSXN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TJUqzSXN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4980dc26022so37041015e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786128017; x=1786732817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tk3QjEz1+VgK3/9LJZo0poEfxFkr/dBSa6yi3XikNK4=;
        b=TJUqzSXNN86CeXlM3ccI16ZU/j3Val6/9hM2YmhZbDKOdCZXmba+KnUTcKDlguOpVK
         Ca6hSpQ8yC1jaHKcl/TPyvJcMKF8/hHi5wDKowE0h16kE5rFQZ4S6cKvbTVbwBmLX2Hb
         7Mrf5J+vmWkxu/AX7QzQsAw+Ui5BtJSLERVHkBjExxBaYL6YH/tsMJx3MLTQ37V/lqqj
         CC1goytAJeUXF5aoXtvQo+qqK+ajEcvo7QhOuivZU8T9M39rtEF4Ds+Ev6v0zYYYd6oj
         iIthRliO/0okdozfG/TQ2Xp2ZaSf9yIqEGxr+9Bs1m7lDt9ZMJcGY0M1CQHE0LmuO4ZP
         cy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128017; x=1786732817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tk3QjEz1+VgK3/9LJZo0poEfxFkr/dBSa6yi3XikNK4=;
        b=sD1+1VBmYyQcwxh+xd2VOA3gtdIQkJaVBh44UZhwM5qkIGlXhABsVbivgiKxYVxDYh
         McJqQrsK+nfkVSEMPymZPBeXOViO/WeTnaqyIC1dlHWFb/qe2riOPHp6z2+/cKHrqJY3
         qfd6ExzEfm94MRMmcOym4IvtWMCEBirXknvuLxUmiyxrW3HUQNihs0eIZV9yX95yEzyv
         TL7ZPb4/1tEWsnZugvKTWJUAbAm/aI/Dazj7XB8ZdbRo8WHizOsTHM/6g0Qiwna7ityD
         PhG7sQln93KKQWePOh+PWbZoG26SOCQ5HNbGJs9a93hWhFHbe3gm5St2Qg74dYEs1FUC
         TYHg==
X-Gm-Message-State: AOJu0YzeyF5JtrFaoe4yT/do/5Mz9MoL7nA3+Qe++0SXD09tKkdfD6wv
	h0XJFuzc1IjsAcCZlufIbZ4iAVL3ooQGD0pMV9LMqVhkitMU6Q/54LSmr5X7kxYM/AP+oNBdGLZ
	30TvEPX4HhpwyYH3cG8TNaAF9WajwUlnazlXnq6Y0mItVGBVGZ3zawfkM6JEkGjpmPpEB9BZCh3
	Sx5M17rRRUpoNJbhg2vc67plTXrvWYA5/qthVNd5CyELNCWao=
X-Gm-Gg: AR+sD10LbWNxjqb3DF6job6+4Sw6/5ppDGqxfjIlRehnJKqtE2aeQVXSjHJnprQmnEQ
	UYwF8CRh59483bffUb1rPPKqVo6wAMWeUgKsWfmefUbe6nNG0WLuGzQPNVgfJejj+4MFXStH0DA
	aUb+Nm0SKzX4GDrfdMJNS2JoC2p039i+wyT9Sn13nQ5mtPvlmpXilUzAjzx+SWjW9lV8KQwNFsK
	ENAy6IQPiWkXQoUl/F96o2oXXhLLb/3iLFiYd3xjBC1sji5ZxhtX6fx+gPAZ7jtYv19kvjVcHh8
	y4rDnl39GyQSjeceRE9lT8yyjKBJeOJYm+YZ+qZkeCG4WOvQ/PIuwdRb29pcpo6dXIJ71UYtoqy
	5y5Ds/IRLsvOXunagpJahrpMAA7JyT003YuUC1w0mbirnwCgd8fhTiQ3z7WJIbreYlHoSZpSVF4
	FZxOHVVRtINvsCxiXG3cHMH0xnmCaKvUKw5NblnXqTaFQ2s+yQVmi0MDqDi6GCuJ0OAtXUuULDT
	Yu3WkJvaqUF1kh/3pT/aly0EMvtQVW5gv/vQN0OE55PrvwaI1srVDdbA+WMv3Fl8whLBxXaKyF4
	zTZ25j4buPcPg+vhyF44/kYlREELLaMW/sZskTStX44R8BUbmYgD++4izRx7/fN613MWCwyQv+C
	X4IW419o=
X-Received: by 2002:a05:600c:34d1:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-4994e794ee7mr365663205e9.4.1786128017287;
        Fri, 07 Aug 2026 11:40:17 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:40:16 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v16 04/10] tls: add TLS 1.3 hardware offload support
Date: Fri,  7 Aug 2026 12:38:47 -0600
Message-Id: <20260807183853.2288959-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260807183853.2288959-1-rjethwani@purestorage.com>
References: <20260807183853.2288959-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add TLS 1.3 support to the kernel TLS hardware offload infrastructure,
enabling hardware acceleration for TLS 1.3 connections on capable NICs.
The dispatch-side restructure needed to make this safe on the rekey
path lands in a preceding patch ("tls: skip device-offload dispatch on
the rekey path"); this patch is limited to the device / device_fallback
side:

  - Drop the TLS_1_2_VERSION guards in tls_set_device_offload() and
    tls_set_device_offload_rx() so 1.3 crypto_info is accepted.

  - tls_device_record_close(): append TLS 1.3's content_type byte
    together with the tag as one tail segment; use the pre-populated
    dummy_page (identity-mapped byte values) as the fallback when
    pfrag allocation fails so the content_type byte lands on the
    dummy path too.

  - tls_device_reencrypt(): use prot->prepend_size instead of an
    open-coded TLS_HEADER_SIZE + iv, so the 1.3 prepend layout is
    handled correctly.

  - tls_device_fallback.c / tls_enc_record(): thread tls_context in
    to reach crypto_send for the 1.3 static IV; select IV source and
    length adjustment based on prot->version; XOR the IV with the
    record sequence via tls_xor_iv_with_seq() for 1.3; use
    prot->aad_size and prot->prepend_size instead of the 1.2-only
    constants. Inline the single caller of tls_init_aead_request().

  - tls_device_init(): pre-populate dummy_page with an identity byte
    map so any record_type used as a page offset yields the correct
    content_type byte on the fallback path (avoids a runtime range
    check).

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3
AES-GCM-128 and AES-GCM-256 cipher suites.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c          | 65 ++++++++++++++++++++---------------
 net/tls/tls_device_fallback.c | 58 +++++++++++++++++--------------
 2 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 37bb06a8e8f5..bbb1aa733500 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -317,25 +317,34 @@ static void tls_device_record_close(struct sock *sk,
 				    unsigned char record_type)
 {
 	struct tls_prot_info *prot = &ctx->prot_info;
-	struct page_frag dummy_tag_frag;
-
-	/* append tag
-	 * device will fill in the tag, we just need to append a placeholder
-	 * use socket memory to improve coalescing (re-using a single buffer
-	 * increases frag count)
-	 * if we can't allocate memory now use the dummy page
+	int tail = prot->tag_size + prot->tail_size;
+
+	/* Append tail: tag for TLS 1.2, content_type + tag for TLS 1.3.
+	 * Device fills in the tag, we just need to append a placeholder.
+	 * Use socket memory to improve coalescing (re-using a single buffer
+	 * increases frag count); if allocation fails use dummy_page
+	 * (offset = record_type gives correct content_type byte via
+	 * identity mapping)
 	 */
-	if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
-	    !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocation)) {
-		dummy_tag_frag.page = dummy_page;
-		dummy_tag_frag.offset = 0;
-		pfrag = &dummy_tag_frag;
+	if (unlikely(pfrag->size - pfrag->offset < tail) &&
+	    !skb_page_frag_refill(tail, pfrag, sk->sk_allocation)) {
+		struct page_frag dummy_pfrag = {
+			.page = dummy_page,
+			.offset = record_type,
+		};
+		tls_append_frag(record, &dummy_pfrag, tail);
+	} else {
+		if (prot->tail_size) {
+			char *content_type_addr = page_address(pfrag->page) +
+						  pfrag->offset;
+			*content_type_addr = record_type;
+		}
+		tls_append_frag(record, pfrag, tail);
 	}
-	tls_append_frag(record, pfrag, prot->tag_size);
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
-			 record->len - prot->overhead_size,
+			 record->len - prot->overhead_size + prot->tail_size,
 			 record_type);
 }
 
@@ -885,6 +894,7 @@ static int
 tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	const struct tls_cipher_desc *cipher_desc;
 	int err, offset, copy, data_len, pos;
 	struct sk_buff *skb, *skb_iter;
@@ -896,7 +906,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
 	rxm = strp_msg(tls_strp_msg(sw_ctx));
-	orig_buf = kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv,
+	orig_buf = kmalloc(rxm->full_len + prot->prepend_size,
 			   sk->sk_allocation);
 	if (!orig_buf)
 		return -ENOMEM;
@@ -911,9 +921,8 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	offset = rxm->offset;
 
 	sg_init_table(sg, 1);
-	sg_set_buf(&sg[0], buf,
-		   rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv);
-	err = skb_copy_bits(skb, offset, buf, TLS_HEADER_SIZE + cipher_desc->iv);
+	sg_set_buf(&sg[0], buf, rxm->full_len + prot->prepend_size);
+	err = skb_copy_bits(skb, offset, buf, prot->prepend_size);
 	if (err)
 		goto free_buf;
 
@@ -1091,11 +1100,6 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	crypto_info = &ctx->crypto_send.info;
-	if (crypto_info->version != TLS_1_2_VERSION) {
-		rc = -EOPNOTSUPP;
-		goto release_netdev;
-	}
-
 	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
 	if (!cipher_desc || !cipher_desc->offloadable) {
 		rc = -EINVAL;
@@ -1198,9 +1202,6 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
-	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
-		return -EOPNOTSUPP;
-
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
@@ -1410,12 +1411,22 @@ static struct notifier_block tls_dev_notifier = {
 
 int __init tls_device_init(void)
 {
-	int err;
+	unsigned char *page_addr;
+	int err, i;
 
 	dummy_page = alloc_page(GFP_KERNEL);
 	if (!dummy_page)
 		return -ENOMEM;
 
+	/* Pre-populate dummy_page with identity mapping for all byte values.
+	 * This is used as fallback for TLS 1.3 content type when memory
+	 * allocation fails. By populating all 256 values, we avoid needing
+	 * to validate record_type at runtime.
+	 */
+	page_addr = page_address(dummy_page);
+	for (i = 0; i < 256; i++)
+		page_addr[i] = (unsigned char)i;
+
 	destruct_wq = alloc_workqueue("ktls_device_destruct", WQ_PERCPU, 0);
 	if (!destruct_wq) {
 		err = -ENOMEM;
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 3b7d0ab2bcf1..1110f7ac6bcb 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -37,14 +37,15 @@
 
 #include "tls.h"
 
-static int tls_enc_record(struct aead_request *aead_req,
+static int tls_enc_record(struct tls_context *tls_ctx,
+			  struct aead_request *aead_req,
 			  struct crypto_aead *aead, char *aad,
 			  char *iv, __be64 rcd_sn,
 			  struct scatter_walk *in,
-			  struct scatter_walk *out, int *in_len,
-			  struct tls_prot_info *prot)
+			  struct scatter_walk *out, int *in_len)
 {
 	unsigned char buf[TLS_HEADER_SIZE + TLS_MAX_IV_SIZE];
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	const struct tls_cipher_desc *cipher_desc;
 	struct scatterlist sg_in[3];
 	struct scatterlist sg_out[3];
@@ -55,7 +56,7 @@ static int tls_enc_record(struct aead_request *aead_req,
 	cipher_desc = get_cipher_desc(prot->cipher_type);
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
-	buf_size = TLS_HEADER_SIZE + cipher_desc->iv;
+	buf_size = prot->prepend_size;
 	len = min_t(int, *in_len, buf_size);
 
 	memcpy_from_scatterwalk(buf, in, len);
@@ -66,16 +67,27 @@ static int tls_enc_record(struct aead_request *aead_req,
 		return 0;
 
 	len = buf[4] | (buf[3] << 8);
-	len -= cipher_desc->iv;
+	if (prot->version != TLS_1_3_VERSION)
+		len -= cipher_desc->iv;
 
 	tls_make_aad(aad, len - cipher_desc->tag, (char *)&rcd_sn, buf[0], prot);
 
-	memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE, cipher_desc->iv);
+	if (prot->version == TLS_1_3_VERSION) {
+		void *iv_src = crypto_info_iv(&tls_ctx->crypto_send.info,
+					      cipher_desc);
+
+		memcpy(iv + cipher_desc->salt, iv_src, cipher_desc->iv);
+	} else {
+		memcpy(iv + cipher_desc->salt, buf + TLS_HEADER_SIZE,
+		       cipher_desc->iv);
+	}
+
+	tls_xor_iv_with_seq(prot, iv, (char *)&rcd_sn);
 
 	sg_init_table(sg_in, ARRAY_SIZE(sg_in));
 	sg_init_table(sg_out, ARRAY_SIZE(sg_out));
-	sg_set_buf(sg_in, aad, TLS_AAD_SPACE_SIZE);
-	sg_set_buf(sg_out, aad, TLS_AAD_SPACE_SIZE);
+	sg_set_buf(sg_in, aad, prot->aad_size);
+	sg_set_buf(sg_out, aad, prot->aad_size);
 	scatterwalk_get_sglist(in, sg_in + 1);
 	scatterwalk_get_sglist(out, sg_out + 1);
 
@@ -108,13 +120,6 @@ static int tls_enc_record(struct aead_request *aead_req,
 	return rc;
 }
 
-static void tls_init_aead_request(struct aead_request *aead_req,
-				  struct crypto_aead *aead)
-{
-	aead_request_set_tfm(aead_req, aead);
-	aead_request_set_ad(aead_req, TLS_AAD_SPACE_SIZE);
-}
-
 static struct aead_request *tls_alloc_aead_request(struct crypto_aead *aead,
 						   gfp_t flags)
 {
@@ -124,14 +129,15 @@ static struct aead_request *tls_alloc_aead_request(struct crypto_aead *aead,
 
 	aead_req = kzalloc(req_size, flags);
 	if (aead_req)
-		tls_init_aead_request(aead_req, aead);
+		aead_request_set_tfm(aead_req, aead);
 	return aead_req;
 }
 
-static int tls_enc_records(struct aead_request *aead_req,
+static int tls_enc_records(struct tls_context *tls_ctx,
+			   struct aead_request *aead_req,
 			   struct crypto_aead *aead, struct scatterlist *sg_in,
 			   struct scatterlist *sg_out, char *aad, char *iv,
-			   u64 rcd_sn, int len, struct tls_prot_info *prot)
+			   u64 rcd_sn, int len)
 {
 	struct scatter_walk out, in;
 	int rc;
@@ -140,8 +146,8 @@ static int tls_enc_records(struct aead_request *aead_req,
 	scatterwalk_start(&out, sg_out);
 
 	do {
-		rc = tls_enc_record(aead_req, aead, aad, iv,
-				    cpu_to_be64(rcd_sn), &in, &out, &len, prot);
+		rc = tls_enc_record(tls_ctx, aead_req, aead, aad, iv,
+				    cpu_to_be64(rcd_sn), &in, &out, &len);
 		rcd_sn++;
 
 	} while (rc == 0 && len);
@@ -314,7 +320,10 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 	cipher_desc = get_cipher_desc(tls_ctx->crypto_send.info.cipher_type);
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
-	buf_len = cipher_desc->salt + cipher_desc->iv + TLS_AAD_SPACE_SIZE +
+	aead_request_set_ad(aead_req, tls_ctx->prot_info.aad_size);
+
+	buf_len = cipher_desc->salt + cipher_desc->iv +
+		  tls_ctx->prot_info.aad_size +
 		  sync_size + cipher_desc->tag;
 	buf = kmalloc(buf_len, GFP_ATOMIC);
 	if (!buf)
@@ -324,7 +333,7 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 	salt = crypto_info_salt(&tls_ctx->crypto_send.info, cipher_desc);
 	memcpy(iv, salt, cipher_desc->salt);
 	aad = buf + cipher_desc->salt + cipher_desc->iv;
-	dummy_buf = aad + TLS_AAD_SPACE_SIZE;
+	dummy_buf = aad + tls_ctx->prot_info.aad_size;
 
 	nskb = alloc_skb(skb_headroom(skb) + skb->len, GFP_ATOMIC);
 	if (!nskb)
@@ -335,9 +344,8 @@ static struct sk_buff *tls_enc_skb(struct tls_context *tls_ctx,
 	fill_sg_out(sg_out, buf, tls_ctx, nskb, tcp_payload_offset,
 		    payload_len, sync_size, dummy_buf);
 
-	if (tls_enc_records(aead_req, ctx->aead_send, sg_in, sg_out, aad, iv,
-			    rcd_sn, sync_size + payload_len,
-			    &tls_ctx->prot_info) < 0)
+	if (tls_enc_records(tls_ctx, aead_req, ctx->aead_send, sg_in, sg_out,
+			    aad, iv, rcd_sn, sync_size + payload_len) < 0)
 		goto free_nskb;
 
 	complete_skb(nskb, skb, tcp_payload_offset);
-- 
2.25.1

