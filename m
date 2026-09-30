Received: from mta1.migadu.com (out-243.mta1.migadu.com [95.215.58.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE42FFF9D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 05:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746015; cv=none; b=H5RcfaGmk2I0MVVMyfVtdaoNPUMW0kDfLkiDWSTH/wpO+gurqINwx1bPkZIFX6Nx3cwLtl/QZ+9v+bRL2VrmQJTKk2ANoCMVShpydJPYXp6kB4WpSNs6eFIeGC/v/dSIKjeyokCOBGPu7GNQScJ8ewRmrjBiuj8BPwR4FEX2cNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746015; c=relaxed/simple;
	bh=mY3ptsl+dSHF/Cm+TR52bPaPpSnRJLiyYNQXGAPEN7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m8NqrzKIawkRiW490uWamQiAYwF4FyeijoEI9HUiLTRNIeP2gu5zkHFLini+ggEnVQBXEmtcSudfJUTz3XAO0y7xyQdaLLEQhN/x8YqCrYy8QatKtOlNLKxo9bjv1Lh9D9Us9yYjT8J19cYckqQQJ7qEw9P69c+SOUfmN9ePzkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dh8OquRf; arc=none smtp.client-ip=95.215.58.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dh8OquRf"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mY3ptsl+dSHF/Cm+TR52bPaPpSnRJLiyYNQXGAPEN7Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790746010; v=1; x=1791350810;
 b=Dh8OquRfxxVdcP7NzutJ2oIGxTFQiXDXxQKkAxVq70fdM7bl7TKDSXBtbovkyr6PirR41F6Y
 qUO/78tTzVehVHq7sXOllINEHe4WVKAfk8YIWa0y2sEtLyVG4vyzX3TL5AuO4DkLXSkIsMwvpQi
 x53zEEV4E1d9VdRLyFz3NB6k=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2493c55bb302a264;
	Wed, 30 Sep 2026 05:26:49 +0000
X-Mizu-Trace-ID: 2493c55bb302a264
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dave Watson <davejwatson@fb.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>
Subject: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
Date: Wed, 30 Sep 2026 13:26:36 +0800
Message-ID: <20260930052636.166007-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tls_sw_splice_read() returns 0 after receiving an empty application
record. This looks like EOF for splice(), even though the connection
remains open and more data may be available.

Consume empty application records and retry the receive path instead,
following the approach used in tls_sw_read_sock() since commit
3be28e2c9cd0 ("net/tls: Consume empty data records in tls_sw_read_sock()").

Fixes: c46234ebb4d1 ("tls: RX path for ktls")
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Closes: https://lore.kernel.org/netdev/akaoXcfamBp8_mYe@krikkit/
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 net/tls/tls_sw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1ad31986cf2..e23bb8a9dedd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2019,6 +2019,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	if (err)
 		goto splice_read_end;
 
+retry:
 	if (!skb_queue_empty(&ctx->rx_list)) {
 		skb = __skb_dequeue(&ctx->rx_list);
 	} else {
@@ -2048,6 +2049,12 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		goto splice_requeue;
 	}
 
+	/* Empty application records must not be reported as EOF. */
+	if (!rxm->full_len) {
+		consume_skb(skb);
+		goto retry;
+	}
+
 	chunk = min_t(unsigned int, rxm->full_len, len);
 	copied = skb_splice_bits(skb, sk, rxm->offset, pipe, chunk, flags);
 	if (copied < 0)
-- 
2.43.0

