Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37124253340
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636704; cv=fail; b=nbSX1oxnioygbwPmRGmZef6VVWMfsU4yf9tOBCccaCY69HpASoqpXWeQJdJtOsu6nrVh7kFFzke6HiL5cgBw8o47toGFMuTriSE6b1ipG4SNIX0rz3yvbSjLUeZvIt/Cbaw5/TqoTFnL8Cg3UlBrHOjkSQu29GZO90KlE06d3l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636704; c=relaxed/simple;
	bh=I3XcUTjoKfkQGheAKg2w7fRODGti1ETMy7tRgAVPIIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sKd4qkHNqrkl/jo0s1PnnOQeBtP3e9+SH9m0I7laQ+j0pJnjJ8DWIdOyllFtz+o9yae8Qv9cfaUwUpeTFZFWYySM8ItvWMUziWYKQ1RDbbdl8PdJEWhSDXoHOJ5Ii/LHZS11xM/KvTZ0YBD+k0z+WV9rUpR0wMeJGGUeusNDAH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PLwvFohK; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PLwvFohK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs08aFV8cdPj0AY52+2DGBgv1hUC320isQ0Hh3CbWqDCgumqauhTk7FZCUw26pa7QXF0B+iQsNKm5HCbFFA4SafH0GoLacxJAZTQtNbyoTi4BUl3SIzlIGW18WW5D7jpYwc0qbsHfoUKydjxUYCXgHAtPbB2QUkf3O72rThoj7V/zEu2fMm503/VG/35itgSePcuZAvV2/WC1E39gnr/LdVe/qm3zov6opxuFAmjEP8PBlFpiqtM/2SmQjarNCfUmzGE/qDa7sWBCCSflH6vvD6trZfNkv+hGlONHCWNGhrs0OzG0XQzAesQemBM4fK/EIUBPpDHV4uNpfiyB6bWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT8iATZFg91K18bHOlPElC5Ana44utLE1UVihFbXx0E=;
 b=MlC6UcdW2vwUrz7GqzuiUDWB+lofNl4QsDFdP1bFYZmsLu+Bn7T/6l/njf6O5v7x/vnXBYRig6jbfpaGXCAe5NEpp5ll/910RwgqnW67hOAJhJe5siyFluXVzyTuG5/LUm9uwp3YFiI0BIyIPh+tAcnXD8NjvWHVbwLBxG6RLk/GUR9f5ZVijVIAE+rUQpxKkcMKDmrZwNolfwrCR6cP+gIyym30DVVB0FgkZUwJjZK2xRGdcFbpH0Nwv//1U5FEDGR1FQTm9d2UBXrhbXBoruB6qrletmGoQRUs1XrzAhOeBOmw/KrTgxKfzOHUpYgBxITIvNGLX37Luv4TVsrU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BT8iATZFg91K18bHOlPElC5Ana44utLE1UVihFbXx0E=;
 b=PLwvFohKItjzaN0/YD8b557nvqYbhrCTmPGe6bO3Vr3AJj9A1bxNNqdlB2m4K/9ovwxau6FPHhwjRgx/czWz9WAoaxiHrlLiYQNYw0JfifmK6k5+O0wFZH8hvE+1w3S99vOGfaTSFwwDSqt0V5e1M3Ep1Y0dtay9MlFEUvdezejHB76KfgsfY2xfJyEuX5paW5LdFM4LmQ6/6vo7e5wskC9OTiE7qp/ZuMeHyHn+L0Nbywyub245NwRlfTUG0B+M+lwBJ04UrVnF9vznOYJn5tHJrGNhjp10uKjGKqAnSa+UR/VZy6C52V+HS4IvVrZWXYTi9hhOsVuTtTpgXD5Ggw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:24:58 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:24:58 +0000
Date: Tue, 21 Jul 2026 15:24:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	dsahern@kernel.org
Subject: Re: [PATCH 3/3 net-next] ipv6: add CAP_NET_ADMIN check for
 forwarding and force_forwarding sysctl
Message-ID: <20260721122430.GC2592863@shredder>
References: <20260716203713.17392-1-fmancera@suse.de>
 <20260716203713.17392-4-fmancera@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716203713.17392-4-fmancera@suse.de>
