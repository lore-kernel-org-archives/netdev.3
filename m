Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BC2EBDE9
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099396; cv=none; b=uOsMJnu5KJ/eICxsrCyTDxSUd07Yswt+NIJegWOkfgHSfee+Wfl2NFshFcWlqhbWE7DKDvudgX7+ziRm6NuzIL2Jhv9bPU+E7CBQYTGGxgEnOS/YBwAqsH8tRI+nd/51BkcHKqFG8OD4CEVW8bY0r9+BCqnGJNaYJYIhDVAvo9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099396; c=relaxed/simple;
	bh=OIgLDadHm6v3Hhfp+LeVPKY+DdMyNj+RWmDObrAfsfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ids23Vx67+8n8opo12W3Pgiu0ZWA/xtBl10Bw2d/aXj8Am8j23LN+/Q+GXBGEijClhdlMCeWL/bwvEP3wkvwg48OW7K4PWf1YBA2IKFXVY0l0tEEW4mOBu175yL3FF0xWFXsIUUTzewxqRTf95UCRSWq3jh+JMjd1VcmPQUqPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ql3etVol; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ql3etVol"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca06b03so1534325ad.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789099395; x=1789704195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMNMLyka/PxRqW+FEjSX/JhUiPb37rME7mEkb0i98KI=;
        b=ql3etVolrH49pB+DaUji8O5wrQ7ZYcxX0M4OAsmr8ZpYvHTVSalzkNFA+hV30eUClo
         YBaZcY9fiTnZxmgaWq1uJSrHLtQ5RGj4sw12dZ6H9RZ0h2WPJ0BMFwTIq2dvZ0WOKRIs
         mpUbsgDw/McnJk4h/t4LoBqo2rBpNrVpGY5kT2kldPhDjEw7AlzFBISNp0UcOdzO2tQX
         /7nmYrd6puNRtnEHZ1N8gVbXJbinswg8Nmjv+XMFi2DxTX8sdbI6gJcuUw7z4D4es3OJ
         H1saLAKVyz70m9h9oCi0wHlg0KC+utF68FRoyBLfyCoxFbAmiy7WlT5jSEhZnzyGsQOB
         4xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789099395; x=1789704195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMNMLyka/PxRqW+FEjSX/JhUiPb37rME7mEkb0i98KI=;
        b=GPY+DqXPmUtOCTr3VqlXGViwBBWy5II1c4thS6nUwbWMde7M9oPjyvg1alrJ8uQ5yv
         OuLCRCdfvZe0ns80SchbQ600eE9wEA/ix2Gxdq3XaeGq19ct0xn4GQtnjUGfpuhWRMxn
         57UO1UwTJV/sqtlwqemjJPgfB9UQj7hi1NrsHxjoDSuyUIGZNiAzm9hu/5gpDLdarV2M
         wzYYI7b3CmANq2pPLf1Q4tiywIbJdP3KjWBot2L1nsv+r2ainWNgmlAY9Ecw1NHF4Ygy
         94ljBi7n7WMppkqcvfFzqq6CgihbpxUREdN9Zp6bwu2Y1iI/rnzg3sFR3R+F1yLHG3Wg
         FXig==
X-Forwarded-Encrypted: i=1; AKwUvBy1Eov09+FIT4zs4JuuWPLDEbTcrO0yLEHbWqWTOKvXSnCdXInPAyZcdLBlCL35Ob/GdsKMXLo=@vger.kernel.org
X-Gm-Message-State: AFuF++k19CHr9bjhZfX/6j8Bp0Mbe/3mOovX+Zm9ZQjLWfkpb7OPwL/R
	7qWnVnQeRHc/p3ntHpt+KwgFpaS52L/zxoMiBRrBbV9dJc5dIEuwyiY8
X-Gm-Gg: AYBFou1t37lFyi3nHaHln0vKuMJHGuygQulIOtOWV91CZiNjrhAS8fixAI4JIXGr/C7
	nFDRUe83in9F+hItPMBBoqOFfJZmyx9jkPZdWRhEE8qsIwF0CawuGWi6kS+k33dCDLb9K/BU9no
	z/xtbiCHRtTBHCFr1W7SrRYhgeSsJJ6KtqGvz/q+ol0qA2cVtDnTC6TyFwv86JKZfSGNCSOquT6
	2kajpAFPEdWPBfAUh4XWDYrDkCnQtWKgxvdAGp4Hx3+J1qzWyXXgPv7Zx7devxhaDCLZp2QazQ+
	oeDwLp9EYH3GOA463loEBvCVOsbPoVQSiaZO4x3NBaMXM6nbSrkNhOUqStszfHrJA505lVepM1K
	o4TcPq4s1SIRz+nGrg1oGf0BxjZmlGB0Xc3R/+f43BSYVvH0G3pMvs7lNWZ5ChDHGZXu4BQYfa8
	Shfdy4DILri155MJCWQgpoG4njQ24w3Sr7RhcagCtTz3cs+0H5bXXEH/Lp7nfMqll9FO09lt1cf
	TmxRoBOcfk47m+6FvVjSK0iQHLq2s/gom2x67+pEf3p4WKp+EeCKy42YBrX+muEh/AYXBl48eqY
	MKbs9ZRpMn8JJPGsap6ZaExK7JA=
X-Received: by 2002:a17:902:ecca:b0:2d8:d4cf:fe49 with SMTP id d9443c01a7336-2dd2a4550bcmr29793865ad.15.1789099394759;
        Thu, 10 Sep 2026 21:03:14 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc2d3bsm4670925ad.48.2026.09.10.21.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:03:14 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH net-next v6 2/2] net: fec: Handle optional IRQ lookup errors correctly
Date: Fri, 11 Sep 2026 11:00:21 +0700
Message-ID: <20260911040021.12289-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911040021.12289-1-phucduc.bui@gmail.com>
References: <20260911040021.12289-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Handle errors from platform_get_irq_byname_optional() explicitly while
preserving the existing fallback to platform_get_irq() when the named IRQ
is not available.

Propagate errors other than -ENXIO from the optional IRQ lookup instead
of silently falling back to the indexed IRQ lookup.

In particular, silently ignoring -EPROBE_DEFER can cause the driver to
continue probing instead of deferring as required.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c6e29b5c2abb..f7636f23d1eb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -5397,12 +5397,17 @@ fec_probe(struct platform_device *pdev)
 	for (i = 0; i < irq_cnt; i++) {
 		snprintf(irq_name, sizeof(irq_name), "int%d", i);
 		irq = platform_get_irq_byname_optional(pdev, irq_name);
-		if (irq < 0)
-			irq = platform_get_irq(pdev, i);
-		if (irq < 0) {
+		if (irq < 0 && irq != -ENXIO) {
 			ret = irq;
 			goto failed_irq;
 		}
+		if (irq == -ENXIO) {
+			irq = platform_get_irq(pdev, i);
+			if (irq < 0) {
+				ret = irq;
+				goto failed_irq;
+			}
+		}
 		ret = devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
 				       0, pdev->name, ndev);
 		if (ret)
-- 
2.43.0

