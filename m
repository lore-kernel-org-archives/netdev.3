Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18D0552924
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082811; cv=fail; b=iIRyaEjcMbrMsuPbRo6DhykSWKXaK6v22XscpHQCa/yhEnHBwkqzu4Gkvwiyp/js1FHt49wTtvWnetGWDZlK1du3qsPdhFUoYF0baeUyXYam6+qnrz8xxK8a98NR/t2fQomH2QgdgVFnkC82bvH7PHITNfYF1RvMw1Gkqg5eUvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082811; c=relaxed/simple;
	bh=auHGgOZy+kWDVyKxIu7+p0x+ccZpoyNnCgMz5NvLFfE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nLqRmHrDTIAToQdW2zIZVFhRCuDLwVZhaQr2GDtoVzLl6j4bbEWAGNTL9VPCCVTH1IkazjtX2Jkv+Jpd6xy8uUAUYSEw5I7ANpUoFBw2TQC0A0SHYW7BptfeYizabvCAwehD9YEH2xQXI+coj8pj+U+LokMBRvKarWhujk1Ib+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H+XIuitE; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H+XIuitE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mG4EcVBOK3JmHH8NYqM+m1j6iQRGaHmqNG9sPbsDRzXCiZaM9UqPOlvnJ3SztL67qLRBBBjUeH/uFNGmPTVL/foBtkVPXbwW88f69cZVWDNiaWEGPb3oApie35bk90SGo/LN2fQq4nDk4CrDywQIBocBke21R3kSgSqixg+uf3bvysrEV+QvGmEcR/L3CHGZ+5Cf6zZpbDc+TsraPGyASe0QLf8SRXgLLWU86QlKdbulkqWRS8D4x3BtSDHpyyIKa0gyyFv9rm4/K9pgv62ya9ZtkR8a3ijlh8BrC60NZMwIoC51yJUx7pFMDO3wV2zV1R5la66jJQTD43lkg9M9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBRVf6zrAQrGwITKcr1x9GHAN98C5tgqAPdGlYPPXBE=;
 b=i8JlR3smh1igaxqmavdKCXfDpArsauTlBozqqArebMhNKK2pIBHy7qQMLQQa/y5Qs08Bv3DqRdZh7bdY/xGIIQUT9itpCCXpp872ItttYBDPJCTZj/P3/hOnryJi7JmFUvK9wdESVzMkVAo+x8+L/MLxxIoOTqTVyzDT1iBUQO7WwCYx99KVNy2MgrCiP4Wfrz5kDaa5HEN/qApM+t2GahlfKTz8FgP+Xzu+iDZxxE9v44ftzD39YaCAYIZd3Jtzwfi0A8zMyaMXxqBRx6X0Cmpkgs6ms/VRhfUcKEMlpYV+VafJY5jYw3oMjBGFhOHcBQiy1W0XHX7jWXcLpqZ0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBRVf6zrAQrGwITKcr1x9GHAN98C5tgqAPdGlYPPXBE=;
 b=H+XIuitEtgP8D0MuMv9U9diBuEaL6qmuBKSQJGJKolYADhLF+DO4ySsab0Q4AjGw/RgkvMo6AsWsgGZO260q4UYShCOLpY6czCBOGcJ0cKz5QRO5fsZ0Y/l/TecgHXOg8Dv6lN63Qh5ksyzcfb6ZddBRJdZ0FLmsjOti7IWNIZaOIVgBrnQh6aJPeWm+RjrZUGCsfle491s4K34/oQ7Wz56HwXHU1sf0bhfhLuX9uAQ4lDujmUH60kldNPbPoiaZf51m08XriVm3aTISTchfgTyGG2T74Pt7Fasw3crWQenr69z7OhQoiNlqygng/6OeCwDPAIv5UZbEnF8o+nm/gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH9PR12MB498472.namprd12.prod.outlook.com (2603:10b6:510:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 13:13:21 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 13:13:21 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	andrea.mayer@uniroma2.it,
	stesasso@gmail.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] vrf: Stop corrupting skb->csum when capturing CHECKSUM_COMPLETE packets
