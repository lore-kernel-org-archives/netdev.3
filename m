Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670442C21DF
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929896; cv=none; b=P1YfPihIv4sIJkvuGVHuxotnMeWitWYpCkAXCZqRzJc2bTeJNYnNZN+VIfGuKOcw/yopWIyBAzbiwJSMYQ3GPNNJf80yTsBa6j93aU9nyNj8xyrMHjm6zw9A8cTXZ26nskAzGVmjeDDn0Bo0DjpCxXKuWVTf5ohypVSYFwzJN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929896; c=relaxed/simple;
	bh=xV2CxxpHiPwlcqAHa0fSPbXIoxKcO92bZb06sqkypXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2uNrIQafGxT8hVE9JKk/aVaRIWtN8NpiBN7O1R28y1i69G+N7FJ8TsxlG4SDfIQvEj5b3GpjExyfkdoNLTx3dKmL1M1zpNKP4jVFe6McnXk/wCqUSZ72HqJGlXekqqLMjL6BVHd0YXiX1Dzp2SewuVrXSbBzGXl+Rxm40C5NGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz5r7WVH; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz5r7WVH"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so619011a91.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788929891; x=1789534691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MR3MzU2Zp5iN0UaB3/KxSwNcrbqRw02veejgAfQ5Gjk=;
        b=Iz5r7WVHGeCHEAd05HD9KBvQNTPYc+Kagp+SU5HjXCUGvArDXMc9J4ew7BntrZE9SN
         H3KHgBFSQ4y4UJXu6vcXXjwaQS6+ebrAVh3xRRsDoh05n0SjfE1V8Yf0NcI6GDoB3Skj
         cexnIs+w0Z/McLZRWEG884mYate2mdp13Lj25MuoINnLJvVdE0A+Q5h9pMyDQo7Tf6qh
         zuVYorqOZa7mQDSmuJetjYqhdWZSWuvFiWyDswHAHUPKB57sa7U4FTHGaVO//VhbR8FB
         DQrpik7sfNq5bA5bjH/pPRYYJZbQQXIT71iVBsh94lOJ2S7VoByz7gZtulH8BUkUtubH
         0pQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788929891; x=1789534691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MR3MzU2Zp5iN0UaB3/KxSwNcrbqRw02veejgAfQ5Gjk=;
        b=h9eDq/273uEH7hFvQ8SZEK1jUiKRYNfYkYz4vT/z3tcxtO9YWaP8XMajD0y2o+g5kr
         RKlZuVUQ87sRYYSUfFHRbKw2ObnVDtSbMtqu1KPiPLrOrvkTYwRTun+omeQjL2dnvAH4
         o23vk2/T/tN+7kbFjrz59pkVqogUB+dF3nolaqmYnay6tZVZ45CCxz3FoHx7eOkGMVFF
         kTc4N6e+U43IT3nbSbuNY+VEuKY1IqOKRK9b4/0ThRyeDMxsJnQD17F0erbZvJ0UdMZk
         CPelH8AqJBP8ekePJGIlmhoJt3o1v5/10cITSk9EsZf/IhE/u+4hzFjYk+Y0BlCihI06
         dkhQ==
X-Forwarded-Encrypted: i=1; AKwUvByDC+j0pIE6ag39nIiAxzvoxxpOOCBd2PuypPGn+AZjTvAOqMvEnUy7IiH/lGPga0957cYER1o=@vger.kernel.org
X-Gm-Message-State: AFuF++moClC3ubAk2Heqqfs/oe5ePCoGgMGd9rn6UCs+nmFJ29N1yCHD
	zOYOxtt9lfD91l81QuC6Jasy7+wkqoJb1hSDsmGePShNZ+qiPyOc68q5WjTg1Q==
X-Gm-Gg: AYBFou3AaC8PyRIxjZ3r09u3j80ob0cGDuHe+RMNE8StRMk8SuDgEZRwFTIiZE8Yab7
	rBJ7WmzqTvbniLCVmu9hFZqJelUGGVdZ61wqP2uFcDL5SPqp4Zz31rxMlWSqS02+nVIT9iJCEU8
	poLqUmcobpHA1sfRTdWxw4t3xhpInde1YOY9pd+mt2yUkGhJwGHwGH6DoaOUzlRq89xDJt6vsOE
	xZk0ZFaaoQpYbOPVapgRioPtz5JplsDRh3TrVe4gqhVyDb0W/VHkYMYkwmJxQ5m3W3c1OPQr8Mp
	LPgwpxTfb9ToRohFhuGsGhyOeT0NqT0aJ22+O1dvdmMQR1L60HrQ68L88N2hzMmxLxGUqK7586r
	aMHqvBFu/hluOcPmRk44sHKkqsSgtQzInENlV7dFDxLUJQfK4lGCcCdGBKGYQI2zmoNHag2FR0g
	5lwtI3GolVtsvAJlFyRZM6ipO1uqkUMYLsJ30Z/sKlSrKh2qcq8CMqWvlJv1XSTLqnrSdsgDeaW
	as7gvuo5xAdvLJHf0iqNiSK307TJ/cBJIn91lVano3yF4uzvQSW/9nQlZnb8/4+YTlcRppTTlCM
	LPyU4uR+/1/tr5c=
X-Received: by 2002:a17:90b:520e:b0:398:9be8:ea65 with SMTP id 98e67ed59e1d1-39bac3c452dmr5568713a91.18.1788929890882;
        Tue, 08 Sep 2026 21:58:10 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612ba2bsm28999461a91.14.2026.09.08.21.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 21:58:10 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v3] net: davicom: Propagate wakeup IRQ errors
Date: Wed,  9 Sep 2026 11:57:37 +0700
Message-ID: <20260909045738.16705-1-phucduc.bui@gmail.com>
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

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---

Changes in v2:
 - Add a Fixes: tag.
Changes in v3:
 - Remove the goto statements for the error paths in request_irq() 
   and irq_set_irq_wake().
 - Drop the Fixes: tag as this patch is intended for net-next.

 drivers/net/ethernet/davicom/dm9000.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index b87eaf0c250c..e294b365eb06 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1511,7 +1511,11 @@ dm9000_probe(struct platform_device *pdev)
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
-- 
2.43.0

