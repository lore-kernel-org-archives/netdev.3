Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF684DA9DC
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673939; cv=none; b=YxAJNN5JfH0VcrpXIMSWwFU8xVcjRSR1fQkQ7ftQxgwJixdQzZnv07Jb8ddTgE3mXsxqjxRbeojM/rOSEwvbgm+H1MLNy+Ra1TyayBmoxcHI+BYJJxHOsU00TQuNS+6yNU7r0KtgJjoTflc40OGn8YGBapNxrIQ64b3h6jT/+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673939; c=relaxed/simple;
	bh=zlI6cPEnBqZ4NXZ39puSLHk9fcYVmQZ79vqcCv31lpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOHRQD1+lP07wx/R1hNkS4rNCEb4pb2+QCK/Yzt+WWNMMBxPIB4QRhPloM+egZ7QvyODRe7BdgpG61MFE6yfmuTiFPXIKkBxYeeJpvQ4cPlWQj48umUbyZKrZRluKKp5ZFR6hfseIPDy/MiEmXQuNTN03kETqWYiOR+ywJDOpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sKfFNCbG; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKfFNCbG"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91235f46716so458386d6.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789673936; x=1790278736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4Q6Ad+YbWNAFT1S/eagIuareTvI4szF4zzV0Tuqr8s=;
        b=sKfFNCbGpTNzeEi4ENv/2ziPTXiJatiCcyrImuWvgsAszaB7HN61JRrrd/XR+SbJNu
         a05eIETWvu2NtdSKYEHHMTFCeOQRv8jn3idx9svnVkW7w/FjUNF/ag5BkbNTIViPaU2+
         H1qZSdzd02z5ElFYYaBiW5LhPk1yDmgvpnN00+9mfdj+rJmsDQgYPGmy5KQr3OuMgBGI
         +xAJL17EF4GoXeC9Svfdt7wC/jdW5IkJidOsvW/zP0vBKIGi3bNB5x/Ac9HABHhOKnjr
         BZtqoHyzqA2E1NPHZm6MK/h7+LmH4M4+jg/nbuRkkS6CuAPTjzenNZApex5rB5aA5aAH
         goig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673936; x=1790278736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4Q6Ad+YbWNAFT1S/eagIuareTvI4szF4zzV0Tuqr8s=;
        b=xuy59yUWff7k4iwzRmqnwWja2rVCFE4XE2o92oj2BglRAbboyMRXH3DWCQjVHri2pd
         sKr0s6hKkQLNBPFVk3wbmcYSwIzgSLgPra/bdZLq7IITQTIrJrExXXPAMYg+gBFMiprO
         7J4wijgvdejsq/9FPrA2y91iKExkDohelZJ4cmzM1Har5pOdTFc+hM4Pr46gAGzPuPl7
         DgwvkU6tKHC2H+sw9+P4iKvek2gXuDe5zfsQRr5kkcjG8GskDhTqagtZHaQET9D/k1Zs
         sHjIeh+vUi51fekmp58y8n1e8sBfP3zRFdzAw9GiGNNn9dxcvw8vTcJPPbH9B0oMylot
         w0Dg==
X-Forwarded-Encrypted: i=1; AKwUvBzuNvg5gDL1DRUfdl9udAIyabWykOjpssi6tKXsll87TtNVJVTzWOah5K2lhcDZQ71PghrOTlI=@vger.kernel.org
X-Gm-Message-State: AFuF++lg6Nutjw+ocPGZREM/fqvmXnsc7eJNGONEEVAC8fc1W9jpVpWZ
	88evVKTStAn/+0kwxJRWKQahs+8kz1dNpPw0V50mUZKXmzeFNM1EBdo=
