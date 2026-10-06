Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06AF4AE12C
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327568; cv=none; b=WobEmHjdgf54c7aLbq/QtoESzaExBFk+iaynIhYflnTwvu2Sg4DkQqSFJQ8QC929t5eUXF6mwYpgwl1LaeY5cE7dLBy2G4zSKxdF/hGEU3BCmRNNhrXrCdyG0lh81SaQ1eXh9lYbm9hpVxi0PWjWVYxxTDgzxLsPCBYcVFHdrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327568; c=relaxed/simple;
	bh=QC2yNJfHWu7BrPXXLu0FNWZJA4O8hjP3vsQGnmytBs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvkfhT3pBS09Jt4YKRMZ+GlPG7M2q1t7gfRDCjgNP0chVwN7HfXq1AEM034nfdLDEB6ekaUCLVcxL3gbb8+q4bWztcq7Cdk2Z/arScSQ/AWx7xX2EdwzikX2b6D7cgyj0DYPgcWMjrfbi8a8HoRkro634iGeU/UZNngZ8177DPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlZ3zKWW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlZ3zKWW"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-878b44611ffso914094b3a.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791327567; x=1791932367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=coyVeVoFbF41AA1zZ12MagVbMg/zKq5s1UIi5pu8/4U=;
        b=TlZ3zKWWKTGxXGnUcgKYd6NCguSmp5WQGoZmrlvOqK7mKQvaOSgAYZrYsacxwvUATY
         PJOYlG6QGKI1a53pB9nAvJYBPu4e2cW89pf6fwnqVgwga0PDBLHI/d+fwUKPFGkB7ak5
         N4kWw9BmcrHrhtxdA6mL7uUC+256mOJ2vuvOBHBln3i8Tlgjlk0JQtduUCRocY8brywH
         yJXa5UeOitg1ZuvMWsryXhN9LtU14+oD+LRNeid+tlYXcqZc9FNJyjdTdh5iOQdDHMQd
         OaVflfdNrNMHpvSY/WhvMzehcNqrRI6ZUbBt0QIHPX6SkvKVcTSTQPGZBYgbCpzxqDrn
         85/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327567; x=1791932367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=coyVeVoFbF41AA1zZ12MagVbMg/zKq5s1UIi5pu8/4U=;
        b=wlU9TvsqF/86jq7bDzrqVg8h+zu8PgAE+Fvne8f6xe07kFyBQRRu5U0Onq5nrch7Vj
         Chq2KLo/HBu7hGhYlMb9YIVEKILV3InUcglqNp6dseF7RgE2BFUJSwRot+IBAVkZAR3J
         yDdD7ZX7e9KEE2IghJNj8ALhJ2b2P4scDbudbLygLpPfbQpn10FpE0GG4puwAJ4OevCU
         H7zzj2v+3tMFgxgGTJyUVz7XSsbZjn9b9ZdwXbeRvEWSzd74Fn4Uk1LzFYaGXYXQvdAY
         e3cmlNTAZiYdpJe4eYos7oiR7SqGCH0aD5j95R3L3kJCbOssrMgP5nDY4Yd7wbGMCtgm
         sx0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzdp2v4yk3VPJvtWvRFLDo3sbCynVvYGirwZxcvk9pSrQ327DZ1hNMTUsYRi8nSO7q98LAlwGw=@vger.kernel.org
X-Gm-Message-State: AFuF++m5zCxLakcyExEqoosG1RikalBlS5aVkk2bchq6d9tkLKSS29Ax
	miknBio2uaGWBU3XsJt61EKHrbk0tqis9p925bdo/su25fdH94gpiXPV
X-Gm-Gg: AYBFou0j+7xUHr5YD26gqIgNzNvs0/XxbV1ZD+WMZ/x6X0VOpHkpzz10ZKmnCuyMRSo
	p5kLvS8zP4YHTthgHJcnKdhBvIUoy8ahFSHSvvVbjoHfebmq+eBU+9GyNcEUYvj4F+oyKF67YkN
	NILRBzowP9Kh3/HZt5S95XtfUfYZz/cjLnbi5RiqnDV8sCMGGewnMZ9ShoeTay0Cpxbr96llc8M
	kgxjVFBf442ltvuD/cgQFC6/fD2SYdhXqTJerml/8cZ5IZ/+wKCdry8keHbzhiLLZ4ksOU2YPKY
	Hv2cSfiZhUbJIck7cAKTGmJboLVI2Qi3zbJ35mculjIIyisb3xo1O1YRSyZm/J0tMcFiGzvEP70
	BljMISjbSnXY3K1yoW9t+n3r0sEzKxPATlbMwA0diqjl143zCX+mDw7b4mXC3rF15tDYnSn8EM0
	/Ah7/dQJ6fClcSvXJ/H9Pmlj1dfiq7TFoiS3RTU6EAyzG8evjw2TXMzIdXuFIbl9CF1wSgMl3eX
	rYB
