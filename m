Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61233F1643
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996308; cv=none; b=KhinFApsRnTFIwtHa5nHb5yhVstigCMKkl+gs9Z8/cEApVu4Wsot4ytXtkmwti0VYWbXT2P/uIje+aKfUc158GXSvC0WIPPRFeLd2W0j9/v+l0RpLaKJ6Swu9OeQ2oDlDAnpEEhYt1VD7PnOfPIqID79jZuEBZDyggXIY0rEWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996308; c=relaxed/simple;
	bh=kKbi1oxTKbsnezrFVdJiiwa4t5+jQMflJfKhT0EoNTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXUOy6ymYk1u6ePUd+54JrtYlT1a26dU/GANr4DxGlYsPb/SHzpV5dC6JS+TQ6npqtjLH1XU02m5YOZx2F81+YQrzr1CBO2x/Bg5rOzbD2MlzZ8JUj4dcn+JEzDh75ceuJ8RHHme+n+n/7ggY33OAdlCQ7IF3c+RRZxcMLuqZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WOw9eUir; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WOw9eUir"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sd11GRsV4i6LvSYuRT+ftiOVKq70GFM/yYDVhZNwmto=;
	b=WOw9eUiryeHvBjoZ49rPVn8SYGM1huAgqAoGAg/CoSWpGGE4egv6Og+R+B7T6MGDRw4WJl3Ru
	nb3SyWerF1Nk0Z7hg4eFYxr9JvO8At2rOV88puG1gX7zKuY0Df1WH8YGzk0lTurizN9SR5KPBKb
	x2njfeGWczgdFeYqIqt84v8=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gZNHj6rmdzKm4s;
	Tue,  9 Jun 2026 17:03:45 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 101A640562;
	Tue,  9 Jun 2026 17:11:42 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 17:11:41 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 17:11:41 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <tpluszz77@gmail.com>,
	<idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>,
	<xuchunxiao3@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net v2] xfrm: Fix dev use-after-free in xfrm async resumption
Date: Tue, 9 Jun 2026 17:21:17 +0800
Message-ID: <20260609092117.1362316-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200002.china.huawei.com (7.202.195.90)

xfrm async resumption hold skb->dev refcnt until after transport_finish.
However, xfrm_rcv_cb may modify skb->dev to tunnel dev without taking
device reference, such as vti_rcv_cb. The subsequent async resumption
will decrement the tunnel device's reference count, which lead to uaf
of tunnel dev and refcnt leak of orig dev as below:

unregister_netdevice: waiting for vti1 to become free. Usage count = -2

Stash the original skb->dev to fix refcnt imbalance. The new skb->dev set
by xfrm_rcv_cb can race with device teardown. Extend rcu protection over
xfrm_rcv_cb and transport_finish to prevent races.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Reported-by: Xu Chunxiao <xuchunxiao3@huawei.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
changes in v2:
  - Stash the original skb->dev to fix refcnt imbalance
  - Extend rcu protection over xfrm_rcv_cb and transport_finish to
    prevent races.
---
 net/ipv4/xfrm4_input.c |  2 --
 net/ipv6/xfrm6_input.c |  2 --
 net/xfrm/xfrm_input.c  | 29 ++++++++++++++++-------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index c2eac844bcdb..f6f2a8ef3f88 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -76,8 +76,6 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 	NF_HOOK(NFPROTO_IPV4, NF_INET_PRE_ROUTING,
 		dev_net(dev), NULL, skb, dev, NULL,
 		xfrm4_rcv_encap_finish);
-	if (async)
-		dev_put(dev);
 	return 0;
 }
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 699a001ac166..89d0443b5307 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -71,8 +71,6 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING,
 		dev_net(dev), NULL, skb, dev, NULL,
 		xfrm6_transport_finish2);
-	if (async)
-		dev_put(dev);
 	return 0;
 }
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index e4c2cd24936d..eecab337bd0a 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -467,6 +467,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 {
 	const struct xfrm_state_afinfo *afinfo;
 	struct net *net = dev_net(skb->dev);
+	struct net_device *dev = skb->dev;
 	int err;
 	__be32 seq;
 	__be32 seq_hi;
@@ -493,7 +494,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					       LINUX_MIB_XFRMINSTATEINVALID);
 
 			if (encap_type == -1)
-				dev_put(skb->dev);
+				dev_put(dev);
 			goto drop;
 		}
 
@@ -655,16 +656,16 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 
 		if (!crypto_done) {
 			spin_unlock(&x->lock);
-			dev_hold(skb->dev);
+			dev_hold(dev);
 
 			nexthdr = x->type->input(x, skb);
 			if (nexthdr == -EINPROGRESS) {
 				if (async)
-					dev_put(skb->dev);
+					dev_put(dev);
 				return 0;
 			}
 
-			dev_put(skb->dev);
+			dev_put(dev);
 			spin_lock(&x->lock);
 		}
 resume:
@@ -699,7 +700,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		err = xfrm_inner_mode_input(x, skb);
 		if (err == -EINPROGRESS) {
 			if (async)
-				dev_put(skb->dev);
+				dev_put(dev);
 			return 0;
 		} else if (err) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
@@ -726,9 +727,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		crypto_done = false;
 	} while (!err);
 
+	rcu_read_lock();
 	err = xfrm_rcv_cb(skb, family, x->type->proto, 0);
-	if (err)
+	if (err) {
+		rcu_read_unlock();
 		goto drop;
+	}
 
 	nf_reset_ct(skb);
 
@@ -739,8 +743,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
 		if (async)
-			dev_put(skb->dev);
+			dev_put(dev);
 		gro_cells_receive(&gro_cells, skb);
+		rcu_read_unlock();
 		return 0;
 	} else {
 		xo = xfrm_offload(skb);
@@ -748,23 +753,21 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			xfrm_gro = xo->flags & XFRM_GRO;
 
 		err = -EAFNOSUPPORT;
-		rcu_read_lock();
 		afinfo = xfrm_state_afinfo_get_rcu(x->props.family);
 		if (likely(afinfo))
 			err = afinfo->transport_finish(skb, xfrm_gro || async);
-		rcu_read_unlock();
 		if (xfrm_gro) {
 			sp = skb_sec_path(skb);
 			if (sp)
 				sp->olen = 0;
 			if (skb_valid_dst(skb))
 				skb_dst_drop(skb);
-			if (async)
-				dev_put(skb->dev);
 			gro_cells_receive(&gro_cells, skb);
-			return err;
 		}
 
+		if (async)
+			dev_put(dev);
+		rcu_read_unlock();
 		return err;
 	}
 
@@ -772,7 +775,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	spin_unlock(&x->lock);
 drop:
 	if (async)
-		dev_put(skb->dev);
+		dev_put(dev);
 	xfrm_rcv_cb(skb, family, x && x->type ? x->type->proto : nexthdr, -1);
 	kfree_skb(skb);
 	return 0;
-- 
2.25.1

