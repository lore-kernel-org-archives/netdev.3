Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BD37AA8B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128040; cv=none; b=trNPESvSy869TLJC9n+duLSyCF0+atyxKyklLsm94UIFIKTc6LRekIN9dtjP4Blc0dmsElN9xnVqz8xNS+OI2pLUuNl3/hHeGdOH23rVeUALwzx2cOOWNT1Y1XbqzRfT5ThOvPYIWPeArbXqxi2QlR3FZEziEuxbfo3woFcZLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128040; c=relaxed/simple;
	bh=ZEDjpJZQelhxXFfCBjXLLOAn8DcCuOAlAzcnnfRyTys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tu9LmJpPthvIubpa9DCzLV2qhSRsUD7MHjrVqFa8Ry08dg2Krgmao8mUhIP2GzR9LE7tcWyPY+OcJjJSpWOQ1BOMqwlJB8SmfGArG/MOR5bvF0GMZHNNdbs2k3wwyUZdiEpsj1BRtW6F7rRa4MapnZZiXJeSEGPpJ8IGOw/X2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GzcLTDVC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GzcLTDVC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49802c418b5so35695535e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786128034; x=1786732834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OjgCDwyVXvLh1j84pQ7TBErqpFrI4sVPwde/yoVJiAQ=;
        b=GzcLTDVCBpFEwLjsDoLyae5ydDWPMFWMuzPUlyapMryLz2adbEa4dgSZkpUgeelsYf
         deqqYmCvkbOr7KTeTG+2dI1+Rkns5w/SQmsWzvJxAS/JDWgMYDUV6efLrr3NTDpzrQH2
         7oY21F3q0zrkWnokpM9l8/vyW9DFk53raJWeKOmEm05oq27PWWV7ddElpUKa6xILfutD
         LB6KZeN1krMz66TiNVA5xNq974I6PnqQWtBJ0BORMcYqGi3e/HmSIYTUGFF4/hUY2cUH
         gncuH0OzgCpHD5E18fH6jiw5hgQNR79wwJ802B9PYvVMxAuCbZhfcIylqs/KNrVLRGAL
         +j1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128034; x=1786732834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OjgCDwyVXvLh1j84pQ7TBErqpFrI4sVPwde/yoVJiAQ=;
        b=MDMXND1TZbKxaOWAJWusWWwCY0RKQhI2FucVLy/JNyGpf1TyadiA6boup+JrvZq4Rw
         TWRRXMph88hZYdE4NFNMCrMM/vXqCuf9LNz71DVxqgeFaGXZZw6Hfu0QohqlkeEBIIkc
         43Yxp5KtqOLQbixRteSOggRV7X1Rkiq4d7/LY5xUiOwh7GvN/Z5ICBbkGim5EXJrcQtD
         u0yCNKm9EwYVZC3106tdfKssGE9GDmXPE/R3GFQCUXzdHb8pO/CHR2KYkbckJVHXgSCa
         ItToSSKJnL/iCIRsHirs2GbCQGJZMdgN9v3ZRVKrGZKfpn1S2BVjaS43zpEjqZPvlD9y
         MmWQ==
X-Gm-Message-State: AOJu0YwisMfzljFI3sgOo/MWdnk6f/rurHyNkn6wquCdNFsS5eLcwAOd
	tUIzlgvzBdwjHo9Jtinr8329Su+MjQ1oGi+0W0+rdUPoeyMaHvFDrEw28vAUM03mDLn4uCI/vZO
	wrqyp/1Qzhnwiqx3YND1z/3i91Ft2Uq3si9KzrlSCeH+UBVrlzOIA12laZDIKOsmLZdRVYm0ZJu
	t80Ec+gBBl+/iofXehAl/OV6s5YcI265/1TvtYJXBjoWevuOc=
