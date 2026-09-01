Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1345D5D9
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247785; cv=none; b=qv4LLm4MfQ68lfhEAIh8B/yV474AqsHP2FyGJ3lJe0xypSr8BL2PH0y+u7QHF8/aYoJVxJ6OP4A5bOK/5VOo5SUvRcyy2/pHmaDJgC1yppK+mM6KdmQ8AqsjQW1lG6DVyyFObOFQZxWBpZYEJK2NK1bjIF9hliwrCSAgwWQ+jVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247785; c=relaxed/simple;
	bh=i1xoBqdCaWtGTV0cIIyem6V7efWtFcemLh92s2fwpYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZOolzPWCFXHXzn3wra1ty4yo/1appxBVnYoekZ/ILNE82+bRhOFR98UTJI7OpGSPtG+x6BsRnez4RlGUAaifU6ItcBCp/4eydUXeY0cdJRUbfpDMwTOwk00KH5ltSrrlu+J3hquWUHpFHRtPXabctj7g0F2cML4mQkeOdNmm/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jS4/WqQ4; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jS4/WqQ4"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i1xoBqdCaWtGTV0cIIyem6V7efWtFcemLh92s2fwpYM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788247780; v=1; x=1788852580;
 b=jS4/WqQ46DDYmrAfFjt4XJZtjnEzC0xMRXlAAm/3KjjzKawCHuzE34de3GyYM5r92TFxe9H8
 69L+15URtp76AXpucnHarSHcHj1eY/9ADKXUDaiQUlO0KBWuBaZLYrBWVCA7Z972+noypfMkqBc
 aoxkDJCKgUCSnvybBd1Q6MsE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c873ab9b9223b804;
	Tue, 01 Sep 2026 07:29:40 +0000
X-Mizu-Trace-ID: c873ab9b9223b804
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] tls: fix the open record check in the max payload size setsockopt
Date: Tue,  1 Sep 2026 15:29:26 +0800
Message-ID: <20260901072927.128688-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

Fixes: 82cb5be6ad64 ("net/tls: support setting the maximum payload size")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v1 -> v2:
  - also take tx_lock in setsockopt, the socket lock alone can't stop a
    device sender parked in sk_stream_wait_memory() (AI review on v1)
v1: https://lore.kernel.org/netdev/20260831025607.62927-1-jiayuan.chen@linux.dev/

base on my netdevsim + tls (in progress)
https://lore.kernel.org/netdev/20260728125658.390500-1-jiayuan.chen@linux.dev/

Previous finding:
b17cf742eaad ("tls: device: fix out-of-bounds write in tls_append_frag()")
---
 net/tls/tls_main.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fbb274287aa5..114e5113bafd 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -833,15 +833,29 @@ static int do_tls_setsockopt_no_pad(struct sock *sk, sockptr_t optval,
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
@@ -862,6 +876,7 @@ static int do_tls_setsockopt_tx_payload_len(struct sock *sk, sockptr_t optval,
 static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 			     unsigned int optlen)
 {
+	struct tls_context *ctx;
 	int rc = 0;
 
 	switch (optname) {
@@ -881,9 +896,17 @@ static int do_tls_setsockopt(struct sock *sk, int optname, sockptr_t optval,
 		rc = do_tls_setsockopt_no_pad(sk, optval, optlen);
 		break;
 	case TLS_TX_MAX_PAYLOAD_LEN:
+		/* Take tx_lock like the sendmsg paths do, the socket lock is
+		 * dropped while a sender waits for memory, with no record open.
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

