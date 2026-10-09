Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00953B582F
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556548; cv=none; b=uBu7+Yuqy6O5sL3HClTRpKBHvMS12vP82qhk5eDaHPIuht7cHyjB+DBp+npoK6s+QfkA4cse4xcYpyZ6zNaV31NsrObHLMmRExUslo+7I+mL5RblvRs3jUHA1K6uY6z341aXZrgwPD1K1fyCPuxYdJqx/oiLXXZ/vvHFO9ZhtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556548; c=relaxed/simple;
	bh=H8lDnuMZHGBjHEVyvOTnXWdtAgPcjmRjSfHJIg8Gs8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k34AUjnmhVTu4zYTXvclE+3n7+clVz+rU2kOs5qEgDVQh8TJEWn55u8tJphFSocVRxg1zVwIlJdKN9RwamFo+UWZf6KqOYksl4RVFcmvFoRKjd5pQRhdvMxHnpAE7NyjVAf02Xzyjb5vu1Vfn2NNAO3NkuGN/evZSwZ20S5ifWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=OQErPqeD; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="OQErPqeD"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-9179bfa9e9cso64070726d6.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791556546; x=1792161346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u4rMSxv7fGQfOdSLQl+/yMzz9zh4VpNP7itM1e9F4lA=;
        b=OQErPqeDbaamjq0X/1u4IDgq8Pok8pyaH8uMOZRIB119SlS+nlLiuMq7UFOBrcLW96
         lj7EBrp7mnUgDzNk83GyYTokthHE28J/W12MIx++lBcTK15QLlagloqkNjGahJZK8f6Z
         HWnNnCVNA26mKnDm6NeU2VoOPmvc4Q1S9bKc0rO2/U/L0N7b6Uo0vu4I2nlaeN+7M+v3
         UTGY52cSewfwWTGxqEw6XXBQpPWrDCwkFvzH0SZPHNKPq9i65tFI8aXRTPTliMUVAgcz
         9n/YPfb1cEgq+tWHcRrnbh87treBIt5fm9tak2r1pjF1zF+Oy5LZssDXRhaXBQ/SpgjP
         5W5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556546; x=1792161346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u4rMSxv7fGQfOdSLQl+/yMzz9zh4VpNP7itM1e9F4lA=;
        b=QPLMX7s2rc3Hi8cgXxHzgck5yStYvYrBVtnfie7EksD0oNonXdN2P1K0M+PU5eNgf9
         XDydOuRJ0FX0yShvjbPVLtH0kBQOzBH0gb5JxR3DiSA7BDn+ZlMbI3pP31hbUqBKKazV
         x3J9lLRSW7LJLRPUu2Qlch25ozwFtLb6iXn9PQZ67U+DojhcfSAbCX/WxsDAkNI3LBpn
         xmuUlJrV++mOEaxvJoTGQvgtK0kE8t4iRQ8YM/bo0t46hL0bGuRZvmNq3rebJUHOpS8O
         S2BJkAJHO7UtR2ep0DBWrTVMmPamfnfV4HqbjPnGYf/1I9ZhHSF47zQNMsGIvOaXC0K5
         B14w==
X-Forwarded-Encrypted: i=1; AKwUvBzNgGkUUYq4nkwD27AQNWeW0O++wmUV0vpSUlTtFaFphj1JYJDEDUOnIY2NB1BD5Yr4fXg/eZ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvfD7baLynWh6LRZMfoHjk+1QZfpDajAFA7AGZAc0DInGX9wiY
	DoHUDABfFwyVEbIsbR32BGvFK4WOznGb2iNHtArMxc/qPwPP4a9RMQewUjORQWQUYA==
X-Gm-Gg: AYBFou0cL4PEphK1x+xZ8SKmQ9Rk3sENjtZDBo635Oirrd2Hpy4bgO1T/0yMimR2mfW
	Yb6lMmd71+nb4wpPoBSL0ZaHysw+eh/QJDBcBGzmXiOr5T7Uop7oxBZenjLfRLeLO/MQpQ9Oiaz
	XEoAWJhg3nhXtae9dbXgsv0Duu7H9+4LfzKlDBIZQEqhkEu8/YjMYtb11dIrF8woBcqDuP67XB1
	aLXElVW/9UT8JdFKYZFLBmb9ch4HLBBoYRPlEu5mnDyXJxJbkS8w/5Y3WMhATUkIYR+xpKRKiW8
	AJRWiVuyLFLexOqJOM1mgTfmygMAhzCcsAbJu02qsvogPon3S6FV6FBPc+JjyXhXnlSUw2qGe5/
	cV1GXGbnUJv4YdI4DBepfqon+wutMyhTni/wsm5Eddfgw2ph0ib6Ck5KIWmiQ/jxJs3o0lzHQZq
	F2RrRojkw+3oJn1npBCEPv7UM25x25OztL7MgHJDgeRD6uAvuUvXK1wqPE08j8craLnqqEKVU=
