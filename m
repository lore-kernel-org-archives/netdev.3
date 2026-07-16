Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46E5477E
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183748; cv=none; b=C+8bB5udx0uIR/9j41GGiP8UFwo6mX8oIQPzKI66UmtAx8yb3A51kid0IJpMIV5lbvvxKG/8+HjTPe3prwhl3mxmvwmjPqU79eWtZUH4ZHvTlBONO6NvEBnerjgwe5/D+6PDaME72pxaVpSKEFUx2R32vxw6KPTezrF9dZEvJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183748; c=relaxed/simple;
	bh=XOSLJtUwqXLcB9Y9NuETyjtm9l+vOiFdbXsyssAhiYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ioiZP858amxxho9+jvqpvgz2z3n9DIgjQtMGKHsbWf1OZsVv55DOOwBQMzIzawXMtiFzEcqEkcUSTkxVHTE04v5ZibAZ3in1SVVKK+CDnwlV/cCLn82ae0rcDTXlDOujvjdKiV7SKki0ctCphL9l/NcEM2GRACqGpnNk28hKSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 90a956b680e011f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dfa832d8-3b24-48f2-a346-37e6e52d9a00,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:0147c24ce978ca9d1758202413875cac,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 90a956b680e011f1aa26b74ffac11d73-20260716
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 851581052; Thu, 16 Jul 2026 14:35:41 +0800
From: Minhong He <heminhong@kylinos.cn>
To: jk@codeconstruct.com.au
Cc: heminhong@kylinos.cn,
	matt@codeconstruct.com.au,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com
Subject: [PATCH net v2] mctp: check register_netdevice_notifier() error in mctp_device_init()
Date: Thu, 16 Jul 2026 14:35:34 +0800
Message-Id: <20260716063534.116793-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20d74693ac673ba1db0c0052a7236db777fc5ec5.camel@codeconstruct.com.au>
References: <20d74693ac673ba1db0c0052a7236db777fc5ec5.camel@codeconstruct.com.au>
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

Fixes: d51705614f66 ("mctp: Handle error of rtnl_register_module().")
Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
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

