Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648D45C71C
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302206; cv=fail; b=Jo6MseaDYPhspBOm7wh7BplFD4mNrWQVI6dJtc/c4VbSsR+hLR10OKzPYBQLUTHeUFoHWKgXAq5VXwmUepNwhJHCHTH1PJ7EE1bYM7OCkaRNqiAAKXCn2wZEJbJ9EZ7BogZ87QL34IhcxoOE5L+zIKbgTk6i7DGmiXb22oZyPWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302206; c=relaxed/simple;
	bh=149QaFuZ24eSMeExZdc0UuAFJY+AB4OItKcI2qDq7eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ya7Ne+xP6qUzaSxNRVPjRk7n1bUvorvhGRzZKYWF/srNXWO7GMIhPNarim5zufLuGadbFEOPfR/SxbTXgCMoZtcyk7dIdSaD1tVM2bp5c2MTsqJPq5T6cHROwf2Zz/q1v0JhnPlAS/VW/mqmuArzieICI1f+cIV3MKVfBMRUmXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kPWStFWj; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kPWStFWj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1BV0iCvRQQ8CPKq/3FMwZxv/Avhd3DVzSPDGQROryojnX2nicopWSNGqKnRaOUbNmiDfq2uMdbZHJ3J7KateeSFpWfRY0JeXcXJGFXJRj3M21aehioOlqDUbZKriVreF0BGZBchzwnBbt6IuiGcoZvQhnbF1CHRJp1mnfQvrdedHS3L8ulgFMzkRkVO7a6JK688r3Lk8KDsRir9zc46UuHSeSbI2Vlz5dUsiqxngdHYfzZZG5+R428Z8ebjoQg4Ou16cmdSAy80QYZOTAPVYifYc7dcMfxVXGAi0IU++TLP8r1EuZBlHts+iJPZ7L7me93CTwbXby/NDDMRwbb2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U65jgXjXWeum38OhOYlxecEpFOIyKMRjLyhlIj13lK0=;
 b=wfw009Nyyrkd3POr44CgcMhIvPwC3xKCDNZmY+cI5kKtG10Zv1N/970oIw3w2b4yj2iadEqXMDaabyFl82hWBGrSHSmNA56q8FQvKyEafdsKuBwcuKkZNRC9CHsVVspGaiuhFrzvNsVM2GFxsqWRBTqPDoJ/2lVAYZlUKMhLhxRMoJ7q6WpDubf2ehGv2BIT7esLx3Q7tA9AkAOn5X02nynG1J4PC6j+OrOi2MecYUpanRl8+pDqnGiOj4xLKYtw+/GFYYvPP1OED77+sC8YYvRyNmU0r5vhAQoH83DeOdlsqYLKCHqdMFi3y6J8zpawrf5GA26dCZMlbrQift85MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U65jgXjXWeum38OhOYlxecEpFOIyKMRjLyhlIj13lK0=;
 b=kPWStFWjmJ+pq2hRAFLcFZVbrXbkRZvLWVHBxgz3B02HmviFXT4c1mIxqeOsc6+Wd/6n3lXeyAirHSV/9iOby8tkFX+63hEkpVaOODLFu6TzYAV3kiaI8NhqFw4oZoigmuxCY4yJSvTFN7pUZz/FSG2f5iWLM9PeBg+xIPd/xJgsHUB9c68522nEJj9RVe4Kbmci4PJNPUnuNlXoOvWH6HHGXmhslz2S1SYXV6b9/m+FDaB/+s1hnqiKpWbJY5ajX4WI+vhyDhZ3STJ44pjl/xb7n3fexTRAEJWBCX6LEi+HNsOqxkLQOl8/WqoYUBdzt3ECEv5GZ5NA16FOm/enjQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 15:56:40 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Tue, 6 Oct 2026
 15:56:40 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	petrm@nvidia.com,
	rostedt@goodmis.org,
	daniel@iogearbox.net,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/3] ipv6: Report netns cookie in fib6_table_lookup tracepoint
