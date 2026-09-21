Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98E4A0EF0
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008109; cv=none; b=ZZIe20JXNCW8ECxD2ODsNB/PkNjVAPiLSU6CMqtcpKB/KO3EX6RXzr0RMfHyo6XC+fSxIJ1T7FCKwdzlS8RXgbbDFHEWN53BTTdtbXs1b99MaA7QhfQmWcJdHLA9VO0z5nxPeQbRqRivdUm+kNtl5cYzh0VPeSXYaiz4dcQbrF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008109; c=relaxed/simple;
	bh=DGE+z+HMVw7Wm3wbAO5Hf5vNf6MorJIqbNSE7J81iJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkXGoO10UXQxk3lQsgqntKMEC/o/5/vqMqvGcmj/3/AJgfDCrw57/9EXrX5m6hDaRF4Bs/K5cCB3Qyz4ap2RX/7A9VPMl6Szpc4/LBRjvY4EKZKEfif0+hCtkVKCHU10/1aTPL9m3QhSmwbzdJJvkCaKcw+x8zyJVXYv2EXET7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6OyKLSi; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6OyKLSi"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so13811415e9.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790008106; x=1790612906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ynQgnyM8Zt60ziQeHCgB9enVL6BTbb917dDtvs4z3LU=;
        b=b6OyKLSi3lAP8R1KH2jMK3fV5+atp54s0u8C2Y7/4VYyeQRPVQ6w7WVzrteel8aLjB
         143qIE0FBN2oKnmHEXt9lSPk7v8bglW2n8Z8E7LvNcoOgGTH1UCTZFZ/Xp+pkq+gk96X
         Rl0eBzc6qXOu+4KH62GUS/UzeMNa42diqeEwSFO9vZghFiI6zgbgXRMgKyXbv+jkykvp
         n4JVtLjJvt2UXmuWkNZuaQjPXW7/Lch3okSWwkp53hpGk5fzr15CmhbTdmtLjrB8gx38
         Vsue4L+FGPc79XuRHO5Xn3EjraVXWcVQnPhfnozjcT9ofrZtcK6pR/Cm2UD+z8/UFmWB
         Av6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008106; x=1790612906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ynQgnyM8Zt60ziQeHCgB9enVL6BTbb917dDtvs4z3LU=;
        b=e5eznmurl0C7wYwefAazbK8hpCtbl+WJTZAqaZLM5KGKk5ZQK8ao16mHZAf9hCwZAY
         nJX0qvywzkOrHmqe7Jo2aDINq0YobEQdY5uVT4r8AkRQHz7Srp3AueNlUblJOPgRQPwq
         LsUZtCsiKco4NYXGrDwsUsOnpwpMQIEM7U/djFZYzvt3CKdavGU12dDxZ8K5ocD4xGJL
         Z66n2RAeehyIyZcf/BqHNVTGRXrELNsdaYZIEYzA29HAWKRZhW4SQzyO/ti4Tg1B1x6f
         qM9IzH/FGQVT7S83UbNS0Hfagbtcg6bENB78mcjWSaLdRJDtr7RiGZhvuhtdUNpZ1sH/
         KTww==
X-Gm-Message-State: AFuF++nUczd5HGBeARkzAHNPBZvxRPHoxm6GY8bGoormbmw25SaDmjEF
	FN50RFyUYCBTa9br6pSMBSZWz9VM/XAy+A/qcKfe7Ii9ntn3ofLC6aQw9+G6vA==
X-Gm-Gg: AYBFou2RVtx2rxomaxEBedTPnNRU9mgMkoLl/bplewZ4EE8SNmfC//fV9VF2R5taBr3
	OABXgmmoL68lwsng9jo/vCj+QzUgcLpDAY6G9oMb0dPSRDTn641ptqjx49sHFyM2ONFsaJrvROZ
	bDiEFaiZR0hr33pKxZDwSxa3g1htBkbLSfAYiHbFH6VqlspqM3232dJh2tlcuCSNO040PHDjMQB
	3UIHcSRxFbMSQc3/SmOKVmfmcz8Me6u8biPreacKwcpWdjrVjQRu4jz23NIh4jxfCexYQXDDBav
	UU2b4GFufHGWBH8EC6ofbk1k93jpWo4ivix9cUyQRNnK8EArsS/nT9ThN30R4Zy9U4DZAW8uNdd
	xQdx9DXBp/mZOzkF0U5dNu0TJpa276Vs955Vib0iQZn6PKpCDb8+K65mScvY/ewaAu3d8a6Kp11
	bbTGILTSi9Lf/yvaE4LilVVl7lm6CpeQY1DbJV0Is7LNLL8T8vb6IItaBpkuK2R/5eGcKDUSgnU
	IwQidjQOwomswXHQb1wRZoKdzlMtQgHgevhThdQPyVOVsrHcTaFucS5ckQ66Zti20VBG/zBT8S+
	ftRpRUn2j1LiIw==
X-Received: by 2002:a05:600c:3544:b0:49e:7c8c:bc77 with SMTP id 5b1f17b1804b1-49fd8868d52mr2788275e9.7.1790008106127;
        Mon, 21 Sep 2026 09:28:26 -0700 (PDT)
Received: from shift.daheim (p200300d5ff3cee0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff3c:ee00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8a636d1sm4059645e9.0.2026.09.21.09.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:28:25 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.100)
	(envelope-from <chuck@shift.daheim>)
	id 1x8gsS-00000002CpZ-3Tsh;
	Mon, 21 Sep 2026 18:28:24 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	jacob.e.keller@intel.com,
	nb@tipi-net.de,
	edumazet@google.com,
	maxime.chevallier@bootlin.com
