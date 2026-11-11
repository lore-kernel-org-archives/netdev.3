Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416761;
	b=u3qxTOTEphYXWcUsqOaz3BV16artYzBqFxMqNwbfFEC6fRehxD7aktg0cL4qqs3AarU4
	 x8osWb9m2JO1Yp1xSoWzyxKUrRF84UAxAEY3LHCHgrQkZ+rlhxT2Dk73/jaAkbfBVKrMa
	 4xKEu8Rags5rkiLYNMgSWrC8WRH4SOtXsoUletkvT/JgOUnkNF6tobwxM6kT/w+TW+OwZ
	 WyryVDCfGz2AYmDrmipPd5Be7JhqGMo/D1bteZ3lYNG2XjCYNcmgeMWW5xXq+gX09hI3r
	 Mr3s0lQ6Ku1PTQSylN15VjDYHsOyVihbJAcVcSvUoIK59dij37joeBstA9MiOuTEjLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1xnopvEZEzie/o3uHTj2YcSIP2GSDNMyJkurGYUsKGE=;
	b=fJ4lkStNKLpFTEXoUfRiauO53o2i9I9zNsCQT8jOEId3fteSaSarVsPYybfVoXzLHuyV
	 RKQ14Z5C2KSjKJdZHGfeYUozf1JtBJXfN3zimaIIku6abrli3oiiD6uch2bht5FeoWCWw
	 KGQRoYSTZTvvnPdQHVvvEYeNNiXI0i89IyCaihqSULsiTnoMq1FEGMSBtUnOVD+DSCJjc
	 34nM0xb3uUJwTxfdWr+W+MEN+GXhSD/U2vyZN/uCVITe39xachdA9msgEj7V13Njal7a8
	 +C+egr3d1ByAp7Epd78Dsy2c47TnduFIO3T21wn7Lm6E6RahDgSPZdbT9RpOpno157Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDlMrfCf;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B03606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02B03606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDlMrfCf
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so2679252a91.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794416760; x=1795021560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1xnopvEZEzie/o3uHTj2YcSIP2GSDNMyJkurGYUsKGE=;
        b=IDlMrfCfRk83+CpCsqlKTjDEpt3pi9YKutfnlitSxFWtfM5phb8ZMlfdCkySAd4WM1
         9qUT7XAObzPLg4/AnRzyX5OAHt2GUn2GisZoema+ye/g6yQfQMOsnYowP4GB2s02TAtO
         QVHYdV5WoLvL6+4knGCNqCAX8jxFUWPZNs1dsvBXCfUJWvr+scsGIopfaBbE/xmlSsVp
         yMVYZyGbfm0x2JZxbo2+pAfW8jCJJCti6cmHLuv/DShxLHrig5SCx9CAXSLmfPH4s6hI
         qHTXRq0ZFzC2AZh3hILFR356W7d+SYLoN8FJpdEjiELqRC+TOoWc/DFSomuGzVUjgAtq
         s6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794416760; x=1795021560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xnopvEZEzie/o3uHTj2YcSIP2GSDNMyJkurGYUsKGE=;
        b=0Of3v+jsCRZrfFh4z3QNB97P3iFltWziCBmpw4E+ATgOIXBent+nH9DpwK3fSi1H5L
         kbjsCbOKKG3yCxsfLC03WNHt5kPEUGcjAVWJz+DPNlv3iveK/OnM2AMu9mn3ZW5OnIdn
         RQ5C/3SHcNCyVLnrevZhf1s1JRdTLN1IVc0R1U28UStJiNVHGvpkOwKruAKud1wmp0ba
         Y7yD38v7qxUr2EWbjySBou+n/dLa6S7hYlWP4ggGC/k14T6mfWQ/nvfuyYEWQ0hZZV1i
         C8bAF4MbDCYQ4R1QiY0+1mO1vRYkq8C1UEVqXT/Njer8DUKPPnAj8jDUeFiCYjbycu67
         t0/w==
X-Forwarded-Encrypted: i=1; AL+hErE2jPcdu57hgH473C/HGKcomVxq8Cs5y70XDa15xIXhY0IsKSbtHnTg8q3u4jHY+v007gkisYQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z93c9Fq4NB50dMU6jdE866YMoIWQbutd1cU2O/otMacOpTi14F+
	6gtP/Zp+RzjW9tJDBzksrwK5mbs89pvss5RSxBkU4F05MNeoHfbk5xTs
