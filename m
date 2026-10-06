Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6F46DFF3
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296565; cv=fail; b=pJ7MXLH9y0W6WxYrOFTxIXaUqNBmNscTR02fk0GF7zB7sO5djAK97g0Kx+mkpCO1lJ0JjHhRLHxcuQ025rA2GFKW4T23WzZeANy7jUWqZ+mDb4dCwfDfKGuY5HdE9ZxTs0JpEAOqlUlqkYO2WzaWc6mJFuwGRN7LOX/J5dyZKXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296565; c=relaxed/simple;
	bh=S7MmZI1Xocvbo49hMZJD4vVY/F9TAe+c/hbdbyfcCUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SltoVRAaN+9f0hvS/CRnsVEn45jK4i1Si5YyWrI5H5GsQKoTO+pRDO2fb0+4tEPBeq4eLgTk+YY1havJI7bF4tzuF2t0G/RcwFpP3Lgg+aiwRQJlBemla53oZN35q/Cs/lL5zdLrHsMvbzlrSi2fapk2hbpqXVG8MNztl22eygo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HxD53Z8E; arc=fail smtp.client-ip=40.107.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HxD53Z8E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYCU+C6yhOnThN1elj/pi0waonq7Mgox6zC+VSBwJ6V8qXmz/XYWGtW6gJpJtcpMz0IxEcQpulKB0zsdw4AiyDBAHBjImPMy77YV5ZEdFtWjAQEpDCj+Ro4vSbAyxTXiecCAPEQqy2oCi3U/L/ExK2Khn3qt2OXM6DuUU7hMenefHlN6K/xNWkJIaAvYUkvkH28AixhAiGPYCgCko/3lNnFOIk5ZYpZXEaXmD0b9AEN1wulrvNA7JHVNlfRf0hZuYCLAHGJp8xbuaam03Odsrl5VCsP7lrt0o3rTbzkS2J4P9l261/tfNa2fAGlnJoDIjsM2Wgyv1+3FhS0L3cvj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bA4NQtAIsjAm8R9Pans8cG69uKwz3AWodR9gxUvHPfc=;
 b=QTzKBhiFuNcHJT+Z0kdZbgWYP3otvkacLFmte3WFlKwYNqJBJvf5UekI+jNMlLNCt74yl+jVsUEEUPMp/jsYenADt7MjoHaxlgbqT5s4f1n2N1XzA3r72LdX+X1IUVTuXGTK77+K+9tcUswXOuFnCRU+fCJ4Ps0yADCa2/hMwVHz2R3gcZknnC0Ft1H3Gk2i41ExNblOKOQLQHmVBzGtEtYXKwAMa1dSiCrFWQv0HkwVwAAa6jrPOJINMnKljEzZvNgi8uBokKpoPtH8hZ+pklt57jv89dM5J/4gaWiVB+YJkaPya2vfA74SK8SY7PdOuWMFedsKALQotu+boYYyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA4NQtAIsjAm8R9Pans8cG69uKwz3AWodR9gxUvHPfc=;
 b=HxD53Z8ErEHthjaDYuP6l6etHk6SRza+e1LOT49h1Ic66BxtpznJoG3eBXTjbAG8Lzr8VCdQKqM8flq3zb72gJBdrbIVBJYqWqOanc28zU0zn1SIlZvpjE/lFO6cCatesSuPTyADzeZFUOoHMUwn28B0iMT0YjWd6MO8nBOAhwZsJnCAL+P4Q0Z9JarZtTJxWAyEcA3sUDkThiIKYfEvzM2zU54kzsnsJKa/1nApiZla8S5uREXjmSiLgaEakX/sPKhg9AUVDf7EkHP1mxKR2r74dN+yGOSDo/mXKFX/2HLdTUJyi52eG9gdwY32gEqM0D+Gw1z1IplmpV9RqyBh6w==
Received: from PH1PEPF000132F3.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::38)
 by IA1PR12MB8286.namprd12.prod.outlook.com (2603:10b6:208:3f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 6 Oct
 2026 14:22:37 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2a01:111:f403:f90f::6) by PH1PEPF000132F3.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Tue, 6
 Oct 2026 14:22:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 14:22:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 07:22:04 -0700
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:21:59 -0700
From: Petr Machata <petrm@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Wentao
 Liang" <vulab@iscas.ac.cn>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH net 2/2] selftests: mlxsw: Test port range occupancy on template create
