Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14242901F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208242; cv=none; b=bewngTVfDXSlzosQ2qMm9BRFHekbqu+yGvk1dDsg/Yw0+Vafacmsr6r81nvWElQz/rt6XDpF0FBLAfpg0VG8o6x4wFlk1t0eOCE0MeL2L3IWeMdshhKU2L+FceXKDzvKS2Aeq7UTfzEgNnpYkMVnrM6u5wTluA0dPWwbLDMo42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208242; c=relaxed/simple;
	bh=2JgBpAWc31ZSpkYiSaZDvjmnHKEA4A5V63g6j0fsopU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILQhSXhhIuIQRQ0vkyjRRsRTncerThj2YWwJYIoYLdjL4cspVDXyrHbJHtP1lJKXsMvv4q4oygq24rFX/DWpAg/wsjf9qCp9722mWUlC+cQVVERkmMCsgIBEOsbNKK3DkpJdAWhiuCWPOzjEklhuCURkfDW13hVbzcHF06RjCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=z3W7Q/Vp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="z3W7Q/Vp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so12999245e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784208239; x=1784813039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=z3W7Q/Vp0l1NU8deNMLBoNbWyYcuLSpHkGAkibaFWx+4p5jEFFZ1wg3/PeOwjquSrJ
         sG7/2NBJZ5Nb3jRXFFnRU9GOGQb3igJw5xW32mJkvID9oA/m5S2Nqb68z9FBTAgmeHXu
         C0LIrMOGkrRSBK8h0FKbm3uBJ7+UnaKSSidEnSMUbdDE7TYfwFQFfIHVssaQMAkuzHsx
         djL8B02CPgRwTlxHvbaAlVARHmjE+8X+af8JYFk1NOPbG0Psv9FNgDpinZEKCjP06S3/
         cN5efKRCLZyH+IDqW+lkn/BoBP6otHCF7S/lk4FepSBtK4mllHKdFLEOQfAQt5TgKepd
         9aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208239; x=1784813039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsn8I3x6C8T9FLWqok7MXQBFznxd0+GMkoGzBjmbnHQ=;
        b=WvNcQWGIad+fcFLuiNpo68VLmn/ccrqSbN1A2VTbi9HF4QjxXD0+iuVywpvOrpUWz9
         YakPrb86SsFNJDeCHammiAlk8fK8vsFVhP9+0ftRwHLdwEFsnqYl5hBQdjmvQFxnYLFp
         WVuXctJm7TcBQ7yLvSHeo7/jC/C4Ui0n+hCY+dFhnDpMwy4isJr/COToLcfgHssnkd2c
         VQpWeFffY+Fpe/kIrMgGRSL4q5SSN+DNZMFF1mbodAdyBoxkmx6cJo0CrH2m8azAa3lu
         6ArbtG0Uuhj0CCct1QZePHVmjWSqiQXE0HdO4RZXvcm2uNL7JvBADZhdNjEnRFePXD9/
         08UA==
X-Forwarded-Encrypted: i=1; AHgh+RrUmdqZAnoWFZb2L9pEy4A9aEEDyASahWoh8zysuszD4/4b1O7dYDWbluGFuMVLeI8ODMnFI3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YznbMf4CrE+z6iWBjr2j+SIkKrj2LbAlXpLCSvyXdAd1MAVZ96C
	zPTGMFe7nsY9yF73HU482rsE15wVkISuQqKiV5uyqPabKsDM3OTtCVi33hzSBZlja9Q=
X-Gm-Gg: AfdE7ckY4VUTUHwneDaMPZ9MB7tCgMhMVeFwJkisfZb5rDr5IdXHrQ6GEe77QIsXhx4
	glzud5VHaiTFs35frZNOjaMYFpaMPePSebHdb0DBv88Q+jO17ZZeKQHCRblXVT4Q7lGG5f4MNuL
	Q8ghj80Rxjuq0A5aSXV5M/BYsiQRmEAJ+Uzsm+mSdWHRjPDavyYPdlroyI0IHD/KtSEbXrjw1By
	UIom8rYis11wTLbGB5/nJJ7b8MvFz0uXn6u4jyDYJ24GsVo2odvVET1cwibivhEKb0vzywMIA18
	MaAEGGAsqr+a+ncoc1B/pouLMVuV42HfAO70jRTMMdN/AaL0SWlk29vjwvo+eO2Tcxrj11sIzzi
	GBLHdsJf1j0WxnLfQrJb6zM9L9kId9giVBSA+xtkFxNqEj3C5KjotwIbWmgQbd2EfUsN8+dUNyy
	qEc/bATjBRInU=
X-Received: by 2002:a05:600c:6089:b0:493:b7cb:c5f with SMTP id 5b1f17b1804b1-493fa8afbb6mr218943975e9.11.1784208239547;
        Thu, 16 Jul 2026 06:23:59 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e8c47esm60892495e9.8.2026.07.16.06.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:23:59 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	cmeiohas@nvidia.com,
	roman.gushchin@linux.dev,
	bvanassche@acm.org,
	zyjzyj2000@gmail.com,
	shuah@kernel.org,
	tj@kernel.org,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	yanjun.zhu@linux.dev,
	cui.tao@linux.dev
Subject: [PATCH rdma-next v3 10/14] RDMA/core: Document the SELinux ibendport net namespace limitation
Date: Thu, 16 Jul 2026 15:23:11 +0200
Message-ID: <20260716132316.1495242-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132316.1495242-1-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Document that SELinux ibendport labels use a global (device name, port)
key, so same-named RDMA devices in different net namespaces share a label.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/security.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 9af31d1d9d70..a82c46965416 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -700,6 +700,12 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (qp_type != IB_QPT_SMI)
 		return 0;
 
+	/*
+	 * SELinux labels an endport by (device name, port) from a global
+	 * policy. If devices in different net namespaces share a name, they get
+	 * the same label; distinguishing them would need net namespace support
+	 * in the policy language and tooling.
+	 */
 	spin_lock(&mad_agent_list_lock);
 	ret = security_ib_endport_manage_subnet(agent->security,
 						dev_name(&agent->device->dev),
-- 
2.54.0

