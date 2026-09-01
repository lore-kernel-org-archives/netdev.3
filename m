Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFC391E7B;
	Tue,  1 Sep 2026 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262622; cv=fail; b=jAhC6acylD8iP/X0JMOeZ03oKD+XkM5xBaqmMXUI9P3ZfarrO25nX/lyjlO8UH1EVnDpztOFQEJAxGUIQeoYmS/H6+dtAwQHdTr4bHJqlEZaLq3gB9zJ7xmHmwmQlFyd4lxWbud0oX3ZvC93YV6gfUT/KZvqXDQLHe/cyzIoRHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262622; c=relaxed/simple;
	bh=khakfYs2Pb1oRQN2tcLrjMrGV2u98EVS3E96IDNGViI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZE9ECWNwMczWrppqlkNEQ1r32Tk5EKpLpx3mKHkZaZFTIXoSuhePdnpoTo5qksYJkMvqA+7JhgaD1blM2+VO+qUfr0ReghdBjTqZI4J2oW+EWzmWzPm8EybeysXAH17GchUYYLqf/DMW8BWjnmPkBQzDysLkGtMsZ7e2/euTwkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oMAA8JTj; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oMAA8JTj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOBIfvC6975CESoxVN64TgVtNFsLiY079KBPDrT+sDHNyeJtQ+MLILxl8nzCp1oGLOwrBMhxHLHc9OiA9xnH3zJ53D9EDt05hjPYNMuyTmycU3ALSFdb5ui8gKPO1uDQTQVUdY7h9tjViLUyJra6dArl48TFHEGajIGJHbQigI6R6XQnMysrgy32PNhvEVV/k1Y5czxBPyR4yJzD8SAriqti2Rx4sn6p0VgTxNg8R7w9QBF/VTxeFOhH4XbZmH/wriVY7pOaywuvy3nzFAwQui/K9NoPj4TwTGV79QmD+Kl+pZ0jpF5HRj14CBglmjagEUen7Ma9hS6W2+1SbltNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9LCS1/4ccoP3zvaYwIEjIY+CD65rriaqJttA3T7w5U=;
 b=G/MBg3KGp13tZuUdwA+AOtC5vu44Dg+OhCfPIPL+s0TfaOx+mRDPki2HOamfxDaiUm2pLqH1lA/GCkPSt2UaHOESz7Eols8oaeBxlOVi0As9NJ5jYr2zylFBiL8Z6fr/gSa50AzRIbhcbGbulB2Xjmx2d3JvzeN/1OQdLHRl7a15T+T/vjfyZjEVajrxj+OyREnnKVWAhMy++dtyp+OV682l9JTdaeklFzmi1cxHGc8y33ZALU1p0z6u1zVP2/pe/a4jeJ+bOwIyY7P+g7C4O7HbI+sb3urRamvu4WOO7tJIB0OcIksAkY1dT1gmV2eWbZMwbCV3teigwLr8PimJoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9LCS1/4ccoP3zvaYwIEjIY+CD65rriaqJttA3T7w5U=;
 b=oMAA8JTjQMLBOIerLF9BJnAwLpXJhP5eTJ8FbAkIgJ9sEsP+C6OKRrrqircky4wrzQgztrljVJe0Rq1xJu/mYx3FKG87oz68Xjdp0coz0hKMUOTfLraSQKmykNYSLHjgB1HUtG4Wue3hSDh4+XUYmvyX2KXxYc8JsTMG5rMkR28GhG8l9FaZKIHbVLVuQD7/n2cFSWAaOPQsn+fR5uN4fAx0ClHG/6jCDy4UEWUGs5vWx7ok2Umu8zRRmUuMei/k/9qeS0kct1CN/ndXnlFynIVGXAc8XcSr6MU4SGoEwfuGGo7YtWToVq+/5l3pJMep2x8SSKxt54fajkX5z6uiug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:36:56 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 11:36:56 +0000
