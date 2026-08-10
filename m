Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5C3C3F7D
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363036; cv=none; b=eiO6+v2SeZrxrRiX7/JoX84NYlocSk3DFIbMuCJ0C49/LkV9JyGmyh86kawqCJ+wPpZYrxa75a1s28zz+CQx/M6PQtMw5q512JHzU3DzhVEs3PHRPxfWcwLn+DIitY8Yivtnxd/ZzcoOQLA94O8Sa8KR3gyQOUOjczaYDHhlLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363036; c=relaxed/simple;
	bh=FaheUX33TRJ4qYN53f+S4rMRfVUaGE8qHSXgcixbUww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pF/W7QIpxcJ+5CSl0MLZP2R1UZPR+4VfDBKlW7HOoem7fPf+wgIsGivIal9FmlOtwrRRa0i4LUMEK6GjDoTATPX+DDZ7EA4Pu5oT8rJJ1bDIM3XnA2VeU4rxqydKV9GlokKAYmSnX5ubnkGB6OsNfZmdRE7slqrqg9+KErPZPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nG8QMI4+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nG8QMI4+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so6878215e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786363034; x=1786967834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lTRbu60u5fOzuvM1p0IBRxQ+W8tiNJ4MYzXEdegdXNo=;
        b=nG8QMI4+YFHelz4ww9z1ymxz3b514NOh7PMSmGk6jkbab9V9GzsTtRAl3FDdn6gSkT
         taG7zdIH/srcvyAIGTwwq8cPP+/ZRJFsmSG9aMjhjRIwBPUnlpnrBQzuE6anUKPWhA85
         MZEUpzqOtrBZPun4q75Y3h5sDThEvFGgTB8t7MAkmVw9yzKKOb1fzMM98RhRfI0YB+te
         odVUN2iQIWt0DcvjPKcSvZrmVQ829k1LGnQSp0DXDEqFM051cZV5UidmLbvg0/1Cjgjs
         CJvzxk5Yvy+7oWyTjX/L0t00I1uWXYiZ0KC+qoJm6dU/gH06FrXg5uda/Zf3d5NwC3P+
         AC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786363034; x=1786967834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTRbu60u5fOzuvM1p0IBRxQ+W8tiNJ4MYzXEdegdXNo=;
        b=a5VmpPv/ffQnaO85TCTtssFCdmGCzcG0CuSvouWO0r/SbZCYLEnpGNC697g715LOLd
         b8u6pki2GgeQhbzqWhfURwYgcz7NRqIwJv60hNXPrZXOz/MPJHLUkBi7v8l0xA/fy+Kv
         Eu79jpBVOjIg0w9mJ0HascGKxe+XRmDqSApPN/bScHXv9nfBvbyQjwM8Ctf3EBI6Lq4T
         yRWeoqkjcRyURgT/bWppnU6i0poWZ357TC/v3FqBmZ6JFA73jfUEcswZIQoWW3ZbV02A
         X5d70OQXwotmrfRAFwpENGpjTwu61O+HTVBTKPCyC59OvYbcCv9ERTuPWj0hSpkhTg1u
         iILg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7S+FOjqVzaE6Oa3u6prbM0Eslh7aemI+VJuk6aODJEBRVxnNKR+mMGR5Tuw1ZFZwOdDuoguk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMXAdZkY3sQHXBjH35nBzp1/Gpbk6Hxt38g6LanG3W6YBaL3uQ
	yvXdVsfLhuLxidK8HEfrU0MDkuBLl/3CxxmI6qr++l9esswwBMR1aFN3
X-Gm-Gg: AR+sD12WZlsoLI293Vpdz+Gq6pJWFKlluJ/yPj0XA7lQKQPNj5xeYvjq2ISlxcNJK5z
	JQfMzmrZi4guGLjtsGOP6a2lHxcLXiM5TYmH9REyBS6/6J2wMv2wAyDGxOwxRrd2sx08j11JHik
	fsZvifN5JZ0FnQsDhnvt9I58Z+ziJykzhIxoqQ6r7+5UMRWVdAxTYqWFPZMG502EdZntkFOMxc2
	k6v1Qb3j+F5ZJ/jbKv7zEkXFvCnTC0aj5ANxtkqiYhYJHO7Hi7IIzxhn4Fj4OpD5ncXeIoh2ZSa
	uRzj2srtyRj1nv2+HZ0UucW4wcHrcvlYgHeJlF2YRqYSSV9uTBarGhK9Bth6DMBGUMGwsQ0P0CM
	hz6dha5lOiAOadBPKwpcO3ojgRzc77eV6uHeY5cwJF4LjJ76VVHJr85lsuoylIOV7RaiB3tU97f
	PV4cLWDGtysErZU3hgScEZMvF2jwpPliJEYiU4E1ZPyKefc91CJtQ5MDhMxIelGE/dYEZbm4PYo
	xd1XnWfzvsnppqQ9m2xkuRUcNXlcg==
X-Received: by 2002:a05:600c:470a:b0:495:6338:1453 with SMTP id 5b1f17b1804b1-499727a866amr14257735e9.16.1786363033266;
        Mon, 10 Aug 2026 04:57:13 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021f9182sm34997090f8f.28.2026.08.10.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:57:12 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH net] virtio_net: Fix resize of the RX ring
Date: Mon, 10 Aug 2026 12:07:25 +0000
Message-ID: <20260810120728.47445-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a AF_XDP socket is attached, the virtnet_rx_resize
should resize the rq->xsk_buffs XSK buffer array. Otherwise,
when the size grows, the virtnet_rx_resume() causes a write
past the end of the array. This is easily reproducable with

    ethtool -G ens3 rx 32
    ./xdpsock -i eth0 -q 0 -r -z &
    ethtool -G eth0 rx 256

Fixes: e9f3962441c0 ("virtio_net: xsk: rx: support fill with xsk buffer")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 drivers/net/virtio_net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c6c8..e34c52d059d3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3444,17 +3444,31 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 static int virtnet_rx_resize(struct virtnet_info *vi,
 			     struct receive_queue *rq, u32 ring_num)
 {
+	unsigned int old_ring_num = virtqueue_get_vring_size(rq->vq);
+	struct xdp_buff **tmp_xsk_buffs = NULL;
 	int err, qindex;
 
 	qindex = rq - vi->rq;
 
+	if (rq->xsk_pool && ring_num > old_ring_num) {
+		tmp_xsk_buffs = kvzalloc_objs(*tmp_xsk_buffs, ring_num);
+		if (!tmp_xsk_buffs)
+			return -ENOMEM;
+	}
+
 	virtnet_rx_pause(vi, rq);
 
 	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf, NULL);
+
+	/* virtqueue_resize may have changed the size even if err != 0 */
+	if (tmp_xsk_buffs && virtqueue_get_vring_size(rq->vq) > old_ring_num)
+		swap(rq->xsk_buffs, tmp_xsk_buffs);
+
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
 	virtnet_rx_resume(vi, rq, true);
+	kvfree(tmp_xsk_buffs);
 	return err;
 }
 
-- 
2.43.0

