Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8A379997
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140070; cv=none; b=Ga3myPj6nTlF0+gQlUfZljFuFnIizgmjvJuMuGFI5dHs+XsE2nzJmTBQoPth+WkQ/O06Q65EvRK81vRg7mlvGOBOl+zoqc4v4L6SyNfuue4uGcWa+qfxLhYrz4FttJ4BUXqEBi0J7N9CfHFwjSEKMPqzCMdt0ub4Hgnv5UXPWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140070; c=relaxed/simple;
	bh=L3OldUJh3BnS9U3kvXaxxc9dfz8BC6CD0xrNFBhboQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Od+RFDRqoN3aEQsY/NJGiQA+uT/QHGafL3qNziFIC+LgO9vOXIkA2e0EKiAae+65L8XKeQ8OLmX8gJNuZhqCG0sTJhOrpMU3XlrhpnIh8hZGc0Ces3V5wqCkW1mdzZgUuC0Nl0RNtoJOsH4ScnDi+SS4Ma2vGDAYmBbQ0TpQkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][net-next] net: vrf: switch to synchronize_net() when releasing routes
Date: Tue, 10 Mar 2026 06:53:31 -0400
Message-ID: <20260310105331.2371-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Replace synchronize_rcu() with synchronize_net() in vrf_rtable_release()
and vrf_rt6_release().

synchronize_net() is RTNL-aware and can use the more efficient
synchronize_rcu_expedited() when the RTNL lock is held, avoiding
potentially long wait times for a standard RCU grace period.

Since these release functions are called during device teardown where
the RTNL lock is typically held, this change reduces the time spent
in RTNL critical sections and speeds up VRF device deletion.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/vrf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 8c009bc..92a0f4b 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -755,7 +755,7 @@ static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
 	struct dst_entry *dst;
 
 	RCU_INIT_POINTER(vrf->rt6, NULL);
-	synchronize_rcu();
+	synchronize_net();
 
 	/* move dev in dst's to loopback so this VRF device can be deleted
 	 * - based on dst_ifdown
@@ -1002,7 +1002,7 @@ static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
 	struct dst_entry *dst;
 
 	RCU_INIT_POINTER(vrf->rth, NULL);
-	synchronize_rcu();
+	synchronize_net();
 
 	/* move dev in dst's to loopback so this VRF device can be deleted
 	 * - based on dst_ifdown
-- 
2.9.4

