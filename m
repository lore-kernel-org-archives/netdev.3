Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C118D377ED7;
	Fri,  7 Aug 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096508; cv=none; b=VU0Ds/JmjLNHjIHIQKlMcxvbmJpEajX1U6QgGkhsx+QruZuuOnnzs1vly5vZPAj8RWCcXhX661fstCrHguhOCGRMrPDUf202GLLQWdhYAqLTb5YJiqCQkiA0SEhMw046GoZ1QQbjc88DZSaBM/OQTU/1BiHHpLp5Pa6MYWAztJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096508; c=relaxed/simple;
	bh=KCtRJ+a5gZ9ziP+VCBdd/234T81s+X2T53qgzmmgj+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhG5VHwSj9B37JW3JC4gVsQ2B954szCeXg+vXqs6YQoegMXDe5zeOv6UYocAerKXwI0OFKscxHXisFhZuEnDR+tlma19xaeF7on1/8nf5DKBWSNfE3HyzOxw/a7hn73W+8+iHremV2e+3ziqbFEwEWymTQ55n+4spxzBAtxy1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KgyCfvzo; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KgyCfvzo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QVgfmBluaZnUjMLr50+g3Vh7nfXTTGPctw64a+rZv24=;
	b=KgyCfvzo8K2j4os4s4u330vIRTu5d5oDlLEiJy/Vn4YDYBW9LxBin1M0CRAWIFxnUzTaljORN
	UBFK29AvlNX63a7bjGEOXyujPDxi03DrszpWKd+q2BBFZq5Zzzbzu7HBWH/Z1eCrpKQL2MWk8M9
	POnKOXIsKF67RisnwF4LzC8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4hGfQd2Y2wzpSvQ;
	Fri,  7 Aug 2026 17:45:29 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 90F0840561;
	Fri,  7 Aug 2026 17:55:02 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 17:55:01 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 2/3] net: hns3: add missing const qualifier to hclge_log_error() reg parameter
Date: Fri, 7 Aug 2026 17:54:34 +0800
Message-ID: <20260807095435.2959246-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260807095435.2959246-1-shaojijie@huawei.com>
References: <20260807095435.2959246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)

The reg parameter of hclge_log_error() is never modified within the
function, but is declared as 'char *'. Callers pass const strings,
causing a compiler warning about discarding the 'const' qualifier.
Add the missing const to fix the warning.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
index 7e124e2c718d..6093a60d257b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1762,7 +1762,7 @@ static const struct hclge_hw_type_id hclge_hw_type_id_st[] = {
 	},
 };
 
-static void hclge_log_error(struct device *dev, char *reg,
+static void hclge_log_error(struct device *dev, const char *reg,
 			    const struct hclge_hw_error *err,
 			    u32 err_sts, unsigned long *reset_requests)
 {
-- 
2.33.0

