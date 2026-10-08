Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CA4AA416
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466472; cv=fail; b=OKo1bM+/FM+hjmR9HEXneK3wWPL8b0OlGbr81P9LsuUHrCssBSRaAjGiRUF8kaSKyHM/Q5TFta6TiTarnk5prY0zAqYxYfdFNnyRD5MaPfTFqMh4wzyVA2afPztaHouGs4BDoGAcb/AXvLNgnheoKR4/sA2h5EN5VvoUWwreSAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466472; c=relaxed/simple;
	bh=tpO+NYoYxJMW86HyGCrNuCGxFyAp/7bJwf8tkYmEyxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JEIU8IBNtDfkhracUeCCZIFljtsJJMSSqMUBaTLLEtSx5C0/7kWyRXsXr5XkkTUOvrQl/6eCN76Orol45HchoCWK7uaOyoyvSPxr358LCuXEKDOzZ9mbKU5pwHpIfUwdiQ9CcwKYKawwOIqR3IzfWM29YxUwbRQzGkkUaNpe9Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suZylAuG; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suZylAuG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C980C407dwzo7IYFrJP+EuAPN3SNVa80+5lYHbFQRiVVtXT5V+H/+ZEQZRqdFKq6vMQV42KXSFaDvyd9y1Cv4ugN5hnT5xPfBHWT5rPu/qtand6FrIH5/iC6Y/LiMluDW1M93Jguc5cjnG2BvL2/RVUcQWmCIV34L1mkjlt2BqyaGhWUouCxgRAx/Pxs2AYo9aAPxIopHO/Mnb6llvpQWcG07f84X7vdYe59PzgSikN0mea3wybqSpXUs9XlU8AzeFu0B3CSnfFl594OaYr8NHMN71f3Zslgne7MDfrHhc9MN6KbDUlStjB3zlav2AlMSuZS4GfciFdDDYgiM4XOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FinETtBzktDBcq8iGXJJzmoA87mTpht+7q+SOrO0HN4=;
 b=ZuJq4Yo6jYLuIjpEcYWeQck+qe5zqhwR33Kd5sLtmUSAMB0E77dM7UsYS7MHEtdLrlBalEFcTvip3P1xi41I6Aa1pWoqzERkNzIGPXUB4gMxW8r3GoQnT0ZBWuAYW426bFT5I3bMTklREyyc6gTmkXxDIwX9HYfYiRHpTkP0Y9wMKUhKqHiWFsd50WmwoAYX8znWUhbabih00Wjn8KCScXxr6+SxBezQXbtUZbyGreBoHHqQ54/8eQGqHgVhpKMF4BuXyAx/7I8D5SW15zUFiuKAFKhU2E+NfYVS0a9xBpwKR4R8UW6DCqaCVx2z+67cVSUNv98I5pNW1Psfv6oI0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FinETtBzktDBcq8iGXJJzmoA87mTpht+7q+SOrO0HN4=;
 b=suZylAuGsgxOJRjtLz1qPIoJompk170AakA737Duci5YagCMgO/l3KPjSDhqOXNqC/UaApHQRb6iw9Fe1u8IjTw33Ql+Zz1wMy8UgcDveRrWNWE3dEoEfPuqwkBfyMclGsP/R0csAlxnSFmGLJtC2OXxQspUJgd9wjB7BlT8MEpYGyixvG8P/y9+LRVtlnXBlgnFQxEeNAXhXVJcr5BazccRoYNUjHBgjDsfMf7TDbAcxR68C8jmO8VCxQiFcioK3Uqu/eBUICJbyltY82jJqbV8RTPXgCmFWL8yYqcqwlrb3rH23rrkJXI+Ub/KbukN1XlSrpilzzyQcTIv8r09uQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 13:34:26 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 13:34:26 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	dsahern@kernel.org,
	horms@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	daniel@iogearbox.net,
	petrm@nvidia.com,
	ferenc@fejes.dev,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 3/3] ipv4: Report netns cookie in fib_table_lookup tracepoint
