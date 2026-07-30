Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF73C9438
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442316; cv=none; b=Gww80a17dIi5dLEzvV8ssgPrl/F377zDa568hvHKVdHsXzXniNv5WBqWOaGHFcwB4vF6jmp5setIUEoicauGNUJUAPlHamkTwR0ZH0ACGHIpHj0SQrOsowtkBi4kRsi9BH+K5IESN7r8ARx7GPf9EGQXDYFpwGGW7QZ9ChE8mt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442316; c=relaxed/simple;
	bh=bgehGYxVvOhqrzJ9g+V/DTye3Nic7PErqY7Gl161rk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TFYpmNbUUj8x0hnZcFcpWvy072RTFcK+P1MxkH+ikTI2l7r8byuyC3WArNTckOGgeEg/LnIQrSsKJdr7nWRvgonMXidFm1yQqnEpbIDA6tOd0emyudmMp+YkvuAbQkOAI8bwPJtSArRT5akuRCgpmgmp5QUubO0XaVKfLMojwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPRHU6lD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPRHU6lD"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848d21bbaffso372023b3a.0
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442303; x=1786047103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QRL/mQO23aZLDOYAwAiZdksOJj7+W5EBU224dpv2hko=;
        b=OPRHU6lDbMDEHUFF1ZIxZ2FPR3KXkwHT02N8z8G8xm7qBAvH50vGstqFkKEkxNYEpg
         JWNEq7Y9Hw2FPtMYris0qZslz6Ez7fSIVXa/DQ4v+Vozgxw2z7Osqj7U0GkflGrYDBWl
         3+G1eK61/bVTsR4KdfbXDEuTK0U1UV3XkNS/flvEM2DSHHc/nJ/9yzrQC4UxCmLF9FBG
         UCTiwULO1MW9eC6pcP4NoHJz7RJ4O378FnqQhLNU0MPb+4wuN3j86csgp3dRH+MKEMRY
         TQnMV2NPclc+c2iSnZxPqN2GFXa5YDHyJzKjLcSZqzeLup9hfdfmcxxsK7tdkcYgf0mI
         z2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442303; x=1786047103;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRL/mQO23aZLDOYAwAiZdksOJj7+W5EBU224dpv2hko=;
        b=MXLjeGxXyP5p03FuHWJ0gk9H8DrvZ1I2gAdpYCiVR2fpJ/p5MzzBaX5p/QMs+HDfVC
         +Hy3mjPdwbop/GIR53W5lev66opTnLod3wRROlyJkd35yk4nxi8OB/cgOAfh3RSh3jEH
         8qfc/KsWGoPrlqescjkgtkkvxGI604qTGWeg73w3QfduOTmBdxlQ6NqdhHbVo9CLBBC+
         tzgb/rlPCrrQKVW57HmjgO1SucYQb/26J9QBwqmFMq6eg3YM5jx2w6y4YhMi6cZTZHxH
         q5WcwWiplbChIQqwCzkGSuH9apGC3Ldxxy2sTF2gNquwu4rMQO3KIxO3CfBR1m1WmZzY
         xxvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGoRGQQHWC68ZR/t/rAyGb3NXsn8E6ewwqMNQcrj0l4i00oi0rK08AwH7l3zxbMrRNEgHp1xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlf/RuyybYIeb6mAZVALRBGUlliuju3H1QQsgvTmTKIxDb8wS0
	o5ybJcSO5FfLS1bb6AVKWe1ajECr8KKejyyd2ay/eGXvf0BrtFfy2c6X
X-Gm-Gg: AR+sD13f2tJkVNWt7c+TcLjpQNdm6hM2+XIp5nhzbCkvsFLAPLfbnqPM4gb0RcTYfnz
	Z8uoGtFEtflkWYWYcXfi44bNpNYDsY5TYmGBm5Cg0d1OXVj/vWfKDX3FU0LO7BGLHNHPPA5kv65
	n5NCFevVPuxD4EoWUzp4RLzffu3HC4tY6lPCs1MdME96PwyN90lfgBeggqJ3PC7Z7J0BN/LtpOx
	GjD699leIgX9met4hDJ/4eSc+qqSj4/0TF0lTZpYpDbyugox793yFA94wES6iE0OuBfijlddr41
	AbtH9b1EG23UfspwqkQwUj8Al2T90UrJZD1yvPW5FsUK2OFAqVqI2CrlJgeC59r0Jl48We2XKbI
	zxEdmqAZW64vEg4esZnXdVY4xteDbhyWDs4RFbqYGVGloDChh+fd7SNwAbKIAn3hEoeaO/y16KJ
	cFsT8lBTTCRAfs8lTWn9O8OtukTPw0RVIJAipC24H2SYhuaullQlOWmeqSPAP/WJ2fTCYyfE93T
	wb6YthHZO+BjR18i1C5FdRk45P8jkNJZVpaavcj5qk=
X-Received: by 2002:a05:6a00:c82:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84ebc22e874mr3531492b3a.21.1785442303585;
        Thu, 30 Jul 2026 13:11:43 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:42 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH 4/6] drm_hyperv: Remove support for synth video protocol of old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:21 -0700
Message-Id: <20260730201123.1767-5-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, it's no longer necessary
to support older synthetic video protocols. Remove the support.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 33 +++++++----------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index f0ef627b4898..cea1ea2595cd 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -17,7 +17,7 @@
 #define SYNTHVID_VER_GET_MAJOR(ver) (ver & 0x0000ffff)
 #define SYNTHVID_VER_GET_MINOR(ver) ((ver & 0xffff0000) >> 16)
 
-/* Support for VERSION_WIN7 is removed. #define is retained for reference. */
+/* Support for WIN7 and WIN8 is removed. #define's retained for reference. */
 #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
 #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
 #define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
@@ -557,23 +557,12 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 		return ret;
 	}
 
-	/* Negotiate the protocol version with host */
-	switch (vmbus_proto_version) {
-	case VERSION_WIN10:
-	case VERSION_WIN10_V5:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
-		if (!ret)
-			break;
-		fallthrough;
-	case VERSION_WIN8:
-	case VERSION_WIN8_1:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
-		break;
-	default:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
-		break;
-	}
-
+	/*
+	 * Negotiate the protocol version with host. Since support for hosts
+	 * older than WIN10 has been removed from Linux, only negotiate the
+	 * WIN10 version.
+	 */
+	ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
 	if (ret) {
 		drm_err(dev, "Synthetic video device version not accepted %d\n", ret);
 		goto error;
@@ -581,11 +570,9 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 
 	hv->screen_depth = SYNTHVID_DEPTH_WIN8;
 
-	if (hv_drm_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
-		ret = hv_drm_get_supported_resolution(hdev);
-		if (ret)
-			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	}
+	ret = hv_drm_get_supported_resolution(hdev);
+	if (ret)
+		drm_err(dev, "Failed to get supported resolution from host, use default\n");
 
 	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
-- 
2.25.1

