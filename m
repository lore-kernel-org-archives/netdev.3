Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857754;
	b=tFcWEpiPWsmyt9b9XUQ1IPRiGHnOOL1A5cNSCQPKlMamboilHMwfawZQAZzHLlXgQ/HS
	 pYlSid8st/iClVhJLZPkjJtX/2Eq36qDW4Ib2ZyLckfiDhTN3Ovy9VWqVor5MkbIlmYPi
	 82S3yI8t3xt2MhYzt5p1ZIALGsqN45HJtLIDCvlnRdIc+BrgTNEg7Um3NzB+GPZx7mcCy
	 KeokUL2FFbGiVNUC/eawjewtIOSN22QQVlhnluR+VlHOnfkb9qdXvwz5iaoS8F9tE3a6V
	 34112sOx1QDnvQcFvd+sUg4/11mYtnAfYBjyiNWhrS7KKFhYvWzp208aoJO6TeD4C8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=knxpemwIgRXpfCw7909LRGVkkjzWdBAEoQQwEqa/ptA=;
	b=vLx1+ELbHw47EMZVjsvafFpb4M3LcynxmJrFHVQE+xQWSUGFBNV3t/0M9OE1nfDcTtPY
	 Il+FYwFjB/NlepTVAPzqCruE0wWOmNMo5Rtw4LYc72XWDG4EJxw/ecCnKjfWfFs0mAzV+
	 Hq5KYErqTbVgCa4fBWvYJynSUtyk/q9Q0kWbbkNnAkw9vLhemmFBwYA5mx63wJmHx1tLR
	 /6TMlZ/z/FaB9xU/ZIaKu2dqVyrXszrgXgaQi1O2NXiFQRp2G5l6JIa9DLPtWH0xgkL3e
	 Cy7nVAAE66v/skg+p2bxfobhsp70ANumOuKVp+FOwUB+HwYxYa2x+icJqqIU95/EwrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GS64Jqzk;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C607606A32C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C607606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GS64Jqzk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so255060a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793857754; x=1794462554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knxpemwIgRXpfCw7909LRGVkkjzWdBAEoQQwEqa/ptA=;
        b=GS64Jqzk4Jufax3KoKuoeN1tTZ5mo+cnIki+/HYGOCBeaItOFKQVR8vkOrhF1hi8TV
         O0a+CMLGGugNUBgeGzhZu4Ye/Nlc0zdEwbQxMIVivuo8S4otgDi7e0T/Zc3VlvziVcG0
         lJwtLUWaMoM8HyOgLL5b0y22BE0fecVwJ8KUK2grEA5qs6gfSANXIvCH3z47wpNTXpbU
         CoxoagPMCC2hzoZdLnqMj23IGq1irB/mXiC9Dl0KJZs82VKYBB2KGsLIhhp6wgYCVaQ+
         eKhxkkLm/62cZ43UxAysF9tCc3zO0dq9IrxDAs5snXoB3HJMda98BgkIHKbMEM12TcQ3
         R5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793857754; x=1794462554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=knxpemwIgRXpfCw7909LRGVkkjzWdBAEoQQwEqa/ptA=;
        b=ECE8+nmclkrwDo5wI3ouOY3mcygKbXh9xINl9k4CdnoNxvNNa40jG+KhJXw44TT4oh
         mwlqYk/855QshERawfjOocJn8JYqJdSRjr7vDW+nMMGMxvTfGDcaDAotUazg5j79pnlu
         KYrtWP0lcDczqYana/TLiC88MMW4pjZ9lmb+xXOOJpkJ/xvGRZ0MVf0oqUgNCS9AgTzR
         wV49UzDxnZep9iMCky7NMOdar2P53MZWy/Ojg3a+aWjy7RZ0kF0jH8v6ay9vTCpYJyMb
         XEgnJG9PVPp7AEm/7dFkmvBKHf9iDLHUP8VF7PBixrrZxL8tP6Fu7IZB6O9PdsUXQHDs
         apCA==
X-Forwarded-Encrypted: i=1; AKwUvBxeyxMi/gEc92vxAyk6eDXnxnf1k5peXG4jyhMZLlGnpCXVAtqxdQp4YM2W93Fv7ilWIXemjMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZJkS8LziEDO1HHUeBOgh8VlWmZXcWiDDMVcYKp+MzgZowOqIZ
	q9Hkm2LYnucpAN0JYmUIvAhX4L4IkeHzGta8MiEGakwCUbPYqxy4YWs5PvA3QqDZMw==
