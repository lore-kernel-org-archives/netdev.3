Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144244A2607
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792328222; cv=fail; b=oXBXI8mckBWsrWxGGHAOVBXD4e5NWlqgh9ah8gsvCVzN79WKCI+XJ2T2RnI8/Ni3MYIUYNLDCaA6w44jcmG+/+3TDms75hgDP/FpxVIOpUrFOkrVdWDAK37DQGxFp7GqQtRSZwzgCbQQt27mULhdl4cJEJSFy8b1gNVV4vd3I+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792328222; c=relaxed/simple;
	bh=ail5pwvN2cxSRFJmZgokv6aSaL8Fxfi+LEbgoiOTZfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VnQW7Ogu9LJVXUac+CAqH2SRvgDG3GnuJiMJiTyalqHNEo1gNg0B1Br5tO1b6+fM6bXVHkm56qFcWp3tmxMkLlwntHB06/UFoiYGIPLTZZPvGU9p5w86EpxxkRClLvRNvIVUWir2lxDSoQusX7FfzppjO8AxqLggQRN5+rajc2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jnma2uKu; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jnma2uKu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPj6h3kkYBUCMHEKhyXiOqiOGX25KMxuf5ck0TV6PJGvRIeyBMgdnEstxxfYW/hzHxZQSpUU1yNxtYoC3raKPUF5ssvUWhUlHrYcWGnkt8OHBPzEs8gKSPFBTVFbmQ/QLAscLiLF+uiKxQEvYnt5sCky2HsayJJCXTaxxupi01jyhUPOYLonVUkgixzwQFw9kU0h70uBNeHuMXX5i+wPM4i6b9gh0AeJESNezB/Afrx+wcGbDcdjDq0BANilTpqY3j//bEJV1y6CyggJfUen7Qm4wtug8tyntpkvHy7NvzCxAohPaHara5tbgNqD9MkMJXU5SSXqlZ43glT6U+Oetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7E2B5MgdUK0V74bLE27HRkNrSNK8ZBMQ5HfwBEYlPE=;
 b=w/mUM+T07YO5+nUiD+xftpiNStwOTLmUXRnW0EhWUdvJyCSSZ5nAm/j4PShwBqUsXjtbnA2JaQdM3N+7stAliYEiQEsifIqHP96lqFY4uiiVDOKroqw0cWVcDQZmHr8+boWx/EDL2yqZl6rBB5bAQQ3JM15OqTC7qM1p9xRqCvFzZaVxqBTqctFQ1mI8JZRAaxa0yjHc5UUc6DolSAYa77o0ZdLHLJofAhY109vev8BMRZT0tVo5H9usntp1SzSNFts4ozO/7aeOB+QJhxsfUMLM+06U6Mw/pAwxkaFivnHsQRfpsY5pph7wa31iKwUy5a9oYBTzlM7/6I2kV8QSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7E2B5MgdUK0V74bLE27HRkNrSNK8ZBMQ5HfwBEYlPE=;
 b=Jnma2uKudC3q54VM1HoPUgQXpHxbcxk9qeONpQBW1hf5bAaGR3iwacUD6Px/MMFlPtkosjHWnKSz/M/8ahPx6Mf3aDZmUncF1ThSEOcsTXfB3IbNJLJYyGgqVZbKDbCYC/+7Tig8XF32b3fl01gckKeiVxAd8GZ65wF/HekwfnRC/eR3nMT3szT4iT57qLztKGkChxeB5UBTfhkw3++YzR1yQWc3vJdKGA1wRaI7PKavWmkkmrO0H54Yzi2MgpFzYV/eWnH+qQ4vqMi1za9+2EmudQBnQof5mlEfrQ+9ipNjfVCPEQDnNxMp7FonHbwCSeB1kAIM9vV4TbizOLbXJg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Sun, 18 Oct
 2026 12:56:57 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 12:56:57 +0000
Date: Sun, 18 Oct 2026 15:56:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org,
	dsahern@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	horms@kernel.org, leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v5 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20261018125649.GA2499803@shredder>
References: <cover.1792215075.git.zhilinz@nebusec.ai>
 <192b5c65be8b370c1e6e4f6a31edf03d2606f427.1792215075.git.zhilinz@nebusec.ai>
 <CAL4WiirgJTWD4sqz_v_1=gZx6DKC5psXxEB77hPk1PSGQGi2Yw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL4WiirgJTWD4sqz_v_1=gZx6DKC5psXxEB77hPk1PSGQGi2Yw@mail.gmail.com>
