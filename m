Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9ED37B40A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128054; cv=none; b=cyGZhCbpQBPUNQutv2Qt/73nUS0exMQ+p7eKn32GhbFW0A98yT5Om45jdpn9sIzq6IQPiDY98K5ey7bx1LKm4VGkbf8xGp7QACQP08QTodDh60Ue26ovbl8lyYGKbCDt1gW6QUsrsb9/7plZJaqPfpJzwFEsEjZ3tyrZ6yttbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128054; c=relaxed/simple;
	bh=dgKXuQbDofbdABvK7lEjKAn1PQZLUXvRAwQ3b67BTRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRLGLTz8bd3jNmg6YI3AkW7vIiSH3oiUdOcWg+AlXLgyfIr4AqDTUVgvnEJZ8DE0HEHziFX3VbQljhyBiU5DmivQGesE+zzwL4g+hHIyS7Hq8RoEdQmS25JergHys6GeqmrpYCrBuasEk1xsAkWWSpV595dsTFwpaFGmGcRXlUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FVN5sct0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FVN5sct0"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f7854678cso2431556f8f.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786128050; x=1786732850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56Iy2AFMiwFvffp5aE9uCnj9qn09Y0HGT4I+Po6OxKw=;
        b=FVN5sct0dMbNKL9t0ph14+gnt+FgaPCw+/XYhjhzbJ23HJNrCS8STtEmRE/nIK7wDE
         EUM1qvzZK1Z4d7smZewxZkyyeRAs0bEKjuhPm0/SOnchvhJnTkAvgQeQW+3R2PgOCQkm
         UD9zH1P0MkGFzg3Ib09qJtpHV6E1PchOnNzOR8OSmoJKx2K6qvbsSTB2zx8fwOnsTI/i
         r0VaNaGMUMro1yHhxdrqVA7tS/jISNZfITN8QOoFz+RXO2IF8qKqIt262LOMlkZ1Etz3
         4DSYnojwnb5B8wLjT2CZc8rFRqQsnjE2sGzgAheLUvOTDkJSl96QEA/EnFA2+W5RFWWD
         YhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128050; x=1786732850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56Iy2AFMiwFvffp5aE9uCnj9qn09Y0HGT4I+Po6OxKw=;
        b=X/Yc/AwgWbaVGfxLkWqLy5sKb38I7BiqZSXO0K0gvfjKExz7+ZCmEjDCl6JrB4ARfB
         NkOsbLvv8PYhyglCKE86fy8f9WKbZ8+GaOauPON/HO2qR+3LLxjP9wBBEkOEX+r88Xws
         B6T9uGLQzGrUVO6A3+AKAtF2cFkoRcPkdfgt/XF1d0s5sCyxSV9zDPBopTj/ypB9vLdR
         Y9YPq1+q0CDOKCKmK75huFhEYhwwMSjhdl0RO9U6vpeLOaQ96NGumF2Sm1nR/B1cKY59
         sP2uZqwHoGpdi4QuoPZkOPxqDlqfnpMe5nhKNy7ZKHweg5oV2dd4ZHC5oPII0TcTWNuC
         LYPQ==
X-Gm-Message-State: AOJu0YzuwxmqKkPD5jBhZW/xgNz8oLhFmuCq5g0GTYt/aoIU7tzH4SfR
	WP5sI6PfxwD2oWwGtTeC3KCat+Pma1CFKctZsJrufTlII9Ny/hxrWEcwLUckBjf2PEJlyR/BZS+
	p2Qb+Kk46+NL4E/6hJWvKQWAR62HOEzvX7MlSIGRl4mwhWNJPms3fEfOPIe34SZnuyfbD88kAc2
	dR15dWaITvuCQu91CuCWFs0JawKSXzAIGAyyvtNnKqutGl/oE=
