Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F730E82E;
	Tue, 28 Jul 2026 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208892; cv=none; b=N3NZhKnARhUzE1d0wA6vzbF20IGTLT6IDh1Oiz3edLFJVbJJDrcB6+dp8OcUHBGr8gzA0aH9RnvooSNX2EgB+mJb+NFWHGIussBqeafHCKwOlLcuAA/0I0Fh9+jeIvvSJk7zeu/ve+fwSDA7aVt4t1NAuTfMqo8klJIp8SpmmJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208892; c=relaxed/simple;
	bh=9iEWdyQIESDP/l9oevkMvP30xZSruDv4LsYJ9Z7/Znw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciey02S9Ope1VdNjt3C5fE5oi6Fp9KE0HaCr0qUYdL0KdpJeZjUexL3QL0R4jkRORWEvKm0CoEWWeOPtzQRvDCByhwwM5GILI0VWiitx1napeajpfVBXJhE8RaJzehtdP5wd+Gu+boXaqbcx82nCZjFmz/v/1sUCdU7ux6jgPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6916f2be8a3311f1aa26b74ffac11d73-20260728
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:97b461e6-e000-4247-b11b-1c288a61bbd1,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:97b461e6-e000-4247-b11b-1c288a61bbd1,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:78d33024e16dc73202ca6fc05e918874,BulkI
	D:260728112125804CV86K,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6916f2be8a3311f1aa26b74ffac11d73-20260728
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 815425078; Tue, 28 Jul 2026 11:21:23 +0800
From: Can Peng <pengcan@kylinos.cn>
To: manishc@marvell.com,
	rahulv@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH 1/2] netxen: unregister notifiers if PCI registration fails
Date: Tue, 28 Jul 2026 11:20:45 +0800
Message-ID: <20260728032046.121631-2-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728032046.121631-1-pengcan@kylinos.cn>
References: <20260728032046.121631-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netxen_init_module() registers the netdevice and inetaddr notifiers before
registering the PCI driver.  If pci_register_driver() fails, the function
returns the error directly and leaves both notifiers registered.

That leaves notifier callbacks installed for a module that failed to load.
Mirror the module exit path on this failure and unregister the notifiers
before returning the error.

Fixes: 6598b169b856 ("netxen: enable ip addr hashing")
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 5ee2bd9d6886..67d9bf69f8f2 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -3447,13 +3447,24 @@ static struct pci_driver netxen_driver = {
 
 static int __init netxen_init_module(void)
 {
+	int ret;
+
 	printk(KERN_INFO "%s\n", netxen_nic_driver_string);
 
 #ifdef CONFIG_INET
 	register_netdevice_notifier(&netxen_netdev_cb);
 	register_inetaddr_notifier(&netxen_inetaddr_cb);
 #endif
-	return pci_register_driver(&netxen_driver);
+
+	ret = pci_register_driver(&netxen_driver);
+#ifdef CONFIG_INET
+	if (ret) {
+		unregister_inetaddr_notifier(&netxen_inetaddr_cb);
+		unregister_netdevice_notifier(&netxen_netdev_cb);
+	}
+#endif
+
+	return ret;
 }
 
 module_init(netxen_init_module);
-- 
2.53.0

