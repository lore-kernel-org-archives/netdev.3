Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661343BB12C
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466460; cv=fail; b=Z8uKKfIKpME5BFtxvyG9mIOXlJ1mi9wp5IJqD9/vIcuQzPvmcy+3VFcyCb7bbH5TJAtbcylypUzQE9ylXfuCjxke0+M1TtqqqjMamSwfY91Gd2mAVLAqikwwmkv7ZVU4Ue5b4hEnQtAXFwxZ29Tp8WfrV6B67fTHePRQIHq5NLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466460; c=relaxed/simple;
	bh=pb72jcDAoC7Vm7nHpYjms8pk79eZXF/KfWmmgbbR/n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIimnf0kG3nxvIcGLURiUlO0T1W/oQ5dIPyBS3XrMcdORBllwBzUkzYI+aGRtfdv9Z/iEHOUT10inL/oj8hXvGeyWg2n04FLZe8wkrdO1hYYsREay0nkH/eiqSnrKGfxcHf75E3WPPTjy1X0lFHVp2TqImPL9ljgo4LaRmrwP24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dk9hNC3I; arc=fail smtp.client-ip=52.101.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dk9hNC3I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKsCCB5vFHzFxIzERyENYXFuyfNxQoUGz3wale6FedTOF+PpTJJuvvRLN42bUVTzdYdrCFMTq8s7w4qttginLngcjsEZlwDAU2fqMvrKATd7+A5ZfhIR8pA8T0lP/Hbiaae99tFX2H8fGaRvv+aYzNFfXM9DYgfpbcQ5S9z8zCowrX7cyqmDOulW9YJS0yC/IDbHrw3GzMgXFe43Gp7feLoBv14M0Msll/7eBId4CHPpkHcZjiWe0jxrIcSeZ1WYQLdOGQzHc0tWq/MRVLQ+EB5qZHYwU4B60p4TqYHY3c7siwbZ0j1iJ+nl7/OBYXj6koKGYHgsG6nvR1wnohKNGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaQg/lNUH23saZ5yuI7LloPYuBIlgqqXhnxnJhWl3tQ=;
 b=OuQIY18CpQugtypT/ZwUv6gl1oIJ+qsnY/vwVPB+f6scZ88cPzMqLHPrVvWONDfJgfIVq9seWZZ8QLBVTKBGVX4dw33s0jxtJk8vIH76b707EVeiKGVDO2pQjU4Ang+E0LEaDHe1YR3tIqxAWeyLNWhjgKoB20zo9pYIZzdHtUNlAz5rlMbmkP/At5ltjCRuRHtD02kvzWHVCrZmbcRST13zco5aUV+S2aUuXAQ7weLFmpQcmcbdpatgl0EoW8WYrdETMkNw8tVfKF0FqaZ6h4vbwvPWP1qG6l5cif9w5sVpFqy3zlHLb4+Zw7M/bFODCCRFPBsTvHYoG0OIMzEtKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaQg/lNUH23saZ5yuI7LloPYuBIlgqqXhnxnJhWl3tQ=;
 b=dk9hNC3IRR71yL7Pv+SOIMDtGQRdADT3F7R+SjkrS3U75KikiOA2yznX2MIyC7rBC5zvIlHoadt6bd3yNxRgD/w3Q3RFYbV34MVbWAA4UY/tLyWFfBkZo5bCWjokRH5HFfTmQMwsbLwxADq/OYDDB0Qu1n2a5FJ64ziXosuImJByFr8u4gspt11XneIeXt5cvBKFomzD08kB9G8mStTQchSu6E2MpfkqjDlV/1VZFc419hfvvVkrz9DHS6UcBkCyVWsEGBGDq0t+5utCUuYPxMFzmjKxbT2hWR6HQP+hRcPjyUd+qOZuTQf3iOGMTAzV65H+LfilEq2ncvFQp2LHpQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 13:34:04 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 13:34:04 +0000
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
Subject: [PATCH net-next v2 1/3] ipv6: Report netns cookie in fib6_table_lookup tracepoint
Date: Thu,  8 Oct 2026 16:31:56 +0300
Message-ID: <20261008133158.1438907-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008133158.1438907-1-idosch@nvidia.com>
References: <20261008133158.1438907-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS7PR12MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 307faf19-365f-45e5-f797-08df2540d1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+GT1v/NEubUaX5WBZkFdAMwh+inybjuYjp7uPzxHxYRsSd7yxwIW77TNvYgzcagrGYoJptUjpw0LilmXnrLuPDVxzokJBgGKlBEEJkYlde1Mwx3VI0mOLlwZendoFiAt2aK+ykBzVgHFnn8lYGSSh3HcarvDKAt437qKLL7HUs7RIbFz6C8sTqIUl0HHDyojGVsE5xOusCb2vJHWBgdoVQ9HaXKjB76EwdzoODQfkXdHlByF+XiS7uL3DB+7/XMHgGNUV2VD2QFcNmRczyy1O/oUWAg2LuTF/RDmT0kXXhTlS2asDSwluiomHtBNic3BJd4QKKNnUeHVdm2SegtY7Ynw3a72lKjN0Uini14T11nc795haV808uwOiILfu3CxzrvOvrpP4gLor+amYNPqUTN34hL/C+X45MlNXv2+PD5kPYRvV9C4vBfGNpr+VkNvxWSMciAMVSR7RhNsPnmxLVQ1PhXKXeEWxBKbiFjVrw5FRCMYjHbjtQctyl/spKstCEMoNX2GhwYfdSVN3P743Er9wPy4KDXqLGbEzu5KvXis+eSjQDExFnr2RiyNfmzF/7ZLVc35lAVeFrB9AOVngbC+3VHp6ikJDiXbCPqAh7qqv0RAfkQAJgOt7jaLmG1gmDzpi9cv7Kuc5JccHOzcc2gvszR41nO1MCW/jTnkpk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GSKnqUXn03QTPitanY5ZED13BejdFlHYbaEnN5R+ph3cuBuFN+sTtFu6ENgu?=
 =?us-ascii?Q?Jn9IP5M757TEn4ijakqWccW4WiMMcdmq7W3wSLJsmnABPuyz5c1t69ZUQHtx?=
 =?us-ascii?Q?pOuEKUJEvSzT/RNlTEh+bM9emYA2MJ2Rn+t5aHPSA2W+J4LVXIr3sCBlNAb0?=
 =?us-ascii?Q?gc3+yRD3qkotx4etCyTD1NSj8wa6Nbr7gktTKGDTx6v4H4mp6sRgu4eb4Hz4?=
 =?us-ascii?Q?LPAqcUKsyaNn3dksgVQBAeD2XAmqzObuuwHBHg+gn3+otMu57Ee6vRcEuMci?=
 =?us-ascii?Q?OugilMamLJ6dV9Kr12jZeXenht/XnO0Ujy8h8uZ1jJmjCErROTi6t6+9krV5?=
 =?us-ascii?Q?iKJUnSFQPrpYuR/WkYoTJP6oEjj4yvuNJzRAo1GfEQwV4W3ain/wfP/0tjBy?=
 =?us-ascii?Q?mqBLPjJLqgpF8FANka8bYfxizooqgoAeMA5zYUs1powS12EKtLKQrkuY8CzR?=
 =?us-ascii?Q?p8z2a6Dxdk84M6qpo4ZLGmYGrD77Mif4ex3xdZm7Kg7afWFX/betwtunBC19?=
 =?us-ascii?Q?Usde+sX93rW3I2+Hsuy4MpIidVS4BXX/FvtwVv21gao9PSPzoQI/yDu97/cj?=
 =?us-ascii?Q?uh/bxzYnL3CcbZ5AacgirBPr7261Zecho200U+wdy+5EL5nc/3ooBX2UYiAT?=
 =?us-ascii?Q?bNKBxiqtybDBNbqNgYOclVjsbEBna9sbAGnKQFh3AtKMmuts5GFCBFLfFq1k?=
 =?us-ascii?Q?A1TrJoug7UMRMswoUyANVLZoSbzoMiQTyjCDWgX9xfltlbxuEJ6YyDsMI//2?=
 =?us-ascii?Q?EJkzC+DVFSB+iKBr91PMAWN3i6mnmPZ2MdZZm0WR3UIQiaGc8TJIfATofbaF?=
 =?us-ascii?Q?fsICfWHyUGhcxxVIVuO+ghNhXHuEbcIzlHVAceHrPM76PLuwTRP0m8JgUKMR?=
 =?us-ascii?Q?orsYuhWy24qC8WMj7N3B8nC3M3eBX0M/aHiq5lDjHVr0ZihMLdFNJLvBqcGw?=
 =?us-ascii?Q?YODhUU87w0pKnjFx9bE7eydnsd5Ngf0u60aunpDnbytETWGVAI3vcU7keqX4?=
 =?us-ascii?Q?PxkUFafVuZA9ko/5ejOAbod+/9qzQ497UlryIl+fXCoK1UqgT/JHMECvvceX?=
 =?us-ascii?Q?37IPu2FJWxsDn9TCW6lT0TAC3btN7HGAMsyoyB67/Z38IlKB9XUbUd4oDvv8?=
 =?us-ascii?Q?H01IR8zhW6YAhq4IQqFNmaesaatB05GaKjSjkSRvzO1XjEhvZCXr8a4cd1Rg?=
 =?us-ascii?Q?/X8/nCHuVZTdUhCzw0gdmIhzD5J3+0wairBREdGOHiVzJxolsp1nG9LtXMpQ?=
 =?us-ascii?Q?P99s2ZX/ks2QqCWvz6qv1Q80U5VbTus4c9Ud0fzOnMi0P1r6QsmgCI2Ax8RH?=
 =?us-ascii?Q?H2rIpOuIVRyJT9JTghlc93TmwHZocT1UxdaGzf2nlrnfQnKtkB9EXlka1nV7?=
 =?us-ascii?Q?/gUnGJTFQfznXosJiMtVp+9NJ2/omt9I2wlcQ7k6l9ihnerML+sQTExqkW0c?=
 =?us-ascii?Q?1X9yYO9wNRNrGCKFSkWLg41p5X5m1M5vGOC8mcbXS0sooDH6H7RX/rGrF0fX?=
 =?us-ascii?Q?VaUZ1zswVb59rysxsIxYmdrfNaY6TfGy/VYiJ8q/6IRhf4nzUnnn48wBPVtB?=
 =?us-ascii?Q?Gif5LdFFS7Kf5gH38uuaUFA6YzO3ktOBtN3t1gnr0iM8nJubIUi7CH92FGTS?=
 =?us-ascii?Q?7412YMpBLyzlIBjYtj6tVp0EXBdHdD8xyC+DJjxJqDNhGmTxOuqHpb1tS9Ru?=
 =?us-ascii?Q?BMyTRL53MQUISlrk6UimgQaW74mYRp/yTP0ZJVTMdtLvMHq2l5VJQWTXjKYQ?=
 =?us-ascii?Q?MjXzx88JJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307faf19-365f-45e5-f797-08df2540d1b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:03.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFWpMVDk4TNopDPhovtosJZ2a1JloQ6/OxF8I2NMMaKUCdCdQ4QynYf4R4cGflDlyv5bYjW733mPwyLVcTNVYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007

The first argument of the tracepoint is a pointer to the network
namespace in which the FIB lookup was performed, but the tracepoint does
not report information about it in the associated trace record, making
it impossible to tell apart lookups performed in different namespaces.

Report the network namespace cookie, as commit 27cb3de7f43a ("net: add
net cookie for net device trace events") did for the net device
tracepoints.

Assisted-by: LLM
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ferenc Fejes <ferenc@fejes.dev>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    Sashiko: There is a pre-existing issue here regarding an uninitialized
    gateway address. I will take care of it separately.

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

