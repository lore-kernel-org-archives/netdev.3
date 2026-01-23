Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC75E353EE5;
	Fri, 23 Jan 2026 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769161783; cv=none; b=iPc9CdvolwLobYa6bC3Ovf3Q6SugpJ9dib4ifxsuFWU2YO6CCGnlZQHufy4cDyIOEj0FSL/mWQd7+PmcR7HL98bvcFTD5HXgMZzhn0LbPILX0EDpvdoeeNT6cKslaR8b4jyIM0hYfXpAlrvM8vZlnJMMAjXqdrRdhW36a/0Mr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769161783; c=relaxed/simple;
	bh=mjqm+YmaFZmTGivWCwAacMWLY2up9zvF5sZfzMObb1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LfnliJhg+h5RhgmFgiD7OCjHjGaRnFOkprBW/2sn29AdSeQba+IzEQv0ubL5BfJX5gk+U2n7v0PA5MPZV55coIBwY1r9oCOnAzR/Zb82yuEE9dXlIyjdkMdz9xv06u6th9Ly5ejsBw88kvhdAeffR76TF326JtPK8jslwqZOs2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yxUFgkeH; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yxUFgkeH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=w+h4m1LfAdEROOF6RTvxf4Y8vol5MWEKwwUeoyB14Y8=;
	b=yxUFgkeHhwUz1t3tG6MwlvgrNSENEn7qoZX99DSuf0oEp/PQwqA+7RZ+L+qC/mSZV3DxNq9zo
	VYRHUDPAqOO+yteqAGPrzJ812YuNNDO/3yKzTtM/7Yym7gTqWnX59h5ZcDq7tda/JRFv6EMLTMu
	B06H7l2AlCA8SOOsmy6EPmM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dyCjX75W3zmV8B;
	Fri, 23 Jan 2026 17:45:52 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 990C140568;
	Fri, 23 Jan 2026 17:49:18 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 23 Jan 2026 17:49:17 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 0/2] extend bit width in the flow director of HNS3 driver
Date: Fri, 23 Jan 2026 17:47:54 +0800
Message-ID: <20260123094756.3718516-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The bit widths of HCLGE_FD_AD_QID and HCLGE_FD_AD_COUNTER_NUM are
increased to support higher specifications.

Note: The hardware already supports the specifications.

Jijie Shao (2):
  net: hns3: extend HCLGE_FD_AD_QID to 11 bits
  net: hns3: extend HCLGE_FD_AD_COUNTER_NUM to 8 bits

 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h    | 11 +++++++----
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 11 ++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.33.0

