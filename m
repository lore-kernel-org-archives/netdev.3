Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E241BA9B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685113; cv=none; b=QC8O1t2K+1Pa3UNy7oBQj0lIPcv1HhS3cWFEZYh8a0x9fHhOqdvXOIM/1LmcFod2r34ySupNUMlVCTFzPa6VRKYcSqz5hdSyd0tj379pgP0fWzppAwD7bmqwDflZ4NuLpjymmEYsyMOew3YaK60xoeiJ9340FE179ppia4+TuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685113; c=relaxed/simple;
	bh=6VNG83JMpitISinWU0kqRrhM1UJBqEAXUPP7+uhfubY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/z68dLaR45TQx1ssulcahdxHnsj8sWZfjPAMgBClz17TeFlZEdBvRIzbqlRENtPAaW0APQfKJpDq1HpBYCQEG0mE9EYGd7zbSa4Iz3Va55oNq55n42R3kAeS67OG5Pf4ajvuGB5Ihjsg5DJcAhuYIc2bxtnD7tCy/9tvgDUwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ByyMtdhx; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ByyMtdhx"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6b9cb8883ecso62884eaf.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685110; x=1790289910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2yz35qdVlJ7T//h61Os1RAKwSlzUISc0CpMdRXpofKM=;
        b=ByyMtdhxRPcg8aG9plCWLPfY1q7wPWaVBCnxou/MeYQXkBgHoZ1um2Ck+BGAVsV16Q
         Pojt193emEZrIhK8NCBzX60SWOC6fXZ8YRNvBmDfpgqHlnAukVRSV39s87xAglMKbAZh
         nXEsSD/Pr3tAPdx6bZCkTYsmEkWNTCEUTPNArKZkNCJlHkijm6Ytltx+FTj9lrN6uR63
         JI6lvUofFJE78l9O6hmIZDtO21c3fqzSNb9+oxH+W7FDTfk1wSFJMoR+cC8pnMX5bH0e
         GQrR3P6MWlvh5uKBMxWzwazt6ZtDdt/1emUde902iaxtwsBOJiYW6Uk25yiQb8whu1zf
         dFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685110; x=1790289910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2yz35qdVlJ7T//h61Os1RAKwSlzUISc0CpMdRXpofKM=;
        b=W+8VpyrVbwyjAzEKkXv4cRpOgQL5j0A1HWQclJrIie3M6lKXEQbUJX52gur8ASW0tR
         EaPxah1ldZyj8N+UfC/z27c/kyVdd6Ixr9PjpLMvR7YHEYtkTVEzTrFtcGF0BvVopYtL
         DAH5tpvM43/wjV0WhZAke2XLwWa/YkrLJtLsdmstv+tsxhoVr5fBWTp7dhhZs+H6bPCe
         qYSmI3Sa0a/bLfChXcTJiQyapnB4iZaM3qMoAYPc+VWRG1ODM90u5AWcCK5v92KEnR7O
         OkP+zx00S0DFQadiL+WhuXKukix0BFc/pAnv6xQSvFh1bzj2FVnY+akefMPKHo89iBA6
         dZ7w==
X-Gm-Message-State: AFuF++mVDey0JF1wrKvHrgCbMat9viqAykCjpetKQ4IFcei/BgHC2Q6d
	LTPkOGILRGuCkh7CPb7zPLdX5t2OnQY07p9XkXVWquPyIl+dwR+cNDZGXyOwDk2foucm++e+Rp9
	sXdmrmu66HZcpVBK79zZwso5ZGz3h/1bWfcKmDQ22WPhzoTlRh+k2JlLITYK1ygevhD107JYWaz
	q/Qx9bTF3mpC8Nj4iJJBBLUY9WaJ/oZ1+9VVwND4pS1r5YOlE=
X-Gm-Gg: AYBFou1gcm/RZCySv5FnMsgc9hcn2qFBW7UC40D5kELc/Z6jTYUUy5So1YERAgEj+o/
	BLIQueXBNAM62fp9QmxuE9saaXdMO1ZoGYuk4IkF/sV92T4OhnyH9nV37cU/aHk4UMsAg5ExqYW
	aEmwXsfdQjcKnrXp1cQ4Q4xB2zqA+j9OWQfgwY+2DSdMn9ouXoYrN8c4ulmfuR6IV9nT/5hzkuJ
	/WoZHbetTpVHJUpiopxJTzj2FkAHM+TNGDuw8v051GhZ+yPmGFpeSzjEHgFqUyduBRHl3bWvkEs
	hOxU/VRcIIiZKZ0pj7Nc/v9kPBahsu4pgx/HLjNeOVAA1zT2BCpgX/cwQYmUPnlCZsbJDWCPDJH
	BU1K3MJAuBHzlnc9jC8v2c92xtejmeqbNGTIzHxFqJLCssmGQEnZWxw4T+xegem2qE9TsNFq7SO
	h1bG/nGIhME8mMRm5HKaUW0Lu6/i8Hn7J2cQviExSLB3yrh9NKyy1fC9OsQnxeGEO4jqRcAu4X5
	+RdGl2GVDAyQQ/cj5XIYYnVlVGC0KmDSRwrpd/vQ53WQiuSSxq1oxTPcfj40nQVGoS6WjQlh9nK
	F1dLhUAgyd9MwdmWV7IpqMY0G4lLcn0kk2SjAVoijdOX/Vb8oz1x+UT32vBd6Yg0fTpenuFsMcq
	R0pGFyVHdcF3ZhWgBGw==
