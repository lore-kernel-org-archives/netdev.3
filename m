Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42517190462
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779748; cv=none; b=SpIYQLECmqZQk/XczowNQDazJf3ktmkc6JeQjUF0A+M5K3Ha2GzZ7z5mYIGXVYyW5yqJikC7d2314n9B3yoDqwDsmz57FpoyBzPMaIKGhwdXDj2KAPtMvB5BkiSz1tre7H3Qng0zaHqT1GgtWFL6hsaDLkiMiIOZKmm6hrq9wyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779748; c=relaxed/simple;
	bh=EjwSSC8bnvMcTZFASyRaGDdx1oJMWy9Tm/8iXx9H+50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qhXSmfhBi12DsHJ1R4r6gRLQVrH8nAsq5xlx/4orZLSzdxGk0BmnJXrywNt4k8X/JM6rA+5X8nXG32zqNkNp652Fvlwcp/IrfUseqiFHZONi7NoBu/idzFleFJxaiSiKMmwLcWvcSGmskpBfrrMqpSAQgmNdljCjb7E5UGwYAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rgyZBblk; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rgyZBblk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JFSSVEc4yWIt6RK2R6BNTxwii/iqR0aq6Dbp1rMtYi0=;
	b=rgyZBblkaWAGhuNYxx3eul4VCl1r66bJMj0s4Ao0zA57gnm5CexXR0ESfbp3DZiRt4TLJNL58
	rG3Z8pRs3GXzdmlWfog4Ucb4aJ6l+lEpIuq2bxSEK021MpqnksOn0o7GxAh4HScSAC0PmGS/DXP
	S81hTJlZ9ntZ+I11LR2LtEM=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hMW4v4Pcqzcb0T;
	Sat, 15 Aug 2026 15:31:59 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 3337A20333;
	Sat, 15 Aug 2026 15:42:12 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Aug 2026 15:42:11 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 15 Aug 2026 15:42:11 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <herbert@gondor.apana.org.au>
CC: <netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net v2] ipv4: icmp: reject RTN_UNREACHABLE input routes in icmp_route_lookup
Date: Sat, 15 Aug 2026 15:51:02 +0800
Message-ID: <20260815075102.3426068-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)

When the forward output route cannot be used in icmp_route_lookup(),
it enters the "reverse path" and calls ip_route_input() on fl4_dec.daddr,
the original packet's source address.

ip_route_input() only returns an error for truly invalid packets. For
unreachable addresses it will succeed and return an input route whose
dst.output is set to ip_rt_bug(). The existing check only rejects
RTN_LOCAL routes, so the RTN_UNREACHABLE route types can still be returned
and later used for output, syzkaller triggering a WARN_ON_ONCE()
in ip_rt_bug() as bellow:

 ------------[ cut here ]------------
 WARNING: net/ipv4/route.c:1273 at ip_rt_bug+0x14/0x20
 RIP: 0010:ip_rt_bug+0x14/0x20
 Call Trace:
  ip_push_pending_frames+0xfa/0x100
  __icmp_send+0x905/0xf10
  ip_options_compile+0xc0/0xd0
  ip_rcv_finish_core+0x321/0xae0
  ip_rcv+0x1de/0x260
  __netif_receive_skb_one_core+0x11a/0x130
  netif_receive_skb+0x7b/0x260
  tun_get_user+0x11bf/0x1c10
 ------------[ cut here ]------------

Reject any input route that is RTN_UNREACHABLE to fix it.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/ipv4/icmp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 0caedfc7ca92..4703d8dd6b47 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -585,11 +585,11 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		 * checked fl4_dec.saddr above). However, a race condition
 		 * may occur if the address is added to the interface
 		 * concurrently. In that case, ip_route_input() returns a
-		 * LOCAL route with dst.output=ip_rt_bug, which must not
-		 * be used for output.
+		 * LOCAL or UNREACHABLE route with dst.output=ip_rt_bug,
+		 * which must not be used for output.
 		 */
-		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
-			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
+		if (!err && rt2 && (rt2->rt_type == RTN_LOCAL || rt2->rt_type == RTN_UNREACHABLE)) {
+			net_warn_ratelimited("detected unusable input route for %pI4 during ICMP sending, src %pI4\n",
 					     &fl4_dec.daddr, &fl4_dec.saddr);
 			dst_release(&rt2->dst);
 			err = -EINVAL;
-- 
2.25.1

