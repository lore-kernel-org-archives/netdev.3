Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2641D626;
	Thu, 27 Aug 2026 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822291; cv=fail; b=VdBuHnl2lF2S80yfQ1cA468rstntjRtzBgCyGxYBzewcJc9Epl3P7i6JEMYHSu4OcZBt4Q9sNbQvP7dVEGi1209nvWUppT+UByLSKPO5GlHOOZLnamdWH7sEvq1hfNTlkrt6h8qAQUKsH/pqdZEqfEaPwisj9LPMpqWk24ahXZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822291; c=relaxed/simple;
	bh=8fpDwn9TvYpVJCN8+L7CZakNFwxFLac1oUv/vL2RNy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X+mFNz5ON5texiAwDB4cHOjtXaqZfDsnHQTWdm/h8s2Id4HnlERcw0usMUYSd4MpFn8JTzfsd2tMLZ0RAugfsDKyO8pYZrm+N67TJczgcYg4mgOr9RW2EiZbENSSqOTiDt77oZFhc0H2jNuseXJUDBFVNWliR53dHXtLRjFyzKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IrV8M+uQ; arc=fail smtp.client-ip=40.107.200.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IrV8M+uQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWVvAB4udkjOmZOoXLErhNxjOQbjXzlMFrPGTMjbkXPoxiCHrtsO2ncRCHMa4dJ4RyYiS5d1Ml2wxfilbjAt6usIAj2Rh4NNLeJBC8tad9PwjR78jhZUGPCqe5jScsNsNideer78zGwpFuBxhTyid7DKPuOd0PyiLAfJI4Nzm0dRK3kRDA9zqmf+JrDfbEW5Jq+niSG/a4I3iuQWjH5t92LPirkTEqWu1YYQ/Aekr7XBAkhLPyYPMCHAgGnSesdRnVm8ETY2SDaI5gcvaQbiQoUWLFmmj9OyQFWsMMHcMZANPyOMkv0Yvvqlkfxl1+zBzu0objSiR1KqovbQlyW0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Qn83rjPzDDaMM9z9dhwnkCgS1CHD6F9Gaz++cebeFA=;
 b=WuxkGa7r8WNR8IKEt1ncjqP8mbMsYrJNCCli0Q/kLkVgeXWMp0u8WUs/t4nAsagwbmzGyGOm7foTlvX0lEk+Obh2Tq1pREtn2Jm+u1brLmDVP9p08LzRaKsH0mnU9bf+hVkL+QrCkl9mhG58C7Ft1MsKdb5vAGMXhGVjC8m4UyAocTLT2pRElIfSuKk/XssyAXAjiP9nQgzMRe5x/d7StBPzGMbxep6xVxuRaCzabr+ZrfuSqsTscTN72BZiOwZWDZWr3c5OmGHtnxOHrFY7qq/UIhyeP+EVWY6y5CLJjgbAkKrjuplmCAXTEfq1B0QWtL73AhtU1XwT6K9vizBN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Qn83rjPzDDaMM9z9dhwnkCgS1CHD6F9Gaz++cebeFA=;
 b=IrV8M+uQrE9MN5YpMuRlq+nyamwVWZ4GmhloZMHbCxj7oK0O1ELxELAK6oe8gTjRBL/H+55PsEUx6KRi7wGNOD3Ipir+vMK8qETKseO9GszbhhE0D3U6vhLajawT0tAO1M2z9hq7v5of8Q3PnPJ+f8GPjU2gPNpou2avq5LCsdZ1DOJoE8GYRlj/hTTd4fnxuXg1M5FnUS2+pQFbxRz/SOoQG0ESFJXO7gueoqYiNOSPusOz656PXJKL/emOODIdaMGWZWeXlsbVne+KbQO7F076G4tG4CxXRAhuBu0lcL8hTaTpOKP8jjOf7pj/U5BMmWCGtr/JE6IXz7V1zTPJQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 09:17:54 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:17:53 +0000
Date: Thu, 27 Aug 2026 12:17:44 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
Subject: Re: [PATCH net v2] vxlan: mdb: Fix use-after-free in
 vxlan_mdb_remote_src_del()
