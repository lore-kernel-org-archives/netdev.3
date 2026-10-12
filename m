Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA0248F64;
	Mon, 12 Oct 2026 10:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791801476; cv=fail; b=FpR4xYkq6KDp7drjzzCGzEhcMZJD6MrTPyoOUaiyY/934AtSrwPAUWQVbouw7KV+wJD0T66LLwJ5aGL7W7ED+IVQbmjFxGCt2dptGekQfo15XDZbN0ymny6UTspAgRmgr9igANmngGfBOY/FTUCQZnPM7IoZ9F1vAhEaUWItxLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791801476; c=relaxed/simple;
	bh=LSX2js8E/dN+qiAxFPi1ROhezKQRCIzsvL7nkav6aaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pba/gSk+XrQAHQsVA6xMukbTILxlZcFe84OBocsU04ikgIb77BX1PdpRKIBViFILr3Fenm8/DiHb0X994/4irZfGX09TsezNkyT0LlEpcFxS2ZpBfQRqaw+IlZMIXWSijEznOt1VxbnMK/X2oqwh+abJxRTn1t/MxT/aA669LYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Izo2ujes; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Izo2ujes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6sov3FRVEKLjZohA/6S896OBi35klaARunakHzF28j2c8KAe1MMRwY3vkYRIJsi8dckitL44sRpbwjUIoegC9M5AxlUNtngyeCPtB+eQuJQ5efGdo1yKy/dQMmWvVQ7YFbzS8EoGF9DjQIqGDm/iYAQLDIyNW9z8dUfytZV+Y5CS1ClLUCfjZATbrz/eAMjDdRimnP53bDXzv1DiSRHZk8xyVjzyePhGePIJzOLvF9BV7rp3Ag3+X31VuYey4S9OiTTCUsGvpneg7wAEQs3j4rA7nLULa9JrrCuZig1Ui0PS1EMPahJI9q40BUTu336rMAQEe/xPftHaEb57feoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1muJFVwVq6Zo/jjPhDXVyUJDSNgtRV6bNRhjpR5Iqw=;
 b=B/6CZEugtdwBOPxF6Y+HN0BdT0unzy37sCoGX2SHG7eBE2UXcWaV1kaXrt1+GY2ndaA9Mu9NBhYlVdF0/HNghFfNgpzpfrOz++9v4jSX4wJOOjLz+LtUNiQVZQ1+M5hNNcJKiNrW9rcTvyS2QCZdwrhvcs2HzaY8HExlO1OIrhZKrBrgGzTaaXJrnaRhqRR5JV2pHO/XAC8kQwi5GRzIkoRHhXuriI1toICxXTgEbIWGOtHrokZAKyswAYgCzHHCl5pr0V9PZMXusuW2a7yEE4H68dCJ/6fZqlAuYZVcEKfkmAsNuxRO/86aVP4vpERpadyo2qU0qRnEc/s6HMKkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1muJFVwVq6Zo/jjPhDXVyUJDSNgtRV6bNRhjpR5Iqw=;
 b=Izo2ujesi2A1W2YR1coIpATs58/XvrvcurafrtO64nGq5c42bJaoZbxMrDsIHe4qBY97FM1JzfOayqOQ/pZC6zZqWqAJVCv3PghuOU7bmuuAZxe++sZuQvQXvvv6LbScFqcjDjEV/QnpoQwJoTARf1e7fbVkxTERVcCc3kl4R66wcz8UdSDSpbHYitXpHZ1yLlsnzOiCBey2VtQ9v85H2ZkBpWRS44C7dFezXBnr/UbBoIKTytbU9aHhIgT2kLPjdW/kgu5eniKV3N6zSvXS5yP4kWQucJ/6T23hcIghy0BjPepj5kZLC0Yay/p3lV1KI88lMIV9shpb934JQQuUXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 10:37:51 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 10:37:51 +0000
Date: Mon, 12 Oct 2026 13:37:42 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5] net: erspan: set lltx to avoid sch_direct_xmit
 deadlock
