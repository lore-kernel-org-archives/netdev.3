Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8993FA5D4;
	Thu, 27 Aug 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821547; cv=fail; b=ZNMLHgGgdnJpczE/uHIvba7usA2nKSAfbjxhIjLBzb59912IPvgUfv195yQgV866NP5IX+QoR7wWfOhpiOx1HMRseNnHuqL0dndQNuOogVFrvVdZdI6s/VSBKjstw1Scm7ha10NMx9b1EFizagQxTZkucVodTgdPSCbrX9pOqpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821547; c=relaxed/simple;
	bh=w1Ls+fOmMbVNhGJUFmRyfm3mMbeeyZ0a7+KTnSiIORU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OGeOThU6x7W85nhlFESjr57U/nu8VgrKpAdIl6Ld6KieH2sv0/Ldte2AKqXu7fqIiDrDrtOrGVXYwYPH61XZ07XyQy6Vj7VPWhfzQKd/Ljjh+z1aede4qhJpCzodEUlmo4ZsiathMV2RvrqZDuDBPG9EicgE9TIB2nQc61JZsfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dtCsUdoT; arc=fail smtp.client-ip=40.93.196.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dtCsUdoT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK/SVmZgL08KcVkUQSl34E+g4ehfEG0I5WK+8RkCCXYmW/UYTPbGFemSWtK0VVlPiDiAext/IMYJc3wwrguKuhUKFK8CoeWQn6cR1L9xNC8qgahttnvM4DgXUCyJjiXI+UJt7GgN2RhDDp3PGccdyqBecb/NEQv+kwhdjvsXZ5/26I4/oBxgAEMSRpAKs0V3TtC+XqYPy/VKVb/HC+TKReR02WHtAWCZHMikHTs8mXwnf8lO/VusWBk7oTK9J7SubyK8Hw7pIskQMnNW9ZyRM/HC2WN6CjmjQwYtiZch7m8W/P2uiMz+T1WzCgtPfDWx8t5xqYe3P/NG03RjSn1kFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x49BluRE+DKMwsyx4GTxYWwJYuy9ssb22kTYWDPOEic=;
 b=qjGHWjswl7fVA94am+l+y/H6Cig/wYFZ4Xy1WqJ+Gsc+x/x/TgPtwdo10Z28YoSIUSt5zLFO0cTv0qmGso7gmoIgodUM34hFnVJyf3JJufVhVlJk996xvFPDOcggGHBkhRky+FEJhSNVcuvaTvzBf+Oiu8QH7d1MKa1j2vxjLU9D4B4f/AtF0w2Mo1XJybf3tNW1aVQ3lruj8lBas3CpchBt3TjXG5ZI2Bnt2pLBOR0lypNb+U9DMjzSTr8T/pIv/j+Ay9aEBAL97E2JyyjZ9L04IFvEP7xSVh4+/N3bljtp3uXmEtCFnBd9XOJUY2wEYZFFnEFJ7qtyVACgFFew6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x49BluRE+DKMwsyx4GTxYWwJYuy9ssb22kTYWDPOEic=;
 b=dtCsUdoTOBwMAk75LAJNnpPcpAPz4tl7N4jA9A+g5/viRO1Lo+mnjdH/S6NhIZAqIh1dvAfbxwnnkJvNtviWYbssxN28ZPaU2GDANHgXH/Z+tHCBVQpdq/TF+/zEPy3fYQkRsu4udB0Cn1OiVKKWdH9dHxJLTvHcrC5CMdjPqw9BfN913wE2Ps3jU0NTcWKTXZQJUeaFaCzdK0eBfzG6z/JB9/peSozOM+OsnAR3hyNQT6nxga5ByfIMOLkr9htPgzzjT1+kDirUbM1LPW23zp/daTtEKe5On/oNjuZ4AkpuRkdfpfHqL7RT/Hj137V84NjZiwvBAEyA7tkk8U2jwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 09:05:31 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 09:05:25 +0000
Date: Thu, 27 Aug 2026 12:05:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Lawrence Lee <lfqlee314@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Arun Ajith S <aajith@arista.com>,
	Roopa Prabhu <roopa@nvidia.com>, Jaehee Park <jhpark1013@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next] ipv6: update NUD_FAILED neighbors from NA messages
