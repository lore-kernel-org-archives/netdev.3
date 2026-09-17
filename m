Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FA4D90D4
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644890; cv=none; b=fGwe2pQcJeQ3Y0Z+FhUOAM6JvfgLm8PSDkSVqs2XZzKMYIQQjdcrY/CkY59I5CKlnuC/qXftJGc3MVNmV+wG6KNcmo9MEmcCE8YIqQzMzjJr1WTJhV3Zblf/fNLVdlClhbBK9MpYhcwiRspztWZtkytUKizyxD8Qv1UaOOGEzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644890; c=relaxed/simple;
	bh=l+jdgxlnr+smtXNYteCaDe7E4B8U+QK0wFqrI0cDl1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N+dl2CPQg5z4zAgGc8wapK5+anY48c+2EpHrrm3agPvBsPgKwqjMxmPyLk/yQTPZBAe/8PPNCkREX3xwdfaDZOsQVPMYKyxPtqX7FBtBSriJYGKYv1syeDAh3+hhZw8WfURjwN3Qpa/aFQXtIXz+vOf8a7X7qVNySH742A2WEMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iejj9rE4; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iejj9rE4"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso9161355e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789644887; x=1790249687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jKvbsOh38juXFYArl3E5Xa+Yg1zNIxwf5ND1eSWW2Pg=;
        b=Iejj9rE4UydhVRQAo9e7op1rOwAcvNKP2j6P4+puxWnC7XNTZX8uF8HQZH3UQ1NObC
         n7LUWBDJb5Uu/7QDulee3virL30tWWCEUi9Un2BbQ5re94Z8R7Q4fV46m8Cfvi2N0fW8
         02hMratYfbW8nv/VBCU4NrfO8igVggB8a7hW52vAkvFsPJgyVPwPfKSU7WNepqC5NF5V
         un9w/J4qEGKrg/9fuMzfaKL0JouyTfXueY3P+n3mMJWcOteb/sFGHZ1SJXtrgtE0Xdu8
         U2z1GRXXYYzvd7HXa9hipb8bBTs5yjrAT7UFTgjcOZR0DYl/FVepsxV4T6zk3Cs+R3ZK
         cqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644887; x=1790249687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKvbsOh38juXFYArl3E5Xa+Yg1zNIxwf5ND1eSWW2Pg=;
        b=fE36Tba0ko7jV/kFeepGtHR4gszSTPaxSFctXP2AEsT6iNTKSzgTfvCAPQeLs73Pei
         MuAswuVAlWmDnxgjPr/H8AbGQhMUqXFkRWTnnGSGCM/uiXmLy3F6cZxXIm1CAEaD2rS6
         z07dzPfmARzdAfuXrXDwiNmDnDH9/oEQjhS3/Q3fjD+7aVmK28WcpiVy2ovb9Tsfc0x/
         k3eeYtLwSYBphbb+qL0ABOxnqTLh3EGsYg0SV/lRAYQSVZl9EOOkupm8Xg3p6gtwdcmG
         5+LxESM7S+sU6li6N6wiIaDh+YGBQ3Gq8ylfo12QXEzJbNRhGIydt4qLiC9hCLaiVbLy
         Oydw==
X-Gm-Message-State: AFuF++nkUgekDkIH9a2CNKfA4QpX9TN+PraL4RY8xNZMoN0gpGpEfqcw
	2n0buEgj43QQmanvTgF1tG2OUq81hfTKmQk5yv5wbJugUmzdfQgb5TUt4BEW3A==
X-Gm-Gg: AYBFou0dNeR0L/wxoGzURwpShak29W5mNC8BhkZ1v6oyb372IjgKm00NFVe61rmohd4
	0tw6/UMctdDzpE4+s9XTr8GsiuKamiQN0L7FCV1Ii8QzTGQD+CAfpw0OLLR5neu4/ivtlHmzEb9
	rcvJ8GEipWWX30PdZ8f9dMIJ4ggZVLSJVDKhu5x3QINeOP6RwCFj4ZMRk05+QGPdktKo4ilaV7N
	wuhLNBse6lIvMCfXxV1rUBnFnZYTZb+/eo/3ee/sVhg1W1BJYsLgnqmR92nFC06gh99OQKeKSeW
	7MasyrCbOU9t9BGl0zx5LwblRh6HDzhRgn5Lhgj69zA0hFkAU3qGUs6mVo6mLSgk2eXlCkfYMVl
	SAkAGMaffnoQ3dyCEgwlwK1UeSjfBClikncn4cxSd4k6ptgjdDYZsR/1RmVShX+UZlvgjGTdUAs
	cenST/lfFKcPT/xHZITN2ukEqiWJ3B9KerucUdhtoce+UCmqbWw37hUWypq9gBV1ZW+Qy/jE6Gu
	1yWbWROl01H0geESThzgvzN3lBmed6GgK6mIRV+rwqiWmxY4YBeKEcfoOBku+YWBxXcZ2B3AVsV
	Sg==
X-Received: by 2002:a05:600c:8b8a:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-49eac46376fmr142195465e9.1.1789644886836;
        Thu, 17 Sep 2026 04:34:46 -0700 (PDT)
Received: from shift.daheim (p200300d5ff3cee0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff3c:ee00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf4161fsm13585878f8f.34.2026.09.17.04.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:34:46 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.100)
	(envelope-from <chuck@shift.daheim>)
	id 1x7AO5-00000001wEg-0y7J;
	Thu, 17 Sep 2026 13:34:45 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net v1] net: emac: move setting of netops to fix crash
Date: Thu, 17 Sep 2026 13:34:31 +0200
Message-ID: <f11843d8416cb3d94b79a7f224bd4af0bf859c1f.1789644724.git.chunkeey@gmail.com>
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
sets netdev_ops+ethtool_ops further up as emac_init_config() derives
that by looking at the device-tree and sets the required dev->phy_mode
accordingly.

This patch was tested on a WD MyBook Live. the device now works again.

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 1d46cf6c2c12..48ece86bcc8e 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3044,6 +3044,14 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
+	if (emac_phy_supports_gige(dev->phy_mode)) {
+		ndev->netdev_ops = &emac_gige_netdev_ops;
+		dev->commac.ops = &emac_commac_sg_ops;
+	} else {
+		ndev->netdev_ops = &emac_netdev_ops;
+	}
+	ndev->ethtool_ops = &emac_ethtool_ops;
+
 	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(dev->emacp)) {
 		err = PTR_ERR(dev->emacp);
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

