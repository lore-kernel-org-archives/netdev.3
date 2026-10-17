Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1E326951
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198446; cv=none; b=VVtUUB5hkAgDh5Gdb+fTemarsw8QeoMN0piQdYVMJqy5KQzs3c1x+F8ojpR2Metjl/yEkX20VP/D15rCtTrJwGnMLqAcxPAhlGSWCIG3sMN0xLvlkPWQ2oZRJnkKTWTkcfFrbnoBhhPsEJOIoYUqaZXRl+P3pTm1XNLf2hCFpqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198446; c=relaxed/simple;
	bh=iptxo1dpce8yozCw+G2LByQPOGKOPLntMtE2IYYXJw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mTG/3Jc+Yo7Gs/5+q4lvH0lxfUU2RzYEhuSpE4D/cTpf3YyTh7bQfNRThzSDtdDg3MN+NpYdEfqp5pgAbFjEtlDlisEw4Q0tS0GmCwXrrW1lA+QD8Al77EJn085AmggfAgnEJb6EEBQQp+8u3NmKC8TsDJnwBUfOv0yxef8aG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUGXZpvj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUGXZpvj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e95bd1c14cso3248365ad.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792198444; x=1792803244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaI1EgkzwRp5eluxbgVbe1/He564x4H9VjRFr/LCzsY=;
        b=YUGXZpvjBODAUIuhaiRDiKVTU033nnVQ7ZicxYn7Se2FrQtwTCAWu0XS102RDQTeYN
         dBUjGsn3eD/eamZ5SMjVU7/V+CCBavQ+r8SxTY9mNtNWuEtNmMSuAgiBNSIpKu3uGdqM
         Ik5BLCD6hla6S0Fq7hSWBht8xAtDk+mv3D3miRsXAVGqvEuJ5WcT29UZQfRrWma9Z2OI
         kSB9kWT5a60Fzi82cvo4EnPvb9WmDgLyMYUBoEsuRhHZclZgU7ty2k6hhwCg8hdQOwmy
         Os5FckaKCaFOqSJy26GjfMtQuM3wXNKke+1Odfv9nKLALiQLN1wW+AEq9hCjLfUoRV9b
         Mnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792198444; x=1792803244;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gaI1EgkzwRp5eluxbgVbe1/He564x4H9VjRFr/LCzsY=;
        b=MBXkWWOqNndLGZ22pZD9+iGE+NWRSep0Gdng8DVV/YhAx8VlqPabp7XwVLRRLnfWjP
         TnQBF3q86Llb/IPNd3zeW5pTmbdclXzj2T9EBsY7vgHbb/V078PM34iOhbHWpQtii1Tg
         QfIJnS9gzBDce+vtqA/ZZk8Lf/7SSpuNFwkOQGWzh+QTGFGPnw7YhV9OZHVjVzmehjYL
         3xisIit78vPEiIy6quFmQDnhsh1CE6e4PLyittk+2XCxEctWQI2mtYGcZLMHpNy4wpH+
         O1ObthVDtKp/jMe5hp7w5PgBds7o7057yKK9XN7X/pW4o++XXGGC7VwefA5eopmk3c2I
         fnPw==
X-Forwarded-Encrypted: i=1; AKwUvBxNYF/7egA9EJcCxUF5SimCth/C8hrtUSSnr3+6CLJU/0rMR+MFcSRE0XIt+sANERTzK3pzPHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcvOvXO04E1rfNb59iRrupXmrAdjY3QDEVCKVEE5Mlf6GyfSL8
	xw85bSBEAq5yjk5TXvdfUOeGxvAQzK56qMzUAtzKMJ+WFiB0cb9HBaDJ
