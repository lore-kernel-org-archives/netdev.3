Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1854A33F2
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420237; cv=none; b=E4MGE1fVsmBrFJ1dWHfFEoUknk9DPzmkk64UyMZNW4cO3zdGZ1eqpjuE2dzOUxPryljhbKydVfptUhIdP9Sey6sl0CZDmW8iUEOQRvCfrn5EEdsKxr2uzVH5m8pkKJhNMVQexE11OJuSiOr4Cge1kMxBL7Bk5WsLR8DIOJ0Q030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420237; c=relaxed/simple;
	bh=o3M9fMvQMtpZS2GzO1eYfnxXoUMFpU5XZAqklIXwo4A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UB05oToeCIym42xvwTQxddTJ//Q501qSA0krmq111QI6WOdMd2jgooVQyHouzvtcYpN/Zgu6NwI6VBmWGQozuJI7mCiUUHarotxdF8L5uX6E1QAmPCAVpaOP16oItE/KQcnHH/tegImxoVdr1h6JBYub4UQ0m7IuuJTz2mSrdCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErwHv8ww; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErwHv8ww"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fe517774so32773465ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789420228; x=1790025028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9IiLJr5Vf5wvphms5NnQhY4OIWF+6MuNuAFO/k7he6M=;
        b=ErwHv8wwLzgGHmlGi1X6YEqiJaZiKDyOC6hA5bVuiBDQdiS33zjxnnE+jHoN/OTqIF
         zSuXrmolG8UnUbNABPV97aI9JXNvEXkQh9jnptligYYJPnmPr3Qf3mfRmf4P7xz5MS2c
         n9KPYM+rsH3ZHKd8hG2fIsY2dyjWEeXBdaVOkWNMrM1gTTwJLPQQ3BTzpittdR63ZvO0
         ZndZnrhz4H/Gdx4XcBLDDv57nzwxEPK8qc1xSN/1ZVvmtE6loQXnz5CQr6yiY68GUwCF
         BHZBRhPPkwirri+lWCSR4AedRR3vpmZ+AWvf4a0DE0WtGpaRH2K2hjtEEyERLekGu08w
         yufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420228; x=1790025028;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9IiLJr5Vf5wvphms5NnQhY4OIWF+6MuNuAFO/k7he6M=;
        b=r5uVc5aQtS2SqgjiAhYpEcbAeSOOMr6q/zQEtEJTvCll39wWKqAPibWYjBRqCHnF1o
         67hM5qxJcPTobuymoXxW+0ANUVYJ7ajJfEKdrMouIZRLH0j63mAFSqmlckqfXqKZ6HyL
         6SJP+6g5PoLvwsX/GdVwSPp4rVKt4zkT5lp7TMC6/mAE8pzLKqxw4d5vKtMgfaDkx1sL
         5vR0iRYmQJ3C8dXMrKvDDOn1TIA6EN0vpcFFaOQwanD2Cpu4ylSLwuaByaBeWkUELbe5
         val01KxC0/NS45XwsFvPZz8pnqSEOK3zVX8dKJNhbQ2SvP4YTKEcz4kABy/eUv8Gy3oT
         2tbA==
X-Gm-Message-State: AFuF++m9Uww5YBXXXFgFNtUMH2lVTg4zX3kEwZhO5GNvihYFK5UtsFdR
	KX0JOVu2VcAowm721FZYC+HlmGa3Gyx7HtmvygoCaJbJoR0dXvUoMwbS
X-Gm-Gg: AYBFou02ogDbrtBIiLMKr7c1gaHwvDEJQEkkrQ2xdI24lg2j7ClnqvQrMLZiX7YdsvR
	rC3uIxVJrz+PVNeLM+x91nLpemHR+5LYs9qIUgCBpwZ1lU3FUoLOE2B6TIOAzHntnIEE6u4RPKR
	OucG2yISJ2ASx4eYgC751g/PlHK3ESIA9TJMDbD4lNePyOBITkKw7BdLRhMLdSdB3c9io+YWKa2
	RTCwnGauwYoo0Rv9uHruc8GIX2NTq3Koxrqb4vFEhS5IB4sp3t8HLQK4u72oNZh2WNw9tMYK8IW
	rZhOTFbWUXJUFjU0F6Kj17iAoaTCdDtFBGM/fAki1jU3+RWIiCEG07GnL+4RwmGj7NiJ14HyXYK
	9ucIcEgX4PuZjU70LikoBgeIQGnXncLZBBdBPwU7KOo4ksjfP+SQBnyRTZQ5tOZXN+6bP/1VQaZ
	qg3tmq4wJa9AVNrvLJ0YAGfpSu3WyeDPP7NUflJ8R+nGNQWdyfxlS8f7BzOWC5wQNhs0HWNi+HG
	8Wi/zkTV6ulgHK5CmW+Y+W2HRYrKSwE9c/xSEfsIHgDyS4shKzGGXqwRY5w/1mHB/DjmiOhVxVk
	QG7aybLBHgvYXOCy50g=
X-Received: by 2002:a17:903:240d:b0:2d8:d4cc:be68 with SMTP id d9443c01a7336-2dd6c75858dmr100466835ad.21.1789420228276;
        Mon, 14 Sep 2026 14:10:28 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:d680:cb2f:f831:8497])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb7720sm55202385ad.37.2026.09.14.14.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:10:27 -0700 (PDT)
Subject: [net PATCH v2 5/6] eth: fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH
 when flushing the mailbox
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Mon, 14 Sep 2026 14:10:25 -0700
Message-ID: 
 <178942022583.7700.11050671998277309744.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178941996343.7700.9376081102002673062.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

When tearing down the FW mailbox Rx ring, fbnic_mbx_reset_desc_ring()
writes AW_CFG with FLUSH set and everything else, BME included, cleared.
Clearing BME halts the device's writes to the host but leaves the staged
requests parked in the PUL write pipeline rather than draining them, so
on the write path FLUSH alone never terminates the outstanding requests
and the flush the firmware waits on never completes.

Add the FLUSH_MODE definition and set both bits so the staged writes
drain out of the pipeline on their own. BME stays cleared, so nothing
lands on the host; it is restored later in fbnic_mbx_init_desc_ring()
when the ring is rebuilt, once the outstanding writes are gone.

The read path is unaffected. AR_CFG has no equivalent mode bit and
AR_FLUSH terminates the outstanding reads by itself, so it is left as
is.

Both writes remain plain stores rather than read-modify-writes. That is
deliberate: the matching write in fbnic_mbx_init_desc_ring() restores
BME and the TLP attributes, and clears both flush bits as a side effect.

Fixes: 3b12f00ddd08 ("fbnic: Gate AXI read/write enabling on FW mailbox")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |    1 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 64b958df7774..14af30e189d6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -974,6 +974,7 @@ enum {
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE	CSR_BIT(20)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_RDE_ATTR	CSR_GENMASK(17, 15)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 283d25fae79e..59aa879798b9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -60,8 +60,15 @@ static void fbnic_mbx_reset_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 	 */
 	switch (mbx_idx) {
 	case FBNIC_IPC_MBX_RX_IDX:
+		/* Clearing BME blocks the device from writing to the host
+		 * but leaves the requests parked in the write pipeline. The
+		 * write path only clears outstanding requests when both FLUSH
+		 * and FLUSH_MODE are set; FLUSH_MODE lets them drain without
+		 * landing on the host.
+		 */
 		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
-		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH);
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH |
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE);
 		break;
 	case FBNIC_IPC_MBX_TX_IDX:
 		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,