Message-ID: <20260827091744.GA2039952@shredder>
References: <20260826173604.90158-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826173604.90158-1-baul.lee@xbow.com>
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c0af89-fca1-4174-c2e8-08df041c12ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	k3NWdkogfhIXNavV8iOCPXoX+GS/CvJZ9EfmCxgnngANrT/YG0R4VyVzRBkDWpp50nAxp15rkBUVcaJMv2eU17Zcq9FmoV5km8rA9qgp5Dc658UVy3XfYdMf7N+kVYNwXqLv9+THFKlMG5xvB4gwDUGO9r6dIMdOukYRru2mk9nKUNIa4RXfAmM9Wfr1HcEnYZijGNri5+Rrtkp7ckjGK64TY0GeKWCSsm70uj5vBYVF9R45YLyyNhCIAMn64OSxNXRE9rfZH2Bq1hM7vsLnYNtA+CEWbX9HvujWBgVs9u4PZvzUjzMGUXgZVKrCcLmkFHbHHYtq/OC7GllCNHRaHJ7LV3ChdfbTnlMsgfZfOmyGezd/udfDxCVWiNbdTlbsf11FDj19H3+FyKR8e9FQtDBO3cfJlDvUBR8l+LexWu/wdPRkoUTSHnomBCAP/kgaJLG68HKEWHSzctRQMfYyb3DECGEoUkdAARoJqySlUOEPFMSDQ40HsWvhaKgeZyOeMiRNCf8v3rVqnFFxpm4dfhh90emponFxE6gTKtkFc4rEaiH4fXBs26UnBMt5OKPKGtaGinTsYs6+BNVlN+0cw9UDq+mwH6yap4nJ7NGZ+8mFOAcuSCoycaYxT/uId+iWvK7ZoZHkI8lXHTXELLvQjXJr3LGNjAdbbHomP7Td8BQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mpNZniCnK+W9kb+v4NbUttCZCAzwQPdDT5FNoAUFi2CGd+n8BWMt6a0kPnkf?=
 =?us-ascii?Q?1vPUdwgcxoMVCPH/9OvUv6P1Kx7oL1C2+W6xrtTOUv3dU+y1VxKhuyFT3a49?=
 =?us-ascii?Q?CONfXeuf1yAoJ6lH3yJK02Z0dUlx3jLO7+9eM0QXIzmUuitzSnERsWvQCB+1?=
 =?us-ascii?Q?1q2mG90fMD4yWedpYDrq4cOrT25rRh2N29YoXuOkny2lBilCr61d8AGtyHil?=
 =?us-ascii?Q?iisRpjLumuj9mLBtWJ3vYM1csm3oN8SytxCb+nhI7J+t8LbhBL0nG/Q/6nYH?=
 =?us-ascii?Q?I9QX14NV7QfWYOPga4KsFbj15L0XhXWS2KUpswExYgNSeOLK3vOIU0QlrCTn?=
 =?us-ascii?Q?g8aXvhLEj3zQDCBNYwA9I1vksm6dS5jN896/wcf0sjjAhpM9XGDcdG2PZv1g?=
 =?us-ascii?Q?0P2BDlcYvreze+6of2Jj30Bq+6BnP6fVFeDcxbgpVqWSnekxc5wow3NxON6v?=
 =?us-ascii?Q?2hh6E+KNK+JEQq5TFt7f9yILrUEnfpTRd70RHwK9UJG1sfXb12iX2QLrKD+w?=
 =?us-ascii?Q?eLvyyBBPdzSfe4WAUrHBpltSZERGQm/pxwHuB0Vb4+cN8Rp613BRZj9DkgI2?=
 =?us-ascii?Q?8Vc6OVhcSFwr4AuHLWQfyJOkbK3nI3GZ/FTVOVlODm69CXoflgXNX7rHrETc?=
 =?us-ascii?Q?eXUkVi4vixgRbquBs3c2MJdG+0rO5UBMlVxeHEj3UDfCbLBaD/wVYP5vrZuv?=
 =?us-ascii?Q?cZO4Srm7c9+bClisSjORbm815Xx5CUE1kHuKTPZqtQ4JOZYtIrvxSCNwmcgS?=
 =?us-ascii?Q?iym7d+j6U/cp+8bciU2S3b9qMV1Z6n43bhlVvmwC9JQp3KBU7fYPWD2MLc4K?=
 =?us-ascii?Q?gUMHNrWLe8/jDf7QQvfoNeXmhu1TkqcZMBEUuxh3xmgs4XaXiLsxXfq+D9KI?=
 =?us-ascii?Q?4vi9auZu0Rpy83s0NwDXHIOo+A3OKqpq14ApcujI8ezXh1y5/tgTVpz02QRz?=
 =?us-ascii?Q?V0O/qQgtNn2G5F7QkiaYSJ+i1wzeXeMbCL8GbhFWqNWsRVDabvHaYb59V56R?=
 =?us-ascii?Q?0/LwGJYW/0N34yjgikxCv6BZgmEb+eKzAI1s4G/Pkr1yL+krkCAlTCCEyI6z?=
 =?us-ascii?Q?aY4r/k8OnA1ZPrGj/wSFYJ5+SHoWZSQ3Vp7jXFelEnpTOLPJzZowWp/LdjfA?=
 =?us-ascii?Q?kb2WmZX2LJwNopBlIwqZuVrY7sWu/ZZTr1PZDC2C0ckRRi1HF/pq9kYmFoL/?=
 =?us-ascii?Q?c8CSCGLlytbd7AtrfySTmnH9lKu3DUAQ+UQEk3lE/zlbeUkPnnc0zACjO3Yd?=
 =?us-ascii?Q?JaTKdCalhHkECFTGRRNHc4PhEL0TCr5IVa9ql/JW7nxqGVRPuV/yF39Bcs6l?=
 =?us-ascii?Q?1NS5rjFyw8PZ87w4xOhbKCRBdKDtGvu+flcf0mBkZ1NaTqLfXyGpk0AOq1Bd?=
 =?us-ascii?Q?zmZHgIgKe419TX/2oaEaJ4kGdAaCHCoUq+sO9IxaSHSVawu4IPTMICazAo94?=
 =?us-ascii?Q?gq+73oNVPnFOj4ptH4XDaQ2/WgTS2PynvFV8VZJjqokyPotWBjwkFmQzb4o2?=
 =?us-ascii?Q?7k56X5++fuHq+ge5dOEcdIEsXB9fLN7UhgSDSdRBTklCOLR2UjEMio7YnGtg?=
 =?us-ascii?Q?7B6/3+8aQvlyOB/a6rHbz6S5rOTXAdmmc0xSqfLtZk+syVDZ8B/EDfPCKTD5?=
 =?us-ascii?Q?1OEf5943eU8podc+p59ZyPRyrhi8MH8GbPqS/xiHMiKamS7P7MnHFFhmxc4Z?=
 =?us-ascii?Q?FFSTjTaG0w+wDXfMOgu7771v7iH9bkMHYBJezxBmN4ry/QXK35einek27Wc9?=
 =?us-ascii?Q?Cu0dq6Ve3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c0af89-fca1-4174-c2e8-08df041c12ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:17:53.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6N9tE578rIwyPbi5XPQA6qQEPOvgwu0OZJkglqvHSHB/5pneQwL2nbm/BKCFfC2kZ9WIhTYGfULyl2h+vF5nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

