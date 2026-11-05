Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857761;
	b=s4aiOadRauG6ivzjEGGhskpsTN2pN/llwasHmNwjj/vkV7WYRV7R30Jiy6x+156VdCJQ
	 FRynCWAmBqYOWjwR2mivWDxJRfRk81Hy/9PsKKfMCQ/8DD51hD6uUVOl6bocFVsWyTW2u
	 ekU/XPUJqM1yjDi0DtZuPQblFXQCJVUHUP7IN/sExocAC6/5kT6R9u5qu5pIu4sm/HpS7
	 DcApt3I8vdEzjkPWpoQ+JuRGOazNVBa0M1aMddegAKBOBERGIFDvBqxzhBkJQ2p4rTZv5
	 /AjIHVc7d3ZAEknc9d71dtpwzayNjBC5Owh2vnK5Tf3stdKey/pqeqGWhN1LzY2JDIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tcMipQjCxk6KpxhghZ33X+zD0NDiIBNGo1RCNpsRpC0=;
	b=M8sE08DmkAqsWF9TjZSOtKre/MPqMCTGGy9gS7r/Wwq/3TYcFU9GbYZ2mLDdbSlM4SdQ
	 dBjR5l14yBre9G2s4qcsItHjdhmeotZJgzUQy/JvLSFrgZFWk0/jIc+/URLce14VA3tB2
	 qdXq6dupZfDMKv34xFaqmReaZ5Tg0A894hC4HdmScBt6vCYRtv/aUziTVtqTjBJedORH/
	 Whgx0HAGHj6FFfjoJJRx53XvrDR7weqHW0t4FBBzurewoTG+H/lnhnlq8gKF5SmxJcX/t
	 OYxju38jkhwkuaBuZ0J+IHH6vZ4yOZ1CNbibJATnUezPU4vV7FF5ZLJ/Sj0PbhTjeCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Wy9SrfRT;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B0606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B15B0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Wy9SrfRT
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1076861a91.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793857760; x=1794462560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tcMipQjCxk6KpxhghZ33X+zD0NDiIBNGo1RCNpsRpC0=;
        b=Wy9SrfRTldNls0AxzaGcFYC4tVRUG531DXAaFntVkITuXsP+elg52r9Y7mSocnvQEE
         yN4BLkkgSMpFrX7Q6/fP9aZuA8kD2zh26CWgC4rDU/Tsyer1TCJ+p2uXQEjuVsw/0J77
         Jg7plRJ1ivgHYTr3U/GdwvYuh7DDwBENe0h7nXK3j1Olbnb+2V7vWBtBDUvjcCsRTiQR
         lWLmM9/qoFc1MikB70IF/y9XYCAcumI6EbB9UqYthYHkOuQuRt7UUUuUAhd6loWeDXl7
         JuQ5gxoUhuna109NElo5pokZR8JetliAjfz8Un9Cb3imQO04uJDyXMl4SBzHIjiKFj/T
         6VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793857760; x=1794462560;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tcMipQjCxk6KpxhghZ33X+zD0NDiIBNGo1RCNpsRpC0=;
        b=VTPYEfiopySD7oyDtsz7L3g8/eVJ4pdWYRVoq8pmVsMNlOeGhnss++7gE088vxf8qM
         awFMW/oUm6P7USfCzmYvR8SlV4HE+5aYLc2t4aR3bZKaUXVZ3KQTBT2GD7vvtMhAtW3H
         xC5WJUXKuWmb0qbDgMV9jWvdwV31CHPlZqQ47LfLyEn/m0EkKWfdMe4H4hRCy4sln6iL
         i5VyHcRUCKdkfjisLdM4oBK05zUW01STQLLSOG2B+dhWPhlVAnmrsRRr4+BFqnt2bEUP
         U0VD1bYJyU2nY0MiIuxFEaG9MTM6Uaiqfil4TjGANB8HDkjMxeGQoErVtZ0mT4MAC44Y
         9UKQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDcAhGMH4bdWUyXBDgVFnCz++x6evPfbFX57M4apHJLDsEM/hh+y+1I20AH2jYHMUvj2NHRnY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fwwp+whmOseGxn/QKw0Cop5A5KC7IQ9T8+19pXPM5/ghrYaGM
	sIPl78+uwsuPcKB0mNc3gYEeu41W3M8d8o6owLEbDrtPqVSQ6C6IEp2xQDvbtUb7CQ==
