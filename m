Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E703B3C12;
	Sun,  4 Oct 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791130561; cv=fail; b=kJ25X3ZgmBZlQmmncI6lhN356D1YLJSph9DuW6JifR/gc4IQMy1BU46k5K3+Mf2VjvyTAOz1ZMS+fBdPNRbAErxQXrWfCrtVbu8lJ1WGWqOB6M5e4iYKSgXlqhpixvDMs3zc8UYpJfOCfkIHT9k7lBXnV+YTq0DbKFhJrHWLQlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791130561; c=relaxed/simple;
	bh=d5F0Nt8tpWwusGk9V4VsI8IlZQMrXcmb9fxyf9F12Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mDvDnMZEtLQbky8CA+RINOyS9NlaV+9vZrh3lvH2004EV0hD8pXE69DcsWnSZmYcoPEknyhVFVNMWmEFB4I1RjTpbjIWYDtC2JKFIqcIr9U+lk64jRB9oCHC4BaZkd9SZeYc0x9baq1NTu94V/GjkRTF8dMxLW0pX0oYDsFzsEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J2iqWt0K; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J2iqWt0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjbYK5C5UszU4leU/FNeLh6f/hljappIhsrb6ptgiajpZIgkyICC6NOW6DK6Bwh6cf4eVLLirp7Jq0iEBSl+itgoFCqI6jQdYicPwTLu3NVZ6ho8MuMOvM0IvO9P9XlJZqeYPk1tUv4Of+/qXMgag0/rHzZZs3f1z5ha17OCoClNO/X0ShVIowVqANBlipN5/ZSi9/fiy6YKQKiDCc0GDBtiRGljFA1ls1B5UoiFRl5ymUo8rcaQPL+DHRQssc9w/nns9EBH4y9mF/7UVgBQTC7rLpItG5ghhtIKX51b6Ku7C03y/I3sQtCcPyUXPt4Jh307aNRjmBT1A1jkDbJoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gVSg4aqOp4lE2vtRjqzMEbmMBLDU5KwcNzKG8FzM5g=;
 b=KMEJ1opSDVoYog4Uta3Dbtrz7watdLB9q1kAnxQEUUJsT8kmgSSPWW/+9CnZGxt92bFXm6l/tHl4wx5zfuhLw2oZ7/2T8tMuYtKwWsOPO1PlAbH5C2lxOzaBENapetIdzRpS3ESTsfol/XzaxcgilXImQHclRsNNCb5eEx3iIiFufEJvCP0mrGosaNR0qcc/v10k0TBURyuCVtdfV5oJtJm+7UyCuWp56GzwfrfPKghO2KIV6PhvDtu1qIv46POE21JQALptiHRkYFZBnjLlJ8zZduGOR9DjBvG7XeDcQ6aOIjfw4tipudzkMoajuWYuWuzNHb90t5zY724Qzx1jgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gVSg4aqOp4lE2vtRjqzMEbmMBLDU5KwcNzKG8FzM5g=;
 b=J2iqWt0K2xH7AT7YCuep8XSzaxNeW/RLsxc0NUp0A9u0OjNCZMNWpru4Gv3+LChIlxVOJZFWqOLwSRV9CpNFkgQ+FLi+sZKEqXy72mROuOE4pX/6+0tOljJolSHcH9Opj+XxhSZ81BzjK2qUKNIJ9DgHg7hBaW86IvKgbBMBr9bM+kzNAECiWyBS71QIXC/SbBlxVhm/TQ9+9VEBtaOuH7eLdCE7mu1DvnP0mDqwtaeKkE2FN6+rNrZcU6XskpmcEZQPSEuATF3u2yrwyBvD1l6hfaShh58xZrbQsOAzqymZP6ztSR5/xgV53mEj7fF5IUDvVnt5JJ+0u8kZeso3yQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CH3PR12MB297944.namprd12.prod.outlook.com (2603:10b6:610:367::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 16:15:56 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0451.026; Sun, 4 Oct 2026
 16:15:56 +0000
Date: Sun, 4 Oct 2026 19:15:46 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/14] ip_tunnel: add drop reasons to the
 transmit path
