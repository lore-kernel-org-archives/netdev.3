Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74D30E82E;
	Tue, 28 Jul 2026 03:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208248; cv=none; b=KI6L8bB4Iqoh4X2N3EnUWtZNcnC1P/DWY7F1Q8fePAfmStg76fkLnmWMeJbCMS9v2O/LdPnK4WZmuEiGIKF34m69on+mWJF88HZ3IMkV+XWcBoDWEy1t7ls3uoAqCUx3Y5jT+Yvvv6ntb5meVx4s5kbNAV1VGVib7Bg2MUkb9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208248; c=relaxed/simple;
	bh=w0AkUZbmPzZthixNL/8ll/amym2kaWjn6bjJ3JC7k34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+qK0Uhjfk51rGGGrk+Xd6klpVYBCa6cwu4SPP/L5yFMO/SWHMyrtFKPBx5dRbvZ+tVKpYsVnaWgxvmLilH173ZFyi9ePodiXaoAWXLifYcTZug5RbZMpBEIXmn4yHgPuigyTYHSceDQXMOXlJ3iDCcaMSoeu+f1gYzEZFI8c/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e863de128a3111f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:01cd3472-8ee2-4cf8-adcf-44ff07197baf,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:561533203ae85b9c0abaa7cc9a2adaf8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e863de128a3111f1aa26b74ffac11d73-20260728
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 562120143; Tue, 28 Jul 2026 11:10:38 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] net: failover: check register_netdevice_notifier() error in failover_init()
Date: Tue, 28 Jul 2026 11:10:33 +0800
Message-Id: <20260728031033.76431-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

failover_init() ignores register_netdevice_notifier() errors and always
returns success, which can leave the failover module loaded without its
netdev notifier registered.

Check the error and fail module initialization early.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 net/core/failover.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/failover.c b/net/core/failover.c
index e43c59cd6868..b28cc6f77204 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -302,7 +302,11 @@ EXPORT_SYMBOL_GPL(failover_unregister);
 static __init int
 failover_init(void)
 {
-	register_netdevice_notifier(&failover_notifier);
+	int err;
+
+	err = register_netdevice_notifier(&failover_notifier);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.25.1

