Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758AB3ACA6C;
	Tue,  4 Aug 2026 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849673; cv=fail; b=nzYP+6vm0Yf4PWg+sC4959chCm+ccsI7WmD/xC0bk6yjJT7jPzO0eo/ygZiMRwVcsyquXmYqxE3cprqv60FaP9Ako3o3RikPEjE5Din+yvJ8o1X6MZhDhlmib89p1mCE+HzrQt5h3MqSySrCquTMPCnjd+8jFItlwIxniPh6hWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849673; c=relaxed/simple;
	bh=ds50rb9UxnCE2k21BsPFeSqzredInzU3TCXEBGnFTiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+O2iCctWdTTk99m1CL6ecPM4GiNCa/8yfiQotVSQCX8K6/Ai1jJ66iy6fysa0FZSq65/dzXGOrOxqGBLiCoj+hLHszQIhakSbl+93oDRFZby+9tR2ROXxTXEXwHuUWPWOOiWjrPlddVU58uNrc9pjQqEZnlAkL6c6zinjcDcJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NZ/dAvc6; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NZ/dAvc6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqIAzMubZnfQcqmzTpy4ClpBMoaYyLexYP7IcKSt7bYWlafr9ldcQKmxKPTsngZI2YlOakIGwDN8J3e7VgdO2Reg2CHetRewemBhk9lUc8ORVEG/ca0NTDk9oNMQw9NCK1ABavDofaVEMdNiv1XM7wp73+hTGG0NFdnrECk4SXjjFkRIqd+iKrQ4kt98EaWL1v2dAKY+YR/wbMuLgtOVmSL43utiynuPNcgxsul94I4sIl4JGyM/j/ebk6I67uasc6/DtOhR8CmX2dEV6JdLjKitOGnNJZ4NTpde14ygAtRTX5x365Ve4QZXZrIl7BxZVvu4QXJom/hMzTZdPti+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOc8NmxaNzaKILe4KxGlLMWutI8IraeTGg1SinGN1Y4=;
 b=DC9UX9UpXJFDqWXZYJWmIXZEwOuJLUNMGvELSZrDHujvLm2bnFlVg4Fytp+V44iUhWGKzmBSxbl8PsapYFwHFsjTEkFa7tSDD+cmiV8ea10vDBA8Fc2HcxeL72R2sMXJeF/bAqEv1aIOVPT25cS5d97f5iFIYUuUvN4lQnzpJGOE7SISiikj67UzJojF004/L+UyB0wcmIrAMElj849Wk7nqB8dWPVKhPCGW23ZmkYXYrmNFrzzDD6fZ0o/9WwSIzqWpkf3/aBUVQf7PMpa8iGamPIxF9BFAlSjwELEcqmHGJYM6Zu7JdOmXIOGOlZKvEF7Xd0Js1oZoAs+K0qgg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lunn.ch smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOc8NmxaNzaKILe4KxGlLMWutI8IraeTGg1SinGN1Y4=;
 b=NZ/dAvc6RO1n49kwpaHIN2xj5kPOnMIQC9DI30IGz4teXBRO9dcr8I+9vmWzVkvZqVd2nZezUC/dXPzaAnxpY81mbURsSNcvEwymJ+D7u+lbP5TbGqhQG9mgZO7iR79aigCK3VWuRFk55wzgj5QAJYuSsm2HOx6ZnTtWinWQWQI+CzXm1uJ5CEHgHOo7TsQvLet5y7DW1aOPDWGdgZ1kWx0Zr2gKL6FrK2ZdpDzs89MwxQrcEY7AJPRHPwOx5+RweVO9s6JUoLwpyNjQYKRWfnpSpvehRCpmg79uJIhsopVpN9DYhh3K2vgfX1gpSUbkRQ8chADVPnzzhGyVunsKng==
