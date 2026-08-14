Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC6A47CC9E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718793; cv=none; b=gXAwVZQnGhLXi8Oiu6wjhsStIfqPP1NqAfUhlxh05YVJyP5q4WOjsw2oxMg0afLtybgZHPsDzTEMTCZ6jTQcsxjQaFYAVCRxi1GsYOwXYasW2hx3rmz+Zx3HYi4CDKp13JC5d5CS196AA1dYsbrwzNfy6ry5GF1IZ87of+SFBoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718793; c=relaxed/simple;
	bh=Xa0VSs5Wgy2s+5Y5cGxNKlGb+hYYsFQLTHT2zK+trE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwvjiBGwqqa1A7VZBRQjnYVEJBBJ4wmPb9kqwgPlfTATuownK+yl9ypnBHJ36w3lgTeefQ+Wv4XigF1a+WoznRhyfoM7iXmoCWOZz++EXcf+1/+Y0DDbMeSWHC+yF9SSmMWVsY8Npg3yCXBMLuIYNhUKP0WFZuzg16X4Qmz9TMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCT4IIvj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCT4IIvj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d53197d8b5so3056935ad.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718792; x=1787323592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YY8hyvFF7qJQztCQvpK0cOJf2H3tyq11sUcoS+GLPLI=;
        b=RCT4IIvjxKxRVinQZg8+kzUjoKTXew9akP25hUKcFmz0VDj+ehHv5Pk0eC3BJn7UQ0
         C89osGKBCelOZ+oqqpCf5PTTQxm1xnek/vczrvAX/x344z3F62pCqcS2TTuqwiXzqPfM
         k67NxC0TjE9+3naVqFaJQ/scr2HIYhLnhqV8Ei7CPFjmqYF54Tamy9LFtjiG1FDLxgkd
         wQT6Ns7bwUybdvcxvrANS3Qd5LrFZA5KoWwK9meVmp+aLEMMn0UJ1pcLCMDaiRERf85Y
         CiyGFQbFjI1UrlnstfLsbUYQYsrGvIe/DGRcRiUVx5ryBhMduDF6UbYk4ll/wFwBgyIa
         ULlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718792; x=1787323592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YY8hyvFF7qJQztCQvpK0cOJf2H3tyq11sUcoS+GLPLI=;
        b=Uul3vJuZoEhqW0jwNlhH08FOlS0jXx6ykV0jvTlAxEoQrvQHygvSwjE6zql7qHk+0I
         goQFubg37LEygBUywxmKgUziASQ4585QEZC2FzHDMKdrtYZSQMzc80lMsSsL0Iu/8Zqa
         EJ3HZYuLOtUk91Mx6gjtbvT0wHi6HQzaICFztUxcL5n60qckdg+WUuZlJj+qlHbeKQxp
         e/jK0D0A647Gr6BzkHdobS7ouBdkCeoKJw72dmNSVeOB0bp9vRF8twnRqSG5qtfJ9T+x
         Bu3HgrWzhCsLMJbmhGBbAtq/L3KqnZgFVFIWQfLlLpJo0b1g9I7cM/pn0dzn+Mc9z9K1
         zgKQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBPQIuaKmU6Hq2ThX5E9NZ8JDD9h3AQ9NtozJ5IzOWRtjZHCf4HLbmSfb7V3JoGFuHc+0RMWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZbm25LPTPr+J2chwhuVpBv0RR/okwK+xeQN+TE3BQLmmo5FO
	0WgHUmS/nT2m3I2MphP/FeFUngP4Xi2hsXVTruLVQ6hwW2houSlyjH1G
X-Gm-Gg: AR+sD12/b5jzmsPfkht43KzaiAr17zzI7UPwOdLQFbcSlpgXCckkVCHoo87irQwclc5
	VuOaf5sYGW3CAp9evbtRzWf7UTdHfdcyoVNwraAu018xAY2J76bZvpgBDXZSOH52jrkUejNWPiQ
	0gUp9C5grLm6J3QFa47XZ1NdWpPlWwSmvyQLd/NlE85alr/iubu8UcGQo4TwY+8nMrJB23xLyYw
	hdjCzgdKpdc1BIYxDOHlojz7bQPJua8azpHwP05+dgwKOR0E67TSVLAV9xjOyi8+iyEDIrdDS1E
	yzt7bOvd8P328GD8GaEUdGU538KeKdPCeD4mYzviv9sCFo0YERs8oar0Cx01dPPSvjQ0K8ZnLla
	/WpmejERLcZPIUeIVUbX/GekiEqRvuvdhwpHeOsk0JQDGP1y03cPq6bwZdjSqH9sbL59vogg3uc
	PqYRhtGNu+GrzUyojNfCZWA0NhLODBSaUCxXGeA5qdysWOf3NFqmezz7Se8tQmdew=
X-Received: by 2002:a17:903:230d:b0:2cc:aa38:4df3 with SMTP id d9443c01a7336-2d3b0c47f94mr59329875ad.13.1786718791165;
        Fri, 14 Aug 2026 07:46:31 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df03e1sm5158782eec.16.2026.08.14.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:46:30 -0700 (PDT)
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
Subject: [PATCH v5 1/3] vhost: add helpers for device IOTLB lifecycle
Date: Fri, 14 Aug 2026 22:45:56 +0800
Message-Id: <20260814144558.134314-2-physicalmtea@gmail.com>
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

vhost_init_device_iotlb() currently replaces an existing device IOTLB
with a new empty table. A later VHOST_SET_FEATURES update, such as a
logging change while ACCESS_PLATFORM remains enabled, can therefore
discard valid translations.

Make device IOTLB initialization idempotent and add a common teardown
helper for the inverse transition. The helper detaches the table from
all virtqueues, resets their metadata caches, clears queued IOTLB miss
messages, and frees the old table after the virtqueue handoff. It is a
no-op when no device IOTLB is installed, so callers do not need to inspect
that internal state.

Callers must hold the device mutex. The helper does not update
acknowledged features; backend-specific code continues to do that.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 30 ++++++++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index cda5c350d9be..61676987ad58 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2451,6 +2451,32 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
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
 static bool vhost_retry_iotlb_misses(struct vhost_dev *d)
 {
 	bool wake = false;
@@ -2475,12 +2501,16 @@ static bool vhost_retry_iotlb_misses(struct vhost_dev *d)
 	return wake;
 }
 
+/* Caller must hold the device mutex. */
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
 	bool wake;
 	int i;
 
+	if (d->iotlb)
+		return 0;
+
 	niotlb = iotlb_alloc();
 	if (!niotlb)
 		return -ENOMEM;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 50fccc85d594..a3c598a79251 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -283,6 +283,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
+void vhost_clear_device_iotlb(struct vhost_dev *d);
 int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
