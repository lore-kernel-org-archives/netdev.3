Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D615275B6
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913553; cv=fail; b=mAMJS3a7H/pKUFII1L8zOoXCoMm442WfR9/thDiCg14ArAX8YUphbZoUXRan7g4GU1K/sakYUAgLKRvjsbKIdIcMMZbntR1hsUCUX1J4PMzMWMo07y/0CtE+nXAcGp1GJFE6LyR9f+h/xfk/+ZwROdXslPP+IHHpuGdx1923AWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913553; c=relaxed/simple;
	bh=9RyUg6VgpFrBq/CFNUprjKH5oG0OWcwpRmxAf2zzW+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zwe85as/SzzUoi7A0qCH5bnafk42AqXAN19tN+q4K2AkAKhVdnp+IO3oXzpU29g3hbeQl+eurwWdLgPdZloQ9x4Ix45QVrShcM4oNT63YfojuFEOYyODC01pt7LEQ5NIkPR5INDgc/05cCZp+rgCOsKSEjaldF3zJy4kOiD4als=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jq2C1u/I; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jq2C1u/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHEmJ1Dnwy5+46GZMZLIG7otubkg0x1toBALGkBRy3XzpZdHMcfaQn74wkDxrv+q3SCkMZNLRTm8gZW0b3D3sV0X6s4mfDHfAvo78wTso2vWUjfjiZk6etvhOlSxokc2VUO+/VU3VluCePFvTkue7onUM+aMjX6iBwb03/yQwVX2QaDCrB/TGqbdlvNgKaUZ5kWg3fFV1dSKVtCWEbOlDhmsdJvBzcQ35NeGk2FWOiJvBzsVTV6emgogXE+sKe/nQvKV5YSDuXENQda2dpI5InomBg3pPJqBFCCgdvyEAlythq3pVtiZ7jxLGF19sd9tdBZq6HtK3ZmxPFJ2bMCd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RyUg6VgpFrBq/CFNUprjKH5oG0OWcwpRmxAf2zzW+c=;
 b=c+pba9jzGLyPGU7y0+6q1hZ2GW9DfcclTgwxC1BT1w06G7ak0ZNTJojnJ3stSncsv/DiFepQV8MRH9EykPoXpK3FwziSgUF5ZP0OLHhakTCeon46Rs5ks/MdWBa4wVW6fX7y0mVJx8Yurer6fK2vbDUnJ1yU0cPVPi2RCLztMPMcZcMhM90Dwc2aERcuY2rxm/RGBNoShkbvgT1w0M8oIaXk5Gn88T1DdgM1+mZAIeBFFV/oApvxZgB6atm+6467u5tmz5QFuFDbsg4dEQXoFNMfKueuFdQk6LUB8O/N05+4LR/IUvdIeUkXgkmq4T59ce0f/D6f6HOh7FA/flK6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RyUg6VgpFrBq/CFNUprjKH5oG0OWcwpRmxAf2zzW+c=;
 b=jq2C1u/IBjxuMPNjJ4y6QA+gKgXsEgjTP1UEvTpdaPgJ+XUfHF8hbFldZoIFIEw7lGShYctbEKAStwVZpHPIpArKXgn5p+VwbJ8jFGyzDhPJ+ZrFmEA3eUZHeew0tm8wO7GEvSzZh0voFmUgCVfGPxxBbjqz04NaABvVzpvCFSaPXc5nHhoaEUHH5Y1j0+MVEHdzIafDMgTdBfPhredVOjcb/bJHEJpqZ9liHqjuVdVEnpSJdmW3H2R6M7xCCoRTpuJmrMaRV/lm2UQzHADlGVuqStQVMprWHOVKiMS959MqK93WZ7oELPvZWo+fWQDowcVjLJqXLSFMlFxGoQ4HPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 13 Oct
 2026 17:45:45 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 17:45:42 +0000
Date: Tue, 13 Oct 2026 20:45:33 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@kernel.org, dsahern@kernel.org, horms@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, daniel@iogearbox.net,
	petrm@nvidia.com, ferenc@fejes.dev
Subject: Re: [PATCH net-next v2 0/3] Report netns cookie in FIB lookup
 tracepoints
