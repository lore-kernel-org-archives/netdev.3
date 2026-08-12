Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2F3161BF;
	Wed, 12 Aug 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525910; cv=fail; b=nvsU4sHwrMWo4an/ZszAMTDFomzekOmtm7yxsymuBTs6xfsEpKdx4arIT8FX0psfo5C9YRPHjDZBzIflUW3BaULwebFv61XCOBP1XfaRiB98rlqW8lkAsmlg3guV5jcvMeSWqKwrm/y5Q97rV9d4SidDjTc5cyGaoLFr2X3eVtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525910; c=relaxed/simple;
	bh=jl/Ro1XMr/ihEIXqWfjp7L788eZdJmuA2tcJL4bUKeA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X2SPXQCLpDS1YWQvX37GwJiuArVZu2EN4F0B9OivwZ9SvYv9J1iWPUWgN2cgBf+mWgEkDFgizUUYN+mSSoGqwFGUUwcPe2CuSnrodMbhixCLljqswsa4kmRRRTvd4090CbGg8jw0nu561ci+3UHbQlROcGrGzG6x7SzbZUonbHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QUmqaBrZ; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QUmqaBrZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwd0uGtPQsXdS3iQcWdBE8b34uw4bHDVpHO4kuiyXx6LhzhF8GuKGEqW4v5hIKwImJk7qg2S9Nopxtj2UaXMNoRyEdV2mZru+hKdyntI+jo568HH4LtTwCQnRd0VxXJYjNgeIJdsNAxATSkZSdIE/hFuO2em2ghCscRoC7KWR9diaCUVk+G324b+Nz4H7xcF4gegmUq9FUVG6hm6wJGzY+mHUN0ZiQkPP+gJadJWmX98EWnPSo48GSdWDy9+iqiwTlXbwf7pmjxz//TP0RGYIykv48qeNAT6BtAwFRapDR5vuQv5PkWmnN24sj6NDHFGy4vIstB2FPlhs/sf+r/wFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gTroEd2apjAHO6GmbHDjeLW/t7FuVBKyQ+0qt0MmYI=;
 b=aEAmrcbo/JW8NmXitlve18M1Sa8ajrA6rghxYMu26hfRutQ5zZ716rpWTy9HuYnvIz3FxdMK1++xSEZXMk1ElD9VMCRcXevmP6uu0QR6lHlgnKhL7BSSaVmV0PJahh7MN1WeE1jQC7j3PfGEqOuWM/HTnDmVL0e73NfWJdSb81M7Yh44lPDeOIyjeps+Y9Zp+dLFT8h1LL8GRSZqpPWSpGwIrjxjtKbGp5IwUQohxSf6XhEyYbHv5ATrw8aac5T+SaQO7fO6FKu96YWQ5klEAzBtG6NxLjV4GjsO89McUPKM3sW/Iau8kpjSJAVWv0WR2UDNrvZYBXZ+2pheaq2++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gTroEd2apjAHO6GmbHDjeLW/t7FuVBKyQ+0qt0MmYI=;
 b=QUmqaBrZfdO60yLsNwA9vAw1cN07XV6//sr7q5PYucOU3b/fHWLhAWqftcSUcTfpjsks13xvkrIFiRPiATUwTci7rVRiapxX6tNq65N5exB3ezrFcx0J5eD7Yl5KTOjPo9XQv/cd9eVM7hO9vkUq9aEW1/D5miVFbRzcwrsw8u8ie0L+6OwQQkprIlG8wIKrw2Y1EO4ioXFm0I0+fYbrHZtGqenFR9wL5HhMALEf9G2VW7HGW0Eln8ksm15b+b/SOFi3VOQrtKakvDsfklgW6cMCJY8BmmjH58ZFcSuHw4lif8t5T3mrKsgR1F5mF84iSc/IcoOCXOA5xKUO1+OcWw==
