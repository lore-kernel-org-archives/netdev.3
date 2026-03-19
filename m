Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4036A022
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964104; cv=none; b=SuWkqVMkwiBMVc9Trjpcx2EGwafqnMESwhRHOqpAhtDPCZYYuJPGuP0qQZIXQzC8/+8vYxtpe3Ygs+S66G2RW27NB6CeFkZFtnfmGiaHBtzkll/3YVD9OFv84rNyBDjF2AngkBBSnkyFNbzawGU30oKKCwB2OEaItjjCwiWf56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964104; c=relaxed/simple;
	bh=lt7zr+CfjjEGCEm0i96jCuoUT6aZeVkhn7C7krD6lCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpO1jM+VV+n+B68T3zU9D9F3ngk6p3pd8hNwEdbvaYkG6LK0TmsoGVs9m0uOhaIUUIcH6YNRWK5T73P4GkptzmnatSHUOTZUppMM+etfP1ixZ1jP8XB3dp4oRur+cRr83rcrIu6CDLuWbZj4zs3QCayAbA/M8/tfmz4WQQtpGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XYap+2nx; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XYap+2nx"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-56b7e5dfd25so1659171e0c.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964102; x=1774568902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mIqXq2hZsAzom3D+tXGFGSO/Rz85EoquHdyxtgI908=;
        b=mdU1MADe16UkktZ4wGGf/kSZ3Puphe+RwIn2E4MzDqtbtTHvWX4XVHORYuMhFtzazm
         teOTpvbho3XVU2T/iBc7Ms9rgM6qc0QNBwPqugH5SxUpebsLuticCazjMYyLcPVg4g1g
         H9QW/t5dNPHsh6WodJBYOWFNmb+sjfCjxILChMoTld+1dwWuQaCU040z9b6uTcGBkVUz
         Emzu+Gz97eUlLW22LD/WdAPAY0iNqKGc5Ph6r6henciGi57fgoI8zHW5m6JwJ3V/Gagn
         QVFVELm+QSd7GX8zcmJEIDfYUsAD0K3+aOgznSGuG7ktQcPB9dLJCCWoPGXx8RhnhWOp
         azUw==
X-Gm-Message-State: AOJu0Yw/GNclP0ySC7NmVgweh0Qfbhb753dDUEpqriSRnIcqz4ti0WOu
	eYR3puQVQyzS+H5WiOZmNgz6BpjYVYT/Yt3+6VIpnFy0Vw52x7/Yl4SX8h4C2ivLSp7E1JsSU10
	Pk0QuMxyutV/Rb1DdP41AIptZ35xujPvK8Y3crRlhdwAC1GzVI+GKdN8KT/R2qC00wShFhiguuB
	JCDu9EgizfysmO7rd9OUZjmkKjTf8Yg8LnAhv3UXCGKSza1VaIuqJVAgow+2iIHvBRBEe2tljtI
	5KnvEoN1A==
X-Gm-Gg: ATEYQzxh/fWXVxNa8+TYuaxFYY7BXWsPxNOZPed5ydGjS50fI7OoCXL7NyxIITB1P7m
	iLcReM+BQj/hOxfVSaqSeMQTZcWLF8lK11IB/79/EPGyHwiN/+ktUvkNTPwTf8eX+/UTpB9Cdnc
	xgOTeXPIQIVUQYlNmbCqzIz6IdWe1EAmac0V0AoC7XI8y4neSVpoigPxRlYm1sHtbVTNJX4YoVp
	TxwMv3fWJNCo65nfk0nP+u793OVz/OD27xLnc+YPYRSNjxANcE7IZQMHLzPna3hP2zK54l9t/QO
	UL/jgDNJxsFjc3YDTL8tTWM8BujEQle2Sg4sTwSiI/Xj24+6VLXlymmaA9sKJgiUVV8oMhnWq57
	ksFsGOi7Gwk2VrB95xVifIJDADfwRgsGDDvbw2pgDjxbUP3+SnrcqfyIgLwNK3So5ADo03PLnT9
	GNGe/C9+T9ehL20AZ/hUNA/c/dm7ekxzCnaetIIiDXo5Zw99wPFmOtQcY=
X-Received: by 2002:a05:6102:e08:b0:5ff:ecd0:1d1f with SMTP id ada2fe7eead31-60295fbd13emr2866139137.19.1773964101696;
        Thu, 19 Mar 2026 16:48:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-95136b4c0d9sm30827241.1.2026.03.19.16.48.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 16:48:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bda35eab74so1005026eec.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773964100; x=1774568900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mIqXq2hZsAzom3D+tXGFGSO/Rz85EoquHdyxtgI908=;
        b=XYap+2nxqMiNoi6uTwKvVw0lxI3eX/lXR9/37rJOeW/CCdqaJtMEflt1VHWoBnRR7B
         BIYosC+ZG1aBsQlQq8jhD2tzQj+J8n5hOmu875fj0GJLKlcxbOMJA7sj3N5cmrBMRgXX
         Ha9DqZFan0qZa4T9bLocEwV6BY5YI84K86xS4=
X-Received: by 2002:a05:7301:4002:b0:2be:acac:af7f with SMTP id 5a478bee46e88-2c0f3b7339cmr2810576eec.7.1773964100099;
        Thu, 19 Mar 2026 16:48:20 -0700 (PDT)
X-Received: by 2002:a05:7301:4002:b0:2be:acac:af7f with SMTP id 5a478bee46e88-2c0f3b7339cmr2810552eec.7.1773964099385;
        Thu, 19 Mar 2026 16:48:19 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2d673asm1141697eec.24.2026.03.19.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 16:48:19 -0700 (PDT)
From: justin.chen@broadcom.com
To: netdev@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net v3 1/2] net: bcmasp: fix double free of WoL irq
Date: Thu, 19 Mar 2026 16:48:12 -0700
Message-Id: <20260319234813.1937315-2-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319234813.1937315-1-justin.chen@broadcom.com>
References: <20260319234813.1937315-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Justin Chen <justin.chen@broadcom.com>

We do not need to free wol_irq since it was instantiated with
devm_request_irq(). So devres will free for us.

Fixes: a2f0751206b0 ("net: bcmasp: Add support for WoL magic packet")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
v2
- Split into two patches.

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index aa6d8606849f..2034a1593db7 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1152,12 +1152,6 @@ void bcmasp_enable_wol(struct bcmasp_intf *intf, bool en)
 	}
 }
 
-static void bcmasp_wol_irq_destroy(struct bcmasp_priv *priv)
-{
-	if (priv->wol_irq > 0)
-		free_irq(priv->wol_irq, priv);
-}
-
 static void bcmasp_eee_fixup(struct bcmasp_intf *intf, bool en)
 {
 	u32 reg, phy_lpi_overwrite;
@@ -1363,7 +1357,6 @@ static int bcmasp_probe(struct platform_device *pdev)
 	return ret;
 
 err_cleanup:
-	bcmasp_wol_irq_destroy(priv);
 	bcmasp_remove_intfs(priv);
 
 	return ret;
@@ -1376,7 +1369,6 @@ static void bcmasp_remove(struct platform_device *pdev)
 	if (!priv)
 		return;
 
-	bcmasp_wol_irq_destroy(priv);
 	bcmasp_remove_intfs(priv);
 }
 
-- 
2.34.1