X-Received: by 2002:a05:6214:5983:b0:915:ea96:d73f with SMTP id 6a1803df08f44-91b553374b4mr34143616d6.2.1791556545453;
        Fri, 09 Oct 2026 07:35:45 -0700 (PDT)
Received: from cantal.lan ([58.136.72.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501751dsm19769456d6.17.2026.10.09.07.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:35:44 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped MDIO writes
Date: Fri,  9 Oct 2026 21:35:06 +0700
Message-ID: <20261009143506.2507607-6-jjc@jclark.com>
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

Take system timestamps around the command start, then add the time
from the command start until the MDC edge that clocks the last data
bit, calculated from the reference clock rate and the configured MDC
divider.

On BCM2711 that edge comes 64 MDC periods after the command start, on
average. This was measured on a Raspberry Pi CM4 with its BCM54210PE
PHY. The PHY's PHC was read with PTP_SYS_OFFSET_EXTENDED while the MDC
divider was switched between 9 and 39 through /dev/mem. Any error in
the number of periods would make the PHC offset jump at each switch.
After compensating for drift, the jump with 64 periods was under 10 ns.
The MDC divider appears to run freely: the PHC offsets spread evenly
over one MDC period at each divider. So use 63.5 and 64.5 periods as
the lower and upper bounds of the delay.

Use a 200 MHz reference rate for BCM2711 GENET, whose clock is not
described in DT.

Signed-off-by: James Clark <jjc@jclark.com>
Assisted-by: LLM
---
When there is no clock, unimac_mdio_clk_set() assumes a 250 MHz
reference rate, and no in-tree DT gives GENET or UniMAC a clock. For
BCM2711 I have no documentation of the reference rate or of the clock
that supplies it, but MDIO busy times measured at several MDC dividers
fit a rate of 200 MHz. This patch checks the parent's compatible string,
which is unsatisfactory. I would prefer to get the rate from DT, and
would welcome suggestions for the right DT description.

The delay of 63.5 to 64.5 MDC periods has been measured only on
BCM2711, but the code assumes it holds for any UniMAC.

 drivers/net/mdio/mdio-bcm-unimac.c | 105 ++++++++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 31e396cc9fb..e1ae806d1a8 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -16,6 +16,7 @@
 #include <linux/phy.h>
 #include <linux/platform_data/mdio-bcm-unimac.h>
 #include <linux/platform_device.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/sched.h>
 
 #define MDIO_CMD		0x00
@@ -42,6 +43,7 @@ struct unimac_mdio_priv {
 	void			*wait_func_data;
 	struct clk		*clk;
 	u32			clk_freq;
+	unsigned long		mdio_ref_rate;
 };
 
 static inline u32 unimac_mdio_readl(struct unimac_mdio_priv *priv, u32 offset)
@@ -73,6 +75,27 @@ static inline void unimac_mdio_start(struct unimac_mdio_priv *priv)
 	unimac_mdio_writel(priv, reg, MDIO_CMD);
 }
 
+static void unimac_mdio_start_sts(struct unimac_mdio_priv *priv,
+				  struct ptp_system_timestamp *sts)
+{
+	unsigned long flags;
+	u32 reg;
+
+	reg = unimac_mdio_readl(priv, MDIO_CMD);
+	reg |= MDIO_START_BUSY;
+	local_irq_save(flags);
+	ptp_read_system_prets(sts);
+	/* Order the timestamp before the relaxed command write. */
+	mb();
+	unimac_mdio_writel(priv, reg, MDIO_CMD);
+	/* Flush the posted write before taking the upper bound. */
+	unimac_mdio_readl(priv, MDIO_CMD);
+	/* Order the read-back before the system timestamp. */
+	rmb();
+	ptp_read_system_postts(sts);
+	local_irq_restore(flags);
+}
+
 static int unimac_mdio_poll(void *wait_func_data)
 {
 	struct unimac_mdio_priv *priv = wait_func_data;
@@ -127,10 +150,41 @@ static int unimac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	return ret;
 }
 
-static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
-			     int reg, u16 val)
+static int unimac_mdio_sts_delays(struct unimac_mdio_priv *priv,
+				  u64 *pre_ns, u64 *post_ns)
+{
+	u32 cmd, config, divisor;
+	int ret;
+
+	/* The delays assume the controller is idle. */
+	ret = read_poll_timeout(unimac_mdio_readl, cmd,
+				!(cmd & MDIO_START_BUSY),
+				1, 1000, false, priv, MDIO_CMD);
+	if (ret)
+		return ret;
+
+	config = unimac_mdio_readl(priv, MDIO_CFG);
+	if (config & MDIO_SUPP_PREAMBLE)
+		return -EIO;
+	divisor = 2 * (((config >> MDIO_CLK_DIV_SHIFT) & MDIO_CLK_DIV_MASK) + 1);
+	/* On BCM2711 the MDC divider runs freely, so the MDC edge that
+	 * clocks the last bit of a write comes 63.5 to 64.5 periods after
+	 * the command start.
+	 */
+	*pre_ns = div64_ul(127ULL * divisor * NSEC_PER_SEC,
+			   2 * priv->mdio_ref_rate);
+	*post_ns = div64_ul(129ULL * divisor * NSEC_PER_SEC +
+			    2 * priv->mdio_ref_rate - 1,
+			    2 * priv->mdio_ref_rate);
+
+	return 0;
+}
+
+static int unimac_mdio_write_sts(struct mii_bus *bus, int phy_id, int reg,
+				 u16 val, struct ptp_system_timestamp *sts)
 {
 	struct unimac_mdio_priv *priv = bus->priv;
+	u64 pre_ns, post_ns;
 	u32 cmd;
 	int ret;
 
@@ -138,19 +192,38 @@ static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
 	if (ret)
 		return ret;
 
+	if (sts) {
+		ret = unimac_mdio_sts_delays(priv, &pre_ns, &post_ns);
+		if (ret)
+			goto out;
+	}
+
 	/* Prepare the write operation */
 	cmd = MDIO_WR | (phy_id << MDIO_PMD_SHIFT) |
 		(reg << MDIO_REG_SHIFT) | (0xffff & val);
 	unimac_mdio_writel(priv, cmd, MDIO_CMD);
 
-	unimac_mdio_start(priv);
+	if (sts) {
+		unimac_mdio_start_sts(priv, sts);
+		ptp_adjust_system_prets(sts, pre_ns);
+		ptp_adjust_system_postts(sts, post_ns);
+	} else {
+		unimac_mdio_start(priv);
+	}
 
 	ret = priv->wait_func(priv->wait_func_data);
+out:
 	clk_disable_unprepare(priv->clk);
 
 	return ret;
 }
 
