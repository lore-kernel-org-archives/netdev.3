Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066473806D4
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205609; cv=none; b=JCWsh7jZkqF+NO6DLWDlwtOtmBBEQ3aF4XNEQoCgTzhidLe0y8ggRbR/Qyi+um1RmzSoD05Fe7xauI8FNtZBCFSN2ABCyq2pd4v44bA/Vw1VG965/0t2rFXXvLgc4jD90S3QsCd86i0y4TXly8lf6n8RXNSHt2p9ySLqh28cKV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205609; c=relaxed/simple;
	bh=e4lGR3DstaAiSVA+rn/IL++bEhqX5bOxsKkVamSfiaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqNG1b73IKHzZ1XKQLWxfloVdmiChVaIc2gwDYcwd9hy06CI5CaqNL9YKGK3UTrNmtvFjq0j79+YINpoJIpVgUKEvuFiNiNQUMfr/UlSI3EKlotv8SbgKzvjMT9oUQ5v0I52s5IOWWp+KrlElO1inVU40ya/OeRvMt1jUwWq570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Uv/V0rVp; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Uv/V0rVp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775205593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hF7hZ7Wiu6b35f63HMhM8OOd1wtXQKw5Xv9T7odndBw=;
	b=Uv/V0rVpCdsrcq4FQRaFmu01wF4+D6+Ipo1ZZXI19wMMK/LK2i1cHrklcLU05VbaRe3IMX
	8sHn9JboUvJjZWf/9fSZrcKc/fjUn8XFfnOdsJKHjxEpUXG4bT33sIU5yKQtiCGbc0aesO
	YMOSaK3iaJDx6TEfsDR2RrXgwcVFid0=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: linux-ppp@vger.kernel.org,
	Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
	Jaco Kroon <jaco@uls.co.za>,
	James Carlson <carlsonj@workingcode.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Guillaume Nault <gnault@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>
Subject: [PATCH net-next] pppoe: drop PFC frames
Date: Fri,  3 Apr 2026 16:39:26 +0800
Message-ID: <20260403083926.68320-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

RFC 2516 Section 7 states that Protocol Field Compression (PFC) is NOT
RECOMMENDED for PPPoE. In practice, pppd does not support negotiating
PFC for PPPoE sessions, and the current PPPoE driver assumes an
uncompressed (2-byte) protocol field.

If a peer with a broken implementation or an attacker sends a frame with
a compressed (1-byte) protocol field, the subsequent PPP payload is
shifted by one byte. This causes the network header to be 4-byte
misaligned, which may trigger unaligned access exceptions on some
architectures.

To reduce the attack surface, drop the compressed protocol field frames.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 1ac61c273b28..457a83c73293 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -393,7 +393,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (skb_mac_header_len(skb) < ETH_HLEN)
 		goto drop;
 
-	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
+	if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
 		goto drop;
 
 	ph = pppoe_hdr(skb);
@@ -403,6 +403,10 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (skb->len < len)
 		goto drop;
 
+	/* drop PFC frames */
+	if (unlikely(skb->data[0] & 0x01))
+		goto drop;
+
 	if (pskb_trim_rcsum(skb, len))
 		goto drop;
 
-- 
2.43.0

