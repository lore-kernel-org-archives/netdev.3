Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA01C2324
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040373; cv=fail; b=pC43TgciG61OwvWqOXkoEWHrqXefuFWcFqw6VtgquGBtA3x07EwfTe0PeQl2XlbNgQIV4YZ/oix8PSgCbuVJ7wuiCPOOrl3Xc7N8SBOaYogvrtXxcdAGAXwfMzJxA1W1pehzJB0DCEVtGYb4E1yJIfq7JqN0zYzt5OfJJ+tyB78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040373; c=relaxed/simple;
	bh=B4Go834oYsgfrGTMPCP5fArH91GkwnBRcHaiLDjz3rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sU7F/hHkkDXATB1u5SMhhmzxypnNvlC8ihPgnK1Z7ec/NWm2YhajewHtz/SsTfOoHWBahJOXaM4zbaWHEDaWp1Xta1d+Ch2XDAGjHHn3aFcLFM+0M4Pzqadnpk1mpEEgWUSS7g7LeU97oZB/Lc64L0010tUNAwvwZSRnaXfWMJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i01XDMmA; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i01XDMmA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y354S5Bc+jzQRkCxR8/+3iBR4pddico3qhaPVp2JgAGrLodPgmM6JUulKo6E1dNRWjaQ5tF3rdBwlgPVmnZ9s/NAkzZBnIOaUUnpeMva1HZKP7LV+vrvKMcFJuvOGAXSiJZIisJwhO1KI2yizuip/NVRyjnX3d0wlaJ5hOIDYKS9eH3Sv9QJfXjzyXZSVI+4KXR8+v0Sxpiw7v39JtzoDqiuxLfJubwZKNsFA9wive0doN7wn/ttQM9WrkXNc77gRxd+tu6VpRmSU1Jvf/E/ZWMKDtNG+fY/gkVvXtYZtVkQ7p6Oep4tAztKMZfCYM1tK39CPTGPptz7p7ExBYLa+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cd6i7Eb9b9ghPh0I3LMj3U7rAzK54b0OzDOmu8wtzs=;
 b=HP8ZX/9pSse8cw0dGhKfKG6Vjt5fLX8j+WawbFWDfDEj6zOsi/jfo9TssctYQn/IvY/N1t8eE62FnFD7O6ExoQHSdMS1F2EICoVIap3N7GRc2G+upfrVvSaKMP1h84kM0hwG6dSIyY6pgrSXpd0YumuxcSBCbpd1Quy9/yDMv04sL1QIq0NepGez6PZSeBDVwGG6JR18YvWvlbcreR0ZkWczZmrJWDAjt0CDEc1J/q4+78M7M7TLIYSM7jjHO7cifFvJVzW9oJDkFG8yrGxTfpwPTJkv9UtSM5VAUS1a2QZ15QZOE05gROFWUn2rhkZhprhTOxZcub0iARrxofaC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cd6i7Eb9b9ghPh0I3LMj3U7rAzK54b0OzDOmu8wtzs=;
 b=i01XDMmAid06NyN0nbsKFvI+k+Yiv87X9UqNvrlIBd92UTExn0vwuEc8zwQea9a4FbLfJS8pIlFjcvM/C61blb3JRuAzoLRiwcKq1UuJf79sE1ky1CtGjylBncpmQvfVVI5QB6yt8CyELM8YJL0AHsWLZOSfJIxO7qGDcoaP5np6Usay/SKxgAz3mWD/7qfIOGVOgrjghnm6Ka1mzvLwt22Nr7JfVSuTCRU596oIlxVWGHO3R+Ju3drnR9GtAWDf9zUDjaBofe5zGwvK04elhDxt8rCW9RSzc/kPdqNJpHH3jIjBvsoXJko05K0oLieYDoKdJdvj0Lry2rIVAbbF4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8855.namprd12.prod.outlook.com (2603:10b6:930:bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 18:19:30 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 18:19:29 +0000
Date: Thu, 6 Aug 2026 21:19:18 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: zhilin zou <zhilinz@nebusec.ai>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, tom@herbertland.com,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
Message-ID: <20260806181918.GA2060872@shredder>
References: <cover.1785734738.git.zhilinz@nebusec.ai>
 <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
 <20260805090721.GA1364862@shredder>
 <20260805172902.27c9bde0@kernel.org>
 <20260806085214.GA1748060@shredder>
 <CANB6i5xN-rrcVe9foAJ+nUP-6VLrgXa90kwh5banCUVDOwG=1A@mail.gmail.com>
 <ae905b11-1b13-4f3e-8705-8a8c2ea7f54b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae905b11-1b13-4f3e-8705-8a8c2ea7f54b@redhat.com>
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d70de66-8bd3-422f-4e0e-08def3e7415f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jvZSJADoQAqJVclTmfzrf+nEArpaBX/YM8ZQcjj3l78dVCer/K5G/1wczcBbUTAagj8OYEB9mFeDwUK5G+qGVe30RWuzuhMDPeBkFurc2YG3d3gwy7lgIpZgeL2xBPmhzdXAeGcq88Dc53Deusc9G9Ik5XR0he9NtX+Fxyy4s1obtMjZ8pc+4UYJuflgg81t0H0sxSTyAXwrvJ76VzYm+ukWBPUuUktegIkuVwOTgjmeSJohecVU8eOcqYQ7425g1TiV7P2SCKqnvWLMLPi9eHt5q0yIhabR1AUnMaLALu6JJJ0LeFgTCMyfjnNRtBtny5GXrv3Odk4nzbrI6dtWxZWEFNBGBXF/t1m5JHjJBHCcvVs9LS+xByr5Gz+I/c3o2k0oRPHTktJ+c7DLRNOq9iv9PYzNC4/z7cnJUODBaVd/EByx1pNAAnXp3bif7fJW46T5R6TJEEfs/Am4HjxICySspw47fYWvVQv68VjYsnd+TVnlbndPz5Vrw/iljJYYXW4gGNtTZTjx9JYjR8SLxROHqzgRmRMuzzLAflcznip+8N3pqPTKnYBRJb3JOoii78XwryoVjObM7Q6YcVxDXiFabpjfR5XJht4zOehr40jb66cZk3Dhtkd4sExQFIobtgB0GkymwUxom1fQqdEDMJM0rddN6+BUGyMqVbJ6Tas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2JEcE5DMXFIYVhOL0RGcDFFSWJUZUtXT2lhYk5paUxJalYrN0hkVGdac1lm?=
 =?utf-8?B?WjQwZjRlTVVOUytJcVVleDNyekNCR2I4RStQMGw1L2M0bmtnY1c4bjBJdlFK?=
 =?utf-8?B?dGhIUnArNUtBZ0d5UXBZQmF3TXBteE9RUi8yM1IxbFE2V3dwT0JuZE03ZGFl?=
 =?utf-8?B?WmZYTzl0cWllYjhqVm5PaGVrOFFOclFjVjlycWZHRkw5dWtpRk95bHJkM1h6?=
 =?utf-8?B?ZXhWMHZzQUVTbmUxQ202bmhISit1NVNGMy81WWJ4NVV2SnRhR0prY0lJVjZ1?=
 =?utf-8?B?ZWJiSTBUVWZkUEpnWkRwL3dWaml2OXM2SUs3cmxHbVc4SGdNQkM0d0lIemVr?=
 =?utf-8?B?WHpFaFFQSVBBcytsZk5JRkMzdjM2alYvanR2WU1lcXo3RlVHOXZ1eW9kdUNK?=
 =?utf-8?B?QkNwdmVJaWNLNDMvYkM5TWlPMUpIenkzSDdYK2tjYk5zSjhIV2J4R0tZRmw2?=
 =?utf-8?B?dzBFcDEranQ2KzVYTEh5cW9xbC80SWJhaHE2b2FxajNwWnRVU2tZOXNiTG5x?=
 =?utf-8?B?dkQveDV0bkltNXYxaFM5VW1pMzI3WTlDTEFUVVVoWDE0aFZnc1NuREJzcGox?=
 =?utf-8?B?N2NwbHJ3bkdPNmFRRDkyNUhrSFQ4cmZzTnBiYnAvK3FycTdZbHBFZ3UxL0hD?=
 =?utf-8?B?Rzhmb0psZXZ3M29EYkl4dlo2MmN1STNRSDdLVzYwRnVoYzhDbUZHTWdkVm9K?=
 =?utf-8?B?N0RVQmRadnhrcEs3ZHU1d2pOcWdhbXF0UjdRZlU1TGVzZ0VFSnNTNFVybHg0?=
 =?utf-8?B?NDhiU1I0a1E3dU91L2pmaFdjY0NMS2t2N2tiTTRHNW9uYnpLdk1mb1ZHZ3VP?=
 =?utf-8?B?RTNCMXpYRERqTWFMcDJlanZXVW9reSs3Qk16YWp0UTJmWTFOVHlOMWdkc2lO?=
 =?utf-8?B?MjFIc2RWdU4yQVdSaTZkVkFEbE9Rekc0SFoyaXpnbDVFZm9XM2s5WGZMUVBv?=
 =?utf-8?B?RnQ3ejJaVm9jTGpBSmttcEJDYWFLZFM1YVBRc2ZYd3h4cVBHNzRpemVWNTBl?=
 =?utf-8?B?b296NGZUVmJKYzgvQ3BMQ3c0eG9WT2V6SWFMaTJ3dDVEMlA1STNIbklPbkJr?=
 =?utf-8?B?YmZpZlJYWlZDRVAzMFRiZm5tRDA4dGRMSzlBcysrQi9pYytOZVBrd1IxL3ds?=
 =?utf-8?B?VjJNOVczVkt1VEZPOFNsK3dsWlZQTTFWRk55NG5UU01sVUpEWGwyY25BVC9H?=
 =?utf-8?B?aWRmOGU0Y2hvVzl0alJrMGdoTStlWHNiMGQ2dU53OSt5WjZrYUFtcEQrKzVN?=
 =?utf-8?B?YS9IWWZjTm10cFBWRnptdHFML0V3eE1Xci9xeGxValFRb3RSVEdzS1JsY1pR?=
 =?utf-8?B?a3VjaWg5c2xLUzZyK254UnRlVjRJZzlURU42S0dTNmczRUpBY1diU08rQlpk?=
 =?utf-8?B?Nm1sclhCQUJHT0RaZmVlZ3ZsQ01icmx6VnZQYmVqcGt0MkNocEtiOUFjaC9j?=
 =?utf-8?B?WDl0R3lUbk1JTWlSSjRmeWlvV0pxcXRwYVV4QmQrUERqL2Q2SG9oQlhsWDB0?=
 =?utf-8?B?cFNsbXJrdFA3cWRNY1hTNVNkbTJoSVFyQjJSano5NG1TQ01sTktPZTYzR3Y4?=
 =?utf-8?B?Tmd3UlRBV1lVUmtQN1U0RGRLNnNhb2RHbUorWUFCYmZlN3A5RjVqWGlMRGMz?=
 =?utf-8?B?Vit6NTFPUElPYWlyRXlqMlh4UXAxSUg2MGV4OHFCb1NxdWlKS1hESHhJWUFa?=
 =?utf-8?B?MHI1dU95RTNjSGx1bWZMVVl3eVFVN2hjM0p5dHRiWWNwd3k5WU1hZThuVWxo?=
 =?utf-8?B?T0ZIZXZyWE5EUVhQTHBORTVtbFRvcnNDNE1pWCtmcDFWWXpyWDV4QlR4V0ds?=
 =?utf-8?B?YmJaVFB3eEtQQjMvaHJURS80NzFGTVBPZ2JYNmFGcjMxVXBYN250YXBYMVV0?=
 =?utf-8?B?ZE9BRVMyK0p2M0x1L3hmbU5Za3R0YW01TTU1YUpISTY2cWtLbnl4dzRQRFd2?=
 =?utf-8?B?L2FtTVI1c1U1TmFhRXprU1ZBS3FPbytkOWU5dDJ1eHlGbG1ad0taMVl4UGtJ?=
 =?utf-8?B?YlRZTXp1VkFQZHFQUHV4enkxcXBZODEyanU1cytxR3U1TmtZQnE1b1R4S1RT?=
 =?utf-8?B?b0I1Y3IxUEFxYkhFSFJpamdjc1dXZ25jZnpUZ1NOeEcwRS8zL3VVYTZNZWNO?=
 =?utf-8?B?YVp3ZEkwRlFCWkV4S3kxNW5lVHB2MkFoNUlrdzE3SzAzY0VrcU11K0U1SjJz?=
 =?utf-8?B?UytUSlU4eTZJS0ZjQ095WGN0ZWJXWmwySDA5MHJBNWRlTzd3Wi8yUG80Qlh0?=
 =?utf-8?B?YXlOcmpMRG1OMEdqQ1BxS0JMbStGRHl2R1RtRjJ1RXBqcng2RnZYN2JtejAw?=
 =?utf-8?B?MDZVS2l5QkdvSUh3akFYTHBZcnJwdGpPdWhNNmdjRnpNeEpMZTFEQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d70de66-8bd3-422f-4e0e-08def3e7415f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 18:19:29.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bc45dpEC7Gjd/4+6WKENkZfe/FYW54+nObrQrHppgz2yO6OOIwPAaqJgTYG6EdyzjxWnrrw5T7Il/YbRTsZ+UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8855

On Thu, Aug 06, 2026 at 06:28:00PM +0200, Paolo Abeni wrote:
> On 8/6/26 11:06 AM, zhilin zou wrote:
> > On Thu, Aug 6, 2026 at 4:52 PM Ido Schimmel <idosch@nvidia.com> wrote:
> >>
> >> On Wed, Aug 05, 2026 at 05:29:02PM -0700, Jakub Kicinski wrote:
> >>> On Wed, 5 Aug 2026 12:07:21 +0300 Ido Schimmel wrote:
> >>>> __gre6_xmit() and ip6erspan_tunnel_xmit() already call skb_cow_head()
> >>>> before calling ip6_tnl_xmit().
> >>>
> >>> Probably just me but can't they all be buggy?
> >>> PKTGEN likes to send shared skbs around in funny ways.
> >>> Can we get a good explanation in the commit msg or maybe let's
> >>> keep the check?
> >>
> >> ip6_tnl_xmit() is accessible via two Ethernet devices (pktgen doesn't
> >> support other types) and they both clear IFF_TX_SKB_SHARING, so if
> >> pktgen sends them shared skbs, I would say that it's a pktgen bug and
> >> not a reason to block this patch. Note that pktgen is not available to
> >> unprivileged users, so it's a less severe bug.
> >>
> >> The patch also makes ip6_tnl_xmit() consistent with its IPv4 counterpart
> >> (ip_tunnel_xmit()) which is already using skb_cow_head().
> >>
> >> Zhiling, please add a note in the commit message that ip6gretap and
> >> ip6erspan do not expect to be handed shared skbs given that they clear
> >> IFF_TX_SKB_SHARING.
> > 
> > Thanks, Ido. I'll add a note to the commit message explaining that
> > ip6gretap and ip6erspan clear IFF_TX_SKB_SHARING and therefore do not
> > expect shared skbs, and send a v2 with your Reviewed-by tag retained.
> 
> I'm not sure if it's too late, but since a v2 is required, I think it
> would be better to keep the skb_shared check: that will avoid a later
> patch for the pktgen/shared issue that inevitably will land, possibly
> via the security channel.

What do you mean by "keep the skb_shared check"? Return an error if the
skb is shared before calling skb_cow_head()? How would that avoid "a
later patch for the pktgen/shared issue" when other tunnels are already
calling skb_cow_head() without an skb_shared() check (they clear
IFF_TX_SKB_SHARING)?

Not saying that there isn't a possible problem with pktgen, but it
should be fixed there and not papered over in various drivers.
