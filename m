Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00833B6F4
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027203; cv=none; b=rXj25AeTInGgDg7vuCInNUkXhXSpH+nt4m6LBTYcSemssU6cb7oNOUoaHLqDwQiB2JuIC/CpRxrdgQAgWOJY6kGbKyGskh544vCmsngkXEDaiASX4n7D+1alb+1LDF0uD0CW6I7e8vYsONEvJSr1jKFdvFP8pXyhDW8YHBAB2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027203; c=relaxed/simple;
	bh=i5lJDuKpaj451ORek1RkuNKvrVPA7j5ESmxEVRGGCBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pl5HveuUCOyMJMyP0767uxM3+jRYT2joPXMTYIKDSoFaRhgE5bJyNhyleI0C5SnSILOHBW2rud8LPCawcnyLoz938roae0XMOWSohQJ7Wz6vNtNi4L/5Z/UufSiWtO130As4QMiKDdqah7X9ZRZEGDXXcHq2aN7ntPWLdYyNkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9L0vp8l; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9L0vp8l"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8487214ad2bso5685588b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 21:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787027202; x=1787632002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UpRGh7AB0RzVN4Z1bHcSA/fyKDz1HZtg4D8+CDGvt3U=;
        b=C9L0vp8lUOtTTJ3fjJVkuGgNCTiZUbpBQbqt2vEad8zC9zU5nWTZiEAmXqkiJoKd+z
         N57AxHvecLsKJqE5p6jJ5WPzlVn9ZafnKl/B4Wv7CGgh+iTv0IAIY21iy6B4QhAk4WT6
         PZ1G4Vs8Qi2tX5yo85nl6eRfe/v+guzMfLXnSJH0ct2NRjkso5gGw6UJM+iPlzjCMCKP
         5qEFtCpzvooKVF4Q+lkg4PlZD6l3RqYDweJXzr/XXejR8d8aJwdmVFhAIHBb4JSLPTjA
         pkLquiyP5SJWY3lFFO6iDtkykG6li/3XRFBuOW7Z3dERfVNJieVI1OuyHuuQtm2hpl0A
         Z4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027202; x=1787632002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UpRGh7AB0RzVN4Z1bHcSA/fyKDz1HZtg4D8+CDGvt3U=;
        b=LPmGLgoxTylQY1ctukvc+5lnzfzun5yg6vQs+DslldkyDWmvjwuWp0Oc3kLu23gEv8
         aWiV0XLXqA9bcTGs79QW7DjmvdIBM+9wzU6sEBN5JER6dJ71DAb+fImM1lz38HcqzOoV
         ju00LBC4PqNVtmpE+/6ESGkAT+ARc6djDVxAlY9RH7f2Fk1BNYFYlkWMnSOv08Mo+4FU
         9ZPm3i00UN3O+0Yuabfm5iywt9WfX/JsX6qVAK7nnN8SF+Jn2xz1ukvXNVwM465eOBUo
         xYmktK6P++FDtzg53GdlgPfmWieNSt43ZiCiUyavLgp3YgqQmN6aiHlB9WYdI17/sorH
         pJlA==
X-Forwarded-Encrypted: i=1; AHgh+RpNGuCACSUOlOx0ks8zpIOUoEqk7xEJb5A4SMAe7KARw23xkiNVwo34qVG05GJsxe1JeVATg/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUdOHxAztCzARAfdl/6gMPjbgJXeHrM7mu4alIoqcS3HDGiynH
	OixWxVtZ2h+6dQmfNtV9smsH0UnF/9ZVjIgR8iCli/oiaBtvEzHg/SDH
