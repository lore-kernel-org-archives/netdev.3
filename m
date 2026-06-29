Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC58270540
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722766; cv=none; b=Km/8dV8fN2bUgI0El0iTs8Cj9pQKw1K9aLc5O41OvNH5SN5vEcHir4FA7yK+w6lWWXZvIluQjTuJuCUxkvJ2MhwWSvgBFKPcuGRHN1JZrpuiQ9IaYo4e0Mh1UvHg2rWbcY+XU1KllarWC7EMugrbWbqhF7oMLHL+dOIDImKzQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722766; c=relaxed/simple;
	bh=f00bhBu1DWfmKeN+Mt+gDvf6h2mu2VhICGcbH9ksmvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hZYe83q3TPSRpvzWdCKxCXOT1H1MqPtmmY0qoVoL4L+CltbfrKACtCaaUFmUwiCTfDuNX8hi7CQpb5rA7A8NmwBkrnN8e6w9TDhN1YbeHE9GhMLtBQxLu1d6z3zn3lhSvt7nC5x9xpYo3V967Zj0RP5nSP1cI9OUDAdxWDWMKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=flujbt1k; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="flujbt1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782722755;
	bh=u/9D703qkJvByqYo1HynA/w4Nqm+6hp/9sApEaNWPqU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=flujbt1kRMzF6EAnVMwmSgQTS+UJ815C1NrvKW9rL+SX6vIG0WvX7dLF/r7l3Dg8p
	 1qrBvWgmEcGDsW9SWEYazRmjQNcoobT3WUSyfSBSMdVWQsuUxd1Um31Ji/Muu66hOZ
	 gdJM0N2Phr/gnuz7kN8h1r6matZJdR5b/DoR5vPM=
X-QQ-mid: esmtpgz12t1782722741tfe787270
X-QQ-Originating-IP: rEmtwW8me4czeH3kj23Eq5VX69+2ort3JzdMcJnarZE=
Received: from localhost.localdomain ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 16:45:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9342495626788472101
EX-QQ-RecipientCnt: 12
From: ZhaoJinming <zhaojinming@uniontech.com>
To: horms@kernel.org,
	andrew@lunn.ch,
	madalin.bucur@nxp.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@linux.dev,
	zhaojinming@uniontech.com
Subject: [PATCH] net: fman: guard IRQ handlers against pre-init interrupt
Date: Mon, 29 Jun 2026 16:45:29 +0800
Message-Id: <20260629084529.3709393-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: N7bzzhFwp0G2OBrbk85IV1m/jbwadjaIkZjtL1qEdqn5KxZDbSzg6gJJ
	D0Q0PLtkZUjw7bj9MhpPR9oCb5frZtQKcf21dYeu+PX3tSM6gw8ua0xwt79hjDjCdM/chyc
	qIjug0vd1LpbTc26M4s+2t1LE0BPuUsk0rXVuM20r1qQeMXutTDnuPDHlevhfLvVVVyjtcI
	JK8aWnGPjlBkUPuJCUUyKZs6k+O0T/4ZzSHD5Y+p2nGRq+tCnjjTq7aS8NXsIAAtMu5+Kdk
	Y2A+rMYRBhZLlSCHHC4FwNDLJPe+Y3rrAhVbVBBuFdft7ll9pTgUlw0QYSrUUvFkLbRedvd
	YMEIjSHwH8OvciVaRlyaCuhbWOfo+eTTn9cQc5RmOc12Cc5GQ0rsWiS+T1EJC2O0yt3NqMM
	fncJFtOsBOyGjt14oo5/5dp8kAAh5xtOcwa7Kjyg/EfzhsaSnE7V12ZffUJhE9GEgnwCj1f
	jEVdfZkd7Ap6o9kXYN7A1OoefUq5cayKVYzEv+pnynYsUBKOrS4/ZRBfRIjne2IgbQqRSBP
	of6oVBhaMKCIIyP2L59wmoQrTs5ywdWUzMlhhGoVGtUdWqEzXxaXXOQPidjl2LgYb/rZzb2
	Yj/CK65XthC/S3AAM91NfqCp//eo4thz81HtwqoKTOYRyBVHCU3CdbgdsFgSUgfox2bCdhm
	X1g0vSMZcM5/ieTVK5J9FzC8pdSujg0Nadd023rMXwQJfYz0KnA1QcLcfJhxx8PDhySvwYM
	3/Zct88SFh041UvJO2KVI4GvWw2kD0XsudWsWoDQ5dZe1CdcJSqLNiSwb/D3dNcF9r6BaYe
	U4oL23ZsYTdEzj1YxTY78W91zR3E+ddrACYYZtXxkSZJcYJg7bGuD5cER+OODLk9BC11Uxb
	scyNlfV26c6eqyqV3tBhxZrxGCIq5KdKN/hVDEo/FygEyhpF1HaG0SGFIfWhRWE+GW4tryn
	kckm/LZsHKlphx6wHj9w6QyBvj2MPWxi/CyhGw3Hb/Q8RpPRB9e69xhBkiqzhmbZBRUrNm4
	sD0WizxDmVj/aKQBoF0ixf+sT4rpPf91yyFWOAvw==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

