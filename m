Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF01DDFE;
	Wed,  7 Oct 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391565; cv=fail; b=BHWsPPharrltYUK0/VAuYpe2oaG04WHNkwRbAK+HxsjLOywHglpxaYLhu1bi+V/M5I1MfG00cxQb/wY50/kKODv+SlD9nKj+B+ZlsZHs4SAhOMsH0joTkf9CGZEJ/xgYnNrsyNHT01HWmexybJqtLssXvhaX9oi/+K+obQ43TrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391565; c=relaxed/simple;
	bh=oz3junGvsX/Tu0rpKE85GAByYI9yqzzbVpJbAFcr5KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DxPO0I3rK7T9dHokYi6YPe+od7QfiYQvl+/9T4wBQoxCtVlwvoQdb4KXK81XM2lRYUPMM1ITV0U+sVQcLjfemLB/lBoBM789Ms6QCyIg1IkFamMplTSDUbkn99BBoTzAGaTOXp0C5iitRCsDVoGWyLPLBF7qhSpy38xxzOj7/Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ooAHKn+h reason="signature verification failed"; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ooAHKn+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyveGi4axmP5kwuEQJQL0xfBe3uVB0ktnBtMekUs+feZ0MFVwNBBI2Sve7Xjjk7BnwpEHqkueyACeNVrl6c4bRUs9xX9j79vOUYt0oelBtVqmIYAklCdX/vManJrgmfUcw0W6C8qm/QCh2IrPh2NAK2eHmkLczGOusUnNuFSE+cKUgvJRVFmKE7gwYSJYNN6bNpvVPb/JedY84dMMjmbTKCFxStilLEuZ45zkZQFBKD688VX5nnpZaMYXuTbi8lSGwshGWis3Y9g5FNd8h+Cj/+CjO4NpJtZmiN8U6OviSCzxt3B0L6KE2rkAxroDc8wy1ItJrOD32unbhItPPPiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KatEdh6nRZlGlJ5865MKOUD4RhfiOxPXEizt3JLqxVQ=;
 b=XU72PGDAqB7AK/1JduAeTUK48EuERnzj6AFalx1G4kQJL4ct7IBAytsugkeDrEciXE/vaVQ2F0Jgyg3gR2f9jrziCaRwMtzLOqFEPzCmidPyVwzOQyZDdKATcOwZQmUx9kYLxlrLT2wUZf+C91ewenT5k/VHKqMHIosAKpb4wz3J+zBZa5QGmFCQjr2Utbyj1TyX5tmMPLK5gkvlqNxzew4X/pXWoFPoKLNJNWEMGEFL3KKZVGxxuKmsyB1yw6FS/LsSTJNWTssrebA0oB8+icoQDHv/ata5zYKOI3mTxGqx3osb1ILvZaBVHl9l1RHNhsO21QI8fLL4dri3Bly64g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KatEdh6nRZlGlJ5865MKOUD4RhfiOxPXEizt3JLqxVQ=;
 b=ooAHKn+h5TrzoyNhH8WR6bPanOWBikbBP0j8iSweDxui4xfsluDcMR8ZC0d1ykbcOkOJNagwIBEVrqLd6gAyrcFlhBwogoP6VO0/2/IjKqQzNsNNwkOlWPuOYh9Osf6r7KV2JJDK2XM58adZmK3fNn+s0xhFtpKHqxI8he0hfeWKHpB3LfGLJESLWpUT06iITtGA/81tEOy68UMrB4KPmX67tMfXGJWGcrdta5Dle43LtP+IFXSeWoOs2QsAQ3WWoxwIAyjBaYCxtHd1W5L9+f+PLftGQ0izWF6sBvFt4Za6dIKzCOS9F1Q7pdtCcIJSQqwTigqxFGns83lVAq2I0Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 16:45:58 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0451.026; Wed, 7 Oct 2026
 16:45:58 +0000
Date: Wed, 7 Oct 2026 19:45:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev-bot+sashiko@kernel.org
Cc: 4ncienth@gmail.com, dsahern@kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] ipv6: serialize address publication with
 device teardown
