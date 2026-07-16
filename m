Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC72F290B
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784184467; cv=fail; b=GD91TtZF43kjFbisADYBJkw9DnmvHNsOnKpL2u3+0egwkbetgn5KmuM0tc1k9U2ZUfzUX/RjLoszBTRpmjFdnAvbiDQcZ84r6imcy+MG/CA+5S9NfcAQR3WEr0cSF5YB/eNPvIpCTAwkItj9qve4aznM8vn17ctep8/F66Qa9+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784184467; c=relaxed/simple;
	bh=zQR2PTrUNLdRpM3rKQXkg9JBFwlLgxB/BifN1LknKU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHMteK0d0kwIuIr+xYqwxFQvA3Z3tIedP6ROdrvPwfMG3i8J4B0pfupSa9gO0Z+TrFjK0PaELcXn7+ZMPbdHVPZl8gdh623z6guVMwSW1UA9TLrHKI0RUpVAPiImcuiJozLmv2xtYJCU+ZcvefYP9836mz+UZ8r9FpArUI6QOlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XefXocv2; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XefXocv2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc4DyZKtDQgQm11OboKaWCclkU0nYchQT+NLh5SV0SxrkOlcEEu3cCnUJmpDTLlgDj9K6vIdc+q0Lv9k7jdhxvzHNycUrhfuRzhkBezVT5uSkbZV/PyilbNxV38PkGBr3EY/FwhJzKA7Ucl12x1M096+9TkXLzXfceqI67sCNU/BCvqiFk9A37FHV2XvTIUJ14AgfAeOEn3bf6r3StfRABXb647Gg3KUKKSJBTkta1AMBGmtx9N2ZZ0Ry7NQD4GQHCX4LveawqIh9r/hZvQpmn8QDSPxLVPq0zrJJeCaabv8rf8SDWHQsT02u2HBNmJGOf9mMbl6O5Pgs8Zfy0W5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bMGryHPpw1HH2+P+ENHoAf99LE5ZW1VlPzg8/G7ejE=;
 b=IKPz02Ly+QG4BorjmYy/9V1UwGzoGXgpLASzfqaazCa2Xlw4TX6GNpD0UTpUeS5bOycGen3bUvdUQz8SxHK1W6EROcjUeiW5dXmMz3gnwt2HwF8G8o/F+9wqRB6mHGUh6Fw2icsIUihobWfvnZpExxaCV4WqtYodm/1bFLb5OgZDkmTxHS+23GJM6ySkbzPTKJ2gparc6DjQKi+KT5mbkh7fuj7T+sR8diukjKwrmhzTWFbcBZKoDgodaXW+6MIq+lple7FAxnNNsGTvNgzPZlBePSsOVuZTvRu1L3k627CGRmZl3h3VEuWnjGrA39o04BMgNFK+i5ozl2y8UNiIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bMGryHPpw1HH2+P+ENHoAf99LE5ZW1VlPzg8/G7ejE=;
 b=XefXocv2xak+fGqQs1b7qSQzvZqJS1c6KHPbjJ26ZTFNRuOBUeV4iR+M9phH3OP4x5AjR0wUH/CRZ4o+jL9vQRC4LzLxsv3RcnEtjzDpgq2SeHHhcJGy2oYcBaJhEr71CrCxQHy6DHcA/tTCA7bczcS1dt/HDnMYXYbEHODzyhukKWiiL+q8B/DWNF5TH/jw7oPJePg5cePAYt9FBqzBywT+Vqykkx6xZdPdtbO8be5bCRS6zMQHhfm2TnFk6Od7OAGuMFTLxj4wQFdONJXPYo3kydvXCM70G6Cus+1Dj2u03wS73P1MHUsEv4gZQhm1k5b9v4uQYBE64BdsXPHplg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH1PPF5A8F51299.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 06:47:43 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 06:47:43 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz,
	danieller@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH ethtool 5/8] module-common: Avoid undefined behavior with CMIS transceivers
