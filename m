Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0352F29E
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869430; cv=none; b=r2Tf8M3b8Q8tZGNnQM/QhpUjjNW0rlY8V6IPJGNSDG8/ifURpLBVoIJ4cGfDc8r4D9rluBl5kBAiWBLWy9LqSi/PXyi3ffecEcXQaRxL9GN+2Ukty2MGy1krxG4zkb0LRxJjooaDJ0u60azgTi9Pdg5OLQU8YR1H6FfQiaJ5DBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869430; c=relaxed/simple;
	bh=NU1tcfxsGIRXOwTlOTdT3KASYgMOXkANAP6rLnE6FPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPTHyhOLSPA2WJu1aGsw5rPdjgGqlY2EMgGvOIMrEKbbKCk5IOLANtlSrlvxJVuhdwUj7pB6sBJw/i5DbpU+x+JABvtyu5DILYWvcAopiz+sPUg3WDMQg6ePRxYh34MqSC67zHJUvYj5GRbzQpIBxeYWNqRERNku5/LQWwf9fFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvFD2cw2; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvFD2cw2"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so50723665e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869422; x=1791474222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3w38V8ex0VOw4g4gXJzyI6iZd4Ufe9XP7XfLEOWUUyU=;
        b=mvFD2cw24Ct3o2qOvczJFjAy5KWeswDmqq3Tegn4pjqzBsiewXrWFX4VD3YelU1N8q
         Kq3wxpAEqTu5/xZZOt3r3/PiCSVi8swD6v60qA89BOklyAGdSv81i/iWaPhFv2RsC35k
         XMNHCpRbthUuyVYww4fLmSg2Lbfvnx+6EwStzOJWJZtIsdABtVDaZBsimOGWj0TjxG12
         GQZp6lCTUmAiJwnaeeoF4QuuqaKQu1F39yCHb9C/vi8XAgdgOEgeSENEQX/wU0ViG/tU
         zd8KQP1Dh5sd1WhFSPZwa4b/s9D16ybqxHIPxC0rixi4G817iLLH0iT9lY7pW7rog8aY
         fiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869422; x=1791474222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3w38V8ex0VOw4g4gXJzyI6iZd4Ufe9XP7XfLEOWUUyU=;
        b=JAPiu27JKb9ecLVRSWRXR4EWB74y6WvUQg9NMsvVeMddYJwSD/fIEDUTRfRzcdfcMK
         7iJqk/LcmejWKgNyZ5hLAJsv3rmgJJgPj4aR4yHZ/vBUJ+en136OJptQ+kZlLGW6ymZM
         lavHnmXIMyWkVNR8xaLxCMOHsGxX4iKe2WYfhxP1a64eCGeXHBxnNpQrMli23a2L5Yzv
         XUorQRAK+ZrUaL3hhb7lY6KhvSPFrhZ7I8493+sA1uy5nAwokYcBBCl7x8m6DfVkrz+b
         NSmHrb+/hojOnIDCdIgnoFBYIrR3Y0e0C4SowUvXRC8jKldfJ5J5RCmelkxc9GvLpQyH
         8qSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxxLol4tIghk419VJi0osIJqnTLouku73hl19r56GVrxpd8tygmHwOtdHy13jeO0kgHY3bb/o=@vger.kernel.org
X-Gm-Message-State: AFuF++mSGBGm/rSF0w6dd7IgAJmtTXg9PYz8zvc6eZebi+RlAVLUz39V
	Rh2Rk0B+fc21xbgHs2mT1jEHh/MiLoDhpLrOO2g3HXAN+hHsxlC6PRL1
