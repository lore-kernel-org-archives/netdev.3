Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43FB3E024B
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630481; cv=none; b=G8ZM8feyvtVlD5mRw6B6c+Y7meeT2VhGf/moM/8S2LqTpzAuH01tUADBtruQXn4mZ+00DsFnoYGXASLVl8+qSZ2lnDy1Y4EvcMgayKCbR5CvQLQVrxPtJhGZGq2zSjo4Cbdh25yoOalu0O/LtpXLdlyabGu/JBw7OFECFg2sT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630481; c=relaxed/simple;
	bh=1uiIxQ2lNTx8aDtvWUnAGJHbQp6IXYDFCAy0L8WuE6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OrNPxXVFGG/p1EB224nXm4y+yxK5bicxVmGgEZeCL33pavXR3g3rBG+KnqjHY+YUvRnLaeVMAFi3+5u44z7rgpVfOHV7Yjl++YVJ77NYRdUe/A3SNwEQrZ2k+7gPrycqevLe17e5JqbWNYGrWX7ylHtkSFC1nV0JjgRWNo7qM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K0TpkYRw; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K0TpkYRw"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a190528769so88995eaf.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783630478; x=1784235278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nlfxSCrKalnA4ikc1LXl/7BwxSQEPCADJP9wNT6lCVs=;
        b=K0TpkYRwiK5WswbMmXBoiHhDX3NOb3DBUa56+PJh56KUWjo9j3pwKCRl8L/Rm5vZZC
         oYt0YZHWfNxO1Q7R9tmCXFL39fjUpLvK5XdDO8/r0v4Fa4qOtOOWQtKAYxB8DJSiVsSC
         4VQBMj1jE2iXTuc+Wv3gZkIeosMwO4J0V/3FC7tNRC0Bzs6PsRuIHBBoZfNwjkVt98kM
         nUdY2fPwKzLFiYYS15L96GCd3B+eZB3b2jWDIeIUD7xuL5c/Jj5gq2lM9H6sxoWDpj5V
         MtsIVdHeNjR07XSnnSTPDmGMrtMP36VnzUuCNxH3WxFaohKChxDS42+LrjHry+qCkkH2
         osEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630478; x=1784235278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlfxSCrKalnA4ikc1LXl/7BwxSQEPCADJP9wNT6lCVs=;
        b=cxmxBeYtgcz2pKgGCu6UxArmqb+StjEfV3rKORtE6fHPRY7GCT3qzZXRgs2xUHDH68
         +mAMB2L84ty2txuO54AEGJzOTVUL943yKyZvTNfDgQK+ChyCgeRrIPgQMbTAsigETCq2
         UKISkjOpCn2ZY2VXnla4qOQ8+KUmdh5rpsVdoCVkzCChWmA93UFNWTTMJivlhCbc7LNh
         xYzvIHRynGM/dyH3XTYrd3FWlMn524TBwcnXcq8O7SQGnDBHj3efebBqj/rr3qg6frn/
         j3hDQwOiLxlmjAqdeomSDeVpkvWLTnF+vlb7vCLohABtzUhblBQntCbcXghXgdJqzNPa
         NDFA==
X-Gm-Message-State: AOJu0Yxx6w2e72wAUvAcs658isr6ukF2DJKvkWX7xdMq4ulCxkXHyJnl
	9Z6GohRiW0LoGSgm579WOO4vJryZrLELYgtauQW77ygRUxBsCuOdRwMbMlj4cyDfdiANjOAF7T7
	b7RENLQ/YqtAQrEvm5J+rMEX5XFVkg/4y3t4EBq79AiLndort8h85TluGicV6hvYL8K0JqxZytf
	X062bOgarN6e/zVEi0NUl1juvq9F0n1PoIpCeIkt6kBdgwCcs=
X-Gm-Gg: AfdE7cl6U1v2gomsh+9hXFGRdYYRNl9ePA56AvomEd78QWFS9ojUInPfT6khiHKnCSv
	+YdKokJOoEQ9jNLxc4elPLMKWMtRcmRMAatR+q0ng8hnfDlw/awyHYY4e6SgixDYOAc2D+KbCYo
	IrMB6EFEJYu0CVbX/WIemX/ruSGQHxPYcjZExc5rnqSmY0azPbwfMRbKJdojtod17NCXwkEAaDC
	PM2LS+5j5FZ0TJR+jWbSCZ+l4SJt+CPw/Q9ZRIS4lSM6uNfNI5RvhrVBHHdK598IBqz5ZLGudnF
	lCBHtoDdmPDtC3L67ZQz5O9UCg6dRHbCoijO6hmPWzAIDn7oz409btkyrgFtZD4h1+EBzBrwAhf
	EGe/05kSS1nP2oIXUdhQqOrL4vNBXU2JMVqOVVeAcJgWeGKSrhoyuOFxrrt+oNyhzGsiPbjpF/Z
	OJQVP9BESpj5lSAHd59oJm0n7kfbCUnHqFIvDjYeHRyMtl7mCOfSiL/iOFF8XKXeDIawSsTzap7
	Gg1IW1cRSK0ND0iMVMMzwm9zno4ylf3lNqZNmlMM9EIjUfsiq3Rl+fLNBF5wN64EuEhlFYvmpYr
	E8SMhExTnjm2iLU8QlN5yHT8c2kBeRFA9Z0=
