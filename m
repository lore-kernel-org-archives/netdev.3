Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DA4DEC19
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399600; cv=none; b=UV0sZiMbgBQ8BbtMm6CtPGxqzHbQ1wu413bxaJVOeEVcZj7HzRXwyTlq612FbTohOUnhXEF9t10Y2C2txxT9WRUUf+OvBZs8rfKS8pbcEJsD1+fHEeSnZ2S85U2MmmIZPmqe1sHuPYSiYAh2nq/I3IAcGWawoZe9dHSfdgbHyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399600; c=relaxed/simple;
	bh=KxrpTucu5pKwEKRzf6YkGxecdRJNpI/HRAgf1CnFPHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOQorldpVYuGMt7JGfIMkXfJRfqM3hUK5QT2KEN5hj6Px4d6NnRjjQx/bDnBHiROU7I7ZdJ+GYSs8tf7iOpO4JqujpHZY8laBk2kBx33K/jRMuajnlGXcOsX54bqCCkNz9ALMLpgpj984vWIs9qFroCnCSioXuTQVCSzcHGGM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=IgI5RocK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVdRZ8TQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="IgI5RocK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVdRZ8TQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7899BEC04E3
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:59:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 07 Oct 2026 14:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791399593;
	 x=1791485993; bh=qpxrPJb9SwoQEfoUtEzTZHYlp8fwFZHvQn7LQq4Iw8c=; b=
	IgI5RocKiTNuX5QzLLded3rwG5jRXljVxAgWoiL7Xex3J4hDyCG6oBrUQvr6wplA
	UkO0jawd19J7QgIZBGYaly6FCEaeNViYpBmgh5Q90wOCxk9HoRYKJkn58/3E32Ho
	BpXlgSoD5f7BBWp/A0arvk7YXrkxQ/RknjbN2ppwnJYO6Pd59StVBOSxENHZHSpl
	46aEBDkVaPcg64WralB1MXtFkh8KzbescBdsbpxidc9bq5LRAkp3ZoKcxsfbrWgh
	Vo9gyQry8KRUZuqr3EeQdO/vWQLfPJmeg28XIuxEkwI3CiiZ1NAx1vQvqpBZSPJj
	bYkYZ5A2TFn+CXYv0mZnTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791399593; x=
	1791485993; bh=qpxrPJb9SwoQEfoUtEzTZHYlp8fwFZHvQn7LQq4Iw8c=; b=l
	VdRZ8TQOUSJHbVoMYSRijWPAER1uTQ2pjdjMDzEsKBIIYEHBBfsnoSZEBINvFeaF
	B6LyMxcOOYdNT9yd/SvPG3Q/4E2G5u1hr6WCxGFeGMWO/OUithr80jZDFNXBsYe+
	LE2wHrlqdXZpB0YxoTVyE/lVHisjJXqJ+eRbfNSE4obMBxG4/vYl0azhYtBEkMdW
	vy1PDvjCdjvhs5jb8mI79MUC884Dnh5BRZ+UL0cPf/KyeJpIykr0X3yoEGft3bYG
	q5DjlM+oUjib8qdx32D7gtSjkZjtAhB4rLvntcoF+JQHZOb0fTofgy8tpVmU9x6c
	XMc4naTjSuueEODeX+NnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791399593; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QOqrqjoZDcplgvYreyZVMgAHgmjlCxH8Di1N7xqXfSzEQin
	Qswn+CV/AGMTGods74mYlgV3IzNiXnu7bBLCXWf35U25yOqRU2ibut4u8RDdiZlP
	lqZW+gFWnubSUC8SniAFSDy0s0hCAmFDVIIrdCg0dR+gg5NFqbS74j4zBXuzVPJl
	SOOcnCRNxG9rhxdKiSBdjYr3aA9ko8hvqFjG327oYx+NU9Ik5oTaBFzFfVh4W1sD
	qfBWmUVcboGEjuWAxTNBOg/w0zR47Z50x6m37ynXdRn62E3MnGC4hMu7mJU7vsQr
	4U6IBUwmCsIQkdctijQFBEgo1CVJICo5iLmDQfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QNWq3YYKIrC5xEoGn1KuoJz2ibiyffSYLFVnAe62FYE=:KxrpTucu5pKwEKRzf6YkGxecdRJNpI/HRAgf1CnFPHM=;