X-Gm-Gg: AYBFou0xArj3NiB+H6D2biSIeaINnR3Mknzvfcgd/zsXsMGhWLdLEf9CY7md4IXoff6
	tZLIgBKUgZd8fZhOXBwQAnDUv8CufeisEeb2xFMDnrEb4iyj4QG4DwVifxkOOqX8TlqxG47wkM8
	QUZQuFIOgiYpKbe0PRu5aej1zOl2agP0qe9Gzp7mDEDyiQxzpwhuvT/REKYgqB5kYqTnnzIN1GJ
	HFqDGbgobfBhydgiU644t1tJ/BaIS9UW+CilNxyb3QdnITHNkW9FCAfBo2apl00D9YmPgFjM+HH
	m/0bPjj5zBq2OWr6FSy677SJ3gnco4W9lN3TPwIAqAI2LLLyDJjZCjznxpO4ZjK0IZOsJTKAsq6
	96Y2dJ96oX6wHADUm6QJgJlVs+7YuxgYDy7h84+GhkoOlPvLpJkuLQwzei1H5cPKWFM7TYKt2Vt
	3T4c5Gk159y2mXwjHVNOoP0DSl1pHQiPZUk/zDK7RLj5dKD4IcgAXnNxYf7N5S/iaKoBT1p3GB/
	s/Blh7lznS6yGo=
X-Received: by 2002:a17:902:e550:b0:2e5:a355:56d8 with SMTP id d9443c01a7336-2e9a6c0e2e3mr14728525ad.42.1792198444428;
        Fri, 16 Oct 2026 17:54:04 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d6esm17075975ad.14.2026.10.16.17.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 17:54:03 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] net/mlx5e: Update netdev features only after a successful ringparam set
Date: Fri, 16 Oct 2026 17:54:01 -0700
Message-ID: <20261017005401.1582755-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

mlx5 couples HW-GRO with tcp-data-split. If a user sets rx-gro-hw on ->
tcp-data-split on -> rx-gro-hw off, the driver will leave HW-GRO on.
mlx5e_ethtool_set_tcp_data_split() calls netdev_update_features() when
tcp-data-split goes from enabled to disabled in case HW-GRO needs to be
released. mlx5e_fix_features() reads the new HDS config from
dev->cfg_pending, so HW-GRO is released before all ring parameters are
validated.

If the subsequent call to mlx5e_ethtool_set_ringparam() fails, the
ethtool core discards the pending change and reports tcp-data-split
enabled. The device is no longer splitting, and subsequent ring changes
are blocked.

Move the call to netdev_update_features() after
mlx5e_ethtool_set_ringparam() exits successfully.

The issue was discovered by manual code inspection during review of
a change that stops mlx5 users from disabling tcp-data-split. It was
reproduced on a ConnectX-7 with ethtool alone.

Steps to reproduce:
ethtool -K eth0 rx-gro-hw on
ethtool -G eth0 tcp-data-split on
ethtool -K eth0 rx-gro-hw off # HW-GRO kept on for tcp-data-split

ethtool -G eth0 tcp-data-split off rx 1 # de-sync driver & kernel state
 netlink error: mlx5_core: rx (1) < min (16)
 netlink error: Invalid argument

ethtool -G eth0 rx 1024 # valid ring changes are now blocked
 netlink error: mlx5_core: TCP-data-split is not supported when GRO HW is disabled
 netlink error: Invalid argument

This is not a terminal state, users can recover by setting rx-gro-hw on.
With the fix, the failing ringparam set leaves rx-gro-hw on and later
ring changes succeed.

Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
Reported-by: Björn Töpel <bjorn@kernel.org>
Closes: https://lore.kernel.org/87se2grw3d.fsf@all.your.base.are.belong.to.us/
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 3ed59ced0407..f38e033ab8fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -403,11 +403,6 @@ static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
 		return false;
 	}
 
-	/* Might need to disable HW-GRO if it was kept on due to hds. */
-	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
-	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
-		netdev_update_features(priv->netdev);
-
 	return true;
 }
 
@@ -468,13 +463,23 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 			       struct netlink_ext_ack *extack)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
+	int err;
 
 	if (!mlx5e_ethtool_set_tcp_data_split(priv,
 					      kernel_param->tcp_data_split,
 					      extack))
 		return -EINVAL;
 
-	return mlx5e_ethtool_set_ringparam(priv, param, extack);
+	err = mlx5e_ethtool_set_ringparam(priv, param, extack);
+	if (err)
+		return err;
+
+	/* Might need to disable HW-GRO if it was kept on due to hds. */
+	if (kernel_param->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
+		netdev_update_features(priv->netdev);
+
+	return 0;
 }
 
 void mlx5e_ethtool_get_channels(struct mlx5e_priv *priv,
-- 
2.52.0

