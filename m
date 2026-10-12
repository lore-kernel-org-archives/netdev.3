Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1957493D42
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817404; cv=none; b=CCpu/tC+05pcEk6haxLQInC3Kf5BukRLEUEq1X9s7AGGMWW19RE3UamcYRl21yCzUezgHugS4xEXv6Srja+JOwrBn3zfhs1K/IeFup7HzqF5yuzVQjnMH6XLITLkVhpLVsEAT0dhxr+s/U8AE7Xg5+KjQ7OdwetoKn7hcXPcHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817404; c=relaxed/simple;
	bh=nELPaAPua+7IB/hVRm1psNXCa3I0bCk6bvAmBHNyxhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7LBD5fIrhBL9CEsw5vak9gFtMa0N7ackfOXFsV0NSjXCqDodGhI8MVl7ibfeqegu6NxdWsoEOKGULUb2azEwGsOXDDD3e9k8Sf7cwt4CJ/KZO+WbcfeDqMa9eKBunWJAuuyGKnRWq5saZH6DhxMR0Tf/GE7srQcB+fkJD8f/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW6HFnSb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW6HFnSb"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so1535039a91.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791817402; x=1792422202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pO408NIMRZiYBttvqoEalFxO06TzS1++JIbffjzp+Ek=;
        b=ZW6HFnSbKJnHprmJRR/iYiQtR2zqPxd9rj7JotXfJO3Gv+igcV8qv5tR0xmRD2eBOi
         8FsMlGuWdMS5YuwkLmOoH5E8O7kYgqLmpwhF/L/JDSj6jFgzrpsKH6AaSWTCv8th+VJC
         iMyBSuYgc08NWVwMIfTecCREh9nNqdU0uRE1AIlmDgB/khVBIl7XFHve/pSoVr0KQOES
         s8+dWAqKfQXf6cU72VVbN0GvADIhYSCb12OtGkjrBFQui91DOU3fwEurkV45DVeZxheT
         5R2E6RT4RdeMJYdswVd8xJ+WB5Jj2AnX3TXltXUCysK+pn48y7xRC/hJULxhTsKiCqhR
         +8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791817402; x=1792422202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pO408NIMRZiYBttvqoEalFxO06TzS1++JIbffjzp+Ek=;
        b=JXPDXf+LmXywvgs8RG8zWZlBjMqPJ+uZfuXjZtKbAqb3yir2ErXS5VXMsxv7OrFkH7
         +FrzkBctAxwUAPgIsQ2R+SVSZV81f2H+ejlRvn9SABkYKMcHZ32UmMQG8xw+0E/ike5T
         Z5cqQ3zloYBkOmgKPVSKVsXs7Bsd2FXsPelW5KF2MfCiPHC8pEh9GX7Lxj3U25xSkjrI
         JCmy85oMdCTU/J71ubUmuJzoteEv/pT+kOdgYd3/7la/fQbUH2iVF5bd7pfk2tPotnTE
         pTXu5BnBQdOv0/T71O8yWC+HUIVjsjjC0lCUQQ99LsgMV0lH7YzuljNCEuxtHKLlNY3L
         5wcA==
X-Forwarded-Encrypted: i=1; AKwUvBxcwYJ2B5s9dbNifYNrL87GiksV4gefB6QBlObVFR4EgGo4qnr0Jvl53fd1/krxadQiewdkqzU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSHZVPw80ypuMFL6eS92h1oSB4x9ODwWW4i/j6dVgvrdvQ+WN9
	A7wRdy7jU+nczVoxGRt58bMHafSWz9YQ3bmlKcKi8VYGgWLjM3J4BD+Q
X-Gm-Gg: AYBFou2MdpLFFDMBBOicuFezzu1ZMQDT4lNZ+sXKdjoVgQ+qa1bJO7UFlCOIUB/WF0i
	dr3V7+AgWT39n1PZHha0VJ9F1qAkD+ueeQ3RKuRInv/ogt3l8rr8oJPkIHH5seuocqPCyR2Yp/x
	LVkgCnncEGTMIAxGow5U8BDWUcVsr4ZA9GNvXJTwPKJWKwW/+8pKqJNN8ITFX27Oj41ineqSXuD
	X7HDSIaJhgXTI2gg9CB+JCJ3Rzen+ipW86dx5FfzP9mtANFk8H+5XRvQSoTRZgIDGYbwYmvtFkH
	azpJjmueWUnPFYJTgob9VoWxjTyoBkiCFlGvtFEpNVkXCFLv1Xe2r9GchWteWNgE6yhUxLFVDpk
	eXmokfOS++Hg5G2yrYxZfIlQDQ1Cl9OKsijH1lpnBVdDTYlYwkYrnwe2tGVKcSmcxZhU5b0xlQI
	lkJTIgB4bEkWSIbUj07BNEplfpMgWCk5kmWAzjMz+sAta6SS4kpjWelMUWr23XRYC3r+koAGpfj
	S0KEKHPTrMads+A4yoN7oxr
X-Received: by 2002:a17:90b:3145:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-3ab3a33db2bmr8277610a91.2.1791817402228;
        Mon, 12 Oct 2026 08:03:22 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab393efd88sm10110088a91.3.2026.10.12.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:03:20 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net/mlx5: Remove redundant memset after kvzalloc
Date: Tue, 13 Oct 2026 00:03:10 +0900
Message-ID: <20261012150311.555104-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvzalloc() returns zeroed memory, so the memset after the allocation in
mlx5e_post_meter_create_mtu_table() and macsec_fs_tx_create() is
redundant.

So remove the memset.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_meter.c | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_meter.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_meter.c
index d03376d7bb31..fcbd464c5539 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_meter.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_meter.c
@@ -310,7 +310,6 @@ mlx5e_post_meter_create_mtu_table(struct mlx5e_priv *priv,
 	}
 
 	/* create miss group */
-	memset(flow_group_in, 0, inlen);
 	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, 1);
 	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, 1);
 	fg = mlx5_create_flow_group(table->ft, flow_group_in);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index efc5167493c1..12af812a1e19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -476,7 +476,6 @@ static int macsec_fs_tx_create(struct mlx5_macsec_fs *macsec_fs)
 	tx_tables->ft_check = flow_table;
 
 	/* Tx check table Default miss group/rule */
-	memset(flow_group_in, 0, inlen);
 	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, flow_table->max_fte - 1);
 	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, flow_table->max_fte - 1);
 	flow_group = mlx5_create_flow_group(tx_tables->ft_check, flow_group_in);

base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
-- 
2.43.0

