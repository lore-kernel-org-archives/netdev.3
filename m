Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACA4F55A2
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416153; cv=none; b=bREjb0L8es00eQ4cAoDf+Y5vZCAyDeY1Oy8aS5vFxeVEj9vkcj+AcbTJIbVbTVzZJW1qBj8oTlEicppKSPAE6oC/Pogd4i5BYui511mmFND6iRTfvm8uomomnIyekCSZWMiNEDvDIDGBN+RbcYkODhr5RNGhkExUyGxgGGImRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416153; c=relaxed/simple;
	bh=5Dw4ApFmugf86j9b3TFizFB0Yq2QsSowt3OciC3O4bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=prDSNbnn0gvMF4Qd+Z6PxZ0hLArcUGP9dgm2N1RZnTy+EpWsUyCOwvKHba6bvsXL8aCr+35y/pvPWNQ3cPYm9/zXFunQww0IiS1TJtPOMydI8hcBiP4VShnBvRV2q5YHftA42i7Hz0AYN550BIgMtAoGT2ZwnBWFMWRk9F3zEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5OaEEkn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5OaEEkn"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-878b44611ffso1159567b3a.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416151; x=1793020951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nLKCvUycnmLTFqHSAdrCkAg3dpCGjBYjq7zy8w3DV4=;
        b=J5OaEEkngpuqFLCKx1MPP+1xzgpmNxmiiFnByZoXAvqYWJegdBe0BJ4IBPZ192dWzA
         1gP9SzT5cwjSjReIv84O42An6dR0VppQ6SY7loETHG543JMuq/zKpK1/528gkmwrfQDJ
         T7qsP3v2H604B4fi6ycMhzIVb0UVwwNQtCJudoPdoI/gZ7yhd9mU2AdWHEt5lHj3R0uh
         KHZtjHDeDpOPI3zmGaLUPka/PCy5O25KgDPkK3kSrtlvI6y3YHTT47M9nekicQTkcXaq
         WN54kBQsxD2KdNet52KBR7t5DUm1pLVMgd7wsnRGND/rQsiS6SAI3aQT0ct4JNn11pnQ
         v3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416151; x=1793020951;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0nLKCvUycnmLTFqHSAdrCkAg3dpCGjBYjq7zy8w3DV4=;
        b=StdaQF0w1NRkxA7APzOAGheoGi74ZHhujrkGO6w8A8JRx8ixrIw+15F5grf7XDAVaA
         lNNycNPDbwYLH7/4htwPr25BrM1SYt1phFpJu79kJNC3j/3gHTUMOJBkKfMMjBJxQ2gx
         OQzDpgRWX9A6G5liQ1Y0agSTQRxCgBSUTVOIj+OtCyo2wHBmNM0FkZTWmpMee60m/s0e
         iO/0EOmN1VoEacC+VI6Dkvbze95icRmthkEmeoKs8b/XQOKptrFFi3yJ31/Ehi2Wa+8U
         kj34TxquIXoPdf4WsBPcv2qJrhy5b8easKzSN5xxUEmQ/DLQDo+jeZPlTQv5D1BR+pYh
         /+3w==
X-Forwarded-Encrypted: i=1; AKwUvBz50LWvnTC3wPdHRMu21OI7Oeb8HBNvcQ0au4C7fHgWgU9xtjSqtVDhh19xFOhtN5ANrAfeCSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLbD7EsaIdo8XbzrOzYM8Wiy3U2thUsgMlQbJBzV3Z+is0AfYg1
	x/BtJWFytLYTyi5kKmxovuFaIoE9En78asVfMIB+s+02PeuXFvymUjTA
