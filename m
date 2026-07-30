Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F95332EBB
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399014; cv=fail; b=LeiqnNG8N3ZSG44cKWavshVnKKPrlLYTB1/Xw5PgZ7ehAamiwBoiTpUq1KfHpFcYJvOzbgRQ1B2J+gHu9iT6hwa2pXUOInDOwyZkB7jaGMGrTRcpnc7d8GRWU+AsdYRu/eisM1jnlOS/67f8e7UNoXaONilrv7YEgCnAknspkdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399014; c=relaxed/simple;
	bh=mczKyiKyKKF7YKj8Mt7k3wBkWfgX7WGrla3pXdexMI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EyXR4Y/+rh2TOuwmPM/I/PX5SghK8ten1OF7ndcrXXD6fift0XJpSphqw0zmU4jnFfokV8M/MnXRUduGYlajPzeNxj0CrpL2Dw7XFfmsWAJ2bKmbXCXmnOymo7xR7yV9xoWHz7SP2lZ87RL42WhqnqM2xmAAt8Im8kLfvvMoR9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QdIM4XKD; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QdIM4XKD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDNyN7Mn4csWYF7XpuzgyObNmMVMPEbDAPj4kt34UG1hqEWpplZ7uk6MDn6gceD+rKjM+w+w5oRz2mOc52EFH5U38Jf8WM/HNkx+l4C7S0LWJwpF5NEcpT6g09Jll7Nde9Xh631gMr6tycIllDkFKR/Qe0Yw4Sh5ULjrmDJ1gc8nbk/L5t5d8eu5YIAwDHEGQSsguGeTrLOm0DLv5BfoxUSwDUPamxbbwxVUE843cqJDMUcsp2EFiWS4tuUI0xBzj4//nqK5/9T+TlNRti7bcuhJeIlxVIKFgSqTWL8AWJKojO9eL++RzMfNbu1P1e1nmY/iZ7XtLP/d13tA60gN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwu0iyEIEoiXkTBfvhDNaRAuuX/zJtTjllB9m0pe+I8=;
 b=BluF04e79Wsy10NtcMzZCPXa7739dCskFc9G+2REIkCgdkFVNtXZ02LUtAeRDyXeV8zUPxRvYqiEjTS2X97jrB60W7MfsSeELQUykYLy+jOT2Ea4jb/W02LtUfOKulXxAIVZjQRgarAD5ex9OKO/TySv075pipPTbXX4Yq36FvBx4PBzg+e+szryd//9bgqpV68kOnfxXCXurTgNXdej8e9GrSaSzrse20OP3nCeQxVI/uMNTg2iqlE1N522GDcDxwSpyv+VjUcbTR1UbN4b+tXK2n+jw332ee2BZ8ERB4LuAGOmNWrTHDswxl8EcwGlUeqGZhSLs3a2SN5ewFQHdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwu0iyEIEoiXkTBfvhDNaRAuuX/zJtTjllB9m0pe+I8=;
 b=QdIM4XKDX8e/ABfTWYi9KBxKLtrKRYdhXhXUo3Q/VnuRzyglpJYWXlAIa4UbhqF9fdRB0mXQEk0o71fYQq3nTOwbOrBAkGbl3Kvvy9yUKfVU++qBr0W9ZM/5iGlcua1Qq9U6pPhwSC4OT2DYVW3RZwLe/8Qyn+EZ9RJnfKx2zVU/69ENHEcOBFuXWaOrB8gsSoQZlqE5LnhrueHq0K6BlQkaPt06uigjc2LdbM4K802Vx0xcHqPSKkNkgGvtwAq4FlcssaBmeebP7KRxxgSNwwTYG1ACcLC1ehpx4DbjU6Rz6pEXVUliqLj5vHmKDZDroqWiQZp8kFIilpsYmkQt0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 08:10:06 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 08:10:06 +0000
Date: Thu, 30 Jul 2026 11:09:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Ren Wei <enjou1224z@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	kuniyu@google.com, jlayton@kernel.org, runyu.xiao@seu.edu.cn,
	kees@kernel.org, michael.bommarito@gmail.com, gustavoars@kernel.org,
	willemb@google.com, lirongqing@baidu.com, vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: Re: [PATCH net 0/1] net: reject IP sends with excessive headroom
