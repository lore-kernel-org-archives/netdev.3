Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE293B47D2
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542334; cv=fail; b=dlSFfxk+IadPnW+exOrwqw1kkaigwEeDbYUUax9rCFNEFFeg3ch2T55/9tUAcw/3PgbX8ayODucKXupuyp7ZYlB86JqRAkkBf9KHMMRdlKCUEsPmkPTX7nwrt+Hx4RhzFedDXlxFhHGcMHSit4C9eoKi7FTR81ayAavqkAnvbCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542334; c=relaxed/simple;
	bh=IeiIMA0xwpe8+/5X29J9j7LbSuhDGRm9SEmJu98WR68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4IhRtZkanS6MgzRSgTtRJMwzQBhUoLEyrCRkRqdg12Xlo6SnLH8Id6TCqieyEnL+pr4sAlJDLO5ZzEYewJknbvd5wh2XQ0KxX+xqDlDHvkIwFb7cm4o9W5QiC0lPFTOvawOmfpH0kTZJNDEUYIbWONcDdAxo6O69SaXWL+n2ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZgMf2V1s; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZgMf2V1s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSl32i9kBR4UPHWJG6mZRcEFzql0U8Ac+sYY518TUZOllhWTGA3KzRbekgYhyRgOa6r4PJ998PzBz8gwQ2iBA0hqgYzhStftXjzrwrFOMdT7sGXPPHjVttJrRYyxzPSYDQudLKlPGYlnaIHBtqGln5or8jFoqQf0mDF/Td8lgL22oA1JEtYARCKEVRpzaF9fXBVpKUT66bwcc1oICQR769vr3d0gESpHJ8jylP9Ju+KVwJb2axqjBbgm/O6SB6lYksGKqvF5WF7FP1asPceIAbEIdoPzY6Eau2osbRqocz7Mju+ju97muOGJTG9Yw8wwmX+6zzPztYSthdICIZjdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mOuB41cqAh32oNd1Siof1QAOfRm2s3X7/53RluhH+M=;
 b=UIKVxb5Ah0fvyxQFqqOSNZ9fmVek6KQr8exihaA4jTw+k8kpCrDGbqEA8G+m2y0NGkvTQS798EYciRfWBlOP5uesSKz1NNlTxGeV3uQvpYvi0Bd7xLbDz5TPxNzrKkQFsf4yWBZAp9QBwpLu6xDQPSMeDMsMu/mTDWJJm7qNBYt/55qdQIB/+8MI/WWUlJycQiI9SVGdkHzx040I9UgyzC3uYBJ66p6Tz3CHnlZtxMC0l7o2sbdX/4Yol+UR+ZtNzgyMAG0XIVvsV+ZK1p8Vx1U4SmPAdt+kJWBKo84zsXxR5nXGaIXShRdNdT7+E/2yF5ZOzwNOWPTp8NJsOR1CKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mOuB41cqAh32oNd1Siof1QAOfRm2s3X7/53RluhH+M=;
 b=ZgMf2V1skmQheg8wYpUZmkm46pVHf9uKNbeI86sa/CiY0/yl0UypQLp8iwa3c6D9Z7XswAjQ6x34kKiHDeYByM8S1/iYDgTYvY9Sa1KZSQ18Ui+Gy5zKh/oVZXOhwYJbnEgKi9g/gbJIDMY9XUfDCiW0MfjYL43wThycXP5ZDMuJTntWqX0j2B1rMumdnYkWx9XD4Q8F8vOKWboj1m0DLnwchJ0/ImI+k2eeLklinaz3YbTMYoU4hmC2yvZ2gMp1gRLOkLFPnA/9CH/Unwxa0Ac6v0LtRQZd2yXifRCD0wk0X/9D+WVOcox40a8K5NHJCgh24fk09uaIJGccNdcztg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 07:05:29 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 07:05:23 +0000
Date: Wed, 16 Sep 2026 10:05:12 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Quentin Armitage <quentin@armitage.org.uk>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v3] net: allow IFLA_INET_CONF messages when NLA_F_NESTED
 unset
Message-ID: <20260916070512.GA846427@shredder>
References: <20260915140518.GA687229@shredder>
 <20260915213320.1527029-2-quentin@armitage.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915213320.1527029-2-quentin@armitage.org.uk>