Date: Tue, 1 Sep 2026 14:36:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Seungwon Bae <qotmddnjs@ajou.ac.kr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxlan: serialize nexthop fdb_list against cross-device
 concurrent updates
Message-ID: <20260901113647.GA3441118@shredder>
References: <20260901050253.47197-1-qotmddnjs@ajou.ac.kr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901050253.47197-1-qotmddnjs@ajou.ac.kr>
X-ClientProxiedBy: FR4P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db373b4-b409-4065-fedd-08df081d53ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gN7IH0Pt0MJvlk9uLQHKi21SsevMgLwmODysnEWpTRLaAeYrBnkKW6+0FvoSn1dYEfv3tlvYK9nuZW7tK0UgT2pJ0M+EiooDPjhi5ijXBXtvbVu/5Rz+vujbeN/oI87MFD5f/auGxc2K+O/06eFQVsEpswgaaqnvDM8heek7uHv0FknLzd8XJcrLnZTR1g019+2fQu3J0yT9fNbDg2zpgjHa26jyzJgGl1PVI+xSyM3/DFVJsKmFIVtdgv76DLTM/Sb5oKu+W8mcqKQJe6dseSexwaNpUomvQ6osFWMD5qk1LdQayB1VhBKWKtYvp4iVgjfr8kf3TJF3bnXNbDoFPsbOEmQbF0ty3LDLtrIXOJu0oNwOxy1VLPyQh3+u+IH1tB76LuX/yFB+3IAVuduVf59qFfT1SLLPMI+Og1sGrohwrZiQeAplufeMTyaBgt20cuNo6HWCl1ptQowl/mfzuvjSzvCxh6ymtYqrjPS9RgHdvPlL3UNeEmzbdw9ATSa8VFgh8BMRS+2CrPhbe/CU34UOtF1nh7rwHcsxe9++AL34vkUrf2Vk+g0pqq2fh/QgJwfRyn6lNeu0RnA2E7ZQGfPjoac9xptJg8CAedE7rvwFdw7FzRgdyJL8uZyzEurBRV14OfArNC1jhnkRYx3YneSOdbZJSSFALCnzkP9nSfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hXN8pkxgfajuisWyO494mm8Xm3c7+dd2AR0gGTC9SOq6SDGBm8s64uTUPxk?=
 =?us-ascii?Q?RW1i3xr60wn+mZI/N+shrBR2eUcAnaCK524AC/GMC/cm/UqazNW3Dz2baJT5?=
 =?us-ascii?Q?Je6H8npS54BL2JtPBt1NXvirlUKLOyZHbbyA0RGYhPRMC2FQ4WePm98zK7uM?=
 =?us-ascii?Q?cOoqgj0LFXhzkLp+P1ox6kqSqDHlWMyYPUbNNOkbBCVfUM1Ff3hc5JyBZQqA?=
 =?us-ascii?Q?r/AtTkKaKUDqdHOzhqLJYk2v2PBo+aqYGcMrinAL1JJP64PLF1ge1z2N/EnW?=
 =?us-ascii?Q?gtbpXTB/YEmFyKJTeD7uZg+UqmMgey1IJIVaDOYwBlH619rbCdnCTrvJPGZa?=
 =?us-ascii?Q?dfLTiiwN0g9TojAkWO3WHD+WS8qzPEQDmAK58QQlKw8BfCJF+T7gbtPVAegc?=
 =?us-ascii?Q?Ykd2DF1wlOISaR8tp/8qUFawcTz3w5LhDJRBYGZIy6oXZtkxUCrHDyVPHKG5?=
 =?us-ascii?Q?Q6G2hsfcDhbKo9xcSjCSQdaUiAxNrYCKGcBzy4ajQPh92fj1WAHZeNr/tjeC?=
 =?us-ascii?Q?kwiMZv37wohljMC4wXV/g9YFpKqo3AjIINx4R9qAMC/gM2h0IH5yxMi68ggX?=
 =?us-ascii?Q?vVnLu0djB//wCiyZhVTMGWUw1bRn7uvMAoaggeuw3L3wrvFkltecuTa9u1QS?=
 =?us-ascii?Q?V1rFpEfCjl7iKjkTXqQqYxG1uX2837O38HIXsnk4Zx5t204hbwe5B+Xit5kC?=
 =?us-ascii?Q?EUFvWMU2dEOwdWU4yvamyLW2S287RcKSzxXGllorpWHIkPq9THN6p71nSAz3?=
 =?us-ascii?Q?REbyQJsBBAtZ7e5Rb2tfsNf1TvTXFZ5xAkVpAUYa3afjvsBWlPOIm5T+VRGl?=
 =?us-ascii?Q?ELGWyryyKC2c6qtYXmgg/2AkqJGlGUK/vST6R9UbAFwzbT9OZRnpla3S87bX?=
 =?us-ascii?Q?bCSDnFdbBUiv/FFZblcNIyIF+xcROKUrJ9VPM2BKcPF7phiJlpULHDu8CYYh?=
 =?us-ascii?Q?tCciDunnK1lysKF/WtZwoCk88cpHoeQxYh81I2ijtgvoIaKAi1Wpf1vLKHQT?=
 =?us-ascii?Q?6MDjoSruAVn/pabOrDuwBXF4WWeF+Vd0FPxeuZ2bq3M0zroYUuT8mcGoKVI2?=
 =?us-ascii?Q?s1GCdtJNF7q4OON9ylWX9JPcf41S3HeELltUw+SShmjsyJProsKTUpiU2dn5?=
 =?us-ascii?Q?p6Ys+mkl5TAJ3fAc8PRhUvCYmgJu6c5bRFGbtpG4L5vEfMRFijLEP+YY0pQI?=
 =?us-ascii?Q?FNHPJqCaeZTKe9ZygDDvnWvSy9+WrrCGs0EClYrM1NgUntze+pePzcjNCtnj?=
 =?us-ascii?Q?/H/D2o8E75PFezEocIegtx07CIi7JLyGa7CmjUhuTo/JnCT1kKPwvA+hEWvg?=
 =?us-ascii?Q?L5NBsf6MJH4sQoXqRKFDbYavrvfNUN+fk0iyd8gsxcog70dYB1CO1IoxRhzB?=
 =?us-ascii?Q?e9SxleciM7o2HneDnZwbb6hZL17dAuLKL4KgzkSMwJXElye1VzeOdcSguKVS?=
 =?us-ascii?Q?KPfysGl7xe+Yb+pU63jwiyl5wbfYokEurTiuxJeys3VwRXYSKZLkz3mVthMW?=
 =?us-ascii?Q?WWYCep5PDIDm6Y2zVMHf9ND/w0WXGFMU0C3EKBERvlC/+7iZZ4CBfHC5G+FA?=
 =?us-ascii?Q?m7GQzA5gWDSpnOrJDbVTphQclijUmWRlElbQcaJMoIE7OTm99NBMWu4uxI1p?=
 =?us-ascii?Q?yflXcxov7pa5GdwjB5B5vJUkPbkKypS/C0xvvpmpAR+VwgOi303vb8VIYVMa?=
 =?us-ascii?Q?7NSygAcS9mPF406g/S39yB2O9soizIFrUzU7wYjl1QkhKUAparwJf/NOe++E?=
 =?us-ascii?Q?qjvSFr5wBg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db373b4-b409-4065-fedd-08df081d53ee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:36:56.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aI7WIFd3gvLxGa1a/EHgymDJXrEWqCmndU0AeD86WwWa9eQIKc5CwKKeEiPseTieaU4tgpHQMvA2iuvXMv/BQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736

