Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF43AEB29
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369265; cv=none; b=Gs47rvBYimh7bbDx7zjiqNNUkp58wyKrtd4XK8FO9z+Yx7vtC/Icbhyn3ZfRJWDpggJ00BMBlyF8UPYs8nJujh9DWbGYPdwCA0JSR5V+dlXHgYeGEHNsGpR6FOhpMos8wtGbcaktBxhdPgcL5og0Ias1YxCVTyItMbUM6FbM+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369265; c=relaxed/simple;
	bh=m53EkhQFEeVWYP+OkPDmqEJQ4fOSY+ZFOJarQope3ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2079dDHj28Awd6i2IF+2XZFZR6nAV1QBFToSpPd9KL8GKs6ZNwuKmumRzmTW5u2poLH09dQaMa1x+Ba8VZf4dilDGjv3IrInphRneZZ+xahXAWdyT/oW2udig5K54g5NBBNaZ8wt9tExXvX0+wT3f0TZzcdYX2VepqkLyLplIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUUIcsdO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUUIcsdO"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84867f07d63so2166115b3a.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369263; x=1786974063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rWtRbZHwwJKxr9m3CvsahX+FmG6nPUQO4TaHyIPdRr8=;
        b=hUUIcsdO8n63I3MroaQ5IychCQiR9EfZj0Kq8Cyp3XKBszsMXOkvVVpAaHQSf2PX8Z
         ZpYuxJPvQDy2lnM2GeTTvHNXnEsHUjAWzHsuTg0xP6choYgZ3AwzexC1iXFk+GeU/GqY
         f9OqMM9AhvfgOnj2Ae/Ln8buaoIex2A5wVhZhDLohHInm7qMiRz7mYdyVq5IxjQBBDV5
         fk9etYiJmRziMezg1T8GuS2oZDEfi8aRK6cP/wkk4LsnqN02e3yAQ1davXhTMjTDi3ue
         OmHZCzsFOCyrNZPWxSZ6IKB0+9CzkxlkfoT0PTSzWLtJ88qhFxEjv1pwJCzNXKKUHNFA
         w7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369263; x=1786974063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rWtRbZHwwJKxr9m3CvsahX+FmG6nPUQO4TaHyIPdRr8=;
        b=bwiDhDPhQCNleac/yjRHEDi1ac4GpZea/OrO5iikc3aK29smBZnHBwssrEyz6BspIk
         87j5WgLkwLT/D3NkFhjfO3FYw6+RXUmnu2vJSbj4tvPoMIpRDHCAoTRjY18znf74ONhX
         jeXeisSbZMrPcNCJY8f5VTRqO1P/6qqhQjKo9I2IpbIGDdUBYUvjdkZjCQkZru2bUlAJ
         54qJpfGIz8WdFzSztmEusQJ0ITmKp9ZV+WnulzaiwdgMORSdzvZHHAhUbso8KP3zfBdX
         80uUk9umYarvQ/2J63DgmUenYvnPzyMevBWtcn8gdULFBpTCZ1hV6MpDn4qv9ixK6GbB
         5Vgg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5ElbJVvWjnPgfN6HgiPKhK7v/GZCwj97Lfm4CZYULFfF9TpSj+czn0ydghXcthHf7wUqv64c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBf4eFkGZPl2QRakWyZ5zq3M7IorizXEjHn1mLKQQBXIm+WHAg
	80VuTg4Ryi3N+pYtAwoC9tY3Q6a/v3g9XF8k22+fkG4xKlVXbWAWBd7G
X-Gm-Gg: AR+sD13kUomHpOjYrRAU1BooFwxl5NDHUq9IzmPenKJ5mawcMsDfVwi1o4mCJSrD+xg
	tebkQ6G9K3eEJK9CXzm+u1X4u6Wxx7ksuc+bdsy2ZpDwxrh79PzUDB+ZEZWOJQ+v20g8LUNVg/w
	oz5u1RPd5PBOp4WqW6DyHUauJpgVz5RXh+JmDj047wk5EvjKmELJW/BUUKsC3hEubbDFpGYc3TK
	n/ldvFdJySs52wFcd0MQCars8ga9lMpJoP/QY+UoeT8TEJqB0Bqc/BdffbW8bN2/01Q2lcXi/oG
	sUfkplWtPRSXy8ZvtuEyWffaySFnb2SFSusS+qQlWSAgQVIOg5lpemIbXLguKi8W++0Ufn/Pf9j
	RkHF5xkZcnpufZvS7R2s3rN9XooQx+wtrR+n/HJWtSOZyOPRCTanEjrm3oz5kOmNN2/SRBz+J2U
	3SS8w3PlNM/7c9Vok+erYexS76d00Bb5dZPC8lzNCaH3ZaM1T1FKjdiGcp5dk=
X-Received: by 2002:a05:6a00:4086:b0:847:b16b:46d9 with SMTP id d2e1a72fcca58-84f9c9983d1mr1774067b3a.34.1786369262252;
        Mon, 10 Aug 2026 06:41:02 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51f166sm4006236b3a.35.2026.08.10.06.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:41:01 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Mon, 10 Aug 2026 21:40:17 +0800
Message-Id: <20260810134018.143973-2-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810134018.143973-1-physicalmtea@gmail.com>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock_set_features() leaves the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
continue to use translations installed before the feature change,
including HVAs made stale by a later memory table update.

Detach the device IOTLB before acknowledging a feature mask without
ACCESS_PLATFORM. Serialize each virtqueue handoff with its own mutex
while clearing its IOTLB pointer, resetting its metadata cache, and
updating its acknowledged features. Keep the old IOTLB alive until all
virtqueues have dropped their references, then free it.

Also drop queued IOTLB miss messages and wake readers now that the
device no longer accepts IOTLB updates.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..7372c22691de 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -851,6 +851,30 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	return 0;
 }
 
+/* Caller must hold the device mutex. */
+static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 features)
+{
+	struct vhost_iotlb *iotlb;
+	struct vhost_virtqueue *vq;
+	int i;
+
+	iotlb = vsock->dev.iotlb;
+	vsock->dev.iotlb = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+		mutex_lock(&vsock->vqs[i].mutex);
+		vq = &vsock->vqs[i];
+		vq->iotlb = NULL;
+		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
+		vq->acked_features = features;
+		mutex_unlock(&vsock->vqs[i].mutex);
+	}
+
+	vhost_clear_msg(&vsock->dev);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&vsock->dev.wait, EPOLLIN | EPOLLRDNORM);
+}
+
 static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 {
 	struct vhost_virtqueue *vq;
@@ -872,11 +896,16 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
-	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
-		vq = &vsock->vqs[i];
-		mutex_lock(&vq->mutex);
-		vq->acked_features = features;
-		mutex_unlock(&vq->mutex);
+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    vsock->dev.iotlb) {
+		vhost_vsock_clear_iotlb(vsock, features);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
+			vq = &vsock->vqs[i];
+			mutex_lock(&vq->mutex);
+			vq->acked_features = features;
+			mutex_unlock(&vq->mutex);
+		}
 	}
 	mutex_unlock(&vsock->dev.mutex);
 	return 0;
-- 
2.34.1

