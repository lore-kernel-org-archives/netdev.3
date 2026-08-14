Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CEB46EC6D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718821; cv=none; b=g14Uj/dyqGjYaRKJ6G04TFJ76NKbunDuYm384OeIrKofD2zuFJ2/1Do5AEveTb7xg4tm/mF+D2Y23/DPhNkp2Xuv19eVDq2rxNxwq3t+CFxOCPyxUr0YHgukTScGpo8Uw9UuAqjFwBaSAA10XwoQO+YV2KxKeAwBLEUksbT94kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718821; c=relaxed/simple;
	bh=AL6Q65vw+ZJt4TGaGgMNlD2ik6ILvC2I2FVHjTJiIRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgwqEtkzXiC/Ny4yuWH3WXV9jy364NqHUf8IochDclWQcsZnHv2AtykHUs6WGagvsY3HaETgZyvaxxuDJKifsgjHwqpedk3ZMhqOz2qJUOBR5BcrshDCRU7zr6YHxqeCkP6PcTWhuVZe+UVj/rQHABmWQDR2zjukFzanOvpCy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlJs5qbp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlJs5qbp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1130092a91.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718818; x=1787323618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xLjQg6E2MSVykNQCAn00xe/LP5TgPchFkGhjlJGqvKQ=;
        b=qlJs5qbp905lKSmzsXw8P54X7WIpLnYmXJQDiFBZnV35yodpiBtg2nt3LQZj42mcbm
         C/NMK3fPr6knkSiRtvER/P4TYtUg8ywRAYghgRjh4btmIqKslS0sddqBP1ukC0HEVq+a
         HpQgte3JG/885v7Ej7JpJnXbl2Wk23dKsnS6uw1vATP7e+mSTcckG6UokMUiQCgprBFh
         sYQQUAgXZ4gusGNovqmHhxQsK+Q2UbI9scGXqK15ODw5nR84KQgAvtUsslWqJlT2xWNV
         RJvDjJVBfkbe6nqWaFt71DwkhoZtJKp+pxszHGzuXNYXwQ6+wbOzF93S3AbfWb79I1zF
         0jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718818; x=1787323618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xLjQg6E2MSVykNQCAn00xe/LP5TgPchFkGhjlJGqvKQ=;
        b=b9Ei7BV/jFr+Jqd7E7xzT2QPx5XySSLANd1ceV7tWDla6r3Djm0wz6OtMXdrxk1p03
         zNAU+XSRbmuzCYp1sSGGSfniNzp+mE/hQFgoOrxlTOBVA0ynPcvE8z4ORuf1Osg5wlpm
         JQ+WSS1lb5QvZrWoPYK5GkRFgvuumZhV3ltzhA9Jiag9AybtpECVjzo7xxFPCkeiEMsr
         fP9FmojosdvKuSRsa82VHL1pwYBf6wDJrU1KiHUHVqvBL4jbxFI5ECRhMyyuIxGU7y+/
         6Q6yQBzFoK7p9M9S+xEzjw/RmvqoO6/i0oLNE7K2+G5XHQmjGfm+0b3c5q4w8aXzUolT
         j3xA==
X-Forwarded-Encrypted: i=1; AHgh+RpFFza83sjVHSnqp69/C+qoqTk19OZYD4zYCDLTIOpSAmZfRmBksP3Sukv31sTdSUVOmGeZp98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRsqGCbGngyUYDVAo907TAU4STKiuie/P5ESb5PKpH1mGnQ9lE
	DLLuEqVCoHtAWZ/cdoptOzy0KmJUdVFUg/evTrrxYsNTKy344kjF2ZsOm17tYG1E
X-Gm-Gg: AR+sD10IP4r7819wBmCsHKBHrTHeo9JkzU/4m4Y0doS+wu4NbHNfdgO5ywpqXt2Rfoa
	h6e0aDEzyQMejpVwgDC8Dh09l7Xp0gCNI0kllvx/zJlfQ7/Coec3Zh66vQi5BBk+OYEkAqG1WgP
	jnVr0h6RlZLMC+232kzFDetJQCz4axwGPblIuK0HJH37d8fBC1/6kWuiFzHrkCcgWjMgMc6hutS
	feJLDYlbqWWkuiWKejgyWBBxXxcHxr2tLvT+D6o7UE0GBYwoTli7zIKI6ElWNx772j2H2CDop0y
	35Wott0ajb05wn5qbjNcx2rU+o044lrLtFOP4KI5RcXQf4qX/bTV4itD/G1wTL8/eVeVjcJBQGg
	pWcGvBhFccULlkaCAOCYOFcNS4xod+mD+gtYdGDhqmfqeMVtMSGoAMTa/+z49iABCP2V0y/ZTPH
	v/8WHSQlgIxIJ++7MliOxGGFGwdRTZBE9UnpylVyO+GWX+5kma8AcrOf+/yg0NrD4=
X-Received: by 2002:a17:90b:2c8d:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-3933e62f4f8mr7303910a91.17.1786718817623;
        Fri, 14 Aug 2026 07:46:57 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889bca5sm14642249c88.12.2026.08.14.07.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:46:57 -0700 (PDT)
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
Subject:
 [PATCH v5 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 22:45:58 +0800
Message-Id: <20260814144558.134314-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814144558.134314-1-physicalmtea@gmail.com>
References: <20260814144558.134314-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_net_set_features() leaves the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. Later descriptor translation
can therefore continue to use translations from the old IOTLB after the
userspace memory table has changed.

Use the common vhost helper when ACCESS_PLATFORM is absent. The helper
handles the no-IOTLB case internally, while the common initializer also
keeps an existing IOTLB when a feature update retains ACCESS_PLATFORM, so
logging updates do not discard valid translations.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Link: https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6536cad9c4f..8d6f530f49b3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1687,7 +1687,8 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
-	}
+	} else
+		vhost_clear_device_iotlb(&n->dev);
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
 		mutex_lock(&n->vqs[i].vq.mutex);