X-Gm-Gg: AYBFou2XgpZWPIUhH9AnBmkCtrq3sn3SN+aYqTb88+ewJncDaVh4UteQ2TwMJajvJTd
	DvwKOsz3AxrMdfjdnWV5M0g9mzwEpD8j0VJrnXdwjN+/p865dppHE569G1ydTs47aBtw086PYlT
	SDmuLhen46Qlc0n4PEhVi2IKm7aFmIQpc97kj+yqbGVp91lEwW//yFXtoim9Iid7hgPPT2zY+P+
	igcJj6P4nnA3LJhsbP4bSp45tjc3ev8mThX2ZVxGPFwq75xaauT/K/9pDGgorzg8dL7P8YJLaRp
	EkDVxLsJyxtFGyTIGNzdCB4W0pDb7Hsy2gQOXiTKbIpJrCt63j5QaPdB9GGGIAnyZelTTKzlRMO
	YUIKm/AHr1ho+l+GqUhVnyurtRbjzWN82m+xKSEGMEHBjvm07OF7CUqujXdggzfNKboPUR0kmbO
	uWKdqHXVt0Vcl5p6M4wxV6gDAEJOxFpsPuOt+5b2cIXm1uZGMraNleq/EUkVaM90/iQA81ODSYU
	2Hpc/oSFnRhvpdj2WgnPk7sW5Pln0ie7tTegVoLGy27f9WNIXAti0OQoJIyhyWHnWcD+Hm/cknA
	9I8MibtWHO4XRRtrfcd0c+KVpp2GoeyG7zgO
X-Received: by 2002:a05:6214:d06:b0:912:517b:912 with SMTP id 6a1803df08f44-91254cd0594mr3693816d6.49.1789673936433;
        Thu, 17 Sep 2026 12:38:56 -0700 (PDT)
Received: from localhost.localdomain ([104.39.169.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252ce6d54sm5254416d6.39.2026.09.17.12.38.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 12:38:55 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diogo Ivo <diogo.ivo@siemens.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: ti: icss-iep: Cancel compare work before releasing device resources
Date: Thu, 17 Sep 2026 15:38:47 -0400
Message-ID: <20260917193847.63849-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compare interrupt can queue work that accesses the IEP state and
registers. The managed IRQ is released when the driver is detached, but
pending or running work is not drained before the IEP resources are freed.

Initialize the work with devm_work_autocancel() after its resources are
ready and before requesting the IRQ. This makes devres release the IRQ,
cancel the work synchronously, and then release the resources used by the
handler and worker. Moving the IRQ request also ensures the handler cannot
run before the platform data and register mapping are initialized.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: f18ad402cd8b ("net: ti: icss-iep: Enable compare events")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Validated with static source review, apply checks and strict checkpatch.
No build or runtime testing was performed.

 drivers/net/ethernet/ti/icssg/icss_iep.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index ec085897edf090e816b05880286a3f43c69225c8..fa45538f1faa6c8b44e7dd9a4ebb7269843b60bb 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -857,18 +858,6 @@ static int icss_iep_probe(struct platform_device *pdev)
 	if (irq == -EPROBE_DEFER)
 		return irq;
 
-	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, icss_iep_cap_cmp_irq,
-				       IRQF_TRIGGER_HIGH, "iep_cap_cmp", iep);
-		if (ret) {
-			dev_info(iep->dev, "cap_cmp irq request failed: %x\n",
-				 ret);
-		} else {
-			iep->cap_cmp_irq = irq;
-			INIT_WORK(&iep->work, icss_iep_cap_cmp_work);
-		}
-	}
-
 	iep_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(iep_clk))
 		return PTR_ERR(iep_clk);
@@ -895,9 +884,24 @@ static int icss_iep_probe(struct platform_device *pdev)
 
 	iep->ptp_info = icss_iep_ptp_info;
 	mutex_init(&iep->ptp_clk_mutex);
-	dev_set_drvdata(dev, iep);
 	icss_iep_disable(iep);
 
+	if (irq > 0) {
+		ret = devm_work_autocancel(dev, &iep->work, icss_iep_cap_cmp_work);
+		if (ret)
+			return ret;
+
+		ret = devm_request_irq(dev, irq, icss_iep_cap_cmp_irq,
+				       IRQF_TRIGGER_HIGH, "iep_cap_cmp", iep);
+		if (ret)
+			dev_info(iep->dev, "cap_cmp irq request failed: %x\n",
+				 ret);
+		else
+			iep->cap_cmp_irq = irq;
+	}
+
+	dev_set_drvdata(dev, iep);
+
 	return 0;
 }
 
-- 
2.47.1
