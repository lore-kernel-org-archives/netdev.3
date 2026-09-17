Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D224490C0B
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685140; cv=none; b=pb4M64us3BeAgbGau0MGX0M2hPsgK7hYAjJQsnj2UCVZ3/DYJBqDpOA+796RiyexEIErxYWJ2/r5AsdEotdTFEndSTKbmVqA350gd5zcJWybTwq2oF2Gjd2KUoIy5uJweNiXAbh7XfyMGXvDGCIZXGu/dqBQ7t4lxxPTtwU7HAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685140; c=relaxed/simple;
	bh=dlizKLk04f758PTnBcgpUbpdgHxc1Cnd0uHmF4dZIm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtHJWa8Yp2OzdPR0sqlLGW9/ztW+YYqAmtMvttghFV7pOswAErsXFonDZib5BXgzSkPFCdNnacan+zpMvNZAnS8fzWVH6vPSONlCFOWDPy4Uuu+RAtuaVP5cM+T769iR3yt7Op82b3+6l6q1xvyVPPKxVbRPid6BpkkTrDVB63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dincDkUs; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dincDkUs"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae6a9aeaso68488eaf.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685134; x=1790289934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4W63kaZznniP+7flXgyKpOxQvokpvMIGVT0Upm7X+TU=;
        b=dincDkUshU6URuYPECX0b68FMEHxWNdSkcBPzgJLiqNnDr3ZQRrsoOYnR5HbVewuA6
         1hNiTKZAkLBOnZl9EB8TTfrDSndWkMT2+qVjg9DUILAwS1cLrqE0c1SbYbECrCvTWWXm
         5YwhKKyR52dPO6xKh28up6IWUyp54DiN9ByIDqai7bvNH7e5RCuGaSXEkzGx5of7DdtA
         pQyNtlHv4k42DRrnj/Sx4XaHO4fL4Yy0Bfjb/F4XzuvzrxmDANshkUrnwGpkVBErXhm1
         56SlwNKcHdmdseuwLG7lbKnuPL3ErZoFQ+J29XCqF6nMfNECI8ml8/DR7gVLlPxnkf/i
         xMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685134; x=1790289934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4W63kaZznniP+7flXgyKpOxQvokpvMIGVT0Upm7X+TU=;
        b=ESa8+VoGDbaXooGCSm1R+36LOJpyBVX3HZNqiO1nZnFDgrUZw3ne4Qnx1toeA9ATFc
         DmTTnJRTJfz/w46On08PmsFjD5HIA6XFeoyYpRIgW/XPoTkjO69EYg8hRnJyMSLRrld2
         NetT0gc49DjAh1Txg+r3XINLVWWXcIL+49kzfCSbbBFjoA4JXkBKC24Zvk3VN6o5ehkZ
         fRb7Zo2UjJs1GB0zfeokgLbps4Mvc29gGYcM3dNqbTOkAoAfrhy/WaPuEWtWbBHVCpxn
         9R6GEsx/vB40DhooiYCZIzFIFkeSX0AcrzVrdY46ZQl8yDn+4Jgr0LKy/EFLz/0Tbir1
         nPBg==
X-Gm-Message-State: AFuF++m1Deuag/AqZzC9AC1N5Dg4TKnVNbM4oo5a3l2NrsqdnkNaMguA
	NgN0ms3JCfpcxWtZypgYuSO5u36RUckmEBRoQW3wdQZc+E18BMxaY4+hOPza1fp/0UYTR2HqFak
	IjfHlhpfbmOXATEeY9iJ8XfH7mBgvWrUPOl37aG9C/X1ennnJlTr2g8db+5HaUCqc8Os9obApoQ
	Jp7Av28Hd/933qVRTwWTCsw5KyW7uighEtf7NymJXe9XyYGF4=
X-Gm-Gg: AYBFou3ZLe1sYfPCDrdRYTH5yzhgkJAOpma5pvPvpPGxjiQdLR5FdzfVPAMD+yK3vl9
	/GaOUCIQwFUdnvk/XR8uSkDbAvVl8VbgpQOeUv9qVwnpCzHXuQZQWt9mtv9evnvyRbXMoDpuc8u
	hRfDQUebKvGGFc88uFmTpHtjBMVLzV/mEkgwxy7Vi5JVLxLUpeIXmDKO7YAyftY+7RXqMU8/CEx
	waTcX9nBuh1Ihzo8GhLrBZHnCC8nsiBrmYjf7Q8LrB+ccDyVliyOFgHeKBNCAXhKg4qTaY1CmWF
	6u0WwZIj9Mgy9FPW8gdhKo4JIhjMUigsriggS6ozFGXexpU+CFkU4EIUbjWg2Bud3t2yCwrh5on
	6mGvP6727XyZQniz7OBzGks/QEAhRMmZUFk5hx1vrXtr+wTonCvY5BNHxQlfp0FMdC9qRyPPFW4
	naESka/O5HfxyUjeFKZ0ub+UAAtkcXxmMDY29qm+fyeNxLSbACHxQ1j3gs8IRgubsZHcWoLVyAh
	vxXNDtue4DYlREa/YIIbXMJqx0jAvonsR5U/ibxUp0r0GQWxuthJQRmfEPN9dq8U80DA0cfxgep
	lkOKQj5jgMdJ5Rh6Nflm4W7HBCkHQxg6z0Tc38RxERPhAzAnocxmqmKTuQe82hLjpQTSqm0Y9BO
	Z3BXwa0vFniN0eefLNQ==