X-ME-Sender: <xms:qZbGatlPfaU7k7DLVnP1OCm-tEMpR81jEFN58U94s-Elu_6rutm6Zg>
    <xme:qZbGahmRTHPDMACbHg23BT8C3pvcm4yr95Q6G8_ns04Egb5sIN5VlZm69P4CUpXda
    osBtScuWRzPiXQN42OtT6l2GJ8k41vBpk55_AIe7F9dQ3zvdq3XeQGr>
X-ME-Received: <xmr:qZbGaiVdoZ2ah8SFzC0ARlSFAKUOPSMJkHgZDr0dK_8aYvGea7opv4nMx5Pc4Yzu2Am-YWYK70ng92Zjm4fUtuzqrbQL-D4>
X-ME-Proxy-Cause: dmFkZTFYNJOU7N9FzrFFxJqli0ONz6LkF2IRzexUHjp71GFcTng59m3+i/DH7TdaaX2kk/
    H9wp0bpCoEHAvhDXdik2SABbExxYs3DjcvPm24C5VkmXtZFMkbGBbIC3ZBAySLIAeULgkn
    m3nv1yV7skCwJ4UqDbIzG2nnjz1YTAQ26HyPwwMMYmQJrt0RnDr6DpMxjyG1e7yoaTvi1B
    gTRzeh4sCbTc1ubkFr+ctPubD26c0a56mMa+wCvUdGiskBjML6wzP2ecurnqA0v6WwX3Yu
    685r7HIjy5FxsclKENO6in28MGLKHRJUgw42+J8kyiC5/u2tNdcRTFuKrF+IvMDOFgKqLB
    4oYrUZsji+ou8rdt5CX0iBriLKjs1cScQ0tYhuPKHZEvwbty7XTPT7uCZXKqHcCRIB25Zz
    +wGwu5GOYKI4qVMGsqT9+eVlhLqljkLRAmSMOMKUoCqmpT9XxMPX0rJUx4lHA64lTMQ+6z
    kYIL4vgyDrZJcT4TToSKveGfbhOi70bQ/GyUSrNC5UN2A9twcc+jy2JKusxyC3Krc31nw8
    +Dg35xhYC0GijKeq6QwDzt0wVm7LNrbHKIpURyF/TBYcsdz2QBZ+nhDgYMlzVzS8hI29gg
    Nr1U9RLSqiMD8lCKqv0IrmzxieQHkhAd3yA6KFh0mPc3Rzp6MxGZw0325r8A
X-ME-Proxy: <xmx:qZbGav99mm1AOX2003oscZL4MCro7zrVsOUm5MojVlBODFn4HwyNAA>
    <xmx:qZbGavp-xVzp_gCrkqKxqhgb-6sdvKSZR9MZgjqetRhRO8enrDiR1A>
    <xmx:qZbGahljms5ZBMkjrcxmiRVjIzZ_v59MiODbGq0RGm8_NHwvk4hIzQ>
    <xmx:qZbGajaxdsuVHCRCV7pWPnUmUBtHMN2wg-duH2JovCzV18FgDhP2eA>
    <xmx:qZbGatcaHloqWGmUse-vM1Pl6rPfpO9JU4l6ifcrA1uGjFMVdovARfym>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 14:59:52 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v7 2/3] ptp: Add driver for R-Car Gen4
Date: Wed,  7 Oct 2026 20:59:19 +0200
Message-ID: <20261007185920.4042783-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007185920.4042783-1-niklas.soderlund+renesas@ragnatech.se>
References: <20261007185920.4042783-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add driver for the gPTP timer found on R-Car Gen4 devices. The timer is
system-wide and shared by different Ethernet devices on each Gen4
platform. The operation of the timer is however not completely in
depended of the systems Ethernet devices.

  - On R-Car S4 is gated by the RSWITCH Ethernet module clock.

  - On R-Car V4H is gated by the RTSN Ethernet module clock.

  - On R-Car V4M is gated by its own module clock, the system have
    neither RTSN or RSWITCH device. But the module clock is the same as
    RTSN on V4H and the documentation referees to it as tsn (EtherTSN).