X-Gm-Gg: AR+sD12O4VV+OQbvlPlbIm7Zl19CONEc9zw7Wx9dwr25U+9ksHtXf//yLRaQ3jVBTGe
	qTgJJA5QRVtrq9Fspjqv+Syc1e+37xBPPYyj0HIhD+AT+lk5N5IWWCfUh1yk96lMHkPUUb8bi3c
	itc+cQjH4CrZsPLC/dZxwvTkLXpNvKFA38ON8Z1XgBzZQ2laNiF9UMSFZgs8yEMWtdr2BBzWG86
	huHzxAhINmfBMIaINHWi6svyB51GII+ssgRxzgDNKJv3+3uLUviSTPij5Tqlf1NbsZA0tXXO4Tc
	vplPEN4YXmArzw3fwik2gDdO5db0WhCmO5epEGfT+aBNmUhEVx8RQptv9TS2AVHhfzpT8D9FAXn
	0Qp23pqm3i759QGmM4ndOG4Md/X9qGYfblHBcCc+Vuy1kfzc3iB/4z6clXmRoUMeR3lJUf5ZJVy
	Qrz/sRAYZvOBBvANdXO2ghXua2h5a9TK4koZIU3hznnCRtpXrflYjvniQmXIP5r8EUf8lQxG+5P
	LczVO9Br5MbaA6++6I8TOtJkzPiiGZq+QDTMooBu1w4MgBj5QQxFjRVdViy/3O2aKSxbDhxIwRk
	zj44BRJ+yIkno+ztt/EhADEuoyxqKL879LpwPLHEfVXtt3MK+ac2htlrM7s/mQSnY2rSeh9tC/e
	P+Va7r24=
X-Received: by 2002:a05:600c:3555:b0:499:521d:bff1 with SMTP id 5b1f17b1804b1-4996194e53emr29472075e9.2.1786128033970;
        Fri, 07 Aug 2026 11:40:33 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:40:33 -0700 (PDT)
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
Subject: [PATCH v16 06/10] tls: prep helpers and refactors for HW offload KeyUpdate
Date: Fri,  7 Aug 2026 12:38:49 -0600
Message-Id: <20260807183853.2288959-7-rjethwani@purestorage.com>
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

Preparatory refactors for TX and RX HW rekey support; no functional
change.

  - Hoist cipher_context / tls_crypto_context above
    tls_offload_context_tx so they can be embedded in offload
    contexts.

  - Add tls_tx_cipher_ctx() accessor and factor tls_sw_ctx_tx_init()
    so the TX path can redirect to a temporary SW context during
    rekey.

  - Split tls_set_device_offload() into a dispatcher and
    tls_set_device_offload_initial(); a _rekey() sibling follows.

  - Factor tls_device_dev_add_tx() and tls_device_commit_start_marker()
    so the rekey completion path can reuse them.

  - Move crypto_aead_setauthsize() into the !*aead block so a fresh
    AEAD is correctly configured when RX HW rekey allocates one.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    |  38 +++++++-----
 net/tls/tls.h        |   3 +
 net/tls/tls_device.c | 139 ++++++++++++++++++++++++++-----------------
 net/tls/tls_sw.c     |  67 ++++++++++++---------
 4 files changed, 149 insertions(+), 98 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index e57bef58851e..eb258bcd62bc 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -155,6 +155,22 @@ struct tls_record_info {
 	skb_frag_t frags[MAX_SKB_FRAGS];
 };
 
