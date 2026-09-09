Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3923B440E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936962; cv=fail; b=qWniqThHEwjx6ZOedd08W1DuwebuiJ6OVnsTau6qVRWglvssHtBcpGfVwPMSw23FvJQXcpZU20y7ZOi9kq30fzHxcQoZZdQFpal1QNJ2V6WbBRBfqbR6KFhf2o0WXh9Il0e2c08Ryow1I/1Plt8g4ha2kTt/GIzlG+2uf1vgR9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936962; c=relaxed/simple;
	bh=xRtm+Zh0DloDLVYFgabZQlGhh80I3iFoY/s9DcwlRDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K5E/GkbsSqKNnqgfCC51y8nN7DApqj5A2oAgNFYDJ6Ob25O6dGXhCnqdrZzeAtoSYN8TnzdGfDCmnlLVIxpAiifl60fr2DGoexK0Sib8j49fIEvsOfcED3G0fnmnhICiz9g6RnRFL4W5qNWPDHGuYrmeDhioutsg/UxgeDA2YhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGXJVloo; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGXJVloo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bInHq8NX86wAUsesAYrdwBEAxJHsFNReEVE0iVEiO+RBsSB5x5HeriqxCEmqhjGriYyjDVUYNyroN0h4YZxRaA0UPEZYLWtHap0VsZjQ1zBIbnesneV5ECri6asiNTPdvF94AREPoyICHGI5tApVb9S0zVwOJLlmGeUNoVzFyaPHonjN+zfjnQU93ribta8MC85q/Hnf4Qf7xY2svjKYygM2eoQ+6Y+pbUD+Hpb3ZRL56LhwOr3Sz3QKzAX/OBv22PBVsKBLvHbctp3GpYydoSLJjAF8oYbM/RcsdT5bOjYogSf600KKELEXs+mUetIzGglySsPIkKqUJvkfInlHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP1n9k0qRBPYk+Myl1We7yuom6gkILXl9lRuR0sIimI=;
 b=VA92aHa8SZdifAIM+W3NFqmYDlA2qWjTZoLe+lF35pcVXOOF6pI3RH0/YsfqAV1c0+3Waji7K+ObSz+HLXVqiSbhYYcG+A49VJdHgHXuZahXiSTDNJNqkIi66IrRwpSm33iqDAmlbchlzvFPSKbB8Uh0nqRnogRlFnziS4ugd0Q9vOkHtsoVQgWDGBHsJou39t0cGEyzQts32kRFPtuNPx6EZ8tFbbguTywjADSG1R8M1U7jZCdVodXyj1SZQEYaW2boqEbb3H51D1dlHEHgCbUDGv8ETmCDF34zNFT8yRhacPZ1JkYuzkKY2Qp9eQBT0oQImh+oNHEZmkwRw2Dfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP1n9k0qRBPYk+Myl1We7yuom6gkILXl9lRuR0sIimI=;
 b=uGXJVloo86HQs9tbY1kU435n0M5Rsu1ePiI8WYVnTwmOC0Jv6VkDH/oHmG82GTxl9DE3a+TLW2YdBGTwP++gItHi/6tLV6SPn01tRMm9jx5MAawlFPhYFmY+96QqDnlwILfqSbwcNUf+Fsjp7ZxKXwMeyw4PCVBgMe1hOj5zmRQSMk1xaEni5EeMPccam0PrdHINF/LPJIr9y8xPv4SPHG27H+KVMGrXr/puseqmAXPgHyYWLZvX4tMZvJpGBV2pDZH7iHOMfW2xBiYB7kiX4JN4oRqSkgUFXzBejok+K8BFMAsYo2ClVjMU1Y65zD7SD4CZQZ9XpSY8dle4pJLkug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 06:55:55 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:55:55 +0000
Date: Wed, 9 Sep 2026 09:55:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Yuwei Wang <wangyuweihx@gmail.com>
Subject: Re: [PATCH v2 net 2/4] neighbour: Enforce min/max to
 NDTPA_INTERVAL_PROBE_TIME_MS.
