Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792567620;
	b=sa/pju9b2nQRLduFB5FN30+VTsXAXFv0DpiXYFn8RwxSKwneL/ggECfQZkfDmbEe7Obg
	 mdKTFVRbWVZAgpfNqdY5dmN+5a9u5d8XUiLeYPWIvJKkW2hymETUt67eA8pYATCntgimK
	 tJE71O4tQ5DK2sscI604485j9enHRk1Ul7xAlJQYVZ3eAXsXO+Xk/4i8hG6QEXRGWwPej
	 JgFxxigysgPf6omtOvOKzSgxjwD37MSc04IQwHu90WL38G7JVva/LQPHZ9BcAPqmUSnoy
	 Y0FNC7pBafZRM+MUL+5L6ervCTjzMom+4gpZtZkz65YBS7vbYJ/qZ7HYWdMnCcYCrMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567620;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=aDZ3ndX1fnaLbRfzON1PuMIgEghBiy3kRRWeZ/z+o1M=;
	b=3/O/x1HxCEeECmC7UIV8v/CzTbxc2vFg/L8ZVpvJsvlcCWo0m8djPR0HG3rgYOis9Teg
	 HpzhnBdzVFkCwb33Gaz/OxSkD05PFc7tmO2llNgrJMqUOVf7bxRGPUZfDFkjjEtgIBP4l
	 KjrmYs7fBElx1wwc/cGBsbtNIJMFDM1OROIRnBFZgNvKLTI4Pi6REFRn/fF2XpxScqv6Q
	 JtDqbY1miZd1e/pUTV8LwwacXFDRRG9CpEYxaTJrqrtqo6jE3osMYvI3KHr7bj8uvmUCn
	 QKMdf2Apyo/9i0+lBu2N6OredVCy8s3f4Gjfm51h8k/Wn5LPztL36wPqpcRE11Drdxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RbPB4S1C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.43
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC6606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54EC6606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RbPB4S1C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPa8FGmLQWGCeOKJXIgqA6z3PRvlxV9Aqo1SPQbBkjJ/3OVx/P5vI68AIRiYJexut9TPNRraMyLIBXzSzuiG7vh/XPRcJBczLSkFIDt6R/UEYzqlbVIg/XJJPSb7ofmM7WcO6ITDEk9UMrGhmHTWRJqjb1VhhuSuYGhc7hfcLtmcH+mKezyX0asOPkUqeHCqvGZhAD+BSXg243hdZW6uQQ38MOFEX7teimfMYybnR8jJfY3gUaeWbn4bYxU2f26W9GR2a4QlxGJWY+ccDd4XrK32N19ILHj8BP27YdGPVCMikEts6hk3EkGUxtAYLDaBgbzmQSKdq48AmIWtdUfQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDZ3ndX1fnaLbRfzON1PuMIgEghBiy3kRRWeZ/z+o1M=;
 b=jdV0Vs6ZqHVe0YDAt0E53X+d8v62tQqCph9AB1LhwbZC408Gf01HLQ4BwZR132nhVWVvyIOG3N93VGr4IswZUq+w2z8cczmcOEa04OH1ubMhLMeCJWQECOIs67i4pUbYHVcM140L4vqnzZ0sK6LeHepMVV+KYH+vTFyCn01rGfVPeTAc2rUzYzX0pJn98QpeUtpzA/i8TCWPTBEI96wgrVOqo7a1y6vh7KeviYaAO3Ym9P1duHs1qFmOMT8ZZjuZrhvadk+xLAuOc5OpY1xNi9oSS0io7BcWcyxNjQXVOaUgYXSpUlNhLAbYoMmpbTfIR7uJu19GwpUvpIzYUn8U/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDZ3ndX1fnaLbRfzON1PuMIgEghBiy3kRRWeZ/z+o1M=;
 b=RbPB4S1CS83NIZn29NH5ES1wKbc3a/ycXmaCAnfw8W/4J26KDN1l3PR+BpkVZv0NTw1O1AI1Ers7mZnYF+gY5rK9NZJ4SufZ+ayftTB35wiXClFhW5fSMgOLOa7Pce2wwaxn5hEarWZjXmrm5KRGaI2PQJv4/PDTvQlihQkTHaR8iDDbLctOJGhg7n77FaRRA0ZhxHVQhC3BlXhmArwfrla0CunoAc65fEubC3ouWV2kfUSXCiBWtq/CclTvuwVtkmWkCdT6CS2GI4ZVXnFE9l3JORigzDuu0sIaR9Ylz9HcXrCzxV3ut+pYPqoFYMxreiDXFx6WHd1cIwHsg2m7Xw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 07:26:56 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 07:26:56 +0000
