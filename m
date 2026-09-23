Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAAD389106
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180304; cv=fail; b=rIAfXnMT4mf5MILWcV4pAaA7S/LNwjyOILGjYqO6OkknBh3YqZp0+KDXCfSOWJkaUDHJ//SPXiK3vj4j8zT30hYebauh3r3kg6H5g/emEsC3m15S2FnswAiMDfEARQ2rC67tZ7Ds8ob8IjKE4rb+J40Uwq5eRy4X+HNJ7U+1POo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180304; c=relaxed/simple;
	bh=4HnpV3FI1cMCVfw6Y3oD0vo21lOyOQ09oONEAVwHVW8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Frk/hYTA/N1XL3J3ryg2CF34Rq1PcbY4z1+DsV1PhfM1+KeiMqj3j5zQINOezuouFpZnCJjVpfc+gDdZAiOa7pBV3iXC+biZ1AHpxRYEhEtrZPijJ4oEWjKDGNMsnZRfozu3Mh2BQDL9DidJ1y7FpPf05fnT2dwyikJV6Rimo3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SpXnsXAh; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SpXnsXAh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMFhroXKz9Nv0miFtUHYFr0nsiuuGgZ/Cl2Moj24zJsz8vjL13GJjGO2zg5jZt1oxiPk4ffhW0/G+QcyrN2Z0YAHjS0YzPaH1JKs0NdabyNQ0u+NfcF3mYoMcCAsKKki9SRjaPXruf1Cr9l+CcR7+Zg4Odw2epw8+DeBY3idRw97jczaQpiK0SbtZ1G38wq2civ04/eau9pYE3DqMHmYTM01cg4QQksceGW7DDyhTNxJoKoUZemGA6FEMS+FEYDk87O5oafU0vidoHFONBnxWHzsvosky2yyb/MWO+FHdqIk1j9NHsb91BrFkPs0AK+x8Qhu4wtBI0Wow1OboTjPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJRCMS8kVOZokSWkFeMneR7Fhu7eBxbsh64jBADvSsw=;
 b=fbWoyEUUrlj2opNvw6iRVydyGH6k+dbF2il7mBl6OYo9+Z/aqWKUjxjRtdRata1SoLw4Kya3KMweMK7RLTLzvu+TBD9p04hbOS8FXnMLfO+Pj8YDtocdhNuusKP7X64M173b9Q3XvBRppmgNnhgKNzkM1iWXCnUtU4nf7wuYuw7VEqshJISnhmSF1be/cbbdCGKINOGTpPYC3g+pYXcYekrSmnTTdinV8BwgFVJI2xvrGVX8fveR2JojBVKXBsBwiyVwDSlUkcyDj+3bP5DSxkSAd3nic3awFTUH1Fh9I8A1ApUbtTd2AuvFctYJlRyV361A3tRsU3R5e25dhnzNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJRCMS8kVOZokSWkFeMneR7Fhu7eBxbsh64jBADvSsw=;
 b=SpXnsXAhqB13s56EpWc+dNp2IfmJW0Sgza3Gbtno8ujfi6jvR2AezOzwYM+tmS5Sth14mW06/i3ufNVbaA5lGlpnkAuPQDx5tjfOaHvHvyJxeEV/mY/fK4YzLgpQaaXDjr0G7OywQ1SZ6b7WQUG9DNU5dfKhhd96/Dlo5ItQjLhKDnkZs6A/w9LMpM2zMBL/oahUjKHs4d9fOTpAz9IpaCcQS+Hs2Ol9bZJ2/DYLg1JkeGjhmay6faFbKVqVWPsv9O17uurgE80zHuZwRq6xaMOz8bcobWhQqmJha3Dz1Yoi9O5wFoWRURAZORUNiEj/U0h/sc+slEI5kf2gv7BZRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by LVUPR12MB999135.namprd12.prod.outlook.com (2603:10b6:408:3a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 16:18:18 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 16:18:17 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	petrm@nvidia.com,
	daniel@iogearbox.net,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH iproute2-next 0/3] ip: netns: report the network namespace cookie
