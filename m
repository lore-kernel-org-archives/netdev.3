Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350CB47140D;
	Wed, 26 Aug 2026 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762665; cv=fail; b=U47pabjSoWQi9INkSKDbDwMwr+kfNYoyklH9Fj52iOFr6GAXvLEVm8k0YqzZFjSXWFUhAZ/ORUa8cBX7RpB8UYDeGqOwERVxiWvasWZBD8M4lzJFhr9gBDT1LeOGTaFCJa3PC5jR9SWpOMga42nwGdqTQaRehyrSp3AFE91oEWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762665; c=relaxed/simple;
	bh=H5g6qOkQwPuqGeIo/zsNa22K/PNeigZTYUeLrJFXfik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qvhaXeS27z+P2h9awGL2Ua56Ybu7uyXQt9JwdmNIYmAw/JW7/O/V2J0aWmlh8TmyU4pQvSfWB4LOHnJh7Gq+kpFCHDhnM7Y2M6Z55dxrBNrFbXqHh9Ehvich/ao3qHzL3zrMEOn+a86vn+g9aOWK95KfE3x+9pDSK63K+6gobsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q/kbT28B; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q/kbT28B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coU5Mpznmi4HCobD4mSR+vi2crJuhwlDuARMQbm6jq9bLrf1itoLlYgdGWM9qbTcx4raKWM9KklobM+KzmBoQTrQtTfo0HaM1v6Qy9NzQRSeCfBLTBcguDWnVnJjM+Li8CZoW4GreknxmHWgqSv8VyGvJBcClY6mr0Ff/2tx+Wp1pmH5QnBnc4fucrYSbP9AN2+eP4EtqE1xGDbSdEd8Rhw1ce+EHRBG3OWveJRC9t/3oWhXJPCzbhYo94gRafEe47arIL8kBiZXDoI6KKY2+rchH2JidmaH/wnzd8FPsy1D1SXUQVnDke8g8XEfFP3bMbmw2qaGboCEMBeS0+qfHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGE1Iu6vgbN84yb/2RTgpU0rD8Ea4tVuOWxKtlHzTJ8=;
 b=MAoAR0dcOeZI8/UUTsq4LaTAY3tdBLlwcRdflFaGmDKWjWXr/rl6no8BjQA8mQAbFXDZsJdwpbB4AG5PexVnJRSSfosFc54z2AJ215xLcn89nnvRiLJtLNeWtWmccFkbYZUUZzyXo63o8m87pn1vqhGKwIgDksxIMrJggxGxIa+SbF3yW0oCBr3YfE7VYmnlfswCbJxnMTFJJlIZXPIW59lbGCFf4aelbzNhv2TPRIy0Q/mKz0RmCL0s51N5+sAX/hsFuM+igO/gk0bh2P5s1RhbPTkFO3ZYYq+a8QoIfbUdTH57hzO8CkepPFY2KdQGDI7OjMcbb8my6EZirlTSMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGE1Iu6vgbN84yb/2RTgpU0rD8Ea4tVuOWxKtlHzTJ8=;
 b=q/kbT28BEW+Qp6tPJjhqXRvcef1L85pm+EMrX5E1DyI/MEMD9xE320b9vz24aPjyXLxJVtEIMAES1fQz7plrEfSGqiUcKVPos5sDw1L0JA2EkN5sr1rVUCEfY05UpIxWCr+Py1THAw6epag2qk92ZTbWbq+6+gc2fAgeog6iF+dFJwfxtGfP0JAAHYBKKyc1gO+Wc2K3tsFretONoNzWBJ/1+I5gP77BOow2Er2pNLRAF3cnzQpxo6ZH/9z65TLrLiBusFDjVFo2GPvPJAWiO2TbFSesGVvk5JRWAKDMmgFXyE4JyMfiVxSwycsNyLZMyHyx0P2xxeeTN6x+1qJ1Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 16:43:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 16:43:50 +0000
Date: Wed, 26 Aug 2026 19:43:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, federico.kirschbaum@xbow.com
Subject: Re: [PATCH net] vxlan: mdb: Fix use-after-free in
 vxlan_mdb_remote_src_del()
