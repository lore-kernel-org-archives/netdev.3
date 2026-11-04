Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816484;
	b=dTYy5sjhCWIiDQ19zn5SRPKnQ1UgfRvYLDsVg+d1u4Gv+BpzNby+jjz5IF8mQhfenSRK
	 tCx2NSs7fqR6ca6T9UE4F2nvJS+G3ul0EWHVdO74THXSu0C6WH5U6QZkmrre3eLqFta/I
	 QRRQbsai6ZkPqLled5Ga9l+egV7kjhOiJzamUkCT6/wloK9zCpln0RL768LM2IZDEz5pJ
	 /KVrOFOs/5wevWo2/gNFviGg+TPZPjqelN2Ov5SDT/iKAAldx1vXvCIxc5JwT27+DnYk6
	 mg1fX04mZq/vCnqgTtiQW47tDEQN7wSwoNxZQucOLhBS5aLKA+f4r10nMf/mIzDUp7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kS8FsxW+/obnUJdGTs0yg1R4GTkAEyCFRJDeSYb2Rwc=;
	b=jAR9EN6Q51spCF11eoUIT0SrI4YGP8fu3RXHqnQIIwZLbRA5RZntC2xEuLjkY1y0mGZq
	 vkRlrfgj8PcoeP+Jwp3KefMpuLRlFoWRcNaL6RNBhQDf639MoXtoRAoMdfaIQSXYecN0L
	 OL+2VmjJpXlVM12LhNKcwaUIyPHCPpMsaoS2iNxfmdIK2VFI/ImN6x4taiGghzVNrJevu
	 rsLM8Dn0Q6if5Qd6JoKUZD/vNtPLxVduTYWsyCZEyb6pHK/OfhJWP9yXwesOMhXUH9I0p
	 90xpI+KjdvU3BY9Lwe8fOkxWRTfNu6b5SrRBbvcx0Rer/9t0mVUXdoNhSi3xC/UrlHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MaRJVZjH;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB060A2600
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42DB060A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MaRJVZjH
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e10a70540so648796f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816482; x=1794421282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kS8FsxW+/obnUJdGTs0yg1R4GTkAEyCFRJDeSYb2Rwc=;
        b=MaRJVZjHoGszbKDJC8SqmXpVaKUXgwGDHZNfnnz+umrkQSI07I2biPhuPRC1OxUbxw
         cOBw84HZIgTo5EPSsSINCBq2dGPskloOeDHU1ZEOSvq7QIcfAlqTJgErFSxqoWP/HuLq
         4RBEBw+df40WPYpG8gti9C2+yIH1SO7hm2qkmVguzyuO/plf/sfa3czoImmmnwLenwPl
         N2oaT0zYoR4kMpLUSYlDemDNJCOa8klIiQr7rZLE48DQh1H2+OtCRZI23Rfqx05TQ2UG
         ELIbyiZk6P4TyuQqP47aS5LMOM+7/d3nRV9N3D2ThyJPOwZpZVf+uzumYoZpK/XwdVYr
         tyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816482; x=1794421282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kS8FsxW+/obnUJdGTs0yg1R4GTkAEyCFRJDeSYb2Rwc=;
        b=vlWrSe/cX+91bdndQvC4a6bTu4302+6/63U8q/KOUzRHQLbp3HjubsbtncEgz93wAF
         KY5MpsfSHOhBKZGlubN+qEA3x6exXAIWIgqcFsXSVCtFx4lVy8gIMBmLaBytmpj7ZGaM
         /BX9ueosUMRAAiIwTW70g6pKIyeCqpfhWVqyhTNuWzpbwyaR0elO3D/be6gftZ85umzU
         XY1LMHt6j4TGT+iO6cRT3YoI4B3fjIL3aWCmPUFS2TPxt7WJQ5px2DKzE1NZCeD/vMuh
         /b91sNxW45fwPJCcF43fWY1/kOh0OtQh8JdJbxbsGfDELwB9Z+zw36wFnsoq41TkTnn1
         jFvw==
X-Forwarded-Encrypted: i=1; AKwUvBzuSH51itEly8iiwIdH/qRkgJv5JLHb8PsUiDpo57T8RcXgLBAFuniRyDuTFF6esI6d9STdzy4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RYpXcEDnIDXD81/csAelxkHYDL9N7ApXmwlp4cHarP6/zUYf9
	lBlyzr5O/AeODyva+gEjp0A/BXusqcOVdcbs3naXwO6ebav4SwWlssYg