Message-ID: <20261007164548.GA1153540@shredder>
References: <20261004183639.3773498-2-4ncienth@gmail.com>
 <179122559913.434549.12720841717630168470@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179122559913.434549.12720841717630168470@kernel.org>
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 546e3ef5-3537-4f80-8f89-08df249275fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|260925022911599003|56012099006|260925021311599003|10067099003|260925021911599003|11063799006|6133799003|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rY8woA0b8/edrYmkWscafvqK0z1nKHw0zfP1JbZq/67YoeMyRqZodP5kKuPpKdMtY62u8UL8kX53nG1vFegft14UurTeTZIFZXly4cbWN6jE3YPunMGFPg7gtiXi0SjHCWLNv8FbZDsuO4LrvTq68RnZzPxXdf70L/A4UJbciB3wgvWZ0+WI+c7BAQCAoCzpUTSE+xqItxi4kkuy/4G5c++Gb0H6emwBNDt+Y3BaCuoQGdBn1t4AfOT9CKV95gbZXWGnQj6ukTm/zTkPQ6dbU9vmsUkwv1N3CpCRTDFddw2YpfLYCJlcmunk73C2wjI1JawPoAI/JrO1WqwikIGtI8vunpoQBvJ3fZOdnw2rLae2H+ttZPnJ404+efI4u0UPaHTwJmy0MP7iPRKLSMTy0Kybs2YoKZY97xjSbBr3GbFzN3VyaCDYTxnt1D68ZqbilANd0jsco7e6qQePMiohsB1RKchE8vbg29VOupcWIPioQFftfirIlf3IpN44LYZqZoNpHFHJgZYoAPgTBLn4MBw+kZrd5oc3vHF25GV0WDd7GZZcBSuC/AEaImvGdzXWxVyg3yXc5dFf1b5NMy/04deddaZcfDA+u07dJkwdMY8Bxsuh/XobKXd2k6FDIL4UYPJmzW3NCKhMK/tW7r6GoKd11wyV5xaYvJdKIwQB2Z0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(260925022911599003)(56012099006)(260925021311599003)(10067099003)(260925021911599003)(11063799006)(6133799003)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ngko7ZK4QN7zWLwz8313/ez5aiale8kZV6Nb6JPycUpGzoOtsoxAC58e40?=
 =?iso-8859-1?Q?sHL2TcUffs3FAIIUarHuFh9zLBUPNyW99MXKjS+lFQz9Jbc5Y8atbJTNNI?=
 =?iso-8859-1?Q?I1PRxkzmjCpf/T2tGePgeAKf1QY8xBI0GINW+8kgSdqjUHZ+Vu1Fk4w9kd?=
 =?iso-8859-1?Q?Xx7evuHaavCUVjv+G8vDYjFjyQsaap4oWfo+iTgqs9iNkJovJFYXCT+g9i?=
 =?iso-8859-1?Q?V9+wQ1WYjLqG02HnKqY8qgDcdpnG+8Aoc7P30RzzfurTx2Gwuuvw+ghhRR?=
 =?iso-8859-1?Q?mTfkSU68GnGGwLHMSWpy/3ODKSE+P5EgQU5tuYHn2RvhSSRrDytCjr9+V+?=
 =?iso-8859-1?Q?H+09U5/rNMgNvP3xV82Rz8wC7Vmis5PSsgsS5KNDvoxunLVmpy/EURjVQ1?=
 =?iso-8859-1?Q?nYI6mZx909O2OXQofo9KBnp8O4qQg5+drDWQZbadQ2YanULoJE0c59QNnS?=
 =?iso-8859-1?Q?uqKRlbedm+dbClq6Qg8bs8b6O46aRk9giq3wl/Fv9Oom2uXMg6syyBVnnE?=
 =?iso-8859-1?Q?Kb/JvarY/e9aMab0Yhqn5pTXEJT9da1CEFkA2zLe2fRzDMRWjFngfXe3vc?=
 =?iso-8859-1?Q?dTy8+n3MQ+3SqUDp3Wxsm/F8ovbtWfRRX8oOan564RYoQCQhlEt3FkPKdB?=
 =?iso-8859-1?Q?kPKB1C+uYJFrQwA6P+BQIDkrW3XzVzzNC0Vkinl8QGnyLyTqEt5ZyZPxPB?=
 =?iso-8859-1?Q?VR4cvUe2UIdnMZnA+WX/dcZSI3eylEEA1unm4J24Mka1qsqkN45SMC895S?=
 =?iso-8859-1?Q?RO8avO1UzzaHbwtU9/i/1LcBHui9Orbhz7CNhQspt0O2n2xH3UHac+Q+Vd?=
 =?iso-8859-1?Q?YSBXLOKtycuyGd0zoEnZI3XGRuoXGm4+0maD0YFi6NZoaeIwaDcKThNVya?=
 =?iso-8859-1?Q?kvbyXN7y8siHKz+ARUDtZ+rYBF8aepXIj98yFk7CXYTgPDnP//LTWFcU0Y?=
 =?iso-8859-1?Q?YbD4oDadhHszFWZhydsrDCX58TMKhPqNoulAF99/87todhFxDK7eSIp4Yk?=
 =?iso-8859-1?Q?Z2r/bYj1RZONXGnRHk951tGX8vV3V/1WvKhu57uoH7qVuGzabdthZVALDF?=
 =?iso-8859-1?Q?pzka6iCve4ktWHGrHO3vRP4g3DfTzdxY2uYj+p3K2cSjArG6ZLOxZjuzb+?=
 =?iso-8859-1?Q?ZYOOYFmgLxsPYusEfjoE/A3C/GT4ZEb+118MDeBZoc889+WipKz3fKqog1?=
 =?iso-8859-1?Q?/JPN0+Iur2ZKPU/p68H2OmYiz41gLfYqHa1aU6mOKugD7ReqROSOiWm71w?=
 =?iso-8859-1?Q?Z1kMIPVr17L1eUKDNRn5P6ei7H39BqprsGjIM1nFzPKMc6iVF2yxM6l6IM?=
 =?iso-8859-1?Q?tmqEf1pNMHvt2EN9v8rgie8ancgrfIlXDJN/cGJ2hBUB5BRhkXxDw9aQNG?=
 =?iso-8859-1?Q?vC835d/i/emcecwG4qswRYWVGC6ZTWabtgjPRLbrQI39NPsdLGOIgaNb7h?=
 =?iso-8859-1?Q?iHzwGoB7rnMLYeqxdJ474PqswUWerg/o1yrV1w3L2sZZdYT8/zv+pEVzfD?=
 =?iso-8859-1?Q?vfsuaTaj5s/dVQnFyVtDJbRUJR6Yyv4jAAsv95+xnnclMjGn5h/fZSs+nn?=
 =?iso-8859-1?Q?FQ4GBjFg3mdxJ4KR/2Du0n97VV271UBfcyDckXFbSBjiDdKb5z7CcTdlMV?=
 =?iso-8859-1?Q?P3AyCJgxWqTkb4orahggT9/TZIJLfpdJs+WiSBx7Vg1zavpsjgI4khLfWZ?=
 =?iso-8859-1?Q?CgusjErh5kWvpC48yczDZ/9rP+hLnMnFf7sZ06EkrXbwSw257p7GGCAVry?=
 =?iso-8859-1?Q?rpYKNGWq08EvO0Fc7VaBHDYOG9sVeipGyukSsi83mUyn+g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546e3ef5-3537-4f80-8f89-08df249275fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 16:45:58.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgYU9gNIWA15cD537usYhMpojY5CsZXASPR5kErXz9j7Q3aX1P11aEoBth6RNjrGUKQ69YtPzUqFFUpz0ubuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

