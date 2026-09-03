Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896FA43E9C3
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423392; cv=fail; b=sEQFoWaMnVa8ck5vphYRo3v4/wiKLkyRecS75RtOckJNFxS4Zi7rR0nJRpszEOdMvRf3jNZ1hjmjgHKokcjDBeLvkNAiN0L/4q6UoGJL47I3uFxsShEFUYNQdUMRcmJLjJV56zekjJmx3O1BCBfLHHAsUzZr8yAeHfPPytQRby8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423392; c=relaxed/simple;
	bh=SWrfPEEzX+m5iPm7/DzuMLebek08u5x/oENLyr8zpow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPQtoLk/lW6sxFgLQH6M4jbIN4G2YY9aM0jEZqJ0EvLpQLBMrY7yQeJe+Hf89WCLcxSMKGiAc2pVA8bXlJz8q1+zGPxJrBKOYLT8cf3q5MOI88CdpGBkRN4tM1qNdMh7rQR+0AKbnHpcMCM4sbII0vVOWc4xpj3JMUoYFi8LD7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aXfO8yVb; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aXfO8yVb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTLjvQR/H5j2PHJmiQbQ2usrL+Vw1PEvPxesQgnVRTx/iXeCVVaOxFwHxoA3PdAhzs6p7ERionfWuJuPXNrN8ghv8gRF6xitkPYUi7/qV12kSVGxrMvFiQ7/y/oG01QyK0cchBzM6S59Wn3GItFTRNMitvUJxVQ0n0TNlCVLO4hxhUnQadkD82j3ZYSdjDHzwBDIE93/leITEi8IXxg7PXaIcS4uZVWheFSfSBBvbvrX4yrTj1+sytzXxz/RRNQRP8IgiIO0Pmzv4eA5bNcxEw1Zq8h5GPyzmFZRK/zdUch0AJMZOOh03u2fF5Gx0iWPxiVooKriyyiWCvkAMtCmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucNiArfi5xB4Z8IfGPA4IndAG6oySvygzZrpph4wMtI=;
 b=YUWEHbzEIghjqFQtPbyGr17Q6FbAZb6FjhPTQT82dTNj3b+/cNJNL2bWLYqcIUWyte+ve7Dv9oCXAq7nFkLNagy3JExc264Cpm3b892ph9Q7Y6HA01XiaOizCGL7h4Z2QZDVaMOYVrJVy3hhY32dfWClqK4uuqRS1TQu//cbAXq649rtQQCl9JswXg6lgVqXskypRQIiz5xZwtUJE8T2M/J18XAjNB7b2bmsoqMVIxNmJTY27OSQMFpAg4l+eZySfStauVvuBZIbeEDNII9HGrkOL3aanOHJFDq2V8vU1dXjlXdzEM/09l5sor0SJ+ujK+ocfNqH0u09bD10WI3+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucNiArfi5xB4Z8IfGPA4IndAG6oySvygzZrpph4wMtI=;
 b=aXfO8yVbVJirUiq1fzkd+sTw97G5i/Mpe5KBXTKAHJcnjs49KY6YVw0ukampog/XQ+FOZ+PeB2ZPFN97UPGfNNty/axSZfZ6CHmrCYzzt1ZsFGE5nhuCD6yCn8irlpZQhIesvISZTHqRlyQ+n16+/HS+Z3HJ2ScJShknR5SE3ZBBoLL4FTrF8r8otpJPKMK+YaKHO6HGmGWD4YC6uye91ozWhFf/EAtXMMs//c/GDpH3NIeIAsNUC96U5psxsKDcFTq8EzVXumy9XJZXkjB7/X7JElY1SgF9cjwzn8+Jpw2r7CsW8TTS5/fBlk6IPDMBlrvPnx19Vk75GC6Qou0F2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:16:28 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 08:16:28 +0000
Date: Thu, 3 Sep 2026 11:16:17 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v4 1/1] ipv6: flowlabel: cap duplicate leases per
 socket