Date: Wed, 23 Sep 2026 19:17:53 +0300
Message-ID: <20260923161756.2914560-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::15) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|LVUPR12MB999135:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8ea74d-cc2f-4b0c-7798-08df198e46fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|3023799007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	MlAS4aRdyhaT87S3fenXESvX5KRrtTdQIKUrcmVRzBfAv7/Zx4DA/InfmajqIK9GwrD4+quZByLwkZ7n3hv7179OKDDpm3XUWLM9b8RV6n7tVX3+LrzXuDAaa+61g5d8EaLPtW2KtkXJKzKiDLmeAkdEJcLADUZB0zCUVAaEOHJ/r5fHpVQmy0osH/Zhdp6pALHoy4x4JDnvADcuMku+Kii5n2XUZmoz+D7/MYwFuIEmSgM+bKkgchiuDIcGuDvYLEo+yKx1FhyzsjDUR6z+CzyO8Fk/HTnexRffCH/OVb1xVo4nusRwNHSMAHK/LDH/Wor9DCb7DyhLcdZX+pAfEfq7l+jkvlKsPhdfSFxbvm9VdTmEj6aTE8I6QdBn1wWcL2+MIpFJ89f9PgttkzwmquAKFpYBAnt/df+5OaRovZFgM09qiNhO2MQxHqU+UjbtaCQOPyn75FsBveNw4ykC6X4b0t3oP/pqqiJ8IPblSSUA1iRCV014TGNCUALPj0cHo4KpZG8GKjTKRCjKOTqT3Yxg1jcqFQAnzIQAeiptsO9ljohTUHpZ/hJo2Htk58jcTbh4vfo8MVgGq1wkbzb26hs4cV49igzKLAnxJT2+5De1pZ+GRrVwmFwffbgKvlFyOCFdeNjHZ2lW+Tt/ZGgV2rx4H7wp1lToM75X8wLnkWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uJ21Mx7EBUtncsaCgV2k/hGCIznpI0JjnDdVQcXE5gwF/BQVPXHGzc6a/adt?=
 =?us-ascii?Q?w+hgGhCkMu7vLDRE48e71vm5lPKNy6EkPbUT5jOCyPTfL6Jj/UEqMMY8OdZN?=
 =?us-ascii?Q?LFDthx666WcYvjYFkZ36bEwfQLyA3fBC4gj5cXIFU+MlbtJDui7hd5Ai8Dxq?=
 =?us-ascii?Q?eYZsFuMMRLXPZCKEvPt71EstADty3FF3U4hzkcyT2vyucRlzEz1HEZtF4+BG?=
 =?us-ascii?Q?iVVk0M0Phu2e8xiTAAQy6qXek3PE7ZIgBly4iFJnoVFTvxoNigJQi8cP9nKA?=
 =?us-ascii?Q?wluJGPXOk9r4sjd8yNQzUh4I+wgrSPpaIZlzaV0ee7CHKplrmcgyp7DTJjXJ?=
 =?us-ascii?Q?xW9s6FKvuKpbZDbEVkin3KMwzGYCSue4Rqc7LVqOSRMyhUSvIiLORyDJn9gf?=
 =?us-ascii?Q?e4eNqKGUgt95t82cHrdKgBNHV8TysxMLeJxIWC4IWOKUE4tJHu6vEWJcP/0S?=
 =?us-ascii?Q?jWdLOhfAXuBHRElQ0yzjg26zeKRm5Wf7PQOdCl+sTKALUeMLefDHPSJ7RsaN?=
 =?us-ascii?Q?veewdsByffd1t2RlbNqeFnzSpzE6BacIA1ABry1r0zithgi08p0jnKfuE/Uo?=
 =?us-ascii?Q?6mjAmyT3a+IUQkfzOJtFqqRY8oAy77knu91VItnYc0nlFUR4C+whc7iLVI88?=
 =?us-ascii?Q?UzCekZI5BA9WbnF2rZ9d9lIeMG6eCYKLBplczTKbD9T2UT+KUaPQCPWJNDAA?=
 =?us-ascii?Q?w2/eGSbSK1izcNMpqNXUDEWOd4YpjM/M/fGoD2K3aJCm21bUy0msgtNugyi6?=
 =?us-ascii?Q?+7Dhjtm1XpoYiO2oe6Z7U2Re8byrTkQnLEuSx1H5DL+am0iVXAWx3LF+XWuc?=
 =?us-ascii?Q?aPyNf3pgQsZY2LeRzUSfc3wi+WT9UcqUVpQ7QQW67gFZ/dc6P+IdRoGVJDUX?=
 =?us-ascii?Q?4KLs1viWdvc8pu8i8aYzUVQ33lB2PzFJhUC5XIYmMU5K+OxGlaW1LjCjBMC7?=
 =?us-ascii?Q?6zZSnfrO2WQuXnM3BZl+1k2o3cw8nmLoDYu8PMO24B/vDvAFOKIGzQNdFMby?=
 =?us-ascii?Q?vhPbjsdDRzdypITVDvpS6/0ruM+lQhO1yXGOqSuqHoa+i/CplC1lLoZTtWXx?=
 =?us-ascii?Q?qrAZ2jk8SgZX9g205nLq+gk/c5SnqJ03OCW31lTBHYoXnCDdjkGPlLG1os7y?=
 =?us-ascii?Q?U0UN8KHy7mbqkztwIDW9JIbkdoNzm/VAXer51GRWXc69bbTw0UnHoeVybDbw?=
 =?us-ascii?Q?ZqNSuWEBqGSJJ9sVwW10Q5Fg0QMLgXbEjbMfygBQp81wOFfdxfA5L4YipnUd?=
 =?us-ascii?Q?m3JpW0cJGs3J/5WIEKO04PH8yAv/Yox4r8dayLu4S5Czp2s+7KLDCu2u5puO?=
 =?us-ascii?Q?ubEudo7hnqzEN3RrKuqpZ6AXhD1K3Jwt5jG2KASPQTLpUQlI1SD8d5yDfGZe?=
 =?us-ascii?Q?zr+GadLOwPkrei4d17FAU5K72Rn4bfbmJ32yT54pemguAQnbKDRGwCSCt0qD?=
 =?us-ascii?Q?yZv/WCZ0vHSm1xrMng6tqBtb1JMktvCgozIdag8RQaxJK7MXQjZjy1XwRWN1?=
 =?us-ascii?Q?zVlfeLtlaw2dlQbY+5pJHRK6UJtFKYTWEtw9FpQvuC9/1bmxjXUyWCh6agg/?=
 =?us-ascii?Q?sty6DM55mhLoATZQiOI85W6By0GTJkRibKc2e1TBwb5BgQY2NNPbMoUoGOji?=
 =?us-ascii?Q?3wEEntfU5W8/mqMSbArw9icnPNGZmLRHK++9l4l/il5CAxaemeFFBscYy5kK?=
 =?us-ascii?Q?J3wVGTtf7qlzcMm0MzTLk3eUgKLaKnc+qfsTO7Cf0kg8JjO9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8ea74d-cc2f-4b0c-7798-08df198e46fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 16:18:17.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCICe0Lj5i9uCzwie5cEcFxICrrUbj2DZqTJOePgIrF+KGzdfmUMCYdZSm23TdZ8ZrLuW2WYxNAZAKDM+HaEsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999135