X-Gm-Gg: AYBFou2TkR9LqkKppCItZjUgTTqCislkFK5UZcjkheANVkWjr1GeRflKxCN5lwQ/baZ
	Z7PeJvYRpgvcLeadr+HtVlYTdOXe8S3f3PIpVo28EuI4mXD++mFb/s93b9akrdaHn/Mz3/+EgIT
	dEptEdakmfOWsk3e48pl2A9z4wrGsSEpIKRJnOygnipDavt69an3NBy3WVMxJTmxh2apeQH0iQ2
	53LcoDdIzNtdZ61MTASx6tU1yI34i4Nepc0MVc+Qg+CE+AT1TmqCUsuWNmvVeJIrKdaCJp+jUWq
	pnr0zExieWSp0MUXCXcAjBnrVmAKk60/9HQ+ElgeGz18SMl9xy+DGCuY41zGm5cfTbA+DptGPmr
	wwmm3YARx1iM2HEaalbdyDlvO5JVWGKq2hzAWRyZEFVClBb+hVzGm1FITFgibk0zqkU8MV2Y7tp
	3irqYd1UloSUnb4VLyioCFO3cf3b+O73EFigkoYSRyjV90ug9LV72PW3aKgpB12EZcsVuOu7ChM
	qeH+xyFg6EMEDWZTRNFekVWYAfNGHG3pLj2u6U3Cxlm5pzqn2ln3Q5C5no+Cq7FY4VV0UzuMsOW
	aZ2x1XBngL6OfqYrikRUEEgh8QD9ueNejNYUnPyCNvFdPC6gf1K0cswE
X-Received: by 2002:a17:90b:440d:b0:3b0:c7ab:4644 with SMTP id 98e67ed59e1d1-3b182e6ed78mr3037677a91.14.1794416760110;
        Wed, 11 Nov 2026 09:06:00 -0800 (PST)
