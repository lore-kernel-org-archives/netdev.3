Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2C44AAC5F
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685138; cv=none; b=mRbIAl+CCbaoCbIQ1mL3Qm4wM5Dla0CJHR/FZIUKtn5eefq435xh8HFDJ22uK8j31QNmB193QkPQhuvOLaqrA9KQYcwDTou6tkOrILu5pfCfkNr8jse18FSxUhuO2wt7roNCpN3n0DEejopohM87eogulb0C08Bq6FzbLCCORPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685138; c=relaxed/simple;
	bh=15JK954BrNW9wgga3hvqIAjyNU2WGSZdrcDFkyc1hQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkMqFm/24fJ6gxDiDJBqwd8Z8/v7ecvieL7GKF0r8hcv35cmuuoJnW838KgFGQxS0PGzdofucGVRZp3cuOhLuJycjRsH6FTWwmcJaMwPQ1BYNj51X9lxgb769arwN3Mpo1PRKhpYmcL/xQtjIfQ5ruC7f65GxyZ1G46muYxBPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S1zhZ7td; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S1zhZ7td"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2ad9so161510fac.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685130; x=1790289930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkNkdPOxGgB4nqml337oX0d6NcYPT8ZTKeetjc4wQ+U=;
        b=S1zhZ7td55dCQPrT08F1mmmvTHoq/N+z9si86TpQcm9/v39wOF3J4wdmGgDGNqhswc
         OzveoRqECnQYgL6WW41bffUHUfv8mqCtTsUk5rjV05yQF6n++0Gwx6UAtBfzD7pZKgcj
         ootTrP4cEAYKlDO/o+GWfS7jBonjKV9W9WNf/SjvsXYjvivJUh4Iv+55a1MZyq4zlxZN
         CQiQacuWyAFLW4IDCIHs01dIsXn+x9bCpGz/mjOJ2e12+iBSEy/rp2aKeCXnr/kZjzsV
         ntCKv1cUlaYj4m0GL5dBUVcz/qxW5jdDr1yxOaAbPsPHbYgHkh+Mm5ByMWFqGTMc8zYD
         LtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685130; x=1790289930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkNkdPOxGgB4nqml337oX0d6NcYPT8ZTKeetjc4wQ+U=;
        b=x17XeST3Ki5YIrn2TdJwIyIVXJQpEL/5VpTNFKhtBLuSVPcm/Nw6vq6AZLvjXvGAI1
         FiY6DWPIFcCj7a3J4iY89ZY2Xspgj3gNUP5wx/jeUZRSGe8dfdBl7WAZ+51EpXasAnkI
         NQNdspJ93BCxWjhATATAv4Oy7al0QirQQoyG/FiWmiGUeToSC1I/HLGlfq4IHFnO0Sfi
         5bjQ5BrD74vXUxJRXpHNYuzl7ksePrrsBfUuSI7t10FvpeLN2iPhtRPUPYYVxJONcLUU
         Sqxmmq6wWRgJsgfH7V4XqnzHmaVPe6YmxnL+qVcE3501W+RNmET4nQE2Lo7wUkNrGIgh
         g8Tw==
X-Gm-Message-State: AFuF++nndl2Wn65gGRBtlYgYLVuE21Lf/w1EVlqlNZrFGJyHztGHh743
	gA9CGGB04XcIH6NjFhna/sa0PfHhRSw7pilsIQ5nd7vF9otErxL2SKiXI+r3dm/gTyIMKSvUfBQ
	gvqkQ+pswbznQTCLfH/1HGeKI/uj0p+IivJDcpVF/VvsyTbdRGcaa0Jfal/IjGGZykhpnkMZKmY
	hVx9GtIj5mhUHGrfJCYmL3ZSmifz8WW4weZc4cA9NZ8TGkEs4=
X-Gm-Gg: AYBFou2VkVwRythvqADYZjmRLvQUXjbVz7lVTlx6Gm2DE3FtaUlo8pLUbbI8NXPBwTl
	BuyDXHqz0UNH63oMbgK3iGiYetof6O1TDIy5sa5bKLldAdxc2LCi5Qb28IARr04ekh0oSHAwxWB
	+l00wR8K55U9sjo7pVngoJX38h/rD59bnsUYRxGwGAEEmIexk3mYcJynakfPVhdks95HXwceIJJ
	UDe8WVcZrcsmntQ+txrGEEhfAGdwre5jaiy7Vs4y98m17ZD46igfTXsemfjTBko9ngWAqZIb55a
	zGk+/+uGJWGNqyKOBnB8DfZVDAfw0vJ6S689Q4X5EgUjwO9pHBA2NSS50QzevpVBzA9t0RBfnsx
	Mjp5YOkBGtnz5DHhyxbTbYDStBAaqGjdpYrDXvWaz6kIRaMVD7hTN/rg5Ni4042pmQ8jf4RDdlR
	kHE8kVZRXIjPMchSfiTb/tpKnj+Ae3Rq6Cn5/4zjivgG8CZCu2ULU4YEuiNqbvAQsDRH6Er3cAm
	X0Gn8q9fb6JicTmom+r9Am9XxswMdpZl2BcsC7mQNYuz2r50xR2PHZv6A6k8i25jth/jO5ORIjB
	APAJVZO5MkefNCR6YSQoX6CAtgQ9l2qUMa962oBIHMn7rh998HJwnF5/fCyJSHtfkKJg39/OoYo
	/Y9+PUgbkSaohhYKvlA==
X-Received: by 2002:a05:6870:c221:b0:457:b657:b084 with SMTP id 586e51a60fabf-486e6de37c4mr675313fac.18.1789685129899;
        Thu, 17 Sep 2026 15:45:29 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:29 -0700 (PDT)
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
Subject: [PATCH net-next v17 11/15] tls: device: add TX KeyUpdate support
Date: Thu, 17 Sep 2026 16:35:22 -0600
Message-ID: <20260917224355.2288021-12-rjethwani@purestorage.com>
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

The NIC key cannot be replaced while HW-offloaded records
are still unacked. tls_device_start_rekey() installs a temporary SW
context with the new key and redirects sendmsg through
tls_sw_sendmsg_locked. If no records are pending,
tls_device_complete_rekey() runs inline during setsockopt; otherwise
tls_tcp_clean_acked sets REKEY_READY once all old-key records are ACKed
and the next sendmsg completes the rekey, flushing SW records and
reinstalling HW offload at the current write_seq. A KeyUpdate
arriving while one is pending re-keys the SW AEAD in place; if the
HW reinstall fails the socket stays in SW mode (REKEY_FAILED).

One side effect touches the non-rekey paths: tx_lock is now taken for
every TLS_TX setsockopt (initial install and SW-only sockets included),
because whether a call is a rekey is only known under lock_sock; this
adds the tx_lock -> lock_sock ordering already used by the data path and
is uncontended during initial setup.

