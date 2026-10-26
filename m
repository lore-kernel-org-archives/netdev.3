Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793017840;
	b=AtLM2EOEhlaMy7/MPgc3+9jWI/f1J+IixjeZ6htYCikMSKKfuqE/nIfdVcqUwkXZcuR4
	 dRzAzRobtCboU7LhzKu8bcmP9apUqRV0SSraffujJET5ZV/dY8B5blRN0voHC4Mrfn2VP
	 GPz6mmGiTWA9dfGaLGHnUvTWSIif+iSGsARSYlyQyRbEUel2qgk+2uJTOlgNxt4wva0wL
	 jRZZcFux0pYOANiIewUtiPIfJw1/2gOGfxIzqS7/UuBQjR5DID4YDUNRJV4/4TxAtWist
	 o04A0+W0A7oJ+aIMI2e3Isn9vWnQDvA7dK2ifrKnYUtJm8Z2CJ0m+mrKcK0b1pPpuTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017840;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MURmnKjFa4Z8V0r9Q9Fo/W4BYLk8JYb4uUWNgiNjUyA=;
	b=wF2jhWtysmSfBhgEcgP7VrRKZ8DSd+HDORIPaoIYt0bp/5zii+p4YZsycHHj7NP5DFX8
	 A4eHObT+0oxhVbophLPlJWju3bjf0BEV39narKfPGEcixQpn/wPX8xRqPyNiFsvrCnLNY
	 N7YZbRAWaF6YPcSUvQk78AI0p+vz/+hr3Fb9h2FG42jJ4v4jppQ9ev/N//S27kLHkFHVJ
	 2ww3wXXENVc+NNJGjbiqbJLO94xgeBx/sJYJqM5Pcrn2enxsutAU9QTWCLYdlv8+xL/Si
	 51LkRrfXYbfPQrMYVGRw7Jspc9nQOPOOTfQ8VmslNGBXuuuEC8sU1eO3VqNJNAAaDtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uR+QkIxL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.27
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E62606A31E;
	Mon, 26 Oct 2026 12:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24E62606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uR+QkIxL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McZQ7N0iHN9yAUktKX/iD9rcZ1tJYqyJkp6hcnhV3cezsm9W9epS8bdccxwi+g/9jXINhMvD3z8jUJN8cGvaY5FrBkNW95Srj8vGcMDHMtRrT2YhiPqcmHJPD0u8HWtqMYvuJQLt0r5HgJlCcZHw9VVq8TEHTjhrSi6tPowtpo8Ik9xLdmEuDj03uEAyt8bWTdXQyNWeE/qcMrIzSojxWODzeg4HJQNHTwRLB3gtLtUW1AUCFzbhtJMx5TzH2pRs8dbPyBIIEfohokDLI86jS34nhLTmZ8JFnGD0FCxJxMLLmEzxjapjFgSFjjMYi6kfRg12OHpXVy1QWCOla+1X+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MURmnKjFa4Z8V0r9Q9Fo/W4BYLk8JYb4uUWNgiNjUyA=;
 b=otK27Gcu9JIEpZhHnayiwtTGqt6U/TtZwgQESb/+2PPeLVaDPsrcL8JB5EbuSBSLJGaJtjcpkDmio9cGH+viO9z3Ak/R0yprpJ6I7uoS1EHWRCBDZ5OPdh1sURgYoxCqs8qi69QdDeLt/k48wr+RjqzAG6GqnaB8JuQtHcT9P42LycTOIAqUtEva7s0p95I2I5kXeDfxlXJVeDjzV1CoALKDf/FtV+lyKh2zjd2XGvaAiuHdOLASzUX3SQMER3LHvDai5t2diN9C0ejLD5QJm4HGkapoEOsxJp9u7gXl5NaevGraCu6C+ZVAx4ErZVTemQz0EWt/ezeiSLpdVretJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MURmnKjFa4Z8V0r9Q9Fo/W4BYLk8JYb4uUWNgiNjUyA=;
 b=uR+QkIxLkfcB5gmghBmFVwDXy9i1lBGGDMamAnl6pIDugV+uuOlmcrJvhNmI/dECNEMbPK4hg/r5t7lYNjiAJOV0eADoMUTp76q7PMTDJATT1aqnbEzZlsIVIfXYM2k67R+lJ92Dem31j8liFoq/Q3QJtgFIK/Nj+KVNcJ5EtIM=
