Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452623E557D
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836630; cv=none; b=cd0fONesrWIC31GuyupQVDIEbBEass5SDePm5Y/ggfbYbfXa/OjLzyWdw9KXGQXU/RnBoAj9nL+3pIhhqyeQAcnjm1naDsK5bgCWF07RgpFSA4fXIh5kyoCOEp6s/jROYvQ2yg3FraheL0voujRpJgqr+LVxB0rc6U8Eitmw4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836630; c=relaxed/simple;
	bh=bdYNamhAOrL0omvybEShn0NKNF4/pV7bfN33/XRnNJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B8z9sR0xXRlAHG9jdyGmrAL4pw6P+ucuX2OXFcatprv1n8jpLGOUbcOEo4FM1o1rfAUGePHWX9SQepJMsLN+inX9cyjikzee+rX4FbGHd5ds+kj4ULZeBEAzYbKu1d66iCjc4T4ZujhbJMCCdzHR69KH13vSMei1uC0AZhEFzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uFm7hp8a; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uFm7hp8a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785836626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YfT5CY2AV1NRk0tpt3k93b4nNEloKgbHx2xVUYjmwlA=;
	b=uFm7hp8axh5yT1foQFpHJ2aU8FdUb64usdBnbNGyNMkCLSPhnwXCVulQW3G5QuDI5Zn1+c
	svMKZcFoB2e85dX+D7o9yVHSMDJAxn3pukwqty/YtFtxZerwagTLaeBwGdlq2XNA2hYsZ3
	Hfgv/x22NwHc2Nh3gL6Iikn1uVg1LdU=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] pppoe: remove redundant xmit wrapper
Date: Tue,  4 Aug 2026 17:43:34 +0800
Message-ID: <20260804094336.109364-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Merge __pppoe_xmit() into pppoe_xmit(), its only caller.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 6874a1a8edaf..bf7414b46a26 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -85,8 +85,6 @@
 #define PPPOE_HASH_SIZE (1 << PPPOE_HASH_BITS)
 #define PPPOE_HASH_MASK	(PPPOE_HASH_SIZE - 1)
 
-static int __pppoe_xmit(struct sock *sk, struct sk_buff *skb);
-
 static const struct proto_ops pppoe_ops;
 static const struct ppp_channel_ops pppoe_chan_ops;
 
@@ -839,11 +837,13 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
 
 /************************************************************************
  *
- * xmit function for internal use.
+ * xmit function called by generic PPP driver
+ * sends PPP frame over PPPoE socket
  *
  ***********************************************************************/
-static int __pppoe_xmit(struct sock *sk, struct sk_buff *skb)
+static int pppoe_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 {
+	struct sock *sk = chan->private;
 	struct pppox_sock *po = pppox_sk(sk);
 	struct net_device *dev = po->pppoe_dev;
 	struct pppoe_hdr *ph;
@@ -893,18 +893,6 @@ static int __pppoe_xmit(struct sock *sk, struct sk_buff *skb)
 	return 1;
 }
 
-/************************************************************************
- *
- * xmit function called by generic PPP driver
- * sends PPP frame over PPPoE socket
- *
- ***********************************************************************/
-static int pppoe_xmit(struct ppp_channel *chan, struct sk_buff *skb)
-{
-	struct sock *sk = chan->private;
-	return __pppoe_xmit(sk, skb);
-}
-
 static int pppoe_fill_forward_path(struct net_device_path_ctx *ctx,
 				   struct net_device_path *path,
 				   const struct ppp_channel *chan)
-- 
2.43.0