+static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
+			     int reg, u16 val)
+{
+	return unimac_mdio_write_sts(bus, phy_id, reg, val, NULL);
+}
+
 /* Workaround for integrated BCM7xxx Gigabit PHYs which have a problem with
  * their internal MDIO management controller making them fail to successfully
  * be read from or written to for the first transaction.  We insert a dummy
@@ -234,6 +307,30 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	return ret;
 }
 
+static bool unimac_mdio_init_sts(struct unimac_mdio_priv *priv,
+				 struct device *dev)
+{
+	u32 config;
+
+	/* The reference rate is fixed, so read it once. */
+	priv->mdio_ref_rate = clk_get_rate(priv->clk);
+	/* BCM2711's 200 MHz GENET reference clock is not described in DT. */
+	if (!priv->mdio_ref_rate && dev->parent &&
+	    of_device_is_compatible(dev->parent->of_node,
+				    "brcm,bcm2711-genet-v5"))
+		priv->mdio_ref_rate = 200000000;
+
+	if (!priv->mdio_ref_rate)
+		return false;
+
+	if (clk_prepare_enable(priv->clk))
+		return false;
+	config = unimac_mdio_readl(priv, MDIO_CFG);
+	clk_disable_unprepare(priv->clk);
+
+	return !(config & MDIO_SUPP_PREAMBLE);
+}
+
 static int unimac_mdio_probe(struct platform_device *pdev)
 {
 	struct unimac_mdio_pdata *pdata = pdev->dev.platform_data;
@@ -292,6 +389,8 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 	bus->parent = &pdev->dev;
 	bus->read = unimac_mdio_read;
 	bus->write = unimac_mdio_write;
+	if (unimac_mdio_init_sts(priv, &pdev->dev))
+		bus->write_sts = unimac_mdio_write_sts;
 	bus->reset = unimac_mdio_reset;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", pdev->name, pdev->id);
 
-- 
2.56.0

