Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D933B7B7D;
	Mon,  3 Aug 2026 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747614; cv=none; b=Kvo9AIT6smrlE3j3bVoHlYpef7R56M8AhO84GLtiMHGnncaIc4WaXy5kQhAfQ5G9B8si+f7jNLI9nCryEErCNnHiyzZJazGqpGfC80ccU0XG6ynirU1iKjCSCFwiXmw9x8tz3tWJnkcb/ELDfM5200LAzpGeSibZACrXHGCQfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747614; c=relaxed/simple;
	bh=fBrHYonxHWYsrAQNzo/czHdSxqDEJUG0t17psnp9W2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PQeks/T6Vb4fQ44BzGS/vv3959V95gRwDGqo9ApqqEcXViNyZrQIR9SwRv63DYmQcVa9W9apjOfleqHx9CJ1L6NSzotfMxS0GfQ1VW+KeNjnR5LUkV5PdmBrUnETWlOm3TtC5WDlbahMhdoRiUouMtuBYL2ui5irjeuqItT6F2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b65e7a3e8f1911f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ed95633e-751f-4258-bfd3-579c5a931d1d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:d92519df59625fe6b5faa82e493feb2e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b65e7a3e8f1911f1aa26b74ffac11d73-20260803
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1541270778; Mon, 03 Aug 2026 17:00:02 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: pppoe: check register_netdevice_notifier() error in pppoe_init()
Date: Mon,  3 Aug 2026 16:59:57 +0800
Message-Id: <20260803085957.142386-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pppoe_init() ignores register_netdevice_notifier() errors and always
returns success after installing packet handlers, which can leave the
module loaded without its netdev notifier registered.

Check the error and unwind the packet handlers and protocol registration
on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 drivers/net/ppp/pppoe.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 4a018acb5262..035795b120e0 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -1278,10 +1278,19 @@ static int __init pppoe_init(void)
 		dev_add_offload(&pppoe_packet_offload);
 	dev_add_pack(&pppoes_ptype);
 	dev_add_pack(&pppoed_ptype);
-	register_netdevice_notifier(&pppoe_notifier);
+
+	err = register_netdevice_notifier(&pppoe_notifier);
+	if (err)
+		goto out_unregister_packs;
 
 	return 0;
 
+out_unregister_packs:
+	dev_remove_pack(&pppoed_ptype);
+	dev_remove_pack(&pppoes_ptype);
+	if (IS_ENABLED(CONFIG_INET))
+		dev_remove_offload(&pppoe_packet_offload);
+	unregister_pppox_proto(PX_PROTO_OE);
 out_unregister_pppoe_proto:
 	proto_unregister(&pppoe_sk_proto);
 out_unregister_net_ops:
-- 
2.25.1

