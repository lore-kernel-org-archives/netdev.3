Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791E9476CCB
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204725; cv=none; b=OcV7nJjAvRH3Z037EzHJ9Wiapa2PSPkZSkFz2wGrHNmnt7NaTCOxmJOtFUFHStEkEbZSlLhM2EGfbTWzBIVHpnE95oB4DKRqhVMDHBFm6xKWBNsU/Q5A7F+EBoTJWk8UYJFd2bOcoKj/0LZctyYI5PZk6Trs0h7CYxCbHz+pL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204725; c=relaxed/simple;
	bh=T1ta5ePMk+zQfSwvW2sATCvCAK1KdXn6U04Q4LWpTCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWa/ubKkHKx3aWKXL15wGkbnB37YfHCZjLwI3vlvfJabN5r0udML6zZ1eVUCq94o67B36IHpCb+WCYh3g+iaEyO3AmvkxTL/JN4sQU93ny0VjVOzRtJZSF9mk9Rt2aruxAchkpAPYjF8R9TYEPHuMwxc88mYTtmwmy/MbZ0l7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmb+9pXz; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmb+9pXz"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so7757625ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790204723; x=1790809523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QSdcxCpNx4svg4OY5VX44zy2bI3XKAytqtWifRNIQRw=;
        b=Gmb+9pXz3o0GU3CBfRynm1JV9GyDKFZoRUr6xbfAeC/v9e5pXfJNvRpD7Qj3v+/9Y0
         8SlSAoLfZ+mYddSk4jNdHkRl0Us07oV7duXWnUlsPFp2XfHIMm+t063mFs8JYR5DUDmV
         l4X0+1D1frkeavy0451ubrzziZV93NHNk//EXaErZHqOtLoohYcJ/Ul6h1ux4ihnNKqf
         lbFOqZzGmFkh3v9MtNR517a/wBGGsDG2WTL8iYOLtJ0wtvEYPotqIfzgAW7uvQXSnuGH
         zb0s696VknP0R/jNLhtgoHK4164kvRmiuAicLum3qeUdQvurbbj0cpcRLNeg868m+0Q7
         YjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790204723; x=1790809523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QSdcxCpNx4svg4OY5VX44zy2bI3XKAytqtWifRNIQRw=;
        b=x1ZWlMPD0IHYgIoRuF3xyWaB5SuoZDoyly5Gco+SoaJ8psvcb/cSqw8NK2BeaV85KJ
         SgaLWt7Ex9bmeoxwvI+XdSrMmysoyFwL/cJQyqafokc5wxnnP++hRYJK9yElA2QAL5sv
         nRt8xYPxBsdfsvQtAy5GnbmrVoqiHPM00TWPd7rpfYL46BoaW73mXdNXefn8SO1Y0Zld
         vFKjDh1QnsCpWRdorhphQHLB4sG1eCKnxW+QCqEPDMrVCGFT+Ri0NQP82kF9y+5yqVYK
         P9dQvOUkMoLguJsB9LqUodmzqlPQufDSO9kuh/ehbyjmmk+wnClh63pCnmk9bxwchnUq
         JVSw==
X-Forwarded-Encrypted: i=1; AKwUvBy77zXuLaQjmdFVHGjvp2wnXWyDF0p2drgYtQHheijCd+/k7u/QFbbQwLaIROmOOYUlDt0sCww=@vger.kernel.org
X-Gm-Message-State: AFuF++nVah4lSEN6v2/6HzPrejkFJdZYUf0xuga3U4LNsxLkls5vSPDM
	NqaTP1VBfo5YmgByvjL3PCKAcHRbBbhkFyLysA+zMm7MzF7oKl6NyJgZEeJvog==
X-Gm-Gg: AYBFou0L3Clzt/0wi7GRyMrD8JOvBk9nvPHlz0snlqcL/LG3QTpPJAgngVHymHqNFX1
	T9rdrh6v7zJESuSK1DwTXw06FV6jzb+xetIfcqP9B6jLKcW1NL9FmHjge3U05p+eziSj1bUG4pK
	yAED/GO9Iq+6Jpt7fKd/MwOPe242Vjbn6nNwR3IXG9Z7K4NGy1lYFV/zXHd9Vnsv+p2cEDEh0ks
	GMClE7kbQrmKmt2GzMM79xvj55svuzQKyN+00riaEvXZJUzlr/RgGUi2hlJKxauIqOZd0UcxdOf
	ypB5DOOLL7BX+i7yknTHHbdfSaz+2CIR3ESaFjcvpViZsyPzFhDA/I/773+VtzmjDkPibEqy8hP
	k5X4J3QpeMU4yrEb7LBgL+s3hc2kYwCSCgmokafRren8IYF5K6bqdDGl1VKYzhfGDK/IhsLiSGC
	YLOH/dQbsyP5UgJmzbJsPW/9S6+DF1zhU6H3R7+76slmey7TRp8n1VPNFA+lkcC0i/vj5zSzQOG
	VkE
X-Received: by 2002:a17:902:f791:b0:2dd:ad74:6d17 with SMTP id d9443c01a7336-2df7dc1a1a8mr5160745ad.29.1790204722416;
        Wed, 23 Sep 2026 16:05:22 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:59::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5db494sm16971865ad.56.2026.09.23.16.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:05:22 -0700 (PDT)
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
	netdev@vger.kernel.org
Subject: [PATCH net-next] net/mlx5e: advertise tcp-data-split support
Date: Wed, 23 Sep 2026 16:05:21 -0700
Message-ID: <20260923230521.1267511-1-dimitri.daskalakis1@gmail.com>
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
without explaining why.

commit d347b28c492e ("net/mlx5e: Add hds-thresh query support via ethtool")
added support for ETHTOOL_RING_USE_HDS_THRS, and modified
mlx5e_ethtool_get_ringparam() to report an hds_thresh of 0.

Between these two commits, hds._defer_reset_hds would skip the reset because
neither hds-thresh or tcp-data-split was present in the ring config. After the
second commit this introduced a KeyError in the hds.set_hds_enable/disable
tests.

Re-adding the feature advertisement fixes the self test.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
Before:
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

After:
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
 ...
 # Exception| net.lib.ynl.pyynl.lib.ynl.NlError: Netlink error: mlx5_core: TCP-data-split is not supported when GRO HW is disabled: Invalid argument
 # Exception|
 not ok 10 hds.enabled_set_xdp
 ok 11 hds.ioctl
 ok 12 hds.ioctl_set_xdp
 ...
 # Exception| net.lib.ynl.pyynl.lib.ynl.NlError: Netlink error: mlx5_core: TCP-data-split is not supported when GRO HW is disabled: Invalid argument
 # Exception|
 not ok 13 hds.ioctl_enabled_set_xdp
 # Totals: pass:9 fail:2 xfail:0 xpass:0 skip:2 error:0

---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 261c466a4d36..62060a6fa185 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -378,6 +378,11 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 
 	kernel_param->hds_thresh = 0;
 	kernel_param->hds_thresh_max = 0;
+
+	kernel_param->tcp_data_split =
+		(priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) ?
+		ETHTOOL_TCP_DATA_SPLIT_ENABLED :
+		ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 }
 
 static void mlx5e_get_ringparam(struct net_device *dev,
-- 
2.52.0

