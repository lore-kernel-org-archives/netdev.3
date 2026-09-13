Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273493C1D71
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281684; cv=none; b=dNWLHhV4V9NO0dQpasAjev+CGq62u2VOJYiXU66s6K4TTFQnU/z52derWCzep2eWbneemLdGIj9qz0+XqhaP+3ADm0qCDlCGmJd8of6x+/qt2cDYNtZub+TvdZYrgfwCsdTMfS90K9hyahb/oDfuuWX+7bx/M4hOXJwUo9uX/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281684; c=relaxed/simple;
	bh=2isl3eP2I9Ofhmo1cfW/hgvgC4igkB3in+RmAUkHUsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEGcPEpvfJjWZDWF/S8wBJO4eu2o4LzAnEpMnFgKcY60+3u4tJVFxxt3GMluScbfTuMaULVCwCff6DdRPIZH3kvKAseOo3ERgSFGbc29g18V1D035llQ3aBdtUQDC5qAT0QHO886s2NDUYE0OLqSsVJzt4wZlChlou3KSQxfHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR+H538B; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR+H538B"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so70731b3a.0
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789281680; x=1789886480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0suMaCXibllLZ+k/N5xA3Vj2voIiuPLg/g+cL0xmFY=;
        b=GR+H538BqwCfDO9qfWSW9TT/DOPKVAuZCJxBbctQclKCVpLHjf00j9F2/7mK6OmMM8
         pm4ALT18Tsw0yQYamL7WDuWFUN3Z0U820MUW0ACvHktbisRU1RlmkUJV+FJ5Ya9clnRJ
         X0zEVT/MvBCEXKj2lQULcDZa1g5u4wPLK9Rwh4BfbKFqixODgP3KJwaafvuR7qdnUYsl
         e5EtlsUsRlBvBOJllbrLUEjX2WwqTZAuMWaiUe+FGwx3lZo9wSpONKOvRbiTcrpsueuP
         ck4oN4EDhTWboH8HU0JAup7oIlqvTOT0GqPzatqkQ/qtk0Vp7GPDLafbCJvhdeJRA18U
         rRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789281680; x=1789886480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0suMaCXibllLZ+k/N5xA3Vj2voIiuPLg/g+cL0xmFY=;
        b=m8oXtMYH4iSGEhngPeJ0ADHGrPiKf7Pq7SSdwTIb2mbg1qnhqKj7rzovVK3RKhUPhS
         J8A7weYZ48FcPM9hPNb2ep96tJufvoqFX7rMFAh9RzQyjV8sV+p/R6inGXxRAhkdaK+9
         oFnVETLEzVU9Ky75a9N54QVI3pOf4JwvzjoeFhPblH+LyXqsz+IfPXrhFZx14V3NlWja
         Mz+u/ZO6b8kOr8VXhuo+tpKQL6YP10UZAU20iyAshyooVZhu0FwH4KjC/b6Vlk7pYyvm
         3RMNg/JUxeSEQupkiPfEtwDaVkEc7JlAkI32uu0Nnwa62/LVytCuuhlRB1smw/ES67AJ
         ICbA==
X-Gm-Message-State: AFuF++naxyx/tfDgECHdeGMZovi0P9/j2jeB6eY2pe95p9Z7F8D/AMtF
	EsVXfBAlvORlWJCAlYCmffCNSbyD/CqyTqq/43VMbI4+OCTsjSaRNHz1EKQBDTuJLQ==
