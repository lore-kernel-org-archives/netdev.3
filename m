Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732504963C3
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734283; cv=none; b=oRXv3GhAdZq6+YuN80gFQDhQSi9+yJKSQ/O2Ns22GLyVBRDfD5fK6gsde90UFc5edk993Chw5XBAJi8ZCLli0bPUU3hMgrvw7EghTtNf3F7eXUMB/pvYa6R0z0o5zv2uNl7Vy0KrSfIyylxv7KK0PS9Db/UtxouoHqSG1VfJLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734283; c=relaxed/simple;
	bh=Pw0NZaYpiHcJ6LnUczkxjh53XdpFkgJeSJbVi1h9dsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYib13csPOsr5UAindb18w7BbG/dD+YVbMdxqLErGQldNEIMJsEBMGkWVc24FN9vOGNKZtWS1lYPbOAqj2q4uEm16d+eDlH8GwfHyNNFlm/bZfZzB+Ql8JT7Bq0i1ZYMCwWpfNbgL3VpdiDmckPcKcy+KI4osCwD47CMbhDDzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goHqpxBt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goHqpxBt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1924202a91.2
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734282; x=1787339082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WKJuMY/9Z2qQ1nJiebk6zH8BqGVpVFHJzd3jEHA9B+4=;
        b=goHqpxBtML0Hd5R/s3QPhKzDLtTfWQGXxtEDCwRmoUzZq8yZ1/sK6OMkizPM0yVvYA
         fRACJiPV80hTDTfEShUgccW8DAg5zadLHujwfwSw9XeXkgagpuVUe8a1gS6i9fnueEhn
         SfaGlfPhrp0CYGi+lePlSJN3/fJFgW+Do712cY8ZYCbyAAvH49CJJFB6nPhhGQK26mzq
         EFPOp3YjaF5AhU4pzuTqQIf4dm0SpB8jFYcEeyse22H7EpAlANqDS32LDDzDkVeRnpWa
         +QeyJ9VY1Bx6AKbXzJxCoFvR12G+En7xTSs1pfD+ikh7riUXIHJvIO48G+LrpVvgR4za
         ONQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734282; x=1787339082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WKJuMY/9Z2qQ1nJiebk6zH8BqGVpVFHJzd3jEHA9B+4=;
        b=oTKan2+gM0VZBOJ6ij1eKLLIX4Ag/2j4Kx32gfyERFw7wTVXmGOEbxVyXQnEbM8DSf
         hJZyaI0FCknLM2fAx6OLlwNMv8uqW6ztkkcBDjXLa4htQX0bR45VRwOWKFAVQ0eQqEGo
         IDT06gLGanK4/tGWkijDYqO0F0jjFg4TcQh+1mdN6dtJUF256Ex9C4K/LtJ0rgyhvX/H
         98kuPggjrJU7errGgVX9dkMgCeQvoUeYHN7G386n5ueDc4nGAW6MhfqlcqexJizyr1UG
         taV/Mvn27Mcf0Y7VmSr/qyDWvBuWYajOFEYZzj6VY77EyTzBjfH3dQyjlbRvRbkShMky
         jCkg==
X-Forwarded-Encrypted: i=1; AHgh+RpDkRIeXfmGARpY7dE6YoRP2Z6qUk6hIzzLVVEWibMBSI/rsXXhydzAL0yRSV75Hblg8TsKNcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFmOdIf5b8TlFeC6S/cpgE3tmTAI7xX6TctrkBoxdSIvDU7Yfr
	lVbiGukwJB9BuCKbAQaBpNNnPSb6JWHCr5VV2/Jh8XuvXTSTZFjvK7lh9iux5L/lnqg=
X-Gm-Gg: AR+sD13PpmLFF80e4sG0Aa9UXJllkAAbrVdbG5c1A7bJKqkHLywc+BbK8SVAUK4siB4
	WEHofs95sR35bK+HcLhQk8/5TxUHnkiLRDxKVsO3RTMTa03AlKuyQ/RyvmFY1OcAEf8D3M86LLh
	S5OT5CeUQCsRtSz/3XY2/Exm875HOUKJQbLEq/n9dHZ26Nrv+vWT6JPWRJkZdwCVQWX5FHkpweO
	5XK5tc+9hrt6O1tlafJ6T8EyHMr0Z0XTS06Si1xW8DP3CGVgZVU7tghrQyf7OM7yg4hVhkTRAaY
	bxxqPZd4XzSRVI3CvlHXXkNvHkoNfwSu94vv6obcknpz3YMO2YaoZ/UmrgY2dH4eTB89FnAK9Ly
	FegMIzMZIQbRYD2cTxnvqRafhbGNI7tQc2I4ZbLQxMjN1+UA5Aw3Cxz7niYad8L2Puq8HDhF//8
	fXUmX9g3ixtjxqEYxBmDtx8NcKQEPrGU0/JYNgTkEa1w065/YcA4eBrxlYOQNe7bz54oIUY2lvn
	NgLX4jQVvepfNIZsws7yBsL3ovdBHRHKxqkJVZNami3rGlDzd1Mfd7Yf0mBE1mLwd6LI+e13QMM
	6z51hYCG07yw
X-Received: by 2002:a17:90b:2b8e:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-3933b8aa611mr9883133a91.15.1786734281764;
        Fri, 14 Aug 2026 12:04:41 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141388b2554sm16952785c88.14.2026.08.14.12.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:04:41 -0700 (PDT)
From: manushprajwal <manushprajwal555@gmail.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH v2] net: ethernet: renesas: rswitch: fix device_node refcount leak in rswitch_get_port_node()
Date: Sat, 15 Aug 2026 00:34:23 +0530
Message-ID: <20260814190423.933-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manush Prajwal <manushprajwal555@gmail.com>

On an of_property_read_u32() failure, rswitch_get_port_node() set port
to NULL and jumped to the out label before releasing the reference the
for_each_available_child_of_node() iterator was holding on it. Once
port was overwritten with NULL, that reference could never be
released since out: only put "ports", the parent node.

Rework the function around for_each_available_child_of_node_scoped()
instead of adding a manual of_node_put(), so the iterator's reference
is dropped automatically on every exit path. Since port is the
function's return value, take an explicit reference with of_node_get()
on the match before breaking out of the loop.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
v2: Rework using for_each_available_child_of_node_scoped() instead of
    a manual of_node_put(), per Andrew Lunn's review.

 drivers/net/ethernet/renesas/rswitch_main.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 6fe9648163..ffdc42f430 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -1303,8 +1303,8 @@
 /* Call of_node_put(port) after done */
 static struct device_node *rswitch_get_port_node(struct rswitch_device *rdev)
 {
-	struct device_node *ports, *port;
-	int err = 0;
+	struct device_node *ports;
+	struct device_node *port = NULL;
 	u32 index;

 	ports = of_get_child_by_name(rdev->ndev->dev.parent->of_node,
@@ -1312,17 +1312,15 @@ static struct device_node *rswitch_get_port_node(struct rswitch_device *rdev)
 	if (!ports)
 		return NULL;

-	for_each_available_child_of_node(ports, port) {
-		err = of_property_read_u32(port, "reg", &index);
-		if (err < 0) {
-			port = NULL;
-			goto out;
-		}
-		if (index == rdev->etha->index)
+	for_each_available_child_of_node_scoped(ports, child) {
+		if (of_property_read_u32(child, "reg", &index))
+			break;
+		if (index == rdev->etha->index) {
+			port = of_node_get(child);
 			break;
+		}
 	}

-out:
 	of_node_put(ports);

 	return port;
--
2.46.2.windows.1
