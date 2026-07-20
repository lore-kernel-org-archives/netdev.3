Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E62E7396
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532337; cv=none; b=lbsSVS9Ya07uiAlpwP0huJNfxhX/HjEDvXab3QI2RNgS2FCW+ysB4ZHOmrGVOSaObmwo6ZjbmNXSyLkke3M3iZ6SBL6STSb5UTtA5ptWeibYrbrv8+Kj3QD4jB/oSMqVdqfQ12egzYv2sMLxgut6TeOnrHGrvM8wEa/SRz4a7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532337; c=relaxed/simple;
	bh=NbmgxLXhpCKxAgN2n9FuDbcBws/Tl00O0m+FCw6b9G8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MdXTFNVrQDCuwMiy/ZyCHaBgkij71Yhop9HKgqxb9cthFjdHdSJIz6teivrGZmmYxlyHy56JkRG6Dx9SCKRUpYLGpuOzZOOAKsMsoJcucuEoGiPDytAWADcYM9XO2/aWmH9ouP52zfFc8RnQMqInQbnLd7UjZBie1sBjG9CbAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2e074b88840c11f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c6d49c04-9d49-426e-882d-e18531c8c4c2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:66c14f0a432845ab5aae7abab80c4c37,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2e074b88840c11f1aa26b74ffac11d73-20260720
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1033594482; Mon, 20 Jul 2026 15:25:27 +0800
From: Minhong He <heminhong@kylinos.cn>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com
Cc: heminhong@kylinos.cn,
	netdev@vger.kernel.org
Subject: [PATCH net v3] mctp: check register_netdevice_notifier() error in mctp_device_init()
Date: Mon, 20 Jul 2026 15:25:18 +0800
Message-Id: <20260720072518.112614-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mctp_device_init() handles errors from rtnl_af_register() and
rtnl_register_many(), but ignores the return value of
register_netdevice_notifier(). If notifier registration fails, init can
still return success while the module is only partially initialized.

Check the notifier registration error and fail module init early.

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
v3:
- Correct Fixes tag to 583be982d934 (bug predates d51705614f66).
- No Cc:stable (unlikely init failure path; stable would also need
  d51705614f66 as a prereq on older trees).
v2: https://lore.kernel.org/netdev/20260716063534.116793-1-heminhong@kylinos.cn/
v1: https://lore.kernel.org/netdev/20260713073918.419422-1-heminhong@kylinos.cn/

 net/mctp/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 2c84df674669..822120e860c8 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -536,7 +536,9 @@ int __init mctp_device_init(void)
 {
 	int err;
 
-	register_netdevice_notifier(&mctp_dev_nb);
+	err = register_netdevice_notifier(&mctp_dev_nb);
+	if (err)
+		return err;
 
 	err = rtnl_af_register(&mctp_af_ops);
 	if (err)
-- 
2.25.1