While a rekey is in flight the data path encrypts with the pending key's
SW context, so getsockopt(SOL_TLS, TLS_TX) selects the cipher context
via tls_tx_cipher_ctx(), the same accessor the data path uses, and
reports what sendmsg is actually encrypting with: the pending rekey's
key while one is in flight, otherwise the active key. lock_sock is held,
so rekey.cipher_ctx cannot change under the reader.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 TX KeyUpdate cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h             |  83 ++++-
 include/uapi/linux/snmp.h     |   3 +
 net/tls/tls.h                 |   8 +-
 net/tls/tls_device.c          | 631 ++++++++++++++++++++++++++++++++--
 net/tls/tls_device_fallback.c | 128 ++++++-
 net/tls/tls_main.c            |  54 ++-
 net/tls/tls_proc.c            |   3 +
 net/tls/tls_sw.c              |  33 +-
 8 files changed, 895 insertions(+), 48 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index eb258bcd62bc..b5fc281ff365 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -185,6 +185,14 @@ struct tls_offload_context_tx {
 	void (*sk_destruct)(struct sock *sk);
 	struct work_struct destruct_work;
 	struct tls_context *ctx;
+
+	struct {
+		struct tls_sw_context_tx sw;	/* SW context for new key */
+		struct cipher_context tx;	/* IV, rec_seq for new key */
+		union tls_crypto_context crypto_send; /* Crypto for new key */
+		struct tls_record_info *start_marker;
+	} rekey;
+
 	/* The TLS layer reserves room for driver specific state
 	 * Currently the belief is that there is not enough
 	 * driver specific state to justify another layer of indirection
@@ -209,6 +217,28 @@ enum tls_context_flags {
 	 * tls_dev_del call in tls_device_down if it happens simultaneously.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
+	/* TX HW context has been tls_dev_del()'d (mid-rekey before the re-add,
+	 * after a failed re-add, or by tls_device_down()); prevents a second
+	 * tls_dev_del. Cleared when tls_dev_add re-establishes the context.
+	 */
+	TLS_TX_DEV_CLOSED = 3,
+	/* TX rekey is pending, waiting for old-key data to be ACKed.
+	 * While set, new data uses SW path with new key, HW keeps old key
+	 * for retransmissions.
+	 */
+	TLS_TX_REKEY_PENDING = 4,
+	/* All old-key data has been ACKed, ready to install new key in HW. */
+	TLS_TX_REKEY_READY = 5,
+	/* HW rekey failed; TX stays on the SW rekey context until the next
+	 * KeyUpdate re-arms the transition (tls_device_start_rekey()). Also
+	 * stops tls_tcp_clean_acked() from re-setting TLS_TX_REKEY_READY.
+	 */
+	TLS_TX_REKEY_FAILED = 6,
+	/* A rekey has completed on this socket at least once; that arms
+	 * tls_tx_drop_acked_clone() (see its header for the rationale). WARN
+	 * avoidance only.
+	 */
+	TLS_TX_REKEY_FLOOR = 7,
 };
 
 struct tls_prot_info {
@@ -257,6 +287,20 @@ struct tls_context {
 			       */
 	unsigned long flags;
 
+	struct {
+		/* TCP sequence number boundary for pending rekey.
+		 * Packets with seq < this use old key, >= use new key.
+		 */
+		u32 boundary_seq;
+
+		/* SW encryption contexts for the new key, non-NULL only while
+		 * TLS_TX_REKEY_{PENDING,FAILED}; consulted by tls_sw_ctx_tx() and
+		 * tls_tx_cipher_ctx().
+		 */
+		struct tls_sw_context_tx *sw_ctx;
+		struct cipher_context *cipher_ctx;
+	} rekey;
+
 	/* cache cold stuff */
 	struct proto *sk_proto;
 	struct sock *sk;
@@ -356,15 +400,38 @@ tls_validate_xmit_skb(struct sock *sk, struct net_device *dev,
 struct sk_buff *
 tls_validate_xmit_skb_sw(struct sock *sk, struct net_device *dev,
 			 struct sk_buff *skb);
+struct sk_buff *
+tls_validate_xmit_skb_rekey(struct sock *sk, struct net_device *dev,
+			    struct sk_buff *skb);
 
 static inline bool tls_is_skb_tx_device_offloaded(const struct sk_buff *skb)
 {
 #ifdef CONFIG_TLS_DEVICE
 	struct sock *sk = skb->sk;
+	typeof(sk->sk_validate_xmit_skb) validate;
 
-	return sk && sk_fullsock(sk) &&
-	       (smp_load_acquire(&sk->sk_validate_xmit_skb) ==
-	       &tls_validate_xmit_skb);
+	if (!sk || !sk_fullsock(sk))
+		return false;
+
+	/* Pairs with the smp_store_release() that installs or swaps the
+	 * validator (tls_set_device_offload() / tls_device_start_rekey()): the
+	 * pointer read here is published together with the offload state it
+	 * guards, so a non-NULL validator implies that state is visible.
+	 */
+	validate = smp_load_acquire(&sk->sk_validate_xmit_skb);
+	if (likely(validate == &tls_validate_xmit_skb))
+		return true;
+
+	/* A TX rekey (tls_device_start_rekey()) can swap in the rekey validator
+	 * between this skb's validate_xmit_skb(), where the old validator
+	 * passed it through as HW-offload plaintext, and here. A skb->decrypted
+	 * skb under the rekey validator is therefore that straddler: old-key
+	 * plaintext whose HW context is still installed (tls_dev_del() runs in
+	 * tls_device_complete_rekey() only after a synchronize_net() that drains
+	 * this in-flight xmit), so the NIC must still encrypt it. Everything else
+	 * the rekey validator emits is ciphertext (skb->decrypted == 0).
+	 */
+	return validate == &tls_validate_xmit_skb_rekey && skb_is_decrypted(skb);
 #else
 	return false;
 #endif
@@ -389,12 +456,22 @@ static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
 static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
 		const struct tls_context *tls_ctx)
 {
+	struct tls_sw_context_tx *rekey_ctx = READ_ONCE(tls_ctx->rekey.sw_ctx);
+
+	if (unlikely(rekey_ctx))
+		return rekey_ctx;
+
 	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
 }
 
 static inline struct cipher_context *tls_tx_cipher_ctx(
 		const struct tls_context *tls_ctx)
 {
+	struct cipher_context *rekey_ctx = READ_ONCE(tls_ctx->rekey.cipher_ctx);
+
+	if (unlikely(rekey_ctx))
+		return rekey_ctx;
+
 	return (struct cipher_context *)&tls_ctx->tx;
 }
 
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 49f5640092a0..a2e0264641de 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -369,6 +369,9 @@ enum
 	LINUX_MIB_TLSTXREKEYOK,			/* TlsTxRekeyOk */
 	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
+	LINUX_MIB_TLSTXREKEYFALLBACK,		/* TlsTxRekeyFallback */
+	LINUX_MIB_TLSCURRTXREKEY,		/* TlsCurrTxRekey */
+	LINUX_MIB_TLSTXREKEYABORTED,		/* TlsTxRekeyAborted */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 920a926e8e68..e749f429301a 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -165,7 +165,10 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
 void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx);
+int tls_sw_drain_tx(struct sock *sk, struct tls_context *ctx, int flags);
+int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx);
 int tls_sw_push_pending_record(struct sock *sk, int flags);
 void tls_sw_splice_eof(struct socket *sock);
 void tls_sw_splice_eof_locked(struct socket *sock);
@@ -245,7 +248,8 @@ static inline bool tls_strp_msg_mixed_decrypted(struct tls_sw_context_rx *ctx)
 #ifdef CONFIG_TLS_DEVICE
 int tls_device_init(void);
 void tls_device_cleanup(void);
-int tls_set_device_offload(struct sock *sk);
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *crypto_info);
 void tls_device_free_resources_tx(struct sock *sk);
 int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx);
 void tls_device_offload_cleanup_rx(struct sock *sk);
@@ -256,7 +260,7 @@ static inline int tls_device_init(void) { return 0; }
 static inline void tls_device_cleanup(void) {}
 
 static inline int
