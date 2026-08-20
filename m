Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D490417355
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224561; cv=none; b=TfdR+RFKdfXB3XN63d8u977TWcStZ48YWGerNIc7LagNoJMs6xbi3SPHFqG9/vmTwO/OmWRfIN0o231a2AcH2UbLPWmu1VbPvK1bfkkOrWmg3BYCj43KqVvBfAdmM2iry3xJ7kUAW12hpVLOnxwNDEItoKk5Fd+TglG4yPFfDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224561; c=relaxed/simple;
	bh=25xWmE1Aw5OhhpAVuAXQnuyzKV0mIHMiuoUcNa77BFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkP8K27bTw3CuTcY2qtMKE9+gFpe6kVbcPQAiYs6RGznGhVvtfWCZbAkmVyTP77/25CGwtL11rEPJ8h8Fwdf9pnG1eUNe/hR/xJc2+0eYEjM46cCZzU64JdbC96Z5kQxzK1oUyzzT68YAsTxwTT0Iew7/ssbk9B2nKhTpXvpPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRtQwhn7; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRtQwhn7"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38101f85591so617698a91.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787224559; x=1787829359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K3bUlSyExGxMXTwtT3kv6u/5DTQGMhNhhhuxzC6RV5U=;
        b=KRtQwhn7qtQrkp5Cl6A/5jCgXtOwRPpfTJpfHBsVcRDdUcX1D2UR8/8Sh9UkRTzsEq
         1ZsNPfNhcZFe81QM8PPbtMA4n5dl4+etuGee2wG7bBETbBbPIW2gcfeVaIsc6Jg41Mbq
         2ZRVnqRQLifRVSqFNMGm+MqUqNCWscsOkJS8nA1lGd12yq2j8ujo8C+zcFzY45j1kY7p
         KSfGvHHBHDdpKhP75La/EayTIDB/8pucN5PBMw9kvw7FJDfzQXi/BYe1hA8Lfd81f43X
         y0LUzWX9mYOQO2TlUc+OQPOMD3rkm4QIV6sUcckQnENAoAFujaZh80IMxxrtLXHRH9w+
         1EGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787224559; x=1787829359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3bUlSyExGxMXTwtT3kv6u/5DTQGMhNhhhuxzC6RV5U=;
        b=WinwNLIeufSouO8d/u10Aop2lI/Sb+P7Cjj4vbyWMa9zLgHUzuTG4JcloLnQ91+Dxf
         wooD3iRbI814chgsUG1a3rXmP+X60NwczOIZnekpo1RCsaECFJt7t2xCM8uYwiZvRd1M
         W3axNrje6PSxc9pkqLghO4x2+2e/uL6Nygu1mFFwR32L5kvr9wj4BoZZhcYtqxJcEWzM
         OliT2Q/BCxyaGO2Rw6d36IhsyqOIgtuhHdGk6B541bHZ/qpUT0HGtXwCIZ9HOTMISLr8
         cssinxDoZKHKIdYLO1boopKvGiT9C2RvTTdsPKZW38U6WhmRAOMton5mlc/pQ93mn10D
         p+8Q==
X-Forwarded-Encrypted: i=1; AHgh+RoP5+md6msOkcu6ssfC/g32WF2WgQB0qs5RqFeL6vrup2ZmLpbcFjtiU13GRJaDhXcMiP4iLjw=@vger.kernel.org
X-Gm-Message-State: AFuF++kJWkYQdkY3Jz9j5UnZivmB1JvSiR41q2Qabg4NY6YYbfAXk5OW
	1a7/ujfk143IQ6jw29wEq6twBT0ecyWzZUVDUIDf7n+PSCncf9hJj+7t
X-Gm-Gg: AR+sD12ZOlIsYt+uoz9xjXjKgoiNBMEp7PkTCcBXxb/wauH2IiGA67nNeFORyfkA8J2
	rMIxeTuy0omA0ONx+Ax0hbIO7gnlRv5aHn5vGgRKb9n9LzEuvu9zeXUrzHcGMvYZSQUNACA8jgG
	J4xdgdS6+sdKRsJdzoYbBiEWX9CCxQxn2aI+99B49ikaJQqDOPq3JrDvyYYp9yYmu7qWhTtmkgA
	uVNXJMJ8Qtbt9zYNzNJGFGm2wyCa4qYR5E4Qj8iU6W1PCC4CI4Ww0mtsDv84Jdf+AypfkWwnbOR
	y37uF01LLeyurAFvoVrK0002iw4niEZillr1DunT/L6GMwAOc/y0FgAEdUDNNIsob7f4NX/H/yr
	wHA3oxsXUdo1YkX8D1b0NOaZsIFZ6LtMc2ZKmZvfp9mB2ajHymuKut1W50niNF13sE15c+qqBQM
	nX7g/wGE7Kc11IjiQuz/XWY1KppTW5WhwxG6iW4N8d0IYwbmR/GEBlqZ6Cb4nwJBsV2iTbVwSgE
	rn2nwubPyp8AgZJqln+P2+0a6CqodRH1EC0Le6SXcBSa1ybPtYyXe6Hln/ea4bclGh6SVBv94iN
	75eE
X-Received: by 2002:a17:90b:2584:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-395a074aab8mr6160121a91.10.1787224559411;
        Thu, 20 Aug 2026 04:15:59 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb51271sm6803505a91.7.2026.08.20.04.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 04:15:58 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] net: davicom: Propagate wakeup IRQ errors
Date: Thu, 20 Aug 2026 18:15:47 +0700
Message-ID: <20260820111548.97990-1-phucduc.bui@gmail.com>
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

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
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