X-Gm-Gg: AYBFou0To88+rUTe5SIZjpnHp2KBCAmMg6Wvz/J8iJTq8jTF/cPCO5wkwf1pWV4GIMR
	+pyWoMRkG516kEDZXGVPuYeWBRpbr+MYsM7OQGfDiZxgW8Xv2eq+NRQLrzVeoOEhoyzS+tsym/w
	nJ3Ks51yQb0pG3RkDHA5PXwc0FcvIkieNGD+plBCxNsichMsfDzqJPmjUvQrBe1eME22onYTaHc
	XjZ+Dpd2c0VAy2EX/XzKLFzxqkoTAfpttcGi6XeBJKdkmDbGpWwRx42xSjoGNkc9nkNIClIk41p
	mhezsWcUAcb0YWsO/Re/vT7etkkpvgeh6bwCR70aJbqYfhYIfCj1HBWftyIgEoXCv54Xujp9Osf
	m5+wuZSX2cTJI+E7uiC4yWFo06HNMAJ4ggdU7h7IKNdAWKQBog7Md5CStLNUvNKA203MA68dkl6
	JI39W0O85MNNdn+9lVzujCQlBKXDVG8ZugnNLUqtlMuX/It8+zLT0hi9phwbNBRizS/VFUKHIGm
	0d5Sm4c08ky8EmBuLxGrwJxCSTp32U5R9alld04+R6f0PkH8e9YwOYVgUeTj/ErF/K3UnIGpGeu
	hj/jF0x/Noso+F2duE6JDg75llql3RKW2HWPgtr9/Dv47hhnr3MPY0+q5WQJV+CrqIsUBnVmkLR
	KBXamliuxVWGGzZUZMR0sEdCk5ixiQH/A0MjGVQ==
X-Received: by 2002:a5d:6208:0:b0:48d:ecba:3cf8 with SMTP id ffacd0b85a97d-48e6e4f8bc8mr29009463f8f.43.1793816481575;
        Wed, 04 Nov 2026 10:21:21 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:21 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
Subject: [PATCH net-next v4 10/14] net: dsa: rzn1-a5psw: Get switch info via OF data
Date: Wed,  4 Nov 2026 18:20:58 +0000
Message-ID: <20261104182105.1102555-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The driver previously assumed a fixed 5-port layout and derived the CPU
port and number of PCS instances from this. Newer Renesas variants use
different port counts. Although the CPU port remains the last port, the
fixed port/PCS topology hard coded in the driver no longer matches all
hardware.

Introduce an a5psw_of_data struct holding the per SoC switch info, and
use this match data in place of the previously embedded constants. This
makes the port loops, PCS allocation, management-port setup, and other
topology dependent code reflect the switch layout selected by the
compatible string.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- Added return value check for of_device_get_match_data

v2->v3:
- Fixed typo in commit message: swicth -> switch

v1->v2:
- Updated commit message
- Renamed A5PSW_MAX_PORTS macro to A5PSW_MAX_NUM_PCS
---
 drivers/net/dsa/rzn1_a5psw.c | 31 ++++++++++++++++++++++---------
 drivers/net/dsa/rzn1_a5psw.h | 20 +++++++++++++++++---
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index bdfa84745eda..ee0187aae2bd 100644
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
@@ -1222,11 +1224,16 @@ static int a5psw_probe(struct platform_device *pdev)
 	a5psw->dev = dev;
 	mutex_init(&a5psw->lk_lock);
 	spin_lock_init(&a5psw->reg_lock);
+
+	a5psw->of_data = of_device_get_match_data(dev);
+	if (!a5psw->of_data)
+		return -ENODEV;
+
 	a5psw->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(a5psw->base))
 		return PTR_ERR(a5psw->base);
 
-	a5psw->bridged_ports = BIT(A5PSW_CPU_PORT);
+	a5psw->bridged_ports = BIT(a5psw->of_data->cpu_port);
 
 	ret = a5psw_pcs_get(a5psw);
 	if (ret)
@@ -1271,7 +1278,7 @@ static int a5psw_probe(struct platform_device *pdev)
 
 	ds = &a5psw->ds;
 	ds->dev = dev;
-	ds->num_ports = A5PSW_PORTS_NUM;
+	ds->num_ports = a5psw->of_data->nports;
 	ds->ops = &a5psw_switch_ops;
 	ds->phylink_mac_ops = &a5psw_phylink_mac_ops;
 	ds->priv = a5psw;
@@ -1313,8 +1320,14 @@ static void a5psw_shutdown(struct platform_device *pdev)
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
2.56.0

