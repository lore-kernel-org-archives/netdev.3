Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F35748A8DE
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832386; cv=none; b=iFJPctG/i59wuycxVpQ9mHKuxFVkSOO56d+Rc7SDiDCoEOgs9kSHByNXWjtZ9mQnb9+MHP3UFmydVcgvgTHxvT0dazKw5O2ezOBoMdhlA/IqZVVTnuaLm8Qcwk25GScqMAZUuR+lBJub2IbyKEfux8YrdOhlRa6qHQldYrgT/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832386; c=relaxed/simple;
	bh=4nPOOxQQdsH8s+vHIqe3mHFKEUuR7Q7OhqCIYNGa1DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoKFwPy5EjgZWZ5Mi8ZlqoVwpRwXI+E77oxkkVK9uppiObW6UowLy8ZsS2gOruL6PR95X1wjJav2UGSCMV59GrdX/XPDf0ZAKemP+3tyeNYAXRx4OLrbs1K5JfoZeNovBwS77t6EiNwNfG68Ir7uEY5myqnmflj1dwK9Ai0lFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKMrNrjE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKMrNrjE"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38101f85591so777464a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832376; x=1785437176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QiNsXajlQRLTmIS3RzF6Ciae3Ovg515LecRLWPQA57w=;
        b=NKMrNrjEwXAFWbuy2PddaHTBcfdK/dVgCS7gJHlI68vW0sNh+mEwvX+PLrt50C/56+
         XTPZmnY87ObbFBOXdGf6f13lLHVyoIuFljuzgzvJD2+fdRsCmUJ29Z4ZQ1mQbNnWGWW0
         3xeYTp0ZeEWJ4py6WKaDOnwmcD3S5u5WghPQGRzUuJH5jEZajbagajXfJ7EGnvRj4Ypv
         aN4kYZ54UYglFHhKtFzA+t0JAM7t6e84Ja/T+sC4M2TjQ8lIw2JFUS0H4cx5/jVZSghQ
         J5QvL3RSZpdL91GoXPk+6RJeVUuZSvGiMZooW1WKKl3OUK0j9/7Co1WE/aoCD4ZZO1VR
         Y+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832376; x=1785437176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiNsXajlQRLTmIS3RzF6Ciae3Ovg515LecRLWPQA57w=;
        b=otNsw5SIyJX4SvQ/DX32gRGg3Y2Js39UQ9Z4ffrtXUpTJSeap/EdWRNiYLRAeR+JcQ
         wrwuLWWrwuyek6bV42D2CS3J0cV8kCwoZJ4fGTWrv1kDIjGH699arXJ3E2ypQhebhlhK
         tiBJQzRZLo0k+CgJJR+I0zBbfBn6I5Cvjud2RyTbeXgHom3Vm9ipprMjqss7bQeS8Xb/
         ygZBou1lGqCPmN8v49PxiTg/zYuApdPO6mlIcOoyN2m/ZUJF622ZNSPSsFztYb4R1WEF
         MMySnyLy6DylfZr5M9L9IGptuBxxly4KRiwy8CkRCkrYorOPbD70bzivbAIF932Gk4/2
         04Tw==
X-Forwarded-Encrypted: i=1; AHgh+RpYMSs9AoKzHpELU7p7T0LXVxf5qQliK1+uOpEtWrYXSOqJVd9lvcKIUwA9/7+rwiDQVPGCStw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvXsKaGr9MQ/vImY4aXfZSH12+NF7qC79tmnBgAzvjr2uTOcp
	plgftK66ObwTedqNfWKZfiAxhdOXTj6IpNwDr2AqDiocWr1fNNnE41Ml
X-Gm-Gg: AR+sD11oR4s62eBETCUN2fbJ0JkP9SH3jcJsRpp8Q0NpQLHdACWvo2K0LdfnUl6IanX
	PEwvY6l4L2K9yCZ+mInCwRR3z7NBrMoWQUmka3ZwssSMGGl6OXSagvS20Js6yiksBaMpepXtiFd
	glBfMrf4Ze1XesvCZorBuL3cEn3CMNY/8LINRi8/t6ToWy4Kpz04mF8UGqbjvvWkJZ1LoRJ4JQB
	I+eVkvS1eWXow/HbYYhc5uftSzwTTKKOKHBHl6jsJAJTacu8LA2+DfVv364ZRqhlX09z7kgzvGf
	II62/qSqiGhQVYrFaq/1vY3OPaoj8eDWXOao4wmVpgQdOt374dmPsl33JjXKBnH7KdvOCPAt7ff
	QEJktq5UTGq+tQq6pVrI3+vZLSsZCEMyuvJvrIZPR1FtAZvmbZAMjEBFFiQY7Kjv/XsTo+b0x
X-Received: by 2002:a17:90b:4d83:b0:38e:4f42:d0d6 with SMTP id 98e67ed59e1d1-38ec8461966mr2882664a91.12.1784832375589;
        Thu, 23 Jul 2026 11:46:15 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:15 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	Shahed Shaikh <shshaikh@marvell.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: cocci@inria.fr,
	GR-Linux-NIC-Dev@marvell.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 07/36] net: ethernet: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:09 +0900