Date: Tue,  6 Oct 2026 18:54:52 +0300
Message-ID: <20261006155454.853588-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006155454.853588-1-idosch@nvidia.com>
References: <20261006155454.853588-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::19) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 673a9bbe-6cd9-4ab9-f539-08df23c268c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pTBOphCfc0T4V0eMVfbHZ7Tp156OjgZwvYGJpJQYEBTTzPLVDym4FNQtCzOUbA7jsZ/Yb2amj7CbbVWyUY3SK6NaO9bHSMjIrHI23nnL+ASbH5IFHpYFMeIwFJEty4InJ/P0vbRYjsM8O5G7jgJTFRwKx1ZaVYw04Bbheb5B6BJQETVgKSzg7fsPJy+dM4qN43ZKUAXkOk9i+vBzvChUdxpVxO9ZqJo/6snhGsBkqPdx2IaJ0j+9qhN1M10X1veJXtFJh3A8PyXaFFGJfT/EHtQmbMM6w6X3Q5vso2+Um9fdpNehvOTkjRHuE71GBYJLuHCZ9rhVol9LAAKT1oGxjOP3W7pHxZbqXxSg2zJhH3c1sTGxl+mZ6GF2xOacOM7/vfFf8XhwRrxG2ezvS1YnrqeoOkoCpRwwW7NcO6+MOx05MHUXY1V6XWlYcVp4saQYSO4PznJxtui+WkjysyW+S1SaAxEY8PjE/1kJoJiD3nEpOauRnpvfLwRriaCyk0AzL8Gw/60QBQxpBD/MHVTM8cY6tu/cDlNmhvgvKVrD4aM9jRXcI9I5j9Fv5xwWaVUyFLWKt8nbK/e8NZmlniRclRGXv6I55qx8H0FHXZVnyHVZbc8WlNS5EkqKoaoCT9nXANSh5pgKsW/llgKFWjWUWOp/47ixL3pEFhqxvPEVoxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7sAfLXfP04I8b21Mlt0IjhzP01Uw+/R1G5Lgx0B6IpbtLb15p8nLn4HpQL9?=
 =?us-ascii?Q?8bgaBNLoVMwY47ZfqsTaC9mYXpWqPHI2RFVTPZmZAFVhPMnJEQr6wkNSJenY?=
 =?us-ascii?Q?7MIslCElhKqlfv26rYyxqgqrJbTj59bGJ+ue8N7TnB1xIl5U0amb7vFVH8D+?=
 =?us-ascii?Q?M1VPQC4Mgd/02fWC60gMIxJHA2hQKl+Fho3A93ShGlCDNyixQJT+sii0s+8J?=
 =?us-ascii?Q?Co9LBi1Hc/tZc4c4v8fiPXGu5WMqmHq74suwCeW5p2FFCuwS8GK6jTGdmpM5?=
 =?us-ascii?Q?Hw53X5sLqRlBMvjzE7yg8Q/dYsG96zw3wy4YoY1GQ8CTgP/LnP+RckR7qeDX?=
 =?us-ascii?Q?C3oDe9hP97OFnCFdceAzvFp7Nytw0KuzatY1yj+MPUztF051V/ahNQuDYG7x?=
 =?us-ascii?Q?yMUa5oqWDDC4ieBji8TWQk1Q0CNjwYrkjT11n5CojeP/zjVNH6uQUi+44UUG?=
 =?us-ascii?Q?BavgmUrF50YmpxPqRkFBvD8pSMVII424IIVHaG7B/WwpXhXO9crcLGt478Kw?=
 =?us-ascii?Q?1cRxkpGPLPLl59r+/LH04wyXaPxLZvs+ovVKs2JOWi/pcbt2EpcW2VPGeVX8?=
 =?us-ascii?Q?Q0fsr8KdbQp+OqKoLC0KvGv6KI4VixNY3FZJlaQrt4gOFWvcN7ZmeHGjJS6b?=
 =?us-ascii?Q?KrY6Fd9hdDj3xFoT69rUOkwy0T4gl8TqSjRvdTiznhVy6xIoQ7f6p36thbDf?=
 =?us-ascii?Q?ghaeL8V9h2YpBqlBhhPKhrOJE7a/eVoHv7knmrnbqmMfOlteOCg2XG7RlLCk?=
 =?us-ascii?Q?azQBy1mJN7lE39/pLs58AIsGKbK3DnDoUu8euk6THHymUdPkblWkcC+Wk4/n?=
 =?us-ascii?Q?e04fOQ3ZS4Mbfi5wMiD8ScFvNlF+7eylcyzCorUMxaLBA90dyuxQ9bDsJ1WW?=
 =?us-ascii?Q?J2tWHJ2vH6UqbnLICisZH7nl8HFGoXtuWDj1EJpnI9nfO6Fgx6Nm0eyQ/+jo?=
 =?us-ascii?Q?nOrivjPtCPrvvpPydH4fs7tKriDRwfPNed7t1EO5xt6AMVH6AAsBpA9OXP0x?=
 =?us-ascii?Q?foZRB3SNTnNEI7RtDqRq8+iuX4SE1nmnMgg/2jZuJxQSvNgK+2DUlgxHeDXB?=
 =?us-ascii?Q?k/KbFpTTkY0we1qT4Tm26HvRNgmtMgMZi7AO0RYZFZzWrE4vgiWrt5LITaSB?=
 =?us-ascii?Q?GE39bheg+LuTwEEbAldHy9FfEt+HfRXNiu9J5+tyslBLp1CyDYnm/O6ZCCP6?=
 =?us-ascii?Q?EqjJKeLERVADWoTEGxeNYnApYZhmW5Pp6iqzeSYWYu9KnRdwdSegP5+5ibvL?=
 =?us-ascii?Q?tVLsqfO14BnZ2QPr7ER5h/haSzvQEm/OIKjnDM2iZpO4l9uIe7VnY0JfRPoI?=
 =?us-ascii?Q?EiCivRrw3Pl53cuoCappygD+yd240vLhs0/BC3UKXYBKLoTj2DTehVeQWwNM?=
 =?us-ascii?Q?vdC1hVG5choHuJbSXAL5bRN1fYoj/YYiKFUCLGFYnSRTkJ9UkxYYxNmnHZch?=
 =?us-ascii?Q?X2CUTuHSP9Sg/pvckesRyFvYCxR1vK9kcsg4d5xEJMTePtng+qmJ1RIfzMQX?=
 =?us-ascii?Q?gA8hZ5oBRxvjhr71qM4ZG2Zie9bOoU+xj8Z1ZtMRSg6qJSrTSV4Dp89+odUD?=
 =?us-ascii?Q?tijjCzvWiFsjQbs8aBqY0Dgkn0W5RhbrVWqLkgf8E9pGGGRPAgbo/GeJyrk0?=
 =?us-ascii?Q?mQUfNm8aoqVdh53o40QLSP0X8b2UIYyr8mZsIEI4nhVPQlXuwRzjeFB742Fp?=
 =?us-ascii?Q?JLGBSQvqiGpp60lrGRGYLCy6AgZDLsPC+xWFRDviRR+GZu2A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673a9bbe-6cd9-4ab9-f539-08df23c268c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:56:40.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge2F5Co6qrP4COkROoeAgLU0OIQeR3nPKic7TrBtbMwpAPm/GfG5cXafFryRlCN5Z1P97wILXrWBZNiHapV+Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

