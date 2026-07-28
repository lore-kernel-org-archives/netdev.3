Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95254474262
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275250; cv=none; b=Xibk3JgpKqBojhTD3/LeRC48NoOIOv4LubSpHHrR5nDMedycHxdeFT0sBPEzryk1iMRpnsp7B4xCi0ZLrvjoJ0jtvUBqhfj+86VC197OydEDMWRQIF9Lk+LjOxGHM7DDrAactJYTqB4CeEMy9p15Dmugp770nj+XxBMT4pE3QCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275250; c=relaxed/simple;
	bh=arCSHmIPe99p+uOZo/Ya0BLeIuYdbdd5sTDUO5dIv54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lFOIrLIbnZBXqD3JB+OsaeNliuTktuPD8ktJFeHQZ0gS1NQxz8W0gKbvLKVhPCVgm4Vb8i5FUGS6kD+KYzu4FGIShVEH6egjY76HaB/s3dnM3F9IcfIN22aDHmKwQjuT5D9mfyKaZLTGDrCY93sR3ijbzIp9O/2FAjwCEj9BmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJQILAO5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJQILAO5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so291870a91.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785275248; x=1785880048; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6TWIGKjAU2ehn9qnpDFwgJ4KpTmG2HvE/6J3W1aUxlU=;
        b=XJQILAO5fCD5XeYW2dLAMmRR9GvnQ30fyqLk+6Qn7XnKEhNzOPfBl2Sm9vSYsjfGQ6
         bHPPYypz6InpfHgnYVG+GASIjq8pfHo4k0qnhxDS2GC/Rwbsil93ss6aixG5Inl/LF4V
         dqACUssu7f93guY1+pLRtWob1lTMzNoPbC1gx/JO+rds3A1E+pM4m8D7BqX9X1tyfnXv
         5efqwPne+ZwkZS0cIFouYDrejVxOJmJ4dOZkRuy2v56nHmPf8cQ+jl7KcTyc1G6TnNTs
         Vz2CuefFhKXR6CEl1Xb6h+fSOz0OvkCuD/7+Uj3YvRsAvQL6wjwhSdyXAdmwnu+ZrcGH
         rcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275248; x=1785880048;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6TWIGKjAU2ehn9qnpDFwgJ4KpTmG2HvE/6J3W1aUxlU=;
        b=BTZxwVl38JhdthrV5vC+Cz9AaEC9dq/N/LmR2fC+6G5SayhWTp5NxVMH5FInNx7CXC
         fuAzcOHICCnQuReePImdHPcGl2R3zC7cunnEeAHrNm4dpj7xdaW4244PCxONKem7H5F6
         mk8of0Lc0Ya+Y7/FmUbvIHV2RAdeOq/gWnVgTY5dASI40kEFwg7UQVep8oVo9PZAIO83
         /7oxk/LZXhUZj48E24Zx51Km2JB2LMgIq6rbEKiBUjnXY4oz9mOI7YoKHEkXSK1i9RHw
         NqVdoGLtyP3bDJK528FiTjOGMkc6j/ZgOUMpRJDVqFt4zbuxM7jQ4W37VKR67BpCqkHs
         U/kw==
X-Gm-Message-State: AOJu0YwsiHH8MZUJ3l2f2H8Ei6KoR1sElQCOh82eoRbxF5GckLZ+A9aF
	wgOBW7aBBTwqcR0sfs3qHYdHQWbyrgF8gmDZsLu51rYvWKywVlSSfA0C
