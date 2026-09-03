Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA9411F94
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788431256; cv=none; b=SZL7QRr8ZJDJmEpAdsMaGA+jb++SItYPFQ0GY5WCsrue2fIpyYJ50//CHp97J8hzBX22Gz6soGTu65mCvXf/ZEriq7Hjt2gFOYWZVMbx/4RxXeAcAuowSixyk7WevF9i57zFYLaGCejysmZWKhgGNN6xa2kuf2rUhe6whvFrRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788431256; c=relaxed/simple;
	bh=LFkbEPJMXtlKlu8k0CfjzImXNJSiYxotiw5JDji/Bhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsr6jxrD4v2SRrYSNN2SCCXIGY3vpHV3QXcrmo1PBGRqHvQc/HjBOEzaAf9TJjCtrd7DZHPfxMS857/9tIOe6ofaXA+BCVtNTOsdcglrLmFZFZ/kPOgRWhuYMsgyBvG3D/32v5rSzsv3KYgHPvgG8Krcg4QWDoMp4HDqghOblnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXO7UroJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXO7UroJ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2776711a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 03:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788431243; x=1789036043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2CQkGuc52z9Az9JmaiqvdXOtnpX3mU1OHrbdWMMw/t4=;
        b=SXO7UroJc4aGkQcR9AmFBP1bOR/oVEshJwuQJG8xn2t05oUpZnZJ2YClNeuifkIAd4
         BOWXgPj3esln8Eu+oKREC3Pe+0pXanlOVuRRN/hshABabSSkceDSI/PKtBJSglokAvRx
         tMDQXmVw5sGfvlhBQwygAp1YF0UT03Z5JIKUXLWFxSnVZ/vnbj7KlH+xgzx1bekgzMtk
         QxRrENBqDBB93s9i+2GUtKVtVdX9XVEMmF/V1OBY59TIB7Sy/FEHRzdvn/Gu5Orc0NLl
         AzVtAoeqMXp9GnzziLJk6aC6uwbLKb3/Wq1RN3CddfM/Ma/206cjUk3T+FKt4xK4iTKT
         L7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788431243; x=1789036043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2CQkGuc52z9Az9JmaiqvdXOtnpX3mU1OHrbdWMMw/t4=;
        b=sSnBA25nPORXDpF4qSqRtEvnJ6IiCPLzAdUX3rZfMnmwq/m8bV7rYKWA0I74o6DVAs
         Kob0fhZH7U9xooQSP1/D62Ek1i/vkqRu1zTOLFuV0/MnhMX5Rcs4EKliPERCYPrIor6p
         cX9lc3bRMQ0zAcZjoH+Vv9hsitYsFONkfJvzSd589b2cWVc78p/bEZ9STXtKObRKl2Dj
         P/NMNLZqTzOH1iAv5i/QNt3o54uqoSoc6cHOysEj1miXlC3v3q6po2pgpGAnRCee/tJD
         R5PQv/JIyCdtlIkrIRABq8Md05DNxEoDYkTcNCym0JHmoWxo52KSYGFFrKINkBgvh/8y
         v2AA==
X-Forwarded-Encrypted: i=1; AKwUvBzTJHS3AJUfHdEDQoVABwUc85kH2WEuyKMzmZLTpGL0aMXRUR1L49Mt/hxQXn/A16Vb8qIykww=@vger.kernel.org
X-Gm-Message-State: AFuF++npYQ3g3o9d7m+TvJxkKj4ZgrTZeexi0EqZVMB6w7V8M0JM2N+1
	UGc+GAno/UK+nAieLOFTS7XfgDAjY++d9eaZ/7pC1qpCM2ycjaA6fvth
X-Gm-Gg: AYBFou3GSXxKoIdolIVzSD91jZPteG0ULU9ouTgciz4gfAQJALTYHwMHOeDVBpyl6A+
	W5a3APAjnu03Vrf7Gwje7noM4fkHwyoACrRRsA2w/7CFYDg8A5EuWBR44eNd3izl5qdYfD4hElc
	MkmTMrMXjgB18AZeN1UQC7XbV2jzGs8qk7c6nmmg/f2zccA8o6ADkDyzk4m30cmzNW99BDmW8VL
	bV4tipjTzSFdr30V3ANBrvaIQMqk9bFDVszgN7eLoGgdR7XjBmLdkBRxEquyxKTsZ2Afdo/refw
	o057a17yPEd5tnQmYoDsJkIoZKC5IUb2k3M6s2jIxhPnekDz0vZ3AvEZ//GeH1/X2pWOXPDDaIY
	3n/CymN3eqy2QJNr+s1RADWWVf7dAydGIsauyGcSzB/vPY5RiDv0HUcCYnYYA3qAtOM94h3kmPR
	zgQ6/4+XQRYUoyfvjBj4oBb6DeS2EohpNWmz7GCLvNCzzGzXmoJ08aw0ow6XHMBWsMvx+YU8V2Y
	RTW+FEwBVmUvl9D3yoLt9J8nO3oBXU6DUsfhmldd/WfAL/A5YlW+QhsUNjGXq7rwQheSSc0XWY2
	t2kX4JbKFggwNrtA
X-Received: by 2002:a17:90b:3d84:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39aedf7cc2cmr18831032a91.2.1788431242712;
        Thu, 03 Sep 2026 03:27:22 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm4723578a91.17.2026.09.03.03.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:27:22 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Cercueil <paul@crapouillou.net>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v2] net: davicom: Propagate wakeup IRQ errors
Date: Thu,  3 Sep 2026 17:26:56 +0700
Message-ID: <20260903102656.370039-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The wakeup IRQ is optional, but errors from platform_get_irq_optional()
are currently ignored. Propagate errors from the IRQ lookup, except
-ENXIO which indicates that the optional IRQ is not available.

Also propagate errors from request_irq() and irq_set_irq_wake() instead
of continuing the probe after the wakeup IRQ setup fails.

Found by manual code inspection.

Fixes: 2e2696223676 ("net: davicom: Use platform_get_irq_optional()")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Add a Fixes: tag.

 drivers/net/ethernet/davicom/dm9000.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index b87eaf0c250c..904b859f0a63 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1511,13 +1511,18 @@ dm9000_probe(struct platform_device *pdev)
 	}
 
 	db->irq_wake = platform_get_irq_optional(pdev, 1);
-	if (db->irq_wake >= 0) {
+	if (db->irq_wake < 0 && db->irq_wake != -ENXIO) {
+		ret = db->irq_wake;
+		goto out;
+	}
+	if (db->irq_wake > 0) {
 		dev_dbg(db->dev, "wakeup irq %d\n", db->irq_wake);
 
 		ret = request_irq(db->irq_wake, dm9000_wol_interrupt,
 				  IRQF_SHARED, dev_name(db->dev), ndev);
 		if (ret) {
 			dev_err(db->dev, "cannot get wakeup irq (%d)\n", ret);
+			goto out;
 		} else {
 
 			/* test to see if irq is really wakeup capable */
@@ -1525,6 +1530,7 @@ dm9000_probe(struct platform_device *pdev)
 			if (ret) {
 				dev_err(db->dev, "irq %d cannot set wakeup (%d)\n",
 					db->irq_wake, ret);
+				goto out;
 			} else {
 				irq_set_irq_wake(db->irq_wake, 0);
 				db->wake_supported = 1;
-- 
2.43.0

