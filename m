Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE689B652
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773970546; cv=none; b=YUVjQGMCcrw0eC9zg/sJkeChdTYnGefl4gF2vEmM5Q8bAj3txe3D2IKcXvYYr8ictiGxWa/94xKRg2PS1ZSM0M+j2rxGoXJZ6vlzOAvn8VnhZA17UgkKv1UwqaonCx3U3NtBqjThas5V1A3NbHeAbIn+ie13xnm/QeiYhJQHA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773970546; c=relaxed/simple;
	bh=VkRQdVuBJATzzzZhpZR3rhJXQQ7erJTIEDbMp4KTufc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lu+bHPyu6IFS1W/zdIMv5VNVU+pbQxEDJh2Z7i5oH3UUhT9lWns6sIwF/mUfMGcbKyBV/nUPlkXiHS9qQMWVUq5AJS09iLwHoV6slRCinuAgWzJPYzBffuDogX7f3gwVRJ+b3tE8U1LSvC9qtfYOvetJ/AlmnNM5VmMAYQ4maI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bt9Lpbyd; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bt9Lpbyd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773970532; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FeQQv6rGFps7zJrCnlqon+i7LcIT7xaD3R6sIA0LYi0=;
	b=bt9LpbydXUZqSuuqKduZsCwSN+Gy0znDUi8G8ZGVxGaCRQwEOq7gthqml6zi26F+6rwys6UVQjgf6d5kFm+d46JamJaB/4eEfQdlVcWuETlu2sBfvrlcHxlPjqD0Z2uKJhC08+hjp44VM3eM75ziyDc2hsDOkVuijpvzcK4pVrQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X.Jl-Yj_1773970531;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X.Jl-Yj_1773970531 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 09:35:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net] virtio-net: correct DMA unmap vq mismatch in virtnet_xsk_pool_enable()
Date: Fri, 20 Mar 2026 09:35:31 +0800
Message-Id: <20260320013531.36931-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: d2e7c67b4765
Content-Transfer-Encoding: 8bit

When enabling the XSK pool, the header DMA address is mapped against
the send queue's virtqueue (sq->vq). However, the error handling path
incorrectly attempts to unmap it against the receive queue's virtqueue
(rq->vq).

Ensure the unmap operation uses the same virtqueue used for mapping to
maintain DMA API consistency.

Fixes: 21a4e3ce6dc7 ("virtio_net: xsk: bind/unbind xsk for tx")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a5a2..7c6f304b7be5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5917,7 +5917,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 err_rq:
 	xsk_pool_dma_unmap(pool, 0);
 err_xsk_map:
-	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
+	virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
 				     DMA_TO_DEVICE, 0);
 err_free_buffs:
 	kvfree(rq->xsk_buffs);
-- 
2.32.0.3.g01195cf9f

