Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFA43F8D4;
	Tue,  4 Aug 2026 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848780; cv=none; b=gzQOiXTUTDIkWGgwa+W4XmwJICIZIYJwx6jHGBnHiRbe33x6ED0zHnmvI2dlK+2U5O/C0nbzW5ClxTFYthlc0r80AJuJ+dx7lGH3rSXrhxtNd6terCqMGs8Jvrz/iZ31fMJ1wZ1iGSeLyRbL0qFHOs7/3q5C8BVSD0wvT1iaTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848780; c=relaxed/simple;
	bh=3TwIWzyIBCVaWUC12zHhkewmyLDVSfAxslpouR3ztPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tNn1hZ8Z/qt3heiKp/wLvstF1ieRTbGdLv3pKbJuTyWp6K/ljDbKfnj2QAIMWzKWBc6jr0/SkPBRDQLPnq9reW6Y8u5TRhuVfc9+ZuHCvV4Bi28IF+zUFWDiZQNkOfuehZQZ+iMMR5Ih11fLJ7ly5yueMifGUBA0OvMjU5mjHMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rJYdpWGk; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rJYdpWGk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IcYKgu/tZYio1J0TW6HqHgtSR1994OX1gMfBz7vbenQ=;
	b=rJYdpWGkcB+289uVJJVePNUq+9O8vtHNSa5LXt1mJfS/v3vUrJwK0lWeyYVyaZylS9lVGOlY0
	KV3gBEjIxE5eCE5uvDLdoQGO/rMovNmTmQUF+sdEuiwhhJZcPf521pRJ64m9pd3Nxk/Ydb9DLM3
	xILZno9M6zPsuSoT53S9T4w=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hDtpf1Tgbz1K96b;
	Tue,  4 Aug 2026 20:56:42 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C9D2D4057A;
	Tue,  4 Aug 2026 21:06:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 4 Aug 2026 21:06:11 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <yangshuaisong@h-partners.com>,
	<ningwei15@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net] MAINTAINERS: add myself as a maintainer for Hisilicon Network Subsystem
Date: Tue, 4 Aug 2026 21:05:54 +0800
Message-ID: <20260804130554.871716-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.43.0
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

I am already listed as a maintainer for the HNS3 and HIBMCGE drivers,
but not for the broader Hisilicon Network Subsystem entry, whose file
pattern covers drivers/net/ethernet/hisilicon/ (e.g. the legacy hns
driver). As a result, patches to those files are not CC'd to me.

Add myself alongside Jian Shen to help maintain these legacy Hisilicon
ethernet drivers and ensure patches in this tree are routed to me.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Acked-by: Jian Shen <shenjian15@huawei.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d7987278c07..a77cf599bac2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11743,6 +11743,7 @@ F:	drivers/net/ethernet/hisilicon/hibmcge/
 
 HISILICON NETWORK SUBSYSTEM DRIVER
 M:	Jian Shen <shenjian15@huawei.com>
+M:	Jijie Shao <shaojijie@huawei.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	http://www.hisilicon.com

base-commit: 1a35da325cac4d5bcad76a2aa943408a6f1d9000
-- 
2.43.0

