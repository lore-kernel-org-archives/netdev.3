Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684481;
	b=W+cyGOi+Dldx5Yl72157X/zjJMJZqy1dAkvkd5/irMg3m9J4/hYxsDqk4FB1nvob+bit
	 dTvCubETbzFjheQVK0mcTTia4lB3D+OpS6AMN/le0tuihV49sUvh8/SVhBaAbkoWgnzVL
	 fHxzq9SbqT+DPgDU4Q5NYpaaQytbqJIY376mEAQk8JnF44U+22drEv33K6icfDMfKhfXx
	 utQaOvJQ8fkNv9ciO3flszGquTgDCP9HotGhRVFjzu3bUzYLsVzx1LIJm33/aS1PAqWnQ
	 dE9wQ5Rh3oTXZpAz5Y8obc6FIlWlC2e6Gb1aqupQpacbtqidtfbI12bsAYZBXJ0kbHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684481;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fw9MZRcOmU8Ehb4tKOD55KkHpTquvtk01ZhunBeT+b8=;
	b=hr1qoWIdBzgsKX1AvIhIonXlq17KGdJ+4BnyNawnSuBJx32Qq/PT5jJEvJK8bYFqPAhE
	 KIbeMpNfb6ffLYqfJkVYMsGY22yakv09rLH2KNrPpbBbkGEE+KvUtq6ednEy/yiXhNgOu
	 AET8cZ3qBDTXsqmIue4dAT7Sukur2Y7QU649oMGl88Ec/awJ9fBpIOZtJQ9QVV3Kv0ghQ
	 ZDL+IybfzisSOAEpCQQ2w4aMj0TaZpK5weJFcLfD19xSZSVI2nUhRWiiRSfikpqkQWPzr
	 nlu9DcgsJnfsRU19mOp93I3mUcRDlY2X/Bzlh9qvjhESzY4fo69BnTDQSKo7djDPglg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTvUvctM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED5606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gTvUvctM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58BF1F01825;
	Thu, 22 Oct 2026 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792684480;
	bh=fw9MZRcOmU8Ehb4tKOD55KkHpTquvtk01ZhunBeT+b8=;
	h=From:To:Cc:Subject:Date;
	b=gTvUvctMpSAIH6x4EfkBneI6lDwjKW47MzbKS+qLmVvLispfvp4teLSl1W+6HaaUt
	 kMH1bLoE7NADid68I823+BpPWtICyKb3hxlBSiMw63Bzr/LGTqrVd8tIiazTkHcRDf
	 CmJTZDuz/lUXRsJ/312RhTWyM4bbxnUdSbH1RGrKc80Fki2UDJ6pU9IkN4G8bFvkya
	 hj3N4TojvDQZ35emfXugFIj4NQ1U2JcJY/Wi2SIP7OWQnr7ulV8/5eg/ZWtOTq/QMF
	 kJA1CnVWH7u6NAwiIbSXARiX10yxUZfseon2lsp6UpJZVrQBLLsPv2GCeNYHMzJUNZ
	 a5Oenct6vxI+g==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	shaos <shawnq1@163.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH net] net: harden qdisc_pkt_len_segs_init() against malicious GSO packets
Date: Thu, 22 Oct 2026 17:54:36 +0200
Message-ID: <20261022155436.117507-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

An SKB_GSO_DODGY packet can carry untrusted gso_size and headers.

For instance, gso_size=1 and hdr_len=65532 for a 524275-byte frame
makes qdisc_pkt_len_segs_init() compute an accounted length of
about 4,294,574,091 bytes (after gso_segs silently wrapped in a u16).

With DRR quantum 256, the dequeue path then needs ~16.8 million
deficit refills before it can dequeue the skb, keeping the CPU in
the qdisc path long enough to trigger the soft-lockup watchdog.

Commit 8f735d64382d ("net/sched: bound qdisc_pkt_len to prevent
qdisc soft lockup") added QDISC_PKT_LEN_MAX to bound size table
amplification. Use the same bound for DODGY packets:

- Make gso_segs a u32 and drop packets whose segment count does
  not fit GSO_MAX_SEGS, instead of silently truncating it.

- Drop packets whose estimated qdisc_pkt_len() would exceed
  QDISC_PKT_LEN_MAX.

Fixes: 15e5a0307164 ("net_sched: better precise estimation on packet length for untrusted packets")
Reported-by: shaos <shawnq1@163.com>
Closes: https://lore.kernel.org/netdev/20261022144755.65025-1-shawnq1@163.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 net/core/dev.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360ea87ade0846e4a4f9016dca587d6..573bcc9d67b1b1e21e844f054f0b51a172713a90 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4175,7 +4175,7 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	unsigned int hdr_len, tlen;
-	u16 gso_segs;
+	u32 gso_segs;
 
 	qdisc_skb_cb(skb)->pkt_len = skb->len;
 	if (!shinfo->gso_size) {
@@ -4226,6 +4226,15 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 		if (payload <= 0)
 			return SKB_DROP_REASON_SKB_BAD_GSO;
 		gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+		/* shinfo->gso_segs is a 16bit field.
+		 * Also make sure untrusted gso_size/hdr_len can not inflate
+		 * qdisc_pkt_len() beyond QDISC_PKT_LEN_MAX, or deficit
+		 * schedulers could spin in their refill loops.
+		 */
+		if (unlikely(gso_segs > GSO_MAX_SEGS ||
+			     skb->len + (u64)(gso_segs - 1) * hdr_len >
+			     QDISC_PKT_LEN_MAX))
+			return SKB_DROP_REASON_SKB_BAD_GSO;
 		shinfo->gso_segs = gso_segs;
 		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
 	}
-- 
2.53.0

