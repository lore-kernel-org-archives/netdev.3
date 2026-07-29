Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33636314D15
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297172; cv=fail; b=lwTJ1pCdTsoEQQbUHwPWwmgteozfIg3/Pj9GAJr7lW0ZSIFZj1oAhUGUgBwKlHEX4zZszY83tyFvWHDt3u8I5iCGJ9JSYv7oiPqlOeS9hPT1hhCb9UcY+W3SGYbnucoC8wBETtthTJ53e6t764uXBeuiNASKPwloI+5VRKQmwmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297172; c=relaxed/simple;
	bh=guFpHg1GbPV8TsgGx/u2pKGg9+vP5ImX7ZjIvo3rNiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MNHE71NXCZeflXkcYbc4ESLEfknzvebjbICBvAUe15qXnMwnzPeKLYrokpBTgBgNY4Cn/P3eIhAeqBSRLj/VchPgH6Ir+HbbLDUzghD8fIyFkUv/DcQBbn1LB0heeTXE+tVgL/zixwpk9tAv/qcUHkp7gxkJWWznB3/q6Db3dzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T1m28fb0; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T1m28fb0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvxXXdwIGUmv7bDELjLM5WuD+AuaNIY91t7pDRTDRUWP/qn+F8OmTJNkmUK+RES66d7J/xveert5rB5pf4xFeLDzov6cm4JQJs4RxeammO+kdggzTzE/eB/EKUdhijvHh1hwYfEx3HKs6tEpFjMUhtzxczbPXO0inNSJZji0xQGeJFbzLNN5FBeOjT4uaP0AWvaYoNDfhxbTTcGrR0o4j/NlOYDTzXoTpQb0CRGmTYb5iu/7WK/yN2rph8GZwsJQxGcz5xxHNnERBlHUKp3BQLDy/MgKRAv8//FKJbGRq0O5TwMSUSBd3upD+PPT/AvJX1gKuxuVpslST7jR9mtZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAyWVBDYfLR246USWY7ntzN5LazpiNAkWZV/4PFab9Y=;
 b=DpCI2uNh+GCrUXUMUkt9CxaX1+d2fLRL/UOjhNebSJXS0v9EWJLmhVT3hXbTkMcDi+0iXYEQLRpG72naN1tZ4n35y9ahBz1EZhgIuYel/KrNGUJmzCea1zFeD6AUHA5silYx02hud16gPa3vW+GK6kAokdFzov74jJBN3F/ZqXn03SjVn6X8zY0vpvO/Wp64EfhpVR2n3tOo1yZi5jbxrfOxGXyhks8ziEm+S5V3XExIdM5EHokEuLmykzdN4S1r0KkwaU6UOVdKrrQq33OvDGepMJVqSpHcEr3kATICk1m6beZbGPfF45ALTYdMPRrHIcw4Wc16Yy7ItLT6mxwc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAyWVBDYfLR246USWY7ntzN5LazpiNAkWZV/4PFab9Y=;
 b=T1m28fb00wLjX2OWLJvRI4hUTuizLJTEZ5k2pcszxG/LA1XlsfZ6sy9lNptQJtoaeGuTSS1Gy/4tjymRaT+QfQwnIqJkO+jQmnvfdW90rPL+XgHLP3GOdXocvgKTTCA3T+m5vssQSB9LoKuCdb8z9QWDriFTwKzii3eViG+udlY=
Received: from CY8PR12CA0043.namprd12.prod.outlook.com (2603:10b6:930:49::25)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 03:52:44 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::2f) by CY8PR12CA0043.outlook.office365.com
 (2603:10b6:930:49::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 03:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 03:52:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 22:52:42 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Wed, 29 Jul 2026 03:51:56 +0000
Subject: [PATCH net-next v11 1/6] pds_core: add support for quiet devcmd
 failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-upstream_v8-v11-1-e4b7d5bb2913@amd.com>
References: <20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com>
In-Reply-To: <20260729-upstream_v8-v11-0-e4b7d5bb2913@amd.com>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: 090f0431-2e15-4ba1-c27c-08deed24d8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	efNpQGPzuOyH2EsD+RQGCnVvzFmX5UTog6XZSn/eOmSobABZ8+GZenORkcztc1WmLzcEDZyQiLynMY5vzR30ouLr6feGSBnwsyWUkXMrpCqR0W/OADARCfFEw9MOYKOha3p18hqQhs+V2ZNRnVaV3lf972uDKGkcUaJf3bvuJ35qiUURBMYKLqp5pz1eESXSW3EKsGAXrjQYt1+xteRa/odA7ud2nkQltUSMf5eJvGcWrgm/y4PeF4KhF1VP7yV3ePon2H1JAH97DLpSm6Bx23tVtO610zIKRKvTqJ8e+VE6h28LxuNdABTW31F6vJhPjZnCqJ48tTj7TECOZW+pHHSxrrmihmTHCcqWnGuLYkI9WjR6dKkaZM4gXLey4HqMs2OEUlkekn7ges2hk+uuZL2TNf6i/6KsLCDXU94stu45O7KaGzzgD0gFSjxL4RIzCG2HWu6lGM1aiF6ug220LPp5s4QoliSRDVsDpb5ZVxaOKggrnxN46hfFZGZd8Glb+U92Xsr35f+sXTvTe9zG9YszW5k6a0SrobwQOd+60dtxoh0iZyDYpAPCDGKnPrVin0InQo0IqBgnDdxsp2KlSaINlDp8uXDkozw0A9r9Vvv9zy8ehMrjyVvx1s7gH3kAYgSLXvGxAGLg88j4kmD3AnRYdDPF3nh0RbuMHyHPOH6OAuK7ZmpMAPgVnLjUzOGXZkn30co+o5ryjMDsN/JkYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qbs2iPkmO6tcJyXGUrWkXzbUvkrnS5U7frmEm7XRJp9CbWfdL2SPLWRg8qTetjxRrU2DO0LIcax7lfiSkygy98wU/B+jZYo6jgSzfAReC1MD8jpbTRYCsn3ma70AVtLnrnHnur2NPaM1JwT+s6+/oyxuFUQqAVIRGfe5n195t3bIEWMlSLfmQKdbJKCwlHKm2HqsBgVm9WbeVtIrVy+5z5iBoZb9o+i4oBPdyi0SaXARThO4iZjpmb0/EskdR+/c1xFJWsAKP1f0rvGoGL3PC4QXZFG3chNrHiQQE1D1JSM2ZigI1aVrGNuf8sAIb662bg/ErLr+9AkDt+eZ+ajOkzQG1A+iW9VeHWxjd9L5fU15YezHhlz2BppnvbyxqIuJrYqeeduEIt0uAIzZCEl5okxhexIUX0EIWPIX2xIKx8jRDwoMIdnJ1JTMWzTUAijT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 03:52:44.6230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090f0431-2e15-4ba1-c27c-08deed24d8eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

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

