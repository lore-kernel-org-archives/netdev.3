Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A53BFAE0;
	Sun, 18 Oct 2026 04:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296462; cv=none; b=kcKGx+kpbfpXSaXg9+U+hmBRwW+c+cDfSb8SV63zVltFDMhqlnmmlmJEw3vwdqoGf5uxG/wQSaSFXjpZvho4epxKa9XVsvy9A++FDqEmRZRY5et+oVWInah1gwlBnMBxpFy9NpQgUcy/FsBrx9hhdwGvGF4dczWBh80sNcMkII0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296462; c=relaxed/simple;
	bh=OR+cze2TKJpbZjeVwwz6dRX2dQNoD1nR6Z/FXRDUZ30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RtgIRjiDRECzUfTQnvGxtim5EWDzDJo7whfFB2p0uEQvJBGHIxNWPcMFyoD3FnIv1fvw8Vaa/5N/LoVLr7o8gMS7rpPiJjFmEfmRaIHH66CAua4iAMbqKNnbo61iGCbyKnuMp1ACBu4w9fzKaxt9aYVL+G0Zf1WMeDZbUcSU8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Bn/kVlQS; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Bn/kVlQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IK
	hz1b9qvOVME348VjVnSK3yk7/afTvgofmANVMFvYA=; b=Bn/kVlQSx9wz5RffNE
	/50Bytkc/M0q3QCytISoGXZHTQDDaGRkTLjgKsqXVZFrLuz8JUFn+qwIFdeh6oZS
	0peUGJgvqZjpwQtv4Evz3t3x+29YfAd5awwj+YVoaLTUNa3g55VuUjLaGA2Nynj7
	2jmeMHf9+oAMDZaUD0JzWxzWE=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXCgreRdRqJ4XyAQ--.60798S2;
	Sun, 18 Oct 2026 12:06:55 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Elad Raz <eladr@mellanox.com>,
	Scott Feldman <sfeldma@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] mlxsw: pci: drain EQ tasklet during teardown
Date: Sun, 18 Oct 2026 12:06:53 +0800
Message-Id: <20261018040653.534066-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBXCgreRdRqJ4XyAQ--.60798S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw13ur1rGry8Xw1UuFyDJrb_yoW8Gr4Dp3
	yUKFWj9r95ArWUXw1UA398XryrJ3sIqa4jkFWftay3Zr17Aw40vr17tryYyF4UGr42q3Z7
	Kr15Z34fCrZ8A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUUgArUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8B9YkmrURd-IdgAA3-

The EQ interrupt handler only schedules a tasklet. free_irq() prevents
another interrupt handler from running, but it does not drain a tasklet
that was queued before the IRQ was released.

The pending tasklet can access the EQ DMA buffer and queue array after
mlxsw_pci_aqs_fini() releases them. Kill it after freeing the IRQ and
before tearing down the asynchronous queues.

Fixes: eda6500a987a ("mlxsw: Add PCI bus implementation")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index bfe3268dfdc1..ba66142ae333 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -2085,8 +2085,11 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 static void mlxsw_pci_fini(void *bus_priv)
 {
 	struct mlxsw_pci *mlxsw_pci = bus_priv;
+	struct mlxsw_pci_queue *q;
 
 	free_irq(pci_irq_vector(mlxsw_pci->pdev, 0), mlxsw_pci);
+	q = mlxsw_pci_eq_get(mlxsw_pci);
+	tasklet_kill(&q->u.eq.tasklet);
 	mlxsw_pci_aqs_fini(mlxsw_pci);
 	mlxsw_pci_napi_devs_fini(mlxsw_pci);
 	mlxsw_pci_fw_area_fini(mlxsw_pci);
-- 
2.34.1

