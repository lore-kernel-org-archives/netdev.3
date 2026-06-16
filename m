Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012030.outbound.protection.outlook.com [40.93.195.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82043B71B0
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608059; cv=fail; b=X/yE/PfYW+iPtOjS+W6cWnPVmmeMN2FJXb8Ur+KYoFW1JuT+AXgb079Bv5QxSbQGE4aSPHWRGh5xhktfcKhANE5W0FNbJjWsBF/ALsU85S7i9XzxjJNY0YXw4cwWti8LEMQUaFuZXrdRQ6G/MbKb0k+5WU1ugSvGTjsO3Jiv4Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608059; c=relaxed/simple;
	bh=5hxmVP8pTcvMhcs4Q1e+EYgAZFk8sSmAoEdRKaUtH34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Blo8lyGutAz8F91qqQc9uVsow2jw47vG9Jtll8ypWusvkPzSTAeZNfgN/TSak2Ai5TXKz0S1ZqEd2dcKk4RgmV2VoWcBG3LuxHWuErAXcyAAZfoHjr9iVJomkVscVjL8zNrdBBlHsKGlFhF56EgPPj/Ky9JxUPLheXA2o4FjxW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KKg2dutS; arc=fail smtp.client-ip=40.93.195.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KKg2dutS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCp77xFRj5yPpfwygc1cllwYSDpOLr7ESEp7f6QeMLAk2Mb0zpssUQJvFw/Yxi9+Ce0komcd24pkthC7LqfMHes9fucA2PuSS0uCeTNDOENI7iEAxIwha1NXpEhwTeNX7KEgU1dbSKI4pkj/ZKcPFANXJ1fMkoioI515XbeOtw1QD4iDJItcDATug91+pMLUcJ0DZRd/k0zxKYUBGL7MeSh0jX76/XtP5QdS0bv2Kw+X+YJP2JsQl8/EczkZI4pBmt6JBqVRiK21m7I9/9jhNu8pLiXaudxVVvv8ITtp7j6xhXr7osR07Lw0tUmU6aWiQ4avwo3eK98hUl2VeKe6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfEU4fGSA+Ro/ZzG2c84YRpe1Qm7c5wvVRn0Tec1bHw=;
 b=fU2Ent3I8GjndQJEv0hI7v42uRnYQxvvTcTMGu4shkkoUjLw+iz+hhV5SbiTBTxy873d3cTHh8AzUm635UhqpUaieOmD7+oF3XvlAGnoOGNuQOjpeEp2S/4VtRNb7VkCthEjLtXGB1EF/lJQZXKAEtHgpY+2GZitTvmR9ZZCgAsGc5NU+C8dPmM5KqWeFwqcqWel/u+oAema+FMQwNzIyF5zKm4NlEuEmuVN8367oUf0CqzEsbX9svvDOV/Q0yPXxfwP1i24BiTrm5Xjb8kEdJB4UT8stE4iWxX3LT0hr80jXVUKKgtqahnQKwwGlOrKV6qrKTX/H8h3yntqlx+uuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfEU4fGSA+Ro/ZzG2c84YRpe1Qm7c5wvVRn0Tec1bHw=;
 b=KKg2dutSR/TTFFqWi7FpcRKl/Dy3fHi3G3R+GH6IT0+4RKx3ufgGK0X2plbLFlodTIw9DkqY+1ljQxhzKrwNhyLvTEjM0AoHZWWWfYgmlMh21L4GNPRvf6lOJ0LVsT+9wdieSipYj/KIFqxyJaGo977Ld+sp9C9BGfR0aSFP1wwGIEiM5KiRb4iCk1PkRsy2qLbdIxo17LlgsFNukGO85YzB6WXlQm2syqT4bs1yVZUNlbOcWLlJkVtYq81yOakIfwYaV3gIizCBB34+8asRdrdSt+VBXhSueQV0ImIkxyPVT0uvXOOqbxtJCNyqSEIafTn2FV6YvbXE5WjlfV1vQQ==
Received: from BLAPR03CA0043.namprd03.prod.outlook.com (2603:10b6:208:32d::18)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 11:07:32 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::9e) by BLAPR03CA0043.outlook.office365.com
 (2603:10b6:208:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 11:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 11:07:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 04:07:14 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 16 Jun 2026 04:07:11 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michal
 Wilczynski <michal.wilczynski@intel.com>, Carolina Jubran
	<cjubran@nvidia.com>, "Cosmin Ratiu" <cratiu@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 2/2] devlink: Fix parent ref leak on tc-bw failure
