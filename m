Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AC33ADB9
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787483574; cv=none; b=oqmlnere4IVcBnc521WMsvgSbs8fahrFi15lykEwj4qxd/83/ABna5hi7BTQki7Zm8ujDM4qtBS0buHxnpKJCgw1Ki0HXlApp4/IBuhq1IVj/B5CpEUrUMMXHpqW1RJtZ5OShQ46Ta9Zvl57JOxRBL/J2KmGhVVjWhmZwEWYgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787483574; c=relaxed/simple;
	bh=Y8qA2gfoLT6dbN2KIQqj+OeRMyjgyrwqfZpOxE8/hbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=agJWxycjo8tPMzx/rmJgfu34wriKWvQeMfjTLGNHNDYLAA6t80Lp+RJKyXl4p9E1Db4mnvY+2welUAPC7EjBaMU0sgUvABuTODvnpL98NN9NaEku2zcNjvpHFxZiD8yfs+sFnNgKO3IIKoFwZ3+1d5/tSzxIS4i0zFcQam73St4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z21UIN0b; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z21UIN0b"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1938993a91.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787483573; x=1788088373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CN0bq2syvJ139+FXiDl4BcBzxfhMrGPXSp4/ghjML5E=;
        b=Z21UIN0bCtA/wUvkWr5/LiJ8UyKgjOYeC1/fY5cT85FW3vY/2AglHhPKmpthUoogOj
         08YQhq5fabetunVow5o0YOo5AqbLMV3Ph7hRtAfDEFUXD2oGfzUyvXevYz4QF0Kz7xuB
         +AcfawTR7/7wGwLcvyJ7jsoSkGaTKStEst1yuBgz5mWJYXvRVrJjTq3Nf0NbUOTlYRZa
         9kwcYnQgXDwP169jDnVGqogscpmWL9DHczS6o1BxEsyMSXUdojj7Lt3QfGjZRupdPSiA
         v61lyNjyfnD1u83qj5WL7+fzI8Xqm477zFWX5pOMsEa+/PsR/h6ErseJjl1DHUdXbFVm
         ARyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787483573; x=1788088373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CN0bq2syvJ139+FXiDl4BcBzxfhMrGPXSp4/ghjML5E=;
        b=ndy6krDOaaSKR2iyiFlmYysX+PKzR3PPuzrFnM3LVl+YhZlU1DizZnZIdjVxaCfQza
         GyyZChpD0w6pkUlrmOfQGjOa58ZriC0ntHBKLOdBftefOPCQAG7a4MNg+q8n3eiMzJvL
         /uqzMByPddV8uFxheIES8MAmzIgvdcse5X8NYTteEno5hcFpBcRj5OpkSdy2QGYsl7MG
         S7utJam2hfF+LYC3AxAdEpoZAMTcdXq4ZcBFvdjEE1C5o6XR7kpDER+yJyOl9G+tYHV6
         k6zrjFm3fcG3EF8JQ01+wFEBapk7RnUxiTkkQvtPYl1d0w5u0BfmdTzaxMxErBKgZQBj
         rPcA==
X-Forwarded-Encrypted: i=1; AHgh+RqJTe1b0jIb6OxUoycWr3Es2qGGbBZeZT3/pu3tHV5T2G00dHvkxdXU5cGgIecz4S1S2XOFMyU=@vger.kernel.org
X-Gm-Message-State: AFuF++kfDHUlSqwzFgj5U5OyZsKErSlGG5RqWlZwvZa+o2NcmpGgviiZ
	stJhdD4lGDmKaawZp0ges4Rg0D5xK1h8sgsPdX7yLZk0ocnYRrwNGokk
X-Gm-Gg: AR+sD13DukmPfv9Cse7P21Szd0BcKjf0VZp2CKTJLoPlRlwJvLEMx2P4hTbaaHzhfcY
	VuHKpBUrHuHeQLbvOytouFXpFcLyetnV4EHZlQqnDoU6Jj653h5+hMe7Wys6+GOqwKDiG9dOIeb
	UP3ZgUM6lo4bk+kB1sTxSVQ9v3WJOH4xeDv63j+V+gn+1DyWQEA/vgJqMSHOme7m4+Nc8jDcs4+
	e3vRmZZQA6Cu9IpElddyKr2v1g/obFa1+o4oQ8BTXGnU1oPhKLXA2+vSFv3ioySxFXDAN9SNhPU
	o04a/7rLyTDyhx4heIfWU/1jNWUHTb1Eav3pc8O6b2urRgY6TA2nZMKF2c7OM209XNl5buF/m0q
	O4Uq+tQKHNtDR/0F1w4xafvML2PJXEj4pnTmkdx+iYZUDzgF4Da1UYVuUs62oGVVLsmj+X9d5MA
	ADJ+/k6Ey/XembTB0lgf4uW1XRTcFalNVjFopU6dJxzlwQAB/x71mKn5MlcVHzkXh5VSg+0PkOF
	IqdEMBQEYQKUtnHmMCv6yYzTArnfP+5rG+P/3yUKaQz/ziKt1lwfO1O9RrF6pvPev/xMJG9x9N/
	KN96gfRnUGI=
X-Received: by 2002:a17:90b:1b42:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-395c3a06ffcmr30899372a91.12.1787483572595;
        Sun, 23 Aug 2026 04:12:52 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:a5e3:6c88:cdf4:5469:310])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418619d6ecsm14510633c88.14.2026.08.23.04.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 04:12:51 -0700 (PDT)
From: manushprajwal <manushprajwal555@gmail.com>
To: sgoutham@marvell.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] net: thunder_bgx: fix fwnode leak in bgx_init_of_phy()
Date: Sun, 23 Aug 2026 16:42:31 +0530
Message-ID: <20260823111231.372-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a child returned by device_for_each_child_node() is not backed by
a device_node, to_of_node() returns NULL and the loop is aborted with
a bare break, without releasing the reference on the current fwnode
that device_for_each_child_node() took. Call fwnode_handle_put()
before breaking out of the loop, mirroring the existing of_node_put()
call a few lines below for the "lmac == bgx->max_lmac" exit path.

Signed-off-by: manushprajwal <manushprajwal555@gmail.com>
---
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index b63039999..246eee327 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -1479,8 +1479,10 @@ static int bgx_init_of_phy(struct bgx *bgx)
 		 * cannot handle it, so exit the loop.
 		 */
 		node = to_of_node(fwn);
-		if (!node)
+		if (!node) {
+			fwnode_handle_put(fwn);
 			break;
+		}
 
 		of_get_mac_address(node, bgx->lmac[lmac].mac);
 
-- 
2.46.2.windows.1