Message-ID: <20261013174533.GA1114705@shredder>
References: <20261008133158.1438907-1-idosch@nvidia.com>
 <43857d08-c4f4-44ce-a0b3-0e7fcc56bf90@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43857d08-c4f4-44ce-a0b3-0e7fcc56bf90@redhat.com>
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 83da3502-698c-425c-c222-08df2951cd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|23010399003|376014|11063799006|56012099006|4143699003|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	68VxZ5A1sUJG2clcEpZvJHPfH98cyh9VlQxyCCXcogHlbOzTDWmVrJcT1PbchbDWuONYjFD7b/qWEKFJxu7APK/AtXAQX3pn+ky3irqNFBwGjSisfDNG1S/NcSdK50E4hTYa238iH6FT4/5AAQF+e8bdGBPpVTdVGg1+SkmriOGfqX98wEm2labWv1yusB/wDO0yk9NDe/C6HmLGpWblnD9KKMPsfjRP2w99QmgJ0P39S9vXcDrpcmDq5yfUxNMGcVzqAV6oofT4+AJWRemOlSyOnO+LhIlAGxLFQgF+PGDt02IenJhjTGyhQtp1HGejMzpLz2fzQjxdvFe9F4ROJFyRU50vHBSZHNVoMHOR4lohx/7j7csPIuuYMwwoIpze0GGcvisvnkvZIfFfK34w1Cew0Z48BchYHUITkmejaBq91YiyAsKPnt3drS7kd7xqZFonbjbHmsr5I1bJwmYIoLWTIVVwyCEPewHqJ0Nvj+5KFnB6hS4KXF9iIxrK5cx+C4A+8ToeuEXJ358lPsdibIfk33wCPRVZuKkgBDa/QRXgBmDVkLTqX34cUGwNsaJRAhkSeGVrtKkLHqaK/xg+nYfxFcPPbe4NygmSJlqH5lJ5MnGx83vW2xoluJe3ext7uWZllhfnBO1ujgy1b0b6ASe1aJy38RhpU+m8rcvXRPo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(23010399003)(376014)(11063799006)(56012099006)(4143699003)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMY3WhDFIbTlXrLBESKg3MGHsD7+7cvQ1HN1KP1UetDlncdMp9RJlz67TQb1?=
 =?us-ascii?Q?B0ODpdAlZr4Ys5AYxLWtFriYNaieFTrvq4qtESE9xMulSBL+95dtG37BEG8s?=
 =?us-ascii?Q?eINgc2Pp5RnUcMKF8lumI/ewO8H1MbE0devsE3mXr6ptf9XU4Xpdl2SZq6aB?=
 =?us-ascii?Q?lLYf53jfUGEMTHkJjTZO24Ac7gxj0ZR9XtA/XK8InNQ67+BJmykoXxagJQB0?=
 =?us-ascii?Q?hWoMj487+1E2SSdKXdNrGqcIRhx14T040MGzex6o7+nw94rufefvREgKOABl?=
 =?us-ascii?Q?fUFhidSgbazWKX3yL78YdG9TvpZ35G+oS8rLNLBQS5jFa6VNcRliTmZs/KYk?=
 =?us-ascii?Q?JZwoxgAJOnGqLlGK/z3L4pqNakbQLhtqlgINGX3H/1OcA/Ri8ijxQj7GaL8j?=
 =?us-ascii?Q?ITGnldw5+BJwyG/CBsDaHtBChVAT1hRLcO+zH1AUwaMp1mA+2gGQQ4mNlhy5?=
 =?us-ascii?Q?shmZnXWtvqEveR99BDFnwc7mV31dsV2jf+VNqp3rIleagBSVZ3hcgAXPAXeD?=
 =?us-ascii?Q?3rMbz9YMa1COH1uY8J6yA26ii86tSf8DrntuppxX3iKZP5C8M/5LHxWUONPQ?=
 =?us-ascii?Q?nBHKZ1wfoTr7kQpOLhd9Er3y401m4W6nK+oR2+VDd3FU7U4EnoOewG+O4SjM?=
 =?us-ascii?Q?vuEXuoLR681cQd4xb12i1kl6gGKg5Og0PcdgnbQ4m4rUf1OShmo/ipEZqxId?=
 =?us-ascii?Q?8UrbhvB34mSNIcriaEhVqkiHNlNK2PTfQ9S06u5XMs6Y0vjFamb0e3AdP40K?=
 =?us-ascii?Q?Nlf9ROwBU1W4UJmitonxOg2H5eSfJzUxwKdnPKFqCApJbNSMLfZinwtzYTC9?=
 =?us-ascii?Q?BcQxlrhqX/S0yZGKARBH5sOoIRmLOdbnrm2yp5HjggPAQ8eigN0MIFmv3KU3?=
 =?us-ascii?Q?kOBu5ULY0wKNe6IfvV/VgMQQkNhFg1eVRgHvvrlwWKaHH42KS6OqaM5BAKQJ?=
 =?us-ascii?Q?njuZpbrZtRgNBIEVOhivW8V/LbOwz3asZ5at5HUT5UQhX7KmHDK1h3XLqz+x?=
 =?us-ascii?Q?mHwrSMYQyLUGpFSDzB+XDfZX8laTKPKlnjP7CSW/v+6OfsAiPo6PvDWvbtwi?=
 =?us-ascii?Q?+5NIMQlJsxuAXNJoO0caSEHwcUNwPLjjhxztTo37LaFrzXPLHaeWxmrago7V?=
 =?us-ascii?Q?20tJU6vamhjfPeznKLc88aL6kdh/PrmbdIXlLZPNm4IJFLn2IM2PNp0Rtg1f?=
 =?us-ascii?Q?nd+LxXZFAOE0P7dNFpXdYw384Soj/cx4KSyjK851vxsvXFSAHBtrAEIgSdV0?=
 =?us-ascii?Q?8FKFQz+IHPCMSBoBPonuznw027TBs3de6dvSYraDf7IxIOfrloFE7B2hni4v?=
 =?us-ascii?Q?JePnSVsW5zZ0QIKhhwswztaoN9fQDlwThDcijuvImm1aXmvp8yexeLwLKCe4?=
 =?us-ascii?Q?FNRWEv0Lg3rnOt3W6lTL3geRDLqPDSlemwRkBiqBxtvIf4QbEDtGQrssCSmQ?=
 =?us-ascii?Q?36ANKj9fv4LMbn037YYQsA5N1RueDPzTFQu/8ALLpK3BbUqenEMapulCWdpN?=
 =?us-ascii?Q?jIgfht0xD6+ifEF8e6A4N0Eo9WuEbnNkPwtAeSXJDn73afKwgIzK4tqPp5uC?=
 =?us-ascii?Q?E1mC77G2Ka4MR4/UGjBZMCDDRh/nNLdMx9DfZe5j8V2OZwGqSc3P9nhObsfm?=
 =?us-ascii?Q?4sGCiJSbKRKhxY/TFlykRF9/qTRGFAPvqXxhcyWVkfKpX/uPfs1+jUNe3khJ?=
 =?us-ascii?Q?yLbYjaqiue2a7dZHelgBDF93BTOhvP7NmfZQIFwklMDh1H5ssk81NnV3NZPv?=
 =?us-ascii?Q?K93JeA/C2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83da3502-698c-425c-c222-08df2951cd1b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:45:42.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sy+3AAXbyaAwOudrPX38GSV/YHCxEtbING2Y/3UbyagUCoo+mrmtzOkHRllVb4vIXGE8kYWW0DPjHKK/2GF7DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

On Tue, Oct 13, 2026 at 12:25:56PM +0200, Paolo Abeni wrote:
> Not intended to block the above (could be eventually a follow-up), but
> I'm wondering if you have considered adding a `net` (or net_cookie) field
> to the fib_table struct instead of passing the net as an additional argument
> to the lookup functions - AFAICS the latter are also called in critical
> path and the additional arg could be unneeded (very small) overhead.

Makes sense.

I tried to be consistent with IPv6, but fib6_table_lookup() needs the
netns argument regardless of the tracepoint. The fib_table struct still
fits in a single cache line with the new field. Will send the patches
tomorrow.