Date: Tue, 16 Jun 2026 14:06:33 +0300
Message-ID: <20260616110633.1449432-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616110633.1449432-1-cratiu@nvidia.com>
References: <20260616110633.1449432-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9668f1-ca52-459c-53ab-08decb977653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MNK4iduygcBGDvy3qbemsbSIEPPcI6ohaVmWADhEnnVm5VM0faQwc/QFZjmriKm2R9ESJ+2nbec6HmX1ZNwFqbQwHQuaU41m8G0zCeSCwtmUpdcUpWUurkulTpBEnZqlc0er6Tgz6JmWRGQDZnn1aHynlA9f6f4diwbdZD6TKkYObMaGeh89wZz7UBXmuJeiIUgIsaevJEVZJR59RwsAs5PiLSW4cpcyAITKdCQvFa5l0IBTk3lOdpumNuuYHx31xqOV25p/vTUNjKJLB3W3+KAX1E07ZedAx8va/GvK9JfQKH+9deC9Kj+zRvckrDjJY4OAaLNw9irgE9dnnqcI27PI+6ameY4r534wHb67zpPI7tup+OjYal9BxwnlEnJWXKrYmlM7o9Aa9r36Uo3QFNEs6f5u2ZV+343WgEKSZL7/RtXYMQsTjqsV/M7spKcYmCZJa/QY5yT6Li+/V6ZQcQMhYpv+m8+K86xucdQvdZQHennJyYN3E2Bt/6GRfmCyjZJipBsvz8AFdfrWyjCB9Ha93YzlOWj2vKZvgxd3uOx8IyfBFBOZHrqI3dPknEdOby1kqDTZYM4Q2otsKN2iO0459zD7L6an58H6PzZoce3WIa0tGHNpvrBYBtNs+oxgvlW9rLeqmDTB8snx4FJgYybxg8rYOSLCrCTSY4JOTYE4wFN2E3ekmQ6C1jAkMOla04tQki0U71pEGtfoJ7OjqiSYyH6woiMywgagLl6dTbo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x8GDCzJlyZ9uoZ5FYpFlXYwcw4W793MG7ExmIMJUwxLKmhiPQ0F6jqUla9c5T+6xdeKGx9/xFNCSweKl707PtKswdCOaFnO9XYRGPhtBFkbnptS/njcoUGSWgJ0lTUv4T5zBfHixpRhI1S6sfKZnjwE4BrFO8n+GjPNc7jz0rKo7YYa5QP+aAkz40D1k6EUeCTzh24W1jRBCVlT56DZ3uPOgPQ+u12TtwqxVe6kuScwrRwsylhBrRpg8YM84pZj6ZEPKuC3fKGJyCPdOj5MvfqCNskLc03hI8IPhnu0qUCqe3HRcOIhXFpVD4obauplD0YTZe5KJT3ArCQ/JQmvWB0cAmhuKe8pqShEBFXFb7NSqQRvh3vGTiY7jhgPAIONmnfCk2OOXKJZldssSMee3/g7fCLB4KpCJlCb1iJnPBy6kYEJ5guQaBTu2o/XPhc62
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 11:07:31.7118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9668f1-ca52-459c-53ab-08decb977653
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428

When a node is created via rate-new with tc-bw and a parent node,
devlink_nl_rate_set() executes the sequence of ops. It bails out on the
first failure and doesn't rollback anything. For most things that is
fine (setting some numbers), but the parent set can leak if there's
another failure after that.

That is precisely what happens when parent setting isn't the last block
in the function. After the referenced "Fixes" commit, when tc-bw fails
to be set the function bails out after having set the parent and
incremented its refcount.
There are two callers:
- devlink_nl_rate_set_doit() is fine, it just reports the error.
- but devlink_nl_rate_new_doit() frees the newly created node and leaks
  the parent refcnt.

Fix that by reordering the blocks so parent setting is last and adding a
comment explaining this so future modification preserve the ordering
(hopefully).

Fixes: 566e8f108fc7 ("devlink: Extend devlink rate API with traffic classes bandwidth management")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 net/devlink/rate.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 210e26c6cfa0..533d21b028a7 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -486,16 +486,19 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 		devlink_rate->tx_weight = weight;
 	}
 
-	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
-	if (nla_parent) {
-		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
-						      nla_parent);
+	if (attrs[DEVLINK_ATTR_RATE_TC_BWS]) {
+		err = devlink_nl_rate_tc_bw_set(devlink_rate, info);
 		if (err)
 			return err;
 	}
 
-	if (attrs[DEVLINK_ATTR_RATE_TC_BWS]) {
-		err = devlink_nl_rate_tc_bw_set(devlink_rate, info);
+	/* Keep parent setting last because it takes a reference. This function
+	 * has no rollback, so failing after taking the ref would leak it.
+	 */
+	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
+	if (nla_parent) {
+		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
+						      nla_parent);
 		if (err)
 			return err;
 	}
-- 
2.53.0

