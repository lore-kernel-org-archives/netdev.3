Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C63BB677;
	Tue, 21 Jul 2026 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624427; cv=none; b=ikx7Lne1rMXqXPWwo/viOj3pwXoeI8tHOQccOR6/XnobYkyKHF5w9fW4NYvEYzxSZ/5shMzdz6MymuQin3G4x62ugv8iie2Chl6XkyMT/S/F5hpz3WV/vkWWNddeV5uD3Z+pV7GovJIXtHLTGJsF12C4eWelc2OX0Ax8pT3ZCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624427; c=relaxed/simple;
	bh=SfgpNjJBpGOAUA1VWA4sklyoOuwx62du8iHNp5+NBiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s2o0zUdyl4F78IoAWEHrFtVNMzTyYNatd6ctHh3x6zyCfvR+ZcXhh4IP3vHGJpnz6y3LhxpYhYJOFZmOo20/Rv0IQ3zpES1foZdGTpRj7FHBGiR7oCrX7OpKyOltuDey9WRLnqZDTaF58eaBxn+US7Jey6OPXaKiwP5hpDslcAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SOsGojSc; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SOsGojSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784624370;
	bh=kolMI9/8OMm8eQLS5pVy6hbx4v4QIt3/T+M/ew+F7b0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=SOsGojScWPKfABsXGlcttoWj5ksqGK1lM94CYGNq4r/8+wTCxuM18y/knqYtPw75a
	 q83qziX4TKX5poEHO3UeDutDIoK7ZpCxpUlA5INiQLXyFJukPEHnUW99/TU4ul9ue/
	 fW1EHvxN3SMXzH8oanQrSdKCinaQqOMX2LS3liho=
X-QQ-mid: esmtpsz16t1784624350t8097b608
X-QQ-Originating-IP: sjP3PXbugXavF8Gchw0r7oXDnXxIofN9aUZczEtshfM=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 16:59:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 723668688038499813
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: horms@kernel.org,
	madalin.bucur@nxp.com,
	sean.anderson@linux.dev
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH net v2 1/2] net: fman: move IRQ registration after init to prevent NULL deref and UAF
Date: Tue, 21 Jul 2026 16:58:40 +0800
Message-Id: <20260721085841.488088-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260721085841.488088-1-zhaojinming@uniontech.com>
References: <20260709145221.1564906-3-horms@kernel.org>
 <20260721085841.488088-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MZChPk4K8ikNuhSGWHG563dFJYOCBYIhJDDiOm+k6mh/lQl07/3mZ3M1
	BvKsR4bsbs/qIsow9fXnnIh5FIuPgR94gEYC9FForLW2obtP4t2FtBQyQka9GUnZjxStQ2c
	3N+6noJaGCZGdndHdsDkBFF+LT9i2ALzk6X/sivmHdE9AngKzeHZ9m9HuEId78UllCfJudo
	SWM7pf8vmHnaRw2ofjP9DutDVKp6rA+RLPSiY95L78ghkC9++D9GF0jw9mKqaOD1SAf9M2+
	VWo8pYGHb8bq1TFc5mHthSmza7BvCmYkGywkFLlZo+yzRRX8qRUcEG07r4LpWt8uUSQWfO2
	AKS53D/HI0rch0uCVkG1ajNhRgHhBM+M9u2ZENNVOqqdQ4vqEWdoMwin1u44hYIOxIL+0xs
	1fcWxOaPg8CcPnSngcwGNb1XDHxDgiEUgT/JdPVYdkbTJ0+LuhkLuvdqs+u657cUOTlShhQ
	IC0tncZ5G0q9KJ+5Lvv/XdO5Hzd0LDthGATgD4LEyXbZ1hjZP54lJnZqV4djZ5uiJiWSrzs
	dDoUPt8i9aD4DGjlbjZ8/PyyudDzbBdqWQ0lrGTcjFvuVqHgaKx70jY0UZNLybfAfen76d5
	i3TRomQ8XD/3viyBiVNtgGWQtLNBD+p6UAmjHPEoOdDbDV+J0FmltSvmdtBIZ2AQdVVbJHJ
	foKyxBM0Eq7zBc4aDlMpIlVEi09+XDxmBlVk9itTBHaL7f9k62sLTX6JGOAR167hWzSa0Jt
	3GblCcf/2+g0L0T/I40dGv9IUzS0/hFeYZPcPejRJR0b0JexQJwbGuoNlkXrIKCmlerDFyj
	xJCA9jJx2TWrODoFaDzEWGqdojlKNI6fC6TV2na6S+MBhRAJQoYyU2vqWUgywXPybYYNWeS
	WXAglRR3Ei07teUHKeE9PWsV/5EpIetRK3j9zZFLi9mNqvkWWuiF47Sw9w1n+jPXvMWQ91h
	WFVTK9GMF5N9hH9GU/DSRUfJLOtsCzz+pfmammvL5NoHTdPv5u+5+MIIBb7C3YT1ScpnsdZ
	WqTzeKoQPpe+Vk3tP5qYqDR/PGOWKJHq5/LlMBD6ZUay13VEIH+FELXt3UfwqbRVY+pSZxo
	A==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

