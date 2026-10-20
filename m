Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498377;
	b=eLgBpmPkdzaeugzpb13X/2C2/q9QJq0hNZ7L/zNClATYZMxP3lekBcWcrN9NcXY/KlTl
	 bXkpCY4+4v15SsV6+DwYLY5pCI7AB363k11YZzHHJ6hYjMY6vPpdR9L8fVq3rpIBycxqH
	 r92Nzk9coN4EqI9GY8hOLJqY9j0/Lv9KBKo4jSL8IPLJCHoMZsBaYEDbq5ztOeVsmPKgW
	 2+5zfDWCFtATL0sQUg6qeZnpcBOFvKJtSCqtgjAOp6Ossun7joSrRt81yiTaPoc0ljl6r
	 9dbZ/+ViafKjKdDo2BpqDunrDmxAlbEy7KXmdwUWHfVh+W8G7N9nGrmbRyCepFN99GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498377;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+3aP9S+I4hN8ayAzr2FdVXGfcpVuzHhgRmKY7lrV5LU=;
	b=tk6F52N8CpkeSO2XZO6MZsfmNwyCt3kkCVejyJOHR7lM2Tsnbq1+pjWCZ5FXdOdy5LNv
	 U4l+hiEwfS2gcJu56PW1N8ExktR34Wf5TwwAx4m62AhEmesGTdGB5NnIw+IGI2wMUA2Ya
	 SaRvdP6vTrLmLr4FiiaojYu2nCLDjaAbjia76XcnLMk89VboclNCzXWAG5/OvhT7jDGoJ
	 CHAwCunQ4Un7GW7Ve6MmJ9gvzYIMUi/SJf/9xJ7SQOy74ZgELT+cj5rcTxS6um993BBct
	 2phgjAtVvQiKXodPOMSQyotWw2vC8CgPkTgQskSsM9bYKuvhxcnQ6FTAGzJ+3N3TRKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q9KMvSBE;
	arc=none smtp.remote-ip=95.215.58.242
Received: from mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08542606A31F
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08542606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=q9KMvSBE
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pHt6jSjv0iNign9HC3Cohxdp/lbHFVpVVhQ1kwkIEhI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792498374; v=1; x=1793103174;
 b=q9KMvSBEXRZHEK7AmP+Eif3Mgy+vhxvZyI3cUHdSMzwUHcO4qE8bE+CfIe66VaLGQdYy0Dxm
 WIo5Il2/9bQn+o4baJa3+fguXruOvYOMx0B/Ruj0jZO5nfUH+vje3qV6wrH26Bmo+ITI94HQtyh
 Z412TWwJm+E6cBRxokIjMPII=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c323d3c4687816b9;
	Tue, 20 Oct 2026 12:12:54 +0000
X-Mizu-Trace-ID: c323d3c4687816b9
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	sd@queasysnail.net
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] tls: fix the open record check in the max payload size setsockopt
Date: Tue, 20 Oct 2026 20:12:39 +0800
Message-ID: <20261020121240.29082-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_tls_setsockopt_tx_payload_len() refuses to resize records while one is
open, but the check is broken in two ways.

It reaches for the open record through tls_sw_ctx_tx(), an unchecked cast
of ctx->priv_ctx_tx.  Under device offload that pointer is a
tls_offload_context_tx, so the check reads a field of the wrong struct: it
returns EBUSY on whatever happens to be there, and never sees the record
that really is open.  Dispatch on tx_conf.

The socket lock alone is also not enough to tell no sender is in flight.
The device tx path drops it in sk_stream_wait_memory() after
tls_push_record() cleared open_record, so setsockopt can slip in
mid-sendmsg and shrink the limit.  tls_push_data() latches the limit once
per call, and a record left open by MSG_MORE can then be bigger than the
new limit, making the u32 subtraction in the copy clamp wrap around and
build an oversized record.  Take tx_lock like the sendmsg paths do so
setsockopt waits for in-flight senders.  Re-reading the limit inside the
tls_push_data() loop could close the wrap too, but a parked sender would
still finish with the old limit, so serializing on tx_lock is simpler.

Take tx_lock interruptible, as tls_sw_sendmsg() does.  Both sendmsg paths
keep it across sk_stream_wait_memory(), which sleeps until the peer reads,
so a plain mutex_lock() could park setsockopt in D state for as long as
the sender waits.  The lock_sock() after it is fine uninterruptible: a
sender sleeping for memory has released the socket lock, so that wait only
covers short critical sections, like every other setsockopt.

Fixes: 82cb5be6ad64 ("net/tls: support setting the maximum payload size")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2 -> v3:
  - no code change, explain why tx_lock is taken interruptible, in the
    commit message and the comment (Paolo)
  - resend, v2 was marked "changes requested" in patchwork, thanks to
    Sabrina for the reminder:
    https://lore.kernel.org/netdev/atdJUP6Jb0jODBYE@krikkit/
v2: https://lore.kernel.org/all/20260901072927.128688-1-jiayuan.chen@linux.dev/
v1 -> v2:
  - also take tx_lock in setsockopt, the socket lock alone can't stop a
    device sender parked in sk_stream_wait_memory() (AI review on v1)
v1: https://lore.kernel.org/netdev/20260831025607.62927-1-jiayuan.chen@linux.dev/

base on my netdevsim + tls (in progress)
https://lore.kernel.org/netdev/20260728125658.390500-1-jiayuan.chen@linux.dev/

Previous finding:
b17cf742eaad ("tls: device: fix out-of-bounds write in tls_append_frag()")
---
 net/tls/tls_main.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 8bdb78718a8d..42ab291eee42 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -831,15 +831,29 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
 	return rc;
 }
 
+/* priv_ctx_tx holds a different structure on each TX path, so tx_conf has to
+ * say which open record to look at.
+ */
+static bool tls_tx_record_is_open(struct tls_context *ctx)
+{
+	switch (ctx->tx_conf) {
+	case TLS_SW:
+		return !!tls_sw_ctx_tx(ctx)->open_rec;
+	case TLS_HW:
+		return !!tls_offload_ctx_tx(ctx)->open_record;
+	default:
+		return false;
+	}
+}
+
 static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
 					    unsigned int optlen)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
-	struct tls_sw_context_tx *sw_ctx = tls_sw_ctx_tx(ctx);
 	u16 value;
 	bool tls_13 = ctx->prot_info.version == TLS_1_3_VERSION;
 
-	if (sw_ctx && sw_ctx->open_rec)
+	if (tls_tx_record_is_open(ctx))
 		return -EBUSY;
 
 	if (sockptr_is_null(optval) || optlen != sizeof(value))
@@ -860,6 +874,7 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
+	struct tls_context *ctx;
 	int rc = 0;
 
 	switch (optname) {
@@ -879,9 +894,18 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
 		break;
 	case TLS_TX_MAX_PAYLOAD_LEN:
+		/* Take tx_lock like the sendmsg paths do, the socket lock is
+		 * dropped while a sender waits for memory, maybe with no record
+		 * open.  Senders sleep with tx_lock held, so take it interruptible.
+		 */
+		ctx = tls_get_ctx(sk);
+		rc = mutex_lock_interruptible(&ctx->tx_lock);
+		if (rc)
+			break;
 		lock_sock(sk);
 		rc = do_tls_setsockopt_tx_payload_len(sk, optval, optlen);
 		release_sock(sk);
+		mutex_unlock(&ctx->tx_lock);
 		break;
 	default:
 		rc = -ENOPROTOOPT;
-- 
2.43.0

