Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6DD531
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104688; cv=fail; b=YISX8D78WDIHEuqCL+MaDrOpJm268GLUE0ip7SvvmS8uufUEaTB5YVzDAI2USbk3RDvoqUmKzD+8fxZHGzUCySsDvkraRvSA8XxdEpEa4+Tn/XVjsV0K2A0xn4vxaPbZTbOrUqqlEvejxgMMEj0iOLUCWRFmcHsJXP88o8aHhEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104688; c=relaxed/simple;
	bh=+ZF6Xpq2OTGsXv5i7PPpXXJ4Srk4c5PWCrvx4rhzxs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M1bfJRN6vL1NXM5AMprO5KO/40yGAE8z+T3jfblGNH0ElO4bZiq+GOs23WmOPF8pwEvnBxnAHEk8cgY8Z1nE3UXFLtKrnyjSc4Ni1PbOVaHnHIgeAvITH/NrF04CdNLf2VAGo5Z3b2B1QEf9MR7U/1OKgOKHEQjzPPiDb/67ywU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JrRT0lvD; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JrRT0lvD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC7mPaut8IRM7kU5UFqAKNh6wAxp18qdPjSgm3M5/k9fwQlksttZhy35sUTsc2ZWSakkKnnSCzd0B+xJYttcDW/KFe/yCYtc27FTTPGVnUHZ/0eb0ChV74XMNs2NHtM6KIU4ds3ijgAl2LlhUk1ZOl79Tc1E6hXZvfHe+YDHBTXwFPjIgPBngOpWRA/7810Vol5jye2ZojLSwg+3LUM9STIqcicvrvpG/fzC+2s7pM6VvFea5MyCxLE6EMcEBpo+p4IbFN4mKXQDitzUyBHzWqeE4E6xMlP+xLwO7Og4PhDgPn2gPtrH9bIWKXYmUW6IvNTSW8yXedHU4IFw2Vw2GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/0DfDQ35yxqLstwncL1jBwnFGQh6eSW+LpUq7WggvA=;
 b=TWUVdL2o+bFofbXWW5d2Q08G9CSaFstzpJ3r1NygSLzaKBRLZqLGosUMz1ljNYd3w1SvISbh3VFm0FAuKZqxpyCnGucdd9kW+N+LskmbbsA3el1atc2hko9lqRvMQo8iEyKamcIBlRF+Jn3r1/EBKu5qcRa5y/Qxwp28Ivutk+N6MbZBL7gUfIMMEUHe0RKiYOycGMxITx4hfStF9b0+q+CkfEJ5AwYc0NoKhVpgI2rDhBmpe80ecaeoqlc46RpPVnrKN6kp4pPmHKuflObCgmJCkWm2CiI6XhTcsVH6Kt8h4hGgLD7GtW8w/+jDD+KyeO1KvZh+gI2y7ToGnlRyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/0DfDQ35yxqLstwncL1jBwnFGQh6eSW+LpUq7WggvA=;
 b=JrRT0lvDvRmPZ6MSuJgaRUdw+Zb6kBLRwSVZLS5vCwDLG9KgRI+VMyBMjyO50SU0xKepfoyaEcMuR1oGYJ4pyFuP4pM7Ydk1PFlY1VaqiqRzC64nBhozUsmUXWOQ77M5RPkl3IkbOFQ+ksLnTUMQB9KyYOGC2jBliFrTnSpivAlLRFEmrOMykDYWNrZUhOidgHypxgHfimZYgSHqicrQNM3+ei9QAM5TXMGk1K4jE9dU6eWH/EW4i/JUbO8DZKgRHBfGO5VpcIcnml5uURtUN4UvM2R85WtbKgyrSL/2+1oAvJMuqU1Y3mP24uPtffgiRLFB2vQa00ayZgzpmWrzgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:44:43 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:44:43 +0000
Date: Sun, 30 Aug 2026 18:44:34 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH v2 net 2/5] ipv6: mcast: use copy-on-write RCU updates in
 ip6_mc_source()
Message-ID: <20260830154434.GB2974032@shredder>
References: <20260828084531.1826790-1-edumazet@google.com>
 <20260828084531.1826790-3-edumazet@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828084531.1826790-3-edumazet@google.com>
