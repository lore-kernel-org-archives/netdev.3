Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D23A453A
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426561; cv=none; b=Iai0AbWGL3cQ4/FtlbbrFqkKEuiLYujQ0EVa/rrcEyqCFHTVyQuXVDxYhDfO+BJ5HR9L6z8DtjMNjiXwGAF3Z+4x6bKj1gem3kcnUi1y4xz2lwU0mrZo3vLlzuhNY4eVBtRenj9yyJS5jYssQ9u39Aw+kXtdwcB3UkLsmLVyVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426561; c=relaxed/simple;
	bh=ZFJ2jKibxTRAQQcLArsg9vw4dvVYpeIPiEEcHcwoUBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi1sahuHyKFT6OLSQlDOymA59iKFZb/HVsHmAcYB9yNWtXO2Fo+VL0gKIAYQSFgBXEqdt+6G75ISuKetJ12zaWyiPlNcaRuloJo/462E968bgi57kx2VpBWb+cm7zKdkTEY3H8qT6V/AfGDyv23kZRbUd69Iu/Fe+uR8G7dQIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX0FJfbd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX0FJfbd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db80fcdf8bso19266695ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426559; x=1792031359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6416T0r2C8uo23gUqa11GtkyI4w0JCXupvvSe9G6koA=;
        b=TX0FJfbdDmBiCN3MjkKgyGek/Nmyg0eft4V3TeUu/HhXrpSI0M1aFHAqxJQcbkYFQS
         fFVMhW9R+IxNWMjtBTfN6EOTNRQAQGqdYjolLUHEs2x6SEaxmuUF7Fze1nIiozD1MB6U
         XEL7BkVQOnsFFn0dil6cXq4LECbZzPerAWiQhesQvM5MtfvFk1YistkB4kWgBIaa/X8D
         7GbczYnjn93jZ308+rMPJ8W03WgopANJOQsFys2Adiv0iewzk4E73EAx16ha9mDN97CW
         RtbpYkHnmc2D95+mHpVTndkx9ZrKf68rf8J2DYG/MBPB7pWXIog6oeYZWbM+A4e0Na3E
         WOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426559; x=1792031359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6416T0r2C8uo23gUqa11GtkyI4w0JCXupvvSe9G6koA=;
        b=Q8MZqzJQCRCNEKJbHAoyVjoVsI+LTTDuIO2tzU8p4vl5F5kNXS6oR/dR1+TYMUxX4M
         8xdPmn/y9Tr9N19hPUuHax7238a5evJ+BhfqeKD+g9TeXFZ7A+8voBwiQO0D+EdOcjuZ
         eKOm8gvaTDyhHcHLcNIxRy4NIoV5LEw4jf60SxHFT16YqSUfKTuwCnybboX97DrKtTuP
         GxCAcqKs1UJZaxL9nxzTzmLO9bDEJZsCojo7az62zn36+xBT7bDF5zRUsg9HJINdaYlY
         0whE6dGTRMsOR6F0bzM84MnYiGndZJjUM87ntECyIi0Rp4sbfIKn0S2c75+K1XkEnnV+
         nGgg==
X-Gm-Message-State: AFq9FYIimU11LnGHVxSY7W/dskLw1/v6qrws0y0ZTW17fyEJo7Lh0x/B
	/EnDTJHFkKUCznwvDI6dkfFCt1f7eUHeqmJYy5k/pkHSh71s/b44UInyO9hliEAh
X-Gm-Gg: AYBFou2117buxV+indmFbQEIrA4jRqj7RlWFx6mbKPNOD9/claPEV0sULmmwyYPKNUh
	HvxD7EgE/mn/aW94N0R12bztXLzkr2VPwE4rIiyFeMxgF0TXMk1rB6DmeuwY+XRbA5EhcPimVL/
	I19HTCE2NFV7iwTlROCthqY63hSz8h1e7xYiUOO0fc7aAvzywL+n3xaofmfljTgLKU/wqSF0oWO
	PVnzc/fvN1apVaLfrr1FJN6fz9/TZE+BZa1YHN5CqzX/DmB9VqGqK5dikKoCvHMO1EqbooCzghp
	CWkJKlYmCUxmzZN895PTFAkYHoTB8oKnxeWW6USZMWNuTtTZlGpUovyzs4CzE9FEVbY3/9oFiSW
	V12hFaBsd9r6KGjWVG2wdjhZW1N/lh4LdSOcP+AlZlq1ig/cRLL90+GjYAevIv0F3ekWvMKT+vd
	F/peY9Goigkyrhztg6jWXkpgv41cpeBMU/TFFSa2LBhjWB6ARa9N/gBc2o3DEFPWpHujt2DlXaY
	9xARE+pQ4786keUwP9+7N+EZA==
X-Received: by 2002:a17:903:388f:b0:2df:69e3:7395 with SMTP id d9443c01a7336-2e60036c465mr33848495ad.18.1791426559405;
        Wed, 07 Oct 2026 19:29:19 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:29:18 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Parvathi Pudi <parvathi@couthit.com>,
	Roger Quadros <rogerq@kernel.org>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 09/10] net: ti: icssm-prueth: Move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:51 +0800
Message-ID: <20261008022656.3592191-10-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008022656.3592191-1-mmyangfl@gmail.com>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

icssm_prueth_netdev_init() calls of_phy_get_and_connect() before
ndev->netdev_ops is assigned. phy_attach_direct() ->
phy_link_topo_add_phy() reads dev->netdev_ops through
netdev_need_ops_lock() since the commit in question, so probing crashes
with a NULL pointer dereference when CONFIG_NET_SHAPER is enabled.

Assign netdev_ops before the PHY attach, as was done for emac in commit
7c9f391ec89c ("net: emac: move setting of netops to fix crash").

Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index b7e94244355a..b42c98e861e0 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -1563,6 +1563,8 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 	}
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
 
+	ndev->netdev_ops = &emac_netdev_ops;
+
 	/* connect PHY */
 	emac->phydev = of_phy_get_and_connect(ndev, eth_node,
 					      icssm_emac_adjust_link);
@@ -1590,7 +1592,6 @@ static int icssm_prueth_netdev_init(struct prueth *prueth,
 	}
 
 	ndev->dev.of_node = eth_node;
-	ndev->netdev_ops = &emac_netdev_ops;
 
 	netif_napi_add(ndev, &emac->napi, icssm_emac_napi_poll);
 
-- 
2.53.0