X-ClientProxiedBy: FR4P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::13) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cec7e9-aa8d-4c91-7463-08dee7231420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|21046099003|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	IIQDn9yJlACVRB7DLcBYanSrZcjQvzGKsU2PupivvnLhloR6rdAtgc+4kOJGnOfF1BSq8x0N03NwBJ+Qd3/JZYboPypyp1bqPXslIY+oN8BGxFeFZtbXMTx4zkeMmqF7/3PPE+YRHltRWEb9l1sj0uLrNBveYEKlIw3r4TxsbHLl6w7Bze+FAq4wloOBZcS9yuRkXAQNkUUbQMlg3f1avuNwY9KkF6/s2yxnict1fuML8O2YLFXp6dKfqqYy88IaMZRtZiOUSRuheMPVEQhyTpDCdNoiv0yvOhgOrOy/DzIznMCDVWSWA2FWJMZf5L9rFstlqNBlxLszg98a5mnpR+hXuAEuE/oAMS/e1Y2G5JU1QMVT6VdtAR5FF8+GkzJp7qS50Nn3lGAfwwCMQZ3iHgq38PsXjzMaoESMcNjDiOD/fUuajqcQv326qek59dlClKZpI9iNsrJk2Wu5pTYHrdTLb6I/Vi2o7mHQwWEjl6a5G38/6XgLn/8UIJzcDrx9mtA9XEgpuHCIjRBmLLMXbEW5RKUtHMkIwaI3EEly6rCAZMBBToa9hHlOxMOHbumgARs1eHkEvDRQxzCx41QK4LKXNImgHPKMTVTRInylwZW4Wi2Tky4ITwy/4JDvVk3MwMwtZg0xwPObcq/5lhdTfvnXYa8WmQI5lRQVeh4cXpM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(21046099003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yAiVtrbk0ResVs7Fkvnr6XDVkQ/PTU6uBFK/4vQLkvlR6+v22o3/b4cF6+X0?=
 =?us-ascii?Q?QfCihuceuNmOkpWE5qbWteyrNGQZRO7OkExWKikGfCOqz9ubxmz2XxfbckKO?=
 =?us-ascii?Q?y+7HIbqfbs2tjRbvSW6ilIWmjQZ1SSBQ4xuVVEcU+3tGWELCYgKI7DbcNKGf?=
 =?us-ascii?Q?spCU4Kg64NoT22iZC66+pjBnH2l5wol3A09hG53qx0Cdvrw3cB3+XfndFAQP?=
 =?us-ascii?Q?+KA9M5WZL3AugIgh3pO3CdtyUDBE/HxNJu/vjccDmjrDvaC6FBlCu/lGGieS?=
 =?us-ascii?Q?ITprBY4r8Vv2yCGS5BYc3b3r2g5tZY9Tabt8AY9IwaS2QIgB2S0I7xHs40G2?=
 =?us-ascii?Q?WMiO1rg4La6M28wAaYBmE62K7uyRNUZ9GWLK2eZOClhi2qLaB8r8VKuvSRck?=
 =?us-ascii?Q?1w1phSGAB/AulJWxyc/2QMB32WDRJejZg/8q+SXg9HJ+kLobLF4URhC0vSXi?=
 =?us-ascii?Q?gclclRZ4DX1eV8hOohTrdfF/fVWCIrVamJh5qKn1kGgPSp79H0SeWDHXz6Tk?=
 =?us-ascii?Q?MDsN3mzDKwvbK5EtCm5Dgr/mlrGLPN65KEos2PbR7GVUtMS9ZTAdpZvmgrRk?=
 =?us-ascii?Q?8xH91Ncw0G4fDCtP9uqOLv2V2TLaYERr87lV6EyKlwjOnPCXOWW+pRKIOZfy?=
 =?us-ascii?Q?KlOi8FAt41fTmUpderXCP86WZ1f4jOl2ZjcFkuzJGF1u2HtbPqLuM6Uw7QXf?=
 =?us-ascii?Q?6s1mET+FDgpi9z8vJKtf3F48gLRM30o8fbMOgIbTz3DbLQ+9ROquBk1/OWOU?=
 =?us-ascii?Q?7dRnoIVR0YGYw5ruaan02CUInj9qozfiIbYwFANkn8773gyrbeHpzma8evL1?=
 =?us-ascii?Q?jWgMKybDDGjphekDAMSzS4ZL5NJ8BRE2LS3ym199m4Az1XvcNphaUoNVh+AQ?=
 =?us-ascii?Q?G1rfNtFk85CET75JCb8FRC7R9iPlKBwnmvOvGjIfHlZMot1eu6I/6mbosGKl?=
 =?us-ascii?Q?thKIZZ9AcODvjafMNohDdmYgq+ZtmUh9wphu3lGbQvUkjg6gKzyOPYoz7NNA?=
 =?us-ascii?Q?W9BsLVYUvT5wUlXLrKeTTWPnIE+QAWqSPIR9cIBb3euuDlrAYJMG4cf3qQyD?=
 =?us-ascii?Q?4QN6kv9Doa5geWWMkb+Rm0jtyk5KZ2uyAP3/0qMFNsxESHsDrMJXCWO37gwD?=
 =?us-ascii?Q?SIMM68VZET1GWQdvu7eqqxtKV5frjg8qWV2mYreXZX5ww4LyO4ytqaIlQvXq?=
 =?us-ascii?Q?6bsDzuthU/k+mAQlbJA5K8nefeGw6TKhv3FzVWO4R7xrPawzUvGIYIduz3d+?=
 =?us-ascii?Q?Cq1Iv2IOP0dxfTs+BjDCdx3xmHc7vNTQn8IqLKjiLf+m5zVSHKLLfVfjFhU8?=
 =?us-ascii?Q?/t2KYojH4ln5rOOJT5aLBMTObMe7yWHz1yb0SgLkuFCDOTccvmp7NJvqcIzs?=
 =?us-ascii?Q?oYKKEXlF47qN4k2tJHCV6kVPF6e7SYPMK6AwQhWoW/GSz6zBC0QCrv5Ushhc?=
 =?us-ascii?Q?9JNcw0m7j5UB1KYYj/SdLT8cWzexNh7sUbxhowIcOAQ+rpByVUwJIRBtd9LK?=
 =?us-ascii?Q?ggw5pbqZDtktEva5eEXN6eP6rKB1/FHReBuxIRE68muFopvcGdH3ZthkS3Po?=
 =?us-ascii?Q?DfHO4rsbZAE8XpskInxq0zg2nSaYc7qZ8fPPoQ3GGLPxF89X9jrtRmJeGIjJ?=
 =?us-ascii?Q?JyKnPL8sBoLw180Ib3YSNyAnhVH5kmy1CuKlmHyaOenYWhUCAt11twTmA5Z1?=
 =?us-ascii?Q?AeRrwWTW5Ad708rJX41CSP+XfxwnOh5IsRUBUFzLwg5wkrt5C/oxFQbE2+N/?=
 =?us-ascii?Q?dWeaTEu5CQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cec7e9-aa8d-4c91-7463-08dee7231420
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:24:58.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lw5PghxHG7c1Q/Sj+vN2gfuCKGeK7Il2PiN+Clh9Ln91xOVvUObBKpmm4WQnvkon6f7uSdMQTy/MCj+0Op7aFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

On Thu, Jul 16, 2026 at 10:37:13PM +0200, Fernando Fernandez Mancera wrote:
> As commit 8292d7f6e871 ("net: ipv4: add capability check for net
> administration") did for IPv4, make sure that CAP_NET_ADMIN is required
> to modify IPv6 forwarding and force_forwarding sysctl. This keep the
> consistency of permission check logic between both protocols.

What's the value beyond protocol consistency given that it creates
intra-protocol inconsistency (none of the other IPv6 sysctl handlers
have this check)? 8292d7f6e871 does not explain why only forwarding was
changed. As-is, I don't see much value in this change. Tested using
[1].

Before:

uid=0(root) gid=0(root) groups=0(root)
v4 fwd: 1
v4 rp_filter: 0
v6 fwd: 0
v6 accept_ra: 0

After:

uid=0(root) gid=0(root) groups=0(root)
v4 fwd: 1
v4 rp_filter: 0
v6 fwd: 1
v6 accept_ra: 0

[1]
#!/bin/bash

id
capsh --drop=cap_net_admin -- -c '
	sysctl -wq net.ipv4.conf.all.forwarding=1 &> /dev/null
	echo "v4 fwd: $?"
	sysctl -wq net.ipv4.conf.all.rp_filter=2 &> /dev/null
	echo "v4 rp_filter: $?"
	sysctl -wq net.ipv6.conf.all.forwarding=1 &> /dev/null
	echo "v6 fwd: $?"
	sysctl -wq net.ipv6.conf.all.accept_ra=2 &> /dev/null
	echo "v6 accept_ra: $?"
'