On Mon, Oct 05, 2026 at 06:39:59PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch leaves a teardown race open that leaks a reference and
>   has the same symptom it sets out to fix.
> 
> --
> 
> ipv6: serialize address publication with device teardown
> 
> This patch takes idev->lock around the write of idev->dead in
> addrconf_ifdown(). In ipv6_add_addr() it holds idev->lock across both the
> hash and the device-list publication, and rechecks dead and disable_ipv6
> before publishing. The goal is to stop an address being published on a
> dead idev, which leaks references and makes device deletion hang.
> 
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index c90ee6dd7446c..426739abb0744 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -1168,14 +1168,20 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
> >  
> >  	rcu_read_lock();
> >  
> > -	err = ipv6_add_addr_hash(idev->dev, ifa);
> > +	write_lock_bh(&idev->lock);
> > +
> > +	if (idev->dead)
> > +		err = -ENODEV;
> > +	else if (READ_ONCE(idev->cnf.disable_ipv6))
> > +		err = -EACCES;
> > +	else
> > +		err = ipv6_add_addr_hash(idev->dev, ifa);
> >  	if (err < 0) {
> > +		write_unlock_bh(&idev->lock);
> >  		rcu_read_unlock();
> >  		goto out;
> >  	}
> >  
> > -	write_lock_bh(&idev->lock);
> > -
> >  	/* Add to inet6_dev unicast addr list. */
> >  	ipv6_link_dev_addr(idev, ifa);
> >  
> 
> [Severity: High]
> Can the same kind of leak still happen for temporary addresses after this
> change?
> 
> The new critical section ends in ipv6_add_addr() once the address is on the
> hash, addr_list and tempaddr_list:
> 
> net/ipv6/addrconf.c:ipv6_add_addr() {
>     ...
> 	in6_ifa_hold(ifa);
> 	write_unlock_bh(&idev->lock);
> 
> 	rcu_read_unlock();
> 
> 	inet6addr_notifier_call_chain(NETDEV_UP, ifa);
>     ...
> }
> 
> The ifp reference held by ipv6_create_tempaddr() is handed to the new
> address only after ipv6_add_addr() returns:
> 
> net/ipv6/addrconf.c:ipv6_create_tempaddr() {
>     ...
> 	ift = ipv6_add_addr(idev, &cfg, block, NULL);
>     ...
> 	spin_lock_bh(&ift->lock);
> 	ift->ifpub = ifp;
> 	ift->cstamp = now;
>     ...
> 	addrconf_dad_start(ift);
> 	in6_ifa_put(ift);
>     ...
> }
> 
> On the RA path, ipv6_create_tempaddr() runs in softirq without RTNL:
> 
> ndisc_router_discovery()
>   addrconf_prefix_rcv()
>     addrconf_prefix_rcv_add_addr()
>       manage_tempaddrs()
>         ipv6_create_tempaddr(ifp, false)
> 
> Meanwhile, addrconf_notify() handles NETDEV_CHANGEMTU with
> dev->mtu < IPV6_MIN_MTU by calling addrconf_ifdown(dev, true). The device
> is still up and keeps receiving RAs. This is the same trigger the commit
> message cites.
> 
> Suppose addrconf_ifdown() takes idev->lock right after ipv6_add_addr()
> drops it. It sets dead, and the new recheck can't help because the address
> is already published. Step 3 then sees ift on tempaddr_list with ifpub
> still NULL, so it has nothing to drop:
> 
> net/ipv6/addrconf.c:addrconf_ifdown() {
>     ...
> 		if (ifa->ifpub) {
> 			in6_ifa_put(ifa->ifpub);
> 			ifa->ifpub = NULL;
> 		}
>     ...
> }
> 
> The rest of the loop marks ift DEAD, unlinks it and puts it. Then
> ipv6_create_tempaddr() stores ifp in ift->ifpub. addrconf_dad_start() does
> nothing because ift is DEAD, and in6_ifa_put(ift) drops the last reference.
> 
> inet6_ifa_finish_destroy() never releases ifpub. Only ipv6_del_addr() and
> Step 3 of addrconf_ifdown() do, and only while the address is still on
> tempaddr_list.
> 
> If so, the public ifp stays pinned. That pins its idev, and the idev pins
> the net_device through dev_tracker. Later device deletion would then wait
> forever in netdev_wait_allrefs_any(), which is the symptom described in the
> commit message.
> 
> Would it make sense to set ifpub inside the idev->lock publication section,
> for example by passing it into ipv6_add_addr()? Another option would be a
> teardown or destroy path that releases an ifpub attached this late.

