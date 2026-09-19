Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86CF31327D
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789838523; cv=none; b=SjORpWCLFVb5Qz/2H/lfro5yLBSgh8gaSzkKnqJQ7z9zNDTSCO5vUWwrvNG7LY2dH2V0yF+Yk8lmCLDgYd/qmqOOukStMUKqepKK62fxqq96dyGMJEIMSswZUuBGz2seoyWyjMFWViRFAyJUI3eC6/oyEFOqWHV6uzAFO5c0KS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789838523; c=relaxed/simple;
	bh=GllVSDw6kg+iLMkp+9y3znXzr+FskJwzrrqrjJ08FKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqQiylZpMe46462OoH2c0+zePsOWvZ6RaRCzXHxPteUYVSEe88mswANsoYp0YW2SDqUGZSlpxADB/DjPbFXYJloCwbMeHfL88NC/BMiO2PnjINB5hP8IpVhOdiLhcNHI9z9RJEMMtf/hpy8Ad39jUVHLW5Um82yWAkCcOcsT9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6BxKIdf; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6BxKIdf"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-398b9f722abso919089a91.0
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789838520; x=1790443320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gd85OUKLih1FwD89RxmCVAwGTJLLVkFC9DviJqE2Mj8=;
        b=S6BxKIdfnFoGrzqs3g9+vp5goqYqsuhIoIbKTXdcPDXZfN197AO5rQgOKpdQUM/omn
         qMU5SBqHRQLw1Sdy+dJJgcFnF7GvlOW4oMNmwYs2wkwPMWvgoYqTUP5IQmCRfoa3dE5C
         lf+cAXMmfLPE3VvoFIMnCMxoPUVYQrZzLf8gpwPmpm6vCr9gZyH40ZYqixFHhWu9m73e
         zP6mT3KTm73PN0gHyKHe9SAX5kBQyzUjixBJD5CB++WueAoZB++bdNsZWQC0wS/XLof/
         Equxf/4m/q2o+D1ZDRxvMr0ZdId690vWXab0mximwvwNdgNIJwbQyReYnBLA9NZ4qfpj
         ufUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789838520; x=1790443320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gd85OUKLih1FwD89RxmCVAwGTJLLVkFC9DviJqE2Mj8=;
        b=gSKxYBtBPAYmeqPVcZV3sMKz7/ogt/orgQ5w5nfJOHANSsVDR3ArHe4QR7JdovwZI6
         IBu57lKrkfbahVDjaE5zwN1hXqZRZbgb/UlqmdMqvDeQmiN5PXtDD+loJHfpNWb10tHL
         pN+/ocqXS2i7MyafT/Yg/4tkdZ3nJNU5/GT2/WmPwlYBgF86pxIjc55t8XrlkYp8qvGf
         9tfr/JA5NVNzeK5dow8/GU6PGpH5CPWr3DAI85wCpLJN0ZSZb2OLIStsEWEovafwsadI
         9EP5xtwW3ALH4BiapysNjrM2LD2isPUH8rK/rQ9yP5WaQbcJIMUIP26ZQWi/AzE/h87j
         WS7Q==
X-Forwarded-Encrypted: i=1; AKwUvBz05QX9MUkrz9k/d3OEXsbNQg8iQr0SaIflP9f68TbGLHzqW9ZJv4QnxdV5G3NuIS9IJUswj6w=@vger.kernel.org
X-Gm-Message-State: AFuF++nczVWwsTYkolFdgIz+LRt9RdOA2Edj7gDXwXotHisapPKhWycM
	3SWxcJz2bDjX+gMUHQu48IdmbhQQRBez6x5wk2gXD6seVYxnv/oHZ7VB
X-Gm-Gg: AYBFou0YFmIC8JAD1Yb5izDKhgIbvJxdvQCkpYdXMl7BtUx2Kocz0Yw2xQxUUyZRJ7d
	8l/LaRsuBabWMtEJOb2q4Fx0+Z5gJXMyxgYdPu+vtlnKEhrdLbIC+hZWj1itRzl2qBz9hMBAsHO
	beOc6FjjhwN5BK4tCALjytvOWlTH6jIuxDlf3T6k+Y+1L4V1DNpBur/IrkUHl2rBQvjv9wVermv
	yF1psJbsquhGKP6ZKvaMzhDcIMFaNjh9DsvHIlEM19pYjLCNjL5KHWWvGBEc/hddWs8p0eE42wi
	6P76XHf0OL6owuvUt+OHTCkRbJ6sQcssGIO/n63v2L6iVYTQwToSAckbfr3CEQBYc7clDKUK15L
	tIMzQTzQ1ePHuyozXGBv5YLuwMFhdqx3q9IPLpO5p5GBx2FWgAK94fqc+TwxY8noRjUvFxcujeA
	ie4a/NbCl9SXCaYffMp56z0t2Aj8VBFK8sb50F8WVJo+aLPiUJI7U7byBtpsEgda/cmHWrJpLrx
	GliWDeH
X-Received: by 2002:a17:90a:1057:b0:39f:d323:c988 with SMTP id 98e67ed59e1d1-39fd323d93fmr2258003a91.48.1789838520515;
        Sat, 19 Sep 2026 10:22:00 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145e5sm5773510a91.5.2026.09.19.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 10:21:58 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net] net: pcs: xpcs: fix clock reference leak on xpcs_init_clks failure
Date: Sun, 20 Sep 2026 01:20:21 +0800
Message-ID: <20260919172021.2336748-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xpcs_init_clks() takes references with clk_bulk_get_optional() and then
enables them with clk_bulk_prepare_enable(). If the enable step fails,
the function returns without dropping the references.

xpcs_create() handles the failure through out_free_data, which calls
xpcs_free_data() but never xpcs_clear_clks(), so the clk references are
leaked.

Add the missing clk_bulk_put() on the enable failure path. The
prepare/enable side is already rolled back by
clk_bulk_prepare_enable() itself.

Fixes: f6bb3e9d98c2 ("net: pcs: xpcs: Add Synopsys DW xPCS platform device driver")
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 0337e2bcc012..b415b93d77c1 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1545,8 +1545,10 @@ static int xpcs_init_clks(struct dw_xpcs *xpcs)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");
 
 	ret = clk_bulk_prepare_enable(DW_XPCS_NUM_CLKS, xpcs->clks);
-	if (ret)
+	if (ret) {
+		clk_bulk_put(DW_XPCS_NUM_CLKS, xpcs->clks);
 		return dev_err_probe(dev, ret, "Failed to enable clocks\n");
+	}
 
 	return 0;
 }
-- 
2.47.3

