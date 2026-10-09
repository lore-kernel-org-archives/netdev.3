Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7D470450
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556541; cv=none; b=hErfcuWGyeR64AmytrUNa8PD5XqnnW0/sxcnfqOExuFAC3KUFkyQiCGC6xDwCDN7xCMp2ZhDfSJS2CP/5KFYiwkc+nGx3m41YFszX3uMHH54tZbjIHN9vr4eBJkQCq84NJ0b8nkJsTKzapwBRSa0oBFQbxahAjIP1d4lX6OS67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556541; c=relaxed/simple;
	bh=ARJUZomiNWr2Esi35N49l0FhoUlm2R7xfcFwjyL02JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/vj79yMJ53RI9JjzC0zwo/E0hOiWmY3LoRO4KiRucX9J7U0aMPxVWn/yR9R1kRV4c//76NFwpUh5nIIly8BdLnsoR/m5KmQkn94xWgSwCST1VMSXXt4SHqdDVqIzJORMS8iqYes3VKpXwxYQei/TiO2sttIBgrrYHEuX36zeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=kY3Ipb0B; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="kY3Ipb0B"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917aca1aee5so80689866d6.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791556539; x=1792161339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnICXPRNt7kphCrcnyQTA5McOgtnsdRXgEC40bg24aY=;
        b=kY3Ipb0Bwk2iKVIPw4yeVy7dmFbIc6WFEbalyseA6R5Ima7CkngmC8/BlbZuYUEtq0
         AZm9hIRCNSHnwFRqRVwFz5kNbum0Tjw3G1cbdev1YhLaO+RYPpI5pergEDtumOMLrtQB
         2kyUfeJ/zx7NQTTWitx/B3Ou/aMNl8/8Nzl15xTF9z4o7OOJDLmZ+PFNfgOhPP3C4ZZo
         xUp28NWVeAJrHKDvdpONoGdKW6w26KfIRw9BPNJy7ZrWYkgOr3oyoc5WKLXvmxnpwghY
         pEkLoGX/k22Hi1BODJpjieterxvYW+vyHPuboeK136iGKV9Pv1rRrjdW8VjOaq3NP7ny
         RX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556539; x=1792161339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnICXPRNt7kphCrcnyQTA5McOgtnsdRXgEC40bg24aY=;
        b=iECR4NMOK9LO7h7SAkZu37g9N04fi6GbaLr334rZ9cEY5+ZJXMpT86fG9Jx1OAYBi6
         AB72HlBTx8ADjVNaTT0T5NqPOem/zmc6v2+yUzCa9utrlWywIy2ZG2UmH4KEOpYV2Ism
         R6/OoB9FtJTF+XhKrfrYY81jTa9Abli8xnLg2vcTVkDqAJENmq8vDbrIflk7PHMM3l4x
         ymigvIw9fH7x10gzBQtdlnKEnDEz9eJly9/sAwkcRxZTIuO5nh3ttAw1MYn4RLGFLEgN
         mJhVoaMk4m2HawUJcFBubZw6/VAMDyGgjIq9wF0YGkfpM6LNGTwRhdO1zi/PtbWrzWk5
         LVHg==
X-Forwarded-Encrypted: i=1; AKwUvBzoSmSA6iTt64XTp/TFT69xcyr4UBKTyxqS8NUsItvmAXDYbpca2AioFzOH+DwD4fkdwsf9Du8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmJZKkNWbsrweBSmVP38SgY0TTY+PkULRXTpy9AkmBlmBlHwm+
	CvGNi1PFUXGwqj1474R4NdteuhfxO6EkWW8nK7SNdZEFstK2az6UjrVBkO0wAIBchQ==
X-Gm-Gg: AYBFou2RktpWFxa5V40grPi6UurSlqCqDTehwbgeHhWrgsuwnbEpojvCXqVbQzQziQ6
	5vsLTU4ygwGfd2+0uRCh3Fl0av36LBJsPJDnBHMPCjLsN6Hu2njwkZk1zFLG0tor7/gjlerTo7a
	SL4eR+n4awKImBCJI9Pbiwb0NKv42AYkA3Ha+7IB3TOXljwPLLDuGPRBQP2jG/DS4zbOw3b0/05
	qf1+fmXpkxPaRRdgAIT4dIRqpT9XzUQAoHBWytHniU1LXy+MSuKEYC97c8vZt6ZW536UP7Aqy0F
	5DC6ZQ26dTD9pZAaJ0bjWiGBZXUOUBGKh063+65frwJpJLhSomuiCrDnOZ1hLIJu39HN+v9EDsj
	yRoJAP/uMhvwKR7OGRg7XztXYCPDV4RSoyrfSnheiqf//4hlT/hoSBKq/pzlp5TTFbaHPHt+LeQ
	8stQthfD1tssGK5Yfev0r4bFbU1vBTqd9nLvAtV1LrUBRGzplWmQ3JkBaeauygOD/KEBLVEiY=
