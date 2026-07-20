Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33683AFD09
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538651; cv=none; b=KtLc/096wsocVQtNZVQ8+zBdHpTMZc7REplQ4RDOJKS6dnvRmAZ4gD/o2ylhUP+OWuds3nutL9u+5IhU364HV0BYwiH2G3cj7Tefk2dQqC2AYQ8F5uOYBtZR2SR05c8y/PEn9WbRi6+OCP2CFSloOJCsqIykouEmAOYuglfwMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538651; c=relaxed/simple;
	bh=Cx9dGJ7B8n/myjZMLncB3dmJYHsXwmkXdaBUzxA6YkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UKGnNmnwOq+UrtS2go2PCkIEGW1GsTdCoAOJYPs3wysYjlaiTzEW+pR29QSMGa9UexRQxTtjDv2tGWFa295+bYQ56pYUxx3sGnZKi5q2LrLu/ZgL2bb5vEx8uH69EHcTBXjergzaG1Jcx7S8NqyCTmebtkOlPHqeg3nXYRWT0S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jlbLCXKj; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jlbLCXKj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784538646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rR95PyqxdQQtMnhCvHLkoeN9Zghr234eqztcQksIdaM=;
	b=jlbLCXKjpVemkfth5XZxJAq9qhLeb4i9usBcAyRuf14KQ45L0/XAUNKUWexRKYM3jlbOIZ
	eMIheVIDLmMiiJECVJOtjNn5BsLLsH/nRkLEvbTvojOJDzPlqxtwwAs3IUlC6/lUs8DElw
	YOcJtP2HLLsG7U73KjSL3hvhI6jXmds=
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
Subject: [PATCH net] hinic: fix leak of ethtool RSS user configuration buffers
Date: Mon, 20 Jul 2026 17:11:02 +0800
Message-Id: <20260720091102.1653378-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

rss_indir_user and rss_hkey_user are allocated in __set_rss_rxfh() when
the user configures RSS via ethtool, but hinic_remove() never frees them.
free_netdev() only releases the nic_dev structure itself, so the separately
allocated buffers are leaked on driver unload.

Free both buffers in hinic_remove() after unregister_netdev().

Fixes: 4fdc51bb4e92 ("hinic: add support for rss parameters with ethtool")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 42f4792d255b..7d9c46004bcd 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -1433,6 +1433,9 @@ static void hinic_remove(struct pci_dev *pdev)
 
 	hinic_free_intr_coalesce(nic_dev);
 
+	kfree(nic_dev->rss_indir_user);
+	kfree(nic_dev->rss_hkey_user);
+
 	hinic_port_del_mac(nic_dev, netdev->dev_addr, 0);
 
 	hinic_hwdev_cb_unregister(nic_dev->hwdev,
-- 
2.25.1