X-Gm-Gg: AR+sD10sxURN8dr60RN3CM5kdX5SVJRi3T5NfntMARrWeebELik+k0OyTATOOLtDWnR
	1PXvzRet4Dg4hv8FIB0QucYSILvIGNMJ57VylDaR/5kIgGv/5bYlmuTQqn+JrBra8RlX2yQehUX
	95p9h3EYRxsTP4dC1PB2/jE30kBGtyxakjIxOZWOMyYJ17t+8Oc9OFMxUwcFT+gj6qMoaDNH49V
	Mss/fy0vqswgXKg/dZgmiH+Vwhnaei6DfozHe9E5MwlLyyzdShiR9FB/ifRg6NUsmBWr5fHhdfl
	zzE7ajacTGicVwGs8FxW5sh88hFh1wcrk6HQ6gS5uoYS1SWkxMPf1TZ6+HfFA1veFrc+WNDgXpU
	N5bT0ZZXVTWGy/vQFrlCJJa3YLKf3UO22ohZ4YL0UzgVqB1Rvi2Wa14HzAY9krYEKZ1Vwvs+hy2
	iaJzPF82w3/DLz+ffNuWUzxesTP98OcXqozzh2V/Oj0jjNI0UBG1r2GH3H5hSq+0Z4jA==
X-Received: by 2002:a17:90a:fc43:b0:37f:d265:18d2 with SMTP id 98e67ed59e1d1-38f6a267d72mr3944402a91.7.1785275247903;
        Tue, 28 Jul 2026 14:47:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f642e342esm1844961a91.15.2026.07.28.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:47:27 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Jul 2026 14:47:05 -0700
Subject: [PATCH net] net/mlx5e: fix BQL reset on SQ re-activation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-mlx5-bql-v1-1-99a0ab77ede7@meta.com>
X-B4-Tracking: v=1; b=H4sIAFgjaWoC/x3M7QpAMBQG4Fs5vb+tZvlYuxX5MRycYtgkJfeuP
 BfwPEgchRMcPYh8SZItwFGeEfrZh4mVDHAEo02la2PVutyl6o5F2YK18aUvqt4iI+yRR7n/qkH
 gE+37foAfhq5fAAAA
X-Change-ID: 20260728-mlx5-bql-84e02a5a46c8
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

mlx5e_queue_start() deactivates and re-activates all channels but closes
only the queue being restarted. mlx5e_activate_txqsq() then
unconditionally calls netdev_tx_reset_queue(), zeroing the BQL counters
of channels that kept their in-flight TX WQEs. The next completion then
over-charges and trips the BUG_ON() in dql_completed():

  kernel BUG at lib/dynamic_queue_limits.c:99!
  RIP: 0010:dql_completed+0x23d/0x280
  Call Trace:
   <IRQ>
   mlx5e_poll_tx_cq+0x668/0xa60
   mlx5e_napi_poll+0x5b/0x7b0
   net_rx_action+0x15a/0x580

Reset BQL only when the SQ has no bytes in flight (sq->cc == sq->pc).

In the case that reset is skipped, the outstanding WQEs will eventually
complete and rebalance the dql. The dql->limit is carried across the
reset.

Fixes: b2588ea40ec9 ("net/mlx5e: Implement queue mgmt ops and single channel swap")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4a8351f95b27..44834890a409 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1940,7 +1940,9 @@ void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
 {
 	sq->txq = netdev_get_tx_queue(sq->netdev, sq->txq_ix);
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
-	netdev_tx_reset_queue(sq->txq);
+	/* Reset BQL only when the SQ has no bytes in flight. */
+	if (sq->cc == sq->pc)
+		netdev_tx_reset_queue(sq->txq);
 	netif_tx_start_queue(sq->txq);
 	netif_queue_set_napi(sq->netdev, sq->txq_ix, NETDEV_QUEUE_TYPE_TX, sq->cq.napi);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 0b5e600e4a6a..d0ad1b8d6988 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -909,7 +909,8 @@ void mlx5e_free_txqsq_descs(struct mlx5e_txqsq *sq)
 	sq->cc = sqcc;
 
 	/* Do not update BQL for TXQs that got replaced by new active ones, as
-	 * netdev_tx_reset_queue() is called for them in mlx5e_activate_txqsq().
+	 * netdev_tx_reset_queue() is called for them in mlx5e_activate_txqsq()
+	 * if the queue has zero in-flight WQEs.
 	 */
 	if (sq == sq->priv->txq2sq[sq->txq_ix])
 		netdev_tx_completed_queue(sq->txq, npkts, nbytes);

---
base-commit: b515dc54795ef370be3cb396e7c12ad91686b6d1
change-id: 20260728-mlx5-bql-84e02a5a46c8

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

