Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F7421F10
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577885; cv=none; b=Poq3Vj8MCxjrourgJRcF0diCX9sp+9PqjIiVmavdmk81FfuQkYv5JxHfAYTz7gcETp0FDHBycVe/ble+9eRlCBfoo6H8TPw3FZmklI0YnD2aly8PN/AyxqrmpQgUXqJ2gi8aiIS9ObH+HzIbYz589XJ7KFBoaSuM7wniQ1bXppM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577885; c=relaxed/simple;
	bh=79Mdp1AOyEnseQ6YciyHtVOQDkgA3tpWYMzYOqm3TB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y5ieilwwXNyuGhg/19dRyBxfHf+2VRf445J3gduQGew90vPtGglI+YPB/eu9xiR2hgXr8PVfLZ4ybclW+kiDT/f/ZD5x4u+xI8HWhjNSp8+qSjS2xb2TN5rc/agGb/zHLAfTzl8+bgpJq/hcU283fKYpDme495OrPm27MJcQT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R8/MNnUd; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R8/MNnUd"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780577882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlSixzpVPe58sKtClq15cLtWL0cPTKiwPec4PU8Bn4o=;
	b=R8/MNnUdp7U9NmYIomXbeTYl81HJaA8cfrOUNgwObKtfaTD2c5B8Y2OjGRiVP1lccHLQbp
	Wbt+F87UWjO8nbZ2a8bqQUaExGBCBuqnV94hIzrFGoaFWcNWnM7T7YTlwPPZCDLEFjWCg9
	CPb4TqLDTsutvPatFBRBWeQdJw9J+sw=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shayd@nvidia.com,
	parav@nvidia.com,
	moshe@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH v2 1/2] net/mlx5: Simplify cpumask operations in comp_irq_request_sf()
Date: Thu,  4 Jun 2026 20:57:04 +0800
Message-Id: <20260604125705.21241-2-fushuai.wang@linux.dev>
In-Reply-To: <20260604125705.21241-1-fushuai.wang@linux.dev>
References: <20260604125705.21241-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

Combine cpumask_copy() and cpumask_andnot() into a single
cpumask_andnot() since the function can take cpu_online_mask
directly as the source.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 22a637111aa2..d11ec263d53c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -886,8 +886,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 		return -ENOMEM;
 
 	af_desc->is_managed = false;
-	cpumask_copy(&af_desc->mask, cpu_online_mask);
-	cpumask_andnot(&af_desc->mask, &af_desc->mask, &table->used_cpus);
+	cpumask_andnot(&af_desc->mask, cpu_online_mask, &table->used_cpus);
 	irq = mlx5_irq_affinity_request(dev, pool, af_desc);
 	if (IS_ERR(irq)) {
 		kvfree(af_desc);
-- 
2.36.1