X-Received: by 2002:a05:6820:2084:b0:6c2:6f93:389f with SMTP id 006d021491bc7-6ca9bd48180mr579049eaf.37.1789685133859;
        Thu, 17 Sep 2026 15:45:33 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:33 -0700 (PDT)
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
Subject: [PATCH net-next v17 12/15] tls: device: add RX KeyUpdate support
Date: Thu, 17 Sep 2026 16:35:23 -0600
Message-ID: <20260917224355.2288021-13-rjethwani@purestorage.com>
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

On RX, the NIC may have already decrypted in-flight records with
the old key before the peer's KeyUpdate is parsed, so the old
AEAD, IV and rec_seq are retained on tls_offload_context_rx.
tls_device_rx_del_key() is called from tls_check_pending_rekey()
when a KeyUpdate record is decoded; otherwise post-KeyUpdate records
(carrying new-key wire encryption) would be decrypted with the retired key.
tls_device_decrypted() classifies records by old_nic_boundary:

  - after the boundary: new-key record; drop the old key.
  - before, fully encrypted (including a non-mixed record flagged
    decrypt_failed, which was not transformed): advance old_rec_seq,
    let SW AEAD decrypt.
  - before, mixed - partially decrypted, or with XORed frags flagged
    decrypt_failed: reencrypt with the old key so SW AEAD can decrypt.

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

On CQE_TLS_OFFLOAD_ERROR the NIC could not authenticate a record; the
driver sets a new skb->decrypt_failed bit while skb->decrypted stays
clear. Whether the payload was transformed depends on the record: in a
mixed record the XORed frags carry skb->decrypt_failed and must be undone,
so tls_device_decrypted() routes mixed records through the
reencrypt-with-old-key path, which undoes the transform per frag and lets
the SW AEAD re-authenticate and decrypt. A non-mixed record with
skb->decrypt_failed set was not transformed; it is still wire ciphertext,
classified as encrypted and decrypted directly after advancing old_rec_seq.

