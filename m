Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A128686;
	Fri, 24 Jul 2026 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784867601; cv=fail; b=Y2yB3x+zFH4nYDtci8Rf+0uY1Z8HDhZ6PftYYw9xt/bLwG67mkRJ1dSB1ORVv9y85xRrz/rMioRegu0Lv1u8f5UnYbnLvaFfBF0KzjoLlh3wwNwFBrcmA27S6Ys0rIx4ZkIIBoOa3IdHn8RlN+88W0uW/MYc1Wke16BRAri2oYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784867601; c=relaxed/simple;
	bh=AdR/J7cw9gZcwQBWj7im9tt4obDE8YD5/BM5OUxBmb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4gJkUSqS/yfiVHH0YP/KCcdztPa4eiG3mXHhx7rrj8hZO3L0uVde4NGBFoosObHImstMAhepZxv9t2Orn7a4T+EgAX7woPcNg5wgzsN3MkLdRdvHUQd2+TigXIU+uKfwDY+Ok/6NYjZZQp25h7Xpyfwaleq9fRqXo0yET8aSR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wq9BOgJs; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wq9BOgJs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1yIrJG//Oe6a0HEr8EYlQls99pzmNsj9583godhyen3CFVLcPxyKphYmedlJ2iLlbHls+ktbI4oCJNOyRhkC+3Px7iAijaaVklK9rC5dm4VWjN+lmOEhyLXLSoiwgirQXIGBTuSvL1Hd1XNE5KSA0x6MMRNlboLJw7T5+9HO0WjCLEdefhnAnqZxUwofUQ7cEmfu3YRkpShye//+r6ltjawfrhnmhg0afTdMJF3tliKrPmAkGz4AAc+V/EIM3KUWTEd5DVrdrr/y4cpQ8Ln4AJ1TTJYEqT9mLLN6akW/l2fRWEJItXU+6WvsHM5gYb0psGLgBJcitPe1huhRddGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HjkCj4H8esMiD/p094pKD1+oKgRYOd8nh2HWlOaOwY=;
 b=ajW6IBNWr9hcsEuVvwiUH17nn7vQWV+jOphlQ54/CpgtBScNBtfmt22Yvnq0eyl/L9v+La+bLkCs6TUvaNtBJItcvMJCSZp5rBfjdGMul0U8sV9v9gF64DqsIUeknbE1WLC/dLpXz39kpk113PdE1V0lPF+FT1rf8Lisa85g1CExVzY0ddkfvRP3HqMM+LieZrrrwk2A08VppqwqzJ2XYTZ+cni66V7EUvFaSxjEdjFQvorpUCVHHQayt3uxVES24nONJR1oYGLSGFQT55sPhS3g8NcIJ+khzPHDrQphwH5r6s3CILvSqaVMudSLMLyUB6c+ASlzy0IXBM/FReAv+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HjkCj4H8esMiD/p094pKD1+oKgRYOd8nh2HWlOaOwY=;
 b=Wq9BOgJsS4+MpzwphKAb1gzbbCI6vlrAqDolzFYqMKvTymlFlLxfJ7vwvp0K7KFEqobgrRyUZQYtj7Vr3LalWE1DSdZaIoiEB/oQ4iHBcXYec+YU3zDxxf3gGeSs1JZMF9Phoe7MCUPiXxyR4ydOXmDJ1XZbWCM2L/D3dxH9o78=
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 04:33:16 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::2) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 04:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 04:33:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 23:33:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 23:33:10 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 23:33:07 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <theo.lebrun@bootlin.com>, <conor.dooley@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <vineeth.karumanchi@amd.com>, <git@amd.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/2] net: macb: remove unused ENST Q0/Q1 time register defines
Date: Fri, 24 Jul 2026 10:02:56 +0530
Message-ID: <20260724043257.2221030-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: b5abe074-4532-455d-8847-08dee93cad77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3prJjVzl2wfABNMtBa862BWDyNftGSBdOVthR/mKsz9eOaRyAlLZxHlM5m2Wgsdc078Zn0hpoXggzvc0rVsLeFEF+purFb5Pztrx6W00rbzgqpG9FHFDsvW/ttUBP08cNm8j1Fuz812wl4CTv6EbT+Rxt3AFigu3DrGdX6iuH/uV+dGELOTay7THFGcFnqPPLzkovgfqZagXFt0QhTj/4Rxb+MdPQK9Sikcd+RtcpKRPeE2eT3v91Z4nwlXMXvBoWqpTLce3RVJQDbhzUFC3P+uEHQM6RF8z2BUqTuLaSerJevJvFhC9QOfQcF4GqW64+93jox8Xp+Fs/6zMbtlb6/4HH0eRbI0AmQYmRsRACePTYPmZhTyT+8QnHUw/bdjjZ6kZYYL7f3/sFTUCvL7P+/YQq68vSY1DXqnfctgNjCcA2rHwFnwt0oxumtaU+u+aH9OfBdiYFutMI3qrSbI3aR3I39Kjtk36m3HRYjYP+VTZ09yEdl08Eo0VyBYTmjcl5H1EySqaCnqnvJy7NshwB+R5v5YVPWbfvubLDMsaUn8lNthg9YCMe8AyRiF/eN/f+dhfiOgHE+Kj+IC3zcHbi4ZcgxUT83d/7HRsTvZFSEwEJlwT4K4L9UD930UvInHFEHLhQSbkjWMlVzvYJVAs/kK82aTN09rXsZakqJm6PPzK/SCoqHLbn74Rlr7IFugK7VnyIklAz5nfC0JG77GLWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y+QTg8rXUVqrY9fHlx8M6qRIqJh/b/hQ6PlGVwYcxp3Drj6F19IsHeZNQnj3gdLDivbvVEOt5nvbAFGFKbp2bK0iR0Ytm6crc54HAwd5iqsV1/gVX5zQphOKLeOlt4PlT+L4HAcSfK9a89dZUegiEdc3oPdkGtI5zvBtGOhJisfzp1UcAh6Bu/s3onw+HiFQcRpibUTbskIOn0zuOJqQN40o1Gp6yw9shXwuuPELmf4IRIGTPcOG8yXIGcPbvO98f+VBXsnqV2RIO5mKW+FjZ68ZTSLV3W5ebJXs82OQcs4s3CtUYRXQQ/mSFdmQ6DKajh4dD5FmNq8j/tBjXopgdkBEADbNCtyj6wmXfN1heDgG3BwEJwun2hetOCx5VyU3NqiCopUcUkPFIIAmB9S1SPBoM6D7uZWnPOAXRGfGZhsAHqvfHJD4IyjQh0mxRRew
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 04:33:14.9691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5abe074-4532-455d-8847-08dee93cad77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

The ENST start/on/off time register definitions for Q0 and Q1 are not
referenced anywhere in the driver. The driver calculates these register
addresses from the ENST base offset and the queue index instead of using
fixed defines, removing the unused macros.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2de56017ee0d..a11052565436 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -184,12 +184,6 @@
 #define GEM_DCFG8		0x029C /* Design Config 8 */
 #define GEM_DCFG10		0x02A4 /* Design Config 10 */
 #define GEM_DCFG12		0x02AC /* Design Config 12 */
-#define GEM_ENST_START_TIME_Q0	0x0800 /* ENST Q0 start time */
-#define GEM_ENST_START_TIME_Q1	0x0804 /* ENST Q1 start time */
-#define GEM_ENST_ON_TIME_Q0	0x0820 /* ENST Q0 on time */
-#define GEM_ENST_ON_TIME_Q1	0x0824 /* ENST Q1 on time */
-#define GEM_ENST_OFF_TIME_Q0	0x0840 /* ENST Q0 off time */
-#define GEM_ENST_OFF_TIME_Q1	0x0844 /* ENST Q1 off time */
 #define GEM_ENST_CONTROL	0x0880 /* ENST control register */
 #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
 #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */
-- 
2.44.4

