Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56E4D486D;
	Thu, 17 Sep 2026 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660678; cv=fail; b=JtNrvODeXjyUPbLlOUo1ogcIQflMonH7gw8dhZAm8jBF0hB0G/9q2gJ/AzUmPvjSW5ETssJM34GlD82jSc9bZkMhkwZnwwbWvcCRzlzL5ygZ6cGQC+bdJSV5OzjEsQ7coiodEro+GqeCitYPcnNVn0Tf6K2djUKeroq11Sf1zsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660678; c=relaxed/simple;
	bh=pxndK4JLm9FDIVkKEY3tJSvb4xAxRGrRTX8rY1eXW3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SatXk3ePx0EKUL1z7N3pYYCGn6YwDmkxmTvNDVBcNFX05KX4f18Noq0wocKbVKIeTfT1/yXnbibI5huMiaGYi4uF6W+ygn2SFmjBSRUiYRTxgGkFv1+R5+YW0SURqXXtWUctgY4E9FotmxyrudI5vomxZ148m1fq4Rk2zrIbtko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WguwIEDa; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WguwIEDa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZQt2h7Xm8HOTB6kh4yXOadsi+Bw8r+U4oecccPHRIfBmojoWuuSvLP/OuK8Ki+S5fr4xMJL08u2ODBHGYe7NS0L5Vig8AgKuxXfwIWkUZd3LDALFdE9O7iXhxwvUkfe5kRKvDl/YkOhea2pO1iKkqYKtg3eDXeS8C8j8bH4bBNo4VAg61rUcbk7Wr2oNqGlsNT9rL+W3ZubZE1nDcEpAPaRpVPTOXn3eX/ofaYWrNSN0yPyVyMgxFBL/QDwknyC5iD1oWRCXe2darFX3PYsZ3wV1r/QHW7JeemcbS/0uO9P8Vbl1ixeWRugUVeWELWY5rImSfQYO6MiZpfbwbDKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jst4LtxPTZqftSfkOftBxS1sUe8nZcsIwvYEqfVHVcU=;
 b=y3hghLFfiSMO1WGEFQG+u90pxd25kLEyS9bgU2Tp7EIXtL/I67oxYBpRUxmBVeHkK5CnngIEZKcj8kcuYG/xp2b79RovnHwWL4stvCsqfXSvzwuJrRqangQ2AtUWwmTaIX2CJ7eNd7xf1nS7Dseist4jifFK4UF1AQUHWmP+XydiTNEL4LKEwjrQsiHIIP5QqOtJtbdGdhIOFDb3DbTymPohj4ReTmea+59Nn8hUIBf14q2YhBVK3+P6atcaTAejgpGAnL4AaXw9HE4F56CXVhAbCiSAbirm9y4XH/ZswGY3UlSSSlRhW7rk1yAuRYiB6+FIyTs+RclkmKi45tsByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jst4LtxPTZqftSfkOftBxS1sUe8nZcsIwvYEqfVHVcU=;
 b=WguwIEDazF7iAFs24GTmz5lGWjtxj2PNJUTWUceSDlsr1+Q94wOhzsuqLVLpbZfStXytmq8sgcr24FqMm1I3/bOzM62UohCBdLJoexoRp/nqSUN0ih/ElQU3DKhWbTQNtqQIhzWvlQ3WTZ+ePyFMXb5GzXecIAeuCKXDvrrRULPMdmMVzyID0R19D0cwoSbWucE8iuvkzbM0H0miK7/Z9TrLrbvzYdbcrl9z9bk5AOKleclFfon34AKz/uYDf1s6nntUmVoSIR2HPY9fAOFNU5s2YSgzWe50QQUx1dFbmA6p9c7shSA0hZ2/OLeEbY+X/tmoh8s0+SrzZ1t/FtrAlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 15:57:51 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 15:57:51 +0000
Date: Thu, 17 Sep 2026 18:57:41 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>, dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: do not let ipv6_find_hdr() return an offset
 past the packet end
