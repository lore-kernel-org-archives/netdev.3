Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011013.outbound.protection.outlook.com [52.101.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635113DDAFD;
	Mon, 10 Aug 2026 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367451; cv=fail; b=skgZ0/zbvUdrVmLNVNOWwMLf46SLkf3FJTMQVx7KfwIxUdqQlIPayzJ/tFm0i49J0OHkPCZWqQ34fzouLngPFfCitTzDmk8w7yNj2uleFI92R97nSSs4YOhmkfZPJSMjSVpSojKTKY8S3EYE6ie+hb5NVzUeXmdujMQck2155fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367451; c=relaxed/simple;
	bh=+DQzmSIpnSrAIBPDOuXJCQxExOYAzC+dp627SvqZTqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsAaihrjs8tUnX7T3D7IMdBTSUCHjVY4csq5GX8VupVzZ8i5g1Uf6L0Fmzr8w+cd/rQkCqxJ8y4QLRbx8pV+BFb0rgowVdjuDuXTOq8dWzdhmth/qkv+yQhXwR49v6NpruibFe4V+am3H8PfPaDtRDqatpAwE85WPT/P+6nzsko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=hIITHZAp; arc=fail smtp.client-ip=52.101.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="hIITHZAp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yj26A0ALBDA/bOQRHaORFHAQxu1q46fPnXxk1zS0mDVC+r0gmSH4rAqX301MDtVWkNR0UAEsDgIZRw3jqe8fI8ctDkkML10RtJkc7E0Vsq2S5mR+KrMH8TGAH2alcs44y6vaO5ZAfWd8DwplExhacRvfL6Jof3mBFF8z/e96saMvv6AfyL+kLWhL72W0OpbvfgV2yP3xOEMVS93UOHqeSaxzW69r25wHTSejUPSDNiQwzDKpxJRXlNBcOQKDFKiU2y5ffoMClZInJ42EvHHES6rBGyiKCWbo0TIjDKmwHPHX/07s7mnE/E1F4q2dOUY5IfT3/fgRPIUGGeSVfQ1gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZvatw1BbaKWTqW0uNDCLB2scIbsuTDvq03v0+9Jprw=;
 b=alr+IPJ9VUmR3jpGiaRvwl9bHJQek3CFIKiRJqUfIhJb7SxVhRNa8VdFs1ivqzgeFmOFJXUqoEfy2x3Q5Uu4tJhLm1DRMMEzDEvMoJ767pFWKrFwAqvp9fto2naw5XD+yd36Pu7UWFciPzJgtRvB5HwYNr0fXrLP0ZOOWr5xPYlRivyJr5DQV7lD1zte38a44NTQO9Z7OHiJZnoPNFsuQ7Nvbbg5XMBpS1VOF9FkhghjzQhGFbtUfYH2EPuj5uV0NKz2smKJZ79CCyMWWwlMyyfIc/4sHR/CJ0cCurupKrkKz/8Ioh3Xj+hq9wC16yK5usPPrN+/U1c269VReJabbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZvatw1BbaKWTqW0uNDCLB2scIbsuTDvq03v0+9Jprw=;
 b=hIITHZAp11E0epOXr4FNVGfLNXNi1nz3xPgRSxR/NeHtlWdcB7JOJcdOM1Icd7wH8DXcmW80uLTu+y85CvDy2O7x0WVkJFrtZUYQvq4kL/3Skm2phVyGxYO8XDjJFoH+vFMlrEymmW1UiTuJY2HkwFasiZqlBmGqbJsClKqTEMO5PJMgHGtzg/tyIk++nE3NnZJJQUTvXB+moyIXS5G4fI+7mxmtJb3xPloDwPggvU2gUBqzmU9Df00Jbg+kk+pJDq+8+zDDPHGThsoJ2jQsaLqKf0oAbimgildNg6rGja9p8Of41do7aZHqgnY0Cuyi4aFu9rNJH1rCBMUs2JdqhQ==
Received: from AS4P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::7)
 by GV1PR10MB8735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:10:45 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::86) by AS4P191CA0017.outlook.office365.com
 (2603:10a6:20b:5d9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 13:10:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 13:10:44 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 15:15:38 +0200
Received: from localhost (10.48.87.235) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 10 Aug
 2026 15:10:43 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, <linusw@kernel.org>,
	<antonio.borneo@foss.st.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: st: increase deassert of PHY reset in stm32mp257f-ev1
Date: Mon, 10 Aug 2026 15:10:32 +0200
Message-ID: <20260810131032.455435-4-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810131032.455435-1-christophe.roullier@foss.st.com>
References: <20260810131032.455435-1-christophe.roullier@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|GV1PR10MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: e227a6d6-eeee-4066-be80-08def6e0c9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|921020|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3P98EwNIxGSPji8jVrgzDUXS58qzU/18xw6zyHjhPyOA6N4WL7uj9HiI63HUdDJz5yRurfLSE+K9lN4AYh8u9y4Bzi8Jjit8wBx2ZIQY4Yj1CG6yw8dU+pSt6n5bKDNGoZ/OZ00JWdU16GmqZh+pWnD0mQz9dULNwiBkDyepowmVB73GM9wOM9qkoYCQyqPANoelyK73BBof/Zlk6dt8cUTsdD2LvG6WE1pyz62Ybr1NClMeqE7ubSYqDmUVhJNAVTfeqRyPS8teBy7p1RB4pYDvuGERK9JWFbKHYIlW9YnPg8mn8s5Bm97BBGzbXxkOwxPZXpJfrz18E9X8iPTOgB46qzcnG2u89/Oq9XO5OqtPfRDB/6LbHF9PrDRNoytydULu/Dm2EHJRpiBAYIDwwoiaq5BckjXmaq5q7KNQmRCBaPg76PA/ZsDzSkbB4KRd4ueid67sFBqaH2LxVQJowruw01zYvOuDGITy4ppz68jwVXYyWu5Wf6gX+cTUcwmZPmEkbP9m8gTYsbjmtJTuiElDRFJd1cktqcXcmA/bPtCGuI0xnWNfViz/FBFXGeqNZ6DWO7W+dsRvxmWQ9w84sEdj1HYkbQrw0j+V8n2kNlFVGS0HaFLPnjdGILDprt4l2g42XCiKguzrrn2eJISe1atsEKO3aK8+FpF0aH0YboG5M9hXeeyZRq/5z/nYf/+sxXKYlwdRw6OKwko3Z96WE8I0dTVTXXzukvnHyfJZ7cOhOFLp1HMw7g3p7p9Bb1yh
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qLxzRgSpS/LWwkq03uvXFUQpeHttCIXL65kQ1lNpJjFj1K/+mIMxoZdnlczrd0qsbsuSXw/5BvcU2JjBFsuNTQ5jvbTwJXQhz99bq6410uQr5dDIxLrcB6uYoBEZmWjBN/SNaLKAjNAkxfxY92wh/msTaqFRe5Dt25UdlyH1YdqxdLG5nochW8ruzCgFwM1dM4qJxa7COId0aSYhzaGyXl3MnHk6EM5ssxbL+zL7DyJLYn7dgmYOQmngZZ/A3uGAFVTepWQG9qmMSj9pbSApcGCW8icFcx9I+BPDnbwRG7W7jsCuaUovm+fBK2oFTuDYebDN0qX1GcUX4vFzIIZ9cEWXahOchDvt+OAp3cZr6ZLqb9lxUPNOhcvPdTOnz1FWbwCOAH3XKdmClrA0PWsJ1jUSvc+0qcLic+2jU4zhjtLarnYFhyeFkZjvH4M0k4Bk
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:10:44.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e227a6d6-eeee-4066-be80-08def6e0c9a1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8735

The RTL8211F has a PHYRSTB pin to reset the chip.
For a complete PHY reset, this pin must be asserted low for
at least 10ms for the internal regulator.
Wait for at least 80ms (for internal circuits setting time) before
accessing the PHY register.
All registers will return to default values after a hardware reset

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index b5db62a0a550..0c7c29f4b71e 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -247,7 +247,7 @@ phy0_eth2: ethernet-phy@1 {
 			compatible = "ethernet-phy-id001c.c916";
 			reg = <1>;
 			reset-assert-us = <10000>;
-			reset-deassert-us = <300>;
+			reset-deassert-us = <80000>;
 			reset-gpios = <&gpiog 6 GPIO_ACTIVE_LOW>;
 		};
 	};
-- 
2.43.0

