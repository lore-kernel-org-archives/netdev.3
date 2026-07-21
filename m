Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5E3C13F2;
	Tue, 21 Jul 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624548; cv=none; b=Tn9kkTE4uFIJKCLF3gMghNbFKdRnTZT7t/S/ZVlcVGMqvjarsCxzD4ErmTwddVLrSFUde7hdl4a9uuADC8N5E88TlVjFtTCKwSr6PjacfUMt5XF5ScKg8t4qisPgCZKGpxiZKoDoetaV255Xa26WOYaa5lSKRWF/bYzu+0uq9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624548; c=relaxed/simple;
	bh=yj9Ytki6jbqTSBQqHgre1McRlfsxk9qonmt4PoM09+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WlwgX1/FVleyxhgoruNDr030EE4Q1UDmIenEo7BH+4VI0PSGyIJx0E+aihKVY06OOdBc2fTOWcUPdg2DFgk4p+PfkUqaU+/Bnp4dEa9oPDgEG62LxwZh+3SKMsmpKPj4+F5szUjLwAabxA/G8J+PMJb1CrvxxEm8BefNV68opB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DYH3lddZ; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DYH3lddZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784624376;
	bh=CBPXqxevhKA4kwEyyHEOiA1H+YDO/kYclhGiWCFx5vo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DYH3lddZNiNAALYRyZ1wtdCeEzjyFxnxVps7m78MjadzkETpuQau/icWl6Slx5YOQ
	 hvo2Xsj9iFlL1Dj4dVnp8Ro/pqacUJ/Ta1pp2HYbPLsNa4InsyQ159zRVip3XwRf5u
	 96MOkuCYbvLPO99b9XdZBA/vTESEZOJGGcxpPygQ=
X-QQ-mid: esmtpsz16t1784624357tb49791a7
X-QQ-Originating-IP: 1sOYBZEzcPlZiopgg0rFprzTZmF5mSoO/ojKXE+g/Pk=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 16:59:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1395446343565307657
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
Subject: [PATCH net v2 2/2] net: fman: add error cleanup path in fman_probe
Date: Tue, 21 Jul 2026 16:58:41 +0800
Message-Id: <20260721085841.488088-3-zhaojinming@uniontech.com>
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
X-QQ-XMAILINFO: ObEYZLOwlZLan3dHRHc6MG3Pcz+epgWn28ejVH+GbA6rotbs6NAUU5Sr
	3zfJgxAYnSIDeVlmwSvVr+w9qJiDO+L4fR16gNhdXGTTdB8sAsD7fBrcD6gqZ1LYhN0kWQU
	medpibVtqRdLylSHoBxjJHVo7OYmpDta9NGC84mHs/xgFXup1GNtO0JM8mJF9fC8VZsCZ7a
	9xHmCarCySndwBrLWZtih6vvmcZeK/W3UV89lWQJpjkXwqwp8sEfwmoIoObzRg/2D86FsWV
	G6siNNZjFlMIIQkLAjTcZyFUr3xD4fD/Svk8Ze+tYrdGOcetiowOWac/WTQzla3v+wH8Rnb
	Nti/Js5h1nO/XbVoJz3UY1TPZR1gQ5g4Ex04sDKaCffELnkw3zj8JlqDfNxcnmfWtvqvC2q
	vSLFX3d0O3Z8Np8cKPqvih8jsRvnblVp3fNV3EzbW5eipUiqUsra75pGQHzMLrhXfcMioW+
	+5UUA1MD8RzGuNbgVNFrGJQR4GmzLty4Ex0Gw6nQI+Nvw3IZOv8a+RntGpq9COv+1sCaRKi
	Cy+YXd8OpXCq3ZA3Cl+NNVTxB0qilXa5++aXxe0I2JZkip5ALxKXjeR8Zb2GRZIfNY3tuae
	pkvK6VGqY+7L0tsg0Cnwskg/jOJcvws9DUbgGYYwcg5ZKosvQVxdEmX6KImz331XHvP9Yqb
	+khs8FYuBoZNqc1zOGXFgB5A6oYDvJ3t05FxaftwsZJdW+Q/4B6PilFVs744aXjx6Y0NIWe
	ekhQav+19mzys3YYLqYFOKTbCYXPghAFj8THC55n/x5b+E3G6QvnCmcI8hrCbP3ve1UGrvt
	x1xV6ogliZ1ah+Cy/v0hbWXmqc9IkE/MEeHLRMKJg+szDA/KX3v3Gq0qlx5EBo3FYqfedA7
	1tDE1MRKb0hhyh2kqnBV5F8UQpuErafVSMtQD5GK8vygbNuaZljQx0XgvAkzcMIb9nTvcCr
	gSS5+UaY3Bec0tJvh/L1uTka7/g/pLPsGZMHS5cHZhcM9OSVOIRuBUAB32pnZWF4YQiw4c+
	YLjH5ohRFG6oWsfJk/PM/FgFBYL2dF+/xw6jIB8mtXVY3HUdCbr1PtIKE1QIa37h0CMve1S
	QaEzk3EhRUI1WSYO/nuIfo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

