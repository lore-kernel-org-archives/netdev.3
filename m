Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0313BCD33
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213113; cv=none; b=GDbt/XfMA8UvP/ObuIniq30T6DxYXwJajbuqcl3LkmsL+VJcaUXqx2YhsSN1X8TUouFI00fapz6DYtnIDC8Ifh7Dwt0jwtP3JbEb6HiSm2UqM7TA5d2nkCGnNGDClLHA5bAasNjm9GEYtu1ie+Rmn4D4c+OKfgJu7PuqW3EPN5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213113; c=relaxed/simple;
	bh=dKGHt4r84CpOxIzBLIbsre1FSK83Rg5xkKpViCYYB1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dtht96oY9tYVLcMZCp51pBP+m946iT1q3pv7ldir2E7HrggnLeNCbTXweyO+4oTO8z/OdTzHxY+lUQ+rpNvtIf+q42ZoBBAmHq2fo5JcCeBxaZSM9g9IqSa8Q20SGLfCwv0qltTxkBgP8tKarx8pl7Fl3UaRSY2IjxAZIOKr8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEw+F0Lr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEw+F0Lr"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbedf318752so1161866a12.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787213111; x=1787817911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTb4s8ilSvnVrxrv/sl/GlxziAICPTcGZMT22LW8F5Y=;
        b=dEw+F0Lrqj/hRN1l2/jZd26S04Zj0a5E3WrPiGj/IP4mbCSRqeFpKsU/v6QLXFVj9l
         8UDW3h1Fw6p6KgHiuFy7A/n44ExciFeEm/2XYyUs6xedPLtgBwR9zr8Pl14ZbCrb7deh
         eumPK/1wSFQH4dJFrhsUE5MzI2wSv0IFSJQglh0fS7NCRKLvJvEwabyIsKx1PEhVEsF4
         PE+JsRZtJJVCizyjze0pOVwmy7607mUyQuQfGswAKHuFV+HO1ZhFZpSE7DgzO0iweL+H
         G6GXebAxPvUMHws9AksTOu4uQ3HEd4SzUPqud8CyV4ftcEVV2EJ5xXzSDvRW0gi/Ipv8
         dQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213111; x=1787817911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lTb4s8ilSvnVrxrv/sl/GlxziAICPTcGZMT22LW8F5Y=;
        b=TkRAJ5ao7kjuUrMQXh9Z+Q4XfIxERaCRbIyt2SYCL35NgxXlruqtbg0aIbeO0EdbzM
         M2B34UpApmQtJ3Kk7lLsi2ULcFqfSrL6wzaM4t4cTvnowCT2TeCitaAgPHH4eBBncsOh
         2IeJRQ8JBstLqlbChirdEhh7pEBExlYQ7nY9BssBImGbDNV4lg5S3ccXRxyfHP7s9tXa
         Wi8yjIvxrnoDQ5xiSr9Cf/8IcDTBsErCvF4kSrL8orG/KTtvS31ytbMBND0GebSbc8t9
         c4j/gisGF1EmX66hSUCeiw7KdeeeYn+aRDSytV2HibBiqm5NXNlnA5cLzuyCY9y51D9l
         k1hw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9hpKghfVXGkXSMHITipg0SAYe4dpqS3u6sV+kaAvvaVg5WIn5QVqPrXf3wcttRvQiCA3OLIY=@vger.kernel.org
X-Gm-Message-State: AFuF++mPM7laywuqqUheKwe6gJOmj82mRARCiDJKi4zRJ3sF8iXzY/Px
	S7JDu5XsURoWB2rrogXMs7R5smQY17gTNEL+DEDhN1G60Pp5Wh/XM8yD
X-Gm-Gg: AR+sD12eATAADN+zH7iNkd/EfsGCnCAS+PeykoL4FrGzD7WyoSSAPXzgss/ug9RjoLE
	izhrQHaj6FY3o28fFB9kNR07PJwJcL8axGi9eRE0X2fCEO4l9C+f6MsbPgMtyqyFt5241zxRWTq
	1gwVmcJaFIr2rXmvJEJj9jUJlOccyEwKSK1X7+/JTuC3ailJp8usvewd/i5QYQN38O0GK0o1wIT
	rkoNrxEl0Q5bxt2X4lxeUZZjcD2kfoQpCiRsHIrHY0uWdHFUUYF2EU34IPgQWGloCx35GkSyKsh
	6XpF1BktLvTeIkKhaJzjk0uGblSnOBpS56EYZtF2odY42dtGqnlCa+RSZeZvybdwAtrKbk2pQBO
	aE/PMm84+I1JRqO0j2PB8qRs5V6VhjhX0SaA3fodGvuj9tNXt4re+nsOy3/QwY2e6yIW2bqZRDY
	vac212wBoE0L/o2cqGn626uDkNh7UTxA9AGB10dA66F+6A0Q/3htzpyJO+bNzrb/yK
X-Received: by 2002:a17:90b:4fd0:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-39580a4d031mr20764760a91.3.1787213111062;
        Thu, 20 Aug 2026 01:05:11 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb321dfsm6047155a91.16.2026.08.20.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:05:10 -0700 (PDT)
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
 [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Thu, 20 Aug 2026 16:03:31 +0800
Message-Id: <20260820080332.313933-3-physicalmtea@gmail.com>
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

Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
Otherwise descriptor translation can continue to use mappings installed
before the feature change.

The common helper invalidates cached vring access and applies the
transition even while a backend is attached. The backend remains attached,
but userspace must configure the vring addresses for the new address mode
after a successful live transition.

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vsock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..e1e9d002d6ae 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 		goto err;
 	}
 
-	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
+	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
+	} else {
+		vhost_clear_device_iotlb(&vsock->dev);
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
-- 
2.34.1

