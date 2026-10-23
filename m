Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749732;
	b=bGLWycJpDcWerZ7NOUm4sdYnFVOdjBwSwiPX7rrIJxLRfqyltgK+FpqOhLbgPJiiCFN9
	 cqE3ayxwogXL1L2SbyEj6uydcYwFyyth8W/hI0upj0JkMFYRYGSCnuvis62hvhhFeoQyi
	 yHXkdtJTBOCYaamEPK7HUPxKi8DmEI8xJ6Sxc7eeN5n214LMR2qvrDgifHc39EkOFAaTq
	 PptoRcVbpdkP+aZ1NNCK7iJMSO9EWqI47bvaBVF7aALD9x2dRkh7/GSKy0sdnTnlVDAYa
	 DYvgDHkLF4oy/TTU0jHa0aIqh3xxADjUu06fcZHycVcDiJw4lVH6Rz6hL1blHR3mcPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NSR56nnQnUR0d6l59Po8MuoMPblQ7AEGRUC1M2Gh/5A=;
	b=zN0Btomy4MocCIuVi57axQAFDICeMwX1K+PBjIYkiDHNsQDsaS/QPfCviYCNi6fMdGnn
	 5ehrrQJ1Mps1v/ElZqxurPRuvkJ1itLh6WgU2DSMqgsdApKLnn7b6ExS8VuxPcWVIUz8a
	 6Bx3z1xsGssfKrOuI094bG5h2ungcdV81tuzxrShvoVBmaMd3sOFo2J3SOHnyr1FegilU
	 DEPevGQugx/7RfcW9QRjoar/7tkt3vTSuEGbHm2FyyN+Z1vheU6HS0J9ubfW9TqnFizI1
	 g2m8KFmoXXLQN26SEbftjS3I5TZ4jHjltKLLkyJ7kC32RvzizB8dPCd03AFTe4wlAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="e/VonHDs";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901A606A31D
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 10:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6901A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/VonHDs
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48df8fe8513so611623f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792749731; x=1793354531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSR56nnQnUR0d6l59Po8MuoMPblQ7AEGRUC1M2Gh/5A=;
        b=e/VonHDsRcN+yoJTQWlImqGswC0azS4maOfw8sqzWjYxI6m5YuadKrBI3wsSM3Kdol
         f33SjPRNQxiHbtG11cEW+zNdfA23IggN6VxfY3En5xqzUkNQjoLBFnxZrKC5c9d1F1V7
         86QW95Gbn9QaUG9ctmVajG+TWYF6O4wMl4E9wCXtM/ggiJy83O1M7KoOCEEZhmH6ktC8
         cKid5ORUaDulA4AP9ZuFDgZETyGdnxoMqBJ3o8/L/4TBRe0qbsDDA4MdnpjVbKJXg6rQ
         mYLzpj+FHbvk7j4suWqlh0SE8DUiQ6SOGeFjx11DANc0OWJsFUa+XYK05vE848HgShw5
         xciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749731; x=1793354531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSR56nnQnUR0d6l59Po8MuoMPblQ7AEGRUC1M2Gh/5A=;
        b=ORbyjE1EZfOCX0DgrjF3eFyLZ7guMMh7oEbbDbuSj3GKnqqF7yiRKpMzUNCEv296mT
         PU5Oh5hsMTLsYnLuC3I8CJxm3xN9RVYkiQ9c/dFAvq7muBX079u1p5DoIOewnqzZ0k7f
         7Xj9fQh/AEeJ2kVwbId5QMHh7qXVg9WCX+43wFnEuVL92/IDU369Yp2eIlQ8lBscUocd
         GT9HzUV/++m531tA+8kZ8PqQTKl8Ha7cGjqudvIm/9uKP0YtLefqvSP8O8woGBGzzM37
         IDQ+P6rfzaazY9FNo9QdTQNhizSYUHa8lWa5zvggi3WTpJSQoAXErM3RPr/B63p+8zUc
         sTRg==
