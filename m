Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C2352027
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521826; cv=fail; b=rJCooY8zw1cp6GhuxgRNMg6ZK47HfcDcza4IENzhfLSI0EqtPbS/WKkZvpTWmrQU15wwghSaoWgd6Ntf9rhpN9VoLTzHrEjHMwYVMNRz3PLU4D0k1zIV+RlQr5h7R7Wk5bEnC8dsJ85IH9QV2o28jvqNwwmRvH66kCAb+BaySYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521826; c=relaxed/simple;
	bh=Xdgwsn8Spf6mw/6yJvBot5Mnq27mgrq3nNceJLx5l5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L1E0KxLkVcX6O/PtMI8iMyonG086Upxi1A/qarCKCew5lUyQTGqD/P+yzn0MwP8wMu+TG4FyglgDnfS6JFtrjaRkqJttAMs3xHK2cFpnzNO24MotbCXghYeW0If6BzpwbNAw3gXve7cQM+oghekDXLWdaEda97QihV/UldHUnMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BeQB/POi; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BeQB/POi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRHeeP8WVhIeaoUTqRIywdUhDD2NslNKOK9arNPhcFnmmqM60g37YV1NMvW/ge2OpY9yIIOeM1NNg9lcwhIiN6VLINvGj3sEK45MimX8TjrPr+s/hdb41UGFx7ZvEkLDHUJeBdNgdArgMOVZqfKjlEn2wBSExncYSm0ZJHHt9G5rqoMsI5PUmmhm6HtYgI3V39NWAQN/veozdpDHulNPgOLzpWBqPXUZwXze+Q4U0a8ba5xRGJ57Wfh6bJRoxgJVVxkEvpT91Xh0T7CAeB6P53LHA/P0IaarzuikGtis3h+aUiZEXhp5BvNt+8kzBn3mEbYhrpxkQB80WsoJL0d5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcI7ib79alSi3P4B2ffM0MgwrdjFGxw2zOfqCtDibXQ=;
 b=M42XiqqjdXPZlQoNdKHef5TzRR5d7Dl+x8OTwBmSSeT3rGa58ck7Y7hixL6VUOOJ95DamF2mZR/bSb9Pe5RcA/EwUF7QEsrebTjGaH+f+DJe4Zd39bmMfSsyKQ79pL5jmHhEjrR0hxnaj746gejfEoXHXfCyOW0RPm0NmETuTI2XjZZ3QEz5Szdf6lL0UGD1AFAKYZSBRiQmZgtxt8fWtz0OdDdT7IrFiRG/xFa1O8K0aofMkNsthI8UTID+7K7Tj/uDWWDi4T2yzoqk+b+1ixijMCkWcTRzv20y0rKJHr2UJxXxzFDA6ckfWcCrke82cK4bCdpuEPHXrCMWgbc4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcI7ib79alSi3P4B2ffM0MgwrdjFGxw2zOfqCtDibXQ=;
 b=BeQB/POitvvPsbFd1FmenVIJYU8+WEbuigNv4AAC0uJ/4c2KQcOGsAxm9ipvHQPT3aSrTSEfTt4gTYeSI4oYW+R5fhiHfcwbv4o8u7DgnyfvsIoUhENJYSrwlW4yzqWGWaVOmVyXImQTboWNFpy+Smgo2fARXAVVNRhJzhnWIAIKERjD0NZNIXrKDD6jGk20/D7YnfquIZbzd0yIinfl4UWTr052Qr/fgjHzXUa94OuNpSi6wCJs5eiOYs5XyBBchUD8BPSCfC2YpvJVgAtdyYEa0IIoinGGEZB2ARTMfxKJA1FNNdlkJUOOYM9neENRP6z4FWxJ8+XU91iKiFyh2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Wed, 12 Aug
 2026 08:03:38 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 08:03:38 +0000
Date: Wed, 12 Aug 2026 11:03:28 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 00/15] neighbour: Namespacify arp_tbl and
 nd_tbl.
