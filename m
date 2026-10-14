Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972092F7F05;
	Wed, 14 Oct 2026 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960178; cv=none; b=pVRzU7PeFLSNc6uuBzHPskiAWkfDTQ6KJ1eu0s4ikZf5ECT+78mMayW9s4ovfeDkPnJRJTKBA85tojMu0wvWL7yH6BM3lVR0sCmqjVpYzvhxePRXCMPAsrg8dhUbZE0L7SVScG7+nz38SKaZmokyXG5aYVJAwTir3h+d2xMAHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960178; c=relaxed/simple;
	bh=hAlukcTVlemJDMH1tcMxKsSVPOBw47EG8GguA9EFPP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bE4qq/OtGfZIHq0OFSVvDZme/cjK3+3wNzaV6CfMZg2xckg9W5OQcy1CoqLgh5IBbWHJ0sLBC9okH5o/3HkBA2ypJSW8uSI75Zbex/Sw7ZrsV4KZHDr2uaqUB0xx2Vwo7fpig2GRtqabsNvjdpFr5ekDeEDDg48QsBB88WquCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mWZxpNTI; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mWZxpNTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iJ
	IuX/aIEU0eARygIk3MkWkpVxNtFv/aphxvSLEZSeI=; b=mWZxpNTIMjUxoOfrFb
	06nzVYU0qqVoDGRRPalAlCSTBKniqopcebub7wGx+XklXBo5XErfvZVg+rAyOZe5
	MoRjOlvhJj2uATttgOupH9H71x8yC0l0JKHr+AZGOOS4hTnJDzP1TyFM4HW6lwOj
	2uFIKMqKsij9uiwdjQgbbhP6I=
Received: from colol4bi5.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgC3U3g9JM9qUVT9EQ--.44584S2;
	Wed, 14 Oct 2026 14:42:06 +0800 (CST)
From: Binbin Deng <18983559317@163.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	rkannoth@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Binbin Deng <18983559317@163.com>
Subject: [PATCH v1] octeontx2: Fix use-after-free of qos node in delete path
Date: Wed, 14 Oct 2026 14:42:04 +0800
Message-ID: <20261014064204.291688-1-18983559317@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgC3U3g9JM9qUVT9EQ--.44584S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyUAry3JFWkur1UtrWDArb_yoW8Gw17pa
	1FyFy29FykJr4Skws7ta1rXr15Jan2q3y5K34Yvwsav39Yk3WfZryYkayrK34rKrWrG3W2
	qFWUAan7CFn5Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U01v-UUUUU=
X-CM-SenderInfo: jprymmytvvmjmrxbiqqrwthudrp/xtbC3x+mimrPJD9TMQAA3w

hash_del_rcu() only unlinks the node; a reader that already holds the
bucket iterator still uses the node.  The immediate kfree() has no
grace period, so a concurrent transmit on a socket whose skb priority
carries the deleted classid reads node->classid / node->qid from freed
memory (use-after-free in the softirq transmit path).

Fix this by calling synchronize_net() before the node is freed, as
mlx5e does.

Found during a static-analysis-assisted audit: candidate sites were
surfaced by a Coccinelle rule, and the reader/writer paths were
confirmed by LLM-assisted (GLM-5.3) code inspection.  The issue was
not observed at runtime; it is identified by code inspection only.

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Binbin Deng <18983559317@163.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index f160b1618efa..2ede0b84e5f5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -331,6 +331,8 @@ static void otx2_qos_sw_node_delete(struct otx2_nic *pfvf,
 		otx2_qos_update_tx_netdev_queues(pfvf);
 	}
 
+	synchronize_net();
+
 	list_del(&node->list);
 	kfree(node);
 }
-- 
2.43.0