X-Gm-Gg: AYBFou3LJ14gxQSCZ1a4uDuZD772J6ZhEHPrHDaPjHdJ8rp15aHLEbiX5n3WDQudx4r
	E8qV2SQSrf4Tv7aiDgAB7M0+0S4YK0Gf1VQX9BrfzHqm7T3To4FrnSnEwSN5ociuDHojK45whbg
	/1zY40TP9v24QarqQQeC97QNBk3yIqEgGRUwzktuiU4keocZXe2h5+nFLxMZvt0OnwD4V9rOczE
	Er0p7whvB5u1wfpojkH/VeteJi+F7FvHdeikHjiW8TwiDH5qojcHvbXlxR5t3bHBLjWImrke7FY
	T5f7zEPCSNECoezcIV8uPnWZqevMp3BbksZzocSWVV6I8KnFj2h1tXbE7cTFVeUhmSln2dtFo7r
	HlerKzP+oeohVjDlS91ZnI2v9u5r0LU5dnzypzXepru/qKDFG1Yq5r07Of22mmqYDnRk+Q0A9XA
	aDUXJXMUriaCK/UxM+s3GyQDKa0pHcdkMEM5pTfVWbvVRag0CeFRmvHV6hGZMmOYn8PrAcSszJD
	xSzZKc9aW/V3endkexwCMrHQr+ehnqTrChJszyKmcC+mVl9FnRilv1n0nOIB4zFBPCdlUuPIEBN
	VYmDhYCsaPITIgopJBt2/FiAbeqMCI52wn/WdeEYzAAdjU8CyW7vStrkicvtI0qLxfcfoS9xqOH
	yeyLm0y531orIFcFriw==
X-Received: by 2002:a17:90b:268d:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3ae895a5bdemr14683833a91.8.1793857759926;
        Wed, 04 Nov 2026 21:49:19 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b319f2c9sm1989676a91.10.2026.11.04.21.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:49:19 -0800 (PST)
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
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Hubert Feurstein <h.feurstein@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 5/6] net: macb: implement timestamped MDIO writes
Date: Thu,  5 Nov 2026 12:48:38 +0700
Message-ID: <20261105054839.2248046-6-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105054839.2248046-1-jjc@jclark.com>
References: <20261105054839.2248046-1-jjc@jclark.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement write_sts to provide system timestamp bounds for completion
of an MDIO write. This enables tighter system timestamp bounds in PHY
implementations of gettimex64.

Take system timestamps around the command register write, then shift
them by the time from the command write until the MDC edge that
clocks the last data bit, calculated from the MDC rate.

A clause 22 frame is 64 MDC periods long, and the transfer ends on the
rising edge of MDC in the last period, half way through it. So if the
frame starts with the command write, that edge comes 63.5 periods after
the command write. If MDC runs freely, the frame can start up to one
period after the command write, so by default bound the edge by 63.5 and
64.5 periods. Add the MACB_CAPS_MDC_WRITE_SYNC flag for a MAC that
starts the frame with the command write, and use exactly 63.5 periods
there.

Set the flag for RP1. Measurements performed on a Raspberry Pi CM5 with
its BCM54210PE PHY show the transfer consistently takes 63.5 periods.
The PHY's PHC was read with PTP_SYS_OFFSET_EXTENDED while the MDC
divisor was switched between 48 and 128 through /dev/mem. With 63.5
periods, the PHC offset jumped by under 2 ns at each switch, after
compensating for drift. A frame starting on average half a period after
the command write would have made it jump by 200 ns. The spread of the
PHC offsets also did not change with the divisor.

