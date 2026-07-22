Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B03911A9
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 02:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784688859; cv=none; b=rfhRdGYVMK4qJ2qUwh3JSz+q4l/Yfl16vPsTjvYfcmxXCczCheF0Is/bXsbeVERAbxTZri8c60jGSa0bpXjO/uDNGTbsFB0QA+aA6hUMt0ROMjUyELvyqOHT0MQZwh+2M8Sloi7nugCFbmevU1mPl5I+rmOGyFWNBm0rmX0imV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784688859; c=relaxed/simple;
	bh=BYwq5hTPbnb07MhThDmBAsvyYoQNOKH70Dk0qMC5LFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtZeQVF3WIBnV0dzBZ/YoLtU4DZnyJ27tLhi8oQDLjx5m3NKpne2oFdNyAIz0rMNaBE61WVGSItATbcVDdrI0i3fXErPNcMeL0Tb9NWpRTvL+pSZaBielucLBr2IF8GQr/kOORujf4Hpbr8fi94nSdXZfVPjeCkhxbgLbL6eX2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eFb9gDaP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eFb9gDaP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784688853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jabf1ySX5blvivyZQPjwIYKyEIMRTNtMWT5NnIlOypA=;
	b=eFb9gDaPRHdVaF4ce7buXZ3T1vevhpMq7o4bvUBwuPYQ2qk8OhfKpaYIf0AW4en8WfoMmU
	9nIMtiOC9RGZdcvwc5LoRV1XtAOhIhWUgQpf5fF4pjRIaNmXsc4zuWYsp521Jzw0ymU7cc
	zlmr+SdrZS7GGqEsfWFd9tdXKdOPoXU=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: cai.huoqing@linux.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net v2] hinic: remove unused ethtool RSS user configuration buffers
Date: Wed, 22 Jul 2026 10:53:53 +0800
Message-Id: <20260722025353.328179-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

rss_indir_user and rss_hkey_user are allocated and filled in
__set_rss_rxfh() when the user configures RSS via ethtool, but
nothing ever reads them. hinic_get_rxfh() fetches the state from
the device, and the hardware is programmed from the original
indir/key arguments. These buffers only leaked on driver unload.

Drop the unused allocations, memcpys, and struct fields.

Fixes: 4fdc51bb4e92 ("hinic: add support for rss parameters with ethtool")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 - Remove buffer allocation operations as suggested by Joe.

v1:
 - https://lore.kernel.org/all/20260720091102.1653378-1-chenguang.zhao@linux.dev/

 drivers/net/ethernet/huawei/hinic/hinic_dev.h |  2 --
 .../net/ethernet/huawei/hinic/hinic_ethtool.c | 21 -------------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_dev.h b/drivers/net/ethernet/huawei/hinic/hinic_dev.h
index 52ea97c818b8..d9ab94910a2a 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_dev.h
@@ -104,8 +104,6 @@ struct hinic_dev {
 	u16				num_rss;
 	u16				rss_limit;
 	struct hinic_rss_type		rss_type;
-	u8				*rss_hkey_user;
-	s32				*rss_indir_user;
 	struct hinic_intr_coal_info	*rx_intr_coalesce;
 	struct hinic_intr_coal_info	*tx_intr_coalesce;
 	struct hinic_sriov_info sriov_info;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
index a8b129ce1b7e..f75e8563f23a 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
@@ -1064,17 +1064,6 @@ static int __set_rss_rxfh(struct net_device *netdev,
 	int err;
 
 	if (indir) {
-		if (!nic_dev->rss_indir_user) {
-			nic_dev->rss_indir_user =
-				kzalloc(sizeof(u32) * HINIC_RSS_INDIR_SIZE,
-					GFP_KERNEL);
-			if (!nic_dev->rss_indir_user)
-				return -ENOMEM;
-		}
-
-		memcpy(nic_dev->rss_indir_user, indir,
-		       sizeof(u32) * HINIC_RSS_INDIR_SIZE);
-
 		err = hinic_rss_set_indir_tbl(nic_dev,
 					      nic_dev->rss_tmpl_idx, indir);
 		if (err)
@@ -1082,16 +1071,6 @@ static int __set_rss_rxfh(struct net_device *netdev,
 	}
 
 	if (key) {
-		if (!nic_dev->rss_hkey_user) {
-			nic_dev->rss_hkey_user =
-				kzalloc(HINIC_RSS_KEY_SIZE * 2, GFP_KERNEL);
-
-			if (!nic_dev->rss_hkey_user)
-				return -ENOMEM;
-		}
-
-		memcpy(nic_dev->rss_hkey_user, key, HINIC_RSS_KEY_SIZE);
-
 		err = hinic_rss_set_template_tbl(nic_dev,
 						 nic_dev->rss_tmpl_idx, key);
 		if (err)
-- 
2.25.1

