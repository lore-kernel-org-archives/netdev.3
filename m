Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C8416870
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692568; cv=none; b=eHY5Oaf437fXt43GVKvMUW5VneL80DLZjEm+Za9tkhE39amdzXqPlJy0SJhaRXMR6jZ5XUgUKol9qqkWEoy/6t5cuSnoiaJSw6j+wEWAbsVXnS+UgR/5ItAU0lXszvreqlK2H7/MvVUXhX/c3lGlPkpV9drSOk4R9sgFoJd6ymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692568; c=relaxed/simple;
	bh=y6rMr9v8RkMQDzFniTx5ksD4K7N0krZyH7ayvc6VZdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/MLU9591lzHofrWFJzMiXHDte42FWugQ2ByBEgkaulmWoFjPFxWg7Bv8wWfDyHIDDUgMeyOZBcRUNx4eNldtB5knJ3MwlMs+QkKEYQQleRR78ZlE1pgX/JnGdROySh/JEWsHt3sI6IV6xkj8q8mhEgaXrOI+UXJt3H6HJrV4iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9d1/ETA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9d1/ETA"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so510335b3a.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692562; x=1787297362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=whRMOBoocsT3J+VYRBCXYaXX4rPKx8GaSyd74snbzsw=;
        b=Q9d1/ETAnHSXU+zBviKGHhUrrKLa6gHe9Qv/QkqfAnmi63ZwDEX5Jd+jQQOhmSO5Fb
         mHMpUT4ujklD/Th/BKMRitASQLOJ22BI7qQjauwIIKRNTWq9fdcxmrj8XhFmooswD/fl
         5DA9rPGG7RwsPjkwjyK/zBErjBsbNB+D2UPcQ4O+1t59Q05HJPojCR1TS/ip6mx9htim
         +AERp20+eGVX7x+QAhNMi+5f/o+/qKDhwm2FltscdotztRcbd8cNwFGzEWZKA3eImp84
         Q78nztKcZe/xrOCO8xKTyBAfa4bSLeQHl1GZ0lGh0WEwuin0tIJKLCFAe7I19e5vmmWx
         eBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692562; x=1787297362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=whRMOBoocsT3J+VYRBCXYaXX4rPKx8GaSyd74snbzsw=;
        b=kvNBYYGGkpREhHKf2m2MHc7WSHmveX1BvFv8qpNu+QO9kVN46kn82H+hYfnM0Q9A8k
         mXTJbo3OS+qReWsVbOS5j/gpcitdFNUAIlSLWFFlLGrBNbrGwkxhezRbeAa5+29RwJoH
         D7dGkaPv05R64m2RuM0xVp8sMMw3dKyiS7gLHcspSJt1vCv96NdUlkcrXuBayzase6dS
         3B3niU5zm8jrWJo61eQ3N+2HXoba6dDNd014v6OvgLBfMLsFlS1as4FJKBy86a+G9agv
         7h+VVNJzw6+DMAMG9xBWX0l5/nFvBW/5Bo/ueK+AEiCOm3b3hhnZ0ojWHLnc9wgfqKrZ
         Pg0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrz6xUB6ABjfQbvS1oJ0dwzYG4z4lvjnh9w+LPRRi4Vl2wELeXcAbstx66GF3Pp8ElZAyllqR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aKj1joo232pnFIYxR+Cl8zFVnxd03wAPgU4MdZK0/DW2H5Va
	WCQinB/Be0m8ULiRwXIEj7Qmy7Ex6DNqVDtI5xhwcQfGNnHbSwKT9sVC
X-Gm-Gg: AR+sD11OV77gqfBzODvqyOFQSB4SL6nEBFz9Cn1u+pDrWw+tv2Hte76mPzCrsT8Jox5
	C0JPWMNpt9sUbKoutT64gs5iOOwMnLiSLlnYOSjMQsiSHr9NrL9Bo6KdClGyoSP0Fj2BXNPM5Ie
	tyzEbVQ7BDCaRcMWFYECx++d23qKAeyH0dg+3sw032Gix1V+b7M4SARVwKNf8pAb1GiRE0tpdZF
	tBLR4Hs56tGimsiR/B+vDky5jtvM1GbIIN5bLt7+eLQGTj7jqw68tqq16Z9I0W5JucLfFTWlF8e
	m0/5AKkyf42RdV/QtMNQtAFkK8KQfrTr4S4Kycdn24FynudsbFM706dAj5qzi8oCyamjLZh3SMU
	LhEVoxSy7zde2TooeGuJB+Jhkvq0nNL8kXD5gLq6F8wnwqEiDnYKZwme6Fev0Mdc/AoeZPyffIj
	hFf8L7/WA/nj7yMoTdItX2WGU8zybQho2pYcfV/xR1kvWvsuoj90182oYqxVdFRYg=
X-Received: by 2002:a05:6a00:1793:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84fde314673mr3794400b3a.35.1786692562070;
        Fri, 14 Aug 2026 00:29:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d249b39sm93258b3a.47.2026.08.14.00.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:21 -0700 (PDT)
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
Subject:
 [PATCH v4 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Fri, 14 Aug 2026 15:29:02 +0800
Message-Id: <20260814072903.124991-3-physicalmtea@gmail.com>
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

vhost_vsock_set_features() leaves the device IOTLB attached when
userspace clears VIRTIO_F_ACCESS_PLATFORM. Descriptors can therefore
continue to use translations installed before the feature change,
including HVAs made stale by a later memory table update.

Use the common vhost helper to detach the device IOTLB before
acknowledging a feature mask without ACCESS_PLATFORM. The helper clears
each virtqueue's IOTLB pointer and metadata cache under its mutex, then
frees the old IOTLB after all virtqueues have dropped their references.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..b69c260eaeff 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -863,7 +863,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
 	    !vhost_log_access_ok(&vsock->dev)) {
 		goto err;
 	}
 
+	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
+	    vsock->dev.iotlb)
+		vhost_clear_device_iotlb(&vsock->dev);
+
 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
-- 
2.34.1