Subject: [PATCH net v2] net: emac: move setting of netops to fix crash
Date: Mon, 21 Sep 2026 18:28:17 +0200
Message-ID: <49cd7343bc0e507c022071f3e2b5662b053dca73.1790007431.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fixes the following crash on driver initialization:

|BUG: Kernel NULL pointer dereference on read at 0x00000158
|Faulting instruction address: 0xc0566b40
|Oops: Kernel access of bad area, sig: 11 [#1]
|BE PAGE_SIZE=4K  PowerPC 44x Platform
|Modules linked in:
|CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: GW 7.3.0-rc3+ #1
|Tainted: [W]=WARN
|Hardware name: MyBook Live APM821XX 0x12c41c83 PowerPC 44x Platform
|NIP:  c0566b40 LR: c05648f8 CTR: c04c1e9c
|REGS: c1053a20 TRAP: 0300   Tainted: GW  (7.3.0-rc3+)
|MSR:  0002b000 <CE,EE,FP,ME>  CR: 24008808  XER: 00000000
|DEAR: 00000158 ESR: 00000000
|GPR00: c05648f8 c1053b10 c1063600 c1030000 c5ab3000 00000000 [...]
|GPR08: 00000002 00000000 00000000 c1053b40 84002808 00000000 [...]
|GPR16: cfffd210 00000002 c0beafcc cfffc960 00000000 c1030644 [...]
|GPR24: c0beafbc c1037000 00000000 0000000a 00000000 c1030000 [...]
|NIP [c0566b40] phy_link_topo_add_phy+0x2c/0x1d0
|LR [c05648f8] phy_attach_direct+0x1a4/0x368
|Call Trace:
|[c1053b10] [c0811e04] klist_put+0x54/0xb4 (unreliable)
|[c1053b40] [c05648f8] phy_attach_direct+0x1a4/0x368
|[c1053b70] [c0564ae8] phy_connect_direct+0x2c/0x60
|[c1053b90] [c056c7a8] of_phy_connect+0x50/0x74
|[c1053bc0] [c0572a88] emac_probe+0xd50/0x119c
|[c1053c90] [c04cb770] platform_probe+0x74/0xa4
|[c1053cb0] [c04c8f08] really_probe+0x120/0x2b0
|[c1053cd0] [c04c9254] __driver_probe_device+0x1bc/0x1fc
|[c1053d00] [c04c9334] driver_probe_device+0x38/0xa8
|[c1053d30] [c04c9560] __driver_attach+0xf4/0x10c
|[c1053d50] [c04c6af8] bus_for_each_dev+0x68/0xd0
|[c1053d90] [c04c7c34] bus_add_driver+0xcc/0x1ec
|[c1053dc0] [c04c9f6c] driver_register+0xcc/0x110
|[c1053de0] [c0aa3f40] emac_init+0x1c4/0x200

This bug showed up starting with v7.3-rc1. At the NIP in
phy_link_topo_add_phy() is a netdev_need_ops_lock() check.
This was added by the following
commit ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")

The bug shows up because at the time of_phy_connect() was called, the
netdev_ops were *not yet* determined. My fix is to move the code that
sets netdev_ops+commac.ops+ethtool_ops further up as emac_init_config()
derives that by looking at the device-tree and sets the required
dev->phy_mode accordingly.

During review, the Sashiko bot's AI stated that the commac assignment
became a dead store. Great catch! To keep the original behavior as-is,
one mentioned option "set dev->commac.ops = &emac_commac_ops only in
the non-gige case?" sounded like a great plan. So the dev->commac.ops
assignment for the non-gige-case moves into the else block.

This patch was tested on a WD MyBook Live (RGMII). the device now works again.

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---

v2:
  - "set dev->commac.ops = &emac_commac_ops only in the non-gige case"
  - reworded commit message to include commac_ops and Sashiko
v1: https://lore.kernel.org/all/178999551085.2160803.13630958553679103031@kernel.org/
---
 drivers/net/ethernet/ibm/emac/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 1d46cf6c2c12..e7043523457c 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3044,6 +3044,15 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
+	if (emac_phy_supports_gige(dev->phy_mode)) {
+		ndev->netdev_ops = &emac_gige_netdev_ops;
+		dev->commac.ops = &emac_commac_sg_ops;
+	} else {
+		ndev->netdev_ops = &emac_netdev_ops;
+		dev->commac.ops = &emac_commac_ops;
+	}
+	ndev->ethtool_ops = &emac_ethtool_ops;
+
 	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(dev->emacp)) {
 		err = PTR_ERR(dev->emacp);
@@ -3076,7 +3085,6 @@ static int emac_probe(struct platform_device *ofdev)
 		dev->mdio_instance = platform_get_drvdata(dev->mdio_dev);
 
 	/* Register with MAL */
-	dev->commac.ops = &emac_commac_ops;
 	dev->commac.dev = dev;
 	dev->commac.tx_chan_mask = MAL_CHAN_MASK(dev->mal_tx_chan);
 	dev->commac.rx_chan_mask = MAL_CHAN_MASK(dev->mal_rx_chan);
@@ -3144,12 +3152,6 @@ static int emac_probe(struct platform_device *ofdev)
 		ndev->features |= ndev->hw_features | NETIF_F_RXCSUM;
 	}
 	ndev->watchdog_timeo = 5 * HZ;
-	if (emac_phy_supports_gige(dev->phy_mode)) {
-		ndev->netdev_ops = &emac_gige_netdev_ops;
-		dev->commac.ops = &emac_commac_sg_ops;
-	} else
-		ndev->netdev_ops = &emac_netdev_ops;
-	ndev->ethtool_ops = &emac_ethtool_ops;
 
 	/* MTU range: 46 - 1500 or whatever is in OF */
 	ndev->min_mtu = EMAC_MIN_MTU;
-- 
2.55.0

