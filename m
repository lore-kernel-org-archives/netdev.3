Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20025B093;
	Sun,  2 Aug 2026 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785652145; cv=fail; b=evpSGuysZV2tHIa87KeTr2Por5Ubc15iyqNhKBFkUGO8FoyNFeRzO8JjFcsKhlgSKHY5uhE9fDxQ2dxcStoNGcrME5us+Axk+gyllT0UcIqUf/88rEKrHuWzPWrVNjIFaqiEmouSK2713gI1jCqpp77SeAuUAaLTd/T6DUjk6kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785652145; c=relaxed/simple;
	bh=MbaFstEXvtu9WWCIjC7H+4NHzf6T32eXawQGHzsf6qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDT4bpjw+npQVmpd8VskH/oEUXC9O0oZHqnv7Eo1d/9APMD5SjJRdpy3rBilyOuAOoDw9ENwq2CKeAOgSMlVaq1fy06f4xaTL1y3xqYnKOCnSnOVF6ERZSVehvZTvaX421VsG3QLIzdhrNLNz20prw/Z+INTtFW5IUrjwaBpdFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eKBC7azq; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eKBC7azq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrHSbjGw4Cmd+Vs72YUQJQ84UJwzY1ExpND3rnrGbhHT9l1AWYegByaGz16z3NNamffPwikmCHaSXyjHkizXHldMdSvTRLHoy9Nuy6mvlkdNlTwyMGoQKtFxtFHuAIfxQ9kq1dhzuGoUkg2XZ1AJ5P/T1I3mBxVn0rQM+WZ1We6rpv8TiCvqbj1h2kZXTjoczk7gatrxJGvUcUjqKs3PcKqz5zj/VDrQHsojiEdoeA2ZcPcQOIYroTWyU2QNQWCKDIkRiesIvx9SDpcbR6rx8hDcHErgFKPStcgbcUC9+kJwwpYoOOql4988apTQov0IDuvaTSRKDbq2R3POHw73kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU/p/GqCyuPwTw4eQZ9jdk26/YRrCdLTvZ7qumSL3wE=;
 b=GQAgRV/cUUORWQzJB5omCqLBUbFrEgs7+ilvz6WBFNNZ/rVFGk7dZtd/fpi2o8vHcc1a1G8M+SmJcJGtr8yt6hQsmNp7nmJh929X3WPh9A64CkA25EAOQdiL9MW4xzDKUAaB3dCypfHPmLT//HIhvAQ2XOkx9y2DopW1lmaSgE643XzaLwYXkqnfhWU+vy0unEbSCVo22eljYi3uK/H5/ek8N/MrjYC2rY8ecivCFPiO/Nqhnf/wO6P7vRa587NkSBBzj1xPVGWtil+u/K1Io3Cx6Bi9/+IOwnk6CZx7GqSOZqc4kBlkxwhuOttERSyaPLd9TKWvlZ8lDoEPE/o1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU/p/GqCyuPwTw4eQZ9jdk26/YRrCdLTvZ7qumSL3wE=;
 b=eKBC7azq8YpxW0BRW4k5i5gRLfDLmeyMq1qU0hpHNJ2x8E4nvqGkka/PCkiDmvgcM5O41VzBLyH3N1WyihbtXPQOj6Vjjz/WAYw3ISujm9w0t+vZqUS/o+CkqUVDgR43utAmkOgfe/IA8jx/1P7dawCNWI2CS1xisG0R1mMHY2anJDp43a5b7NvOFuNrF1JA9JsDrZ+7YGqLhMJrnTa7NDM3+z9b+KlyafffwXv2OpIWv2kbN408XPbNWQVkfRHMFWr0qOj9WBeIFgO0Rg83QhfPbrBF2Bawvlw7ZJkk5RNXiVn9QyjUYG3nAeFRwfdGTWLqYZKzVDmONLMqDQ8OGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 2 Aug
 2026 06:28:58 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 06:28:58 +0000