Yes, we need to pass the public address to ipv6_add_addr() so that we
only publish a fully initialized temporary address in the per-idev list
and the per-netns hashtable. Something like the diff below. It should be
another patch in this series.

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index e6764245995f..8e608bb9234a 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -87,6 +87,7 @@ struct ifa6_config {
 	u32			preferred_lft;
 	u32			valid_lft;
 	u16			scope;
+	struct inet6_ifaddr	*ifpub;
 };
 
 enum addr_type_t {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c90ee6dd7446..d24773f76805 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1159,6 +1159,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	ifa->tokenized = false;
 
 	ifa->rt = f6i;
+	ifa->ifpub = cfg->ifpub;
 
 	ifa->idev = idev;
 	in6_dev_hold(idev);
@@ -1487,6 +1488,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 
 	cfg.pfx = &addr;
 	cfg.scope = ipv6_addr_scope(cfg.pfx);
+	cfg.ifpub = ifp;
 
 	ift = ipv6_add_addr(idev, &cfg, block, NULL);
 	if (IS_ERR(ift)) {
@@ -1498,7 +1500,6 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
 	}
 
 	spin_lock_bh(&ift->lock);
-	ift->ifpub = ifp;
 	ift->cstamp = now;
 	ift->tstamp = tmp_tstamp;
 	spin_unlock_bh(&ift->lock);
