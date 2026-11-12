Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473268;
	b=2XiYjW1FbynT/Ef+RMlkrWayMuURWBnPDnxk4HUSHLBOvCZZch1MwMVGRDqM6ZvltVPM
	 DGg02apY7XJisjb6aa9/rH5TblHdA3Ofyqf5+np3KZqZPzsHuFdJIUazW9BBf4jonqK6A
	 SWgxkobhzqXwYylMqiUmMX57tt/9d3KMxqN7L3NXmH2xGeQCRO6XF3jI/XUQwGznFGzvX
	 Dm37CziJhOoRM22VnMneX6o581+qgM/7qMXa6AkDSVr1ZNurErH/lEACy7mGgjkIC8lTf
	 kXh10a9I1P9hTd9JZoxjcq63UfxUEZZb/wIzzpuG/KZS08gmQIVyx9o2tn9HF5WaZHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473268;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=dcsxoU8M8jswOaYjwBMhrB+oQ7qC9KvS+elveu08Ck4=;
	b=PRjglzw2KHBHGMmnt6OjH93BNn9inSxkKi3qFUPkWc2Ia7qpPdmsYIKHzmJ9YzHZaUXT
	 IN7w4pcbgMwrLLmePYzTENR/LPZ5M8SZzdbf7R1Z3C1jolmWcaeKjIFIqlFQnQZWNmSI2
	 yLApKa0BcJxwJj7JG2sgUoEhVWon6uU6/vDFui+BW75LT5HKJkm4izcnRFLsctJTBif9x
	 NqPISD+BA8Q0S50H0xn2/PVlU5HKhTMwZbw5dToO9XnPM4asxTjH3N4G77qvZ6VclO0LO
	 PsrxAXTRMVua6KO6dU9zDGgB1cUpyU+IUHXtvkc9z/MVv/LUK/5atXc46x0fN7weZQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cn.bosch.com;
	spf=pass smtp.mailfrom=cn.bosch.com;
	dkim=pass header.d=cn.bosch.com header.i=@cn.bosch.com header.a=rsa-sha256 header.s=selector2 header.b="i71/fcBA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.66
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA794606B247
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA794606B247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cn.bosch.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cn.bosch.com header.i=@cn.bosch.com header.a=rsa-sha256 header.s=selector2 header.b=i71/fcBA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJh70O63s3XVTTMMKiXKNxHJOfHLxVCxwG/0zKcxOtOvqNTElLWvg+rpeSnCx9+5h5aFqpYLhyExbGokg3jG4cA52oveUbtiM4dBXgh0w3+ed5CB8/nr4MTicA0iku0TAoJQJ/0Uqjue8zvX4YTeNizRWN3EYYXjI8bHrWrkS7wodUeeu7m1Al6byTx3Q9wgQbpQ+4ed0VF/lMtzG7LIyE+sQP8DN+YzPbCwr9dyIfnKobJCpRIRd69YCF4FHX3wreLWCTttGE2qChuC4NnhDU7xuABYJiRykS+1LINCjKCpQSS7M4sE02Klzff2rKLEuGQmutAb9G0WMCMKZ3sFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcsxoU8M8jswOaYjwBMhrB+oQ7qC9KvS+elveu08Ck4=;
 b=ZfVTaOZJpVAqmozCpgVanvJ5x7buQU246gFfWtX2XqHDisFEGMIV5iGvz8xvejuojXyp8qXBspHJhZmneB89WkOVWQpikmhbow3kehKtZwZowKPVcVNeRXpOsrgKpOAvH5AtdX8zBNHHU2HQTppaitSmCaUFU6ghB2X+p9UxaR8UCh3HDmAmZF4SFoG2vq6H/ax+Acd/xhFw/ZJuWX1sVai5Kqlnj00LZmc6kJXDGOsjx2bd9lUFjSib+Cm8xhcAGg9LCFjLE0EcHUvWaZtDoBBzagaMvdzUsE8yHeEhJDqmQNnsWg05KRC3HBU5/9i6GNZP/Nj+GytW5LS/mI3vyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=iav.lv smtp.mailfrom=cn.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=cn.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cn.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcsxoU8M8jswOaYjwBMhrB+oQ7qC9KvS+elveu08Ck4=;
 b=i71/fcBAfa5UJ5Eof4f1Gf1kqhtVYtrJMMBNgzwqDtUqzwax4zWwPGUizavUtNPdkx/erZLPyIId5sk1Vh1kxR6FYZd/u3SKHaRZib1HnaP2QmhPuX7nVn4OsTv4oDYazKuYA1M94z8JWbw6Et6MSYrBtdxymwKg3mkNQ7G/5BoZMaqNEpS+enCmSWy7S7QPnoH/aU1ip515+brv5PRacIHzGILwzCygyFdhVhU5DBe7BQfGgVDw+3LiUt7qhIubqCwXGM2Tw32SjEuYrcbPsEcib4l76HZj4xOLkq4qbKjRF0b/toKxuxb9Jx8RNbfVPbtTizJy6Y5N9TT75r8+bA==