Date: Thu, 16 Jul 2026 09:45:29 +0300
Message-ID: <20260716064532.1522382-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716064532.1522382-1-idosch@nvidia.com>
References: <20260716064532.1522382-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH1PPF5A8F51299:EE_
X-MS-Office365-Filtering-Correlation-Id: 870cbff7-d113-4e66-a234-08dee30622fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GEbTxhS0DZmcfetUwQx1XVmYIwBAKgtXL1YhLDycn6tqw3y2ldFqD/PVJeYlnDcp9afNIiqYAwREaTY0QPfpZrLjYywJEZ8PbujOI+NoTXdv0LdM0/yHv4J9FX5/4zV/V6rVehQXPm7XLrpw2FfEF1z/X+JJ9LawBhJd1VTszcMNMpoDClkkCZ8sIH4xNlyx5016K5owznF4C9NxvdkaEkg6jl6VDE9ENxfQK/m2pWWPNRkHwrtrr0ZCC5S8qr7wGn6tt1IOEJT802E74LoTu4pLi/nKgYkPGR0UrAugOx4uTtS7/a9+UUZ9lVhvBP+i7tT6dIJHzRjO8jhoeSbGOL40Bjjft3GIJli330O0LFvuszaTCeouIACSxwAhgIlELRxv9iGYyaybT4sBMi2u/eDQmSn4qLYsHVuBGZ/tw0/S/HJsUadMbFtn1dfIFvgbO4zqe2S0QoIDi1tmlJvrWYUMZ5lauutn9Dwg+PyW4NlqyRw+O46hMKlgPZt57H/cbj5/QfJgv9da9zcXTL2i4lvReJZjX2g7JWeFSR6e327aBDPUsX+PK6Dnmqu9/rZVT951W+N57pI5yWgtUIIU7BAcz4MO+qiwu/WXLRWIJ230zsUD4x2GDQhUELeuKp3nJqCwG265gMSXUr1jCeVfpAqT8VU/OHSentjoDM3zTA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?neydCmXD0SVstwdx2J4KH8+zXbtL04NQklkNJa9fw0fT3hndke2FMkkkj8Ox?=
 =?us-ascii?Q?RKFPsue+vlCglAShyxqe43XiHD8nW44CwoUquq4vEjYpO9VqibPDlDaF/aLu?=
 =?us-ascii?Q?t+VMzx99KVXwL+sWszFy3ErfCMF+rYD3kn2lZTRIaX6sozk3UH8rccJ/Hfbp?=
 =?us-ascii?Q?BuPIXjYPY1VePLbpOn5J3jeO20HQTbWMmkfJ1EpQzED2gXdvB1I5ywqKYXLp?=
 =?us-ascii?Q?6yJMKL6z7taltq6S16qfo6LHgzQAwBoomVu4wUeYLD/0Ikv6Fa1Lf6kOA0mf?=
 =?us-ascii?Q?/AncRIViIizDUHi/29w7wQq3h1VarwtnHagGau5X5f9DG6Qdy+QmpbRRLz/4?=
 =?us-ascii?Q?qUxTxVO4C+hC/7NijwM8aq6+xikJPuiFJ9PfjL03H6KXSF0QAR0/t5EOZS1C?=
 =?us-ascii?Q?Wgb2dg/+fxVS+IBOmv5ioty+beDyouVkXWVIhHXP8Zqx2O+5gRF4KB2qgtsi?=
 =?us-ascii?Q?k5aPJiWWyheMB+Np62BpVrwiB/2QGjnCFj8wni99Z6RDpxX4hm2nZA8cw7U1?=
 =?us-ascii?Q?Vk7b6OteN0QAl5tpEstGV/VJFjSjSgtFIlYNa9K4yQnqHanMUWLs4Yh2vxgO?=
 =?us-ascii?Q?Oz1Fmcv8JnxjPqjIJ1DBZlOFZ8rRdmeEvbOTpfGI2nlX2jKycKHzjFrzH/ro?=
 =?us-ascii?Q?t2XvhiGjPqvTTBh5QaU9RhkixY0qlsoGlsDbpo+k8blo0riT7FGF5ETV4sS0?=
 =?us-ascii?Q?swakwDDWCxJGMPTnRVffHr2RmCgKVRzxuQ46K6d7Zpw64H1q8NtxTrye3aQW?=
 =?us-ascii?Q?aRxgIr9B1xXj0yK7QrxmRRLSeTxr5MFtAXVDIuFFM341zIPkQBbgSBPLuBhE?=
 =?us-ascii?Q?vozADqdaX5HteLw7/QVoXkroZzVnXg4tefHFl8Ba4Bxfv469IXnAeagaOm+f?=
 =?us-ascii?Q?6vAsgGCoGuAeV3qCRW+rWm89oQHrzdtMmFNG7Ycg5sULDewZHNWyOfORIHis?=
 =?us-ascii?Q?53c4fj+FxVSYxwh5dbRdWmE9t783jD2k4lSfuW3sAzOp6Ghs4U8N1fhxTmTo?=
 =?us-ascii?Q?iKtb05nQKZfbHRky4cBc8kmwRdN6XJbGXD+Py2Se0vDfq+qooK18vzaFwVgc?=
 =?us-ascii?Q?bzdqfVHUd3ocfytie703/d1K8FGROOyxkcnahrQQK18P69z/YHngxMDGPb/h?=
 =?us-ascii?Q?UWS5O1NPT3SRvkSWtydGdGigrDVUFjO32FYliasmJGvUNvTBms4HZ9mY9ntp?=
 =?us-ascii?Q?eMm17iJgSIdT8xuGq3JXqqfdqc4Su1aWV7JffTFSNQGzcQEl0XfTEltutQlc?=
 =?us-ascii?Q?YHYnf34vJYVtKF7fbBAednne2p1+y4Rhynm9huNdRsIP7SOyY/+eOTcsePUL?=
 =?us-ascii?Q?yg2QF49NTzifKaZhFMM4qwejhzaJGMa8KpWnbH58WFxucPTvmw9D5sZywwFG?=
 =?us-ascii?Q?ZNdv4Pc9cIyufImKXYT087GeOqPIv89Is00+MSRweU5Zv85k4ST4g9T2PCjw?=
 =?us-ascii?Q?qInz3MkYsr7JLeTveejvEYMDiRqZWAFD79XHksd85UZfEN/K1i1/HlxeetEK?=
 =?us-ascii?Q?B5KCnEHXsWQi9N40kEfaztyYJanDtnGIhtq5rr/IpKdS85WpBC9lFeDWnkB4?=
 =?us-ascii?Q?dgovSHcTgKf7Fu7jOs9j8UhHWBbneCl0AtaDFurIABlOZoz3VdM42epqfYcG?=
 =?us-ascii?Q?0BPLwcZzcStmLEgvmES52dqP1oMmzQHx8KOIKfEkkOgdEI55LMQK7y6+QHko?=
 =?us-ascii?Q?LRUlSC/irtYARLWGx/w75U2BXFKKcLp0U+IGrI/ubX+WNbEyGlZvHIOebK8x?=
 =?us-ascii?Q?hQ89m36cBA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870cbff7-d113-4e66-a234-08dee30622fa
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 06:47:43.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dq9nm3WpXL9jByjjqY7qvwAytf2NQRYfPgM1xmZwZ/RWkPvL8e5tj4p7LBiBw05GdPW6y+vc+558Qim+xY2aTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5A8F51299

While the function that handles the printing of the transmitter
technology handles all the values passed by the SFF-8636 parser (0-15),
it does not handle all the values that can be passed by the CMIS parser
where this field is 8-bits.

Fix by adding a default case that will initialize "description" to
"Reserved or unknown".

Fixes: 88ca347ef35a ("Add QSFP-DD support")
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 module-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/module-common.c b/module-common.c
index 997dd2b37ce7..ea4514ab3899 100644
--- a/module-common.c
+++ b/module-common.c
@@ -628,6 +628,9 @@ void module_show_mit_compliance(u16 value)
 		snprintf(description, SFF_MAX_DESC_LEN, "%s linear active equalizers",
 			 cc);
 		break;
+	default:
+		strncpy(description, "Reserved or unknown", SFF_MAX_DESC_LEN);
+		break;
 	}
 
 	sff_print_any_hex_field("Transmitter technology",
-- 
2.55.0