write_sts runs under the MDIO bus lock, so it can't call clk_get_rate(),
which takes the clock framework's prepare_lock: a clock provider that
does MDIO accesses, such as air_en8811h's, takes the two locks in the
other order. So record the MDC rate when macb_mdc_clk_div() chooses the
divisor, which it does at probe and when the MAC is opened or resumed.
If the pclk rate changes after that, neither the driver nor write_sts
adjusts to the new rate; handling this is outside the scope of this
patch.

Signed-off-by: James Clark <jjc@jclark.com>
---
Changes in v3:
- Pass &bp->info to macb_is_gem(), which takes struct macb_info in
  net-next

Changes in v2:
- Bound the edge by 63.5 and 64.5 MDC periods by default, and use
  exactly 63.5 with MACB_CAPS_MDC_WRITE_SYNC, which RP1 sets
- Explain how 63.5 follows from the frame timing
- Record the MDC rate when the divisor is chosen, in place of reading
  NCFGR (Théo)
- Explain why clk_get_rate() can't be called under the MDIO bus lock
  (Théo)
- Say that neither the driver nor write_sts adjusts to a change of the
  pclk rate, and that handling one is outside the scope of this patch
- Make macb_mdio_write_c22_sts() separate from macb_mdio_write_c22(),
  as Andrew asked for UniMAC
- Express the delay with MDIO_C22_FRAME_BITS (Andrew)

 drivers/net/ethernet/cadence/macb.h      |   2 +
 drivers/net/ethernet/cadence/macb_main.c | 115 ++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index b7b4b6a38298..fa32e4100a45 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -785,6 +785,7 @@
 #define MACB_CAPS_USRIO_HAS_MII			BIT(26)
 #define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(27)
 #define MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE	BIT(28)
+#define MACB_CAPS_MDC_WRITE_SYNC		BIT(29)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1373,6 +1374,7 @@ struct macb {
 	}			hw_stats;
 
 	struct mii_bus		*mii_bus;
+	unsigned long		mdc_rate;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	struct phylink_pcs	phylink_usx_pcs;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f087f278f9e5..c8ed34fc6d28 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -444,6 +444,112 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
 	return status;
 }
 
