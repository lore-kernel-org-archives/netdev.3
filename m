Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C633045563C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684462; cv=none; b=dvW8NQ6Gcg7zkGm6PJEsSPkrDh/b8nl2JRNLLwxgdaKFNPkjkPaHseTPeJ8eF4OWHxGs/Pt2Kp6fna83/rJcWk9+sptmueD0Yybr03nj5A+C8/5Fvn9X4gVvBrfSPapkdA1m56hoerUKyXlJgpwIzt95KBlh2I84Lr1M734IdV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684462; c=relaxed/simple;
	bh=97ZdlDOT1zsc9shggZe4pcdmtviViWwWImxSzSasOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition; b=kvJbyQxLK7qTwN/1FgxD4qb+VCwBmZJ0zDMkG+1fsjKcsebQPpQHBxJ/r9TpK+ACitvnhkYuOZnLhpsNSN6rqos9Y4a5VfmWAf6b9ghVXohVkcfgoJi62OK9t/eLUvAOojlUHDJt0iwUUccNlKXtxVyc8zkr1IidOfbMZdoFk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=bIqrcjNe; arc=none smtp.client-ip=209.85.222.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bIqrcjNe"
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-982838c4cccso68838241.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789684458; x=1790289258;
        h=user-agent:content-disposition:content-type:message-id:subject:cc
         :to:from:date:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mP0cYoxxpm+bHnvqZGpTtuMKlRy9j4QXXTGcbvOvgmI=;
        b=hpP4rBabaPGSUTI1b0M3W59gwz0pfGV0xp8d0HHHM79dVPMqGryYPZWpVFW4zvcnwK
         5kNMVJyGEUZBwpLzH3UmaYDGqlyFk9sbDZ2Tx0ymqN+J7F4Cu2G5BYXHGO0crSrG4/+y
         oAR3AFkIyAf9ojGXosNxaI4bOMmxo2AotN3cuiBKzqdeYby88/Ib9vw1n8ygwnbSlWRT
         M1JbOl4tkCI21tmpIX06wCWU7tW0byvXSNSyoz11nrME6LYMfBleNfuucOMFjqtkQ25x
         c07USxxvgMFo2FyVuSCpQuqWixyMSiruVM07aAJI6eVtc3kD2N3YXr9hFeOfBxQAGSsB
         giqg==
X-Gm-Message-State: AFuF++m6i99E56XkRiAgbx0uX93cWGeHtrdHRCz83aXmZbnTKy00+OHF
	eOTlW8J5VFQsiGKRv1VHNN8L8DrRF0a0jvxelCJCRkyHU5v9vSjq8MSxrAroykOzfxER24VmB2K
	pgGrGuH12H4t459D4B6avPdtzF1tYHbqscg==
X-Gm-Gg: AYBFou294ZOAaYBvAIfPc0uv+V/sufw/zFPwMSWqK2g/omCAQ8c914QEGPzX4+4OYrg
	cWlZP2MAgbUCbHiLQu+obuC/g7H3IkhTmpOZn1VUKvBsKiSOwQvdM6sZhv4G08Gh9THYNi3DifT
	bQuGODeTYgtFHZSvG7yNVYNlrcv/KasuYcKZ3zh7zoRysO1Pf0X6ECFzyY946m9zprTJLYDsB9B
	j0Etmj6E91Zg7pvQrZXxD12X8aaudL6I2R8331PF5/H7JUIvlEOWmzR1Zp4Ytz3eJXRCe1oDqEz
	KkHCPHGKxb6cdC3gizbcrti0VvGSD0fedraGxLLT3hZ4rBgcq9FLah1vMLtrAj3KmeX4SEEgPRh
	757bV0rMCnqGhXjlZG6qzvMZdp5ZIirE=
X-Received: by 2002:a05:6102:61d3:10b0:736:f95c:4bd4 with SMTP id ada2fe7eead31-7a1e8138ae6mr1000529137.6.1789684458154;
        Thu, 17 Sep 2026 15:34:18 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx1.aristanetworks.com. [74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-9832326cf49sm1326058241.0.2026.09.17.15.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:34:18 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1789684457;
	bh=mP0cYoxxpm+bHnvqZGpTtuMKlRy9j4QXXTGcbvOvgmI=;
	h=Date:From:To:Cc:Subject:From;
	b=bIqrcjNedmYJ7ItfBizIBDnJY4sT7qHw/7Doma70AKGYfAt7pd06DJ8S2umVORZvv
	 lKzYkTQ5Ytsh5covN9th0ltxIq3FNkjWtELk00KBk8yIWowHZvYz4cKOKaUViH9yok
	 3oHsWMQOJqnbNqAtjvuSSKFO0kpFbpR82Zekx99v9WAgXd5emWIGA/uQTLUDRCR78p
	 m33eowQRtpRUxlfdUcNciw9x46O1CTxvi6Zpb1fZY13OA0bRlkz2+JCWBcTc5zvFbP
	 jKyO6+NNtsb5YOCwjRynPQICgrdeIaMpAPEVejMRWpIvTQ9OFs5T3oTmLAK/m7roqT
	 VtzAf6SC7aW1A==
Received: from visor (unknown [172.22.75.75])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 355B61026BF;
	Thu, 17 Sep 2026 22:34:17 +0000 (UTC)
Date: Thu, 17 Sep 2026 15:34:16 -0700
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Vincent MORVAN <vinc@42.fr>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Subject: [PATCH net v3] tg3: use random MAC address when
 tg3_get_device_address fails
Message-ID: <20260917223416.GA245819@visor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.12 (2023-09-09)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Some of the tg3 NICs we use (BCM57762) reset the SRAM MAC address to the
placeholder address on link flaps, tg3_chip_reset, etc. We've typically
fixed it from userspace, but since e4c00ba7274b ("tg3: replace
placeholder MAC address with device property") was merged, tg3 just
fails probe as we don't have a way to get it through the generic
device_get_mac_address infrastructure as fallback on our systems.

Make the driver assign a random address in this condition instead of
being fatal for probe.

Fixes: e4c00ba7274b ("tg3: replace placeholder MAC address with device property")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20260909191751.651aa5c4@kernel.org/
Signed-off-by: Ivan Delalande <colona@arista.com>
---
v3: handle EPROBE_DEFER, set deferred_reason through dev_err_probe.
v2: https://lore.kernel.org/netdev/20260914230521.GA1400582@visor/t/
    assign random address instead of changing the logic in
    tg3_get_device_address.
v1: https://lore.kernel.org/netdev/20260903233255.GA4109366@visor/t/
---
 drivers/net/ethernet/broadcom/tg3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..813181590bce 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17914,12 +17914,17 @@ static int tg3_init_one(struct pci_dev *pdev,
 	}
 
 	err = tg3_get_device_address(tp, addr);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Could not obtain valid ethernet address, aborting\n");
+	if (err == -EPROBE_DEFER) {
+		dev_err_probe(&pdev->dev, err, "ethernet address provider not ready\n");
 		goto err_out_apeunmap;
 	}
-	eth_hw_addr_set(dev, addr);
+	if (err) {
+		dev_warn(&pdev->dev,
+			 "Could not obtain valid ethernet address, using a random address\n");
+		eth_hw_addr_random(dev);
+	} else {
+		eth_hw_addr_set(dev, addr);
+	}
 
 	intmbx = MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
 	rcvmbx = MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;
-- 
2.43.0
