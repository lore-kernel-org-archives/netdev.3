Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383EC1DED42
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184411; cv=fail; b=L5YoF30fV++PNtty3/XdwXd4P0CwiuOhtzDqIpYlzcxnyrwHerEgjIHoaf+aSD108qnEm/7Xt5E5xpDrN698kn9FhgozJB/XlWfRW0FuT40CKrugySbhJfDPZZMGow8eL5ZfrzmDM0ObS0oq7DV/XqFiqwW8Ppr5oGBTRSkqF+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184411; c=relaxed/simple;
	bh=xvPcbVw0lfX5Fu/WjVbQNQ1OFCFKvkj0m0ZU8g78KUE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jx3p957A93ZEBbHDb8w/esfjTLq6VddhSPrXcPEXTWd5KpPfidcdpotTgaj8iwXFMfHEKNbo2STcUMhU05fVSzx1mfTfZhy81Dksw0XRv5sRHN77r9HEFO6sLkYybvzUVMK3fT/LDlvlKFkN5CZ0C3kYxXwRBPXR6U1eAEjzwsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aq43ki1Y; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aq43ki1Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7ql5+xjKXJRJ42fYXc9DDG2Qn7Q9xVwQlDfVqRbz9DPFmV+xamkwKqNyJ44E/s6PDEYBPwJjjzEkFdAzGpYNFcCoJ9EvLui5ay2SEqVZW7UfWup8y/kGrOIZRfOTFQx0h6HY688JY7KM2nP151H2ndS3LerNqXxHa7JqK/68ioM6mZv9RAm4H5KzvMLO4wc778zyZcyHfXBnUC0Y6eNBmo7nGyae3CtZ4jmwNZfDA1KoW3sPik0jTK8TsDTK24Bym40jIs1gvCs3Av+5I+lgoCdShTqfLSO1wr8pXE0k2Kw5bFWv3xtzUCc73ygkr557r5++tYIeGBVFwML6R5/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ISK2lAwXwKvp4Jl6FIxRVqrmJE40ctT6OxZD+Xu1TU0=;
 b=B3dpMfTfBWeaJTJGl9ZbnI5D4idyJDhklz4iB/4Tb6o6N9WaJWX55S5GeOrPgaWglwr0q/xA0xhX0Y5wFJHmvy+C+I7KOwqYAU2VgU/dP82hEoXeufiMeX54xdMBfB9bnzm8Fw+eSURNQwCPhpOgfejU3Vu1QwRDSRXCuhVFeHsipSYzK193+r6lowZAcNwFerJYvjzI4lrbtMlRf2bWdYcJKBG8hz2rqAgkZdlekHcK8PKwlqxkBzRn2XOqx8VAhTRmZMux0xfSNkTG8a1Drgzz2K0OVZ3u1gcnGCQj/CXiaVNTISE24ex5RhR+fIsCTOEm/fjfh2eRAOwrGZGopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISK2lAwXwKvp4Jl6FIxRVqrmJE40ctT6OxZD+Xu1TU0=;
 b=Aq43ki1YvRWP278JqvC/Gsjsgbu00trhVgLL3eHfShDY1zWO+wD+SvB40L8dKtJs/P8csiTuAs3R3sO4N0iNYKqMGRsR9K7JF4b8HKLOw8rmczlMgBJvmdN+rRBbGF1WDFqFKhxuzfEGjtPvlRcNd/KESVHS1kuLHOorrm83bMSe2wdwUf0gHNgq86O83Ragq3nXm8ctBcc+9Le8YxOTXwhs6YEieJxlaFsWeFpfFxdgg2okPwf0yrTH9a0/hpGWRaqiQrkItuUgwk5Cmhq6zTXTI0ThCT3J4Yi77ZwQekjSaSJgan1wyJ4+joTjl/O+sTBCDH1QtGL0MsP8WXs3SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:46:46 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:46:44 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 0/8] cmis: Miscellaneous fixes
