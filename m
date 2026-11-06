Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954284;
	b=Dqrqc7IsR8m3l5aYMYYzGFIOFhytXrTTwZARsnBaEMqVxioc6hBxb3CxTUBjThJTYMXl
	 gxdi5E7hd31FvkZTkK7kmKAqhvTLhR9su8/hXkD49oIiPMwiGG0x9x21YUwR5KLvNykqW
	 68ZrRm32/wDB2eBbiFGscvObNGxXFNOh2YTONfaa7xv13l4QQiUsguBaeNDaEYUTtyBhv
	 ouLDUaHIxlB05bYWPY/raozVX9bZ1KDt1gc13V4MmrwK3szHB3f2v77DgJXu+TVMzYy4S
	 tJW7HcPPUJzzaWnRZiGuLTN+K/kTu3bG3/Kb9rhO8IIcuQfwQysbYSiZ/iCuVLMIsbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lCz99xV0pwCuHWp/MF8TtxJKQhzQ+E9UJnv/R9Hy57w=;
	b=sVnjFMAyMXV78vGsDDfVkhfxZwa/b+1fXrKWbFkdWzyzMCV0sN/P3JFqkn4Y3qy2BLy4
	 HXLUqKAUxH6rYE2oeKVw4io/i5J6mc/RGJAqw24zMRoq2d7/xav/zVJhlPSmwLR0lUNDl
	 O4XjDDAcWRqeV35cu6whwjX/vjJOg3lkwevz+bVEy8p3C0IFamrlKFpJ3FFq4SxaModkv
	 6xDlqC+LAXy+KH4Jp9sYdiN4kFUSbj3Ut/dyGT0iqSwZaIc0v7KPZ805XeEfbPx+/5Sbm
	 lHDqsFVcVCbywd8KlfzpFoOnzNpP4WJp8yBlYvVcwsfCEvsTa72NVnRggAqSqywODyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+iunVLZ;
	arc=none smtp.remote-ip=74.125.227.128
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF1606A328
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AF1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+iunVLZ
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2ed216ed287so3432505ad.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 00:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793954283; x=1794559083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lCz99xV0pwCuHWp/MF8TtxJKQhzQ+E9UJnv/R9Hy57w=;
        b=o+iunVLZDINC4ehShCH14286mSr9iLWUncdmU/oFy1R6yw2eha5PgvV65arbMyAnae
         J7DA+Z27xjCldFjukhRix37WsZVVJH6lG8Z2Ddit/qNgozGq67dT1H4pTDg1EM5VKg7z
         u2l2a8ytkN4O09k6zbSPuZtoVPuHcBzjJ1+VimKYZpIim0fW1I2Moz54DctKEqsFPe+K
         RMC5ANzJjI75l0lH8u7NpDeZprppkL8tIJO9aL6Je7LbCPRGcfMtt0cYifrHqnK+Mrrj
         hxVUOHqnne+f/CJTYJvFI1HUyy1X7vOe7v//e1p1nb7U9jFdNqMAkhU64AeIyumsealm
         Vw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793954283; x=1794559083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lCz99xV0pwCuHWp/MF8TtxJKQhzQ+E9UJnv/R9Hy57w=;
        b=XLqPfKJc4jXmKtjyq817UxVquneYSEQs8vYxEBh9qKZEmUwoB6klh1f3D5t+vTKqPy
         AqRW9JxFWAGeDAxdJYpEw3QaDnq1wZOgetb9HyyQmgA6LfRQIdv/lV+akLdVqMh/0ZG5
         qEDezkaWxrxtajLh1069MxOjKoukMXAO5oekLcHoalYnmfB3l6MtedpWenooYMC4znUi
         HOoG48S/dZlzYV7PtPw1/S/XXL5IlLGIUY8TaibCpG4ilvEA9fsKr34MPGM6jRfu+fXJ
         b0s7DEDSt/xbP+fDmDiGt4On2GRp8klxZNcdPX1DrEqGmVvRzQ7V3cqEdgNuOyoF1+/o
         RQ4A==
