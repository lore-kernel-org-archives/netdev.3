Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50A644E67D;
	Tue,  4 Aug 2026 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848988; cv=none; b=AFEf50ZZrWvZPg5/sSRxV2RvPo0BXbaapSYhL2CCYZ0jO/ULpToFAXy2kxCmTnppuJw/NHaBf6vGnTj6ywXbS1qrq7smliyWyCHbfVUy9Yohfk6rbhzA8nWlhqn4rxu2zQYQdsaaMzvX9Nn9h6tkFnaNGEqTgzaxC0faphLG95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848988; c=relaxed/simple;
	bh=5qKmtPXltsLoXjawN8v7AjSKZN0OrP5nhzXyMclGYFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nU7KZyqUyt8zicg9N+0xg38BlUo9n1+/xEuT4IBeMzY4q6V1r6ae3xS0aQxXQwFzkPBbWRWopPWOF3plECNGbop+aNfc/sGX5ClnWumnyQAY1JlZV42rR5AD9NmKMu/ZHW7M1eEUyRPj3V+54DcHIiAJm9nQS8JBppzoyqDB0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dCg6XNkV; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dCg6XNkV"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CGTWXrW8IjULtMf+66bwZ9RvUKvt0QeJAX7xo/X4/0s=;
	b=dCg6XNkVqbMxpAbGg4ytZRwPV+9+tHn6mCpWK5JPSCDM7zto5Tz3u6Co3Ns1HcZaufgJKwfNH
	YUCYYgTkvYc1CElZmzQy4dfp4uLzdyc/bkA4k3zmGLKmNnUFMZN8bfIIN/1Xl3c3SBpNib9Zfy9
	rhgrJIp5FvrUvEsfK3k4NqM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hDttf5HgWz1K96b;
	Tue,  4 Aug 2026 21:00:10 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 568104055B;
	Tue,  4 Aug 2026 21:09:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 21:09:39 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 2/3] net: hns3: add missing const qualifier to hclge_log_error() reg parameter
Date: Tue, 4 Aug 2026 21:09:32 +0800
Message-ID: <20260804130933.880552-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804130933.880552-1-shaojijie@huawei.com>
References: <20260804130933.880552-1-shaojijie@huawei.com>
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

The reg parameter of hclge_log_error() is never modified within the
function, but is declared as 'char *'. Callers pass const strings,
causing a compiler warning about discarding the 'const' qualifier.
Add the missing const to fix the warning.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
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
2.43.0

