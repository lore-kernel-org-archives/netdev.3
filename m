Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0957418A30
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692577; cv=none; b=QjveU7O6XiR59vCazMn0O7qLdBZ4v9FQSJ4+iacIXkAvAwoInKuybTOYzu7FC/xg58XtHtLiRrkaNHw0mob2u7uiElLZdX51Hkr8NcvYFxvU8tcwZdDDYN5iJrAi3ZqFCTzw5eS9vOgTN3Ycu6shIgmQqIXAQ0edZ5NAcRVegDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692577; c=relaxed/simple;
	bh=lBg0JhbsnNpsGb1wruN50IIhyCn8WZ0eKcALPJXFHwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRbCA2aHH8P8vwF2borO60mP+4MShXjkpnncHTFookijaFXTCB4zJev90NjeO9qVfGxcDJoNedIX5ZwCXkIotn24YlFfYtqdBaW//SEofHpqmuvywZeIGpioceLfu/RVaULhDpo+et/kFMMdNBu50j6eUK66bz0BE+nFwbvrhyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5m22vlR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5m22vlR"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso939697a91.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692569; x=1787297369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sb2mcYm1zw8ztLxWQHXttWOsqNChoxNNVKIkbMFY0ww=;
        b=k5m22vlR87KEN5e8D6r7wNHpVys6E772VUtKhbROw4/AKEqE6N/p1k/NtuoNBJvWFu
         AgoLqq1bAqTP54gb8kj7wf7h/vqlVrVS+iPY0bb3XEWntrEABPzWTtkarSIZ0OX9H0if
         LquE0PXj8h7crUyh5w3yZBp1PRcCbrsQb+Y7zzzdVAJ51JpsQWQvUMJnhIQdX7DjiCdl
         LvtUddo5dMJ/Ca9FvyFUE4mAMVelL2Mj8AhS5mYd98x64OU/giMXe8Q1AvSBT//adHJQ
         IFxdPgirDzTs8absJRtrDu21fBvQBCVjhpHMVFIoQ3oZUBel/vI68Nn2BDt6UlUk/kr1
         wqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692569; x=1787297369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sb2mcYm1zw8ztLxWQHXttWOsqNChoxNNVKIkbMFY0ww=;
        b=N92HOVMlxK3mcOfGHU9O+t0eA/yxrHh0OoH+kkapITSbSmEYwnGxW8JyAzO05BV31C
         0RctHRnSiE4QXtOGcim3SaYYr0wVopDZTFn/2ZuG6DDKdEHGOcc58t+g8KCoDMMAu08F
         AACKQ3P9/Pq7GHPMXHXzF9Pz10Ti7bIeilHuSTAUUmfErI9+8Kxx0i6Yy3jM610UW0Tj
         8jXw519It5qgBN8vDPakJe8YGRmWWa/ho4d9HKIvE2G3zBwEp1Yi/GPiVgdZGqi0M2tK
         HVNHNl/dvaFe/b1WzLV1B13YeGJAmiWIGjjhGQC4WNp+afKcWbu0IMxf8pMQnL9BRRj8
         RFZQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYR63OYEtLcB36HcDUrYDe6thW0ZccJ6z60Ds3lc+dx6Ski3MPrZGt1mDgNoeKy9unawRYgXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzchR5yByjIZ3cxDPERPVcsDrQ3iwoVgdtk9y1MqoZzu4b434D3
	sb3OZh7w07Nu5N+8EpT4kru7iYLfuENm19tQxDE/mhFoIp0W4QmwoV68
X-Gm-Gg: AR+sD12s2UtFeRmN79/C+T5MGUzc9KlUOG1tPYHmmQBqub0bi8dHmrosAg20/dEV+AL
	a7AeEsmyUyJRjSgy8kRPQNmbFx7uWcER8NEi8pn62QgMnl6eatjKtNf6As8OHi6q/VH6DR7e6RR
	hWjAbX9kgwWyjiMhI/XAaFH4mVl8HGiECvxfLRksgYgvRovHSkjIJQokKfajY9aPe3ddnLo1q/K
	kGIQWV1+xn/DHG0tuM3M4uRx2QIesD6n0hMrEVR+6fUFScnW0Yiz7KuCVB41opYrcX6kVsoAxGa
	Ss1AAzJo5XvB9EJGwBVkl1kOwDt0qT7UOJTBzl+Y9GafNLqc0o7WxQt2rbqzs89D07nZ1x2sxs3
	dybcWCWludVhzTvJSOy5HZkmmVBl41ZcBB6BKdmHy8EM0Bd+dP2E/qC8sEJvw+qeUwgNMKqoPNJ
	wGS9UWFwb4hJA8puNt2Wr/Fl2eMiFj0Fis4npMFqr34b3oP0V4owOSyuHh1Z0Ogus=
X-Received: by 2002:a17:90b:520d:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-3933b6d0171mr4528637a91.3.1786692568692;
        Fri, 14 Aug 2026 00:29:28 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebb888e3sm1388828a91.11.2026.08.14.00.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:28 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 15:29:03 +0800
Message-Id: <20260814072903.124991-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814072903.124991-1-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_SET_FEATURES is also used to update logging while a device is
running. When ACCESS_PLATFORM stays enabled, allocating a new empty
IOTLB on every call drops valid translations and forces avoidable
misses.

Initialize the device IOTLB only when one does not already exist.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index b69c260eaeff..9142fa1143b2 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -869,6 +869,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	    vsock->dev.iotlb)
 		vhost_clear_device_iotlb(&vsock->dev);
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    !vsock->dev.iotlb) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
-- 
2.34.1