X-Gm-Message-State: APuU4Z9FawxBfD+ctV7tadmFMAC1z14KWzChhhAj2KClXCrGzEj+dJEP
	0d1LSMmNHx9fnvI/fazC6+gH2akhZDkJLroVTHa8yxnJhkAtuiJSQRr7F59PiJoCs0zVeA==
X-Gm-Gg: AYBFou2IvmOMSpUAmVbl8zvca03JVhWGo4cGF9RB572n7Xc5D7QxQZ7Zb5/gzwGcUsU
	rRBaJIho91mGVRPbYOeR7wardTMDmEb09VmejPX12Q78Q1Nx/q80aZ79PD/aIQYN1wyu2Lh4Gt9
	t0ABnLeAiUGwH62YGyFdNY8OXyWJFiKs8Le9yChDShAg/QiEEVNuFPx6EsqUr60S5X3a7vi6xan
	hvUbZp8h2+ex/G6p8ahYY64R3pb0mj+Dao7fwGavQFfXSK1UPvHItAJviVfEPICbs2zxyq/lHfV
	S3RaB2lIQJyS8tlYR4geJsx80dNt7L6sEqRGoF6eD4CW6QEjhL1oSzfKRNp+HVsksMgBkmnjnSt
	KXwGQcQqa3rJ0wgnFAkLrDcn4L65b7jDnet4FLpVWAq/kOawm9W3wHzNOEUHTVjvxz2MMzyPqfz
	/EOQROC3io+x+jqj5gPmSohb4FJIDYaB+22Yqgr8CmKHDCXCmwR8gbGWActGdnymsGZUA4gCJ63
	tzLB3Gps/fYuHc09k8kqNmJ+KzG2l0LZL6Mpa7UQ1uNf+ubSr950lTq86aoA1xAmRggotN29Hqs
	lSpVfJtn1NK/KfW5mIzIVXEWqqCWATySkKvWM8cKvwBnp8Q=
X-Received: by 2002:a05:6a20:1449:b0:3eb:39fd:bacc with SMTP id adf61e73a8af0-3ebb2a9e69dmr2297053637.50.1793954283154;
        Fri, 06 Nov 2026 00:38:03 -0800 (PST)
Received: from localhost ([164.52.124.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3596fae32sm414537b3a.21.2026.11.06.00.37.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 00:38:02 -0800 (PST)
From: Jiabin Deng <dengjiabin2023@gmail.com>
To: netdev@vger.kernel.org
Cc: Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/mlx5e: SHAMPO, Disable end padding when relaxed ordering is supported
Date: Fri,  6 Nov 2026 16:37:19 +0800
Message-ID: <20261106083719.22798-1-dengjiabin2023@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SHAMPO and relaxed ordering writes are enabled, aligned RQ end
padding can corrupt TCP data received directly into GPU DMA-BUF memory.
The receiver gets the expected number of bytes, but some payload
prefixes are zero-filled, with the corrupted ranges ending at 64-byte
boundaries.

The current RQ end padding selection avoids alignment padding for LRO,
but not for SHAMPO. Extend the condition to SHAMPO to prevent this
corruption.

The issue was observed in a two-host test using a BlueField-3 NIC and
an NVIDIA H20 GPU. In the original test with MTU 1500, 354 of 400
transfers contained corrupted data before the fix. After applying this
change, all 400 transfers across eight message sizes from 32 KiB to
4 MiB, with 50 transfers per size, completed successfully, with no
incorrect bytes or corrupted intervals.

Fixes: e5ca8fb08ab2 ("net/mlx5e: Add control path for SHAMPO feature")
Closes: https://lists.openwall.net/linux-kernel/2026/09/15/154
Link: https://lists.openwall.net/linux-kernel/2026/10/20/1322
Suggested-by: Dragos Tatulea <dtatulea@nvidia.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jiabin Deng <dengjiabin2023@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5caf7820a136..159f79302a08 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -911,10 +911,11 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 
 static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
 {
-	bool lro_en = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO;
+	bool no_pad = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO ||
+		      params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO;
 	bool ro = MLX5_CAP_GEN(mdev, relaxed_ordering_write);
 
-	return ro && lro_en ?
+	return ro && no_pad ?
 		MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
 }
 

base-commit: fafbc4051123d5459ea6950899cec08ed946e278
-- 
2.51.0

