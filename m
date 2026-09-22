Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE11E5018;
	Tue, 22 Sep 2026 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038375; cv=none; b=n89wtnSzqbkh9jInSs0VbMqdJHH7TBG48FyV10IQQ1/iFRb7gIj4CkZDGOzejyP3zsPYzLlUga9oBTGu/QMErK8C6BuNRAECGYVePStuZFWFGZobx99983i9y/GMDMHeeT4pbQBLhsTQ84hCwnO1dxG1XPhNdSWvMfd2jQpGnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038375; c=relaxed/simple;
	bh=Cb9hO8NrsaK7bH1Uj0Su8hEHDVvCvniPNrouaz/Epsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZmlwllAygDNMA/4OQl+pjqfW9cTAo9TfLAvwCrE+ev9GKy9FmxUjbKacQzWNaiAaZjTVlQXq9LyAUw9jSrEFa6WzLnjruvewdiXB5TVOpBPAnLHkgrPJGuZ9jLHR5t+DQdoi0kvgn4gPO/5VUaQUmcgMV2WAGdkVt1j2OniqH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/yFrYnG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/yFrYnG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDB21C2BCB3;
	Tue, 22 Sep 2026 00:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790038374;
	bh=Cb9hO8NrsaK7bH1Uj0Su8hEHDVvCvniPNrouaz/Epsk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Q/yFrYnGnK+dcCQiR89wS2SDNQ6ioFgb/YYoKIc/oasgYKZm1y7a8gD9nYcaPwC27
	 zRvdTBXwa7tuLB5omp9efwu/xE+BtJ7Nid3nnLBBJareCeyi/u4jpenIfun1xlCgW4
	 WZN5m79sK4Rk2TVUjRg0q3cX5xTZWkGTXCkOlUOUwDF6nuX8eGpHYmqwLIM4/HPgag
	 NL8eBTSIe8JVa1uPVGWNCECT4nbfak7hmGrRD87eWzdh0WI8qoQzzMftPC8jTG3uWi
	 J+VNrm9+XLVoYrBRzDuL1DmZcsvUuYsnronnZkq2u6ZdaZgLjwXAfARRgqyswHJ/4I
	 FplB81o/AQPwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0475C982ED;
	Tue, 22 Sep 2026 00:52:54 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 20:52:52 -0400
Subject: [PATCH] firmware: broadcom: tee_bnxt_fw: publish the TEE context
 last
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-tee-bnxt-v1-1-c8a58eb16f47@vt.edu>
X-B4-Tracking: v=1; b=H4sIAGPRsWoC/yWMQQ6CMBBFr0Jm7ZhSKKRehbhox1HGxGraSkgId
 7fF5fv5722QOAonuDQbRF4kyTsUaE8N0OzCg1FuhUErPSirW3x5zMzow5rR2GHkzlgyvYJifCL
 fZT1q0/XP6eufTLkm6sO7VNzoAs11OnAZzx1G6mHff4RsHfOPAAAA
X-Change-ID: 20260921-mb-tee-bnxt-5967e359c540
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: linux-mips@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790038373; l=5164;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=LpYmTkJl9oqVg6XeoRcgb3tPHTSxYv6uoy6OX8WgKF8=;
 b=MKxpzprkjHO6YTd2UXsHRgwErh0XF3oDnENhbcRChsXZaK9MlqOSp/id4Dixwm3iKd7NfqgxS
 OOoFTDQdPPUADXo1IeLgCSwT1G225KNElVRbsfLxLg+1L2szyAZ77H5
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

tee_bnxt_fw_load() and tee_bnxt_copy_coredump() use pvt_data.ctx as the
ready gate: they return -ENODEV while it is NULL and otherwise invoke
the trusted application with pvt_data.session_id and
pvt_data.fw_shm_pool. bnxt_en calls both from its firmware reset and
coredump paths, on the NIC's workqueue, at any time after the NIC has
probed.

tee_bnxt_fw_probe() stores the context first and opens the session and
allocates the shared memory pool afterwards. A caller that arrives
between those stores passes the gate and invokes the TA with a zero
session id and a NULL pool, and tee_shm_get_va(NULL, 0) dereferences the
NULL. Both the gate and the payload are plain accesses on either side,
so the same stale view is reachable after probe has finished.

Keep the context in a local, store the session id and the pool first and
publish the context last with smp_store_release(). Read it with
smp_load_acquire() in both helpers and use the loaded value.

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 38 ++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index a706c84eb..7bf544116 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -101,13 +101,16 @@ int tee_bnxt_fw_load(void)
 	int ret = 0;
 	struct tee_ioctl_invoke_arg arg;
 	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMB];
