Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C873496D51;
	Mon, 12 Oct 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818012; cv=fail; b=OmQdPxGVHi0NuRvcmBVe6Yv+TVzkQUgxMjEisPS10TnKHXRQMI6G25UCYDkzRkJB5taTUIAWhzMitHlGRvg7Nl5ndlZlppG/mDfqYd5kCCq0W0lp9gecjSV6muw2Drqla+681jMR6M8gjqdW8uCf8wYhhBkd437zTmWzPQJntQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818012; c=relaxed/simple;
	bh=cqdUSbUPi3lBzpnVAtKCol373UwCfjgwf5xtEgapVmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e9os5xQec82h5i2an+OUOq9yE8qoGX7AZRpJuFTQPdUCshrqJ2KW7VGGCaWErpUnUGFxgwuFhAlZFQ46NG3j5+tQerpWH6K+cXjMVUvi0zLHbnhqWUOkVFG9rWkSBxKJcULNdECuw+/z4LQVQqa4ilg7XSowe0Cu4Z5fZenh648=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqfhBRr+; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqfhBRr+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQyjx701n1fD/Ir90YZrdLcGuPej2RI/jCKglXh6lnfXNk2dVYXACcVwtXg5gnSYUNjqhXhBEw0AeC/sdDWCHAoY4FlIn4AJ1mGmrPUOq4qWwUXzyw+Hc5+DPKeeq3q95OCQRciHb05zvBLN3YdUfu1JcHAcA+rZBDWob9b7Wwpf7v+dK3HeWJCn277CP2Y8ywn5CHzNgLF+li8N4ZTmCxRo1gbA8uXFBNOoWuDvH7OeldE/9hz9+8aFW8BhYmLUNKB0eorjJVZuCMk1zU4owmM6Fc9jqWRTfbE39pJBBok4IeWsS63YBL/QTMpYKnLGWk/vko6qYa9xtPv2j5jQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmPtDOIytOJn+vwptqX8mWPghapg6EgNK6QP2wx7Yd0=;
 b=ub+k/g4f3uaJFCkm8OE/gAUShZRdRvj4Klzkx7zRnvFA3oKrgK635hSH8v4F1qHu/YHH37VZIbXQuOq6ID+BIP8RaaatuhRh661+iXNomTb5H1VngOXEnuLT9S1XGyFKfRi5qoY/xhKIz7zfDMUoE2TL0BDGHpRe765esfm6SH852kph4GpA7EhuQc/VBkMaMZdWqcPBLe9T2yt9rtQb6oknLNBH8OHrFOzJpRWCWHEgEUkiM5FpVZOqCL5RzOv/legNqUQFR+ik6PRcJ3vKUTm9roJ2oOow2gex+oKdhy+rUM6V5Qcn8kMDgUDD6w5XiteU1sbHB/FGwhNt0MRFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmPtDOIytOJn+vwptqX8mWPghapg6EgNK6QP2wx7Yd0=;
 b=oqfhBRr+MSEgrc2NKU04g5IsqJ48kxb0HCK/12xj2Rpy9gamOE/zb//GfTRICVJEzhP8ZRdHebCSCo9lkmDFftb2hJceTlCgz9C2YEK1Hj56wM3WNrS52GRxaYIGTPap1uTclSsq0/CzvdxlzxeE3BDJNwgJykNDSw7FIRH45q4AA+HDx+Ws6XgqMu/ZegjdajBEK7Smj6LGFidxEKmVPtVK2YxgUpBvnEtq89ceSVtVMCdPh48FKoQb2IbNhSvLeobJn/5YPkTCoUBHRq0ouMB9Ap6aWO5o85SF79ev8ExdnJY1HTCLmgzoFD+hFE0Q/oxiajYVKzDVS8M6oRN4Pg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by CY3PR12MB9578.namprd12.prod.outlook.com (2603:10b6:930:109::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 15:13:25 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0496.015; Mon, 12 Oct 2026
 15:13:25 +0000
