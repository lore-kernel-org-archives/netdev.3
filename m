Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678E356748
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887810; cv=fail; b=khwYEFACj6Kn4uey+uKKoZTeH/Z3nV7kpS7Y2Bri9jaQwndv4s/s28Q1ARpaEvOZOh/fzaely8qailFLj4EiL/zMem56kR+MEdHeBw8mMZXi+4Tu/Rj+rDQf3IV1Fgx6YkNm7bCEEf4077JYGksSxcJsoIcnG4HZGNaNbJYeUQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887810; c=relaxed/simple;
	bh=jAnjRGqPBj1alb2khLtAYzaMGKulorFHIevtrGeVpA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P6Xl7RR9IdGBM/4aUaybcFcHH1STme0MQeHmM8rNuuN8BtwAVZUyznXUyYBKgeBUIPfuVz4esTbS8wQ/tETs5KwTafRl9BwXds26ZEmcKtJDmN4OIPwvgGazQ1p56FVySPoIwqvRx6e7EZ8Q6RQKWRlS0tcGVtDE9NFbhSn7eKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ji7CcZvg; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ji7CcZvg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulGoWNUIpp1oEXT9rN+M51r6SnpdsSwuVwwdA7cbeI4PKqWSdC6xs8YRU0YlDqJrMDVDrkVHAaAlYMgyHztKhobTOYyBBicpdNCHdePuU9okF6pgGpm1whvJ7eHcmh/kO5D3dlutfSQVcx3x61b2XFG7bcIEIA2aS/jLaShxgZ5hovzvfCTCPxNwA3LMZokIyEUOnU1tUQEUtGRyILeERjgdveGlq1WSjWI/c+MIpTnFFNY6CLgPQEAsT/hJxcu81ZKuB0n9SI6VZ1IyZdmHaA7beGBsBcjag6Bb7Qym04y6RZ473p6U4llR1/0xjahwDmYPts02kMsQkgCdQbz5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pfwp8mwSNa/speqIm/NmfL4pzFTSu93XwPnvru5sZo=;
 b=GIf+Lzr8NAhCgowdJjCDEhD5e/8OAwrBZMnoxlTZCXE2MqKq9hTR8IQl47+Yfy/+Gu+9S1cWgWuz+A3WKWAEnVvGrsPzApT18YU9ln153UbVMln/UlaNCUpbwzG2yJRp5wWQv9r237oNkDthvrW2dYbO8LaI3rQSoH2B488uKGcQyTKGVEn+kC193eZa+seXjCGwYqFXyTyNAAHxkVzjAFMhOMzliW4aU70xDZEAgoarxbev2oKz/rWIc2bvYbP5+NQxP4mPeeqFwOO4LePabYf4FBp9zwXEFfB7tlbDm/PaVdLi2ieEZeIIZTeo6L/4AVfZmOVhSSXJjw8KY6CIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pfwp8mwSNa/speqIm/NmfL4pzFTSu93XwPnvru5sZo=;
 b=Ji7CcZvgc2HGJ4fqFIG1qVRK4dXdImcvT9aSqjjIKoGwqDnNyqUV0gHyq+GaoqHqZmfoVbl10ONBWXAr7crvt9JKRVOnHuptcsj2opTeDASi8KVTxfGWDrEP+QmGciG+vu/YFoMBK5TBhKASuIoY6F8nRI5w+piAK9lwXuKey9g0acmUM7iFzjCxTY/MAn5ZM+TQzXZnketycHjoSJDCtSoI5VGoRewKJhhtbO+xRW5i174cHLUalhaY8rUkdxzA4gXkFbDFWXxihABngFbrKDiv5v1nzG2ywdfh34UPyictxK2hCH1Rf4AiUYQ8u3Y8oA2z7mQJFPeqJp4NzRyeNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 07:03:25 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 07:03:24 +0000
Date: Sun, 20 Sep 2026 10:03:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, jiri@resnulli.us, vega@nebusec.ai,
	milkory@outlook.com
