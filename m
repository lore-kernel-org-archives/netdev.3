Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E33FBEB8;
	Thu, 16 Jul 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196918; cv=none; b=s9tAD66pGei+3Bmx2Fb5NPZYdTbYiXmZxR5y9A+uxvpagKybUkMp4S8my5HwvF4fSKq63m/IRSpqQtdkFWOEcKbSfInTg6xJI2RNiOHgLRmEX3Wg4c7ywyS3BZ3BAMH6buwPfQYFYVhwo39XczRb7o7ytTSecnjIRbaim0qLBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196918; c=relaxed/simple;
	bh=F6zxoCTVtRAFR5DuG1jCDdnxViSPJW+v9TONdatUqxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVxOKAI5bELdRBmV+qm4BB6CvbLuSxoE4ygEZAZuxlXl5oxksOIK4zNMHQs9qCskqyBDfYf4EFwAseBlkG5A/2IRZFUhTTOk+IllXdWLfTVI93dVL4Q2j9OLkW/KnH8SUeSIdKnjG1IiSh4tfTQ0eg7c5ukrMFhsChAbQYeKOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3a44e85c80ff11f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8921d6fb-05a7-4c57-be43-80be2834340c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:9a37fe03b14288cc02d888aa2ef85f33,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3a44e85c80ff11f1aa26b74ffac11d73-20260716
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 510243431; Thu, 16 Jul 2026 18:15:10 +0800
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
Subject: [PATCH net v2] phonet: check register_netdevice_notifier() error in phonet_device_init()
Date: Thu, 16 Jul 2026 18:15:04 +0800
Message-Id: <20260716101504.158387-1-heminhong@kylinos.cn>
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

Check the notifier registration error and unwind only the resources
that were already registered (proc entry and pernet), without calling
unregister_netdevice_notifier() for a notifier that was never
registered.

Fixes: f8ff60283de2 ("Phonet: network device and address handling")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
v2:
- On notifier registration failure, unwind only proc/pernet; do not call
  phonet_device_exit() / unregister_netdevice_notifier() for a notifier
  that was never registered.
v1: https://lore.kernel.org/netdev/20260713075212.431455-1-heminhong@kylinos.cn/

 net/phonet/pn_dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index ad44831d6745..e6c31cfdad9a 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -356,7 +356,12 @@ int __init phonet_device_init(void)
 
 	proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
 			sizeof(struct seq_net_private));
-	register_netdevice_notifier(&phonet_device_notifier);
+	err = register_netdevice_notifier(&phonet_device_notifier);
+	if (err) {
+		remove_proc_entry("pnresource", init_net.proc_net);
+		unregister_pernet_subsys(&phonet_net_ops);
+		return err;
+	}
 	err = phonet_netlink_register();
 	if (err)
 		phonet_device_exit();
-- 
2.25.1

