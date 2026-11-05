Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857767;
	b=rGfYTR5lleetza96wGjK9UV7ipcODmJFImUnqVz+N1zD9fISlVZBQvzMxGMl/IP2yEwZ
	 DhVXY9nt63eiN5pz2XG3FuPfs++paTuYk6Iw1pD0Kpb0dblKF/b2Es+++r+q7SReiVO3b
	 R+0R5ehCFyqY4Qy1sT485h1r5CfEW4xq9O1tmmFPInagvFRhlIyHMR+HHVwT2Xa1PK3sx
	 DJsNtwZ0KhmTrXtXTpMopUZ4rlmcW93va0KUySV1IsnroRns6r/gqyWkTg8fm6aWXv3Bo
	 HJsSF1mlT4v74xaNDtxju595Xw65woy8zBu0ILo70v5AsQliAAiWyZ4BKciNcxjVlRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DRouvZOlTgkO1/S9+Q/eMlFgPxz9+2crlfyL0eD4J2I=;
	b=4PwSm66L/vGW2V+PV8xGvmD/G703S+Jw3AvivFSkmOcIE+Vk8SIMkWFfGKaVTjV0XDj7
	 3qdQDnjlgnfeNmxfqlhC/EL+6Rs1BZaYxEsbAEFAmXdcjMmIgMlqcc49T4xKyVKTzLI4V
	 TwcRGcFnKAIpIQ539Aza40n9MJW4Zdm522Q2TQQ9RnikVABadre9gXxTcTi/zAxJPcgjJ
	 1Q+/xBXQmSuoiu4k1n5GlHXo3WEG1DnedY8roCNv6jQtruI9EEnhBiZVPZgN5f+Yt2nz3
	 n+54TnezgABnqJXAi4+hxyQBWFEDG68tTwIxHQkqcYYBJYKVW4htOf08LoBnDBD2CgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fS1ZZgSA;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF48606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF48606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fS1ZZgSA
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso904709a91.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793857766; x=1794462566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRouvZOlTgkO1/S9+Q/eMlFgPxz9+2crlfyL0eD4J2I=;
        b=fS1ZZgSA+kKqvRRp+50KCGCJVgXcK+QZ+H5lrC36xpZknDDOmp/cdDYxoaBowSbNve
         RzkksOwGVVIxH/RPqOVQWyQOr+QT9QuPIEplwVEQnU/7DRI8A7+diJnRdOnaLN2RQjzZ
         mzs5pQ6jg5jf2YU2CZypcsK3Ct1ymQFV1rYvfpN8G6IfBOvGs4sPitWMHqzn9+eu+XTJ
         4BO6ZAw38yog0eY1sbSXrdjh9FlxPSPus9QJlAtOi+0NxOyyDq/gfGWUVreeVArCBhEv
         nxvBy13etmOtcjZYxwreGj53JXO0gnVy4YdO5sGmfvnxteB0MWlZTsoV3t2rvzIKZ2ph
         6JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793857766; x=1794462566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRouvZOlTgkO1/S9+Q/eMlFgPxz9+2crlfyL0eD4J2I=;
        b=Ap+7Q2T6MfOS0n+oAWMNuhpv/LbjWMye8tWBSENYmG8+eokQTbSu2xD/mMR+ko39pQ
         VcZp8PTAt4i/Du0hEbZhuTYP6gDEpsK25FXDNDS5QfAE9t4hkfiBWETBGTWckTHDUH6j
         mEqmzXD3rheximGGhmMx4b2SImbg/XDIHmleQ2fyKquQA72LLry943t8119YnmX2Z7Ku
         WvUUCg5LUfGL6mUtkgfqI2zK1BVJ5O9Y7pFkMRicf5akcPbBBq2lzNfvyTHtB6vB04JI
         55MCnGcyKWi1cyRjb1ZYK4+AOi33+ggRLwXfpHan61McYprFezRl3AxhUP/ThrAC1Pru
         6etQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfFHqPMJ7k49WQQyrpXgrmrjGRwgjAPadAGgdGm4mVD4NHtqAYSAkApABw2s2F6NJGbGLVsdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZuWUJU0l2xaOch20uKlK1y0/ONijsnzs9nTWrELO6G8GPZpPL
	OFhnCvxwbim1E8bd21AxYhxt0RXIVr++ILe229Xq15TIOLG7W+Fhcphq427cCFleXw==
