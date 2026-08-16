Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B822F1FEC
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 10:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786877095; cv=fail; b=lMS3PbaiUDrngmpBfTGwYxKHbXDptA3M4E4NNavf0hm70hOy0KFb7huK5pJ+rJm+kb5Ch2JPDWuFjc3KLtjNx/EsGKaQDLAYWPhAgK8jgW4d2dp8OxC1I2CPxm3HFGwYMKZWVzSblrwOT26THpDGfjSumEkzvaSlFTh9rvAmSuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786877095; c=relaxed/simple;
	bh=mr70BfyrijvRSsMjIAVNcU5/obC+k9smSggIxp7x+V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tUKEx0yTzI6UA4xwTV9cm9oetkHh7hTit6fDZd+kSXlRxkcBwS5UQbdfH5k1y8+VodBkCHV+qUnB6qIx83nzPrxUgbyN5yHYjQ9RlAe1KW5RhaE3BvfvfBFVOuQP/Ie8NqdmlRur5dqRFdTsndjEpAtJlF90H/cqCIld/UAGmGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lUSLEH6v; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lUSLEH6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxwjJiro/mp03he+sk4qyg2hA5/6GkZyY7UhuD49HKSJWt1e/18EfBvDpE/ikTNK1VZqro5PBYqQ+vANWN003l35GxaY4j25tAUThqdQQ16QmhodwPIOez3BLtEhkQiZrgJff8BnObVpfoQdlx3+nxiArEwJk/xb8d/y3UZ0t/m7mMJSp+6B1a1BliYwVij9aSf110FxMv1HbRHglD2sdpFiP4owa0R55rQKNJJRlc1AbJhkIM/iX9kO2WVFDded2t+sCkmaw5stRhZPQkfpbzqDU5x2YWNnwj36uW63W+SguRdefBBR0hxTF9FuzmpSO4Q5gePW/mtYLY/aKNxIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7nWBuXbawTcNZ76WLKp9WCQAA+y0qVcmrTavTRcfLc=;
 b=jQa5YglU6oBKuGuJUJWl7u4/05QCvx3P9BGV93u7VvF9F0II3jlME9VFtYFTcfX//e1VP9vAb0uKp3LFdzvOQ2d173iGE8AiYnJh7nULa30G6jdhVrmzauTEv4MvMut4kwGrX6CJV5uxF9psOhbJHwxms1KBOgpgiGLayM45mw/XNeQeFGYFnHQ7wtR8WVw0pdLJd2f0Ie2HJ8EhMWhRNZzo/jkIzJ9vnY3qAakUVdG1Ds6WNaQVoDciyUHW9lHztrIZP5DdOfyqbOAwDNTBLostPxFlEc4ZxCgeAL5iBsgibb987mQsELDYT4YdtzNBBqU+uJPTj485QbMphvXfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7nWBuXbawTcNZ76WLKp9WCQAA+y0qVcmrTavTRcfLc=;
 b=lUSLEH6v/DT6+r7PIh8BXULWoOwHtjX3PbrgTZHbhvLoonBqq4pjNiOoS3Ndi4KIR62RUXFSpJ8E9h9Zafql7+u5WrKcvt+2bM0B2Ae4CXLfWxRsTBtGYau4soxlTzi2jAmdGsWTmdW6ZUQvFHKw4eKYSD3zrG4zkcu7JGF5ENe3XoZsMiwUpPQPytGT89IRjycmyz7cm5+zBP0h7wzCgy8PRn64/aS6yy/o7Pf9jw6sxOoxlEZeHxVdfuTF9OwMIjr1uUSAv9Jopa8RKM00orsGxVK8duihxCADd5OvICBigu4PZ5pD1knAf1AaVpvQuHuaxK8x6Tg9bGvQDss+og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Sun, 16 Aug
 2026 10:44:49 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 10:44:49 +0000
Date: Sun, 16 Aug 2026 13:44:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, vega@nebusec.ai, edragain@163.com
Subject: Re: [PATCH net v2 1/1] ipv4: reject undersized MTUs in
 ip_do_fragment()
