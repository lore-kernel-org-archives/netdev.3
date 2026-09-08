Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2B379ED7
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845261; cv=none; b=TKYBcwRWB7qOFlKd0i5dYSQQSen7FRIp4kaBXxpXsDUWoI30HSzaOojFFm1YzD1hgwg0Xun0GtKXmXpavqRtbPX/EMYQe3MTnzGjrX4J2HRzEtqAnJlUHt+OHOaP1rmwFaoQwuVZgJ90ER7sDDVyGbxZ1HFTwFSs7s0ZpsG5SwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845261; c=relaxed/simple;
	bh=Og17tNfr1MSjCFANiTkltISsVC58pPAzd5pXj79CkxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=us0deYUEjPmyuxfIAgHRSnuhBurkVmEZEh/z2mVLk2YfdkG3DXGv8EpBmRdutNpRmeb5cRcAy2YA/hj38j3lohECRWplpZyIqx9T7WAQJxvgq0/5rkgWBMlRqDe4siH8nGKnxY0EXNvrkBRyQJjL2BdHtkEnaoFaXe5cMEHZW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7JpBQHP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7JpBQHP"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e04df8c46so4594491b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 22:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845259; x=1789450059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ThgDhRyE+Y72EBv7/U4oxOtCi6RtEmzsslCG/DRcvA=;
        b=l7JpBQHP2vk6WBDHMcRbNgK6J/qmwni0n9s+ftc/g6ut/zo6aUSEQ4S0AD35ywi5hs
         LvklrhDE3M7Exzsxn4UCAn2TT4M6PtYdfk9F4klqmOJaEJMj/Beo5pX5l1P9AmuJEZdF
         MyapI0DL6iWZlTzYC3McI2BOC3BcwrE5tZLHvM3gulpTGYmryDW7UReN9jkYqpu861H9
         Kzw5JSQ/h9ewM1fi6bOYl/dEyExm9d9SDnKp9an3FWlxmDsNCWl9/HIB3LRvBxQUODxc
         bVxjvabZoyeJYVe0+c1loOwPl1IpyGZG9tytk/C8+ZiF4ZI3teiHjOoRDpPwR844lhjr
         aawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845259; x=1789450059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ThgDhRyE+Y72EBv7/U4oxOtCi6RtEmzsslCG/DRcvA=;
        b=jnKtVm/DMtrK8rd+MvBkR4VNL1uJvbdjVGIfpy3E2l93mz7aWvIWjLp9vXOLhQZK34
         5vGpDkIvTKDw8outgh5nmSyx6ZIFVirDa4Zn8jHw+v2t5oue5VLlkc7SKvnzXzAf6tln
         tg4fd4hzb3YU8UEHnJhJFzr80zMp3aCnaJ2d0mG56gD5pZCQQHzf8k0o+ZoSF3HWwFHz
         YI9GK8hwVq8zevbINwODXTCe0yVWKHPZcLHOWV5ZkLehoiAGZi+dvKx3zqg8t7SCHEUa
         UGOglE4lk/5jTVm0eR4BwkzKxmkaJf0Iog+YP4R8shOUL6nlFmgWYM7FAVvQKc9cHho/
         U+sg==
X-Forwarded-Encrypted: i=1; AKwUvBxUiqaNdpGL2ax2De8y7y4UYsOqSdHG3GEdU3XIk7V/OqOLe8CetOEWOL5+Cp99CCr7msJ4uu0=@vger.kernel.org
X-Gm-Message-State: AFuF++k6abXUxi0vffnkuJWxJACWl5JrwRRKsFJVnB3jvBV0N3FfGkIG
	OyYyZGSaoKPlzqnhT+4J8jMMo6e/oaeL45dIAilV43auF7JR9ZpAEMaa
