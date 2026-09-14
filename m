Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBFA499F14
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407821; cv=fail; b=Q5YLDV6e/aZUaD9E10G19L8uF6plH+eGsGNYnMvur5C9Bu68PjVCqeH+p4OEkXJkarHRp18fPONU6LHjnpJ4pFVmGc9ujsBgv4Hic+FZzrDWPkGMlqm/TpfXqry4AS3pewmCIAb1Xo8snwvIs0uccPh68g7kipDEfCWtsGLMXYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407821; c=relaxed/simple;
	bh=MiegC8vIL87bpAsJlKWrwcvaIQJcxIbmvdg19K46TyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q29l8/TpEv0kiByVJXCiZ9rG7pTqRApIaKBVNJ/qsAkJp1zjxr8mw3QomMFjsyLE81BsBI8T8Zf0b72TQtAYRXIiQejkIXtyLeffSqOUsenZEmPeXgOrZO8ncNm0h1j8tinTqxlFhe6L/qQq6OcUSm2k5TRihxQ2Ss2E+oWW3no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rJLM0FTB; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rJLM0FTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voBGiksI0j5jjJ5r7tdzooHjTSlj5NpwPbmcDPlh9AGnTenCKgaVJtyogt/1F4niKxkxR+IBlXMmPuFceX2R4ZcY5E3yRW7xHZGhg1R8kjk5vP/HuavFeIqjdPSpqP2IxnS3Yvt7Z1PTUKJAYvjbYAhVS3jvFUCwGXzH6lxLhpwbkFyjVV5hUQW8gk6sSzLaYYmev7W0zyBQdjz/NWrhQOjYdz5Bcyn71zBArbfgQXe9G1hragI1cyMei+BWhdARxfZB/s0PgUtHoDZU1de4RS6QKwat23GYnBAg6hNt3NnJrJNyeYg1zMWykhU0cVj9+MzV83dXsYb/gQDS5Or/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VWgNV7QHxr0I+9/Uo2A0wVJLg6g0ZPQ26Vcgt7Ccuw=;
 b=FTUHUGE3otzODcfyyzQWB2cfyJ790in6db36r3lCXWrwJlFAFEqOz6H4WID+KCr5nKL2wNI54B/e8CBs0Ug3EFWypxxDGPTXEMTjC42hXktbzMRxQJ5s4irkEY3TuYiVDEICbPKidSb09EqCy2yo/F9+gm8eXclCSBC0jyUV49PwXBbwckq6IfqAb7Bk/+og/Cd+7765VzCZb6ty143Wvt+iV+3CXuikI72BWugh4TcssZZUYTnNpRaZw4F3RjdCfXoFY87mdYkJyIyi7cW32o/MZDHDh/U0HAm5b6h3NiBWoXCB2qK+ntI1yk8Rqr11l1RofMQeDzjiUDBapnrOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VWgNV7QHxr0I+9/Uo2A0wVJLg6g0ZPQ26Vcgt7Ccuw=;
 b=rJLM0FTBRI9I6FFeNvOGEC0uKY6SZ2ABlQ2sjAylcYzFBTUJPMpa7cPvCn8z4pttpIcSeJKCk0Da+VF3vPUl5bXZ9UldQZA3HG5FEkrdm12hK6JrJ3f+jT671y7SRl0tClMne7iOb7kcfxBqXlfkUzr1kFN1k57nF/LXQEtSpN90Pfj81VAlsm5yxNl8/YmfRWTXZfb0FRBRs/KghdemGiCjZY4M0WHsKHArm4q05Z/js2TMYB+kwNNCDrQ99VFrcMFGKFg1vv7uqxCwnvTSOq+Q6zjXnmcy+IgG021FPQocuoOtAZukLBSacSVH7rx/Rr2EliL5wnG9i/0gfW7u6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 17:43:19 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 17:43:19 +0000
Date: Mon, 14 Sep 2026 20:43:07 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Quentin Armitage <quentin@armitage.org.uk>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED not
 set