Message-ID: <20260812080328.GA3281318@shredder>
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811165453.GA3163487@shredder>
 <CAAVpQUCiW3pPVBCXJjtpqmfkiX496YiMwjpQxx3R8oqpupLvCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUCiW3pPVBCXJjtpqmfkiX496YiMwjpQxx3R8oqpupLvCg@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 662de194-7212-4c08-ac3c-08def848373c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|18002099003|22082099003|56012099006|11063799006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	M5wXt4EYTAhFfpHSG2TFb8/VtByoheIbrpdbCiADZcWcL425TKYZ4VUuZMNPMHia7ouD+oSYi5AcxhpEoZkL5hx8oXAultBCJJ6xWy7l4iOTnI9NzAXGhf9Tm5unLUC3fqQGhyBnWmZ3gUWxPJvLew9YwQrMaOMMxtcD1ziLMJscjWWIH3Ym4A+CyVnzODgfvlWK5ZMMvNIyLrcbIHf9iYFSTR9p9l0oaWZyiNM0zmNhpmKclXMcgKuUdjp6L5cIz69nlUIhc3Up1q56o85GD+ZC+t6No5vq0CYUzOLasWQfXtCWw6BS0sJZOoq6lCXbukfj8/wPFicRIXxD+Ha14Lr1lEbrdC8kO9IymXYFesGgpJIVkWKxKp5PpSlgfWNBi0oA2i8HgciXPZkCxRpyYv1Dz7TV+uzIpGla4IiXTOkyUY03Fr/kkaJKog8kvJ+kHdiSuaKWcAxiIFDaEwVp0rP66F2naBlV0r/8Ec3yZdlFL81jv2Mu7Twb+o+xWgb0eU7Zm7aG0KJg/wUM2tD+y3AAgFXkc8Vro1fqEobpLN/ONKdndsZftQEnNS5MdirMPt3vWL+NIOxry1RezwjLeIA3vIfNfDUAK0qL0ek75IwNHPVOFppNmEh4GdPrrMJznDTC4U3PRwYDapK887wZQIj2/13h7Nf3iWpOCK+bCuo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkpaQ3JkTHVjR05wai9qbXk0alVSeGtsZ3NyL01tWTk3SGE0SjI5dnpwT3V5?=
 =?utf-8?B?cTN0TERQR1lyRllkMkoxeFR3eHVzZ202SzF1RjNFdkM5K25MMHR2S29tQURl?=
 =?utf-8?B?T3FHSHprTTRnMWo1T3kvL1Z2UmNCcmJWNzB0c0FEamErVnZOVVBvWlNNcDJW?=
 =?utf-8?B?NWNDNjFMbGlnNDMybWU2eVNVSURsSUJuSWM0NFZyM2hCcHQvR1NyMjZzd1RW?=
 =?utf-8?B?dmF5c1pwV3Y1YVB0c2djVWN1RDlsSlgwS05LM2pEcTVDWnVrTTRlSXpKSzR1?=
 =?utf-8?B?T0dpeUtoa3dMdE5aVzhjcjBjYTRENWJEc2ZFZW5hNXUzeDhJVzNnNXhMOFNB?=
 =?utf-8?B?NDErWURCUzdvakFPNHBOTlFQaE4xRFVoUWJPcGlPVXVoMzQ1NElwYXVIaDl4?=
 =?utf-8?B?NTFvTk5tWWZFanFNSnF3L09lMGtKRGVsNXNvVkJzTDVoTTdZU3BtQ0czRkMw?=
 =?utf-8?B?K0NheERFTzNxMVYyM0ZuV05namdNZXRiQmx4SXJtdkRmbS96WDFKOGJnU3B0?=
 =?utf-8?B?bFRqUWJoV2FIeVMxallxUysxNHZtalpNSmt2OFZ4S0R2a05YZDVIaG1wWmJU?=
 =?utf-8?B?U3R4aFRhcXNtd3ZZYUxHWjJ6RjdQWWFDZHJhOTE4WUl6dEdTY1JEd1pFQ2dD?=
 =?utf-8?B?N2dRZDdVK3U1Y1F5a1lNNEh3anB0MWtLVkZDTHFlR0xxaW1ONjkwalZ3Tm41?=
 =?utf-8?B?NDJPTXZmcGxNNHFaYmZGYjlHTU1VKzRXb3RXZVg0MTRwSXRjV1ltOXRCVzRE?=
 =?utf-8?B?UWJCWWNaMHlMeVpjSU01NjlwWVlnTkhYR1JXTG9XckRiNVZTWnUrclpzcTZ6?=
 =?utf-8?B?YzYyVElvQVNVM0NQR2JKZjFTYktaQS9uOWRYMWkvUWNsa0lCMEJWdjlvMVJP?=
 =?utf-8?B?ZEQrczE0MlUwc1Btd3E0MEJCcjI4Vmw1cXYzcVdxM1huZ2pENWlha2VzUUNv?=
 =?utf-8?B?Z0JsTVZyeGc3a0FpQXcvRlJnL1UwZ0VtM3lhUEN4NVIweUx0SzhtanBNNldZ?=
 =?utf-8?B?MFdsWW4wRHlGN0NaZXI1MERXUlA0dGVaMkZmSnFvbTIrUGowczRoTVVuTVpB?=
 =?utf-8?B?NVlyeS9QNmRFekxLU291RWxKbTVGanFsdm5veTNBOUZCZjFmamV1VGF1aTA2?=
 =?utf-8?B?aDZNa3dHa3VvRWVWaXNud1NQQnlGbnQ2cGF6SS9lR0pVSzF6MEwwbEUzU3FK?=
 =?utf-8?B?Uk4xaGFmdm5wMnBaaDI1QVpVZEw1b1hhcG5IU013a0RkaExadkZYK0pNMWNK?=
 =?utf-8?B?SFpxU2lURWdrTU50OGpLbEk0Y3hsa0IyVTgvVUZUenR6RG1HVVlIVEt3TW9Z?=
 =?utf-8?B?RVkyWXM0WkpsRXl0RlZUQ1Z0MUtGVzRQK2pEL1NQUnZFYkUzc1dVRWxLdVIr?=
 =?utf-8?B?N2tWOGVmN1dDSmUzeU13d01vWkVXSUhwRzBnWFdMSGdJR0RoQ3QwSWdocTdY?=
 =?utf-8?B?bUhhYmkrOVNSK1N2Y3k4Q1JjVnFkb0xsSUphS3MxRExCR0pCTExkQjcxV3Vi?=
 =?utf-8?B?a1BYZ0QyTTFvdXE1RHhsdERQSkRDZ05qZkF3MUxmUzRwL3pyTHpGSEtOaFNq?=
 =?utf-8?B?aDY2STNoKzhBUWRFZTYwb25MWE9KMnRVYkRLTmcwMGswVW5ZSmgwNTdBNUtq?=
 =?utf-8?B?Z1ZmcFMxSEtGbm9ra0E2V0xmWndlcjFyWjJYb1JhUE1SZWZ1dlNhOWRnMjVY?=
 =?utf-8?B?Y3VFY2ZyNldQK2ZHc1R3NnNiZ3NnQTV0WkVZRDZUQ1g2UGhPanpldllaR1I3?=
 =?utf-8?B?TzlHakFPZDdGQ012YXU3YnRwWjBVUTRFVmQrc3czWjhXUG9YZWNvbHZXNXBK?=
 =?utf-8?B?WFJSY0F6ZGNwTXJZZWRyaWhzSDA2Z214b3FyeXJsb3pDRmpoOVB3QmZraFpX?=
 =?utf-8?B?SEZXYWJUM3NUTkhxQTBremJla3RtWVdyRFh2azE1a1pybVNWM0JRZEIzTWVz?=
 =?utf-8?B?OXFveG5hZk90VVpldGlaVDg3SFFTeEpYdEsvWmFhNVFiQWhuMHgrYUZNUnNs?=
 =?utf-8?B?V1J0OE5NL3RWMmFyMFFsWnVZY3VjenlqRktIb1QvSEpMWSsyUnJvS2RIOVk4?=
 =?utf-8?B?WFBqNzFRNkMyYjRSZ0Z3dnFLeEZzNGE2VTFkSjBtc2ZMSm5ET3o4T01ZRFBa?=
 =?utf-8?B?QTR0anVBczBnSmhPNkRXRnhNakU0NmlybkEwZGJoUXo5SFRxV0JUNHZkUnZ4?=
 =?utf-8?B?UGFUSGdoUVlSSG1lOHkxbnpJK1B6eVBXdWV4N1VyTlpqZkFoejduM2U4RVpt?=
 =?utf-8?B?QjJVYy9VblZabDVXTk9pQWhyRlZNR3VuWTlFZkF3NC96U3RQWXRFdHNkNFpT?=
 =?utf-8?Q?P9Sigj6ZiEfrVJyf2U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662de194-7212-4c08-ac3c-08def848373c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:03:38.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeEn5Ge93QAUjODsxOMwuHf4me0+24aPzcnHzRmF/DVuOUhiCZJsLIHlkT0DE6fdSHMqOx0+fQWuaNLd4R3AJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839

