Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD448C8D9
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685111; cv=none; b=MMbH+QyXb3SkiupITC64xoGdqFSfdyLSkS253GfmwX5nWdTE/x7P5NfouV743q00Apz2QmB6KwbPtwqKa0X5hFpMHI9ll/DfoIIEKyXrkk7248Sc7eN14UPssfHaFUSB4aHBZV2srwlmdUbf0fXDAzLEKrC1k8yZ51/7Jt8ADG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685111; c=relaxed/simple;
	bh=kJFlquwWPhd/mcWnDmuEP9WnYcvx5yxlD3zDgkvXDVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHbnkQQSFXxiKRj7B1aK76L8nbpYLZS2ClVxEZ0cOgaXVBIVW5Xx8CwlCwuyktq2P+ZOvqJjYqQYv9sNGD8/BS20TJAK6Xh8ycnGT2eugAnyX66IT5ZT4izgqOZHuHUK02LKQlVwTsPq9neXdUYT2H7vVqP3ILozyuy5A6ZWAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=R6PKAfiQ; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="R6PKAfiQ"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6bc475ffcbfso41508eaf.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685107; x=1790289907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gmGN/vQ5gCdxSWY+xZ+bTThAQOGmalMXsBPVCYFDRM8=;
        b=R6PKAfiQWcWIJ3F31AQDrh+6kZxTQhUlwrYFBGP40MHgwK4afd2KdVITO/UxvQVLar
         HT4d6TxkK8iIXZXb4Ih8kF7kcb9/rBsg8a76RvC4iLXGq7932jfz6YJR1Qblw3iMjBai
         +QVlL8SOHpGffukCnk5Nq1B3TcwfDclqFZyxG1kerSwOqrDuVU3HwdOwfpm966bvdOKq
         q6YfIxSPirRR6WmFfaySD73J8+7nddryf/T40Ge/u3Yc35MVQAJsRgJc3mbc47ByNMBO
         6lNOJYZFR4XFK6EMpGkpALCmg17//C2w2ca6wRVirDQZWljE/9ENibMQiTmV2e8w/Dp2
         pnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685107; x=1790289907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gmGN/vQ5gCdxSWY+xZ+bTThAQOGmalMXsBPVCYFDRM8=;
        b=ocH8UWwz9iwJMcX+qGWQ/jqd82mgB40UM6pnAB6ROQae7rqn7mKESTHEvH0JwC/Pzg
         Ca1/XtSpCPz/VJELCNUXEITigVrHm3qVA+QfGny/Qtc2lP7s5l1FoqSMaWuBRhkLsMl+
         QGhhVzMch0NW65K/11vSojBpKPL5DKnm3tC5QRl5EsGlDQ+AMvXFbeMjO581uNe+zbLF
         RJtXl9YYCG5241sf7tFPA+hELN2t2D2pJtBpYRL7huVeYa9g3Q5/ot3XNH3h7Or0VB9x
         4qAQk9GXGhZ6STeagKk4QWNFcJMf23jXZVOcJU1felV7DOgtrjkCZuD4yHGX51lkgn3m
         EFHA==
X-Gm-Message-State: AFuF++k7sThHiJBWgmf8icFEV+i4+8LKXea2dECFHuSA325BN/rnSSmB
	lU3SCy5CFW21KkDq0h5HW8LE7n2EqNjHva9YAVS2fk5MKRd6uWtWHyuqXIXX5b/YgRLiPWNY+RR
	BVKL5JSFdxa4dY7iXsJ//XaolZ6CFfsv8yRuca1HW1WMU22iy+sGcpdFf1KG2KNqUFoVfM8Anym
	cLoQeb1Qe1xVBGdgwshwC4YsXDFBwXQXcSt2xObHhSKV2e2pM=