X-Gm-Gg: AYBFou22eWOrIpWAADQBs/IO0A22f9WqH6WyrQVLivnqYbXyqsNxSunA3gBgXEmUwnf
	I2NfKBk6MtuYF8y73iHUif7pLlr3q4OHxrOjhhZ5BW8s8n/2xfFTI+tnzWA9wocYO1jtCDOvqRn
	nRxfwmaR6bdB7TuU7/tYgk7t0Km1VsFQra4LPGOho1IuwFFN4aW0C4hLgnBIn+eySozKjF1CKBa
	ya82c5TIMTTvv13V3buHivto+SB7Ad5abxROcjcpUxqoyJA5+AV/jKGUVZ3bOM5hEzCYT369yFq
	wXzCcfplLb8rYyb6IAADBKm0eGIUp0343+2DetfEFMac6Eo2CrmvEQME+9Y6Xs2NoqiA8xRsZbY
	b6+7udELAgWAkay/S4Rv/vbNNhcErIfiHAeP6z6YlXF8qBDSiHMXV+jtTi+aA/p+U61jPhF9Mjx
	Q4SumFMKG1Vg7l50AEn03F6eSatJ8wsQA9s9YTCSXD5ZYeLIGrWCLWb1jMgq487GCLCkdIJtMbC
	Bbx7tBsnT5Xuw==
X-Received: by 2002:a05:6a21:3943:b0:3c4:1493:6822 with SMTP id adf61e73a8af0-3da3a0aa8cbmr44065672637.18.1788845258816;
        Mon, 07 Sep 2026 22:27:38 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm11720586c88.9.2026.09.07.22.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:27:38 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Chris Snook <chris.snook@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Geetha sowjanya <gakula@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Manish Chopra <manishc@marvell.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Verma <rahulv@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Russell King <linux@armlinux.org.uk>,
	Shahed Shaikh <shshaikh@marvell.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 10/10] net: dec: fix typos in comments
Date: Tue,  8 Sep 2026 10:56:02 +0530
Message-ID: <20260908052602.27497-11-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908052602.27497-1-hemanth.selam@gmail.com>
References: <20260908052602.27497-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspellings in comments, found with scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Comments only, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/ethernet/dec/tulip/de2104x.c     | 2 +-
 drivers/net/ethernet/dec/tulip/interrupt.c   | 4 ++--
 drivers/net/ethernet/dec/tulip/media.c       | 2 +-
 drivers/net/ethernet/dec/tulip/tulip.h       | 4 ++--
 drivers/net/ethernet/dec/tulip/winbond-840.c | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/dec/tulip/de2104x.c b/drivers/net/ethernet/dec/tulip/de2104x.c