X-Gm-Gg: AR+sD13mfH9LuAt1HD4K8oQbuIsHTEV7agw8Lg+tOmds+kVVII+OazvCA8tcsXHCLSC
	ALZ7uZHt9iOr5uXqtedkG6RopI8o+c9HHTzkWmLTmL/+QRBjPSigaSH+qqxJK2duZE8T/HReHR9
	DMTgO7ZL52fBej3zypajH7XSmAk1MIbnJTK93xgkU4W1vNbwwdKPwgE55ZchFoO6d+T8YTLny5h
	PEhMvODZJ/xadjkPENHKdtbjuscX7+HnHyZ5ZcZMS4liJqeRDlzllEsXdBAMtIBNt4kza+Rnxuu
	uO68Lt93FweGrYy8IiWn5VVu2Gx+NDGJD+x2GwgDtraWC4dY12mcOr4SUrlTeCpQd425x+3RN5g
	DSITSG8McNxmogoggRNK5YWi/AzOr/zosbXjafKPSL2OxtpFAk19nCj5dwGzUEpmpitCkAlWGX5
	4wqYriuGGxV5ULZkpOc/8F+L5eB9BRFOqXr8BrbG5eTmYzrpl5jJJ/A/CkafF/fz5eHMtAxtZtI
	6ZxO/tdrx2VH6ifgUnqFDrBVT6K4FyQp/6PtiWTWFPT/fTEAZCcMP5YGuM3hm7OO+fpzknvoMTg
	0WL0qUqo5/bovj8rENDAK4VeF5PlEEeYmV0N6blH4xjFADLZVEK9PVz8HaJ73GUcpZ82zJhZs4K
	TKSgH07U=
X-Received: by 2002:a05:600c:c490:b0:495:4572:21af with SMTP id 5b1f17b1804b1-49961992aecmr22177685e9.9.1786128050064;
        Fri, 07 Aug 2026 11:40:50 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:40:49 -0700 (PDT)
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
Subject: [PATCH v16 08/10] tls: device: add RX KeyUpdate support
Date: Fri,  7 Aug 2026 12:38:51 -0600
Message-Id: <20260807183853.2288959-9-rjethwani@purestorage.com>
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

On RX, the NIC may have already decrypted in-flight records with
the old key before the peer's KeyUpdate is parsed, so the old
AEAD, IV and rec_seq are retained on tls_offload_context_rx.
tls_device_rx_del_key() is called from tls_check_pending_rekey()
when a KeyUpdate record is decoded; otherwise post-KeyUpdate records
(carrying new-key wire encryption) would be decrypted with the retired key.
tls_device_decrypted() classifies records by old_nic_boundary:

  - after the boundary: new-key record; drop the old key.
  - before, fully encrypted: advance old_rec_seq, let SW AEAD decrypt.
  - before, (partially) decrypted: reencrypt with the old key so SW
    AEAD can decrypt with the new key.

rec_start_seq is the TCP sequence of the record's first byte, used both
for the trace_tls_device_decrypted() tracepoint and the old_nic_boundary
classification above. Because copied_seq is advanced at different points
in the two strparser modes, the record start is computed differently: in
copy_mode the record has already been dequeued (tcp_read_done() in
tls_strp_msg_cow() advanced copied_seq past it), so full_len is
subtracted; in non-copy mode copied_seq still points at the record start
and is used directly. This also corrects the tracepoint's first argument,
which previously subtracted full_len unconditionally and was off by one
record on the non-copy path.

For mixed records the NIC may have cleared skb->decrypted on auth failure;
the optional tls_dev_rx_rekey_fixup callback re-asserts it,
then the record is reencrypted with the old key so the SW AEAD can
decrypt it with the new key.

The new key's tls_dev_add is deferred until the old key is fully
consumed: tls_set_device_offload_rx() sets dev_add_pending while
old_aead_recv is retained, and tls_device_deferred_dev_add_rx()
installs the new key once copied_seq crosses old_nic_boundary.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 RX KeyUpdate cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../mellanox/mlx5/core/en_accel/ktls.c        |  10 +
 include/net/tls.h                             |  19 +-
 include/uapi/linux/snmp.h                     |   3 +
 net/tls/tls.h                                 |   9 +-
 net/tls/tls_device.c                          | 326 ++++++++++++++++--
 net/tls/tls_main.c                            |  46 +--
 net/tls/tls_proc.c                            |   3 +
 net/tls/tls_sw.c                              |   1 +
 8 files changed, 363 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index 337201f12895..71c9d3ca947d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -86,10 +86,20 @@ static int mlx5e_ktls_resync(struct net_device *netdev,
 	return 0;
 }
 
