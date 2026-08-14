Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC00499F25
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734315; cv=none; b=obfT30QO7uPeq3+HzMdDXjLzFKnklP4fXnGT7nNKfwrlE/JOOLlOLgCxsbWBD/STpFaRRZfC0Ju9TyxxmSPgXDgi1BPdp2rLQHGzNgLvjTx4WP8IcR6QdJwgUfDK38Hp6/jXN1GOOXj2sB8XHDBnZjCCOw7LWrzo3XIWyprGuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734315; c=relaxed/simple;
	bh=Spi2g/l0DU/TSnpuoBVEEPWOagbDP7E/EPAUx/28EZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgydHdSg1fPgIAMpoALz7U+3oajsdjYKNrQXcYkEtF/v8haFTBSxY4YHOODxE1zhv703FWfUFKHp+ns8RkWnQtNUlI8FSJxuGgvrVngn5pvssiW74wtwjRiQi9Z0u3QXxrfrlRe3iQ01cLP7UX4KMtGClkwhRnnIPNHDcVfDTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll4Csaog; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll4Csaog"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so17962575ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734311; x=1787339111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iZoyd9mh6KPY8EIdjDmfp31I8TVRdh5hFcpdrgccT18=;
        b=Ll4CsaogYxYOdvR61KBSOCOESag9WuHq66msJqKqC5cQLp7i1OPQepWy4df+dLJSD2
         XJXpuh5FeMZlhQxIOZdR6QDj21UPTeNXSsuqcA/qdSiFN5zfb5EU/UDGtn6sd/2r423h
         UIxbG3KemNXRtOi1hZfmemTnY91x/2UEeEU+HDRiSTMvInWktTYcU1FpIowtjrjpm/Jv
         VDVevLry2vsvTIf8MB4vLldfCId2a68SzXNZIy7B4u54meOxDvZyBMbAm++Qeznsz5X0
         lDMyx0khgJ3UxyoWpYsHuAEoFYDRjOHEO6Z4VPCn9wsPllEyattymmXQolnHt8Jk+lKh
         qgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734311; x=1787339111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZoyd9mh6KPY8EIdjDmfp31I8TVRdh5hFcpdrgccT18=;
        b=C97IM5WZ/RgF+vraFRjxOo337xHIaM4erZdYLg40PASkPzR/ONSs/bb41jPaT0PSI0
         BwONKnuuV9zEEpW7x7dr9EcTX1ZEOVVS3Kk62ZHIvZQAIGQdk/XJX2nTLfK0dPu1moP3
         /4oj9Jhxvynca6UIpGEJr5I6IJSQ4kPe4T7ovBhc2BDhNfP5y08qUB+6TZHKk6vC8uP1
         6jCP7PyDS81hh482+przmHR9XpiydCkOytun45u4wK3UqiGF9W4MGZK/F5ChRT7lUs9k
         L7hUxcq16wa5r4bVorORBLj0UIyReiOgbbW8SieD2yY2Aovl7StjoG/5Sd4r3ke72zGj
         Krpg==
X-Forwarded-Encrypted: i=1; AHgh+RovfB0YzCAjiqWi3UJO2uXNz0MT7OMZfvCWnNXkRNB02LelkilaPpeCFOkHtKhsxv49FxE5I0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnD6NHoEH2WjdN9tHxRQU5CMEx108ij9Y+7dYmVnm8rOiLUyGD
	SP0fuaydqmlF6ZulMm/cAal3G4O3fIl5EXxZWtQkropLiY9SLRVMvqsE
X-Gm-Gg: AR+sD12RazIJW646KBnzpn7wLz0NcSxFhbclLBRXmVOAZdYf24OwHu7PRJA2p9nqUVl
	hYbJ8h0sH8QhwlzysBOd/j7woedOJCxwFFWsYnVRXrpgzYloVt5d/vZA2Go1Qjrrtj2Et8bPV+Y
	hDI39xG+GkHXL6WBj5LYnxQLGwKWJtVQB4f/I7w7Kjb44CLJNmdFJ+ycmZl4WRJcaHzrX1vzPaT
	7uNGhOWJv9nI/pFwkML4CkDVLN0q1NZqLHncp6z7ICUscr9bi15rqaq08RaefBytMXrQAs70JsE
	JUn5arSLzE4jw0Sjba/af1gfqPICG78jlINijsw5pItnbCX2lE9CT1lxPHr5HsUn2/7ZZI0ATbh
	yBVypgHeZYh2k/vVLoR/KO9tD3ha20ZE7efn2xayXMrUj1nJKlUd4IEokhcMuIJ3NuYeNvBtRHD
	TPWB/ShWZLXgeJJuYc4Ooxul403hfQclHyo97nd9Qpeyh32C19g5TuWDWNg5i/s20/MB0DkQkXN
	lKO5cH2Dx/L488FuU8FFq+VNFOjKTy/gB1hTVCH53q26JrsPsoPpxqwyGqeR7tvYPGhjsQw7xZ6
	Sg==
X-Received: by 2002:a17:90b:134c:b0:38d:ef48:b04 with SMTP id 98e67ed59e1d1-3933b8721a1mr9084957a91.10.1786734311281;
        Fri, 14 Aug 2026 12:05:11 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320e9df68ccsm7349275eec.14.2026.08.14.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:05:10 -0700 (PDT)
From: manushprajwal <manushprajwal555@gmail.com>
To: davem@davemloft.net
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH v2] net: ethernet: ti: netcp_core: fix device_node refcount leak in netcp_probe()
Date: Sat, 15 Aug 2026 00:34:53 +0530
Message-ID: <20260814190453.951-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manush Prajwal <manushprajwal555@gmail.com>

When netcp_create_interface() failed for a given child node,
netcp_probe() jumped to probe_quit_interface, which released the
"interfaces" parent node but never the "child" node that the
for_each_available_child_of_node() loop was iterating on.

Rework the loop around for_each_available_child_of_node_scoped()
instead of adding a manual of_node_put(). child is only read inside
the loop body and is never used after it, so the scoped macro's
automatic cleanup on the goto is sufficient on its own.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
v2: Rework using for_each_available_child_of_node_scoped() instead of
    a manual of_node_put(), per Andrew Lunn's review.

 drivers/net/ethernet/ti/netcp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index eb8fc2ed05..a888aa35fa 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2204,7 +2204,7 @@ static int netcp_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct netcp_intf *netcp_intf, *netcp_tmp;
-	struct device_node *child, *interfaces;
+	struct device_node *interfaces;
 	struct netcp_device *netcp_device;
 	struct device *dev = &pdev->dev;
 	struct netcp_module *module;
@@ -2246,7 +2246,7 @@ static int netcp_probe(struct platform_device *pdev)
 		goto probe_quit;
 	}

-	for_each_available_child_of_node(interfaces, child) {
+	for_each_available_child_of_node_scoped(interfaces, child) {
 		ret = netcp_create_interface(netcp_device, child);
 		if (ret) {
 			dev_err(dev, "could not create interface(%pOFn)\n",
--
2.46.2.windows.1