Message-ID: <20260826164340.GA1867215@shredder>
References: <20260826151542.68815-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826151542.68815-1-baul.lee@xbow.com>
X-ClientProxiedBy: FR4P281CA0375.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccdf3b2-92a3-40f3-3144-08df03913468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|366016|376014|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	jdB3ZlNxFnvRsSHHLLpePSg/QD4jwym9r6CFT2jsacwmUtz/YeF4Oesfo/3loNSzcQahvoot4V5btrUyWHFz4hWdyKK14UypnfuB0hoy7vlqATJ4Cie/ekbR0G9mH9kJ/lqHYV+8yn2mPf4aKr/L7tNJbUtuoOJ/OhqKYRElC1gpZEdHN6QZXnThMhBOVa0cG6Eg2mK1ohEDTYhlFXdWWOp4g/EFH1YFFAuYJeKwj5Y+qvEesy9J0J4uyOb3u107kSFZxTMhOVumNvnynobUrTnwQS6B9w9+vC0U8fymmDCvEK4uCOO+VYBRLVV+JFEV8e8e49woC80ytNeXqgQ+WJkuZO/2R4+o+5lR2FmzkvQndKTbT59Fnp6BNYS82pHwmm7yUPPfSkGL91trtV7xjNsbP4C70bEBojlFpRy4pumhdu7hFUGPtAfhllIKh/CG3IEfnB83kHlQzQv4QaHXL3U3Y65He2Div8DTsjPOz4Rgf7sGZcEsQrawwMqvGb1uhAMeb4R/V1mmZH1YfQpPNyIx4672YY2phDA7zTdtix2K6gbdZ7AR6Tzfz5gli/O/3lSy93pQHJb+LJKR74oZsMfVBeZ+Klg1XaK1NZKD90rDJyTN7ryyC9DCtqE3Lt8+w4r6/iFAel8mPVHUWq1T10aK36CiDq5F91y5nM888Ew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(366016)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paNAagqn8l/3nBdok9wi5jTRzqF7HAx5n68xeSiqlnc8C7zykRZSJJCDS+If?=
 =?us-ascii?Q?S7LPg3jICd04EBy7SUyu1l9fj3KP7d8fM77s4S7ObzdcbVc/768KT8AF5tW4?=
 =?us-ascii?Q?h/y7HFfJjnswpSK7tMtO2Yif1hdOSYKKw63MBZEUB78FmwOenKGGbYURrajD?=
 =?us-ascii?Q?XMe53nswu2Jaxg85kU0SN8KLxk5MHrr/7ZLepKKTPpXY8R1s5PJzCiJnpbCu?=
 =?us-ascii?Q?tb754mezz7zyxn55jr025RO5pPX3XXe6+aqvJB7EsDyN/B+f1h1f9ZdEXC8A?=
 =?us-ascii?Q?9S394vfTF91ztNiyBOT6GPt9UZCfxSyGLfvrootfYw2/sT2XXcXxxMhbXm1V?=
 =?us-ascii?Q?Olzu1585ehoCVUB0dt7Z1r5S0mazixxqPlGBwxn5LF152n5ChFUtQLNHQQx2?=
 =?us-ascii?Q?xafy4DCwAW4RskbO0MxNLy2gOndX+TixA3fRuvgxYANMXyf/oOcOkIBJV0Pk?=
 =?us-ascii?Q?gG6CYzQ8n3ZLBpQKuAXnFnJWzHZdCmOsgttTjhHceXFxoNpvOFpSVyicw32A?=
 =?us-ascii?Q?OuDrMn7Fcwdx8F/MVMBeEHDSY3BqBtmKBP5QWuVnW1FOnlbVnZ7xf9AD0/Vn?=
 =?us-ascii?Q?/rH+9ycT82suDx3LEaMfQ6wOl0BpOs7DD/1GhYq8QVsbKY/rsYPtZuGCwYR/?=
 =?us-ascii?Q?XNxAulP7UeBzQ2e0NuXPB48zvGj3rHp2IzGWfNEQkLmVOCsSL3af6ffkLZVp?=
 =?us-ascii?Q?Kf4qM/H5Gy3LIUNlAF0/08Qp307zGTszMzCAAysnhuzPvltoEGZqdIah6cFk?=
 =?us-ascii?Q?QBUZdL4nXyhzNZ/31oX+YVO0WiORn0E1cv6NpmyYfxuqmDzoSGc9R3weNsiW?=
 =?us-ascii?Q?3MEfbXgl+3foXDDKfo9DuecI+A1stULm/Dv5JnH3ErLY0q8OUEdA+XqtmqEe?=
 =?us-ascii?Q?7bggeNDiI97jV/QD8XNkqpV9UsJB21yLw7UC6ApQ4ps9siIfUL5vT/H8zgVz?=
 =?us-ascii?Q?aHb9cFB7lghdXvl8iAqDg5lb9QcVpZ/J4CRPxsZo8cbRPM/fqhuTkKVx9fE6?=
 =?us-ascii?Q?XZfMxqGJ652vU2csGi5NF3Q3f34NNd45SLFVQDNAQUviaFQOSQ6ykiasiOWr?=
 =?us-ascii?Q?z+4IkJTYv7Fwcg4coT/8ujIsAknY5zStNtnWCtLBG9QqGqBOUrNrIC+Ons72?=
 =?us-ascii?Q?8vssy1wUNsOtA9XIVR8W1bt/gLnOSWWFBHfYLo9QaAsfR8M7viS9gx6RwD2C?=
 =?us-ascii?Q?muwqD4gqimLZpPAAsQBxUf7WClKoFKvDQRyoA9x3ODudn24RH4LE2hJlHF1I?=
 =?us-ascii?Q?lR/aYGsIQN5lRCu6bdwbgdLMtBWcS5bjlEk7aGUmE53ACR3kEvVkhGDl+DZo?=
 =?us-ascii?Q?CfO8r3dy/OpCEXAzCZtwXKvwYKQ/2aL8wOU9vpUn4XjvyBHY45DfImb4wwo/?=
 =?us-ascii?Q?CLnsMlVsG4AKsMQCUy+xawIxOXQU6qI0W5tv243S0mNOs6XRGu8Mc5q7oqms?=
 =?us-ascii?Q?PXfgj2QdfXztnjdc0wkA6qvvkpbHiCS/OHGaTiFxxVdXyjbBiLAwJtc4No5h?=
 =?us-ascii?Q?rgczOSOJKHKuV9XKCUfQYoqH7M7vd47Lj5pXU83sDNrtyGLDH7gwrIqKphAo?=
 =?us-ascii?Q?c8XhLENO0h4cSK1yRmxgPj4PDuBy53G+3V2IbqOk+Uq2GTwq9VVj8j5ZsJrK?=
 =?us-ascii?Q?G8Bm1BDgUGlB0tPqpqcKhoqKF4CKIZBib7elRuTOVgbdfcRDMoSpR7YiUvjh?=
 =?us-ascii?Q?MaAT/h+rKRB/IfELghM068JWbWZDLu94vSTb1+eN7KPgPCYJUgLRLehMprJa?=
 =?us-ascii?Q?w7nhnDlSzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccdf3b2-92a3-40f3-3144-08df03913468
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 16:43:49.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/YjvIMV4Vu3zTop6gcnZC6juWDA1IqnMVct2olIwbhtIXiek87H1JbrXKrtuvaDXoFECZBL3SJp4aUKkZ3e2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

