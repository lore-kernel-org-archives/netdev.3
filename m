Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F212F90E0
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258957; cv=none; b=gcu043aNvXKRV8Hey09f8BwH2lSGioZHVkNEwP4hZb7+0NAd8ZY/Oi+Bwodrfh5VPzDNRVYdz32HqZJ7Gt1vC9AyKZrlY75NhMJq66avwB9gT56kJ9+JyrIadt60FSVI1v7kPVoAH5uV/ajuUeVmNldRkTn6XxKPpwnoHFS4u2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258957; c=relaxed/simple;
	bh=OKcAVSyqAk8ru1r32n3EaZyWolAJF1msAtab6WuNRtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfdeoGzRyR7tNqH3crPXsiff/vR4HsIvE7Soz9wemW+WelFoiqRG/Z1Qk/mZNU4ocIRBje20Bj8FFY+2uLMTcJMxm55bzNGwu2R1V6MwiMc6MfhUvNsqBqoHhUjHrdcrXFSAiSqamnVW/4Dr//XVjZUOb1DYnKHtkQC3viAH9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZY2fJIp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZY2fJIp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc73e322dbso1648925ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258955; x=1785863755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8vqxAh8CqqJc99YaNfeG8WErYj9oZt2HH/TEPC3CmhQ=;
        b=TZY2fJIpWe+ACwobPSWzhycUHmIEdw/uxuwg9oMd6xXS7JCSfG3LmGfqpvnHaaVlHK
         v13aN1/IPe7WksXREtOxfseYldwuvlYTIqicMMCgXL28KgIswYX2qA+7kUgXmPrtLlfh
         txnmWaAj/of0lcwPzaz4r7QIK7hE1ODSHtcLvVfDxDNOD6weGlIm/eY0RJLx43iT965y
         1HpXUel8y5QoC74gPIkClB3/DzuqXaQ2faug9TBKMdjLEzRYWdkSts1GRc1T/9FiBZTH
         KfIWcQ31F3p8+X7mQUhGwFwMHHToahEl9ndmwbhHCoxI0JbXbFc7pBx/c2S3un3aXQSV
         GXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258955; x=1785863755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8vqxAh8CqqJc99YaNfeG8WErYj9oZt2HH/TEPC3CmhQ=;
        b=LUGLzCU3OdpYUUlW6PJd63HoR45cgKWYISVibZNEvBe12vaaGxpukgmh0c/MTviROI
         qyzrf8P/dHWCjHNUOBuU85qhyJ4DvvjCNd42ib4MyGDCqBx7tirfp0JfKBHk/G1gGTab
         H3XIwsliIrYS5770eNZydw+s8DMZoi9tecgrwjf7CSWJTdXKwe4+hiOr/+/3GK7tKKqQ
         6qwAl9MFjcEOsEMaOaujExI+tCCbkP5quDdfcTzmokKZza7q1h67ocsHElYUzQBb+8yI
         UH9CBqGUVgB6D9BmFJRRIJmDQwrbRvqovPZ5yXZ6/Cuh4fK8804lTkwJ1Kblan0AbDYi
         ES0g==
X-Forwarded-Encrypted: i=1; AHgh+RoUYcbAxKAoTALKW5RITMXQDsluaJkE969AnXZJn0XSX//4e6SxI9Qmr+AxR+7Q2C4GWF1jt04=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIT642UIBUN/ZCXXRNhBieJYnT6nRXyndV5eF57RCmoOc4FXhC
	jJb0lVhVu66YFVAtbOSZG+lCrGBiuqjM+F86A9gljrBZN8FDfNuXI1o=
X-Gm-Gg: AR+sD13z9IelzZqAgtkSrqZmovWYCIKFpg4RsUnLpNqo78W+G4T4Js48bENJn5H0pS+
	5Nb5HKVOfwSrMqu+B+/a62Y4DflHjiFYtEjpk6J+3zbB7NPiq4gky8UFrvPodCjgDaItuBU2UFs
	eOllwKX3PER1qs0+Tbmkbh/vPH/bsaEAXhWLFzOwhMjJgCS+qWH2FQn87uR5KRtgV06Dui97nz3
	HUUcGGsPi0Tncxn0HcRo0hByWjepGxbH8ZK9VuhNYfC3Jd1/5dhqkaoudoFGR66K2u8e036X4mN
	FmUY0NVgbmUlHZpMYDuMYhSezwglkwSp3OUJ5+fSlLePwo5JUwwNTe6w7xPnUi67TaMeHfLkcbe
	rmB2Llp5n+tWshZHppNY/tysC9PXNRkxrqll4hHoIosgwsFGLqh2to6KB8bJ/35VFH27pGTOzuP
	zuWNrlMI/B75rBbyFtiPtClgUtc/zSC4MdiLZUw6Gbsz86B3zhzOC1w0LvX8JOHlsnj745S6Had
	vimVrU7Zr7MhsMtjv7uav3I+ehwek4O0NMkvwQR
X-Received: by 2002:a17:902:c40d:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d015c2ab6fmr39514985ad.14.1785258955014;
        Tue, 28 Jul 2026 10:15:55 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a466a9sm3235ad.22.2026.07.28.10.15.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 10:15:54 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Wed, 29 Jul 2026 02:15:45 +0900
Message-ID: <20260728171545.49247-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucc_hdlc_probe() registers an HDLC netdev whose private pointer refers to
the separately allocated ucc_hdlc_private object. The remove path frees
that private object without unregistering or freeing the netdev, leaving
a registered device with a dangling private pointer.

Unregister the HDLC device before releasing hardware resources. This
closes an active interface through ndo_stop, which disables NAPI, stops
the UCC, and frees its IRQ. Then free the netdev before releasing its
private object.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb9..4c843c94c 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
+
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1268,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-- 
2.47.1
