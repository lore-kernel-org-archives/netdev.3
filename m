Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4D37B40A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128059; cv=none; b=Z1+ezdY4gSQjgUkAwWiEcgQT6TfMoQqHxsKwCJ3lCHaDAX94ta0daPt80xl+m+pQAPSSZtiOf3EzEe/VUagZ8bW753KKEdkI7y9byMzG86Zbw+ilXp9lP+dkHjKnTaSkfu9be9d3MW+OQugyFKRrzplVZ5BYkejTUAuekYoxXAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128059; c=relaxed/simple;
	bh=tvJHCYcaC1UDKFc4rb4PuFn2AkLDyDZ9ZdYj09XA1Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMBrajHOarnkpX9qumnQY60vUvFpL97VJdZ39gIUYw22eL/htxHyPN6AME5C6wnIbLXWx/q/S1dzKW3sARrUnt6hwRHFADCcPCH+AOzEb5qsMxiN0j2K7dS3dIlpJYAztrN3Blp0z2eOZpwg8PN7IUuNP0XbcfAl10VATsBPM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KvvT7BLp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KvvT7BLp"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954d29264cso19679185e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 11:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786128055; x=1786732855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/u9jRWXQlLgc8NyNPzvH/dtj/AGe136pELuWGmdhFM=;
        b=KvvT7BLpH/MuQDHYxIPJicpE1c5qEO4fQdJL1zWyLPRHdT6P4ao2tA5f0yhjYVcxHc
         yh9Kb7g/4D53Hofwyk5H3zW1XFNmCzrYGHqJ1s2ghiFeJU64aAne5G/JEAthD8lhj/aB
         GSBINOC9a+JE4cFxrdei29YW2QSNJY3Q3FGVX8m6GhYpB6wypT/TvP2ft/q2+C2fW35x
         nGsIjAwwRmxf8XH1LCwMWuaSFE5QVNi+tTeumRil9K6Qh/LS8YS7l7bJYVFvqwvwNrqU
         99AvNZHexpdw21ScyYtpYb/72tadnNzGgT1i8VlLuCUAITmqDuNUP0E4QyshLtL7AO84
         zHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786128055; x=1786732855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/u9jRWXQlLgc8NyNPzvH/dtj/AGe136pELuWGmdhFM=;
        b=Oef5RXPN7POj2FXpG4VRQan9EA+W80fbQP8ThBsBt0LW0NR2ztkpHVMJDarKC4mf7p
         UUNM63bFj9ubvfAZlWhvA3K7WuSM6kqkzrhPPRPzbctpwpEQHKGKuz9mtwZt6+42TwVD
         LlXp9L+5R/h9DJwVNkV7DrI4Jh/ul9++WbXLlw0s7nbuZMWpQp3WLer0Xzhx5b+tlY3Q
         KzjQrZzs8vxLLR/6y911B+pdUezrrjwhg06JfInrf4hQbxwNh5APYwXqC8D+29rQqJc0
         NK0GrvKCYdlJaPQX+uRyV4mSsglTa/hvCwHYreaf3JRGbPmiVIsqMP/9TO9J92wHVkKa
         yarQ==
X-Gm-Message-State: AOJu0Yx6xavyJeApFaqyoqIo0xsc1quCx+JlqDGoaTjOfmNrL1wdt6XE
	UgbHbCyF3zzMXnHesHGiOqjzWDa5DTWuzsUrQgB66xTQujjt40FkZbCzku69nsRzInJ+nJR4xok
	aNzRIMWyWEK7MlEGZqCBQJaYm17U1cV1oxtHCjUekJTWU5JYkuQcwGEVo421d8QHJxYc2AS+R8S
	FAZOzcPc42+M3CDBSmroeMmtHkFj+HBqstCZgeVeR78cemQxI=
X-Gm-Gg: AR+sD11uEQt+W+/t6qwtLR2iuU1lsvZVIQ9JquhP4n+qeQ3rIWDQu0t/Y9uz3jwd4/T
	q7+o6p7hZFuUAspqBFjTLsK2dvYdAwBNwwycemiRmQ4FAHbDFnc/EIlchdWv+rmzlSox1hIgUqw
	Vs78A7gjWNLy3IJfDPzFklhwQp8FEY9uyoYMWYNX/1wGLnbsPdR0hQqUcNfKxk9ghm/GOoX4kfQ
	fvFma8mhy1qy5fxpa0YSDQANWaI0ba1YvYVuoY7RDiVey9xTieOdc76NKIQQMV8bMQobBX2afCV
	g4UY8x8FQ5gMNIk4MYQQbm2Pf+NA2C9qnpTZFKv8FxECluyZTQLRXpJZ+ZFULPbMRAz/qO0WwLQ
	PwT948B3CPeXGYpCywHv/xeolZLHPpxBcxEFe9OJuSXB6sUnVRcSgDpETF6+oGdFd92VNYfgh1Z
	54lP5zgofd7ElhSuJ22hbQQllQGfzEEVLEwBgAO2o51FLjoZ9Hbec0Rs8/G6hkHM3V6ekmQUplw
	GYb2qmkXEjsQq7NrWYEePXR+YR7NoXVUAdc3s+USkaF9lQDH7Ic8GQwLnhLUx4fMEh8jVtu3sgu
	LYEm2bwcbtu16NRbB57lLxdJ4TTZ8XC53rRjf3UZqlxK8CqN4o9BLTsNB8DKfYcQtrGqQ7nmT1M
	llkFVJ5S2hC7n1ssL3w==