X-ClientProxiedBy: MR1P264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::6) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b29bdd-96f2-4b6a-9467-08df2d174ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	u5v764doZSDenDgmAXRDyXpXuo0SICe4i+AE0AQqNeF/eQDA0lLg438iQl0bgcDo8wSuatP7z8Dcz5NeVl3u4/u+REOYN5stPhrAPlX68AMUoqFXa1d6qOxG+HU7NvCbzV56Rjo4gHicBK601DaVl0Hgn+jDzkCd6nJ2K3sHa5XtrxyQwy0rCrChSsUnTIXICp/w1vneremcg1ARc0PaRDjFMuCKEpeWD44j6hhy7Sl3WPIXRLUGwUkHdZvysGw/McKE73QN0/TDKmT8uJQX1PUwby9AJOm/RIKwNqlyEO7pJyIb8k8KyGl/9pYYnni84t8nHW1v2o0akyqiJ9CLQhsEqRbsu7PLBURAlg/iZGPFGMlAutD9jnop23MICYexnsnOxgYnQjBTv42xIvKlMwPY6ewEhOKrrU7TcpiOyOU+8zKEXtv8LY8ZjNq6Ono0MoZZ2OOkmLb694SM+WCOOPa/B/gZ9OCSNNBGPXHL3J32BiVzY7ccHaS6aFJmEoga+xKP0Ei1Of86vMsCV3+90Npje6cPby3pJXy/USShXltx2V5+gHYhrLg6ZOpca9xF+8QFqunkpmOCqf5TVaIMva1XT8AIWDuzH4LDW5rcvnpN6TmiKKRPKpYyt9h9ri1VON3M2KZ1mZ0tiMPN/gkJ2fqME4v7W1KGvHrtvPQvDdQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hxFTGh2rAti9+z2oVUX+NITcYHnvTlixeob0mncPrRNa4KVH8NSt4ZRCI5bN?=
 =?us-ascii?Q?metUbX6wWOSMNrXYPnl5Xnr7MZEcMLxBtTakV+zAdR2vKQ2o6aEZO4u3bItJ?=
 =?us-ascii?Q?dVvVgjQlBN+V1SA1QNyYI6FGZo0xlbjd/g7Y/J2NSfMwX0hjiB05YbohlUlP?=
 =?us-ascii?Q?EIAO8JwI2Au4IX10SOXsWIUgANpIRSBGnypyQU0l1vm6aC5uvxaLbvf6fbeB?=
 =?us-ascii?Q?iY0MTmBM7WHYblXOkvDAnRD6YzTVKEwFAc70YRqZAtQpLrbglgM+jLinHGIC?=
 =?us-ascii?Q?7sAjZDNMAkxzPYU5R/wkoHvbbEZhuvaKj3T0Et5MfriHmK5TGY0ko7vxYe8N?=
 =?us-ascii?Q?QDFx2OPlHdOqUnf+OqoIaoX7Q6qTKu20zgNdwk6gJDtRpEKwh1pe6OTUqDaH?=
 =?us-ascii?Q?/oPV43PJDgkA7lQbKEBtEoFAMGY/AhDKw45wQHSHcmPQEkjskFFLkkdxSjv1?=
 =?us-ascii?Q?y6b5b92/hCPLh10bKhuH5pkijilMdyyXlIxClMzMz8zxRnQZretnQ5qSzzOW?=
 =?us-ascii?Q?dkSGhtV/VYqWClvIMAFhlKYAk0rvPe+H1p5GYPfSiYaVxFl6bRSpolH4nk/Y?=
 =?us-ascii?Q?lgvqWo8KyRFmvwO5VN/OrEMEqa9lDxkfatdRtviNP1g0V2O82TFANTSP7GIm?=
 =?us-ascii?Q?Pd4QT+gC3jXOXfUGv9hIv2J9ElveLq0o1lwy/l/CbnGK/HsC42MYm8JibpKH?=
 =?us-ascii?Q?snzOW3sylScaxruU5vTbpuw6OEGz4wlZPin7E/hqsafhOhNLDI79FvVUYzO5?=
 =?us-ascii?Q?lOX9qCkP/U+P0hGHqwmpc7pj6dxzX464mlLhErN8KFMLqpXY0BReCYuNLZgq?=
 =?us-ascii?Q?8mV0Z24yVWQTu/XQlRb+lgy2E6tCm14G0qRUHXhTt2/7f6vlfN5rgrbqKn36?=
 =?us-ascii?Q?fGbgoaeCkjTIqscHPzFUECPfLlqOY495gsRTsieZQfCeAj7MBlrMMy+Eg3fT?=
 =?us-ascii?Q?rVnFmTpPhrsi5LWwmrrn3uMqUvDH3G5O2noWVoFWI4GelPkv9pCLnNIz2OXu?=
 =?us-ascii?Q?sE33PbGIjtQG01Y5DwsbUcC5SqcHrvOOUNXy88woSAYq4IDh2B/Ofm1hUMNC?=
 =?us-ascii?Q?EcO4cCri9dOHM32rmZZMvRlJW5DfyYJg5OHb5Hq/zQ659kxKDus073avXrSy?=
 =?us-ascii?Q?KJ6l1/vJnO8IegzDyPvCiMoRPuJvlHva3GF2G/n/cERuRY9UrHiXUH9PJL92?=
 =?us-ascii?Q?nCwY+5YQQaf33EfgCPt9ydppY2Z39ZaPcevvOtwDX3HOaow6UBP0Af8pjaTJ?=
 =?us-ascii?Q?1hbgFE7U9ywDSx+jcBlWw5TyKDATxGiwkmNHmF744UD1SIJsvjW6yq5nmlnE?=
 =?us-ascii?Q?n725++KWlOueGbOx8yGzk6oXLrITBrOXorTMC5/yBwpaOHCpDrkWfxNi6luz?=
 =?us-ascii?Q?RrxqhUMJTWCCrp/VxVpODECdSsrnQv07BO7R+NCyh5CWXONqpZFKsh0cKk2P?=
 =?us-ascii?Q?Ev3TKNuv1O26dnRqYMpicChqZS0FrJZOErJwPIsDqXfVFiKdF6PUEsAwDexx?=
 =?us-ascii?Q?tdRDrUiZ3y2e/AragO7kMm3thbct3PdnZqOFPIu/yauEi6I5oWM7hjzDX+Ef?=
 =?us-ascii?Q?lwLVskXU7z5+RPeNW25ccFCq0BQqBThSBXSG4Zi5BjFONnE+NlEdhdPjmsIz?=
 =?us-ascii?Q?AO6uc+HCViPDy/2L2e7nlWekuygmfp8ahl7e7JrlcUXTnX3d1tlSXVk/qQaP?=
 =?us-ascii?Q?qMtuqjnhLoYCGcgQj+xhB6ASMvOA4p+blY7lkpBWXUFlqKB6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b29bdd-96f2-4b6a-9467-08df2d174ada
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 12:56:57.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIA7dAaKYjbJAY2Rd5aPUQFFO4Z9/l7T+oV8DFsc+n2nwcpQrQP/unxqo9WjH3FfpwGoVymze7Bdh6g+x5+6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962