The kernel identifies a network namespace by a 64-bit cookie that is
assigned when the namespace is created and never changes.

The cookie is reported by a growing number of trace events such as the
TCP-MD5 and TCP-AO events and the net device events (e.g.,
net:net_dev_xmit). This allows filtering events that occur in a specific
network namespace, for example:

 # perf record -a -e net:net_dev_xmit --filter 'net_cookie == 12'

It is also available to tracing BPF programs that can access
'net_cookie' in 'struct net'.

However, no utility currently reports the cookie of a given network
namespace, so mapping a cookie in a trace to a namespace requires a
custom program that calls getsockopt(SO_NETNS_COOKIE) from within the
namespace.

Since Linux 6.18, the cookie is also the generic namespace ID and can be
retrieved via the NS_GET_ID ioctl on a network namespace file
descriptor. Unlike SO_NETNS_COOKIE, this does not require entering the
namespace, so the cookie of any namespace whose file can be opened can
be retrieved without privileges. A kernel selftest [1] ensures that both
interfaces report the same value for a given network namespace.

This patchset extends ip-netns to display the network namespace cookie.

Patch #1 imports the nsfs.h header that defines the NS_GET_ID ioctl.

Patch #2 reports the cookie in "ip netns list". It is always reported in
JSON mode and only reported with "-d" in plain text mode to avoid
breaking scripts that rely on the current output format.

Patch #3 adds "ip netns cookie [ NETNSNAME | PID ]" to report the cookie
of a single network namespace, including namespaces that are not bind
mounted under /var/run/netns, such as those created by container
runtimes.

[1] nsid_netns_basic in tools/testing/selftests/namespaces/nsid_test.c

Ido Schimmel (3):
  uapi: import nsfs.h from last sync point
  ip: netns: report the network namespace cookie
  ip: netns: add "ip netns cookie" command

 include/uapi/linux/nsfs.h | 122 ++++++++++++++++++++++++++++++++++++++
 ip/ipnetns.c              |  71 ++++++++++++++++++++++
 man/man8/ip-netns.8.in    |  30 +++++++++-
 3 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/nsfs.h

-- 
2.55.0

