Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467197;
	b=KoehdpwAutxnJWIqJEsxGXm5Bum/5z1MJ+09NEvmDRu96NOoRilpsA6Ouhza2Hq4klt9
	 5zC35rk9rcxd1FAbJ4J/TQv4A72eWAt29HNhVXUqCjGSm9DasQJ7q6jR19uXsUR8xICEo
	 LmcU1UuthzgPlfGzwoESjXxIbSdrYDCbsPx3ev4900l16OEq4UR9n55/KfdUw2FfAC1R5
	 2XAEA+C8bX6gCbapKOT1G1GZIbairWTKXQLKv2LAP/wigr/Bte0a4v1VpJu6dfPhQOLFa
	 9ZH35AkLc/7J5z0fWeo7yNEsLzDBi41RxoeNBc1W9b7oWKlvZyKF4aZbJHYOWXF+37A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467197;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=dMt8u1kOMML99JIIetOfyywDcYomQz3pDU6fHAV3iv0=;
	b=ogsWh6w1RLIkJsgDNg2L1w0r+1TGIPLlSzGEqjsMw0FTRY0g6n3fxcA9Q91FaPtGJejM
	 jSwWgMBSpYgFVulOYwFVpkLb2B2ROMsyp98sIT/6BhNDopRj6dT+LfIgF8sF0FfPKQhBS
	 5r9c6NT8sAte43T+GmLo0BO3nuC7KMPraxKYAgsTkMoNDgua0LI1zVuXCUoeyiv5UOORV
	 6f37Z8v4uSj3w/eXHemQ8h0PAyiy7EI1tczoquZPdGrIWKQa7jmA8dJgBccB7zXGKmlge
	 TNLF8D5eJIlWp57n1kI01Y/GLvKc37YRNG8HEfWFIVj0lmOTK4Y5VX5UA/LraAcr5YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HcyQC69S;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E835606A31C;
	Thu, 12 Nov 2026 07:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E835606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=HcyQC69S
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dMt8u1kOMML99JIIetOfyywDcYomQz3pDU6fHAV3iv0=;
	b=HcyQC69S06bmzR9G2io7KlXS+LlYCzyUb2ZENuj/U/OtHKJVE6n+h1N+I7BdJIYRQ+BvNZzsF
	P2+KRnJBtiZ53DF+15MQB/4k5+Hc3GYWUpp24I0c/JSSFG3Aq7UFX1KkEXxcYKWCLjrsVtiBp1W
	V1swqZLEzIoIF6yc+xt2iGM=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jQBJ66CLbzmV8H;
	Thu, 12 Nov 2026 15:06:14 +0800 (CST)
Received: from dggpemr200004.china.huawei.com (unknown [7.185.36.180])
	by mail.maildlp.com (Postfix) with ESMTPS id 8575F4057C;
	Thu, 12 Nov 2026 15:06:30 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr200004.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 12 Nov 2026 15:06:30 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 12 Nov 2026 15:06:28 +0800
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
Subject: [PATCH net-next v03 0/4] net: hinic3: Bugfix for later patch-set.
Date: Thu, 12 Nov 2026 15:06:19 +0800
Message-ID: <cover.1794467919.git.gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemq100015.china.huawei.com (7.152.185.230)

These issues were discovered by LLM Gemini-4-Argon and Claude-Opus-5-5.
At the same time, LLM recommended submitting an independent patch.
These issues were not actually triggered. Based on theoretical analysis
and consideration of actual risks, this patch is used to fix the issues.

Testing:
  These patch-set have been tested on hinic3 hardware.

V03:
* Clenaup checkpatchs in file hinic3_netdev_ops.c.(AI Review)
* nic_svc_cap->max_sqs is already in the range [1, 256].(AI Review)

V02: https://lore.kernel.org/all/179437094656.2168702.7238120951030130700@kernel.org/
* Rewrite the commit message and provide an explanation for each
  patch.(AI Review)
* Split checkpatchs in to a separate patch.(AI Review)
* Fix the failure of napi_alloc_skb() in recv_one_pkt().(AI Review)
* READ_ONCE()/WRITE_ONCE() only stop the compiler from tearing or caching
  the access. They don't order anything against the work item, and they
  can't stop it from running. So, remove READ_ONCE() and WRITE_ONCE() on
  nic_dev->adaptive_rx_coal.(AI Review)

V01: https://lore.kernel.org/netdev/cover.1793946318.git.gongfan1@huawei.com/

Fan Gong (4):
  hinic3: Solve an stall issue in hinic3_rx_poll()
  hinic3: Avoid concurrent updates on 32-bit systems.
  hinic3: fix some checkpatchs.
  hinic3: Ensure that the value of max_qps is not changed

 .../huawei/hinic3/hinic3_netdev_ops.c         | 76 ++++++++-----------
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |  9 +--
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 11 ++-
 3 files changed, 44 insertions(+), 52 deletions(-)


base-commit: 73022f605c447f31610b94ed4a983d2b4bf2c721
-- 
2.43.0

