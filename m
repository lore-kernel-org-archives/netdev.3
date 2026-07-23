Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619741C2F8
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798791; cv=none; b=SWW7XkK395wMHSgh0hqnKJGw7Dmv/grYmbs/F2KahvnfayilEqI4dJCibRu7UHk3rAHV9xPeoSh2XYvl0qCQ0BBbYRdSUl+mesZh4ToBZJwBKymf0m9nP/p0sdqVQwNDIiNdUBrBpT2mgf2CtqNEiPqlWmfJYkyfOiTaO0o4OSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798791; c=relaxed/simple;
	bh=9kRxwbgf65H4NCUeofkm+bQq/X22uQaztmwOrWoj6/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vdil6LwU76GOZUC4jnyhnDYfDEUFQITklnF6U3hz4McTLFZ1yfl5fKZSwTtWJvhm7JVNxDMS+2Kztf+yzgjNRs2Xyf4ah4hAlldF6N/+v/zWfSy9wyds48fk/IxTdTMB2+vsKmsvIXKc2bsrACI9Ir2rcd7ChLuBdYmXo+W2zno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NjgtSB1S; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NjgtSB1S"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784798785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XIWnFbpxQ4ZXsdtj0a8s2VHcoPJhe1/65/HLXErAgXc=;
	b=NjgtSB1SmgHOCzdwo08S6xhWypZ/Tujp6exhrXSND0mVInZRs3G0ysQ4RqSkLfxyJJJboS
	kJw6CpPdlergpMaRg1SyGX1FgYPEcEoutmxUX0qFUkjTdvGD/cNS+s/WzrGT3l61cv1mYR
	i84eQEhVGyZbS7nc3ONalM2lcggOqOc=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: rain.1986.08.12@gmail.com,
	zyjzyj2000@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net] forcedeth: fix UAF of txrx_stats in nv_remove
Date: Thu, 23 Jul 2026 17:26:37 +0800
Message-Id: <20260723092637.2135095-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

nv_remove() frees the per-CPU txrx_stats before unregister_netdev().
Until unregister completes, ndo_get_stats64, the NAPI/xmit data path,
and nv_close()/drain may still access txrx_stats, leading to a
use-after-free.

Free the stats only after unregister_netdev().

Fixes: f4b633b911fd ("forcedeth: use per cpu to collect xmit/recv statistics")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/nvidia/forcedeth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 5b0435d7bc39..106885bd0f6b 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -6187,9 +6187,11 @@ static void nv_remove(struct pci_dev *pci_dev)
 	struct net_device *dev = pci_get_drvdata(pci_dev);
 	struct fe_priv *np = netdev_priv(dev);
 
-	free_percpu(np->txrx_stats);
-
+	/* txrx_stats is used by ndo_get_stats64 and the data path until
+	 * unregister_netdevice() has completed.
+	 */
 	unregister_netdev(dev);
+	free_percpu(np->txrx_stats);
 
 	nv_restore_mac_addr(pci_dev);
 
-- 
2.25.1