Date: Tue, 6 Oct 2026 16:21:29 +0200
Message-ID: <e7b37b80adb7ac8b0ef20a22d7654a6656c1c545.1791294384.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|IA1PR12MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 35189266-56f3-4de8-45a3-08df23b54520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|11063799006|10067099003|3023799007|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9qvH6C5ZSZQQEZbZCBHaxiVEPSPyxdwjYWrzd9WQ7vYDm1GzfJWettSfEPBLUmw8MaA4jqwqMMtBpKThc14lg6ZYJpziagvtOcWkXul7W+ZPbpot/PGXepOLa7fTMAp9QlgnGvZbutNwKgTHxHdFqSWATgjg2YycUzwaWOele6DaX/YZ2XEWf0wlJvkAoD8TvAZlU4n5mMzRyn52h8zcsk37K31llmgc8ZBvMypYDjwq/RwwnbpQh+I9A/RuXOsEiG56ZVaT75cs0GOCsln+jBl4VdLOhNx9/VC1iJmbSIWw83H+TRD2/yx19hDe4BnmxOevYrw6PxSvPcpBzez5xGzWKbIpGd07lQmE3QUJM5Ht5//ue+4qpDfcMua7CH7w+RWoiUGgOW4Y1/02P1oT6b/TdhUG1WKRuW/0aVyV90Er9ctTF20W9uBEJ9wvnaSrmXsWCHujCZxNla2lQP7Eu2C9lVumgqwuBe8ZmAY2nkCcbGU2j+lLS+WCJmU8iPYarg1SYEuR/IAdtejz/egVy+KMCVm0FSqIMLqO85HhmfjYNJ2yY0f/6+QMUwdjB9i4wUxuY6p1FScfkIBJ4Uf1OFlpjBhNxpzWs/kO5wFIaN6b0Mze5B28P7tgkroIsazty3XCX28SSNqNBonQuZrOFhfs+mbHM6hVhFR2BaOrUz0D5eDA9WJIFw52FfxGOWFxuKTTY5XsplV7sjj1zRUiFw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(11063799006)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	66ipQ2aRTfbchkqfckUMXhY1u1KELw+antLNajVggO39+24eo6tysI22UiI+0ElLjhGfg0JjAYQ3l6iG4h3CKnOje9yGZGXJlwxalbKXZsL8PKlTBlKtP/2KR8Ju+I6kCfCUxaYh2KCsCxFkIeybquwAAqDNFYJijaFdhGmgEizf/yFz5uIfP+sRk/WVE7Dt7u8Y7GeL1l1aWwcgUgE9sUYgcd03bmgPtVIbrcXih6acynGdMadGcEI78OPzqCOI166ih/Ay0d2qjDmuZ413c3A20VON4QMVgBQ6giBJgyKzklBPi8SkH4qCFS0BYtbH/isaI5fanoaoa/PCdzrAE9fztBj4d2JH+z2kQOFYfjeHo/X4jJ7xigI1W2GvmEP8Q3P3+zujrk3fKXXeHjgWcyfvMlvjXP/RqppeQ+Hpw9Uxh3DorQOYn77Vy8N87laj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:22:36.4122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35189266-56f3-4de8-45a3-08df23b54520
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8286

Add a test that creates a tc chain template matching on both source and
destination port ranges and verifies via devlink-resource occupancy that
this does not leak port range registers, neither while the template
exists nor after it is deleted.

Assisted-by: LLM
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/port_range_occ.sh       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh b/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
index b1f0781f6b25..c7eba3f15066 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/port_range_occ.sh
@@ -9,6 +9,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
 
 ALL_TESTS="
 	port_range_occ_test
+	port_range_occ_tmplt_test
 "
 NUM_NETIFS=2
 source $lib_dir/lib.sh
@@ -101,6 +102,31 @@ port_range_occ_test()
 	log_test "port range occupancy"
 }
 
+port_range_occ_tmplt_test()
+{
+	local occ
+
+	RET=0
+	occ=$(port_range_occ_get)
+
+	# Addition of a chain template should not impact occupancy.
+	tc chain add dev "$swp1" ingress chain 1 protocol ip \
+		flower ip_proto udp src_port 501-600 dst_port 701-800
+	check_err $? "Could not add chain template"
+
+	(( occ == $(port_range_occ_get) ))
+	check_err $? "Got occupancy $(port_range_occ_get), expected $occ"
+
+	# And just for completeness sake, neither should deletion.
+	tc chain del dev "$swp1" ingress chain 1
+	check_err $? "Could not delete chain template"
+
+	(( occ == $(port_range_occ_get) ))
+	check_err $? "Got occupancy $(port_range_occ_get), expected $occ"
+
+	log_test "port range occupancy after template create/destroy"
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.55.0