Message-ID: <20260816104440.GA8589@shredder>
References: <cover.1786599079.git.edragain@163.com>
 <8809ef6314b98913681b0b370a05a85c2b6cd579.1786599079.git.edragain@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8809ef6314b98913681b0b370a05a85c2b6cd579.1786599079.git.edragain@163.com>
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: f6810b4c-0667-447c-0420-08defb83654d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TugmdIybwzZgKcvqbifLBx9CTaytIKsxzRBfik5dITZha43s1OofD2DHVDOL2vake5EAknmkjpgQ9W9B23eVOvbI0uA7LiyrZZMUiYdapAORrAEDTezcu1HdjaZ/uDKRT4VR2NPDoollY8NlQsUfq3vNNmrTV60wcjg0ch773XUt5SLKZf3c9MQCPQewyv/uWr9O8DHnYjRi/uAaXIquNNBvb3LH7+2mlqC3KU9awfI39kWY6ApRqpnqE1pfSOkh58zt9Brnz0U+lI35gd3WHJgTO934GPOedttBficLFcgF0Kcnne0CcR5kCef23XJTiAuj4kNONdQ7EbUW2rxvVjk8PAJ8XwpCqMTNqcLP6+ScYwaZJDphg+YB/mrAEb54/V5rWWo9HVsa2vz+LAP2u1xbhP6LwpRSWbqkoLjNObQBXGUK7V3g7H/Vep+hTtpvSX7FwYuLyNOggxf6yZVBD9W2QtuxxL/BWh6UezDXFva50GFOlOITw5HcEKO2UKpoTkZ+FNW2ra0hKKUNHtJGCyNIJ+xhovNCjjq8b3t/4UQchcySZ7aAPnEgerNouyWBaUrgpYtzWhO3YOSl1k+bVHBVDTTc680SwVUSn9++WW9SXHwo9UeW4+MpGifiMBPGByin0c6FR1JR+1LCbqS7a04amzxNkPuXWX8WhfDcnXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofAmF9jmGsCPKJZR1hTxicsp27PYs45E/gYiSR+lrM1gzHZQhvPappAPk048?=
 =?us-ascii?Q?LuigBWKTV1XfZ9p9lS+/ELIKR5CBL+AbQcsUHxtbY4Gmn3vDp0U5Z4T364OO?=
 =?us-ascii?Q?JQJ7cgl/BW+F5OMXdNKctvnEhQvjnAGYYVLTpFgUghAWyEh4feeYG0Krf0h6?=
 =?us-ascii?Q?gI8XFkw9v+56XrGRq1GQ/5kLUusxFyNGApbhmmtjmEb0xkTRIbzPNqwtpU1n?=
 =?us-ascii?Q?DVrpLBW18CzvUSo2z0AMqXP0e/K7JkHdmEQz8sTFh2AN9yQ8EgLggvWHGGGV?=
 =?us-ascii?Q?/NeOb6CF9rSeflyqHCUjxE0zkPPQIyCUSaYJb/fDcb0X7WemGbmIf/EuJOnE?=
 =?us-ascii?Q?mD7jVfJdpfWfkiGhV6ir/cdn96F4pP5oi08XctQQ2EhT41wvGZk58yOPYrx9?=
 =?us-ascii?Q?9lNt9+dnqXbcDNaVawkdjxVKXQhgWG/4sgBYEVd49E27dGeGetv3P8ktNnku?=
 =?us-ascii?Q?IREVZbl9/BttClJ36C3isvM3ijoZUtLNyKTRVUUEXjee/7v1qrojkUxZtkdK?=
 =?us-ascii?Q?tbLblGagUXcpPwNXNcsR+AAJrb7XdWe+eYaMUtyhT2OnVnwnXZiX87RH5M0I?=
 =?us-ascii?Q?/TUrYVZys98DTOqYdOxzCaM0YPEFEd3px/dGdNnhlxkQSaZZQC7NBrgrOX8p?=
 =?us-ascii?Q?NbI0WLfi/4BgrE7bqriRe+v6eAKPdtAD9GInAEEAE7ZZB4uR8V5my7o1z9SP?=
 =?us-ascii?Q?z2V1BbiXoNDFKMwMhbYGV1iPazTVE18Af0neqXuYLFHk/2E2QlWs4WuvRIvD?=
 =?us-ascii?Q?ZMBAeWuWeGdF5go0KaA5nPvqO4o/rll2u/BstYRYdx1NYHun1JYOAEduI3y3?=
 =?us-ascii?Q?OJe4AChHWRgjvDG3w+gYp4EC197yDiv8fNyb4keTMcLpYpVNucyhXjmz085G?=
 =?us-ascii?Q?MQ1PIm3qYWjuWlFMhbBGJExexkgnTiPO5iCioZxahuaFqCa10e21sjOkiu7x?=
 =?us-ascii?Q?jJL/S4TMOy5Bvg7MLZ71TvEh8C2Oea2DuVODnE9MZHXufvxV84JeaoVLL1hO?=
 =?us-ascii?Q?6RgFWRJpnrnx1/F9awZScZKGw8Q9ip9hnXV+iWKb3WHM4ullBL4Y1dOMLWhx?=
 =?us-ascii?Q?p1pf7rbNbG0KAOWicIvzbB5xHIZjejGsBoMIP95GXxoufGFiZ1mydKjTWxtk?=
 =?us-ascii?Q?OeS33zvlAZ49XYNUqc017+s7UqyuSbyoc9LEOQEZr/8An52TrryxXSSgdr6X?=
 =?us-ascii?Q?B5PnJEbmeRzfWHDy+nZg0xFVUMc49MbjisUWvpBnhX8Ml0OZZv661vWRO4Ce?=
 =?us-ascii?Q?4Cm8YtfTlv+lHbsA+LHSHSty6RElFD5D6QFGNIzZ7Nw1yHq9owJQqM77pBl3?=
 =?us-ascii?Q?eceF989VYp8EzHqEzdKtrjaT3BZiWAqXhxvizvRirAfUdJUu8CwDbOm2b0x1?=
 =?us-ascii?Q?uzlsihTUz4QEhhfW05V06dcrQ4KOsqc9MZ8nvKvJuD/5OkTVuTFUhnzWkZnh?=
 =?us-ascii?Q?kbPvzr9Q0yqqoVarne8InDB7cjecIFtTjcvbRO85FbYtE4nsrOCHQhvA4F5X?=
 =?us-ascii?Q?2I8f1dyVp8eEtj74rzzP61aGPciBrN+CjfDVo+PQpkrQThUyc1rDSvz+Juxj?=
 =?us-ascii?Q?aZOTGoW2xt3e0qh3cSSvbAESSW9/+trkO6zqKYVyTJGsAEQ2WoUkVT7GQs48?=
 =?us-ascii?Q?2OHu8kz6tCFE/nSDwzI3qoDsrlhsRKCHidil2+H4zHmSLrsaOvnaB6oMw+BE?=
 =?us-ascii?Q?BFN1T8/wfS2cwny7GedQCHzTr9Fqd5Pe6/8+cCP38s0Gd+cH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6810b4c-0667-447c-0420-08defb83654d
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 10:44:49.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHHPmOtxHv3zLBLCx8Q86n6jKLQ4cwLXT0msVphJ3PFAY3dCpuFkR3Z1/Ki9V3dZqoNPXZw5g5sgyPl8mpTCvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

On Fri, Aug 14, 2026 at 01:35:26AM +0800, Ren Wei wrote:
> From: Yong Wang <edragain@163.com>
> 
> ip_do_fragment() subtracts the IPv4 header length from the effective
> MTU and passes the resulting payload MTU to ip_frag_next().
> 
> If the effective MTU is smaller than hlen + 8, ip_frag_next() rounds
> the fragment payload length down to zero. The fragmentation state then
> never makes forward progress: state->left, state->ptr and state->offset
> stay unchanged while ip_do_fragment() keeps allocating and transmitting
> header-only fragments until the softlockup detector fires.
> 
> This is reproducible with a route installed using "mtu lock 20", but it
> is also reproducible without route MTU lock, for example by forwarding a
> packet to a device whose MTU is 20.
> 
> Fix it in ip_do_fragment() by rejecting mtu < hlen + 8 with -EMSGSIZE,
> matching the existing IPv6 fragmentation check.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yong Wang <edragain@163.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
