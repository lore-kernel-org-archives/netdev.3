Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B03932D4
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845293; cv=fail; b=FTP6MUKcg7dWiUY6FMLLn+6p+eqpQLGBGm8VyEKCdnc+690XmOX0MwI9f4ts/SghLsGdUgzfgloaPQ461u8IbC7tAHI6vJlIl8ULsLpO4KMJ9XuGPYceeItjknVVT2gGn3kKqgkwFFqSDBEUdBOq+6ASfipsVt4wnX41N13P+90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845293; c=relaxed/simple;
	bh=zRlPfOe5CtCs78UeQeqLfLcRSsjFMIEAgFnekkxinlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DyoV21PRc3sfoHwixmgFZD/bqn8ORhW9rgXcHjN4632+iMDS1Ts6TdVIz3bFKEP74ghkgNKfhErvkvJb0FqS0I8pA+eDJsGBUhabxnfRTEDDX9jCFSUkfc3/tnKdRzZ7iai/AV1ocRdfktUF0AD7LejCr6YZou8CE0ZQ/fedGsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HiQzCUsr; arc=fail smtp.client-ip=52.101.56.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HiQzCUsr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEH1ldOCt7GfCd/jT/M9WQp2Yy0xQ+JdEX7ueE9pB2vx1Kw88/Ms9NtH06a9reO2/5MXSpzVtlZmICSHoLafV5XNc5H90tKjPhLSw+fvSbmn4rYB9jTs2VADg35l30wRsqnufFmEJlsqvlLdFi+tVcZdVaALrDby4absN2FSoNbRmVA1fU+CFSYWpK71PoJodHjakIcqYwJ0f291Fe5CXUKNSY8AFpHn3WjtmeCeolqr//jJvg2HkcQ1aCno65VwSZb5xn/OkUUa2ZBrNZuSgCYDm51Ui3XYrH4swe2IUYwQx2Gri/HSBMgsljpDngw2g+1wMFV542PyS733Z6e08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKyq9d+q7L6T721mj0oYLmPKNe2S1B6hlcdWDjL+oZM=;
 b=SKutjUXL8EmAUxuWKSzDK/O56DTG64H/74VPTkb3HPK95UNkX0yxL0JurG668HNVQxu8BQPjGmUFjGBtvTngPJLq32jyTkjX5kvSHZgXsG2s7AYSxXWo44mmqdwi4l03HkigRHPmDivQ5mRZ9+qannixvug/S2sG4s9u4XAyvW66i9qGOo+zLbx/AQ+hJUn3Afpj3BAjgLRVcX1tbANthJqJNuQsjaKnqN13T+fmWqGlwisHM0JijbO+8xMh/1k61v7L12yqVm70MJCHlyJuC6VYSXuiZF2uwyl8DvGYk2xKhT6S+VYvnze4+G3JemRbUXy2G52pSVUmg9r8KRmzjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKyq9d+q7L6T721mj0oYLmPKNe2S1B6hlcdWDjL+oZM=;
 b=HiQzCUsr7Wy++RrSuAfEjHJ8sjuXbn/lEMdhk9Qvym8z9YTqPVzxsKEI2EpPkcPnM/PaxmNORKhJJ/PvCqqeT2dImsdwPaxFBFP6hsMaRSI4fNZcPHfFLAWW0b765CnpSOK/tJse+/GGvJ5xsvBDzHs+fv3xUAtbajwHxUu5Guee+GJ/Qo4YH6MprDKiAV5D5IG1ZHaZQETT1RPfhuyxNUvCk9L8GYCdYplR8Y5HFArG+8JDP9X8klLJcPfv9gB9a4ikBuBV5otrRFCY0xy0ANLbgJjT14o8oIPGD99R4myjGrUQgAAPsqrBbSgFsXWGq9m8T0xwfEjKh1YVyCJQ/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 12:08:04 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 12:08:04 +0000
Date: Tue, 4 Aug 2026 15:07:53 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	kuniyu@google.com, gustavoars@kernel.org, runyu.xiao@seu.edu.cn,
	jlayton@kernel.org, michael.bommarito@gmail.com, kees@kernel.org,
	willemb@google.com, lirongqing@baidu.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] net: ip_tunnel: reject excessive tunnel
 stacking headroom
