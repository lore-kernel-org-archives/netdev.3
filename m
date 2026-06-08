Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3B3B3895;
	Mon,  8 Jun 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958461; cv=fail; b=Z1nMR2zzlEBnMcCc9hORPRF4RNe/KQO3PeycU/zp92nZnD8zJLc4ZlsbElrEpE15NB5g/viRiucx5r7lz6v3cg/aDNQygVURH1ybJjK0+wZYNv/hNuKEYyurQqPb4YFc5hGEyspoOTaasBWVhS24Ukv04AXgciJICZJ4/0Lcp1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958461; c=relaxed/simple;
	bh=IpW58tjuS5VVZuyn/2Akg6AVMlDqt8L2Jkf2HvK7kYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpzVu08g3W9nP8zNZU7tOnKnEj77H/IyBMdo3vatt8b4axGIG0g4LU/xrrPI53epPPN4ZVhOA7hiU2MDSDSb/Wiap5xuEmJ/B8MYCGdxHZDidKmEWTLki/QHQymbosY10nwOFcur9DxdjOt238M2SWY3xuvoWkk1ASZ1/LRVX8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EV0ESt/M; arc=fail smtp.client-ip=52.101.57.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EV0ESt/M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVFL/0n53B8kLdt5kEjcTLWJTWFIxm49fZYiQO0hs+5JYTMallaiq3PEcXoSKpyXbbF9GhVpP9Sg/kTwFIUGt+SeeECA0HLEb7H+KTpXd7D+TP8v1gu1ToMSjSafNWM/G9cUAJZAyCdkAZae5DlH5Dy28z0W+9BgrdJGip9TP297qa64YaR7XHgpjno2MoQ2NEXjpB2Q8ZQ2XvJKpcTTIQym5t/zwoKDH7XSTcdARftqVLVag7WclhfhLJjwztWZbr7nD0SxB4mrgp+DtKDVrtgcMDDJ+diU2HCkQRxsbqbAU7Gm+rtcZ/l8apU7RqC1ffLFOBlYA6EHvD296vODzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=vlFtRgCdNk4AIf22Oix+Owftyedloo+kPTo4K2DEQG5Zl4hpbhCvg3ymyGeAFxq8e2mOyQK33Ab/8YMwBJS3/GZGlWLLAKMNZPaEQdIq4TeQTY+k0gDLbmafRpKmHYA68MBADxdfV8zBmqhMDURT99qPmKpXgXZYuuZh5sslDZTFirusH8ejjWNEzdXutO9TJEjZHlSL84Hnta5j+aIXUlXJAxIZ6olQFrIxBk2vUWBLx5Db04F2s55mSycFup4gXunMnEnt9snBkNUPdKMn7vOAO7hPvA9ro1hBrCs3gvfQlVfMVxrBUNwYwYGl9xDySx3ZF5CMAqcNd3fFSmOrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=EV0ESt/MEx+4ltyeU7Qmzim7h0F+io1oThU6ddMe44XXyZqoOZVCayXPXOvvSd0+/9Swz9B+5c4v3fGVETV+WF2YWoC/E4nEWDcjDUBgjxE8Wpfa6kphcI3vU8OixiwQpr8atflna5ERmG4/yL8jrRuFnAB+CrNKa8Helh3r6TY=