+static void mlx5e_ktls_rx_rekey_fixup(struct sk_buff *skb)
+{
+	struct sk_buff *frag_iter;
+
+	skb->decrypted = 1;
+	skb_walk_frags(skb, frag_iter)
+		frag_iter->decrypted = 1;
+}
+
 static const struct tlsdev_ops mlx5e_ktls_ops = {
 	.tls_dev_add = mlx5e_ktls_add,
 	.tls_dev_del = mlx5e_ktls_del,
 	.tls_dev_resync = mlx5e_ktls_resync,
+	.tls_dev_rx_rekey_fixup = mlx5e_ktls_rx_rekey_fixup,
 };
 
 bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
diff --git a/include/net/tls.h b/include/net/tls.h
index 7c2cf51dc887..de4e25b034d6 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -211,10 +211,11 @@ enum tls_context_flags {
 	 * to be atomic.
 	 */
 	TLS_TX_SYNC_SCHED = 1,
-	/* tls_dev_del was called for the RX side, device state was released,
-	 * but tls_ctx->netdev might still be kept, because TX-side driver
-	 * resources might not be released yet. Used to prevent the second
-	 * tls_dev_del call in tls_device_down if it happens simultaneously.
+	/* tls_dev_del was called for the RX side: the NIC currently holds no
+	 * RX offload context. Set whenever that context is released (socket
+	 * teardown, tls_device_down, or during a rekey before re-add) and
+	 * cleared when tls_dev_add re-establishes it. Readers use it to avoid
+	 * a double tls_dev_del and to suppress resync while the NIC has no key.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
 	/* Flag for TX HW context deleted during failed rekey.
@@ -321,6 +322,7 @@ struct tlsdev_ops {
 	int (*tls_dev_resync)(struct net_device *netdev,
 			      struct sock *sk, u32 seq, u8 *rcd_sn,
 			      enum tls_offload_ctx_dir direction);
+	void (*tls_dev_rx_rekey_fixup)(struct sk_buff *skb);
 };
 
 enum tls_offload_sync_type {
@@ -349,6 +351,15 @@ struct tls_offload_context_rx {
 	u8 resync_nh_reset:1;
 	/* CORE_NEXT_HINT-only member, but use the hole here */
 	u8 resync_nh_do_now:1;
+	/* tls_dev_add deferred until old key is freed */
+	u8 dev_add_pending:1;
+	struct {
+		struct crypto_aead *old_aead_recv; /* old key AEAD cipher */
+		char old_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE]; /* old key IV */
+		char old_rec_seq[TLS_MAX_REC_SEQ_SIZE]; /* old key TLS record seq */
+		u32 old_nic_boundary; /* TCP seq: NIC switched to next key */
+		void (*rekey_fixup)(struct sk_buff *skb);
+	} rekey;
 	union {
 		/* TLS_OFFLOAD_SYNC_TYPE_DRIVER_REQ */
 		struct {
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 119fbd49179c..284f879c92cc 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -370,8 +370,11 @@ enum
 	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
 	LINUX_MIB_TLSTXREKEYFALLBACK,		/* TlsTxRekeyFallback */
+	LINUX_MIB_TLSRXREKEYFALLBACK,		/* TlsRxRekeyFallback */
 	LINUX_MIB_TLSTXREKEYINPROGRESS,		/* TlsTxRekeyInProgress */
+	LINUX_MIB_TLSRXREKEYINPROGRESS,		/* TlsRxRekeyInProgress */
 	LINUX_MIB_TLSTXREKEYABORTED,		/* TlsTxRekeyAborted */
+	LINUX_MIB_TLSRXREKEYABORTED,		/* TlsRxRekeyAborted */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index ea8fdf198572..0e2d6baddb4a 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -243,8 +243,10 @@ void tls_device_cleanup(void);
 int tls_set_device_offload(struct sock *sk,
 			   struct tls_crypto_info *crypto_info);
 void tls_device_free_resources_tx(struct sock *sk);
-int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx);
+int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			      struct tls_crypto_info *crypto_info);
 void tls_device_offload_cleanup_rx(struct sock *sk);
+void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx);
 void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq);
 int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx);
 #else
@@ -260,13 +262,16 @@ tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
 static inline void tls_device_free_resources_tx(struct sock *sk) {}
 
 static inline int
-tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
+tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			  struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
 
 static inline void tls_device_offload_cleanup_rx(struct sock *sk) {}
 static inline void
+tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx) {}
+static inline void
 tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq) {}
 
 static inline int
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 85c74d0816b7..c34268cd9531 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -67,8 +67,18 @@ static void tls_device_free_ctx(struct tls_context *ctx)
 		kfree(offload_ctx);
 	}
 
-	if (ctx->rx_conf == TLS_HW)
-		kfree(tls_offload_ctx_rx(ctx));
+	if (ctx->rx_conf == TLS_HW) {
+		struct tls_offload_context_rx *offload_ctx =
+			tls_offload_ctx_rx(ctx);
+
+		/* Normally freed and NULLed in tls_device_offload_cleanup_rx();
+		 * free defensively here so a future path can't leak the tfm.
+		 */
+		crypto_free_aead(offload_ctx->rekey.old_aead_recv);
+		memzero_explicit(&offload_ctx->rekey,
+				 sizeof(offload_ctx->rekey));
+		kfree(offload_ctx);
+	}
 
 	tls_ctx_free(NULL, ctx);
 }
@@ -186,6 +196,82 @@ static void tls_device_commit_start_marker(struct sock *sk,
 	tcp_write_collapse_fence(sk);
 }
 
+static int tls_device_dev_add_rx(struct sock *sk, struct tls_context *tls_ctx,
+				 struct net_device *netdev,
+				 struct tls_crypto_info *crypto_info,
+				 u32 cur_seq, bool is_rekey)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	char *rec_seq;
+	int rc;
+
+	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk,
+					     TLS_OFFLOAD_CTX_DIR_RX,
+					     crypto_info, cur_seq);
+	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
+				     cur_seq, rec_seq, rc);
+	if (!rc) {
+		clear_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
+		clear_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
+		if (is_rekey)
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+	} else if (is_rekey) {
+		set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
+		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK);
+	}
+	return rc;
+}
+
+static void tls_device_deferred_dev_add_rx(struct sock *sk,
+					   struct tls_context *tls_ctx,
+					   struct tls_offload_context_rx *ctx)
+{
+	struct net_device *netdev;
+
+	ctx->dev_add_pending = 0;
+
+	down_read(&device_offload_lock);
+	netdev = rcu_dereference_protected(tls_ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (netdev)
+		tls_device_dev_add_rx(sk, tls_ctx, netdev,
+				      &tls_ctx->crypto_recv.info,
+				      tcp_sk(sk)->copied_seq, true);
+	else
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK);
+	up_read(&device_offload_lock);
+	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
+}
+
+void tls_device_rx_del_key(struct sock *sk, struct tls_context *ctx)
+{
+	struct net_device *netdev;
+
+	if (ctx->rx_conf != TLS_HW)
+		return;
+	if (test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		return;
+
+	down_read(&device_offload_lock);
+	netdev = rcu_dereference_protected(ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (!netdev) {
+		up_read(&device_offload_lock);
+		return;
+	}
+
+	set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+	synchronize_net();
+	netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+					TLS_OFFLOAD_CTX_DIR_RX);
+	up_read(&device_offload_lock);
+}
+
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -904,6 +990,8 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		return;
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags)))
 		return;
+	if (unlikely(test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags)))
+		return;
 
 	prot = &tls_ctx->prot_info;
 	rx_ctx = tls_offload_ctx_rx(tls_ctx);
@@ -1093,13 +1181,56 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	return err;
 }
 
