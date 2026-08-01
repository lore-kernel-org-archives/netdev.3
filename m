Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724693BE16A
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557630; cv=none; b=eWJXWclZZ7Bmut1enQeLrXfswt+DTh52Pa3L6MEQbrkRFKpmpEQxFRXNSRX+U9M14SP2b4H+JyB+LRkzaOEwHif3cFPA1A8MPKwhSxks8kjyCnNeW+XDtozB7IzgCzRqOQZQaIEq3h4bZ7b38eeZ0xQo/lUrOqW04unv/cLZZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557630; c=relaxed/simple;
	bh=nLDhV+zmniyuQ7LULgZwxZlvkpLR+oYwW3ogdJt5Ks4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HXaZ9qmMx/t/neZnT7TbBP0RbFCUOZAZjGgGKRyVJKevqef5bLO4hXQeaXAXeBsNwb9yCIrsqJNNMliGzE8nETOGCYPjypV5IEvPDQvFlyN/7yWCgviopa1LgFrEmqbtcFxo8Iy0xHt6pcp9i+xBvPFxVML3/+Rz5Z0ZQBLY8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdAx3v0W; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdAx3v0W"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so1722241b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 21:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785557629; x=1786162429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jrE4UH4YmQ8myC7nj8WqD8zWfQkc375ZACniEnS+p14=;
        b=VdAx3v0WVUbS3LaJpw5x8m9bOlkzAenEMm92djo/88lN+/3b51kfUQaOWdpl+GGTvH
         5Jzb5P2nRSwSUbcsZaD7dIAkE8IQR/yQ7rYF5QDTzpBrD0ZSzfLaoxslcBo2zqt0izVA
         6YLm5fnPZNYkLKr/tBWHQVNJMO8dtPdMv3r54Fbg5f9+4XoH7wLHNZdJBkHkqDbY+sVj
         jP0wKJptEUnX2H8c5WtBqjuwlXjxlAevgrWuQpPbdIp5Z46d1q6Q5EEnkECcKVo4JTiD
         eDTF5ElJOd71YOeNXnGLHqmGkaEkSJFkU5VHQp5S7RLw34wzUOb4/Qn68b6UXqRTq33j
         tiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785557629; x=1786162429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jrE4UH4YmQ8myC7nj8WqD8zWfQkc375ZACniEnS+p14=;
        b=i3j17uXB61pFVT69JvoZ9gOKB64VJhZeL9EwKbiofiCMXeUV0QllgmRcGwc58NNvGT
         MfcTRoF/rvRYV5A8Z/ARlmxNoFgJXTm6EtXc9dxyCudkvvMr2OZIDLnjOVeKGbJgHbAj
         yCZfpgGBvYG7zbPr/iythCsOrfMSYFLT3Hq+CPRIrqopWXhUCqb/kwPyqXyZ2ma+20is
         xxe2p5DmOQKIuHZcuPhAPpcWXCjLJQg19kX47D2lfu4BsyczHdFmmpDQIjSjvYWL8WUV
         8Ez1IHH2avEzVGD66+v861duB6u4OZYyfkeWEgTSbuSB2uDR0mBfkD4h1/Qn5aiCEUji
         OLwA==
X-Gm-Message-State: AOJu0YxfELG35mKV85zGG92YutN1Fy8L1mynTVVcWtMxPCMWcofrwd43
	bEOxGUUVzJw++KfzO6MVqwGk3p2u3O57o0WghgsowE9yFSp2Lq2Unezd
X-Gm-Gg: AR+sD11PaUjJPFBDFgy13gFJbMhr70eToXEMMMdHnVQAtjXie3UNOYLeO3sQuiisgp5
	u3zT+E1fRv+WwgQBaoJIvvia06bQ8bwr1AzKVOw8iuCmbPvj8mo4avfKJ2BVKhFvQ2MTRdFm03s
	bd2cI6oEkuGnmWbpElBcTBZFkbFY3Z1IieGWqFJEpItDK0qfXdMdxWACtJ9kiYiHe8BHoU0PlBt
	QgF3vRbrKIJ4t4Si93UHXHT4I0zlXCvMiiqd6dDl9AjeW1AMJLE/VsQ4avrtDxq70iywWLIZ7Pb
	7xhLFFuNt5/sEzYP9AHuk9f8/ZI1D2aN809De7e6x1bXtfVl/b0b0wMtT09HlAXbW1F0nPnGXQv
	kvUEaA2DIDFJJFKD7u2QDxpn8q8NtP1CzF71Cx5nsM7NsLVKRScL9Pr5LopRxlggwotM5c6o8aS
	1F4pIZCB/rdIxui6fVmxTKjZ9eA9Vu4BxLaf5989TRCc0dcxlvTi3mKbWh/h5fFhyFbkMkjOVFr
	vpPTBcrCQiL6tQqaHWNhQ6/7Q==
X-Received: by 2002:a05:6a21:e598:b0:3c0:9c1a:894d with SMTP id adf61e73a8af0-3c92a95303emr2124391637.69.1785557628712;
        Fri, 31 Jul 2026 21:13:48 -0700 (PDT)
Received: from localhost.localdomain ([163.125.213.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39e9f22fsm1307504a12.22.2026.07.31.21.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 21:13:47 -0700 (PDT)
From: paulinsider <paulinsider@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	slamhu@tencent.com,
	paulinsider <paulinsider@gmail.com>,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH] xfrm: hold state while flushing device GC list
Date: Sat,  1 Aug 2026 12:13:40 +0800
Message-ID: <20260801041340.92117-1-paulinsider@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device GC list does not hold a reference to the states it
contains. xfrm_dev_state_flush() drops xfrm_state_dev_gc_lock before
calling xfrm_dev_state_free(), so the regular GC worker can
concurrently destroy and free the entire xfrm_state. Subsequent access
through the stale pointer can corrupt memory and cause a kernel panic.

Try to pin live states with xfrm_state_hold_rcu() while holding the
device GC lock, and skip states whose reference count has already
reached zero. Drop the acquired reference after the device state
cleanup completes. Also use hlist_del_init() when removing dev_gclist
so the node is marked as unhashed after removal.

Fixes: 07b87f9eea0c ("xfrm: Fix unregister netdevice hang on hardware offload.")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Signed-off-by: paulinsider <paulinsider@gmail.com>
---
 net/xfrm/xfrm_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 36a4f6793ede..01138d3d1067 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -785,7 +785,7 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 	if (dev && dev->xfrmdev_ops) {
 		spin_lock_bh(&xfrm_state_dev_gc_lock);
 		if (!hlist_unhashed(&x->dev_gclist))
-			hlist_del(&x->dev_gclist);
+			hlist_del_init(&x->dev_gclist);
 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
 
 		if (dev->xfrmdev_ops->xdo_dev_state_free)
@@ -1006,8 +1006,13 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 		xso = &x->xso;
 
 		if (xso->dev == dev) {
+			/* The device GC list does not hold a reference to x. */
+			if (!xfrm_state_hold_rcu(x))
+				continue;
+
 			spin_unlock_bh(&xfrm_state_dev_gc_lock);
 			xfrm_dev_state_free(x);
+			xfrm_state_put(x);
 			spin_lock_bh(&xfrm_state_dev_gc_lock);
 			goto restart_gc;
 		}
-- 
2.44.0

