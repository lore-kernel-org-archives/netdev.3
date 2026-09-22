Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BB3F410D
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108848; cv=none; b=cKDF60EiboY03SSOxvjfTlS8JvDxXjCtr3V3E28G3wn6MzdSGym5Rc58wPckJ89328AkLmw0KVi8GzsSzFxVFqR9lQUpNxIpD8uhcMAn2UblbvJkLsbgb2bnGJ9cIbzP5QOX8Pw2wV3l3/JnCOXWXrBLYXZn2/330Te25wDMhMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108848; c=relaxed/simple;
	bh=ArxDFWRorxA57HvtQ/7pxyhtGP7J3HI5SzpnYoUoOeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv/5bhg3gYx9ubcUbV4IoAFx5zelI3HKogF0nDGO5m4Y3Yz9+fCoj1uuX87TXvm43S/IJRsrl11pDR2+42/nCq5ABk/mWeSbaUugOjuiRHtbNlxn607ybg2A9Q5QGQDTpO1tltuAD9Ts/wGw5tfJjkj5gxKDhR+Robdl4EN+NsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0zsXM7X; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0zsXM7X"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f70553dso34955466b.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108828; x=1790713628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dEnfg0DJvW7Jh7XGSYp9/aB0Ty7OF45cuMtXbpCs8/k=;
        b=O0zsXM7X247b1IWMstrv2zCz+UvXCMPCuTL8yvn9l7G4JJfjKwUeGkXay9xqOKF2/Q
         GP8sRWN4hvJHX7gHLJfodPIzCl8kf4tdli3Le/wmsc2lEpdlrp7wqV8m9LiLDlEehdkM
         XUqINANZhgiEs13u/6c1SI09RPy32mSS+qDWj6wT0a3/YOD6vqBfwE+X7gXE1ylykhek
         GQTKns5OYSK+BpPTzmCtZ3//4sCdNf2rlj+zzJE7Z/WPnqp4MXgN1jDyp+jHVbP6zuCU
         mOF1dCKKBcvxsipCu5zgy8LfF7KeeKuPwasbG6+vL8dBfwyQYEs0IGqRiSuiVzXQ790U
         bnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108828; x=1790713628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dEnfg0DJvW7Jh7XGSYp9/aB0Ty7OF45cuMtXbpCs8/k=;
        b=W9oV0EYVNRvl8CtisXdng0gGPXLSk9WjyOEiz2dA0fzNkmK3sCZ8mYdoRxopJjB3hA
         PZZ0EHlMHA9gquSUAIsF65S0hyU1wFYZNriL+r74LXJEAOTwpXjGjW2ZKyOihL8/AlvC
         HTAJEbWeFKtRpV6mVqJwaILH/PihjwGJERp7fAen6FTJUqZV1mrmAKw99MW9BOHSPkBP
         knFq4CiuaMx/B+9NYsKJlgc9sI4hpEAoRlvzORuOe14Z4nTA9iaA3vc8fl+BZBuui7kP
         ZupA7vOjE0hQ6rB5vdIH5d6Ttzt7fCsEWod4SR2ydL0ejzUoU/v3XG1pEkjWVx5XMjAm
         wd7A==
X-Gm-Message-State: AFuF++lKv+DKG7vaIfYOODGHhTm0qN/G4Lvf7tL4cRN11pvS3uCJPcaM
	g9rxoqmMIkg1JBtABX9Cr7di+BmwSJSI7D4v1K++k75PicPYGnA5/36ed/xgl66aIbQ=
