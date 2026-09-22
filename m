Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F91552938
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084242; cv=none; b=dWjz47DhPbbC7mm8R31GpdH1zb2zo8hsk6aPJrK8XV2r+FV0GjADspxcGlCdGc03FB4lIl5hzoUGeGYKfEK6FKFaycPU4pMjPuQfrg0IXo5+UkSCjXW21QJpF481ZyHzEWdPZq1OI2rjYD+1JMHIuq+dBFm396nhdunYhtuOaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084242; c=relaxed/simple;
	bh=mBdcqcN172KO80HSi7Th8858r5FrM5kirxRy5AQ3cSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWhDgRJd2uG1yT1rG3fPQ9LSKJWtos6xnxXDy56YVTUHPNqehUtOmJ6KYAfX3cSypN4JFayREW/g7Ld+Q3jXFbxj61yURJTF2/icfE6CB9t/b0bvmgqkWrFLHXXIiUcYVhcgtGeI18Kt2jSQ+PZgaqpXCTGAHPmFpt6qa7V5n9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHYQDAea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHYQDAea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D941F00898;
	Tue, 22 Sep 2026 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084241;
	bh=PCJLpRfxtct7DbafgSfwq4uII75Mlz+xgFX95QdMSj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHYQDAeaZmEPkGZUIYDYbz8ItZVCEMU1kf5ewfwNr7Pr4kAtXOIY89sTbMDNDKmEs
	 dke1qMWCtITm+rq4aIBUT9OZi7gsQAmUEeCQYjYA8VqcW46LlkagFpSx+3oJKW82T7
	 PvhTSq2So11dmhiNu6bGA+03Dg6TcWfykM/IghSA0qUw+RIy9WXH6QxiONhJ6gOPUL
	 S5nIU/cwaBK13Y24a6LVBGg8xFzzZT3iQBnfj5TtEa60seHq4H6vgsTidLRmUdsEGZ
	 L6Y/WXAek8A++k5uQfo4BKTdxOOUb4HSzWkMDJguYzc82Ms920eDtLAnpijHL9nnAJ
	 tkhfjrkvV8OzA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	Martin Belanger <martin.belanger@dell.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme-tcp: start error recovery when read_sock fails
Date: Tue, 22 Sep 2026 15:37:07 +0200
Message-ID: <20260922133708.84522-2-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260922133708.84522-1-hare@kernel.org>
References: <20260922133708.84522-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Belanger <martin.belanger@dell.com>

nvme_tcp_recv_skb() disables the queue and starts error recovery on any
errors. But if the transport encounters an error before ->read_sock()
is called (and hence before nvme_tcp_recv_skb() is called) no further
action is taken. This causes nvme_tcp_io_work() to stall until a command
times out.

This patch checks for any error returned from ->read_sock(), and starts
error recovery when the queue is still enabled (ie if nvme_tcp_recv_skb()
has not detected the error).

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7eec983c0ead..2f1ae3968678 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1422,7 +1422,23 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
-	return consumed == -EAGAIN ? 0 : consumed;
+	if (consumed == -EAGAIN)
+		return 0;
+
+	/*
+	 * read_sock() might encounter an error before calling
+	 * nvme_tcp_recv_skb(), so we need to check if we need
+	 * to start error recovery here.
+	 */
+	if (unlikely(consumed < 0 && queue->rd_enabled)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"queue %d: receive failed: %d\n",
+			nvme_tcp_queue_id(queue), consumed);
+		queue->rd_enabled = false;
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+	}
+
+	return consumed;
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
-- 
2.51.0