X-Gm-Gg: AYBFou1kncRCjwLpTv/zVRq3QuWLOAIsfvsNAKfnhLtvBH+NtAzfDdjx/wa3G/P4aPW
	Rhb/Se4dCYtI4QOOTr7FjNc0uUTIC7PeirNnqIaZlFug+3nuvFJuuvF6f1UEKynuqfc5iCfBQO9
	ZDomVCRn1OmZjG9T2IoWbsrBdav8wzk1kCrZ/4akTGLCK+aD9jEmied4fgwq2kGwwrbvxbTLrn8
	Cabr/XK11tUWknS7sZHrspbUeb3aAFPlush3s4lBdtujbyEgaRB/He48i5Zs5EDD7o0ALPQ+U38
	ULT2+ya4cZTZAJVCS0gFZndNEOVl2n0JTx1tCqlS6jwPmsozTQFOEnG18rcXYniTAq8/lu81lu4
	R3C5gGvwZ+s5bdn429nZZBEEh1Q3C7IEarWjOaE7TW63ONLwjYJRQLMeFcLjQukUrVFSARalgwJ
	RUMRYbVb9a+BMHOHTEQnQoGdvs7WkSAaLzuPwP+RC8WpPSV/P5fG6yRTQZbctdAIrEcWGeave1c
	SLs82RUYgyfiwZHVC0JwrwtVoWh6ybCkopUQNtkCZgCq+7ZL9IhbM80PL6UkjPZtMCnuXSmdrDd
	EeF6xI4WYv5fTbMcolzMdhhXR2l3Qpxotdd9bUxQGEx1Tzd2vxXZXDqElkHxSKaVoC2eL8vn1rF
	PyRB8zavblJCbkZf3nA==
X-Received: by 2002:a17:90b:1644:b0:3b0:a7e7:68f5 with SMTP id 98e67ed59e1d1-3b0a7e76afamr2202042a91.7.1793857753548;
        Wed, 04 Nov 2026 21:49:13 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b319f2c9sm1989676a91.10.2026.11.04.21.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:49:12 -0800 (PST)
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
Subject: [PATCH net-next v3 4/6] net: phy: broadcom: use timestamped MDIO writes in gettimex64
Date: Thu,  5 Nov 2026 12:48:37 +0700
Message-ID: <20261105054839.2248046-5-jjc@jclark.com>
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
Content-Transfer-Encoding: 8bit

When the MDIO bus provides the write_sts operation, use
__phy_write_sts() to obtain tighter system timestamp bounds in
gettimex64 by timestamping completion of the write that triggers
capture of the PHC time.

The PHY captures its time a short delay after completion of the write,
the rising MDC edge that clocks its last data bit. This delay is not
documented. The correctness of gettimex64 requires that the event
delay passed to __phy_write_sts() is an upper bound on the actual
delay.

The upper bound BCM_FRAMESYNC_CAPTURE_NS was established by measurements
performed on a Raspberry Pi CM4. The same PPS signal was wired both to
the SYNC_OUT pin connected to the PHY's PHC and to GPIO pin 18. Two
programs were run simultaneously. One used polling of GPIO registers to
estimate the system time of each pulse. The other waited for the extts
event for each pulse, and then performed a PTP_SYS_OFFSET_EXTENDED
ioctl. Combining these gives a PHC/system time pair for each pulse. The
system time of the PHC reading in each PTP_SYS_OFFSET_EXTENDED sample
was estimated by interpolating between the PHC/system time pairs of the
pulses on either side of it. Over about 30,000 samples, every estimate
was at least 285 ns after the lower system time bound of the sample.
The write cannot complete before the lower bound, so the delay can be no
more than the gap from the lower bound to the capture.
However, the polling brackets are about 150 ns wide. Compensating for
polling error by considering neighbouring pulses gives an upper bound of
at most 330 ns; BCM_FRAMESYNC_CAPTURE_NS uses this rounded up to 350 ns,
which also covers a possible variation of 8 ns in the delay,
corresponding to one period of the PHY's 125 MHz clock.

This assumes that the delay is a property of the PHY, so that it applies
equally with other MDIO buses. Changing the MDC period between 100 and
400 ns changed the delay by less than 10 ns. Measurements on a Raspberry
Pi CM5, where the same PHY is on the RP1's macb, are consistent with the
CM4 measurements. But there the GPIO is polled across PCIe, so the
polling brackets are wider.

gettimex64 can now return -EBUSY if the clock is stepped during the
write, as gettimex64 already can in other drivers, such as mvpp2 and
ionic.

This patch does not try to fix the error handling in the existing
framesync code, which ignores MDIO write errors.

Signed-off-by: James Clark <jjc@jclark.com>
---
Changes in v3:
- Say that the capture delay is measured from completion of the write,
  the rising MDC edge that clocks its last data bit (Sashiko)

Changes in v2:
- Take into account the PHY's capture delay, with a bound of 350 ns
  found by measurement
- Say that gettimex64 can now return -EBUSY if the clock is stepped
  during the write
- Say that the tighter bounds need a bus driver with write_sts
  (Sashiko)

Does Broadcom know the BCM54210PE's capture delay, from the end of the
MDIO write to the framesync capture? If so, I can use it in place of
the 350 ns bound found by measurement.

 drivers/net/phy/bcm-phy-lib.c | 27 +++++++++++++++++++++++++++
 drivers/net/phy/bcm-phy-lib.h |  7 +++++++
 drivers/net/phy/bcm-phy-ptp.c | 33 +++++++++++++++++++++++++++------
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index b64beade8dd9..5f8813d01a8e 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -42,6 +42,33 @@ int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val)
 }
 EXPORT_SYMBOL_GPL(bcm_phy_write_exp);
 
