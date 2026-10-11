Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EF1C75F9;
	Sun, 11 Oct 2026 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791709696; cv=fail; b=jkZ50Ze1bdCylfuV1MWU20WZt6fH9kG8jycu2dsbtlgCerH47damxet4u5LV1MyN2XV7dxD/u8eu8yFFn2x/pu6cAzBfJaliJdl5L77Yi9Q/6ctEBna8/am3nHg9aewWluUbH8nO9bPO3gcqnohkdKhD/6TwE0kuFtFkOUYrBr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791709696; c=relaxed/simple;
	bh=uo270Z7k7EOwVmdvwX7J9uS1ureBQ+k0DjjGlyzsG64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j45fl8H6uxUjfIPzkygxymebNlBDpfr+RDDze4EqV6xRW5CJPIp63suDK/eQc+hBeEIk6z5ho7xoe6i1ZlzIC4FHDiJ4Uaql8r5cCHjJ1HlLz7b83+E/e2QJeCwVQNHJG2XUUu+PHck9Sr1VxqfliO5vdGJDeDxDcmFrvBN8PFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OVmGC/8b; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OVmGC/8b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8ZrPbvGpydUL7ifykYm43gZ9ndgcVxYVoA4HjeNwOy4RdzgMNff1doWKqefRue6bCJS2F3YDZBcFil7xR5ZOszRvkqTGHk6JqWwPyuwwIGtU8JcWc73iCO+2fz3NXl3QC9P+BVkr0Kcv/uB62LsOHDYcj9IK2uaFKBVkZqvkx4vSSgO560REORFgHstBDrEzTZ7lglMODo72PKNhI5fJvVjGAUhZAy6NEof7wi4h35+nbYnM96i9MALTy10g/J/cg0IZ6wxUYBiKExHd3uJKULmZker4glKHUHEaXMW171n1JdsLyln3wdMjVmT4j9QSKTK+c6kd5C1419BBbfmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBGTXGmYg1CVUezIy9ZQvHZ4zp42xL5mf45NWPzhpOQ=;
 b=xV27GcSieZ+J6cSd3IvLrG60rlgbgsOKaM6UGRodygFfkmV9m4c6RgRRhzIAR8wcY7b0IIlePmDEOpb5+ytaCoS0gxvCrA/Up5FIdxQ10fdCJglVZLhF1fDL1qRvOK3T+lnizgvY0WFgJtaddZpVFAfiCbPA16h9agoUzwN+yStSX4F1kDUBj2Gtg8NGvqzEHsuV8JiRbKE0FaT1KA0qBKiwx1tk63weFFi2xqwjN7Fr5NscEFXCfl59As0u6sGbSyu30XqzYY8gX/rAKmdS5vCp33Sbyjgbm7tlV7C2fh1vpU5mbE5gFHhZ+LsY8n850WWN1FluAXbJMZ+uaLyOFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBGTXGmYg1CVUezIy9ZQvHZ4zp42xL5mf45NWPzhpOQ=;
 b=OVmGC/8bfTsmHNpwW2wl3npVpyhBEtBBlCqneWpCzlEQq3ewRsHwM3zfnCA+l8b6POtFEcbiY9Rf30+cC7/dnXYuIlqWS2/NAzYTUUmB60+WnP6z1n5T6MBzHvHg2AUFQVkUSBDScH5NFTSF74YgKbUok41GaVzqVfdhXDUM83+LKURpksQMcRet45j1bHzg7TrZ9aQSC7PgfBeb6R2ff+s+M3iE8485SzPQnezryIafKbPo1xm0PdURy13HqvC/CrpVSx2T5M6dlDCWXYCuC7mTCYBfP0deV8x2yr7Et87/e+k0KPvO+UX7gw4DZu5WXI2MwJD1l659J6y0gfxAUw==
Received: from CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::23)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Sun, 11 Oct
 2026 09:08:10 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::36) by CH5P221CA0022.outlook.office365.com
 (2603:10b6:610:1f2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun,
 11 Oct 2026 09:08:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sun, 11 Oct 2026 09:08:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 11 Oct
 2026 02:07:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 02:07:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Sun, 11 Oct 2026 02:07:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH net] devlink: Fix accidental merge error in nested devlink docs
