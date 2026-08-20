Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD8041CB2E
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224528; cv=none; b=RoOhXhXQET2hsGekW75W8B1PCK7R+iees6S/dYEFzbatCidii9AEyh1lzblaVcBhmO7v3ZJbOQCkcZQUDcUqIPkJn7OtyU3eM+iogEKEF95M7wF1pVYgR0TTjMKi/7mI+lXVRzqZJFcChRa8RP4VS6V611j7KQwtsyba16nczTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224528; c=relaxed/simple;
	bh=bnOez2D7W1xADEeYSlrlChjQSRZM4eKefXSq81oer5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYfGC0s7FSoBbf66csxA5SjnqkJi8uL39P5AQ86hIcQqRQ3vb8gpaGErbiC6j+XJ0z8EZgcC3AZA/cq9ltBZIFO+Sl1vxTGFsdNWih0XFjy5xQvbfVMUlbSe7hEOZg5GdsKRnuz+/UAt+d7xm58nIuuDj0P8vYN7OWbDRZCzo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJKFpWqA; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJKFpWqA"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso1373121a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224527; x=1787829327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0EV4ghgeCZRM5rzTYzzjwsX6ZmAWQhJnMm9mekXvTWM=;
        b=aJKFpWqAKakPkQJC+b4Qf47S8gAU0AqtM4dwYAwgz0caF5GLBtx+M8b8hqNe739do8
         MFuwJ563FGAoeDd4DfKPKJMH+miUgHFm4WY9fDBZkxvQO/hCVs3JAoPQfSCQemtHsSrG
         GBnR/YIj+1s7kZi8x5kBOfRGnpSw+OnhwinyQICY/uftwqj/1OOLd2/O+T0nymyyqDqw
         rr6f71ZM1SR58xReT9vGPeNazF14aqE828Rt0CgaH1qgIsqfhRLjRLq2zC93STsmnFXj
         61tIiF6dT83TH4kRJWg33XTPhXPhzAypfTbt5FW3omP4zaq/8Ap7wErapfCGBa1JYhOl
         hpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224527; x=1787829327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0EV4ghgeCZRM5rzTYzzjwsX6ZmAWQhJnMm9mekXvTWM=;
        b=W7/+Rb6XPpP8ZW8V691CGf/UK8gihjqGHpfPhqLWk64J9P+68Cr+ZGICJQEGmMKVYr
         6p2PcrLNFTSv44a5sTkCPY3PGntIM79l3JjY/lHbLU+sHr74Bv2zV/zHLJhuI8fbHZ2d
         DH8WwwU/y8MsevIiyZojtd8BmzrAQFBkcUnpWsOsDUpX4egjcp3Q8U3K1+OTNyh5D7Hr
         SqDW7/EIxE/N4XBxlUAGnn/QBmBJ+6OJ7HeuqMAZqqPPoaHmWo7k0cDzgxUYNIVR8HDn
         Cv/oT0pwQl2aPFl0Uve1XS0Qaxjb0KB25jOlNDOjOx8joujeCGZ81xEX7iR+plwjrrGt
         hS4A==
X-Forwarded-Encrypted: i=1; AHgh+Rp2XVW+qzAKYKPP1/lq2ZMW6H3J50u1927kU54cItbwCZOvfrBBMngnHtOSebBoXAIbyr93TgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiCNsW7PIlW5d+VA+VTV2L+GbVDI7Z0Prp5GPbrXe5/oKLbUYO
	zviI62HHO50A67HfMyswhwFBI9OAiCOd9/iT2H9rMKuc7vBlxDbrR7Az
X-Gm-Gg: AR+sD13KZSKaE1smAU2BRV6Y8GfLDASKLUgP1xUEY8XlzlmFMrd69GPjIx+E+1MHmtz
	ajmhx8q8LAYP9jh4Biv5IqvdXV7We3noOUiizSZFYSo3goen5LycE13cqgro7jC9a3uv5KL8o3s
	8f9DYXxs1nabuRB5UU/4LuhMSZIs5ZoXG0VRow3pBogfBXqghfvc68+u91F5UM4Is1dJEqtmZ0d
	EsaSBvb5nJi7ymkZmRr9C+KZrvDsa2DqVdMb9YlLLNwZ3TBdCePpvJ3BvGQLom04oUaxEP1Nad1
	c/B+S0lyj4UDmIJC80ujj8PwYZtqgfvbJkeL5oZU/bTMQqx7gOhRdK7vNeDUqu4/KXGHckieugd
	csqc+kjeUQsBgmhmosJucDbEv3cila6zNes3gBFPQIIZ4uPwCJvEg2ISkdfeUrvDDtE9DIJ6xwz
	ych/pToInIgzNGrIo3/pv5vEfGJRRFc6ngQe+72CulS2QHGXDCIjQ5HWG7W7n8hDLFmf2R1c6t4
	NA66XWwBv/YFfI+gbVzWlitpo0S8ewG3GMkC+N9+HOFOCgBms7Me190Zd+oGrAKErEEx+XJBxxU
	h6k5
X-Received: by 2002:a05:6a20:2443:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3cd010d6404mr21262791637.8.1787224526694;
        Thu, 20 Aug 2026 04:15:26 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15568c722sm1676503a12.24.2026.08.20.04.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:15:26 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/4] net: bcmasp: Propagate WoL IRQ errors from probe
Date: Thu, 20 Aug 2026 18:14:54 +0700
Message-ID: <20260820111456.97947-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820111456.97947-1-phucduc.bui@gmail.com>
References: <20260820111456.97947-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

bcmasp_init_wol() currently ignores errors returned by
bcmasp_get_and_request_irq() and allows the probe to continue.

Return the error from bcmasp_init_wol() and propagate it to the probe
function instead of silently ignoring the failure to initialize the
WoL IRQ.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index d66a8bbd6e38..02e88adf4939 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1106,21 +1106,20 @@ static int bcmasp_get_and_request_irq(struct bcmasp_priv *priv, int i)
 	return irq;
 }
 
-static void bcmasp_init_wol(struct bcmasp_priv *priv)
+static int bcmasp_init_wol(struct bcmasp_priv *priv)
 {
 	struct platform_device *pdev = priv->pdev;
-	struct device *dev = &pdev->dev;
 	int irq;
 
 	irq = bcmasp_get_and_request_irq(priv, 1);
-	if (irq < 0) {
-		dev_warn(dev, "Failed to init WoL irq: %d\n", irq);
-		return;
-	}
+	if (irq < 0)
+		return irq;
 
 	priv->wol_irq = irq;
 	priv->wol_irq_enabled_mask = 0;
 	device_set_wakeup_capable(&pdev->dev, 1);
+
+	return 0;
 }
 
 void bcmasp_enable_wol(struct bcmasp_intf *intf, bool en)
@@ -1321,7 +1320,9 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 	bcmasp_core_init_filters(priv);
 
-	bcmasp_init_wol(priv);
+	ret = bcmasp_init_wol(priv);
+	if (ret)
+		goto err_clock_disable;
 
 	ports_node = of_find_node_by_name(dev->of_node, "ethernet-ports");
 	if (!ports_node) {
-- 
2.43.0