fman_init() and devm_request_irq() failure paths in fman_probe()
do not free fman and its sub-resources (keygen, muram allocations,
state, cfg), causing memory leaks on probe failure.

Add fman_muram_finish() to properly tear down a MURAM partition
(gen_pool_destroy + iounmap + kfree), complementing the existing
fman_muram_init().

Add fman_free_resources() that releases all fman sub-resources
in the correct order:
- devm_free_irq() for any already-registered IRQ handlers
- kfree(fman->keygen)
- free_init_resources() for MURAM CAM/FIFO allocations
- kfree(fman->cfg)
- fman_muram_finish(fman->muram) for the MURAM management object
- kfree(fman->state)
- kfree(fman)

Use two goto labels in fman_probe():
- err_irq: main IRQ registered but err_irq or enable() failed
  -- free main IRQ then fall through to release resources
- err_no_irq: no IRQ registered -- just release resources

The IRQ handlers must be explicitly freed before kfree(fman) to
avoid a window where a shared-IRQ spurious firing could dereference
the freed dev_id.

Clear fman->fifo_offset and fman->cam_offset after each
free_init_resources() call in fman_init() to prevent a double-free
when fman_free_resources() calls free_init_resources() again on the
same error paths.

Note: fman_config() is not changed -- it already frees fman
internally on all its error paths, so fman_probe() must not touch
fman after fman_config() fails.

v2:
- add explicit devm_free_irq() before kfree(fman) to eliminate
  a potential UAF window on the cleanup path
- add fman_muram_finish() for complete MURAM teardown
- add kfree(fman->cfg) to release config structure
- clear fifo_offset/cam_offset after free_init_resources() in
  fman_init() to prevent double-free

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c    | 42 ++++++++++++++++---
 .../net/ethernet/freescale/fman/fman_muram.c  | 15 +++++++
 .../net/ethernet/freescale/fman/fman_muram.h  |  2 +
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 13913f152147..374f5b7305f8 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -1190,10 +1190,10 @@ static bool is_init_done(struct fman_cfg *cfg)
 
 static void free_init_resources(struct fman *fman)
 {
-	if (fman->cam_offset)
+	if (fman->cam_offset && !IS_ERR_VALUE(fman->cam_offset))
 		fman_muram_free_mem(fman->muram, fman->cam_offset,
 				    fman->cam_size);
-	if (fman->fifo_offset)
+	if (fman->fifo_offset && !IS_ERR_VALUE(fman->fifo_offset))
 		fman_muram_free_mem(fman->muram, fman->fifo_offset,
 				    fman->fifo_size);
 }
@@ -1963,6 +1963,8 @@ static int fman_init(struct fman *fman)
 	err = dma_init(fman);
 	if (err != 0) {
 		free_init_resources(fman);
+		fman->fifo_offset = 0;
+		fman->cam_offset = 0;
 		return err;
 	}
 
@@ -1975,6 +1977,8 @@ static int fman_init(struct fman *fman)
 					     fman->state->total_fifo_size);
 	if (IS_ERR_VALUE(fman->fifo_offset)) {
 		free_init_resources(fman);
+		fman->fifo_offset = 0;
+		fman->cam_offset = 0;
 		dev_err(fman->dev, "%s: MURAM alloc for BMI FIFO failed\n",
 			__func__);
 		return -ENOMEM;
@@ -1998,6 +2002,8 @@ static int fman_init(struct fman *fman)
 	fman->keygen = keygen_init(fman->kg_regs);
 	if (!fman->keygen) {
 		free_init_resources(fman);
+		fman->fifo_offset = 0;
+		fman->cam_offset = 0;
 		return -EINVAL;
 	}
 
@@ -2800,6 +2806,24 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	return ERR_PTR(err);
 }
 