X-Gm-Gg: AYBFou3hS5vWq51J7N55eQua3qbTznSTTbMl2f5o0BnplRqKNScA4MZbR63EuNZnR5A
	I16OF54Auav2d8w41Ga1z+AUMGFPm/49kXOKWW9JtC2co6E7XpRGcoOhEvSzwibehPGJgH527Db
	WHeHhTU6ST+vzHe5giY5f/4onAJSgYdj/JRPEmkaQuQQiS2fFdFprx+JknNCbLUkthuu1X8Qwlv
	WFZpATLPxUK2MHhb/gy22f1jkhPXj+xsk0x9/mJ+eosUM2GDmpw0+WFbwXrRwI8C9PmmUMz76yN
	Lghyis5FuPA7X5wVnwS3f0sZzKgMMUK/SkkFTg42ZXx43i/mQZ7KEKuoyaeHQxVeWjreYyHwWeB
	XLypRHmv8FnQVpcLeW/1LYZr/gdsgsC1JOtIvGbX6yuEbq1qyslD6spiZRiXa+K1AwBHn7WoWPb
	txh/JkoEcE2Mfw96Cz5KQ337pk5zbLv5GscCIOLQv/jZpKwa3r87eq6szMiS1D7ZCkfoqMu5np3
	XBjXepF3S7DUGyukVtLoyaIwgBwOkWO4IVnHjHkDfD+cn3VLZPQcvs6P/hOfpXsmB3xvoOfBFM8
	D/PE21vQ8HrgsPJzCzFqIE5/NkF8QEGdX/Xai/D6j9TDLlSpYkv5P1ErFyo9v7kP2czashr14qC
	Jou5FEIMJFxwwUg6RGA==
X-Received: by 2002:a05:6820:1791:b0:6b3:bb82:2736 with SMTP id 006d021491bc7-6ca9a34a47amr522662eaf.17.1789685107049;
        Thu, 17 Sep 2026 15:45:07 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:06 -0700 (PDT)
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
Subject: [PATCH net-next v17 04/15] tls: add TLS 1.3 hardware offload support
Date: Thu, 17 Sep 2026 16:35:15 -0600
Message-ID: <20260917224355.2288021-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917224355.2288021-1-rjethwani@purestorage.com>
References: <20260917224355.2288021-1-rjethwani@purestorage.com>
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
path lands in a preceding patch ("tls: reject rekey attempts on an
existing HW-offloaded connection"); this patch is limited to the
device / device_fallback side:

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
 net/tls/tls_device.c          | 72 +++++++++++++++++++++--------------
 net/tls/tls_device_fallback.c | 58 ++++++++++++++++------------
 2 files changed, 77 insertions(+), 53 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f5e1b6b61ce3..ada66c0bd075 100644
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
+	if (unlikely(!pfrag->page || pfrag->size - pfrag->offset < tail) &&
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
 
@@ -886,6 +895,7 @@ static int
 tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
+	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	const struct tls_cipher_desc *cipher_desc;
 	int err, offset, copy, data_len, pos;
 	struct sk_buff *skb, *skb_iter;
@@ -897,7 +907,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
 
 	rxm = strp_msg(tls_strp_msg(sw_ctx));
-	orig_buf = kmalloc(rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv,
+	orig_buf = kmalloc(rxm->full_len + prot->prepend_size,
 			   sk->sk_allocation);
 	if (!orig_buf)
 		return -ENOMEM;
@@ -912,9 +922,8 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	offset = rxm->offset;
 
 	sg_init_table(sg, 1);
-	sg_set_buf(&sg[0], buf,
-		   rxm->full_len + TLS_HEADER_SIZE + cipher_desc->iv);
-	err = skb_copy_bits(skb, offset, buf, TLS_HEADER_SIZE + cipher_desc->iv);
+	sg_set_buf(&sg[0], buf, rxm->full_len + prot->prepend_size);
+	err = skb_copy_bits(skb, offset, buf, prot->prepend_size);
 	if (err)
 		goto free_buf;
 
@@ -1101,11 +1110,6 @@ int tls_set_device_offload(struct sock *sk)
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
@@ -1208,9 +1212,6 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
-	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
-		return -EOPNOTSUPP;
-
 	/* A rekey (setsockopt on an already-configured socket) is not
 	 * supported on the device offload path yet; reject it here so the
 	 * caller can decide (propagate the error for a HW connection, or
@@ -1429,12 +1430,27 @@ static struct notifier_block tls_dev_notifier = {
 
 int __init tls_device_init(void)
 {
-	int err;
+	unsigned char *page_addr;
+	int err, i;
 
-	dummy_page = alloc_page(GFP_KERNEL);
+	dummy_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!dummy_page)
 		return -ENOMEM;
 
+	/* Pre-populate the first 256 bytes with an identity map so that,
+	 * when this page is used as the tail-frag fallback (allocation
+	 * failure in tls_device_record_close()), dummy_page[record_type]
+	 * yields the correct TLS 1.3 content_type byte for any record_type
+	 * without runtime validation.
+	 *
+	 * A high record_type pushes the tag placeholder past the identity
+	 * map, so __GFP_ZERO is what keeps tag-placeholder bytes defined
+	 * rather than exposing uninitialized page contents.
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
2.50.1