+	struct tee_context *ctx;
 
-	if (!pvt_data.ctx)
+	/* Pairs with the smp_store_release() in tee_bnxt_fw_probe(). */
+	ctx = smp_load_acquire(&pvt_data.ctx);
+	if (!ctx)
 		return -ENODEV;
 
 	prepare_args(TA_CMD_BNXT_FASTBOOT, &arg, param);
 
-	ret = tee_client_invoke_func(pvt_data.ctx, &arg, param);
+	ret = tee_client_invoke_func(ctx, &arg, param);
 	if (ret < 0 || arg.ret != 0) {
 		dev_err(pvt_data.dev,
 			"TA_CMD_BNXT_FASTBOOT invoke failed TEE err: %x, ret:%x\n",
@@ -136,8 +139,11 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
 	u32 rbytes = size;
 	u32 nbytes = 0;
 	int ret = 0;
+	struct tee_context *ctx;
 
-	if (!pvt_data.ctx)
+	/* Pairs with the smp_store_release() in tee_bnxt_fw_probe(). */
+	ctx = smp_load_acquire(&pvt_data.ctx);
+	if (!ctx)
 		return -ENODEV;
 
 	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
@@ -151,7 +157,7 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
 		param[1].u.value.a = offset;
 		param[1].u.value.b = nbytes;
 
-		ret = tee_client_invoke_func(pvt_data.ctx, &arg, param);
+		ret = tee_client_invoke_func(ctx, &arg, param);
 		if (ret < 0 || arg.ret != 0) {
 			dev_err(pvt_data.dev,
 				"TA_CMD_BNXT_COPY_COREDUMP invoke failed TEE err: %x, ret:%x\n",
@@ -187,13 +193,13 @@ static int tee_bnxt_fw_probe(struct tee_client_device *bnxt_device)
 	int ret, err = -ENODEV;
 	struct tee_ioctl_open_session_arg sess_arg;
 	struct tee_shm *fw_shm_pool;
+	struct tee_context *ctx;
 
 	memset(&sess_arg, 0, sizeof(sess_arg));
 
 	/* Open context with TEE driver */
-	pvt_data.ctx = tee_client_open_context(NULL, optee_ctx_match, NULL,
-					       NULL);
-	if (IS_ERR(pvt_data.ctx))
+	ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(ctx))
 		return -ENODEV;
 
 	/* Open session with Bnxt load Trusted App */
@@ -201,7 +207,7 @@ static int tee_bnxt_fw_probe(struct tee_client_device *bnxt_device)
 	sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
 	sess_arg.num_params = 0;
 
-	ret = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
+	ret = tee_client_open_session(ctx, &sess_arg, NULL);
 	if (ret < 0 || sess_arg.ret != 0) {
 		dev_err(dev, "tee_client_open_session failed, err: %x\n",
 			sess_arg.ret);
@@ -212,21 +218,29 @@ static int tee_bnxt_fw_probe(struct tee_client_device *bnxt_device)
 
 	pvt_data.dev = dev;
 
-	fw_shm_pool = tee_shm_alloc_kernel_buf(pvt_data.ctx, MAX_SHM_MEM_SZ);
+	fw_shm_pool = tee_shm_alloc_kernel_buf(ctx, MAX_SHM_MEM_SZ);
 	if (IS_ERR(fw_shm_pool)) {
-		dev_err(pvt_data.dev, "tee_shm_alloc_kernel_buf failed\n");
+		dev_err(dev, "tee_shm_alloc_kernel_buf failed\n");
 		err = PTR_ERR(fw_shm_pool);
 		goto out_sess;
 	}
 
 	pvt_data.fw_shm_pool = fw_shm_pool;
 
+	/*
+	 * tee_bnxt_fw_load() and tee_bnxt_copy_coredump() test pvt_data.ctx
+	 * and then use the session and the shared memory pool. Publish the
+	 * context last, with release semantics, so that a caller that sees
+	 * the context also sees the session and the pool.
+	 */
+	smp_store_release(&pvt_data.ctx, ctx);
+
 	return 0;
 
 out_sess:
-	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+	tee_client_close_session(ctx, pvt_data.session_id);
 out_ctx:
-	tee_client_close_context(pvt_data.ctx);
+	tee_client_close_context(ctx);
 
 	return err;
 }

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-tee-bnxt-5967e359c540

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>


