Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49423F39D3
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545803; cv=fail; b=Fcz2EB3XzkwF49tCG1OtLbu8bTjuVddoLV8wLvTquWWVN+he/5RqcYB7FJm9t4TbNae9glLpkPOA/XMM8Rwy+9DKSzxYPMAe+3M+rW7OwGYvIaax2Kf+/yaoM99Ya48HwQ0tlu29JFWUfqcjyjVjLFzOoJjJujBra05q0iJFSng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545803; c=relaxed/simple;
	bh=IpW58tjuS5VVZuyn/2Akg6AVMlDqt8L2Jkf2HvK7kYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rusKpxp91EnxhdeZxQYmHIXWyB4cugDwh22j9D/pNt/sQfpEiB2CgcATE27DDtiYi5Ok5WDe2JxTYbCjwb2O0qBip0pnslywg4Xdyw3TRprE3Zcig2wCbec1iN253oOdfMz3mrRDfo8gPzylGZ/8zBbMSEbtOFfXFcmYYLHM1cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=StRvYS9o; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="StRvYS9o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylNy955Ddfu3pw9Z4y+lgsilrZLHmbZyUyiQ7sH2GjGUjq8DF9b8Gf2EfbDG62ju79wn9lc+0J/wGVEWDxnVq9SgRMVwM/wI/S6J6ulkBiBMirru8FHOPRUTIB6fxHkr2coGR39Nc+TGaXU+JpYcisfQvgOZfqJGXRtZHycK9NywmYfoifazTb+IHZu3UK17QUomnrgtIDSZWxpIntrtZLTE8ioiroshIGw4wPxBBCGtDNhmnpVIRRp4b5RUu9nz8LuLEgPWdGedhELNv8gyn4zVr0RbafjHGA0PdvQ1Ea+JvbTtEo1zBXwnijnr3gRKeQQF+1QEbrfKcVSR9MKv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=KNn6OOh56DztFwcY1qUzg4YrDz4+SQYW7Kz1hq+pUbgKJScg+hw+P5adRBnO3xSRXPeHZa/r1mjuQoVST5eXOYj8IPXivX82pEjKGPEFvWY2E46K/lxowXxXPPuqevwb3mgX5ye876VeW6jNzVCnW+EvLJacj87dun+VsaGfHBo+6h/7vQk2LoW5j6Z7Mhctwe09G/S6KpPuZWVe5jnHIrh5+kyoYkvkLJ24ySLrjAKK0iXV0ejJA03Jw4PaKSFVapcpiPtPFk0MKb6BbuUnS/ch8W1ON9cnlQzXBenHklpi8USdAhZMI77L2EAHkHBbCGHaQZXy5zJT2ThpiTn6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eitWM4TjPBRnQrhiWBbIsRd8Cp9i+jY6giJQwN7oMxM=;
 b=StRvYS9o2IiC1wC4t9F/xwsR0h4MdNvYT5Hv2j9YJutd0GY3VZRlevuFVjQM3nyzvtQb+Xsfvm0R4yi6aktK5w1QAlPYYdtKG9cFz4uxyMeVWM8/zmzN6N+q2Phg/wd1XscO6RcbbopuIoLWd/SrhCfx37O/JfvwU0yB9MQnbYQ=
Received: from CH0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:610:77::10)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 21:23:16 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::79) by CH0PR04CA0035.outlook.office365.com
 (2603:10b6:610:77::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 21:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 21:23:15 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 16:23:14 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>
Subject: [PATCH 1/6] pds_core: add support for quiet devcmd failures
Date: Wed, 8 Jul 2026 21:22:17 +0000
Message-ID: <20260708212222.296202-2-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708212222.296202-1-nikhil.rao@amd.com>
References: <20260708212222.296202-1-nikhil.rao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: ea74c7dc-e989-459e-a005-08dedd371fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ugv2rdYhVKMErEePrUuBo1WAjhBYlK0Xoyoo3IBuSn1M9KAgr6SV+SmcWHD1IMHkR5kMRc8WaNJAVAyJPh2utl2JjgNLHamnGqEC3NMmYLqCUM1/pX39czxU6FmyChR+vlrRDCJxThwXz3Z9gJhQbp6rDa+FdWW70Y0z5UDP/P1KdeJPS3ULd1IzHwRBLZi8zrl4IZ2tli4ND83lN275ZVvToUo680yjsmuhSiB31uUx+30lTEVlcxvWlKsMST648aVRPyC9DDFt+4FqMEvkh+hwjChjevbfxU8E02XCLwqwiJCrI6hl1/5NR8pLFdGZ3Jh1c1jeTLXQJqXoEyZt8FMJ4LrIEwaHQoYcwpsFfqVEDa2qBYO9pLHlVwp5cgbEbhx6ZprHcYMMjQ+6Xi4HOrE7RhbyRGn2SRbs4NsnNMKgUGKGnhxRU566jD95/cz4hSrX5O7p2txi/9YSrckQ+59oz+QIqoFLKMez5/56h2tavdRJY8mMJEMvulnCdDSAlUGgWr6S7FehIZFzvevs17WOYpqd5ZfUXoVbQHu0TEqM7RizU9hrbT8quVWhQXhdBfx9c/G7tt8ExyPUHeyB1cvJPttsUNjjOWNd6BXFBtwQEICjI2x/xv/LJhqAlqTbjQrMjuQweXbQKUZkdcDEzIHN2gxgpmmutk+pbH1FivxNP8ykTFf3ZLm+iK17yasKR/B1qQaCVDwdCnP7QIKM6Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T1gVnIjyrd8dX6V4+mzpKckfEIidR/djuWf6MW0S/assp5UnXBSCIwvcJ1tpWMksTwOsQZrbQfyH5iuiXIkfWxpNM7rQz+Yiuw5I7UXb2utEKsQfZEnA1/adx25h03dkieYVEVusAOTmv7EM65TJ8yBUoxhneeMSIHp39ujzGSe2Gbz0yZPuFxrDDbFA4cy+g/kpS6YTJPR1B78DsZwdbs6V8eBzGLblFr+akuuZy6sliplsXD+0jKNzuIzhAKky+mG8tOoCs8wtSCc7GLr65Ub+iyCmmJQNJqWtdw9mile6x58nefWqo6pMPn42lFEb4YXx58UV2M0NOHKWUyhncNjLL2JDLfCQl0F+a0zYBeXII4x1BP/kKlx7JAfynn02s77Lvrnpd89jbKX4LuxIw2aY1StU0OtCcnD/p/Ok0KU3FIIn/z31no1UTE3QTHDX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:23:15.6440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea74c7dc-e989-459e-a005-08dedd371fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

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

