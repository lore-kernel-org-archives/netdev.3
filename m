Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F637CD39
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 10:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786185270; cv=none; b=a3iHaesXhFtwrCFf2lNZrircT5uLogNjfTqzaLAaIBi7TVOTAhLdl6yXpmXLIuoxAr7FJEfVQLVJ5c5NIV0n7HsPqHqImBdqMd3YgWGqP1+XwE0NL4GO+VUx0zZW0sHg/EGyqHSD0uWQ/vxYbCjHUp/AvXMruQJ8HuFswqdm++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786185270; c=relaxed/simple;
	bh=8cLsyOrjXGvoCCKeyA9EG98ua8ktDWJeJNjwpR7WQKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQUVe/GihfP0Dn8nxiRYAjhW4dohf1l2Jqiwp4MtLl25pWDoL3SCI/l8Di4jwwoN8JdIuuLAdxsiZZoAT7sMmW+CSgjIHKPpyOiqUHgQILK3OlRaVe6yeVm7HwlIgwQnvuhPYiN7e80yM1p4ch3nqwIVgtgQqKUEMLyOAScTY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOxI4qUd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOxI4qUd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ced3386430so4896995ad.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786185268; x=1786790068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMt2HBv95FWkEezOYc96XrHhu7tFutq5B2cwfp/ralY=;
        b=VOxI4qUd8ZYG6z0foxa6r2QAkVviy27w2Gsn1NMKAIyTci4cdvDpRDD1nXK2e7GLBK
         YZzoZLqV64xDJxUkxFl5zGLCClrzCgIanrSHfxNprxmFBFgZw0QOb+1DZhnWTY5UIgbc
         Gn4l/a9sSsR6P9nXPERZCB6ac8/F6vo8ZgOs8C4CtJzm4fR6H0jWP7Zl2hA57Q2tzd5n
         NZBN4Om21wGN6AYUkEpc/SZbwi+CKULMd5ZIBFRgv3tDzeL0A89h57FkPtgv1vg0VIlN
         7WzpXPgncAyf4CgnsDiYnkO7MteEXbV9MPTlx61TArBBo3JX8W5bfhHhVERrylPCAOgq
         kWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786185268; x=1786790068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMt2HBv95FWkEezOYc96XrHhu7tFutq5B2cwfp/ralY=;
        b=IFLgV5jL+JFOGhq9Kyx0amoeiEWiXfM10H7Dy3S0hT36BXJpyfE8djKoLAI9VA36sL
         7bi4u+T9c8MClTrFCLYmwYlRZpqqgcLYbz2ODbiqDH7hwE+WUUnq8/JQqH/pwoAzwxam
         xWwrXyAIXhKlr3sCwfcXF7UD8KKoj4n6O8LGu/UFA04LpJgoci2OQTgR+CkToLvzAtT7
         RxwOY3nY25nvlq6Enq/AUt5cHHfgT0wXytH+ZXJnW2BMXosy9qUmZI7P0jYpS+JK7Qa6
         RlTd/jsajjEAwlgB7fK0ktr2kd4tqV2q8I5ATCzBty4Wq2UqyuYHEWujEpz8DONEWfj9
         bXMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqfkorv4NmvoryrlYvkJJC4Aic09Q5ZXMcJ6znAvE6+lj7mlkNzOiFEF0QnuMGeRC1RBdE/MvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqUfhGH7RsHfiq6PIw6VDDIHtNAblsRK6ZpwVllpSY0IspWhh
	v23Yihuib0cdRIJEA+CEQbv71G9lKOdBXm/pyZDczH3zsQfH2+gyDx5tZO+idqMM
X-Gm-Gg: AR+sD13h7XM+5bMrTFwW5e+5vxspWZDa6eN/awZEsG0go1mcosCx/p/dsnbVJEYx/DI
	qtPe90McHg/HaRkCE/Z5qyLi5GzrodVW/7xG0jDIBXYGIJINF0aZtMzd0A/9d6AL5rHap2xnXWG
	YuR7mJYxV8DqVvs840vwVV6j+p7F9+wCygfIECVI6hXBIahbFHXFM3mkdmSCajcP0Sp2I85uW9p
	20mgKfPFvGcnmgLCawmCkbRJhZG6GY2PGfUoshlQ1p67oWcEVwsjYnmFunXSyhL7nKuIvVfeAOc
	AixaIQATent5aBNzmMc7nUktSFOs/KNWtdoFH3JDqIpqPiwSG4ConBK2612lpaykd+LaqCJZ4bd
	pQ+9T9+lH8Zhsu/aesdNt7xCX0l7FXS2u9VqixW9waBeSxJkVERnciwn6HaK/NmZZ1qqIwma18M
	q+ZdS19FtrklDYXdoLPLtev8r6G8e+B4+qqpflXQ6gKuilBLHPUOaGfaibeySjHFA3REWhxvo=
X-Received: by 2002:a05:6a20:3d0b:b0:3bf:b1d3:393e with SMTP id adf61e73a8af0-3cbc01011aemr11771109637.2.1786185267762;
        Sat, 08 Aug 2026 03:34:27 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86d3fcsm18060034eec.4.2026.08.08.03.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 03:34:27 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Tiwei Bie <tiwei.bie@intel.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost/vdpa: reject VRING_NUM larger than device max
Date: Sat,  8 Aug 2026 18:34:15 +0800
Message-Id: <20260808103415.101261-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vring_set_num() only requires a non-zero power-of-two that fits
in 16 bits. vhost-vdpa then hands that value to the backend through
set_vq_num() without comparing it to get_vq_num_max().

A local process with access to /dev/vhost-vdpa-* can therefore set a
queue size larger than the device advertises. On the vdpa_sim backend,
the worker then walks descriptors beyond the mapped descriptor ring.
KASAN reports a 16-byte out-of-bounds read, corresponding to one
vring_desc, in the vringh IOTLB path:

  BUG: KASAN: out-of-bounds in _copy_from_iter
  Read of size 16
  copy_from_iotlb
  copydesc_iotlb
  vringh_getdesc_iotlb
  vdpasim_net_work

Check the requested size against get_vq_num_max() in
vhost_vdpa_vring_ioctl() before calling vhost_vring_ioctl(), and return
-EINVAL when the request is too large.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
---
 drivers/vhost/vdpa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275fa0d0..b2083e1ef150 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -716,6 +716,13 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				vhost_vdpa_unsetup_vq_irq(v, idx);
 		}
 		break;
+	case VHOST_SET_VRING_NUM:
+		/* Reject sizes above the max reported by the device. */
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		if (s.num > ops->get_vq_num_max(vdpa))
+			return -EINVAL;
+		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-- 
2.34.1