Message-ID: <20260730080957.GA1551985@shredder>
References: <cover.1785054561.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785054561.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 4beb0c25-3ef7-4194-0fa5-08deee11f747
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dsHx6SClXkAPaVqoXs/abYUkmg7IkW0bTWME+w3G4ouTiOfEbFhdKW7eqTgJe0Z8QGCOOYhDZfK+B+hdTeqjsEX9k3NSSRloXZBvkxlP4/OQSy44uHntKkjY4RV+AW5fbZkws8RYi8gxB6+r5aTmomh1PH8yJ7gN2mdsIes9VD/vVYh97hbEYvrH0V2mMyisrnJAaCjzDjKdOi03lS/8EOjHTbagutDn89NuNQQJ5dTGc+L+m7Eo5gXwrR5KTkkR23lTeO0EFXEcZCdZWUGSR54K3ZnT2oUmQX4iynooUrdqwBLFBtQLcm4GNBMTL2dzGsG+cmJw4EteACQzErf1dnuebWzSDAxmsbCNPj55FWXt/B+8yQXpT4WQb1M6AVyq4uzv208qZMNmbr16XJcZ43or+H52KDvku6piA6+jZEFtk65BdoIg+Itcx5LH/1ovpr0uUAoykW2lK6xiWZGQPFAKACiLVQeNo2xmezeiatDkwOaKRURI5sYEN2JPpmZkTUKWdyxOoO2twUcXoLf1LMUu36VOfch/XpWAd7uPRLd3aF+ZUOprgE/pqHnZuuxBdPgvV28xtdGG/XbPqh33T041mJI5L/gPbIZ/DmLIwvOp22i6dc8cd90HXwVC+GfLLkKLxAJBa64/0TrUzQKpe7evpiso8lJrILU4PFLMGr4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YlBchXS55ovmTW1FRR2KQBcxFiqFOortVRvfexMVz2dewll4CBU6XXdvPqt3?=
 =?us-ascii?Q?DCh4F5256AJO458I/MBp0OO6mc+YyzZ63IdIO9rCdS+H0f7mtcVLK4ekzPSr?=
 =?us-ascii?Q?0WtERYygbNx4vMWsNY7FcI47giLi3rRlKtygRygP9TkolgTc1/1u0pnsb+EN?=
 =?us-ascii?Q?/Ge0YUcsYpW8MSWadlxVXSxTZIxjYb20WidltfvYjaOI3mmtpzA1NbCqju8Q?=
 =?us-ascii?Q?f+hLjw7U7i5ohBbP2lScSii6wXQZNi8+C4gnEXV+Hp+3M2zkVGarCsKIM6C7?=
 =?us-ascii?Q?HahWdPCNUehFeLSbgPkRGOhp0GtL+lO0jwh0B8RgF3XcCIRpag6tnvS4Zn6E?=
 =?us-ascii?Q?Z+VF6NOCZlAhkWm/60r7gTXVzPurWNqh7QZPC8g11uGgYX8VnPNriLD6gNJP?=
 =?us-ascii?Q?usi0aPLzQGPaf+ftfo6Hd1m5qf39FBQtgEAzmZ9FAujYTnNDcWW9c6vmjBts?=
 =?us-ascii?Q?yWTnHWzyKSp8Jl9QNcpSgW83Oq1x1QX4A9I8aYnb7YZfld0/1JM6WFICj25T?=
 =?us-ascii?Q?o1cnLp9i8/vfkeEiyA0UBdIJhlgCSlNsFR8WfE4AGaxhV+Hqib6rIz3/PZNt?=
 =?us-ascii?Q?qJmWoLSd0LQYT5PK6TtV+c+VnxMg5DeJ1BsEC3Iy4dGamzszMkxeqyiiLUgz?=
 =?us-ascii?Q?tsUDa/p3Rw5bOd6g0CuswIJtm2mzncvRm95e+lU0WAxIylTJ3q/Fj+46EiEz?=
 =?us-ascii?Q?T3JTOJQ1YhLXoXBSYLN1zInZHvBqj3hnC+84FEH/FozICI2w8jjc9kanOK1j?=
 =?us-ascii?Q?oiT+CsYmWoUUfh4rgcipRAfQEBXpcHtaFy0ZtLWnOYVMQpAMr9ItsJ5uzqO3?=
 =?us-ascii?Q?z2GGzvWfVo/TxgY6ebck//m4p7iUiF/gUVW2DH7XHMzfV5kQf8Z5ZCVlim2Q?=
 =?us-ascii?Q?bhtkgMP7MH3vi3ncX39FgkZ6JAB9hr9tCHW13PtAp0UOAqXKDmmo7tPhzYjP?=
 =?us-ascii?Q?WZ7TLGpvJZV8HZXAUcrbpUHWZ4JelB7zQpk9T3zQbnB19rEgF52hZLPnirTO?=
 =?us-ascii?Q?A8Mqy7btqgopY0CTWp7mx4fSP+iv9QREg+ywNHuCVF5ZrbT3e40F42itgRDL?=
 =?us-ascii?Q?u/T0eAzfTV8ehu3rpwPJJIKNjUkLdx9sKdHlzmZUPS82+A1SSEjwb+qccSEg?=
 =?us-ascii?Q?GdN+7tPLAetQUuimotN3zywZ0ezB09dNQhTshTt3tHUViQ0F8L401cD0Xd9M?=
 =?us-ascii?Q?+gDgFgFt5ml70FDCKDXJf3/TfXcIIupLEUya4RWwd+kyRhuxYmQmuNBPcJEz?=
 =?us-ascii?Q?K3bMzCj+9BlbBP1S3/o0wWmv+ST627nyYsYmh2wz3U3S15kXTHFa37evuK+t?=
 =?us-ascii?Q?qIZPQ0UcPHsfb5PQR/QsJWKyGWuzmwpRIaXQGErJEpmuOw1vRkZGPsnWX9KS?=
 =?us-ascii?Q?+ypuU5gzJG0OwmQm2R5s+A6W8hGYSWcnIFdYBEnulwOr0epuoUpDvKKUORaC?=
 =?us-ascii?Q?PV+3H3uB/CtowBprRwzB32/MOzzXGHp9ZcXSxY4nnRP/6LSkkkPoZO7j2gk7?=
 =?us-ascii?Q?PegJCNFz+2Hra5BNzM67h1iaae026qwRV4U+jE4je6F0h9lad5nT9VxbAfno?=
 =?us-ascii?Q?D+d+PI1fhDxRSVkAJo5yyFEBZGJKm56qf07aHT9JSXi2P3VmDugQCRXhedDr?=
 =?us-ascii?Q?KEIDe01hO6ah3B5hZyEfAuX2h8hsjgMT/KrjdCD5xxpUCZPuzupJE1FD8ayN?=
 =?us-ascii?Q?OauA+vxZNxjxBoHmVoFo+8ynI9R3mP7YpP1HMePZUqF4eh0f2Ow4MG4njZqo?=
 =?us-ascii?Q?3HPdnsWFRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4beb0c25-3ef7-4194-0fa5-08deee11f747
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 08:10:06.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRO9+hKigK7Qnc0gPZpxTywOFCuBAnu70dZZ6+DwA6U+3w4NIMPKrqsD/L2HmErjSU50BFypzmzEibvBlKajVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764