The first argument of the tracepoint is a pointer to the network
namespace in which the FIB lookup was performed, but the tracepoint does
not report information about it in the associated trace record, making
it impossible to tell apart lookups performed in different namespaces.

Report the network namespace cookie, as commit 27cb3de7f43a ("net: add
net cookie for net device trace events") did for the net device
tracepoints.

Assisted-by: LLM
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/trace/events/fib6.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
index 8d22b2e98d48..e58facd2d7d4 100644
--- a/include/trace/events/fib6.h
+++ b/include/trace/events/fib6.h
@@ -34,6 +34,7 @@ TRACE_EVENT(fib6_table_lookup,
 		__field(        u8,	rt_type		)
 		__array(		char,	name,	IFNAMSIZ )
 		__array(		__u8,	gw,	16	 )
+		__field(	u64,	net_cookie	)
 	),
 
 	TP_fast_assign(
@@ -76,13 +77,16 @@ TRACE_EVENT(fib6_table_lookup,
 			in6 = (struct in6_addr *)__entry->gw;
 			*in6 = res->nh->fib_nh_gw6;
 		}
+
+		__entry->net_cookie = net->net_cookie;
 	),
 
-	TP_printk("table %3u oif %d iif %d proto %u %pI6c/%u -> %pI6c/%u flowlabel %#x tos %d scope %d flags %x ==> dev %s gw %pI6c err %d",
+	TP_printk("table %3u oif %d iif %d proto %u %pI6c/%u -> %pI6c/%u flowlabel %#x tos %d scope %d flags %x ==> dev %s gw %pI6c err %d net_cookie %llu",
 		  __entry->tb_id, __entry->oif, __entry->iif, __entry->proto,
 		  __entry->src, __entry->sport, __entry->dst, __entry->dport,
 		  __entry->flowlabel, __entry->tos, __entry->scope,
-		  __entry->flags, __entry->name, __entry->gw, __entry->err)
+		  __entry->flags, __entry->name, __entry->gw, __entry->err,
+		  __entry->net_cookie)
 );
 
 #endif /* _TRACE_FIB6_H */
-- 
2.55.0

