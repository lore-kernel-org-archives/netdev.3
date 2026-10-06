Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D7466B04
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296564; cv=fail; b=YGG/pEiBmCgXlB+5gRMrT2vbS1Q65gCoRWxfpEmCzNusrewzQQsLeJrX/ecylZH1kwDkuZC0W6/RU3p0u7PcmpdLT3uDB4YgfwVDJdgRTm9ou9txklV/ppDAQqf0KcFAH4b7FJh3Yfloj+T93fv8jlm8OjJSnEpXwCVB1JsHIrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296564; c=relaxed/simple;
	bh=K8og1GXsEiWf660ndqy/WkXZ6wrThAVWrYKrDHOVGlc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfoC1oD55VYiBBYuQPvAAe9LXugE4WrYN2CbgWfFnaemR2hTShU/ht7cBWmKUJgrAEN2YZxsbnBjO6VizSH5ymxAqhe56w8LGc/w9fAb42RS+C0NSyjwK+gQ9ev+IgrmlRcGZivfJ7JIDiOuvlubKkam3oznd7R0aT0CCPMTwL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OfYA0/Zh; arc=fail smtp.client-ip=52.101.56.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OfYA0/Zh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8rZJV59l4PdAlo7Bqh2Mh45W7/axFl83mTUD32/esaHJBCSDynu/pULX42J0mvjb3bGxqR3OuV0auzyqseEp7GpbjSBEMJ/+zQZ3hM8ueHxBMcRTGra1zeClw5uMBqh+piZRW7Kzz+mvQ1qZDjZiblD59odhG4Sx7fiT+di+cvOOLTlkzWcbuEudwAkbp9XCjrFsxuoiu/kDRyRkxcaBTSlW1IFnDF8bS4+65ufGtyf8iaUVD9auVviLVsinzoFfhhBUT5zeU/JcrNHu54+zWPbMBBv7unEUBrAZU1bdPhhMTCsq41Arqrtz/rN1gnYKq7wRdqekB/m1huIY88SiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvM7BnDgHsrdXjrBjr//JPnDuoixbT3we+VMYESAhow=;
 b=kH7dZYVG0DLKDThU5+4N4fKzylY6zgiM2DiyK8ayS+iBU4r5CnS8slapPhoNtyDaGCoF+I0hu+7pkSCQ21Wxz7nooiWdb0uAfSq74wf3PYUm5gpOXmm7Qe6n3dKan3/CADfHH8NZt2jjnyQsttRyzLBv4qbk7v1xdZ2VrjkvUZ8MjlO3C96UhlVUPozDrbbclKi4rb18W8UQ9yOc2vw5vZenu1JSALwSzjyocx2FWSzFef/qjTVOpIZKf4T+wWHWFgKKphopbZe0rO75wuflF32Ej5kGbukIfd2Y51Y8hDS+JNuk1sV5UF4X0J8/5Y5tpxnEDTyPqV5rSdOtABl7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvM7BnDgHsrdXjrBjr//JPnDuoixbT3we+VMYESAhow=;
 b=OfYA0/ZhesZ1MqpeuRtlmDDDH9KAa2Vqbkxpd6EQxqbCKsZx5RpvY9ki3EEF3WpWryHDRMvMuWe8scNLFGMm3Vzkzf+tRtxUMYZkvmWG2ubIaynlGkykk5g5ritqia8/NMbNCTk3iZsZ0TXepfzAEqdlmXc0YSjzWCVevmOd/hIc1XBShh9ol/+Jny3pPA6TXBGOb5wt6M82ebzrpuwRDDu69mxHwY3ugr/otsMmFniDoTw71S2ce7anMwThameDm5LDuxF1czgMGx0fcpQvwqGhWDKM5FUMBRD9tIKFkChW9jmXAIZCt0+0H0rwiB1hmFe1II9YE/ddS9hXzPQSOg==
Received: from PH1PEPF000132FB.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2c)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 14:22:32 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2a01:111:f403:f90f::6) by PH1PEPF000132FB.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 6
 Oct 2026 14:22:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 14:22:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 07:21:58 -0700
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:21:54 -0700
From: Petr Machata <petrm@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Wentao
 Liang" <vulab@iscas.ac.cn>, <mlxsw@nvidia.com>