Message-ID: <20260723184538.3888637-8-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c          | 6 +-----
 drivers/net/ethernet/aquantia/atlantic/aq_macsec.c    | 6 +-----
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 6 +-----
 drivers/net/ethernet/freescale/gianfar.c              | 6 +-----
 drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    | 7 +------
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 6 +-----
 drivers/net/ethernet/renesas/rtsn.c                   | 7 +------
 7 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 5d05020a6d05..ea89619039d8 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2303,11 +2303,7 @@ static int ena_open(struct net_device *netdev)
 		return rc;
 	}
 
-	rc = ena_up(adapter);
-	if (rc)
-		return rc;
-
-	return rc;
+	return ena_up(adapter);
 }
 
 /* ena_close - Disables a network interface
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
index 3ca072360ec7..fd4ee6212234 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
@@ -735,11 +735,7 @@ static int aq_set_rxsc(struct aq_nic_s *nic, const u32 rxsc_idx)
 	sc_record.valid = 1;
 	sc_record.fresh = 1;
 
-	ret = aq_mss_set_ingress_sc_record(hw, &sc_record, hw_sc_idx);
-	if (ret)
-		return ret;
-
-	return ret;
+	return aq_mss_set_ingress_sc_record(hw, &sc_record, hw_sc_idx);
 }
 
 static int aq_mdo_add_rxsc(struct macsec_context *ctx)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 33e7a99d3e49..79d4a77f72bd 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3935,11 +3935,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	if (err)
 		return err;
 
-	err = dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
-	if (err)
-		return err;
-
-	return err;
+	return dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
 }
 
 static void dpaa2_switch_ctrl_if_teardown(struct ethsw_core *ethsw)
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 89215e1ddc2d..cf636fc5aafa 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2877,11 +2877,7 @@ static int gfar_enet_open(struct net_device *dev)
 	if (err)
 		return err;
 
-	err = startup_gfar(dev);
-	if (err)
-		return err;
-
-	return err;
+	return startup_gfar(dev);
 }
 
 /* Stops the kernel queue, and halts the controller */
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
index fff8dc84212d..e96a268067f2 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
@@ -2478,7 +2478,6 @@ static int netxen_parse_md_template(struct netxen_adapter *adapter)
 static int
 netxen_collect_minidump(struct netxen_adapter *adapter)
 {
-	int ret = 0;
 	struct netxen_minidump_template_hdr *hdr;
 	hdr = (struct netxen_minidump_template_hdr *)
 				adapter->mdump.md_template;
@@ -2486,11 +2485,7 @@ netxen_collect_minidump(struct netxen_adapter *adapter)
 	hdr->driver_timestamp = ktime_get_seconds();
 	hdr->driver_info_word2 = adapter->fw_version;
 	hdr->driver_info_word3 = NXRD32(adapter, CRB_DRIVER_VERSION);
-	ret = netxen_parse_md_template(adapter);
-	if (ret)
-		return ret;
-
-	return ret;
+	return netxen_parse_md_template(adapter);
 }
 
 
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index 45ed8705c7ca..47cd9ec665ee 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -1618,11 +1618,7 @@ static int qlcnic_83xx_check_hw_status(struct qlcnic_adapter *p_dev)
 	if (err)
 		return err;
 
-	err = qlcnic_83xx_check_heartbeat(p_dev);
-	if (err)
-		return err;
-
-	return err;
+	return qlcnic_83xx_check_heartbeat(p_dev);
 }
 
 static int qlcnic_83xx_poll_reg(struct qlcnic_adapter *p_dev, u32 addr,
diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
index ee8381b60b8d..f7beeb73eb16 100644
--- a/drivers/net/ethernet/renesas/rtsn.c
+++ b/drivers/net/ethernet/renesas/rtsn.c
@@ -685,7 +685,6 @@ static void rtsn_set_rate(struct rtsn_private *priv)
 static int rtsn_rmac_init(struct rtsn_private *priv)
 {
 	const u8 *mac_addr = priv->ndev->dev_addr;
-	int ret;
 
 	/* Set MAC address */
 	rtsn_write(priv, MRMAC0, (mac_addr[0] << 8) | mac_addr[1]);
@@ -702,11 +701,7 @@ static int rtsn_rmac_init(struct rtsn_private *priv)
 
 	/* Link verification */
 	rtsn_modify(priv, MLVC, MLVC_PLV, MLVC_PLV);
-	ret = rtsn_reg_wait(priv, MLVC, MLVC_PLV, 0);
-	if (ret)
-		return ret;
-
-	return ret;
+	return rtsn_reg_wait(priv, MLVC, MLVC_PLV, 0);
 }
 
 static int rtsn_hw_init(struct rtsn_private *priv)
-- 
2.43.0