Message-ID: <20260909065546.GA1205208@shredder>
References: <20260908211419.882954-1-kuniyu@google.com>
 <20260908211419.882954-3-kuniyu@google.com>
 <20260909065116.GC1183641@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909065116.GC1183641@shredder>
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 787696e9-d3df-4f47-bb75-08df0e3f6550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|3023799007|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fUDC7sRF7W+rHlmKibvMtAFFySh28V8cYYLmWstBY3mDjpCWIyxu44Efenbn942kW75zLjiKSVA2rfREOZxofX5gTmxyBqTLORbkaK/83Fx3wSxNmtibwhvFjB3y2gvLBCbNnBsg+95XJkKRiBbjZHkpi5GxK7LtEZOLgiBheitRd3caTP5zUe6kzu7PbETzgV8xdMy4WK9bgqGZZzvsfWq7iMV9tOKYpJYHHmbq4Xe4qnjK+MfIUQoD0K0YuTA+8Sm+iym8lVimY9/Wr0EcE+Hta8O+6wkjwumR/kWKXBIysqESvJQE9nOUbS6fD4w/lh69QxUUpIp99uy4iNpTsZhM3h5zOqqJ91x0N+2HDdXpUio70/Sw2RocnCtQfg4DOdfXkbRjs/FIBKvY/PCx5DBv45jbVBVOHndFddBA2LzYGYSf6aJC1R8m4Sl6rwSgE3uQChg4BSpge/ZWcVjK6mGL2qbaAxwieFLR91r5DPL31QsHcH5y5uESCr3TX69SyBYRKxw2TIhFOP8sSolDDxoy0GYivJ/0meNLjwCeSMYCX5ZUfJtSK1VnT2iQzqoLIyxEX4SLhqwwLge/i1GVckeenLlNkIqAALYWrqrPaitrye6oTNXnCoIx3domrOxeIM1J8wF/5NMMKEVJwez2b07Uuzn5Fql4PgbQgUohwCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cM5MHSpHkVCiE44h0IwT5+GHYkq37KROTWEU/+fKl3RPgZu3m/LT/VGPoxsd?=
 =?us-ascii?Q?eIJjtddPivn3tDF2uiz/HZG/OzU/N8T+Mn0xIiPe/PrZSl2XabpVbzID5buF?=
 =?us-ascii?Q?WSBSZjsO9ikb560Zohw3q6Xqz/Jld8LK579ouImCNiohIWJ2C2Fb+J1si4ow?=
 =?us-ascii?Q?gCwyC2x54ktqU73FlU0OCrXIZOsOwAY+8sEj835gQhA9QRXVIgcbSqUxewBA?=
 =?us-ascii?Q?UD7FPfQmYNjvu0kYKF0vj6crDDOhr1aoxtd4E+qB4yPxpV3rtF4FGvagkFql?=
 =?us-ascii?Q?mNRpfl2O/b55mPXMxvLRvXxxJzijd0hZbjSa1x6t5xVqVQ0BkgmbKEs5V1+f?=
 =?us-ascii?Q?0RRXY4kebq6KVnPJ0cFmebNALWXE0THTvZaX08P9irvgu7Yo1T+kx2jOorwK?=
 =?us-ascii?Q?wjhprzCTMJgHMtv99iTI0LvmSU+I4d9e2I/j3oIMS8I9Dvk7W+6UeU8cCSHo?=
 =?us-ascii?Q?Sdhr2IDITWD6n0JfPdCAhdnNewaCQ3aR6uBcGff16YFo5RswwbSdrbOJsj52?=
 =?us-ascii?Q?2beofmHOA04KW/UaPpgNDZmls7Cz0j1ni67XTBkzkdU8Hdd+JDj2stZus+ZU?=
 =?us-ascii?Q?OAu0/VJg7dKxfS/X/YxeZ7X4JiwMHBCdZmkRNX2wEbOjORdw0V1lciyzzbhZ?=
 =?us-ascii?Q?hj8n735KajvJlJZ0cNYjYOblsaSPVP2ZUFcQPCCBIMWp9XdzAbEwktYReL/0?=
 =?us-ascii?Q?OEqs4V/jfxML62t06vMugkXbvab712oQa/Pddfr+W2ppkbNQPk8cSbBOjqr2?=
 =?us-ascii?Q?iHl5rLi6JCjDZhY49OP+/ftC57Q4hr0YofBtOfBzvmJ47gDP3sbxUbFrAEcv?=
 =?us-ascii?Q?/s31MC3rqiFaNEMi9R+4QBCnYXCL1Hw8HPlUE2F6N+cwkuXzm7Fo9KJ5x+zh?=
 =?us-ascii?Q?99ZVUtgbyH22NWlG/HD52QstLzrkB/ztbn+dIqs/f+FdYT4Jht+HcNcd9nhD?=
 =?us-ascii?Q?K0//xbqREbYKd9JhTngmdrAFBo1BS4XLP6Gb+yUlrtcCuAWTmVs/6VIR8ztl?=
 =?us-ascii?Q?D4Cy2W4dFDnr1GF8NTaa/QVJEmrvedskHc9G+AXDRtUk0UUkJybIKiV0KeNm?=
 =?us-ascii?Q?av1OozkZhOsceh1OgFHNgvA3aOYUMSpklx4Zv7dh4FUQGOh3RvGDyWFAHMRY?=
 =?us-ascii?Q?WIVTmCqexo2bJAuS+m+KhtpvWMDHYY7tStlrjaD0CJ+pBgRvFYHM7HCRx9lQ?=
 =?us-ascii?Q?+wITg1rDdVQxBO0/iQOmz1cnX2ltqkGliEhkZqnoSu38slNlaUl60roj5S7t?=
 =?us-ascii?Q?Dr8F66FzintVtLMaewqaDj8TcsHChWY+uX27qwKGi2VxFV1mZtcrPwAz0q3a?=
 =?us-ascii?Q?vu4fYAmznmerRDOzaRy5nkv7SMYCu17PxECftkcYpFWdZ8QxXrVRBudyLr4R?=
 =?us-ascii?Q?jwjftdGOVVT/fzjyO+EfzZfH9pcn7ZM7ApuMeWkgihAANUU1rBsW/UBS6YFB?=
 =?us-ascii?Q?DoHMGNtZBTG6maqMgAIB+Xa+dIzoemvRW08+Ob9nJwR6X/AKeaz4XB6NGd5c?=
 =?us-ascii?Q?J6AoQ5fOs1irRWaGf02wf6lsHZbIlBBblnPSc9ZzSmGJUs8TeQnBtu+QPgfx?=
 =?us-ascii?Q?TZKg2FB3wMduYCpFJNqoHzfH5+1vLB8hdDHTOnIqwnQlLWtqtYGF1TneDn6f?=
 =?us-ascii?Q?7cLdEBy6H7oLUupskTS5nYIIdtCYnwr+i6nCtvc5Dto2I7JWoeXl2YEeEFsd?=
 =?us-ascii?Q?7FMGYwTzBuU25+yH5CvX2QnFCGsTu0c6BiLxTf79/ieM3Z8u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787696e9-d3df-4f47-bb75-08df0e3f6550
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:55:55.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzYebNKd1t74d7LG90f1N/dqMMhkS8GIYuUNclFAURmSbhxCkNo0FcY7kPuj8YWy9VzfOIS7k1wsraV2FLp9wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103