Message-ID: <20260827090516.GA2014023@shredder>
References: <20260813233344.445265-1-lfqlee314@gmail.com>
 <20260825115226.GA1338930@shredder>
 <DKY84BEFKL1S.1BZWGQTGRZLMU@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKY84BEFKL1S.1BZWGQTGRZLMU@gmail.com>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db0af26-2f69-40c5-94b8-08df041a5517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DL22dNAtZ912DTYgEPswXOyg94idl8m1Y3PCtd4Nvi+pDySr4/AbY7DmWfsdVm3QJpjHxMY4NhIRlMH1aHpRU45c1PiLSruSvL1xhQEruSjSBC2gB9hqZ+wnAPlGQfhIb9xM9iMTbvuG7TmJZygas74axX0ZFSewZrHLLf97JfsU7ggCy30wqKs2Y3T0AfWYgoJw3/Bf2cXBkkaDiFY09KOzvgBU1+fZeX+2iiW60P5zrmq2Carm4CTaa1F4xils4xMAVKY78sbu0hld0SKqfmsL7ZGMloGA0q3Fg+BvzLm9JeiuvHwvQRYsnNVTK/4sV75cflk2G9KTHZex5xPFQYorp6LedOOlPvRiKEcdPqlUkY55BFmMRVZr0Zt34GlxALOJjlqnVvYxg34Rf3fFmV05CJIZod4PFA8idO5YrH0y0aJ6bhlivDpLH3hrg85h5zLRKohu7vkfIWPY4KLWtyOc/L5f3gtoLZElzmbkUwYGh+kQ5TE0OIUSfE8sW0pkDLDGzEszldYx0zFk8vUKF/jvzRngfP3s+0wfhMs+aTyBfipiqR4/9BhjhZx3xfuouLeoVlOEWL2MjI/i3H7UVPaNA3qm/VwZzOzh6YPNxyHH1/f3V4BzxRRGH8EYTQeQegSm5sJq/ldrFP7WaLTyErwYqSmjDYHeSKHTwAKzLG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OzvEAo6eccA1wn+rucmmPjlIgYq2iZLQEQoTZW/dc3PH1d7+BNnJEABJfg1t?=
 =?us-ascii?Q?duo2QddlfgX2XrKtvRysb2XhB9hr8faXD7RNdbC9xVYOskBUJzqeyRdWyJZl?=
 =?us-ascii?Q?Jap3hRAmEhvoLV6wI7BvNJmEAgQoYm1eeh9OWoEM5wpQao/EKU8RX/lC+al/?=
 =?us-ascii?Q?JMP2AmPSXw2c60v7SJO3lqcBvrUd3lSwgRI4mLY4V0AALVQ9NPHoq9pJ9JUK?=
 =?us-ascii?Q?bOcjHuiUoaIgNUkO7Vsid/Twf+eRwK7xmIvCs1c/bErQdNuEGVIoZET0M2Mq?=
 =?us-ascii?Q?5pBp88UFf4V0i5Zk7IUZ6nbv1Icdq3zNibjQipKv0EQCp8qgy1PNELGn53M9?=
 =?us-ascii?Q?bZNKRKq1ru45z2qOcq/+A8crLrfOLiWnL0BXK9s6CI7ZlzxDy4AYgTNmy2nO?=
 =?us-ascii?Q?q2dwXJze83IV1wlBcoRsh37aAqzUXNvLLqK6muDUkoAcqOekPwzPWGCmKt6A?=
 =?us-ascii?Q?FtRkpKhy+b6bthWAhfopX2tcmLUMW0u9q33YzZatYD0dsJXo2n9/EK5EUPGL?=
 =?us-ascii?Q?+zfCqEbii0MyidjANUjQXzytt72YvUJb6FqDUGC+1WxstAu5oCa4AuLbemV9?=
 =?us-ascii?Q?IDzr+ciLIQqt2csm+zHsgUIFQyIYQiILhYwcpnpVN7dDZM/G3Sz+bQyxS7xY?=
 =?us-ascii?Q?Pw9CmLJf1/29d72tIqOwEPUjn+3m4ZGuSLQ23t1/JrqzrheGa+H4Vb3GwN7Q?=
 =?us-ascii?Q?VAMLepL/UyGdOfB6gIgv31ehrc/PafyslQQEolSfDxE8C1qI2/qlN3CuSlP6?=
 =?us-ascii?Q?R6qdd4E6L2o0phzMLXaCc3bYjlJko1uLe1hRmR3vX8b4cXzhKgiBaxx/1GFM?=
 =?us-ascii?Q?hiSA883G4TPw1zQSubEjg+N40nYNCRPNfdVk5K6cC4beHCv5pDKVVBUuZk4l?=
 =?us-ascii?Q?w5nejIjSHXEFZQ2KQwP+q+/lQZZfwiVeXXMy1+i/kPpuA4sDrgxo9vnIljwY?=
 =?us-ascii?Q?bGUxBD/89fr3ESKOeZ3SUDqFUGQQjlfFi0YgQPithCGI9lHKk04IZEjndYhI?=
 =?us-ascii?Q?CTT6r2Uw4Fg1zj5KsiAJeiHoGNyixCdmRSuIOZqTrYQD7TijuVCkBQzzEJ4D?=
 =?us-ascii?Q?g3zjF2fjABRGbZchKtcxSOcet/PTwP2qJ67ar8Lo/0monjE+LLglKNxZPeHR?=
 =?us-ascii?Q?S/CdTM7tl3Fhb+gvNf+UPuEocl4RM+48MaIAm2wiocUkw5UZRD7Yi/6dNb+R?=
 =?us-ascii?Q?necyaYdgBdkMSHVkR8lPwTgJejC8JDT5CKq/Z6nNS1w7Aquz591d9c17bWT4?=
 =?us-ascii?Q?VR0kj0+vbiDwkn2ndLnUUkaMdTpKML2n4RPCWhVtDPSXeJtuZTEAW4SNzdn9?=
 =?us-ascii?Q?kgITMk2TuqiLuBRQBuuvfmO5qi/yXp7MeOl9eprcaaWrEX3dZlNeYJOeNst7?=
 =?us-ascii?Q?uA5mGoutcf8B9+hK/heNuOtK5pUMJb34t3hAndbvJElzEh99bY0JLXtWKeb/?=
 =?us-ascii?Q?Tzsxgv1jS6ZQyau9H6CmPgx+kjwiS8bD7P0Jav9HwZ3bwRv086Yaged+o65E?=
 =?us-ascii?Q?DNGjXyF6HIxdvKem8iSgOtOiZuO+lrxt9wMkESDE9tMitEa7nCvHiSAiQpAP?=
 =?us-ascii?Q?m67nbZfdqqA5MZ+TeQ9nJgQQpDI49Y2HVLS1j2KFJmXsebZwNu/JiafeHFtD?=
 =?us-ascii?Q?NQSytcKElYbZmbEocspgAFpTkF1qqJyhTZtG1YWiFhvx8ZS8LHRyYX/QiQS3?=
 =?us-ascii?Q?IT7IdFvLGuKLrSMdFidVr4IAWcE/gMPh+0npqcPy5SFfbhJwpnHCQuUJ3BCS?=
 =?us-ascii?Q?mPxlK2QE2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db0af26-2f69-40c5-94b8-08df041a5517
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 09:05:25.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vQnfM7PsSDyvmoRQWV3u9ImCWJL0lLxgAJxV1qoLgb7Q1E4+KbiQq75ucJdruO3+buaEd61EIEcAwivMRJDBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792