Message-ID: <20261004161546.GA346537@shredder>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
 <20260930183910.3151873-10-littlesmilingcloud@gmail.com>
 <20261004160820.GB334650@shredder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004160820.GB334650@shredder>
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CH3PR12MB297944:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cfc99d-b1e3-4f31-6871-08df2232c559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7RvIaJQvzxGuQD4tNwsVPMd2VpVixy8O2nXJPDdPINcqSh+TdS9oEvGA9/1ex7gL5hg4ORj/JBBEOQNozWmpGM4+VdUds6dGcyInCYtUhnyAJ/b5VuIzm/oH4RonEQ+K2sU0FMu8GRALMntu7Gxq7V7R3hWsT2BJeczlBD07/x3xLfMYIc+4thGrTwkayOekHXVVZNLnyKANDIZrfbwQJViqjQ4APu8SN4NW7ZQSMZPGzO1ipusDdKgszMF6L+BVHr7FqdThyTO/ZU2ztPft9nvYKtZEXtehF5PCg8lVW/tuf7Trh2xL983WFHtIPNqtwHd0FYkscH2J9u635eIMK15EKpBAUYiprDJw7mQ3sHjxiERaV2crRrvG42t1ZKJDFpe30BeuTPrINWiY+cJiSlbSDIhrOqs1KS6L4/nn0rY6qaDHEzflTzu1qHsm45n/BpswzjtFwhHJZjgcMiaFnwGLQzcrnK69qvDITkpck5OQAJWXQX67Ec5fKJbwav86bDB1s+lt8SxLzLID4YKbI8j4E5lN89HCZ3ZAqTkftY3a5vu2LkZ3AzriF1+mvUOssqOINRTU6SkzEnU3wNJbc+PvqYBWJSonBN7nqn6lTSY62v3i0z2UicTH1rJLsR9GPXRkNbT8Idf6/eakSyf95XBFNgbjl/a97ut7TV9LY5E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MPiXC1ha8tVOPiRotmcKuwnOH4H05gUFoIcKSJRSwjpHt3dOQWumizFJmvYi?=
 =?us-ascii?Q?q7tPhP+4npKueYmtNRXNh5caLKAFoB9Afouig8uCnixizDasnGfMHS53d7Sx?=
 =?us-ascii?Q?ARR51p75Hul1uGEbkyM8aDZ0BcA0o4EXmyUlvdlU3ng3PUUQArWCBVUceTEd?=
 =?us-ascii?Q?uei2B0vPGUFKLMmSgPCAs3HRu0iuWMZt1LM/2h8MP4EEfE1e1sZwMS/229To?=
 =?us-ascii?Q?WeO7k4m9rHcv+0bClSPviL051F3GfKFjDyX/bv5gZvF55l6LcSI1yI7TsRxl?=
 =?us-ascii?Q?l+OwLnHCg5MBpxcJ6wpiuIlIEe36/i6wY3JsQj1FZFYZNMAfFsteOv4bwCuB?=
 =?us-ascii?Q?SbtdTdXBlUASBRUSENZ+iDyI4hr10Gx3Hn4DNwbOMvrmLnKqWENsLv/+s70u?=
 =?us-ascii?Q?QD8TACvelMWpEwRI+2X/Zf7IY4rG2v6Zw2hVKB2iYO3PS8WNyp94kBzkF00l?=
 =?us-ascii?Q?tg2O5AoJSWYQl5qH5Bx/TuBO1szOkYA5xA4JjZdtTsgJ8iBKLUWofcw3KA/C?=
 =?us-ascii?Q?ZkbLnH0CRMug2RtpF3Hxel6PFpq8hbP1gPhs8Qs0C9elvib1IzSnbh3Fiibs?=
 =?us-ascii?Q?mJ4dg0myscpxLpasZW/LIqbOrlyX9PdiO2pIPECYW/ARRwzY7x/YEdjJMGcI?=
 =?us-ascii?Q?d4wy07YFfy0P7uTSdrK8jlKbfEstnxIG9qyPGvROELmPRPS21Eour6l4hDxh?=
 =?us-ascii?Q?nJQH3SsGTnpKayK2EJaWxMAx541Wg8NtOjvekfA3BN3vzXv6SsvsB/jZHbTy?=
 =?us-ascii?Q?ueoBASbLfVDPreQoaOniWEhyniasiwYhQl8w/JYpidi/xden5LsdlyjQJLEu?=
 =?us-ascii?Q?Sr6MhiHA4v57r0Eimhrevm4dJ6Gr9CuDy6lleup0W27wVsyTGevw50DWuQzw?=
 =?us-ascii?Q?A3XXBzxG3OBr4Mz4nWQNiW1n0/lAWVkskPTLVZ4CR+qWnIlZnlG98H+Vlkc7?=
 =?us-ascii?Q?FdjvehJPNatRhIfxv1fpqfh7DjpNZNmhd++YZsil29fQ1y8SRFGFWRRER/+d?=
 =?us-ascii?Q?WDktAL8RIMofCT/B/8B12fl6tRs7H2D6ULj5ROff0n3nJ7w/8AwLimEAjkJj?=
 =?us-ascii?Q?EM6RbUbU7PBEmdkez1Pst4P5bSLw+rXe8zpr+2wjlSDTu2NnmYObxi6t2u5g?=
 =?us-ascii?Q?iQlq+WeUnVCPmLxpswMJw4D8eWazWAPuA5REor+CDjxbkOhSaJpjaC5o9k46?=
 =?us-ascii?Q?PWejRLpPQTQsshy/5TqB61OEwE+RGu3XjBnrrBEkyb3hQWhRMq/nJspj1JxX?=
 =?us-ascii?Q?31PgLRXUR1YUlDjQ99ElGJFvRbb2DijhUDQHl/lPBNHNz43W6qxvrJyuBvO/?=
 =?us-ascii?Q?sNl4r7UaKNSBJ8+wTCCmAAeOZXePJBW5rtPt8YNt5o6ZubmJTBJQ03+6Gqvt?=
 =?us-ascii?Q?FBpnOix4ztQxXRWK+3SeJIU9etsjz8DcW0YZBWj0BBJxb1gA3yfDMRrJks1Y?=
 =?us-ascii?Q?CviS8TLLHFPiPEg4uhMBDo2X93iVV1VFl1qKlLSMKe8+W+34X5bk/10e2TQR?=
 =?us-ascii?Q?1FPwLJeweg08GhJgD2C0y2mJQKmXLGV+KQLojD3WZhS17QF1n2VrwbcH9zZS?=
 =?us-ascii?Q?aEItEErMCgnImAkE7OzI8YzxrxhDloum/4U/bcU9+cp7Z1vrj/xNaBsutKj2?=
 =?us-ascii?Q?+a4FjMytd/6d5reMVwm+xAE3ydpKoiOLGaVHlUpOrDaTaXaImBwJKTLjHOYq?=
 =?us-ascii?Q?o3peGSPmjzk29UbP1FouoUVg/JDSlM/P5f2zRBR7gBbHcr/g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cfc99d-b1e3-4f31-6871-08df2232c559
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:15:56.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84UD/Ge3fmhVJr+2VbeZyR2ylTGtJDbgIuFNl8ixRcFxb87VM4dhCFmTHLnc6sASJzbyjhm9aPuVsH3lWHDFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB297944

