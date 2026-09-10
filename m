Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366054949F2
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048344; cv=none; b=kZBwvfuBUZuZgde1Nnn7nrniEr3J0kAizD+mhFoVaUE/I4FUxs3RihUa/9qeitjjNB95nMCQc6aglGmC7/ZPvXLYqZXPY/b8e533D+EFHGtjpn4J4YUhMDZ4gWPo+ICMUYh15fc1Jz1O7ji8AU8msd1o4EzMecL199TDqWADnM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048344; c=relaxed/simple;
	bh=FWNkayyt98XWizn+TnLX4IeeWjcWx693RzsE5aZPFOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DQQc4OgbFh4AMiXX/ZftYaf6nvhp5K8ZbpPaGYKPaNha9ltKelXU+WAEtV/0LCmPVJp8fCSAwSm9JZd4vWTTAOLb0MFQKkI8HbM74128h7ZaA6/UHR5JHewckXygKZcYwq9r0qOVO1GM+UVIKKnOGJaSPVb6kVlXZpSZAE8Znd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hoB8B5Oi; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hoB8B5Oi"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CezzRRH2VOMxiELJvJIAlqhXHUwdxVIitGvfkBQTXuw=;
	b=hoB8B5OiMzIeTExhQ2Zv1/eQlTlMt6m7sRQdhHCVgJfKWaevECSpKfKbZ/bTPUtaL+5SCuKWK
	nO17t5bUC0n6YfR3098pErN3/bF/uaq0JYllvSnXN+5PXSpLzIT9iXGvZRJB5fTT7yudYscwuit
	pIVEbyG/ixOTLd7TLJ1DxUE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hgf2l4RrsznTVd;
	Thu, 10 Sep 2026 21:41:03 +0800 (CST)
Received: from whupemk100012.china.huawei.com (unknown [7.152.185.0])
	by mail.maildlp.com (Postfix) with ESMTPS id 126DE402AB;
	Thu, 10 Sep 2026 21:52:12 +0800 (CST)
Received: from localhost.localdomain (10.50.85.175) by
 whupemk100012.china.huawei.com (7.152.185.0) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 10 Sep 2026 21:52:10 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <herbert@gondor.apana.org.au>, <jiayuan.chen@linux.dev>
CC: <netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>, Dong Chenchen
	<dongchenchen2@huawei.com>
Subject: [PATCH net v5] ipv4: icmp: reject RTN_UNREACHABLE input routes in icmp_route_lookup
Date: Thu, 10 Sep 2026 22:00:42 +0800
Message-ID: <20260910140042.1880242-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemk100012.china.huawei.com (7.152.185.0)

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

Reject input route that is RTN_UNREACHABLE to fix it. The net warning
is only printed for RTN_LOCAL, as RTN_UNREACHABLE is not the result of
a race condition.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
v2:
- RTN_UNICAST judgement will reject bforward packet. Only reject RTN_UNREACHABLE
v3:
- RTN_UNREACHABLE dont need warn log. 
v4:
- Modify the comments and commit msg to make them more accurate.
v5:
- avoid going over 80 chars
---
 net/ipv4/icmp.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 0caedfc7ca92..90c0e22c29be 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -581,16 +581,19 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 		skb_dstref_restore(skb_in, orefdst);
 
 		/*
-		 * At this point, fl4_dec.daddr should NOT be local (we
-		 * checked fl4_dec.saddr above). However, a race condition
-		 * may occur if the address is added to the interface
-		 * concurrently. In that case, ip_route_input() returns a
-		 * LOCAL route with dst.output=ip_rt_bug, which must not
-		 * be used for output.
+		 * fl4_dec.daddr is not expected to be local here, but it can be
+		 * added to an interface concurrently, in which case
+		 * ip_route_input() returns a LOCAL route. It can also fail to
+		 * build a forwarding route towards fl4_dec.daddr, for example,
+		 * when forwarding is disabled, and return an UNREACHABLE route.
+		 * Both cases will result in a route with dst.output=ip_rt_bug,
+		 * which must not be used for output.
 		 */
-		if (!err && rt2 && rt2->rt_type == RTN_LOCAL) {
+		if (!err && rt2 && rt2->rt_type == RTN_LOCAL)
 			net_warn_ratelimited("detected local route for %pI4 during ICMP sending, src %pI4\n",
 					     &fl4_dec.daddr, &fl4_dec.saddr);
+		if (!err && rt2 &&
+		    (rt2->rt_type == RTN_LOCAL || rt2->rt_type == RTN_UNREACHABLE)) {
 			dst_release(&rt2->dst);
 			err = -EINVAL;
 		}
-- 
2.25.1