X-Received: by 2002:a05:6820:f04:b0:6a1:963d:a040 with SMTP id 006d021491bc7-6a36d865554mr6308022eaf.2.1783630478388;
        Thu, 09 Jul 2026 13:54:38 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm3059283fac.15.2026.07.09.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:54:37 -0700 (PDT)
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
Subject: [PATCH v15 4/9] tls: split tls_set_sw_offload into init and finalize stages
Date: Thu,  9 Jul 2026 14:53:20 -0600
Message-Id: <20260709205325.1591196-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709205325.1591196-1-rjethwani@purestorage.com>
References: <20260709205325.1591196-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate cipher context initialization from key material finalization
to support staged setup for hardware offload fallback paths.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls.h        |  4 +++
 net/tls/tls_device.c |  3 +-
 net/tls/tls_sw.c     | 77 +++++++++++++++++++++++++++++++-------------
 3 files changed, 61 insertions(+), 23 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 60a37bdaaa25..5a6ee1ea00f8 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -147,6 +147,10 @@ void tls_strp_abort_strp(struct tls_strparser *strp, int err);
 int init_prot_info(struct tls_prot_info *prot,
 		   const struct tls_crypto_info *crypto_info,
 		   const struct tls_cipher_desc *cipher_desc);
+int tls_sw_ctx_init(struct sock *sk, int tx,
+		    struct tls_crypto_info *new_crypto_info);
+void tls_sw_ctx_finalize(struct sock *sk, int tx,
+			 struct tls_crypto_info *new_crypto_info);
 int tls_set_sw_offload(struct sock *sk, int tx,
 		       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a087cf3f544f..f22f8a550c82 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1233,7 +1233,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	context->resync_nh_reset = 1;
 
 	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, 0, NULL);
+	rc = tls_sw_ctx_init(sk, 0, NULL);
 	if (rc)
 		goto release_ctx;
 
@@ -1247,6 +1247,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto free_sw_resources;
 
 	tls_device_attach(ctx, sk, netdev);
+	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9324e4ed20a3..383eab5150ce 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2490,20 +2490,19 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
 	ctx->saved_data_ready(sk);
 }
 
-int tls_set_sw_offload(struct sock *sk, int tx,
-		       struct tls_crypto_info *new_crypto_info)
+int tls_sw_ctx_init(struct sock *sk, int tx,
+		    struct tls_crypto_info *new_crypto_info)
 {
 	struct tls_crypto_info *crypto_info, *src_crypto_info;
 	struct tls_sw_context_tx *sw_ctx_tx = NULL;
 	struct tls_sw_context_rx *sw_ctx_rx = NULL;
 	const struct tls_cipher_desc *cipher_desc;
-	char *iv, *rec_seq, *key, *salt;
-	struct cipher_context *cctx;
 	struct tls_prot_info *prot;
 	struct crypto_aead **aead;
 	struct tls_context *ctx;
 	struct crypto_tfm *tfm;
 	int rc = 0;
+	char *key;
 
 	ctx = tls_get_ctx(sk);
 	prot = &ctx->prot_info;
@@ -2524,12 +2523,10 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (tx) {
 		sw_ctx_tx = ctx->priv_ctx_tx;
 		crypto_info = &ctx->crypto_send.info;
-		cctx = &ctx->tx;
 		aead = &sw_ctx_tx->aead_send;
 	} else {
 		sw_ctx_rx = ctx->priv_ctx_rx;
 		crypto_info = &ctx->crypto_recv.info;
-		cctx = &ctx->rx;
 		aead = &sw_ctx_rx->aead_recv;
 	}
 
@@ -2545,10 +2542,7 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (rc)
 		goto free_priv;
 
-	iv = crypto_info_iv(src_crypto_info, cipher_desc);
 	key = crypto_info_key(src_crypto_info, cipher_desc);
-	salt = crypto_info_salt(src_crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
@@ -2592,19 +2586,6 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 			goto free_aead;
 	}
 
-	memcpy(cctx->iv, salt, cipher_desc->salt);
-	memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
-	memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
-
-	if (new_crypto_info) {
-		unsafe_memcpy(crypto_info, new_crypto_info,
-			      cipher_desc->crypto_info,
-			      /* size was checked in do_tls_setsockopt_conf */);
-		memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
-		if (!tx)
-			tls_finish_key_update(sk, ctx);
-	}
-
 	goto out;
 
 free_aead:
@@ -2623,3 +2604,55 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 out:
 	return rc;
 }
+
+void tls_sw_ctx_finalize(struct sock *sk, int tx,
+			 struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
+	const struct tls_cipher_desc *cipher_desc;
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct cipher_context *cctx;
+	char *iv, *salt, *rec_seq;
+
+	if (tx) {
+		crypto_info = &ctx->crypto_send.info;
+		cctx = &ctx->tx;
+	} else {
+		crypto_info = &ctx->crypto_recv.info;
+		cctx = &ctx->rx;
+	}
+
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
+
+	iv = crypto_info_iv(src_crypto_info, cipher_desc);
+	salt = crypto_info_salt(src_crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
+
+	memcpy(cctx->iv, salt, cipher_desc->salt);
+	memcpy(cctx->iv + cipher_desc->salt, iv, cipher_desc->iv);
+	memcpy(cctx->rec_seq, rec_seq, cipher_desc->rec_seq);
+
+	if (new_crypto_info) {
+		unsafe_memcpy(crypto_info, new_crypto_info,
+			      cipher_desc->crypto_info,
+			      /* size was checked in do_tls_setsockopt_conf */);
+		memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
+
+		if (!tx)
+			tls_finish_key_update(sk, ctx);
+	}
+}
+
+int tls_set_sw_offload(struct sock *sk, int tx,
+		       struct tls_crypto_info *new_crypto_info)
+{
+	int rc;
+
+	rc = tls_sw_ctx_init(sk, tx, new_crypto_info);
+	if (rc)
+		return rc;
+
+	tls_sw_ctx_finalize(sk, tx, new_crypto_info);
+	return 0;
+}
-- 
2.25.1