X-Gm-Gg: AYBFou2E1n3E91N5Bx9IJz7KEoRJ8bthOZkowEq++t5nlp1csJhqhT6CnKhhK/xqnMi
	CDoxeFkizhJ19ITrHR8L3FrfRBkt1K9meJhL6A0Va4CiYyEOUo5LARJMxa2tM9rpipcTirSFbqN
	onzykyGfW/+9fY96/sXmKKsbJ2jwMsIEmDG96YaW1qCzK++bHeuzLajc6c5SLkzQVk40Eqrk8FQ
	mX7KBrC+E/SWf6KV2W8ebFzpJgheX6/x1ETD382CbxvEiDHegkux57m5CJzXA9CyRkngaUWkaTw
	QcwNFAsj+li/T/WEd8X5WuFNHDrrXBpKscu3ixVzCLiqEq+tgVVr1/NOdDVsBfgY7bwLr+mNRGd
	3aQdVtT39vzu/HQT6Ci6HvF1j9q8zslRCiwK+Dg80EmvZ0hq1hDLhHqEjRhumdPOJ1B6lFOzOjH
	Fi8+7683IbutlX+ICXJvc4CVVG00zFkTQwfMW0e1D6UxzAO1lfjBQ2XmH27eFDl9wFqiRJ7dWjJ
	x3NyQ==
X-Received: by 2002:a05:6a00:408d:b0:882:905d:aa05 with SMTP id d2e1a72fcca58-8a04c14e9fbmr6226914b3a.50.1792416151035;
        Mon, 19 Oct 2026 06:22:31 -0700 (PDT)
Received: from [58.206.202.11] ([104.28.215.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89fcd67cf30sm3329023b3a.17.2026.10.19.06.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:30 -0700 (PDT)
From: Haoran Wang <haoranwangsec@gmail.com>
To: Varun Prakash <varun@chelsio.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev, linux-scsi@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, haoranwangsec@gmail.com
Subject: [PATCH] libcxgb: use raw_cpu_ptr() in ppm_get_cpu_entries()
Date: Mon, 19 Oct 2026 21:22:27 +0800
Message-ID: <179241614797.5916.13928836073297916808@whr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

ppm_get_cpu_entries() disables preemption with get_cpu(), reads the
current CPU's pool with per_cpu_ptr(), then acquires spin_lock_bh()
while preemption is still disabled, and finally put_cpu().

    cpu = get_cpu();
    pool = per_cpu_ptr(ppm->pool, cpu);
    spin_lock_bh(&pool->lock);
    put_cpu();

On PREEMPT_RT kernels spin_lock_bh() becomes a sleeping lock
(rt_spin_lock).  get_cpu() raises preempt_count, so acquiring the
lock right after sleeps with preempt_count still positive.  Sleeping
in that state is the scheduling-while-atomic case, which under
CONFIG_DEBUG_ATOMIC_SLEEP reports a BUG and, if the lock is contended,
deadlocks on the spot.  The trigger path is any iSCSI offload I/O
through a Chelsio NIC that reaches ppm_get_cpu_entries().

The preemption disable exists only to stabilize the per-CPU accessor,
the pool is serialized by pool->lock, not by preemption.  Replace
get_cpu() + per_cpu_ptr() + put_cpu() with raw_smp_processor_id() +
raw_cpu_ptr(), which read the current CPU without disabling preemption.

On non-RT kernels spin_lock_bh() does not sleep, so the BUG does not
fire there; the defect is PREEMPT_RT-specific.

With the fix, preempt_count is 0 at spin_lock_bh(), so rt_spin_lock()'s
might_sleep() no longer triggers.

Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
---
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
index 2e3973a32..5f68c5d57 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -125,10 +125,9 @@ static int ppm_get_cpu_entries(struct cxgbi_ppm *ppm, unsigned int count,
 	if (!ppm->pool)
 		return -EINVAL;
 
-	cpu = get_cpu();
-	pool = per_cpu_ptr(ppm->pool, cpu);
+	cpu = raw_smp_processor_id();
+	pool = raw_cpu_ptr(ppm->pool);
 	spin_lock_bh(&pool->lock);
-	put_cpu();
 
 	i = ppm_find_unused_entries(pool->bmap, ppm->pool_index_max,
 				    pool->next, count, 0);
