Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB08423EBB
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208207; cv=none; b=EWrVLgG0hP2J1bYskhYjCXUf/tTtNtDSsUNLzas7VXRf3HcSckfXkcSVaoQTD94feWko/RWnJBMmg+cfkWDxZR+l9dBbm8qv1W8d9hi19s53220ynmJ2yECpxEDaFQ3ZDLWsd7yDOM9wo1UfymI645Vty98xbKvl1IC8AbwEV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208207; c=relaxed/simple;
	bh=fj0Q6ihUmYqKUkY8KaHXFWF5Aioa8BtTYy9MtuieBMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZadmCssyneqGlE9xbO6OUfDf/H0VBv5NqdpyLekyrQk2dIOLAu+tj2A9Q+lMNdxlJbLjpsP0NiyJ1S2FlOCV9obetcIQs/seEO+aFwe9PXMbZRZLwx8EaIfHLec2ddhlEiGaMm1sQ+wteLc8+hi8aaq3U8vSuYkaQkt+0wHhXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=qox0pSLi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="qox0pSLi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso38881455e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784208203; x=1784813003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q+RolV7SjzshTN5zqSzxTVIaSTGOodHrW0P7odUB/p4=;
        b=qox0pSLiefj3H3b5yXgGce7hMBs+nGwFP0fXP8ildlEPyWKU71V/Mc/7tx2RbhA+k0
         phHG0aca3QdBs7SYgG+hnJwQVpwpKX39JOPQpMtME1P6gikJBkk0v5PX5CZlwRz1WZsJ
         8iCVsVxGrqxkRJBp9caqDo1ON5i09Nws0QKBJNaH8PgPpF2hgkLHHGTI45Yu/yqnyQkD
         Mf22PCSNPxX8QTqLcud/saM45nIDPtMLogkkSNDbON9i4WaLfYpdh6p8K3xao0rASsE1
         jyt3mjXWyyRPovgPNYlD68FzrJJluk9vjuSiWT3d6O3RQPLuwZvlFCgAcW8WFC0ZQClO
         aavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208203; x=1784813003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q+RolV7SjzshTN5zqSzxTVIaSTGOodHrW0P7odUB/p4=;
        b=YdSsszvojj34z4oKMxFp38kWp+Unbt8R6cxVGGzw7fZ421tbCWoqOmOyLUlVUMRquI
         pcEsX9LoPmowJgiBQmPp5tHamXEYQR/87JOGIZ+wPaGBHuKmbumLUDmTMV8OIUJFOaI7
         yqIM2hb7aauEBQ70MXx5EbL62pPyNCMg3Huw7NMMq9XCxOzyO243hOpfIwx58lb0Jgbp
         qWpzNLCmA5VAbERtSc7pdYwDA0IQu4IOWFz6P6rq6FnazBagGdhhaZx8yk7ISvkE9ZnZ
         yfCbJWryeeJkTgutImh4BDQAW+6U09cw890BfseAHgABr+gA9DWNOoCcFRLene55dRjL
         FjRA==
X-Forwarded-Encrypted: i=1; AHgh+Rpl9AVdx0d5un8R3QmmpjzMOWlOL7FwOaqwmIETzS7oWsIkXye4CPV4I+bW1BN1pg58/NUhSY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvrVLIYPTgEE9QVmVVMQ/hE8F6spLfsDhkc255kVH37VuVlJi
	v+FAC2Ru95FZE7BR0f+8g3bqpo2IjnY8cYa/vJ48Qo5XaBzQeJtf/d/nk2vAPu4PEbI=
