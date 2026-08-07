Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384F37C92F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128034; cv=none; b=pS0ABQBBo82gwRs1itkpCKqMDRCQJ4VFQIM9j+YaTQ2HPllSbtOEYFMiCY9fQDn041r9bV/5FaUB/aoRrzh3erroVaM4Uf0k1AscZpHY6i/8q45iuU0FtaKTvEyBV8BnNyFWwDEHnakZBqoUWPyYA5TW1ZzUQ8wSULBOd69DjNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128034; c=relaxed/simple;
	bh=+FbKTiP6+yL26LrW8rKzgAL8dTbH340Ee8iU5no3FD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubR2ewDjHlQS/WXCFrsLhVHa+fAYfs1rie+ZUtCG3A4c5w5bGbVfvx62yTbEhbIY7CofSW0FW6i7k5/2tJccNxeydDmxWu/agld4BjvUluRozNLu77+k37Ldryw2c8MOnPJ+6TSyzV2awQKCk9+EigUR3mARHOBRGeKRIPDZpsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HdvWYHTF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HdvWYHTF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954dff6536so27163905e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786128027; x=1786732827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r9ocLTjA1krsXmHdvCAvau1CBXKXGnVvohZewsxp+YE=;
        b=HdvWYHTF6gFr1FX6D20Plw1vpLLHBCBt2FgtpOlr4A/H9vEycxuEq4YsCBnbldrX8E
         RerLwCRVPJu4lDhs8TGJcBJwNl7yH3/qoaLTc6LljwBo0ld9auGOd4rpBqJpTUyJQukR
         0h7gau3MpIaE0/NQs1lHwqSkItLXYP8swFUJP8dGS222AYxNKC1vT+eI7ypQvKWMsdgW
         ehBn/0uLCJvtITUifLyCWwaAL+io+uZ1lmtKE7gxqld4GVY7ZJTjYL5knDmh4mGL62H5
         /FKDdCsbmp/BhQiwn77cYuyGa3PSmZSFlAGrVmie8AOXWFHC9ybWG8wtAtlWOD0/O6nN
         ZkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128027; x=1786732827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r9ocLTjA1krsXmHdvCAvau1CBXKXGnVvohZewsxp+YE=;
        b=bFaw0RALdjId0lBx3nspZBrjwXAQNCIAit/FHkruSg9wemkJcZ6tsgvi41bBow6xJO
         sg+bUKK0xh6pyeAl2/8cSOo4+yQc/PYfmCY2e1XxIlKIatcf0Uexl2zF0U6/8RhUm4/j
         oXu5IVw2z9qpBIqXgZvrFgitevoK1uD8+h7RN90jDiHmkptbTpI3TNH407gjfAbmLUxk
         s9IFd8mnVTHRE9WARuu2c/+08Mpr6RJOQFUQ43ZK2v6nmnnrsql7sP+DowYUZ3OyL5Qq
         krzLQETc/hwqwOJHha2Haay2EnSHSVhRxxpZHDfaYnkLYr2T4SerfnZhGMAmQfu/n95H
         IXww==
X-Gm-Message-State: AOJu0YzbozhWnxdRf93pIRx23E/ngjR0w5fg5m9QqqtzsmcCBuvZY3iN
	BXAC4MUei2kyWDwMcNBtbnJaj4gfa5kAKIrFoEW3h9BC/uxV4qQmrdDUTyV0jZnCM94xNcfCF09
	F+5BCfCgmyG3RQSYJydHzZsuSBsJVTV44ntVMDxHP+ASrq97eH9oXRmpWVQbnUUnEZrrfRf0c4l
	a/lw6IlD028AwlATxLgTBS3SDv1izyouvjHHYHjyntjQf3z/Q=
X-Gm-Gg: AR+sD12/ybfJ2JatFNEK6HM2zyJlCgYkZ4OiucyLrkNCt9Ck+rYS5/0uGymVn5DNP/Z
	zQjF4DAiBuV96SrpEfMCapniHJPkFYuG3EJmTnCvUj8ftGOFyNTWD1ShGhRqQwTQBlRAZnuJ5pZ
	XVw7UeaZSwm8X/FAg8/yjx6UF0RJr7MFWClgunZj/ERsqS0BzVeJiGGckg1C0kwB9Yn+FIkOkxG
	/exrBUIzfDdVzSx1mn0i2ez8UtnfMmuToDiLQVadSceY+B5NXECo+WFWJNfWN3ZG4OgSMHB401P
	ZFmZd6a29S85OdtxweNk/4jg/xbV/KEfEmwJFqDAza7pfidV43gamNKB0q58TbddD/Nwph1cg8b
	tJM2af2BqZaMRmMsQZpEjUEmcEQn06EUTlQxwBwHgv58c45ZrT3vluK1nCTjK1YGMmOrbIp80wW
	aQtZEq5W2RRAkuVxVT9tjsch9nketasOAWz1xl/Ux6Ubgrdxk3gVoa+ce8TKKXgS2T3NvEE3/vd
	q+O7NbPT7R0uXhnY2rjmw5C6laotCTlROeDsun9KSOEN9pW2w3Rjo279sm6/ORCov9nyI+O7kah
	vo1MKRSl4GI1F/k0KpMnewAP9LoBBvA/2KdEV2G+FAvFqPkhsaNpU/CLvMmsetTo9VoviX2UJRm
	AVRtzDwU=
X-Received: by 2002:a05:600c:4f82:b0:499:518d:ebd6 with SMTP id 5b1f17b1804b1-49959e3c714mr143332335e9.17.1786128027046;
        Fri, 07 Aug 2026 11:40:27 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:40:26 -0700 (PDT)
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
Subject: [PATCH v16 05/10] tls: split tls_set_sw_offload into init and finalize stages
Date: Fri,  7 Aug 2026 12:38:48 -0600
Message-Id: <20260807183853.2288959-6-rjethwani@purestorage.com>
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
index bbb1aa733500..cf67e1f6c5f4 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1235,7 +1235,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	context->resync_nh_reset = 1;
 
 	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, 0, NULL);
+	rc = tls_sw_ctx_init(sk, 0, NULL);
 	if (rc)
 		goto release_ctx;
 
@@ -1249,6 +1249,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto free_sw_resources;
 
 	tls_device_attach(ctx, sk, netdev);
+	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 62d46736e24b..63c83247f9a3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2517,20 +2517,19 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
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
@@ -2551,12 +2550,10 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
 
@@ -2572,10 +2569,7 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (rc)
 		goto free_priv;
 
-	iv = crypto_info_iv(src_crypto_info, cipher_desc);
 	key = crypto_info_key(src_crypto_info, cipher_desc);
-	salt = crypto_info_salt(src_crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
@@ -2619,19 +2613,6 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
@@ -2650,3 +2631,55 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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

