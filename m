Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D603C3456;
	Mon,  3 Aug 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747630; cv=none; b=byWuPEXbcFbUCj1eHRuKkK4QyCukbsu1NuZV5vaf02Li8bUFxmWiOnjbp7uh6ZHMlNTt0OC7OvfIHJ+vPJZfO6vj3q4beXKbzwGXoNvItUImE5tpQEe/N7dP7F+P2IY018UpUSINUR40wRKG5SEx+GU9zkwU0FdQ21V2MWOa0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747630; c=relaxed/simple;
	bh=r+s4T/bxe+7zy6LKh7gyPESXs/6nwAYf5mIeKtAiNj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g5JSUgUegWEMbZ2F9d5emj/wbJOctUc09/PvM6wI45HXdsCp9bgLKKCTDmt4b6m2GqTiF1SrIVW5mJPN7lQftIftAF5Ixw0OrXNYCWHcAYhbDmYOirf3dQm4A7AexMm3V6WWECoO26fXHVoJnmFhAgk3M3C+0u4FRZX4upu+Xn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c09c42888f1911f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3829f947-a2b4-4436-acc0-6f79ecc6d273,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:f777a6cecf48cd3b061ff901c6e6e665,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c09c42888f1911f1aa26b74ffac11d73-20260803
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 734913476; Mon, 03 Aug 2026 17:00:19 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bonding: check register_netdevice_notifier() error in bonding_init()
Date: Mon,  3 Aug 2026 17:00:12 +0800
Message-Id: <20260803090012.142638-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bonding_init() ignores register_netdevice_notifier() errors and still
returns success, which can leave the bonding module loaded without its
netdev notifier registered.

Check the error and unwind prior initialization on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 drivers/net/bonding/bond_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e1bec8164221..3405a20bd498 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6637,7 +6637,9 @@ static int __init bonding_init(void)
 				flow_keys_bonding_keys,
 				ARRAY_SIZE(flow_keys_bonding_keys));
 
-	register_netdevice_notifier(&bond_netdev_notifier);
+	res = register_netdevice_notifier(&bond_netdev_notifier);
+	if (res)
+		goto err;
 out:
 	return res;
 err:
-- 
2.25.1