X-Gm-Gg: AYBFou1FQXKa5gW4FsIBYYvmuHXjRYmy+PDIYsFXrQPgCkwfy+u/X6VPpJqeLlrjfLx
	QKg9VT0Ta/TU6it4BdnowUQoLHRsDsIug38ghC0U8u+Df7sg20YZj7I9N7+MeB73HQdpjThskyj
	4M9bOl2AAvHYKKroKKrUtRM+nHPsilXY3UGdaKnwu5MEOXT3WOZKzPAaBTDd5IaObSF4HActtwh
	t6tDLEB6GLS0O29Tl5mkXqpCDm10Nuaz5BYbu3Yz5FHyNcJi7dFIt9GgMDk8u1Z26YfWyKV+D/Q
	Pcot5BTnhK2kT1N70PDW51FZftrwVgZtaywaUqCrzxd2eh//iI83ptSq6pdcz+9+SUg6Uu8i579
	eJQZhIkRZ1eU3d1/OmajedwQXQblT8mIeKpTgcjidGI5PGOswCArVN848yVzeFnJZD5l2avZfBD
	gBpjLECo4fK+aqVMCtVYC8XN1UZOXI+nNxOqIT5BZV31Ei5vM5BywFLfUI1+6nd75h/wohSDl0S
	aD4rBaISYPzNGtmkerfIBeyHoNqv4BgP3E9GxXPCJcUfWKtyRPJIu04yW7YdBkcZ2IIhf91382n
	yz0gSzQ00N/Kqxs6Xzw=
X-Received: by 2002:a05:600c:34cb:b0:4a0:1fe2:d4c8 with SMTP id 5b1f17b1804b1-4a02754224amr596985e9.5.1790869421951;
        Thu, 01 Oct 2026 08:43:41 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:41 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 08/12] net: dsa: rzn1-a5psw: Get switch info via OF data
Date: Thu,  1 Oct 2026 16:43:21 +0100
Message-ID: <20261001154326.754314-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The driver previously assumed a fixed 5-port layout and derived the CPU
port and number of PCS instances from this. Newer Renesas variants use
different port counts. Although the CPU port remains the last port, the
fixed port/PCS topology hard coded in the driver no longer matches all
hardware.

Introduce an a5psw_of_data struct holding the per SoC swicth info, and
use this match data in place of the previously embedded constants. This
makes the port loops, PCS allocation, management-port setup, and other
topology dependent code reflect the switch layout selected by the
compatible string.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Updated commit message
- Renamed A5PSW_MAX_PORTS macro to A5PSW_MAX_NUM_PCS
---
 drivers/net/dsa/rzn1_a5psw.c | 27 ++++++++++++++++++---------
 drivers/net/dsa/rzn1_a5psw.h | 20 +++++++++++++++++---
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index bdfa84745eda..c8197ef62fd2 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -382,13 +382,14 @@ static void a5psw_port_bridge_leave(struct dsa_switch *ds, int port,
 				    struct dsa_bridge bridge)
 {
 	struct a5psw *a5psw = ds->priv;
+	unsigned int cpu_port = a5psw->of_data->cpu_port;
 
 	a5psw->bridged_ports &= ~BIT(port);
 
 	a5psw_port_set_standalone(a5psw, port, true);
 
 	/* No more ports bridged */
-	if (a5psw->bridged_ports == BIT(A5PSW_CPU_PORT))
+	if (a5psw->bridged_ports == BIT(cpu_port))
 		a5psw->br_dev = NULL;
 }
 
