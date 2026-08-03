Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF839A80E;
	Mon,  3 Aug 2026 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747620; cv=none; b=WmNuIgp5L6msVMxuMc9Z4fTNBO9XqAIy8SR8HpXpl0v8qIzBhNprODeCo9fV7vZEDtBLWzkzfebovzyudFK+apb4M/S8ZskwY7ULplG7d7P1R7tlRewY3MX2OzadMVKassBTVWtGZEvm4lz8ewCy7eRZX+WCgJxjWuW/UE5zwck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747620; c=relaxed/simple;
	bh=VIH08Jp8oVEUiwkyHyg+q88wUh/bfnF7ZD3TIGJTrfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lkrfwbi987BUeIzCOai1YH8cIRjsX+xUShULvvfJZbnRHGldBP7gJeLZhVq7daDZcIS6EU8kkHgCJayD/h3IdOGI4GQFKYdQbSuIkFYEvz96BUGxOPd4TUYne9W1q5Smmy0VDN6ZjtUZbWjp5s3he8rDSxDv/cWh+b8AItIEnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bc59126e8f1911f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:108a83f0-17b5-4c7a-94ab-45a8910c570a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:e3dcf60a25b71a90e680580aecd5bc4d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bc59126e8f1911f1aa26b74ffac11d73-20260803
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 821115204; Mon, 03 Aug 2026 17:00:12 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Dmitry Skorodumov <dskr99@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ipvlan: check register_netdevice_notifier() error in ipvlan_init_module()
Date: Mon,  3 Aug 2026 17:00:07 +0800
Message-Id: <20260803090007.142517-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipvlan_init_module() ignores register_netdevice_notifier() errors and
continues module initialization, which can leave ipvlan loaded without
its netdev notifier registered.

Check the error and fail module initialization early.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 drivers/net/ipvlan/ipvlan_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index ed46439a9f4e..518c7b97deaa 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -1048,7 +1048,9 @@ static int __init ipvlan_init_module(void)
 	int err;
 
 	ipvlan_init_secret();
-	register_netdevice_notifier(&ipvlan_notifier_block);
+	err = register_netdevice_notifier(&ipvlan_notifier_block);
+	if (err)
+		return err;
 #if IS_ENABLED(CONFIG_IPV6)
 	register_inet6addr_notifier(&ipvlan_addr6_notifier_block);
 	register_inet6addr_validator_notifier(
-- 
2.25.1

