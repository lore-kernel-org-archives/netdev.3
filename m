Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727F1F1534
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790035762; cv=none; b=Q0e2VCcus0rvKLwGZKj/8FtJCFnsZuWDUbs7A+qHq6pi2/iNo/3VhRCSIQP/vo5ynMo6tauBMIoJX9epMiYnukufce8JEU4sBtOwOH8OnhbyWxtJGBeOe25LO7/CVQQHpBi34L4XSvZT7ikDglP2PxZJ7aLKH6EMlOii4jiUcZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790035762; c=relaxed/simple;
	bh=g+F1XzIjG9tPsGCMtumO2J7BqYdSrLwWUlEAMXEUQy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSkpb226TtYpLh/RkLlzqI6FTw7rojL3hM0vFl36pTlKqudLVqtv+vGccNYZH4bWitIMB38gdnskwIqchYxnjeL3JWeGqH9W3tPAPakGhL5/KVNapg59AvRuIbH3sAdTCA54/rjXNSSqUFcEHb/lHrwAqV/Pq/HF4XLHENsCHN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGGPDtBe; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGGPDtBe"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a2a8c29c4so373408885a.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790035759; x=1790640559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+px+gyXVLidkcy+k/uZ//IG8TqK3wgfrhlr6nss3oOM=;
        b=qGGPDtBeywuo8153H6+ImNCOQoLuVwZOD6Mn+7G7Z34viSUp0V7Vi9B3EQK1qFe7N+
         LHX8M3oXk2LQkNZzXaBuY0cvlBT8iDieUmTacF5nCg26WHx4wC9MIa1U9ba5DK5OpTE7
         6S2XAl5sOt5Ck16J06WaF4rJAwBR6aDueZfjtbsStFgd4m73AR27P8qxvQncXG1QlaJL
         5VgXA+FQOmFiw/7wJxcX+MwYxeBHNWKQ53RAlhYFsMyh5J+3EqtFbPIMBorEZkf8enPj
         b9L5oId/otBx92cRC+WKNThy5zk7+DwfvT+2mYd0wyzGm4SEkF8/SWFITwMyMfaelVgG
         gKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790035759; x=1790640559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+px+gyXVLidkcy+k/uZ//IG8TqK3wgfrhlr6nss3oOM=;
        b=jAU4JvbT7cBQzPISu2CDD00ofr+6NdWE2BNRJ/QELNCHRG8s+TnAuTqX1LuRdHgzpc
         he3FIkrKJGxqhwYEuX/W1KNcG+vJSwz0ql41a9uH0j0pDQr0765VCqN7IaQyJtrMcdse
         MGwo07cXCfUUEBBosFcWGY3ZX4I9PvLZmS6KkKrbYPwI7aiISufFkh4dF1iPfMu5DTeW
         XhuNmLEPWct2TKdhYq5s/+dMQqZseJqvkhkzAJA5sNf/Uk/2xohRDjRjuuspfvIAJFLw
         7ztb0jMVSNncWFpQLDhKHs4QXEXmQZMZXRoyh8I/rRLSYag4iiUhiaFEJblf4ZHRndJo
         IGIA==
X-Forwarded-Encrypted: i=1; AKwUvBwztRhZCdL6e8+g8hndtkCMYzWzH/vxXPuAgRy2prBQnbAsMYzbwaJn+yno1W7ET/vcpl+6GN0=@vger.kernel.org
X-Gm-Message-State: AFuF++n5pqsRAIrgkYhirpZRNlyNDCUZoBIvH4fi+AvaWSHFxoS4ziyP
	wtP3+uSgzYCrf0Rbuw86CbxzPboIAwnEOe2c8V3F2sTiW8Cr2FsWxIY=