On Tue, Aug 25, 2026 at 06:07:44PM +0000, Lawrence Lee wrote:
> Sorry I should have been more specific before. Maybe a better way to 
> phrase it is that this would be analogous to IPv4 in the sense that it 
> allows NUD_FAILED neighbors to change states upon receipt of a NA, but 
> by using NUD_STALE it remains consistent with RFC9131 Section 6.1.1.

I think that your setup is quite unique and I don't necessarily agree
with the statements regarding the CPU load, but it doesn't change my
conclusion: IMO it makes sense to transition from FAILED to STALE when
receiving NAs (most likely unsolicited given FAILED state).

Mention in the commit message that trying to resolve FAILED neighbours
by periodically probing them (e.g., using NTF_EXT_MANAGED) adds extra
work compared to having the kernel stop ignoring the information that
it's getting via NAs. Also mention that the approach taken here is more
conservative than IPv4, which by default transitions FAILED neighbours
to STALE upon receiving GARPs.

Note that you also need to update the RFC 9131 comment in
ndisc_recv_na() and the description of accept_untracked_na in
Documentation/networking/ip-sysctl.rst. In addition, please add a test
case in tools/testing/selftests/net/ndisc_unsolicited_na_test.sh

Before submitting, please read:
https://docs.kernel.org/next/process/maintainer-netdev.html

Run the CI checks locally:
https://github.com/linux-netdev/nipa#running-locally

And LLM review:
https://github.com/sashiko-dev/sashiko#1-local-review-recommended

Thanks