Date: Wed, 21 Oct 2026 10:26:45 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: edumazet@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
	leone4fernando@gmail.com, vega@nebusec.ai
Subject: Re: [PATCH net v6 1/1] ipmr: only copy pktinfo to cache reports
Message-ID: <20261021072645.GA3280290@shredder>
References: <cover.1792476357.git.zhilinz@nebusec.ai>
 <0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0545f0c83f5ee2f6696210f87268e811ef655715.1792476357.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9a3429-3797-4cd4-bab0-08df2f44af68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	edSo/MeTRAbzwp8PYj7np5YFx4M8QJiDIEtZ5d3CZjfAR5ezZ85wT33I4h1f84+4z/BVALckB+GUPxz2W3w4mAP+d7mBpitIZqcWpVcGYheXbhJfnEw0EsmXU4QtZFllIGjfBGcWmMSlEVwYPsW3vuAHT0QHuwgKMUn0tHTsTncbt/TQhUgjAfsRFGm3l/xRGFs8qU+1NPXoBD33vURFLIA/RMKx9uktd2lRfNdzmV7jBp6SRl+m5a/p0ygALrlIGe67PiR5ipCEqPqrLyV/d2Wz+tYaskAXzYSP33yJq/W7fMHM4U/mPeYheGEFUFXv6IBzG044e/DGlN69wd8BDDbI/6o7AjYEEtp3deCXojcsOhkPICSDcHaSHo3cw67K80v9L6PXpoDcJtvVFz09N1RAeCCXzKlEybjxtBJ1IuIy7e36QmnWIJVaI5eK/zYnq/uyw7+wghfBUhaWVJ+cdrP6s8HpRbhiN2Dz74pFDB3TUamwiQ0WK+3q4n6bPC3R+1bd1zcWEE6dEGOzC5s9Hbu/RDIIVJ9+G4fhQGT8/6gUg9s8W4RvgEF4KAm77wr61OiUj8AiyPFjtM1bxPrRmbzpiqYGBVxCblPpDUVSNr3GWoBtWgVl+3T88izOU2CEmeeQTqzUQbvr2jzANKJ9DdA8EPKlidYN8K/8ol7D7DE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hSBY0poiVDjoDppUUuUoQE5NfG7FFQ+fx+j7RPkcTXM/fZC1kTbaUXYsUeYI?=
 =?us-ascii?Q?bZy0oq3NQ+TG12pA/zzXms0kHTtQkFpBFVrLrNoqYpAt3sGfbDH4Svnode0b?=
 =?us-ascii?Q?5pkrxo0MSJVPVNMfj4U3I2Lcpvfk3ixqL475T8Q8g2T+1acpCge3KQnZQgtw?=
 =?us-ascii?Q?YyaOyJFb0bRr8FgQMNrA54MbXYqejUeoJAWdHrj4uFMy+NFdpFohL2sIdZz+?=
 =?us-ascii?Q?IqDn6Pu5VF707gXQgsVDk+9d62M9c+C/rF+mx9dYLdYb7MTN3UxNhHJzK8lV?=
 =?us-ascii?Q?ZXVRym+LT7Kjg+lBBMvXYE9ZvR5oYkGRqYqy62f3REPE6u5F0n5QdDCssiHn?=
 =?us-ascii?Q?3Nmd0T1PMV+ekRQJCazWsfAKu5gyPkhWHqYuo8wFXKJMU3jgf2MoO120+OtW?=
 =?us-ascii?Q?1K2S5PEMdvt4GS7fZNAElrWGwdupxKQk8oK78ttEio70CEwqkwKT0MQ0Cuwa?=
 =?us-ascii?Q?dKicK+lDOS5R3eDMpAEwNdYNgj7xQ9NtooBmUdEuqPCz97MlUvPjWWg6cKyc?=
 =?us-ascii?Q?friPjuoTI4iP0hVYf65Qt46WSBgALxyMrV5SEm5DYf/2YxzfCnXHfSNRrHTF?=
 =?us-ascii?Q?wck8y0ITLQWBjV6bZG0DH3Swzcq6WXE+lYQOMOZwLmuP4HERZ6nQL7/fJT3r?=
 =?us-ascii?Q?4oUi7t79Rw+RjaiyWRM7hesaYavDQQy8p1wC2Oiku2kzpi2Lj98rQQJ8spMb?=
 =?us-ascii?Q?XoaQXze+tgDN6fh+UIjbEOEMPmoQOAAsCkYgMQuqh+MsdxNsJ5vBKPawW1it?=
 =?us-ascii?Q?4Atvpx3Jf5ATpmPv7As3vS05ZdFcbFJDg7XsjWqZh55uKSijjcLJPgQqT19E?=
 =?us-ascii?Q?tFfktuSD3skvQaKmJ1Bknune+lgAFlyOLmT4n7Vn7WmuTQ8EvJranAkBssM4?=
 =?us-ascii?Q?oVLhxGqwhEyhxXJAdVLNlm7bEZ2iBwED9ODtol3X8IYbEoQhA+pGqOI59ZEb?=
 =?us-ascii?Q?E2tEQICvtcY3iRptpdJZ1W1IOfjLEuj2ZeL7PTv+zLWHRDYgwbflpfIVJP2U?=
 =?us-ascii?Q?kSzGX7OWr2PcoBY9cvLeON4YheIfqyKtGJ+Z7E0QAo3H/WVh7PEihgalCpMv?=
 =?us-ascii?Q?D5CIzgs1km9szcf/lcn6unbbVM3nVpoXeO1YkB2IUmh+KrPUMLD4PHuhx1N9?=
 =?us-ascii?Q?y+8qHHGyV4vD0LdoaK6jGzT6Rn+BsDhIhCeHGkAqvxNrP0z+yzRw7KfPB97O?=
 =?us-ascii?Q?SfinSSBFmZvghdf1UZ9uCLXqIdL8H0kvYdFPOrd5Z6utmAYuKcttEfjizzGW?=
 =?us-ascii?Q?u5ZKIONlZBcgAFiATwNTFkIVAKn+nGVi2PKJ+1aG50tdPXCxzhcqUqTxVop1?=
 =?us-ascii?Q?6PBLR1O91fEhWEcX7apCxQS6xsqcGXQuAw/nMHE9QFY9/rRHu+xiWhXsKtOf?=
 =?us-ascii?Q?q8Y7ZdoZMCIgwitqIjmXvqSij0BmYmZ9sf8RC0oc1lQbtUjRC2G2eu9OJInU?=
 =?us-ascii?Q?SzztQQ4a2N4B3CYE1ylUnCw+WSNGoiQDUrIJKBDgzbi1zKYKXsFVK2+6AZM8?=
 =?us-ascii?Q?yk2mTVGH13fti2D8kbR9WgYf1Qw0v0Sc6YNL8pI5sbxf4qlV0ciRQZnz5fGd?=
 =?us-ascii?Q?9M5JEzpLrVY1MmvILvUr+L/BzQ0uKrkucMRJ+tQw4KMCx8BPn0QvOXS7iHLD?=
 =?us-ascii?Q?UX0MqMqJtuOnROxNjsxmVaVA3bhKCcXdY8OMXxG0lCj/C0FZTYMk50bBRQDg?=
 =?us-ascii?Q?3Gt+AHOrLlzhiEYLLVmsfl5HWIAozEsHw41EZUIGccj3njIJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9a3429-3797-4cd4-bab0-08df2f44af68
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 07:26:55.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvnE8a3bawuWoTfHAXeiFHkK9X9JyzdT83Vv/FhzgUC/vW2AK/q6HDWqaDCnICsBMNk2so8ZSFLUbMngde1BZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377

