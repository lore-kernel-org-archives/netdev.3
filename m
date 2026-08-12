Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A6F401A2E;
	Wed, 12 Aug 2026 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525915; cv=fail; b=i2tMTIAEPhGt/hiTV6cWXb7HMCs+F6wEy221jZ4iY+V13znMnZu6l2CO8N55bZ7jlsnmS7PPdQbs9p35ca1FHjMvlkQJdOzM+MjuCqe4BasQaukA64cloZumpmOOmOGsQpeT3583WVKXKC/qE9Ug3L/T575WdQmvig5qwyXIaj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525915; c=relaxed/simple;
	bh=onpA/DXZI1llSEX0AJqYN2Kew13O3poKZPNtioMaW2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzwO6Sr/IUBf+SudUm/J+OqWA050DmWBcBGtv8BJKfMdUXfv1yQy3Ora8cJiQEQXLL0cc1+mveOMuDgbLewzcJtXr19fK4aROAX06GK+4dckFauiin9QRvyZlE1uNDOhjzinGgKujJLWENfWsdMpT84E2NN7fPKQZiYiFN+6yus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Au3p1e1Q; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Au3p1e1Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVC6Wa67SK+bpCrXcHf56bGlhAKrfe/Yir4FiW8/hVLuNLHe4QylQacnBD0UrbuWJL74fDAj7zM9O7yttwX3nvzKSx4KTlZKfVDII3QMl28+Z1+DGyqLGOmkLZNx13NkneGGuRVR2H/Fg5E3MbinsV3D7YC85/ulIoFkV9p/QNY3QSHYpvuSoC3u8aWe1G30mqBk0QfRWh4JfYieU4F3A9nO2p0dYzMM2gVr6+A/g2z8zNvDckHjiBBsHQ3Pm9gjjUSWF5Akbj+E5itHdMagqC9/wlLZKmUpclFpNpkYk8aULI4UiMaPpM83coiDuzf1h1cQZaTII1+ZDGSAU0eoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaCBEd7HjxyEbgc62KABzvSO1MXnTSfahYmKY+gefUw=;
 b=cr+iujVWfThh/Bg/pH5fcn5lrlPCr0Pnd2/ElHw4FRVzSee/YCFdJL3ghCq+YGHi7mTKE84HFNevIiHuMk6Cng7Nnix/g8P4HJ+u/Xcpx9Xp2SgLO/S7GSyGnp75GAmwcuzGCWnkYABYl78R0o+YwtA8XFIOPZ0iYtGHnf6pTycsczZnGD7GtEvbfPAz+w2HElC7WITTMM7I6jXx6uxKYcoKhBeL0lrP41+q+Vk6FK2HnYehdgxbyibMGDcYEsjWSqbTLmKey68LoaD4suBf4Gq5CYGIEEQk91O4QCQAqPrqI8Raw+Kds1HfN9xSE7aUUiLhowFSAPiN5KlDRpByLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaCBEd7HjxyEbgc62KABzvSO1MXnTSfahYmKY+gefUw=;
 b=Au3p1e1QFMRVIBGt4Jg4+yJIikMhHIss7Sw0QjvfB/x6EfomE5Tx0RzQHnuTnXu7OCcn7z4bCqks0GgQZDUHLa7ZkeoREffe2HlseDQ4BBH4IBMNT8ItNVRj/ApdD5uKx0hI+/xrEIT8U9L4PDjoMZjeVfRc/8V/4LuZYRpHmC9arVIhzpK8TBKxMlmwZrEyLMZ+OGCwUo02oz4nNEJ/417KGmYQuOhp/nX/Khv+8kRanLQHYFF4YRUEgEH2ufw351n5unjNUjX0fY4ANJ7QGbVwf86hfbnMaS0v+VNxRzCdWGmV8TTWfst9/o/etWJuaJnEo4csaASdaZ1a+Zwqhw==
