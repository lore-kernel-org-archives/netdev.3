Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347530C371;
	Mon,  3 Aug 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747608; cv=none; b=DPbN36XQWI5sPYNep2vbRPkwmemcp35kkPnYeq3pPhRKByPY6oNvkNhdJzGhcGmrf6wYygzhGmPFn7AY3ychl2eI55icrEY3gzjIaa5/r44FxJ0nLqBHKN+jzBXAfgYLm4BQmRSD8jsLOcK4l5GeMDmrDQ2HplCsSGd5dOzmDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747608; c=relaxed/simple;
	bh=fW+ZnD6ITzKhbjRO/NXjeEwOWCuzLzeZeDewcvuHX34=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ER8EhitZEURKBXeI1KxaYZP0gifzT6uxWtmBKAEl2RBCI7hiJGqjL/2eAPG8bU+0zqzZvpnxBP3S0PUxuhz4//lYEIzNCngizdeH1xTNDfGNeWkILu8WbT3mExkJpzqav8uPayubpD7bSuktcVMtnQdj+lhiLxcc2pkLeFHz9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b33cb17c8f1911f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:21643688-a88b-430e-a867-d763699ca3dd,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:680bd878915c164cefe67eb8014956b4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b33cb17c8f1911f1aa26b74ffac11d73-20260803
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1612843656; Mon, 03 Aug 2026 16:59:56 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] net: macvlan: check register_netdevice_notifier() error in macvlan_init_module()
Date: Mon,  3 Aug 2026 16:59:50 +0800
Message-Id: <20260803085950.142325-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macvlan_init_module() ignores register_netdevice_notifier() errors and
continues module initialization, which can leave macvlan loaded without
its netdev notifier registered.

Check the error and fail module initialization early.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 drivers/net/macvlan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 9a4bc99dbf53..4294b433838a 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1906,7 +1906,9 @@ static int __init macvlan_init_module(void)
 {
 	int err;
 
-	register_netdevice_notifier(&macvlan_notifier_block);
+	err = register_netdevice_notifier(&macvlan_notifier_block);
+	if (err)
+		return err;
 
 	err = macvlan_link_register(&macvlan_link_ops);
 	if (err < 0)
-- 
2.25.1

