Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7839E6F0
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126762; cv=none; b=XE6TfaZK8ppjeKYJIZ3Zn+m8siwpDn7BmYjiqqUY49opVVRKiAjXNUXNubR+MoDA3+KSaYCADBEyoYNAUDUrW7lPEfbJCHA/YGHOEPhClZLaUYQJSYy6krAh8gcN3qnNRMPVK6f5EOUCNQoHDohL4RmYwamzGX75ZSNo7l95cy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126762; c=relaxed/simple;
	bh=crYD9FsCo7u/ZLp7PH3HreLTAmNAPByXPBRR/HgHCL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMOBjk7EH69gwPE4pk3l66iunLtdOC0avGB/A1+KiorYgIUpZxHeWRGE6+XTiwBnX8VEsl4EFU1qPFHLoRZ9/VyBvXhpp8l72zxt1i7LpFlBA+6/v7Cl03ITI/NPadG4N4D7YNgAUO4+Ms1c/UJJnoDiwLkdp6BMrEa6zsGve/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYpitZqq; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYpitZqq"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e635220b4so589541285a.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792126760; x=1792731560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5pMf4NdY1cyxsLm3fpLx1RNiNh9Zh4IdtUUYRx7XZw=;
        b=CYpitZqqgbCaddqOw4a4GbZiZPSlFSE2a8z2tuiWqGglcJD6H83CEZWarY0R7Qnsc9
         Stql8hCSji4iPsl5lst7LOEcUnbPQirYzGJ/GLuN+2bbhAu9strJM6O0wySha3A6MwhO
         G0NfpUzWoRxMecu/IpxSMLJFyuR/WOA37HQaLkPzTKcAjWGacUtjD+29U+IkHFffQBx7
         mPoYGgYc+qvRWi1OHseqhbLrYe/NFyOMv9X7CJyNvyZn+b7qNQN1Xivi9q9//KKJ+MCD
         lS1uwCEyx9/30wZLBNmXUdOz3o0QlotN3h83S7tolJEyMJ8tVLGI7fP2AE6gqUhHitxv
         C83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792126760; x=1792731560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z5pMf4NdY1cyxsLm3fpLx1RNiNh9Zh4IdtUUYRx7XZw=;
        b=kVPQR0CHnMgpaJPk8W5rAiUPeul9+uqHeukJdQPkfA1gTOgTluzkqS8btpiAHssZAi
         cYQ43pO9BhiBIT67N1afZ3Xoeum8TtH9/oz0Sos4oBkJTP2vvJ1DeJTCbtb2L/7D3y9U
         UHQDIuIvLNdPydWgQ/lDidto9rOvrdPY52WE8/ZUsxi2DsPl/dGiHSQvYLogmPuWixjD
         7TW71sEp5aTSTasctaIFaGCNgK+UflvFSVUInkF2ONd3d5CQRpF0Qs9ofvfdGhgyU2Ps
         tDuP01e6uaedY6MDA4vda7mW7vBGpWkxlrGVpLhv55B9G2u/RoWcpFk8fIc+ZmqvMcxT
         t0Ug==
X-Forwarded-Encrypted: i=1; AKwUvBwe0q5qOet62xPJV0Xl/R2r2cFrBNuE2OA+9e4IkkaAAZ86Hgs5I7g5+84Opu0nnJAYXaVd1TA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDw18pXmJpsLu4St6Zu0ezdp+XnHAXS+AkS+xAFb9cXkcPVie/
	+8qKcSCDvKGezSKeXqn8aEWjSg8kzEFNSMQuqnJrfCduvmhKow2TXDZV