+/*
+ * Temporarily swap in the old key, run
+ * tls_device_reencrypt(), then restore the current key.
+ */
+static int tls_device_reencrypt_old_key(struct sock *sk,
+					struct tls_offload_context_rx *ctx,
+					struct tls_sw_context_rx *sw_ctx,
+					struct tls_context *tls_ctx)
+{
+	struct crypto_aead *saved_aead = sw_ctx->aead_recv;
+	char saved_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
+	char saved_rec_seq[TLS_MAX_REC_SEQ_SIZE];
+	int ret;
+
+	memcpy(saved_iv, tls_ctx->rx.iv, sizeof(saved_iv));
+	memcpy(saved_rec_seq, tls_ctx->rx.rec_seq, sizeof(saved_rec_seq));
+
+	sw_ctx->aead_recv = ctx->rekey.old_aead_recv;
+	memcpy(tls_ctx->rx.iv, ctx->rekey.old_iv, sizeof(ctx->rekey.old_iv));
+	memcpy(tls_ctx->rx.rec_seq, ctx->rekey.old_rec_seq,
+	       sizeof(ctx->rekey.old_rec_seq));
+
+	ret = tls_device_reencrypt(sk, tls_ctx);
+
+	memcpy(ctx->rekey.old_rec_seq, tls_ctx->rx.rec_seq,
+	       sizeof(ctx->rekey.old_rec_seq));
+
+	sw_ctx->aead_recv = saved_aead;
+	memcpy(tls_ctx->rx.iv, saved_iv, sizeof(saved_iv));
+	memcpy(tls_ctx->rx.rec_seq, saved_rec_seq, sizeof(saved_rec_seq));
+
+	if (ret)
+		return ret;
+
+	tls_bigint_increment(ctx->rekey.old_rec_seq,
+			     tls_ctx->prot_info.rec_seq_size);
+	ctx->resync_nh_reset = 1;
+
+	return 0;
+}
+
 int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_offload_context_rx *ctx = tls_offload_ctx_rx(tls_ctx);
 	struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(tls_ctx);
 	struct sk_buff *skb = tls_strp_msg(sw_ctx);
+	u32 copied_seq = tcp_sk(sk)->copied_seq;
 	struct strp_msg *rxm = strp_msg(skb);
 	int is_decrypted, is_encrypted;
+	u32 rec_start_seq;
 
 	if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
 		is_decrypted = skb->decrypted;
@@ -1109,10 +1240,50 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 		is_encrypted = 0;
 	}
 
-	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
+	rec_start_seq = sw_ctx->strp.copy_mode
+		? copied_seq - rxm->full_len
+		: copied_seq;
+
+	trace_tls_device_decrypted(sk, rec_start_seq,
 				   tls_ctx->rx.rec_seq, rxm->full_len,
 				   is_encrypted, is_decrypted);
 
+	if (unlikely(ctx->rekey.old_aead_recv)) {
+		bool before_nic_boundary =
+			before(rec_start_seq, ctx->rekey.old_nic_boundary);
+
+		if (before_nic_boundary) {
+			/* A non-mixed record with skb->decrypted clear is
+			 * untouched wire ciphertext: the NIC never XORed the
+			 * payload, so SW can decrypt it directly after advancing
+			 * old_rec_seq. Auth-failure clearing (see rekey_fixup
+			 * below) only ever produces mixed records, which are
+			 * classified as neither encrypted nor decrypted and fall
+			 * through to the reencrypt path.
+			 */
+			if (is_encrypted) {
+				tls_bigint_increment(ctx->rekey.old_rec_seq,
+						     tls_ctx->prot_info.rec_seq_size);
+				return 0;
+			}
+
+			/* rekey_fixup sets decrypted flags in case the NIC clears
+			 * decrypted flags on auth failure
+			 */
+			if (!is_decrypted && ctx->rekey.rekey_fixup)
+				ctx->rekey.rekey_fixup(skb);
+
+			return tls_device_reencrypt_old_key(sk, ctx,
+							    sw_ctx, tls_ctx);
+		}
+
+		crypto_free_aead(ctx->rekey.old_aead_recv);
+		ctx->rekey.old_aead_recv = NULL;
+
+		if (ctx->dev_add_pending)
+			tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx);
+	}
+
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags))) {
 		if (likely(is_encrypted || is_decrypted))
 			return is_decrypted;
@@ -1643,13 +1814,31 @@ int tls_set_device_offload(struct sock *sk,
 	return rc;
 }
 
-int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
+int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			      struct tls_crypto_info *new_crypto_info)
 {
-	struct tls12_crypto_info_aes_gcm_128 *info;
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
+	const struct tls_cipher_desc *cipher_desc;
+	u32 copied_seq = tcp_sk(sk)->copied_seq;
 	struct tls_offload_context_rx *context;
 	struct net_device *netdev;
+	bool was_dev_add_pending;
+	bool moved_aead_recv = false;
 	int rc = 0;
 
+	/* Rekey is only supported for connections that are already
+	 * using HW offload. For SW offload connections, the caller
+	 * should fall back to tls_set_sw_offload() for rekey.
+	 */
+	if (new_crypto_info && ctx->rx_conf != TLS_HW)
+		return -EINVAL;
+
+	crypto_info = &ctx->crypto_recv.info;
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable)
+		return -EINVAL;
+
 	netdev = get_netdev_for_sock(sk);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