The new key's tls_dev_add is deferred until the old key is fully
consumed: tls_set_device_offload_rx() sets dev_add_pending while
old_aead_recv is retained, and tls_device_deferred_dev_add_rx()
installs the new key when the first post-boundary record is seen. It
anchors the NIC on that record's start (rec_start_seq, already
copy_mode-adjusted as above) paired with the new key's starting record
number, read from crypto_recv.info after tls_sw_ctx_finalize() stored it
there. Handing the NIC that (TCP seq, rec_seq) pair, rather than the
raw copied_seq, which in copy_mode has advanced past the record end,
keeps the sequence mapping the NIC tracks consistent in both strparser
modes.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
TLS 1.3 RX KeyUpdate cycles.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h         |  28 +-
 include/uapi/linux/snmp.h |   3 +
 net/tls/tls.h             |   9 +-
 net/tls/tls_device.c      | 572 ++++++++++++++++++++++++++++++++++----
 net/tls/tls_main.c        |  11 +-
 net/tls/tls_proc.c        |   3 +
 net/tls/tls_sw.c          |   1 +
 7 files changed, 562 insertions(+), 65 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index b5fc281ff365..6844a685d6e0 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -211,10 +211,14 @@ enum tls_context_flags {
 	 * to be atomic.
 	 */
 	TLS_TX_SYNC_SCHED = 1,
-	/* tls_dev_del was called for the RX side, device state was released,
-	 * but tls_ctx->netdev might still be kept, because TX-side driver
-	 * resources might not be released yet. Used to prevent the second
-	 * tls_dev_del call in tls_device_down if it happens simultaneously.
+	/* tls_dev_del was called for the RX side, releasing the NIC's RX
+	 * offload context, while tls_ctx->netdev is still kept (TX-side driver
+	 * resources may not be released yet, or a rekey is about to re-add the
+	 * context). Set in that case, and during a rekey before re-add, and
+	 * cleared when tls_dev_add re-establishes the context. Readers use it to
+	 * avoid a second tls_dev_del and to suppress resync while the NIC has no
+	 * key. tls_device_down() sets it too, so the rekey paths can test the bit
+	 * alone.
 	 */
 	TLS_RX_DEV_CLOSED = 2,
 	/* TX HW context has been tls_dev_del()'d (mid-rekey before the re-add,
@@ -239,6 +243,14 @@ enum tls_context_flags {
 	 * avoidance only.
 	 */
 	TLS_TX_REKEY_FLOOR = 7,
+	/* The RX side fell back to SW decryption during a rekey (tls_dev_add()
+	 * failed, or the netdev is gone) and the socket has been moved from the
+	 * TlsCurrRxDevice to the TlsCurrRxSw gauge while rx_conf stays TLS_HW.
+	 * Accounting only: the functional state is TLS_RX_DEV_{DEGRADED,CLOSED}.
+	 * Cleared, moving the socket back, when a later rekey re-adds the NIC
+	 * context. Mirrors TLS_TX_REKEY_FAILED for the close-time decrement.
+	 */
+	TLS_RX_REKEY_FAILED = 8,
 };
 
 struct tls_prot_info {
@@ -359,6 +371,14 @@ struct tls_offload_context_rx {
 	u8 resync_nh_reset:1;
 	/* CORE_NEXT_HINT-only member, but use the hole here */
 	u8 resync_nh_do_now:1;
+	/* tls_dev_add deferred until old key is freed */
+	u8 dev_add_pending:1;
+	struct {
+		struct crypto_aead *old_aead_recv; /* old key AEAD cipher */
+		char old_iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE]; /* old key IV */
+		char old_rec_seq[TLS_MAX_REC_SEQ_SIZE]; /* old key TLS record seq */
+		u32 old_nic_boundary; /* TCP seq below which the NIC may have used the old key */
+	} rekey;
 	union {
 		/* TLS_OFFLOAD_SYNC_TYPE_DRIVER_REQ */
 		struct {
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index a2e0264641de..423aec9ae4ca 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -370,8 +370,11 @@ enum
 	LINUX_MIB_TLSTXREKEYERROR,		/* TlsTxRekeyError */
 	LINUX_MIB_TLSRXREKEYRECEIVED,		/* TlsRxRekeyReceived */
 	LINUX_MIB_TLSTXREKEYFALLBACK,		/* TlsTxRekeyFallback */
+	LINUX_MIB_TLSRXREKEYFALLBACK,		/* TlsRxRekeyFallback */
 	LINUX_MIB_TLSCURRTXREKEY,		/* TlsCurrTxRekey */
+	LINUX_MIB_TLSCURRRXREKEY,		/* TlsCurrRxRekey */
 	LINUX_MIB_TLSTXREKEYABORTED,		/* TlsTxRekeyAborted */
+	LINUX_MIB_TLSRXREKEYABORTED,		/* TlsRxRekeyAborted */
 	__LINUX_MIB_TLSMAX
 };
 
diff --git a/net/tls/tls.h b/net/tls/tls.h
index e749f429301a..5d8f4d458df8 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -251,8 +251,10 @@ void tls_device_cleanup(void);
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
@@ -268,13 +270,16 @@ tls_set_device_offload(struct sock *sk, struct tls_crypto_info *crypto_info)
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
index f32c1bb6b497..ac09f356cff9 100644
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
@@ -192,6 +202,129 @@ static void tls_device_commit_start_marker(struct sock *sk,
 	tcp_write_collapse_fence(sk);
 }
 
+/* Account a rekey that could not (re)install the RX key on the NIC. The event
+ * counter is bumped every time; the gauges move only on the first fallback
+ * since the socket was last offloaded, so the recurring post-NETDEV_DOWN
+ * rekeys and repeated failed adds do not drift them. The matching move back is
+ * in tls_device_dev_add_rx(); the close-time decrement keys off the bit.
+ */
+static void tls_device_rx_rekey_fallback(struct sock *sk,
+					 struct tls_context *tls_ctx)
+{
+	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYFALLBACK);
+	if (!test_and_set_bit(TLS_RX_REKEY_FAILED, &tls_ctx->flags)) {
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+	}
+}
+
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
+		/* Back on the NIC after an earlier SW fallback: undo its move. */
+		if (test_and_clear_bit(TLS_RX_REKEY_FAILED, &tls_ctx->flags)) {
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+		}
+		if (is_rekey)
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+	} else if (is_rekey) {
+		set_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags);
+		set_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags);
+		tls_device_rx_rekey_fallback(sk, tls_ctx);
+	}
+	return rc;
+}
+
+static void tls_device_deferred_dev_add_rx(struct sock *sk,
+					   struct tls_context *tls_ctx,
+					   struct tls_offload_context_rx *ctx,
+					   u32 rec_start_seq)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	union tls_crypto_context crypto_ctx;
+	struct net_device *netdev;
+
+	ctx->dev_add_pending = 0;
+
+	/* crypto_recv.info.rec_seq is frozen at the value setsockopt() passed
+	 * in: the new key's first record number. The records that drained
+	 * between setsockopt() and this boundary crossing were SW-decrypted
+	 * under the new key and advanced tls_ctx->rx.rec_seq, so the record
+	 * starting at rec_start_seq, the one being decrypted right now,
+	 * before tls_rx_one_record() calls tls_advance_record_sn(), is
+	 * numbered by rx.rec_seq, not by the blob. Hand the NIC the live
+	 * (TCP seq, record number) pair, as getsockopt(TLS_RX) already does.
+	 */
+	cipher_desc = get_cipher_desc(tls_ctx->crypto_recv.info.cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+	crypto_ctx = tls_ctx->crypto_recv;
+	memcpy(crypto_info_rec_seq(&crypto_ctx.info, cipher_desc),
+	       tls_ctx->rx.rec_seq, cipher_desc->rec_seq);
+
+	down_read(&device_offload_lock);
+	netdev = rcu_dereference_protected(tls_ctx->netdev,
+					   lockdep_is_held(&device_offload_lock));
+	if (netdev)
+		tls_device_dev_add_rx(sk, tls_ctx, netdev,
+				      &crypto_ctx.info,
+				      rec_start_seq, true);
+	else
+		tls_device_rx_rekey_fallback(sk, tls_ctx);
+	up_read(&device_offload_lock);
+	memzero_explicit(&crypto_ctx, sizeof(crypto_ctx));
+	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXREKEY);
+}
+
+/* Retire the NIC's RX key when a KeyUpdate record is decoded (from
+ * tls_check_pending_rekey(), lock_sock held). The NIC must lose the old key
+ * now, before it transforms further post-KeyUpdate records that are new-key on
+ * the wire. TLS_RX_DEV_CLOSED is re-tested under device_offload_lock because
+ * tls_device_down() can run in between; synchronize_net() drains the RX path
+ * before the driver frees its context.
+ */
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
+	if (!netdev || test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
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
@@ -969,6 +1102,8 @@ void tls_device_rx_resync_new_rec(struct sock *sk, u32 rcd_len, u32 seq)
 		return;
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags)))
 		return;