-tls_set_device_offload(struct sock *sk)
+tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 972c9c7ba7de..f32c1bb6b497 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -57,8 +57,15 @@ static struct page *dummy_page;
 
 static void tls_device_free_ctx(struct tls_context *ctx)
 {
-	if (ctx->tx_conf == TLS_HW)
-		kfree(tls_offload_ctx_tx(ctx));
+	if (ctx->tx_conf == TLS_HW) {
+		struct tls_offload_context_tx *offload_ctx =
+			tls_offload_ctx_tx(ctx);
+
+		kfree(offload_ctx->rekey.start_marker);
+		memzero_explicit(&offload_ctx->rekey,
+				 sizeof(offload_ctx->rekey));
+		kfree(offload_ctx);
+	}
 
 	if (ctx->rx_conf == TLS_HW)
 		kfree(tls_offload_ctx_rx(ctx));
@@ -79,7 +86,9 @@ static void tls_device_tx_del_task(struct work_struct *work)
 	netdev = rcu_dereference_protected(ctx->netdev,
 					   !refcount_read(&ctx->refcount));
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						TLS_OFFLOAD_CTX_DIR_TX);
 	dev_put(netdev);
 	ctx->netdev = NULL;
 	tls_device_free_ctx(ctx);
@@ -157,7 +166,10 @@ static int tls_device_dev_add_tx(struct sock *sk, struct net_device *netdev,
 	return rc;
 }
 
-static void tls_device_commit_start_marker(struct sock *sk,
+/* Caller controls locking: initial-offload path is lock-free (pre-publish);
+ * rekey path holds offload_ctx->lock.
+ */
+static void tls_device_add_start_marker(struct sock *sk,
 					struct tls_offload_context_tx *offload_ctx,
 					struct tls_record_info *start_marker_record)
 {
@@ -165,6 +177,13 @@ static void tls_device_commit_start_marker(struct sock *sk,
 	start_marker_record->len = 0;
 	start_marker_record->num_frags = 0;
 	list_add_tail_rcu(&start_marker_record->list, &offload_ctx->records_list);
+}
+
+static void tls_device_commit_start_marker(struct sock *sk,
+					struct tls_offload_context_tx *offload_ctx,
+					struct tls_record_info *start_marker_record)
+{
+	tls_device_add_start_marker(sk, offload_ctx, start_marker_record);
 
 	/* TLS offload is greatly simplified if we don't send
 	 * SKBs where only part of the payload needs to be encrypted.
@@ -194,6 +213,57 @@ static void delete_all_records(struct tls_offload_context_tx *offload_ctx)
 	offload_ctx->retransmit_hint = NULL;
 }
 
+static void tls_device_commit_rekey_marker(struct sock *sk,
+					   struct tls_offload_context_tx *offload_ctx,
+					   struct tls_record_info *start_marker_record)
+{
+	struct tls_record_info *info, *temp;
+	unsigned long flags;
+	__be64 rcd_sn;
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+
+	/* The deferred path reaches here with an empty list; the inline
+	 * path may still hold the old start marker (never a real record,
+	 * since tls_has_unacked_records() was false). Only markers are
+	 * ever at the head, so stop at the first non-marker.
+	 */
+	list_for_each_entry_safe(info, temp, &offload_ctx->records_list, list) {
+		if (!tls_record_is_start_marker(info))
+			break;
+		list_del(&info->list);
+		destroy_record(info);
+	}
+	offload_ctx->retransmit_hint = NULL;
+
+	memcpy(&rcd_sn, offload_ctx->rekey.tx.rec_seq, sizeof(rcd_sn));
+	offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn) - 1;
+
+	tls_device_add_start_marker(sk, offload_ctx, start_marker_record);
+
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	tcp_write_collapse_fence(sk);
+}
+
+static bool tls_has_unacked_records(struct tls_offload_context_tx *offload_ctx)
+{
+	struct tls_record_info *info;
+	bool has_unacked = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	list_for_each_entry(info, &offload_ctx->records_list, list) {
+		if (!tls_record_is_start_marker(info)) {
+			has_unacked = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	return has_unacked;
+}
+
 static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -222,6 +292,19 @@ static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 	}
 
 	ctx->unacked_record_sn += deleted_records;
+
+	/* Once all old-key HW records are ACKed, set REKEY_READY to
+	 * let sendmsg know it can finish the rekey and switch back
+	 * to HW offload.
+	 */
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
+	    !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
+		u32 boundary_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
+
+		if (!before(acked_seq, boundary_seq))
+			set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
+	}
+
 	spin_unlock_irqrestore(&ctx->lock, flags);
 }
 
@@ -252,7 +335,15 @@ void tls_device_free_resources_tx(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 
-	tls_free_partial_record(sk, tls_ctx);
+	if (unlikely(tls_ctx->rekey.sw_ctx))
+		tls_sw_release_resources_tx(sk);
+	else
+		tls_free_partial_record(sk, tls_ctx);
+
+	if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags)) {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYABORTED);
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXREKEY);
+	}
 }
 
 void tls_offload_tx_resync_request(struct sock *sk, u32 got_seq, u32 exp_seq)
@@ -462,6 +553,9 @@ static int tls_device_copy_data(void *addr, size_t bytes, struct iov_iter *i)
 	return 0;
 }
 