Subject: Re: [PATCH net 1/1] net: arp: reject unterminated device names
Message-ID: <20260920070314.GA1791430@shredder>
References: <cover.1789648438.git.milkory@outlook.com>
 <7f570426c2fe95743f017cf1a14cdc7ace42851a.1789648438.git.milkory@outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f570426c2fe95743f017cf1a14cdc7ace42851a.1789648438.git.milkory@outlook.com>
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce1cc23-b3a0-43d6-1166-08df16e54369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k6rjSAkvuinZuAv3UsJFmL62WmdLb8Gne12bkoUcOfA8kPuTYPRn/fdGpJsYp2GyIXxIsW9csL/uFlYNIjuKIu2cYV9mxHDD5ei06s9f8LIUqUJsGklSWIf8Ao/j9rpM8Yli6LO8FC4NdWd+dHUDgVOPAhx4DiTe9h8muFhu71IUwydwUpxpHW3vDQ8cEfy7oZNCbKRaVTlCgY4DFTG+hdEfvVzaCjZfu0cbjZ9tVAVICebjW8D0gE/FOavxZgiULj2f2TTqb/VcSo9d5E/6EoAvldzioNtrMdACgaIkAleSrJwhe/qcGDcYOe2ydZl5NkPa4vr/bY8QGbA3ms/F2pINsVbs7ahxXHyG0qORTJXlbteNKNbSS0ep/tnyWiMNpAquxFvOQY2BTxEz2oU/fvLpnci3N5C0g0RGncu5jbNcVjSZY0LTabiM6cAtvdKkpvK3rZT1r5wwe8VeaC0UEQK+jSQRuqImIBeHjGCC7WGpJSur7mGVpaHi8R6IuVqZDAZMiZ++hNwvhOqHDJXwbbdv1SJDkBxTMISpf8IdI4NhY7MIFzcvegeQdT/UW28+DtYqMblFjuvRRP/lPhn0GiKhrm6z8e8JdhBUhFNQQ9a0cbgDyCMj2xo+7JiCTjkjxMbtIxcuJq71w/BRDa12sKjzHB/bVM2nMs9swDMnU7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DYrkJRBr5g8Sl+a/H+2Jxfq8C/oaX5jbiBqRFyyrinC4F/Xb8AcBnwBhlrKR?=
 =?us-ascii?Q?LRycErH+n9mDbiGsWwzJHxfbzQV/1ZCCFUH0SsEzZIFG5yhkYZxoXY36RC5a?=
 =?us-ascii?Q?8j9Rq5usaF5rllCcmb+bpB1jFFmnvJY15YWb/you86Cq34Oh6qg7LNfAFgi9?=
 =?us-ascii?Q?Kj8rbNibAebDWC4HRjsgGWi17W3xGjfOMPDDJ2sWqSXuTyQ+u2ZBhIvtZr02?=
 =?us-ascii?Q?xSb40jZ2+ZXFnuBfefB8DRboDk7DDbG7xdz3m6WcLIWQ8AHeuFiFo8nM1fcw?=
 =?us-ascii?Q?PyLHYLvdRewp6qYyMcYG0ZH/RNs6demekM587y7HJZeMyvKD3EqBo2DxONBu?=
 =?us-ascii?Q?wyZnoK3hdp8MuCJMPTEO41yn90REDej5abE5vETQHXLL0Mm1MfqEEgiy9vm/?=
 =?us-ascii?Q?TLLn1DdrrPQqCy79q84llHGxSxl2tJcsevLA4UJnhY29VYxbUmQ0wrnVWvdD?=
 =?us-ascii?Q?rHCgPgxlhCnSfywB3E6ReG7k7J6bgO077H7VyI+cIGWm8u0XvkoD1ukrI6Sv?=
 =?us-ascii?Q?fwN41pDuRPe3WYq8TMvsOBv3qFhhcUSpHCKUQzsUT3u/uEuBLacv12xBkoNg?=
 =?us-ascii?Q?dbVcSzrQZylHWqwJP3zX8+jrTcG8GMOQ1ejV+L48U7W1fCTjJ1ZQ5WlftFGG?=
 =?us-ascii?Q?9CWdP+KNGHaz98bGOTkpx2PoMbYIDk8Bp4XU9g86R6NQLxTEi8bvw5ee+rMB?=
 =?us-ascii?Q?e+oZ2kyToqf8a6qyW6VvW9/6+RToDZEMNmlOCxUlZw/wbjYtGy9IxHRx7kY3?=
 =?us-ascii?Q?lVLeZv7g0JSjGjZQooJn9S+vRh7d3kydwsH3TiZnu+SUgxK1lg6hoEgxkx+i?=
 =?us-ascii?Q?+I7j9vMD7MAaN6n2BjKk5Nn4hLb07Max4bnS0DFW27lLPc8yR65aSO9B27Dq?=
 =?us-ascii?Q?bS+KfzGFs2aVggFd4/QYxJ3dR5doL0r7BOeRcduYUUVJWYGrDyjHfxn3a744?=
 =?us-ascii?Q?CEyejA1Z9n8lD6GDNj8Ec08VzbCagEgp9DJX3w3vXf68+5rqWo03HkTh6Fgu?=
 =?us-ascii?Q?y1P4nd92ylLGuVonNzuF5NYV412/zfu0hDGNkrBN3czjuH/fjc86xOxTyvX3?=
 =?us-ascii?Q?7jWvxzh3vsNbQA2IGdHFUQ736GDl3z69qaEJdcesRC543y2uzLzDlPCA845Y?=
 =?us-ascii?Q?qE1U0ldThMT5D0k7B0D6meJdVfj7sjB32qF0qtfC5oLxKuSUszPir7VhuUn7?=
 =?us-ascii?Q?AxJYTs8+uuOTQzrAai1RAefWKpRwf9Z1GKHoEFPQ2Xs0/PIkRXNNYh1QHdqW?=
 =?us-ascii?Q?7sxbNbVeFCiMVXbftrwRyqpAAJFGydpLcJS8lk3jPEJR+NiWQf3x5NyrVFmn?=
 =?us-ascii?Q?b/Fgs2M1icKi/r3zKZzIjMGTcWvimPWNQ4n2HF8rBKHd9SfLWZuluA2QXwr6?=
 =?us-ascii?Q?jbHFedZLDxPA72d/CGk44gOu2eMxQ/myLhQP7V0/VTIcblAMo56lnbrCdnDT?=
 =?us-ascii?Q?z7tOGEz3jPPb0izG5/WEik5gM9mewGZt1tjXdYLEyzc0MJ+EMRaSjU3vND9h?=
 =?us-ascii?Q?Oh4TjXvSq1gtwFVPWPAkDRiarwg0VELwCXDrO12yvIHZk4chSfdDpkkw1RUo?=
 =?us-ascii?Q?Eg8cIwxmF9SWozKlkPxrpMj1E/i8d4l5nPp8yVSrfqLWb1Sm34oqjM44sQdV?=
 =?us-ascii?Q?HZwuWZCGnnopcMqeCtoCmcD7lHEnWblvcJawDv/ZiwZGufgcJj0AuCVK8OMn?=
 =?us-ascii?Q?AnmTkSb9zQplsiEmoeHORfvtJnn1blUTtrXaMSrDA02fjvBDLXHJsC0jcH0I?=
 =?us-ascii?Q?RnAX2FZavw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce1cc23-b3a0-43d6-1166-08df16e54369
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 07:03:24.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9BpPzZzdpQYAGtt8YfiKtTWLROXyjcFXgzGOYZawDwo5ht4o+vsjbkw9R4YriBkYEqZG80OC1KP/9IR96D9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488

On Fri, Sep 18, 2026 at 05:32:16PM +0800, Ren Wei wrote:
> From: Zijie Huang <milkory@outlook.com>
> 
> The ARP ioctl copies a user-provided struct arpreq into a stack object. Its
> arp_dev field may contain IFNAMSIZ bytes without a NUL terminator.
> 
> Such input is passed to dev_get_by_name_rcu() or __dev_get_by_name(), where
> strcmp() can read past the end of the stack object when a matching
> alternative interface name exists.
> 
> Reject non-terminated device names with -EINVAL before the lookup to
> prevent the out-of-bounds read.

Other ioctl handlers (e.g., devinet_ioctl(), dev_ioctl(),
br_ioctl_stub()) simply add a NUL at the end. Is there a good reason for
doing something different here?

> 
> Fixes: ff92741270bf ("net: introduce name_node struct to be used in hashlist")

Nit: Blaming 36fbf1e52bd3 would be more accurate.