On Sat, Oct 17, 2026 at 01:05:49PM +0200, Eric Dumazet wrote:
> One remaining issue: for the synthetic skbs built by ipmr_get_route(),
> pkt->cb holds NETLINK_CB, not IPCB. ipv4_pktinfo_prepare() still reads
> it as IPCB: the iif comes from creds.pid, and IPCB(pkt)->flags
> (l3mdev bit) from netlink_skb_parms. Whatever ends up in the
> IP_PKTINFO cmsg for these reports is meaningless.
> 
> These skbs are already identified by ip_hdr(skb)->version == 0, as
> done in ipmr_cache_resolve() and ipmr_destroy_unres(), and they only
> reach this point through the IGMPMSG_NOCACHE path.
> 
> Could you skip pktinfo preparation for them in v6, and leave the
> report control block zeroed? Something like:
> 
> memset(skb->cb, 0, sizeof(skb->cb));
> 
> /* Route queries from ipmr_get_route() carry NETLINK_CB, not IPCB. */
> if (ip_hdr(pkt)->version) {
>         memcpy(pkt_cb, pkt->cb, sizeof(pkt_cb));
>         ipv4_pktinfo_prepare(mroute_sk, pkt, false);
>         *PKTINFO_SKB_CB(skb) = *PKTINFO_SKB_CB(pkt);
>         memcpy(pkt->cb, pkt_cb, sizeof(pkt_cb));
> }

Fine by me
