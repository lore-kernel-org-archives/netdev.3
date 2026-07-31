Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125931F9BD;
	Fri, 31 Jul 2026 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785466385; cv=none; b=NACR4u6EZecVNfWdaqE+cwX7wFAyC9gGJg6rfDkT+hSXEvihDBkVUOXdl1mmYYO0G7qJaWrHW8Q/DPhzU1jgPYa3tGr1jP6tCd/UHfjCE1TzhAP4qq+VxdojX4pikHxGf4bdj9uDZ2UNmSiitybyI0kGWfGl7xMP1KdORq3xhsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785466385; c=relaxed/simple;
	bh=7Rqhg++on5uznFdRUImExOavpvo9WaJ/P8R7OHvzbBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tV8mt5kIZQZ/ur2mJoFhNKEbLQdrDQ8BLv+HXt2iNlYC/0WR+/QkoZQk8ITB9t9j7BChcvuZwWwfbyVteAlGUOnbgDmS4DRVr4aSNoWds/++ZSVtcWTHfEADDV0bLcfKol1fzpPbv5/+g1d5KCVZFiB4uAi7aMfYpo0T5VQ1vIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ee9a78d08c8a11f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:49789ac1-c614-42c4-902d-f2969add941b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:4c001bb45a3e360b866626ede072f9f0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-19|2,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ee9a78d08c8a11f1aa26b74ffac11d73-20260731
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1947232340; Fri, 31 Jul 2026 10:52:56 +0800
From: Minhong He <heminhong@kylinos.cn>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] ipv4: nexthop: handle errors in nexthop_init()
Date: Fri, 31 Jul 2026 10:52:49 +0800
Message-Id: <20260731025249.80026-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nexthop_init() ignores errors from register_pernet_subsys() and
register_netdevice_notifier(), so a partial initialization can appear
successful.

Check those steps and unwind prior registrations on failure.

Do not check rtnl_register_many(): for built-in code it panics on
failure, so the call cannot return an error to nexthop_init().

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
v2:
- Drop rtnl_register_many() error handling; built-in registration panics
  on failure
- Retarget to net-next
v1: https://lore.kernel.org/all/20260728031055.76708-1-heminhong@kylinos.cn/

 net/ipv4/nexthop.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6205bd57aa85..aa2fa17391e7 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -4192,12 +4192,22 @@ static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
 
 static int __init nexthop_init(void)
 {
-	register_pernet_subsys(&nexthop_net_ops);
+	int err;
 
-	register_netdevice_notifier(&nh_netdev_notifier);
+	err = register_pernet_subsys(&nexthop_net_ops);
+	if (err)
+		return err;
+
+	err = register_netdevice_notifier(&nh_netdev_notifier);
+	if (err)
+		goto err_unregister_pernet;
 
 	rtnl_register_many(nexthop_rtnl_msg_handlers);
 
 	return 0;
+
+err_unregister_pernet:
+	unregister_pernet_subsys(&nexthop_net_ops);
+	return err;
 }
 subsys_initcall(nexthop_init);
-- 
2.25.1