Message-ID: <20260914174307.GA450786@shredder>
References: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
 <20260914102108.788e700f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914102108.788e700f@kernel.org>
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c1adfe-8a85-494e-cb9e-08df1287a991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Y44VTVFLKMiH+2K+ZPwUseMoOvErt/OVjWLXZ8bBxdO4A2rCqCpzfLNQWPXnkCaY03BpFZP7g+r5OGpPD0jJ2nttcImNv2WDa775ZMra0cyxX3xcgNv5Z9nLLFwGVEcyUp+HkEfR+WQfCiUOh1N471G3gN6yFV1blzccU9p8aCOe690etY63PerGJr/zr1sVS/mtiXFx5nW5BdyJR21b+IsZPbmbM048gOoGY2c7Yx+JGxRWYGUh8uTNYjBFcrggs9Cp0mLXAm0vVd0TlBP6buBvyamkKVsGxJJZBC2FIlYT8MBz1zbfDd1rJ9sFH6ylHf0daR02KjBe2CBifpNRFhzb+UW7eIjzvwB5PDV+3PQPUYhCX4cpfTOaG9ZgTD7v+oG2XqV1JFtGDQ3VXaHJ4erL9/LbFg3PekFgnHLkfGB4tqio927Zop3QCgQ6EN/3LgyF8lhYTAPO/ZUxUba/lsbghXh4tnxJAEiSySIyhEWOBszNT2h7RwhI3OcoFjyrWURFyByd8FXouGwchW3MYtmvN/F1rlYtCscKWXsD6E6GciQtbYAssFxP7PDPRBlwExgzMAuThie9sAUhl5RII+mInPJecbjAnmj70eYvaTWVfl8eIvt8ywhtlN7p03OrVWGVhQimx7J9aUUbwjzPkeXIBSI4R5EqJaIFrNQfGEU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1oRlSA1PtpPhdITrS5rDi+Hv+86MntRPBYEclQIE/GYhkJRFB/T5QjHScq0v?=
 =?us-ascii?Q?nfZGDaEoSRbbbUAU2dZTjDFHoFcyCybWApJ8QVYcnXF4oJ/N38bAEkl+Uuv+?=
 =?us-ascii?Q?M13mn4pb9blWC3qgHg8nHaAN2U1ddpstqR3aQVbyVIsbqLwsPn8hZTZxgOGf?=
 =?us-ascii?Q?P5XY8lK03FD0Itrlr4h9lqaQyy/vAtRAvitCFKd5OEzvdhThBObHIGIsDPXD?=
 =?us-ascii?Q?tkM4TsrlejgC0LcpFeNIRdthSQoJndrwdy+90Arfd8Xw/IcgH82S2UG1eWs7?=
 =?us-ascii?Q?bOJ6OY2DomhX2UC7MgVYMRPsL0eQ6oo4HtaSN7z/fdwXdzM3VqfIW8FmYhCo?=
 =?us-ascii?Q?g3tpJeoTc3DLbWEcdYZkIaieeHM1vbXdMaFJkea+lB2abvYsI5WfKLGzyPbb?=
 =?us-ascii?Q?6JGk38pShabPresDyvbEGBv7JoxPzHP3h/cjR+oX/WuVcVBNIC19tqKpANoD?=
 =?us-ascii?Q?OuzCkEl2RfQqKCLzwJ2lGkuwoQsRTjpbZBCCKjgqri8csq/tRjpggTcv/XH5?=
 =?us-ascii?Q?ikReuuGNLFqOChsVBv8qEMdbPLT1QfyEa12AW7/8PgyEuk0xRM9g8cjqSTaY?=
 =?us-ascii?Q?wUqgMQCuZcO/0ovZIeaioHVJK2jzlBFLkFPDBreg9xgM+gVgV+yGHU4liLv3?=
 =?us-ascii?Q?AFHt8f1K5adwHTp+SUiA4OTtasNz+BKNRq4EsE8Ba+w+CzjWSj+5WwlQjkTU?=
 =?us-ascii?Q?RA9OhLFNWaKCXhLvyma4349XkUyMXLUsDnWGIgrbiILc1Nk2hXdvsZT9kydo?=
 =?us-ascii?Q?uWuVqzS2Z5FUgtHw3UpaXiQt8GAnPM0k+wxvrS615PPgwohW9Q706A6vcS3C?=
 =?us-ascii?Q?OOa15ZMZIylTIrHL9tZt4sbxG6ZYrFkQvxB7CFC3R0M2uu50qAHqifsyZN7U?=
 =?us-ascii?Q?wOc6crtKC2h9UuX0zfEhQ8xgPGEaCzR20Z63mq6QdCav4tukP91yWkTrgjbX?=
 =?us-ascii?Q?pCFvcYCkxhD4uvZiRHd8rijtEjvWCrspTYphFsBxzIv5/o0rcvKm+exDddBJ?=
 =?us-ascii?Q?oBwcDayYrJ0vLRli0nOYu9zs3Z/UdCPdsblFN73ev/3U7ZgpTnKysOjV6BzB?=
 =?us-ascii?Q?QKELX4bNGm1qqnyFHKVBLOLCz5guPGocrzT+9xuDM6n8plwRozT7Rb6hCUEd?=
 =?us-ascii?Q?uX5k+Pe4x1d1SedPBdvv4pJ7dt6mv+8wuPgRUp6AeZRpEbWLqPvstgXvkv0U?=
 =?us-ascii?Q?WEHJjT1hYLXFYc86h7CUjoRbThSLBOe6ALZXyehwW5qa1FGEhk9soHZVEyV/?=
 =?us-ascii?Q?rk9ykG8jTo0Q7TjDqtzTHUehgOr22o062zNhtTA5pJAasD1v/+Ei6+61OoxT?=
 =?us-ascii?Q?tvc2vCo9InzQ2fWaNEUkM/vx3swX7Yxc9xej5nQuOicLW4StbwqOmIJhhgLa?=
 =?us-ascii?Q?AbEBND9UE0ccJhx1/L6CAQQv7GSSYkeeY477AaWs+yNTvAX867HzUjJ2QQyp?=
 =?us-ascii?Q?fmBjQVlYglml+K8+3psm4B6z0vP8s0hBQuitdS+bvcjDtYlLYlFuXR6S9XTw?=
 =?us-ascii?Q?48F3jrx7XVS05cLOgBqOZ4Z/oEuIKIxCxI7DfkV+PMFxmzxyEAfFj2t8TtTS?=
 =?us-ascii?Q?l+pzRZ/pTrEgWcguz75JaxMyfjk2eVfyZM3XL/RfTBv5DprQHB62gwZDHT1b?=
 =?us-ascii?Q?1inGQ1Ki1nlmEgiGiyvNA/D2nz+VMDjbPtfPI8P8oxzJS+T2V5zhuiNXLAfR?=
 =?us-ascii?Q?xMcmqy3P/M+uowE7m16kQM6/0d9PDmn7vmXdqxHF7yHpTfQrytIvWin14S3P?=
 =?us-ascii?Q?OEml5BKUqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c1adfe-8a85-494e-cb9e-08df1287a991
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:43:19.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPWk4mCbRy7cscApXM433JT0eFKueNh3YpRgaI0PE6UdGBtVDHjeipO3uYWACABUaTnIixO+3J4qmfP1QsLa8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

