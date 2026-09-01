Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DF38D3F2
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237770; cv=fail; b=RXXi8N/GqPKyWR3Mvb6RiU5vu49Yjdy0aeE4+NR5u9/61RW4PYHsiwZb8mMnE0Gch2ljkzpD7FlvFAXlQgskZFLLuuRQUTH7D37fHClyfyxiD9YiwWORbFXXjqhnzJBpEbH1z2rDA57OqwLvOhU50oBMQ39uFCFxThxJlKeN1CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237770; c=relaxed/simple;
	bh=cMiFTP4Fr9fcVP/v9Q1MpNZ7/xCCFFfpwOXtZJuTaQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN3hgygfyVbDBnIET0WkFQcQp1IDpocsmkJvAjiW/f4FIREWxg1c0rhUltf8cgg4kd0874pzjOTpfrRWUU3hTwI/3Z2HaSmZ9GsgEYkoTA5p7SdEMkuRxhF+xhe1UXFn7PKClzIMmNfzlIgsdFhs5sr4uOgyjPriTdpn64ExToo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mXwng0pH; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mXwng0pH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkolXjHzE6DMX1h8HdHHCn8nwooQ9m3A+tdJ/DMLlqHLCaHgR1wUKIOnAcyE9/Z70w5pb+S0Zf9NPE1Y4/0DNeOm0t98UjKVB2t+QCYPhpLRE05R8KYDe+mJUbftayTGY3ZOp6uFSw8o/3XX0k4Y9gh9eTHpm5fx5/gOZdAeWy4Txf63yDjsI4R+2jp1aqImFZBw2z/tDzyWA67ygBKvIQ9+r8qONRr+3gH9rQ6H9Dk6ohVTMWqL7ExsZT7T+Hb49kLdnUGPYPApmBXMTGRPsOAHbWs+0BX5B3sgsmbtsnxqVN1zUl+xstKzDQV8EGmlCkIkrVwu9qC7h3uIHtLfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xh3UAyvnAqMyAXAaxFPjmTWuhAxIsMcNqqaCtntGXNc=;
 b=fSKmvaedEf5KYqvro9emZI1TG5ErBPlfbUzpKZf48dnJwkUhdMuUGQd5rEZ9XS/rRs27Yr92TFSbs9qLeBe40tU83RmPYI33W1eozSqQzrLe5w2LAbnOD+prev0c68wHQ20Gsyb6xlKoa4YG+j3DhXNv1EUdpIXGvMNZHyoOuTmrmvZZGIgBm8Nq+FQr2IfAhKHg1OopB9t2ZjavZeP3dUwU/x/5JfvFgrnSjkAUXglI4wNW53m49xUNF/iJg6lUhOP1A01gUtXkEBPZO+74cRxFAu2VjBI/0PzeY3t1J3t/KguOcWBMOhTNiraPfG36jBroVJ4mzD7H3NC++5npug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh3UAyvnAqMyAXAaxFPjmTWuhAxIsMcNqqaCtntGXNc=;
 b=mXwng0pHmL3jaGD0kZSrLHaQG1k7DkZCkNstz25FW6XJCrJU4zhnwPI9RI2bHjh/Dhwhhi39q7QkV5eriJWo73tkGYTI+RzIqL1PX2Y5XYAhNQz5hYSKy0Djk7Y9Q92cxdrjlEJqFjZ16BeYMd298g8C0yMmRyZlRXniU8pGxAQ=