Date: Sun, 11 Oct 2026 12:07:39 +0300
Message-ID: <20261011090739.746757-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8ddb06-5d64-44cc-fc05-08df27772bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|11063799006|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AVzkPEGMeL+PVbC7z2NmGIMCyifq+M9vsdYaVFiOTFEGU8a9VNV8LvTQUJWMmiKTw4RmReDB5XCrAs5UmLyVG3orZIjMNZp4akx2DOHQbCel0CzVqeGoGmcptbdYK1YDcH2S7iyX9A39ZktmmEzmKIZsYnVbJZNgSDoYhiuOTJ4YWAGxNr2nZjedT99GdZcKJ6uuplWiMrAZtFHH5FDxZLHGfzb+DhhMMGSX1X/DBbRYcsn5TPfltAnStU2VSKz+5IgYkuqtJ+k27YUPmww0CClT6cTD+ZsEaCOqO8xfZ7E80V/JFycmuJtXHfrI71jdA8ka/iLgipKTTGiOIeJ6do0tI5ze6EgC71cCMqsQ/YAd/ttdQh80yBdNKqyb5GPlRPsGNxZ1DquDPL0lJZptMkG8E9inHRgrknCzjZMXr1W1Tj6cw55iVWivw6XySN1nZWb5OfxGcJixucZvvag2KORE1C3EsgGTRUYvja9uR9v6gPqFb87mz7GXQWsFcC4swsUdLuB3QJ0UCWxO/2Se4JInal9CS6IzzCFqPhbQIonopwM0wfKtNJhQCbyF6/4pO4LNEV2DToZhNolcUMk1tq7bjM4Kill7m3JZbjGBsZsUt+NGQxOnJGBgZfUfTkyba3HqwtX8bzNcaYH7fnAPndz9b3L3svl8V4eawDcmv3rsFX7ILAczaKMyOERas7IengnRQqzQiF0UapzPG05IrA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jdL8JzFJXbK7+kTSJHcL0quznDjmIfMKfW82FFV9Y9f154ZrKH7uhRCW981oJFfupjnAY3hUjTz8hKl6xu5Heb2qP4cuwhwWgXjboCpHLFdZ76kFFbmwLNt3ktjHODj0v5IUcQ8t1zfAgeRibZ2GNx5+rl4FL0elqctR4C8j08jFclyRQJehmIKU8ltWvZOFFDQbNKA9pXKJln/8e5aJOpb8XDOHm4iNfr3ZP3yLjPvSti5VWeJmBx9U2YY0GgDZ1PZScV9luJIomaEZjWXvwabYBtR5qvHS1822U9dcO4g2RUDqQxidHDQl9SholRJnewAgzT19c9OmpLfI8rtRkiugE9SAW/I0rzNbWgsuAMGE1AKhpLcnC9yazob5gZd0L7MxKKidpGnidKqrbajPeajTwIIw5mnetF02BKzTLRHh5LLEfZ4RVNFoyf7mmJHD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 09:08:09.8059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8ddb06-5d64-44cc-fc05-08df27772bce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025

From: Cosmin Ratiu <cratiu@nvidia.com>

The referenced "Fixes" commit accidentally reverted a correction
introduced in commit [1].
Revert that mistake.

[1] commit e504cf18ef47 ("docs: net: fix minor issues with devlink
docs")
Fixes: 3bf4c5970ca8 ("devlink: Update nested instance locking comment")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index d4a83fdcff7f..64e498e4ff16 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -33,8 +33,8 @@ sure to respect following rules:
    lock of both nested and parent instances at the same time, devlink
    instance lock of the nested instance should be taken first, only then
    instance lock of the parent instance could be taken.
- - Driver should use object-specific helpers to setup the
-   nested relationship:
+ - Driver should use object-specific helpers to setup the nested relationship
+   before registering the nested devlink instance:
 
    - ``devl_nested_devlink_set()`` - called to setup devlink -> nested
      devlink relationship (could be used for multiple nested instances).

base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.44.0

