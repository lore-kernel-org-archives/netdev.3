Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370596;
	b=R88XlzJlK7vZ52vnot5VndK6rg7woklsT4KbccqBsm+tBuerBhFdPTDX9HADMCGWI7HP
	 tTaZMkU81ouexRVvS5Osdz4nNJsspFsMjpO7/Cb2WlOv8jKMltP5K1wUlqS1jUIPnMX14
	 kz5dVi7lLXl2wiNd0xJBcu46PY+j30s26zo6PfqlIUgX/xEWLIxz4VlREJKOgX/DtMuev
	 GtW9K7J5Z+OZDlAphk+fjk5Z8PI4f+gKKh07iooP0DuRDof30CYe/yo/XsUoGgsKuI/2w
	 R0KEUlYzSXNWXk8Xx67apQLXb6b6b6He9yNUSZucihbP5H3XN/z80CFQqlWO6ssHKow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370596;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:From:
	 To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=2f/Alns9YdFyAlX1rCcIBcf8bfBx4O208HusuqK0LT0=;
	b=dTl6i4v39pdlBpDamkUlFtCC5jxlt3ZVNKW7A/ReZ9FWpTB9rgw0cS42tk84V6kiYhb3
	 UXnuRBuZ6y1cT4SW/0dGe8gNbyLTHV6Gg/CJ4O+oOXDJnylA0Q1AFkx3oPcksXBDF0Qlj
	 Kbh1Rm/85yemPhZCo44n6C+TcQ2P+dQAPmlDQ8EPdR4s8RGMPxrR880cWMgEd3fStNl4a
	 2PL5HcLGG2WpDxyKdc0cwePpiMpsvBbNoBNeBOO9L7YYE20ZQouongV1VY4tQVCSO88e5
	 UfYWajd0lLVgBl08XcodCnenJT7Vrz7II3Kb27ZlZC/EnSOdYeKgTNnfYDCjLitFIcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yvMMVfCJ;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D38606A320;
	Wed, 11 Nov 2026 04:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D38606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=yvMMVfCJ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2f/Alns9YdFyAlX1rCcIBcf8bfBx4O208HusuqK0LT0=;
	b=yvMMVfCJbOIjAhl0aH24+F6qsAfQUnaqwDCf+pnwnRDIJhEu4HTcyM/MzIBRDnG5uuWZV7PuY
	dcaxY03L45nbaqBHDBfrvkRrfGiRxeZsSFHVh0LcSTsGRlGYPcQxyabSnTvc3YRhbqPqmOzvRlQ
	IdnJ2gAveS1Owq7cINtVibA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jPVZX5DhrzKm4x;
	Wed, 11 Nov 2026 12:16:20 +0800 (CST)
Received: from dggpemr500013.china.huawei.com (unknown [7.185.36.37])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B7A34056C;
	Wed, 11 Nov 2026 12:16:30 +0800 (CST)
Received: from whupemq100015.china.huawei.com (7.152.185.230) by
 dggpemr500013.china.huawei.com (7.185.36.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 12:16:30 +0800
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.220.94) by
 whupemq100015.china.huawei.com (7.152.185.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 11 Nov 2026 12:16:28 +0800
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
Subject: [PATCH net-next v02 0/5] net: hinic3: Bugfix for later patch-set.
Date: Wed, 11 Nov 2026 12:15:42 +0800
Message-ID: <cover.1794371175.git.gongfan1@huawei.com>
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
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemq100015.china.huawei.com (7.152.185.230)

Testing:
  These patch-set have been tested on hinic3 hardware.

V02:
* Rewrite the commit message and provide an explanation for each
  patch.(AI Review)
* Split checkpatchs in to a separate patch.(AI Review)
* Fix the failure of napi_alloc_skb() in recv_one_pkt().(AI Review)
* READ_ONCE()/WRITE_ONCE() only stop the compiler from tearing or caching
  the access. They don't order anything against the work item, and they
  can't stop it from running. So, remove READ_ONCE() and WRITE_ONCE() on
  nic_dev->adaptive_rx_coal.(AI Review)

V01: https://lore.kernel.org/netdev/cover.1793946318.git.gongfan1@huawei.com/

Fan Gong(5)
  hinic3: Solve an stall issue in hinic3_rx_poll()
  hinic3: Avoid concurrent updates on 32-bit systems.
  hinic3: fix some checkpatchs.
  hinic3: Ensure the value of max_qps is greater than 1
  hinic3: Ensure that the value of max_qps is not changed

Fan Gong (5):
  hinic3: Solve an stall issue in hinic3_rx_poll()
  hinic3: Avoid concurrent updates on 32-bit systems.
  hinic3: fix some checkpatchs.
  hinic3: Ensure the value of max_qps is greater than 1
  hinic3: Ensure that the value of max_qps is not changed

 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  4 +-
 .../huawei/hinic3/hinic3_netdev_ops.c         | 66 ++++++++-----------
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |  9 +--
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 11 +++-
 4 files changed, 41 insertions(+), 49 deletions(-)


base-commit: 73022f605c447f31610b94ed4a983d2b4bf2c721
-- 
2.43.0