X-Gm-Gg: AYBFou2BLvGpHfYR343Up41K50xRZtlcnzdhgiR433PF8z13uVgUUvMnE8FYBf7stgo
	jE0Y90bM6LTT02NL6WhIUcW3AWGh/4w62FOx4xgVLkjyKPe7KES/xSuxl5ALMuU79gVzvxbAntf
	jCuODm6BQQgRk7K9K7F+NkoYp3krENF1dymhVW0HbZUoL1BQ7CaBV979gQ77P8JnEN9b73M/Swm
	LepgVZ+qh79cRwsTAh2R8+azcm6JCb20leVXt0ttRL/22z24TmrSejujAZn/dRtD+9wQ7s5KLp4
	ZZqqgEoiiHGIZ5qz2K9p3aygmJht0FrA5FmBO9GcIYLVXcfXkwT9NNQs7ttg0JL/hIrrYQ4zX6F
	Z0WrZ4qjY96ofOz1wsdhEMhH6p0y8Jc0P11N+nRsW+u6Z1h637a5RQ8gxSyhJXxnxfjYBnINcY6
	shIIrc08ZclKkG/0jQxDR610neTbXN3++LuOge0JdFiuY00w7rYGiGPJjEzCR6MtanESqom7d0G
	PKwJoEqE88OIiwu0SSeeMHed6g6iA6tDGx2rXr4LLrp1mwSpNsAtSNtUyYQ0qVNBVHOLmXsdAAI
	mv9AbaDl/nC1mmOtGl4QYc7VXvAtWKUIDPJvivkSbjXJp+GnnrakQlDPyT9dw4+fv68Z+C1aQeW
	ff3EsD5oSYoiQqn6mzw==
X-Received: by 2002:a17:90b:134f:b0:3ac:7613:1ec3 with SMTP id 98e67ed59e1d1-3ae897e081cmr13401083a91.37.1793857765963;
        Wed, 04 Nov 2026 21:49:25 -0800 (PST)