X-Gm-Gg: AYBFou3oZGeE6W5Ss9iJLtqckXV+xabLH3OLW5+4piGhJCDkjQSScnpSVS49CuxStAY
	/HWYOEhWs8JLbjWuozrxLZiiec1rMljAcKDx9CuVB0Y229daXq/kNinj+/DdA4lcYt/KbXzx6Lr
	aeWXK0cq8RQZaNaom5DtYcbiiwZQNYhUiquMIjqQSSfBx7AXrh9zj8ZyvUGBPpDj00ZQHKfkD2o
	fiQvqYvwxkCk7zntGO5vmckSa4zqOKlxH0uVMDnM/R7apBAzOtx+XOLrUPW+93oqgEjldF6knxg
	CSQOzP4a/M+G883NroRt/EJOxtrNcfbGB6x5GSSKsmPVcQ2TfnzWa6D9NqmxQeXamMhzjj0T27Q
	dzKG2VUNjWe1aAFi+ShxOgJWmVbZcJEhC7bhcw+88LMPT9T6AIk5tUgs78VEl/knlsfIBXPJWiL
	XEUyX09ag3C4twPKcqAZ7wa86c4HlZpJTS1/0UmC7a+K+umF4NPGdiyqjB433Jx4jBcbyXo31Nr
	kgmNSGc/zoyo97upBqKmCG8G+K0g1mAIhWnAVpEa3Jg3A2BLBZm2oSkRgioZsJnMcMcTLJHHKpy
	3MAnVBVAN/IB0p3jXPkjrXg7NgCw
X-Received: by 2002:a05:620a:1791:b0:93b:f246:bae8 with SMTP id af79cd13be357-93c15e78ed6mr305051085a.37.1790035759325;
        Mon, 21 Sep 2026 17:09:19 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c19a812d4sm53263785a.22.2026.09.21.17.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:09:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: airoha: npu: cancel wdt_work after releasing the WDT IRQ
Date: Mon, 21 Sep 2026 20:09:14 -0400
Message-ID: <20260922000914.542068-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

airoha_npu_remove() calls cancel_work_sync() on each core's wdt_work,
but the watchdog IRQ that queues it is requested with devm_request_irq()
and is freed only after .remove() returns.  airoha_npu_wdt_handler() can
therefore schedule_work() again once the cancel has returned.  struct
airoha_npu, which contains the work, is devm_kzalloc()'d and is freed in
that same unwind, so the late work dereferences freed memory.

Register the work with devm_work_autocancel() before devm_request_irq()
and drop .remove().  Devres runs in reverse order, so the IRQ is freed
before cancel_work_sync(), including when probe fails.  A cancel left in
.remove() cannot get that order.  Initializing the work first also stops
a pending watchdog interrupt from queuing an uninitialized work item.
Probe currently calls INIT_WORK() only after devm_request_irq().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 23290c7bc190 ("net: airoha: Introduce Airoha NPU support")
Cc: stable@vger.kernel.org # 6.15+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 5bb4817a898d..4d3195eb00f7 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/devcoredump.h>
+#include <linux/devm-helpers.h>
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/of_net.h>
@@ -751,12 +752,15 @@ static int airoha_npu_probe(struct platform_device *pdev)
 		if (irq < 0)
 			return irq;
 
+		err = devm_work_autocancel(dev, &core->wdt_work,
+					   airoha_npu_wdt_work);
+		if (err)
+			return err;
+
 		err = devm_request_irq(dev, irq, airoha_npu_wdt_handler,
 				       IRQF_SHARED, "airoha-npu-wdt", core);
 		if (err)
 			return err;
-
-		INIT_WORK(&core->wdt_work, airoha_npu_wdt_work);
 	}
 
 	/* wlan IRQ lines */
@@ -803,18 +807,8 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void airoha_npu_remove(struct platform_device *pdev)
-{
-	struct airoha_npu *npu = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(npu->cores); i++)
-		cancel_work_sync(&npu->cores[i].wdt_work);
-}
-
 static struct platform_driver airoha_npu_driver = {
 	.probe = airoha_npu_probe,
-	.remove = airoha_npu_remove,
 	.driver = {
 		.name = "airoha-npu",
 		.of_match_table = of_airoha_npu_match,

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