On Thu, Aug 27, 2026 at 02:36:04AM +0900, Baul Lee wrote:
> vxlan_mdb_is_valid_source(), which validates MDBE_ATTR_SOURCE and every
> MDBE_ATTR_SRC_LIST member, accepts the all-zeros address.
> 
> A source list is only accepted on a (*, G) entry, whose source is the
> all-zeros address, and for each member of the list an (S, G) entry is
> derived from it by substituting the source. Entries are keyed by a plain
> memcmp() of struct vxlan_mdb_entry_key, so if MDBE_ATTR_SOURCE is present
> and holds the all-zeros address and the source list holds it as well, the
> derived (S, G) key is byte-identical to the (*, G) key and resolves to the
> same entry. Omitting MDBE_ATTR_SOURCE is not equivalent, as the key is
> then left with a zero address family.
> 
> vxlan_mdb_remote_src_del() removes the forwarding entry of a source before
> freeing the source entry:
> 
> 	vxlan_mdb_remote_src_fwd_del(vxlan, group, remote, &ent->addr);
> 	vxlan_mdb_remote_src_entry_del(ent);
> 
> With the keys aliased, the first call deletes the remote of the entry that
> owns 'ent' instead of a separate (S, G) entry, and frees 'ent'. The second
> call then runs on the freed entry, and its hlist_del() reads ->pprev and
> ->next out of it and writes through them.
> 
> Adding the (*, G) entry with NLM_F_REPLACE and no source list marks the
> all-zeros source for deletion and reaches this from the sweep at the end
> of vxlan_mdb_remote_srcs_replace().

[...]

> The MDB operations are netns-scoped, so an unprivileged user can perform
> them in a new user and network namespace.
> 
> Reject the all-zeros address in vxlan_mdb_is_valid_source(), which covers
> both call sites. A (*, G) entry is expressed by omitting the source, so
> nothing legitimate is refused.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
