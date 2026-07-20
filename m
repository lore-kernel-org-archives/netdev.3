Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A93D279358;
	Mon, 20 Jul 2026 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530854; cv=none; b=eytbn4ybtbykbdWCyzxQSD8p/Vk8ZKyjuf7xiccOEr95/eozDBvacsKOoHz7fc5ioOshLgIVK+RC+Jyk1FpK+amm0v9GMz6xYnH6B5mui7piR7oxoFd8GGj0hlA9ySNSShZ0xqyo9f6E+AJyZUpjFn+KOJcE6ruWxnx3ucmFmIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530854; c=relaxed/simple;
	bh=fBRBhV7GujRQxIDVoi3pk67zxTIhTnPiUCtz2ZirBTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=igO6JsxvFzkVbYZtCHPweszR3kCUHN37CYYqvZV7lTlOPtOdjpcL5o7oBMDgYNvVV8Qs7onOhyh6TP3fNvmpdGzLXUuMIhBLl50kbLOfOgc+xYzpSlHdO3TOV4Xy040eb3WTsEmWTQ8snWnrAcfPAGFSYLkAdoupXtW0Ht+RchE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b6931b70840811f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f09353fc-fae2-4083-96a1-a7cc91604880,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:51e01d3e3375f9c994b0ec6729f5432f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b6931b70840811f1aa26b74ffac11d73-20260720
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1271551701; Mon, 20 Jul 2026 15:00:38 +0800
From: Minhong He <heminhong@kylinos.cn>
To: courmisch@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	remi.denis-courmont@nokia.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minhong He <heminhong@kylinos.cn>
Subject: [PATCH net v3] phonet: check register_netdevice_notifier() error in phonet_device_init()
Date: Mon, 20 Jul 2026 15:00:31 +0800
Message-Id: <20260720070031.108248-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phonet_device_init() registers a netdevice notifier before calling
phonet_netlink_register(), but does not check whether notifier
registration succeeded. On failure, netlink setup still proceeds and
init may return success without the notifier in place.

Also, the existing phonet_netlink_register() failure path called
phonet_device_exit(), which runs rtnl_unregister_all() even though
rtnl_register_many() already unwound any partial registration. Calling
the full exit helper on a partial init is not correct.

Check each registration error and unwind only the steps that have
succeeded so far.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
v3:
- Use goto-based unwind; do not call phonet_device_exit() on
  phonet_netlink_register() failure (avoids rtnl_unregister_all()
  after rtnl_register_many() already unwound).
- Drop Fixes tag (theoretical init failure path; not suitable for
  stable autosel).
v2: https://lore.kernel.org/netdev/20260716101504.158387-1-heminhong@kylinos.cn/
- On notifier registration failure, unwind only proc/pernet.
v1: https://lore.kernel.org/netdev/20260713075212.431455-1-heminhong@kylinos.cn/

 net/phonet/pn_dev.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index ad44831d6745..f41322a12fb7 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -350,16 +350,30 @@ static struct pernet_operations phonet_net_ops = {
 /* Initialize Phonet devices list */
 int __init phonet_device_init(void)
 {
-	int err = register_pernet_subsys(&phonet_net_ops);
+	int err;
+
+	err = register_pernet_subsys(&phonet_net_ops);
 	if (err)
 		return err;
 
 	proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
 			sizeof(struct seq_net_private));
-	register_netdevice_notifier(&phonet_device_notifier);
+
+	err = register_netdevice_notifier(&phonet_device_notifier);
+	if (err)
+		goto err_pernet;
+
 	err = phonet_netlink_register();
 	if (err)
-		phonet_device_exit();
+		goto err_notifier;
+
+	return 0;
+
+err_notifier:
+	unregister_netdevice_notifier(&phonet_device_notifier);
+err_pernet:
+	unregister_pernet_subsys(&phonet_net_ops);
+	remove_proc_entry("pnresource", init_net.proc_net);
 	return err;
 }
 
-- 
2.25.1