Date: Tue, 22 Sep 2026 16:12:39 +0300
Message-ID: <20260922131239.2509494-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH9PR12MB498472:EE_
X-MS-Office365-Filtering-Correlation-Id: c36aaf5b-9089-4e3e-622b-08df18ab45d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|3023799007|4133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	u3FjYMdoQJIZqS/BHbne7Z5htEaGvabrzG4CdwtDRrRnWxEBRihe1wIySeXn6LNs7UvJLs+RPIzSC9cpJqC/No0Vvx97vTkp2FUhE+ioeP6vGF67s4Hir6wgTWzG5VEI2uGVInnzVRHsGs7/GGcGAPf8Zi7fCj3tPkjyvOlGl2Id6fRGj3sO21zNuOlN7SuncIky2qR6HOBTP3o3yMFVy+CEbDqhcv4z+BnjQfeOgF1hkrunRADjXdMmbePOaQWIoN/cCgKgFjCyQ03PxFIT2UwO3whFhfi0WeE8FfZcn+SoLKjJbcOpHQ2JwJyHRwVcJo6XKdWvg4ve4nBDeiSxSfmedCJ79OGVIfl6cge5t60K3V1aUagtIACyN3xXYXzqSJo2ZU3uuI58xzduCIk4+vHnvB0YntXyTFG0Uj8gH2KGbzFR6oWC4no3D8Kqon1huy3xDCQOz9h+NwkOI82rUZjSbJfXl2H+NUk/j2SYZRSk4VtOdsU4QkgO1y5/rwa3EqbjEyOONfZZtHmxukMfbIU2zMfJNYrswfVHGxW5acGK/rMRVUVlkxL756JIKLiRuaAaNfK81cXtG55OUTslGZ1hhanA0Vyl+3Um7JpjyZ+O38hWJ5NgodBey+XOnGbsOAJsDE3IpyssYhzJ9oTK16SZ8meopTB1d9P6esrlFIs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(3023799007)(4133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yptLyOamEp1QLtlzpEP94qLj7gqNIjc07cW8MXpAdo7AUFWoCjoX09dWikrf?=
 =?us-ascii?Q?3WPiENEaaYM8eru0vc6BohCew57uMVoctXNg1spy4UR1RjIAF7J3KrQIR74K?=
 =?us-ascii?Q?UIbjwPQhBNir+HNMhUum7KMLqmGE7fhlbBFG9rOmPLVDPRxfqaugynx9StFb?=
 =?us-ascii?Q?wcSAIRloN+z6+lhk3mfh8/Jw4T6K3VQid6V/aitWAx471AAjd56Ju4EupCIA?=
 =?us-ascii?Q?Z4gfK304laKJXX23dI5c6eP9woOR3EXabysARPW9WEFD8XU6PnP3kq3eX0v4?=
 =?us-ascii?Q?suEVUMEyyMtlGOFysYV/sJGjCixuz/esjVeg/wmlmjbmmiWhsIkihWRj7Z2B?=
 =?us-ascii?Q?gYgOmpWS4IRy2VSvUKqGWqaCxR10jFUD6px2DnxbFvPfMYlRbKVuSwLm/76y?=
 =?us-ascii?Q?PMkRqz5ZGSe2FAtZTLYcDoDoNO5JAOonq25Z1kEUXPBig0iDPoyNhXfCVaPc?=
 =?us-ascii?Q?9EjrXolDJiFYdplY3s1K8bqxJakll25RMAObrb6qFUcE47tXw97idPDUyaxi?=
 =?us-ascii?Q?neohyg0HdxFr2qTH6HzxBcoMKtccrczLYLtxHC2yqzhTgAFvH4YgR8zBNyHx?=
 =?us-ascii?Q?Pda3ZT4Op/9VZGjU4z3mmxy/F2vy3l29EKACmpowf/7dEF3VPHOrqX+e2l5s?=
 =?us-ascii?Q?LL8JZTq2om7lSEFh0nzcnvzFfy9NggIAcgyhLSHEqSL3c9XooxyfU8+mvfEz?=
 =?us-ascii?Q?jhaSfqBX039eG3HTFPMbX6G+V+bCahMNyi8T+akElW9xffL6yr78kGdUjHyI?=
 =?us-ascii?Q?SqjW/hirH4ld8noDH01zVb33jpFmsUa46Pqf/aTiwq93NXgx74R7JtogNMGN?=
 =?us-ascii?Q?aCFaiDBjeCKDND9fQHMX4gOUD7KKX3/8dRzjT3TtgNZJCBEuWpy8QNPAMjnF?=
 =?us-ascii?Q?XO1T/QkhZRklyctIyWASLJIxsincGuNXxz6Ra+Oyruiz+Z5gG3m2HfFAKWRK?=
 =?us-ascii?Q?TtvocF3tc00LdpcqX7Ch7TKgQlop21vt+yv/pRaHUq5LnPN8dG63PdGYiJyt?=
 =?us-ascii?Q?esSWAKEQG65mbxbmc4S/ufnD9NRYmKGhPq1xl5ifGOEnwxb7hwApz1TOLXC2?=
 =?us-ascii?Q?B4Ac0kU4OPb9dy0pny7pZnv8+KSf1X/bbbiVSiOzKfPT/Eid6byMWo0QJSdC?=
 =?us-ascii?Q?W/Bl8a/aYMeqAOKIjbzk0fNiSC2c6TDFyjatiU9QM8xfI/BWhY4/foFAg/FM?=
 =?us-ascii?Q?n5V3WAmX0XVpherYH4WJQ1vLYM4jZi2bwmJjqucmRprFrP/OOb7mRGqjAVG9?=
 =?us-ascii?Q?lAE1w/z1jQRnMAvAg2bJjrnuFwh4WkmFYRoWeKZfF041Qa/Z4TrTiXwekebz?=
 =?us-ascii?Q?gQ2W+qGvmFI0oGQpPiUq2a013WvL4/PeM6HRhvBU9b+WdQSJabd+B1m2wbMO?=
 =?us-ascii?Q?E+O9uIdHacaSp+2WKz7gxkkljgHA0TQkfTrvVvq5xHs3WnpJHTs568AP4Two?=
 =?us-ascii?Q?Ml88sQkIiHB/iOwntV5Xq2XAnw5edoWLBqlzD5o8ysCzYXZZO3n4OfCu9Xft?=
 =?us-ascii?Q?esFEF3b808eSJQpM/YP5fWJ+auiwfmFM0LTLDIJAR95Mn5w9SFuhXIUWkEjc?=
 =?us-ascii?Q?D4vctCH/zfikh+92P/7HiVBEoVQNdaeSl8NmLFzYVOGY0sMbATl1ApGGBv3G?=
 =?us-ascii?Q?SRupIQjf1NckiHQeuTjOu9Z28KgqQ7vimlNn4gMxqEpYGDDUvKkMieeGlETq?=
 =?us-ascii?Q?qXMpi6wNj63MjGVTntLudzwtEZ0sL452M4KFsSjEbOGe8R/+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36aaf5b-9089-4e3e-622b-08df18ab45d2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:13:20.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjAakduNmTutVgfA1ZcQiaZt6Mm+7N+GhGN6L7c6H116dgLsLDCJ4HOrFI/30+PbL3Bsrs9NOh5fH6llp44EPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB498472

The VRF device is an Ethernet device but it can have non-Ethernet ports
such as IP tunnels. Before the cited commit, capturing packets from such
ports on the VRF device resulted in these packets being detected as
malformed since they lack an Ethernet header.

The cited commit fixed it by pushing a dummy Ethernet header to such
packets before the capture and pulling it afterwards. In the case of
CHECKSUM_COMPLETE packets it also updated skb->csum with the checksum of
the dummy Ethernet header. This is wrong as skb->csum should not include
the checksum of the Ethernet header ("checksum of the _whole_ packet as
seen by netif_rx()").

This also means that L4 protocols receive a corrupted skb->csum and
potentially drop the packet, as is the case with UDP packets whose
checksum was completed by software.

Fix by removing the unnecessary call to skb_postpush_rcsum().

Fixes: 048939088220 ("vrf: add mac header for tunneled packets when sniffer is attached")
Reported-by: Stefano Sasso <stesasso@gmail.com>
Closes: https://lore.kernel.org/netdev/CALtE316UtL3x7LL6uxfXzx8rW6AbzYPeDOb478hqJCr_-dj=Wg@mail.gmail.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index a0557a3a7026..d4dc6d690a75 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1175,8 +1175,6 @@ static int vrf_prepare_mac_header(struct sk_buff *skb,
 	skb->protocol = eth->h_proto;
 	skb->pkt_type = PACKET_HOST;
 
-	skb_postpush_rcsum(skb, skb->data, ETH_HLEN);
-
 	skb_pull_inline(skb, ETH_HLEN);
 
 	return 0;
-- 
2.55.0