On Tue, Sep 01, 2026 at 02:02:53PM +0900, Seungwon Bae wrote:
> struct nexthop.fdb_list is a per-nexthop global list of the vxlan fdb
> entries that reference an fdb-nexthop.  vxlan serializes it only with the
> per-device vxlan->hash_lock.  When two vxlan devices reference the same
> fdb-nexthop, their entries share one nh->fdb_list but each device takes
> only its own hash_lock.  vxlan_cleanup() (the aging GC timer) runs in
> softirq with only its device's hash_lock and calls vxlan_fdb_destroy() ->
> list_del_rcu(&f->nh_list); a concurrent list_add_tail_rcu()/list_del_rcu()
> from the other device corrupts the shared list, leaving a freed
> kmalloc-128 struct vxlan_fdb linked on nh->fdb_list (use-after-free later
> consumed by vxlan_fdb_nh_flush()).
> 
> On CONFIG_DEBUG_LIST/KASAN this reproduces as:
> 
>   list_del corruption. next->prev should be ..., but was dead000000000122.
>   __list_del_entry_valid_or_report <- vxlan_fdb_destroy <- vxlan_cleanup
>   <- run_timer_softirq
>   BUG: KASAN: slab-use-after-free in vxlan_fdb_destroy
> 
> Serialize all nh->fdb_list mutations with the nexthop's own spinlock
> (nh->lock), which - unlike rtnl/hash_lock - is usable from the softirq
> aging path.  Lock order is hash_lock -> nh->lock at every mutation site;
> vxlan_fdb_nh_flush() keeps traversing under rcu_read_lock().
> 
> Verified with a KASAN + CONFIG_DEBUG_LIST kernel and an unprivileged
> (userns+netns) reproducer that runs two vxlan devices churning
> add + aging-delete on a shared fdb-nexthop: BEFORE = 490 list_del
> corruptions + slab-use-after-free; AFTER = 0 corruptions, 0 KASAN
> reports, no deadlock.