Received: from SJ0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:2c0::27)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 04:42:43 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::33) by SJ0PR13CA0022.outlook.office365.com
 (2603:10b6:a03:2c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 04:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 04:42:40 +0000
Received: from lab223.rund-run.pensando.io (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 23:42:34 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <brett.creeley@amd.com>,
	<eric.joyner@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net v3 3/3] pds_core: check info_regs in the identity debugfs reader
Date: Tue, 1 Sep 2026 04:42:19 +0000
Message-ID: <20260901044219.1361466-4-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901044219.1361466-1-nikhil.rao@amd.com>
References: <20260901044219.1361466-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: e69bc870-83de-42f3-4c40-08df07e374e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wu0++/QowjW4YbrQgwQsAZ3PYqhiRrq0992vFXRuDJ8AwCzaKHh96fkOGcO5yrUqU/JL8beTcALMl+rLZhYwrM1OJUd36t/ABkS6d7GYdr2nJhq6OZSfQdJHz8Yx5qJpVemw5p27JInoGsNGNLJbMrqNzg0GSwKcCqqXOU6P/s9xeDPDmes/WPEn2wF1dacaaiJ7dn6aJAu1LNYvb+QtvKlCrvjgv00ZvpgQXtfsmzyBSlBQnxzkAVEtninGcnw3to6Y42T6XRZSK7Riql51tHyM9gzeeXDnzHPgjp7IaEGrcJTHqeHP/77k/vGaDs0NEPrdw6Bj1PNkAWgw5EWDka0iG30HnV8Vku1FRoOxrbT3/wEm8nbnZe/Mlk1aI9h8zPJpO/nn9dOUj2nHmg/JrY3en2nxdOvae/Bth+V6HG8yq3eCz2Q0A+VMoTE8L8U4/EtCy4oACWYAc/dQ5THvrOBEXFpsWhq9r/7b0LOHCs/GrOnkA1XXmCMwAJLqZZYvhSmF/cR0NOx2Y06gwz+IQ4xyoIcjwhOAPwcsawiUEiegw+B8sx27Yk7UZitbTaKGKC/d1erBe5JXiBlYD40gSOVFqk0dwzWmBhceaHJU0SgZYE2vgdvxZ8VzhfI3XgM8RiQuYjGg8jxawhziG3Bo/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tc2K1OEelQZ20NQvQA+RnjltUMtydpKUSwc3vLX/m7JGUU85vWX1Jmg2ARkzOy7wDDUB+w3I0gU5bfDjoS1UOY21YJI9qIs30e5wPoZCarNy0CRdktiuNAbpKGbWWp6ryIE5kc//ii6SAPNVSIyk23kw4iLygvvCzdnAQ02hGxqSf2HF/Mg5+T+uUKJ824v141mGTiHwu+4wJDD7+wgHND6qfHYFJlgA8FnzNphWFEiHGbF/BhQyggoEyJdsqNBWayHce4h9VFcqpB2nngmZHuZ8WQUuOJ+8kg6Ehfc+zQjz8uOZRpnVHFzhiGGlXkPNhA/CpbsSN9MHSB8XnQyn+NTqw7T5Y2Q+Xo8/M8eevwwuXhoQXi82+hJphTNzTy1+VBZgzoXgiuMvpuhH8fijHBUwW3Ke158tMRWok3QWaYLkgsedDnYD48n3HHW1/KWG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 04:42:40.8719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e69bc870-83de-42f3-4c40-08df07e374e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972

identity_show() reads fw_heartbeat from info_regs with no NULL check,
unlike every other reader of that register. pdsc_unmap_bars() sets
info_regs to NULL on reset and on remove, and the identity file survives
a reset.

Fixes: e96094c1d11c ("pds_core: Clear BARs on reset")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804235946.177762-1-nikhil.rao%40amd.com
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/debugfs.c b/drivers/net/ethernet/amd/pds_core/debugfs.c
index ef0a1b7d159b..c458e6758959 100644
--- a/drivers/net/ethernet/amd/pds_core/debugfs.c
+++ b/drivers/net/ethernet/amd/pds_core/debugfs.c
@@ -38,8 +38,9 @@ static int identity_show(struct seq_file *seq, void *v)
 
 	ident = &pdsc->dev_ident;
 
-	seq_printf(seq, "fw_heartbeat:     0x%x\n",
-		   ioread32(&pdsc->info_regs->fw_heartbeat));
+	if (pdsc->info_regs)
+		seq_printf(seq, "fw_heartbeat:     0x%x\n",
+			   ioread32(&pdsc->info_regs->fw_heartbeat));
 
 	seq_printf(seq, "nlifs:            %d\n",
 		   le32_to_cpu(ident->nlifs));
-- 
2.43.0

