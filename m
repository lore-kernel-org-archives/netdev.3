Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012056.outbound.protection.outlook.com [40.107.209.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA787282F18
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296560; cv=fail; b=qDHK/Q8gH886OHckdL3MO6t5kt87+JWaZXzaiEkBrsxPucfKMSl8WLWUmCNC+6rIyUfPrVEtCjovEiNAyOsfj0Ei1GBnYxW4j5RX1IilYmKDpaNGfQnJyqlhcQ3YzxS1ifOLErxDYnHI4YHfmXvAr5svlAb0h/1Ob7DIl9rHuS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296560; c=relaxed/simple;
	bh=z6ILJYB7HRgijOHu7RSv5PnKyGzDZrZrWqeVCnhtjU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gEuln0ElQBWNP9QuzlNli4rT6qCFns/7MVCB1mT+1f0QSM8uPp1XXoTDqCn4hpk2tEUPGHJLZG+g3vc7IxzRQqnVpL985RdcCP8TqzgOTjf/QNi+NkDa8FNqI6clcXSJFClOemCzzQ3kE6P8aKttEXAoqwhjwVTzLbWuTzmpzmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BmbEuxTz; arc=fail smtp.client-ip=40.107.209.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BmbEuxTz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsQUtTlrPan/gevj4Qs7yV0ar0uxxOzYYa9GNQvCFhqQ+GdJuwPo80YNJNou8A528Ok+kXNe/wZr2IR1WGJkNdWDdBNYHOBN78dibPPzMX6SfiaQswqELYasflT+sacRnXkJP1OujzRB7/uWCFPnf77hyz8xqenQtkKu0JbwtpU7lf2gBjSz1oHpPb80opnd0+mMy6SE5md9y8nxZzRbmUzkPjWdv60sNOWzEy2/G4mQPEEWQzt9K5VNRmb3IiZbPYkEppUIGm1tWec7ctpMTSnCKZ6i0WIUI7sVMW/Ncq1rpYqJEQPfBI3wuW0IgSf6KePgcu+WTcn8KXQAXFzesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUd2a7rV7YH4NYzpozePoh0q5J69yfxb+7jRIu4KEhw=;
 b=og9Ek0psRv98tartfBujPLrvOndNOdATIYjiXUb5GtvSatzbRFvR5fINX9CpaI4KKSkQ00Ppi27LPCtepbSYXcDrJyWJ22GuIQn0RVWJrpz837t9yfS2ntHhqpRjy2KEOuS8Wcd7VmolXhOJxQNyDdV+14MCvIa4XL533utFClEPyOLatlmFRJwnf9l2nJ2OBVi95Sx5MZ6n5vjAJI9Akyn5yrDsw/6fIXiXM4dx9ZCr1DAJueDXtnK+sV5tHkKyaAjOXmAn8AN8NPDsaMlrZ3Oye8plpO8ADy8Q7aJnjkO2YEI4r5Aosw3O9cOaDXPI3o/pvdDzRO+LrRmemSe6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUd2a7rV7YH4NYzpozePoh0q5J69yfxb+7jRIu4KEhw=;
 b=BmbEuxTzv+nxjwFyBqT5eFEoZ8BQJjhb3Kj3lLlgYalJ1PgeD++nmuumjOfM7uemONB7c4ptJmZeyoiycXBnH266f74LGyBqGmFYJRJA+AB09UR3PtJmqJiTi6zdWrmti2b28IT4h36G+/0QS96bXzer/QiksRmcHKI+RT3iBGXnBNnfRne0ApGKXLqfq628fqZ0PU/vqsDDIjCBIMopM+TLltgAexd0p9xVjyimS34u7ePyj9hVUC8WbY+uMjgcJgdNyEkhrjfcXcegBUoEj6T2/R8CN0zCArXYSbs6pJWhHKJyIX/9UoyX4Is28JFI6E6EPfxdjxSmwfPYy77RDw==
Received: from PH0PR07CA0096.namprd07.prod.outlook.com (2603:10b6:510:4::11)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 14:22:27 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::44) by PH0PR07CA0096.outlook.office365.com
 (2603:10b6:510:4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 14:22:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 14:22:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 07:21:54 -0700
Received: from tuxedo.docsis.vodafone.cz (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 07:21:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Wentao
 Liang" <vulab@iscas.ac.cn>, <mlxsw@nvidia.com>
Subject: [PATCH net 0/2] mlxsw: Fix port range register leak
Date: Tue, 6 Oct 2026 16:21:27 +0200
Message-ID: <cover.1791294384.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: 401beede-b255-4676-f494-08df23b53f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	T61XiP8V6KNQElBxiiFiBzfjHXraLt453LS8APz9Pc/PqDx2+4zz0HAwWtMsip4OSKHRYGyZO61FXJTcXY6PD8ziBtWh23/cIA0236Bm9UFrW8SxH1Ufr62D1x+F+eXQkWD7pCZSq7N4S3A1OCz4g9gvYfU/WmK8MOvVPE4Mkr1lfEZlhlYQZYrC8StksVLcM8DZOm33lB8NyDTd85odDb97QedFaE7vJu1UtfM7FgPHjFlgPhV0IvgcZXtKmgsLpOU3QzkqDPFeaQZbkL48S/NyF1f6atXnpqOT/PI2k3WEW2DDGORlZqIc6bcIn2d6nhDHLwCbpN4E+mAWTsdqGbdtAHzBuG8A29cNjkzCajj0aUGzPlQKeuzob9qEifUxBBbxaQDPty+ETm+0f/5sKqfxQDwiYJ0JuU0o2rIeDTKcq+aMitqrOPA/UtUJJCE1l9r/ggIoFqDSb568conz6Gk7bvJKcQ/bgQEHCtwRs14NDEbMI+bkbmlLir8dPQ/1/w+YFfaYPwnck1Pjwvug3SiSEqhfTOzLOOV3hja7+F3EQla3gBtxDK42+rFw7a4LBPOMKJKqDyi4LzDJlyYz5QSTMAaq0pN0JLJf/aiX1/xMLNYJDZ87TjVZgDnpRemh4mj7ue6WKaUJu8eXISwO/wwLDkccPN2zabeyODh1gQJJ6CdlXScJ2/KxsD6MpS3ug+coTbAnFoFAxHXvVwLPYA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zR2Ytik44K6oODu+Z4xSqhzTHPebUgjK+Jc3+4fyn/zgH581yaTbYbiUrJDg8jQFH7N8YZFOngTnbaKm4tmDdtRgNhx4J07b8KVPhPw46uieZ/A+5Om4JW2+YWlzTn0Db26MX1zBgpxOZUalWA1/izTlWIrQcnvutBo0wcLzrTPLugWaAxwGwiyfG27HRRz3zTRPHfnfut33sneoUOpocHD7sydYJzyp/0ZOO+zfJm8utUPlcCH8jqWpq8I+QvJx10WJhD+v4GWuFFYwJ5wwuRuBIs7hsFsn5wJj5UQCOTdG/A8FPovTWTdwPIWvFahbRthvD+TuJAifYlmz2lQoz1GGQcK2q52sLbQy4RfPQP7shbPHd1DBjpdvfB1StupND3DcUpV+C54iXU/498/Mh1YSCyAlHNusfdkEJAbqKCaegIBNQPYtI3EZ7Fbf0wVy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 14:22:26.2072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 401beede-b255-4676-f494-08df23b53f09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731

When the mlxsw driver parses a port range template rule, it acquires the
actual port range registers. The parsing is only done to determine the
element usage, so the registers can be deallocated right away, but this is
never done, and the registers are leaked. Plug this leak and add a selftest
that would have caught it.

Petr Machata (2):
  mlxsw: spectrum_flower: Fix port range register leak in tmplt_create()
  selftests: mlxsw: Test port range occupancy on template create

 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 ++
 .../ethernet/mellanox/mlxsw/spectrum_acl.c    | 10 +++++--
 .../ethernet/mellanox/mlxsw/spectrum_flower.c |  9 +++++--
 .../drivers/net/mlxsw/port_range_occ.sh       | 26 +++++++++++++++++++
 4 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.55.0