vxlan_cleanup() shouldn't age out FDB entries that point to a nexthop
ID. While their timestamp is updated by vxlan_snoop(), such entries
cannot roam, unlike normal entries.

I see two possible fixes:

1. Have vxlan_cleanup() skip such entries.

2. Reject FDB entries that point to a nexthop ID from being dynamic,
both when created and when an existing entry is updated.

The first is safer, but the second is the more correct fix and I doubt
anyone is relying on this behavior. Therefore, I suggest going with the
second option. Something like [1]. AFAICT, this means that
nexthop.fdb_list will only be manipulated under RTNL.

Also you need a Fixes tag:

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")

Please read [2] and run [3] and [4] on v2 and future submissions.

Thanks

[1]
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 459f19f7071e..be95af64a1f5 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -996,6 +996,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
+	if (rcu_access_pointer(f->nh) &&
+	    !(state & (NUD_PERMANENT | NUD_NOARP))) {
+		NL_SET_ERR_MSG(extack, "Cannot make a nexthop fdb dynamic");
+		return -EOPNOTSUPP;
+	}
+
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
@@ -1257,6 +1263,11 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
+		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
+		return -EINVAL;
+	}
+
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 3d347126730a..431d7bed7622 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -533,6 +533,20 @@ ipv6_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 61 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
+	# fdb entries with a nexthop group cannot be aged out
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:15 dev vx10 nhid 102 self static"
+	log_test $? 0 "Fdb mac add with nexthop group and static state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
+	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
+	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
+	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
+	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
 
@@ -669,6 +683,20 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
+	# fdb entries with a nexthop group cannot be aged out
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:15 dev vx10 nhid 102 self static"
+	log_test $? 0 "Fdb mac add with nexthop group and static state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
+	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
+	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
+	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
+	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"

[2] https://docs.kernel.org/next/process/maintainer-netdev.html
[3] https://github.com/linux-netdev/nipa#running-locally
[4] https://github.com/sashiko-dev/sashiko#usage
