Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5344A33F6
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685142; cv=none; b=PsPpx/qAFqwfbr8HKzEKlv9k2YgV9RqFQemGApEvBKNTJd3IInEbrtK/ZL9nLZxACkKzXJsN6IlahqGdtwDn7qyWCh2lVUmHf+hVGrRoxu8WFFa6VJ489JWTg29wANYhgbLOpDgDnidZ1gpAECcJ4t0y0l/72pzOXWKvKX7fbWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685142; c=relaxed/simple;
	bh=zzRo565KQ7+wLrCBU86/yHtYwUloqXK7QvurHoZ+wTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN6Gap5aEA0BJzfCnEsTsAgLferIGYcfeb17n3Mzbl0jgttTLLRnrrTEyDMJw7sc59YuyurYJI+Vh7hM0UvIZcoEISKF9OxVKES4jdwe4O7MLqv5jVt3Ka++KTtghiM4GAfuWjygjo92PKlUprkudAc65tYZsjOq38SoQIAGY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FG8Cci4J; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FG8Cci4J"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4693691fc81so119507fac.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685138; x=1790289938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOOiiBZ4P4FBgvVdSz/6BojdFn7u/ToWn57MgqQCV3Y=;
        b=FG8Cci4JfwwRiBGzGzDTZ8US/jQ1BH2/gMsKwaZq8hG6H7vrI7RA9nJ+vzmtLdNXr1
         48Na+BMQm8ivr4toYwOO+LGlPbA0JlrnyoZ1WHrkbX9gJYE2jkZ9sUZ0jDweFg0Zsb1d
         f5s5NjsZcEuFQZ6Jo8C0EN4yETQjIvZ9ziNtXK9VsNW0wvApJz+YsOu5zpcWsGbajhPH
         cz/NXx81sqM6iodjRbpjDj/uziBARIHffr8c4l+yZtpl3NyaMLBD6FjSXkDHLC2RGiLX
         7DzvoIJ+61Gb5+6/7XH1uPfjLi6G9aIWeFHqgIXMeynjuZN0DHxTKhWHNBXkhFkdbPwN
         lozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685138; x=1790289938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOOiiBZ4P4FBgvVdSz/6BojdFn7u/ToWn57MgqQCV3Y=;
        b=j9L1E45kDgjq3OnfaJ/E0CoFu5yXAekNmNT9FqZmHF5SlDEmDE5SGIjtlkd9BZbPOS
         O2qi924r2/FVF4ktsaVOlke3d1IXuhY9qnBJjwOa6b1EEDFzOT1YfcczIijKTHsWKVmg
         5U6nQGg+ZHUjeN2hXztcq2koNCqVpSqXby1dmTwoNJfcmL0YQn5o9cyXaoFv49Y/HkMG
         cCsu4OILtUviwz5ySq49L5YGsPVgquxtawY74UIm3t47ANNG5AYw2b57eTU5ZS+UXqU3
         cr463k9ilvurQvA5dLHiVIw8Za/TBnJYX+wh7Fg8Osb0TR5Qd7lnKHUnAdj929XIM8vC
         wNHA==
X-Gm-Message-State: AFuF++mmauV9hKhkZ1ZXeMNs4wHmnhi4JES+8Ialfapu4VAICuBoXsxb
	AZnz2qmHByGx26JlZcCmC6i0Rg+FMkX1XvDtuZBY3IgWTHDtlmV0UbMvIxUwNE7oOWaliRi4T91
	NWTB5gSOYOZrHlWC7M2EAm/VPyqUk+oo4eLGdQYquWQ164eMMEfap+XUTLJtdgaBerYS2I720MV
	GVPDfTX2jVsEi5av74BV32/d4VgxOouA275vH/od10F7rcwXo=