Received: from AS4P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::7)
 by BR2PR10MB992333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 09:11:44 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::9a) by AS4P192CA0018.outlook.office365.com
 (2603:10a6:20b:5e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Wed,
 12 Aug 2026 09:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 09:11:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 12 Aug
 2026 11:17:13 +0200
Received: from localhost (10.252.2.245) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 12 Aug
 2026 11:11:43 +0200
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
Subject: [net-next,PATCH v2 0/5] Some improve for STM32MP2X
Date: Wed, 12 Aug 2026 11:11:17 +0200
Message-ID: <20260812091122.566439-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000042:EE_|BR2PR10MB992333:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c4031d-43d0-4195-4a2d-08def851ba9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|7416014|18002099003|10067099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WjbjILSO5h7v6xnPB8dUl80zlbuLplnLnzEhgvdMveV6LkNiqlXgAYJUl7b4xb84B1VBcKRGaS02V8fuvMJ4kf6onbqqwT/O0p0WhyjzaD+nqZt2KTpWSp2Ad1BUNf6vlCRxPwOiaNuxye65aY0OoBCLQVW3Rw9isBzS6JKhJ0kViKAy5NHu8o5Kgbn8JfpI0xjB2ZZhZdz9HR6z4wFPLOAXqzckmySlP2V8Wsz2R7l7o6v6sW54OnXz70DZtzy30aOASHaEOMI1tz8lQ3fj03T/a9T+APXSluRmuRTEm/mKqLHFe/lRsKOn/lM8j0zhzWoxxbEJQfa5VGrZGxrdTIfu/WiS8rHm59I3SwspGPonV/3F7Yx67y9LRL3FuRVnnYrWO5UZRxZrk0Q5bt7gj09LBAFAmX/DhVQYObDAF+xhVaGtwG85N6MGj8aoaXoQidsdTWv/0lrSMtVlFhcjK02owPVOEMFefPO3+42HV1AhAI8vcfd5G/5Hsw4m/h7SA/1JX6n90nJwKBTRzO5f0e6OXOnUjK0Pwz+DzdmFD6Wq2DjeTKDdmOSjSQ41r/h7IdgJMZ0vZmy5jiWgdHNCqBEXNZFhkAyaeeNDlOp7sErBgCqDid6gG5hmPuNkpVwnQidQcqtI3PYuzYJIkfrOYdIunGJcu1xUVF4UXiUd6yXN2Gz2i0D8QqxQahZiWgV6DpdfIu7Q+Y+Sd8zXxzfOqqRw6i/PwzEM6nq56Ru1pOcgSNnHraiJXEvgr0ZZpZT0
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(7416014)(18002099003)(10067099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IxqCgF4dZe0OOiv5Wl0b/o56bCaEWy3RKd30ONjS7KkfeCKGcbU0ct+L/FXswOaAAxVmGnprm/ZWm6j+8+AEQ+GsGRwcZlmYIRXcy36d3MrP6cnJa7Rxs7mwlQVLT7s3HSJnmjeM7dYRmO/A0lPDiMTBv+prNl2402kh5Q1NBd7QXMITKw8wnvVAcEzMZ1/Qk1Y+uvONX9qNkOTJvY3sAi7n0mzq+tG0bZrHUGrxZghONJOmoBaz5CV09gmnAZBuBPihm03O7SehfhADhuUk3wYUgdt39G7sn7apU4Tn38V9cnsj00NCaPbKCky8a5eIaVC4l+0xhnZxgL8ISrHEdtbyrg/fxykKnNxcCcITCbvvgg1Zei/Os6ZzMV+vrxUFqvbPbpCOoSW5hzuJZmbCHqx80gjsWpSh44UUfOGmwDE8bpXxTZTmFSQi7KEWfFxF
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:11:43.9264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c4031d-43d0-4195-4a2d-08def851ba9d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992333

Add PHY Regu for MP23/MP25-DK
Increase deassert value for PHY Reset for MP25-EV1
Add support of phy-supply regulator
Remove commit "net: stmmac: manage error case during stmmac_dvr_probe" 
from my series to push in net-next networking tree

v2: Add reviewed-by from Linus
    Add missing commit to manage phy-supply property 
    (yaml and glue support)


Christophe Roullier (5):
  dt-bindings: net: add phy-supply property for stm32
  net: ethernet: stmmac: stm32: support the phy-supply regulator binding
  arm64: dts: st: add 3v3 regulator to ethernet on stm32mp235f-dk
  arm64: dts: st: add 3v3 regulator to ethernet on stm32mp257f-dk
  arm64: dts: st: increase deassert of PHY reset in stm32mp257f-ev1

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  3 ++
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts     |  1 +
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts     |  1 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 51 ++++++++++++++++++-
 5 files changed, 56 insertions(+), 2 deletions(-)

-- 
2.43.0