Received: from CH5PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:1f1::14)
 by DS4PR12MB999099.namprd12.prod.outlook.com (2603:10b6:8:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:30:37 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::1b) by CH5PR03CA0002.outlook.office365.com
 (2603:10b6:610:1f1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 26 Oct 2026 12:30:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 12:30:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 07:30:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 07:30:36 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Mon, 26 Oct 2026 07:30:34 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, Alejandro Lucero
	<alucerop@amd.com>, Pieter Jansen van Vuuren
	<pieter.jansen-van-vuuren@amd.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>, Alex Austin
	<alex.austin@amd.com>
Subject: [PATCH net v4 1/3] sfc: ptp: drop the stale frequency reset in efx_ptp_start()
Date: Mon, 26 Oct 2026 12:30:21 +0000
Message-ID: <20261026123023.3566549-2-alex.austin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026123023.3566549-1-alex.austin@amd.com>
References: <20261026123023.3566549-1-alex.austin@amd.com>
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
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS4PR12MB999099:EE_
X-MS-Office365-Filtering-Correlation-Id: 702f6702-139f-4d16-6288-08df335cf033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|11063799006|56012099006|261021123027099003|261022105027099003|261021135927099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tllx/sPxJ290TlVbGB3jQ3fcUINNP1jugnwGCc85AUs/yVPX50H+jlLG9n9jCgvJ0DX+p9XvCYwnZ81uvUR2sJCMT6hhR7HgPqonTwVTVyMvs3gKu2HWnuVYOLu15WcSB2+CPWl28rfPULYJHWY6H6xO+UrjOCC/mdD8FiCcHkHKXX8LxFN4WtFsh/b3iFrnjIERa4FjjHLWz7E8URNE0Ph8yO5CKLK2qp8XnqE2wXeut2D7t0UxWTahg/EWpPG6bBrJr7gsGK7pDHuH1+9gPJsKjGV9oOqCXZYKVGkRXDznxTUpItZ7yvlzlfkdwYpjU9opuy27dMTjnGKTO8FCuoG8F9ZK/yRBMeoFiIF/u4VC4WQzU9J0YpG8sOGa2fQ3aQ48oGWonEdOCDTo5iefAvp23246AHc/AMBZSJKk6MpAMbvR9/7ZehtnbZHawXvlXYE+Okzm8+NsbJIMik5bysT5Mx6bMqyxgTm1/8C2cU+gEJS9K/VkIQTyrusCDXYp+xRvCx+ltzBxcn7SjKXiVz60dfZ+lF0UMeMvF1P2yn5BncJJNRitXK1jFLJ1MMT8S+fyoNbWKIZ4nXMopAZcXUXeYMdKMGktUC+zPf1koFjBIr7VAOvw0x4nQFyXlV1y2NtjQDUTsXiZpdCSwlF2zZNSMOE6D3lKDHWKy6P/B4Xo1bK6OWThr2RE80G/LcVQLeSwxfk+7KJ06noCuPhmsA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021135927099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r4GlRlkCjy9oi9DE6vAlSlV8nJCPpn+NknHYZlEjl+d7TUfoYQDJJRHf47ZuetUczM+kXoubadYXtQIkvu5o2ygK1yJr4jD6Y/sAMEYfteoCvT5obqYN36jJycYIzO9ABmwelziar3j9W5qDJYF+m/9VPyJq3WNNML2OrvKUelqGNAeCZVKVDXDgbVNorGZpRJVm1FcrfoPizEx3PJTwMYKyE+cza/hShJrdk5hwYjX181tyQBbfS0XLbO/idqEpGJ3vj8MqIJTm9NilyPtOkzHbHiK/e07wWCZQ3pm+/i20xSqm4AGTUuW71G9mQiYZ6DZ+K2wSNkFFsGOX7iDeZKkMEY0PXS9DtVpAyu+sVgotqr0l/eMOq71Jr3HbxtRfwF92R2FQHmQ+65r+aE8JLC1+0QqDb1W89RJoCwEY9hPH+OUZ4bLEKMhCafZUGABl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:30:36.9251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702f6702-139f-4d16-6288-08df335cf033
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999099

FW does not touch the clock frequency state on MC_CMD_PTP_OP_DISABLE or
MC_CMD_PTP_OP_ENABLE, so the driver doesn't need to either. Doing so
just desyncs the driver's cached current_adjfreq from what FW still has
programmed.

Resetting current_adjfreq to 0 here means the first efx_phc_adjtime()
call after efx_ptp_start() reprograms the NIC's clock frequency to 0,
since efx_phc_adjtime() always sends current_adjfreq to FW alongside
the time step. efx_ptp_start() runs on every SIOCSHWTSTAMP mode change,
on ifup, and on the reset_required path in efx_ptp_worker(), so each of
those silently drops any frequency correction the PTP servo had already
applied.

efx_ptp_start() is also reached from reset recovery, but that is fine:
on an FLR or PCIe reset FW does not touch the NIC clock, and on a full
MC reboot the clock is reset to 1970, so a stale current_adjfreq from
before the reset is hardly consequential - especially as it is bound to
MAX_PPB, 1000000 ppb.

Fixes: 7c236c43b838 ("sfc: Add support for IEEE-1588 PTP")

Signed-off-by: Alex Austin <alex.austin@amd.com>
---
 drivers/net/ethernet/sfc/ptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index 6ca9a75..2247e5e 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -1446,7 +1446,6 @@ static int efx_ptp_start(struct efx_nic *efx)
 		goto fail;
 
 	ptp->evt_frag_idx = 0;
-	ptp->current_adjfreq = 0;
 
 	return 0;
 
-- 
2.34.1