X-Gm-Gg: AYBFou3DnBBYySQFBTWcM86an48jgsVIjd7Oj1wZ1HI9D7plyZ3fIEYF1rfCzClQHh+
	zL5CKWPPKbjzE3+mYBUX32AXFsPJSXdNldiiCku8/vYDobquKIwwrQwn3pnFxEJW4LIaCMgbnfE
	BqI2hxG312pTaLHFxqHjRjUSW0OTj3LxkGuMjGxtlSc3x/aLUPWDhuOKeS7jCRK/DCjTFA1HUP0
	F+yaf93B91HlcnQQ86Hk2vz3LIyZ2tkdLbbnjiTjGomBqQIewqkaIWCgcfta8Ig8KdUccQM0iI6
	PqO5iUbYUQmfAvhDRrQR7BI+hqOmm8VmmkIl3ugf4QOjcd35HkcoKsMV1IaZG18UWfTbRqaTeni
	+gTyWQ5RjFZeQee460bKjyb1hXA2P/ZSjcZ+qhADWr4fet/BqBiECRjGGjk7hQDj+QRqzQgydNb
	sB9f3i/2wI+OdVjmTsSMdaxAoJrKDs/94SDCFXA57tgpN6rGGNfkDEwPB4756FEVMHYQMTnBw9l
	dGR+vSNTIWIIIbl71PHnkdeXGv7LTaCSOPzSrFlk/c5AkvUcYR+blsqlqPg/e+Nc03xr0yUJ5/I
	9LI5Z8gGCE9+qFFBAHd8NXjq/E8+K9pJLnRya82TyJgtTS14+fgq4cdSqfBmEV8v+lM//V6FtZ0
	asAhpZZiYxd0WEN7DZg==
X-Received: by 2002:a05:6870:4409:b0:475:a1ec:9622 with SMTP id 586e51a60fabf-486e79508cfmr591011fac.36.1789685138106;
        Thu, 17 Sep 2026 15:45:38 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:37 -0700 (PDT)
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
Subject: [PATCH net-next v17 13/15] tls: device: add tracepoints for the KeyUpdate path
Date: Thu, 17 Sep 2026 16:35:24 -0600
Message-ID: <20260917224355.2288021-14-rjethwani@purestorage.com>
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

Add five trace events covering the rekey state machine in
tls_device.c:

  tls_device_rekey_start: rekey accepted, inflight=1 marks a
                          drain window where old-key data is still
                          queued and dev_add is deferred, whether
                          this rekey opened the window or landed
                          behind a still-draining prior one.
                          inflight=0 means the key was hot-swapped
                          with no drain; nic_boundary is then the
                          candidate receive frontier, not a stored
                          boundary.
  tls_device_rekey_reencrypt: old-key undo pass for a boundary
                              record
  tls_device_rekey_done: a drain window's boundary was crossed and
                         old_aead_recv freed, either by a record
                         arriving past old_nic_boundary or by a new
                         rekey superseding a prior one whose era had
                         already drained. deferred dev_add is issued
                         if pending.
  tls_device_complete_rekey_retry: TX rekey completion hit the
                                   transient -EAGAIN retry in sendmsg,
                                   the next sendmsg retries.
  tls_device_complete_rekey_fail: TX rekey completion gave up and
                                  fell back to SW encryption. Emitted
                                  from the fallback path itself, since
                                  the sendmsg call site only sees the
                                  transient retry.

These are independent event markers, not a paired begin/end span. A
rekey_start is not 1:1 with a rekey_done: a rekey that lands behind a
still-draining prior one reports inflight=1 without opening a window of
its own, so several starts can map to a single window and a single done.
The invariant is per-window - each drain window that is opened closes
with exactly one rekey_done. A window can also be abandoned without a
done when a rekey is aborted (tls_sw_ctx_init() failing after the window
opened, or the socket being torn down mid-drain, the latter counted by
TLSRXREKEYABORTED); those paths are not traced.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_device.c |  36 ++++++++++++-
 net/tls/trace.h      | 118 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index ac09f356cff9..5f45c097bad3 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -866,8 +866,16 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	lock_sock(sk);
 
 	/* Old-key records all ACKed; switch back to HW. */
