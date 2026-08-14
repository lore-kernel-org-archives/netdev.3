Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE1411FAE
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692561; cv=none; b=ZRBbhawGmtkNHnZ38f8HJkTLLLfWLSFOZVFzJh4OH5M7VTyWSWvdm0X+OMFpY0O4uvxD1/B1CJu6y9BZ/jv2VJSFhRn/qUZqoQPICiMWLdxcKUE9G1wwhKuRMe1f4mf6adddDWx/mthLTgLZ9NEBSqArowrhTDVz5JGzym8rdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692561; c=relaxed/simple;
	bh=A2c/1UfoUVZwjPKT93Tz38x84LdjXaLsxnnPNTXjSOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5FTLMbRRYMhbJiZNhN8fRYgfJ6F3lzvcpMqDKCdhhvXCgCOwx5CiEYBSa/8rNmKaVqWoVuH89Vgml7B+EfkE94cLoiYw9xycOrIPSRdoYlHvINcAZoeQh3p73NgatCtGbBCCNLX50qgj3lP7O8FVTee4tzNP13sFh7djCw38Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYJ/tA7Q; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYJ/tA7Q"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so1644691a91.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692557; x=1787297357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbblxrsuoqHEDjKyrMAHXwYMuYA31QBlUn7tIsEpyi8=;
        b=NYJ/tA7QHL31bSmY/qmTDkoTVJCbGI3lO+41PaSNKW6qXACb1r18aP4mzMB9XHXiRp
         cIbqS8DcN/veVtWLgO4e++WZY73fRXf/cpM4WsgvLXNp431ByCZ2rNDXERN0X/JN/dF5
         /0pJSO028bVUDG6KvOoEqjENIdQ+ngBdc2UyFuedH4+bqKYEzfG+gWF+QCNwJRMRHRe/
         Ge1smsw3lt6gVxUk5PGdKjvkeGa/9tueH6o9K+MMcomWbGw7ZDWg3FKM62I8K5GdeJ0t
         Meq/YlJFWt5jTYkvSP2Z4k6/GtKA+59dAzhJxyPrcYLP+ECkgaZvIx+Gt6/2IPW76U78
         yU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692557; x=1787297357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CbblxrsuoqHEDjKyrMAHXwYMuYA31QBlUn7tIsEpyi8=;
        b=DNBlGR8Wv9gsTrxG3Q7RHZFc+eG3YHXd7gK6Ut2UHvUQTO/hWovB2GHXirBq2p4tCo
         9UymCKD7G7cI9hM4XcSAdqrpeZMsvW1DNzfEL1Q68RFEZM+o60dR4sFzmSJglZi/mjPR
         ovHTICmKX45r8451hzcNOkuHdo7tKcjVx0cMljnoE6NdlqSjf95PXE2fwUlSrQKREPoh
         gJkn6rYL+NpH8u9f6/bAdds/N9UpaTI5mOXlhdCSyyuBjh4qtoYJRtp5eK/vlXEwJDAh
         FoeQh/mKg2FN4gHelMiXfv+PAgZCJl2epeZmwNBrZQHRzfVFNFUKxw2WcYa31aze9++c
         Ky2g==
X-Forwarded-Encrypted: i=1; AHgh+Rp3tnUDRdFkkGh8h9bo3RlqrZ8kLRnYELaciNAjOEXzCfYIQaSutdhM1yoyWLfU+2KTofIyH1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDs1DVLiBM63epfUTfcYoOMjCSly376vMLemSoXLKRRCJN1me
	F0CiHohwCVMaGjMyeDuI13G4cDFLV0qyFaucscScdQtSWcoCnf+L18SK
X-Gm-Gg: AR+sD11D4ekYK5uaS2X/DkT2n9IO+vifDh7kLb3YEsjijLF4uRboHt4W9xxqKEragfK
	VL/KrO2pw0b15Zdl9gsLrHDe61jz1jWtova7/5aR3NOcLzWdg+VMAR+ajr+LI5Mvtw+tuXUZmWG
	ISsm4Zi0VdDrVo1RBc2ioudQcD+06OO+JVqlMLEjAZ8oZYIMh8Y8hurwAbjzOKmx/TNdSeTYhOm
	rcZ45pwtDI6Pu5i4GqMoa+6y5o0fS2goeSMzuSieAU3PHAbDUzQoxGlvaiM4ljiCOWCjuMhnObx
	I6+hjSehrcZhKxB/2evIOIjRzZ1WyqTH9HDYRNfl3OG4REs/PwZBMNNdbRqgmwodabzNNSdC98o
	7E8wsWnPIEccSdjfLYzOqIwSy8VRD/LYdRPGbit2jYUKzqhaMITpk0lEuXXxoA3EI8m5qWukv2a
	ZYr0jLs1geFsH1aSTAdi1tQIdep6zEbA1to6mEiZHYhzbFzgRpeWoujKvvLBSmHveKFP4m7LWvG
	A==
X-Received: by 2002:a17:90b:33c1:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-3933b0d5d31mr2565281a91.17.1786692556330;
        Fri, 14 Aug 2026 00:29:16 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394e920ba18sm1460185a91.0.2026.08.14.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:16 -0700 (PDT)
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
Subject: [PATCH v4 1/3] vhost: add helper to clear device IOTLB
Date: Fri, 14 Aug 2026 15:29:01 +0800
Message-Id: <20260814072903.124991-2-physicalmtea@gmail.com>
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

The device IOTLB is shared by vhost backends, but clearing it requires
dropping each virtqueue's IOTLB pointer and metadata cache before the
old table is freed. Add a common helper for this teardown sequence so
backend-specific feature code only needs to decide when the table must
be cleared.

The caller must hold the device mutex. The helper does not update
acked_features; backends continue to update that state in their own
virtqueue loops.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 269efad90369..7eaa61d9ceeb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2283,6 +2283,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+/* Caller must hold the device mutex. */
+void vhost_clear_device_iotlb(struct vhost_dev *d)
+{
+	struct vhost_iotlb *iotlb;
+	int i;
+
+	iotlb = d->iotlb;
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = NULL;
+		__vhost_vq_meta_reset(vq);
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
-- 
2.34.1