read_dts_node() registers shared interrupt handlers via
devm_request_irq() with fman as dev_id. Two bugs exist in the
current code:

1) Pre-init NULL dereference: at registration time fman is only
partially initialized -- kzalloc_obj() zero-initializes all fields,
so fman->cfg and fman->fpm_regs are NULL. The handlers check
is_init_done(fman->cfg) to guard against incomplete init, but
is_init_done(NULL) returns true (intended to mean cfg was freed
after successful init), so the guard is bypassed and fpm_regs is
dereferenced. If another device on the same shared IRQ line fires
during the window between devm_request_irq() and fman_init(), the
handler accesses NULL fpm_regs via ioread32be(), causing a crash.

2) Use-after-free on probe failure: fman is allocated with
kzalloc_obj() (not devm), so on error paths in read_dts_node()
(ioremap failure, of_platform_populate failure) and fman_config(),
kfree(fman) is called while the devm IRQ handlers remain
registered. The driver core's subsequent devres_release_all() frees
the IRQ handlers, but during the window between kfree(fman) and
devm_free_irq(), a shared-IRQ spurious firing will dereference
the already-freed fman.

A previous attempt to fix issue #1 with an irq_ready flag protected
by READ_ONCE()/WRITE_ONCE() is insufficient on weakly-ordered
architectures. READ_ONCE()/WRITE_ONCE() only prevent compiler
optimization; they do not provide the memory ordering guarantees
(e.g., smp_store_release/smp_load_acquire) needed to ensure that
writes to register pointers are visible to the IRQ handler before
it observes the flag as true.

Fix both issues by moving devm_request_irq() out of read_dts_node()
and into fman_probe(), after both fman_config() and fman_init()
have completed. This eliminates both race windows: by the time the
handlers are registered, all register pointers are initialized
(preventing the NULL dereference), and since fman is never freed
after this point, the use-after-free cannot occur either.

Additionally, defer the hardware enable() call to after IRQ
registration to prevent a potential interrupt storm on the shared
IRQ line. Previously, fman_init() called enable() to activate the
hardware before the IRQ handler was registered. If the hardware
asserted an interrupt in this window, no handler would be present
to clear it, potentially causing the shared IRQ line to be
permanently disabled. Now, enable() is called after all handlers
are registered and the is_init_done guard is valid, so the handler
is always ready to service interrupts when the hardware is active.

Change enable() to read qmi_def_tnums_thresh from fman->state
instead of fman->cfg, since cfg is freed before enable() is called.

Add an 'irq' field to struct fman_dts_params so that the primary IRQ
number parsed in read_dts_node() is available to fman_probe().

v2:
- move devm_request_irq() to fman_probe() after init (replaces
  irq_ready + READ_ONCE approach from v1)
- defer enable() to after IRQ registration to prevent interrupt
  storm on shared IRQ line
- supersede the separate UAF fix patch (v3), as this patch
  resolves both issues in a single change

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Link: https://lore.kernel.org/netdev/20260626162323.GE1310988@horms.kernel.org/
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 78 +++++++++++++---------
 drivers/net/ethernet/freescale/fman/fman.h |  1 +
 2 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 299bab043175..13913f152147 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -924,7 +924,7 @@ static void hwp_init(struct fman_hwp_regs __iomem *hwp_rg)
 	iowrite32be(HWP_RPIMAC_PEN, &hwp_rg->fmprrpimac);
 }
 
