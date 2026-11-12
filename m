Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794505781;
	b=EU08j1FxU8T3kRlSCo0OKcdnHCUmr6KKCLfeD4UCYA9jHcyM5H5qOqvS1blisBcYNohp
	 dpq2cywjKtE0ookSa1OLbWBfZEFqif4tig6VnIiLw7LPpFXjAnGQJbBbRK2c7nPaQmk9B
	 cer7TRrhJ0c+ecb+RyEv+qdNel3kXPE4rmwTTqzr79ec05xs/Vj3KGZ9AO4eFrWNwE0AQ
	 kJM/RaN09fBpH1VlJkv/sG43eewr7Vt1wKgOnKVMeGVNe+Q1q6WLmiD4i9Oz+bl52dxXh
	 EOi0MlUh8V9wLpUmgqStwSlGqzXs/qBWZ1v2+Z1F3XpIVelIMqzRztRWn398nR1kcpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505781;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=BctAhh4r+Uc7WKowrcROrcDpiSYnKeVef/cvEsV06Mg=;
	b=RIsp/vQIddXebs8mkPqMdzpm6A/3B+JWdvFydBujzd3fhLqSk1cmtKrVhvhPo9yQv/OI
	 q96q68twn3LhSTSnWbmJ+iTiByWOPAq0C5cMPcyXM5suAR3wF+512vt8OsMoNQT4qrL9J
	 PN86m9fDF2M+wEu0WMpcuRwSjFPrL7tLKt68wH4J4Ol5D5qWFqitKF/s02SjV6dymozK7
	 GFb+aS4pYtvzt9LTFPqm/hZX09Y9Z+EE+McDWXWVnju/tig/OfdL/+yGbBnlCUcdrbxR4
	 /zjlFwANADPWvbCOo17jFL0Fg9wuqYmlw3srnvSxnrEOMH0JJTmF0bIAvgYDqHwFXMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QUKFC7hS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.12
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C623606A31C;
	Thu, 12 Nov 2026 17:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C623606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QUKFC7hS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB7ZsHsbnndfg/8kcp+W0zCn9BtGgbVydH6q/UAatlJ/qAOEGYi/TG4UbuuQPOWZ9mtgSSHcGlorhyl3H8AB3PwtdtHOZSMh+bh5hSwEW2h2+WlIeuy36GlMOm4jjj/a6CWv4J4Fj668pr5KPKEkwW8JDnfkxcZSvy6iv2kf9Z0KG0atfyk679aiUdrEIUBltPYyR/4j/MAUJ+ry1GeQJmsilxKi/nrtKljPnG3j+Mgtd7aBifi0oEb3bAeKNAq7gL4xjsNR5FCK1ra3dBWSn9yDXiZACi94F9M9Gplz0ySHhX21Ok5Q6zm8kSNqJL3VfI+jLk8xPhUwSs5SxYeh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BctAhh4r+Uc7WKowrcROrcDpiSYnKeVef/cvEsV06Mg=;
 b=sdCd6Hzm7JDlakJctQaLRZynXQ/Ctx+2pGpQlfrYoBEFxm3Cc5EVtE74xFhznbfPLFO2vaHNs6Zrho3Nk80huextTDwp54Udn0H+eYHVWplPz9zfgXa3ROZIi7e7Kxqqs7M3C/UzB/scw2EjsJ/Ad3qvDM/xThC4cJtveQsjlRWAoGTOv2GOTfjJzgtBlMHhuxXmGnBvdH3W/Y9aKAeku0aBPuqM2gCDfgoYx4mvyPxNJrXiq7VgRf+uDXjuNMPGCt5ZMEvHfPRjxo119ennvIA2uosSvnq0TavvwN4ytWPXNIVRnp5q2AmfBykJ3Pca8hGBnauGFdGR6d2m6JIuYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BctAhh4r+Uc7WKowrcROrcDpiSYnKeVef/cvEsV06Mg=;
 b=QUKFC7hSUrxo8upxvRqMqrKqNIh2Q86CWPw4O9wa3LG+/MlIe8qVYXzcpG2j1q9HYZvp8sAWkSTu+MSqXeWKExDAf1851KKVZ016NPSag87kEfxf3jZaYyxzyIuWcpDT0mtBHwNWX5FO5loCGOqNLoeKj2SAmMHJiRL4lBaPwVY=
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 17:49:37 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:408:e7:cafe::58) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 17:49:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 17:49:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 11:49:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 11:49:34 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 11:49:31 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <netdev@vger.kernel.org>
CC: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Michal Simek <michal.simek@amd.com>,
	<linux-kernel@vger.kernel.org>, Suraj Gupta <suraj.gupta2@amd.com>
