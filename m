Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4C24E4B5
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365156; cv=none; b=i15J7LtSv2VcjAwZpcNkc4ShbiKfKhq+spxziMAnuJMXx+I+apMHNTB2R9hjW/+0UsOcCXd0zgj0b2uZXZ3IuQENiuRCc/vF/Kw7w/g8DuWNRvFszNaA6b/kT1xgVoF1VdsXszcFbwsmmhOi10t938mWxL1IHbXevOESl51u+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365156; c=relaxed/simple;
	bh=GPyxZx0+cSIU8x8jKvE3lu0Z41GxQ/1gIT/YAe6XtNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWefQdUl1dedBmxynKxGFuTvbolUAHU5kQKeuInGAN085zFKd3sU3Xly7VdW80qTeAWoTLC/azwWpeg8/0COAgnozBXCqxRPeazQZn0QIgj4l2YRMOf6rwQPRK+JUxENLeHFSWpWv0GI/w0gxl0rIL74wxu7DFd3zXjYZhLhIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE541MGz; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE541MGz"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5bf83925ddaso538670e0c.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785365153; x=1785969953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h9u9uRgNdOHE3Hm6tQKrXhbypx1MeLyG0qZtrVKyk00=;
        b=HE541MGz9Fkq0AIFCfF9fmAeMLlu1bk6w8rOsCf0/QHAEhV69T1sUw4atRrSy5jF6e
         Gs+kD4UwK1i+GoRRUx5MDCpKWGXi9MhtxawyA2arvIBLibIzlgs8m0jUNla64elsES7i
         EzqW28xpq3Dgl9hXFJQ2xSaVBWFs1lp3cG6rHGLlpR4fLCh09IKnjcyFr2VJvMHIpvlY
         wbFWeKQhVkFK+MHG7tqIpKvYxbbxuS5I924IY2Xei6+7jXJSVKVhSQ4hHj3s4jhOjxQ8
         prK4yWgBS8dRtAHWGRJ2vV6DkmxaWl3MbjoLX5a4D0ohGpdWODpEEiHwZw+uf8DA0FCh
         Wlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785365153; x=1785969953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9u9uRgNdOHE3Hm6tQKrXhbypx1MeLyG0qZtrVKyk00=;
        b=npu069RqGPj17LbnG5+1pGsB3OULD+OiCrH9dBFQuTjSRCo/8kChMQT6nt764x85JP
         EQ9UOGBMA13uaOdXlmAM2w9r/JoLATADXjBLoyuN40HvFCFu7ruXcPyAI+HjtPNsJst5
         hAN6vVQa6gGQNFVqv5ZVFDViNA9xE2gs6MwsqIOsZO9TuxYzfN91AqeYLF5Wy43VEGAq
         zGCRWCskm04X2ei8VYWlfV0wpwjgsMLIx78G2fBPRbUXEGrKoK7dn0Thpdo1At6uxRD9
         3zrvQlRDqd9V3mnhQqJRMxldptbDh5dVN1siNjwcpPRlOXdgXXb7MFnaxR/lvf5ckAY1
         KU8w==
X-Forwarded-Encrypted: i=1; AHgh+Rpgl/Y4uAXbQKKY2labhEA+gB5oX0q/heG7/T+5xPcJvl8tsTlZYMWmLytmpXgujdSz0BZTS/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPKDpbUdvsrIpRRb6W8jo6Osmqu4tvDyFq0WrvwPs7T1h/ct/1
	RVjZXmj+q/pNs9/YsjFevnAGYapW6YZcA2a1Sg/QK239MB+AkGejkKeh
X-Gm-Gg: AR+sD127QcLFkc3HRJlQ3myR5fGkDsJUKfIXYFVPZ04vPx49Xnbfj3WZ8xpyDqDLYvR
	eSkVAUwIKSgzy/JgT6kURzmxlpAzQt9GlHwlQ6APG4O3YoCxbW/3LtIWh/BKmOlUMLu07ajSY8l
	+mCugqub4HLLH9UHr4nTcDZUZDf0XgOHJoRfPiWZJCCLHF0EzdcKTVSwsnJdycxGjInjvWRBzYv
	cbz4SMQe2mLOofrTl8cGGN0gWBx41Pc2xCyPsJS6J2kRdaXPGjCW8I5musq8c5LCxCf2dYJye4+
	zt+Nz/+I4Zv2ZtOuZOLD24TBJZEznwlcpdpKLaSnzL9O6xTJJLCklPTA14RBcg0wUQWJ2l5sBvb
	hEBSRPVofy+eL4Xaxn3RMwkcXy2OzqPlmwJ4W1xp2oL3IZO7zjQjHR1S91aGOQS+fDdlifBqp9G
	R01y/pSsQ2XNKnqG2JarkYmBjoRMSPgZprpo/aS0HvlWJr5W/G+Y/bicvjMQFEwYzAFPePe84CD
	AIY17jbStt5CSgQIgioTNV09TGpuYF6ItJVRw==
X-Received: by 2002:a05:6122:4684:b0:5bd:c27a:dafd with SMTP id 71dfb90a1353d-5c365fb257emr35318e0c.3.1785365153129;
        Wed, 29 Jul 2026 15:45:53 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7.. ([2804:1b3:a801:60b4:a913:91a7:b883:6046])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c366570bd9sm24356e0c.8.2026.07.29.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:45:52 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kuba@kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	qiangqing.zhang@nxp.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	Clark Wang <xiaoning.wang@nxp.com>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH net] net: stmmac: Select sleep pin state after suspending phylink
Date: Wed, 29 Jul 2026 19:45:35 -0300
Message-ID: <20260729224535.506598-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Clark Wang <xiaoning.wang@nxp.com>

When MAC Wake-on-LAN is disabled, stmmac_suspend() selects the sleep
pinctrl state before calling phylink_suspend().

phylink_suspend() may access PHY registers over MDIO while stopping or
reconfiguring the PHY. If selecting the sleep state muxes the MDC and
MDIO pins away from the MDIO bus function, these accesses no longer work.

Select the sleep pin state only after phylink_suspend() has completed.

Keep the transition conditional on MAC Wake-on-LAN being disabled so
that the pins remain active when the MAC must receive wake-up packets.

Fixes: 90702dcd19c0 ("net: stmmac: fix MAC not working when system resume back with WoL active")
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
[fabio: Reworded subject/commit log for clarity and made it priv->wolopts conditional]
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Based on the NXP kernel fix:

https://github.com/nxp-imx/linux-imx/commit/7905fa71ed07d8c2f1da88ad9fffd5ac5e89461f

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0de4bc949913..36ab66ad80fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8183,13 +8183,15 @@ int stmmac_suspend(struct device *dev)
 		priv->irq_wake = 1;
 	} else {
 		stmmac_mac_set(priv, priv->ioaddr, false);
-		pinctrl_pm_select_sleep_state(priv->device);
 	}
 
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
 	phylink_suspend(priv->phylink, !!priv->wolopts);
+
+	if (!priv->wolopts)
+		pinctrl_pm_select_sleep_state(priv->device);
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
-- 
2.43.0