Message-ID: <20260804120753.GA1073788@shredder>
References: <cover.1785691607.git.zihanx@nebusec.ai>
 <a25901403c69929d6f72ba802b3ab912f2adbe63.1785691607.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25901403c69929d6f72ba802b3ab912f2adbe63.1785691607.git.zihanx@nebusec.ai>
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: 30744568-c153-47a7-aece-08def2210968
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|4143699003|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yaNqHJqo82pLuW1o+Q++0YZf0f08tiv/N6MTrWvl/j1rNZ8gOz5scYaUEPJ0unBQ2TDRi094F63qMdpaIOfQEuCbD+nWO0S+sACgr30pa6o3MZeerjyBlXgYD1cDSNxIU514fI0boAY7h/fjXtmZA1NhrXRpcphpiwEMlVOcD8DfDomaKfNDYpOGEQ6W9lQQ5Pft1R+VqODY1fC1eYzpICRD7k8pAqeq9xivswLKwOeJBikOGnvOj6H5dFC7aPWg+Nwp58bMpEKlEM5rj/op7L8L6EyiRR9d4PdLN3He0d4nUvZt+zZa3bRIZhN7RCRFZUDRijdkoi2FnCZT7+9Ubm8cJQL+sRzuu3zVtwZwTNgkOEBlscUFXkPnmPXZ0y5iaJpaQNWQRvn9xC5mWgqaasSGPj8MFYFHqSWgzbuWW5F7H+5daQoVSQACJMCsInTzNTXRVrTr4Kj+sFGlKxnrtTDZKYffYf5fdObe9i7ARSLc4wiEFLW6VFoEyItbBu+6O7QFLC0CDf5/QfTYbZMfCAKch1ylYREQa4Oorrdl4HQU4eINfoO+ayKv4jVT+Q5raaV1wcdIgBn6UQZ+wGd5m0l7LfFLkGCFJov0F2qVtiC8ncM8xCErC3dzAbgJO2zHwqaQqu7dgIHBrgzdfTcZRWuuj00XtS6WJJ1gBWQq8bY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(4143699003)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ODkK5pvzC4oxUI/xFsGn//1ze/iIGB0IWiiLW9ZSthsRcrIsNwNP9jzW2wof?=
 =?us-ascii?Q?pAUgpQ2mqVKYd4fjzN27lf4lCtGnQtu6EXr4Y/Dbnc8FVEes3l3iuxiE5VoW?=
 =?us-ascii?Q?k0xfz9v5plL/4Z7Fm/yn4lUkDg87vnzf5uRn19SfjctCmpSOcBUYDVIV0p6E?=
 =?us-ascii?Q?VaAFqcQi3t4ZOuNPfDbTK3tM0QY+ISZwTSrJJ2ltOo5yvsOEK/CORl3ddEmx?=
 =?us-ascii?Q?Mx+npO0Z5xBTWkCweT1wlryIpJ5snSl15wspM/F5Ywi+R8rXzg+DlzVh/iC4?=
 =?us-ascii?Q?zBxhdMlfvg0YxyZe+fAvY67YxZUR2+KGOEWdQyrbBjGZ8FGa6YxiXf9BTVFw?=
 =?us-ascii?Q?RraaOixGeBXdAOSROcVQeE25BQays8NgW/4A73UN/EJ65FI1Y/IS72ojlvmP?=
 =?us-ascii?Q?I9dHuXrCfoj0kl3eclsWznWBcvWV9S1HwF433sR6x/QpBzfTjzF1THcYtFIH?=
 =?us-ascii?Q?b6CsuVem5i59+CC7MH+bnKYxKlaPlDejAGgDhsFBqGv5K4CRFhaluOvMSjra?=
 =?us-ascii?Q?M2rYtZ/m7WeUpUpQxNuC5RxMaYzKtwW824bncHwMyNfrP+biW+Wcttaa6ReA?=
 =?us-ascii?Q?AJj0HBp9yZxLt2ZmMRxTIedkdlD0VaO+h7MaC1mrTUxO3ukGvC2RzJA1PClp?=
 =?us-ascii?Q?ZhpqsYI+0S/fHy3Vmw6qEx2Fup8VvkNm1O4wTtbFmOondSaijhwXI6nayao8?=
 =?us-ascii?Q?wL6StNqtz07+OURR4MDjjtaVgtrJwsyLCs2oR1HEMnNTRmjarF8uuSov9+t9?=
 =?us-ascii?Q?QKcZvWcnFPUSWks8bjqXU9cFXXX64ShexVSJjOewXnvNu+sEjuwhFssYtl1F?=
 =?us-ascii?Q?C/+eAwYzn7tf+f9RzN/Gxx7BKlg59oOBt5roj1btlXQZp1mkyFA0L444gBzM?=
 =?us-ascii?Q?3GYsTRMu7LIaQ/9lNakVwnmIVgq8AegWODKzRGAWzWYalrHJR2HYoAfoHJ8Y?=
 =?us-ascii?Q?uVTONhxygurCoFgCUZhb9gmPkxK09KJ53oXesMbmc17NQXdBDPsza4RG7+Fr?=
 =?us-ascii?Q?R54FLAJGiP4hwkHxnv9+0pC2kTD/pYL+SGP/mLIYKVp0Lq1NpRcDp1Dq72zy?=
 =?us-ascii?Q?AKMjr8GSM66fZH5XT8K7O7kvQLduHocDXrAt3HdIxB9Fnsf4FiWhDzYS5lPn?=
 =?us-ascii?Q?tx6pHIIrJKosLwRvJ9XnfpDjdR+oZ3+ptt0/iP31CdWVhb/ZnTg2bvlDmY8+?=
 =?us-ascii?Q?Z2lOANI+1eSZ/cqA/UqlgBpe5runLKljEx550KsXn/2DDc+sLqXUeAX5UUqF?=
 =?us-ascii?Q?GSItrBeZ7EHjgEGD67j3QgAh2dy3kg0hnXs4yMyOkUnl484fXio1qh+5c0c3?=
 =?us-ascii?Q?+JjFdhELZZbwxjRL72k54Sq9jvrIps/O0kD6mou88SbkcYDfr3uUgguAeMo6?=
 =?us-ascii?Q?i0YOW3tb7F5ReJ4xQUy8qv6mJiOeVSm5022aHvIsHtfDzoPiNh9k4c9/QwDu?=
 =?us-ascii?Q?A/XZVrWFYtzzQymOv2NtZ8oUSqKihWclTcnbEte0/tbCWkI42nt8Cy1IQf59?=
 =?us-ascii?Q?XDagqRApwtR0q76/NRNdADtW8k6U3ZUSItBroceciyKbq+bOOPe6SZPbtwEc?=
 =?us-ascii?Q?pxt+RLOK4J52obJUxf9AWJFAZuP0gA85pyVTgIR/PAbBBjCiy27ZsECNMd7O?=
 =?us-ascii?Q?YND3oy03Ez7Cif7X2hjzTbEwDXnAdDjW+utmPRgcLIGvyHQAWf3OCWR9P1cx?=
 =?us-ascii?Q?ygfAh7POtcmNK4d6RyPCTB9bdjLtUSqFsvsSmfls1SYp46RLfpzTxXBi2hGj?=
 =?us-ascii?Q?DoS81TqjEg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30744568-c153-47a7-aece-08def2210968
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:08:04.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88xpHuJxax/Ub3NDht12ktUUWOOdhr8A/rEHUgOQOgVUlsq7SLhXU0dOYo2tn/m2XaCeVJXoXf9rgruvY7Na/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125