On Mon, Sep 14, 2026 at 10:21:08AM -0700, Jakub Kicinski wrote:
> On Mon, 14 Sep 2026 15:21:59 +0100 Quentin Armitage wrote:
> > Commit fa8fca88714c - "ipv4: validate IPV4_DEVCONF attributes properly" changed
> > inet_validate_link_af() to call nla_parse_nested() rather than
> > nla_for_each_nested() for IFLA_INET_CONF. A side effect of this change is that
> > the code now checks that NLA_F_NESTED is set for IFLA_INET_CONF, and rejects the
> > message if it is not, whereas previously there was no check for NLA_F_NESTED
> > being set.
> > 
> > The consequence of this is that code which worked prior to Linux 7.1, albeit
> > erroneously not setting NLA_F_NESTED now fails.
> > 
> > In order to maintain backward compatibility, rather than calling
> > nla_parse_nested(), nla_parse_nested_deprecated() should be called, as it is
> > earlier in the function.
> 
> Please explain how you discovered the problem.
> Is there some open source or closed source SW you're aware of which
> breaks?

FWIW, I sent a patch to keepalived in the past and I remember Quentin
from there. It seems to be affected:

https://github.com/acassen/keepalived/blob/6d6194307e11a3d55870633fe00a50b56db7e3b8/keepalived/vrrp/vrrp_if_config.c#L172
https://github.com/acassen/keepalived/blob/6d6194307e11a3d55870633fe00a50b56db7e3b8/keepalived/vrrp/vrrp_if_config.c#L210