+static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
+				     bool deferred, int push_flags);
+
 static int tls_push_data(struct sock *sk,
 			 struct iov_iter *iter,
 			 size_t size, int flags,
@@ -607,18 +701,46 @@ static int tls_push_data(struct sock *sk,
 	return rc;
 }
 
+/* True while TX is routed through the temporary SW rekey context: a rekey is in
+ * progress (PENDING) or has failed and the socket stays pinned to SW (FAILED).
+ */
+static bool tls_device_tx_uses_sw(const struct tls_context *ctx)
+{
+	return test_bit(TLS_TX_REKEY_PENDING, &ctx->flags) ||
+	       test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+}
+
 int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	unsigned char record_type = TLS_RECORD_TYPE_DATA;
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	int rc;
 
+	/* Reject unsupported flags up front. tls_push_data() enforces the same
+	 * set, but during a rekey the send is routed to tls_sw_sendmsg_locked(),
+	 * which is the _locked variant and does not re-check; without this,
+	 * MSG_ZEROCOPY / MSG_OOB etc. would reach tcp_sendmsg_locked() on the
+	 * kernel-owned record pages while PENDING/FAILED.
+	 */
+	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
+			       MSG_SPLICE_PAGES | MSG_EOR))
+		return -EOPNOTSUPP;
+
 	if (!tls_ctx->zerocopy_sendfile)
 		msg->msg_flags &= ~MSG_SPLICE_PAGES;
 
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 
+	/* Old-key records all ACKed; switch back to HW. */
+	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
+		tls_device_complete_rekey(sk, tls_ctx, true, msg->msg_flags);
+
+	if (tls_device_tx_uses_sw(tls_ctx)) {
+		rc = tls_sw_sendmsg_locked(sk, msg, size);
+		goto out;
+	}
+
 	if (unlikely(msg->msg_controllen)) {
 		rc = tls_process_cmsg(sk, msg, &record_type);
 		if (rc)
@@ -647,8 +769,10 @@ void tls_device_splice_eof(struct socket *sock)
 	mutex_lock(&tls_ctx->tx_lock);
 	lock_sock(sk);
 
-	if (tls_is_partially_sent_record(tls_ctx) ||
-	    tls_is_pending_open_record(tls_ctx)) {
+	if (tls_device_tx_uses_sw(tls_ctx)) {
+		tls_sw_splice_eof_locked(sock);
+	} else if (tls_is_partially_sent_record(tls_ctx) ||
+		   tls_is_pending_open_record(tls_ctx)) {
 		iov_iter_bvec(&iter, ITER_SOURCE, NULL, 0, 0);
 		tls_push_data(sk, &iter, 0, 0, TLS_RECORD_TYPE_DATA);
 	}
@@ -719,14 +843,30 @@ EXPORT_SYMBOL(tls_get_record);
 
 static int tls_device_push_pending_record(struct sock *sk, int flags)
 {
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct iov_iter iter;
 
+	if (tls_device_tx_uses_sw(tls_ctx))
+		return tls_sw_push_pending_record(sk, flags);
+
 	iov_iter_kvec(&iter, ITER_SOURCE, NULL, 0, 0);
 	return tls_push_data(sk, &iter, 0, flags, TLS_RECORD_TYPE_DATA);
 }
 
 void tls_device_write_space(struct sock *sk, struct tls_context *ctx)
 {
+	if (tls_device_tx_uses_sw(ctx)) {
+		struct tls_offload_context_tx *offload_ctx;
+		unsigned long flags;
+
+		offload_ctx = tls_offload_ctx_tx(ctx);
+		spin_lock_irqsave(&offload_ctx->lock, flags);
+		if (tls_device_tx_uses_sw(ctx))
+			tls_sw_write_space(sk, ctx);
+		spin_unlock_irqrestore(&offload_ctx->lock, flags);
+		return;
+	}
+
 	if (tls_is_partially_sent_record(ctx)) {
 		gfp_t sk_allocation = sk->sk_allocation;
 
@@ -1106,6 +1246,425 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
 	return offload_ctx;
 }
 
+/* Build a fresh AEAD tfm for the rekey with the given key, so it can be
+ * swapped in only on success. Re-keying a live tfm in place is not atomic:
+ * a failed crypto_aead_setkey() leaves it with CRYPTO_TFM_NEED_KEY set,
+ * destroying the previous key. Returns an ERR_PTR() on failure.
+ */
+static struct crypto_aead *tls_device_build_rekey_aead(
+				const struct tls_cipher_desc *cipher_desc,
+				char *key, u32 alg_flags)
+{
+	struct crypto_aead *aead;
+	int rc;
+
+	aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, alg_flags);
+	if (IS_ERR(aead))
+		return aead;
+
+	rc = crypto_aead_setkey(aead, key, cipher_desc->key);
+	if (!rc)
+		rc = crypto_aead_setauthsize(aead, cipher_desc->tag);
+	if (rc) {
+		crypto_free_aead(aead);
+		return ERR_PTR(rc);
+	}
+
+	return aead;
+}
+
+static void tls_device_copy_rekey_iv_seq(
+				struct tls_offload_context_tx *offload_ctx,
+				const struct tls_cipher_desc *cipher_desc,
+				char *salt, char *iv, char *rec_seq)
+{
+	memcpy(offload_ctx->rekey.tx.iv, salt, cipher_desc->salt);
+	memcpy(offload_ctx->rekey.tx.iv + cipher_desc->salt, iv,
+	       cipher_desc->iv);
+	memcpy(offload_ctx->rekey.tx.rec_seq, rec_seq, cipher_desc->rec_seq);
+}
+
+static int tls_device_init_rekey_sw(struct sock *sk,
+				    struct tls_context *ctx,
+				    struct tls_offload_context_tx *offload_ctx,
+				    struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_sw_context_tx *sw_ctx = &offload_ctx->rekey.sw;
+	const struct tls_cipher_desc *cipher_desc;
+	char *key;
+	int rc;
+
+	cipher_desc = get_cipher_desc(new_crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	memset(sw_ctx, 0, sizeof(*sw_ctx));
+	tls_sw_ctx_tx_init(sk, sw_ctx);
+
+	key = crypto_info_key(new_crypto_info, cipher_desc);
+	sw_ctx->aead_send = tls_device_build_rekey_aead(cipher_desc, key, 0);
+	if (IS_ERR(sw_ctx->aead_send)) {
+		rc = PTR_ERR(sw_ctx->aead_send);
+		sw_ctx->aead_send = NULL;
+		return rc;
+	}
+
+	return 0;
+}
+
+static int tls_device_start_rekey(struct sock *sk,
+				  struct tls_context *ctx,
+				  struct tls_offload_context_tx *offload_ctx,
+				  struct tls_crypto_info *new_crypto_info)
+{
+	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	const struct tls_cipher_desc *cipher_desc;
+	struct crypto_aead *new_aead, *old_aead;
+	char *key, *iv, *rec_seq, *salt;
+	int push_flags = MSG_NOSIGNAL;
+	unsigned long flags;
+	int rc;
+
+	cipher_desc = get_cipher_desc(new_crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	key = crypto_info_key(new_crypto_info, cipher_desc);
+	iv = crypto_info_iv(new_crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(new_crypto_info, cipher_desc);
+	salt = crypto_info_salt(new_crypto_info, cipher_desc);
+
+	/* The record flushes below hand the open/partially sent HW record to
+	 * TCP and may have to wait for send buffer space. Honour the socket's
+	 * non-blocking mode so an O_NONBLOCK application is not put to sleep
+	 * inside setsockopt(): it gets -EAGAIN and retries once the socket is
+	 * writable. Kernel sockets (no backing file, e.g. nvme-tcp) keep the
+	 * blocking semantics, matching how they call sendmsg().
+	 */
+	if (sk->sk_socket && sk->sk_socket->file &&
+	    (sk->sk_socket->file->f_flags & O_NONBLOCK))
+		push_flags |= MSG_DONTWAIT;
+
+	if (rekey_pending || rekey_failed) {
+		/* Flush any SW open_record before swapping the key. -EINPROGRESS
+		 * means an async AEAD accepted the record for encryption; it is a
+		 * success, waited for by tls_encrypt_async_wait() just below (as
+		 * tls_process_cmsg()/tls_sw_drain_tx() also treat it).
+		 */
+		if (tls_is_pending_open_record(ctx)) {
+			rc = ctx->push_pending_record(sk, push_flags);
+			if (rc < 0 && rc != -EINPROGRESS)
+				return rc;
+		}
+
+		/* Wait for in-flight async encryptions submitted to this tfm
+		 * with the previous key before changing it.
+		 */
+		rc = tls_encrypt_async_wait(&offload_ctx->rekey.sw);
+		if (rc)
+			return rc;
+
+		/* Build the new key into a fresh tfm and swap it in only on
+		 * success; A failed rekey here must leave the SW fallback
+		 * path able to encrypt.
+		 */
+		new_aead = tls_device_build_rekey_aead(cipher_desc, key, 0);
+		if (IS_ERR(new_aead))
+			return PTR_ERR(new_aead);
+
+		old_aead = offload_ctx->rekey.sw.aead_send;
+		offload_ctx->rekey.sw.aead_send = new_aead;
+		crypto_free_aead(old_aead);
+
+		tls_device_copy_rekey_iv_seq(offload_ctx, cipher_desc,
+					     salt, iv, rec_seq);
+
+		if (rekey_failed) {
+			/* Re-arm FAILED -> PENDING under device_offload_lock. The
+			 * PENDING set and FAILED clear are two stores to ctx->flags,
+			 * and tls_device_down() tests !PENDING && !FAILED as two
+			 * separate loads; without the lock those loads could straddle
+			 * the flip and see neither bit, letting tls_device_down()
+			 * install tls_validate_xmit_skb_sw with PENDING set (dropping
+			 * all new-key ciphertext). The lock keeps PENDING || FAILED
+			 * observable throughout. Non-blocking, so no NETDEV_DOWN stall.
+			 */
+			down_read(&device_offload_lock);
+			spin_lock_irqsave(&offload_ctx->lock, flags);
+			WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->snd_una);
+			set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+			spin_unlock_irqrestore(&offload_ctx->lock, flags);
+			/* Release pairs with test_bit_acquire() in the validator:
+			 * a TX seeing FAILED clear must see the fresh boundary_seq.
+			 */
+			clear_bit_unlock(TLS_TX_REKEY_FAILED, &ctx->flags);
+			up_read(&device_offload_lock);
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+		}
+	} else {
+		/* Drain partially sent record and flush open HW record
+		 * before switching to SW.
+		 */
+		if (tls_is_partially_sent_record(ctx)) {
+			rc = tls_push_partial_record(sk, ctx,
+						     MSG_SENDPAGE_DECRYPTED |
+						     push_flags);
+			if (rc < 0)
+				return rc;
+		}
+		if (tls_is_pending_open_record(ctx)) {
+			rc = ctx->push_pending_record(sk, push_flags);
+			if (rc < 0)
+				return rc;
+		}
+
+		rc = tls_device_init_rekey_sw(sk, ctx, offload_ctx,
+					      new_crypto_info);
+		if (rc)
+			return rc;
+
+		tls_device_copy_rekey_iv_seq(offload_ctx, cipher_desc,
+					     salt, iv, rec_seq);
+
+		/* Publish the rekey under device_offload_lock so that setting
+		 * TLS_TX_REKEY_PENDING and installing the rekey validator is
+		 * atomic against tls_device_down(), which under down_write() tests
+		 * !PENDING and installs tls_validate_xmit_skb_sw. Otherwise the two
+		 * validator stores could interleave to leave PENDING set with the
+		 * SW validator, and every new-key ciphertext (never on the offload
+		 * records_list) would then be dropped by tls_sw_fallback(). The
+		 * blocking flush and crypto_alloc above deliberately run WITHOUT
+		 * this lock, so a stalled peer cannot hold up NETDEV_DOWN (which
+		 * takes down_write() under RTNL) or any other down_read() user.
+		 */
+		down_read(&device_offload_lock);
+
+		/* Prevent a partial record straddling the SW/HW boundary. */
+		tcp_write_collapse_fence(sk);
+
+		WRITE_ONCE(ctx->rekey.sw_ctx, &offload_ctx->rekey.sw);
+		WRITE_ONCE(ctx->rekey.cipher_ctx, &offload_ctx->rekey.tx);
+
+		spin_lock_irqsave(&offload_ctx->lock, flags);
+		WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq);
+		set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+		spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+		/* Switch to rekey validator; new sends won't use HW offload */
+		smp_store_release(&sk->sk_validate_xmit_skb,
+				  tls_validate_xmit_skb_rekey);
+
+		up_read(&device_offload_lock);
+	}
+
+	unsafe_memcpy(&offload_ctx->rekey.crypto_send.info, new_crypto_info,
+		      cipher_desc->crypto_info,
+		      /* checked in do_tls_setsockopt_conf */);
+	memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
+
+	return 0;
+}
+
+static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
+				     bool deferred, int push_flags)
+{
+	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
+	struct crypto_aead *new_aead, *old_aead, *old_sw_aead;
+	const struct tls_cipher_desc *cipher_desc;
+	struct net_device *netdev;
+	unsigned long flags;
+	char *key;
+	int rc;
+
+	cipher_desc = get_cipher_desc(offload_ctx->rekey.crypto_send.info.cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	DEBUG_NET_WARN_ON_ONCE(!offload_ctx->rekey.start_marker);
+
+	rc = tls_sw_drain_tx(sk, ctx, push_flags);
+	/* -EAGAIN (sndbuf full) and a signal (-EINTR/-ERESTARTSYS from
+	 * sk_stream_wait_memory()) are transient: leave the rekey PENDING and
+	 * retry on the next sendmsg rather than permanently dropping HW offload.
+	 * tls_tx_records() likewise passes these through without aborting.
+	 */
+	if (rc == -EAGAIN || rc == -EINTR || rc == -ERESTARTSYS)
+		return rc;
+	if (rc)
+		goto rekey_fallback;	/* hard failure: fall back to SW */
+
+	down_read(&device_offload_lock);
+
+	netdev = rcu_dereference_protected(ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (!netdev) {
+		rc = -ENODEV;
+		goto release_lock;
+	}
+
+	/* Drain in-flight xmit users before tls_dev_del() and before freeing the
+	 * old fallback aead_send: (1) under the rekey validator a decrypted
+	 * straddler may still be inside the driver on the HW context (same swap ->
+	 * synchronize_net -> dev_del order as tls_device_down(), which also keeps a
+	 * decrypted skb from reaching a torn-down context); (2) pre-boundary
+	 * retransmits routed to tls_sw_fallback() read aead_send locklessly. No new
+	 * fallback can start here: every pre-boundary record is ACKed and freed, so
+	 * fill_sg_in() bails.
+	 */
+	synchronize_net();
+
+	if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
+		netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+						TLS_OFFLOAD_CTX_DIR_TX);
+		set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+	}
+
+	/* Build the new SW-fallback key into a fresh tfm and swap it in only
+	 * on success. Doing this while the HW context is torn down
+	 * (TLS_TX_DEV_CLOSED set) means a failure falls into rekey_fallback
+	 * with HW off, so the SW fallback is coherent, same as a dev_add
+	 * failure.
+	 */
+	key = crypto_info_key(&offload_ctx->rekey.crypto_send.info, cipher_desc);
+	new_aead = tls_device_build_rekey_aead(cipher_desc, key, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(new_aead)) {
+		rc = PTR_ERR(new_aead);
+		goto release_lock;
+	}
+
+	/* crypto_send.info.rec_seq is frozen at setsockopt time; the SW context
+	 * advanced rekey.tx.rec_seq for every record it sent, so hand the NIC the
+	 * live record number (mirrors the RX deferred add).
+	 */
+	memcpy(crypto_info_rec_seq(&offload_ctx->rekey.crypto_send.info, cipher_desc),
+	       offload_ctx->rekey.tx.rec_seq, cipher_desc->rec_seq);
+
+	rc = tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.crypto_send.info,
+				   tcp_sk(sk)->write_seq);
+	if (rc) {
+		crypto_free_aead(new_aead);
+		goto release_lock;
+	}
+
+	/* Point of no return: HW is live with the new key. Swap in the new
+	 * fallback tfm and drop the old one; the remaining steps cannot fail.
+	 */
+	old_aead = offload_ctx->aead_send;
+	offload_ctx->aead_send = new_aead;
+	crypto_free_aead(old_aead);
+	clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+
+	memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
+	       cipher_desc->salt + cipher_desc->iv);
+	memcpy(ctx->tx.rec_seq, offload_ctx->rekey.tx.rec_seq,
+	       cipher_desc->rec_seq);
+	unsafe_memcpy(&ctx->crypto_send.info,
+		      &offload_ctx->rekey.crypto_send.info,
+		      cipher_desc->crypto_info,
+		      /* checked during rekey setup */);
+
+	/* Start marker: the NIC passes through everything before
+	 * write_seq untouched (it is already SW-encrypted ciphertext),
+	 * same as during initial offload setup. Also drops the stale
+	 * marker and rebases unacked_record_sn so the record-sequence
+	 * bookkeeping stays consistent on the inline path.
+	 */
+	tls_device_commit_rekey_marker(sk, offload_ctx,
+				       offload_ctx->rekey.start_marker);
+
+	old_sw_aead = tls_sw_ctx_tx(ctx)->aead_send;
+
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+
+	/* Arm the drop floor before restoring the HW validator: from now on
+	 * tls_validate_xmit_skb() drops payload retransmits of fully-ACKed data, so
+	 * a stale clone whose record was purged here does not reach the NIC and trip
+	 * its WARN on the new start marker. The cleartext leak on that path is closed
+	 * separately by the skb_is_decrypted() gate in tls_sw_fallback(); this is
+	 * only WARN avoidance. Set once; stays set for the socket's life.
+	 */
+	set_bit(TLS_TX_REKEY_FLOOR, &ctx->flags);
+
+	/* Switch back to HW offload validator */
+	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
+
+	WRITE_ONCE(ctx->rekey.sw_ctx, NULL);
+	WRITE_ONCE(ctx->rekey.cipher_ctx, NULL);
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+
+	memzero_explicit(&offload_ctx->rekey, sizeof(offload_ctx->rekey));
+	crypto_free_aead(old_sw_aead);
+
+	up_read(&device_offload_lock);
+
+	if (deferred)
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXREKEY);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+	return 0;
+
+release_lock:
+	up_read(&device_offload_lock);
+
+rekey_fallback:
+	kfree(offload_ctx->rekey.start_marker);
+	offload_ctx->rekey.start_marker = NULL;
+	spin_lock_irqsave(&offload_ctx->lock, flags);
+	set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
+	clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	spin_unlock_irqrestore(&offload_ctx->lock, flags);
+	if (deferred)
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXREKEY);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYFALLBACK);
+	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+
+	return 0;
+}
+
+static int tls_set_device_offload_rekey(struct sock *sk,
+					struct tls_context *ctx,
+					struct tls_crypto_info *new_crypto_info)
+{
+	struct tls_offload_context_tx *offload_ctx = tls_offload_ctx_tx(ctx);
+	bool rekey_pending = test_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
+	bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+	bool defer = true;
+	int rc;
+
+	/* Defer the switch back to HW until any in-flight old-key records are
+	 * ACKed. A partially_sent_record needs no separate check: its record is
+	 * on records_list before it is sent (tls_push_record()) and stays there
+	 * until ACKed, so tls_has_unacked_records() already covers it.
+	 */
+	if (!rekey_pending && !rekey_failed)
+		defer = tls_has_unacked_records(offload_ctx) ||
+			tls_is_pending_open_record(ctx);
+
+	if (!offload_ctx->rekey.start_marker) {
+		offload_ctx->rekey.start_marker =
+			kmalloc_obj(*offload_ctx->rekey.start_marker);
+		if (!offload_ctx->rekey.start_marker)
+			return -ENOMEM;
+	}
+
+	rc = tls_device_start_rekey(sk, ctx, offload_ctx, new_crypto_info);
+	if (rc)
+		return rc;
+
+	if (defer) {
+		if (!rekey_pending)
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXREKEY);
+		else
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
+		return 0;
+	}
+
+	return tls_device_complete_rekey(sk, ctx, false, 0);
+}
+
 static int tls_set_device_offload_initial(struct sock *sk,
 					  struct tls_context *ctx,
 					  struct net_device *netdev,
@@ -1190,25 +1749,39 @@ static int tls_set_device_offload_initial(struct sock *sk,
 	return rc;
 }
 
-int tls_set_device_offload(struct sock *sk)
+int tls_set_device_offload(struct sock *sk,
+			   struct tls_crypto_info *new_crypto_info)
 {
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
 	const struct tls_cipher_desc *cipher_desc;
-	struct tls_crypto_info *crypto_info;
 	struct net_device *netdev;
 	struct tls_context *ctx;
 	int rc;
 
 	ctx = tls_get_ctx(sk);
 
-	/* A rekey (setsockopt on an already-configured socket) is not
-	 * supported on the device offload path yet; reject it here so the
-	 * caller can decide (propagate the error for a HW connection, or
-	 * re-init software crypto for a SW one). KeyUpdate support replaces
-	 * this guard with real rekey handling.
+	/* A rekey of a SW-offloaded socket belongs to tls_set_sw_offload(). */
+	if (new_crypto_info && ctx->tx_conf != TLS_HW)
+		return -EINVAL;
+
+	crypto_info = &ctx->crypto_send.info;
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable)
+		return -EINVAL;
+
+	/* A rekey targets the device already holding the HW TX context
+	 * (ctx->netdev), which can differ from the socket's current route after
+	 * a route change or bond/team failover; tls_set_device_offload_rekey()
+	 * and tls_device_complete_rekey() resolve it from ctx->netdev under
+	 * device_offload_lock. Only the initial install needs the route device.
 	 */
-	if (ctx->tx_conf != TLS_BASE)
-		return -EOPNOTSUPP;
+	if (new_crypto_info)
+		return tls_set_device_offload_rekey(sk, ctx, src_crypto_info);
 
+	/* Initial install: a HW TX context must not already exist, otherwise
+	 * alloc_offload_ctx_tx() below would silently overwrite it.
+	 */
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
@@ -1223,14 +1796,7 @@ int tls_set_device_offload(struct sock *sk)
 		goto release_netdev;
 	}
 