On Sun, Oct 04, 2026 at 07:08:20PM +0300, Ido Schimmel wrote:
> On Wed, Sep 30, 2026 at 09:39:05PM +0300, Anton Danilov wrote:
> > @@ -636,6 +641,12 @@ enum skb_drop_reason {
> >  	SKB_DROP_REASON_TUNNEL_OLD_SEQ,
> >  	/** @SKB_DROP_REASON_GRE_CSUM: GRE checksum error */
> >  	SKB_DROP_REASON_GRE_CSUM,
> > +	/**
> > +	 * @SKB_DROP_REASON_TUNNEL_ENCAP: failed to build the encapsulation
> > +	 * header of a tunnel, e.g. an unknown or unregistered encapsulation
> > +	 * type.
> > +	 */
> > +	SKB_DROP_REASON_TUNNEL_ENCAP,
> >  	/**
> >  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
> >  	 * shouldn't be used as a real 'reason' - only for tracing code gen
> 
> [...]
> 
> > @@ -620,8 +623,10 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
> >  	if (!tunnel_hlen)
> >  		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
> >  
> > -	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
> > +	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0) {
> > +		reason = SKB_DROP_REASON_TUNNEL_ENCAP;
> 
> This will also cover the -ENOMEM from the callbacks, where
> SKB_DROP_REASON_NOMEM is more appropriate. Better to change
> ip_tunnel_encap() to return the appropriate drop reason like you did
> with gre_parse_header().

And change ip6_tnl_encap() in a similar fashion.

> 
> >  		goto tx_error;
> > +	}
> >  
> >  	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
> >  	if (use_cache)