On Thu, Aug 27, 2026 at 12:15:42AM +0900, Baul Lee wrote:
> diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
> index d71e1925ecfd..7986c5b5dc67 100644
> --- a/drivers/net/vxlan/vxlan_mdb.c
> +++ b/drivers/net/vxlan/vxlan_mdb.c
> @@ -354,6 +354,10 @@ static bool vxlan_mdb_is_valid_source(const struct nlattr *attr, __be16 proto,
>  			NL_SET_ERR_MSG_MOD(extack, "IPv4 multicast source address is not allowed");
>  			return false;
>  		}
> +		if (nla_get_in_addr(attr) == htonl(INADDR_ANY)) {

Maybe:

if (ipv4_is_zeronet(nla_get_in_addr(attr)))

It's consistent with the ipv4_is_multicast() check above it.

> +			NL_SET_ERR_MSG_MOD(extack, "IPv4 all-zeros source address is not allowed");
> +			return false;
> +		}
>  		break;
>  #if IS_ENABLED(CONFIG_IPV6)
>  	case htons(ETH_P_IPV6): {
> @@ -368,6 +372,10 @@ static bool vxlan_mdb_is_valid_source(const struct nlattr *attr, __be16 proto,
>  			NL_SET_ERR_MSG_MOD(extack, "IPv6 multicast source address is not allowed");
>  			return false;
>  		}
> +		if (ipv6_addr_any(&src)) {
> +			NL_SET_ERR_MSG_MOD(extack, "IPv6 all-zeros source address is not allowed");
> +			return false;
> +		}

This looks fine.

Please add a test case in star_g_common() and sg_common() at
tools/testing/selftests/net/test_vxlan_mdb.sh. You can squash it into
this patch. We already have test cases for error cases there.

BTW, are you going to send v2 for [1]?

Thanks

[1] https://lore.kernel.org/netdev/20260815172032.79740-1-baul.lee@xbow.com/
