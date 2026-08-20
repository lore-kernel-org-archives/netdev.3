Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B8E3CF039
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213150; cv=none; b=lcOKmRKmdayGYYLpjPItftgbT29YJyiPbzXCd8V2UHzHlYFaBD/w9VDsUtFvAs1NYY0sfhlgcFb9FOa5Jt2cuFKYXCDDedxxg08oAfcPxWnhOPwd/OJqEXh842ggncGf3o3Obo+shUYBy/NroEr6aQMCoC0AjFbzNLh65OMT8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213150; c=relaxed/simple;
	bh=qgynlLSlE9GedrgWrdeKiRWEM+qpmwf3VbwiSO5eBQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7qGEpYHd2be6ARMXX6WhvSFX+D59ld2h2Sg7WOtKApxgLriyZIX+oYZz9Qa+9EKTsgak3PGEKdK6CyJZ5K3irssxgrkgs4Oo0B2xepkBtrI6MmcT93G3JYsNlJqkP5lcqJu8GdtST8gvtd0NCj3EAkJkvkLaKeHVLHsortyirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMHm7pSb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMHm7pSb"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so1515646b3a.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 01:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213149; x=1787817949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNr0zjEJARTG031KsfcMOG4mbwEr/hGSSzyVmooR7Lg=;
        b=ZMHm7pSb8aVMctA7jgqzIMXhu0MwOYjbBVPhNeDQ6I45ZUTUNU2DErSoiL2krcIvVs
         8o4yq4YA6BRnXvIf6OoYEO6RMbDJOz8YVzalMP+VkbuYBwXoGwDUymkeq9YpZ3WtMBHC
         ozIHTbH/iu1aBYdM137yPrakpdTDHBjlKme4mYQGYN7Wrf3VmGm9XIdp+1UIg2di4Hyn
         mBP1Kqw5VyKwOLmWlUvS5jB2bykQt/w9ahAqnJLX/fwpxdK9nsR4qqRFIAVyE+HOsxCy
         i3TMvScpOMfyGc0CVcVZEyuJ0WVKmMOssxMuLREgFvlLSkBxKUswcdsvLkHuCA+Y4LGP
         cwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213149; x=1787817949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GNr0zjEJARTG031KsfcMOG4mbwEr/hGSSzyVmooR7Lg=;
        b=EqqgcpSwcd9xB3Y5luCR28c0HfpxyZ4+yHZmOuBZj67I7BqWvcajPb4ysL2cpuD3xi
         07ZM4Dhmp1QxnaQYk56Hr5Yk0angG/pX5pCzV3iEzUkhDOKYEi7e9eoi3T4CpsaJPpOG
         Z9uW8yMpABfE5YJRXaDR7vgNhSCNihItGzXzLEZGLr3GHi8Yre98rdbuz8HgF+TqppHy
         gaeIFlopkxNfqduYpK1V2XdeoNK13XAPmWGDuWA7NBVozmTvBQNtFqXappD8AOtwUWA0
         owXb/AKuPocms+YQjj8UoAEzak6XyZvYXeJ5rYoOD7sisxUaHyGbP1vEsQTmqcMQ1YoS
         2vsw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1I27NyBV0NNqmVZ/LbCB1kRapimLAvTUc2EPMfYWPWP5yTF3E3FSQjWyC5DJRcKFtp2mrOAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxENqthQSu97wteH3WwgqtCIibcZQVArg6XdjcjntuTZARltF2
	7/08llYAnczIjMWoDXsMe7sbbhGZ/HDuG2Wu8eSgWa3B4kpjWLrio643
X-Gm-Gg: AR+sD13fgNgZM8HjqD658EzJw0xOjx74Z7lwqzxG+Tgyg5GEuymyxW6Q75o9PLHv+hW
	u/0Rtg/AdiSzzApqTyd2+Pl8ybfSXfs9t/dDJ+VVT1CCxJVqp//5S/sF9B/LVkzQ47Ll3SMCOXL
	Vs/4f4YQhIvlvw0axok1/nUk2/8GdZ2iuaNVwBDu6wJCMqahdgUlVCJUJPX754NO6hlwlIikClE
	d4WhtJYE6MwmU4CF3vA/2vR586ciZuCNx7lvs/HJpm/5gTvdtJxLIdB3e41pIsWs2NOFx+pCs2V
	5uZV/Zhl4Ez4WAeUYWkVM68ymAsMBpeO0tQENfsKgIHD6CuOtBeQRMLVMzY8u8h5IV0l2tJipEd
	H7i/Njy0v3jkrcoreU5EzdXbjJZU/wlPDwAiNq6J/b9TOyvI6fDzRuB2ETM1g3otF3IjOI2A5cU
	Q4loAcA+wdMYzxZwEy3vjXMIKcMfAfPGFFEn47btnYhd7dnI1D2g2SXcwakAYpR+r9
X-Received: by 2002:a05:6a00:2301:b0:847:7ffd:ce35 with SMTP id d2e1a72fcca58-851d382e720mr17907618b3a.8.1787213148258;
        Thu, 20 Aug 2026 01:05:48 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d366d65dsm1412020b3a.50.2026.08.20.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:05:47 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: stefanha@redhat.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject:
 [PATCH v7 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Thu, 20 Aug 2026 16:03:32 +0800
Message-Id: <20260820080332.313933-4-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820080332.313933-1-physicalmtea@gmail.com>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apply the common device IOTLB teardown when userspace clears
VIRTIO_F_ACCESS_PLATFORM. This drops stale translations and avoids
rebuilding an existing IOTLB during feature updates that keep
ACCESS_PLATFORM enabled.

The transition invalidates cached vring access even with an attached
backend. The backend remains attached, but userspace must configure the
vring addresses for the new address mode after a successful live
transition.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Link: https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 38d9c184082d..4d9d7c2216ed 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1696,6 +1696,8 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
+	} else {
+		vhost_clear_device_iotlb(&n->dev);
 	}
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
-- 
2.34.1

