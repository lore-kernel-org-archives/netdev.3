Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B43B9920;
	Mon,  3 Aug 2026 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747610; cv=none; b=lrEp7YkKMFU2GoTViH4CyD1XmIFVl9hKZB8/VwRL1xHtg7K9BFWpCLGfXHebpfwvPIH1QTO6jlqmygmZulc5/t0ya1ZPjCdIxaODaH6rwaUhIkS9jG98KuVH47v743slNAIY9lpQYzm0BB+WB6kHG03tCGVSMouzyRNEIC56lAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747610; c=relaxed/simple;
	bh=On6AeXmL5MmXvg+tuP0Uyomt21gRrEEI8ou+H4MWxak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ucsZpWy1UeM8VvBVwX0jSwJtVknvnzjYWUc74UwYV5/8IoE2l71XfJ92mh8GydyocICv1Nv7Is96ohAgAhWFB973tmmYwatcHNOAwGRLZpCRJx8WBQxKusMK7XZlrdwshyAonm/tyYPUDDjRTI4QLB8Oe86d0qdv1TcxhA5aiFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b93890468f1911f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:31218849-46cc-43f7-b6de-3b8eebc49c31,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:c51f43f500fb0d3091a650bbe385cd76,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b93890468f1911f1aa26b74ffac11d73-20260803
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2005699638; Mon, 03 Aug 2026 17:00:06 +0800
From: Minhong He <heminhong@kylinos.cn>
To: David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] net: vrf: check register_netdevice_notifier() error in vrf_init_module()
Date: Mon,  3 Aug 2026 17:00:02 +0800
Message-Id: <20260803090002.142453-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vrf_init_module() ignores register_netdevice_notifier() errors and
continues module initialization, which can leave VRF loaded without its
netdev notifier registered.

Check the error and fail module initialization early.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 drivers/net/vrf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 46209917ae4d..a0557a3a7026 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1932,7 +1932,9 @@ static int __init vrf_init_module(void)
 {
 	int rc;
 
-	register_netdevice_notifier(&vrf_notifier_block);
+	rc = register_netdevice_notifier(&vrf_notifier_block);
+	if (rc < 0)
+		return rc;
 
 	rc = register_pernet_subsys(&vrf_net_ops);
 	if (rc < 0)
-- 
2.25.1