Received: from SA1P222CA0074.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::20)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Mon, 8 Jun 2026 22:40:54 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::26) by SA1P222CA0074.outlook.office365.com
 (2603:10b6:806:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 22:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 22:40:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 17:40:54 -0500
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:33:12 -0700
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>
Subject: [PATCH v3 1/6] pds_core: add support for quiet devcmd failures
Date: Mon, 8 Jun 2026 22:32:51 +0000
Message-ID: <20260608223256.12357-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608223256.12357-1-nikhil.rao@amd.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: b4530b6c-8231-44c3-2a35-08dec5af004a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bYjZ3jkT7S+pky1C/lKrAaZpMkkZUFzAdHSwLfPbQl9L6cu4b7FKrHWmzBsRV89FNzpeIYu6FU1mb0+gtKvEUIqyg2cQ7R1DlecAEUKHJp3gYpFvJhLehfumNNNjjzp97WZ74Q0wHZvF1haESz+C6KLdNM8F5z4iyJC7xBJmLwN0vQNu43fke6H+fpahqQENsJGHiA6eB+PqFTwH0kMEA+t8/R539BekDXnPNlZ+vZvlJidBYea2IxNia7zqvObikgUReelRzYFSExUSK8rKw/o8B0xfD/sUNkJzQi5NPqEQ+Jx3hXUXp5ySxwJmOpbPXXKI+Hi1V9705N/gPL3PdW3K57x+avDhOJ6BBVskMCBLryxwDot3cDYzOt/QPrsic574/gUoxo0boEsk+nxMD3SyHqOdLMkeN85g1DmgzSqTXj2rk0BUgDzWViduFKff2KqCkxIaSG0C8NArof7FJ1qBbSujy1f/0Xyi1kydhbESC6G7pEQSFmZBBmQjMHeefWKhSvEybgJCdqjpElx3u6rToDMVYL+7yYdD5LtRIQjV67YSJ1VhHGBrI0POU3NWQrc50yZS/QnbsYuz4lwhuLjukBe4c8RiwaFJyeszwjxa56OldVqpHdVCWbUIudqKfLirKcsG0YLRysvjZmP5PqCmHOMh+MjLFaBSGqne1cmL0YUWK4Y3CKl9kdNp9iKF5PnYMFNSf1AmhLgl//o3UJMhkgn6/SSz3cdr3N3j3Kg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X59k5IkHlt1BlVDie4nSTYK1Myl0QkfE2E1pa4CAToPaux5oo0QSE32K6kVXPx/i+E1A2VrCNDEW3FJAagSUX9nN/d8lSG3kFeXAi+MaITUfoXNaJrE0qP0ZTp9Pi4zvHNjtidGWgk4dKp1vdOYdNsYfqEzerRnJrlNXCXBQQxO77/u8J1DIKGLGmVDxZebOINUEJoOilcW8SgzHxI5YnPXLCU5Y2NvL9FOZFceIHRwlQddP0QjDN6k1vPsXmjAXXISUUNS+7HaiGebHOVETdPNo/uSWzVxAf11310X0+/RWD+iJ+orOL7GeCa+8thM3qLFPh/Q1HgbkDl46WR3QVLWU+euKxqyNiTT8ag4YPNOzkfGx7FBmyv8EnQYac/T8qWJeFWV2LSttfsGbv+NoVi6jlZcTYRJmbaA1n51glrQAjc1j987UoOxV1SpzeFqR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:40:54.7338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4530b6c-8231-44c3-2a35-08dec5af004a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118

From: Brett Creeley <brett.creeley@amd.com>

Currently there aren't any use-cases that require special handling
on whether or not to print devcmd failures. Specifically
non-generic failures, i.e. not supported failures. Add support to
allow these messages to be suppressed. This will be used when
adding support to negotiate PDS_CORE_IDENTITY_VERSION_2.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index bded6b33289c..dd9989cfe6b3 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -126,7 +126,8 @@ static const char *pdsc_devcmd_str(int opcode)
 	}
 }
 
-static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
+static int __pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds,
+			      const bool do_msg)
 {
 	struct device *dev = pdsc->dev;
 	unsigned long start_time;
@@ -179,7 +180,7 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 
 	status = pdsc_devcmd_status(pdsc);
 	err = pdsc_err_to_errno(status);
-	if (err && err != -EAGAIN)
+	if (do_msg && err && err != -EAGAIN)
 		dev_err(dev, "DEVCMD %d %s failed, status=%d err %d %pe\n",
 			opcode, pdsc_devcmd_str(opcode), status, err,
 			ERR_PTR(err));
@@ -187,8 +188,9 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 	return err;
 }
 
-int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
-		       union pds_core_dev_comp *comp, int max_seconds)
+static int __pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+				union pds_core_dev_comp *comp, int max_seconds,
+				const bool do_msg)
 {
 	int err;
 
@@ -197,7 +199,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 
 	memcpy_toio(&pdsc->cmd_regs->cmd, cmd, sizeof(*cmd));
 	pdsc_devcmd_dbell(pdsc);
-	err = pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds);
+	err = __pdsc_devcmd_wait(pdsc, cmd->opcode, max_seconds, do_msg);
 
 	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
@@ -207,6 +209,12 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	return err;
 }
 
+int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
+		       union pds_core_dev_comp *comp, int max_seconds)
+{
+	return __pdsc_devcmd_locked(pdsc, cmd, comp, max_seconds, true);
+}
+
 int pdsc_devcmd(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 		union pds_core_dev_comp *comp, int max_seconds)
 {
-- 
2.43.0