X-Received: by 2002:a05:6a21:2982:b0:3e0:b9ec:7c64 with SMTP id adf61e73a8af0-3e134061feamr359631637.18.1791327567172;
        Tue, 06 Oct 2026 15:59:27 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4e::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd0a5822bd2sm549468a12.3.2026.10.06.15.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:59:26 -0700 (PDT)
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
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net/mlx5e: advertise tcp-data-split support
Date: Tue,  6 Oct 2026 15:59:25 -0700
Message-ID: <20261006225925.568263-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

The ability to set tcp-data-split was introduced in
commit 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
This commit dropped reporting from mlx5e_ethtool_get_ringparam()
without explaining why. commit d347b28c492e ("net/mlx5e: Add hds-thresh
query support via ethtool") added support for ETHTOOL_RING_USE_HDS_THRS,
and modified mlx5e_ethtool_get_ringparam() to report an hds_thresh of 0.

Between these two commits, the hds selftest helper _defer_reset_hds()
would skip the reset because neither hds-thresh or tcp-data-split was
present in the ring config. After the second commit this introduced
a KeyError in the hds.set_hds_enable/disable tests.

mlx5 couples tcp-data-split with rx-gro-hw. Users can currently disable
tcp-data-split then enable HW GRO. The kernel reports tcp-data-split
off, but the HW is presumably splitting.

Add back tcp-data-split reporting in mlx5e_ethtool_get_ringparam(),
and de-feature tcp-data-split disable. Users can either enable it
(if HW GRO is enabled), or leave it under driver control.

This is not a fix since the feature is still functional with
HW GRO enabled.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
Changes in v2:
- Leave kernel_param->tcp_data_split as ETHTOOL_TCP_DATA_SPLIT_UNKNOWN if the
  device does not support HW GRO
- Prevent users from disabling tcp-data-split
- Link to v1: https://lore.kernel.org/all/20260923230521.1267511-1-dimitri.daskalakis1@gmail.com/

hds.py before:
 # Interface: eth0, driver: mlx5_core
 TAP version 13
 1..13
 ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
 ok 2 hds.get_hds_thresh
 # Exception while handling defer / cleanup (callback 1 of 1)!
 ...
 # Defer Exception| KeyError: 'tcp-data-split'
 # Defer Exception|
 not ok 3 hds.set_hds_disable
 # Exception while handling defer / cleanup (callback 1 of 1)!
 ...
 # Defer Exception| KeyError: 'tcp-data-split'
 # Defer Exception|
 not ok 4 hds.set_hds_enable
 ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
 ok 6 hds.set_hds_thresh_zero
 ok 7 hds.set_hds_thresh_max
 ok 8 hds.set_hds_thresh_gt
 ok 9 hds.set_xdp # SKIP tcp-data-split not supported by device
 ok 10 hds.enabled_set_xdp # SKIP tcp-data-split not supported by device
 ok 11 hds.ioctl # SKIP tcp-data-split not supported by device
 ok 12 hds.ioctl_set_xdp # SKIP tcp-data-split not supported by device
 ok 13 hds.ioctl_enabled_set_xdp # SKIP tcp-data-split not supported by device

hds.py after:
 # Interface: eth0, driver: mlx5_core
 TAP version 13
 1..13
 ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
 ok 2 hds.get_hds_thresh
 ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the device
 ok 4 hds.set_hds_enable # SKIP disabling of HDS not supported by the device
 ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
 ok 6 hds.set_hds_thresh_zero
 ok 7 hds.set_hds_thresh_max
 ok 8 hds.set_hds_thresh_gt
 ok 9 hds.set_xdp # SKIP tcp-data-split not supported by device
 ok 10 hds.enabled_set_xdp # SKIP tcp-data-split not supported by device
 ok 11 hds.ioctl # SKIP tcp-data-split not supported by device
 ok 12 hds.ioctl_set_xdp # SKIP tcp-data-split not supported by device
 ok 13 hds.ioctl_enabled_set_xdp # SKIP tcp-data-split not supported by device
 # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:9 error:0
---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 261c466a4d36..f08a968acec4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -378,6 +378,10 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 
 	kernel_param->hds_thresh = 0;
 	kernel_param->hds_thresh_max = 0;
+
+	if (priv->netdev->hw_features & NETIF_F_GRO_HW &&
+	    priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
+		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
 }
 
 static void mlx5e_get_ringparam(struct net_device *dev,
@@ -403,9 +407,14 @@ static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
 		return false;
 	}
 
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TCP-data-split can not be disabled");
+		return false;
+	}
+
 	/* Might need to disable HW-GRO if it was kept on due to hds. */
-	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
-	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
+	if (dev->cfg->hds_config != tcp_data_split)
 		netdev_update_features(priv->netdev);
 
 	return true;
-- 
2.52.0