On Tue, Aug 11, 2026 at 11:39:36AM -0700, Kuniyuki Iwashima wrote:
> On Tue, Aug 11, 2026 at 9:55 AM Ido Schimmel <idosch@nvidia.com> wrote:
> > Another thing worth a discussion is the policy regarding the initial
> > values in each namespace. With this patchset, new namespaces all get the
> > same default values instead of inheriting from the initial namespace:
> >
> > # sysctl net.ipv4.neigh.default.gc_thresh1
> > net.ipv4.neigh.default.gc_thresh1 = 128
> > # sysctl -wq net.ipv4.neigh.default.gc_thresh1=129
> > # ip netns add ns1
> > # ip netns exec ns1 sysctl net.ipv4.neigh.default.gc_thresh1
> > net.ipv4.neigh.default.gc_thresh1 = 128
> >
> > Assuming that today people configure the initial namespace before
> > creating namespaces, changing the policy to inherit from the initial
> > namespace will probably result in fewer regression reports. There is a
> > knob that controls this policy for other settings (see
> > devconf_inherit_init_net).
> 
> I considered adding a new knob like tcp_chlid_ehash_entries to
> control the behaviour, but I was wondering if it might be rather
> confusing to people in the future that only GC attributes are inherited.
> But I don't have strong preference here.