+struct cipher_context {
+	char iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
+	char rec_seq[TLS_MAX_REC_SEQ_SIZE];
+};
+
+union tls_crypto_context {
+	struct tls_crypto_info info;
+	union {
+		struct tls12_crypto_info_aes_gcm_128 aes_gcm_128;
+		struct tls12_crypto_info_aes_gcm_256 aes_gcm_256;
+		struct tls12_crypto_info_chacha20_poly1305 chacha20_poly1305;
+		struct tls12_crypto_info_sm4_gcm sm4_gcm;
+		struct tls12_crypto_info_sm4_ccm sm4_ccm;
+	};
+};
+
 #define TLS_DRIVER_STATE_SIZE_TX	16
 struct tls_offload_context_tx {
 	struct crypto_aead *aead_send;
@@ -195,22 +211,6 @@ enum tls_context_flags {
 	TLS_RX_DEV_CLOSED = 2,
 };
 
-struct cipher_context {
-	char iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
-	char rec_seq[TLS_MAX_REC_SEQ_SIZE];
-};
-
-union tls_crypto_context {
-	struct tls_crypto_info info;
-	union {
-		struct tls12_crypto_info_aes_gcm_128 aes_gcm_128;
-		struct tls12_crypto_info_aes_gcm_256 aes_gcm_256;
-		struct tls12_crypto_info_chacha20_poly1305 chacha20_poly1305;
-		struct tls12_crypto_info_sm4_gcm sm4_gcm;
-		struct tls12_crypto_info_sm4_ccm sm4_ccm;
-	};
-};
-
 struct tls_prot_info {
 	u16 version;
 	u16 cipher_type;
@@ -392,6 +392,12 @@ static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
 	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
 }
 
+static inline struct cipher_context *tls_tx_cipher_ctx(
+		const struct tls_context *tls_ctx)
+{
+	return (struct cipher_context *)&tls_ctx->tx;
+}
+
 static inline struct tls_offload_context_tx *
 tls_offload_ctx_tx(const struct tls_context *tls_ctx)
 {
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 5a6ee1ea00f8..e8b552c2f4fb 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -157,7 +157,10 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx);
+int tls_sw_push_pending_record(struct sock *sk, int flags);
 void tls_sw_splice_eof(struct socket *sock);
+void tls_sw_splice_eof_locked(struct socket *sock);
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
 void tls_sw_release_resources_tx(struct sock *sk);
 void tls_sw_free_ctx_tx(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index cf67e1f6c5f4..4f6b3ea1bde4 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -138,6 +138,41 @@ static struct net_device *get_netdev_for_sock(struct sock *sk)
 	return lowest_dev;
 }
 
+static int tls_device_dev_add_tx(struct sock *sk, struct net_device *netdev,
+				 struct tls_crypto_info *crypto_info,
+				 u32 write_seq)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	char *rec_seq;
+	int rc;
+
+	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
+					     crypto_info, write_seq);
+	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
+				     write_seq, rec_seq, rc);
+	return rc;
+}
+
+static void tls_device_commit_start_marker(struct sock *sk,
+					struct tls_offload_context_tx *offload_ctx,
+					struct tls_record_info *start_marker_record)
+{
+	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
+	start_marker_record->len = 0;
+	start_marker_record->num_frags = 0;
+	list_add_tail_rcu(&start_marker_record->list, &offload_ctx->records_list);
+
+	/* TLS offload is greatly simplified if we don't send
+	 * SKBs where only part of the payload needs to be encrypted.
+	 * So mark the last skb in the write queue as end of record.
+	 */
+	tcp_write_collapse_fence(sk);
+}
+
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -1070,57 +1105,31 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
 	return offload_ctx;
 }
 