X-Received: by 2002:a05:6214:411e:b0:914:483b:82ea with SMTP id 6a1803df08f44-91b5555f8b8mr34591656d6.33.1791556538673;
        Fri, 09 Oct 2026 07:35:38 -0700 (PDT)
Received: from cantal.lan ([58.136.72.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501751dsm19769456d6.17.2026.10.09.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:35:38 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] net: macb: implement timestamped MDIO writes
Date: Fri,  9 Oct 2026 21:35:05 +0700
Message-ID: <20261009143506.2507607-5-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009143506.2507607-1-jjc@jclark.com>
References: <20261009143506.2507607-1-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement write_sts to provide system timestamp bounds for completion
of an MDIO write. This enables tighter system timestamp bounds in PHY
implementations of gettimex64.

Take system timestamps around the command register write, then add
the time from the command write until the MDC edge that clocks the
last data bit, calculated from the peripheral clock rate and the
configured MDC divider.

On RP1 that edge comes 63.5 MDC periods after the command write. This
was measured on a Raspberry Pi CM5 with its BCM54210PE PHY. The PHY's
PHC was read with PTP_SYS_OFFSET_EXTENDED while the MDC divisor was
switched between 48 and 128 through /dev/mem. Any error in the number
of periods would make the PHC offset jump at each switch. After
compensating for drift, the jump with 63.5 periods was under 2 ns.
The MDC divider does not appear to run freely: the spread of the PHC
offsets did not change with the divisor.

Signed-off-by: James Clark <jjc@jclark.com>
Assisted-by: LLM
---
The 63.5-period delay has been measured only on RP1, but the code
assumes it holds for all MACB and GEM variants. I am not sure whether
that is a reasonable assumption; if not, write_sts could be enabled
only for RP1.

 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 95 ++++++++++++++++++++++--
 2 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 1cb2778fe49..3670731690f 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1334,6 +1334,7 @@ struct macb {
 	struct macb_or_gem_ops	macbgem_ops;
 
 	struct mii_bus		*mii_bus;
+	unsigned long		mdio_sts_rate;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	struct phylink_pcs	phylink_usx_pcs;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c4223ca848d..cec6e5a48e9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -384,11 +384,47 @@ static int macb_mdio_read_c45(struct mii_bus *bus, int mii_id, int devad,
 	return status;
 }
 
-static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
-			       u16 value)
+static u64 macb_mdio_sts_delay(struct macb *bp)
+{
+	static const u16 gem_divisors[] = {
+		[GEM_CLK_DIV8] = 8,
+		[GEM_CLK_DIV16] = 16,
+		[GEM_CLK_DIV32] = 32,
+		[GEM_CLK_DIV48] = 48,
+		[GEM_CLK_DIV64] = 64,
+		[GEM_CLK_DIV96] = 96,
+		[GEM_CLK_DIV128] = 128,
+		[GEM_CLK_DIV224] = 224,
+	};
+	static const u16 macb_divisors[] = {
+		[MACB_CLK_DIV8] = 8,
+		[MACB_CLK_DIV16] = 16,
+		[MACB_CLK_DIV32] = 32,
+		[MACB_CLK_DIV64] = 64,
+	};
+	unsigned long rate = READ_ONCE(bp->mdio_sts_rate);
+	u32 config = macb_readl(bp, NCFGR);
+	u32 divisor;
+
+	if (macb_is_gem(bp))
+		divisor = gem_divisors[GEM_BFEXT(CLK, config)];
+	else
+		divisor = macb_divisors[MACB_BFEXT(CLK, config)];
+
+	/* On RP1 the MDC edge that clocks the last bit of a clause 22
+	 * write comes 63.5 periods after the command write.
+	 */
+	return div64_ul(127ULL * divisor * NSEC_PER_SEC, 2 * rate);
+}
+
+static int macb_mdio_write_c22_sts(struct mii_bus *bus, int mii_id, int regnum,
+				   u16 value, struct ptp_system_timestamp *sts)
 {
 	struct macb *bp = bus->priv;
+	unsigned long flags;
+	u64 delay_ns;
 	int status;
+	u32 cmd;
 
 	status = pm_runtime_resume_and_get(&bp->pdev->dev);
 	if (status < 0)
@@ -398,12 +434,32 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	if (status < 0)
 		goto mdio_write_exit;
 
-	macb_writel(bp, MAN, (MACB_BF(SOF, MACB_MAN_C22_SOF)
-			      | MACB_BF(RW, MACB_MAN_C22_WRITE)
-			      | MACB_BF(PHYA, mii_id)
-			      | MACB_BF(REGA, regnum)
-			      | MACB_BF(CODE, MACB_MAN_C22_CODE)
-			      | MACB_BF(DATA, value)));
+	cmd = MACB_BF(SOF, MACB_MAN_C22_SOF)
+	      | MACB_BF(RW, MACB_MAN_C22_WRITE)
+	      | MACB_BF(PHYA, mii_id)
+	      | MACB_BF(REGA, regnum)
+	      | MACB_BF(CODE, MACB_MAN_C22_CODE)
+	      | MACB_BF(DATA, value);
+
+	if (sts) {
+		delay_ns = macb_mdio_sts_delay(bp);
+		local_irq_save(flags);
+		ptp_read_system_prets(sts);
+		/* macb_writel() is relaxed; order it after the timestamp. */
+		mb();
+	}
+	macb_writel(bp, MAN, cmd);
+	if (sts) {
+		/* Flush the posted write before taking the upper bound. */
+		macb_readl(bp, NSR);
+		/* Order the read-back before the system timestamp. */
+		rmb();
+		ptp_read_system_postts(sts);
+		local_irq_restore(flags);
+
+		ptp_adjust_system_prets(sts, delay_ns);
+		ptp_adjust_system_postts(sts, delay_ns);
+	}
 
 	status = macb_mdio_wait_for_idle(bp);
 	if (status < 0)
@@ -415,6 +471,12 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	return status;
 }
 
+static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
+			       u16 value)
+{
+	return macb_mdio_write_c22_sts(bus, mii_id, regnum, value, NULL);
+}
+
 static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
 			       int devad, int regnum,
 			       u16 value)
