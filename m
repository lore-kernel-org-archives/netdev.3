Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F7B36E468;
	Fri,  3 Jul 2026 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064802; cv=none; b=ioZ1aBW0cWLc7ommlRuJqomv54RKrgvNpDhR8mBKXihKWyn+Js5OyiFcJxbZVGjaoZngXGIg+CR/zyMm8rSMrykzDZMjkqfRGYc0vZwpHx/uuvlJ9ri/vgd0MtChjl44QcYMq8mtTw+b0U5uOiT1rgL5iGdA+UD9VMnfokUf8dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064802; c=relaxed/simple;
	bh=d7oLPLtQYwgvRw4qBbsUUPu8B6Yu2gHwA8CAh47ThBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etUJ4uCt45b5qB+aci+/M0LZOEJn2O0Faki9V0U81/k9+IGT4cEPFHm+J+p4ujmgicKESaBLOsHM1Ee/Inx+AsNLH58H0Pf9VvpuzACHVZ2iF+ULwhSp98Z+umuaowIYu9FGNdIWOL0//sZ2bVVe+p9hIRAOq/YRAL7YRNiwPoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XIZSBJMm; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XIZSBJMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783064642;
	bh=IHXiw1vw+tco75KB3ut3dtVWWa+09qTyCy0asDDMIg0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=XIZSBJMmMquUaI9HhIMU80zNsrLLwoHAAnGQa00XsbbSEpF/Y8OmMnZfI78g2jBpM
	 OFXDb+cO7ax+h6SlM5zY90pbytrzEtkUCbIRjQZm0ke1jAulT6SO5BZGz7MP70gS+4
	 lzGBSOwkJ528E4p81nS8LbZ5xnZLd4ukaN9tvneY=
X-QQ-mid: zesmtpsz5t1783064624t81cc6e06
X-QQ-Originating-IP: Wa9IQjMV5FXNVwJsiopFkX4+XMkbnoA+qcH4qh7whvE=
Received: from localhost.localdomain ( [124.126.19.250])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 03 Jul 2026 15:43:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9081740018991067111
EX-QQ-RecipientCnt: 11
From: ZhaoJinming <zhaojinming@uniontech.com>
To: madalin.bucur@nxp.com,
	sean.anderson@linux.dev
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	igal.liberman@freescale.com,
	linux-kernel@vger.kernel.org,
	ZhaoJinming <zhaojinming@uniontech.com>