-int tls_set_device_offload(struct sock *sk)
+static int tls_set_device_offload_initial(struct sock *sk,
+					  struct tls_context *ctx,
+					  struct net_device *netdev,
+					  struct tls_crypto_info *crypto_info,
+					  const struct tls_cipher_desc *cipher_desc)
 {
+	struct tls_prot_info *prot = &ctx->prot_info;
 	struct tls_record_info *start_marker_record;
 	struct tls_offload_context_tx *offload_ctx;
-	const struct tls_cipher_desc *cipher_desc;
-	struct tls_crypto_info *crypto_info;
-	struct tls_prot_info *prot;
-	struct net_device *netdev;
-	struct tls_context *ctx;
 	char *iv, *rec_seq;
 	int rc;
 
-	ctx = tls_get_ctx(sk);
-	prot = &ctx->prot_info;
-
-	if (ctx->priv_ctx_tx)
-		return -EEXIST;
-
-	netdev = get_netdev_for_sock(sk);
-	if (!netdev) {
-		pr_err_ratelimited("%s: netdev not found\n", __func__);
-		return -EINVAL;
-	}
-
-	if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
-		rc = -EOPNOTSUPP;
-		goto release_netdev;
-	}
-
-	crypto_info = &ctx->crypto_send.info;
-	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
-	if (!cipher_desc || !cipher_desc->offloadable) {
-		rc = -EINVAL;
-		goto release_netdev;
-	}
+	iv = crypto_info_iv(crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
 
 	rc = init_prot_info(prot, crypto_info, cipher_desc);
 	if (rc)
-		goto release_netdev;
-
-	iv = crypto_info_iv(crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+		return rc;
 
 	memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
 	memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
 
 	start_marker_record = kmalloc_obj(*start_marker_record);
-	if (!start_marker_record) {
-		rc = -ENOMEM;
-		goto release_netdev;
-	}
+	if (!start_marker_record)
+		return -ENOMEM;
 
 	offload_ctx = alloc_offload_ctx_tx(ctx);
 	if (!offload_ctx) {
@@ -1132,20 +1141,11 @@ int tls_set_device_offload(struct sock *sk)
 	if (rc)
 		goto free_offload_ctx;
 
-	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
-	start_marker_record->len = 0;
-	start_marker_record->num_frags = 0;
-	list_add_tail(&start_marker_record->list, &offload_ctx->records_list);
+	tls_device_commit_start_marker(sk, offload_ctx, start_marker_record);
 
 	clean_acked_data_enable(tcp_sk(sk), &tls_tcp_clean_acked);
 	ctx->push_pending_record = tls_device_push_pending_record;
 
-	/* TLS offload is greatly simplified if we don't send
-	 * SKBs where only part of the payload needs to be encrypted.
-	 * So mark the last skb in the write queue as end of record.
-	 */
-	tcp_write_collapse_fence(sk);
-
 	/* Avoid offloading if the device is down
 	 * We don't want to offload new flows after
 	 * the NETDEV_DOWN event
@@ -1161,11 +1161,8 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	ctx->priv_ctx_tx = offload_ctx;
-	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
-					     &ctx->crypto_send.info,
-					     tcp_sk(sk)->write_seq);
-	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
-				     tcp_sk(sk)->write_seq, rec_seq, rc);
+	rc = tls_device_dev_add_tx(sk, netdev, crypto_info,
+				   tcp_sk(sk)->write_seq);
 	if (rc)
 		goto release_lock;
 
@@ -1177,7 +1174,6 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
 
 	return 0;
 
@@ -1190,6 +1186,43 @@ int tls_set_device_offload(struct sock *sk)
 	ctx->priv_ctx_tx = NULL;
 free_marker_record:
 	kfree(start_marker_record);
+	return rc;
+}
+
+int tls_set_device_offload(struct sock *sk)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	struct tls_crypto_info *crypto_info;
+	struct net_device *netdev;
+	struct tls_context *ctx;
+	int rc;
+
+	ctx = tls_get_ctx(sk);
+
+	if (ctx->priv_ctx_tx)
+		return -EEXIST;
+
+	netdev = get_netdev_for_sock(sk);
+	if (!netdev) {
+		pr_err_ratelimited("%s: netdev not found\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
+		rc = -EOPNOTSUPP;
+		goto release_netdev;
+	}
+
+	crypto_info = &ctx->crypto_send.info;
+	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable) {
+		rc = -EINVAL;
+		goto release_netdev;
+	}
+
+	rc = tls_set_device_offload_initial(sk, ctx, netdev, crypto_info,
+					    cipher_desc);
+
 release_netdev:
 	dev_put(netdev);
 	return rc;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 63c83247f9a3..7b6ab992c86e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -555,11 +555,11 @@ static int tls_do_encryption(struct sock *sk,
 		break;
 	}
 
-	memcpy(&rec->iv_data[iv_offset], tls_ctx->tx.iv,
+	memcpy(&rec->iv_data[iv_offset], tls_tx_cipher_ctx(tls_ctx)->iv,
 	       prot->iv_size + prot->salt_size);
 
 	tls_xor_iv_with_seq(prot, rec->iv_data + iv_offset,
-			    tls_ctx->tx.rec_seq);
+			    tls_tx_cipher_ctx(tls_ctx)->rec_seq);
 
 	sge->offset += prot->prepend_size;
 	sge->length -= prot->prepend_size;
@@ -610,7 +610,7 @@ static int tls_do_encryption(struct sock *sk,
 
 	/* Unhook the record from context if encryption is not failure */
 	ctx->open_rec = NULL;
-	tls_advance_record_sn(sk, prot, &tls_ctx->tx);
+	tls_advance_record_sn(sk, prot, tls_tx_cipher_ctx(tls_ctx));
 	return rc;
 }
 
@@ -676,7 +676,7 @@ static int tls_push_record(struct sock *sk, int flags,
 	sg_chain(rec->sg_aead_out, 2, &msg_en->sg.data[i]);
 
 	tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size,
-		     tls_ctx->tx.rec_seq, record_type, prot);
+		     tls_tx_cipher_ctx(tls_ctx)->rec_seq, record_type, prot);
 
 	tls_fill_prepend(tls_ctx,
 			 page_address(sg_page(&msg_en->sg.data[i])) +
@@ -712,7 +712,7 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	return err;
 }
 
-static int tls_sw_push_pending_record(struct sock *sk, int flags)
+int tls_sw_push_pending_record(struct sock *sk, int flags)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
@@ -1028,7 +1028,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 /*
  * Handle unexpected EOF during splice without SPLICE_F_MORE set.
  */
-void tls_sw_splice_eof(struct socket *sock)
+void tls_sw_splice_eof_locked(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -1039,21 +1039,15 @@ void tls_sw_splice_eof(struct socket *sock)
 	bool retrying = false;
 	int ret = 0;
 
-	if (!ctx->open_rec)
-		return;
-
-	mutex_lock(&tls_ctx->tx_lock);
-	lock_sock(sk);
-
 retry:
 	/* same checks as in tls_sw_push_pending_record() */
 	rec = ctx->open_rec;
 	if (!rec)
-		goto unlock;
+		return;
 
 	msg_pl = &rec->msg_plaintext;
 	if (msg_pl->sg.size == 0)
-		goto unlock;
+		return;
 
 	/* Perform transmission. */
 	ret = bpf_exec_tx_verdict(msg_pl, sk, TLS_RECORD_TYPE_DATA,
@@ -1062,26 +1056,38 @@ void tls_sw_splice_eof(struct socket *sock)
 	case 0:
 	case -EAGAIN:
 		if (retrying)
-			goto unlock;
+			return;
 		retrying = true;
 		goto retry;
 	case -EINPROGRESS:
 		break;
 	default:
-		goto unlock;
+		return;
 	}
 
 	/* Wait for pending encryptions to get completed */
 	if (tls_encrypt_async_wait(ctx))
-		goto unlock;
+		return;
 
 	/* Transmit if any encryptions have completed */
 	if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
 		cancel_delayed_work(&ctx->tx_work.work);
 		tls_tx_records(sk, 0);
 	}
+}
+
+void tls_sw_splice_eof(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
 
-unlock:
+	if (!ctx->open_rec)
+		return;
+
+	mutex_lock(&tls_ctx->tx_lock);
+	lock_sock(sk);
+	tls_sw_splice_eof_locked(sock);
 	release_sock(sk);
 	mutex_unlock(&tls_ctx->tx_lock);
 }
