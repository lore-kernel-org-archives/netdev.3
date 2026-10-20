Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514591;
	b=JtiMkNdoCparh82QGB3mQnXY/vWSJ/y8xWHRqyZTn+8KaOBoNw9oojwfJqDg2e8/ImNi
	 409I+YH0i9IPQmTFrd1wU4M4BtbirNwC6rZ7v5jzXCX+Y38FS0nvAKr3yZu20Ys/VBot7
	 1K3n3tF9QZdlq4po2yPT3ZpM1D8W7SsZYq8Af9m6sME/wRV/HG6FfMXVOtOBLN2b18SgK
	 s7GItRegVAAskp0x3UuWr6QTgZmIC0Ztg5vbGMe+8t0mFh8nmwRzO/v7sxNp7kp3Dl3lU
	 5ueOP5f3szfR5jnXByHfDgtrFkppfhZ//Frsh/Y9/P8Vpcz/W3ouGYIPlVXBYxBOdRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CdlYPARhuT5EgLufL/ZQ6dU/20tseBOVd7fjLCxWlSo=;
	b=gfNNz/aNjrC5QUNFjczXrBhBdQ9AmQOeT61F3rI7BM/XEuUODoRjUbQ7Ku4vxizMigcL
	 I4lpOhVkviB8Xwf/KVeeEnJ9IhGb29lAeGtxANPE61TR4BH5PRjqvjdDrHoNyxTv6Wq9p
	 Ykazgrr6jVd2Rt8cIP6w5k2SHBj59Z8Mmx/eCMg15S5MUxGchgjg8Cwxm7nv3FTq7Cspr
	 2NABsl4TR1KyGpOgK3zTi9TYBiqHTKMBtCJY6STtYwx+yfTjTHboQ3GlyEP8Zqo6ML8m9
	 qAzdUwZMXfpQ4vEk/FVIxtPqtKPb/muwkJaVV302PC4FhF73EMmWyNnmv9xlYfD0TzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p10U2UEo;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D014606A32D
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D014606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p10U2UEo
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a01933b584so24691645e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792514589; x=1793119389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CdlYPARhuT5EgLufL/ZQ6dU/20tseBOVd7fjLCxWlSo=;
        b=p10U2UEopDR0Q/Yj8jDVPbCso9MIg9ixUZiZzxfdCSAisf/I/blQW1TgxbbPL0VOLq
         R47u8hZFr5snKKUmwksv1uvElX2vsoAik6jLR7tNX4qWTm2rdPCadETL+3ufuFnxbegj
         yR1FRzFy9sluZ7gA3+va6d5yxbXdBI6KZzNjBJd/VX2fq5JBcX3UpoxT8lwSJ9zjrm9Y
         L/7FR4TnzkWqTYuT2jP8fQXlxU3cXhfOYJBWds/snZB/WfjMjc3NxEFbzOHzFYuu+7u4
         kutmn7XgWl/H8tDTNAu0m7FEkhfi8jNE+xaYIRUJvMXpojOwP2iaTkBS8BabWkM3/3sk
         2MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514589; x=1793119389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CdlYPARhuT5EgLufL/ZQ6dU/20tseBOVd7fjLCxWlSo=;
        b=1IUHi3LWZBx0yc89WnDq1iOIBI5UecC02epmxSEa6izqs/iM3zePqkNINhh7qVjnl7
         jSA5drZz7rWA24Jf4DWdprpKwNULyVCLlP6VONMQSQPt+xv/kh3wl8EQfNwXvdRLVqrq
         RJuyFldx/eU+7X4IYd/Izng1BcBVu7QqDXauqHx2fhLAf/0dSaMrHKjnP0RdOB4rEone
         gRv/YBax8sLLof3LVMNTsZUp+azJvLjLimgT8H3kbhVzNXNzi180Nu0AZSzPRmNdRXSG
         m80SH7uy12uj0BuIgtMEjTr939SwzSrwwgyheTjWtASzTfPzMYthjEhjoMgzHkYY+RVH
         kP2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzDbS+PEO1BdcSAZMbTsz2QsSg+58Pxfx+rWkna6+1qZv59R4+50bTV/+1q1up9Lq9Ghr5aphc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUQ0/l0tKtk9EjcNrT3OngU7X2QU9U6p1/6YlpFRE/BazxUGYp
	Bf+9Is8a1lCfEYKIXj9+0tOLqrBjhgMyeWTlDnpiIsIxwU7EZj4ee5BD
