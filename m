Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1547F771
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399657; cv=fail; b=tk/xE2dGGsUOxhRTFPEmrOOU0mV6CjbBT3QUGXuzxIfyn4hOil4V7ZYYU2IOlyRTp8U21b14gLi36kF/bSrcMHC3EL/HVizw2O/CnLJOjvQbZllw8A4VtqSKE7A/+gVbwmVu3vOm54GIJsqJXl3CmHvgvenxa1ozcyHvwZtVcEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399657; c=relaxed/simple;
	bh=wV8tmPnPeMmuA3VBsx6RzZq7VUTWJySD0ZpgOYG85i4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NvujuCOcphpgXdylXVXgwVS+0h8t5m5oQuG6c2wK9vuoztqTnaFzYFKCXDKK6dE3XeGm/yHnlQFRiVJ9YCBp486yPgE8vs39P+FkVMY5eVwmcW7mVTKwX22KpOpwae3BLpt8v43TJeKjtVdbvEZsEZDZs79aJF7U5WwvGWk4vHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b8gQ9RAg; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b8gQ9RAg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiT1pA4V46yGeqVK7wbWx5tHubM2nQRafe8m1C8A8kFuFdjCmDPRhp+7GZc4JmTCccYW5qNEn7PQ0cH0+p/BhfghZjtjlFN94Ui94qrJoE4zm7/yoGxUqZ7ugBKLMUgVwZB0gR1YMXKyv7yhNkopAYWSgGcg1eLeEeZeTgawEuVtiszSSDxggrY+j52PXGCmcK2zpSr9wnDeF0D3+WHC8Yqjc38P9h8UQZqP9LAM//yYBV3RcVpLPfFNSmXLXtRaBdH0uRsDsM4tWkPizytnXZKYjp0OBzcToqu1iHoyfdvLL7oT6BqBdLVudEgtONac3+ymiPr6+b3D9+i5jjpPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9rbh12kS98Q3/kAxkz5Y5WqZS+ibIqL3ZJSgj5we8E=;
 b=g1OKbL5sEmWyagpBfUdRXYNAOjFkyeTQoWqBunnwsznQJ1DMMIR0yQJMWB0c3wMwAWpEix1P8z3OI3yV8/27WcFW5YXzl968/WmxcxIoeHr6nN4TCURBO48dKawB4w6xtusjcYF+fInad1XDbRDs8LA20/6w2GxY7Z2Bv0ageS/0QQ0Jg2e+2OgYcFKLVGZMzpjGF/hLTnUr/rapGn7AkV2N7wUzJEbY5iyPKGTPXM8CPOOK00/0WJz4NZ2f+cifSYteSglQochdx90FP7+OMvEzSeIN+27Jy17zroUdWDNjmDSHxAJ1dMwaKjP8wqUObl85Nq78d66Y/x885dZBbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9rbh12kS98Q3/kAxkz5Y5WqZS+ibIqL3ZJSgj5we8E=;
 b=b8gQ9RAgr+i1/U2XY31UEtaO9a5btCQhmUKoccHudG1OLGJhdYGvsuzwM2P/5Gl6PwSv8zmvjieaRHArc/mJJOglGBW19brkDibZB9OtCWLWm7mhREqjA631E5fhavrLFPP4JhHTEfALEc2QR0gfn68mwnUkAoWQhViGMlapCG3ua0s4UKuqiYDJUPuhpHjBJ6aseQFu62hK1KdfKXjoU/PeWSiLG5s9mqpxmRRQJ/Up7V+qGsM6Iq9dOT58LN7vwzR3qDIaJP1VEaRMyud3h6aoHkzKoHH3bOdMQNXZoa3/FdJdZhKr33jYeqzlTRwG/d4CGRN0xww42Q3PLqgdGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 15:27:30 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 15:27:30 +0000
Date: Mon, 14 Sep 2026 18:27:21 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Quentin Armitage <quentin@armitage.org.uk>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED not
 set