On Wed, Sep 09, 2026 at 09:51:16AM +0300, Ido Schimmel wrote:
> On Tue, Sep 08, 2026 at 09:12:46PM +0000, Kuniyuki Iwashima wrote:
> > diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
> > index 0f46ef313590..5ec57d95d7f6 100644
> > --- a/Documentation/netlink/specs/rt-neigh.yaml
> > +++ b/Documentation/netlink/specs/rt-neigh.yaml
> > @@ -341,6 +341,8 @@ attribute-sets:
> >        -
> >          name: interval-probe-time-ms
> >          type: u64
> > +        min: 1
> > +        max: 86400000
> 
> This differs from what I suggested [1] and fails validation:
> 
> $ tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/rt-neigh.yaml \
> 	--schema Documentation/netlink/netlink-raw.yaml --validate
> [...]
> jsonschema.exceptions.ValidationError: Additional properties are not allowed ('max', 'min' were unexpected)
> [...]
> On instance['attribute-sets'][2]['attributes'][18]:
>     {'name': 'interval-probe-time-ms',
>      'type': 'u64',
>      'min': 1,
>      'max': 86400000}
> 
> Works fine with this diff [2]:
> 
> $ tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/rt-neigh.yaml \
> 	--schema Documentation/netlink/netlink-raw.yaml --validate
> $ echo $?
> 0

BTW, patch LGTM otherwise, so you can add my tag to v3. Thanks!