X-Gm-Gg: AYBFou3jRj9bZbu3TEqBkvcEg+xXcbWWmtumzLCCwukszIR2uFkk5wvGsiaMAMQ8xS0
	Y2lHkomirTCMIyMZWToTv3FTXISM8x4KdzBBR/uZW1BF6h0eXtvVujsIB0RRYShgkrhigRJ59hw
	+C2n1DFRzC6BTHEkEP6jfCOoSw5yS4Jpx+G4KKA5qzw1hPsfdw2PDDiVp7U208N0Re3mClUyvcD
	CRIfzOKkxUZ5/p22hALPiyXRnotWt1o2Ipwv3crVrH0imogPPDd7DIaaXEVZhE4H6Xeq1tg7yvt
	dnTCjgTFn5+s+v3Qet3P7sblCYNpFsMDC2YuH+vDbKRv2lr0HxElNiIJswhWZTKstbIy3wvhi9v
	j9Q+sge1e12/G/gVJg17kgdl/9UHHcsJQf9WhcWitwJ0sD8cjhGKB6GojAANrNrDtIQZUXfvkWe
	+j4Qbj6LinKpEoujyO9tU4sEjYykI7a/wxbz0tCsREC1tFgxHQwPXosbr5Kj7WfzaRHsf+25M3z
	RD67B/H9NgL+1tdFMM1605WIJZZlQzj+T6Otpkdc7SGmD8eRecWxh/sk49IKPHwtmF+CK7uWJpN
	gMHbsTSWOb40ryJWSjAR
X-Received: by 2002:a17:907:86a0:b0:c29:6de8:d143 with SMTP id a640c23a62f3a-c2aadce96ddmr34060466b.19.1790108828276;
        Tue, 22 Sep 2026 13:27:08 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm11080466b.15.2026.09.22.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:27:07 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	ansuelsmth@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yongzhao Chen <yongzhao.derek@gmail.com>
Subject: [RFC PATCH net-next v2 2/5] net: dsa: qca8k: support an internal PHY as the CPU port
Date: Tue, 22 Sep 2026 22:26:50 +0200
Message-ID: <20260922202653.1153-3-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260922202653.1153-1-yongzhao.derek@gmail.com>
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ziyang Huang <hzyitc@outlook.com>

A PHY-to-PHY CPU link connects the SoC PHY to an internal switch PHY.
QCA8337 supports header mode on these ports, and the existing phylink
callbacks already support their internal interfaces.

Allow CPU port selection to find ports 1 through 5 after checking the
MAC-only ports. Include internal CPU PHYs when deciding how to access
the PHYs, without changing the treatment of MAC-only or user ports.

This supports a single internal CPU PHY with an explicit phy-handle and
phy-mode = "internal". The conduit uses its own PHY at the other end of
the MDI connection. Existing single-CPU forwarding then uses the selected
port for flooding and port membership without additional routing changes.

Adapted from the OpenWrt PHY-to-PHY CPU link patch; narrow the MDIO
filter change to retain existing external user-port handling.

[yongzhao: preserve external user-port handling on port 6]
Assisted-by: LLM
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 60f2a615a..17704cb53 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1014,7 +1014,8 @@ qca8k_setup_mdio_bus(struct qca8k_priv *priv)
 			return ret;
 		}
 
-		if (!dsa_is_user_port(priv->ds, reg))
+		if (!dsa_is_user_port(priv->ds, reg) &&
+		    !(reg > 0 && reg < 6 && dsa_is_cpu_port(priv->ds, reg)))
 			continue;
 
 		of_get_phy_mode(port, &mode);
@@ -1089,17 +1090,19 @@ qca8k_setup_mac_pwr_sel(struct qca8k_priv *priv)
 
 static int qca8k_find_cpu_port(struct dsa_switch *ds)
 {
-	struct qca8k_priv *priv = ds->priv;
+	int port;
 
-	/* Find the connected cpu port. Valid port are 0 or 6 */
 	if (dsa_is_cpu_port(ds, 0))
 		return 0;
 
-	dev_dbg(priv->dev, "port 0 is not the CPU port. Checking port 6");
-
 	if (dsa_is_cpu_port(ds, 6))
 		return 6;
 
+	/* An internal PHY can provide a PHY-to-PHY CPU link. */
+	for (port = 1; port < 6; port++)
+		if (dsa_is_cpu_port(ds, port))
+			return port;
+
 	return -EINVAL;
 }
 
@@ -1849,7 +1852,7 @@ qca8k_setup(struct dsa_switch *ds)
 
 	cpu_port = qca8k_find_cpu_port(ds);
 	if (cpu_port < 0) {
-		dev_err(priv->dev, "No cpu port configured in both cpu port0 and port6");
+		dev_err(priv->dev, "No CPU port configured");
 		return cpu_port;
 	}
 
-- 
2.43.0