X-Gm-Gg: AYBFou2lVzf3s5rjISlRwrB5BiRJB9q0laClKOxlBFVh4ywnziRhu8//t88aO75gf6m
	18uVQCU7FGKsiWcc1hMRgggpfwpUN3IJbeVbKlIl74s5UOadOsOe9/Z5mG4iXvMyPr7wuygLztd
	qzgIJe4qOIJSJJh4+3csC1ZXg7hcboLseMGT1HUIeCSY8XIUoWwQm6XLEaliIeuo9KyCbqWCL6F
	BBLw6dIrxuJvQDaLbV3O50koEW6OvhqONchO46GIi0sTjW3WnhUAgQ2YD9GtLZ9Nkm9Tpju7rFc
	bN/gAEk+RRco8ShxGOmrX2T8tbM3SS7Zv9xyJzxhmteL/PzgFSvOSqcJ6hxAzf7j7VeMd32WL9e
	AKVDcctYkv0bV/uLzA+I0KNrA/bSXt6bjf39oZFehtozxmRZr1EqJMt+G4essJ5EfLq2JtXA5+o
	pJiTqRYMF2ErwNmKM5nbh8QKbPoci0RX65F/ij3T7JCKgoSB1y5f/dM/3IX9CGfX277IgLPIOg8
	xSFItVCZOk9IjZCXEVMN95rSuD8PqKtMgQCWY6v6M4/PGUNZeKz1ZSZrMpbS85+wxWE620Jtx4m
	KT8SLmR2e9c/Gx7MBCZdkYAsnNcATGXEh+SPblqhmKUBUtLtcFieitmpgj72fOPizTJ7m9HB
X-Received: by 2002:a05:600c:46cf:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4a1f8cb7ecemr44109325e9.24.1792514588519;
        Tue, 20 Oct 2026 09:43:08 -0700 (PDT)
Received: from p15v.lan ([217.169.3.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fb864dacsm8742505e9.12.2026.10.20.09.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:43:08 -0700 (PDT)
From: Peter Morrow <pdmorrow@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	regressions@lists.linux.dev,
	Peter Morrow <pdmorrow@gmail.com>
Subject: [PATCH net] net/mlx4: always create the eth and ib auxiliary devices
Date: Tue, 20 Oct 2026 17:42:39 +0100
Message-ID: <20261020164239.3808903-1-pdmorrow@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Since commit 7d22b1cb9d84 ("mlx4: Connect the infiniband part to the
auxiliary bus"), mlx4_core creates the "ib" auxiliary device only for
an IB port or a device that advertises IBoE. Before it, each mlx4
interface was offered every device and decided in its own add callback.
mlx4_ib_add() accepted Ethernet ports without IBoE and registered them
for raw packet QPs only.

ConnectX-3 VFs on Azure have an Ethernet port and no IBoE, so since
v6.6 they get no RDMA device. DPDK's mlx4 PMD, which needs only raw
packet QPs, then cannot open them:

  net_mlx4: cannot access device, is mlx4_ib loaded?

Restore the old behaviour by creating both auxiliary devices for every
device and letting mlx4_en and mlx4_ib decide in probe, as their add
callbacks did. mlx4_ib_probe() returns -ENODEV when there are no usable
ports, and mlx4_en_probe() binds a device without Ethernet ports but
creates no netdevs, as mlx4_en_add() did.

Tested on 6.12.111 on an Azure VM with two ConnectX-3 VFs: each gets an
eth and an ib auxiliary device, and DPDK attaches both VFs and passes
traffic through them.

Fixes: 7d22b1cb9d84 ("mlx4: Connect the infiniband part to the auxiliary bus")
Closes: https://lore.kernel.org/r/20261014133951.3219055-1-pdmorrow@gmail.com
Suggested-by: Leon Romanovsky <leon@kernel.org>
Assisted-by: LLM
Signed-off-by: Peter Morrow <pdmorrow@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/intf.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 82e467c..31860b4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -43,23 +43,12 @@ static DEFINE_IDA(mlx4_adev_ida);
 
 static bool is_eth_supported(struct mlx4_dev *dev)
 {
-	for (int port = 1; port <= dev->caps.num_ports; port++)
-		if (dev->caps.port_type[port] == MLX4_PORT_TYPE_ETH)
-			return true;
-
-	return false;
+	return true;
 }
 
 static bool is_ib_supported(struct mlx4_dev *dev)
 {
-	for (int port = 1; port <= dev->caps.num_ports; port++)
-		if (dev->caps.port_type[port] == MLX4_PORT_TYPE_IB)
-			return true;
-
-	if (dev->caps.flags & MLX4_DEV_CAP_FLAG_IBOE)
-		return true;
-
-	return false;
+	return true;
 }
 
 static const struct mlx4_adev_device {
-- 
2.47.3

