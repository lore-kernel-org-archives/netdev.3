Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8A224234;
	Tue, 28 Jul 2026 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208882; cv=none; b=TWraEKVkfg+Tn/gG1Epaa712/oQdwCp2XCWfFWjun2El77FY+JXQXmbuqHEMdUMg0KllPo0SHdDsQzAIMm2WmI5TA3/wX9Rh1GO7ueBJe2as1KeieT3JAZ/KlyEjJ6934dKOjK+gzcoxgtSpxiAVyv1iLaxV0Obyzo3up1s/9nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208882; c=relaxed/simple;
	bh=QlTe2+ISsWRg8PCY63dli0hoWaZzKYkC1qK6m+EsnPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGL0ksNCTitw8bAk2sJadwTuSR361sVvCWroGBtbRZNwJS4ayO3Uju4Y8IWRKOL46h020epib6+lFB37Mo8KOFf2V0hzFnhf94pfUZBau7xUvKkPfUCINN9uBLAvdhAMXs6fOUibPoAiHFpTd5sIU0ZnSfZnP88eeWmZW/H5dDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6380a1428a3311f1aa26b74ffac11d73-20260728
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
X-CID-O-INFO: VERSION:1.3.12,REQID:e23c7dbb-a87c-4bf4-90c0-e5f4a9652d25,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:e23c7dbb-a87c-4bf4-90c0-e5f4a9652d25,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:b7cbd2e653cad50a28f238e39adb7da7,BulkI
	D:260728112116C3PJBXYW,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6380a1428a3311f1aa26b74ffac11d73-20260728
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1160837277; Tue, 28 Jul 2026 11:21:14 +0800
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
Subject: [PATCH 0/2] qlogic: fix and tidy notifier cleanup paths
Date: Tue, 28 Jul 2026 11:20:44 +0800
Message-ID: <20260728032046.121631-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes and tidies notifier cleanup in the qlogic Ethernet
drivers.

Patch 1 fixes netxen by unregistering the netdevice and inetaddr
notifiers if pci_register_driver() fails. Without this, module init can
return an error while leaving callbacks registered for a module that did
not load successfully.

Patch 2 keeps qlcnic's existing notifier cleanup error path under the
same CONFIG_INET guard as the notifier registration, avoiding an empty
if statement when CONFIG_INET is disabled.

Can Peng (2):
  netxen: unregister notifiers if PCI registration fails
  qlcnic: move notifier error cleanup under CONFIG_INET

 .../net/ethernet/qlogic/netxen/netxen_nic_main.c    | 13 ++++++++++++-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c    |  4 ++--
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.53.0