X-ClientProxiedBy: FR4P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::11) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 781d449c-eed4-45ae-c86c-08df06ad9c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nJvlOeFoblBUHk2IlE2vx0O1zlCPmRlA6Y5/D+bL2DMeMvMunjIaqQ3AADHvbDSfXTPyn/X7TZ8Ko1Dqz43hU0r3OezqN5e4mhAd08NSvqFs1VLn07+STStIm/U6WCo8Gt9fgNkF4Dr066f20Won0LwDkGVZdCnaRnl0Cg+h7SSwV9W5eDvlaImrglZNNLV5OIfQvp1j8S7QCFMXxA47Sk3VhmKFNmnVEqCbvTTyotjGYrjAZgQEu9zK0utfualTM8Wjlq/dbjr4apaEV5xb8mmd/hHr1Gcj3ynfDUw94yCSeUEfCg6D9lfMvYfLCEP5pcpfc1B82R+yxrM9qJVQMdqoZycxwN/MfZMbQ+9o/O0BtvyH7dqwPrVyL+N9vg66yD8uoSGD8Qy/L297UJ66a7cTMWvaAOJufDAHS3JamVGxjTtXaZlldkGY+JfJk8gdhSgJZ+y68m/VbNVAXGZGD2X4sL2Wfy0LdhXet1uYn8QcaCgk99RTBOWMwvOXRleS/uAK+kv5pj8apbqnLTR0bA3vTAChC5HFcNlriUxhBl1sbj1wfqP4+YiBwj/cpoQKMQSgGjzYxJXddpbHnyT7NkeOULCE0kd/++CEmeN98yq+5Vo3EVAIIrYjcP0jJR/8tEDIt1vw3gJ0vCMG186M2rexa++5UL3fGhAsjYxGpms=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1yqdjgbyDGBe05P3dMxeoQ/MXeGmNaM2IXtaJ3nKUg12Z4XBFwseUVyjnO6d?=
 =?us-ascii?Q?Pi3YHUBmgEPZRPz1pfrQ38jsmafq/YNw7tuLNmrJWXa8DD5i4ZKMAdPZIuzo?=
 =?us-ascii?Q?dD0uAzLv5Iv6CcvM9iUnHtCW0iLkOdFZ7PdE69nXqlRPZeKZfE1bNDlCvwxO?=
 =?us-ascii?Q?FV+h0H3WQqyqiCB7BCFB39Eglp2isKU7TzWFjs1sLdbOYGD3bnWJe0AL61qI?=
 =?us-ascii?Q?+CFByNxE5R6Lwe3ghVWy9eXxL7xYAbxTFvjNc0FwdXSbhSV/i1noG+v3AlRO?=
 =?us-ascii?Q?/Yu+fCVgDya4EObb799p917ug88PqyjD5AUY+Bt0ryBq5fErDp6N9RLe0H/E?=
 =?us-ascii?Q?j7NvY2E4xhvbmaAJoh1qOHmUW5f9L2gyenDQUiju44kcTksLaqbSfj4ddBmg?=
 =?us-ascii?Q?DBMyRNCnCUlVF+26haXROmda/YmUUL+N+BW0VK98XWyv9ctXfX7FLcxOY+wr?=
 =?us-ascii?Q?CnXXL0QrzyJLIX7/NiSG3+Jyh6bkWWqkc1bsu3+j9GpOTfAw8jDMaUQd3097?=
 =?us-ascii?Q?avztR5p2tkfWnXlN8OoDRKNllRF2g96IeP79J8R1qQm7vPtlcYX2i2PyConS?=
 =?us-ascii?Q?8mvahvsP9GBqJFDUTBqD4mKnEY8dBiH/+eKPoSkBuMh7H1jih/kOdJCcjIxB?=
 =?us-ascii?Q?R7f5wJ8/K6xa5fneWLSO1UtyEGUnY38JBAibtxcapfnIGK3HMoGe9C9H83yL?=
 =?us-ascii?Q?W/bCRw18LY86l1Tku4lbGDWLVSIqPWCEbH++nfx54QI0BkYJm7exxGLrb/Ww?=
 =?us-ascii?Q?eso8jxcx8hhvBgxLHad9TEEhZZ/9KOSYIFx6J2A+G/AN1jJ4bfW2uMU2gw+e?=
 =?us-ascii?Q?inKWOhHuuXSjcZ6k0sw9m40Dkq5tegHvdBJVk44X/GWOESTOe3U39jUPjqkp?=
 =?us-ascii?Q?eWee2A1pLFZDimYxEMlNMb3uqIPcFPJRHC0iCikzPNzHtwx+oTQjpMrZzUQg?=
 =?us-ascii?Q?jD+eS2jcNXVxjosUDPeAGLL41hzP8d2ZLx99xnnEm64OM9wyBcTYBqoxymoD?=
 =?us-ascii?Q?7Mz98+TWblxWePlspmnnG9HwS1Uf7bZkrf1aJg4Tr4+7XxNFXRCGTV6xBZ9u?=
 =?us-ascii?Q?aiVWPqmZNMCvrUJ/6Rlv4wAF7qv0vOmxHEXnkS3gvPf97wl1zj07fVHWKbQH?=
 =?us-ascii?Q?ga7DtXP23KKWxU1FbBKB6RUQDy978VssUA0NPwHr/N6XxqKdkyh6yKNUy2I0?=
 =?us-ascii?Q?DcR98LdUeYS+jyi8IvbjXA5uY3RVQJzdtl1wggSsA0/PnSWxvPPq1CK/ofLZ?=
 =?us-ascii?Q?UpPjW+qGRqgt//EAyeTNib+r+QKnJxo6FRqJtukcXT0YVA3T7SfSVSs3buuF?=
 =?us-ascii?Q?RslUk+Lts5ZqAXyuhf5kswpV18gx6HuMTqg2irZZIzD98L2398NA5y+2n6FQ?=
 =?us-ascii?Q?I4ETQEj57LGjYMFGO/c5dGllEPUt+ua12XtDl5L0hkFmJRMXrFWQiWOWPOHt?=
 =?us-ascii?Q?NGGM6hkvMj6lhOUh45eSrO5IcmgxM/ySPqQk2TERhScPNqzOHFuFVvBAxa78?=
 =?us-ascii?Q?BZtIYXoxuojFfHq7F9F0Z4n7pW3BrhHhKfTrXtCE8pDWdNcygeKr7PFIHG6T?=
 =?us-ascii?Q?Wukddgch+kwM8YBv+zttVOTaqXTufC7jLu4cds1zWulDaKC4729PEjZ1eneC?=
 =?us-ascii?Q?CAy75yLbNIoTZdoEFBdDYbYEebCdfYgCLEGi0u+BY6BYZvukEFGnEyDcd32I?=
 =?us-ascii?Q?ZhYLYAfrKeJuo0SlJZ/5IbyYsnxfpgKV0GjhD/on6VlUpT6S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781d449c-eed4-45ae-c86c-08df06ad9c9d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:44:43.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxIqce01/lLEhCScyiBtXInrVlKRG4COV6dEEGHMSilo6xx5QO0dsymbh+8lMOvUpGD6b7r7ybh2DGCvsHdEDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223