Date: Sun, 2 Aug 2026 09:28:49 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Minhong He <heminhong@kylinos.cn>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ipv4: nexthop: handle errors in
 nexthop_init()
Message-ID: <20260802062849.GA125253@shredder>
References: <20260731025249.80026-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731025249.80026-1-heminhong@kylinos.cn>
X-ClientProxiedBy: TL0P290CA0010.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::14) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 676adcea-7de0-40e9-0f77-08def05f55c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L9CTz9GoJWHDP0nfSDes0paQg56weF81kfAgZZRxvslnjuDeZjtNVjUZomSa9C8lNNrpJWU8fgKdxXTZa4UqHqV38v7ijAlJn8sz3I3FAVX/r95X6UJs3RQDlKtB3lMLXu6igYVZL8UrTaWeGd5G5yNSxjD7Rlf1q2j+aNQCf4dr/vMWIOi9uAEpuzmyaP4UQUE+impoxL/qm+Lp0w95H9VfKMoMW3uR/vv/AZMFNcsXQ4P015r4QJVeUxndaHBNC6HebLp+X0nVesIzlVb7LXTcX7m1EeqTVsyVKzhDNSyt5yZfTAJLhuHMPNiHAwreizEimFnPL5oJTHH1alozxaSh80DHUrvYhBQCrvATw6akjZlDFokEdTGBOwVwESg/dKp7WnxTpMPK2s87MS3+cJeEA/3fFOMYehWlRMVt2oWCr4BCf5T3Y19rbl3B+d26/E6MTJ6TScstbvISd6WZRtzmrw4fh3pDJ1ajEg6xumX+mgV29izeAZDtWzkIaFNmMYYVteea/Y5UPlgxIIWPdDzWzc/bRe++PBTbic2taGBLY1vfj6jzwL+KjjCgBLfFNsXkU12AosS9jLzQpVeTZvO4mEe19xgiULNw6ckzIZ6o+UsfwhGIsjaPb+6BvUe1jKnqmxKO2Who9S7CSW/Tz1MyYtMu5bI8xfZgEJNoSaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AQH94QQ8hiCc/DYL8xGZF5KTkrnGPRbEbZ2JgZnNOX05AMklIw57xTUyoOq5?=
 =?us-ascii?Q?NAMJ2cWzTfOlqxyxgtzKIuzcRzhe7mEL2IuvO1Yyho3tsby3OnMcoS1ypURZ?=
 =?us-ascii?Q?6GbwofvXjNHUnGuGn56rfjJAu0ZPoB555CLcFt3lMl/mvrdD+0jov19jgvqD?=
 =?us-ascii?Q?LXqmZeL1fCz87vU+4uzgp7uZ3YxvNKpJHYgNS5E5Gm0lgX0sdtx9VCGYo206?=
 =?us-ascii?Q?h0SPibeYgKXpGohpY/qes2iuJ/g9PEaa5vrkjmJLAUHAZEEFaUuN70YaCGtZ?=
 =?us-ascii?Q?EXd/Qkg3Y6p552KY9RTI70F1GYPyIHvfA7bFs9IvPh75NfKXO+0W0lWYd6Vk?=
 =?us-ascii?Q?i5Axou6NfH5a8Z9fXSNdcjQxA0uLTiwvh7pplUwx98I1eKip1IbTjBUH3XSG?=
 =?us-ascii?Q?HNl8/iN16aR2H3xi0D7sHTsv0ELdIjED1Fay6m9K94oETqypOX8NHmMM8umO?=
 =?us-ascii?Q?ipyQmcR7MxdTvIOAX9VUXjgwYyYvD592eigZeOxc8a0mZsbSlJot/3wNnq5f?=
 =?us-ascii?Q?yt6ZLbvvlCqX9eOUoef9/iv8FTx1xoorfAY1w1VOd9ITM8peF1vwTJREZUHE?=
 =?us-ascii?Q?MrLOC+C+geYleucrURBD+CoWS7kxkwcVQMxRzOg9HWvpnBbIIQLhb4Ynijo7?=
 =?us-ascii?Q?LHQzS2MMxoI7HFsuyYuOH5ZY/JiCQ+gkDOQ67OPWyqWv1E04gTBYp0W5Lp1o?=
 =?us-ascii?Q?U0d/CsqL5pDx4biLYOOGldh2XY49H9SITzQ3u+wdTHI+SVqO9GfmDzeb3QDG?=
 =?us-ascii?Q?ozaaG2sjv7EsjspU6eyyL7d77XCuejBq2lquA6VrrfGYVM7YAU/XkQf8PEAv?=
 =?us-ascii?Q?mey1JCogdMf861dm7ohQbzqP7b4VHmyuTRL1vMaVJoitGjaMuJAajRXV6l9h?=
 =?us-ascii?Q?F7uEU+bS02jEQk8wnabl7kg/KT2ytrD2a+Gcf4YZhhxEBEDSJqegvGj4sqJ7?=
 =?us-ascii?Q?lOy7UK4T4GCwTNBodGZwWdJnBm2oAfEVlDTcwNrxMoI53ftFLC02hWd8He1b?=
 =?us-ascii?Q?o91QAK7fU3YbxV3iGvy0Au5hbJnG2XIlraLW8Imcxd6g+Gg522EEgbU10335?=
 =?us-ascii?Q?FdVvgCztvu/DQtA6+Ta3UYELcxOxxV9s1we2wCuTn7LdvrGioiF/G9+Cjgz1?=
 =?us-ascii?Q?S0BGhtlc5fqSOkxz2VbBHr916pP11ZPjdqg596ehxIycuklyF2EJ3pEB+oQl?=
 =?us-ascii?Q?917ZQF7C9z0bPTROGiwkcI+8Pp+cBQ5fdkx+6GaWLvF7Fx3/F5aol66DcMBZ?=
 =?us-ascii?Q?7n1h7Ttn1Vwvn17bDvwpG0XoPyrX8pkHLW3yKJrNPZiHkK4ESAXfAvJi9u/U?=
 =?us-ascii?Q?xAxNNkqLjbBONF9ypvV2cAYQds3zKdVZJWyzKjXHd5ZJ9n2O07EadGDJ57ku?=
 =?us-ascii?Q?1oB7HqLVSYWgicF3WifQxlvlRXxxMa4AMvoQxKPVwRrYW8SQWfMQ6z9Lfs9Y?=
 =?us-ascii?Q?kzNerWylTUYQ8hi/AlSpNzTowAi/ZEHV/HUjibL0xs+hH2VjyXmHw/AYGeKG?=
 =?us-ascii?Q?H0hOBospz9ODxaPEAfxooujUVwHYPS5Hmz4rXvJZvxbubgwLMk99D5il7WGc?=
 =?us-ascii?Q?2ekvHY8CBX6/a3sLu5Q5tHCPkNDdN4jk3ArJmxqnO5OrgMWiwmL+HNASd09A?=
 =?us-ascii?Q?MR2Dm2PJL0HaU24uILE9vRJxJTYRDFzUJIANktGHl6oXnEhfBmS/SAlofNoo?=
 =?us-ascii?Q?ooaPCM4MrEjaxttmoblc+hOsJF1yGRmrGI3axjhxr1cj+7rn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676adcea-7de0-40e9-0f77-08def05f55c2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 06:28:58.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aorJwFfCbVumRKDUFei3FEOLkMEqTt/Ug83nIhiPNKj3cgJzWEwMyqaAxRIhl+4V+nSiyrPZawQOGfF+8U38Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467

On Fri, Jul 31, 2026 at 10:52:49AM +0800, Minhong He wrote:
> nexthop_init() ignores errors from register_pernet_subsys() and
> register_netdevice_notifier(), so a partial initialization can appear
> successful.
> 
> Check those steps and unwind prior registrations on failure.
> 
> Do not check rtnl_register_many(): for built-in code it panics on
> failure, so the call cannot return an error to nexthop_init().
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