+	if (unlikely(test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags)))
+		return;
 
 	prot = &tls_ctx->prot_info;
 	rx_ctx = tls_offload_ctx_rx(tls_ctx);
@@ -1114,7 +1249,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	if (skb_pagelen(skb) > offset) {
 		copy = min_t(int, skb_pagelen(skb) - offset, data_len);
 
-		if (skb->decrypted) {
+		if (skb->decrypted || skb->decrypt_failed) {
 			err = skb_store_bits(skb, offset, buf, copy);
 			if (err)
 				goto free_buf;
@@ -1141,7 +1276,7 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 		copy = min_t(int, skb_iter->len - frag_pos,
 			     data_len + rxm->offset - offset);
 
-		if (skb_iter->decrypted) {
+		if (skb_iter->decrypted || skb_iter->decrypt_failed) {
 			err = skb_store_bits(skb_iter, frag_pos, buf, copy);
 			if (err)
 				goto free_buf;
@@ -1158,6 +1293,77 @@ tls_device_reencrypt(struct sock *sk, struct tls_context *tls_ctx)
 	return err;
 }
 
+/*
+ * Reconstruct a boundary record whose frags the NIC XORed with the old key,
+ * then hand it to the SW AEAD under the current (new) key.
+ *
+ * These are deliberately two different keys: the sender has already done its
+ * TX KeyUpdate, so the record on the wire is AEAD-encrypted with the new key,
+ * but the RX NIC still holds the old key and CTR-XORed some frags with the old
+ * keystream. tls_device_reencrypt() must undo that XOR with the *old* key to
+ * restore the pristine new-key ciphertext, so swap the old key in only for the
+ * reconstruction and restore the current key before returning; the SW AEAD
+ * decrypt that follows then runs under the new key, matching the wire record.
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
+/*
+ * TCP sequence of the first byte of the record the strparser currently holds
+ * or is still collecting. In non-copy mode tcp_sk(sk)->copied_seq is left at
+ * the record start until tls_strp_msg_consume(). In copy mode
+ * tls_strp_read_copy() zeroes stm.offset and anchor->len and then
+ * tls_strp_read_copyin() -> tcp_read_sock() advances copied_seq by every byte
+ * it appends to the anchor, a complete parsed-ahead record, a partial one
+ * under rmem pressure, or only header bytes, so subtract anchor->len to get
+ * back to the record start. Both the recv path and the setsockopt rekey path
+ * must classify records against the same start, so share this helper.
+ */
+static u32 tls_device_rx_rec_start(struct sock *sk,
+				   struct tls_sw_context_rx *sw_ctx)
+{
+	u32 copied_seq = tcp_sk(sk)->copied_seq;
+
+	if (sw_ctx->strp.copy_mode)
+		return copied_seq - sw_ctx->strp.anchor->len;
+
+	return copied_seq;
+}
+
 int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 {
 	struct tls_offload_context_rx *ctx = tls_offload_ctx_rx(tls_ctx);
@@ -1165,6 +1371,7 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 	struct sk_buff *skb = tls_strp_msg(sw_ctx);
 	struct strp_msg *rxm = strp_msg(skb);
 	int is_decrypted, is_encrypted;
+	u32 rec_start_seq;
 
 	if (!tls_strp_msg_mixed_decrypted(sw_ctx)) {
 		is_decrypted = skb->decrypted;
@@ -1174,10 +1381,72 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 		is_encrypted = 0;
 	}
 
-	trace_tls_device_decrypted(sk, tcp_sk(sk)->copied_seq - rxm->full_len,
+	rec_start_seq = tls_device_rx_rec_start(sk, sw_ctx);
+
+	trace_tls_device_decrypted(sk, rec_start_seq,
 				   tls_ctx->rx.rec_seq, rxm->full_len,
 				   is_encrypted, is_decrypted);
 
+	if (unlikely(ctx->rekey.old_aead_recv)) {
+		bool nic_touched = !is_encrypted || skb->decrypt_failed;
+		bool before_nic_boundary;
+
+		/* old_nic_boundary is the TCP stack's view at setsockopt time
+		 * (rcv_nxt plus the out-of-order tail), not the NIC's last
+		 * transformed byte. A segment the NIC transformed with the old
+		 * key before tls_dev_del returned can still be in the RQ/CQ, in
+		 * a GRO list or in the socket backlog when that snapshot is
+		 * taken and reach TCP later, above it. While old_aead_recv is
+		 * held the NIC has no RX context for this socket at all: the
+		 * old one was deleted before old_aead_recv was set and the new
+		 * one is only installed once it is freed below. So a NIC mark
+		 * seen here can only be the old key's transform, wherever the
+		 * record sits relative to the snapshot. Slide the boundary out
+		 * over such a record instead of retiring the old key on it; the
+		 * old key is retired only on a record the NIC never saw.
+		 */
+		if (nic_touched &&
+		    !before(rec_start_seq, ctx->rekey.old_nic_boundary))
+			ctx->rekey.old_nic_boundary = rec_start_seq + rxm->full_len;
+
+		before_nic_boundary =
+			before(rec_start_seq, ctx->rekey.old_nic_boundary);
+
+		if (before_nic_boundary) {
+			/* Non-mixed (skb->decrypted clear) is untouched wire
+			 * ciphertext even if skb->decrypt_failed is set, so advance
+			 * old_rec_seq and let the SW AEAD decrypt it directly.
+			 * old_rec_seq tracks the stream's record number, which the
+			 * NIC also advances for records it did not transform, so
+			 * keeping it in step lets a later NIC-touched record be undone
+			 * with the right nonce. A mixed record carries NIC-XORed frags
+			 * (skb->decrypt_failed or skb->decrypted) and takes the
+			 * old-key reencrypt path below, which undoes the transform per
+			 * frag before the SW AEAD decrypts.
+			 */
+			if (is_encrypted) {
+				tls_bigint_increment(ctx->rekey.old_rec_seq,
+						     tls_ctx->prot_info.rec_seq_size);
+				return 0;
+			}
+
+			return tls_device_reencrypt_old_key(sk, ctx,
+							    sw_ctx, tls_ctx);
+		}
+
+		crypto_free_aead(ctx->rekey.old_aead_recv);
+		ctx->rekey.old_aead_recv = NULL;
+
+		/* Anchor the NIC on the start of this first post-boundary
+		 * record. rec_start_seq already accounts for copy_mode, where
+		 * copied_seq has advanced past the record end; using it keeps
+		 * the (TCP seq, record number) pair consistent in both modes.
+		 */
+		if (ctx->dev_add_pending)
+			tls_device_deferred_dev_add_rx(sk, tls_ctx, ctx,
+						       rec_start_seq);
+	}
+
 	if (unlikely(test_bit(TLS_RX_DEV_DEGRADED, &tls_ctx->flags))) {
 		if (likely(is_encrypted || is_decrypted))
 			return is_decrypted;
@@ -1804,73 +2073,224 @@ int tls_set_device_offload(struct sock *sk,
 	return rc;
 }
 
-int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
+int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
+			      struct tls_crypto_info *new_crypto_info)
 {
-	struct tls12_crypto_info_aes_gcm_128 *info;
+	struct tls_crypto_info *crypto_info, *src_crypto_info;
+	const struct tls_cipher_desc *cipher_desc;
+	u32 drain_start = tcp_sk(sk)->copied_seq;
 	struct tls_offload_context_rx *context;
 	struct net_device *netdev;
+	bool was_dev_add_pending;
+	bool moved_aead_recv = false;
+	bool retired_pending = false;
+	bool put_netdev = false;
 	int rc = 0;
 
-	/* A rekey (setsockopt on an already-configured socket) is not
-	 * supported on the device offload path yet; reject it here so the
-	 * caller can decide (propagate the error for a HW connection, or
-	 * re-init software crypto for a SW one). KeyUpdate support replaces
-	 * this guard with real rekey handling.
-	 */
-	if (ctx->rx_conf != TLS_BASE)
-		return -EOPNOTSUPP;
+	/* A rekey of a SW-offloaded socket belongs to tls_set_sw_offload(). */
+	if (new_crypto_info && ctx->rx_conf != TLS_HW)
+		return -EINVAL;
 
-	netdev = get_netdev_for_sock(sk);
-	if (!netdev) {
-		pr_err_ratelimited("%s: netdev not found\n", __func__);
+	crypto_info = &ctx->crypto_recv.info;
+	src_crypto_info = new_crypto_info ?: crypto_info;
+	cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable)
 		return -EINVAL;
-	}
 
-	if (!(netdev->features & NETIF_F_HW_TLS_RX)) {
-		rc = -EOPNOTSUPP;
-		goto release_netdev;
-	}
+	if (new_crypto_info) {
+		/* Rekey targets the device holding the HW RX context, which
+		 * can differ from the socket's route after a route change or
+		 * bond/team failover. Resolve it from ctx->netdev under
+		 * device_offload_lock, like the other del/add-key paths, not
+		 * via get_netdev_for_sock(). The context owns the reference,
+		 * so don't take an extra one here.
+		 *
+		 * A NULL netdev means tls_device_down() already ran: the HW RX
+		 * context is deleted, TLS_RX_DEV_{DEGRADED,CLOSED} are set and
+		 * every record is decrypted in SW, but rx_conf stays TLS_HW.
+		 * The rekey is still required, the peer's KeyUpdate was parsed
+		 * and recvmsg() returns -EKEYEXPIRED until the new key lands,
+		 * so run the same state machine (queued records may still carry
+		 * the deleted NIC context's old-key XOR) and account the new key
+		 * as a SW fallback in place of the tls_dev_del()/tls_dev_add()
+		 * steps, mirroring the TX side (tls_device_complete_rekey()).
+		 * Do not fail the setsockopt.
+		 */
+		down_read(&device_offload_lock);
+		netdev = rcu_dereference_protected(ctx->netdev,
+						   lockdep_is_held(&device_offload_lock));
+	} else {
+		netdev = get_netdev_for_sock(sk);
+		if (!netdev) {
+			pr_err_ratelimited("%s: netdev not found\n", __func__);
+			return -EINVAL;
+		}
+		put_netdev = true;
 
-	/* Avoid offloading if the device is down
-	 * We don't want to offload new flows after
-	 * the NETDEV_DOWN event
-	 *
-	 * device_offload_lock is taken in tls_devices's NETDEV_DOWN
-	 * handler thus protecting from the device going down before
-	 * ctx was added to tls_device_list.
-	 */
-	down_read(&device_offload_lock);
-	if (!(netdev->flags & IFF_UP)) {
-		rc = -EINVAL;
-		goto release_lock;
+		if (!(netdev->features & NETIF_F_HW_TLS_RX)) {
+			rc = -EOPNOTSUPP;
+			goto release_netdev;
+		}
+
+		/* Avoid offloading if the device is down
+		 * We don't want to offload new flows after
+		 * the NETDEV_DOWN event
+		 *
+		 * device_offload_lock is taken in tls_devices's NETDEV_DOWN
+		 * handler thus protecting from the device going down before
+		 * ctx was added to tls_device_list.
+		 */
+		down_read(&device_offload_lock);
+		if (!(netdev->flags & IFF_UP)) {
+			rc = -EINVAL;
+			goto release_lock;
+		}
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
+		/* Classify against the record start, not the raw copied_seq: in
+		 * strparser copy mode tcp_read_sock() has already advanced
+		 * copied_seq past a parsed-ahead (possibly partial) record the
+		 * user has not received, which may still carry the old NIC key's
+		 * XOR. tls_device_decrypted() compensates the same way; keeping
+		 * both in sync is what lets a drained-vs-still-draining decision
+		 * here match the reencrypt-key decision there.
+		 */
+		drain_start = tls_device_rx_rec_start(sk, sw_ctx);
+
+		/* netdev is NULL only after tls_device_down(), which already
+		 * deleted the HW RX context and set TLS_RX_DEV_CLOSED; the
+		 * netdev check just makes that dependency explicit.
+		 */
+		if (netdev && !test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
+			set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
+			synchronize_net();
+			netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
+							TLS_OFFLOAD_CTX_DIR_RX);
+		}
+
+		if (context->rekey.old_aead_recv &&
+		    before(drain_start, context->rekey.old_nic_boundary)) {
+			/* Previous rekey still draining. Keep rekey.old_aead_recv,
+			 * it is the only key that can undo the NIC-XOR on queued
+			 * records. sw_ctx->aead_recv may be re-setkey'd by
+			 * tls_sw_ctx_init(); that intermediate key was never on
+			 * the NIC and its wire era is drained, so it is needed
+			 * for neither undo nor AEAD. Defer dev_add; the new key
+			 * is installed once drain_start crosses rekey.old_nic_boundary.
+			 */
+			context->dev_add_pending = 1;
+		} else {
+			struct tcp_sock *tp = tcp_sk(sk);
+			u32 nic_end;
+
+			if (context->rekey.old_aead_recv) {
+				crypto_free_aead(context->rekey.old_aead_recv);
+				context->rekey.old_aead_recv = NULL;
+			}
+
+			/* Flush the backlog so TCP's view is current, then take the
+			 * highest byte TCP holds, including the out-of-order tail:
+			 * a NIC-transformed segment behind a host-side drop sits
+			 * above rcv_nxt until the retransmit fills the hole and
+			 * must still be classified against the old key. This is
+			 * still only the stack's view, a transformed segment the
+			 * NIC has not delivered yet is caught in-band by
+			 * tls_device_decrypted(), which slides the boundary.
+			 */
+			__sk_flush_backlog(sk);
+			nic_end = tp->rcv_nxt;
+			if (!RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
+			    after(TCP_SKB_CB(tp->ooo_last_skb)->end_seq, nic_end))
+				nic_end = TCP_SKB_CB(tp->ooo_last_skb)->end_seq;
+
+			if (before(drain_start, nic_end)) {
+				context->rekey.old_aead_recv = sw_ctx->aead_recv;
+				/* NULL so tls_sw_ctx_init() allocates a fresh tfm
+				 * for the new key instead of re-keying the one we
+				 * must keep for the drain.
+				 */
+				sw_ctx->aead_recv = NULL;
+				moved_aead_recv = true;
+				memcpy(context->rekey.old_iv, ctx->rx.iv,
+				       sizeof(context->rekey.old_iv));
+				memcpy(context->rekey.old_rec_seq, ctx->rx.rec_seq,
+				       sizeof(context->rekey.old_rec_seq));
+				context->rekey.old_nic_boundary = nic_end;
+				context->dev_add_pending = 1;
+			} else if (was_dev_add_pending) {
+				/* A prior rekey's deferred dev_add can no longer
+				 * run: its trigger (old_aead_recv) was just freed
+				 * above and no new drain replaces it. Its era
+				 * drained successfully (drain_start is already past
+				 * old_nic_boundary), so retire it and let the new
+				 * key install immediately below. retired_pending
+				 * defers its OK/gauge accounting to the post-init
+				 * block, past the error goto, so a failed
+				 * tls_sw_ctx_init() needs no counter undo.
+				 */
+				context->dev_add_pending = 0;
+				retired_pending = true;
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
+		if (retired_pending) {
+			/* Account the superseded rekey that drained OK, mirroring
+			 * the deferred-add path: one RXREKEYOK and release its
+			 * in-flight gauge. The new key's own OK/FALLBACK is counted
+			 * by tls_device_dev_add_rx() just below.
+			 */
+			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXREKEY);
+		}
+		if (netdev) {
+			rc = tls_device_dev_add_rx(sk, ctx, netdev,
+						   src_crypto_info, drain_start,
+						   !!new_crypto_info);
+		} else {
+			/* No device after tls_device_down(); the SW path keeps
+			 * decrypting.
+			 */
+			tls_device_rx_rekey_fallback(sk, ctx);
+		}
+		if (!new_crypto_info) {
+			if (rc)
+				goto free_sw_resources;
+			tls_device_attach(ctx, sk, netdev);
+		}
+	} else if (!was_dev_add_pending) {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXREKEY);
+	} else {
+		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
+	}
+
+	tls_sw_ctx_finalize(sk, 0, new_crypto_info);
 
-	tls_device_attach(ctx, sk, netdev);
-	tls_sw_ctx_finalize(sk, 0, NULL);
 	up_read(&device_offload_lock);
 
-	dev_put(netdev);
+	if (put_netdev)
+		dev_put(netdev);
 
 	return 0;
 
@@ -1879,17 +2299,39 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	tls_sw_free_resources_rx(sk);
 	down_read(&device_offload_lock);
 release_ctx:
-	ctx->priv_ctx_rx = NULL;
+	if (!new_crypto_info) {
+		ctx->priv_ctx_rx = NULL;
+	} else {
+		/* A failed RX rekey is terminal, so there is no HW state to roll
+		 * back to. KeyUpdate is directional and the peer's TX has already
+		 * switched keys, so once the new RX key fails to install the old
+		 * SW key restored below cannot decrypt any further record; the
+		 * socket is dead and the app must close it. The half-torn HW
+		 * context (tls_dev_del already ran) and any dangling
+		 * dev_add_pending / old_aead_recv are reclaimed by
+		 * tls_device_offload_cleanup_rx() on close.
+		 */
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
-	dev_put(netdev);
+	if (put_netdev)
+		dev_put(netdev);
 	return rc;
 }
 
 void tls_device_offload_cleanup_rx(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
+	struct tls_offload_context_rx *rx_ctx;
 	struct net_device *netdev;
 
 	down_read(&device_offload_lock);
@@ -1898,8 +2340,9 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
 	if (!netdev)
 		goto out;
 
-	netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
-					TLS_OFFLOAD_CTX_DIR_RX);
+	if (!test_bit(TLS_RX_DEV_CLOSED, &tls_ctx->flags))
+		netdev->tlsdev_ops->tls_dev_del(netdev, tls_ctx,
+						TLS_OFFLOAD_CTX_DIR_RX);
 
 	if (tls_ctx->tx_conf != TLS_HW) {
 		dev_put(netdev);
@@ -1909,6 +2352,19 @@ void tls_device_offload_cleanup_rx(struct sock *sk)
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
+		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXREKEY);
+	}
+
 	tls_sw_release_resources_rx(sk);
 }
 
@@ -1969,9 +2425,11 @@ static int tls_device_down(struct net_device *netdev)
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
index 3dd3a4ce8209..0a9e7d15fa95 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -361,8 +361,14 @@ static void tls_sk_proto_cleanup(struct sock *sk,
 		tls_sw_release_resources_rx(sk);
 		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
 	} else if (ctx->rx_conf == TLS_HW) {
+		bool rekey_failed = test_bit(TLS_RX_REKEY_FAILED, &ctx->flags);
+
 		tls_device_offload_cleanup_rx(sk);
-		TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
+
+		if (rekey_failed)
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXSW);
+		else
+			TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
 	}
 }
 
@@ -754,7 +760,8 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			conf = TLS_SW;
 		}
 	} else {
-		rc = tls_set_device_offload_rx(sk, ctx);
+		rc = tls_set_device_offload_rx(sk, ctx,
+					       update ? crypto_info : NULL);
 		conf = TLS_HW;
 		if (!rc) {
 			if (!update) {
diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index 4bb1e3727e28..6255f7b07eb7 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -28,8 +28,11 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
 	SNMP_MIB_ITEM("TlsTxRekeyFallback", LINUX_MIB_TLSTXREKEYFALLBACK),
+	SNMP_MIB_ITEM("TlsRxRekeyFallback", LINUX_MIB_TLSRXREKEYFALLBACK),
 	SNMP_MIB_ITEM("TlsCurrTxRekey", LINUX_MIB_TLSCURRTXREKEY),
+	SNMP_MIB_ITEM("TlsCurrRxRekey", LINUX_MIB_TLSCURRRXREKEY),
 	SNMP_MIB_ITEM("TlsTxRekeyAborted", LINUX_MIB_TLSTXREKEYABORTED),
+	SNMP_MIB_ITEM("TlsRxRekeyAborted", LINUX_MIB_TLSRXREKEYABORTED),
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fd162d8f1d64..d546091dd524 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1561,6 +1561,7 @@ static int tls_check_pending_rekey(struct sock *sk, struct tls_context *ctx,
 	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
 		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
 
+		tls_device_rx_del_key(sk, ctx);
 		WRITE_ONCE(rx_ctx->key_update_pending, true);
 		TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYRECEIVED);
 	}
-- 
2.50.1