X-ClientProxiedBy: FR4P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 68351bf1-92ad-4c32-067f-08df13c0e06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mn9DraKY41PvVav1/rGFhwESfUOwKPmj++ZJaGJ7cz9dUOUp/baOuC9tp5vknKnWKne/T3eYVUjEti3jZoqHZBgOv8EKkfRRyaScFCZj4jBlvf85yMeHW4fHTqXZ3Bmwo3WsKs4naHOSvaypGXqr20FiGMBk1Xfi0jsJ1dwtnarggh5u6PGy6k/r28b4b6x5eLeM+44eP5QMsDbo4U2nv9ajvWN0jY2tZ1pHlDw2DJj29pKOImlK3ZxYRkr69friqjEpeF7V5j1v4zQRT0jDmHdkTmOtye3l8qBV1uARZjIyUzPkdD07qAVL1skcAvTVoz3mTAGME33lljN9KxiQUZWk8dXBvxixyzDixqy0O58CVnbYOgWqOITfoaQLP2tceiyZaHMQdHqcOdif7/xTcnKRsarp91lNObFdHTgQjPdblHWv1PrF4sYdNSYtXeZjL3DKMM5Hmsstljt/D6yL52yR0S2V+CUyzzu0t0rWqMVX5//fmAMKJH8muWsnRheIofNWODLvBNzy39NpQ1Ep8nxmV3VSIzleLDcsv2jGFebXxGyCJEk4NwWquo0qPFYbywwhP/F8hmSBocWqWQWUanimW7CcDObvFTlTXts/dunkMoR96L+XqRCzBskwCeiBFGiLX75GBrrLLrJccyd2Ftkwmmyy0dcAhc+F17pNu6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GHEkrBHxGr0iBXcVARLe8MWDboOwGcNPiZXHGjH/gjeiLnHGp224mFRzr0hb?=
 =?us-ascii?Q?aziGf6EOl0TGixexM9afbbCersmnUx5RwQ3Ys9LBwyg/MtTt+SI0YSiXmo1v?=
 =?us-ascii?Q?OnhbaCXvrPdHBCWeKcEA82AnYgcKB0CbA7lsbUbuDSCLsDcO/UUAMHsPWMeZ?=
 =?us-ascii?Q?E+rcUjT3Xn8CclXQnTq15v17s4qrmlMjW23SQh2MH+2z7uqFB3aeOe5mw/I5?=
 =?us-ascii?Q?tIKqV2KpI4i8vKEbJeN9qjZKhk+u00NoJP0w0SVzFVYwJAVOMf98IHnbOIW+?=
 =?us-ascii?Q?j1OkISpDnmNkImuRRtc2AGxIdbhz/YNIzSNtLrzRJEZxIhyy++MbHPJoeOIy?=
 =?us-ascii?Q?ZgxmP4TAyWHMYj2vrXNE4MGdn57Ms3LFY+nMfNKZxsR7utZkEHWQTiKeHdxE?=
 =?us-ascii?Q?teQ0oSe2Qo+9F1gxig3pnxhCS4xIqcWcMCNmQuXmDdWK15zObSLY+9qm7KHo?=
 =?us-ascii?Q?wn/KRVoi9wJOcQl8TfWP09OTyGYGUHd1qb0HL8fQl8Vg2f0c2Tr1nxGM7Oi8?=
 =?us-ascii?Q?q8N2MJHEcQL5VW3WnmepR4EShPuhN/v8RFnqHaofQzYo7h46UZFwO5+kdRjv?=
 =?us-ascii?Q?2hsmW/wfGfqlnTK9JGTr1IPY5l+Y6jrfZTNb9+gnRXmtkeeeLvkMraWbjo/h?=
 =?us-ascii?Q?GcnvcIg5bg7PCz98QY1dlLr9p9tw+d/YtlNVXzjvSXN8L0uYM+mhzdQ9u9GA?=
 =?us-ascii?Q?NALhdgCtEeOGwyg2xscEBYwYuaN2PWbSqR5Df0XRgBQhAJx/Dx8cUEcmD3G5?=
 =?us-ascii?Q?NU4BZGEp6Rf4cvV3y+/bgRGLI6BcFzaE0TdjpNUMncTo9ZeWBJmURg4UfIFy?=
 =?us-ascii?Q?tJ7ZzmPdQk6WhhEXiR4+irQElnOyZv0ABrOZH9iuU1p7TuhV4QlqZegMEpAz?=
 =?us-ascii?Q?In3hMAqunDic4ZMEONHZMRxlfQlC+ASUWI3xiM1bmshMs1zN3U1IBEbiHKM9?=
 =?us-ascii?Q?d9Gfns27nmPTnJh7zFsMLfieEv4CF3RSgxQCPI/AVLo3YOy+AjeWwiFsGl1l?=
 =?us-ascii?Q?/kF4eFKJ3mNtrSJ8NigJwn2itRTjtkAHFGNdbbsaV0JF2Sj3p3V0hqbblv07?=
 =?us-ascii?Q?4jt0UGh1jyG0Fm2puFAZ7UCkg8IaUClAwrPQXCg8mOC04GVGuHQjIR5m5qUS?=
 =?us-ascii?Q?7tb6dHiaJnQopdVHXOhP5VpE+GwtPgSfUiMMgzDBWMRrfktBEZ98pPeqmTLt?=
 =?us-ascii?Q?WahYlrOEuFL79tuu+y6u+gQ3tp04yDSU+gOUqGZwzo4LdcgRCoc5WtFFdjk/?=
 =?us-ascii?Q?7UDtV65T5xLykcUiLU5edqeDKm6BelaItjLpovjYQADcikGNwLInfoHptAKs?=
 =?us-ascii?Q?g6bvrFtIz/GE+UTK9V1pDxkZFhr+kMRNr0NognPUmMPjq9WO/JERAOY5nXS9?=
 =?us-ascii?Q?5WePGJ9hlbnnr+l2a/VWpHFAlUGdYv7XIlEZ3Fx9RQLIjxCaxhBmrsuI1EGl?=
 =?us-ascii?Q?OjcXuq8Zw8zGFqMfGw0QJILpLBIimA4JWNr5F5zrDtImEhHFLWLtS5DQ6ql6?=
 =?us-ascii?Q?nBq5oT6/K0GRFFBtzRMWzAHbX4OWhf/um34Qpn0TCq49Ivofk0Pu4/kO+/IO?=
 =?us-ascii?Q?X4bV+hZHNfqOloVJpbVjC8DS8CsjJlIl1ogaC8LFCljS7rBjfVrlU+OcFCNP?=
 =?us-ascii?Q?EtGawhWPA+XsyTXSOYBar8mCR/g3Us3fMdSvdI8gumlLxIk/MwWJDTA0x/bB?=
 =?us-ascii?Q?RBOpDjtADHgXrZTpgJ+9s1xAOK+Bp25qGqQlPLGYQ5VBUk96?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68351bf1-92ad-4c32-067f-08df13c0e06d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:05:23.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjgyUWuHrlQTUZGgi4r3cMXz/rqgJ/bBSZSrtOOT/IMe81gTV26E2q8o+th7ndG0VTGQiO3QIMZnpCUuADZHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

On Tue, Sep 15, 2026 at 10:33:21PM +0100, Quentin Armitage wrote:
> Commit fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")
> added validation of IFLA_INET_CONF attributes, and in the process
> changed the call of nla_for_each_nested() to nla_parse_nested(). A
> side effect of this change is that the IFLA_INET_CONF option is now
> tested for NLA_F_NESTED being set, and fails if it is not. Prior to the
> commit there was no check of NLA_F_NESTED.
> 
> Change nla_parse_nested() to nla_parse(). This restores the previous
> functionality of not checking NLA_F_NESTED, thereby allowing code that
> (incorrectly) doesn't set NLA_F_NESTED to continue to work.
> 
> This issue was identified because keepalived started logging errors when
> it was configuring macvlans that it created.
> 
> Fixes: fa8fca88714c ("ipv4: validate IPV4_DEVCONF attributes properly")
> 
> Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>

For next time (assuming there won't be v4):

1. No blank line between Fixes tag and SoB.

2. Specify the target tree in subject prefix.
   In this case: [PATCH net v3]

3. Post as separate thread, not as a reply.

4. Use scripts/get_maintainer.pl to get the list of recipients.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
