Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA28623892
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418691; cv=fail; b=anEOcV9vwJnGoLKGcgFs17VWbycP2mETqkgRywznovf1qyTKh+effAh7W9GubxAu26+YMLsbWVwFxT0Ji6FcLCVriWyyVif/4AdT7vZdxs9sZ59+hp+BUTOSjNjj71iFv48sm2k+Ibwh5NCfODCoZ8HLFyeSb8/YHdEbs8BrYtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418691; c=relaxed/simple;
	bh=PD3IADFviKefdqYEKtt766ZeoTegsrsCEakKDA3zcVY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iCIzHcDwHu2EbhqJm3v4kEbDDumWudy35LTbFcDtEGsvezT4r4wBp3A1ZwdhaV5QRkWoLOyCr+w5qZBnDiEItvJtQAAZ51O66bWDkr/6Gb0DVZimi9vujHjTeDdix9YBn5WLPueg//yelrNwVzdnL8CVIA/fqcTn1BKndAOsNT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rPQwLTky; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rPQwLTky"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+K0PniZ9HYzEVhyZcs8vtb5G037ECCAvSFjMaD+dcQxjKWSH29DLSGi8hi+lhBotK/ssl/KTZBDI1c4woXbeKvNspsRc+M++jYonwpE28JN8l5LP6efF4fDETPTOobSleciMgb28ZyAsl0ZWQ7uHwZVGjzh+24bp22PeA11/Ajki0+uU9WHN5UegzU/YzJ1cy/0ceXVbddsLT14vgvXXLV3Of09IntyzuR5lqSCxfVuP9rq/vCZDhrvLqOk4ohH23pJlwHMnNRrS3OUr2V+M1ZR0V5mu8MBW2xAXRbkpc/MiIjUXH0RfHkUHr1mcDDgdKyKJQix3JxeAKdKspH3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npJXoQDJgplu3IUwSvhUs/mZVK8EBvl4s/WaLiYgHmM=;
 b=N9acZIzyqEFN9/FRlL5rllbnCrC8xD2Ppx/QkQR90t7ggB8Dk4cp5M7vJ9uV95prjbVf7hKAjA/m3SDJu+7RcBFEV4ZPIl+a1hMIxDfMdTA+oWQqfcGicIFqLzLnfbwZqxFisdSoA4d0VfIz0l/A0N7nc/kz+IV21A+I5YlLpT0XY7YWhUPe20uj4H8F0DIDsQJU2x6VBO2KOVhaxKcTEmh3av7zyiM5lqyrwJRT0eiBFEBnS0ObNNMNGz/xH0fgmxhk1c1lq/9+P4vSr4nRVLsD4imdt7OXDzOtKuw6PVyOMpDbbdCwjhAKN6DEZJA4MtY6j5P9eLPm5Qa0av+row==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npJXoQDJgplu3IUwSvhUs/mZVK8EBvl4s/WaLiYgHmM=;
 b=rPQwLTkytW6+BbROXbDM4jJRW5m9aJLYWglewwF2EZVi8qGgKsft7Rdcs0Vz3MVrrMksoODonJN/Y6XipDbYplczzpYipI3EdBz2GEbg+bIxnUIYdBH8G/aYs9HNJA7hC8DTnFWW3Zo0kEWSlREgk6ntuqX6MW13gGQBNutKAdpcshj1UXf/gR9ceyQXiiPufo59vmBiD5DZqnMiUJ+RiPZIF2TQMVpOOd+wfOFxJaYdBXJ0b56L2C5iLbrOketyzn4E8JtvpZwI8r/ZQssFlid3F1XxgKByYsnnF9neitfISQ3fjuguB+0LiiXVqYDpQ0ih6DOgLQCrFv9KQAQ2cQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV9PR12MB9758.namprd12.prod.outlook.com (2603:10b6:408:2bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:04:46 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:04:45 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 0/2] ipv6: Fix suspicious RCU usage in route hardware flags notification
