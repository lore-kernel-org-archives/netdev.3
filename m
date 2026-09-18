Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B00B27C162
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771641; cv=none; b=rVQ9EaQ6J5uoTvGj+PVC1xTCduqQvpj6I7quUfIjT7U4ho2l78pVoBCdMlFIzEed0qAnx4K17H0USjtcDF0/JLocxWCTT2i420C87t/7Dan70NuFJyrjGoKvZFpSbFrlBqV7XbGwhWrNU0SRRC3gRqTZrNhsLdC61ly+ALaNq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771641; c=relaxed/simple;
	bh=bUAY8Rum2xsReQr9j/8ZVLVg6PW4ZVPSz/T+5Q01E6I=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition; b=TxHKNqswR/rOTFUB3bvfilnW7vXsYJjlgcXgBg5X3PdTHSUK5b4/v3pjSShDmDZ4AoDqi4PXaa34HiFaXh2gpPrkOREEEO/k7ryqtTBm8LSSpyR/A7rUXlbwPcL0M4djK4a4hNT8F6Sy+SmryO07/p39f4+6Z+6KF2YDs7ycibI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=U/zhfvrf; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U/zhfvrf"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4aa0246b7so116770a12.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 15:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789771638; x=1790376438;
        h=user-agent:content-disposition:content-type:message-id:subject:cc
         :to:from:date:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D02hM4Fy/1MDrWCRTzBNpesn2aSdDSzL3J0cl6adKXk=;
        b=apUoF4GZWAySUs4hNb6Sz4kRr6/GDj7/1TvX6kxz4x2zbEHBxxIRyR3ivF7s/YJOg3
         TzQx9r5iP1OaRuk3JQYfwpsBCsgrVb1Gw86s+bwqCFIK5WQYFvj+aEdjSfqxbrw94A7G
         Il/BXMxMn0HiMbjoTjs/Xyo8HtZX3uEUWD4IaWdY2jsIjapMvb3dvoPTwSHd2PKzG4rZ
         mlhI+opw394nrndy1ek/5wAjaxuXO3LDXTzs8eC+jkumbPk5Smap9Wob+8MjYe2p1/EF
         cXARSUa1Z3OcicFITyTRtt4xP8JIR05U3LAZJ+4edkaGEM1oo3ng2C5I+rtzLirjD9L8
         plWw==
X-Gm-Message-State: AFuF++no0Uu5tExKRfGb0971fm82RdeZA4tql7KnJuze7+J0KxSKeTNp
	sVs/xS3ER4/Mwq+EGrMeKN6sfhd1mSBamnjyA35ydqdrAPmcyV5SYGtxj1FqKi+dazOt8Pcnxnl
	WwuCHgcocClUF+mvmR3e2hTrFoWa9Z7wbpA==
X-Gm-Gg: AYBFou2lTqbjz742AbHWJ08CWXakHBbzCm81NehSZcP2UBypi0hnmoEBpOqE7r0M772
	EUQETlc7jWIk77jAfKUkFJ5klvREnZHwGJ0YXoyJ0iL4YK8usy7GmEkf2QrT8fDfBaLK9tUeOyo
	W2Uo1cvB/0ZdM4rxANPacMQbgGaOOkMktia3uXw89uGhLxLcFaMPqjc2/Hre6TZrwFzw3Vz/aiC
	HY18+9DxVZr62Jf+oVCeJ/u09iN9yC8qlyeCjOohrhhZeW4d1Bce6/AnRYNCWfAjOTgF7ZUG+Ar
	CZzISUIjfneijz5NqRKNxFWavbRbufJaK7OstCHYAAHnQx125k+6qT3fbZQ8M1kQGl2mheijvyD
	AIteXL8TzmzA+uK0vrJKe8iWFVDp4IA4=
X-Received: by 2002:a05:6a20:a10f:b0:3dd:a196:3092 with SMTP id adf61e73a8af0-3dda19632admr1240199637.66.1789771637896;
        Fri, 18 Sep 2026 15:47:17 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx1.aristanetworks.com. [74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc72acebf6bsm309688a12.2.2026.09.18.15.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 15:47:17 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1789771637;
	bh=D02hM4Fy/1MDrWCRTzBNpesn2aSdDSzL3J0cl6adKXk=;
	h=Date:From:To:Cc:Subject:From;
	b=U/zhfvrfCTi90tgPp1NAQLghcQbVjAErxH8fBPh9BbDMUXtEfZZOty3hP1qyPDfkg
	 bjYLDcCyYCgr6RNhRjSun1fE78O3x9IGF8rHz47ubydNOznXaCUbkPGSiM4eJZQWYT
	 q3JTTbnaI2MVmLb8EbkP4M77fISfeeTno4ydjUP12AgxcjEFMhgVSUGYNJa+2oqzmZ
	 05S6pEKRRIkX9aXVVhiHk5/qVnH5L5A5qF5m+xvQrWQjFHLsNz23jS+wtJ+u0u5Apb
	 2RcYnKsJa5ewixKM1JsLtET2+iwbtBzLneN0rkR8q1+WSVsvPBw8butL8v9xu7EoBZ
	 hsGwQxbV/j9gg==
Received: from visor (unknown [10.95.64.175])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 1F63B1017EF;
	Fri, 18 Sep 2026 22:47:17 +0000 (UTC)
Date: Fri, 18 Sep 2026 15:47:15 -0700
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Paul SAGE <paul.sage@42.fr>,
	Vincent MORVAN <vinc@42.fr>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>, mchan@broadcom.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v4] tg3: use random MAC address when
 tg3_get_device_address fails
Message-ID: <20260918224715.GA654128@visor>
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
being fatal for probe. Set deferred_probe_reason through dev_warn_probe
if the address isn't yet available from the provider.

Fixes: e4c00ba7274b ("tg3: replace placeholder MAC address with device property")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20260909191751.651aa5c4@kernel.org/
Signed-off-by: Ivan Delalande <colona@arista.com>
---
v4: use dev_warn_probe and the more compact calling form,
v3: https://lore.kernel.org/netdev/20260917223416.GA245819@visor/t/
    handle EPROBE_DEFER, set deferred_reason through dev_err_probe,
v2: https://lore.kernel.org/netdev/20260914230521.GA1400582@visor/t/
    assign random address instead of changing the logic in
    tg3_get_device_address,
v1: https://lore.kernel.org/netdev/20260903233255.GA4109366@visor/t/
---
 drivers/net/ethernet/broadcom/tg3.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..6b8cb5b50f98 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17915,11 +17915,14 @@ static int tg3_init_one(struct pci_dev *pdev,
 
 	err = tg3_get_device_address(tp, addr);
 	if (err) {
-		dev_err(&pdev->dev,
-			"Could not obtain valid ethernet address, aborting\n");
-		goto err_out_apeunmap;
+		dev_warn_probe(&pdev->dev, err,
+			       "Could not obtain a valid ethernet address\n");
+		if (err == -EPROBE_DEFER)
+			goto err_out_apeunmap;
+		eth_hw_addr_random(dev);
+	} else {
+		eth_hw_addr_set(dev, addr);
 	}
-	eth_hw_addr_set(dev, addr);
 
 	intmbx = MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
 	rcvmbx = MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;
-- 
2.43.0
