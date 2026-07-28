Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDB30E82E;
	Tue, 28 Jul 2026 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208267; cv=none; b=S4ZiqWc/1/wthjVfIPcDYcC3qjLhonTD5p6UbQpQ5zx8/4RQSaqKZgU9FXRhSs+CowcED5UoJ77Mnav7+gaTK6wLg9PPSgNUtQiCZB5EqogptDiIzCk21T6gF53+Y2HYEX3ZLZaqYHoXnGRnemnx1KCmbc+ICSvaJjKxURmZ+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208267; c=relaxed/simple;
	bh=zbzDIac7wN/UD0dBkaiHYxWyG4nv6KeKwKJqNQU5nq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R8rI3PqyQraLWuHY3lC/1MA0byXTv78y3HN27zvprCVbTMTjY5SxdIFHEROXvkS1w1b4D7foyhXh1AWLxLmsX4SjkGUwYzHVwcbQOqu9xIxkO6e4lSXW/mwnzgEAc9Uh7f9vmTYxN1s+7RYHIC3w1ocTCXYnn5UGOuIDza1ItuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f599b5c08a3111f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c6b318ce-08cd-4ace-9b83-857df5e0ee1d,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:991b81fab16968a64d22acced820850e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f599b5c08a3111f1aa26b74ffac11d73-20260728
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1370908918; Tue, 28 Jul 2026 11:11:00 +0800
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
Subject: [PATCH net] ipv4: nexthop: handle errors in nexthop_init()
Date: Tue, 28 Jul 2026 11:10:55 +0800
Message-Id: <20260728031055.76708-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nexthop_init() ignores errors from register_pernet_subsys(),
register_netdevice_notifier() and rtnl_register_many(), so a partial
initialization can appear successful.

Check each step and unwind the registrations that already succeeded.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/ipv4/nexthop.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6205bd57aa85..0ad40d93e3b5 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -4192,12 +4192,26 @@ static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
 
 static int __init nexthop_init(void)
 {
-	register_pernet_subsys(&nexthop_net_ops);
+	int err;
+
+	err = register_pernet_subsys(&nexthop_net_ops);
+	if (err)
+		return err;
 
-	register_netdevice_notifier(&nh_netdev_notifier);
+	err = register_netdevice_notifier(&nh_netdev_notifier);
+	if (err)
+		goto err_unregister_pernet;
 
-	rtnl_register_many(nexthop_rtnl_msg_handlers);
+	err = rtnl_register_many(nexthop_rtnl_msg_handlers);
+	if (err)
+		goto err_unregister_notifier;
 
 	return 0;
+
+err_unregister_notifier:
+	unregister_netdevice_notifier(&nh_netdev_notifier);
+err_unregister_pernet:
+	unregister_pernet_subsys(&nexthop_net_ops);
+	return err;
 }
 subsys_initcall(nexthop_init);
-- 
2.25.1

