Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508973D0BE5
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792317829; cv=none; b=BVgtnRmI5FCKe+CLYpv0ZKj+rYfp+ifPlVEFU9jj5sN9evz1QGXG165rYpYVAzOiU0NURFW7yTEWa8radG/daNTOb6UWGkAhAQueoTHt2GdeTUAufLIQce1OvzgQr+mDL5gCinE/X9cUHHpKfbJ1/MijO1ZCOMxtzi/XYNTZ4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792317829; c=relaxed/simple;
	bh=z8Y+wKG8EFkD01BXFdYzYSiCuup2iIQxAVs1jj4m414=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDuUuhCQ5PqlwqabuMNrJZWAkPQSjkSq4GNh+dYpHFsi0Gv7SbUi6V9IBB2KCM8FEFDjveMDZQ+D5b5QxuZ00K7dLVstFRWG8dl3M3uS2Uw0vhhhHvJxEv+vw3TboALJgVF/2gsO2OdP0XF8TRD2/Y2RQ54lZernGOETWpRBfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=eQ0NbqI4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="eQ0NbqI4"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so839460a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792317828; x=1792922628; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJXCyXh4PPjdgA3K8xycNiIpP4i/Fqn0ZXUWsIMZzoE=;
        b=eQ0NbqI4FdCKI+GESCSoFghY6xeSk8oAPnWS1GIHu9C/BPUXzXYG/efC3NIn5YZ1kn
         IZjR9wc6gxalg7zLaabjl1nxW/ZL2DEOvBk3nP1QvL6O6JC8sq8sz7sNa/8dgxgykcch
         7hOrXjpZYkuoOV3OcMEPbbumduwPxHqZq5M4lQF70SA6XYi8Rexl2KXf9qkPlixBYDNR
         mldIgVZPb8q+hGoRRZbqBII0aYCKFpWpiRacfBVdZzoXr3nffO/i4dSV9iobRImJQgIq
         es+aq4/9YEkm4oOWkkSQ3m8Sg2nVDnmPZVwETqxelADm6Tq+EECNpc/W4F7FTuUMHlSh
         wfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792317828; x=1792922628;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJXCyXh4PPjdgA3K8xycNiIpP4i/Fqn0ZXUWsIMZzoE=;
        b=UMUKLzN3MOIOQi5nPDMQ2dCcnrJBeQBxZNcYcpYCDBvo4Yg7Ur49JenkbNob9CjXcp
         BU2LhZ6tF8vSY8afEomJPOoxSo1QqN3JJltsmU6epeI4tumhFJ9lmQWtB8iyRPKJHyzg
         6xj+KWa0YedehFuZpQRo/jsn+AA7HkiItX/ASTWXF6f5iFe17Ti/AonpCRPAIXJeCnlT
         e9V0YKgstfACgyi3PzlfYP30Uz96/tf+S55uQDuq23N5+vkOi91K6jWBexZICboluOTy
         BduPNLQXyb3rZtSjAqgKTJ9CqMF8X07T8AlByJLdQrvW3CQU1pZd9AIHuL6K6UuGTaEy
         4+Xg==
X-Forwarded-Encrypted: i=1; AKwUvByNpE5PvCH9mB91B7dYFa0HpzakmpMfr0dRaKlJR/LWcSXx3LQp0LL4S6CHJLA3Q4TExEldFac=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaVxEOyzuPgBB95/yCLk4XvPWE4oUuWVpwqSKkO+npp51GYs96
	L5ZbB3nJoiBLlSJRvehUIqL8UMr4aZa6p9iMHytVefrVCVLvxUzjgicAnes1h//wKw==