+static u32 macb_mdc_divisor(struct macb *bp, u32 config)
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
+
+	if (macb_is_gem(&bp->info))
+		return gem_divisors[GEM_BFEXT(CLK, config)];
+	return macb_divisors[MACB_BFEXT(CLK, config)];
+}
+
+/* write_sts runs under the MDIO bus lock, so it can't call
+ * clk_get_rate(): that takes the clock framework's prepare_lock, and a
+ * clock provider that does MDIO accesses, such as air_en8811h's, takes
+ * the two locks in the other order. So record the MDC rate when the
+ * divisor is chosen.
+ */
+static void macb_record_mdc_rate(struct macb *bp, unsigned long pclk_hz,
+				 u32 config)
+{
+	unsigned long rate = pclk_hz / macb_mdc_divisor(bp, config);
+
+	if (rate)
+		WRITE_ONCE(bp->mdc_rate, rate);
+}
+
+static void macb_mdio_sts_delays(struct macb *bp, u64 *pre_ns, u64 *post_ns)
+{
+	u64 rate2 = 2ULL * READ_ONCE(bp->mdc_rate);
+	u64 half_periods = 2ULL * MDIO_C22_FRAME_BITS - 1;
+
+	/* The MDC edge that clocks the last bit comes half a period
+	 * before the end of the frame. A MAC with MACB_CAPS_MDC_WRITE_SYNC
+	 * starts the frame with the command write. Otherwise MDC may run
+	 * freely, so the frame starts up to one period after the command
+	 * write.
+	 */
+	*pre_ns = div64_u64(half_periods * NSEC_PER_SEC, rate2);
+	if (!(bp->caps & MACB_CAPS_MDC_WRITE_SYNC))
+		half_periods += 2;
+	*post_ns = div64_u64(half_periods * NSEC_PER_SEC + rate2 - 1, rate2);
+}
+
+static int macb_mdio_write_c22_sts(struct mii_bus *bus, int mii_id, int regnum,
+				   u16 value, struct ptp_system_timestamp *sts)
+{
+	struct macb *bp = bus->priv;
+	u64 pre_ns, post_ns;
+	unsigned long flags;
+	int status;
+	u32 cmd;
+
+	status = pm_runtime_resume_and_get(&bp->pdev->dev);
+	if (status < 0)
+		goto mdio_pm_exit;
+
+	status = macb_mdio_wait_for_idle(bp);
+	if (status < 0)
+		goto mdio_write_exit;
+
+	cmd = MACB_BF(SOF, MACB_MAN_C22_SOF)
+	      | MACB_BF(RW, MACB_MAN_C22_WRITE)
+	      | MACB_BF(PHYA, mii_id)
+	      | MACB_BF(REGA, regnum)
+	      | MACB_BF(CODE, MACB_MAN_C22_CODE)
+	      | MACB_BF(DATA, value);
+	macb_mdio_sts_delays(bp, &pre_ns, &post_ns);
+
+	local_irq_save(flags);
+	ptp_read_system_prets(sts);
+	/* macb_writel() is relaxed; order it after the timestamp. */
+	mb();
+	macb_writel(bp, MAN, cmd);
+	/* Flush the posted write before taking the upper bound. */
+	macb_readl(bp, NSR);
+	/* Order the read-back before the system timestamp. */
+	rmb();
+	ptp_read_system_postts(sts);
+	local_irq_restore(flags);
+
+	ptp_adjust_system_prets(sts, pre_ns);
+	ptp_adjust_system_postts(sts, post_ns);
+
+	status = macb_mdio_wait_for_idle(bp);
+	if (status < 0)
+		goto mdio_write_exit;
+
+mdio_write_exit:
+	pm_runtime_put_autosuspend(&bp->pdev->dev);
+mdio_pm_exit:
+	return status;
+}
+
 static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
 			       int devad, int regnum,
 			       u16 value)
@@ -1231,6 +1337,8 @@ static int macb_mii_init(struct macb *bp)
 	bp->mii_bus->name = "MACB_mii_bus";
 	bp->mii_bus->read = &macb_mdio_read_c22;
 	bp->mii_bus->write = &macb_mdio_write_c22;
+	if (bp->mdc_rate)
+		bp->mii_bus->write_sts = &macb_mdio_write_c22_sts;
 	bp->mii_bus->read_c45 = &macb_mdio_read_c45;
 	bp->mii_bus->write_c45 = &macb_mdio_write_c45;
 	snprintf(bp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
@@ -3196,6 +3304,8 @@ static u32 gem_mdc_clk_div(struct macb *bp)
 	else
 		config = GEM_BF(CLK, GEM_CLK_DIV224);
 
+	macb_record_mdc_rate(bp, pclk_hz, config);
+
 	return config;
 }
 
@@ -3217,6 +3327,8 @@ static u32 macb_mdc_clk_div(struct macb *bp)
 	else
 		config = MACB_BF(CLK, MACB_CLK_DIV64);
 
+	macb_record_mdc_rate(bp, pclk_hz, config);
+
 	return config;
 }
 
@@ -6182,7 +6294,8 @@ static const struct macb_config raspberrypi_rp1_config = {
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP |
 		MACB_CAPS_EEE |
-		MACB_CAPS_USRIO_HAS_MII,
+		MACB_CAPS_USRIO_HAS_MII |
+		MACB_CAPS_MDC_WRITE_SYNC,
 	.dma_burst_length = 16,
 	.usrio = &at91_default_usrio,
 	.jumbo_max_len = 10240,
-- 
2.56.0

