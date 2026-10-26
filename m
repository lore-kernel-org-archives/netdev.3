Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008465;
	b=GYLUyanj+AXNoYgwOfZJXtUGq8rBOrhTq9El5R2Yawfq3Q/B6qO18qBtuUJ+PaBfR887
	 BpWTLnB3qTikGKcWWnVhJDSiJTffHyH3dhFuYreH5ERsek19505XS/N0Q3DunM34yOFQV
	 jaPR07AXU96VeQ7OxA9Mj9xP8pBJ/tzaDltYKlu51ryfb1UwTnZ5ZEalUxOdtmS14s0tJ
	 ixjY/+m5u+DptI0q/6cmVi1z3X94NBKuRcH9GDZ+JRF2HgSNXfm5AEnLDJhjx4UaNKIjc
	 zxbuBp6ZRKFXWp/RKiylbMzVGuS66w4oP4fz63I4gzsLvmUN3TeS2+1olnGFb/dQqNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008465;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+CdnSQYOGYAynrzkG/QTB342cWFFcGggZ0YCcMYw7pY=;
	b=NsqBhQXt/DKuY6XL6qjOSYQn59nro/4FroadSTiu7bYicBOF1zYe1DkqqmHPLPTWETmo
	 w6J/uiz2GQ7f6wzNTKqZXuH1w32Qsxl7t9bp9um4ZIJYVuRocFlVCQo5LGSAHtHuBH6e6
	 b7aA8SEee3Ik9Us6I7mwdRFxL3sjWgnPwza8BU9DruLk0vAbIYwUeTlNOceep7N3NDnJ3
	 A4wVq22oeB49Mr83acsKNZr29j8LUqRG/pPQdjMqUK2GHgdUlKexmhifr8O5b6OqCI0hM
	 ACDlIfNtXN6ihv/v/bWI2kPfTw93hB9wf62ECGzrFeLGsIKKEF2fMIMMpchU24dhI/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T8HuUKEk;
	arc=none smtp.remote-ip=91.218.175.2
Received: from mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB716606A325
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB716606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=T8HuUKEk
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FYVvf+389IS8ZL6LsNXMb88YYC2tzhligrXA3E/+ZL0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793008462; v=1; x=1793613262;
 b=T8HuUKEk9FzvU94JUU8uap2ICqIdV22wqC2IuByVBc2/vjNmmcnjnBFfbtVHMsRNGF0U9nYB
 ELs19emSE9ONB1pS8YQlaOERa3jplD1yuwTm4DvVrmaZOYBURryNX+2R/eCRTreSz59wZtETyAI
 v59R/Iv8h4Qm1CdxdDvAK33U=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9e2f4d0ab2390074;
	Mon, 26 Oct 2026 09:54:22 +0000
X-Mizu-Trace-ID: 9e2f4d0ab2390074
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	witu@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1] net/mlx5e: kTLS, Fix missing error unwind when enabling RX offload
Date: Mon, 26 Oct 2026 18:53:46 +0900
Message-ID: <20261026095346.1212609-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Since commit abed42f9cd80 ("net/mlx5e: Conditionally create async
ICOSQ"), the async ICOSQ is only created when an XDP program is attached
or priv->ktls_rx_was_enabled is set. When TLS RX offload is enabled for
the first time, mlx5e_ktls_set_feature_rx() sets the flag and reopens
the channels so that they get the queue, but it ignores the return value
of mlx5e_safe_reopen_channels().

If the reopen fails, mlx5e_safe_switch_params() keeps the old channels,
which have no async ICOSQ, while NETIF_F_HW_TLS_RX is still reported as
enabled. The next offloaded RX connection then dereferences the NULL
c->async_icosq in post_rx_param_wqes(). Enabling the feature again does
not help, as the flag is already set and the reopen is skipped.

Propagate the error, clear the flag and destroy the accel TCP flow
tables again, so that the feature stays disabled and the next attempt
retries the reopen.

Fixes: abed42f9cd80 ("net/mlx5e: Conditionally create async ICOSQ")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
Found by code inspection while backporting commit abed42f9cd80 to a
downstream kernel. I do not have a crypto-enabled ConnectX NIC, so the
failure has not been reproduced and the fix is only compile-tested.

The crash itself is the one described in the changelog of abed42f9cd80
("async ICOSQ allocation is not triggered, causing a NULL pointer
crash"). This patch only covers the case where the reopen that should
create the queue fails. ktls.c is also the only caller that ignores the
return value of mlx5e_safe_reopen_channels(); the callers in health.c
and reporter_tx.c check it.

 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index 337201f128958..3cc1213c2f682 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -139,7 +139,11 @@ int mlx5e_ktls_set_feature_rx(struct net_device *netdev, bool enable)
 		err = mlx5e_accel_fs_tcp_create(priv->fs);
 		if (!err && !priv->ktls_rx_was_enabled) {
 			priv->ktls_rx_was_enabled = true;
-			mlx5e_safe_reopen_channels(priv);
+			err = mlx5e_safe_reopen_channels(priv);
+			if (err) {
+				priv->ktls_rx_was_enabled = false;
+				mlx5e_accel_fs_tcp_destroy(priv->fs);
+			}
 		}
 	} else {
 		mlx5e_accel_fs_tcp_destroy(priv->fs);
-- 
2.43.0

