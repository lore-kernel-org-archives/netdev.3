Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E53DA5B6;
	Wed, 18 Mar 2026 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842819; cv=none; b=ST1+Iq1NkY77/mjQDkqWaE/JwVpk8ecK+p0vpUkFvmA9DJa6air9WwaL/ut8pd/Fe8FvguqdYg/N310ZA4GIxWFldLcWB3vFmAwdYfnIuXooIhsl3Un7uJ6mfrgqUbfDY8eoe2DqsiBcBrPcL+IS1uT39uFaW4d6wQ5/ySi5pxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842819; c=relaxed/simple;
	bh=DtMZga5n78vgzl97HZQMh0VX5Sf4maDy/j/FpciqImI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0iPPQwJmFLPC4385RsykJ/7c8kT3GrEjHhm1GVMEMj8Bfg8+nTpHLBHwNLzWGusYgk7ViC+qqtopGswYwamHq1O4nx3gfK3THKJwjGLwFiqww+rQN1ppJBTnUSaQrksR5Awm58fao4QoExC8mj0LE+KMgm9D6qOk44fKCif9uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=E/eXgY7Z; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="E/eXgY7Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CDZ1x6uk3cX7ikuybSPnahjbUbj3LWWbgoH1EL3EOnw=; b=E/eXgY7ZPQr0V7BMykQ9/791pr
	vWig9lMSWJf/8dj4GJU7hNUIpYm+4NeifXJlR/H6qFvKUw1Bd7bXa9gtO7SLQbCVI/zbpBnUXeaJa
	5um0tUvy3Ew2R/y3f7ELe0+sBqkQWZWVJnPLP7htlgGMa8H1q02EeiSdv9ASh2jUfjceGD2evsZxI
	rZjDEUER5F81wvs0agQ5pZtzxCcWdeVv+WS0zoL9pN0UI5gTpOa9sqZX0GVGc8YkYGBvUG4Z10Q8I
	PV4hG25JI9EstaAh/C4Bp4+361iQrkChOQPYbOxotGRGz14L3rnIHHrg+TPaY9RiPbFoDEqygjb43
	xlpbM4NQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w2rXy-000BqL-28;
	Wed, 18 Mar 2026 15:06:54 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w2rXV-000B1s-2h;
	Wed, 18 Mar 2026 15:06:25 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 5/7] phy: ti: gmii-sel: add support for J722S SoC family
Date: Wed, 18 Mar 2026 15:05:27 +0100
Message-ID: <9349c02ab54bc046ae701d9c646bf226a33d8af4.1773751309.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773751309.git.nora.schiffer@ew.tq-group.com>
References: <cover.1773751309.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27944/Wed Mar 18 07:24:13 2026)

The J722S gmii-sel is mostly identical to the AM64's, but additionally
supports SGMII.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 6213c2b6005a5..4e242b1892334 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -251,6 +251,13 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
 	.regfields = phy_gmii_sel_fields_am654,
 };
 
+static const
+struct phy_gmii_sel_soc_data phy_gmii_sel_soc_j722s = {
+	.use_of_data = true,
+	.regfields = phy_gmii_sel_fields_am654,
+	.extra_modes = BIT(PHY_INTERFACE_MODE_SGMII),
+};
+
 static const
 struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 	.use_of_data = true,
@@ -307,6 +314,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
 		.compatible	= "ti,am654-phy-gmii-sel",
 		.data		= &phy_gmii_sel_soc_am654,
 	},
+	{
+		.compatible	= "ti,j722s-phy-gmii-sel",
+		.data		= &phy_gmii_sel_soc_j722s,
+	},
 	{
 		.compatible	= "ti,j7200-cpsw5g-phy-gmii-sel",
 		.data		= &phy_gmii_sel_cpsw5g_soc_j7200,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

