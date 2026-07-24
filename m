Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6613A5E7A;
	Fri, 24 Jul 2026 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885514; cv=none; b=fDPTlmMbHCymI7DRQC277w3rCIgPs4sxOZjCC57abCzWG8bv0mw6H+V0QXGXgLLgnajUXhrEZfeppRo9IlsJ8zE8xo30YWmfOVHpnLP4bZqWUp3JcCjp20wfHxge05xtOaz2gU3/enr13/a9SBtuxnROANqStglAXDK5+kAiHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885514; c=relaxed/simple;
	bh=WASowcMDREg0X0xQrIapTqqwJBQsdHXbuMt6IVmtmMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VDg4ltrA965QeGdvV6B9JV7r0/BuXpcukjC+VBKAMl/hd76gb4x8FsVuX39wVNtXUXrOlnEqSbRdi+79YGXNvJlTYe9ETSz1KavDp7raBZW1C0DulQyZMpEX1Gv1yKQmpSs3G7HpYYBQKcgDTHFeAMM8IHexjuafe8FsFVawdW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Twzvfip2; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Twzvfip2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=blL6kEEmVDew8qIcIPtUsHVslHNRcqKKQ/3setF3gWU=;
	b=Twzvfip2o9KOvRSn2By3Itxi0vvBbEI3k4XMfbvVns/1W3XIjP3ogIaN+T55W3wPvygMh/GzN
	BNdjNcY8REUaazJpg/uJRA+zQPIhwNRCCH8oaQ6MB1wyqlrXL/25L7xjfq5aYIoM5l60zv/T+Oj
	u980jlC4dwl7UIYGUV9QONo=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h62ZS1HBFz1T4Jg;
	Fri, 24 Jul 2026 17:22:24 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 93D544057F;
	Fri, 24 Jul 2026 17:31:47 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 24 Jul 2026 17:31:46 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net] net: hns3: fix speed configuration residue after driver reload
Date: Fri, 24 Jul 2026 17:30:36 +0800
Message-ID: <20260724093036.426631-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)

After setting a 100G optical port to 40G via ethtool and reloading
the driver, the port remains at 40G instead of reverting to the
firmware default speed of 100G.

The commit referenced in Fixes: added two overwrites in
hclge_init_ae_dev() for non-copper media, so that optical ports
connected to forced-mode remotes inherit the firmware-preset
autoneg and speed instead of the hardcoded defaults:

  req_autoneg = mac.autoneg
  req_speed   = mac.speed         (when autoneg disabled)

The autoneg overwrite keeps existing behavior:
hclge_set_autoneg_speed_dup() already uses mac.autoneg (not
req_autoneg) since it was introduced, so autoneg inheritance from
firmware was already in place. This part is kept.

The speed overwrite, however, introduces the residue: mac.speed
reflects whatever was last programmed into the MAC, and after unload
firmware does not restore the MAC speed to the flash default. So if
the user changed speed via ethtool in a prior load, mac.speed still
carries that value on reload and req_speed inherits it.

Fix by dropping the req_speed overwrite only. req_speed keeps the
firmware default value set in hclge_configure() (cfg.default_speed),
so a reload reverts the speed to default, matching the expectation
that a driver reload resets link configuration.

Trade-off: on optical ports whose firmware default speed does not
match a forced-mode remote, reload now drops the link and the user
must re-apply ethtool configuration. This is acceptable: a driver
reload is expected to reset link configuration, not to inherit
runtime state from before unload. The autoneg inheritance is left
in place as established behavior; changing it is out of scope for
this patch and would itself be a user-perceivable behavior change.

Fixes: d9d349c4e8a0 ("net: hns3: differentiate autoneg default values between copper and fiber")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
v3:
 - Expand commit message to explain the two overwrites added by the
   Fixes commit: req_autoneg inheritance is kept because it matches
   existing behavior of hclge_set_autoneg_speed_dup(); req_speed
   sync is dropped because it introduces the reported residue.
 - State explicitly that link loss on forced-mode optical ports after
   reload is acceptable, since a driver reload is expected to reset
   link configuration rather than inherit runtime state.
 - Explain why autoneg inheritance is left unchanged: it is
   established behavior, and changing it is out of scope and would
   be user-perceivable.

v2: https://lore.kernel.org/all/20260708140532.1691493-1-shaojijie@huawei.com/
 - Discard v1 and resend with the correct "net" prefix in the subject.
   Apologies for the noise. No code changes.
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index fc8587c80813..164c3ecf195c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9498,12 +9498,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto err_ptp_uninit;
 
-	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER) {
+	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER)
 		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
-		if (hdev->hw.mac.autoneg == AUTONEG_DISABLE &&
-		    hdev->hw.mac.speed != SPEED_UNKNOWN)
-			hdev->hw.mac.req_speed = hdev->hw.mac.speed;
-	}
 
 	ret = hclge_set_autoneg_speed_dup(hdev);
 	if (ret) {

base-commit: 78f75d632f74b8de0f081a128588f7c37d0d1164
-- 
2.33.0