X-Gm-Gg: AYBFou1khV2GugK1BD9L2YX8OZg+cQDjzqFhslyDiyFCkNkBIMj8rVRLO0VtCT4g8Ns
	W0z7p38mep4mP+9N9xoV89fwgmIZw/r1EPqnD3xOErH75ueVaDk6ioyiO087ixwoEmKzJjXqA3G
	JReZXnHMgDWflm+ssBhBLkHuoCJYwp36kZ0lCML2TVbHQ4xTa6h8FRtCHNUI1zj9cjDETO53V8P
	L95H7MB5zMcDG5MMKOK70XQpXFM8XU9s5QEgCCY8t/YEDCwak0yIWibdEVIxfTI9BWqu4fvSmPO
	JDS/XHT/iZkq8lCxd1yWMA8DL5XPABcZDk7osR/qIv0fsGq2jgetAZeEjy1i5ClmMluVWBU5xNx
	t5yrdPzc85MYW6XcJ4eYzTawEjnSmEhQCgPn1AkeNKAnRYG70k1cet44OhiGZBo6rZFL4L2PDs6
	nSpBk1oO9/nFMBSgeWWBJ9YULLQV5/maFZKAeb6hwRTH6QHSBbuy7fN0hUjss7bTh19YELD+Sxd
	mAVcoqPlOCFNJ9qLI7MDqyZ7d1J
X-Received: by 2002:a05:6a00:13a5:b0:857:72f8:dc94 with SMTP id d2e1a72fcca58-86ccb545129mr9955871b3a.21.1789281680275;
        Sat, 12 Sep 2026 23:41:20 -0700 (PDT)
Received: from localhost.localdomain ([218.212.26.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a5c052csm2989783b3a.58.2026.09.12.23.41.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 23:41:19 -0700 (PDT)
From: Yige Jiang <yigejiang86@gmail.com>
To: netdev@vger.kernel.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yige Jiang <yigejiang86@gmail.com>
Subject: [PATCH net-next] net: netsec: fix device_node reference leak on phy_np
Date: Sun, 13 Sep 2026 14:41:02 +0800
Message-ID: <20260913064102.37452-1-yigejiang86@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netsec_of_probe() takes a reference on the PHY device_node with
of_parse_phandle() and stores it in priv->phy_np, but the driver never
drops it.  One device_node reference is leaked per probe, on the success
path as well as on every error path reached after netsec_of_probe().

Neither consumer takes ownership.  of_mdio_parse_addr() is a static
inline taking a const struct device_node * that only reads the "reg"
property.  of_phy_connect() borrows as well: of_phy_get_and_connect() in
drivers/net/mdio/of_mdio.c brackets its own call with of_node_get() at
:364 and of_node_put() at :373, which would be a double put if
of_phy_connect() consumed the reference.

The node is still in use at netsec_netdev_open() time, where it is
passed to of_phy_connect(), so it has device lifetime.  Release it at
the probe error label, which every failure path after the acquire
funnels through, and in netsec_remove().  Both releases precede
free_netdev(), since priv is netdev_priv(ndev).  The ACPI probe path
leaves priv->phy_np NULL and of_node_put(NULL) is a no-op.

There is no end-user visible symptom on currently supported platforms:
a device_node is only freed once OF_DYNAMIC is enabled and the node has
been detached, so on a static device tree the imbalance is inert.  It is
observable as a refcount that grows across bind/unbind cycles, and would
matter under device tree overlays.

Found by static analysis of reference acquire/release pairing rather
than from a runtime report.  No reproducer was produced and the change
has not been runtime tested; it is compile-tested only (arm64,
CONFIG_SNI_NETSEC=m via COMPILE_TEST).

Fixes: 533dd11a12f6 ("net: socionext: Add Synquacer NetSec driver")
Assisted-by: LLM
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
 drivers/net/ethernet/socionext/netsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index d14a6584473c8..79a0a324c921d 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -2149,6 +2149,7 @@ static int netsec_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 free_ndev:
+	of_node_put(priv->phy_np);
 	free_netdev(ndev);
 	dev_err(&pdev->dev, "init failed\n");
 
@@ -2166,6 +2167,7 @@ static void netsec_remove(struct platform_device *pdev)
 	netif_napi_del(&priv->napi);
 
 	pm_runtime_disable(&pdev->dev);
+	of_node_put(priv->phy_np);
 	free_netdev(priv->ndev);
 }
 
-- 
2.50.1 (Apple Git-155)