read_dts_node() registers shared interrupt handlers via
devm_request_irq() with fman as the dev_id, passing it to fman_irq()
and fman_err_irq(). At registration time, fman is only partially
initialized -- kzalloc_obj() zero-initializes all fields, so
fman->cfg and fman->fpm_regs are NULL.

The handlers guard against incomplete initialization via:

    if (!is_init_done(fman->cfg))
        return IRQ_NONE;

However, is_init_done(NULL) returns true (intended to indicate that
fman_init() has completed and cfg has been freed). This means when
cfg is NULL before fman_config() allocates it, the guard does not
take effect:

    is_init_done(NULL)  -> returns true
    !true            -> false
    guard skipped     -> proceeds to dereference NULL fpm_regs

If another device on the same shared IRQ line fires during the window
between devm_request_irq() and fman_init(), the handler accesses
NULL fman->fpm_regs via ioread32be(), causing a crash. The window
includes of_platform_populate() which can be slow.

Add an irq_ready flag to struct fman that is set to true only after
fman_init() completes in fman_probe(). Check this flag at the start
of fman_irq() and fman_err_irq() before any register access.

Use READ_ONCE()/WRITE_ONCE() for the flag accesses since it is a
cross-context shared variable written in process context and read
in interrupt context.

This issue was identified in code review during the discussion of a
separate IRQF_SHARED UAF fix patch:
https://lore.kernel.org/netdev/20260626162323.GE1310988@horms.kernel.org/

Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 5 +++++
 drivers/net/ethernet/freescale/fman/fman.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 013273a2de32..f14cb02d85a4 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2510,6 +2510,8 @@ static irqreturn_t fman_err_irq(int irq, void *handle)
 	struct fman_fpm_regs __iomem *fpm_rg;
 	irqreturn_t single_ret, ret = IRQ_NONE;
 
+	if (!READ_ONCE(fman->irq_ready))
+		return IRQ_NONE;
 	if (!is_init_done(fman->cfg))
 		return IRQ_NONE;
 
@@ -2608,6 +2610,8 @@ static irqreturn_t fman_irq(int irq, void *handle)
 	struct fman_fpm_regs __iomem *fpm_rg;
 	irqreturn_t single_ret, ret = IRQ_NONE;
 
+	if (!READ_ONCE(fman->irq_ready))
+		return IRQ_NONE;
 	if (!is_init_done(fman->cfg))
 		return IRQ_NONE;
 
@@ -2845,6 +2849,7 @@ static int fman_probe(struct platform_device *of_dev)
 		dev_err(dev, "%s: FMan init failed\n", __func__);
 		return -EINVAL;
 	}
+	WRITE_ONCE(fman->irq_ready, true);
 
 	if (fman->dts_params.err_irq == 0) {
 		fman_set_exception(fman, FMAN_EX_DMA_BUS_ERROR, false);
diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 74eb62eba0d7..ce06d5867a50 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -314,6 +314,7 @@ struct fman {
 	struct fman_state_struct *state;
 
 	struct fman_cfg *cfg;
+	bool irq_ready;                  /* true after fman_init() completes */
 	struct muram_info *muram;
 	struct fman_keygen *keygen;
 	/* cam section in muram */
-- 
2.20.1

