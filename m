Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794298200;
	b=w03VmC5s4FQRvHQFqRcJZY5NpIn7r37iCMPdXZ5ZK3BBHIQXQGm10u3Cq4FxQYOT6Ctr
	 RDM2UQAQLu0Is1PilsNnSmhwqZTbAz8azQBRSOSrVUlPzHvWmSYGaZdo0c4k7uxGb3o/2
	 y5GrQLpEtEp7tXTSQgjo1bk4NNFkSxHdPv7SmUGeqoqyP3O/qmg6OaaHipIy8m+fddLFd
	 bYeXNsD0CombMKKDAitYZ1r6I5TaKV3fCwqRuebjUlrpVMy2RXJSy83OoSlPLxV0er8C5
	 Jrl6qrpQxvtXap3gthyaGGFv6PHmpITbIGjbOzA0rU3m3TDrVIBLifXrab9qw47CC5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298200;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XLq6hLDYm8MJrvEEqRgLlm3f5t67xvwXUwG/sLacj+Y=;
	b=uddoS2TicXuTY08KnAIXH8S4pp2KzNEPnnUTBYIyyAZyql5l1BB+WPFYdpThn5bbbo1z
	 JpdW1NSyMPyk6C6BrbKLClmeyQje2l9X7090cNFPVKPgzDKaY3uYQvX8udoBwMmXS1+Sf
	 J70+/1Ag5JS0M//sn5AUm+dFwKNzl9kU3JyinL0OVF3cumuwLfdMlZYOtgqWjynql3ijY
	 GdKIAqrJj+5zeW3HCKmHyuFmPX+y7RKhkfIeFmVJnNW+22GufvNjAXfeorJK+6cgsn1qj
	 eFXVdOt2YU+mBzeYbglyGW7QpCIRPCMH4SgYIFwBmCwAx+FzMIQX0ck5c9qy1y+YIcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ragnatech.se;
	spf=pass smtp.mailfrom=ragnatech.se;
	dkim=pass header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=Yig8NHSj;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5C5vbCcg;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2C60A261C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 08:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A2C60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.a=rsa-sha256 header.s=fm2 header.b=Yig8NHSj;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=5C5vbCcg
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EDFAEC05DC
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:09:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 10 Nov 2026 03:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794298199;
	 x=1794384599; bh=XLq6hLDYm8MJrvEEqRgLlm3f5t67xvwXUwG/sLacj+Y=; b=
	Yig8NHSj9lHLIZLKjNe8fxpumVVn2Qa9xUvP/5SkTbC86yw3oCfCUmqjrJXcbevN
	lfwSpNyg44Uo5SxKNvY+WVSW+q9vODVA51oGgaewXI/Cz9ZLCqWtEu1z7jGk3flq
	SnR33h16jKqqgNe9lp1CFeakP3jOnFu16ISDto/VrpuQ0Tul/c6moyldyRMf09EN
	EaR6Sok+pf+Gn2tjidG6Z8rmrcDCqWnMXdSrSpsko4jEgEn9yvHQ/L/e5Ev6KOJi
	GSPrk1ZwH2FdZIYnXVL1Ycz83/CGtNdC15lWIYyNQY4Ma7e3nysw+NLIIBne8y6h
	FLd03ewWUSDXtsYECabavg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794298199; x=
	1794384599; bh=XLq6hLDYm8MJrvEEqRgLlm3f5t67xvwXUwG/sLacj+Y=; b=5
	C5vbCcgwi5Brmi6bOsSqvhgsYMtvVq/hIuaRR7gWek1hVHEul2h9IGCxO8k9U2EW
	2l0QdlpEdOyBgUlMl50WHU6Q5wkIub0KE+AReZTOi/HoDwuUDDDSXdB4arkgqh1C
	gCMalnoUpsuVtoRp49AHppflJyLytTA/Z4PllcUuOhouBgRuhX1/NVRaezrebRET
	IMSxHY4yO5kWDLXTSvLuNOSCMO6aSyxyzPXAgNvuk7mT9C/CBhLPB0X2yvq+mYBy
	PQ4x3UBYBCT5kkMiTjcpRgs0trmQeObCabohvvZt/XiArve2Ozh1QR5xv+i7OCMI
	XpNumqEgSIGllaQmLGIRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ragnatech.se a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794298199; d=ragnatech.se;
	mf=PG5pa2xhcy5zb2Rlcmx1bmRAcmFnbmF0ZWNoLnNlPg==;
	rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:io1MoOAw5V2D8dSUBlPKe94+CtCiSWV/FksV65Bv0AbSi0r
	GTka6NkqQat4wGolzmC44uWhG/CmNvJQx2fSLAGT6+EMTeC8CgN5N96hz59f6H2b
	80t/k+GyrA4mlCE3q+ve4qaSKjLjp8eu/QAHESkQ6LE1XD8g0NC4+i7L8G7TXAWI
	4NmbVmmORZEwnKVvoEO2JTkr8OXI2ThLbpp/g71B25EDPaVYgRBik0nkEHwF3RXk
	NWrwrhIyg1wX1J0swnkrJswMMq8+115YZiaO+0EPsSpIGpo+mCUryUR7T/3hjJ6x
	9UOGsUsmwj6YtI3i4UIulQM2/kZMFWJtKsUleoQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:S2YMFbmXBLsOoqovpzknScuW+8i2emKK60YjCc7jDY8=:7r8iapYyDxj+zufD1N6tyXRhJir12RNFslJQ+3bmxqA=;
