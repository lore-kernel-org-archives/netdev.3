Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F473148AF;
	Sat, 24 Jan 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769258543; cv=none; b=gPhefYudrnGd3Fo4oVfJvT80xFRqm4MInAMfJIm+7XvQ0sjhoBlhM+dDlVEyAxdHogz5voPj7ugarKPSk5N8v/nUWY0ncyoi/I9rC/K25fDWCSBRlzI1GcVXZUii0a+0/kItsrWNhhE7b0i9TqJ2QmYCa9ddBrjdkzcxTvYnnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769258543; c=relaxed/simple;
	bh=UH2BPisERv2xmsWEtC30XX0eOi/BxkTvlwwuBRUGXCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q5VjjkK7+46Ek08CEx1ciIm4NQ1H8Xj2W9Ut8ZL28Ja3ss4oV6541QCau+aryKwPt6ukV7BVgmnCHsAOiVtsXfRCh3P8rFTZsh48g36nvgpKtrsIDv6hPMIseFmbHBa60mnAp5+abry2yxUtMcL4+pMKxnc9sCBPSBb3euMLTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=MiXrUKhu; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="MiXrUKhu"
Received: from LAPTOP-N070L597.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31d4a5558;
	Sat, 24 Jan 2026 20:42:12 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	marco.crivellari@suse.com,
	vadim.fedorenko@linux.dev,
	kory.maincent@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v2 2/2] net: liquidio: Initialize netdev pointer before queue setup
Date: Sat, 24 Jan 2026 12:42:05 +0000
Message-Id: <20260124124205.102499-3-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260124124205.102499-1-zilin@seu.edu.cn>
References: <20260124124205.102499-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bf006bdf603a1kunm29d30d5ebf2f6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0sZVklKQkgZHk4ZGh9JGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVU
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MiXrUKhuevyihXqQvGxaQ5ehjc5fUQhzWZ5YXIr4tb3IwZ8Kezq9xuG+nAdTves3FJTWGbE8NvOmJRhQ3vDJIiWk78hvgjGEDpD+16XIl6u/OEJQXx7F16QcKJoPZXhAw4M5LTO6B2YPFbbYyBHKjxKG4ukFqYRvSE+sknNsJaY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Wx1rJPks4lZTfMd7LBXpxcQY36ZNVIHULAiFfh/XgkU=;
	h=date:mime-version:subject:message-id:from;

In setup_nic_devices(), the netdev is allocated using alloc_etherdev_mq().
However, the pointer to this structure is stored in oct->props[i].netdev
only after the calls to netif_set_real_num_rx_queues() and
netif_set_real_num_tx_queues().

If either of these functions fails, setup_nic_devices() returns an error
without freeing the allocated netdev. Since oct->props[i].netdev is still
NULL at this point, the cleanup function liquidio_destroy_nic_device()
will fail to find and free the netdev, resulting in a memory leak.

Fix this by initializing oct->props[i].netdev before calling the queue
setup functions. This ensures that the netdev is properly accessible for
cleanup in case of errors.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: c33c997346c3 ("liquidio: enhanced ethtool --set-channels feature")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 3ba2806f5d1e..2383f0173a54 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3505,6 +3505,16 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		 */
 		netdev->netdev_ops = &lionetdevops;
 
+		lio = GET_LIO(netdev);
+
+		memset(lio, 0, sizeof(struct lio));
+
+		lio->ifidx = ifidx_or_pfnum;
+
+		props = &octeon_dev->props[i];
+		props->gmxport = resp->cfg_info.linfo.gmxport;
+		props->netdev = netdev;
+
 		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
 		if (retval) {
 			dev_err(&octeon_dev->pci_dev->dev,
@@ -3521,16 +3531,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 			goto setup_nic_dev_free;
 		}
 
-		lio = GET_LIO(netdev);
-
-		memset(lio, 0, sizeof(struct lio));
-
-		lio->ifidx = ifidx_or_pfnum;
-
-		props = &octeon_dev->props[i];
-		props->gmxport = resp->cfg_info.linfo.gmxport;
-		props->netdev = netdev;
-
 		lio->linfo.num_rxpciq = num_oqueues;
 		lio->linfo.num_txpciq = num_iqueues;
 		for (j = 0; j < num_oqueues; j++) {
-- 
2.34.1