Message-ID: <20261012103742.GA673951@shredder>
References: <20261008093824.119453-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008093824.119453-1-yun.zhou@windriver.com>
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1f138f-b73d-4fb9-0c2e-08df284cddc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|22082099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1aAsnJfkJktdCl4Cd5id4oKDU9jiZCjAsqX9n/egtP00V/XwSOCCvCt8WlM2bGLJ2oSregVVfUNAU8k8mYd34tImm5um6w+haHAlXX+aB7Omsp/beTTvBiYmYuA03zdUzk+CopNVIk7a2yu3XE1Glr1Y1Yg4M58GpSHYGD/kljOwfDcXCMKBMS52PECCmPz/wJff6ae9jNNXsGk7bBYXL5BQFpc1WCsfpRNokLaqK+DBH70L3JXoQgZEPX1LF/okCeJTLYgk/t44TpfMjP9v5SnqTtv6pB118nLlxC9reMzwZtqoIlzygO5zQJ2sXaYyuavhxrpmcVO/VbJKYgwe3v7K7AyIIngNiRyJwn+T1znpS43L93gW2h7knDElQ3ZC8XNS4chiHBvO6DHdlJXQG8cxJYrz+hyZceVsrGS8knJdb2+Cb0hKR214and0IpfzYr/yb/PKxurGCaBxIamGum6IcVqcKNwkL0aXzyJAHk+OIQQdMVYt4OBehUpY00m32G5Ic3qeH+e777Kaq6PWvpU4sKWcdDYgbyT0I4jLcS4kt91vPxed1x8j9+DXbpl5Dy+G2u8ZDxKs3Es2H6Xh1OONFN4E3OD9SFecWdkoQ2vJF9q3H9elpt/Qjrgg8Yn6M61JSsE0cb1pKklC1HESQEmqy5rCdV0crs+If2MQY9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nm7dsua/OvJ29NwH+MgC4iq3/l3Sg2I1gneFPJNRF9aMtdhm7WEm44fYq2K3?=
 =?us-ascii?Q?1kVx8GN0SEF8ODbg30MmoLXpeu1LjPHZmTvwmq2shAaYS55zqiwsrLxf3jfB?=
 =?us-ascii?Q?0hog1OUDk8YHZuHmnE7bcrO9fbwlv8M+XCI/vOUSd2wavvLkzYgKa0GmttE5?=
 =?us-ascii?Q?4ZbDUtOAqPD4SC9ZmM1+LebBg8rManpNAb0m9kTCJqCStFngWhVb52yI9/ay?=
 =?us-ascii?Q?XnRQBO1xjgmPRkmOZa7TDQfD4IFB/u14iAJMzbqCv1mE8vxBkHiNxJHTP687?=
 =?us-ascii?Q?9IZUB54TayVM8AxROXCPJhln32HdzEN7eg6PSGzM2iInzh69kqCtN/I6wyIP?=
 =?us-ascii?Q?F5OWzKW+kMCe9cef8zAKKv78ojLxVGyzFlYAOiAD8METg2XFWoa19sdm1D3x?=
 =?us-ascii?Q?kO8CL36uMbs1JUjuXAyxXtzcKRNtaYnuNJGVaCp2Gb04TQk/UaY9z5dq00t3?=
 =?us-ascii?Q?3Km3fchdEkaMXPI18gDizHJf24mz199p2m8yEKq8jb3fg1QGiXN4uiYR2GwK?=
 =?us-ascii?Q?ccmTt83K8sQ2isDK/8BU4Cj/CEgNPcXdk1aAmxVUoRlT5YnvcV1X2B6fMdfl?=
 =?us-ascii?Q?DYqmV8cmPIOZ98AOL4ef6nY5CuD4lJlZpYrZRb5C+AgNU/8YXLU480nk3Zr8?=
 =?us-ascii?Q?kBfBWpb7rZsjebms7nY3Knj6xgGDALlxFyeool5c88LSrhJpeT834UyPduFb?=
 =?us-ascii?Q?Ovq8FDiX9uE88Fd1eZyPsU5lT0IUOuMh091WnD3x13qfhaVA9f7zj1g0jBty?=
 =?us-ascii?Q?zngrJuiaLSNm/6CBp6hldufJONG/OsvphN5dZFdarkgGGf+pHOud0mtH+sne?=
 =?us-ascii?Q?1dAxkjpaRvHkP7IquFrqN1xCfIquU++nrSgnYIXwmZ6t89vy0354/XT9n9Za?=
 =?us-ascii?Q?ve9DWlQZESOcrzYo3IZN4al6gKN9woTsXAbL8GJcFy5sT9W05gFtMdAjLRZm?=
 =?us-ascii?Q?+xi1Nb1dFu/TrY3ySjr8WH7WRc/QytxJemBJkEbgBBeufhtaAWh9vNinpG26?=
 =?us-ascii?Q?w5dSNwD/N4uUFCmMzA8a+fi/9V5COakyZ+7mqDg+iYg4vup1O3bQTMYhiFjC?=
 =?us-ascii?Q?MyX70j9OQNjtXw1bqe0xJOAEP6eehS+OytI6Rw5FzKbVSjGaM8uNm/2tHICw?=
 =?us-ascii?Q?KglJ2KVRi77RLQwgB7Pj5pi0BL1UwL4TIWln/r6scJ37W8pNTYpq9dzHrR5v?=
 =?us-ascii?Q?S7SLlOaK39o+N2R5t63peBnuUC5o+yt8LNvgAq/ni7xNe9wZsA4LN6k4xXbA?=
 =?us-ascii?Q?esYvgaO5RHulvhS/NKGDq5D4mpWJc0xc4QleJEOeSv3TPyAvH22hcS/ynnrR?=
 =?us-ascii?Q?qFyQDVjp+pmHU+1qKFD0CXsJU0b+Gz2Lvn8IP0T3CaS0Seeb47RMTy1tm8Z+?=
 =?us-ascii?Q?TgLhYWz7ypgiLYf28ohP7FKC3gNrXUGMh1FZ4CeGdfquP/RniudaHSZroBvL?=
 =?us-ascii?Q?KQopCQzNx9A8CO1yy/kOZ7kb2V/WxwIcH1Ic7AuGB2/ySVX4+Jg5Lcjv8oj4?=
 =?us-ascii?Q?j7qUEiR7oKysrvnqcud2oaOoLpu4E2hNmSBJjWPUA3PVXe1clk7NsaQr+voI?=
 =?us-ascii?Q?E0WN4aKL5L6+HpeghOUqyV3Byte1EoPfcag7pMPNmfWpVGltd2Wl/phBbxB4?=
 =?us-ascii?Q?FEKSGIDBGEAvds04Qxa3Mng1I+4Hjkhdd5uo+Lp/x1DfRroRElackt5eDuv2?=
 =?us-ascii?Q?FfbwjSIpkoPZT8e/MWa3QeHmmj4srorrVLkpdly3Odp619Eu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1f138f-b73d-4fb9-0c2e-08df284cddc4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:37:51.4587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmLWmRnnSVdC5U50vsV94S00J5ho6/rn1eUSLA9NW2lwHGKB0/qmTnajRkBAe0atiHJUIrCx4arPSykkaYiQTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375

On Thu, Oct 08, 2026 at 05:38:24PM +0800, Yun Zhou wrote:
> The ERSPAN xmit path re-enters the network stack, causing nested
> acquisition of _xmit_lock on the underlay device while already holding
> the ERSPAN device's _xmit_lock, creating an ABBA deadlock. This happens
> for both IPv4 ERSPAN (erspan_xmit() -> ip_tunnel_xmit()) and IPv6 ERSPAN
> (ip6erspan_tunnel_xmit() -> ip6_tnl_xmit()):
> 
>   sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
>   ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> 
>   sch_direct_xmit [lock erspan] -> ip6erspan_tunnel_xmit -> ip6_tnl_xmit ->
>   ip6_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]
> 
> Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
> This is safe as the ERSPAN xmit path has no shared mutable state: o_seqno
> is atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
> o_flags is no longer modified in the xmit path since commit 9958e69b9893
> ("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info").
> GRETAP, the sibling device with identical xmit structure, already sets
> lltx.
> 
> Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
> Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
> Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
