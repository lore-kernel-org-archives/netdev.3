Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D92DB7BE
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514300; cv=none; b=bTjALbqGnE+tsXaATQrbqTUBDOuzvJFz9oM1gB1WttMuJbIAtFnf6t/TeGpYydENO/MwqFDNdubb+TMoa8B5o3D59gVeTAdnnL6c2kdKTkkvOkXsjxR9rKadgBgw4NEcE0J+VuL8ky4Z7ZqI8ZlgP4t+XRWjs0HAvno0khJL/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514300; c=relaxed/simple;
	bh=6vbWOQf/L4UZhzzAKEI/kSey8QHneh6kMPrrM4gTi4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EevGnAZqTZEbRDeyxHTHLoqWiASfYvYGJeInD7nqwlNthn03OF/KUD2fIrheLjxtJcQrBCxCQdmnMOdf1A4eRTwEfo1i4HJ8VYQvLUL1UPSnGWw8OVKlAZZr0DP4SPLw4GAjnEfpIxQrgw+5sEIfMbhlZKh/ZS1fQhmZds3TGzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byoz2GgJ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byoz2GgJ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3a865731ee4so3240126a91.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514298; x=1792119098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GmI96dl1PZMpoLyoj8GisHl1hYMLINmAceHNZSk2qG4=;
        b=byoz2GgJiDMIAKMpJkLu44C+dg+VheeVAqvDCbQ2hR21CbDxLxp3FWSDWcRb22f9x/
         TyKkZlxV6wf/0DgNf7trNQeIyH5yHLQ8yrp0zggJbJodnvCMrqcuVaWlHOZg9hqGYNLx
         Bj2iG2kfdcrJy4NkOu79lIqG7x8SoK5gCyz9OSZLrgLHwr7L42yYmgyAJLgctQU7M7aQ
         XnC0+l+LpM4wG8MIIMysrflFaHwPu+lRrsj04mpRQJh3j2+EFsPk6ds+bY4o5ojVdavN
         GTxOG+vn8DL3qhZDVynoWfYFN2b99md8lzQ+0IcBPpibqZp4Vqzt8MusSJ81nPHC7Igk
         vnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514298; x=1792119098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GmI96dl1PZMpoLyoj8GisHl1hYMLINmAceHNZSk2qG4=;
        b=sRL9zmxJJTWFI6jqrZuS8o7iaxovSCk11aQWrWQckhhoxAtqLVsIWaf3JuBDFyyaEW
         Ux4pm32+GTTMwavpEyUNuD+zLKalxUotWkXmffuoeF7ACamuzs3HJ6NMGDVVAWfYZGqq
         IWr7jElCU3k743eV6/rawNEALZIdjN3fM+XqwbpHWFJ7fyRRizlWTbkP4CRHA/BHAzzL
         uK14OwWaZefoyT91Fjm74Qtvb1N0JXiYcb8F1DR0YSF4mfUeNgNa76j2b6ZfZut7WdGM
         IRdzhAhpQQDSLJX9jrcP39KVTmphyf7B3clCAY8f8F4jZpCEJKMhuMLK78QkwP+Knm8r
         0+3g==
X-Forwarded-Encrypted: i=1; AKwUvBwBu+HlWT3/eBJbWns2ohZpgC8I/xiY2MbqYL2Y+rATRHCNdVdGW9HeNWBzWbU21xEz9JaruB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtzC2n+k9XORG/+QvkN/tZEXdBPiXEaMqNlAeUBAxuSfjbRdkq
	00VZpLmBCJdmIAfZqSnB5EDEwazhqqJaitE7W5m5RKGwCDiYeTmrrLBR
X-Gm-Gg: AYBFou2NBF4NsWPqA5JQJ6rsB0DMSCz/vn3jpYLbgfwRIxA4A21MJlBNiXE1ziDTDO2
	e80crzdEgNJh9+Lbg7XizvP0quxnlGnYhL5SGom/olXhtX86rnbu0R+cXsALSYEf8PYhOhwiPNz
	d+P0LYxcaOByUuWDanY9ImajUgyL63FU2zWj17U9YnNYQJrqG7Qv/6Asu5hX6g+4GOrqmS+pFbk
	NnjQm4HeZEJR7ABWqm++Zg3MjYz1hqNwl0y5PKqPINx1ejCYW3oGJZEjDWfVdBxj5oWMwD9mZ/X
	Rkb6uLU5qdnZY1YLH91tXaTYMkc3LNGt8sa0fRGeKSoXVLzrkgXOsB4rmw3gHkfFISGWEg4KvVI
	+pvH3r7+ivpJty8duzP1pve4rukiZb1oYN0oPvKVBMaK8HeUpgUTvYZuTav2W0TL69s3j3crKy0
	qOdR8dzGDf8NCu0PdcSfK9kDBcxWE4Q8dWn4li8ZmlSVK2azbUVxTSFF4yiDdG+5ASdrbG0fyXY
	4fa
X-Received: by 2002:a17:90a:e7ce:b0:3ab:9cb:b5a4 with SMTP id 98e67ed59e1d1-3ab3ac7eecemr732524a91.40.1791514298310;
        Thu, 08 Oct 2026 19:51:38 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:55::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm1543746a91.11.2026.10.08.19.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:51:37 -0700 (PDT)
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
Subject: [PATCH net-next v3] net/mlx5e: advertise tcp-data-split support
Date: Thu,  8 Oct 2026 19:51:37 -0700
Message-ID: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
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

Additionally, move the call to netdev_update_features() out of
mlx5e_ethtool_set_tcp_data_split(). If mlx5e_ethtool_set_ringparam()
fails, this can cause the driver/kernel feature to de-sync.

This is not a fix since HDS/tcp-data-split is still functional with HW
GRO enabled.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
Changes in v3:
- Drop redundant hw_features check in mlx5e_ethtool_get_ringparam(). Packet
  merge type can only be MLX5E_PACKET_MERGE_SHAMPO when HW GRO is active.
- Address Bjorn's feedback, and drop premature netdev_update_features() call
  in mlx5e_ethtool_set_tcp_data_split()
- Link to v2: https://lore.kernel.org/all/20261006225925.568263-1-dimitri.daskalakis1@gmail.com/
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
 # Exception while handling defer / cleanup (callback 1 of 1)! ...
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
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 261c466a4d36..c30d751cac2f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -378,6 +378,9 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 
 	kernel_param->hds_thresh = 0;
 	kernel_param->hds_thresh_max = 0;
+
+	if (priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
+		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
 }
 
 static void mlx5e_get_ringparam(struct net_device *dev,
@@ -403,10 +406,11 @@ static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
 		return false;
 	}
 
-	/* Might need to disable HW-GRO if it was kept on due to hds. */
-	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
-	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
-		netdev_update_features(priv->netdev);
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TCP-data-split can not be disabled");
+		return false;
+	}
 
 	return true;
 }
@@ -468,13 +472,22 @@ static int mlx5e_set_ringparam(struct net_device *dev,
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
+	/* Disable HW-GRO if it was only kept on for HDS. */
+	if (dev->cfg->hds_config != kernel_param->tcp_data_split)
+		netdev_update_features(priv->netdev);
+
+	return 0;
 }
 
 void mlx5e_ethtool_get_channels(struct mlx5e_priv *priv,
-- 
2.52.0

