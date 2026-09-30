Received: from mail-pz2-f3.google.com (mail-pz2-f3.google.com [74.125.228.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20B38C2A0
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756475; cv=none; b=IWa7IRIUIefS8mY7lB+6K73bxNH0HQpvJ2qH8FYC7TzEzyI1ZsdXuxH7Pbe5jMKGgV48QLmOIG3PPVPLvCwCTn7saFmCsBFu1UfqcLBtGg5VBsQN4kskhKTpbd3+8sLB+vp9kEwCIVlu5yRHeL0Ur5qxpwVC/prEH7S0ZWM0Al0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756475; c=relaxed/simple;
	bh=P0WnxZam+SUgpdEBgJI3LyZDEoc1jUHTMId8rRtkibI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOoyv64ltAPiEBt4IEZyi1dsFiX7/MRX6njwXDYJwQjPWYR/u8W9wvKXV7nx4cK+C/Zlvgf9p90whDsyzSDYgcIEx06T1yKYY8eAnlJQJrJiDK3YWwc1g6W5TLhRDWCLngyM4nzzDWpdEFyojVlwF0+oh7orKGZhr9pILXHGkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.228.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pz2-f3.google.com with SMTP id 41be03b00d2f7-cc78c03d45cso606100a12.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756473; x=1791361273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eq1BMklhPqpvc1j1QI1dLTGY02tlXth1DYlMuyL2BbQ=;
        b=2kOhmMF4+wyZaNhlLXVrOAF34AHVZI1Mi5NtRvslPF13ziUsxt9bVAH4794/ryDOWo
         RZ1fxUpQJItsJJ/NO6hIWHFMCn/3USuqqaL/eIrYWO5vLrl15j3PO8qjYOau8UN6fPO6
         NzWJL9t8Ro5E+Ep4jYbALhvOwB7inkOHaZfRHVrOGsc6q2YFYC3KasUORfe2jO7hE0+n
         f+E2rpMqpGNQOTL3m8w7CUrzhcHWsqKkTqGIQgTX7UuPs+ZStLFdHofNd2AtGTTk9/p+
         cmURTYkUHvjpGBTG7XpYVObiAi53qcGlaGbCPsOECV1iHbZ0i7TQD/zEKIXPD8uA0WJw
         eQgA==
X-Gm-Message-State: AFuF++mUrCNse39vYFCoISkGbWNcTxl66kdR6GW4YYXEmMtfT0oKZt+k
	xg5rJkb+rYKQVBLRdXywAML4293N/RpyJdgYrxySHnC7DazYuxwjVYGhe5MkiDgMPL1LLQ==
X-Gm-Gg: AYBFou0mPJ7C9z3U9nonhoqtmqHNHohsrluejSzHOSFN3nTzbsExvul9Ugv2Rm+3kRu
	tqB9FVnAvBgKuvw7CZfndp7wb3Aj0ajs1aBO4J4ORGFDR0PXfkFEr32kaXHHzt/SfB0ZyUW/Bcm
	w8kbx3nvY1K5orVXdpRa0kLwg9bJy+Vrau/bJ6y8e025ZEOlXwzwSi1wEMNLEsQLtWsEd0l9gmF
	V2pnX374wVQVfmG458F2gp2IhNacfnGgtlC/uPD9HpI3OC5nvR3LU9lOWwwZ1nBt7+aYefn0lqi
	hiaGETtjZJDekFlqPJMWfSzPbRSiUsYe6XKQDIl7JhYgHx9Ggd7VtNbYt/4xJ8uuMyr51NBXEI2
	+DiznrdIGA/eS3K53Q7W7DClD6TBRvzKgPgvpLkAMdEscabqB+RJ/AAzsupxKTJyBc80MzasENA
	WwigTfJu57IAvYh7IFsYBmohCfpJk+lX7AYkiHWdGdrnFs7snIq20IomK/kveXjAd5HIhTujZHe
	p76gqsaaOnINr+pgcg=
X-Received: by 2002:a05:6a21:1145:b0:3d3:adbf:777c with SMTP id adf61e73a8af0-3de9e6e601amr682846637.24.1790756473028;
        Wed, 30 Sep 2026 01:21:13 -0700 (PDT)
Received: from foxmail.com ([120.239.72.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8872643904asm419955b3a.45.2026.09.30.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:21:12 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: [PATCH 2/2] virtio-net: unwind VQs when irq moderation init fails
Date: Wed, 30 Sep 2026 16:19:52 +0800
Message-ID: <4e21386a0840526578eac3dd10443758bf3b84e2.1790751008.git.shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790751008.git.shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_probe() calls init_vqs() before virtnet_init_irq_moder().
The failure path used "goto free", which only calls free_netdev() and
skips virtio_reset_device() and virtnet_del_vqs().  The virtqueues and
their DMA mappings leak.

Use the existing free_irq_moder label, as virtnet_create_page_pools()
already does.  This is safe only after net_dim_init_irq_moder() clears
dev->irq_moder on failure; otherwise virtnet_free_irq_moder() would
free the dangling pointer.

Fixes: dcb67f6a9ead6 ("virtio-net: support dim profile fine-tuning")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e34c52d059d3..ef61097c4404 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6996,7 +6996,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		err = virtnet_init_irq_moder(vi);
 		if (err)
-			goto free;
+			goto free_irq_moder;
 	}
 
 	/* Create page pools for receive queues.
-- 
2.43.0