index f38a10c79907..fa52e099409c 100644
--- a/drivers/net/ethernet/dec/tulip/de2104x.c
+++ b/drivers/net/ethernet/dec/tulip/de2104x.c
@@ -373,7 +373,7 @@ static void de_rx_err_acct (struct de_private *de, unsigned rx_tail,
 		  rx_tail, status, len);
 
 	if ((status & 0x38000300) != 0x0300) {
-		/* Ingore earlier buffers. */
+		/* Ignore earlier buffers. */
 		if ((status & 0xffff) != 0x7fff) {
 			netif_warn(de, rx_err, de->dev,
 				   "Oversized Ethernet frame spanned multiple buffers, status %08x!\n",
diff --git a/drivers/net/ethernet/dec/tulip/interrupt.c b/drivers/net/ethernet/dec/tulip/interrupt.c
index 0a12cb9b3ba7..8c02771b28e4 100644
--- a/drivers/net/ethernet/dec/tulip/interrupt.c
+++ b/drivers/net/ethernet/dec/tulip/interrupt.c
@@ -177,7 +177,7 @@ int tulip_poll(struct napi_struct *napi, int budget)
 			   pkt_len > 1518) {
 			       if ((status & (RxLengthOver2047 |
 					      RxWholePkt)) != RxWholePkt) {
-                                /* Ingore earlier buffers. */
+                                /* Ignore earlier buffers. */
                                        if ((status & 0xffff) != 0x7fff) {
                                                if (tulip_debug > 1)
                                                        dev_warn(&dev->dev,
@@ -408,7 +408,7 @@ static int tulip_rx(struct net_device *dev)
 		    pkt_len > 1518) {
 			if ((status & (RxLengthOver2047 |
 			     RxWholePkt))         != RxWholePkt) {
-				/* Ingore earlier buffers. */
+				/* Ignore earlier buffers. */
 				if ((status & 0xffff) != 0x7fff) {
 					if (tulip_debug > 1)
 						netdev_warn(dev,
diff --git a/drivers/net/ethernet/dec/tulip/media.c b/drivers/net/ethernet/dec/tulip/media.c
index 55d6fc99f40b..0c9694d2b38a 100644
--- a/drivers/net/ethernet/dec/tulip/media.c
+++ b/drivers/net/ethernet/dec/tulip/media.c
@@ -24,7 +24,7 @@
 
 /* Read and write the MII registers using software-generated serial
    MDIO protocol.  It is just different enough from the EEPROM protocol
-   to not share code.  The maxium data clock rate is 2.5 Mhz. */
+   to not share code.  The maximum data clock rate is 2.5 Mhz. */
 #define MDIO_SHIFT_CLK		0x10000
 #define MDIO_DATA_WRITE0	0x00000
 #define MDIO_DATA_WRITE1	0x20000
diff --git a/drivers/net/ethernet/dec/tulip/tulip.h b/drivers/net/ethernet/dec/tulip/tulip.h
index 5e010e1fa6f7..e39e5c78d4cc 100644
--- a/drivers/net/ethernet/dec/tulip/tulip.h
+++ b/drivers/net/ethernet/dec/tulip/tulip.h
@@ -250,7 +250,7 @@ enum t21143_csr6_bits {
 	csr6_ttm = (1<<22),  /* Transmit Threshold Mode, set for 10baseT, 0 for 100BaseTX */
 	csr6_sf = (1<<21),   /* Store and forward. If set ignores TR bits */
 	csr6_hbd = (1<<19),  /* Heart beat disable. Disables SQE function in 10baseT */
-	csr6_ps = (1<<18),   /* Port Select. 0 (defualt) = 10baseT, 1 = 100baseTX: can't be set */
+	csr6_ps = (1<<18),   /* Port Select. 0 (default) = 10baseT, 1 = 100baseTX: can't be set */
 	csr6_ca = (1<<17),   /* Collision Offset Enable. If set uses special algorithm in low collision situations */
 	csr6_trh = (1<<15),  /* Transmit Threshold high bit */
 	csr6_trl = (1<<14),  /* Transmit Threshold low bit */
@@ -274,7 +274,7 @@ enum t21143_csr6_bits {
 	csr6_om_int_loop = (1<<10), /* internal (FIFO) loopback flag */
 	csr6_om_ext_loop = (1<<11), /* external (PMD) loopback flag */
 	/* set both and you get (PHY) loopback */
-	csr6_fd = (1<<9),    /* Full duplex mode, disables hearbeat, no loopback */
+	csr6_fd = (1<<9),    /* Full duplex mode, disables heartbeat, no loopback */
 	csr6_pm = (1<<7),    /* Pass All Multicast */
 	csr6_pr = (1<<6),    /* Promiscuous mode */
 	csr6_sb = (1<<5),    /* Start(1)/Stop(0) backoff counter */
diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c b/drivers/net/ethernet/dec/tulip/winbond-840.c
index a5581f1d0141..be9199f55a8a 100644
--- a/drivers/net/ethernet/dec/tulip/winbond-840.c
+++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
@@ -1188,7 +1188,7 @@ static int netdev_rx(struct net_device *dev)
 			break;
 		if ((status & 0x38008300) != 0x0300) {
 			if ((status & 0x38000300) != 0x0300) {
-				/* Ingore earlier buffers. */
+				/* Ignore earlier buffers. */
 				if ((status & 0xffff) != 0x7fff) {
 					dev_warn(&dev->dev,
 						 "Oversized Ethernet frame spanned multiple buffers, entry %#x status %04x!\n",
-- 
2.48.1