X-Gm-Gg: AYBFou2/HCpZIkzK2HJgiRP1bHkv5TMM87QQ7t5agLXm/v314DKn8xV+Pge4lsczNzt
	B1IuHwyQvbAqEQbkI6bR2HKxBJhwUClUzPObOUdaZ95T5wsA3kMa8VfIe1wT4/m/gt99dy/Bw7z
	zVqFEMsLhhEKPmQRuOik3vBT0eeRAuvBxbjDqxIE+SKV3O7LkI1wiV3ABImqrKfncuRrwktKacB
	rNTVgoqEccDvIliDGi/lZyNgxaKDx3yETXixknhIWI4VXCtPy9iRi/WjzjKBlmm0TL0DW5wxnJ/
	CLyTYtVIIu1FUrWYfgF7hwzU5Or7SD6K2N7Pjm1PYM/8xBJn/NtyahfaFFjlRes3Q1bf2gpARZF
	rjWYW3kJ5kPu9UHbyjYLyL5f79hD11JZG/UeUmurhhqcowxBfqEgMYSiL9Y23NW9b446DUqpL/b
	7LWfvAab928q3LHBQOEfveiXyEBg4YHmKFcy59n3uCw6QJvpQ+h3q+KMQB/Qu4nGGYQahTVI2Or
	T5x9EDM+pCFZVe9b9bvitOJt7csZWX2xp8tbnTJ9GJ2SQB+7XiZTMNCu20iVDI=
X-Received: by 2002:a17:90b:184d:b0:3ab:4262:1a3a with SMTP id 98e67ed59e1d1-3acef6300c9mr3733016a91.61.1792317827585;
        Sun, 18 Oct 2026 03:03:47 -0700 (PDT)
Received: from cantal.lan ([58.136.73.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm16101210a91.0.2026.10.18.03.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:03:46 -0700 (PDT)
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
Subject: [PATCH net-next v2 5/6] net: macb: implement timestamped MDIO writes
Date: Sun, 18 Oct 2026 17:02:56 +0700
Message-ID: <20261018100257.566267-6-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018100257.566267-1-jjc@jclark.com>
References: <20261018100257.566267-1-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
Assisted-by: LLM
---
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
index 82499ec6a9f..b19370221c5 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -785,6 +785,7 @@
 #define MACB_CAPS_USRIO_HAS_MII			BIT(26)
 #define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(27)
 #define MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE	BIT(28)
+#define MACB_CAPS_MDC_WRITE_SYNC		BIT(29)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
@@ -1334,6 +1335,7 @@ struct macb {
 	struct macb_or_gem_ops	macbgem_ops;
 
 	struct mii_bus		*mii_bus;
+	unsigned long		mdc_rate;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	struct phylink_pcs	phylink_usx_pcs;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 020a47353d0..863f3ef19a5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -415,6 +415,112 @@ static int macb_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
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
+	if (macb_is_gem(bp))
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
@@ -1166,6 +1272,8 @@ static int macb_mii_init(struct macb *bp)
 	bp->mii_bus->name = "MACB_mii_bus";
 	bp->mii_bus->read = &macb_mdio_read_c22;
 	bp->mii_bus->write = &macb_mdio_write_c22;
+	if (bp->mdc_rate)
+		bp->mii_bus->write_sts = &macb_mdio_write_c22_sts;
 	bp->mii_bus->read_c45 = &macb_mdio_read_c45;
 	bp->mii_bus->write_c45 = &macb_mdio_write_c45;
 	snprintf(bp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
@@ -3018,6 +3126,8 @@ static u32 gem_mdc_clk_div(struct macb *bp)
 	else
 		config = GEM_BF(CLK, GEM_CLK_DIV224);
 
+	macb_record_mdc_rate(bp, pclk_hz, config);
+
 	return config;
 }
 
@@ -3039,6 +3149,8 @@ static u32 macb_mdc_clk_div(struct macb *bp)
 	else
 		config = MACB_BF(CLK, MACB_CLK_DIV64);
 
+	macb_record_mdc_rate(bp, pclk_hz, config);
+
 	return config;
 }
 
@@ -5853,7 +5965,8 @@ static const struct macb_config raspberrypi_rp1_config = {
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

