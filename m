Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E936C9D9
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422618; cv=fail; b=fGjSmZK2SJUy0M056zzi7KUXyS6bFhqBbbQhxnZdH9oOv891vjApgMAg7fvbgV/pDU9o/5X0NWOmZ6lggzrmgrhYhbvl8ILMegH4ZfsVIsOw2uj3azREVltd5Ejw+XFizFoppvVt+oe4GTKWRN3SQ9GUVC+PMdCjCxtwdeG6OjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422618; c=relaxed/simple;
	bh=16ygLat4+PGolZaUmzw9e2hcBzMpgg49W9hLUL+ZQq0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lpU+2/Xcpd5Q5aeNBHf4kFBj7F3pXNJ/sb49ZM6szOGrEndkE19+sfHJN6HjAxvEBXHhEO2Oe48HntiPCU6bQSKwSamWz6qDgldylbdQKfXqJ9ahUKi3vthO7k/IdARDCbU1lOhtzvYjvhluV9JFHLtsbPJAOGcFu+BD+laosLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cpqx1q3d; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cpqx1q3d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ND4G0oaUbHEADa7rXl0hKQwWAc5jPKqod5UfXluxVZyCqJH1ObDUu5gbR35BBWc6Rec7gOZIUhtncVJlsrhgtVGIkX/3WaTvh/6pjVtIOJtdJyVefP2+rUrSIxldXaaB6UgtvZyE7J/B20lLkeJ5vcelzHGP9wMz3i8m4gLg7qDvax/Aos4WNO7+2i6Tve3liYL0d5fDBvW67X2E+bROuTZ//S73tVBbovJhCUEHdmr7t3sQRvpcHx8LmshP0agyq9jUWUPtkK9+sfqYdrHq6nHphTku++fFcLad4oLsbaLkMw4IcTSBYD+rORDliusq58qWve4MM+3OLh9WTizoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MgotoXit5cJtdW08mLp8LenlGf7KAfybYjxx9EA3gE=;
 b=D+zrp2lJIvW9y8SM1epYB104+OagRFvfCD0vUaI1sprb/FnQ10GV7k+pP/cYlRT085PKTCecvLg48Bf8Z5IghlmlPwiGGQpiZgKbKaUBK4yLEBO3GWbvNHYXl5now7s5/vfUO22ba2XfYkokXW6jilcKfoh2t114A4SwsbaWA0dpFQYpMAQl+LOb/G+c+PMv56UwcUXRqtW8jVuKBR/P3n4chESzIwjWM4S2ST9LKTnX7pl4nelkXOdPIPGyyA+ktaCF79zzjiUE9d0TQL89sS7HY+NL/6lx6x+6pQiV8XrPb7Xb+t8ZfRyDMKlOApSidjmoEwrEBzZAexjgoFHsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MgotoXit5cJtdW08mLp8LenlGf7KAfybYjxx9EA3gE=;
 b=Cpqx1q3dpVsURoEodXj9MivxxkQFIZYRep0slrNUvhFrr2BlYn0rwhJfcqnjYYPRDjafa64RJZgEgoXXj00/6/8itVFFpFxVgqkw4uPCo+65RASCYWtnocXbrhypUB9W6d5lzsSSxnsOOtm/rUbhwOpP03a9rhTGLsEYMpklSm8oW/GZrQ8nQnXAFJgymjVIgXaPsZUkfD6M7LsbaTGlKisBxHSfht9WTMRJbc/z5wBG49NYLvSnpIetplN+5uXVv8w8k07nnwDHHBN03S8QyLs4Bxy0oOJ+wAgWqwKU04mwKuhqHpceItrTbazUI+EB/OKArsdtLhFjfGzuknnagw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:03:32 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:03:32 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	horms@kernel.org,
	kalpan.jani@mpiricsoftware.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] nexthop: Initialize extack in remove_nh_grp_entry()