X-Gm-Gg: AR+sD13j8g7Oh4jUlUkNk04seble9AxinWztkZWfkMCAhxZ1xNFrC4Ph5PrKVqWucKM
	VvnsAp67pd9n7vznGQrn8+JcIPT8oCAr1gtteWL50EYYtdsLwjv4wc/s+mhWNApvSLFwqZyyAns
	i9qSNfi0PFWW5H98uJJo4piSDQa5ov9PR7W758Z53iYWfaHyHTJZ5C6FnR12q02limbjqGnJ0Pt
	c7xshPKy2Ia3gIFPnOhB0k/RgiN4Jh6tj/4NfAXVowRIpioS5GSJONjKWro/b5MzU18M+IvTF5L
	axvz9yj2bYezi0kWFzaHLrH2D6tMthj6MgBKiU+L0D8zsgArgzl3m+BK+eIjhpUgNnkfQrDCkZi
	ek4bnvvIGSR5pvSzkmrETSRhDNZmd428tFPRWHtp/qT8P6ncmrZgbcLu8l3C3jyjQgcJSmD8z9T
	/0eoJz5ww3A7RtT6kcC5NPnTe8pGZskPVcWGMyLd2jhysWnHv9JfcHOblJjGnNXQ3RFiDjRA==
X-Received: by 2002:a05:6a00:4ac3:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-84fde001affmr33624373b3a.13.1787027201198;
        Mon, 17 Aug 2026 21:26:41 -0700 (PDT)
Received: from jia ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6fefb3asm1005919b3a.53.2026.08.17.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 21:26:40 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia Jia <physicalmtea@gmail.com>
Subject: [PATCH v6 1/3] vhost: invalidate vring access on IOTLB transitions
Date: Tue, 18 Aug 2026 12:26:11 +0800
Message-Id: <20260818042613.281125-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818042613.281125-1-physicalmtea@gmail.com>
References: <20260818042613.281125-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
used change meaning with the address space. Clear the cached vring access
state when the device IOTLB is installed or removed so stale IOVAs cannot
be reused as direct userspace addresses.

Keep device IOTLB initialization idempotent and apply the mode change even
when a virtqueue backend is attached. Drop the device-wide IOTLB first,
then clear each VQ state under its own mutex, and keep the old table alive
until every VQ has completed the handoff.

A successful live mode change leaves the backend attached but invalidates
the cached vring addresses. Userspace must configure the vring addresses
for the new address mode before data processing can resume.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 4c525b3e16ea..9f74537b1c1c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
 		vq->meta_iotlb[j] = NULL;
 }
 
+/* Caller must hold the virtqueue mutex. */
+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
+{
+	vq->desc = NULL;
+	vq->avail = NULL;
+	vq->used = NULL;
+	vq->log_used = false;
+	vq->log_addr = -1ull;
+	__vhost_vq_meta_reset(vq);
+}
+
 static void vhost_vq_meta_reset(struct vhost_dev *d)
 {
 	int i;
@@ -1911,6 +1922,9 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	unsigned int num = vq->num;
 
+	if (!vq->desc || !vq->avail || !vq->used)
+		return 0;
+
 	if (!vq->iotlb)
 		return 1;
 
@@ -2270,11 +2284,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+/* Caller must hold the device mutex. */
+void vhost_clear_device_iotlb(struct vhost_dev *d)
+{
+	struct vhost_iotlb *iotlb;
+	int i;
+
+	iotlb = d->iotlb;
+	if (!iotlb)
+		return;
+
+	/*
+	 * Drop the device-wide view first.  Each VQ then drops its
+	 * per-VQ view and its cached ring access under its own mutex.
+	 * Keep the old table alive until every VQ has completed this
+	 * handoff, since a worker may still be using it while waiting
+	 * for its VQ mutex.
+	 */
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = NULL;
+		vhost_vq_invalidate_access(vq);
+		mutex_unlock(&vq->mutex);
+	}
+
+	vhost_clear_msg(d);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
+}
+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
 	int i;
 
+	if (d->iotlb)
+		return 0;
+
 	niotlb = iotlb_alloc();
 	if (!niotlb)
 		return -ENOMEM;
@@ -2287,7 +2338,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
 
 		mutex_lock(&vq->mutex);
 		vq->iotlb = niotlb;
-		__vhost_vq_meta_reset(vq);
+		vhost_vq_invalidate_access(vq);
 		mutex_unlock(&vq->mutex);
 	}
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..3c75e8089373 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
+void vhost_clear_device_iotlb(struct vhost_dev *d);
 int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,