Date: Thu,  8 Oct 2026 16:31:58 +0300
Message-ID: <20261008133158.1438907-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008133158.1438907-1-idosch@nvidia.com>
References: <20261008133158.1438907-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 931bc981-5eba-4b81-ed41-08df2540def0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	l26kPuprmzlrbdysG3tLfsbHr4wAUHoV/6y6q9TD8QEx9w7K7A8rr9UvUOeTw9V0jbCA7PnZHBZEI+J5uC2wypoWbPpghK9jKm5WhEEf05Pl5BNXiOyIHi5WjIdwspmQgq7gaRd/0N5GuihiMLHpluJo47vIwTGNN2Q30BQ5OI/u8ug8wPbCBqgRNrH9Aw/Bj2s3HVbxgJvkyJflzAhJ7KBGe2DpiHY8texI4p8eC49Ly+8V2p6YiwIJLtMG3zKGqMpjzrP0KJEzo1j5/1JTEND5MGRHcMlKuMe7l/1Az/32aDAuw6RfkoGFLwgij7Zv5uXX10mvYwTRqNcKLik2ysyuQEkhUVpqjbxtUhJ4wRyKg+1FKIRiixIrpcKFiXSunSkp08bE1oTGLUVI/WVBdGt+On0yfw7EJmziavxZD6jJ3mFsBQmynB4pPRIwyhWyQ3ZPaVwEEkMHnWKdxjwkqsunaP3rJEEULpxxnKr/kdlIUykQ1hltb0g6xSc1/j3emKW/Z5qOyYjqlek5ML7qh/exyL7q5QqnY5bCsY4gb29OkDBEri+XrV0RiK6mTL08++NnkLBVWnsI9vU8iDRjrej1T9s54odJKdnma2zW8+pDsR1Z/4ZXNnB3HqkBE0SxB/9YpC2wWOcPZIO1tmU5way6MVWW8s3Ivl/Telckseg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/vBa9xoPTwl8TcJyPLrtBgO/AM/djX2i7fePmcpRFnpTQ9QQX0RrKS3AnH5m?=
 =?us-ascii?Q?AuWRz7mC1q2KknqtqPVMsz0vhBcsvIO3i2b02OnaX8+LKM7Ckzt0FB1T9K8E?=
 =?us-ascii?Q?P+9Rs8Gs0d0QMemzIoYB2JkdXL3V+QuFVerCaLS2FSB7Zb0W4S7qNqdpxT4f?=
 =?us-ascii?Q?JnRcSrfyI9s5vmalgvL6sO14lgelXCgJN49AFEf46BMb767ZnVqE1V4zGHMO?=
 =?us-ascii?Q?9RuOhm7QP71Jv+2EuYIbgM6x3j4eCNVh15WM55fWWqce18QzNqbhTuT8i2lK?=
 =?us-ascii?Q?IMNiCBRhCuHFpRaePYPvRZ4g0tMn8zSOJ1oGEPD3zW0xLAJmmJYdRoWWTA4U?=
 =?us-ascii?Q?KJyMYqtZ/9wCzQ+FdsCkPQCbkE3JCXWCT2XncNE31OvFliC59HagbwYlQCCH?=
 =?us-ascii?Q?3wU51+Zb62/Zsv0Gf3H//+EdFw9dHXvP7hGg3XyFRarSUTm5DNHoKB91pfvG?=
 =?us-ascii?Q?0s9yR9LG75atZoGcD/I8wvvqXvAcXxTsC43RhiArXALcSD1GlCZSgMxkSgLx?=
 =?us-ascii?Q?8fEG6ANkIayQd5ALFP5lb7doEhdzVOfNrigWYzOEdMFXAglr9tFJQGpWv/ib?=
 =?us-ascii?Q?xP/IqB8DwpsDYLyIgn36O9wgzy66cZOFn9inZUzAl8NQx/GktYYen/vMBuz6?=
 =?us-ascii?Q?j6l0z6OqGrzqWTU+b+1oLknxjq+vXdDOciXLq1mmQaOAPRwp5Pr31LH6hRdx?=
 =?us-ascii?Q?rdIPrbMDHd4VkNniSVFl4QPMYaFGA0hwc9fP1J+uNjfPC7j+fiiHEkE374cd?=
 =?us-ascii?Q?o5+4YGCwqJFCvHdFeVSxxwkFtoveY2fu2xpM4Chd586xWwcLJvO8ojsY3nyH?=
 =?us-ascii?Q?cCn/Rt5XbNT0TzSX1KBqETapgjM8TLIaReI9TbQFjPE3UpqTsBRTiym9hWdE?=
 =?us-ascii?Q?21WlcXM+z0ehyrb/ZXekknxCLWdmLvwCCP3Aq6zKGCAOc1YeVAoX+oY+Ax5p?=
 =?us-ascii?Q?7Apan6wDb+LwmKgE0EUjBPdoqNvl4etdJZvsRBaeuKA9WCXu+kMiLmkDXmtP?=
 =?us-ascii?Q?y70W1aR25B3owjJkQQHDdn6bkc2HTJpxTGW4nCbSMI2vfR/kUnJqY+J3Eo/I?=
 =?us-ascii?Q?SAEudO3SSGpoozmMYZRykxGTCMd3+j27FFENr6UzwcJz6E4guE1xVB4VBIYd?=
 =?us-ascii?Q?SV1PJ4ZPa8JE9urEWIUw7MSVZMiyKyrTfdff5HpZ7z4vlPLA3pMi1/Zde7Dy?=
 =?us-ascii?Q?g9UlqUpS/6MEbsAUDh8kpRgmHfQ1sJORKa4OiDiKeJTw+sihUxmu0OYx+mLH?=
 =?us-ascii?Q?YwnGnkOEeEEfVBk/Ka3+3TjZAARLIIA5cfJiklaz+nRIMdxUkvsx1AuM7Vy7?=
 =?us-ascii?Q?19hQfDtdQAZ6vuucM2svvFGBpe0OHXUQ1Pwa4g86weC2R1MPBn44kU8IfpRF?=
 =?us-ascii?Q?WX7xpKdS2cEDTZ3zgoE8wPkRdHlBs/x7Aj7/NQHOD2AhTuD6vcpSYcmBiF8F?=
 =?us-ascii?Q?D/Bq+bwK66mr1ndoZXEXI3W4LZ1hb7q7gOMiE03FmBgx+K63iwVt898BFJZM?=
 =?us-ascii?Q?FbPeKlWdHa3h2NyxLP4RpY2lBankzEKGVpw18nYqkAIXiV9/Dm53OwV28Rd/?=
 =?us-ascii?Q?qDkrcdNR0+2oPJroZ727K87QYm3zRVjRkkTvv5CXNGPNOd87aLEzOxMGKTU4?=
 =?us-ascii?Q?g3PXIOeFlaTiYcRE5pEd1QqLrmSt6pFKypjXZnPvLtDPxC58GU4FAO0xgD9X?=
 =?us-ascii?Q?mnIJXeaPoW6CDBNY1Dyyy3BTl28CWwhBBOFriK6Y9/4fawCT3CaEkhFSN8Mi?=
 =?us-ascii?Q?+7IQ1RNgCA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931bc981-5eba-4b81-ed41-08df2540def0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:25.9422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECbp/rmNKBY8Tgd0MxO59PHxX7TZg41Qs6idFKcwSKf1TbeyOCjuEMw9tAVk+F+TYAmPWapz92Jq6V0IwM/LIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007

