Received: from mail-oo2-f33.google.com (mail-oo2-f33.google.com [74.125.231.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736963921C1
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685118; cv=none; b=MKmmIdEgMgKe/6dfjaMCzl2X0hKWDhlOW557SDg5W7adJqA2MFHjp39ae3C5JKqosrxpAKqyDq32DvjDrttyCeQrhd79+/uRlAubpZb1fKkM4MP+D68hLkJ0LMgmvwztm6BsbF5eGjZkgaRnBbGg0UjPs03Lk/PWbsR7HMpMIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685118; c=relaxed/simple;
	bh=/loM8c9r0WBMAn57OmayzwirjNu45kXYXUJN97wODDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Crl8Txtmz3F6VHz1qZ8uX9G/nKHi7zubPA2Asj34qrixivcwPRUCDxbbZ2CTTIDv4BLqHyCIfJ2ece0UgXfW0knDT1O79w6ILE1fEBvh6DOEQF3S52va9ab7+BbXMBBkP/gFayZE+q5gMRtMP2oPQGMvT2mXWwEwDJcQp2eZ9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=M1DhJuZq; arc=none smtp.client-ip=74.125.231.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="M1DhJuZq"
Received: by mail-oo2-f33.google.com with SMTP id 006d021491bc7-6b1ae6a9aeaso68406eaf.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685114; x=1790289914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDbN/dGjyDyrNXdiYPKqeRK+vIuDoZ3LSp/jtgGZFd8=;
        b=M1DhJuZqdIQkinwOKlie0Q2xzHsLUL0R3/eLZ0cBl7XS/C1Uo0Q/1V98dDgMe1ekDN
         R8cbJJVeP5tFMAp3Vks9rH1Pc+qhWk6u6+irFeWwi+vxLbPZqGlPmiLOXPWxHVZylxoW
         Q2OIV1o43xfndB+hSXczU2xmUAnLQUk28/nHhwtbZ9q1sP22Wm98GceQAE+YzhdgAFD0
         lztII3ptEcGBIeZePmSrSXFSGz35jsz65LxoOvyX7eB/PW5wV23ht80wq9gBFNFCCY/1
         6E5GmFcOsN2EdQUdpjpQ/o+dllUQt2zOaoi0pP4+Wyl5swCgobUnYGaG+vFjQrQuzUlX
         wvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685114; x=1790289914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZDbN/dGjyDyrNXdiYPKqeRK+vIuDoZ3LSp/jtgGZFd8=;
        b=qaVeLhm50h4iQe2s8fKrqPyczEtTxcj+S2tVb44My8cPRUxaR7OSjIa1NuQzSm4Km5
         Cxi3cXMhSRc72If2KZLiioUbj/LcVXojEVGeHYMvKVXkg0Tdbze3aX441rc3CYAZtkZM
         9PSaoBLL4xHR37Msu1D+P6RYgKiB/DWM5YScxq6bt1IgRKDQHurv+4kCuh6bHbV0Kt/2
         pJrQpCYApjE67IlrdE4T2lQq0ITBjvQYE8nGCgsXIM33NwwVDsEf6GQ+1pRyXbtWv8rz
         WOrd8g5J4KI2JpVCjdDqx3eTd5GFQ5Qt9WarY1T7HQq4iMecXNv9LsS4862ZgZ9ue7Mw
         w18A==
X-Gm-Message-State: AFuF++kNdDgZo/HwmfAUHL0jp/dUrQ1RjKUdciIeAPzn4Ow8h5b1t53u
	5Powpa9UnMGmruTjX3iBnSMrz8StaZcDymxdKuGkkaN51qXDdWU80EzMRYHIL9gJI7VxjvSaeM1
	gBYld3Sf3ufcA3FNs0qonHwDa55jMa3stcM3iHf9l10ZvB3EC1b64SqPIkM5PxOr96OUok9cYlM
	VsdbC0K8inbofHJ/Cid0OogsgmrkBe1QFHZ74XFSpgxsKi23I=
X-Gm-Gg: AYBFou10cZlROTF4531+/54Xin6xoV0h7D1GX0eD7HFqNVUhutqLZ5CJ2cRKwPV3rHh
	BsszMBb2mZfdVq2PvA4p3KjAreuVP6jhr03diRvaTCTHUG4gCFEfrV58B022xVI4bFpIsjfHk2V
	u6fbsboXeq2OPvBlLhi22mpLXsBH8ANcZ2gXkKbg2AwwsCp+74mQ+XQduulU01cSuLCXuMh8d/2
	2htEuitqw4rEoGJg9kWxBmf0ZkznmCjdItFBIZYU6lbCHfKuRBj36QRQm5vMQoJzH3TucNVhWEN
	I8doLO11dnxZCcMiE7QxPejzE5MTl0bFWeeI020vKPH1wCZvb4ElnoE95dJqziJWL8GzhS84CSB
	dnOCXb4k2ZQJNLMElO2w474/hfqMVNZhC6rO56ktAqkH4/I+XOkZ/VmgwXxNtW4uZ1JMPb3FvL1
	bZyTtXoh8XZ9/zJVYMevXsQZW8JpodjGFzo7bHNHIdzL97Yhv9BC+N4sbHftpWbyIeTi/iowIf2
	yfJd4cr+aPupSU8s9PGDw//j3rWHWJoOU5UcTNUge7LZ8IvW3A0cnXMJLD2StZYtI1crZhmZwTO
	dxqqK01ach/pc++NfPO6MQ9DqC28ePJWuJ2toNAP4zdo0I7hEvkHktuKoV+t9TAdus+C9lcAiv1
	fNH6Qz+kENXNSsjj14KTrzOTHgjx6
X-Received: by 2002:a05:6820:178b:b0:6c0:6ced:a9e with SMTP id 006d021491bc7-6ca9cd4f0fdmr510424eaf.60.1789685113538;
        Thu, 17 Sep 2026 15:45:13 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:13 -0700 (PDT)
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
Subject: [PATCH net-next v17 06/15] tls: prep helpers and refactors for HW offload KeyUpdate
Date: Thu, 17 Sep 2026 16:35:17 -0600
Message-ID: <20260917224355.2288021-7-rjethwani@purestorage.com>
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

  - Export tls_sw_push_pending_record() (drop static) so the device
    TX path can flush a pending SW record while rekey is in flight.

  - Split tls_sw_splice_eof() into tls_sw_splice_eof_locked() plus a
    thin locking wrapper, so the device splice_eof path can reuse the
    inner logic with tx_lock and the socket lock already held.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    |  38 ++++++-----
 net/tls/tls.h        |   3 +
 net/tls/tls_device.c | 157 ++++++++++++++++++++++++++-----------------
 net/tls/tls_sw.c     |  78 ++++++++++++---------
 4 files changed, 168 insertions(+), 108 deletions(-)

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
index 8450492f32ae..920a926e8e68 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -165,7 +165,10 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
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
index a1e22d9f3217..972c9c7ba7de 100644
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
@@ -1071,66 +1106,31 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
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
-	/* A rekey (setsockopt on an already-configured socket) is not
-	 * supported on the device offload path yet; reject it here so the
-	 * caller can decide (propagate the error for a HW connection, or
-	 * re-init software crypto for a SW one). KeyUpdate support replaces
-	 * this guard with real rekey handling.
-	 */
-	if (ctx->tx_conf != TLS_BASE)
-		return -EOPNOTSUPP;
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
@@ -1142,20 +1142,11 @@ int tls_set_device_offload(struct sock *sk)
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
@@ -1171,11 +1162,8 @@ int tls_set_device_offload(struct sock *sk)
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
 
@@ -1187,7 +1175,6 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
 
 	return 0;
 
@@ -1200,6 +1187,52 @@ int tls_set_device_offload(struct sock *sk)
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
+	/* A rekey (setsockopt on an already-configured socket) is not
+	 * supported on the device offload path yet; reject it here so the
+	 * caller can decide (propagate the error for a HW connection, or
+	 * re-init software crypto for a SW one). KeyUpdate support replaces
+	 * this guard with real rekey handling.
+	 */
+	if (ctx->tx_conf != TLS_BASE)
+		return -EOPNOTSUPP;
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
index 7b593dac2c31..5531303dd704 100644
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
@@ -1027,8 +1027,13 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 
 /*
  * Handle unexpected EOF during splice without SPLICE_F_MORE set.
+ *
+ * Inner logic of tls_sw_splice_eof(), factored out so the device
+ * TX path can reuse it with tls_ctx->tx_lock and the socket lock
+ * already held. Callers not already holding both locks must use the
+ * tls_sw_splice_eof() wrapper instead.
  */
-void tls_sw_splice_eof(struct socket *sock)
+void tls_sw_splice_eof_locked(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -1039,21 +1044,15 @@ void tls_sw_splice_eof(struct socket *sock)
 	bool retrying = false;
 	int ret = 0;
 
-	if (!ctx->open_rec)
-		return;
-
-	mutex_lock(&tls_ctx->tx_lock);
-	lock_sock(sk);
-
 retry:
-	/* same checks as in tls_sw_push_pending_record() */
+	/* same open_rec / empty-record checks as tls_sw_push_pending_record() */
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
@@ -1062,26 +1061,38 @@ void tls_sw_splice_eof(struct socket *sock)
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
@@ -2401,6 +2412,15 @@ static void tx_work_handler(struct work_struct *work)
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
@@ -2452,11 +2472,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
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
@@ -2576,6 +2592,10 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 
 	key = crypto_info_key(src_crypto_info, cipher_desc);
 
+	/* A rekey normally reuses the existing tfm; the RX HW rekey hands over a
+	 * NULL aead (the old one is retained for the drain), so allocate and
+	 * configure authsize only when a fresh tfm is created here.
+	 */
 	if (!*aead) {
 		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
 		if (IS_ERR(*aead)) {
@@ -2583,6 +2603,10 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			*aead = NULL;
 			goto free_priv;
 		}
+
+		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
+		if (rc)
+			goto free_aead;
 	}
 
 	ctx->push_pending_record = tls_sw_push_pending_record;
@@ -2599,12 +2623,6 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
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
2.50.1