Subject: [PATCH net v2 2/2] net: fman: add error cleanup path in fman_probe
Date: Fri,  3 Jul 2026 15:43:24 +0800
Message-Id: <20260703074324.907294-2-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260703074324.907294-1-zhaojinming@uniontech.com>
References: <20260703074324.907294-1-zhaojinming@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MrL15gPbNc8s9MPEPLQ8Zgigy27YNTEE9IYzBI1uDIYTYXVcnzCyCkvM
	Wg6v+EyD9GcYMDvkCVxAs7iub1m13H7HTZiPDYLOGUQM3Bs3YyDonbVyNwTiXLEyrS3RQn6
	4gmc9MiiGXDX2PcTmN98q6hlGJf9F5W3B4is9eRef3xcCwhgRKXj27Q83cmOVX5SOaHRjsq
	Z+XaWWUiINTqMm/4l1LB90IUl5BSIhYliSQneeP8fqaMOgstnBbcTteKCu168b0ziayTnkH
	UJ76ROEFz5KxYvJdwXrS7s7n95c/31Qxh+JBmPDBKZwv1r1ynG/IvLcbwjVm0jiXs6i8p6m
	jrSyWhMMPaMMb5B1mEOQVzghDjJc4AvMJn+XgC5h5brkn3QThdNQHSubRl4192pBVU2iY/a
	z9J3s4PLqnnENkwQaJ+6BEPlzn/+xGjAelNspcpyKT44ovvsQlDKabz7ZkH1xpxb7Fu8p/Y
	VK1vEHK1ZHcpduG3zfMqHV2eOnJO/cqwiUzLQ+H5XoKmcI+fgpqxuLWn9GKCcj+Bv9Sagot
	JhapBDbLXZ6WWmDDZDEkLGdQbdygg/XI8YlBxJZy7x6fsNXjNqXelzdRvL8GqoJeQfqqXsA
	OHa3YHaGcbIfyJNGrN1cPFsJMcNp24Kg9tHv4ewJ5ZOMt7MvWxkKI/saFbljJj0/dQeVIEo
	bxo/OnEqYIyCzr0EqmUzmM+RvfF7mocD1Xx5JRpOFxLq/XIbpKFRcO6wltY9NTu+nWuwU7K
	QG0Z1+haLiUQnJlCYIBGeB5W55v+u8Be8+ajiVYoT8Pv4H/UUPLJcSG700LWEmwwUy4XEx0
	D2MJf1mHSzKYDtv7WQQ7uWkcnQCBWBgsH6LcgXavnJ5/iNvxWXulDQC7z31smXxnfTCOjtg
	7bsC+hVD/h9nk3daLmKpYAhB8MSrQJRSZw24FluCidY3T8AS4PMiUNwJW8xFLqB58n15cwR
	pMys9HvRWvk9vBOOLcduU+aF7FcEiJAxRZb4EICe5EZjCwl1B/hFK9zvK1tvZy6KQyfXn7R
	fEO62uK8CPQpKesMZWAk2DHadKiwWTPYtANkrRv6q1oO9ddn/tXD09AnIKf1VSmH1cEvZrC
	+XFYoPTUEUv
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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
- err_irq: main IRQ registered but err_irq failed -- free main IRQ
  then fall through to release resources
- err_no_irq: no IRQ registered -- just release resources

The IRQ handlers must be explicitly freed before kfree(fman) to
avoid a window where a shared-IRQ spurious firing could dereference
the freed dev_id.

Note: fman_config() is not changed -- it already frees fman
internally on all its error paths, so fman_probe() must not touch
fman after fman_config() fails.

v2:
- add explicit devm_free_irq() before kfree(fman) to eliminate
  a potential UAF window on the cleanup path
- add fman_muram_finish() for complete MURAM teardown
- add kfree(fman->cfg) to release config structure

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c    | 31 +++++++++++++++++--
 .../net/ethernet/freescale/fman/fman_muram.c  | 15 +++++++++
 .../net/ethernet/freescale/fman/fman_muram.h  |  2 ++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 6947f3bc7c87..752c0df0e17c 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2806,6 +2806,24 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
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
@@ -2821,12 +2839,13 @@ static int fman_probe(struct platform_device *of_dev)
 	err = fman_config(fman);
 	if (err) {
 		dev_err(dev, "%s: FMan config failed\n", __func__);
+		/* fman_config() frees fman internally on all error paths */
 		return -EINVAL;
 	}
 
 	if (fman_init(fman) != 0) {
 		dev_err(dev, "%s: FMan init failed\n", __func__);
-		return -EINVAL;
+		goto err_no_irq;
 	}
 
 	/* Register IRQ handlers only after initialization is complete.
@@ -2844,7 +2863,7 @@ static int fman_probe(struct platform_device *of_dev)
 	if (err < 0) {
 		dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
 			__func__, fman->dts_params.irq, err);
-		return err;
+		goto err_no_irq;
 	}
 
 	if (fman->dts_params.err_irq != 0) {
@@ -2854,7 +2873,7 @@ static int fman_probe(struct platform_device *of_dev)
 		if (err < 0) {
 			dev_err(dev, "%s: irq %d allocation failed (error = %d)\n",
 				__func__, fman->dts_params.err_irq, err);
-			return err;
+			goto err_irq;
 		}
 	}
 
@@ -2883,6 +2902,12 @@ static int fman_probe(struct platform_device *of_dev)
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