Date: Mon, 12 Oct 2026 18:13:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: 4ncienth@gmail.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] ipv6: serialize address publication with
 device teardown
Message-ID: <20261012151316.GA798355@shredder>
References: <20261009054042.272944-2-4ncienth@gmail.com>
 <179161099408.434549.14449036924552933828@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179161099408.434549.14449036924552933828@kernel.org>
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|CY3PR12MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 9367e165-fe55-4101-6529-08df28735cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|261009223027099003|11063799006|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	3mOpTrUGGAyLbLTzVy9duqrk155YTb44+ndmV9vg0OrmgJ/vaysHs3hNh1HQy4BJP+zm4sQSDZgOzWPlgLtjkpHQhNnCTl8JSsU2iNA8lEaXDf3G81Z6V2y49N1i02N/fkRJ8D/w3Vy90MsVpA/FCxPDP8NS9/xpQtuZ5aobVFI7MyVNRd8gFbgD6yD0tx6ueFLSf2tJ8wUg0UDtxfhe2hNIPCoQBmVU5gjqTmf14a5ah2b3xBd7lydTPVfPZgC0j6lON8IBAh2ogZxTLsmQdjmCJWLQSOTFCtYzd167z8fDl0v9XWUYAggAs3RlGAVV4uw5WzbJss3eG0jp4RvlKLxiPjNUZUO/dDcm1eJyMAS+R655+1kpsq4OZ1xysNN10aW1Ghet1e8UorACPCcYOLxLxieZEgKaBTfzTo/palAgu/fJyLBkih3utGX4sjbrwPYTtfXWqoR0+23xfour94wncKEblnHH2HzEd0tICE1ugr7cocNqObmwM1UfWMPKrVVvsgvqgBFJDG3xc6nG0n0a9SoXvwWxB+9pXJ2PjUDtTlXRQYb5ZiKx9eniiPg5Lv1y9NAsAUOpOik2nm0bshj5tabXg2RJrLPkcOb9yEsvDcT1XDYSJ0FhixZsZuBC/3D0GNx72x70Zgaj/6LBMupUGyt4kI2KslvSbCcLOPk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(261009223027099003)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FE21y8zlKUiZ+5mADmV+TPwakaWrjL01c4cTLBhOhMVlSkc1iPxPOlEoUHm9?=
 =?us-ascii?Q?y4R62p+AIra8vOhfPJ+HxPf4nYgqcW+ZAgipe/oem/eUSuptCDOtGLmk03y8?=
 =?us-ascii?Q?q/Bzy3Nv6b9gWKO3YpgcG4j4LhmBouDrZULcFAM2/HEjgvDTHN05eT8ftDeG?=
 =?us-ascii?Q?qRrol6Zp6VwNadT49XMJmCk2mMWoL8fYts88+OJmczO83xm4fmBnezX5xpSy?=
 =?us-ascii?Q?T5YCHNze5u2jn585ifJPjg896VQBm5NJWBglRDKIcfHUDL3cCS5Lj7sXCgfn?=
 =?us-ascii?Q?kUEk1g76O9xCtw3DPO3cTJ0O4EldwG4LfjRnaT0j0GVYLLhJmbWzEKBdxvGj?=
 =?us-ascii?Q?feNunpoPYkZLkgiOgxAdnCxj+5kVo9ymmMbyjHOiXRPFaWvNpHS+PdBx8Ni8?=
 =?us-ascii?Q?3+wJm6A7HlE67mSOflulZZ17M+EXIBlRsmunIMOnoOILf+/neW/5tGVnPnHM?=
 =?us-ascii?Q?uURwQPp0rLcCnI4rsLLPGbzdxxgI4bGSkBHzthXaNINChFoPDX91Kd2c9IOr?=
 =?us-ascii?Q?A7Eyiku1+I/9Z2RByl9Vj0Suk7WxY5whq38te5FzXRgxsEC+WKzAZkLpzi/E?=
 =?us-ascii?Q?gzahTF0NChOzf/wdjuLhdn3teytVJZScl3jKgf76gV5NJYeV3aMcON9XZuzF?=
 =?us-ascii?Q?jchwQWSx4NU5bmC1pwF5dwPck4AkF8WjVxSjvAsQ/h+0pwsJUm3mQLE5cfD1?=
 =?us-ascii?Q?LuKKkb4CYSWdbt08LD+KndQCJla5PSWOZSGTNIf2jE4uVFFM3FK9RuMbOmAp?=
 =?us-ascii?Q?4RUDiUfd+LV1tOa5rsg6jmixHqVtbvZrTTWGqlgNJxaoJwE+UaOaFXAgq6R8?=
 =?us-ascii?Q?2Zvwu24OafykGSbbUHoE7YtpWgcNXmgl1PtxeSnQXKCccaNWBsi9lEhbxpha?=
 =?us-ascii?Q?KVQXpD5prpv86dwHiQf2O1fFeuZ5n0DoiKOOGJY83uBqmc8TSJp8ImQDOXRm?=
 =?us-ascii?Q?EeTzHgH92wQrItXd0QBhqE06C/xBJBqY0AT3FaKJ1burw43DeclkMaO0+rix?=
 =?us-ascii?Q?bEnUMnClr7CmTTrO5AHBRktNM5Ye+zgdY8RUTyb26JhQ9ANaOq/qNsM5aSdi?=
 =?us-ascii?Q?GG15YiqzWRJYrLIDdCsMBwo0o4X4RZPAsTmC4yKmYShRs6kqL94O9tC9QRtc?=
 =?us-ascii?Q?07kVuVtgNiElP35sPjRfx9sSrLA79VyLt1Q3VngieQVRwe5FPhMb3yRCDjtY?=
 =?us-ascii?Q?zkAm5WhR/O2beK0u0KIhnipqIzX+Tg0mxRQp6ew4rz54lfwznS5kHlDvchcY?=
 =?us-ascii?Q?3I8onQ1PyOkXL6p7FxIMFhKT5Ke8uqhE7ofhZV2N86hcwikp7TpYL7W3rno6?=
 =?us-ascii?Q?uaQrU6vUbhYt0UseorcC3tD+bvEymPtN0jGSahWGyUwAv2XULvZuoiw4zJ6t?=
 =?us-ascii?Q?LnV6DWEmpkuOUUb4oGJyBXjTxptbVbXcu+0wQDLcoSEIzGJi4zMutvsVXlbR?=
 =?us-ascii?Q?DqEt1pULAcSlhzUXMU81HOtXHzhjS6JtJhz53ixC4Tcm25XxMryiHuysHXB0?=
 =?us-ascii?Q?nNTZYtFB2ch/r1PKB3BJlytncj4MFVgjgKzcHyS7kxZnisuaUzuYqi/M1RWg?=
 =?us-ascii?Q?o5IXTXyo4uM0Httc3WzXErApUMW+yB+xtOvBksO+qma+UzO2ofVPW+lOecJ/?=
 =?us-ascii?Q?nJUNs/uLUp5BBFCLliMiBHYb7RLXpVzAB7ugihU6BILYZgTkXdp+QsUhG6YA?=
 =?us-ascii?Q?8rNzPtPM4Jtmi/WGW5vo6tSbMU4u/XxBQARRVH6fHKVurVAH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9367e165-fe55-4101-6529-08df28735cae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 15:13:25.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x90p/haR69vsd9YA0/O0x10wYE2lTJaTStJQtS99scs2AvFg7B14HotwpI89Kq3d0n+SXAiT1TBo4lYqL2eeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9578