Message-ID: <20260917155741.GA1377171@shredder>
References: <8F80BA1A-DDFD-432D-9075-242A3435FEB5@doyensec.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8F80BA1A-DDFD-432D-9075-242A3435FEB5@doyensec.com>
X-ClientProxiedBy: FR4P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6803c80c-eff9-4c8a-0789-08df14d46d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|366016|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NJFN+II2lIamc+90QPcxh7VLTwczdyI+9DbEujnOevzTHCazJGMtea0IaHGnBZUVGiC86v5elq3b8f2GdodcJFPhuZeU0SDsOwhvts6zAOycq9sv2ZuS73rt6JHVHMJfJ+W24clE3KiPdt+J7bcVQdrph6r4juet/Wpo7IBgwPl5aL7T+GLTmwf1Q6Hl3Sdu/aHqFuYBOgu2WKJPF1eqIL9pof3BXLOsvkJcjRXBMFDm64kx+QV2/RELGAQ9EVUBRqPtAqd4CKdMbGOKWY2zZVKQVWphNl53sXMy/JSUJWdJhOXPbb+JwWty+PV7xv2aHWmhpwZu9oSIsdECstRDM2ilzpDpG3HgE2nJIfDDBRxrwAbdETZYEwGj1wrwyC0/POfs9At+Y+F04rMTyWUFwOESJsvL4HgkerONLkX2pZw2XPJ/LGEbIuu/qRbfsml0d8Pfi1L1Rosy7lxgQlJ6WpZ7lgl1xr04WTq+9l1QwxL5+8bGWiPr41Cz9noNN4V4NM7AVL6m9KSsKh0eF3WjhKxOBNiTG1+XCQGZkS9ILXRkBunFjfz7aqqskHYjeCMTm4ca6C9UO2KUGl942Qq77sV81/yI3YnER1Fu+qrM0qaGJxp6Tz53BEM2RVgGqofmaDLBYpo+NMzIGpjNbCsUb4TQrf4sw7NeAGqLWZks6yE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Maev6jRfNes3CbnOp5xDrVV+o6ufvkEpcIk/djwFINJkN6zOQ4+RQq7yOqht?=
 =?us-ascii?Q?IzJ4n1IMwSPVKwB69VYegRy7zrMRY7Q/1fQp1J0YcGwzj+FGjv1ahtxBaUwE?=
 =?us-ascii?Q?95PD2ZgswQJ+IhH72/ZlZvCHLHfiaU7pEGOkJjrz9/uPPYHgZMEKOps8Zvm8?=
 =?us-ascii?Q?MT6Cu6U+wA9kvSzEmyRns5UpEtQIz2sTpZv3FeDhvkgCe6B4T3c8FBIR16nX?=
 =?us-ascii?Q?Va2XsbGbkHWrcKHwhMiz2QexEa7pHwRIwzC8sFWuP00+YVLuHLyedAwYXr/y?=
 =?us-ascii?Q?qYlduDTRNWvv69Lk5ZFBzg6YSryd2/K+Gjh9wQ2Vn5vap6xg9tcYcI22nYaq?=
 =?us-ascii?Q?5b6Ms4oCYG8Nh9Hbw+vN/hm5JydUqf+/lUmY80EeazZ1IvShZBOvl2Ci6+DZ?=
 =?us-ascii?Q?DTqUzPoB2BBvAxLBlGpCpdCcn/fD2gEuR8Kqqyq7TlbhglIloYyxry4C9rZz?=
 =?us-ascii?Q?tvykrz8BsuLdBu09grhWws2SiZmR2OceKHyv/pEmvIJ1ZcJ1KK9o8sBixykd?=
 =?us-ascii?Q?LlqdrxhVLRvj3JjQIA7XIFrlr/0Ci/3SIHa+ifDhQ3uYvPy9nxW0jYaYpwEH?=
 =?us-ascii?Q?c8/C8VarQtrRhwAiJHNyf1Yij7/m64Taf6II/RtpppavPUSUZnDNKYspVtgu?=
 =?us-ascii?Q?5hriYqnSvc4mDIf2MgUA9qzqnWzxE8kaZHbhMsPBX45HKvrofesVpHJhy7Qi?=
 =?us-ascii?Q?He0Jcl9Yv4D4eTvcY8GKiF4HgaJETreDLTHH0x6upIme0d/vF+sYyv8ha4Sl?=
 =?us-ascii?Q?zATMxDQhWocKwt5u33SIQBv/mIEAirHU0HkNQLjofG90iqWERKFDQjuauTCY?=
 =?us-ascii?Q?/YQOMQQVNqMyD38zdkd4pWHb4DQmUdmiiywSTXWGrOkYqkayO+DltDbc7zkE?=
 =?us-ascii?Q?1Nb6dFJH+4RGpECtcR5+WdrIN1UFKao9feYRJ+8xWZs1x738gMs0J1fi+MKf?=
 =?us-ascii?Q?umlmqTUOKrthaV7sUzol2YOq4NsSlpHd77raK6myWtFSX5uIQSc3sirDbMlf?=
 =?us-ascii?Q?yzUrxEpj+Mve50MqISzDBrjO6JeusWmpgBPewylrOl5mycRSvj81EsFeZeET?=
 =?us-ascii?Q?Ie1nVXDbLawmUUwp04TLYVj8BZF8pvoRGhRke7MJo8Tiei1ITq9bBFWL6uV4?=
 =?us-ascii?Q?8VxNa9EuEZePYpq7zGqZPH6ac+3Rz9bsYbuApN1m6LYc/XUssQRQYSDG62WU?=
 =?us-ascii?Q?/YLitBi3DfzcYhrsAKO4ikyyFZbW1XiA60o/fdTbH0FNX4yjwC5VFhYc4WDR?=
 =?us-ascii?Q?g0GHLn9RnfSI7P3+lnXEBPTbtON0n5MrSOov7sK6pOno5HSpn5S7TzvGjFmB?=
 =?us-ascii?Q?1s7HgDdRB8V09mXavwxxWFmvN6MUuS2PxqGGlcmmsExpNhn9vT65pVOSCorQ?=
 =?us-ascii?Q?vgZoVK1PkcdF6gDOhbJZWIm2Qkxps7dFGHxPTey7/RsCCej0vBCaSiQjr31b?=
 =?us-ascii?Q?WsQwRT/mDyf000O7B8wMfVv73VZNErgG/PtvjDKBuk1qp26EHcN1YOlVaPYp?=
 =?us-ascii?Q?T4xwdsKBTUdc2H+teOgUVdIbwLSiZM2fbtpD/It8wzPM6tNYJFhtcFsdoEfj?=
 =?us-ascii?Q?Kbz8TUmj+wT/SRc+8oX1N/BIyvaZXOSwfstTB3Vf4DSa03Xjif5IDywnaS/R?=
 =?us-ascii?Q?PUbingavO4wAS/MbqwIB3eeFlzz7wxeD3ywN+APpjwjLWmqsbpUzbU9+urkd?=
 =?us-ascii?Q?KOinfvRx+gQ1e971XfYCOzCmjcNn6KgVaiMDcVtREzWaERnN3xsKJVQld/Y9?=
 =?us-ascii?Q?Reuh8aaJKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6803c80c-eff9-4c8a-0789-08df14d46d6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:57:51.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjAV7QM5qnvLwoBCe6caal+NJf67Tw3x11pRv/kwVVEzOEquLMJa5hYEaJgwT4M7KlPh9aaotm+2nc7SXDmtAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

