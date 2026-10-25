Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792933874;
	b=CVJki0bS2u+N/uTqaBnpBLR7mlHziT0luedd1ulI3MxrcRabQI2Gj8jM+OofMQdlikOA
	 yAXdS1/4JvsdN9269fNU848lS56++pGZr/trNN6bR+dYhl9eeVj3/VPmtNlwVaNlnG5th
	 ByAyma+RjVhoMnlxMXEFDEDCXQ2ymXYAZgEBqCXNp0XJkOZqVBgaeiZyann2eNzJtMddU
	 un+F459p9aU01JNOhzEVczfBeuFeLFhyPXVxTB8haej9C0SotUYTH4z91jgfTo2RjkbOr
	 T36PsI68i96VTdCezQh95BSlal+Z5i/Senng4HSkfMW+oT6vlGsY64p9akE3r38gv9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792933874;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=rpEJMY+rtu1pTSn87xMoC6kBdDWN48RkkAUIT2ehl7o=;
	b=RmKPkFnYxSNQ/eCo+cubgmfcwrhCcDcWoOrBRLS3bdvnJ9DDcBiwCd/Lu0RG6e8bFRHc
	 pGEhcvH/fic9fHBdGbVYicKbBXmarqBkbDS+cwEK6taFhV0Ss1P1ra+Q/OxyM1DW0XXNH
	 7KraCKa4qK0lH7gCLaqonjarrivdP/QYHimlEUBGvXpZCLW2ms5LdlyLDTgLu3CJRDT9h
	 SPWUrIwZGcddETBRfjqiS++zDmn0ywhrzEOHsE/VZAH+1o6nxFzBgnQCUhLLC6mKLPuTL
	 CpFwXwFoLmFCSCTY24cLyetzvTFAJtmTaSqDl8sbeI1l5113O+6jcxE4wv3o6/egUTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Znvbka5i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.7
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CFB606A31A;
	Sun, 25 Oct 2026 13:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CFB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Znvbka5i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebN8Iqldpm45+eMEybf6D51zl18RTcOBj/VUAAr383qm5ASfkgLyHmuQeQ5LN2ZlcaRDlJwmGGK3CZbljvraJNQqbrF4GEKSWjPKzWMn595FZbccQWYvaU4TVvozvPRGq9Hah4C4ZtWqWzqPX4Hww2wjNpkjPhgrSxvMPE9jGoxEHXB643SU5c1nRRA7DTTo14kOsQM+P9Pz+I8kDn7FHh6krj0Boir+m+Hy94ihNMq8Z+nEScBHPYjUbbaio/u0voPwVqlQjMLoEHiMCuXdHfw9W8x5L/Snie1MSc2hAzKFgHjbKjPMhn/bgfQK0Okw8B1Oc4ycse9+vq4E5Yz01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpEJMY+rtu1pTSn87xMoC6kBdDWN48RkkAUIT2ehl7o=;
 b=u1A/9+dWADzwHrKEJbvY3uXS+eESTF+CVrTRX7UFTHnOcmtY293L6kQUb53vq1TkqL7S5aoiaYywpBJ+3sNry6erIQVSsfOjtw0ZXNVT6kSUuYyzYX3P5vXG9OPS1x8bgHU3TVnH559LRB3lSgT9z9L7ujjfxeDh7vwH06nP6MJVS5oIWHmuPX9YP22SIW+MIZYN5ScfIydoV2nuAj7Xh2Us09WaPXCT6/zCZVX2+y3wPxb5ijbwjSxbyKGJ64P1ihRNPOi75yP14tQ+7gWQcI7RBk1t2UjiJIEavEfl0Dnl46TtCY0AHMbWhBSRgPpMpCxdud5CZ2IPEV2K8a5xIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpEJMY+rtu1pTSn87xMoC6kBdDWN48RkkAUIT2ehl7o=;
 b=Znvbka5iuH8kPTEddeKBTwft6Xb5dRA1HLHB2mZPTGvbB2WxZwVFiDS5ByQjGgB8DpK1eUs9oLSMXgkoojtQvjZCj63H87T2Ia4Et1LIF4zAGXldDXEcEHzFzALSt3ggmIJkUujNH2cOndW7fiGOpO1dqupAGZFqR3b1hD9b0rqPHMTmhNlm1z6OwCYbkk5sBZFZbgWmHjKB8Nit2urb8TYlaDG+5mNhMv0w+pLh/cFvH3QmeBxZP+G1FVSL5gZ1h3iiE7kbJiPV6L0qghdvhIltNcaSXga3pHLZOYPePgN5Vj8+i5U6NlG7KmYYOaXjjElMtL/Mow6KBWVs+JII6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV1PR12MB028288.namprd12.prod.outlook.com (2603:10b6:408:515::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 13:11:11 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 13:11:11 +0000
Date: Sun, 25 Oct 2026 15:11:02 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Add NETCONFA_FORCE_FORWARDING to netconf
 messages
Message-ID: <20261025131102.GA184152@shredder>
References: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-ipv6_add_netconfa-v1-1-94d14b07d621@proxmox.com>
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV1PR12MB028288:EE_
X-MS-Office365-Filtering-Correlation-Id: c31b3cb8-e726-43ef-569f-08df329970a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ppXKX0/XnU501LMc9nMX1e+yx5gRxIgrLM8ospSyr9G8uw68ZYXtCYum8flNg0WKZcoX7iQK4BYV/R+OGFLvwl+Tvc3tg2siO13K6ksGnog+gPj5sYAe6nxgkGD4a78sVBPioD9KGr9yDpCR6xDYdrGmgJK5zMv5hTkQFyOZKa+IwbDO/2/6936f5dxZC2Y95nXHYD7n8ZAyrC3XoEQUkwbhqTg+/ifeiu71xZJV3nRL5CHT7F7VaHlUqAvV4Gn9iNUF5Mgbwe8oG2dISMhVlBNdh+r5v68hDlSJnNZb3OI1i7ZeoIv/BR/sqDPStwKvyXMx6dY8qf6mM8EBB0W07k5iRHq/GErTyw+IQEweILVnRHQN8lr658xDMeGJPC5dnlS+yKu18jn5KT/ml60HfXBjpVgf12PdQu+PDhaXSTocEv9892zu9JW/woLyxUo9xiwW6YY4+8+2P8QkMZs3ODbaTw9xjiGni5jUUU54J6jR4olTbgFMnfTD+UFRUHMh1a9t6YYFmVXACnWMEh7qjZHA4OkQNuaYHnuIuI0o0+AbCSfoJ9lf/CdrT7/appfUQeTheXxqMyfgHZMluwipwmV2nXh9kSjB5Dw5U46KIDxwPygw2x9ytDA8HZcommfoAwqaaR2BwI+2ZoTuFhyTsoCrSIDl8KWuBxTKvPCE19o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCELb9Y7FjR26dxkb4yaaN3/wLUm0tYb4X3BDUygNn+/qW2XuLyUTNSfHld9?=
 =?us-ascii?Q?hYrxEOOWhTMymsn/kB3yVvGtzaWYkrQ7C5SBEan3uKM79SoKUATafPbacMTJ?=
 =?us-ascii?Q?GUTTof10OJ0EU/c/cbZHk50Cl7ity6UTljA0vxku8b4tO6BrKp8Vo3ql6KG5?=
 =?us-ascii?Q?i5nTs/UVVv+vxoeWA5nSTege8stTGgaFo58vhEJLBkJsxjpWpoNru6PkLetG?=
 =?us-ascii?Q?4/Fw8JXWjT6jcqcM67ss+WXl8eiiawB956y9HAL66oNT6sjo8M+qnyj5ogMJ?=
 =?us-ascii?Q?oFH6zn9exWY5PB775w2J1a2NY833qKjp47hGBbVs6BrLOM/VRqHxC2Y00yyG?=
 =?us-ascii?Q?ZcVRR8gA0SlXr5ARa73VKLnGY1rsuLvSL2TZYM7mcl/iioRonfZdUYyj+m+1?=
 =?us-ascii?Q?eJ1JEfxdp7CFx4Dt0Rtoqm1RAEDJfEgGCezpRpx4LBth6/lo8jZDeiYXxit4?=
 =?us-ascii?Q?v+D92ZKJYtKGufRgqkWx5y93GRHbDsnLEtSJ5xMvYDghP839plqLqTIXhiGP?=
 =?us-ascii?Q?nNHs4uX8lJ+Fhh8ljL9SnwXXIv/wIFmX7T9k/jn7YZSwFgwu6xymz0CzCg4f?=
 =?us-ascii?Q?2NRDcL2ZHe55Q2SksrrAXl81emAn7rpLSjeJDYbIQR+90PhP/SQhZTBdvaSZ?=
 =?us-ascii?Q?qpMry1azzMMUjdtToEZA+TP7SYxw4YCwFiJIwRZ0pKOO2UWKqjmr1XgiC2PT?=
 =?us-ascii?Q?PbkOvc4gTyYV6icQzp9GAGFzEdQcYINDoqtsCSJHGXlgLWXp5zXLOdzihPGg?=
 =?us-ascii?Q?IjsQmzR1Vp8JglEuN0nMYLIArUJjVHl4J+AfD2zudvAvFPczcjEcvWr2ETkv?=
 =?us-ascii?Q?rWl+ZScbhfiruccqF7wlAv230F4dZqEL67HEfUkPQdIPEkhZ4xhq7VX99X2Z?=
 =?us-ascii?Q?MMM6CCAOj5TNn4sDN0w4DT3tGsmsMlPr/OA3MldZJF0Iw6u70W1ULR+fplSQ?=
 =?us-ascii?Q?x5tpOUdv/3dojmAwUAkwVYvvmTPBjyuFoDNvBob6irhJPVW3ZPYPb7tsnPFt?=
 =?us-ascii?Q?dyDON5JBZ9OmR/Z84W83ZvwtTk2ZlCusmz9wa9s++tle8fz+XzAn3oMfifZR?=
 =?us-ascii?Q?pg2aEvOlxhhJFwjazyuX5YnhKqhDGRu3dzTb2qa+enTjqsfyKZg3zb/Ck5vm?=
 =?us-ascii?Q?MLs0nmRnQmydw+wlknh/n+7FyalKTuWH0Cuy97ETnnlIK0k9PdDqHobaxvT8?=
 =?us-ascii?Q?JQp7th1xF87H0F/rWcrCRdIreobJRD6JKG2ZBwFlUbsKAPtClPGZKhb2iP4o?=
 =?us-ascii?Q?Ej2BI292MmnGcpNVGNq/rtwtkXTL1aILYw78tHpqFbV2fgvboS0uU+u+wzIe?=
 =?us-ascii?Q?bb8KMCiFRwQkwA9ngq+/tE6MRIPrpjq6X80rNBR1SKD9n0GYYjxtGQNJ92Os?=
 =?us-ascii?Q?U5rjHsSvMpj8amZ7AhzPdf/ndD214qiWbtOLi7+McU42JOpzdZYXBg45vFEz?=
 =?us-ascii?Q?Yt0nBit413UTZhrhgegqEpTV7LtLQW5sEH6Je4yhLtQmaJY9syhBmfu9uZcF?=
 =?us-ascii?Q?DfuxMyuj1f6Ph48I3NyfYNm/YtY2uMdwgmrwTsThg2yeaI53gnQKfF8W7S8d?=
 =?us-ascii?Q?SJfEjP/Fy4brqyTV6J8WJefsz5dfwVB4h6WFn0MdLyPTCbv+mo0lPYgHHIuT?=
 =?us-ascii?Q?429Z4ZgPyJ9gQFvwKSakUQ5G/U9mBhGoSJVf3DhWiXdRC3FNA/dXDEvBxbyh?=
 =?us-ascii?Q?L7Wb8Ksb+zGgOeMqI1Ok/GqI2a9IFVkaAekfehXIMsUI67kp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31b3cb8-e726-43ef-569f-08df329970a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 13:11:11.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDBJJz/Vp6fCXr5SKKNvtFalzOuvA0//hhdBASsKnZcULySXFYETfpbP+6kYygsCc37h2WEyMaaTIS+SY4mSig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB028288

On Fri, Oct 23, 2026 at 12:59:18PM +0200, Gabriel Goller wrote:
> Since force_forwarding was added, changing the sysctl sends an
> RTM_NEWNETCONF notification of type NETCONFA_FORCE_FORWARDING, but
> inet6_netconf_fill_devconf() never emits the attribute. Listeners only
> receive NETCONFA_IFINDEX without the new value, and RTM_GETNETCONF
> replies and dumps omit it as well.
> 
> Fixes: f24987ef6959 ("ipv6: add `force_forwarding` sysctl to enable per-interface forwarding")
> Signed-off-by: Gabriel Goller <g.goller@proxmox.com>

This seems to fall under the "Not a regression, not critical" category
[1], so can wait for net-next.

Also, NETCONFA_FORCE_FORWARDING is not emitted when it's disabled as
part of:

sysctl -wq net.ipv6.conf.all.forwarding=0

Is this intentional?

[1] https://lore.kernel.org/netdev/CAHk-=wiSnTE9vBZ=5_v+3EEkdazCCbBM5YABRzRHUAeRdyd4Xw@mail.gmail.com/
