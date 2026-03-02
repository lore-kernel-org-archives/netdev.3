Received: from sg-1-103.ptr.blmpb.com (sg-1-103.ptr.blmpb.com [118.26.132.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15792D5436
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430427; cv=none; b=HlLnQ2Wzv8JvqYsF9Zs4b/jaRd5nalSPKPLnwwh4ijheTrtUU6CX9mP3RC9tnm5l9fTwX3c/zUEa0Bt7vlA1Cu26t5K0ghxCP+D2uYVOjVX+NJjknsDENdrI8PWzzRRe/TX37Px+QX5rheBfdFGq5nqv8hSgT1rD+xNwLiThqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430427; c=relaxed/simple;
	bh=FBUj8CXqrMmWiCJ6H5cfj4MYT+crFnEv2ztcbGdjJyQ=;
	h=Date:From:Mime-Version:Content-Type:To:Subject:Message-Id; b=YuXeLZDCZSAg+RiVTM5GhWGVVpMkov6JTF1qNoxfS8ti6cAXooD/+/eXt7MqK917z/f7ovP2rg6EEGoD7y/iw19uukh++m1Jzothe0Fj6KB3UCR3QbHzIItG3aEsbyDUpPWQKeBCKpNxpJhac9y17tpUNbV5ePQlyWJ7r77oPJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VUEX2y+d; arc=none smtp.client-ip=118.26.132.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VUEX2y+d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1772430403; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=D4s3Y/dQGNCVxUUgdzoFPBIj3DOlIkW5R8WMjLUI9yM=;
 b=VUEX2y+dAFt5rCkT/ocb/U8e+AnrTr3b3+7uKtEGuPXoFD3iLGNCp3Q3D7nH72uUo71Oo4
 WLMbbuOhYLbFnglh59xOhw56s6oMMEtLtywSmD3tGQDEsby3Tv006MDDP1l8jHKdVvbWpV
 O6JbAyul31ZRigF1V9dvQl74EbS5ZjtdBEcTnSZHKw6Z4+5vZepr6T+OiYAzvnoVb+RG1c
 c2y6YAnR/1ua6mpMo7jkdtKHjXkqgJUIRPVD1VpaAiVAkAvJTebKkwUordlCtt/xRcMpdj
 JQbWOaNQ4j/iaGKnS+Tc8xDLESy+riH0GdSz0DdVGm3xl66BuVuK8Y7grVh0Pg==
Date: Mon,  2 Mar 2026 13:46:29 +0800
X-Mailer: git-send-email 2.20.1
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: "Samuel Mendoza-Jonas" <sam@mendozajonas.com>, 
	"Paul Fertser" <fercerpav@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, 
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: ncsi: fix skb leak in error paths
Message-Id: <20260302054629.1347119-1-zhangjian.3032@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+269a52441+210b70+vger.kernel.org+zhangjian.3032@bytedance.com>

Early return paths in NCSI RX and AEN handlers fail to release
the received skb, resulting in a memory leak.

Specifically, ncsi_aen_handler() returns on invalid AEN packets
without consuming the skb. Similarly, ncsi_rcv_rsp() exits early
when failing to resolve the NCSI device, response handler, or
request, leaving the skb unfreed.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 net/ncsi/ncsi-aen.c |  3 ++-
 net/ncsi/ncsi-rsp.c | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 62fb1031763d..040a31557201 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -224,7 +224,8 @@ int ncsi_aen_handler(struct ncsi_dev_priv *ndp, struct sk_buff *skb)
 	if (!nah) {
 		netdev_warn(ndp->ndev.dev, "Invalid AEN (0x%x) received\n",
 			    h->type);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto out;
 	}
 
 	ret = ncsi_validate_aen_pkt(h, nah->payload);
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 271ec6c3929e..9d3ca1c020b6 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -1176,8 +1176,10 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	/* Find the NCSI device */
 	nd = ncsi_find_dev(orig_dev);
 	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;
-	if (!ndp)
-		return -ENODEV;
+	if (!ndp) {
+		ret = -ENODEV;
+		goto bail;
+	}
 
 	/* Check if it is AEN packet */
 	hdr = (struct ncsi_pkt_hdr *)skb_network_header(skb);
@@ -1199,7 +1201,8 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	if (!nrh) {
 		netdev_err(nd->dev, "Received unrecognized packet (0x%x)\n",
 			   hdr->type);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto bail;
 	}
 
 	/* Associate with the request */
@@ -1207,7 +1210,8 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 	nr = &ndp->requests[hdr->id];
 	if (!nr->used) {
 		spin_unlock_irqrestore(&ndp->lock, flags);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto bail;
 	}
 
 	nr->rsp = skb;
@@ -1261,4 +1265,8 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 out:
 	ncsi_free_request(nr);
 	return ret;
+
+bail:
+	consume_skb(skb);
+	return ret;
 }
-- 
2.20.1