On Fri, Aug 28, 2026 at 08:45:28AM +0000, Eric Dumazet wrote:
> pmc->sflist is read locklessly under rcu_read_lock() by
> inet6_mc_check() during packet reception in the UDP and RAW
> multicast receive paths.
> 
> ip6_mc_source() mutated psl->sl_addr and psl->sl_count in-place
> when adding or removing a source filter. Additionally, when expanding
> the filter buffer, newpsl was published via rcu_assign_pointer()
> before writing the new source into the array.
> 
> Because 16-byte struct in6_addr writes are not atomic and array
> shifting is not synchronized with RCU readers, concurrent readers in
> inet6_mc_check() could read torn IPv6 addresses or observe
> duplicated/missed source entries.
> 
> Fix this by switching ip6_mc_source() to copy-on-write RCU updates:
> allocate and fully populate newpsl before publishing it via
> rcu_assign_pointer(), and reclaim the old filter via kfree_rcu(),
> matching ip6_mc_msfilter().
> 
> Also remove the now unused IP6_SFBLOCK macro.
> 
> Fixes: 882ba1f73c06 ("mld: convert ipv6_mc_socklist->sflist to RCU")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

[...]

> @@ -424,58 +422,74 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
>  			goto done;
>  		}
>  
> +		atomic_sub(struct_size(psl, sl_addr, psl->sl_max),
> +			   &sk->sk_omem_alloc);
> +
> +		if (psl->sl_count == 1) {
> +			newpsl = NULL;
> +		} else {
> +			newpsl = sock_kmalloc(sk, struct_size(newpsl, sl_addr,
> +							      psl->sl_count - 1),
> +					      GFP_KERNEL);
> +			if (!newpsl) {
> +				atomic_add(struct_size(psl, sl_addr, psl->sl_max),
> +					   &sk->sk_omem_alloc);
> +				err = -ENOBUFS;
> +				goto done;
> +			}
> +			newpsl->sl_max = psl->sl_count - 1;
> +			newpsl->sl_count = psl->sl_count - 1;
> +			for (j = 0; j < i; j++)
> +				newpsl->sl_addr[j] = psl->sl_addr[j];
> +			for (j = i + 1; j < psl->sl_count; j++)
> +				newpsl->sl_addr[j - 1] = psl->sl_addr[j];
> +		}
> +
>  		/* update the interface filter */
>  		ip6_mc_del_src(idev, group, omode, 1, source, 1);
>  
> -		for (j = i+1; j < psl->sl_count; j++)
> -			psl->sl_addr[j-1] = psl->sl_addr[j];
> -		psl->sl_count--;
> +		rcu_assign_pointer(pmc->sflist, newpsl);
> +		kfree_rcu(psl, rcu);

Earlier we have:

	/* if a source filter was set, must be the same mode as before */
	if (rcu_access_pointer(pmc->sflist)) {
		if (pmc->sfmode != omode) {
			err = -EINVAL;
			goto done;
		}
	} else if (pmc->sfmode != omode) {
		/* allow mode switches for empty-set filters */
		ip6_mc_add_src(idev, group, omode, 0, NULL, 0);
		ip6_mc_del_src(idev, group, pmc->sfmode, 0, NULL, 0);
		pmc->sfmode = omode;
	}

So setting the source list to NULL when deleting the last source in
exclude mode looks like a behavior change, but in a good way.

  IPV6_ADD_MEMBERSHIP(G)          sfmode = MCAST_EXCLUDE
  MCAST_BLOCK_SOURCE(G, S)        sflist = { S }
  MCAST_UNBLOCK_SOURCE(G, S)      was { }, now NULL
  MCAST_JOIN_SOURCE_GROUP(G, S2)  was -EINVAL, now OK