Date: Thu,  3 Sep 2026 11:02:59 +0300
Message-ID: <20260903080259.10378-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: c0108a75-0ec1-41c9-b8dc-08df0991d8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	E5aWCu7Wr33spA2zkz7VNWicgGJrEljnBK3Yk+KXk/4smSNBLlyP2fWUNi/iDTJJKUfBejV+/9llK97oQhi6ud8P/keUl9Ao9DAh0WomtWPFaJkLMmcei4lc/x2OVN01V+fSR6gpDLPn2277oKtLrOhtDRSPud7aJklEPCDu4zUd3yWJpvqMGbPBc/9ICFMw5xDPMZacxE1W/63yAvmx2B8jHkbgpGdwfIUVgOt0srg27udVr7/rBTWO3Pc0qg0xViv532hCSRXEt0Os+xXxnM/HGj9NtkR+O4Yk82JZIBG1RKJYnKNNT8W2ET5o/xu5jJp+dZOErUqMREdDsZrHGO+NynxN0o8r7DooBD0vYDZs6h/Xa8gL+Sfc+0YqNRa+PGqFPJGZNozEWVClZY6FoDoNS46mnZzVZL6Cc6SsBITd7bsh5W76/1LoT1pPqDgGYOevstMLfXvzv0LLs93KckKzw27MGh5fuf+dqgZD/gBft7IhoP2dNRL6f4KhIT54XWnemZjdUeu/folDg6N7OTDitIGWBIO51N5wwjTlRFm+yGN1duaYez8DA5qJeOL/ScxsdKqWf4yXDJ/a1r0bI107pLlyOjJpyD8e00Cxz2iwc0GH4QZVkBQCjjiU46fhMSDzaV+gf2wpNQtmLERRKm5LFbW36ITkd4TlGxcyuJo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ziKuQmzETjkU63YAl53HqVy+8isWWqfEKaz3aXLrDweevwyd/Zp++kmlqJ1o?=
 =?us-ascii?Q?ExpE2MeK4tsuA6uJ7/1oje476plEWG7hQghIWrpQ0X4rrpkqnwspnxEd287M?=
 =?us-ascii?Q?hDoJpmwCf8Et1SHlb1nJA8Kl+4e2qu/XA9t3mVI4XfYa6bTqCpdPKnpBNfw7?=
 =?us-ascii?Q?23BvK/3Gfd0+u8D6Z0M5jD2F7DFVX0an+TKV5GQ/WzisgtEL0urMQOdYjquY?=
 =?us-ascii?Q?dA938ldVRg3diiyWRxlYS1SaTSMaa36dwTwHhH7IgFcE5nH9kvYViQemBNlq?=
 =?us-ascii?Q?QeSQMWhOM21kWvsLlXDzBFxutMITKGy0ab/CV2YhuWI+FHPDIuDWdnOYhXU9?=
 =?us-ascii?Q?6zvFKlsuzEhi4N/khoce3jPRahoE98HvjlejkixWCmGqs7cVlyuija2qiORy?=
 =?us-ascii?Q?2u/uj8amzmmiJHqzI9vleKWx2Jmajj2dPFVIlk7imfXPTtNv00n7O0oD1sA3?=
 =?us-ascii?Q?eEkoqa4EhskBMGJ0g2VNg7VDNNTm8+J+L8ReyHugT+9RhgUJ+LElctgLz2ax?=
 =?us-ascii?Q?Ms6y0ak8clcWLgJJdYMxuHeUWzpceoyDDmb6vWFyLbyrOcyGAFct6Yez7+py?=
 =?us-ascii?Q?kbTl0VB4eg7qE+USNJyj0TYObH1kGNzqQpc6eJZljBdgBi1N3gAUCuPzYMeT?=
 =?us-ascii?Q?SJ6ycd3yIwSUDOoSuYliQSSmFnRynjxPcyY8khjkzJqDnPjbRonz6Yg0cxWt?=
 =?us-ascii?Q?+3pL12bnFvFQIcQdv0e54WTRTNj2AqnzooqWf4nubqjmf5dICyMyZd3wzKmG?=
 =?us-ascii?Q?xfCdoTdIQ/1V7zKpjwF0TmMhyuJswtTOnE8OCPYAIMQCuTkmEbFgaME36uln?=
 =?us-ascii?Q?S6Sv1IFqwAt6OaxNsNmDCgpZ2nnvpolIEmMPaU33dXpQV8Oopp1mCEwx+xq2?=
 =?us-ascii?Q?8LtVmhqxZguimZAH3Di2HCKG3o6Bule7F2gOG9RB2NAxFoYO/hcql1l4QWvo?=
 =?us-ascii?Q?dxLjCyjbXy/Gbt2Eum5g7fgI1hQFzbsyke8xGUCALsCBJJJyj/4EmtMFv/n1?=
 =?us-ascii?Q?Hjs7NpXp4TPN2QpaQ/8mcTxSeh/4r9d0XOWepV53UViUHmSRJKlC6AIDdJiE?=
 =?us-ascii?Q?cRhfOf/LkXBC8So2MKrr0NoRBY9yEmuitI4ZCBGADZyp6KGG55vYimZKe5H8?=
 =?us-ascii?Q?vyRSN6mnhiKG23qVrOG1Gww+HDvcLl6gNZj/ZzKuVwBnamt8bwBRWj1OM3e7?=
 =?us-ascii?Q?g/6pVEQ5R0UeMX24m3iIgq2qTYPL3hZqsHpHlOlHQJTRRk/6iVNl2Q88vOnL?=
 =?us-ascii?Q?l/mfLYLlVTGspcfwelUFT0v62lBoqF7mjZR2+Gw7O1hn9P8l9K4kPQ/me9sq?=
 =?us-ascii?Q?Rbv8r7aa4QqST9IZZXwGCgCgsmDWs0fG4ioFcM+Izj3U4igRvsqNyVIWmewX?=
 =?us-ascii?Q?PTgP3vnFlJsXDZaHRDonMyUtzdLy64dEd76o+ghurnyv8Lvx0Sg+Zhtm8y3Q?=
 =?us-ascii?Q?Nb6C4/r+X65XLjyJmZFk10zuw/Zj735IWx1NXNc34f2NKe5KUbnUUbAYCnEv?=
 =?us-ascii?Q?scN+zGiq0AJ/lria67DEKsZc8ISDNCGG7OgAO4jtJaeva9lPTla8GDEj+bLO?=
 =?us-ascii?Q?LXPDOUaPD1BCt+jTGI2NK69hvny6FYzG7qAPBktkoBDbtiqXIOlKRnOV/Qzo?=
 =?us-ascii?Q?/YoGwuOZyvjc02qLMZRpx+6yDpRMzjFGX2SMUA4eaJfulsIP3BHSDCMfKfBv?=
 =?us-ascii?Q?JzUMz+xxpwnwYLMNyg/TbSpdB/j+atICq2dWugiYxtr8/oPG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0108a75-0ec1-41c9-b8dc-08df0991d8cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:03:32.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4zhC3vQRUsbBf6A8UusoOBsiSIG7dIri69m9Ke125VW863/HyMU2gwS+VTJBJMfiWMMp0oEd+uHGOQpZj/lpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514

remove_nh_grp_entry() prints the extack message when a listener fails
to replace the reduced nexthop group. However, extack is not
initialized and listeners are not required to set a message when
returning an error. Neither netdevsim nor mlxsw do so when an
allocation fails, resulting in the dereference of an uninitialized
stack pointer.

Fix by zero-initializing extack, as was done in commit 6347c5314cee
("nexthop: initialize extack in nh_res_bucket_migrate()").

Fixes: 833a1065eeb1 ("nexthop: Emit a notification when a nexthop group is reduced")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/nexthop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index a7c2b8dced4e..42e55b5a755e 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2036,7 +2036,7 @@ remove_nh_grp_entry(struct net *net, struct nh_grp_entry *nhge,
 {
 	struct nh_grp_entry *nhges, *new_nhges;
 	struct nexthop *nhp = nhge->nh_parent;
-	struct netlink_ext_ack extack;
+	struct netlink_ext_ack extack = {};
 	struct nexthop *nh = nhge->nh;
 	struct nh_group *nhg, *newg;
 	int i, j, err;
-- 
2.55.0