+static void fman_free_resources(struct fman *fman, struct device *dev,
+				bool irq_registered)
+{
+	/* Free IRQs first while fman is still valid */
+	if (irq_registered) {
+		if (fman->dts_params.err_irq != 0)
+			devm_free_irq(dev, fman->dts_params.err_irq, fman);
+		devm_free_irq(dev, fman->dts_params.irq, fman);
+	}
+
+	kfree(fman->keygen);
+	free_init_resources(fman);
+	kfree(fman->cfg);
+	fman_muram_finish(fman->muram);
+	kfree(fman->state);
+	kfree(fman);
+}
+
 static int fman_probe(struct platform_device *of_dev)
 {
 	struct fman *fman;
@@ -2820,7 +2844,7 @@ static int fman_probe(struct platform_device *of_dev)
 
 	if (fman_init(fman) != 0) {
 		dev_err(dev, "%s: FMan init failed\n", __func__);
-		return -EINVAL;
+		goto err_no_irq;
 	}
 
 	/* Register IRQ handlers only after initialization is complete.
@@ -2838,7 +2862,7 @@ static int fman_probe(struct platform_device *of_dev)
 	if (err < 0) {
 		dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, fman->dts_params.irq, err);
-		return err;
+		goto err_no_irq;
 	}
 
 	if (fman->dts_params.err_irq != 0) {
@@ -2848,7 +2872,7 @@ static int fman_probe(struct platform_device *of_dev)
 		if (err < 0) {
 			dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
 				__func__, fman->dts_params.err_irq, err);
-			return err;
+			goto err_irq;
 		}
 	}
 
@@ -2863,7 +2887,7 @@ static int fman_probe(struct platform_device *of_dev)
 	err = enable(fman);
 	if (err != 0) {
 		dev_err(dev, "%s: FMan enable failed\n", __func__);
-		return err;
+		goto err_irq;
 	}
 
 	if (fman->dts_params.err_irq == 0) {
@@ -2891,6 +2915,12 @@ static int fman_probe(struct platform_device *of_dev)
 	dev_dbg(dev, "FMan%d probed\n", fman->dts_params.id);
 
 	return 0;
+
+err_irq:
+	devm_free_irq(dev, fman->dts_params.irq, fman);
+err_no_irq:
+	fman_free_resources(fman, dev, false);
+	return err ?: -EINVAL;
 }
 
 static const struct of_device_id fman_match[] = {
diff --git a/drivers/net/ethernet/freescale/fman/fman_muram.c b/drivers/net/ethernet/freescale/fman/fman_muram.c
index 6ac7c2b0cb19..6c2b4f7a02b8 100644
--- a/drivers/net/ethernet/freescale/fman/fman_muram.c
+++ b/drivers/net/ethernet/freescale/fman/fman_muram.c
@@ -129,3 +129,18 @@ void fman_muram_free_mem(struct muram_info *muram, unsigned long offset,
 
 	gen_pool_free(muram->pool, addr, size);
 }
+
+/**
+ * fman_muram_finish
+ * @muram:	FM-MURAM module pointer.
+ *
+ * Frees all resources associated with a MURAM partition.
+ */
+void fman_muram_finish(struct muram_info *muram)
+{
+	if (!muram)
+		return;
+	iounmap(muram->vbase);
+	gen_pool_destroy(muram->pool);
+	kfree(muram);
+}
diff --git a/drivers/net/ethernet/freescale/fman/fman_muram.h b/drivers/net/ethernet/freescale/fman/fman_muram.h
index 3643af61bae2..a5cb544c0f08 100644
--- a/drivers/net/ethernet/freescale/fman/fman_muram.h
+++ b/drivers/net/ethernet/freescale/fman/fman_muram.h
@@ -23,4 +23,6 @@ unsigned long fman_muram_alloc(struct muram_info *muram, size_t size);
 void fman_muram_free_mem(struct muram_info *muram, unsigned long offset,
 			 size_t size);
 
+void fman_muram_finish(struct muram_info *muram);
+
 #endif /* __FM_MURAM_EXT */
-- 
2.20.1