@@ -1141,6 +1203,13 @@ static int macb_mdiobus_register(struct macb *bp, struct device_node *mdio_np)
 	return mdiobus_register(bp->mii_bus);
 }
 
+static bool macb_mdio_init_sts(struct macb *bp)
+{
+	bp->mdio_sts_rate = clk_get_rate(bp->pclk);
+
+	return bp->mdio_sts_rate != 0;
+}
+
 static int macb_mii_init(struct macb *bp)
 {
 	struct device_node *mdio_np, *np = bp->pdev->dev.of_node;
@@ -1166,6 +1235,8 @@ static int macb_mii_init(struct macb *bp)
 	bp->mii_bus->name = "MACB_mii_bus";
 	bp->mii_bus->read = &macb_mdio_read_c22;
 	bp->mii_bus->write = &macb_mdio_write_c22;
+	if (macb_mdio_init_sts(bp))
+		bp->mii_bus->write_sts = &macb_mdio_write_c22_sts;
 	bp->mii_bus->read_c45 = &macb_mdio_read_c45;
 	bp->mii_bus->write_c45 = &macb_mdio_write_c45;
 	snprintf(bp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
@@ -3095,12 +3166,20 @@ static void macb_configure_dma(struct macb *bp)
 
 static void macb_init_hw(struct macb *bp)
 {
+	unsigned long rate;
 	u32 config;
 
 	macb_reset_hw(bp);
 	macb_set_hwaddr(bp);
 
 	config = macb_mdc_clk_div(bp);
+	/* Record the pclk rate the MDC divider is chosen from, for
+	 * write_sts, which can't call clk_get_rate() under the MDIO bus
+	 * lock.
+	 */
+	rate = clk_get_rate(bp->pclk);
+	if (rate)
+		WRITE_ONCE(bp->mdio_sts_rate, rate);
 	/* Make eth data aligned.
 	 * If RSC capable, that offset is ignored by HW.
 	 */
-- 
2.56.0