@@ -1675,29 +1864,88 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 		goto release_lock;
 	}
 
-	context = kzalloc_obj(*context);
-	if (!context) {
-		rc = -ENOMEM;
-		goto release_lock;
+	if (!new_crypto_info) {
+		context = kzalloc_obj(*context);
+		if (!context) {
+			rc = -ENOMEM;
+			goto release_lock;
+		}
+		ctx->priv_ctx_rx = context;
+	} else {
+		context = tls_offload_ctx_rx(ctx);
 	}
+	was_dev_add_pending = context->dev_add_pending;
 	context->resync_nh_reset = 1;
 
-	ctx->priv_ctx_rx = context;
-	rc = tls_sw_ctx_init(sk, 0, NULL);
+	if (new_crypto_info) {
+		struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(ctx);
+
+		if (!test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+			synchronize_net();
+			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+							TLS_OFFLOAD_CTX_DIR_RX);
+		}
+
+		if (context->rekey.old_aead_recv &&
+		    before(copied_seq, context->rekey.old_nic_boundary)) {
+			/* Previous rekey still draining. Keep rekey.old_aead_recv,
+			 * it is the only key that can undo the NIC-XOR on queued
+			 * records. sw_ctx->aead_recv may be re-setkey'd by
+			 * tls_sw_ctx_init(); that intermediate key was never on
+			 * the NIC and its wire era is drained, so it is needed
+			 * for neither undo nor AEAD. Defer dev_add; the new key
+			 * is installed once copied_seq crosses rekey.old_nic_boundary.
+			 */
+			context->dev_add_pending = 1;
+		} else {
+			u32 rcv_nxt;
+
+			if (context->rekey.old_aead_recv) {
+				crypto_free_aead(context->rekey.old_aead_recv);
+				context->rekey.old_aead_recv = NULL;
+			}
+
+			/* flush the backlog so rcv_nxt is accurate */
+			__sk_flush_backlog(sk);
+			rcv_nxt = tcp_sk(sk)->rcv_nxt;
+
+			if (before(copied_seq, rcv_nxt)) {
+				context->rekey.old_aead_recv = sw_ctx->aead_recv;
+				sw_ctx->aead_recv = NULL;
+				moved_aead_recv = true;
+				memcpy(context->rekey.old_iv, ctx->rx.iv,
+				       sizeof(context->rekey.old_iv));
+				memcpy(context->rekey.old_rec_seq, ctx->rx.rec_seq,
+				       sizeof(context->rekey.old_rec_seq));
+				context->rekey.old_nic_boundary = rcv_nxt;
+				context->rekey.rekey_fixup =
+					netdev->tlsdev_ops->tls_dev_rx_rekey_fixup;
+				context->dev_add_pending = 1;
+			}
+		}
+	}
+
+	rc = tls_sw_ctx_init(sk, 0, new_crypto_info);
 	if (rc)
 		goto release_ctx;
 
-	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_RX,
-					     &ctx->crypto_recv.info,
-					     tcp_sk(sk)->copied_seq);
-	info = (void *)&ctx->crypto_recv.info;
-	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_RX,
-				     tcp_sk(sk)->copied_seq, info->rec_seq, rc);
-	if (rc)
-		goto free_sw_resources;
+	if (!context->dev_add_pending) {
+		rc = tls_device_dev_add_rx(sk, ctx, netdev, src_crypto_info,
+					   copied_seq, !!new_crypto_info);
+		if (!new_crypto_info) {
+			if (rc)
+				goto free_sw_resources;
+			tls_device_attach(ctx, sk, netdev);
+		}
+	} else if (!was_dev_add_pending) {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
+	} else {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+	}
+
+	tls_sw_ctx_finalize(sk, 0, new_crypto_info);
 
-	tls_device_attach(ctx, sk, netdev);
-	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
 	dev_put(netdev);
@@ -1709,7 +1957,18 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_sw_free_resources_rx(sk);
 	down_read(&device_offload_lock);
 release_ctx:
-	ctx->priv_ctx_rx = NULL;
+	if (!new_crypto_info) {
+		ctx->priv_ctx_rx = NULL;
+	} else {
+		context->dev_add_pending = was_dev_add_pending;
+		if (moved_aead_recv) {
+			struct tls_sw_context_rx *sw_ctx = tls_sw_ctx_rx(ctx);
+
+			crypto_free_aead(sw_ctx->aead_recv);
+			sw_ctx->aead_recv = context->rekey.old_aead_recv;
+			context->rekey.old_aead_recv = NULL;
+		}
+	}
 release_lock:
 	up_read(&device_offload_lock);
 release_netdev:
@@ -1720,6 +1979,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 void tls_device_offload_cleanup_rx(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_offload_context_rx *rx_ctx;
 	struct net_device *netdev;
 
 	down_read(&device_offload_lock);
@@ -1728,8 +1988,9 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	if (!netdev)
 		goto out;
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
-					TLS_OFFLOAD_CTX_DIR_RX);
+	if (!test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
@@ -1739,6 +2000,19 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	}
 out:
 	up_read(&device_offload_lock);
+
+	rx_ctx = tls_offload_ctx_rx(tls_ctx);
+	if (rx_ctx && rx_ctx->rekey.old_aead_recv) {
+		crypto_free_aead(rx_ctx->rekey.old_aead_recv);
+		rx_ctx->rekey.old_aead_recv = NULL;
+	}
+
+	if (rx_ctx && rx_ctx->dev_add_pending) {
+		rx_ctx->dev_add_pending = 0;
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYABORTED);
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRESS);
+	}
+
 	tls_sw_release_resources_rx(sk);
 }
 
@@ -1796,9 +2070,11 @@ static int tls_device_down(struct net_device *netdev)
 			set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
 		}
 		if (ctx->rx_conf == TLS_HW &&
-		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
+		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_RX);
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+		}
 
 		dev_put(netdev);
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 536f26d68d9d..466117a1530f 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -753,37 +753,37 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			conf = TLS_SW;
 		}
 	} else {
-		if (update && ctx->rx_conf == TLS_HW) {
-			rc = -EOPNOTSUPP;
-			goto err_crypto_info;
-		}
-
-		if (!update) {
-			rc = tls_set_device_offload_rx(sk, ctx);
-			conf = TLS_HW;
-			if (!rc) {
+		rc = tls_set_device_offload_rx(sk, ctx,
+					       update ? crypto_info : NULL);
+		conf = TLS_HW;
+		if (!rc) {
+			if (!update) {
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
 				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
-				tls_sw_strparser_arm(sk, ctx);
-				goto out;
 			}
-		}
-
-		rc = tls_set_sw_offload(sk, 0, update ? crypto_info : NULL);
-		if (rc)
+		} else if (update && ctx->rx_conf == TLS_HW) {
+			/* HW rekey failed - return the actual error.
+			 * Cannot fall back to SW for an existing HW connection.
+			 */
 			goto err_crypto_info;
-
-		if (update) {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
 		} else {
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
-			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
-			tls_sw_strparser_arm(sk, ctx);
+			rc = tls_set_sw_offload(sk, 0,
+						update ? crypto_info : NULL);
+			if (rc)
+				goto err_crypto_info;
+
+			if (update) {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+			} else {
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
+				TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+			}
+			conf = TLS_SW;
 		}
-		conf = TLS_SW;
+		if (!update)
+			tls_sw_strparser_arm(sk, ctx);
 	}
 
-out:
 	if (tx)
 		ctx->tx_conf = conf;
 	else
diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index adca8561c7da..ae2322481c71 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -28,8 +28,11 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
 	SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK),
+	SNMP_MIB_ITEM("TlsRxRekeyFallback", LINUX_MIB_TLSRXREKEYFALLBACK),
 	SNMP_MIB_ITEM("TlsTxRekeyInProgress", LINUX_MIB_TLSTXREKEYINPROGRESS),
+	SNMP_MIB_ITEM("TlsRxRekeyInProgress", LINUX_MIB_TLSRXREKEYINPROGRESS),
 	SNMP_MIB_ITEM("TlsTxRekeyAborted", LINUX_MIB_TLSTXREKEYABORTED),
+	SNMP_MIB_ITEM("TlsRxRekeyAborted", LINUX_MIB_TLSRXREKEYABORTED),
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 89f60cedb142..21a10a366b57 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1556,6 +1556,7 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
 		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
 
+		tls_device_rx_del_key(sk, ctx);
 		WRITE_ONCE(rx_ctx->key_update_pending, true);
 		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
 	}
-- 
2.25.1