Received: from WA1PEPF00005B94.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d8::630)
 by GV2PR10MB6718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 08:47:41 +0000
Received: from WA1PEPF00009B3E.eurprd05.prod.outlook.com (2603:10a6:1d8::117)
 by WA1PEPF00005B94.outlook.office365.com (2603:10a6:1d8::630) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9
 via Frontend Transport; Thu, 12 Nov 2026 08:47:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 139.15.153.206) smtp.mailfrom=cn.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cn.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of cn.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 WA1PEPF00009B3E.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:47:40 +0000
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:47:11 +0100
Received: from WX8-V-0008J.wx.apac.bosch.com (10.190.167.205) by
 smtp.app.bosch.com (10.124.11.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 12 Nov 2026 09:47:10 +0100
From: Haoning Cheng <Haoning.CHENG@cn.bosch.com>
To: <iav@iav.lv>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH net v5 0/4] net: phy: postpone PHY interrupts during sleep with MAC-managed PM
Date: Thu, 12 Nov 2026 16:46:07 +0800
Message-ID: <20261112084607.130518-1-Haoning.CHENG@cn.bosch.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
References: <20261111-b4-phylib-mac-pm-irq-v3-v5-0-bbfdb5afb7d3@iav.lv>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3E:EE_|GV2PR10MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: ccca5f73-b067-459f-71c5-08df40999c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|10067099003|5023799004|56012099006|261102123227099003|261021121427099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pGtf3XDOhyipDVnf6rawnTvVcKcw9k+5Igozr5BdyuXw4yDcWvCcyIXl3dHKn81d9KxYwbefpznCLeNvj0c91jM6fLcOw0IiP5fwErMpGbpXNJWB4C4zf370Gh3OfaXwCfq6oP2CsupXBRyHNqH+FrHh6Is9HPeCuu84TkY+M9dszqmrv6+lMfQyfcr8glXk8oHO8iWMyNI79idGxaQvg7w2Gq9CaMDSSRFBI5I3y68uI/DRZpL5Q4EH7NPY554fBow+QA7vXbsSW0j9lkYBnAdTZIwaZetM2P/L/5pK5GHm6DRAnBWGBTuCN43EBiEx9qO8xx3YMwec4Ymg0+7rPFRqJV9KzulwS9PODgurjQdd03/gh0u17TRyOc2wEW6J/z3G44J6fJdJfu1dOKrZN/XiWgihxjbfiHcEIpk+UWf8GmZQgI0kGOuML5KEuJ5qbWpycavuszrbvClPnyhxeeHqA55fWqos7tc9U3LfjeNzqYya7tB9MCS2K+9VgblU8e8dX1NpfGWHliKWibEkJXgfqkxQNgc7QwoUyPq2SOMchBx1I7OFK3XRymgAq+rGyECUoLMkLn/7n71skrsPNQGSbsSWB2zojl8DUn0XG6Xg067QaT21SQ+eL8MQ5eRzrmPqTD02xwMg2puFgJ9eu64LuU54f0lc+ZYEpPUFzqmry/MklIP/EDsJAO21ncBC
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(5023799004)(56012099006)(261102123227099003)(261021121427099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WFZ7Q9fxbKYUDLMjCqliCRoxsSwb03i4sV2Pf+nDs+LjKvNrdb0fnEef1HSShKRSKXtom046Ksp8SCJsAnqsmgFEKhuExqELZoFW235/GobWwMU5b/3PqKl7HJ03WQXv6S1YQ+E9zy7xluHG3r5ojmvDcIj/oEsDPuyhL9cSBlsRvaOciqsDkfDcOFF0X3ZUaaLwTQ4qMy3OG5Qypo872dfT3cNbKMFKyppb+2VCBvIiVhxjD3aG/ysyPd5gu3126+XhnCyYj6IcIzGDFRQR7IPyZ0w2NsEAlWFPIOQID02HSG1cq2AdDQPenxKIzppQQmDBXP4Q3AE73ilTQS2LtkLbC9v4FdqplceePRXJOf2jOvHDPtDRJiWn9Vt52d7frz6hCQ4IXS+nYDJwvQl6jtyNEOKrj0gXkjvqEjOZ1onpzN0Y19/bqGjtG6pP3RPr
X-OriginatorOrg: cn.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:47:40.7124
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccca5f73-b067-459f-71c5-08df40999c65
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6718

Hi Igor,

I tested the complete v5 series on our i.MX6 FEC platform with
Linux 6.18, including minor compatibility adjustments for the
backport.

Suspend/resume testing passed without PHY IRQ-related MDIO timeouts
or other related issues.

Tested-by: Haoning Cheng <Haoning.CHENG@cn.bosch.com>

Best regards,
Haoning
