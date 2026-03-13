Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D53B19C5
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413486; cv=none; b=SVqtbgQ97UN7Gc/DNwagFrn1Xp8NBSb7epeqSZLZFxkidEKJCKZEp8mR9cLdVvBv021GR7bCxyBxLX9LaPACS4HhsK0ubQFNI3yqS/+RQxwLhCSmVSrcGh2a1qvOMCMUfs8MvfACEEdlGi8zDATJDXZbJj9BvjJlSSI0Pc9JKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413486; c=relaxed/simple;
	bh=5NcsxaHVIQ2NmCj9OLQh+nSLlXz0JVUjSv0mBYVb1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKLKCq50YWDqPyXJQUMv6dguZ98efVJYtSRriAL+XdwQBinpsFEc86wxA/z93tpjJQfaVYYXSOXzwJCBKd2hw7Oh0aJVhOO1GuaS9zOFxhubXj85ZgKbBJid4glAgPZpVGeYf8x3OBgq6KjQGllCuFY48X9B+ofPO3g7qW9i3lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3457425eec.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 07:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773413484; x=1774018284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
        b=CecMR82L6o6erWqcMF1ivy+oDuWe+Y+kmL+8wSr6SCHweroB+WNYNaAR+rOD+mpHLJ
         H8MMPR1UwJPihasZSyZPJzyyIt0EwdYz+ZOCGDKMi0AKtTGWeSvh12Ni/zLE/wftiQzP
         2TatIS0kiy/m6qo7nxNmTPx06bklo4I1eFidEKw9PiBO3eP7YhMgg1xmqUgr672sVJkY
         q8qro3ff/WmbiZJQHEy5jKeIb1HH8j9SmLq8jeshgP7b8q9lDHg5YFVxtY56MU5fxAxW
         a/N8GQ9TEnBy4zCvxzlDRbuR5SRdvT+d5N4v0tPPO7PpN+kI9dpTIrzIIMjVqYK8wyCj
         SWzw==
X-Gm-Message-State: AOJu0Yx92yYGgZvR3otTdEbwsyj0JFyr5J5WKqjsvsXmFQvLL0Yla+g9
	qXiAb8NE4GiEm7DfV+BhvZdxuJtRYrBlWtMgdmZK1cVu9Tl+dbZZGt3znPeF
X-Gm-Gg: ATEYQzz4md+MKggQIktDsp4gvRlFQeJ+3BCzjWj7aeQCRC3FrvKq2EvP6d0OV/4wQuH
	XBY+3xEaJQMQcJAuoW6DN+dKFeTGBH9FYeagqmsbWnHIsO1zIcvvFK0l1uybi34euiz0SlM3Maw
	LhoCK2Qd0my132EtnB3yHtenm/yWYJ4K29DkemDAnctVlhnM/8RYAKglvcLT7ieJreK8Rr21s/b
	00/IqHMKT2EwaYMdmJFYsA9aStYZR7dPgv9mIsGHJlCjLO612TYsDwlx9y1bJvoNQzNvg/WTGe6
	XR11rndYqXEsVPq86FzkLLIKJnSdUXpQhzPJhjcAfxQwj/48wWJX4Jvn2JSs5GD9ho/fc5Fti0r
	yfo6RamUA9IzShyoBaWiOlHv4blHxGMATLT5qxe7KNhqgIyFTo29t/qesrQIPnkParzwoaVdnyt
	xXzAIrcHgehC3Gcvh+bIjyRlOWgS56I33mV7Ao8/y1OVpCh7BAmaz1Awrq/OJBz1KVHuglg2Jj9
	j0HpM6fdA4sOY4V2w==
X-Received: by 2002:a05:693c:3618:b0:2bd:b7b8:c361 with SMTP id 5a478bee46e88-2bea573ff32mr1445548eec.35.1773413484072;
        Fri, 13 Mar 2026 07:51:24 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab57588asm2923213eec.31.2026.03.13.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:51:23 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 09/11] dummy: convert to ndo_set_rx_mode_async
Date: Fri, 13 Mar 2026 07:51:11 -0700
Message-ID: <20260313145113.1424442-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313145113.1424442-1-sdf@fomichev.me>
References: <20260313145113.1424442-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d6bdad4baadd..f8a4eb365c3d 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,7 +47,9 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_set_rx_mode_async	= set_multicast_list,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
-- 
2.53.0