+static int __bcm_phy_write_exp_sts(struct phy_device *phydev, u16 reg, u16 val,
+				   u32 event_delay_ns,
+				   struct ptp_system_timestamp *sts)
+{
+	int rc;
+
+	rc = __phy_write(phydev, MII_BCM54XX_EXP_SEL, reg);
+	if (rc < 0)
+		return rc;
+
+	return __phy_write_sts(phydev, MII_BCM54XX_EXP_DATA, val,
+			       event_delay_ns, sts);
+}
+
+int bcm_phy_write_exp_sts(struct phy_device *phydev, u16 reg, u16 val,
+			  u32 event_delay_ns, struct ptp_system_timestamp *sts)
+{
+	int rc;
+
+	phy_lock_mdio_bus(phydev);
+	rc = __bcm_phy_write_exp_sts(phydev, reg, val, event_delay_ns, sts);
+	phy_unlock_mdio_bus(phydev);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(bcm_phy_write_exp_sts);
+
 int __bcm_phy_read_exp(struct phy_device *phydev, u16 reg)
 {
 	int val;
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index bba94ce96195..08ab59fb9b88 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -34,6 +34,8 @@ int __bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
 int __bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
 int __bcm_phy_modify_exp(struct phy_device *phydev, u16 reg, u16 mask, u16 set);
 int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
+int bcm_phy_write_exp_sts(struct phy_device *phydev, u16 reg, u16 val,
+			  u32 event_delay_ns, struct ptp_system_timestamp *sts);
 int bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
 int bcm_phy_modify_exp(struct phy_device *phydev, u16 reg, u16 mask, u16 set);
 
@@ -48,6 +50,11 @@ static inline int bcm_phy_read_exp_sel(struct phy_device *phydev, u16 reg)
 	return bcm_phy_read_exp(phydev, reg | MII_BCM54XX_EXP_SEL_ER);
 }
 
+static inline bool bcm_phy_supports_write_exp_sts(struct phy_device *phydev)
+{
+	return phy_supports_write_sts(phydev);
+}
+
 int bcm54xx_auxctl_write(struct phy_device *phydev, u16 regnum, u16 val);
 int bcm54xx_auxctl_read(struct phy_device *phydev, u16 regnum);
 
diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index 65d609ed69fb..b1f61e4f0034 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -161,6 +161,11 @@ struct bcm_ptp_capture {
 #define BCM_MAX_PULSE_8NS	((1U << 9) - 1)
 #define BCM_MAX_PERIOD_8NS	((1U << 30) - 1)
 
+/* Allowed for the PHY to capture its time after the rising MDC edge
+ * that clocks the last data bit of the framesync write.
+ */
+#define BCM_FRAMESYNC_CAPTURE_NS	350
+
 #define BRCM_PHY_MODEL(phydev) \
 	((phydev)->drv->phy_id & (phydev)->drv->phy_id_mask)
 
@@ -214,22 +219,35 @@ static void bcm_ptp_framesync(struct phy_device *phydev, u16 ctrl)
 	bcm_phy_write_exp(phydev, NSE_CTRL, ctrl | NSE_CPU_FRAMESYNC);
 }
 
+static int bcm_ptp_framesync_sts(struct phy_device *phydev, u16 ctrl,
+				 struct ptp_system_timestamp *sts)
+{
+	return bcm_phy_write_exp_sts(phydev, NSE_CTRL,
+				     ctrl | NSE_CPU_FRAMESYNC,
+				     BCM_FRAMESYNC_CAPTURE_NS, sts);
+}
+
 static int bcm_ptp_framesync_ts(struct phy_device *phydev,
 				struct ptp_system_timestamp *sts,
 				struct timespec64 *ts,
 				u16 orig_ctrl)
 {
 	u16 ctrl, reg;
-	int i;
+	int i, err = 0;
 
 	ctrl = bcm_ptp_framesync_disable(phydev, orig_ctrl);
 
-	ptp_read_system_prets(sts);
-
 	/* trigger framesync + capture */
-	bcm_ptp_framesync(phydev, ctrl | NSE_CAPTURE_EN);
-
-	ptp_read_system_postts(sts);
+	if (sts && bcm_phy_supports_write_exp_sts(phydev)) {
+		/* cannot ignore error since sts may be uninitialized,
+		 * but still poll for any triggered capture
+		 */
+		err = bcm_ptp_framesync_sts(phydev, ctrl | NSE_CAPTURE_EN, sts);
+	} else {
+		ptp_read_system_prets(sts);
+		bcm_ptp_framesync(phydev, ctrl | NSE_CAPTURE_EN);
+		ptp_read_system_postts(sts);
+	}
 
 	/* poll for FSYNC interrupt from TS capture */
 	for (i = 0; i < 10; i++) {
@@ -242,6 +260,9 @@ static int bcm_ptp_framesync_ts(struct phy_device *phydev,
 
 	bcm_ptp_framesync_restore(phydev, orig_ctrl);
 
+	if (err)
+		return err;
+
 	return reg & INTC_FSYNC ? 0 : -ETIMEDOUT;
 }
 
-- 
2.56.0

