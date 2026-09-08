Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268263A5E71
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852110; cv=none; b=pKTG/GDtf1BONEzTqHQqcRrVAGdfpny3zZHs6hmgOxTAzkuAZeFvNcg3ouKfjQaHPXD7ONUcjZ8mbXzXAzZ+lTmIYuCCx3WGVc0cFNCn60onQIMtGkpshp1nlfM6EDgw62x3jwjc7idEiJZu8OHs58kCMSm0cWnamMOxpQlbISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852110; c=relaxed/simple;
	bh=Zh/9z+iWI948KTO+S60nAAxNxZjNp+JqNGNxgXYR6pI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKGDy4AzPY8p0Itk5C0omtP4fOuofITCJkokTaky5XWwyemG4c/A2CIe5GnRw1w/P455yBgk7T4ftUVeD+Bbbty/9wL1uMel5DmjNhQBDNqFoasbtFWVsqSuG0/7jx/lS/LNBCccahUAD3dgWmUp3fH1jkRFmxfZ8dC3C6Q5RNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ijwb3hRy; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ijwb3hRy"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Zh/9z+iWI948KTO+S60nAAxNxZjNp+JqNGNxgXYR6pI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788852106; v=1; x=1789456906;
 b=ijwb3hRyVfTmRgV8sCdp5467Bd6r3t+5np37aI+Lwl3hJAEFY9h12xMhJWrh13kLKhizlu8k
 QEJ+mr3cTJh4evV8Y95nSF2B7QWZafnLCUnowE+FgIB673zCF1jk2dSq1Nz9UwHP2PBabzQeh8N
 CGwbL+B4J/9PcL55Nvu9IhVE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6b114812e2948a71;
	Tue, 08 Sep 2026 07:21:45 +0000
X-Mizu-Trace-ID: 6b114812e2948a71
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tom Parkin <tparkin@katalix.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net] ppp_synctty: ensure a writeable skb header
Date: Tue,  8 Sep 2026 15:21:31 +0800
Message-ID: <20260908072135.877364-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ppp_sync_txmunge() checks headroom before prepending the address and
control bytes, but does not ensure that the skb header is writable.
A received skb can reach this function through PPP channel bridging
without passing through ppp_start_xmit(), which calls skb_cow_head().

For example, a PPPoE frame may share its buffer with a clone queued to
an AF_PACKET socket. If it is bridged to a synchronous tty channel, the
address/control bytes can overwrite data still visible to that socket.

Use skb_cow_head() to ensure both sufficient headroom and a writable
header.

Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_synctty.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index f87d43faeeab..ebd62a7ab54b 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -455,17 +455,9 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *skb)
 
 	/* prepend address/control fields if necessary */
 	if ((ap->flags & SC_COMP_AC) == 0 || islcp) {
-		if (skb_headroom(skb) < 2) {
-			struct sk_buff *npkt = dev_alloc_skb(skb->len + 2);
-			if (npkt == NULL) {
-				kfree_skb(skb);
-				return NULL;
-			}
-			skb_reserve(npkt,2);
-			skb_copy_from_linear_data(skb,
-				      skb_put(npkt, skb->len), skb->len);
-			consume_skb(skb);
-			skb = npkt;
+		if (skb_cow_head(skb, 2)) {
+			kfree_skb(skb);
+			return NULL;
 		}
 		skb_push(skb,2);
 		skb->data[0] = PPP_ALLSTATIONS;
-- 
2.43.0