Received: from localhost ([2a03:2880:7ff:72::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d5eb471sm1864724a12.2.2026.11.11.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:05:59 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Subject: [PATCH net-next v4] net/mlx5e: advertise tcp-data-split support
Date: Wed, 11 Nov 2026 09:05:58 -0800
Message-ID: <20261111170558.1654691-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
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

From: Dimitri Daskalakis <daskald@meta.com>

Since commit 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split
settings"), mlx5 no longer reports tcp-data-split from
mlx5e_ethtool_get_ringparam() and the reply carries only the stored
config. With the default config (auto) the attribute is omitted, so the
device looks like it does not support tcp-data-split, even while HW-GRO
is on and SHAMPO is splitting headers.

On mlx5, header-data split is performed by SHAMPO, which is used only
when HW-GRO is enabled. The driver already keeps HW-GRO on while
tcp-data-split is enabled, but nothing enforces the other direction.
A user can disable tcp-data-split and then enable rx-gro-hw, leaving
the device splitting while the config says it is off.

To make the feature handling consistent, report tcp-data-split as on
when SHAMPO is active and off otherwise. Only allow disabling
tcp-data-split while HW-GRO is off, and keep HW-GRO off in
mlx5e_fix_features() when tcp-data-split is already disabled.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
Changes in v4:
- Nimrod and sashiko pointed out that not reporting DISABLED for
  tcp-data-split makes the feature look unsupported. This conflicted
  with my attempt to block users from setting DISABLED, locally sashiko
  found several scenarios where ring changes would get blocked.
  Instead I took a different approach, if a user sets hw-gro on ->
  tcp-data-split on -> hw-gro off mlx forces hw-gro on. I mirrored this
  in the opposite direction, i.e force hw-gro off if a user sets
  tcp-data-split off -> hw-gro on.
- Clarify extack messages so users know the sequence of commands to run
  to enable/disable tcp-data-split.
- Directly going between tcp-data-split on <-> off is intentionally
  unsupported. Going from off -> on would require forcing HW-GRO on,
  which would require careful validation with features (XDP, XSK) that
  cannot support HW-GRO.
- Link to v3: https://lore.kernel.org/netdev/20261009025137.2631215-1-dimitri.daskalakis1@gmail.com/
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

hds.py with GRO off

 # Interface: eth0, driver: mlx5_core
 TAP version 13
 1..13
 ok 1 hds.get_hds
 ok 2 hds.get_hds_thresh
 ok 3 hds.set_hds_disable
 ok 4 hds.set_hds_enable # SKIP disabling of HDS not supported by the device
 ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
 ok 6 hds.set_hds_thresh_zero
 ok 7 hds.set_hds_thresh_max
 ok 8 hds.set_hds_thresh_gt
 ok 9 hds.set_xdp
 ok 10 hds.enabled_set_xdp # SKIP enabling of HDS not supported by the device
 ok 11 hds.ioctl
 ok 12 hds.ioctl_set_xdp
 ok 13 hds.ioctl_enabled_set_xdp # SKIP enabling of HDS not supported by the device
 # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:4 error:0

hds.py with GRO on

 # Interface: eth0, driver: mlx5_core
 TAP version 13
 1..13
 ok 1 hds.get_hds
 ok 2 hds.get_hds_thresh
 ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the device
 ok 4 hds.set_hds_enable
 ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
 ok 6 hds.set_hds_thresh_zero
 ok 7 hds.set_hds_thresh_max
 ok 8 hds.set_hds_thresh_gt
 # Exception| Traceback (most recent call last):
 ...
 # Exception| CMD: ip link set dev eth0 xdp obj /tmp/ksft-net-drv/net/lib/xdp_dummy.bpf.o sec xdp
 # Exception|   EXIT: 2
 # Exception|   STDERR: RTNETLINK answers: Invalid argument
 # Exception|
 not ok 9 hds.set_xdp
 ok 10 hds.enabled_set_xdp
 ok 11 hds.ioctl
 # Exception| Traceback (most recent call last):
 ...
 # Exception| CMD: ip link set dev eth0 xdp obj /tmp/ksft-net-drv/net/lib/xdp_dummy.bpf.o sec xdp
 # Exception|   EXIT: 2
 # Exception|   STDERR: RTNETLINK answers: Invalid argument
 # Exception|
 not ok 12 hds.ioctl_set_xdp
 ok 13 hds.ioctl_enabled_set_xdp
 # Totals: pass:9 fail:2 xfail:0 xpass:0 skip:2 error:0
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 21 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  7 +++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 1f534051cdfe..8e7c748caf2d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -388,6 +388,13 @@ static void mlx5e_get_ringparam(struct net_device *dev,
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
 	mlx5e_ethtool_get_ringparam(priv, param, kernel_param);
+
+	if (dev->hw_features & NETIF_F_GRO_HW)
+		kernel_param->tcp_data_split =
+			priv->channels.params.packet_merge.type ==
+			MLX5E_PACKET_MERGE_SHAMPO ?
+			ETHTOOL_TCP_DATA_SPLIT_ENABLED :
+			ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 }
 
 static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
@@ -399,7 +406,14 @@ static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
 	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    !(dev->features & NETIF_F_GRO_HW)) {
 		NL_SET_ERR_MSG_MOD(extack,
-				   "TCP-data-split is not supported when GRO HW is disabled");
+				   "TCP-data-split can not be enabled without HW-GRO, set it to 'auto' and enable HW-GRO first");
+		return false;
+	}
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    dev->features & NETIF_F_GRO_HW) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "TCP-data-split can not be disabled while HW-GRO is on, set it to 'auto' and disable HW-GRO first");
 		return false;
 	}
 
@@ -474,9 +488,8 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 	if (err)
 		return err;
 
-	/* Might need to disable HW-GRO if it was kept on due to hds. */
-	if (kernel_param->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
-	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
+	/* Might need to adjust HW-GRO if it was kept on/off due to hds. */
+	if (dev->cfg->hds_config != kernel_param->tcp_data_split)
 		netdev_update_features(priv->netdev);
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c3c2c5720c6f..e2f657b36824 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4627,6 +4627,13 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 		features |= NETIF_F_GRO_HW;
 	}
 
+	/* HW GRO cannot be enabled if header-data split is disabled. */
+	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    features & NETIF_F_GRO_HW) {
+		netdev_warn(netdev, "Disabling HW-GRO, TCP header-data split is disabled\n");
+		features &= ~NETIF_F_GRO_HW;
+	}
+
 	if (mlx5e_is_uplink_rep(priv)) {
 		features = mlx5e_fix_uplink_rep_features(netdev, features);
 		netdev->netns_immutable = true;
-- 
2.52.0