-	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
-		tls_device_complete_rekey(sk, tls_ctx, true, msg->msg_flags);
+	if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags)) {
+		rc = tls_device_complete_rekey(sk, tls_ctx, true, msg->msg_flags);
+		/* Non-zero here is the transient -EAGAIN retry,
+		 * the next sendmsg retries. Hard failures return 0 after
+		 * falling back to SW and emit tls_device_complete_rekey_fail
+		 * from the fallback path.
+		 */
+		if (rc)
+			trace_tls_device_complete_rekey_retry(sk);
+	}
 
 	if (tls_device_tx_uses_sw(tls_ctx)) {
 		rc = tls_sw_sendmsg_locked(sk, msg, size);
@@ -1430,10 +1438,15 @@ int tls_device_decrypted(struct sock *sk, struct tls_context *tls_ctx)
 				return 0;
 			}
 
+			trace_tls_device_rekey_reencrypt(sk, rec_start_seq,
+							 ctx->rekey.old_nic_boundary);
+
 			return tls_device_reencrypt_old_key(sk, ctx,
 							    sw_ctx, tls_ctx);
 		}
 
+		trace_tls_device_rekey_done(sk, rec_start_seq,
+					    ctx->rekey.old_nic_boundary);
 		crypto_free_aead(ctx->rekey.old_aead_recv);
 		ctx->rekey.old_aead_recv = NULL;
 
@@ -1890,6 +1903,13 @@ static int tls_device_complete_rekey(struct sock *sk, struct tls_context *ctx,
 	TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 	TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXSW);
 
+	/* Hard failure: HW rekey gave up and the connection is now pinned to
+	 * SW encryption. The call site only sees the transient -EAGAIN retry
+	 * (rc is not propagated here), so emit the trace from the fallback
+	 * path itself; rc still holds the originating error.
+	 */
+	trace_tls_device_complete_rekey_fail(sk, rc);
+
 	return 0;
 }
 
@@ -2195,11 +2215,21 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
 			 * is installed once drain_start crosses rekey.old_nic_boundary.
 			 */
 			context->dev_add_pending = 1;
+			trace_tls_device_rekey_start(sk, drain_start,
+						     context->rekey.old_nic_boundary,
+						     true);
 		} else {
 			struct tcp_sock *tp = tcp_sk(sk);
 			u32 nic_end;
 
 			if (context->rekey.old_aead_recv) {
+				/* Prior rekey's era already drained (drain_start is
+				 * past old_nic_boundary), so retiring its key here
+				 * is a boundary crossing, same as the free in
+				 * tls_device_decrypted(); mark it done.
+				 */
+				trace_tls_device_rekey_done(sk, drain_start,
+							    context->rekey.old_nic_boundary);
 				crypto_free_aead(context->rekey.old_aead_recv);
 				context->rekey.old_aead_recv = NULL;
 			}
@@ -2247,6 +2277,8 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx,
 				context->dev_add_pending = 0;
 				retired_pending = true;
 			}
+			trace_tls_device_rekey_start(sk, drain_start, nic_end,
+						     before(drain_start, nic_end));
 		}
 	}
 
diff --git a/net/tls/trace.h b/net/tls/trace.h
index 2d8ce4ff3265..5b9c1f86d82d 100644
--- a/net/tls/trace.h
+++ b/net/tls/trace.h
@@ -192,6 +192,124 @@ TRACE_EVENT(tls_device_tx_resync_send,
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
+TRACE_EVENT(tls_device_complete_rekey_retry,
+
+	TP_PROTO(struct sock *sk),
+
+	TP_ARGS(sk),
+
+	TP_STRUCT__entry(
+		__field(	struct sock *,	sk	)
+	),
+
+	TP_fast_assign(
+		__entry->sk = sk;
+	),
+
+	TP_printk(
+		"sk=%p",
+		__entry->sk
+	)
+);
+
 #endif /* _TLS_TRACE_H_ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.50.1