X-Gm-Gg: AfdE7clo2caWKLg+6XDJ0uCO4GPQFW8opMoAmnYtgxYO0ij6zC+EBlMPIbH+2Gja7WP
	Fw5tY9Y1AhgBWyvAbtoo3jq9GzQP3ldC47k6GaForsZn7iBdU1EgElJLkKvJS5M8md7YC69qBij
	NqMbfUWMwdYpwrAyGKVVqqekX2qDS2dO3mq3vBLiIzROQfcd3bCsJgLsBC9zDEJOtJEMbcz1L+E
	j7oh1AT3m6ArUfJPbKYrnBC54qXUkByezyNq2UaWZWe3N402a0H1679dWMtu57aV26n4Xnde1wy
	alLoX2cSjfnZYTPJGBqi8ihiCSosq0zTkkqcE+3niUprjigbgv9djpz5Qo4mnlb4gjL6XvO8bJg
	j3Bwf/EfaKtNKvOVVv0zIUjk3q7eJUp61r9HNX0jmBLGtc7ujdT4OSITTmfwTu3Nc8sBqeYwO8Z
	QcgIq1sXmhWF9ncwa7eoYOIw==
X-Received: by 2002:a05:600c:a00b:b0:493:f261:d295 with SMTP id 5b1f17b1804b1-4953f1552bfmr62260225e9.4.1784208203243;
        Thu, 16 Jul 2026 06:23:23 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb02b9sm55456605e9.11.2026.07.16.06.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 06:23:22 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 01/14] RDMA/core: Pass the net namespace to the device name lookups
Date: Thu, 16 Jul 2026 15:23:02 +0200
Message-ID: <20260716132316.1495242-2-jiri@resnulli.us>
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

Prepare for per-netns RDMA device names by passing the target net
namespace through the name lookup and allocation helpers. Keep current
global uniqueness behaviour.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/device.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b8193e077a74..de610f52c9b2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -351,7 +351,8 @@ void ib_device_put(struct ib_device *device)
 }
 EXPORT_SYMBOL(ib_device_put);
 
-static struct ib_device *__ib_device_get_by_name(const char *name)
+static struct ib_device *__ib_device_get_by_name(const char *name,
+						 const struct net *net)
 {
 	struct ib_device *device;
 	unsigned long index;
@@ -395,7 +396,7 @@ int ib_device_rename(struct ib_device *ibdev, const char *name)
 		return 0;
 	}
 
-	if (__ib_device_get_by_name(name)) {
+	if (__ib_device_get_by_name(name, rdma_dev_net(ibdev))) {
 		up_write(&devices_rwsem);
 		return -EEXIST;
 	}
@@ -435,7 +436,8 @@ int ib_device_set_dim(struct ib_device *ibdev, u8 use_dim)
 	return 0;
 }
 
-static int alloc_name(struct ib_device *ibdev, const char *name)
+/* Pick a free index for the '%d' style @name pattern. */
+static int alloc_name_id(struct net *net, const char *name)
 {
 	struct ib_device *device;
 	unsigned long index;
@@ -462,15 +464,22 @@ static int alloc_name(struct ib_device *ibdev, const char *name)
 	}
 
 	rc = ida_alloc(&inuse, GFP_KERNEL);
-	if (rc < 0)
-		goto out;
-
-	rc = dev_set_name(&ibdev->dev, name, rc);
 out:
 	ida_destroy(&inuse);
 	return rc;
 }
 
+static int alloc_name(struct ib_device *ibdev, const char *name)
+{
+	int id;
+
+	id = alloc_name_id(rdma_dev_net(ibdev), name);
+	if (id < 0)
+		return id;
+
+	return dev_set_name(&ibdev->dev, name, id);
+}
+
 static void ib_device_release(struct device *device)
 {
 	struct ib_device *dev = container_of(device, struct ib_device, dev);
@@ -1223,7 +1232,8 @@ static int assign_name(struct ib_device *device, const char *name)
 	if (ret)
 		goto out;
 
-	if (__ib_device_get_by_name(dev_name(&device->dev))) {
+	if (__ib_device_get_by_name(dev_name(&device->dev),
+				    rdma_dev_net(device))) {
 		ret = -ENFILE;
 		goto out;
 	}
-- 
2.54.0

