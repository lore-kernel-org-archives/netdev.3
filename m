Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129B37AA7A
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159570; cv=fail; b=sMplkv5UCPrts5Lhbf0AG+3QSEuvIyxwfQbiRk+vQLish3jfzZJH2RfzX+yb/ZKLDS+7LYKySJp2NvajRxWY53xuv0FYAsL74BbGby9LHPn0PJPhZphWdxLPY77gtEwLFFwax0onlMkbjggVm8CvDDHy29kBMKjf+TJfG2yISC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159570; c=relaxed/simple;
	bh=YeWf17YFjeKeK+nZCI76SFaAazxo0llPwYUTaEEmLRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pDy7LOHc7c+ceQ0fjydNaEZ7V89DAqCMG0ZcI4mXgI8Ofz7k9ixHkEFRq0SyLG+WWUArNMgLylawN8PHi1IuaC6E994xvem6vF/CNPZeiMKjljWejJ2M8rp4mh8X6TvH3YKCBABs45Jl+3uywv4K6rYpCe+sA08KJ11bg9+nFXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tbwkQsBG; arc=fail smtp.client-ip=52.101.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tbwkQsBG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzKxdKGhB00cASelddAUYUyLnjcasCopmX3rofN4CQyNqZhBp2Y3StB3l7wF+yveEgfnyVg4oXfSfpnfCNl8x6jqPSv3GXNAl0nrKjPSqKITTEzYlkUYShD2w+oGbZ4PAf/u11Nv6PZrC6wRFfzN0yRYh7fpirvyDwHBLwE0dM7v9dMJNYVhxGu72Q8dNUb6plMd4v4Cy+a1C8//+qt+lUonzZ4FslMVAtolSP+6hiswXRwZDgM0M/mNVRrTjhVkZLqIjJW3mwAh3NA0JKp5sINGpglNIXDT5a3Eesv5CLmpTdPVQ3eMgbYq+6yetaqqJcQN5oFSMOEO9eETNNCisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF5dcUTDH/54O/IWH41ldWgv8H6BndwtHtAKyl8t0HM=;
 b=S+acflEoo5kyQhJ4IvkFaxhSbwXTEPH3pWyoAVQG2M4XgwGP+o8vW1G5BPxKVMDGzHAL9mLHUpYewuoHE8SAadnVf9NiZShOtgvcmOB4jtRPtoRDUtJcGnohRnsPOoRhsdeWM6J8bkEuB0RO21RXb80Lm0VbudjQbaN+Xa/pM1fEvFIFhM+kXWG/JhU8452KMOYWYFmfW/ysJGzcZkJ6JxMEMSN7NCUBIZRu50kZiXWMHeAhKAwm81tf/hlJU7/fytW+sNlf69owW0osN3zLw/ttOPzh/ZkH5xCuAlz05byQ/RdW4n4zNCyCvbDsRdKY0q5SnVSRhCH/JsFjiqabQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF5dcUTDH/54O/IWH41ldWgv8H6BndwtHtAKyl8t0HM=;
 b=tbwkQsBGZ1LZw/UIAtebktTKC5mFe8SDPWQlVI6BRtYDZV1uqgGUFSoM6sNd/p0CaEbdF+hlHITDsNkPpH2MElIIDXEpngPx7xMcMDmp5/JAv7p+YjNRfzat991IpZ7Mn6XfTgqrEo2E9hT/JJpjgIuxJlzy/zwT/2KKYbjTIl1SsryLlIeh67+RbVHsX7RUYstl9U+0BRX8Qola61hfk02P6SxUSYqLuWbJ2/LyGoSWWZ4537zZwUU66Z4hkleEb5v9Xy01TEiICpWD9ZXKVTfUW9E3upO33a4OPXH3LNt/ZSbZnCnPdvK9IV+14rPOVA20UJJkX7W0H1yX1s+0PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB7996.namprd12.prod.outlook.com (2603:10b6:8:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:59:22 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:59:22 +0000
Date: Mon, 31 Aug 2026 09:59:13 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, aksecurity@gmail.com,
	noam.caspi@mail.huji.ac.il
Subject: Re: [PATCH net v2 4/4] selftests: net: Add exception cache tests
Message-ID: <20260831065913.GC3079008@shredder>
References: <20260828192344.2596928-1-idosch@nvidia.com>
 <20260828192344.2596928-5-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828192344.2596928-5-idosch@nvidia.com>
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 1230cb70-6feb-47d5-4e44-08df072d62f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	LTL2aoopbqoEdiJ7XNS7cp+aUtFbTcoasioLm1pjBI4bClTE5wJW0DkVqUI+RR4RbGBSBveWkEXXj4XuVEtVtdSnObrDrHp2xLbLJJUOsx6Vjv9/sCGZkSG6VPrP6A1eSOxrcywVw5jFnhhRJN8G3NkDKKWbl6yB0qHTL4RBSHU/JUst0USpDB83eoMdykqc9W5mTxadiNxdoH70BGpyQGg8z1YBn1igXbDkeoX7q3AhcjSOlNtmfKUssVvUnj3Tyo8K3lPW0uC5GXbnzIkyDIjUQMiZedpC15NjCkwU1meCBiG31zP0TOYYblgx5TPUCR8xb2+NpRsdZrHIASKyY23oZIiE8wijrDzUoRtWjE7jjCiePRTMZ8E4OdQaIOzx6SL3Ems8BtSNXsufOC0LP3d/IdECuLM3mj81sXleYSEnNkgbCOlgf30sBQkqjasgAd3T2VAigDp02Cjn6/Cjp5ZF4xOVYQh9gEW3KXyPkB/EXCVRRSc22LLSHGS46gZOjsm3IGEKUbs5/rTw+F9xS+pHIZa2gfodZLspIwPcT/1bwJxjCct8u+5HiN9013BuIcOqE56smv/8d2+AQq3i1tdp9Qla8bGJUlTRE0s+LCxrR16WTyV8S6Z3+CSzi/K41KaJed/uS2Zk6RxpW6jhIq03eYhGydjYOpCvcj3qMH0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4JxMNdGsFF8jSR0MccGTgrD5E0+qv6i639nHVNzt7/CSJivPggbFKzpKCQXq?=
 =?us-ascii?Q?IT7HJH7YNGCr9/6g5GAsBhW5JQmr39cLvUuLCkJ7NZR9SDP+qqAQUyAhNO5Z?=
 =?us-ascii?Q?Hp1v9GuctjQTWJg1Ynx43gvQZyY+0jkGbohKW4DPFzVX0VGMhtPiwOZq1D4J?=
 =?us-ascii?Q?5e3KAeJhJf8HN6eccH7P000xaXJQLNaHg18wEOOlsa84lrKOXb/89L/PHjhL?=
 =?us-ascii?Q?u+gQOed3yvGZkQoDUx9figLqFqESHR6pVQkD1Kh7YJMbvAFc14W7QKZHkgCR?=
 =?us-ascii?Q?wA7ZlSQScysJfMCGhEFrEoqZbjTdSDBpyirfJmQPakCVDqZVfWHgSPOcr+QO?=
 =?us-ascii?Q?2kCt/0NPN/KJbxyFc3vazxuvaz9qcQ7EUAAoaZGjVrrJnNhzLa4NPd06bJNJ?=
 =?us-ascii?Q?qzK0ZVS8hVBp3XWUTPYymTUF721fYQR6pZhnVPT79POEz34AuU/vDJgas0fQ?=
 =?us-ascii?Q?8XUjfDnpsePbkxaZ9lb3jTHnwOpAmNYy2BmaZZs5t72O1/FAjE9cv1EzT1NL?=
 =?us-ascii?Q?hBTHrZInDffNLikzNDG54qfIHrciYMffPH2+SHrTSVXRn/paj01wBP4JiKEV?=
 =?us-ascii?Q?79taO8ENZGkj59+2J6HvMPCDYBLwSAEzvKe5JYNlptHP03q7M5sHZcYfpJSX?=
 =?us-ascii?Q?QiiJVnqVtjsBaBSVOGiMoXGLqiMNcxK2MzvpIi6oxpYt128TNuOcqN9My0Wz?=
 =?us-ascii?Q?FYaUHtGM7JMGxfJWN/ONEbiOTgPWUw4A2Uy6LyWK/HKwymCF9sozJUftDPq4?=
 =?us-ascii?Q?8XazscQkFWleH3moswcV3oBuPSDmD4qn+zy+JUgwz9F8BlCs/48S47MuORLd?=
 =?us-ascii?Q?lCPZaWuldPAI0ByJZMhwt2eUW2HRr/aGGmB8i7LNkr0ZaOZPOfv4G7k3/P8J?=
 =?us-ascii?Q?ub/bYLhOQEDb+IywqrJMLVPBVXFXq8uf7Yx4bQxTABpBc+8MhZalkqDAWdDD?=
 =?us-ascii?Q?ZbX2hGlIq95wLDk6UwOUPUmg95ZHCDp0diMwc/Qle68QFBS7kFU37RokReMf?=
 =?us-ascii?Q?iRvQA9m7n/lR+qteb7lzLBBoKs4ZL65e7d7kRRff59r7Qp9rPBZ5FyzU/Vxu?=
 =?us-ascii?Q?zozjVMgJvDuE82Jqk27FTTz1fzy6jqiifTUxbCrRjjybRPYTHn1abeXTTYQi?=
 =?us-ascii?Q?ecttwHr62YNHc2DYShB1nhefVILUA7/KeOeEjWLS6dj4ANRB9glE++swOIne?=
 =?us-ascii?Q?HAT4QerLYeQy3hhkQD+arHkPA4mf7Apwm77i8f0Hh/UifHn8BZKkltTCa9q1?=
 =?us-ascii?Q?RVFSpB+Vdt2M3BNgexZrpjuOXrX712QxVFw8IIMeODP5Ms9qa3znahgUyWL6?=
 =?us-ascii?Q?IgbfZr+3u0x0heiBpIxi6b5li42X1weC4Zgp85aLRVyaJC4V5HypBNwPpaX6?=
 =?us-ascii?Q?N2cqTJn3zHwC+Ry9bTAHzqe7KrnRP4nmIgvaVHBa2KVLFRlMUhgoGgUEspyC?=
 =?us-ascii?Q?ohXd6+BwTyDqUKFouFqfbWQ1vC0uMo8YlpzegqCQdMjjTVllrYqZ76ZgoUjC?=
 =?us-ascii?Q?cDfK9ucBYBUWGL5GWaoS6zfZAalwNyQnB/TAS3vm+rfgfiF191NpUqnhDY7I?=
 =?us-ascii?Q?1D+HgAoBKfzZBnAsPEPAmQTASxi4THqnV64cRpTkVBbHGeFLfDbzRzKT5FSk?=
 =?us-ascii?Q?A3DEUISMXRfgN5fkLhZMlIXoPOz7xZwKx41I3U5WYTOqL6xIM55c+s556f6B?=
 =?us-ascii?Q?UioNzaJckv1ih7QIYDamwBX86+n0XNFNSVkCPu3+9qea2a61?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1230cb70-6feb-47d5-4e44-08df072d62f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:59:22.7014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8GvR57Zn+01aqib8RWuMMNioduDTfVD51y4Wqqyq8qRGZaInSQBtwl9j3P7xmkPhQF8HcJcJIUu85S2JG6+tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7996

On Fri, Aug 28, 2026 at 10:23:44PM +0300, Ido Schimmel wrote:
> Add a test for the IPv4 and IPv6 exception caches, covering the
> exceptions that are created in response to ICMP errors quoting a UDP
> packet.
> 
> The topology consists of a host (h1) that reaches a remote host (h2)
> via a router (r1), with a second router (r2) attached to the segment
> shared by h1 and r1. UDP packets are injected using a packet socket, so
> that an ICMP error quoting them is only matched to a socket when one was
> opened separately with the same source port. PMTU errors are provoked by
> lowering the MTU of the far end of the path and redirects by pointing
> r1's route towards h2 back over the segment it received the packet from.
> 
> The following is tested for both address families and for both PMTU and
> redirect exceptions:
> 
> * An error that is not matched to a socket creates an exception that
>   carries the new MTU or gateway.
> * An error that is matched to a socket creates the same exception.
> 
> The PMTU tests further verify that a lower PMTU replaces the one stored
> in the exception whereas a higher one does not, and that a socket which
> disabled PMTU discovery using IP{,V6}_PMTUDISC_OMIT gets the same
> exception as the other cases.
> 
> Without "ipv4: udp: Create exceptions before socket matching" and "ipv6:
> udp: Create exceptions before socket matching", the tests that do not
> open a socket fail:

Both of the comments from Sashiko are nits. The test passes when it
should and fails otherwise, so it's doing its job.

"
This isn't a bug, but a question about what the "with a socket" cases
assert. pmtu_socket(), pmtu_omit() and redirect_socket() only look at the
route exception, and with the two accompanying kernel changes that
exception is created before the socket lookup:
"

It asserts that an exception is created regardless of whether the ICMP
error matched a socket or not.

"
Is the ICMP input counter a strong enough barrier for this check?
"

Yes.
