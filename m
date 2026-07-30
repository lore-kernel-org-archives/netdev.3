Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11E367294
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385557; cv=fail; b=U4bsWKUCI8sc/3oUUj9/9KF4aBzhvnay+xDmz1/c5EetiHEIc9smQf71FMRa4l3zlWX5C+LcVfwdvrbqVwjQ5pv2z79zx3JbvRI1TDQHz2nNqO3fc54ESOefW6Fq6zEBPsNUUKWdBn+Z5DcPvGd5RrfRJljs6iI/OXaIs7ELYAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385557; c=relaxed/simple;
	bh=guFpHg1GbPV8TsgGx/u2pKGg9+vP5ImX7ZjIvo3rNiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z/sJRCEcfE7mEB8b8rakL7di85qP5MNXUwH/sjWZcsbetUWS8RobrYIIq/vLqvovWgNdvp2T6Ioboe5Bbiw0qzlGdqeV/N1hs5LPSJeXQ0YdKzDR1O5XS0PKpi4mK1EVrfJII+9fyf5wJTHfpiTOLmgKcL2JiChbPI4Ym0y1l0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qwYOvj8v; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qwYOvj8v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUkyPrcc8RuJkfAlN2lmViEfzIK5YJQqRt6KVV+Q9sh10x1j6o+5M5NE0+9gQQSAHvZjZScN9gA4hc0EhAhiYkB25DVQZ1GeHaSk2ozma3QJCFmosm72TjYhb/dod5pXkoJIWmkPZw0Rap64Snyla8pUbyfv7Ei7/6oA0Fhwe3zxXDOsMeXmct50zZU74iUE0P34RnpErVg18o8HYeiTwQUya54xnNVqpPBfab8U7JNbjUFWFbXIzVKct2n+30b8K5SsOh3ecXV9Ujwk+73rtyTKj+dRr2S7BQ1CFgfrvbUrKAogMsOj/1YbqH4p6gEDlxl1OmortHTUFnecXBDBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAyWVBDYfLR246USWY7ntzN5LazpiNAkWZV/4PFab9Y=;
 b=qRt+g1MqyhNBAJEPSAYCL4HlP3tRUUiEn6zhAqrKGf/l/28B02E6TdvdvPiUdzzfSQstb5llRg5M8C5oPU4bOwBDwZ1s6B7k631mWuuRkB7+RgW7yZ5KdxvrolU/upJT+77ybg2sggGeiwcxJJYSlkElJzJ1cUEUncdyk6QgqsQPDwgPBKZjcfi941kicR082eG0G4YwwQGPdPAmkXKbDW0AiC1hIMoTLS7mfLskXsHAjlzMIiCanEEzIX9S8xTHaB6YD2lp5kGHKLfE9WY9apB7Z3zCfr6WiLKJLdXMOSh0MLxCxtpXBd/fMcy+PTk5ns54jk5H75YOT9rQppbldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAyWVBDYfLR246USWY7ntzN5LazpiNAkWZV/4PFab9Y=;
 b=qwYOvj8vFJj174XlXjYGiLi/B7NlyeKbayE3SHnLUNEyV3gmWh9Y0MjK9I9ukMs8Gn8XZc2i+Y47rDuRTce4wv7YMR/kqjcyysVtek+EG+04Hl0Iz7Xfw2AXusVHiq4wMA2vRBQUlR91ywUGosxJ/6VhRXraoDfhG7n4D15WAUM=
Received: from SJ0PR13CA0085.namprd13.prod.outlook.com (2603:10b6:a03:2c4::30)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 04:25:50 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d5) by SJ0PR13CA0085.outlook.office365.com
 (2603:10b6:a03:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Thu,
 30 Jul 2026 04:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 04:25:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 23:25:48 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Thu, 30 Jul 2026 04:25:18 +0000
Subject: [PATCH net-next v12 1/6] pds_core: add support for quiet devcmd
 failures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260730-upstream_v8-v12-1-136cd174ee85@amd.com>
References: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
In-Reply-To: <20260730-upstream_v8-v12-0-136cd174ee85@amd.com>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Brett Creeley <brett.creeley@amd.com>,
	Eric Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e06164-06dc-4638-bace-08deedf2a2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5yaxYVXDzTfX775oheuQAqNG/HZZ5ZQtnA1GcoXFvJbD5j9RGUN2k0XGdNHAahUDopL5+ZwrQK5nAqm2yzqcRo33Py1RZwharhtqhYPQ8OfjAMVgKuOsxqMqHNNIP2Dez532/slbGzmc0khtH/nl90dZihOYrAyd6oASHIJFn8VO3YXY+zj8rSzHyVJBwPMJugzLNbKVfwi4qSVIyF9V8ljgvBDQ2l9uXWNPJRjPzD0kI4Ak1+Fph8aYlObBmJsFJLOyi8yptGxwxuwBnYQ0oK1w7PAthQiDvow7jqSz7GDh2gexGP5ZhHusWIMY2bWk/YPwpkJjaCXD8ZY8yNxMP4Ak4csWm8TYIquVieT4mdWfLLDk2UZpAnV+r1OK01RVtCnm+kYo9gqN0gmMlqZk6inmAwaxxDhap2KRhLM51cGvjxTXuTxFXGeRhtvwUlc3FwhsF2H0OQPnYrOSqLEbfHpm/gnK0Mmm5WulRY+Z3Zz2RamCC9Wi9iigfMYr8Em09ruBgmw6BjNYJWvgSabUoNS32FuRBPGVgChhWrNT5sXJ/fzZWe6Q0p20C2jlv9qjz9AcOA+6CVzPqqO76uwzsLjlvRSgExCV6r6cSG5YNW8yW1omsyriOPBjs9+M7naMhMjIGz4BYWPlJjakP3z4ASXKZ3yU2Jb0BcDDLQJ094x79dOQmbvyr7DgYG9IOMnURWNAPFi0PNG8Haw+1rGdew==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HcYURX08/Kjx9UhdPbkhfB/8srMyWlNLrTYluo6GMJvWLX/UFMj5vyvgP1zU9e1+XZWH53jSMs1iTfLw8dME18ngSIxnDiyTyLDL4JqbrqjOuxFSpvDcU/xpKJmDFV6u3xy4E4YvvzUktLSNIxNl+3IxXSXcv/AOat0ztG4F0invc2Wv+xdPOf5V0Qu8haUr2zIAJoAlAFO3nPzjNYW8PnU5GiRQ8SprdfhNg+lEVxdxOQeYv8uGxI6+ZJeRdtVGqvF0Sc/OB+kNtNaw+X2/DV0Psw+eXd2uiZrdSK8k1I7QMCx5PmpO5Q9/AVsuSThJC4d3ywoCS+XfoVGU3Jx6l4KnXUpcv7IsjjvUI0bgVByHJM7n3dCEOLe9ZIXoQxZcg+XN+JhYURhnMtsdqPxlwUKqn7YYJ4R2UcbtK70cHmHF7IHhZGR5qJUz8ZLYE123
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:25:50.1682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e06164-06dc-4638-bace-08deedf2a2d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277

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