@@ -2396,6 +2402,15 @@ static void tx_work_handler(struct work_struct *work)
 	}
 }
 
+void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx)
+{
+	crypto_init_wait(&sw_ctx->async_wait);
+	atomic_set(&sw_ctx->encrypt_pending, 1);
+	INIT_LIST_HEAD(&sw_ctx->tx_list);
+	INIT_DELAYED_WORK(&sw_ctx->tx_work.work, tx_work_handler);
+	sw_ctx->tx_work.sk = sk;
+}
+
 static bool tls_is_tx_ready(struct tls_sw_context_tx *ctx)
 {
 	struct tls_rec *rec;
@@ -2447,11 +2462,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
 		sw_ctx_tx = ctx->priv_ctx_tx;
 	}
 
-	crypto_init_wait(&sw_ctx_tx->async_wait);
-	atomic_set(&sw_ctx_tx->encrypt_pending, 1);
-	INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
-	INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
-	sw_ctx_tx->tx_work.sk = sk;
+	tls_sw_ctx_tx_init(sk, sw_ctx_tx);
 
 	return sw_ctx_tx;
 }
@@ -2578,6 +2589,10 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			*aead = NULL;
 			goto free_priv;
 		}
+
+		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
+		if (rc)
+			goto free_aead;
 	}
 
 	ctx->push_pending_record = tls_sw_push_pending_record;
@@ -2594,12 +2609,6 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			goto free_aead;
 	}
 
-	if (!new_crypto_info) {
-		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
-		if (rc)
-			goto free_aead;
-	}
-
 	if (!tx && !new_crypto_info) {
 		tfm = crypto_aead_tfm(sw_ctx_rx->aead_recv);
 
-- 
2.25.1