Why only GC attributes and not all the default parameters? IOW,
everything under /proc/sys/net/ipv{4,6}/neigh/default/. Something like
[1]. With it, I get:

# sysctl net.ipv4.neigh.default.gc_thresh1
net.ipv4.neigh.default.gc_thresh1 = 128
# sysctl net.ipv4.neigh.default.base_reachable_time_ms
net.ipv4.neigh.default.base_reachable_time_ms = 30000
# sysctl -wq net.ipv4.neigh.default.gc_thresh1=129
# sysctl -wq net.ipv4.neigh.default.base_reachable_time_ms=40000
# ip netns add ns1
# ip netns exec ns1 sysctl net.ipv4.neigh.default.gc_thresh1
net.ipv4.neigh.default.gc_thresh1 = 129
# ip netns exec ns1 sysctl net.ipv4.neigh.default.base_reachable_time_ms
net.ipv4.neigh.default.base_reachable_time_ms = 40000

I think that's closer to the existing behavior. We can add something
like net.core.neigh_inherit_init_net to make the policy configurable:

0 - Use default values.
1 - Inherit from initial network namespace. Default.

[1]
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 07c62268fc3b..0b55baecc55c 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1913,6 +1913,22 @@ static void neigh_table_clear(struct net *net, struct neigh_table *tbl)
 	neigh_table_put(tbl);
 }
 
+static void neigh_table_inherit(struct net *net, struct neigh_table *tbl,
+				int index)
+{
+	const struct neigh_table *init_tbl = init_net.neigh_tables[index];
+
+	if (net_eq(net, &init_net))
+		return;
+
+	tbl->gc_interval = READ_ONCE(init_tbl->gc_interval);
+	tbl->gc_thresh1 = READ_ONCE(init_tbl->gc_thresh1);
+	tbl->gc_thresh2 = READ_ONCE(init_tbl->gc_thresh2);
+	tbl->gc_thresh3 = READ_ONCE(init_tbl->gc_thresh3);
+
+	memcpy(tbl->parms.data, init_tbl->parms.data, sizeof(tbl->parms.data));
+}
+
 int neigh_table_register(struct net *net, struct neigh_table *tbl, int index)
 {
 	int err;
@@ -1923,6 +1939,9 @@ int neigh_table_register(struct net *net, struct neigh_table *tbl, int index)
 		goto err;
 	}
 
+	/* Must be called before neigh_table_init(). */
+	neigh_table_inherit(net, tbl, index);
+
 	err = neigh_table_init(net, tbl);
 	if (err)
 		goto free_table;