Date: Mon, 19 Oct 2026 17:03:35 +0300
Message-ID: <20261019140337.2886875-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV9PR12MB9758:EE_
X-MS-Office365-Filtering-Correlation-Id: 08634c8a-7381-43c5-b799-08df2de9ee43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	GK+wfYltNOfxCyg8xFzXLLHush5VgDzYAprnjnULKf6Tezs5Imv/7L/SJAeJM0SVWPwyiMba7FJ4E8cnbrjvSjGNLryKqKgbpVqCgvCvZ0DFxBeW+wiM34JhGrXXc5DILCSKarEhZwCXyf7LtyJIQH1L1p/8JodrO1OYoKS6n87GTV8BEEG+UyikH5JLySQBR70e9aZm2WoUzalKLrfbjN6gHYZATs49g+T6Jif0RMPqODeDB3C40HK71j7oNG8yvInp8Rc5Z5FsT5Ci/2/3dtjlTgzcon7UWMOZzavlVXld0AfhlXunr7lOuQrfEH6wSQxNGTqixiIZZ320IeQs/cGjRloCQNNWi2FfZsp0Adl+vTxyqiAnMz5hIJu/AQvEW+i/oKTwt4kuFKGPYFNlQrzS7828VAh+05nCcp6pwvOlHlhDaAqeu9sYb76Gon73I7uC+1oaXh1AKCh/2XG9KxA/OoGuD2W7E1lDa5zB2BR5xUh0kcZVllw3Ul0V806ZDhFL9xQteaVdk85O6VRCucnC6RlQLRELnkmKnH/zPVw8y9lRK/8nQ+Hh6Esf/IWfeFZID3/1HLwFyA20e8s7MMytGwQcjo505HviXyycnfn+IKua2KkZXYkEti8kIchI7rkbNUyH6Q8teww9FjhrV0oHi81hY5Lwao+pz/adXOU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YA2+rGRzQVySzLlQpSPNbAZLs402PN6DUE+5f2um6Ia8PVuXjo/riU7dABf?=
 =?us-ascii?Q?qgIamS8iKr6vRYow3eaTo7q5vIXCFUgUg/kRmd/CLoetMlSd3cD5VM70UQh3?=
 =?us-ascii?Q?iGe76zTiFLrrMGtme5htOMGbSviGpXZdqhvlYSyX7DweDxcOwvqmKMdiaMcG?=
 =?us-ascii?Q?o7ze31Kls/eY3FR3HdYV+enwklREc2EhG1XG2XRcxPJghhj9FWJq72ohSItD?=
 =?us-ascii?Q?wujl2b6325JCPMXI7Z5vGHSBUbZ8/WlN/qOfDCKJyapkD8yX4cvxR7vUg0di?=
 =?us-ascii?Q?L8neWX3UDu+uFtIKHRdVkH72255hzEnbjhyPsD9GehRObE3l9ZsJLfVA1O9n?=
 =?us-ascii?Q?yIhNWLM9Nte4MsTm5KVXz2iMI/KDFTiVZVW2gDwbT+aUpw1QAhDQKr9CokWY?=
 =?us-ascii?Q?194JgAhLJ825DgQy46QTa0H/t2+VWclb3DMDalyye6RHKHyBF/xrwnqS83rk?=
 =?us-ascii?Q?k3Dklavz5i2Vi2E7GKNH9gMeyr0OFT5IvGMYvGk8DudvyzLb5s/G+GX+p/C1?=
 =?us-ascii?Q?nbmfYaMBrCiJ/M3MI3Dpi3PROgxy8nAAzcC701lHtQuIyvn4Atg4e2cPQ4MF?=
 =?us-ascii?Q?rnMoM/jQynekA0OHgqUqOB4GGxw33FXWQwLN8o0mF5C6BhUPQ6esfePpSCiB?=
 =?us-ascii?Q?3wGOqZnutKIFXxkHEd9ApDhS+XguV/krYggTs0cAKmvdDyLiiufpKGvANPNO?=
 =?us-ascii?Q?avWXIgzEY6RZ5IWpxTcKROQI4Ykh+tPOuZeYI48Hav9vDssrBLSYW91Q1Vs9?=
 =?us-ascii?Q?No36AQ4a2gHaJ4TJXaBPylIyt88ZjHsLc0UwUD9fvLaK0bW/rgjXHTRjRdLc?=
 =?us-ascii?Q?A0GW0GcNdncsE0q+cOv2jLfh2PmADM5+J4LvGGdjJWoRhJhA0zgguyzEnCaT?=
 =?us-ascii?Q?0mtSEV0qREQar3ECCcCEd7T22pMp7LzMh1ffyuFI/HbnSgWaYUF2Va0pjkCD?=
 =?us-ascii?Q?cv0Z43BD/ZAg5EWhqFFjgE4w5I0K5Nb4LhkHBpjbNGGduAg38wFP5OctAiMh?=
 =?us-ascii?Q?MzlGFtnKT3Hu0rvVDqhIbhHQp/K0f8Kzs915JhrX+JXEPu72diKc2xH4L7Jr?=
 =?us-ascii?Q?44xQYubGm+sl80v7eq6zMFIpBzQtQ9LKreeiMuS6h5YUhIWnAP/KR94FO9rw?=
 =?us-ascii?Q?ISEFNvuS+o5iTNffYQr5DOxm5J2sGFr3Yszap844HCvnwgVYTaMf08N6dveX?=
 =?us-ascii?Q?hXKzq5OwPl8G0pdjZN2vuaO68+QuAcpsO/Oq0hpUxSCzCbMTs5FY6raDRjWE?=
 =?us-ascii?Q?F/INtH2M3rF8ldP4qGr7RDWQkHrbjwkiDykDNMIyCUbK6qX3ZMLQONenhbet?=
 =?us-ascii?Q?eWSNSkhfTTGG5VBKYmtBPyhu1LwazcMd/yMPKdkTkUTnbia1zv0QuI0I9BGg?=
 =?us-ascii?Q?sPn2fMtjwdYXGjcSNyz8ts/a//fbK8ZGxq1J5JjMcV3lcpYozXWk44t1Xql7?=
 =?us-ascii?Q?nI5trsAqkgwSYPK94ruEdFc98LJU6/PNhLq0eHBcvA1lFzOXFDdXwHZgNyGQ?=
 =?us-ascii?Q?8+bV22CMPfSlTLSSr0jE0zmKX09YUK/65kmZALnrMQZ0ihDk0CxwFKC1/sVd?=
 =?us-ascii?Q?wYEOlSB6xvPW40UvaHMejVKssDJFTL+fmxjaFYxaTxl/zDy+BILGHvnIF8gP?=
 =?us-ascii?Q?RZEBK0y5lSUAe+7GJ+1qIkrT51SULBD25ndu8jsPViTNhJIj2HRKHX7Vx72w?=
 =?us-ascii?Q?kBfvLlHZ/EbKL6EWclMMdKGBF+XCNF9mCjJv01IopKvn8XIW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08634c8a-7381-43c5-b799-08df2de9ee43
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:04:45.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tniwqsi3apAOViU+BiOROufZfCnenT0iDjkKzvVbSdlzNOp2E1vZteBTgJmpSQ8eHD/nwObD99n5/uaLAAm6mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9758

fib6_info_hw_flags_set() is called by drivers to update the hardware
flags of an IPv6 route and to emit a notification when
fib_notify_on_flag_change is set. Drivers call it from process context
without RTNL or RCU, so when the route uses a nexthop object, building
the notification triggers suspicious RCU usage splats.

Patch #1 fixes the problem by holding RCU while building the
notification.

Patch #2 adds IPv4 and IPv6 test cases for routes that use nexthop
objects. Without patch #1, the IPv6 one triggers the splats.

Ido Schimmel (2):
  ipv6: Hold RCU when emitting route hardware flags notification
  selftests: netdevsim: Add FIB notification tests for nexthop objects

 net/ipv6/route.c                              |  7 +-
 .../net/netdevsim/fib_notifications.sh        | 66 +++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

-- 
2.56.0