X-Gm-Gg: AYBFou0i1amkOKDABSMcZRaK8mYUaknDCUSMbn1u+85jTBim3jO3gsmrkVYUmx9itif
	pSjUstm58a9TXOtRme2KNmRIf196n338CrvjpxwA2Rf66mEH34pjs+QcoSgwLBPk/3e3IEdnjv2
	M1ybxJr1JN4LwFv77dEgzXi7Dht9jFUFqnvGSQfowWNyI1meKMbZnKK/9R7N9Hh4JukJNOslcE/
	GCDGKQ1UFfgyGPHHG/vg21VTlIAMGZ+8m0zZ0CnDeW8mOQW9DgWfnH/ELVYsN6w73iRNHklBPuZ
	fgGIq7bTdNPlaKS9HL8E9mK/k1qjMDwS17phhcFb6K3/Bl2I56kyhp34Fjjb4lTT52Tpepp9c0i
	nrEJp/emMTNSeqN4NBQ4ckmbakPknQCqbGxT+YJaJSnKubrUjry/Rlt0LcNXFLAoec2JfzmTw+Q
	N7c2zmfTqSp4IpRIXBnWqsP5HehnnMJzM4F+yivjBsA/wH1W8AhpCG+Cg2ug/96VHV7rn40CbSn
	oBTJTwborTX7k3A/sRpDON4ZTi0E+JI
X-Received: by 2002:a05:620a:2b8b:b0:93e:c12c:fbb6 with SMTP id af79cd13be357-93ec12d082emr3415103385a.67.1792126760053;
        Thu, 15 Oct 2026 21:59:20 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a198372sm118038685a.27.2026.10.15.21.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:59:19 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ariel Levkovich <lariel@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Alex Vesker <valex@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Itamar Gozlan <igozlan@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH net-next v1 2/4] net/mlx5: Don't free the WC test CQ if destroying it fails
Date: Fri, 16 Oct 2026 00:57:47 -0400
Message-ID: <20261016045849.813696-8-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016045849.813696-6-oss.patchbox@gmail.com>
References: <20261016045849.813696-6-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx5_wc_destroy_cq() ignores the result of mlx5_core_destroy_cq() and
frees the CQ buffer and doorbell record anyway, and mlx5_core_test_wc()
then frees the struct mlx5_wc_sq that embeds the CQ. If DESTROY_CQ
fails, the CQ may still exist in firmware and retain access to its
buffer and doorbell record. mlx5_core_destroy_cq() also returns early in
that case, without waiting for EQ handlers that may already hold a
reference to the CQ.

Return the error from mlx5_wc_destroy_cq() and keep both the buffer and
the struct mlx5_wc_sq when it fails, as the regular mlx5_ib CQ destroy
path does. A device in internal error is not affected, since the mlx5
core reports success for DESTROY_CQ in that state.

Fixes: d98995b4bf98 ("net/mlx5: Reimplement write combining test")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. It has not been
reproduced on hardware.

 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 7d3d4d739e2cd..df1b1555ed8f4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -148,10 +148,14 @@ static int mlx5_wc_create_cq(struct mlx5_core_dev *mdev, struct mlx5_wc_cq *cq)
 	return err;
 }
 
-static void mlx5_wc_destroy_cq(struct mlx5_wc_cq *cq)
+static int mlx5_wc_destroy_cq(struct mlx5_wc_cq *cq)
 {
-	mlx5_core_destroy_cq(cq->mdev, &cq->mcq);
-	mlx5_wq_destroy(&cq->wq_ctrl);
+	int err = mlx5_core_destroy_cq(cq->mdev, &cq->mcq);
+
+	/* The device may still access an undestroyed CQ's buffer; keep it. */
+	if (!err)
+		mlx5_wq_destroy(&cq->wq_ctrl);
+	return err;
 }
 
 static int create_wc_sq(struct mlx5_core_dev *mdev, void *sqc_data,
@@ -360,6 +364,7 @@ static int mlx5_wc_poll_cq(struct mlx5_wc_sq *sq)
 static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 {
 	unsigned int offset = 0;
+	bool keep_sq = false;
 	struct mlx5_wc_sq *sq;
 	int i, err;
 
@@ -396,11 +401,13 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 	mlx5_wc_destroy_sq(sq);
 
 err_create_sq:
-	mlx5_wc_destroy_cq(&sq->cq);
+	/* An undestroyed CQ may still be in use; keep the SQ that holds it. */
+	keep_sq = mlx5_wc_destroy_cq(&sq->cq);
 err_create_cq:
 	mlx5_free_bfreg(mdev, &sq->bfreg);
 err_alloc_bfreg:
-	kfree(sq);
+	if (!keep_sq)
+		kfree(sq);
 
 	if (mdev->wc_state == MLX5_WC_STATE_UNSUPPORTED)
 		mlx5_core_warn(mdev, "Write combining is not supported\n");
-- 
2.43.0