X-Forwarded-Encrypted: i=1; AKwUvBwC8cKcB3oaKRtJoYVwI2W7Y2ZoSf5HE7OE9DSGZd0mLMS7gO3NiOuBIbFOKjqARrgRav6xX9I=@vger.kernel.org
X-Gm-Message-State: AFq9FYI03OOdXLh3ycwPAC7jL64i9vEInpRz4SD0vBXR5qPWfa0LRF8B
	H6JulyGBMWbtDJFt+HY18tX6d1E/c+yUs3+zbTcwy1E7abUexHpjxIpR
X-Gm-Gg: AYBFou0B9co6kFWjlwVabrbcSCxfv01KzXv6de/HTIjjY6BLE//HmSi+/9BH106RJFK
	XsJbyajXhTkNRoZoTICcIg9d3olDuhEe723l+CpXS/jtANXfzz4wZtli8IXwd1NxV+1Bqx4BzPY
	PkXi86LYboxRfDDrZiE6OjBZdI12YZ8xiyUhLRWWc5xf8S6g33UF+nClZRO4e6PhFeum1JdszKO
	pXoEELY0QQv7B4/ar7z7WV83W1laqkiTJ0P3iDSKAA0Kou6UAXkGOBNadh9h6Rt1UUs1Qoog4Tc
	6llweZL+gwUl2q4+PgWd/lSBUqkH10Q1HYRaNmc0hKxOs9AWN8oOmiOHnKZ+IxmaFZXXMW0fpR5
	DX+GVZFPNF3N5NI6/72yCQUnv4SxJwaRT+OCpFFkZiuoJkRFJqL71/b2ojXOs/RCHWekHILGqWs
	JfcCMRiAZHwgMs4I5c2THZsCn7yHsv+qAu0foUuIvVIbDDIWJvDKqjLEj78kfR8aS4IR/IE3QKo
	Oxx65GIfNlZDD/F6+fozfygUnq5nLdMrgxAh/sExummbHWsuzZck1Ns5A==
X-Received: by 2002:adf:e805:0:b0:48d:f996:1814 with SMTP id ffacd0b85a97d-48e385c0cf9mr1868754f8f.57.1792749730555;
        Fri, 23 Oct 2026 03:02:10 -0700 (PDT)
Received: from localhost ([205.147.201.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38062dc6sm3902320f8f.55.2026.10.23.03.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:02:09 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: achender@kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Eduard Zateev <hackerowskiy@gmail.com>,
	syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com
Subject: [PATCH] net/rds: hold IB device reference through deferred cleanup
Date: Fri, 23 Oct 2026 12:02:06 +0200
Message-ID: <20261023100206.126692-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RDS device teardown queues rds_ib_dev_free() on rds_wq. Hold a
reference to the underlying IB device until deferred cleanup releases
its resources. This prevents device removal from freeing it while the
work is running.

Reported-by: syzbot+221e213bf17f17e0d6cd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 net/rds/ib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/rds/ib.c b/net/rds/ib.c
index 786f39169bc..597872e4fe9 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -115,6 +115,7 @@ static void rds_ib_dev_free(struct work_struct *work)
 
 	kfree(rds_ibdev->vector_load);
 
+	ib_device_put(rds_ibdev->dev);
 	kfree(rds_ibdev);
 }
 
@@ -142,6 +143,12 @@ static int rds_ib_add_one(struct ib_device *device)
 				 ibdev_to_node(device));
 	if (!rds_ibdev)
 		return -ENOMEM;
+	/* Keep the device registered until the deferred cleanup completes. */
+	if (!ib_device_try_get(device)) {
+		kfree(rds_ibdev);
+		return -ENODEV;
+	}
+	rds_ibdev->dev = device;
 
 	spin_lock_init(&rds_ibdev->spinlock);
 	refcount_set(&rds_ibdev->refcount, 1);
@@ -180,7 +187,6 @@ static int rds_ib_add_one(struct ib_device *device)
 		goto put_dev;
 	}
 
-	rds_ibdev->dev = device;
 	rds_ibdev->pd = ib_alloc_pd(device, 0);
 	if (IS_ERR(rds_ibdev->pd)) {
 		ret = PTR_ERR(rds_ibdev->pd);
-- 
2.55.0

