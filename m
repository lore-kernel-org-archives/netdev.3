Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EFE1E1DFC;
	Wed, 28 Jan 2026 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615097; cv=none; b=ioNTouabNx9HFtposB048MCO+9hRoPonQiUPgYToYTYRgNZuw/m6/g2WwyCfV8eyBRXTrvhB1/7GMSAzXFLkWT0VAnAFPufH6v26JEu+LodB63qPBeVJKAJFhqbTZJmtCu1mqztw+/8yvuBgvIOvX6HwZbX66BUjtjO7dy+2FKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615097; c=relaxed/simple;
	bh=ZAaWOVRM/vFfGE1SFvnAeMmUQRw30b+62j4qN/VRGY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/hfNJQVF1TFrgNs5cFNE02PqeMS9BTlsgPKq1NCWv5YU33sCAr7Xm3B+pTGXBL3YLxED/3JnvASwYrLN4bm4tttu9rdb6JXcPLyD1OBC96lJooHIPpoQq15abEI2E+lDDFBGmMQCPadvMIjmsw11P+NEXy5N9Y6VhDieFdDFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=M4v/krlb; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="M4v/krlb"
Received: from LAPTOP-N070L597.localdomain (unknown [58.215.202.202])
	by smtp.qiye.163.com (Hmail) with ESMTP id 324da1fd6;
	Wed, 28 Jan 2026 23:44:44 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kory.maincent@bootlin.com,
	horms@kernel.org,
	jianhao.xu@seu.edu.cn,
	marco.crivellari@suse.com,
	vadim.fedorenko@linux.dev,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v4 1/3] net: liquidio: Initialize netdev pointer before queue setup
Date: Wed, 28 Jan 2026 15:44:38 +0000
Message-Id: <20260128154440.278369-2-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128154440.278369-1-zilin@seu.edu.cn>
References: <20260128154440.278369-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c05474d9d03a1kunm1b02b57ddb3d8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT09MVk9MTRgYQ0tLGR9IGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJSk5VSUtJVUlLSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=M4v/krlbZ97k3k/0xK05uAW6SJosdZO84L6+GKfUsQ8TXqewfekDQpZqhEIOuz/ZsY+kZTn68zplu7nEZOcRbpp2qEIpzc2GO7B/YK1eFCPK5FwVZV2WRBQ6VUZmi/goluScP8PXFEhgNuakE5h/lKpE8BVRYrALqHaL/Z2NxyE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=2Gvu7Cs6MUOs7Uj2POOLbf2vbtFZCfImjtAFkNUxkoU=;
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
 .../net/ethernet/cavium/liquidio/lio_main.c   | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0732440eeacd..1f10b1b22a1e 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3505,6 +3505,23 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
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
+		/* Point to the  properties for octeon device to which this
+		 * interface belongs.
+		 */
+		lio->oct_dev = octeon_dev;
+		lio->octprops = props;
+		lio->netdev = netdev;
+
 		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
 		if (retval) {
 			dev_err(&octeon_dev->pci_dev->dev,
@@ -3521,16 +3538,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
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
@@ -3596,13 +3603,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		netdev->min_mtu = LIO_MIN_MTU_SIZE;
 		netdev->max_mtu = LIO_MAX_MTU_SIZE;
 
-		/* Point to the  properties for octeon device to which this
-		 * interface belongs.
-		 */
-		lio->oct_dev = octeon_dev;
-		lio->octprops = props;
-		lio->netdev = netdev;
-
 		dev_dbg(&octeon_dev->pci_dev->dev,
 			"if%d gmx: %d hw_addr: 0x%llx\n", i,
 			lio->linfo.gmxport, CVM_CAST64(lio->linfo.hw_addr));
-- 
2.34.1

