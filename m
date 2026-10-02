Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B347D94B;
	Fri,  2 Oct 2026 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790935246; cv=none; b=oKqx7Hj5wlYSKAp2Q/8qIC6F7AnMZkj3l7UqOQhCCN2WvJfKZTbuyT0ZVcYbVW44Iq7XNqoO7vCpEvtIaSax+eV4nQqexXIp4EL/vEkj5yn3vQ9u7Et+Y5YU9yw+bJl9Ents91qWzA/ZXa1EJRU2oW34FbGUhf8NeuU3GeyLnJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790935246; c=relaxed/simple;
	bh=yNZH+SXEGuho7rMOf4gYcOjqFg4lpE9tkex6TwUTDrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmRekOvmzsIGE+o28ciw+B29MDocw7vXXr7E0kUYOoiK/8EdAJqefWGUwrHpAB2lBKbROlL9Adbz5D2HancMYwdarTIo32eVykZ/6OE6MiFDmRuJLBQOiCj7Hn4F+OIAH2MuoFYvLg0KBWDYDeSRwLU05y/4eXdpc+7f0rzvI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WvzewWhl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WvzewWhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790935244; x=1822471244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yNZH+SXEGuho7rMOf4gYcOjqFg4lpE9tkex6TwUTDrA=;
  b=WvzewWhlwgxBjz0/J5GnblN1H8Wr868qHrVgGADHa7pswDDr7+9M/fgD
   WmUOVWFcDGaKnbFvAhMAmzPZoGZpY0qNlJ6bAqVbLYavYXmksxeT1AnEM
   aZ3yY/jFdJcJBcrk7hzVMDB4Nzv3xBAVN3DBvO0cp2ZUpbliYbVyxomyI
   cnCyncy8/x84SRToHk9crGd0TAIqu7As8g7u8EBtP+n+gwFsHvYRT0sJ0
   1p6yqwUZOTEWXgL3zG/a9zXN5mzcnvGw7L9E5jogLDOactx8dF/dA/Q9t
   kKk/Yj+7P16Jtwy5DjcrEeL7FJGLjmEwyjUPyPgcRap0O10t7U5oft1bK
   Q==;
X-CSE-ConnectionGUID: l8/M1AjMSQmTC/xaBpf1bw==
X-CSE-MsgGUID: OxTC9qLKQ5WQSKhPlmIVCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="113484701"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="113484701"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:00:40 -0700
X-CSE-ConnectionGUID: U7Ffk0hKQLex3986Z+JHEw==
X-CSE-MsgGUID: G56TbB1wQ7iZb8FQM10p9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279959891"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 02 Oct 2026 03:00:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5878BA1; Fri, 02 Oct 2026 12:00:36 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v2 4/5] eea: unify return code variable name
Date: Fri,  2 Oct 2026 11:59:22 +0200
Message-ID: <20261002100035.863275-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one case 'rc' is used in the other 'ret', the most use 'err'.
Make the latter use the former, id est 'err'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
index 92eeff32b00c..f493afbcc41b 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_adminq.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -133,7 +133,7 @@ static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
 {
 	struct eea_aq_cdesc *cdesc;
 	struct eea_aq_desc *desc;
-	int ret;
+	int err;
 
 	if (enet->adminq.broken)
 		return -EIO;
@@ -163,9 +163,9 @@ static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
 	if ((enet->adminq.num % enet->adminq.ring->num) == 0)
 		enet->adminq.phase ^= EEA_RING_DESC_F_AQ_PHASE;
 
-	ret = read_poll_timeout(eea_ering_cq_get_desc, cdesc, cdesc, 10,
+	err = read_poll_timeout(eea_ering_cq_get_desc, cdesc, cdesc, 10,
 				EEA_AQ_TIMEOUT_US, false, enet->adminq.ring);
-	if (ret) {
+	if (err) {
 		netdev_err(enet->netdev,
 			   "adminq exec timeout. cmd: %d reset device.\n",
 			   cmd);
@@ -173,21 +173,21 @@ static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
 		 * potential DMA writes after the memory is freed.
 		 */
 		eea_device_broken(enet);
-		return ret;
+		return err;
 	}
 
 	/* Returns 0 on success, or a negative error code on failure. */
-	ret = le32_to_cpu(cdesc->status);
+	err = le32_to_cpu(cdesc->status);
 
 	eea_ering_cq_ack_desc(enet->adminq.ring, 1);
 
-	if (ret)
+	if (err)
 		netdev_err(enet->netdev,
-			   "adminq exec failed. cmd: %d ret %d\n", cmd, ret);
+			   "adminq exec failed. cmd: %d ret %d\n", cmd, err);
 	else
 		*reply_len = le32_to_cpu(cdesc->reply_len);
 
-	return ret;
+	return err;
 }
 
 static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
@@ -198,7 +198,7 @@ static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
 	dma_addr_t req_addr = 0, res_addr = 0;
 	struct device *dma;
 	u32 reply_len = 0;
-	int ret;
+	int err;
 
 	if (reply)
 		*reply = 0;
@@ -214,19 +214,19 @@ static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
 	if (res) {
 		res_addr = dma_map_single(dma, res, res_size, DMA_FROM_DEVICE);
 		if (unlikely(dma_mapping_error(dma, res_addr))) {
-			ret = -ENOMEM;
+			err = -ENOMEM;
 			goto err_unmap_req;
 		}
 	}
 
 	mutex_lock(&enet->adminq.lock);
-	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr,
+	err = eea_adminq_submit(enet, cmd, req_addr, res_addr,
 				req_size, res_size, &reply_len);
 	mutex_unlock(&enet->adminq.lock);
 	if (res) {
 		dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVICE);
 
-		if (ret)
+		if (err)
 			memset(res, 0, res_size);
 		else if (res_size > reply_len)
 			memset(res + reply_len, 0, res_size - reply_len);
@@ -239,7 +239,7 @@ static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
 	if (req)
 		dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE);
 
-	return ret;
+	return err;
 }
 
 void eea_destroy_adminq(struct eea_net *enet)
@@ -484,7 +484,7 @@ void eea_adminq_config_host_info(struct eea_net *enet)
 	struct device *dev = enet->edev->dma_dev;
 	struct eea_aq_host_info_cfg *cfg;
 	struct eea_aq_host_info_rep *rep;
-	int rc;
+	int err;
 
 	cfg = kzalloc_obj(*cfg);
 	if (!cfg)
@@ -515,9 +515,9 @@ void eea_adminq_config_host_info(struct eea_net *enet)
 	strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver_str));
 	strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));
 
-	rc = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
-			     cfg, sizeof(*cfg), rep, sizeof(*rep), NULL);
-	if (rc)
+	err = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
+			      cfg, sizeof(*cfg), rep, sizeof(*rep), NULL);
+	if (err)
 		goto err_free_rep;
 
 	if (rep->op_code == EEA_HINFO_REP_BAD)
-- 
2.50.1