Message-ID: <20260914152721.GB391235@shredder>
References: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
X-ClientProxiedBy: FR4P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ef142c-81e8-4bd4-2661-08df1274b0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uGi1DI3z30NHJ6QxAazF8MT+oNg5EhDfC/9ZeD4im7/JCH97bWzPh94VvUYglc1YhiOKOfEX3WhdUsOXJtue9CYkM+g2VB3YnwBlB/zaC3qElk9k8JC4l5sbbuW2T7xWX401ykIePTwt9J0C0ADqds3DExU82YV8u3+FzDrutAB/QfU4fSl4Q3vscEBGPEBcDCr2qPEUMlBkT4Gbrf/42YGYeVt+XyMr5suQ1ApiYPxSK9A1dNbsxCgIJdlZKsTSXHXi9aOAM9ZFTuQ39dTIXYdwuIQMomCd/El2hx3o6xPfZ7Q47mP9ubO3cIj9eiw3pW+T3Jr6KlDHrQeHE9j+WFHUwE9hoz0CdDNUB0VeOJ5jsRwOeKVHc9ALkXXP8ERZzStqqqw4ddyIQVkw3mdoL85SPbX7XXnjnzxOEwcnjZybhikyXGH5oTLtZY4KTUXXQYqNJM6mBeVklsihpuABJHuUQlK1f2e3BiXt98cPdSz404CHUdqyzryR0ElygjQ4flchEVUrPUHd85RfUkMmCCVCKq94N3THXue5it17OcPlFE/IoZtdl8vI1d2ICv9d0Us8fEN7p4u0pwFJUBv0HkIdZm/jLbzrQh+28LoQWdQ87/wz3602bawMVulmYBKrMbTbcNZ6yM1ARB67JN6WsmvpqWsSmMIwu3uv9I7bzJU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1FYEuWnZgVZr/ujB2OFpr5kF8+R46xAGExAaY6XiFq9YxWMx7b1RQhHTz2vI?=
 =?us-ascii?Q?lIaoweqfVHl8WHlShjKt3N6zKnT23VOnsuTOsAecJTuIT8ZPulJxecnShQLK?=
 =?us-ascii?Q?N7pAq7+G1TQEoEQIF1GVIC8YmggH3qBPlOE6+WYVThm/FGwHG75qJptl79GI?=
 =?us-ascii?Q?WlVeybfKk1n7eRuZT1LOBU0PNO13xQGZSztnf9NDVAt/Qnt/MGYZtELz7cHv?=
 =?us-ascii?Q?tjjruPimzLo4Eak5PF1VqsE2NwDyw8fXmDkbnp/jElEtGHpbmD0ZusGUmfFE?=
 =?us-ascii?Q?5TtVIjwddDDPJT/4Qw02gU3YlQUx9h5ML/Sms3lB5YtNshxRbUFDehTRsFOC?=
 =?us-ascii?Q?1doWpLzfsxKRxW/GWTOlp6IhxAQ4p+izfjHYn91LbUkbzmP0cJXAdVGAl2B6?=
 =?us-ascii?Q?3hzLiLqNg2BNz/zHl3wCNFQIMF7adfw3asJN6vRr3JAusSZ8pVLLrKZXGdcL?=
 =?us-ascii?Q?kuqHBDIJupAEnU46uf3uNAKrJotrXuBgZCnls+FfXdD75w6BuVUAPyM+kHcV?=
 =?us-ascii?Q?+kt4VYqufjGIFP3Z+MwQY6AZjWGVVZVNqn2LMwZ+Xzby71oXtS/gYVschfbu?=
 =?us-ascii?Q?2wCNLBdJMUn4+0dj25+/JvrsYPGY+6/LoTC8vLh5s4eVRYx3AT2rbH3ZM/pv?=
 =?us-ascii?Q?mVfi8ZI3uFQ9K4JDSCEGd8zKo7/xTjC8L2I+nC/amqjMU4i/2ovYnqRdKlRa?=
 =?us-ascii?Q?a38pmunBJDUdcpl7hkku0bpl3ZSVrGYGyISJHu6gAZHSU51/oaziqXhwvhiJ?=
 =?us-ascii?Q?I5TPYrIyAQMnFQgJ1V4jMqtkfA8drgg/kxMcDtYytLHB+tsniE74+OCK1kJO?=
 =?us-ascii?Q?RNXwwK6AOBqWPxObV4wdgvCf41IIYT8wYIIC2qIw/KrvQiWP8B2DyIjUwnnw?=
 =?us-ascii?Q?rBue+ifjHeyUeLNU4nXsdd/inlZnUIpVRVQS+y8JUjAQir9GGjwnTL/GDZC6?=
 =?us-ascii?Q?h/gpeUjNSd04h89Jry35bI9+y853T2Wn+Lcv9Faq9vF5iL9bBhwymOvkBBeJ?=
 =?us-ascii?Q?eT7wIMb0elEkHJfi6gkFBBlnAxUUXhP7IVX1kTcM2Gmud4ZRjhPiaKGADI1c?=
 =?us-ascii?Q?21JxJsKi9/7nYgLrU5ZBcmqKxPsf5KhLwOKwRTP0debvadBU/PZXzMuTItJr?=
 =?us-ascii?Q?kAR4qKDq5Vlx5OHo6m5cylnnpxdCsMz1nqg2E97lfx+G3ev9s7o+DUlksDxM?=
 =?us-ascii?Q?/eN6XjvEHJwB6SBQPI+O/gHEYsgzn4hpiiwiVBtOk4GgfrPFH4pl6QFOiFZP?=
 =?us-ascii?Q?IOHRgHUOYsfhbZyiVPRrjAVZBnKyRJhCsL0s7Eb8jSyIqqmhgt8BPsCOHTKx?=
 =?us-ascii?Q?g99ikIn8LQ8InHwIyDhTpQbX2cM3kVXcdu71jDm+Jx+jNAX3HNNIXb54n+Pr?=
 =?us-ascii?Q?gY/EbI88g5PFNfnP8mFgPszu0EV6wn89C0UeTON/AlkC2L735dIjowZZ7MAg?=
 =?us-ascii?Q?GuatGBeUE+3PzKHRidGD2t3isSoFUb4ejCDYeSzonFCIn+6wjbBykQPGftkR?=
 =?us-ascii?Q?HpN+iUKl4YOmqqGSENS6Yl7McmaMBlp62nj+CYfjpfqnIMDv0SGCtOkUIbnY?=
 =?us-ascii?Q?+0pk9l+YETfgvVkYKxzM55S7TtbNrpsmLHf56QEsCrZJK8noVPnNN+Ywu181?=
 =?us-ascii?Q?w5mGGPKjmvpE09Gu7LkHybDVo4JxjCvTrsXmMuqy5P2VWfInJ6kbDhTVfNK4?=
 =?us-ascii?Q?CqEoKddRrXvzAsPkz+MxRWNGRxtYttL99FnM3FkdQOsickwk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ef142c-81e8-4bd4-2661-08df1274b0d3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 15:27:30.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sksEUWIZL49hwCKuPy06rGuIaAlJ/bl8cMCwKrID9ol4eG9HZH6QAqUwIx2QcQlN99ZLGamhqB6/m/ajAhgnhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6534

