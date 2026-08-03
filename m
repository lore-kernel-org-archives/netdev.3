Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEBF2F7F0F;
	Mon,  3 Aug 2026 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747599; cv=none; b=eZy0wc59bll2HYzkNOraV0WszCPnXfoXHV9JHX99p65G2Jzc+vdR8f3GRU9kxWj9RHTdyTzTNrdjtLZKIYM+hWctrNpveHDWXKoWXAE8NTW9GFE9+G50fI4HiqL6TiBYhg8ltjWvn9FHt6wbQ17hqh/OQ2sPmKP9zww1ra8MPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747599; c=relaxed/simple;
	bh=VjXUlg0eyn1C1U6jWeE7Z01FqnWasKX/Ybom2ps25t0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fyFbfDlvYdo+YTGRBcH+JNisrQVqN6Y5eF3Bl/d1j9fo5Ac3AofidVioA9zX2Td+O+YGByHswJycSU72h+yV8gHAkiC7N8+wIJIOXkHBMKPmIsjNUOYF5qlzO+oJx50mXo01oDYa9JlzmwgIVxgCHJ+7EkMs2/pkzxHNpMApGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: af026e808f1911f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4dc2b882-2c8e-40de-b6da-b49f368ffe7c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:9e6ab94292cd4f5030c9889ad720ef87,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af026e808f1911f1aa26b74ffac11d73-20260803
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 905271328; Mon, 03 Aug 2026 16:59:49 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] net: team: check register_netdevice_notifier() error in team_module_init()
Date: Mon,  3 Aug 2026 16:59:43 +0800
Message-Id: <20260803085943.142261-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

team_module_init() ignores register_netdevice_notifier() errors and
continues module initialization, which can leave the team module loaded
without its netdev notifier registered.

Check the error and fail module initialization early.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 drivers/net/team/team_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index feaa75fbf8fc..beffbe450612 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -3229,7 +3229,9 @@ static int __init team_module_init(void)
 {
 	int err;
 
-	register_netdevice_notifier(&team_notifier_block);
+	err = register_netdevice_notifier(&team_notifier_block);
+	if (err)
+		return err;
 
 	err = rtnl_link_register(&team_link_ops);
 	if (err)
-- 
2.25.1

