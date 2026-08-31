Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76E19CD0A
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788144987; cv=none; b=QAE/W3Rn782dBRfIeotNVq5zkIJdiFqJh4NJCTSVroWAZABxiFXnWmK0P7BYKPzaH14Fr3G3x4DQV+UBRAn65TXMCKTXa6F65N6lJM1l68Ml+xqsqykyo/L96TPot686ISUMUqSe3YbXTeuZ+X8Mtn5UlI1Sn3BHjT4roBHkj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788144987; c=relaxed/simple;
	bh=BRRVhw6VVWn6Wf2kd4B6YYxP/QFMUwj1ij2KKqIVOY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrlO4BVzRkdud88WoQ0vhtt3eq8yadQcac/LOpp9d5LwEhko2SfubD2WniLmTS6WinFPunAFj1yvxgSIdrlyjGgbKg0+tqXdPsx40kHF15zA1oi/hhKety0pbC/jtEwdV50qOZk64Z9KL/5bm/NgrWKYC7zyQEhFFcVCaNqNob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GJuf86e+; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GJuf86e+"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BRRVhw6VVWn6Wf2kd4B6YYxP/QFMUwj1ij2KKqIVOY4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788144980; v=1; x=1788749780;
 b=GJuf86e+gV+oHM8Y4UCb0WVXi6tN8vg6FqLsWWlHhm2FPePqvJTOxA1xBsxcRi8WT4382Td5
 Gf59O/lh8sf/MkFUe59i2WTO+kraThXD8u2BPt++RoREcqKVlmY511f+4+UvMKLHUEiJWCdEo6D
 XtnqBv1HNw3uYbzH2DBRZeRc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a55aa9db1cad4bcb;
	Mon, 31 Aug 2026 02:56:20 +0000
X-Mizu-Trace-ID: a55aa9db1cad4bcb
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
Subject: [PATCH net] tls: fix TX context confusion in the max payload size setsockopt
Date: Mon, 31 Aug 2026 10:56:06 +0800
Message-ID: <20260831025607.62927-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_tls_setsockopt_tx_payload_len() refuses to resize records while one is
open, but reaches for the open record through tls_sw_ctx_tx(), an unchecked
cast of ctx->priv_ctx_tx.  Under device offload that pointer is a
tls_offload_context_tx, so the check reads a field of the wrong struct: it
returns EBUSY on whatever happens to be there, and never sees the record
that really is open, which lets the limit be lowered mid-record.

Dispatch on tx_conf.  Offload was in scope from the start, the same commit
taught tls_push_data() to honour tx_max_payload_len.

Fixes: 82cb5be6ad64 ("net/tls: support setting the maximum payload size")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
base on my netdevsim + tls (in progress)
https://lore.kernel.org/netdev/20260728125658.390500-1-jiayuan.chen@linux.dev/

Previous finding:
b17cf742eaad ("tls: device: fix out-of-bounds write in tls_append_frag()")
---
 net/tls/tls_main.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fbb274287aa5..e4f288c1fa34 100644
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
-- 
2.43.0

