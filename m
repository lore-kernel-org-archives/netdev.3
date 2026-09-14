Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD737C93F
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427125; cv=none; b=tlFDhRilxzR2YF/YLCnhBDUmQZdteNw+1baLzTBTCjN3y+gRhEK0aDgc8PtUDw/h1Phft7h4SlfXO14SGjyQO3bh6y/XI/oQh0ySh0PpQSGbqGh4gavBLpqDARwkaLJEtkGjtFuKHVeyUieGLchco0UCsvZfFLe1SercMdHVOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427125; c=relaxed/simple;
	bh=dsfaITMVZz65MsuFQ+M7Xpr+iEuTbBuMlBkQdDCzdIc=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition; b=urr3C/Sh51TJXuGwqsyLk9o6oFsqrhdSC0uqKVTP4jDm5yNbM1UHbJ3q09c53Yt6+xNoTAra5DHX4iggZpTr90xqdFPTCcOc6u2n70qEWs/elfzA3bd8WiCIp1u2OY8KdeL4zHYBVffo903Aq6V5V+xlhiUE6eCCbq+6qXUPLvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=T3suBCj5; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="T3suBCj5"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so416841a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 16:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789427123; x=1790031923;
        h=user-agent:content-disposition:content-type:message-id:subject:cc
         :to:from:date:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SOL4N9oHtN998PZYk6Q5zVKt0HttTCKyBeiKToHbJxg=;
        b=Utj6uKpnvw8QDLyU74qsdw8Rj9p5KgyIktR1njKgKiWDYS8QAVju9ug5YsfesimoKe
         rQimxu2PqlDpi/8pH3diBLWq/Zbz7QesuN4xs48J6tdRmwK0U7uC+JO/BKhEvhzsnM/S
         tRlmY1pgiaKBpE4ann/U1VWi8DPC4gZRfKfHMB21PE8w1KnAPcuOg8l+JIHIbF9iLl3Z
         IxrTTb3beovmPEOawjDXYYZqBSrB9nGYufQjXTn+2mIzaP+20AcWwyVl6sTmGQxQ5NC8
         z6BwzkEoGBnN7o1twE9YlUy4eirGr2cdPfHBKXpBUqklmYMY6jWbGbbmyEkfpgJ7jrHd
         0aGQ==
X-Gm-Message-State: AFuF++kj9u4DmiFLMQw6mM5ZSifDqoNVorugZkT2SIaZkRPhLW7MrsRp
	fMGlm8/IBtKsjLgYcWx05P3USy/AQbBgQg823i3vFJj4JMqpqe96SG+Hm9GbIN7RNOzb4sFxlXq
	vXOD8MevMWKtAh99PVJ/w55+87hKmuoTszA==
X-Gm-Gg: AYBFou3T8ovuQo4KZDPspKx1XDqbWIw+SMYpkZbxvwxCKPUioR9GDHhqLSHnCYMt8r+
	sSbtEPbdNbgBdeCt5eHqYkH+pSF48eNQJqFGgAa6tTjwwJBfI/w2buaSNIdR7625J0VvpmSA1GS
	l/4BjUi867FyXXO/vkCh88v0jco0H7fLPgOQsoB2/Dsf+K6AGHXJL8Z9FTVBTaQI2cEXgL6fy7I
	lo0MD3Kdz8QDpobkV65yVRIRNVb2tiTtXB+DrBZHn3lzAf2mYmg1xRGxib1+OnfncC39qBXdtz/
	PDSZuAXE2Oi+KUULGWo2b7p/K31+p0ieSexOldjUUcfEux+8bFFuK3lxzNft+nsG/9e5vzw0qfU
	wuytyGRbNZBDioEARgjkuL0hTQ8ppVrI=
X-Received: by 2002:a17:90b:3b42:b0:39b:3510:49e7 with SMTP id 98e67ed59e1d1-39debdf8e2dmr8990612a91.0.1789427123066;
        Mon, 14 Sep 2026 16:05:23 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx1.aristanetworks.com. [74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39dfdc39bc1sm492882a91.1.2026.09.14.16.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:05:23 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1789427122;
	bh=SOL4N9oHtN998PZYk6Q5zVKt0HttTCKyBeiKToHbJxg=;
	h=Date:From:To:Cc:Subject:From;
	b=T3suBCj5Tnh/LeuAEwygmffHGLVoDBEam/o6JDQZ/T/cI+yMFTQQ8my1BzQWqF9ki
	 vvIr8YEXWQEUQFoWokc7BA9z0azioe8pQLN0bQrtigC9BgjSuNCz3EZWMhl6EQ4TBW
	 Q8Q07RDn5aiJqOu1CXiakFC7Q7lPZ5ZKhgBF1MmRUsyOIembnc67USMcwbCEAfFBrD
	 0putatPIHLPNPQxV5ZcyM1thZpx+zjVW3V+GcvGaU4rS9qav52tRu9KSbQM8PgzB3K
	 28UBuRxtBK34MaPdtHYL5wVR/9DxkKR8c3By983q05AjRDF8gutf6ccMDARE7y2CmY
	 c1sEg4f6j4BcQ==
Received: from visor (unknown [10.95.64.175])
	by smtp.aristanetworks.com (Postfix) with ESMTPS id 4A5DB1007B8;
	Mon, 14 Sep 2026 23:05:22 +0000 (UTC)
Date: Mon, 14 Sep 2026 16:05:21 -0700
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Ivan Delalande <colona@arista.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: netdev@vger.kernel.org, Paul SAGE <paul.sage@42.fr>,
	Vincent MORVAN <vinc@42.fr>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Subject: [PATCH net v2] tg3: use random MAC address when
 tg3_get_device_address fails
Message-ID: <20260914230521.GA1400582@visor>
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

v2: assign random address when tg3_get_device_address fails instead of
    changing its logic.

Fixes: e4c00ba7274b ("tg3: replace placeholder MAC address with device property")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20260903233255.GA4109366@visor/t/#u
Signed-off-by: Ivan Delalande <colona@arista.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 73a4b569b03e..75cb0b0fab2f 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17914,12 +17914,13 @@ static int tg3_init_one(struct pci_dev *pdev,
 	}
 
 	err = tg3_get_device_address(tp, addr);
-	if (err) {
-		dev_err(&pdev->dev,
-			"Could not obtain valid ethernet address, aborting\n");
-		goto err_out_apeunmap;
+	if (!err) {
+		eth_hw_addr_set(dev, addr);
+	} else {
+		dev_warn(&pdev->dev,
+			 "Could not obtain valid ethernet address, using a random address\n");
+		eth_hw_addr_random(dev);
 	}
-	eth_hw_addr_set(dev, addr);
 
 	intmbx = MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
 	rcvmbx = MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;
-- 
2.43.0