X-Received: by 2002:a05:600c:474a:b0:496:c361:fb96 with SMTP id 5b1f17b1804b1-4994e6db5aemr298411675e9.0.1786128055442;
        Fri, 07 Aug 2026 11:40:55 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm166106135e9.0.2026.08.07.11.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:40:55 -0700 (PDT)
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
Subject: [PATCH v16 09/10] tls: device: add tracepoints for the KeyUpdate path
Date: Fri,  7 Aug 2026 12:38:52 -0600
Message-Id: <20260807183853.2288959-10-rjethwani@purestorage.com>
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

Add four trace events covering the rekey state machine in
tls_device.c:

  tls_device_rekey_start         - rekey accepted; inflight=1 means old-key
                                   data is still queued, dev_add deferred
  tls_device_rekey_reencrypt     - old-key undo pass for a boundary record
  tls_device_rekey_done          - boundary crossed, old_aead_recv freed,
                                   deferred dev_add issued if pending
  tls_device_complete_rekey_fail - TX rekey completion failed in sendmsg;
                                   READY is left set and the next sendmsg
                                   retries

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c | 17 +++++++-
 net/tls/trace.h      | 98 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index c34268cd9531..9a4c121dbebb 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -760,8 +760,14 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	lock_sock(sk);
 
 	/* Old-key records all ACKed; switch back to HW. */
-	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
-		tls_device_complete_rekey(sk, tls_ctx, true);
+	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags)) {
+		rc = tls_device_complete_rekey(sk, tls_ctx, true);
+		/* On failure the READY bit is left set; the next sendmsg
+		 * retries.
+		 */
+		if (rc)
+			trace_tls_device_complete_rekey_fail(sk, rc);
+	}
 
 	/* Use SW path if rekey is in progress (PENDING) or if HW rekey
 	 * failed (FAILED).
@@ -1267,6 +1273,9 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 				return 0;
 			}
 
+			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
+							 ctx->rekey.old_nic_boundary);
+
 			/* rekey_fixup sets decrypted flags in case the NIC clears
 			 * decrypted flags on auth failure
 			 */
@@ -1277,6 +1286,8 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 							    sw_ctx, tls_ctx);
 		}
 
+		trace_tls_device_rekey_done(sk, rec_start_seq,
+					    ctx->rekey.old_nic_boundary);
 		crypto_free_aead(ctx->rekey.old_aead_recv);
 		ctx->rekey.old_aead_recv = NULL;
 
@@ -1923,6 +1934,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
 					netdev->tlsdev_ops->tls_dev_rx_rekey_fixup;
 				context->dev_add_pending = 1;
 			}
+			trace_tls_device_rekey_start(sk, copied_seq, rcv_nxt,
+						     before(copied_seq, rcv_nxt));
 		}
 	}
 
diff --git a/net/tls/trace.h b/net/tls/trace.h
index 2d8ce4ff3265..2a90b77d75e8 100644
--- a/net/tls/trace.h
+++ b/net/tls/trace.h
@@ -192,6 +192,104 @@ TRACE_EVENT(tls_device_tx_resync_send,
 	)
 );
 
+TRACE_EVENT(tls_device_rekey_start,
+
+	TP_PROTO(struct sock *sk, u32 copied_seq, u32 nic_boundary,
+		 bool inflight),
+
+	TP_ARGS(sk, copied_seq, nic_boundary, inflight),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		copied_seq	)
+		__field(	u32,		nic_boundary	)
+		__field(	bool,		inflight	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->copied_seq = copied_seq;
+		__entry->nic_boundary = nic_boundary;
+		__entry->inflight = inflight;
+	),
+
+	TP_printk(
+		"sk=%p copied_seq=%u nic_boundary=%u inflight=%d",
+		__entry->sk, __entry->copied_seq, __entry->nic_boundary,
+		__entry->inflight
+	)
+);
+
+TRACE_EVENT(tls_device_rekey_reencrypt,
+
+	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary),
+
+	TP_ARGS(sk, tcp_seq, nic_boundary),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		tcp_seq		)
+		__field(	u32,		nic_boundary	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->tcp_seq = tcp_seq;
+		__entry->nic_boundary = nic_boundary;
+	),
+
+	TP_printk(
+		"sk=%p tcp_seq=%u nic_boundary=%u",
+		__entry->sk, __entry->tcp_seq, __entry->nic_boundary
+	)
+);
+
+TRACE_EVENT(tls_device_rekey_done,
+
+	TP_PROTO(struct sock *sk, u32 tcp_seq, u32 nic_boundary),
+
+	TP_ARGS(sk, tcp_seq, nic_boundary),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk		)
+		__field(	u32,		tcp_seq		)
+		__field(	u32,		nic_boundary	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->tcp_seq = tcp_seq;
+		__entry->nic_boundary = nic_boundary;
+	),
+
+	TP_printk(
+		"sk=%p tcp_seq=%u nic_boundary=%u",
+		__entry->sk, __entry->tcp_seq, __entry->nic_boundary
+	)
+);
+
+TRACE_EVENT(tls_device_complete_rekey_fail,
+
+	TP_PROTO(struct sock *sk, int rc),
+
+	TP_ARGS(sk, rc),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk	)
+		__field(	int,		rc	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+		__entry->rc = rc;
+	),
+
+	TP_printk(
+		"sk=%p rc=%d",
+		__entry->sk, __entry->rc
+	)
+);
+
 #endif /* _TLS_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1