X-ME-Sender: <xms:V9HyakMdbq9ZRrZOmZ_MK6AJVjLchWJvctvavtyX3jyB9r6MZjGCUQ>
    <xme:V9HyajtDGVF55gGrSK8kmZhAKBxv6tHQbqAlafS7fuoaU60HFKMl30bGWWdf_Y_8s
    SfT2LH9GbqtAsPYBbPgeIP6neRgOv9DxklM-qKqglt8TBab3L4kTODS>
X-ME-Received: <xmr:V9Hyap_BK6mH3A6vKjz8NODkptfeD9jYtOlrlQD0NBejOLHgof6GS8AnA9vWExAjOE9CQEgCK80S0XxxExHffHNvKYleAt0>
X-ME-Proxy-Cause: dmFkZTGuOLErSs1l+S276B+qKPBR6I6yAmnkdBv7NuWWQbHTIy5o96o4kikxhojnDzOvan
    HrDafnOp4ba81usUsSW5/04LzzAQtwveWm1YoC1JFBnMLieqEfN82NXlxDSbT3Hn8iryXs
    nGxaa5J4aJxISAHyf78+hjfY00lsF6F8mfMAUyd2Y7xwlTSqej5k9lExGsrmsk/p5l16ea
    PZZkKBEhUBem8C3X3b4L0bMFvDgPjYhkLTqS7sr+dl6hJ4kHbuxDuQ4hVMeYESD0rD0/eS
    7AtUJuVETqaQvhe/moLSUh8sJzyk9bNASUP+GeDiGmpS+yAPHTOPWP9hRPE8zGnGgRlmrh
    7eJV3sDW5GSfBQ6lXSjaFRk0gpUL7nntcddtJ6WCuLe0oEsLG2WBbbGB1O96sZcONCamdn
    8XA/d8jogA8tSfuqAETgn3y/aBlekNwXWUBNSqTnWJLHk5y7L1TLQrhJUTfkJS0qyW1DSJ
    5FurZDtwnS6P2WTv4c2kDtMO+TZQpD6i9Pi+LxFhHzWNJaO6bftfykAHMYsJT+o5i0Rb54
    DPqfqMYRGKolasv7DHWGu9xqvR1I2wAJN39Ikm8tND+rKYcceWIPfFtSMgAaBI5BKAF6bc
    5KmJLzzm+T9rP/OjDgM43p5lPlX25qLrQ5YJPAn0oV7unCiVktlc2AEsQ3tQ
X-ME-Proxy: <xmx:V9HyavHhRBqm8GjooX-BvWOMeE94ur9om8IYt5rUCeCYOVantPTPfw>
    <xmx:V9HyagR5Nfafz9PyyVHlhxkkFWb7tG4xTjVmdmmJiB7mwZIcgg1--A>
    <xmx:V9HyalvVJOs6rEGoDU89-frOS69OA-gUAQXXAPSI5h3_BvDdG3u06A>
    <xmx:V9HyalCj6OV9GmlAgUmNlMQboeg8CkYfH-xcDizABqbj-NFTiHOjCg>
    <xmx:V9HyatGqsBwiSZ1kbPvkMudtbCaYs-1yiK6UtxTt04vUHM0YA_Y8Os0L>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 03:09:58 -0500 (EST)
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
Subject: [PATCH net-next v8 2/3] ptp: Add driver for R-Car Gen4
Date: Tue, 10 Nov 2026 09:07:26 +0100
Message-ID: <20261110080727.2377040-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110080727.2377040-1-niklas.soderlund+renesas@ragnatech.se>
References: <20261110080727.2377040-1-niklas.soderlund+renesas@ragnatech.se>
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
index 085fedac38ef..d7ad3e1b5295 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23827,6 +23827,7 @@ M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
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