Date: Thu, 16 Jul 2026 09:45:24 +0300
Message-ID: <20260716064532.1522382-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d3fc8a-175e-4a55-3280-08dee3060023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YTjxnl20BtoSHGRsIlPR1qoKgHenwyL9a0fJh2B+B+sF2qgJ1UYJz3y6JBuUYGcNuQuQswNuYio2W5ILUbbh6VltWVVvsQcVPaqolpYqF12T5zxgk1A+GZg5qZm3k1rNSNzXzhOr5W0CFOw6N0F5azVYREIcf14V0TShX/OyCYX8nN7OhrldIiMrTjn3dCW8Q/BCMiLbWErVYcfcdKFAwL8Ky8iUPou1SZvEE1wlo8z0iQajmBVjM9Dn0d+DgMU4IrZxBLeCtSGPm/TBjtKonTG+VUT0RjPatKydbN2Ir55B9hAyS5ek5QIWl77PS0tEQ9Ytr1VCuCo8q0u2QlPzZzGpoHKHwACJDS1olCnnSYvSxNc5wbDhUhXMC2pVyDQmbPB0YcBUXvD8PsPyrEnhWRyuAI5d3le79sffdjb4Ytio8DAVy0bR6LC6Gk6e2BArE8saXip4spVrBJRKFXIthCjhK6ViPQ++F6z4fb3ieHlUtHu7SwkmkKpvwDo0Qpnxle0kgfQNp3rOSMgZWpivS7mr0+qY0aDJU36dJR53qz29ntmTVKraCyJooQlqOc9jq1saH+sZSFiCvMmuKlPhA9IRo8Wy/1HGKhmhWoiL5kDlvLl0M+c3KpCMOpJVPB2/ZlBhS7c0XBRNl4Ssm4TtSrif9areSz5cf1MFOh8eANs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLfWlqx3GVhO9SQZec9MYQAfQvRU7rp/Q0x+4fKZQGTfdtY+SzEXiXhG1E3+?=
 =?us-ascii?Q?vGUuFRuzuEXPVH1vzdAagj8oFLmsr2s3Y9Bo08zn2KwyOOsE22ESBM6FLE4X?=
 =?us-ascii?Q?GLPuWoXcyKGLmvNz8Dinx3yyZTf2JzIl72GNI7VNeNW2Fnl4SSGkkPgrgMan?=
 =?us-ascii?Q?7G9QW0+h9VmBoCePRLHKr3/OsXkHSC7Qv5e9Y/kyMyXDMFmvNEjCkbVeb8rL?=
 =?us-ascii?Q?8ipfgfzUTEq1Ps/FdNMDZYdMU/CgP1k2J8W3o83gdkXI8Dm+ubtZWCU0qVkg?=
 =?us-ascii?Q?ZJPEVvo2PGKvpPe90cvCsZCSm2HTvYIHxItdgjumYU0WHTDvoZiCz7o0kPAj?=
 =?us-ascii?Q?eXGzW6rbWPx/fmOGlskXi5uicHl06eXTqt/kPZOavIHnAu7BCyDgFpRf95WF?=
 =?us-ascii?Q?7WBz3be/6aG92HHtlhLryAlKHCXWFqROZ7G5bIwKLO7P6p+m5B8pw1smjChz?=
 =?us-ascii?Q?6e3m3k5DtDMQQt6FKmkUmBPmGqwGRpFKa8uqCFPa8gtiAXXugcnN7V2eGcf9?=
 =?us-ascii?Q?JZd/Z2oYy4jEgexQfmd15HAUhgcKMs0pk8/tNG7r3MsKZIuguyGGsnSj4/Ys?=
 =?us-ascii?Q?+MNqWfkbZYZ84Vo012E/+x0G5uw3XyGUb+YQxJIb7zsMBId952I+Di3CKiQt?=
 =?us-ascii?Q?yNedJmb8KPrBECiqOPY5C9wCBbMqjWpdB1/80vI5FWd+oHsNhwQI0MZSKHt3?=
 =?us-ascii?Q?nAHplz8fHbLeTHJDWvI65cAjKLq5hjeI1ffwyz++KtCl+jQZl8FyPiqIu88j?=
 =?us-ascii?Q?ArkeY/dfUJW6XYP3/HWpPd5iu+bsWePvQbD2uqAcJFXlFC6yazdwO+mq1mCI?=
 =?us-ascii?Q?uuzMxD+ZfmUWoaPOpYYCc3b3O22lG/70SKDJKX3zPvInrbg9bKRN1rWQqt8P?=
 =?us-ascii?Q?wDT3LS1/MwAHQ4Jme3RL6ULVCtsgRZa7QAzbRoOP76VlZyhv+Y+i2MHcBy6A?=
 =?us-ascii?Q?QR9bIyNKJvmw2UXVNOOg9G8YIsRe27J42drOOsBfiZhMiG2SK67r9ttFts9n?=
 =?us-ascii?Q?Ss3mQHWePQv4SjUB+/BGLUPEVn4B2gJv1SGZ0+pDigJNLVjz/nrh6N3sOUXm?=
 =?us-ascii?Q?zE6jzpgqH/zfymUCenJNlhIo1AfgX4xPHkAIBfY93RJSLpEiQXi9nzSCoMP8?=
 =?us-ascii?Q?9vfZkpTBkbS2pN/R+7Flt8ncBE5YDJBwi6MmbgyJQZXoHmbWr3tRyk4uluf+?=
 =?us-ascii?Q?9J/HMnoFAgOKoDJ9OkDPW2yF3zTilCLq33O73kItssOBCo0FDbz331Bk4vn7?=
 =?us-ascii?Q?jR8zcPQaUqkeC6+GmF3EXvwIZ+PlP8D9O4+RRXJn9br6b1vYEE80IHEzo7X6?=
 =?us-ascii?Q?zsot5ObC6S1SbFmI1M8g7f8JbWx7ITmli8kY2FCWrHi7R+QmPDqe54Y1+Whf?=
 =?us-ascii?Q?xWEAc9HJPTZP0YSDp2KG7YHU6dsLvuvj/XqHtDvpyFXCFSsw78DzeeQ7q2/R?=
 =?us-ascii?Q?K12j88wRrelnDtiBB1Wl3LNc6y6KyG2cAAbGiPEv2ru7Jj81kE9h7kxhOzt7?=
 =?us-ascii?Q?aG5uU562QDMgmecQh5rpPzpyCJ2wPQr14MVk4u6LRRAFo8J7Ey+Aqlb6LPmp?=
 =?us-ascii?Q?DwOQSVH5ULre8vUGt6M1ONu4B5nBIYLHTYt3Pl+3eE9YscrvD21DDkQA910p?=
 =?us-ascii?Q?TceEEmEL7jZ7u8yYp8JERUzT7vOpd5kNoMyvrNWqQAAcYSp65poOj18WmEg8?=
 =?us-ascii?Q?4VXRUqk2XYdxiRkoyWc00kHJbkPb8X4Iu8Lo1iZjfskwY/NQqJ/sjZlzRddY?=
 =?us-ascii?Q?UKyaUlLXKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d3fc8a-175e-4a55-3280-08dee3060023
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:46:44.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cD4gE/McWYHLqcOlCK3P39svzNa5HS4uu9inqr/0GL++Y97vjXQxK3/LtuLZWp67cnKClDmRYnEq8+5LjRWAUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

Patch #1 fixes an issue reported by a user. The rest fix valid issues
pointed out by Claude Code after I asked it to validate the CMIS parser
against the CMIS specification.

Note that these are not regressions (never worked).

Ido Schimmel (8):
  cmis: Fix printing of Tx bias current
  cmis: Fix printing of channel-level flags
  cmis: Fix printing of CDB EPL pages
  module-common: Fix printing of transmitter technology for CMIS
    transceivers
  module-common: Avoid undefined behavior with CMIS transceivers
  module-common: Add missing CMIS transmitter technologies
  cmis: Fix printing of attenuation and wavelength
  cmis: Fix printing of link length

 cmis.c          | 65 +++++++++++++++++++++++++++++++---------------
 cmis.h          |  1 +
 module-common.c | 68 +++++++++++++++++++++++++++----------------------
 module-common.h | 57 +++++++++++++++--------------------------
 qsfp.c          |  5 ++--
 sff-common.h    |  4 +--
 6 files changed, 108 insertions(+), 92 deletions(-)

-- 
2.55.0

