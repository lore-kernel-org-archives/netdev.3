Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB03A8722
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442310; cv=none; b=C3yI8r/vE/zuNgU1CiL3blGlvaKsxYsTqJP6HfTg3vxZN61YoJR5423grqbJDRCE5SVne+b/FqmXPW2BEUYNjUmGJv0PaeNl+eY6S+FWJVtyNxemu3WW02UXU1yR7273bNhO74C2iwioMLSH5bWxdAuiiA8G4wL0O2Dqq4cYaIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442310; c=relaxed/simple;
	bh=ywoJVudyQly2BSU4Suu/ELob67veyV2IT2JljVMnXPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJbodwP0OE3TKg99n0vkaWSddxrzuGZldEfZQ9lBiskOUBkK7joI7fduGJdhF8vXjJp/+GuaOB/rP1PyxJSyHI07ZaESARHqjpY8UUIMZfDh57WAoWX0PHtHg9KCOsp8bu/heKl9OgWCHHGLev6TTkDyezZ2drlLii8lJxRtC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZE+rgqp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZE+rgqp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso324288b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442301; x=1786047101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SiwSGXnRH3TAjHZf8TYJ+bLPyzkydxq8UaVMUOfakl0=;
        b=ZZE+rgqpWGO8ojZDXUbip2ounkYY1eNg1d/0oFePsUOEIaLoBEWK68sJkW7Do71l+c
         mv2c21/bWO0tG92lgpzz8W59tzWOgzs5Dyb+TSZ63ocakvnEwITXuv2zLJHhH5YoFoUf
         h32nb2ymWScCbUNtfx1Wh9iEYigiS3fehlP6otLLhF/HFqkH3dC9bLl/rlouFDNV1lNp
         57RGYHcbxYHG6TKhdjIMrOTJSX6ljivYWRSYXrsjc9RyVX3bqWyG84P2MnMo2XJKI8jQ
         DgjQ+LjftpwVskuSqBOBR/leyinBmGfR93VbzVs5jHN5dy6CqqY8jpajaPK5QyvgGU9L
         qCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442301; x=1786047101;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SiwSGXnRH3TAjHZf8TYJ+bLPyzkydxq8UaVMUOfakl0=;
        b=krt3oI9u6Y3felX4V4NUZYHk2LO6xuVGV0uBJDoQRXrYzpgr1Uw5HcZ1zbfs+IMoV6
         aRLe6tR0h5DKgpBdtw4Hleq3qJDdCW2mNgeBJfH58Z1U435VIvUWEoR2NN6ApWFmexQZ
         wM3Zb8RGJ/Bvo/yGG3dlNVlxpHjtdbnyCEid029I94hoMBPXT5FuRXxeSD6J2uMgRqZQ
         Tgy08SgL13G8CxC23S20Twrllb3x7OTR4/zYosjaqmE6m61Ax/vlR1hjttoqIuo713Ey
         s/nrbVA0fJcoGfETPg++5s2j7GoziL3RWZDwDH8182TWxLvPJaTVBA8CUOHvC0oZIN7X
         oJjA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9DB6+hnAmFS7Bk1eEC4mxjPVShgoE3CUvk+cu5j/lEcZ7mpa3xEpibOMIo99Ax9+Q/s6O/f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3PRns+nY4Lgur/z+ykeClrd3z1Bvj6DtQLy2D/kW3/SxvCGa
	k4acmbTWJf8ooOw0vYwc0T+fcoB/qDfL8IMtJxdme5uSMB9gbZ6OiifL
X-Gm-Gg: AR+sD11CTgRwLwYYHF4xcWIWl6AdYQUf7u7N8vAU0ZvWavn9QiehVseBfNsNDeOvsLb
	u1M6wOsR3vAIr4TVH70DpshAaTe+2TEZTSLewAjrUdJcPmtja4Ah897keOqlgTV4wfnJy1qrm3K
	ThRe2ik7Ny8WDYAM0g67U5iegKAKRMdTdECy1ISGkTc4BLhBFy2Bw4DrjKcyIUF2MJE1F5WiVBD
	mk8USdVWr4uR8kyFzkEiEmStyBbuysr+kVb2WK0+55R9ybtJKH9oHTjYeJ+H4dkepkqyUKSESQC
	gdAwBtV+QTZSFITro046Y+92TMaXZUo4BSqjTSnLYmsLj5h0xu16RxrYPDHW651iOa4iO+7WmHm
	vnb8bzA0nW05H1VegM6nsNj5Zy7qZeZARoag2ttikys4GXzPPz5N7t4vWx04v7Zn7Xllr04rOGy
	TER8uoxh/VH2auPRPcWA+5EEz8NwaYMn5cMc4USrrZKxS9UZX1bZtTdiKVJ87NhAPgbX6P8DNDC
	NKvDcDo1vUwux3ppS2EJNkxIwgc5wru/fQXr0czRnWkHPcPLKdlpQ==
X-Received: by 2002:a05:6a00:1391:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-84ebc1f5844mr3898044b3a.8.1785442301426;
        Thu, 30 Jul 2026 13:11:41 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:40 -0700 (PDT)
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
Subject: [RESEND PATCH net-next 3/6] hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:20 -0700
Message-Id: <20260730201123.1767-4-mhklinux@outlook.com>
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
hosts earlier than WS2016 and Windows 10, the special case handling of
GPADL teardown is no longer necessary. Remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/netvsc.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 4d319c50955e..4295b96b4312 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -695,17 +695,8 @@ void netvsc_device_remove(struct hv_device *device)
 		= rtnl_dereference(net_device_ctx->nvdev);
 	int i;
 
-	/*
-	 * Revoke receive buffer. If host is pre-Win2016 then tear down
-	 * receive buffer GPADL. Do the same for send buffer.
-	 */
 	netvsc_revoke_recv_buf(device, net_device, ndev);
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_recv_gpadl(device, net_device, ndev);
-
 	netvsc_revoke_send_buf(device, net_device, ndev);
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -733,14 +724,9 @@ void netvsc_device_remove(struct hv_device *device)
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	/*
-	 * If host is Win2016 or higher then we do the GPADL tear down
-	 * here after VMBus is closed.
-	*/
-	if (vmbus_proto_version >= VERSION_WIN10) {
-		netvsc_teardown_recv_gpadl(device, net_device, ndev);
-		netvsc_teardown_send_gpadl(device, net_device, ndev);
-	}
+	/* Must do the GPADL teardown after channel is closed */
+	netvsc_teardown_recv_gpadl(device, net_device, ndev);
+	netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
-- 
2.25.1

