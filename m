Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF423451CC;
	Fri, 31 Jul 2026 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785467036; cv=none; b=kyEuQOZWn8lEcwFU3IAiHEn4GTn8Pa8BarRRehcHqEsZ4tWXCsJZ0REloRUK2xYrhyjML4Q2oqivET49t/uQ7Dwin1+TSJ1MJJY+T3MGbQMzz+OrpMFiVR6xDf1DpMmd6Dc78lQLZ35jMyWnlajJd5/tB9nZOoHvAJ5r4rkBX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785467036; c=relaxed/simple;
	bh=9KHkSzEhruCS2Q5oN8b62MMlV9BioHQJbxctx90Q/6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Szu34GkqcFdrqaEnoSIa/7T58EOUq6E9OGENFZ6IaxB5XrObqKCwRXqXDFFvRcuG4yoJ0jYRDGej+KFxnz/tOLyEIBfcqQwGgPdfvJ61VKxzr7viUg4vwxBY9Pe+d3am1OQLLPW7uWKUMD8UuR65SRmlyRummv7qFSwjK408rIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 70398c0e8c8c11f1aa26b74ffac11d73-20260731
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2dca949f-1f78-4a64-b54e-5edd10bf00cc,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:7abdec38d2a70d8eefdbc76a363fb518,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 70398c0e8c8c11f1aa26b74ffac11d73-20260731
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 911904908; Fri, 31 Jul 2026 11:03:43 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: failover: check register_netdevice_notifier() error in failover_init()
Date: Fri, 31 Jul 2026 11:03:38 +0800
Message-Id: <20260731030338.82508-1-heminhong@kylinos.cn>
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

Return the notifier registration result directly so module initialization
fails when registration fails.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
v2:
- Return register_netdevice_notifier() directly
v1: https://lore.kernel.org/all/20260728031033.76431-1-heminhong@kylinos.cn/

 net/core/failover.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/core/failover.c b/net/core/failover.c
index e43c59cd6868..4c3894a02cb7 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -302,9 +302,7 @@ EXPORT_SYMBOL_GPL(failover_unregister);
 static __init int
 failover_init(void)
 {
-	register_netdevice_notifier(&failover_notifier);
-
-	return 0;
+	return register_netdevice_notifier(&failover_notifier);
 }
 module_init(failover_init);
 
-- 
2.25.1

