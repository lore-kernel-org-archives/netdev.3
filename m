Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E1192B75
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323808; cv=none; b=XXDKFElkG28Z/FBVMSkfhDaGk2GlGPXUCSyK0eHNInvzMYXTKJ18rSvQYBoM5t8uNKg5TPIRkk1xin9arK/KQ++q+ZtL4ohoy5QqzRYvv/Z211qJ+RHMO6xRtcMLAatf7fI/M1Rlob5U+6sII4TXaLz0I/lbgFXrCvjIJvc9d68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323808; c=relaxed/simple;
	bh=/UNLEhTBAnch36SgaK4rfVGlQTG/rEakKekLFDXlBQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=upk4C7vAAWZw0VWJDLwbUzFwO4PoActwh5nyOJsbppo5aIMZrDoqC8NwoTtlROOUiVWK+QSJ9OWxHFfDJzlj9Cny9bxGUmwqAg8X/jG/O4WMYr6USkUu6nosDJSNZVrMm7Zq8fKTmEFhIwXSgr4tvs7O6wshIZMwKyT/Nq6doOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGwPP3m+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGwPP3m+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e347638adso1398183a91.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 18:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786323807; x=1786928607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbbU/F/djf22NMRk+tFA6K7hMv5blZDiEPyCufD11oE=;
        b=kGwPP3m+84MyCsrHaaTZx34HjnPtRt5oHJl2VtkddFBH/Q4o5kj7S3V7u3ytKySR86
         zREW5/Lt7AoMcqgNRktRp83vbQ2z7/Bv9qOjzgVPaFerPzm93v7zyQnpT9Dmte740Aiu
         7x7y4wJHn/T64staKBqy9Mssud5PqLcWQa2FEisIPNJh6+ft8/UpnONDdTtOqoIfwN6z
         vQNgzjKpVdOZDLVtnmcyi3uHKVp7jCer8bPFQH98gZXscyUG1kcLmLYmX17E4HhPulyF
         qc8ntXQlposFtb+/4LzSifw8hOVJ1IUa4lkiUOFVOcm8OB5ZRj7FasDjckeVmnui2md6
         wuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786323807; x=1786928607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbbU/F/djf22NMRk+tFA6K7hMv5blZDiEPyCufD11oE=;
        b=FDLbGWz9/0ERDXEIHLm4oAn88w5GfujWF2k+HxsGJyAbUbRpyZLtOk/sTHal0+4B0U
         HzTzEV2OH82rCji+dOxppznOKezPwWc2XS7XJxJi837E47zbc6rTMkdJIL9i1bPdHxqD
         JqzvugwdurnPc+4/vTLdT/yBYN6DJPNTDT4eYK3VpGdVNXVshm2Ctybf32cgYVErpWZV
         XRVMs3uDc9U3lKwlVRtU+ngjxXUtLakx9E+CFxOprIZPIkdTqOg2svaCVyTDS4NUQwbF
         9AvpaJLv70ngkvaUjRqD+hCeLFK8wqv66i/m7JjvTeOP9FMuYyAeCFYsOtDe8jwAqSow
         Vi3Q==
X-Forwarded-Encrypted: i=1; AHgh+RoakooL0csa0n/Ovu723zMtRqQvgohl2sxKOg8XlDM/fmD+VaSBnXjGcgO0UeM33KJccUGRPgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMLuC6NU+x3xMC+f7e82uPlc1+gVj4QfPcRfv0xR2jqmy9LXp
	uZKymJNSg4fd7pB41ZVe3ICGpVaoe6K/FHP5fSwGl45wJ/MUtKK1/79m
X-Gm-Gg: AR+sD102yKOzGSPIQvcdDjB9kgXEYN72GAyKuiu6EcXGahYlIeUT0/MVsrCdPhhG6Kv
	BsCjvA1wXkNrts+3I+43VrOHXveZGZvLUDKUdfkF5+l7PdrUxc0f/lFSHg7SO7vMNbFFTCvF+Yj
	SlnvLngDQYpVJcdX2BzakUF5U60HcoCxqxxRdZ3nQ3yKw9IC48UHE8wV8pLiCO77OD44XEtWOMw
	cNzYX6uSwAVBzZoij/PsQ4nyTUgkd32glKB7zW9k6qp1cfvovVd+hX2Ja7uHwUhOVqZKerY4gIL
	HZE+k7nVDq0PRHYauBb4Ee0CTY0B6MALTxi9r5fj1LmXvAqxxc/bKfEVeBRuod+5e1ZiYH0tn9L
	zcULVSSwcuUPqeAyUdD3nDR4wRZBtkPQQlUJ01J+OeMNi1p7WQxwv6Kbz4kITyt/U4NDiOg3v8x
	vjTLHGd9ckpKXNl1en9MJZMXieR+qtyVuQuZKCaWi6mtXGI6uwHu9KerJJ1Sk=