The fib_table_lookup tracepoint does not report the network namespace in
which the lookup was performed, making it impossible to tell apart
lookups performed in different namespaces.

Report the network namespace cookie now that the namespace is passed to
the tracepoint.

Assisted-by: LLM
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ferenc Fejes <ferenc@fejes.dev>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    Sashiko: There is a pre-existing issue here regarding an uninitialized
    gateway address. I will take care of it separately.

 include/trace/events/fib.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/fib.h b/include/trace/events/fib.h
index 341905b5edf3..e0ee14d6ca45 100644
--- a/include/trace/events/fib.h
+++ b/include/trace/events/fib.h
@@ -36,6 +36,7 @@ TRACE_EVENT(fib_table_lookup,
 		__field(	u16,	sport		)
 		__field(	u16,	dport		)
 		__array(char,  name,   IFNAMSIZ )
+		__field(	u64,	net_cookie	)
 	),
 
 	TP_fast_assign(
@@ -91,13 +92,16 @@ TRACE_EVENT(fib_table_lookup,
 			in6 = (struct in6_addr *)__entry->gw6;
 			*in6 = in6addr_any;
 		}
+
+		__entry->net_cookie = net->net_cookie;
 	),
 
-	TP_printk("table %u oif %d iif %d proto %u %pI4/%u -> %pI4/%u tos %d scope %d flags %x ==> dev %s gw %pI4/%pI6c err %d",
+	TP_printk("table %u oif %d iif %d proto %u %pI4/%u -> %pI4/%u tos %d scope %d flags %x ==> dev %s gw %pI4/%pI6c err %d net_cookie %llu",
 		  __entry->tb_id, __entry->oif, __entry->iif, __entry->proto,
 		  __entry->src, __entry->sport, __entry->dst, __entry->dport,
 		  __entry->tos, __entry->scope, __entry->flags,
-		  __entry->name, __entry->gw4, __entry->gw6, __entry->err)
+		  __entry->name, __entry->gw4, __entry->gw6, __entry->err,
+		  __entry->net_cookie)
 );
 #endif /* _TRACE_FIB_H */
 
-- 
2.55.0

