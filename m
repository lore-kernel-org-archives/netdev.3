Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A548261B8D
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787793883; cv=none; b=WLAZWw4NBoajWohrvu1Iqv4GesMl+4EC+IwD4dZ7Y/xO8RUpwPXG4qHiIT7kyYkb840RU4fCwu2KsOK9wrW25BZHE1t8PHGbO3OTpPm1Radq/4Nuqwetf98XzBrDxhG3yKcT4IKn1oomlz0r9FLVg+X88cBHwHfBAC6b0RMz0MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787793883; c=relaxed/simple;
	bh=0rceLiqa+9MdS1lvoOTqHr6/JulnOpNwXLbxC8p5UsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCtaTTUweDKJF7TfmqUOeVeW9XAhb5p8C4aqIZsXn7NURuHhXxLVwbKST7Ypxrin3Mqh+hrn/9edfS5JBiEVS0XPtp91ld3AWGsUSm94G14M5yHj9FhmwU8xD8l5VKp8P5ixan7cAby22MmbnFnGV2mo4G82XOMHCMcwhkOIMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5p1YJJE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5p1YJJE"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso156225a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787793882; x=1788398682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/+j8GRAZA/QZODmB/777GdoiTUk16s/0lLReDxBEmI=;
        b=p5p1YJJErrCheOn13hLUTSB9QDd52qKJyRUBrZXOIfYFK8LuJS3Gcnwz2u5LbU0DVU
         g3bO7apqSObQGtyBOJzxkVDzdm/Y3LmVQ5qcKYtWuuL+WN2r+Hw3qZxiK1KoPEZ7P5zs
         QKlDRyR9hLZGvHFCe8bTfvnrMtswLTFpKcuovIgOC+TjwDgQwg0kC4eLL39iHKED93R8
         9JxsIOFf7sk4SY5Nwf+pqm9V6SkhUSn6LIc2hj+Ab245fd92kmeJ7UtaPFVZNIh/UgCQ
         fxnDsh/oFpqAx4c3fqLkjlIW3RvzUyZl6DVLrHmVGrE0amuByb6u71pv6hcqlnOpbJuk
         ljOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787793882; x=1788398682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/+j8GRAZA/QZODmB/777GdoiTUk16s/0lLReDxBEmI=;
        b=oSpIkWtM9Fh1WyCEbZaTaYEK5w3bYus0Ar1MJ4TGblGxPSaF9cnd+rG3Kw2bKkrTg7
         Dnbb40XkRNzLNK1+N4ffX1jhy9gR2viSp0uI5INutJK7u7BAjhtATth0+h8XGonK8Wjq
         DIoZ/h8XI6MbJE0aQt699kBw1iIkId8rEJ6was35xvmnuP7AATWj04TL/dgeuURuyWpN
         zE61eZApUmphNpLn/Lg9qZ3QfHrHnMXmP/BQMR/xqK0XwbkS6Ox2RwhjRx6i8p4U5aUv
         qjfwVCv0ihiSp5puzZUOn97BnBvL7eyahVhSynLt0bnZ5rBJZY4N5xS8HAUOa6zM6BN5
         oNHQ==
X-Gm-Message-State: AFuF++m89XOnYYA2bHXhgGf2tWotN9IPusO/LnOrEIF5e+wRwR5OoUOy
	Ahj6AhrDzWB8mkh79yrTCXuryujc/t8Y8wKH+wy1aW2KtrCPnYBc1hxEFcFfVA==
X-Gm-Gg: AR+sD11xYMZOJRw3qByjv8JK7YNYw7Pj5G00kZc4OAfOwc4fcD1Erv8KLtlR/121njG
	OerhQdJbvNDx6gRuvWBmHcucGU7hxSi5++HAl5ZGz0vJbjm62jatfDbnSPtgHXCvnbtAhTeWHPf
	K3uY00Xvfkc31VYvuzSsaJfUCMas3fxL0v3Dt0WneM/h8bALEW2Tk20AKCj0XNx2lo4b4UYw1lZ
	9r7vdyodRpdTn6+UHsSb3925uqt+e58dp8KMdB9LDfz8yV1RHwA934NBiHfvh3dpKO7SZ6c0Baq
	kBjmmwSBkH0MWyiVrGy+AV3cbSwHHr/9rRkwu4vYpuEsyusSFSjDjMK/+OtFDtSzIJMGimaRM6S
	s0Dus27fgunLy3Gr14mrkO+wEp6fLwXeY0m4+sQ+rplC197RVpa8WZbdfPSLOXGzOQsFcty/TDs
	2JMKIbYE5ozHrL4MAOpx1QxExH6GM0L86nTVUGySc5v6zLI+7hNqcACEMIH32C+GI4tT1Lq8wu3
	O7B665sjK9hb7IQHvDbnYuDDvRkgq7sIfeWMGZ5hg0SX5r9tMW0jChNW6GZu6oC5ANNBUik2/xN
	DDKY/fpdpiSPlEyzFsdR+2vwHL6JBrx6zR4EEQ==
X-Received: by 2002:a17:90b:1649:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-3966d3fe36bmr22244416a91.2.1787793881655;
        Wed, 26 Aug 2026 18:24:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-328593b6b7csm1321890eec.19.2026.08.26.18.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:24:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Esben Haabendal <esben@geanix.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ll_temac: Return actual error from of_get_mac_address()
Date: Wed, 26 Aug 2026 18:24:39 -0700
Message-ID: <20260827012439.162651-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When of_get_mac_address() fails, return the actual error code (rc)
instead of the hardcoded -ENODEV. This preserves the original error
information, which may be more specific (e.g., -EINVAL, -EPROBE_DEFER)
and helps callers handle the failure appropriately.

Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 711ed9c2631b..81ec73e6e4c1 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1581,7 +1581,7 @@ static int temac_probe(struct platform_device *pdev)
 		rc = of_get_mac_address(temac_np, addr);
 		if (rc) {
 			dev_err(&pdev->dev, "could not find MAC address\n");
-			return -ENODEV;
+			return rc;
 		}
 		temac_init_mac_address(ndev, addr);
 	} else if (pdata) {
-- 
2.55.0