Subject: [PATCH net-next] MAINTAINERS: Add Suraj Gupta as AXI Ethernet co-maintainer
Date: Thu, 12 Nov 2026 23:19:26 +0530
Message-ID: <20261112174926.2102832-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c8a303-acfb-452c-f854-08df40e551dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261028144727099003|11063799006|56012099006|261022105027099003|261026140227099003|10067099003|261021121427099003|261026121527099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X8D8x4Kyd6rmjitWe5NemWOROrjIfv4ZVYKcTQsU/xtwn/kxlrn1KmuQde+YHBG4FvNoHn3LdiT8TmvmEgwJEPi8sqagE1+zABwcbFd3Y2nlnDQMVyb6UyyuciMIGFq2u3OiYl8cnY/E49GXe2zVRfJo0hBQWhjsUbjSnu2799NBC60d3sPcS2mbJ9LD97CiDgE6dBHMbYwiZmXFgMe07gcxRKlb0ZiHMmPSgm5z8DpkbtVbVkOvpL29hwWNXLOrF+J0UfgSZSq2tbzW2hRzsG/Is1XcXVdBpQ642+9+rmZQkwPSNR8xwEhQi2JlyFCcpfcb7td5ZF1PZzvz4o7mMNx+9wi7y9CPmCq3Qna+RjRlH0pgaEGmI3qQ3o5WAQPYh/eCzbJ2O0Ej2DT5b9QKFUw/Vv25PHPJ6qD09/Ifc/P3pjZ9yC1HmmDhVdC+kc0IrCSlDTLK3bUndYj2UnDCiQD3VYoGn1Pw5M3PfuwaKu8izeDEnfD+2Oj6BNq26WLKeZ8AIkOuQFsUBAE//Sf6begmskYrvVO9z+QV7XImwpcTiBDpVgICh9K+/5ubt7AQyYDdNi95VKP869Fu7IEzj4685dulGKAsehSZhW1WQjTD/8uvSVlD7BnDJsFxsWYUSJQVIX7NxvyxtPHJzvzP9QD/buB5D0caJvmPCj1pwzILnA1Xsqo53xZ/QNNVFl/v/pdYKpogcaOxIEIeJAjvtQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(10067099003)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NCPA6oSS5SKnBZc2ky38404pGjZr3aRIREDfyl8iBxvngUbZ85+izm5r3XbxtwCAwKT5TS/VZQMas1kJwd9QY6HQo5GQ0OnF16GumcmqRgkR7Yw0wnTI/uyESusSoU9FWpYiUmJMoYZADFZfoucbglQxokf8r+/1r0zOQYvJQALEGVOpxloog5039RC32ho1lLNevR3JuvUCFUXOERxod9cKXQ3jw+sFdtraf3XgTUoB62xhrTj+DuoBd6kWmaWKLjib4FqyC3F9HLz9LEJZDpHmPlw6wcpEyM6kSrDqZ3W3qLsOI9vTjzdQmznSesZt8KcFYZFDbDErr4ZwRv7Pv675Z8U3cm44c7mbk0Y+5x4LcySXtV+wOdyJX9rg9aHWfIGe0WKZxTeJnZ/OapyKo8JAWBDSYuoYZ285gcZ7bqnRSX08XnYx57MflRkX4XMQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:49:37.3799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c8a303-acfb-452c-f854-08df40e551dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751

Add myself as co-maintainer of the Xilinx AXI Ethernet driver. I have
been contributing patches to and reviewing patches for this driver, and
will continue to help with review and maintenance.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..6979b92b938f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30613,6 +30613,7 @@ F:	drivers/iio/adc/xilinx-ams.c
 
 XILINX AXI ETHERNET DRIVER
 M:	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
+M:	Suraj Gupta <suraj.gupta2@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
 F:	drivers/net/ethernet/xilinx/xilinx_axienet*
-- 
2.25.1

