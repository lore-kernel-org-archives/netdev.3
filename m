Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6B2488DAF
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351553; cv=none; b=jE+4sbCx8Ljrj0H+UoYldH6f3zHv7sfGGQkFGKp2NB9i21di1rTkL56NEf65W6vgFoQrZa5hznZ+bIEGbdxxW1fX2bYn2iqjJesa6OiY9uthyt/Z5tDxWiZpCziKmGFSpAqx5TAcczx9qktQYddOLDQiyv1DNyqWnE3/H8fycVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351553; c=relaxed/simple;
	bh=LINqEAjhBd1g3ddyfQvwFEgKvXuCbYGwNsK5S7WkpgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJhLOAuPlRr+Ap3By5bgRR9kKrHPi2+rRXaenYqvZhoeAFT2aNL6rOfRDGxOMMb9E/qCgHcFRV1m/vGb4cPTbyMeT6MniQ3g1jxBxsFfmHdIGb41chKDEXCcjclALd6ErDPMn595wDbHKfCyjPZChKNAoqwIVooyWP/sV7vQojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dks6aKjB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dks6aKjB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so1543124b3a.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351552; x=1785956352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o0V32/dXsc54OzyFlhNUR5QdyRJlD72q6lujfqiekg8=;
        b=Dks6aKjB8MZRfMiMX/XHrClAMt/KcI0vR2m+V8uSPrZB61/EKuIJLpcIgreQnUZV1c
         D8C2TACFHgwihz2tPtDYkO/8hTdCreUSMpJ+FwgKfZzkcGgyb6BCj5fLe3WDgeVGbjiq
         5IC3Jo125rrZUa8KJjfVvoXJtXTOvThrXksejJZnWphLo3RY1D4Dfjlxiig+KupkuNSz
         LNrKHUKgw4M88r1p4dm5TLfCznIDeDTKhbpgjStwbbW+Dj/8tyT5QaOpOyuzP65wCcGd
         72AgM4lkTLhH967WAL44O2mndLrCQcFfyW1yAraV4Wl8IxFUtujfVtUHirBVvAmBynjS
         3JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351552; x=1785956352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0V32/dXsc54OzyFlhNUR5QdyRJlD72q6lujfqiekg8=;
        b=K9mc304a805QCSly9KVDXwOo1t2N+5j2Y4frb+ORomOpB4POv9NXEA724xkKramp4n
         hrQbaEfHMtPs/zLZaNoUpdlYLZN7vFb5mKl8dPl7MP7wlpE6iqfUQvDBo/d+bSAtVXrx
         E/uV1+8dLUAGWE4bU8jYANbBROJ/nIqd0p7LECsClTjC6EczyfdJ3DESPy85Ip09IkQM
         xZB9i3iaJRylGkPFJU1zz0V6jsLYQi5SqlAY8LwHGvj9ii2AEWGS0m52or96oWB7h2AL
         IxeEYakcFsu9pwkptqTTFlkW0ZY/EXzn1p96Se5W69JTjW8PmoTBSFUn78j4qmuMFjnl
         Klmw==
X-Forwarded-Encrypted: i=1; AHgh+RqI3MgEo8PhVomH2qav16q/gn4WbmQtYy/6XUGBszDVshQvX9mCm3lu0r6ldqp2zuYgJBgKAHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5JcE8FWT9Ia42wBl+EelilP3hH07cOKq8/TOt6K2rZlCD0kDf
	Z8XGqB3SVizapsZGuG7PyAv7beA3BD6ZK+JyJHjpRshdQ50OWw/X8NBd
X-Gm-Gg: AR+sD10zpXfCIWQ/QoqkhM8Zoz1U/GeAJ6KMwoqd3F2r02enIJ8U9+iy23IEVOmFur0
	IV9mDVziUW/h2zhAmTg9PLD+pqtd8gDIoh8/+taoesgebbqY3maRobckKVTI2MuQsuCouCDg610
	uTQdCVLybZSn/kvy1VmHxpzYJiU4fcCHpWtoMopCGwi2R4salxRmrVVIQB3FfjuQ8V4yuooqJtH
	Gii7Idr99509heX1/kv4COn7KnQqQPx0obdWNY0fiKLJFJ6rZZj8CckZyGRUrzmG4u+BOyml4NL
	ELfmQQ66i+AK5oXI1MSyYsUyCJ3Fpo99ns7C74AL2SY31/tDijhvjd3lMkGNAqrpJsJSl4BIyIA
	jMUw+gftiCC4kzobT+ijD7mhbMOm0UViexgZmSEJGZc0pF9Qy9Hph5Dm8F/nW4ZNNv66YRM7ZWo
	MTNmJFXEfXsNENSdmmO0c+FHbQKwrfWq7xDwdZ8a/cOCQ35EGyQTZ6nPPXg707udU+gMrk
X-Received: by 2002:a05:6a20:d52b:b0:3c4:5f94:f22c with SMTP id adf61e73a8af0-3c8ba5d871fmr9455053637.43.1785351551927;
        Wed, 29 Jul 2026 11:59:11 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba447107sm1237829a12.21.2026.07.29.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:59:11 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v2 1/2] vsock/virtio: read virtqueues under worker locks
Date: Wed, 29 Jul 2026 11:58:27 -0700
Message-ID: <20260729185831.3247971-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bd50c5dc182b ("vsock/virtio: add support for device
suspend/resume") made the *_run flags transition from false to true when
restore installs replacement virtqueues.  The RX, TX and event workers
read their virtqueue before locking and checking the corresponding flag,
so a worker delayed across freeze and restore can observe the replacement
queue's running state while retaining a pointer to the deleted queue.

Read each virtqueue under its mutex after checking the run flag, keeping
the pointer and state in the same queue generation.

Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 57f2d6ec3ffc..a8e1dd95ba8c 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
 	struct virtqueue *vq;
 	bool added = false;
 
-	vq = vsock->vqs[VSOCK_VQ_TX];
 	mutex_lock(&vsock->tx_lock);
 
 	if (!vsock->tx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_TX];
+
 	do {
 		struct sk_buff *skb;
 		unsigned int len;
@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, event_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
-
 	mutex_lock(&vsock->event_lock);
 
 	if (!vsock->event_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_EVENT];
+
 	do {
 		struct virtio_vsock_event *event;
 		unsigned int len;
@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_RX];
-
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_RX];
+
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
-- 
2.55.0

