Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370612;
	b=wZgLonP0hUDlDV1fZvSi1oeKM6wGPZ9DNR8OwM+NQ7ON8zm0lo4K1ui1ABoMt0prmF+X
	 qqPs9gm/Kp+qk0NSoRs7x+6fuwMo/dk0vNOJKGC9sYCychXzQ1QbDaTglf0L3SVb223ng
	 dX9m+qmbPOY0wdra3HMCNW1xyl9wSdX0efM5f80+HZdOqv829+cfX1VjZScW93xTpaW8w
	 qDx7twmvFQetv956eBUZ04ZxzjrzUa/97FAhohSs1X1JH+2nOP11mCAAMPFP7S8JESU9H
	 40P+BdH+nd9obXzwuIgdoYy5IDA9sXVX1Mt0kaQercRp72kKwop5uGzgvEMfPWcZVuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370612;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=FbariBqHitKZQ0ayBvz9cE4gYDK9yFOH8BP1t/wlGjk=;
	b=MqXBQt+Toln03YVGwS+iBvjNhoM8ybHQDPMIBMBdW4cCNKRFizXbed56+mOXla1R+hin
	 iEWgt81RU5KwkfND2gggXgXjQCmOgw11kT+bBa1TC7uOaGGbZdvg41MrnMz122OKqizx5
	 U8v/EEWyHX05QaYojZELI7dwBdJQnv3ZswRzAmog5Uh1stXmAt4fgNkNEpnCaiXOpUVLT
	 OoEbjpJT+GtjNuyUPzQMZXqgsi4J20CAiLBO5Puvng+HYOPiQ1YdLffdpy4g5njxZMNMH
	 psxpNEK39E4NVFISqPNtMfNL+5VstkTj5meZz9/TGmeh50O+QYsKz8gNDvdiv8I8JbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3tAg1xeJ;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F760A382C;
	Wed, 11 Nov 2026 04:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 502F760A382C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3tAg1xeJ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FbariBqHitKZQ0ayBvz9cE4gYDK9yFOH8BP1t/wlGjk=;
	b=3tAg1xeJn2rvJ7OUiBH+nyHufLGUdSr5R2/wWjMp/eNBnWrxuVxuiHL0Nf4eUOOqDJMnSaY68
	nhz2N2otEUgFyzYbm83gBxUOYMi9KNlWJt4WHeJ5isE+0nFXCHjTVSlXJd1xeiq5K+HYLW/cJZC
	7spO/msaMCevXoA4cbRRnEs=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jPVZg4V1GzLlTD;
	Wed, 11 Nov 2026 12:16:27 +0800 (CST)
Received: from dggpemr500008.china.huawei.com (unknown [7.185.36.219])
	by mail.maildlp.com (Postfix) with ESMTPS id B3BA540565;
	Wed, 11 Nov 2026 12:16:42 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr500008.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 12:16:42 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 11 Nov 2026 12:16:40 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>, Teng Peisen
	<tengpeisen@huawei.com>, <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei
	<ioana.ciornei@nxp.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Dimitri Daskalakis
	<dimitri.daskalakis1@gmail.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>, "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: [PATCH net-next v02 4/5] hinic3: Ensure the value of max_qps is greater than 1
Date: Wed, 11 Nov 2026 12:15:46 +0800
Message-ID: <1bfd52d6bdc2a7fc1b7eaa183293d4859ad7d94a.1794371175.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <cover.1794371175.git.gongfan1@huawei.com>
References: <cover.1794371175.git.gongfan1@huawei.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemq100015.china.huawei.com (7.152.185.230)

Fixes: 17fcb3dc12bb ("hinic3: module initialization and tx/rx logic")
Co-developed-by: Wu Di <wudi234@huawei.com>
Signed-off-by: Wu Di <wudi234@huawei.com>
Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index c5dd53a8fa96..65d311454825 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -267,7 +267,9 @@ bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
 
 u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev)
 {
-	return hwdev->cfg_mgmt->cap.nic_svc_cap.max_sqs;
+	u16 max_qps = hwdev->cfg_mgmt->cap.nic_svc_cap.max_sqs;
+
+	return max_qps <= 1 ? 1 : max_qps;
 }
 
 u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev)
-- 
2.43.0

