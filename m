Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792574160;
	b=gxDtD7+nfugK8MrvDQtX63f4auX9QDJrBXlPszOkBLq9HsKqjH0XkfP3QoupuVedVwHy
	 jf9F886jNVbiU7Zd5y5cvzQvlKCeYS+F9xuwRj8m211VumTdKyLgxJW/q+9rIGhOCPai3
	 Z+wZkEgSCpBFchb2KYS8kHebAYLtXd+0xwCeINscav441DTfVdpKRTy1uwYQcVH03UsLV
	 bXdtpLkM3kdR2x8UGIJWdWqGI8ONm0PcicFCWTdKTPLGfP+yrGU/+PfXD66K8sebeY2aS
	 4zslszBOPvoh+zc5E9xdn0ES8FGBQz6eFgRWIyaWUqpjswulDoYT2KWYSYqXU/ZAYgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574160;
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
	bh=oObfQKD6l47CfVsFEBUqPt46/IEUpDd/oMELYP4pR20=;
	b=v6NmlAsy7FsqYrWr1zRNW8iIn7LZnnVxJs0PDiqubpnEi8yD/Ex4KKtFO7nVtiZxwu1n
	 IkNFQdirFssyOuy9eHqdVYdxWNqlTL8DA3Egn7OdwnN4X9ZfNOURBfDSHysnyMSEIogXQ
	 DopLXAtb0X9CQdx2XwWhKhxi/btQWaXwVHi0xECEWKRMseExezCDV0hWEwOlkzYf4lgiW
	 HLr1gtPcPGM2IrkYkkc7J4bxUAIev0yhpRcCkgJv6KpdY+vNNkjlfmAUncgaRewAkJPBs
	 GqtQUpxgbRVKB39ITWjLoRZQp4xKzx8Hbo/tz3FGlGxCeJAgU6STyq4wdbTLZb+2qGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qROrnqiY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.2
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08EB606A321;
	Wed, 21 Oct 2026 09:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A08EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qROrnqiY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su8+zNGOirwkMQ4XeHE1S1tlesmvyqVtWAD0jLhCQdr/UkRJiAdSJYHAeL/+X/sqQEnPVUb0z8srCzKCZ4qhnjr9a+MwPN7nN1+YYtGCJ6ANgTCpkf0Ac/GkiPf767zgB1zTA51U4TG8xBha9ANj0eFxtl8yUCOyzWwxNjqYAvLRlTTfUaCY+EMh3GkenhMQOAAiGBCro7Fg0RISRetFpK7uws0ZhBgShWl+FoVbiZsa31bswwaKxlcaqWkLD+pHxubpX9edrVdKJdmk1MSMmO4ixssYDZoxQrGJ3eRRHkysOxgvW80An4q+xxarFJTPIZpFkKwrOnLhf1ilaQ6ArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oObfQKD6l47CfVsFEBUqPt46/IEUpDd/oMELYP4pR20=;
 b=KuMgGCmPAs5rKQ1cZT9CEexJ3j7rVr7dCZ+xqHzc4f5pj7zVnCEdjh0sAyCbwll4g+kOdVKUTRliO/c3pGu5NLZJ3m12X4BK7YKJlj9M9K57dvc7OQXU5vrphVzgPKQPMjqvFM/7LHF3YZ02+kBcPkFzXE8jIDH/W2fbgvhFat7MpZLW57xAXpG2i4YoH6WLMlTwAoz5kynDsLM9wHGpZxcsMMghlsEY0fHFvg7+hlcrP1h5iUxOP1u48PFyHk0Q47ameVUWh0tKyldXbojvO89ArodL/oevVffbCmpnOXbBPx4TzeBceB7K/EanUskxcZ8i/yrPDXNKwM16kpp5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oObfQKD6l47CfVsFEBUqPt46/IEUpDd/oMELYP4pR20=;
 b=qROrnqiYCZrKt+M81JXzGLBoYiKNJBDlyzhn6Cy1ih1blddI0SDOGxj4Dz2R06xTPYTqFV9uwv7ek0fEqK0Vg10y2z6RB4BxM174gd4SdwmEV08PJVW91o4L1BhNkr/CkU8rScz5HSoLeChi9RvQSrmw6Ues0aSBhoIUaqactkc=