-	crypto_info = &ctx->crypto_send.info;
-	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
-	if (!cipher_desc || !cipher_desc->offloadable) {
-		rc = -EINVAL;
-		goto release_netdev;
-	}
-
-	rc = tls_set_device_offload_initial(sk, ctx, netdev, crypto_info,
+	rc = tls_set_device_offload_initial(sk, ctx, netdev, src_crypto_info,
 					    cipher_desc);
 
 release_netdev:
@@ -1370,10 +1936,16 @@ static int tls_device_down(struct net_device *netdev)
 	spin_unlock_irqrestore(&tls_device_lock, flags);
 
 	list_for_each_entry_safe(ctx, tmp, &list, list)	{
-		/* Stop offloaded TX and switch to the fallback.
-		 * tls_is_skb_tx_device_offloaded will return false.
+		/* Stop offloaded TX and switch to the fallback. For a socket not
+		 * mid-rekey, tls_is_skb_tx_device_offloaded() then returns false; a
+		 * PENDING/FAILED socket keeps the rekey validator (under which only a
+		 * decrypted straddler still offloads), and the synchronize_net()
+		 * below drains any such in-flight skb before tls_dev_del().
 		 */
-		WRITE_ONCE(ctx->sk->sk_validate_xmit_skb, tls_validate_xmit_skb_sw);
+		if (!test_bit(TLS_TX_REKEY_PENDING, &ctx->flags) &&
+		    !test_bit(TLS_TX_REKEY_FAILED, &ctx->flags))
+			WRITE_ONCE(ctx->sk->sk_validate_xmit_skb,
+				   tls_validate_xmit_skb_sw);
 
 		/* Stop the RX and TX resync.
 		 * tls_dev_resync must not be called after tls_dev_del.
@@ -1390,9 +1962,12 @@ static int tls_device_down(struct net_device *netdev)
 		synchronize_net();
 
 		/* Release the offload context on the driver side. */
-		if (ctx->tx_conf == TLS_HW)
+		if (ctx->tx_conf == TLS_HW &&
+		    !test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
 							TLS_OFFLOAD_CTX_DIR_TX);
+			set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
+		}
 		if (ctx->rx_conf == TLS_HW &&
 		    !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags))
 			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 1110f7ac6bcb..f2a0ae827bb2 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -190,6 +190,14 @@ static void complete_skb(struct sk_buff *nskb, struct sk_buff *skb, int headln)
 
 	skb_copy_header(nskb, skb);
 