Subject: [PATCH net 1/2] mlxsw: spectrum_flower: Fix port range register leak in tmplt_create()
Date: Tue, 6 Oct 2026 16:21:28 +0200
Message-ID: <95339cf970ce78e1a74aa86ffcc104ecf7c7762c.1791294384.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791294384.git.petrm@nvidia.com>
References: <cover.1791294384.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: e68d5457-8bfa-4b31-e253-08df23b541d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gHMbBBheU1U89opZphfT9Mp3pLPtWHQVc9/Fgcte2p02EVsWTWrtL3MkXIctEAYdjmrH6rxPZBN1T/6h817Si9ZHXOhOuAUWXNURNmaCIc4eRMqF8gKwPqjistcKHjfYm5T6uzQyL3GlmlowtoXa4okW8uz35gxamG/VQR9JAK2AuGV8ROYH3G7Q1FCIsya6kEKTPKNz0xitJv51Umx9Re+gINNnehOfrZ01ipmFinPAvJLPrRAVOSsDup8C6soplMkCmm4UGk3BqP0LLNCwecaXPBrN65NOLkbga6GDdd7FIULBPvMEf1waBo9XryqRv6+IHQCVrepcZnaLubGl0KCMSOaxW0w3wMesb/A1980ZjiJmZWxbkfvz9jUZkiZmZ044MJ0uTSkIIk1XRSe05JRt/3bJixk2Y6N8ZP8WpB54Hna07nqPfmtdJin+Ns5K/DbcSQ9KrgA/DMrI4U5pb4uRwcZjpp6IvulwABx0rXv69XUO5MUiFQhl/sOEgOnlFYvTqAd71/YSO22sTfuQWHOqALiAUKfTvu/t9fcBiD5CrwBObH9jrRYhncNm53BD3jnA0yhm4b0aiPJSG1kOk8AYb7uAlQGTIgQqk2G8bLSUqpTWznAQoJ7xphQXJL7VlP0/iECKZQ2kKllhDMpREkOF3Vk3oj/ySXXcCd1F611mEFNKjcXBQrjNMYZBigFTKbZPdzQ2OAdyIeskHnd8Yw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tH+A3C6EPrL/yWRkLbhz5HYZyqadymp0V1OLS2kU7Qz46m73apRAZo0LGG6cEGyiA4kf7ycDWJ6twCXhm2Kgy6jl3Cu7fQSED/kOTopUH7VXsYDrRPaib7C1nn60UEQG18H/yWyGJxv0h2LDwFm7wYYJkNSZqE86NX42VPZ17dm+DC2t30kfVAhaAj4EuNkuqVo/ScHPqC1FJvmCNQsK5ru68V7sbcQbFpb6MVBljwZ7mSx/vXuC2K9R+H76V8MpGYV8nAUx+FO96oCPME4I1/CJktbjeoPa9f55ElqrBv3KhxSEnW7uZwAb7dGC9FR+VWo7rdfDk9yOdNMRbp4te67JiQX5FF6Z3Zwt9mLgBXrK+L3klyZ5wt8k/pyvg0TB4ol8lug+3JJmLMSDF6jNVDpubSP9wOLsThSTMr9Ggjmgg7mPiY9Xco95ijhPUUzd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:22:30.8973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68d5457-8bfa-4b31-e253-08df23b541d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014

mlxsw_sp_flower_tmplt_create() parses a flow_cls_offload template
into a stack-local struct mlxsw_sp_acl_rule_info purely to compute
rulei.values.elusage. Parsing can acquire port range registers via
mlxsw_sp_flower_parse_ports_range(), but since this rulei never goes
through mlxsw_sp_acl_rulei_destroy(), those registers were never
released, including through chain template deletion.

Factor out of mlxsw_sp_acl_rulei_destroy() the code to actually
release the necessary resources and call from
mlxsw_sp_flower_tmplt_create() to plug the leak.

The issue was found during a review of Wentao Liang's patch referenced
below.

Fixes: fe22f7410527 ("mlxsw: spectrum_flower: Add ability to match on port ranges")
Reported-by: Wentao Liang <vulab@iscas.ac.cn>
Closes: https://lore.kernel.org/netdev/20260917113236.2149095-1-vulab@iscas.ac.cn/
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h        |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c    | 10 ++++++++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c |  9 +++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index b03ff9e044f9..10af08ce72ef 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -989,6 +989,8 @@ void mlxsw_sp_acl_ruleset_prio_get(struct mlxsw_sp_acl_ruleset *ruleset,
 struct mlxsw_sp_acl_rule_info *
 mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
 			  struct mlxsw_afa_block *afa_block);
+void mlxsw_sp_acl_rulei_free(struct mlxsw_sp *mlxsw_sp,
+			     const struct mlxsw_sp_acl_rule_info *rulei);
 void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
 				struct mlxsw_sp_acl_rule_info *rulei);
 int mlxsw_sp_acl_rulei_commit(struct mlxsw_sp_acl_rule_info *rulei);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index cb232accb296..f7be4f3a1518 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -340,8 +340,8 @@ mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
 	return ERR_PTR(err);
 }
 
-void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
-				struct mlxsw_sp_acl_rule_info *rulei)
+void mlxsw_sp_acl_rulei_free(struct mlxsw_sp *mlxsw_sp,
+			     const struct mlxsw_sp_acl_rule_info *rulei)
 {
 	if (rulei->action_created)
 		mlxsw_afa_block_destroy(rulei->act_block);
@@ -351,6 +351,12 @@ void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
 	if (rulei->dst_port_range_reg_valid)
 		mlxsw_sp_port_range_reg_put(mlxsw_sp,
 					    rulei->dst_port_range_reg_index);
+}
+
+void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
+				struct mlxsw_sp_acl_rule_info *rulei)
+{
+	mlxsw_sp_acl_rulei_free(mlxsw_sp, rulei);
 	kfree(rulei);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 353fd9ca89a6..5e4632cb792d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -862,14 +862,19 @@ int mlxsw_sp_flower_tmplt_create(struct mlxsw_sp *mlxsw_sp,
 	memset(&rulei, 0, sizeof(rulei));
 	err = mlxsw_sp_flower_parse(mlxsw_sp, block, &rulei, f);
 	if (err)
-		return err;
+		goto out;
+
 	ruleset = mlxsw_sp_acl_ruleset_get(mlxsw_sp, block,
 					   f->common.chain_index,
 					   MLXSW_SP_ACL_PROFILE_FLOWER,
 					   &rulei.values.elusage);
+	err = PTR_ERR_OR_ZERO(ruleset);
+
+out:
+	mlxsw_sp_acl_rulei_free(mlxsw_sp, &rulei);
 
 	/* keep the reference to the ruleset */
-	return PTR_ERR_OR_ZERO(ruleset);
+	return err;
 }
 
 void mlxsw_sp_flower_tmplt_destroy(struct mlxsw_sp *mlxsw_sp,
-- 
2.55.0