On Sun, Aug 02, 2026 at 06:49:17PM +0000, Zihan Xi wrote:
> raw_send_hdrinc() and rawv6_send_hdrinc() reserve LL headroom before
> storing skb header offsets in 16-bit fields. If an egress device has a
> very large LL_RESERVED_SPACE(), skb_reset_network_header() stores a
> truncated network_header offset and the hdrincl path can later copy the
> user header to the wrong location.
> 
> The reproducer creates a very deep gretap stack. Each new tunnel derives
> its needed_headroom from the lower device, so the stack can grow the
> resulting LL headroom beyond what skb header offsets can represent.
> 
> Reject IPv4 tunnel configurations when the computed headroom would make
> LL_RESERVED_SPACE() exceed the skb header offset range needed by raw
> IPv4 hdrincl. This rejects the bad tunnel stack at configuration time
> instead of checking every packet in later hot paths. Keep small raw IPv4
> and IPv6 hdrincl guards as a final bound check for devices that are not
> created through the IPv4 tunnel control path.
> 
> Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
> changes in v3:
>   - Rework the fix to reject excessive IPv4 tunnel headroom at
>     configuration time, following Willem de Bruijn's feedback.
>   - Drop the broad skb/XFRM/GSO/ESP/IPTFS runtime checked-helper changes
>     from v2.
>   - Keep only small raw hdrincl guards as a final bound check.
>   - v2 Link: https://lore.kernel.org/all/cover.1785529351.git.zihanx@nebusec.ai/
> changes in v2:
>   - Keep skb_segment() default error code after successful checked skb offset
>     updates to avoid returning ERR_PTR(0), as reported by the kernel test
>     robot.
>   - Extend the checked update coverage to XFRM, ESP offload, and IPTFS
>     transport-header recomputation paths instead of relying on raw hdrincl
>     entry guards alone.
>   - v1 Link: https://lore.kernel.org/all/cover.1785346409.git.zihanx@nebusec.ai/
> ---
>  include/net/ip_tunnels.h |   5 +-
>  net/ipv4/ip_gre.c        |   8 +--
>  net/ipv4/ip_tunnel.c     | 138 ++++++++++++++++++++++++++-------------
>  net/ipv4/ip_vti.c        |   4 +-
>  net/ipv4/ipip.c          |   4 +-
>  net/ipv4/raw.c           |   3 +
>  net/ipv6/raw.c           |   4 ++
>  7 files changed, 111 insertions(+), 55 deletions(-)

The patch conflicts with another patch from nebusec.ai:

https://lore.kernel.org/netdev/0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai/

nebusec.ai cannot send conflicting patches and make it our problem to
sort it out. I think we should proceed with the patch I mentioned and
drop this one. The current patch doesn't handle IPv6 tunnels.

Related, please make sure the team is aware of:

https://lore.kernel.org/all/83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com/

Thanks