X-Received: by 2002:a05:6820:1791:b0:6b5:ec2f:3578 with SMTP id 006d021491bc7-6c8ffa3004emr3781830eaf.41.1789685109533;
        Thu, 17 Sep 2026 15:45:09 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:08 -0700 (PDT)
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
Subject: [PATCH net-next v17 05/15] tls: split tls_set_sw_offload into init and finalize stages
Date: Thu, 17 Sep 2026 16:35:16 -0600
Message-ID: <20260917224355.2288021-6-rjethwani@purestorage.com>
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

Separate cipher context initialization from key material finalization
to support staged setup for hardware offload fallback paths.

tls_sw_ctx_init() allocates the SW cipher context and installs the key
(crypto_alloc_aead + crypto_aead_setkey); tls_sw_ctx_finalize() then
commits the IV/salt/rec_seq into ctx->{tx,rx}. tls_set_sw_offload() calls
both back-to-back, so its behaviour is unchanged.

In tls_set_device_offload_rx() finalize now runs after tls_dev_add()
rather than as part of the old fused tls_set_sw_offload() call. This is
required by the RX rekey path added later in the series: on rekey the
device is programmed from new_crypto_info (via src_crypto_info), and
tls_sw_ctx_finalize() copies new_crypto_info into ctx->crypto_recv.info
and then memzero_explicit()s the caller's buffer. Running the fused call
before tls_dev_add() would wipe the key material before the NIC is
programmed, so tls_dev_add() would install a zeroed key. Splitting lets
tls_dev_add() consume new_crypto_info while it is still intact, with
finalize committing ctx->rx and scrubbing the buffer afterwards. On the
non-rekey (NULL) path this is a no-op reorder.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls.h        | 12 +++++++
 net/tls/tls_device.c |  3 +-
 net/tls/tls_sw.c     | 79 ++++++++++++++++++++++++++++++++------------
 3 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 60a37bdaaa25..8450492f32ae 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -147,6 +147,18 @@ void tls_strp_abort_strp(struct tls_strparser *strp, int err);
 int init_prot_info(struct tls_prot_info *prot,
 		   const struct tls_crypto_info *crypto_info,
 		   const struct tls_cipher_desc *cipher_desc);
+/* tls_sw_ctx_init() and tls_sw_ctx_finalize() are two halves of installing
+ * a SW crypto context, split so the device path can attach the NIC between
+ * them. finalize() may only be called after an init() that returned 0, and
+ * both must be called with the same tx and new_crypto_info; on a rekey
+ * (new_crypto_info != NULL) the two must also see the same
+ * new_crypto_info->cipher_type. finalize() commits state and cannot fail,
+ * so violating this leaves the context inconsistent without any error.
+ */
+int tls_sw_ctx_init(struct sock *sk, int tx,
+		    struct tls_crypto_info *new_crypto_info);
+void tls_sw_ctx_finalize(struct sock *sk, int tx,
+			 struct tls_crypto_info *new_crypto_info);
 int tls_set_sw_offload(struct sock *sk, int tx,
 		       struct tls_crypto_info *new_crypto_info);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index ada66c0bd075..a1e22d9f3217 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1254,7 +1254,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	context->resync_nh_reset = 1;
 
 	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, 0, NULL);
+	rc = tls_sw_ctx_init(sk, 0, NULL);
 	if (rc)
 		goto release_ctx;
 
@@ -1268,6 +1268,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto free_sw_resources;
 
 	tls_device_attach(ctx, sk, netdev);
+	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1ad31986cf2..7b593dac2c31 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2522,20 +2522,19 @@ static void tls_finish_key_update(struct sock *sk, struct tls_context *tls_ctx)
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
@@ -2556,12 +2555,10 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
 
@@ -2577,10 +2574,7 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	if (rc)
 		goto free_priv;
 
-	iv = crypto_info_iv(src_crypto_info, cipher_desc);
 	key = crypto_info_key(src_crypto_info, cipher_desc);
-	salt = crypto_info_salt(src_crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
 
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
@@ -2624,19 +2618,6 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
@@ -2655,3 +2636,57 @@ int tls_set_sw_offload(struct sock *sk, int tx,
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
+
+	/* Infallible: tls_sw_ctx_init() already validated cipher_type. */
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
2.50.1