On Tue, Oct 20, 2026 at 02:39:36PM +0800, Zhiling Zou wrote:
> ipmr_cache_report() prepares IP_PKTINFO on the original skb. The
> ipv4_pktinfo_prepare() helper updates skb->cb and clears the pktinfo fields
> when packet info is disabled. Since the skb can continue through the data
> path, preserve and restore its original control block around the helper.
> 
> The original implementation copies the entire control block to the report
> skb. For synthetic RTM_GETROUTE packets, NETLINK_CB data is interpreted as
> IPCB by the raw IPv4 receive path. With IP_RECVOPTS or IP_RETOPTS enabled,
> corrupted option offsets cause out-of-bounds reads or a stack buffer
> overflow. WHOLEPKT and WRVIFWHOLE reports also inherit stale IP option
> offsets when their header is prepended.
> 
> Clear the report skb control block. Only prepare and copy pktinfo when the
> input skb has an IPv4 header. Synthetic route-query skbs use NETLINK_CB,
> not IPCB, so leave their report control block zeroed. Restore pkt->cb after
> preparing pktinfo for regular IPv4 packets.
> 
> Fixes: bb7403655b3c ("ipmr: support IP_PKTINFO on cache report IGMP msg")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/netdev/20260903113055.GA90787@shredder/
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

There are a few pre-existing issues that the AI review flagged. I will
take care of them.