On Wed, Sep 16, 2026 at 09:57:53PM +0200, Norbert Szetei wrote:
> ipv6_find_hdr() walks the extension header chain, skipping each header by
> the length that header itself declares.  ipv6_optlen() returns up to 2048,
> and the skip is never checked against skb->len, so the offset stored in
> *offset can point past the end of the packet.
> 
> openvswitch installs that offset as the transport header, and
> update_ipv6_checksum() then reads and writes the transport checksum field
> out of bounds:
> 
>   BUG: KASAN: slab-use-after-free in inet_proto_csum_replace16+0x445/0x470
>   Read of size 2 at addr ffff88810b754b06 by task ovs_ipv6_oob/629
>   CPU: 4 UID: 1000 PID: 629 Comm: ovs_ipv6_oob Tainted: G N 7.3.0-rc3+ #348
>   Call Trace:
>    inet_proto_csum_replace16+0x445/0x470
>    set_ipv6_addr+0x3dd/0x460
>    do_execute_actions+0x6a3d/0x7c40
>    ovs_execute_actions+0xfd/0x480
>    ovs_packet_cmd_execute+0xc38/0xf20
>    genl_rcv_msg+0x59e/0x870
>    netlink_rcv_skb+0x18b/0x450
>    genl_rcv+0x2d/0x40
>    netlink_unicast+0x6bc/0xa20
> 
>   The buggy address belongs to the object at ffff88810b754980
>    which belongs to the cache skbuff_small_head of size 704
>   The buggy address is located 390 bytes inside of
>    freed 704-byte region [ffff88810b754980, ffff88810b754c40)
> 
> Other callers use that offset too, so bound it here rather than in one
> caller.
> 
> Reject a header whose declared length does not fit in the packet.
> ipv6_find_hdr() already fails with -EBADMSG on a malformed chain, so this
> adds no new failure mode.
> 
> Fixes: f8f626754ebe ("ipv6: Move ipv6_find_hdr() out of Netfilter code.")

Blaming b777e0ce7437 would be more accurate, but it doesn't matter in
practice given that f8f626754ebe is from 2012.

> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