On Tue, Jul 28, 2026 at 02:03:05AM +0800, Ren Wei wrote:
> From: Zhiling Zou <zhilinz@nebusec.ai>
> Bug details:
> 
> IPv4 and IPv6 output paths reserve LL_RESERVED_SPACE(dev) before recording skb
> network and transport header offsets. Those offsets are stored in 16-bit skb
> fields.
> 
> A namespace-local stack of tunnel devices can make hard_header_len plus
> needed_headroom exceed the range of those fields. In rawv6_send_hdrinc(), the
> wrapped skb->network_header makes ipv6_hdr(skb) point back into headroom
> instead of the packet area just reserved by skb_put(). The user-supplied IPv6
> packet is copied to that wrapped header pointer while the actual packet data
> remains stale. Later IPv6 output and error handling can operate on invalid
> headers and crash, as seen in __skb_flow_dissect().
> 
> The same root cause is present in the ordinary IPv4 and IPv6 append/cork
> paths, which reserve device headroom and then store network_header plus
> fragheaderlen in skb->transport_header. IPv4 raw HDRINCL also adds the
> user-provided ihl to skb->transport_header after parsing the header.
> 
> The fix rejects IPv4 and IPv6 sends before the affected header offsets are
> stored if the largest offset for that path cannot be encoded in the skb header
> fields.

Instead of sprinkling checks in the data path, why not make sure that
net devices don't advertise bogus needed_headroom / hard_header_len
values in the control path? Commit 5ae1e9922bbd ("net: ip_tunnel:
prevent perpetual headroom growth") chose a value of 512, so maybe we
can use that.

AFAICT, the bug can only happen when stacking IP tunnels or when
creating a netkit device with a bogus headroom using
IFLA_NETKIT_HEADROOM.