X-Received: by 2002:a17:90b:4a0f:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-392823340e5mr16894066a91.5.1786323806331;
        Sun, 09 Aug 2026 18:03:26 -0700 (PDT)
Received: from gmail.com ([123.118.75.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff64b1dsm10138275a91.13.2026.08.09.18.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 18:03:25 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] vhost/vdpa: reject VRING_NUM larger than device max
Date: Mon, 10 Aug 2026 09:03:00 +0800
Message-Id: <20260810010300.132959-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vring_set_num() accepts any non-zero power-of-two queue size that
fits in 16 bits. vhost-vdpa then passes that value to set_vq_num()
without comparing it with get_vq_num_max().

A process with access to /dev/vhost-vdpa-* can therefore configure a
queue larger than the device advertises. With vdpa_sim, the worker can
walk descriptors beyond the mapped descriptor ring. KASAN reports a
16-byte out-of-bounds read, corresponding to one vring_desc, in the
vringh IOTLB path:

  BUG: KASAN: out-of-bounds in _copy_from_iter
  Read of size 16
  copy_from_iotlb
  copydesc_iotlb
  vringh_getdesc_iotlb
  vdpasim_net_work

Cache get_vq_num_max() immediately after reset. Some backends derive
it from writable queue-size state, so querying it after SET_NUM may
return the current size instead of the device capability. Invalidate
the cached value before reset so a failed reset leaves SET_NUM
disabled.

For VHOST_SET_VRING_NUM, copy the complete vring state once and use
the same index and size for validation, vq->num, and set_vq_num().
This ensures that validation and use operate on the same copied values.

Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
v3:
- Copy VHOST_SET_VRING_NUM once and use the copied values throughout,
  avoiding the double-fetch race in v2.
- Cache the device-wide maximum after reset so mutable queue state
  cannot break a later legal resize; fail closed if reset fails.

v2:
- Add the missing Signed-off-by tag.

 drivers/vhost/vdpa.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 692564b1bcbb..f2eedb0464c2 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -53,6 +53,7 @@ struct vhost_vdpa {
 	struct cdev cdev;
 	atomic_t opened;
 	u32 nvqs;
+	u16 vq_num_max;
 	int virtio_id;
 	int minor;
 	struct eventfd_ctx *config_ctx;
@@ -229,7 +230,9 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
 static int _compat_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
 	u32 flags = 0;
+	int ret;
 
 	v->suspended = false;
 
@@ -239,7 +242,14 @@ static int _compat_vdpa_reset(struct vhost_vdpa *v)
 			 VDPA_RESET_F_CLEAN_MAP : 0;
 	}
 
-	return vdpa_reset(vdpa, flags);
+	v->vq_num_max = 0;
+	ret = vdpa_reset(vdpa, flags);
+	if (!ret) {
+		/* Some backends derive the max from mutable queue state. */
+		v->vq_num_max = ops->get_vq_num_max(vdpa);
+	}
+
+	return ret;
 }
 
 static int vhost_vdpa_reset(struct vhost_vdpa *v)
@@ -641,9 +651,15 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	u32 idx;
 	long r;
 
-	r = get_user(idx, (u32 __user *)argp);
-	if (r < 0)
-		return r;
+	if (cmd == VHOST_SET_VRING_NUM) {
+		if (copy_from_user(&s, argp, sizeof(s)))
+			return -EFAULT;
+		idx = s.index;
+	} else {
+		r = get_user(idx, (u32 __user *)argp);
+		if (r < 0)
+			return r;
+	}
 
 	if (idx >= v->nvqs)
 		return -ENOBUFS;
@@ -652,6 +668,23 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	vq = &v->vqs[idx];
 
 	switch (cmd) {
+	case VHOST_SET_VRING_NUM:
+		mutex_lock(&vq->mutex);
+		if (vq->private_data) {
+			r = -EBUSY;
+		} else if (!s.num || s.num > 0xffff ||
+			   s.num > v->vq_num_max ||
+			   (s.num & (s.num - 1))) {
+			r = -EINVAL;
+		} else {
+			vq->num = s.num;
+			r = 0;
+		}
+		mutex_unlock(&vq->mutex);
+		if (r)
+			return r;
+		ops->set_vq_num(vdpa, idx, s.num);
+		return 0;
 	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
@@ -765,9 +798,6 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		ops->set_vq_cb(vdpa, idx, &cb);
 		break;
 
-	case VHOST_SET_VRING_NUM:
-		ops->set_vq_num(vdpa, idx, vq->num);
-		break;
 	}
 
 	return r;
-- 
2.34.1