Received: from cantal.lan ([58.136.77.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b319f2c9sm1989676a91.10.2026.11.04.21.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:49:25 -0800 (PST)
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
Subject: [PATCH net-next v3 6/6] net: mdio: bcm-unimac: implement timestamped MDIO writes
Date: Thu,  5 Nov 2026 12:48:39 +0700
Message-ID: <20261105054839.2248046-7-jjc@jclark.com>
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

Implement write_sts to provide system timestamp bounds for completion
of an MDIO write. This enables tighter system timestamp bounds in PHY
implementations of gettimex64.

Take system timestamps around the command start, then shift them by
the time from the command start until the MDC edge that clocks the last
data bit, calculated from the reference clock rate and the configured
MDC divider.

A clause 22 frame is 64 MDC periods long, and the transfer ends on the
rising edge of MDC in the last period, half way through it. So if the
frame starts with the command start, that edge comes 63.5 periods after
the command start. If MDC runs freely, the frame can start up to one
period after the command start, so bound the edge by 63.5 and 64.5
periods. A UniMAC whose divider restarts with the command puts the edge
at 63.5 periods, still within these bounds.

Measurements performed on a Raspberry Pi CM4 with its BCM54210PE PHY
show that the MDC divider of BCM2711 runs freely. The PHY's PHC was read
with PTP_SYS_OFFSET_EXTENDED while the MDC divider field was switched
between 9 and 39 through /dev/mem. With 64 periods, the midpoint of the
bounds, the PHC offset jumped by under 10 ns at each switch, after
compensating for drift. With 63.5 periods it would have jumped by
150 ns. The PHC offsets also spread evenly over one MDC period at each
divider.

Without the preamble, a clause 22 frame is 32 MDC periods long. But with
the preamble suppressed, the same test put the edge one period later
than a 32-bit frame would, as if the UniMAC still sent one preamble bit.
So without the preamble, bound the edge by 31.5 and 33.5 periods, which
also covers a UniMAC that sends just the 32-bit frame.

Take the reference rate from a clock on the mdio node, and offer
write_sts only when there is one. This is how the standalone UniMAC
already uses that clock: unimac_mdio_clk_set() computes the MDC divider
from its rate. When GENET creates the UniMAC device, the clock it passes
is its own main clock, which gates register access but is not the MDC
reference. No in-tree DT gives an mdio node a clock yet. For BCM2711,
the GISB clock, which MDC is divided from, is being added to clk-bcm2835
separately. It is marked critical there, so the UniMAC driver does not
need to enable it. A deferral of the clock lookup is passed on, as for
any clock, so the MDIO bus waits for the clock's provider.

For a standalone UniMAC, the reference rate is recorded at probe and at
resume. This means that write_sts uses the same rate as the driver uses
to set the MDC divider. If the rate changes at any other time, neither
write_sts nor the rest of the driver adjusts to the new rate; handling
this is outside the scope of this patch.

When GENET creates the UniMAC device, the reference rate is recorded
only at probe. On BCM2711 this is enough: the firmware sets the GISB
clock's rate, and nothing in Linux changes it.

Signed-off-by: James Clark <jjc@jclark.com>
---
Changes in v3:
- Read the reference rate again at resume for a standalone UniMAC, and
  update the comment where it is read at probe

Changes in v2:
- Take the reference rate from a clock on the mdio node, and offer
  write_sts only when there is one, instead of hardcoding 200 MHz for
  brcm,bcm2711-genet-v5 (Florian, Nicolai)
- Allow for a suppressed preamble, in place of not offering write_sts
  (Andrew)
- Explain how 63.5 to 64.5 follows from the frame timing
- Make unimac_mdio_write_sts() separate from unimac_mdio_write()
  (Andrew)
- Express the delay with MDIO_C22_FRAME_BITS and MDIO_PREAMBLE_BITS
  (Andrew)
- Wrap a line to 80 columns (checkpatch)

On BCM2711 this has no effect until the mdio node gets its clock.
Nicolai Buchwitz's patches adding the GISB clock:
https://lore.kernel.org/netdev/41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de/

 drivers/net/mdio/mdio-bcm-unimac.c | 138 +++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 31e396cc9fbf..b59c6838f14f 100644
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
@@ -151,6 +174,82 @@ static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
 	return ret;
 }
 
+static int unimac_mdio_sts_delays(struct unimac_mdio_priv *priv,
+				  u64 *pre_ns, u64 *post_ns)
+{
+	u32 cmd, config, divisor, bits, extra_bit = 0;
+	u64 ref_rate2 = 2ULL * READ_ONCE(priv->mdio_ref_rate);
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
+	divisor = 2 * (((config >> MDIO_CLK_DIV_SHIFT) &
+			MDIO_CLK_DIV_MASK) + 1);
+	bits = MDIO_C22_FRAME_BITS;
+	if (config & MDIO_SUPP_PREAMBLE) {
+		bits -= MDIO_PREAMBLE_BITS;
+		/* Measured on BCM2711: with the preamble suppressed, the
+		 * UniMAC sends one period more than the 32-bit frame, as if
+		 * one preamble bit were still sent. The upper bound allows
+		 * for that period.
+		 */
+		extra_bit = 1;
+	}
+	/* Assume that the PHY acts on the write at the earliest time it
+	 * physically can: when it samples the last bit, on the rising
+	 * MDC edge halfway through the last period of the frame, which
+	 * is bits periods long. Measurements on BCM2711 support this
+	 * assumption and show that the MDC divider can run freely, so
+	 * that the frame starts up to one period after the write that
+	 * sets MDIO_START_BUSY. The edge therefore comes between
+	 * bits - 0.5 and bits + 0.5 periods after that write.
+	 */
+	*pre_ns = div64_u64((2ULL * bits - 1) * divisor * NSEC_PER_SEC,
+			    ref_rate2);
+	*post_ns = div64_u64((2ULL * (bits + extra_bit) + 1) * divisor *
+			     NSEC_PER_SEC + ref_rate2 - 1, ref_rate2);
+
+	return 0;
+}
+
+static int unimac_mdio_write_sts(struct mii_bus *bus, int phy_id, int reg,
+				 u16 val, struct ptp_system_timestamp *sts)
+{
+	struct unimac_mdio_priv *priv = bus->priv;
+	u64 pre_ns, post_ns;
+	u32 cmd;
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = unimac_mdio_sts_delays(priv, &pre_ns, &post_ns);
+	if (ret)
+		goto out;
+
+	/* Prepare the write operation */
+	cmd = MDIO_WR | (phy_id << MDIO_PMD_SHIFT) |
+		(reg << MDIO_REG_SHIFT) | (0xffff & val);
+	unimac_mdio_writel(priv, cmd, MDIO_CMD);
+
+	unimac_mdio_start_sts(priv, sts);
+	ptp_adjust_system_prets(sts, pre_ns);
+	ptp_adjust_system_postts(sts, post_ns);
+
+	ret = priv->wait_func(priv->wait_func_data);
+out:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
 /* Workaround for integrated BCM7xxx Gigabit PHYs which have a problem with
  * their internal MDIO management controller making them fail to successfully
  * be read from or written to for the first transaction.  We insert a dummy
@@ -234,11 +333,23 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	return ret;
 }
 
+static bool unimac_mdio_init_sts(struct unimac_mdio_priv *priv,
+				 struct clk *ref_clk)
+{
+	/* The reference rate is read only here and, for a standalone
+	 * UniMAC, again at resume.
+	 */
+	priv->mdio_ref_rate = clk_get_rate(ref_clk);
+
+	return priv->mdio_ref_rate != 0;
+}
+
 static int unimac_mdio_probe(struct platform_device *pdev)
 {
 	struct unimac_mdio_pdata *pdata = pdev->dev.platform_data;
 	struct unimac_mdio_priv *priv;
 	struct device_node *np;
+	struct clk *ref_clk;
 	struct mii_bus *bus;
 	struct resource *r;
 	int ret;
@@ -277,11 +388,23 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 		priv->wait_func_data = pdata->wait_func_data;
 		bus->phy_mask = ~pdata->phy_mask;
 		priv->clk = pdata->clk;
+		/* priv->clk is GENET's main clock, which gates register
+		 * access. ref_clk is the clock used as the MDC reference,
+		 * which we get from the MDIO node. The presence of this
+		 * clock enables write_sts.
+		 */
+		ref_clk = devm_clk_get_optional(&pdev->dev, NULL);
+		if (IS_ERR(ref_clk) && PTR_ERR(ref_clk) != -EPROBE_DEFER) {
+			dev_warn(&pdev->dev, "no MDC reference clock: %pe\n",
+				 ref_clk);
+			ref_clk = NULL;
+		}
 	} else {
 		bus->name = "unimac MII bus";
 		priv->wait_func_data = priv;
 		priv->wait_func = unimac_mdio_poll;
 		priv->clk = devm_clk_get_optional(&pdev->dev, NULL);
+		ref_clk = priv->clk;
 	}
 
 	if (IS_ERR(priv->clk)) {
@@ -289,9 +412,16 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 		goto out_mdio_free;
 	}
 
+	if (IS_ERR(ref_clk)) {
+		ret = PTR_ERR(ref_clk);
+		goto out_mdio_free;
+	}
+
 	bus->parent = &pdev->dev;
 	bus->read = unimac_mdio_read;
 	bus->write = unimac_mdio_write;
+	if (unimac_mdio_init_sts(priv, ref_clk))
+		bus->write_sts = unimac_mdio_write_sts;
 	bus->reset = unimac_mdio_reset;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", pdev->name, pdev->id);
 
@@ -327,6 +457,14 @@ static void unimac_mdio_remove(struct platform_device *pdev)
 static int __maybe_unused unimac_mdio_resume(struct device *d)
 {
 	struct unimac_mdio_priv *priv = dev_get_drvdata(d);
+	unsigned long rate;
+
+	/* A standalone UniMAC's MDC reference is priv->clk. */
+	if (priv->mdio_ref_rate && !dev_get_platdata(d)) {
+		rate = clk_get_rate(priv->clk);
+		if (rate)
+			WRITE_ONCE(priv->mdio_ref_rate, rate);
+	}
 
 	return unimac_mdio_clk_set(priv);
 }
-- 
2.56.0