On Sat, Oct 10, 2026 at 05:43:14AM +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. The
> recheck above does not cover the window after ipv6_add_addr() returns to
> addrconf_dad_failure().
> 
> addrconf_dad_failure() runs from ndisc_recv_ns()/ndisc_recv_na() in
> softirq without RTNL. For IFA_F_STABLE_PRIVACY addresses it does:
> 
> net/ipv6/addrconf.c:addrconf_dad_failure() {
>     ...
> 		ifp2 = ipv6_add_addr(idev, &cfg, false, NULL);
> 		if (IS_ERR(ifp2))
> 			goto lock_errdad;
> 
> 		spin_lock_bh(&ifp2->lock);
> 		ifp2->stable_privacy_retry = retries;
> 		ifp2->state = INET6_IFADDR_STATE_PREDAD;
> 		spin_unlock_bh(&ifp2->lock);
> 
> 		addrconf_mod_dad_work(ifp2, net->ipv6.sysctl.idgen_delay);
>     ...
> }
> 
> addrconf_ifdown() can run on another CPU because of NETDEV_DOWN,
> disable_ipv6, or NETDEV_CHANGEMTU below IPV6_MIN_MTU. If it snapshots
> addr_list after ifp2 is linked, it can tear ifp2 down completely before
> the spin_lock_bh(&ifp2->lock) above:
> 
> CPU1 (addrconf_ifdown)
>     ifa->state = INET6_IFADDR_STATE_DEAD;
>     __ipv6_ifa_notify(RTM_DELADDR, ifa)
>         ip6_del_rt(net, ifp->rt, false);
>         ifp->rt = NULL;
>     list_del_rcu(&ifa->if_list);
>     in6_ifa_put(ifa);
> 
> CPU2 (addrconf_dad_failure)
>     ifp2->state = INET6_IFADDR_STATE_PREDAD;
>     addrconf_mod_dad_work(ifp2, ...);
> 
> Can CPU2 overwrite the DEAD state here and queue DAD work on an address
> that has already been torn down?
> 
> Suppose IF_READY is still set and ifp2 has inherited IFA_F_OPTIMISTIC.
> Then addrconf_dad_work()->addrconf_dad_begin() reaches:
> 
> 	if (ifp->flags & IFA_F_OPTIMISTIC) {
> 		ip6_ins_rt(net, ifp->rt);
> 
> At this point ifp->rt is NULL, and __ip6_ins_rt() dereferences
> rt->fib6_table. IF_READY stays set in two cases:
> 
> - the NETDEV_CHANGEMTU path calls addrconf_ifdown(dev, true) without a
>   prior NETDEV_DOWN
> - the link comes back up within idgen_delay
> 
> Otherwise the address is left in state DAD or POSTDAD. On the final put,
> inet6_ifa_finish_destroy() then hits:
> 
> 	if (ifp->state != INET6_IFADDR_STATE_DEAD) {
> 		pr_warn("Freeing alive inet6 address %p\n", ifp);
> 		return;
> 	}
> 
> so the ifaddr is never freed.
> 
> addrconf_dad_start() avoids this by checking for DEAD first:
> 
> 	if (ifp->state != INET6_IFADDR_STATE_DEAD) {
> 		ifp->state = INET6_IFADDR_STATE_PREDAD;
> 		begin_dad = true;
> 	}
> 
> Would a similar check under ifp2->lock in addrconf_dad_failure() work?
> The PREDAD write itself looks redundant, because ipv6_add_addr() already
> returns the object in state 0 (PREDAD). No later patch in this series
> changes addrconf_dad_failure().

Looks like a valid issue. Please fix in patch #4 in v4 with something
like this:

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 7bd0e8820abb..7cb156ddc191 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2230,7 +2230,6 @@ void addrconf_dad_failure(struct sk_buff *skb, struct inet6_ifaddr *ifp)
 
 		spin_lock_bh(&ifp2->lock);
 		ifp2->stable_privacy_retry = retries;
-		ifp2->state = INET6_IFADDR_STATE_PREDAD;
 		spin_unlock_bh(&ifp2->lock);
 
 		addrconf_mod_dad_work(ifp2, net->ipv6.sysctl.idgen_delay);