On Mon, Sep 14, 2026 at 03:21:59PM +0100, Quentin Armitage wrote:
> Commit fa8fca88714c - "ipv4: validate IPV4_DEVCONF attributes properly" changed
> inet_validate_link_af() to call nla_parse_nested() rather than
> nla_for_each_nested() for IFLA_INET_CONF. A side effect of this change is that
> the code now checks that NLA_F_NESTED is set for IFLA_INET_CONF, and rejects the
> message if it is not, whereas previously there was no check for NLA_F_NESTED
> being set.
> 
> The consequence of this is that code which worked prior to Linux 7.1, albeit
> erroneously not setting NLA_F_NESTED now fails.
> 
> In order to maintain backward compatibility, rather than calling
> nla_parse_nested(), nla_parse_nested_deprecated() should be called, as it is
> earlier in the function.

I don't think nla_parse_nested_deprecated() is safe. It will allow
attributes exceeding the maximum type or with type 0, which can then
crash in inet_set_link_af(). Can you try nla_parse_deprecated_strict()
instead?

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a90be57c63be..4e0e153f504f 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2117,10 +2117,10 @@ static int inet_validate_link_af(const struct net_device *dev,
 		return err;
 
 	if (tb[IFLA_INET_CONF]) {
-		err = nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
-				       tb[IFLA_INET_CONF], inet_devconf_policy,
-				       extack);
-
+		err = nla_parse_deprecated_strict(nested_tb, IPV4_DEVCONF_MAX,
+						  nla_data(tb[IFLA_INET_CONF]),
+						  nla_len(tb[IFLA_INET_CONF]),
+						  inet_devconf_policy, extack);
 		if (err < 0)
 			return err;
 	}

> 
> FWIW the following patch makes the change.
> 
> commit 5f372809f2f07fe7ed5b91b4293945e8a7fd343b
> Author: Quentin Armitage <quentin@armitage.org.uk>
> Date:   Mon Sep 14 15:10:42 2026 +0100
> 
>     net: allow IFLA_INET_CONF messages when NLA_F_NESTED unset
>     
>     Commit fa8fca88714c - "ipv4: validate IPV4_DEVCONF attributes properly"

Proper way to cite a commit (I believe checkpatch flags it):

Commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")

>     added validation of IFLA_INET_CONF attributes, and in the process
>     changed the call of nla_for_each_nested() to nla_parse_nested(). A
>     side effect of this change is that the IFLA_INET_CONF option is now
>     tested for NLA_F_NESTED being set, and fails if it is not. Prior to the
>     commit there was no check of NLA_F_NESTED.
>     
>     Changing nla_parse_nested() to nla_parse_nested_decrecated() restores

Use imperative mood: Change nla_parse_nested() ...

>     the previous functionality of not checking for NLA_F_NESTED, thereby
>     allowing code that (incorrectly) doesn't set NLA_F_NESTED to continue to
>     work.
>     

Missing a Fixes tag:

Fixes: fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")

Please read:

https://docs.kernel.org/next/process/maintainer-netdev.html

Before submitting formally.

>     Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>

Thanks