Received: from DU7P251CA0024.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::11)
 by GVXPR10MB8987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 13:21:06 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:551:cafe::84) by DU7P251CA0024.outlook.office365.com
 (2603:10a6:10:551::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 13:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 13:21:06 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 4 Aug
 2026 15:25:57 +0200
Received: from localhost (10.48.87.235) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 4 Aug
 2026 15:21:05 +0200
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
Subject: [PATCH 4/4] net: stmmac: manage error case during stmmac_dvr_probe
Date: Tue, 4 Aug 2026 15:20:52 +0200
Message-ID: <20260804132052.205273-5-christophe.roullier@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9BF:EE_|GVXPR10MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2cf755-1b69-4417-8cb9-08def22b3d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|921020|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7znkq3tgzBuvBfVeYtVqkBUAtxqNXLMMyUuApnHy26j426wbNrtiS8OHbkz/GHbISmqaWjeNNFpJFNpxsBmSXYg30XVarkrBICuqWVSjujIPmTyUhD8MrBcQLWfjqSMX7QwzBOwN/HJCLpOZiITjnrkcWHEPrBSC+NOQXJv7ZUvOXLStNq6JFgUt3skmVi+KptO5eXzuNm8XnXmUPwwIYT6zmOnqtvx4WLgfPmokZ2RmASwiyLvMENkxlA+qyWYGKkwuO4VnaGzj/rWo4/ESyVhY3UQ7LkXB1c1zlUDC1ouoEX+3qwVrEthLVagfo9VEavE/SwaVXslDb+tcPVXkc342jXu5DvQQDHfKKs9cEOCocOLeeQdn+Ms/H85Hx96XW+rXSzkdTRFFMuQWFP+5+9Blj3aMPeoS/7QgEHNs55lHqSLvVuit//yBnam9a2BPavX5J7k9w0bYBugBThlK6hpm+vE35qlSDcYCKVECU3UV6RoFp6nH8s9te483nV6ekx6mdkUxqi0EKLjscW74qrZ5TRzT/hjEDGJJdDrIb6XGGRh+kopmYB+pGymKfrBsMqyeK7pOOCbvmbRs3O3gWObNTKBLqoJ9B2EomVGBjHbfFOvTnO+5Szu+ogQh5Tvta0bbpZ/JviCtIvCyC2Z/BF5xqsf+MGCg1FcZDg7WkGWAvM0Pb/yWKiFemreVWO8z9yvoz3aWnYgnLEcvldQryQdYFQTcWl9EYRtPy7ifJFnVdxr9VUZBVgdLBocQBTH0
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(921020)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sWrNoJFUj0Hi50TN17gsuMULCNwzHdRGE4d3SnER8rxEOkmY2Eo1RtjBEJOvalXY6hh+TwEHuDYvo66K/E1ZI2iAlontAiczIPsO22XivcgDE+J2AZ9j2Tum6daJRvQWFV+sRk13ZdalPUp1bHV/abdJPzslgMmLH3uAwW4QaU9/UAitg9C541Fhs2AswCDN8+4RA9efl3f6VVJ344RZrkesf7C9FDHC7FHIIKAH0yVJcAoOzmUf0hNG0NWjY21VF25wNiB+hnPRNMYlic5P4u9g7KvGjxiGMPcxEn6OhbYPApxphQIJkSXu12Arif+qbo9lDabCr/Ndya1q0XwTMcweDu5ejxojSd5bc3IWoPqBbLgl/3j4EHKTtXvdck8TtsCt1nl5SOQ2RA8dv3Ur15A7XIjLKHrZQGd4uayqvKbY1GRT/e4ac1XP5tNCpN2n
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 13:21:06.2586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2cf755-1b69-4417-8cb9-08def22b3d93
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8987

In case of error during stmmac_mdio_register, pm_runtime is not
cleaning before exit probe.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0de4bc949913..852de0f51c09 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8062,6 +8062,8 @@ static int __stmmac_dvr_probe(struct device *device,
 error_pcs_setup:
 	stmmac_mdio_unregister(ndev);
 error_mdio_register:
+	pm_runtime_put_sync(device);
+	pm_runtime_disable(device);
 	stmmac_napi_del(ndev);
 error_hw_init:
 	destroy_workqueue(priv->wq);
-- 
2.43.0