@@ -924,20 +925,21 @@ static void a5psw_vlan_setup(struct a5psw *a5psw, int port)
 static int a5psw_setup(struct dsa_switch *ds)
 {
 	struct a5psw *a5psw = ds->priv;
+	unsigned int cpu_port = a5psw->of_data->cpu_port;
 	int port, vlan, ret;
 	struct dsa_port *dp;
 	u32 reg;
 
-	/* Validate that there is only 1 CPU port with index A5PSW_CPU_PORT */
+	/* Validate that there is only 1 CPU port with index matching cpu_port */
 	dsa_switch_for_each_cpu_port(dp, ds) {
-		if (dp->index != A5PSW_CPU_PORT) {
+		if (dp->index != cpu_port) {
 			dev_err(a5psw->dev, "Invalid CPU port\n");
 			return -EINVAL;
 		}
 	}
 
 	/* Configure management port */
-	reg = A5PSW_CPU_PORT | A5PSW_MGMT_CFG_ENABLE;
+	reg = cpu_port | A5PSW_MGMT_CFG_ENABLE;
 	a5psw_reg_writel(a5psw, A5PSW_MGMT_CFG, reg);
 
 	/* Set pattern 0 to forward all frame to mgmt port */
@@ -1149,7 +1151,7 @@ static void a5psw_pcs_free(struct a5psw *a5psw)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(a5psw->pcs); i++) {
+	for (i = 0; i < a5psw->of_data->npcs; i++) {
 		if (a5psw->pcs[i])
 			miic_destroy(a5psw->pcs[i]);
 	}
@@ -1176,7 +1178,7 @@ static int a5psw_pcs_get(struct a5psw *a5psw)
 			goto free_pcs;
 		}
 
-		if (reg >= ARRAY_SIZE(a5psw->pcs)) {
+		if (reg >= a5psw->of_data->npcs) {
 			ret = -ENODEV;
 			goto free_pcs;
 		}
@@ -1226,7 +1228,8 @@ static int a5psw_probe(struct platform_device *pdev)
 	if (IS_ERR(a5psw->base))
 		return PTR_ERR(a5psw->base);
 
-	a5psw->bridged_ports = BIT(A5PSW_CPU_PORT);
+	a5psw->of_data = of_device_get_match_data(dev);
+	a5psw->bridged_ports = BIT(a5psw->of_data->cpu_port);
 
 	ret = a5psw_pcs_get(a5psw);
 	if (ret)
@@ -1271,7 +1274,7 @@ static int a5psw_probe(struct platform_device *pdev)
 
 	ds = &a5psw->ds;
 	ds->dev = dev;
-	ds->num_ports = A5PSW_PORTS_NUM;
+	ds->num_ports = a5psw->of_data->nports;
 	ds->ops = &a5psw_switch_ops;
 	ds->phylink_mac_ops = &a5psw_phylink_mac_ops;
 	ds->priv = a5psw;
@@ -1313,8 +1316,14 @@ static void a5psw_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static const struct a5psw_of_data rzn1_of_data = {
+	.nports = 5,
+	.npcs = 4,
+	.cpu_port = 4,
+};
+
 static const struct of_device_id a5psw_of_mtable[] = {
-	{ .compatible = "renesas,rzn1-a5psw", },
+	{ .compatible = "renesas,rzn1-a5psw", .data = &rzn1_of_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, a5psw_of_mtable);
diff --git a/drivers/net/dsa/rzn1_a5psw.h b/drivers/net/dsa/rzn1_a5psw.h
index d54acedac194..197ff5916578 100644
--- a/drivers/net/dsa/rzn1_a5psw.h
+++ b/drivers/net/dsa/rzn1_a5psw.h
@@ -195,8 +195,8 @@
 #define A5PSW_aCarrierSenseErrors		0x924
 
 #define A5PSW_VLAN_TAG(prio, id)	(((prio) << 12) | (id))
-#define A5PSW_PORTS_NUM			5
-#define A5PSW_CPU_PORT			(A5PSW_PORTS_NUM - 1)
+/* Maximum number of PCS instances (excludes CPU port) */
+#define A5PSW_MAX_NUM_PCS			4
 #define A5PSW_MDIO_DEF_FREQ		2500000
 #define A5PSW_MDIO_TIMEOUT		100
 #define A5PSW_JUMBO_LEN			(10 * SZ_1K)
@@ -231,12 +231,25 @@ union lk_data {
 	struct fdb_entry entry;
 };
 
+/**
+ * struct a5psw_of_data - OF data structure
+ * @nports: Number of ports in the switch
+ * @npcs: Number of PCS connected to the switch
+ * @cpu_port: CPU port number
+ */
+struct a5psw_of_data {
+	unsigned int nports;
+	unsigned int npcs;
+	unsigned int cpu_port;
+};
+
 /**
  * struct a5psw - switch struct
  * @base: Base address of the switch
  * @hclk: hclk_switch clock
  * @clk: clk_switch clock
  * @dev: Device associated to the switch
+ * @of_data: Pointer to OF data
  * @mii_bus: MDIO bus struct
  * @mdio_freq: MDIO bus frequency requested
  * @pcs: Array of PCS connected to the switch ports (not for the CPU)
@@ -252,8 +265,9 @@ struct a5psw {
 	struct clk *hclk;
 	struct clk *clk;
 	struct device *dev;
+	const struct a5psw_of_data *of_data;
 	struct mii_bus	*mii_bus;
-	struct phylink_pcs *pcs[A5PSW_PORTS_NUM - 1];
+	struct phylink_pcs *pcs[A5PSW_MAX_NUM_PCS];
 	struct dsa_switch ds;
 	struct mutex lk_lock;
 	spinlock_t reg_lock;
-- 
2.55.0

