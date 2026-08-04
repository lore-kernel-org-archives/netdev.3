Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011000.outbound.protection.outlook.com [40.107.130.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29D21CA03;
	Tue,  4 Aug 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849673; cv=fail; b=X+4QMRLg+Ozq1yz58HgJk01rhz6d9Xtzory7OTlEUAGbf0m5t/XBvcBntBAx8k0L7CO0jfUhYgvlJjqUedSWEtoPtS8gPHEe/Sy9zEEuTjMAN3QOgCZFo0+/3SBOYZNfXisZwyqyJonaRULuw2vxL2iDKrD5srVdPq02dntF44k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849673; c=relaxed/simple;
	bh=upoOLoV438gjxxBLAx6QM2c4thxAVYdbpUyGQRmOa6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxfpnWM3OUtebeQ9MleORtxES9bLH4M33kRpqgmQLT9JC43IxD1RwqEs+qlWIPfb42pD82rlh3lhruEzskAkdBwvyD+A/K5DX5pmEMlUmFUgf8cooiNidINUgzvPFmt5MogVfd2tvF3ySbjUBtomEdkVX2JHSRRvUd5KCeHVEEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=l6pFCnCz; arc=fail smtp.client-ip=40.107.130.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="l6pFCnCz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyV8/BS6W3+liqR3ZrRQApDWcl4DjP2V7UIV1cDKuIc7F413lTlr1W0pFYOWxWoBDcdRJHO371L6Hb69ghX/mMkk6vHHD2cX1vfC25ArTqeBtXI1X79TEhiirGJqR7TmxTKE70w9QQkwR5YqWGoAvPrcC+5ErQqGe5eqoHJik2xGtRL0IUaG2cJwoTeieZRMwUW8u83JoXfsDRZymiQZliHyONR3qYPxMjz8OJhkijNXdZbNYFjHijSay0WaRHZTZQpjktWFK83locr+/UjlpBR+PaXvR/lblDHTmSxzWtKi1zzfFaKxRWeJDxjg+Hd+l2EinmaPQDSQrxFWhmtW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fztU8m3MhYy8ptCoILS5OqZgo/t0IA++3B4AcS4zWN0=;
 b=sOF19Z6oVaE+A77j2XW7h/GF8utawO7DWui7gwGKteef3eOenFfAo7OWsnfvbUuNwbOVoevHLUWPggvJyz1+BU3RraprVJOVi/QfcZ0loo7mYGUBHMhOShZxakN8f0z8NvYvkRxouK1qtcoZ7bGuiUgA5TAsMoS+u9QxQC1JR3jArJkEuHk1/s7aLkNSQ70UMtccbE6yq2FMiunbcqcCNijBSzHwU7k4pjpKkzXIGWw1Djj71sAqGN8hdc7qovBhvlf3ASBrBjp/tOSkiAWD51dh9hjXUQ7Ed7udcHcCM6fiPKv2tvNG1/PFEcfDWli2W0iPtzTPZbWq9vhjpv9MGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fztU8m3MhYy8ptCoILS5OqZgo/t0IA++3B4AcS4zWN0=;
 b=l6pFCnCzZ9ew3ZB8F19pCZ+SC43rBrpa1xoPQvmroNU+GYQWr/xIVes33pGfF8STKM/ZT3VpuOoAuDE86co6uYaCM6euQCRXLRG+TtK85qxtK8t03qmm6beIHl78M87Yqs5uV0xHShVKAsMxDF5OO+QYnhxjwkfhos74wz5pqiUMY1OK1t+Hlk+S2vC7qz7PFkEHBnxdD4GEbhJjpH24E2wOQbfYIXyR6VzoVzjdHhGVEWrF1oMuXL7X/gIfGuXx2yfDN6F48UmyJi7khg9e5JSPg4p0mBjtteMns3ocDPUe6zUoAxh71v6ebLYvIKFvPDIzjNcWxzz4fvwp2kyEOA==
Received: from AS4P195CA0002.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::6)
 by GV1PR10MB6372.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 13:21:04 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::38) by AS4P195CA0002.outlook.office365.com
 (2603:10a6:20b:5e2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 13:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 13:21:04 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 4 Aug
 2026 15:26:29 +0200
Received: from localhost (10.48.87.235) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 4 Aug
 2026 15:21:03 +0200
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
Subject: [PATCH 1/4] arm64: dts: st: add 3v3 regulator to ethernet on stm32mp235f-dk
Date: Tue, 4 Aug 2026 15:20:49 +0200
Message-ID: <20260804132052.205273-2-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804132052.205273-1-christophe.roullier@foss.st.com>
References: <20260804132052.205273-1-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|GV1PR10MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 0430bee6-01b8-4a24-cc1d-08def22b3c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|1800799024|82310400026|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1XgPMOsK6lsPK8qOVRTQsl1/QNEaZ95UypewDmAx6H6CcmwQ8lpx54hXZBlud7TJu4c2gw1P6UtYSvbDHONNeXAKQVcLqLbk4ltuQTZCQtsCsINWsFMSYjTaDChoYtv31cRqc2jfx0UDAdQ/rUOq0OlUBAugScGmrMTeQ3ET4oEVFAw8Y6+qO97yHNb+s+0TMCsN4kalv6NZGs1wSHAU3xoydCVmVnN7eBTa8/UC8yt4Z4sgu657TwCavC6rvKmwiQMCjhwZnAx5f4MGfwmqglX9vZ63HJhUBuSfbdXGMyT17aQcKafpDw26D+vUGC+vt1FsFaVQaYdQESpSoHsO+d1MuJx3g0HlXscx98i4TcuHGudd86xcC33ZVbA37/5mXjkfDj88KdArtBQ4hcBzCFc7dqrSBXfY0O9dmnbMy0ZKwhLXxpjikuwW5Tf439Mw6neQrK5HbUkKKdG9ps/69wL+HrgZQnSBaqjKgwAkRl/J6hNYJAAaDI+jR6YYGiXgygrmRwdEDY5wJDJfKZqYwbPZsC3VnTwlso2r99vyPgtV4JmLG2MvwcBqeuAVMcqjbMV5w55yY178V27T7Fqq3SKj1Alp/jGc+1GOt4mMjDvbGGAq/IkCLaIpYjubj8X9JasEaJqwpR0vkVv5o9/W30nErPZRhGuRwUdMmq72ilTZn0rnW7cE1rY0LO5ALEfHjwOT7z///esd92d+s1sZ8BnqI3kAtvhylTbUF/3BHN1g+0K+PCmbnflSjI0c2i0j
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8ZQRlIHagLMJWirOX74N7rjiPg/c/UYktNYVIsQEl15pUC3Rd+7//zfmCm9vqdTi3QCGMgNch/YO+PRIkJD+UsBzhW3PhWDArMbVkQlIJGbikwFhu+BRIQOg1rU91vmOz9h5uf8/tM6SblcLEDinnGXrrw04tEn5kVawPyu1GdAeGf7Oc6SeJlnNdiwyf/ImwYWQX2C3OOiro5ZWZZ39Pm59LH8tne7ax2PkSSReZ93go5fqvMzZDViLiPrtCW+5wn03aorUMeWcNJaMN0qQn/E9KEpIcAfZxngy0ZNnkvKUCBiqMMgP3rns+sTizdONUSUzd7e0CoQ3lnwRmzj4iPAZlr6IS+sYz0h6xobBCD/5mYUJxuOO916eL/Z8mrR/Iroc+03eNjPqbjhnO9euuMCKqow9AIF1HnghF1q6DdNQNMIPfuI35WyiSNVCYlAk
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:21:04.0771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0430bee6-01b8-4a24-cc1d-08def22b3c41
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6372

The Ethernet PHY is supplied by 3v3 PMIC regulator, add it to Ethernet
node.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index dd4efbe5a46e..fb49cd2da2c6 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -137,6 +137,7 @@ &ethernet1 {
 	pinctrl-names = "default", "sleep";
 	phy-handle = <&phy1_eth1>;
 	phy-mode = "rgmii-id";
+	phy-supply = <&scmi_v3v3>;
 	status = "okay";
 
 	mdio {
-- 
2.43.0