+	/* nskb now carries ciphertext, but skb_copy_header() inherited
+	 * skb->decrypted from the plaintext original. Clear it so the bit keeps
+	 * meaning "still-plaintext, needs an encryptor": otherwise a requeued
+	 * nskb would be needlessly re-validated (and re-encrypted) and would trip
+	 * the NIC's decrypted-vs-start-marker WARN.
+	 */
+	nskb->decrypted = 0;
+
 	skb_put(nskb, skb->len);
 	memcpy(nskb->data, skb->data, headln);
 
@@ -396,8 +404,17 @@ static struct sk_buff *tls_sw_fallback(struct sock *sk, struct sk_buff *skb)
 	sg_init_table(sg_out, ARRAY_SIZE(sg_out));
 
 	if (fill_sg_in(sg_in, skb, ctx, &rcd_sn, &sync_size, &resync_sgs)) {
-		/* bypass packets before kernel TLS socket option was set */
-		if (sync_size < 0 && payload_len <= -sync_size)
+		/* Below the record range (start marker / already-freed record).
+		 * Pass through only cleartext that was never offload-encrypted
+		 * (skb->decrypted == 0): genuine pre-TLS bytes sent before the
+		 * socket option was set, or SW-encrypted rekey ciphertext. A
+		 * decrypted=1 skb here is offload-record plaintext whose record was
+		 * purged (e.g. a rekey installed a new start marker above its seq);
+		 * it must never reach the wire in the clear, so continue on and
+		 * drop it (nskb stays NULL).
+		 */
+		if (sync_size < 0 && payload_len <= -sync_size &&
+		    !skb_is_decrypted(skb))
 			nskb = skb_get(skb);
 		goto put_sg;
 	}
