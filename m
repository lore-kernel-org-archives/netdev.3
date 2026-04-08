Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1272C21D0
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775616190; cv=none; b=EZlCD1q1UbRpClF/OEbLox7a4bTWfJxUYRCmstoqeZpP2FRulPOeAI7wx/8UfjJ0Lmyhl+suCbgHl/5Hiv6qhhhX0Dr5Se4h3XpGGzbvgt7EUrVJEChXCm+BGjAwmXQ6B0N4IM3akVNc9/yZYWNsNd7XlyKDlftTlt4PsO0JaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775616190; c=relaxed/simple;
	bh=wc8ebE65UOu1ysogv3ZDcnkX89LztJOefOmPbTNJMjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHqqBrSjZSjUyJsJMKRlo2B14Uagdp3c8M/DasfTdhqFnXnfI8rz2OFGV0ufpZ8UYW3R0qbJ4jnXwd3lEBGwD/o2KhOCdtVZE18mLYTNnYao7VklvuibeCmSz+77M3xayV4yQVrIZ4jdlaAzfVSQ2nyjeUDG130ugbVbeCxf0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xapIOMIZ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xapIOMIZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775616186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=33eXA0SOhVw75BGKPw1R2kGeIPnZ2JkRRsLUeSlZmUo=;
	b=xapIOMIZk4e7lMBCgcYMriHiENqeJAhP8uQd+H+AUKoYG8k+TVFEgQ5EEvaEipnTkAJmf+
	ifi/tG3wafn1351xGoueKxXPHWoA9pNbW90gLoPegDDkxYpwRU5xuPOEi2ad5VEOeWe1BE
	/9l1ktPhKJDdjioI/um1tYBa5jqklrQ=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: linux-ppp@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Ostrowski <mostrows@gmail.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Yue Haibing <yuehaibing@huawei.com>,
	Breno Leitao <leitao@debian.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
	Jaco Kroon <jaco@uls.co.za>,
	James Carlson <carlsonj@workingcode.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net v2] pppoe: drop PFC frames
Date: Wed,  8 Apr 2026 10:42:39 +0800
Message-ID: <20260408024245.312732-1-qingfang.deng@linux.dev>
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
uncompressed (2-byte) protocol field. However, the generic PPP layer
function ppp_input() is not aware of the negotiation result, and still
accepts PFC frames.

If a peer with a broken implementation or an attacker sends a frame with
a compressed (1-byte) protocol field, the subsequent PPP payload is
shifted by one byte. This causes the network header to be 4-byte
misaligned, which may trigger unaligned access exceptions on some
architectures.

To reduce the attack surface, drop PPPoE PFC frames. Introduce
ppp_skb_is_compressed_proto() helper function to be used in both
ppp_generic.c and pppoe.c to avoid open-coding.

Fixes: 224cf5ad14c0 ("ppp: Move the PPP drivers")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v2: retarget to net, and add a helper function
 https://lore.kernel.org/netdev/20260403083926.68320-1-qingfang.deng@linux.dev/

 drivers/net/ppp/ppp_generic.c |  2 +-
 drivers/net/ppp/pppoe.c       |  8 +++++++-
 include/linux/ppp_defs.h      | 14 ++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index cb29a6968c63..eb1503b389ef 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2251,7 +2251,7 @@ ppp_do_recv(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
  */
 static void __ppp_decompress_proto(struct sk_buff *skb)
 {
-	if (skb->data[0] & 0x01)
+	if (ppp_skb_is_compressed_proto(skb))
 		*(u8 *)skb_push(skb, 1) = 0x00;
 }
 
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 1ac61c273b28..4cd10c908711 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -393,7 +393,7 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (skb_mac_header_len(skb) < ETH_HLEN)
 		goto drop;
 
-	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
+	if (!pskb_may_pull(skb, PPPOE_SES_HLEN))
 		goto drop;
 
 	ph = pppoe_hdr(skb);
@@ -403,6 +403,12 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (skb->len < len)
 		goto drop;
 
+	/* skb->data points to the PPP protocol header after skb_pull_rcsum.
+	 * Drop PFC frames.
+	 */
+	if (ppp_skb_is_compressed_proto(skb))
+		goto drop;
+
 	if (pskb_trim_rcsum(skb, len))
 		goto drop;
 
diff --git a/include/linux/ppp_defs.h b/include/linux/ppp_defs.h
index b74209e5a11e..ba6e53655b93 100644
--- a/include/linux/ppp_defs.h
+++ b/include/linux/ppp_defs.h
@@ -8,10 +8,24 @@
 #define _PPP_DEFS_H_
 
 #include <linux/crc-ccitt.h>
+#include <linux/skbuff.h>
 #include <uapi/linux/ppp_defs.h>
 
 #define PPP_FCS(fcs, c) crc_ccitt_byte(fcs, c)
 
+/**
+ * ppp_skb_is_compressed_proto - checks if PPP protocol in a skb is compressed
+ * @skb: skb to check
+ *
+ * Returns true iff the PPP protocol field is compressed (the least significant
+ * bit of the most significant octet is 1).
+ * skb->data must point to the PPP protocol header.
+ */
+static inline bool ppp_skb_is_compressed_proto(const struct sk_buff *skb)
+{
+	return unlikely(skb->data[0] & 0x01);
+}
+
 /**
  * ppp_proto_is_valid - checks if PPP protocol is valid
  * @proto: PPP protocol
-- 
2.43.0

