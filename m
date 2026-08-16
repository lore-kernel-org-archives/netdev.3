Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012053.outbound.protection.outlook.com [40.107.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C43DEFE7;
	Sun, 16 Aug 2026 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786883356; cv=fail; b=HPLGpTy0iQo6j16WQUXdMcJIOpD2aCkaec3+s7GWhMcvApuDpINoBiEn/+Z5XrXSfLAn1kq7xQiKJCxqg5h3T22mUBgYBjAeOdrW78X0I9MLujKSM8vnnUHD1l8mRt3nlFcF7yJjj+VXtFlWDI5J3GeCLTyQyhDAOkCd4chrbeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786883356; c=relaxed/simple;
	bh=Truk3YOfAc+C+mqhpGZAUUp7CAJR0XI7G54EcP9ATdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EflIG4yFE0tl6BktTaGtgXpdW6WviT2VoJQXdL0Ddj+EjiW2CAaNhAlfMg5o53DDwJYl2//HTqkPsIp4H7QR2fnSONZZZKkvHb677ht8JVGBS7G0QN37AoUze05SvRb5cOCz6G6YBnjKJYCJ76JRA3gfyKiPZYGnKMGRMq2qNwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pWfbEBab; arc=fail smtp.client-ip=40.107.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pWfbEBab"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umf8Q4hQxUcdi/cLpqwttam6GWUIPlx7xcCE52whztcL+cP7sd+85fyf8n0DPqFCajWfCVFZylqzyqp1KP0R9HljP+L06pUwx9VXwdNQwtGUd01QNN9eVx0hYsmK6Ax38Mkn3ZnkWyuwSHhEXpsph75DJpimFXQC9xXJFQ2+J5tXSdVpBkBHpjLbNWhS49eZwLOxFjHiDt1kxqdsRcZ4TnmIOexVh4aHqPiVwwy2ppn5JAY202UTpi+5cOkIsCjF9Z1tHYMlSxL2VKoym60gtM4oPQs8oUSC4P4HOG/PNU5kNujHzajCGOsGIwG466v6Tsy06lb9HSh6dpKscWDQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG1S+50z78oGq8ttyovS8mZXzDO6pVY6ZD+lrKpLd6Y=;
 b=LQGhvocdZl/x5UTl1XR2/2vLt63Pc/n9AaEdmKE9vMKeJvy2rKYvfdjsqYHRr34Q6rNfpp6U71ZNS4bgxYZzS6caNdhu1NuoWCujSzELTdL3aeERvErgkmQiGJXtmaRSdcvTxXOf8TGZgr/IlpMdKQNVtduM4n2+Yf5vFvgz6saVdd7Z+iShbSzyY/3f/nk106D0BKkxe4g7wRntkWPc3Dd9uIlvgnDOJSGSpHrsm+KFbSh5etqozgHChOJ1rAiCX6ywX8DbVvHC/Z1jEnXh5GA819Pr/VlWjosCOQN+erDxc4xbdpp/L5RqI6bXGmpcW/Ffx3DTJ49KXw8V8dPMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG1S+50z78oGq8ttyovS8mZXzDO6pVY6ZD+lrKpLd6Y=;
 b=pWfbEBabsKA9ZWZ6oo4XADGMIFLrn57+jnuZ2ErGOWNwScgDCvsB08l7WOdxN0vkQK5id/pddBaUc/dYwAAAmODp9iAJzSk5l+0PEVMhEFKyMUR32CYKIYGRRZ0e3DYZveiPsEXPnaFAcAHkwc0NXJzrPLbcqhbnejLV0ZuDQoxMKQhnqe5c3PnwacG6e/SCHC5N8iOq4PB1tRtqolSoGXTwUt0z36EjZngHLB74reWxGi2+0+TwW5irbHcEKtmPCg6kNv/wnOOgqNMiUeLZInO9F/YTal2qSdPcbKE7zejYr1nwCF2rHVZQu2AE/PYkMlwJjSdt2Bk9dMU0ZV/ryw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Sun, 16 Aug
 2026 12:29:10 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:29:10 +0000
Date: Sun, 16 Aug 2026 15:29:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com
Subject: Re: [PATCH net] vxlan: mdb: Fix use-after-free in vxlan_mdb_flush()
Message-ID: <20260816122900.GA58266@shredder>
References: <20260814153547.29567-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814153547.29567-1-baul.lee@xbow.com>
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: d781c73e-32cd-490e-28eb-08defb91f90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|11063799006|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	r9kKciMSw2aU9hsvTfxcMjMz0Vo8uCYVto869iAS6rvVm6E6IY+TOaal2ZTZKapzbr3GSK2FYMmvaPW9Xu1KKSGO02eZQ55iyurLxbRU/tD+aY6Dr2dB459DQ9TZmKhSXUdhlLU48QUoA5wgY5Qixjs4+s2dUNqYadkEZWptQYscA/IDFBg0VK4BiN0y9qFK3LaLzlyzQ258j8a3ApRFj1i9K6DAI99XCD1/Y9pNz4Z2VoI1v/oYE4GV9WNFdTza8B47iTq3bZmWEVogyUAxzFFtcclxD5Xt7diyxRDudjiLeVbqqFNAlttLhTm1BAfNtrWqV+vcQw2kkMvG3aKmEtkKtYE5355JXjhL6DdDbuRaMsTWJ1sakVcK5u2MdqufV5G4klbGMLO4mcFoMYnvoA1GrSDPPN4lASGdgyC+EpC59KJdeMtzWfub/Rib4Qw6aF0nOqrV/RG+AnZ1d+fsP+dJ6S4i9BqMC9/p5NhfoJwxugCHTe1L7Xj17wTZZUBWlDupCLnv9fcjsuOjHE9owtfPyu+66qaI060Y3jUDy4z/Cjoz8xXmvMKvxDobIgkmu2eeVFTbzIyPkyNsizT9BAxecr7I5rVYFQCwCwLsq14OVP19YLxebGhEeWbyDofaIeMFoRaNEUH175Q1Wv7Pp1e5q0Zf7ei0aE1jJT465FA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+/Wy3EW6luEy0DaM70Tq4gnfvXjsqPNwfYEy1reFztx3gymxOLx17kv3RfQ?=
 =?us-ascii?Q?Vqp6Ey3wxvdcq1uARddxJgcSb5Lq6gikmMRQNN2JQ2tbpKVdR9fj3me1BNNm?=
 =?us-ascii?Q?660g68zrcUuTAEe77dK8arInwWnZqDHYjnFrecAhzbiDV/wdHJcI8MAtfXHL?=
 =?us-ascii?Q?7o3C9IIM6dBSQhcz/r76l2Unb1YgZ4yRLR/9jibXNtnkJX+o6MmwsnrCDIei?=
 =?us-ascii?Q?OI5vgr/tIhXR7MziEWvID/T1xg8iP8t+smN0DfAVz4YliFG+2YgRIVZohHPV?=
 =?us-ascii?Q?4laYIYNLVIaEQvbKMKyLIOKuaj2yAIpriyDi9AcQiPVlCukGaO2n1vEscWhq?=
 =?us-ascii?Q?I/4NjFu8ruYUf1ho99KE4qd5XMtpmdBYqmN/dCtBW6s9oT/mlldDqkikdDST?=
 =?us-ascii?Q?3fYMVBQIO3oPvfziC0vlILVz8ASAQXF96Fn2eLZMwe7cZ+SdfHK6pmAhxBbd?=
 =?us-ascii?Q?PEMWhrVj+PeI5Yy9dkh+d6Pf5pLHC6M9QSg7xJKBHQNefReVK8W7txYOiiP+?=
 =?us-ascii?Q?tdzlZySg0mMWoZZ7GHhP7ueLqp0NEugNDaFFh4xOHyttqRIb9OC6doSB0Iw9?=
 =?us-ascii?Q?81YgXv1fW7AIw8Q0zUL3Gqm47XsdXFhl+GZOnxsWOfk/9wOenB7RPwmXaIMt?=
 =?us-ascii?Q?GoR4+AZgBhjDTMpJHsblCIC3vJaf3I3gafprVAyhSTCmDgcsOWBSDOzc8qek?=
 =?us-ascii?Q?10Rjox0ur6QGF88xRbqnI6eluAl6EaH8TXMyp2ZRCONALOAHQI3d51OenhZ8?=
 =?us-ascii?Q?hqReFpnJ2sXuYF2mvZr7FLykrzFXgrqiuFhME7BNWYwTTcyO0dY8BqojjuAm?=
 =?us-ascii?Q?LzdBYfK+7gMIxhGUGU1d/ZbOKgyyNN8iFOrAnLgfyq8RbcBFj6CbbBOedTmL?=
 =?us-ascii?Q?QiTLKbOZoT/yoePavKl27AY1TdAF2u0b7G2Orgzizb36Ac3EZ3RSXK8cXQQ6?=
 =?us-ascii?Q?vwk8qhU/eyshsc4+Mi8pE3RBcIQ1xUSw41Z0hKIYKJQnMlvConEL6uYErtCu?=
 =?us-ascii?Q?A0vm/t9GZBtnuuEohdtJt1QhrCNiOE6XA5YVNDytbDJlPoIWyzZ2Yyvq3o8a?=
 =?us-ascii?Q?T6ehjYnJ9ImuwczMQGNAsWlvGCZRKjdWhQzn+ch2vLdQpzOVDd6c4dBuAo18?=
 =?us-ascii?Q?jnIlYMd5c5Dfpnko79cxtaEp6p7G5gY57en/masc1fe3LvKqvoDgBYNFUZOQ?=
 =?us-ascii?Q?I277bBRu2gfhtzIBeiE1Su9kHivlJiGoMiV2tZZJR1LwmPz4d/wHYQ1w1qaF?=
 =?us-ascii?Q?0okO9ATN+B5tDrGkz68x/a0IfEc2Dv772lddeyBgftV5oB81EEWvmgqIZ2T2?=
 =?us-ascii?Q?hu09lYkHEJgNFfemuIboC5Oj/aLX3GLAmP+u+QyYT2faVMP6Nb8JpiDJmXY1?=
 =?us-ascii?Q?FQNVsmCIJBmkkFhDt3oNvUtacSeseUTNIYkvbGK/SZ0GkKE5Ll3NvHrZlKx2?=
 =?us-ascii?Q?tQQXflPwEj4JD13EFMCdZtu1cLoEUoVOw760ZMpSoP6O9eDH8rWZwXF371Ue?=
 =?us-ascii?Q?GpDjAuba6+PsvXN5QWAvEwlMVWaBMP2SMyIuNB65dzjZYNL1vS/QujZNZ8uX?=
 =?us-ascii?Q?DIIj7Of/T5WJ/WMVXPSivbOe5KdqZuyVYf9sOuK5JGSR6jPrg3tiOlUdm9mE?=
 =?us-ascii?Q?iZPtFzlF4erKWKJx51cBbc4ok7xJobdlCoippUH+lbftv5s8UAOC7DZerwGT?=
 =?us-ascii?Q?CPoy9D5k/tsOLcEdazUdNFT6DH8gKZlxadOm2eM30UoPd9e3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d781c73e-32cd-490e-28eb-08defb91f90c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:29:10.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WLLW3fjSDiBpB6EWz3KRCGzjml4ztDkaVFy6m2yORhFsV3MmJUVBEzR5M6e9dEQRkMbykKTB3Orsffr1MXHUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935

On Sat, Aug 15, 2026 at 12:35:47AM +0900, Baul Lee wrote:
> vxlan_mdb_flush() iterates over the MDB entries using
> hlist_for_each_entry_safe(), which only tolerates the removal of the
> current entry. Contrary to the comment above the loop, the removal of an
> entry can trigger the removal of another entry.
> 
> Flushing the remotes of a (*, G) entry also removes the (S, G) entries
> that were created for its source list, once they are left without
> remotes:
> 
> vxlan_mdb_remotes_flush()
> -> vxlan_mdb_remote_del()
>    -> vxlan_mdb_remote_srcs_del()
>       -> vxlan_mdb_remote_src_del()
>          -> vxlan_mdb_remote_src_fwd_del()
>             -> __vxlan_mdb_del()
>                -> vxlan_mdb_entry_put()
> 
> Such an entry can be located after the (*, G) entry in the list, as
> vxlan_mdb_entry_get() returns an existing entry without moving it to the
> head of the list. This order is obtained by adding the (S, G) entry
> before the (*, G) entry, the latter with NLM_F_REPLACE, as the addition
> of the source otherwise fails with -EEXIST. The (S, G) entry is then the
> entry saved by hlist_for_each_entry_safe() and it is freed while the
> (*, G) entry is processed. The next iteration calls hlist_del() on it
> again, writing LIST_POISON1 to LIST_POISON2 [1].
> 
> Besides device deletion, the flush is also reachable from RTM_DELMDB
> with NLM_F_BULK.
> 
> Fix by re-reading the next entry after the remotes were flushed. The
> current entry cannot be removed by this flush, as source lists can only
> be configured on (*, G) entries and the removed entries are (S, G)
> entries. It is therefore still linked and its next pointer reflects the
> removals.
> 
> [1]
> BUG: KASAN: wild-memory-access in vxlan_mdb_entry_put.part.0+0x328/0x588
> Write of size 8 at addr dead000000000122 by task ip/327
> 
> CPU: 3 UID: 1000 PID: 327 Comm: ip Not tainted 7.2.0-rc7 #2 PREEMPT
> Call trace:
>  vxlan_mdb_entry_put.part.0+0x328/0x588
>  vxlan_mdb_flush+0x1d8/0x25c
>  vxlan_mdb_fini+0x8c/0x100
>  vxlan_uninit+0x1c/0x7c
>  unregister_netdevice_many_notify+0x954/0xd4c
>  rtnl_dellink+0x210/0x530
>  rtnetlink_rcv_msg+0x434/0x4d0
>  netlink_rcv_skb+0xc4/0x204
>  rtnetlink_rcv+0x18/0x24
>  netlink_unicast+0x4b8/0x548
>  netlink_sendmsg+0x29c/0x560
>  ____sys_sendmsg+0x390/0x3ec
>  ___sys_sendmsg+0x114/0x188
>  __sys_sendmsg+0xf0/0x178
>  __arm64_sys_sendmsg+0x48/0x60
>  invoke_syscall.constprop.0+0x58/0x180
>  el0_svc_common.constprop.0+0x74/0x140
>  do_el0_svc+0x30/0x40
>  el0_svc+0x38/0x98
>  el0t_64_sync_handler+0xa0/0xe4
>  el0t_64_sync+0x198/0x19c
> 
> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