@@ -416,11 +433,57 @@ static struct sk_buff *tls_sw_fallback(struct sock *sk, struct sk_buff *skb)
 	return nskb;
 }
 
+/* Post-rekey drop floor. Once a rekey has completed (TLS_TX_REKEY_FLOOR set), a
+ * stale retransmit clone of already-ACKed data may still be dequeued from a
+ * qdisc; if its offload record was purged at completion it now maps to a rekey
+ * start marker. The cleartext leak on that path is closed unconditionally by
+ * the skb_is_decrypted() gate in tls_sw_fallback(); this floor additionally
+ * drops the clone before it reaches the NIC, avoiding the driver's WARN
+ * (mlx5e_ktls_handle_tx_skb() SKIP_NO_DATA) on an otherwise-legitimate race.
+ * Only needed by tls_validate_xmit_skb() (the restored HW-offload validator):
+ * only there can a purged-record clone reach the NIC and hit the new start
+ * marker. Under the rekey/SW validators the only skb the NIC offloads is a
+ * decrypted straddler whose record is still present (no SKIP_NO_DATA), and a
+ * stale clone is dropped by the skb_is_decrypted() gate in tls_sw_fallback().
+ * Such a clone is exactly a payload skb whose end_seq <= snd_una: the peer has
+ * already ACKed that data, so dropping it is always safe. Live/unacked data
+ * (including a legitimate retransmit, or a straddler ending past snd_una) is
+ * never touched; pure ACKs and zero-window probes carry no payload and pass.
+ */
+static bool tls_tx_drop_acked_clone(struct sock *sk, struct sk_buff *skb)
+{
+	int payload_len = skb->len - skb_tcp_all_headers(skb);
+	u32 end_seq;
+
+	if (likely(!test_bit(TLS_TX_REKEY_FLOOR, &tls_get_ctx(sk)->flags)))
+		return false;
+
+	if (payload_len <= 0)
+		return false;
+
+	/* Drop only when the whole payload is already ACKed (end_seq <= snd_una):
+	 * such a skb is purely a stale retransmit clone the peer already has. A
+	 * clone straddling snd_una still carries unacked bytes, so leave it to the
+	 * normal paths (a live record is re-encrypted; a marker/freed-record hit is
+	 * dropped there too). Both the leak (skb_is_decrypted() gate) and the mlx5
+	 * WARN only concern the fully-ACKed case handled here.
+	 */
+	end_seq = ntohl(tcp_hdr(skb)->seq) + payload_len;
+	return !after(end_seq, READ_ONCE(tcp_sk(sk)->snd_una));
+}
+
 struct sk_buff *tls_validate_xmit_skb(struct sock *sk,
 				      struct net_device *dev,
 				      struct sk_buff *skb)
 {
-	if (dev == rcu_dereference_bh(tls_get_ctx(sk)->netdev) ||
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+
+	if (unlikely(tls_tx_drop_acked_clone(sk, skb))) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	if (dev == rcu_dereference_bh(tls_ctx->netdev) ||
 	    netif_is_bond_master(dev))
 		return skb;
 
@@ -435,6 +498,65 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct sock *sk,
 	return tls_sw_fallback(sk, skb);
 }
 
+struct sk_buff *tls_validate_xmit_skb_rekey(struct sock *sk,
+					    struct net_device *dev,
+					    struct sk_buff *skb)
+{
+	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	u32 tcp_seq = ntohl(tcp_hdr(skb)->seq);
+	u32 pivot_seq;
+
+	/* acquire pairs with clear_bit_unlock() on re-arm; makes the refreshed
+	 * boundary_seq visible in the else branch below.
+	 */
+	if (test_bit_acquire(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
+		int payload_len = skb->len - skb_tcp_all_headers(skb);
+		u32 snd_una = READ_ONCE(tcp_sk(sk)->snd_una);
+
+		/* FAILED: HW context gone and all old-key plaintext ACKed
+		 * (snd_una >= boundary_seq). seq < boundary_seq is old-key data
+		 * whose records are freed, so tls_sw_fallback() drops it. seq >=
+		 * boundary_seq is SW ciphertext with no record. A retransmit is
+		 * built at seq == snd_una (tcp_trim_head()), so an ACK landing
+		 * before we run can move snd_una past seq while the tail is
+		 * unacked; pivoting on snd_una alone would drop that live data
+		 * and force an RTO. Pass through any non-decrypted skb ending
+		 * past snd_una (mirrors tls_tx_drop_acked_clone()); fully-ACKed
+		 * clones fall to the pivot and are dropped.
+		 */
+		if (payload_len > 0 && !skb_is_decrypted(skb) &&
+		    after(tcp_seq + payload_len, snd_una))
+			return skb;
+
+		pivot_seq = snd_una;
+	} else {
+		/* PENDING: new-key data is SW-encrypted at seq >= boundary_seq;
+		 * old-key data below it is still unacked.
+		 *
+		 * On the first arm, boundary_seq is published by the
+		 * smp_store_release() of sk_validate_xmit_skb in
+		 * tls_device_start_rekey(); the xmit path loads that pointer with a
+		 * plain read (net/core/dev.c), so pair it here with an smp_rmb()
+		 * before reading boundary_seq. A stale boundary_seq (0) would pass an
+		 * unacked old-key plaintext skb through; tls_is_skb_tx_device_offloaded()
+		 * would still HW-encrypt it with the installed old key, so not a leak,
+		 * but the barrier keeps the pivot accurate.
+		 */
+		smp_rmb();
+		pivot_seq = READ_ONCE(tls_ctx->rekey.boundary_seq);
+	}
+
+	/* At or after the pivot: already correctly encrypted, pass through */
+	if (!before(tcp_seq, pivot_seq))
+		return skb;
+
+	/* Below the pivot: retransmit of old data, SW fallback with old key */
+	return tls_sw_fallback(sk, skb);
+}
+
+/* Address taken by tls_is_skb_tx_device_offloaded() in the offload drivers. */
+EXPORT_SYMBOL_GPL(tls_validate_xmit_skb_rekey);
+
 struct sk_buff *tls_encrypt_skb(struct sk_buff *skb)
 {
 	return tls_sw_fallback(skb->sk, skb);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 15e83e853f22..3dd3a4ce8209 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -347,8 +347,14 @@ static void tls_sk_proto_cleanup(struct sock *sk,
 		tls_sw_release_resources_tx(sk);
 		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
 	} else if (ctx->tx_conf == TLS_HW) {
+		bool rekey_failed = test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
+
 		tls_device_free_resources_tx(sk);
-		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
+
+		if (rekey_failed)
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
+		else
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 	}
 
 	if (ctx->rx_conf == TLS_SW) {
@@ -369,6 +375,8 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 
 	if (ctx->tx_conf == TLS_SW)
 		tls_sw_cancel_work_tx(ctx);
+	else if (ctx->tx_conf == TLS_HW && ctx->rekey.sw_ctx)
+		tls_sw_cancel_work_tx(ctx);
 
 	lock_sock(sk);
 	free_ctx = ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW;
@@ -445,8 +453,17 @@ static int do_tls_getsockopt_conf(struct sock *sk, sockopt_t *opt, int tx)
 
 	/* get user crypto info */
 	if (tx) {
-		crypto_info = &ctx->crypto_send.info;
-		cctx = &ctx->tx;
+		/* Select the cipher context via the same accessor the data path
+		 * uses, so getsockopt reports the IV/rec_seq that sendmsg encrypts
+		 * with (the pending rekey's while one is in flight, else the
+		 * active key). crypto_info has no accessor; select it the same way.
+		 * lock_sock is held, so rekey.cipher_ctx cannot change under us.
+		 */
+		cctx = tls_tx_cipher_ctx(ctx);
+		if (ctx->rekey.cipher_ctx)
+			crypto_info = &tls_offload_ctx_tx(ctx)->rekey.crypto_send.info;
+		else
+			crypto_info = &ctx->crypto_send.info;
 	} else {
 		crypto_info = &ctx->crypto_recv.info;
 		cctx = &ctx->rx;
@@ -710,7 +727,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	}
 
 	if (tx) {
-		rc = tls_set_device_offload(sk);
+		rc = tls_set_device_offload(sk, update ? crypto_info : NULL);
 		conf = TLS_HW;
 		if (!rc) {
 			if (!update) {
@@ -787,7 +804,11 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	return 0;
 
 err_crypto_info:
-	if (update) {
+	/* -EAGAIN is a transient sndbuf-full condition on a non-blocking rekey,
+	 * not a failed KeyUpdate: the old key stays installed and userspace
+	 * retries once the socket is writable, so don't count it as an error.
+	 */
+	if (update && rc != -EAGAIN) {
 		TLS_INC_STATS(sock_net(sk), tx ? LINUX_MIB_TLSTXREKEYERROR
 					       : LINUX_MIB_TLSRXREKEYERROR);
 	}
@@ -880,12 +901,29 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 
 	switch (optname) {
 	case TLS_TX:
-	case TLS_RX:
+	case TLS_RX: {
+		/* tls_device_sendmsg() holds tx_lock across the lock_sock drop
+		 * in sk_stream_wait_memory() with a half-built open_record
+		 * exposed. A concurrent HW-offload rekey (tls_device_start_rekey())
+		 * would flush that record and swap the key under the sender,
+		 * corrupting record framing. Serialize TX setsockopt against
+		 * the data path with tx_lock, unconditionally for TLS_TX,
+		 * since during initial setup there is no sender contending it.
+		 */
+		bool tx = optname == TLS_TX;
+
+		if (tx) {
+			rc = mutex_lock_interruptible(&tls_get_ctx(sk)->tx_lock);
+			if (rc)
+				break;
+		}
 		lock_sock(sk);
-		rc = do_tls_setsockopt_conf(sk, optval, optlen,
-					    optname == TLS_TX);
+		rc = do_tls_setsockopt_conf(sk, optval, optlen, tx);
 		release_sock(sk);
+		if (tx)
+			mutex_unlock(&tls_get_ctx(sk)->tx_lock);
 		break;
+	}
 	case TLS_TX_ZEROCOPY_RO:
 		lock_sock(sk);
 		rc = do_tls_setsockopt_tx_zc(sk, optval, optlen);
diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index 4012c4372d4c..4bb1e3727e28 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -27,6 +27,9 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyOk", LINUX_MIB_TLSTXREKEYOK),
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
+	SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK),
+	SNMP_MIB_ITEM("TlsCurrTxRekey", LINUX_MIB_TLSCURRTXREKEY),
+	SNMP_MIB_ITEM("TlsTxRekeyAborted", LINUX_MIB_TLSTXREKEYABORTED),
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5531303dd704..fd162d8f1d64 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -522,7 +522,7 @@ static void tls_encrypt_done(void *data, int err)
 		complete(&ctx->async_wait.completion);
 }
 
-static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
+int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
 {
 	if (!atomic_dec_and_test(&ctx->encrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
@@ -763,8 +763,7 @@ static int tls_sw_sendmsg_splice(struct sock *sk, struct msghdr *msg,
 	return 0;
 }
 
-static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
-				 size_t size)
+int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -2421,6 +2420,31 @@ void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx)
 	sw_ctx->tx_work.sk = sk;
 }
 
+int tls_sw_drain_tx(struct sock *sk, struct tls_context *ctx, int flags)
+{
+	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
+	int rc;
+
+	flags = (flags & MSG_DONTWAIT) | MSG_NOSIGNAL;
+
+	if (sw_ctx->open_rec)
+		tls_sw_push_pending_record(sk, flags);
+	rc = tls_encrypt_async_wait(sw_ctx);
+	if (rc)
+		return rc;
+	rc = tls_tx_records(sk, flags);
+	if (rc < 0 || tls_is_partially_sent_record(ctx) ||
+	    tls_is_pending_open_record(ctx) ||
+	    !list_empty(&sw_ctx->tx_list))
+		return rc < 0 ? rc : -EAGAIN;
+
+	tls_free_open_rec(sk);
+
+	cancel_delayed_work_sync(&sw_ctx->tx_work.work);
+	clear_bit(BIT_TX_SCHEDULED, &sw_ctx->tx_bitmask);
+	return 0;
+}
+
 static bool tls_is_tx_ready(struct tls_sw_context_tx *ctx)
 {
 	struct tls_rec *rec;
@@ -2609,7 +2633,8 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			goto free_aead;
 	}
 
-	ctx->push_pending_record = tls_sw_push_pending_record;
+	if (tx)
+		ctx->push_pending_record = tls_sw_push_pending_record;
 
 	/* setkey is the last operation that could fail during a
 	 * rekey. if it succeeds, we can start modifying the
-- 
2.50.1