Message-ID: <20260903081617.GA11345@shredder>
References: <cover.1788415194.git.zhilinz@nebusec.ai>
 <83f8535972ff6e3741548476a1d50dec24c758be.1788415194.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f8535972ff6e3741548476a1d50dec24c758be.1788415194.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 6501b02b-517c-4bfc-b1b7-08df0993a72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|10067099003|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	cJTxucTDeu5thkUzmizvulYQ/Nhc2QgVeYHkKWvSdianF23Ux262o/oVrjzAWrapFj3dW787PEqn3WjtNB1ptu2b0YQDabn5ELD8kCcQSLPkv1q9QPg7GZGoujunEThKvmuQ8xVkT0/NGMiAOmNxWf0klN8nelwEzjf8l09i4ty/oH/hb2wHBS+75plzni0gfUPjcBrw5GQF70igsW7mRGuiaJmR1mr5ilV43mrTmnpQSjd/bDLGWbMyI5v4XiTglNcz4dg0Oy6ruM+1/LaEc7CU8oUlmvpT1twnl/N4dU5vj1pyaFGXAF7YZpdvfPhWTNKQjTbiEbU5qObSDJfEEE2/EEJI5QRwg/IItN9uWHP1bLGQuDUfUXtesfh9L5ROLHns1Cocc63ix3rA+BZXGUZk/HCtWZv+YbsC20nrCsOt8PWfrQSUAn8AIab0l4GnVqqd0q+dWYsCFD/YDUC8cbBytdfuK9Gw7Xmop4NlVN2jDhoDf4JVRbhTgWmwYCRG9d32S4vnbAwj5Oo/cS+nFWTE7mALQngLUL56s8nyZrDj17vbG3sgFvcIkMAJLNxVkATQGykGCsuFLq+CSPq+PeJWe8P3JoEEn2c9XYkgibqWryDQQbxQtytKPnxLVDCYMJlPE2KArwqXeA2/w9fAaYXjqEbmpOB90UeQKFojEcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTa2v3PAZcCO8Tn7uZYEHt4vIkn2bjl7j8nz3HotcqXXtI4epF3BnvaZKFWl?=
 =?us-ascii?Q?KJVCb8BwTBFw2zAGEEoBFs0EyopQcQFW40rm+VWnOxZcrDWkIWijDqPYvXal?=
 =?us-ascii?Q?UIRfOYFe7+yHeQmmXVl263GlyMia6Pt0CyPuctYOI+7399ug3Ge1jPh9j9qw?=
 =?us-ascii?Q?ndNWH7Kwt7qKh6AL5OknYp14cfdSW8KXePXoIJtCypY22N3U8YVkfxmYc3tj?=
 =?us-ascii?Q?slV0jd3FJTqfZiOHW9uTzKtB7oujOjhexiQrwcBrj+NPPWeZU/5U5nyqgXSq?=
 =?us-ascii?Q?k0CWxcXfnWH1vTOMEhxJDe1X287i95tAJR+JYiINe0JYmDM2ahLJVH00tGrm?=
 =?us-ascii?Q?R/eJ78OW19GMuDz8B32GnLYaj/dl/bpX8X3XoOT5L2qcrKIwNukCEKpMzs3z?=
 =?us-ascii?Q?GPM0CfcfFsFUYzlIdikMl5cqTw4reXO54EF4+SMkTJFJSv4FCoeMpJeq8o8N?=
 =?us-ascii?Q?Zx7J4ZNRW/xRSlu216UEqZVCUwS2G418ZxxlSdf8SFooKd9vLaPU4LmeJ3ru?=
 =?us-ascii?Q?xkNIFEUycIfJwbAdL5CiumHxmijOTZR0NndnncXm+w6PCk6dfPIltLyWmBIY?=
 =?us-ascii?Q?xrL+qvFrUNRowZOYbkXvOiVOw/tbeIg06wohscK27MufXYZWI/UrCV8lSHqn?=
 =?us-ascii?Q?C+KmAY3m3sXbEz05MYliDhC+dGKaOTYX9jqNMh1A/FgnA9E/Ifm8qFHaTdk9?=
 =?us-ascii?Q?ajvRti4o2Rl+pba7WFtvEUgFBG+XF806aA78mY58fVc59obt2uxe9CuVGJJ3?=
 =?us-ascii?Q?kwgCCnPtp7+52jTxC21Kz886gS9WJi1V5NHvYFdF/kmOCwJ46ABStG79DC5J?=
 =?us-ascii?Q?0YhaP+5XCwRtQDBtjC59tnicNmMoH5bEmlkKbUgWZsEP4ZurcrcdsJpqadIu?=
 =?us-ascii?Q?vjqPW7HrpIiBvUrjDTPiAP2GX9BkaWlwIUcnVmK+6mn9Sxciir89wncfUrn/?=
 =?us-ascii?Q?wWFrunBSVpTZWh/QIsTu+wT2LcdtTCDXVqiXXXeoqYUxvzT2Ua4FttW7cqGh?=
 =?us-ascii?Q?FgP64iQFACClJFpZ2qiWknUUGlbFrAXX6cwTD1WOuPD2TGCXDTton1BHZRe2?=
 =?us-ascii?Q?PhK4P67drPsabAIbpT7dU+rYAfnMKvmCeyU7oHiiFfGelsOSr6+m/9bsscZe?=
 =?us-ascii?Q?f9XkELo7QhwsSm6TsjsGK4VMtba0SFyuEq4SgbB4Xn6wAs5jz/7cN1hamWsP?=
 =?us-ascii?Q?z02TDOKJdVPfD6MENtMYEoCow6AQ14efzg1AF3vIs07N0e+JaSDdShpbeyMy?=
 =?us-ascii?Q?PfjAnY4yJrqGmcAa2wM8ba3ROCtSIeaQYdgR3hqspEOcfemEev7tdfmUYNDa?=
 =?us-ascii?Q?0YuL86e9ah/nu+pjuwTKCjGIL8ti8lzXqNyQqkIPVqrlicyXas8Od0PcwLOx?=
 =?us-ascii?Q?Mz6MyvpA/0Z/NxnJ+LHX1bQWxHM7UiQY3y7F5zSHQdeISzstpLNCQBVe75fP?=
 =?us-ascii?Q?818E8bbtRooaZ1qxlnKeFe3hGgZFxCEHt+WykwTYjPFRJZAKcIhSojoijthd?=
 =?us-ascii?Q?ezpJl1Mw8ZUUsLYbdWb4kY7VmcQ1GdTzXnYckr3QX2mJPe/zh+7DVHpXFPRc?=
 =?us-ascii?Q?9JGQ7ULIeZJdGStDlph3+q3sAegBlzDfFzKjGH9mZDSMP3CTct5RRHAs5ok8?=
 =?us-ascii?Q?zab4zQW/edFb1n3UaDW5C9lMLNowyxnJITOh7sPqP2cmqp1w+T2Dm7KEIPYX?=
 =?us-ascii?Q?rB8sbFbGioOTtz7vlSUH1n1qId1ajFXs3R21Sh+GXce660y5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6501b02b-517c-4bfc-b1b7-08df0993a72d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:16:28.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5WZrIMjiXSHytWF/MBbLX0eg1Eyg5+1Jer050fIZWQa+AaO6A6chpX5pMQPPakPU223WkdK57YUGq8sV+5q4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8

On Thu, Sep 03, 2026 at 02:23:03PM +0800, Zhiling Zou wrote:
> ipv6_flowlabel_get() allocates an ipv6_fl_socklist entry for every
> successful GET. The recheck path for a compatible existing flowlabel
> links another lease without applying any lease admission check. Repeated
> GET requests for one shareable label can therefore grow a socket's lease
> list without bound.
> 
> Reject a new unprivileged lease once the socket already holds
> FL_MAX_PER_SOCK leases. Check this on the shared recheck path so reuse
> of a globally interned label, including the fl_intern() collision path,
> is covered as well. New-label admission remains under the existing
> mem_check() policy.
> 
> Use capable(CAP_NET_ADMIN) rather than ns_capable(), matching
> mem_check(). An unprivileged user must not bypass the cap by creating a
> user namespace and a netns where they have CAP_NET_ADMIN, which would
> still consume host memory.
> 
> Check the capability only when the socket reaches the limit, so
> successful unprivileged GET requests below the cap do not generate a
> capability audit. Do the admission check before updating linger and
> expires so a rejected GET does not refresh the shared label, matching
> the existing socket-list allocation failure path.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