The gPTP device do have its own register space on all three platforms.
But on S4 and V4H it will share its clock and reset property with
RSWITCH or RTSN, respectively.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
* Changes since v5
- Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync().

* Changes since v4
- Drop mod_devicetable.h include.
- Remove clap of register value as .max_adj prevents any overflow.

* Changes since v3
- Clamp increment calculated to register limitations.
- Check return value of clk_get_rate().
- Disable PM if ptp_clock_register() fails.
---
 MAINTAINERS                 |   1 +
 drivers/ptp/Kconfig         |  12 ++
 drivers/ptp/Makefile        |   1 +
 drivers/ptp/ptp_rcar_gen4.c | 225 ++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 drivers/ptp/ptp_rcar_gen4.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c1d592cd788..2a3b0c417d65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23204,6 +23204,7 @@ M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
 L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/ptp/renesas,rcar-gen4-gptp.yaml
+F:	drivers/ptp/ptp_rcar_gen4.c
 
 RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index feb50f8cc406..573334a66557 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -264,4 +264,16 @@ config PTP_NETC_V4_TIMER
 	  synchronization. It also supports periodic output signal (e.g. PPS)
 	  and external trigger timestamping.
 
+config PTP_RCAR_GEN4
+	tristate "Renesas R-Car Gen4 PTP Driver"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PTP_1588_CLOCK
+	help
+	  This driver adds support for using the Renesas R-Car Gen4 gPTP timer
+	  as a PTP clock, the clock can then be used by Gen4 Ethernet drivers
+	  for PTP time synchronization.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_rcar_gen4.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index bdc47e284f14..0464a586bed2 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
 obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
 obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
