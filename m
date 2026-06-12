Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6FD3E171D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250495; cv=none; b=u4czXOEhUmti4hkApDz+IKMfiC9LQ/Q3qc6rkbA4vjgS6b2UO4mjIYIASj0rFd/FacG51s26sXSuSc2OtHvDtcze132HuGPB/mmaVceYib/Lq/pUOFbvTU3hWxmcQ6Ryt7sYhb41Hupb4nZEsDym2iBe2ZSyUL4GIE+qcDq7M4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250495; c=relaxed/simple;
	bh=/Wjr6j+7asCtiAKm3ysROkvUTFX8fyLByXKkA9YmKpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qI9f7dBAfmtG9SsNNrqGD5OUsY7CAE0Yq/ANFbK/hTxs83VmebIaJBOhJAzhLy6h4pgyGnDZxApT763nG+soDlvVfOmo6C+iqL+w+v0ykMZyu33Z0WsiEA3QLk/9Eu9ecWtieJI85/pPcLfu9z7tGdt9VSbYMUBw8FpBIh3X+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=SOLPVdIV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="SOLPVdIV"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3874420839;
	Fri, 12 Jun 2026 09:48:11 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mQR6wcoFao5h; Fri, 12 Jun 2026 09:48:10 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A347D2082B;
	Fri, 12 Jun 2026 09:48:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A347D2082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1781250490;
	bh=r8ggNS3/PX99ocVUMNopQojBgUbu9VBTl7XAwOm3Qoc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=SOLPVdIVLrmRIZvbY8OklAv12GL9ELIbTG6rEODWsBBo+YJ7n26ybqGb7phcyLOT5
	 xmP+5yOJMKq8FFgtDRs8Bo2clcQbe7xXIVf6a2ouFtfTJfSjtxyMNXoPi6s9eUVPXj
	 V638v3LYHkShauyrnc4XF+QEdy3wZ5ph74eiNU2/2lM1JVxQhM8K+PPQGgPbwYvl93
	 Uq7fXHoZBNldZ9JDlF8/7NQT0x3dPOvLgRe7J7qlFxRF4ppU5VGczx9ydX8zQ77nRs
	 hFRVJjb7EdirGybOFonMq3HibNqnJyERr2DN3K0mcXkBRoRwWejqOKz8o9T3QvIq+X
	 8/0V2sELVBfZg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 09:48:10 +0200
Received: (nullmailer pid 1768308 invoked by uid 1000);
	Fri, 12 Jun 2026 07:47:57 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 15/18] xfrm: make xfrm_dev_state_add xuo parameter const
Date: Fri, 12 Jun 2026 09:46:31 +0200
Message-ID: <20260612074725.1760473-16-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612074725.1760473-1-steffen.klassert@secunet.com>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

From: Antony Antony <antony.antony@secunet.com>

The xuo pointer is not modified by xfrm_dev_state_add(); make it const.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h     | 6 ++++--
 net/xfrm/xfrm_device.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 4b29ab92c2a7..5515c7b10020 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2104,7 +2104,7 @@ void xfrm_dev_resume(struct sk_buff *skb);
 void xfrm_dev_backlog(struct softnet_data *sd);
 struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t features, bool *again);
 int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
-		       struct xfrm_user_offload *xuo,
+		       const struct xfrm_user_offload *xuo,
 		       struct netlink_ext_ack *extack);
 int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 			struct xfrm_user_offload *xuo, u8 dir,
@@ -2175,7 +2175,9 @@ static inline struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_fea
 	return skb;
 }
 
-static inline int xfrm_dev_state_add(struct net *net, struct xfrm_state *x, struct xfrm_user_offload *xuo, struct netlink_ext_ack *extack)
+static inline int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
+				     const struct xfrm_user_offload *xuo,
+				     struct netlink_ext_ack *extack)
 {
 	return 0;
 }
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 550457e4c4f0..630f3dd31cc5 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -229,7 +229,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 EXPORT_SYMBOL_GPL(validate_xmit_xfrm);
 
 int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
-		       struct xfrm_user_offload *xuo,
+		       const struct xfrm_user_offload *xuo,
 		       struct netlink_ext_ack *extack)
 {
 	int err;
-- 
2.43.0

