Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634732;
	b=S61WtISFA8nOZgANhYFHA6074sBOjeeOGNhOyDDXhwiCjeuTXC2hJUvbnzSnTvdc3Sri
	 hyS8xIovax/hoUqe1rkVQ1Rv4+LA8Hj4ey+LJhhEtdIXlgPfkKlBqaqZV7/xle0/loFsK
	 10MvliQFLX5rDaZbDzA0K9zWCpsop8474YQcOptyMgUVcoxsIA9K2Kfv0QUG6o9kWYYCj
	 wvMZ4HBYyMxRJy9XFssPkZf+/0TizNis073FcWkqotX3eM7rRBivG3d1Cosjb4MQ0/VUX
	 skW9sMO/5cEEp7uIE19HsYxQ3r76Vo94w3+PZQqHm3Qb1ng9MobY+GpHu6QTDItnzgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634732;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wKLrw167uz5vnqL4s9bXN12DEPMpo4oId8hlYp1KDSc=;
	b=ggxK8yof/A8HwMi1LYuow0tdTuK/0SpLwvhINj94FQo72Rwem7W2qDcKUWx2HPtzrcev
	 KEtShMcKXcILGT2PMbf9CakjlQhBO3pMP1HDkb8DKtn8nOIPwSr4rtIXhom/jV5klUI/I
	 b2yQzrXg+RhYYvoMQ/+Z1jzycLRBEcVJl+4GF1GUDu4PMljT/FYbowh72QTNH0oWqiTuc
	 5CLpr57N99tCWzCtPUbASUeUdqth6lhW8EKdDSHPT/3TYER8joeEntqL5VHqKjzVMpJ0z
	 Hk8vMbgI5vobgfZFWKGw/rVy9FXP/dowfjC+kM4vaE7EDtyu40pyK43m3pZu6CShsFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=foxmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12F607827D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 15:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A12F607827D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3ae7c6a2d07so854059a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 07:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634732; x=1794239532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKLrw167uz5vnqL4s9bXN12DEPMpo4oId8hlYp1KDSc=;
        b=YyrS2K+pBoCzjHjhcezHosVunSsl2pV1HkB3jQu2qD9qDRN5lLO0zuINPpSBJPDuaX
         hZ9S7GTPo0HnPLn1b7LUBhLqZ+gsbo7CksbNHz0LTHGnmNMMSPvz946bUgZ9KYeuIhj2
         4TvDYxhfatqG+XmVf6g1taUlQdBlsi0HQAOa6UG4uicbEjWskhxu56yh1ah7Fzs61aAH
         kOBKXO6KidYuy5JoRxYQFEvPXRGpHWAVVSUaCBLVE315ERn3DE3QW+XjqzOGlDhJajF1
         dqcEvKYlMsPUgoccXZFKfK9ssMJeleS101BoManZlsl5NmD2JDJJLTpJlpkmpD7KSxox
         cuew==
X-Gm-Message-State: APuU4Z9e0rfMXo6s3tv9u/EOqwf8TQWXi5xjaWY5WhhXEvPbFwUU3BCJ
	vSYluRs0tmWJwrF1mVjJP0BIobbX2u2LPIAfWLsnuriaqh6/ltH+sK9omawNBAqb
X-Gm-Gg: AYBFou2XI3ddYideUCGQ711rGun9SyQC2qupVlZWkz7JgjbTsrlKMESlw08QIxP6S/F
	18W+FMxx8v+Femt7JYvBCeEyaNC8F/v6cvsTuooJE31yaScVkwwOw6vuptWiBkTTYkIBpZ7kxO0
	FA92ElhjKrOgvUk3P57sLmp50GUQ+PTf9z0uwRcoIVM5+X5D0duyM6Uzl7YWj/+1gTBk5DNJqTz
	jwuH8PE8N9GDEFKVoKrY9CXMUzJXc9TM8JmAMhBP5AAIcPXHEvzJfImOaRW4j3qOXWOGK4Q34eW
	28M82X9zrzignVxMQR0DobNgNbxxxq5D2n3lT6ZV9d8OKq+goB+UOZv1HUAzKxywf/uFrGjrbwL
	Pzyg2irOwmDUy44eJ9kX8iGluzKCj8o6fXAfPQ3joLe5aK6mCfcdiB+gq0YySq2l5wYdDceia+8
	/3WnzrG5q19E/Bbv4UPA504AKnrkPC7SwyEBr+n1hAgc/EKjFqB01pcBj96n2z1GbM7ovfv08Jx
	kIG9kApHslL32dMPIQ4IlVx9pla8i+W8zQtVmSEzMq+j9ce+PEMRq4rH9K/a9Q+CdOMbN3KOh9i
	CvVtM3D/b/8wQUJKAelzYf2OT/TfdGUn/kphWe4J25GLXoDJexFJt4njn3gMIy+weEo=
X-Received: by 2002:a17:90a:e7cd:b0:3ac:85be:cd56 with SMTP id 98e67ed59e1d1-3ae897ce1famr8769905a91.12.1793634731895;
        Mon, 02 Nov 2026 07:52:11 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845aa27esm14267953a91.11.2026.11.02.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:52:11 -0800 (PST)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	talgi@nvidia.com,
	hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: [PATCH v2 2/2] virtio-net: unwind VQs when irq moderation init fails
Date: Mon,  2 Nov 2026 23:51:45 +0800
Message-ID: <20261102155145.23144-3-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102155145.23144-1-shijianlin11@foxmail.com>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <20261102155145.23144-1-shijianlin11@foxmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_probe() calls init_vqs() before virtnet_init_irq_moder().
When the irq moderation init fails, the error path does "goto
free", which only reaches free_netdev(): virtio_reset_device() and
virtnet_del_vqs() are skipped, leaking the virtqueues and their
DMA mappings.

Use the existing free_irq_moder label instead, as
virtnet_create_page_pools() already does on failure.  This is safe
only after net_dim_init_irq_moder() clears dev->irq_moder on its
own failure (previous patch); otherwise virtnet_free_irq_moder()
would net_dim_free_irq_moder() a dangling pointer, dereferencing
freed memory and freeing it a second time.

Fixes: dcb67f6a9ead6 ("virtio-net: support dim profile fine-tuning")
Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe..d3ad1f1334bb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -7027,7 +7027,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 		err = virtnet_init_irq_moder(vi);
 		if (err)
-			goto free;
+			goto free_irq_moder;
 	}
 
 	/* Create page pools for receive queues.
-- 
2.43.0