+obj-$(CONFIG_PTP_RCAR_GEN4)		+= ptp_rcar_gen4.o
diff --git a/drivers/ptp/ptp_rcar_gen4.c b/drivers/ptp/ptp_rcar_gen4.c
new file mode 100644
index 000000000000..e82b6c5abc30
--- /dev/null
+++ b/drivers/ptp/ptp_rcar_gen4.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Renesas R-Car Gen4 gPTP device driver
+ *
+ * Copyright (C) 2026 Renesas Electronics Corporation
+ * Copyright (C) 2026 Niklas Söderlund <niklas.soderlund@ragnatech.se>
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/types.h>
+
+#define PTPTMEC_REG		0x0010
+#define PTPTMDC_REG		0x0014
+#define PTPTIVC0_REG		0x0020
+#define PTPTOVC00_REG		0x0030
+#define PTPTOVC10_REG		0x0034
+#define PTPTOVC20_REG		0x0038
+#define PTPGPTPTM00_REG		0x0050
+#define PTPGPTPTM10_REG		0x0054
+#define PTPGPTPTM20_REG		0x0058
+
+struct ptp_rcar_gen4_priv {
+	void __iomem *base;
+	struct clk *clk;
+
+	struct ptp_clock *clock;
+	struct ptp_clock_info info;
+
+	spinlock_t lock;	/* Registers access. */
+	s64 default_addend;
+};
+
+#define ptp_to_priv(ptp) container_of(ptp, struct ptp_rcar_gen4_priv, info)
+
+static int ptp_rcar_gen4_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+	s64 addend = priv->default_addend;
+	bool neg_adj = scaled_ppm < 0;
+	unsigned long flags;
+	s64 diff;
+
+	if (neg_adj)
+		scaled_ppm = -scaled_ppm;
+	diff = div_s64(addend * scaled_ppm_to_ppb(scaled_ppm), NSEC_PER_SEC);
+	addend = neg_adj ? addend - diff : addend + diff;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	iowrite32(addend, priv->base + PTPTIVC0_REG);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void _ptp_rcar_gen4_gettime(struct ptp_clock_info *ptp,
+				   struct timespec64 *ts)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+
+	lockdep_assert_held(&priv->lock);
+
+	ts->tv_nsec = ioread32(priv->base + PTPGPTPTM00_REG);
+	ts->tv_sec = ioread32(priv->base + PTPGPTPTM10_REG) |
+		((s64)ioread32(priv->base + PTPGPTPTM20_REG) << 32);
+}
+
+static int ptp_rcar_gen4_gettime(struct ptp_clock_info *ptp,
+				 struct timespec64 *ts)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	_ptp_rcar_gen4_gettime(ptp, ts);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void _ptp_rcar_gen4_settime(struct ptp_clock_info *ptp,
+				   const struct timespec64 *ts)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+
+	lockdep_assert_held(&priv->lock);
+
+	iowrite32(1, priv->base + PTPTMDC_REG);
+	iowrite32(0, priv->base + PTPTOVC20_REG);
+	iowrite32(0, priv->base + PTPTOVC10_REG);
+	iowrite32(0, priv->base + PTPTOVC00_REG);
+	iowrite32(1, priv->base + PTPTMEC_REG);
+	iowrite32(ts->tv_sec >> 32, priv->base + PTPTOVC20_REG);
+	iowrite32(ts->tv_sec, priv->base + PTPTOVC10_REG);
+	iowrite32(ts->tv_nsec, priv->base + PTPTOVC00_REG);
+}
+
+static int ptp_rcar_gen4_settime(struct ptp_clock_info *ptp,
+				 const struct timespec64 *ts)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	_ptp_rcar_gen4_settime(ptp, ts);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int ptp_rcar_gen4_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	struct ptp_rcar_gen4_priv *priv = ptp_to_priv(ptp);
+	struct timespec64 ts;
+	unsigned long flags;
+	s64 now;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	_ptp_rcar_gen4_gettime(ptp, &ts);
+	now = ktime_to_ns(timespec64_to_ktime(ts));
+	ts = ns_to_timespec64(now + delta);
+	_ptp_rcar_gen4_settime(ptp, &ts);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static struct ptp_clock_info ptp_rcar_gen4_info = {
+	.owner = THIS_MODULE,
+	.name = "R-Car Gen4 gPTP",
+	.max_adj = 50000000,
+	.adjfine = ptp_rcar_gen4_adjfine,
+	.adjtime = ptp_rcar_gen4_adjtime,
+	.gettime64 = ptp_rcar_gen4_gettime,
+	.settime64 = ptp_rcar_gen4_settime,
+};
+
+static int ptp_rcar_gen4_probe(struct platform_device *pdev)
+{
+	struct ptp_rcar_gen4_priv *priv;
+	struct device *dev = &pdev->dev;
+	unsigned long rate;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -ENODEV;
+
+	spin_lock_init(&priv->lock);
+
+	priv->info = ptp_rcar_gen4_info;
+
+	/* Default timer increment in ns.
+	 * bit[31:27] - integer
+	 * bit[26:0]  - decimal
+	 * increment[ns] = perid[ns] * 2^27 => (1ns * 2^27) / rate[hz]
+	 */
+
+	priv->default_addend = div_s64(1000000000LL << 27, rate);
+
+	pm_runtime_enable(dev);
+	pm_runtime_resume_and_get(dev);
+
+	iowrite32(priv->default_addend, priv->base + PTPTIVC0_REG);
+	iowrite32(1, priv->base + PTPTMEC_REG);
+
+	priv->clock = ptp_clock_register(&priv->info, dev);
+	if (IS_ERR(priv->clock)) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
+		return PTR_ERR(priv->clock);
+	}
+
+	return 0;
+}
+
+static void ptp_rcar_gen4_remove(struct platform_device *pdev)
+{
+	struct ptp_rcar_gen4_priv *priv = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	ptp_clock_unregister(priv->clock);
+
+	iowrite32(1, priv->base + PTPTMDC_REG);
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+}
+
+static const struct of_device_id ptp_rcar_gen4_of_match[] = {
+	{ .compatible = "renesas,rcar-gen4-gptp", },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ptp_rcar_gen4_of_match);
+
+static struct platform_driver ptp_rcar_gen4_driver = {
+	.driver = {
+		.name = "ptp-rcar-gen4",
+		.of_match_table = ptp_rcar_gen4_of_match,
+	},
+	.probe    = ptp_rcar_gen4_probe,
+	.remove   = ptp_rcar_gen4_remove,
+};
+module_platform_driver(ptp_rcar_gen4_driver);
+
+MODULE_AUTHOR("Niklas Söderlund");
+MODULE_DESCRIPTION("Renesas R-Car Gen4 gPTP driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

