Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F1395276
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789527628; cv=none; b=VFgQhbjTzwveyxF3JhfkwqMOCboFl+OzstrNhP5PsE/nn0xHjPWg5NELq1Y34v8+87tfZZdQDJACfbc0JwEyviAYLzhrjO6RH97Woh0HB3yoRicObVwzA6mVqrYLHtxWBAFwc3KlSMOKwHQ96lYU8f1QGmHYoP7NbC5L+cPZGME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789527628; c=relaxed/simple;
	bh=RmS+xdgWocibZMZYCA84W4qaV1yXYkVlLzdVkYyMD5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kvPyO9GxNAetwHfChRNmKnFMArLWHI2z6Bugaye6tSNXKNwYMZHt74Tg+roG/jX0xWjWS5fyquv0nyJW2iuznfMbpTyx2jrcUjgRc5rp9xmO7NDOG3CgMO6+MObnVcTJ+QJ43cY0G8/jsUz8ayz/+MLMNAuQ94HHX8S4efeN7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRO2IsBn; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRO2IsBn"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso388927a91.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789527626; x=1790132426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jVvxgQIw7AeCLmLEQiDzAuJvlTjekJJ3lxgJZwxjO7I=;
        b=FRO2IsBn7A5sw6+At3iy+Hv7iM5Q4dItUOzD5FevIWXH8KmHuHGdQYHMV7GQqvw3DO
         ox2z1ZWb7RptCWNdtp8A5pwufxwYaXiRuJgTRXL92CXSgzwne4nJQsFZDPhhYtGhXIRo
         gde1t+ip/ntDSFyB6zfqyoO2lAX52ee0X/2TsKywty9vDPYjbke7tUk6J5od2AMQwCs1
         grTjra0u+oqLEYU4tCyVeGZP8L1axqBWuuoft1h+4o553wUfkmIcnIp0QjWGaTOE6GRU
         WSWDlbypD/k7O/eozwyePZ401UmR3ek5TPhQEuZjWVaAmrjeRFOoia4FLyxpXZbEXlkw
         IZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789527626; x=1790132426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jVvxgQIw7AeCLmLEQiDzAuJvlTjekJJ3lxgJZwxjO7I=;
        b=kS2zJK15yXEZgiKmfK7zy689v0oalf6TPtMuXEp2E0yQmHpX8ZPz0JNkZxq67ToQH5
         VvwoDSNWvCtwIuaZwEde23oultOxQtEg1hysqQ3RosyOSaijWr4LIVn/tnIi67oT7PwN
         nO+KEctq8X+436hfpIySkSVvV0KGVlqk+cXXRI+E86a2hSDrhg9hj3WISQ2lhHDptp0w
         VnNg7LbOBSxChDOe0/xCJexVSpJTaESz5jWjDLqOxFJkwmSxj0W9TTg4Zjx/TpOnEz2N
         WR9/PdwmqtXK0lioBP4myxqWj/7XwisE9MFO3QJxn+F02N9K2Jem5vA23JQjJX8HNMU1
         2D4w==
X-Forwarded-Encrypted: i=1; AKwUvBzw7/+ktLDjg5s5NIdIO7ZfzAUfVwunJC0m8EXSEe9BzPnwX0yGFNEtqx1i5l2vF9WaciTjs9U=@vger.kernel.org
X-Gm-Message-State: AFuF++lG1LnO8KSYr4NDuiiEn0Rul3/1ZQ+I6SsebVlaaKdOmQtVKDPE
	xMZCG0Ldj5Jb5GX5nip6zUQ3FXBzi37rcgC6hSudOFUza9NTdR68QO4r
X-Gm-Gg: AYBFou2Fd6fd8mj/9ra9I71J1Ax6nHFgul+uLfBrlAr5uAyhNVMslVYeVoxqsWUMiOa
	AOE/zG6giF4H2udIdOV2f0iCp3YUMxic0F1CWc/BJd73Ds/TOWyb4QLaS9n4MbEK9d7FOqAHVs3
	RqDzFrpkXxHaudrfoRRrqxLU6AeG9igPtSoBvzSokaBebcocR+R4Ioy80ZGUP/R78KcUHYSzu7t
	wvsnMgBU2gvz44v8XILAIF+ISppQk12p7h43YrgV7uYnxMi53iSDU/w4U45gIPqQetC7ULbUKg4
	hY2J878ym4Y7Gdcu5q07Apc5gbiN40ggXHFsp6kEafqDMEDISkqoF9KtbMBzWXNmt6+4BNEzB1j
	NIWXy08IY8L+TuRTBAgM2+ym4bl45lrAYdsUF9EFDJyuaZhDbui+ANgUysjdj1Pv8kEKjy0nnAg
	tdqZAa8HDySuYTK/l654TmA9x8ZNiHeZQptwEvqP4qmg5gN6Q6QRM03A==
X-Received: by 2002:a17:90b:4fcf:b0:398:b1eb:136c with SMTP id 98e67ed59e1d1-39e1e2f3dedmr2184461a91.9.1789527625769;
        Tue, 15 Sep 2026 20:00:25 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395caccf1sm2428257c88.2.2026.09.15.20.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:00:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yangbo Lu <yangbo.lu@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: dpaa2: ptp: fix device node reference leak on remove
Date: Wed, 16 Sep 2026 11:00:15 +0800
Message-ID: <20260916030015.2818545-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpaa2_ptp_probe() gets a referenced device node with
of_find_compatible_node() and stores it in dev->of_node.

The probe failure paths release this reference with of_node_put().
However, after a successful probe, dpaa2_ptp_remove() tears down the
PTP and MC resources without dropping the device node reference.

Release dev->of_node during driver removal and clear the pointer after
dropping the reference.

This issue was found by manual code inspection.

Fixes: d346c9e86d86 ("dpaa2-ptp: reuse ptp_qoriq driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index 4497e3c0456d..440319a1e775 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -232,6 +232,8 @@ static void dpaa2_ptp_remove(struct fsl_mc_device *mc_dev)
 	fsl_mc_free_irqs(mc_dev);
 	dprtc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
 	fsl_mc_portal_free(mc_dev->mc_io);
+	of_node_put(dev->of_node);
+	dev->of_node = NULL;
 }
 
 static const struct fsl_mc_device_id dpaa2_ptp_match_id_table[] = {
-- 
2.43.0