Received: from DS7PR06CA0030.namprd06.prod.outlook.com (2603:10b6:8:54::22) by
 DS4PR12MB999099.namprd12.prod.outlook.com (2603:10b6:8:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:15:57 +0000
Received: from DS8PEPF000000E0.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::9f) by DS7PR06CA0030.outlook.office365.com
 (2603:10b6:8:54::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 09:15:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E0.mail.protection.outlook.com (10.167.23.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 09:15:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:15:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 04:15:55 -0500
Received: from xcbalexaust42x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 21 Oct 2026 04:15:54 -0500
From: Alex Austin <alex.austin@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>, Alex Austin
	<alex.austin@amd.com>
Subject: [PATCH net v3 1/3] sfc: ptp: drop the stale frequency reset in efx_ptp_start()
Date: Wed, 21 Oct 2026 10:15:32 +0100
Message-ID: <20261021091534.3164258-2-alex.austin@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021091534.3164258-1-alex.austin@amd.com>
References: <20261021091534.3164258-1-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E0:EE_|DS4PR12MB999099:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d04405-8e82-4034-2b61-08df2f53ea52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	scL93CQ+ShBaYg1kUBv5XoOf8wiQAaug+1fuFhVSxHJS3B6Fd2Mo/ub/oQf7go9cQDhFp4U7wisMVWy3HrhW6/YbV4FYnfqgFnwNZzF+w7KVKwlfEfoGLiIfIubax/YLS+DNljhaIPrnHuyeJlFMOEeKXaBpyUzJl2ncmYuc/yL+xKVPFaL1sTt6nzDQxtuHJTZIgO1ntvjL2UQoRexC5LduMt3cj6SbUYHp7HOanXhoCsde1Krldfq30tgxhit7rXUxN1La/ScQIBytGuX2un2soZWvWvrPRx4fNhOo2BJP1D1m2Yhi3fMM5TaxAGxXqd5x6mouzZaNc/Gx8buBxKZ02SQEcvVHVQpkjXefvPvJh1rILtcekyMDY/u8xJD2HkZkpFJlUbcgaZ4WnWZDxjBFEuOnOwxlrCpuptLsBGy0OszilYzjeVHZttAuBI4F3TvjGyZYlAkEfcUuf6gG/tj778U4aO+e70Hi0wBRQ52ITE84D2tQqQvRgXWLL2eGQlAq2xM10qQzsVObND/STZgZCoNgfoac+0/n4t8tQy1+miwdiXKaPzqdMFywnPBFNZZmzZVFlpVbksO8G3nflSHwuyZPUuOtK7hNBcEAoLOxsN+y0hxcGUCMwOXRjJ3/2ptqGHj2QxdvQOpe2Iu9pe3KoFFLqapANT90pWURvGgv1OGuIhQkNav8sIcg7NIQtA4CBLibyFOyMlDbDP/CSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w4Na9u5JIuQZ59ABqUREkeZR6BrONdwJEEp7jQVRPQ90tlnBEHA1daOgSIKm/x/cftd4RHn9XI1OWVZZDsKMFK39W3DRP7ZuW+Et5CQCMErDccVtQSgTqwyJ719iOeKijyUD9TJvP3Q7cgGBeDcbPxGtBX/G0h3GdPMGNeJBVnz8dDLDMTY80UOXFEhqXyF51BLezInk/nnH3yKm3pIoh6uh5w1/w0gsiMI8Yp/utKb6sTUhLiz0HGkNTnD7Bx4mH3opP9hvngSo/muo2xZAuHB5CIbSiyNSBynVOI2IbLIYd1dtTYOzCYXmm/k04RPeJjjP3T4Ysu5j4+KPz1C3lLH/ET1zhHQQfunQECRZ4v9zIITweRKks5Bt1uy5bmAlQrqjhKIMqksyVl+3DAXlqpeUE6cSpbSW1SCPUlkTNH2Ug4ELRva7NWgJE3uueKyz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:15:56.9342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d04405-8e82-4034-2b61-08df2f53ea52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999099

FW does not touch the clock frequency state on MC_CMD_PTP_OP_DISABLE or
MC_CMD_PTP_OP_ENABLE, so the driver doesn't need to either. Doing so
just desyncs the driver's cached current_adjfreq from what FW still has
programmed.

efx_ptp_start() is also reached from reset recovery, but that is fine:
on an FLR or PCIe reset FW does not touch the NIC clock, and on a full
MC reboot the clock is reset to 1970, so a stale current_adjfreq from
before the reset is hardly consequential - especially as it is bound to
MAX_PPB, 1000000 ppb.

Fixes: ffe9554c17bf ("sfc: Add support for IEEE-1588 PTP")

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