-static int enable(struct fman *fman, struct fman_cfg *cfg)
+static int enable(struct fman *fman)
 {
 	u32 cfg_reg = 0;
 
@@ -936,7 +936,8 @@ static int enable(struct fman *fman, struct fman_cfg *cfg)
 	cfg_reg = QMI_CFG_EN_COUNTERS;
 
 	/* Set enqueue and dequeue thresholds */
-	cfg_reg |= (cfg->qmi_def_tnums_thresh << 8) | cfg->qmi_def_tnums_thresh;
+	cfg_reg |= (fman->state->qmi_def_tnums_thresh << 8) |
+		   fman->state->qmi_def_tnums_thresh;
 
 	iowrite32be(BMI_INIT_START, &fman->bmi_regs->fmbm_init);
 	iowrite32be(cfg_reg | QMI_CFG_ENQ_EN | QMI_CFG_DEQ_EN,
@@ -2000,15 +2001,8 @@ static int fman_init(struct fman *fman)
 		return -EINVAL;
 	}
 
-	err = enable(fman, cfg);
-	if (err != 0)
-		return err;
-
 	enable_time_stamp(fman);
 
-	kfree(fman->cfg);
-	fman->cfg = NULL;
-
 	return 0;
 }
 
@@ -2695,7 +2689,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	void __iomem *base_addr;
 	struct resource *res;
 	u32 val, range[2];
-	int err, irq;
+	int err;
 	struct clk *clk;
 	u32 clk_rate;
 
@@ -2717,7 +2711,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	err = platform_get_irq(of_dev, 0);
 	if (err < 0)
 		goto fman_node_put;
-	irq = err;
+	fman->dts_params.irq = err;
 
 	/* Get the FM error interrupt */
 	err = platform_get_irq(of_dev, 1);
@@ -2773,25 +2767,6 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 
 	of_node_put(muram_node);
 
-	err = devm_request_irq(&of_dev->dev, irq, fman_irq, IRQF_SHARED,
-			       "fman", fman);
-	if (err < 0) {
-		dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
-			__func__, irq, err);
-		goto fman_free;
-	}
-
-	if (fman->dts_params.err_irq != 0) {
-		err = devm_request_irq(&of_dev->dev, fman->dts_params.err_irq,
-				       fman_err_irq, IRQF_SHARED,
-				       "fman-err", fman);
-		if (err < 0) {
-			dev_err(&of_dev->dev, "%s: irq %d allocation failed (error = %d)\n",
-				__func__, fman->dts_params.err_irq, err);
-			goto fman_free;
-		}
-	}
-
 	base_addr = devm_platform_get_and_ioremap_resource(of_dev, 0, &res);
 	if (IS_ERR(base_addr)) {
 		err = PTR_ERR(base_addr);
@@ -2848,6 +2823,49 @@ static int fman_probe(struct platform_device *of_dev)
 		return -EINVAL;
 	}
 
+	/* Register IRQ handlers only after initialization is complete.
+	 * This prevents two issues:
+	 * 1) Pre-init NULL dereference: is_init_done(NULL) returns true,
+	 *    so a shared-IRQ spurious firing before fpm_regs is set would
+	 *    dereference NULL.
+	 * 2) Use-after-free on probe failure: fman was kzalloc'd (not devm),
+	 *    so on error paths kfree(fman) ran before devm_free_irq, leaving
+	 *    a window where the handler could fire with a freed dev_id.
+	 * By registering here, both problems are eliminated.
+	 */
+	err = devm_request_irq(dev, fman->dts_params.irq, fman_irq,
+			       IRQF_SHARED, "fman", fman);
+	if (err < 0) {
+		dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
+			__func__, fman->dts_params.irq, err);
+		return err;
+	}
+
+	if (fman->dts_params.err_irq != 0) {
+		err = devm_request_irq(dev, fman->dts_params.err_irq,
+				       fman_err_irq, IRQF_SHARED,
+				       "fman-err", fman);
+		if (err < 0) {
+			dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
+				__func__, fman->dts_params.err_irq, err);
+			return err;
+		}
+	}
+
+	/* Free the config structure before enabling the hardware.
+	 * is_init_done() uses cfg == NULL to indicate init is complete,
+	 * so the IRQ handlers will properly process interrupts once
+	 * the hardware is enabled below.
+	 */
+	kfree(fman->cfg);
+	fman->cfg = NULL;
+
+	err = enable(fman);
+	if (err != 0) {
+		dev_err(dev, "%s: FMan enable failed\n", __func__);
+		return err;
+	}
+
 	if (fman->dts_params.err_irq == 0) {
 		fman_set_exception(fman, FMAN_EX_DMA_BUS_ERROR, false);
 		fman_set_exception(fman, FMAN_EX_DMA_READ_ECC, false);
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 74eb62eba0d7..630d57c3144c 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -286,6 +286,7 @@ struct fman_dts_params {
 	struct resource *res;                   /* FMan memory resource */
 	u8 id;                                  /* FMan ID */
 
+	int irq;                                /* FMan IRQ */
 	int err_irq;                            /* FMan Error IRQ */
 
 	u16 clk_freq;                           /* FMan clock freq (In Mhz) */
-- 
2.20.1