Received: from DUZPR01CA0189.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::7) by AS4PR10MB5600.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4f2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 09:11:46 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::5d) by DUZPR01CA0189.outlook.office365.com
 (2603:10a6:10:4b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 09:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 12 Aug 2026 09:11:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 12 Aug
 2026 11:16:40 +0200
Received: from localhost (10.252.2.245) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 12 Aug
 2026 11:11:44 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Alexandre Torgue" <alexandre.torgue@foss.st.com>, <linusw@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [net-next,PATCH v2 1/5] dt-bindings: net: add phy-supply property for stm32
Date: Wed, 12 Aug 2026 11:11:18 +0200
Message-ID: <20260812091122.566439-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812091122.566439-1-christophe.roullier@foss.st.com>
References: <20260812091122.566439-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0A:EE_|AS4PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ad7eb8-66e5-4329-1171-08def851bb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	jO/HkBal07bjsajRg2y/xwY7bVF3muR8HvEGz0poKljvDx9G1WXP7cbGNgyLyjWzVksfWMPRv2TpAuhLngf1/hWZl0LxdiwuloDp9/iujPnBba2Y5VNi3CbH/Lz8txi6/qw8i1BfDODbSytf1x0q29sOAmJ8SfHBtrXmCl84QFjJ6rg7VtMmrAkeVxxZ0cmn32mWtnItQJg0KG30oeFbZXeqK8f1hBK3MyaQ7HiZEamZ+c39cJuByxr6IebUr46soaZGur+5Jx7ruorzQuat+CXrpjqAt9NtiaNV5qh/PbKrPuAQmIWTjMp7Z1AkjecA5ML1i1xnopNPX9HvO9fLIUmCcPrrPzFJcLonvIe8Z4aaTNM8kzjix64qR3jOLEYBM5wqgIc1McENF3HJS33MCwK5FGX039uRFXlHyJ5HWRiqw3yTdk1W0FZON6iT5vkISwTkZ0Kmu7Ht6LW25FcwD7pM7wuQGHdAy6QgCJvIYpdqlOBg8MXldxqtcFZNP7XS7cSlGKmYLrWgAECgua7M8nhhMJB2T1wKErzDe2gYpF8KNvcPJvOeHNGc6cuT1YKlaYTwRU0U9SSq6Fd4nH1w/+iJ4AqgYjk6vpazk+Lhn+zHWLUVG0h7ELDGkHrWPop0h1sTy4R9M1gimNI8L/dDM4+oVH32horRLtEgABmcs1sEB9iMK1VH0K4GGoWs8XY7s2RR/FM34qKOEqNKqdCfN/8omakxF203RbnIB5c1uOtdErndXFnywcKRa/Loc17C
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oKFGxhUemsVpDTwhS4mGOPjUWexKPUIuzmCyKc9rCLURmnjZ6mtEQI+f4nc56McB4jvo+xQvQpqRl+vjTpu/UboYofzL46Mr1BJRDTgMcOrDe2ZlbxMrLhqysnT2sLne+AntcfX1XX8N4wcuxP/yYrpdgGbLt+P/fqaovsVyVedGhL5Iw61kzctjtkEnvfx1/f5AybgPnpd7I6gLvCQOIXRRChs3QZNmgidi/zsw5fy3fUnnXa3fe4Ra3hfw0BZn7+/Z2KaoUFZxPpaQfIPmjywwLIIZKF9nPvIS9xgcGSWy7QJ7oNXCNumiBjJ4qk21Tmi+IT/+05jN6eR1XUtiNpw6dMGA9JsDYy5UKfE80cMUcpXTZFLtNFNE0B2oKnWk1arDFrM3gAPFw9C45CUNpeCVC1BJhKLiY5S7rokUAiXcvAFSZ8GCYXCRXsvVuwsV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:11:45.0394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ad7eb8-66e5-4329-1171-08def851bb4d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5600

Phandle to a regulator that provides power to the PHY. This
regulator will be managed during the PHY power on/off sequence.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index 987254900d0da..0c7eb1ccadd47 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -99,6 +99,9 @@ properties:
       encompases the glue register, the offset of the control register and
       the mask to set bitfield in control register
 
+  phy-supply:
+    description: PHY regulator
+
   st,ext-phyclk:
     description:
       set this property in RMII mode when you have PHY without crystal 50MHz and want to
-- 
2.43.0

