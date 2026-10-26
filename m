Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792996694;
	b=Kc3KQ5GwyYoT3JBSgDRYwlcFjdVV0PBfnxh0JbXzEcQDaWzlpV5N2ztBoX5dGjCVaBqV
	 kEhZ8FJaN0UpdbxvZL/Hyf5xZSYtiVqUgco481tsuVzO9LMmqvYvz/XebKTDGg6UuLsSo
	 UxBheB4I/kwjczBj75bTK055JKmR01ogqBYad059t1dS4zROMlLdUWcAvbZK55vRQCpVA
	 FNBUrmUx3qeA700TaJBBxg0xPC+glT1fD1Gpq8DdQXrUigf7PGv/ZIA/lhuBVOF3/hSoh
	 EJBoBV4Y96S+umhTdAYJRCDedJ6GhVIB/WwpndY0F0JpfbIXCbKal8tjzzvrk1OzLIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996694;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HXumgwTWc56UW0/3p3q6VVEbnHZb28/9/QzETJyWJ3w=;
	b=hDCbnsGNn2o+0aPsVwMOj2AJWSiytv8drGlKF/Nd0HSWvt7cZ5DxKcw44k9axElaqMBA
	 TUtRYii/zR3Mru1ZBszZM7cnCt3t3wVKTSb0KprR5vmKuz8WOsGKNKab4hPgZqZHAYJy0
	 wZ10Bj+t1CFle4/1YtHB/4KnMMmIH647qyj9y+ENFjA7UGbda8w4T+GlTMQmGrXotUXvL
	 3sDNtn2F/u9V2rJeWnja8FV3MAAMJ+nphKQE2pOBE1fSDFyD0slLkSB0qCsTL2DTptgyf
	 fyVy0qW5G3aH8q8VwW9+y7wcmdHaeeind/rO0SZxIy4i3Z0DlOBrkHJp4NifQFVTzmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaguarmicro.com;
	spf=pass smtp.mailfrom=jaguarmicro.com;
	dkim=pass header.d=jaguarmicro.com header.i=@jaguarmicro.com header.a=rsa-sha256 header.s=selector2 header.b=qzuCkF6Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.137
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022137.outbound.protection.outlook.com [40.107.75.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036A606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 06:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D036A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.a=rsa-sha256 header.s=selector2 header.b=qzuCkF6Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3dbTtXI/SK/QGeAcp6K1LaQDYOAb7MMAPHp7UTnK9xkLxbYv7Dh214czo4q2V6yWlWShu1ICXQosISIj7RpX4JGjk0B9ytCg1a1iQLqCe0uo4iMKZTws4TIUgViaa5vudUHrfvd4xEa79AA38YWSjAK58F9vZe6g5GmWBfDj1zRCMq1LUFb5l7qt8C/XrmqeC/AOHLqHufcMrejSPjml8jNU3bYHXJN6ZjVgT12x/oZOs98VquYoUoe5KohZVJOhNxGvZrm86eOeYCvbAgo454YFyUCfkziJBUBn925hSKRzVYc9sMRpWkC7XpwFtAqm46O1PjpvS3QPaL+7DhkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXumgwTWc56UW0/3p3q6VVEbnHZb28/9/QzETJyWJ3w=;
 b=kIaVhgZhfiW1Psm10o741hlEbhOG04k1yQIDqDSjCa00yYk7UWj6T2D9Scwmx7jsYisq/I7mNsVv6V/WAFwCvo/WPA7pqFQnn+LVSMu4kLuN0xSK41YfE5hMC2+414FpTFyocgA3rAT49Id44qOlR1CtH0O3sQ5Yt0hoQZoAyYtkUgpiSpKNsGQoj/0M6Qg1yqx7NtinyrIC3rcBsaACXY+XrKxiFsT1dG8JGi6vPl4SIu13F6hIQEo+Agl2aJZoKTR60LrxmDXP/rQQHR4uU3EcPeuSiOGIG+DeV2CA7uMldJPtgbQegIzkWo+2O6iDeKKd8jPnHXNKb/xb6Pp7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXumgwTWc56UW0/3p3q6VVEbnHZb28/9/QzETJyWJ3w=;
 b=qzuCkF6ZrxmEDzxlWvjTrUalKXUprBvQ+I2mwbSZelCIYjFUVM3sE8ulfIntUVron/RQShQ4A7bPXAlXlRPLAZsCdRzv/W6ubJ0itP5oXB/+uQkCs/cmtHNhj2CaoXrza+XJrT0YNDPNEYeDvfA3yLSECarH+U3xSwBRYSGqd5kVcXh2DZqu41diq1rMm2GhIhIV50ayljeb9OF0ynJ76sdPJFlVmaQKmKAbaTs/SLVQ/ksdYWvn6glqiho3XdYpdPw5pZbo/gEZSXmYTRAltql0JhZn4kac5MvDqwW2JWvzpni96rnGca2aEcBzcr8spMlA7gHRTYtE6CxraJtm5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5)
 by PUZPR06MB5903.apcprd06.prod.outlook.com (2603:1096:301:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Mon, 26 Oct
 2026 06:38:07 +0000
Received: from SEZPR06MB5897.apcprd06.prod.outlook.com
 ([fe80::291e:5b76:3d2f:29ed]) by SEZPR06MB5897.apcprd06.prod.outlook.com
 ([fe80::291e:5b76:3d2f:29ed%4]) with mapi id 15.21.0569.005; Mon, 26 Oct 2026
 06:38:07 +0000
From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	lorenzo@kernel.org,
	alardam@gmail.com,
	memxor@gmail.com,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	Xiaoguang Wang <lege.wang@jaguarmicro.com>
Subject: [RFC net] netdev-genl: skip DEL_NTF on NETDEV_UNREGISTER rebroadcast
Date: Mon, 26 Oct 2026 14:37:42 +0800
Message-ID: <20261026063743.1797-1-lege.wang@jaguarmicro.com>
X-Mailer: git-send-email 2.43.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To SEZPR06MB5897.apcprd06.prod.outlook.com
 (2603:1096:101:e6::5)
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5897:EE_|PUZPR06MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 269711fe-1e93-44fd-ee90-08df332bb1c2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|18002099003|55112099003|10067099003|56012099006|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261022075727099003|261021135927099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	fCveWYaVwvJt8eNb9HxDnaXSF8R/l7lcSC0RwFGdhl6tsoVrEnLt4nh8yAEUNUrH5ut6PScnyA8nXZR40C6SrJ0Yl7Sk/jPVdl7WBoaCg2a68B0wSIvLB7FRSc2veaAf9a6C0mecnpiStm3Gp3XJLw6Ukewuc4e1eflq+TLSnSjE54gh2s4SIp0WyM8qU4v1SNoNQbC5lTDuYZnAUoexZsSzlFpH1+1ENY1NFe1FdQlw7aolZBGb3+98n2qVGaGfSOjLgtFDSAoXw3o0puD/iTkOgDlO8KxS+I/dANgjXuo0imqNxNEmeuPgByGFW8RDXKZmOAZ6SvOuqPXMySeUYvk3apFPT9qyzPrTUgIZJfsqAoCJyIHKeUKxZjMXmCgjyifn/9XSf72HkGtcjkiwaOExwt0FdoW4oAls1aYg6DpS2y2sahkF1zUjxVflFz2zmzUra6dQwc4MgKnxq7l4VLwxWDbHI5OaxARHuqkz8+X8BDs5kuvKE6f/7kZaI5ANTfF9Kug8Z//EoRhDf6Nw73v+Psg03+Z3AhKAbOGLJZnTQoOZkDLovmfkTME4VEg9TRVN7/JOVEHPVm5naGwbaxc4529Ut059iaUfCsoCAkxhpPfIiAfBSpW2YxnPuNdPl4OPSwUxFBALrr0Mq5Mkisdlh72jlXayviqp3s4xbBEdyYt4l8RQ3sx0mqWny5XdNXyQDSf9LQFAZDK3qMvrrB8VVnnmebCYRjKB5mEQUd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5897.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(18002099003)(55112099003)(10067099003)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021135927099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7sPgS2MaE/1+KNTQJHBNU47THOj8ld1EbRGFMf24PWQDis9zacVoBuj2ZmIr?=
 =?us-ascii?Q?V3qwSKtgMlfr6hJGojM4XcBILnQc9t/h4ZaUmPhXFyT1ZEEhww39CX8FSG4F?=
 =?us-ascii?Q?bNKTiMlvylH1D+/+aGMw4b01Vj/6/1ltM3BYQ/z88eO8oRjSd/l/2PaOf0bj?=
 =?us-ascii?Q?tQjGSneAji1GropSBxI3KWniFV1eek88U+T25N1eQpg3yCPlbbtk6zWkr7zn?=
 =?us-ascii?Q?ITAny+tOI8najZxjQVYap+woXDGqIfPf7YmfJ9ZN24Km0CQ56fE50hS3Lykx?=
 =?us-ascii?Q?ZjUIdGebzyO+kXD0llc1G+43uYeq1WKBsywerrFWs0KeHz5WobPby/OkwDeK?=
 =?us-ascii?Q?NJmi0sxhOx7ooKXUf59mTGpTWMKioGJ+EogKcVbzJPYI3mCdgpiJr7psPZti?=
 =?us-ascii?Q?0bOKdOgfgiuyw+XZMLyQ6J74oaNE7EyLnZVMo2/6akTT1H/TsyMQUoxrfCQN?=
 =?us-ascii?Q?4MthkAA9tKt7ze+srvPM3/cTSCZGQgTzsv82QROLZSa5SfgVmBCTv/Y9zz/C?=
 =?us-ascii?Q?t7Abb3i1W/l9d09OCxLWDeLLDJXXQIMWnipVpyhgvGWEZ7Z60wdNHQe5LvtF?=
 =?us-ascii?Q?5+taQ9yzDNeVUscpTtUkKAmFvI3ndiNV0P9mi0L6G1ysEhJV09TPV7YgGWnB?=
 =?us-ascii?Q?zgy6JhtwENql8vE6BvTnULaMNjTYnSKLt3Vs1HkfYXWVB8i/gTpJF8k0o3p6?=
 =?us-ascii?Q?/m56h/Wc691qcUgeGbJlOBSvqdN0UUbhYSUopFoFYYotaa9NzaxFzLo04TNE?=
 =?us-ascii?Q?nD3m65lMcF8v2kGzVkwoehyH6UUcRpC7a/nMniYcFQNE89RPxtBaSiiOePyk?=
 =?us-ascii?Q?GY9BWHctOpz6DAzLxKDHW6ahL4c0yKv1IWyIksxbkZrUoK/8GTqazLHUljSq?=
 =?us-ascii?Q?H6cAKsdjiKApma9RVMMyF21GUTKrmEPSs8c8tNYo6zg46qmqsKA2KYwc9oKL?=
 =?us-ascii?Q?5zgMPDS7CLTgvTzR9ci595Hcp3tWC2VO3glv3oPW5WN8I13Ztct45PRbmWGd?=
 =?us-ascii?Q?CS8RUIcpYC8MpXYj9NhYaapF81BKl6mzof1yjBKNpURkvAsfvoETVG0gb0a9?=
 =?us-ascii?Q?bw5Euh6uem/5Y12eIKf6tkXgxiyyJC9uyhAijwL21D2883vUgIUPawd8M17H?=
 =?us-ascii?Q?dW52n13CavYONn5Qu4V94+1/VxBKRlK8sanGPTGd6LzzTRnv22MAmV5EK4R2?=
 =?us-ascii?Q?yB32iJgwB0O/CZgkoiCoABg0vBFyESAKG0NnJwqJvLpqBwTSYLy1ZPIEyxpl?=
 =?us-ascii?Q?q1rnsnYNqED4q33b+5OyuSiPCKRxuROi9y+gNf4HSfm3yB3AS/yV1jS021qM?=
 =?us-ascii?Q?HrfJiEvzutNxN2S8U+qw744wZIRXeLuTP35f3Ds9Dg+4tJfWo8v4BzTD4HcM?=
 =?us-ascii?Q?vxchx6F3caU/72ztORLF0FLsvHfb+hhwTqy+tsfEgvRS2NeIl/lo+PhBRXIZ?=
 =?us-ascii?Q?HPdw+qumeq9gxfwISnc20AIY+GYMe5DnAIknV56RvXaNcmuTE49RVW3rfmgL?=
 =?us-ascii?Q?4UcvpYBuk/wO8PV6sDY683c+3sPwJhK4+oTEMcLNqts6dAa87aqtigrB3Dm6?=
 =?us-ascii?Q?Ug0pojqL2WGheCxUEYGSpKDWoZ6klF7Klynch0xoM1fENkmIZrOw+OVy2K9V?=
 =?us-ascii?Q?IInE8R6t6KVv5c76GhKoUTJRECmS7jhEnPv0KHAxxFK48g5eAR3ejANyLGWL?=
 =?us-ascii?Q?tTPPg4zEEYum0lJ6JlbhsCSNvB7540pka3TiASmNOU4nWPBQNswefS/zfZ0M?=
 =?us-ascii?Q?Y/w8CsX5mg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269711fe-1e93-44fd-ee90-08df332bb1c2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5897.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 06:38:07.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcgqjvlS2qEcnyzjhNjY9QinpkyYCjsqQnxBP2eEkqnfYe/tCzQGA0eUsiJ/x546nL6OamVwFZxHZ77YRQz/WA8blRlt7xR6oNQhl/DDBm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5903

While netdev_run_todo() waits for the last references to an
unregistered device, netdev_wait_allrefs_any() resends NETDEV_UNREGISTER
about once per second. By then the device is no longer on its netns
device list. Since commit 8a4fc54b07d7 ("net: get rid of
rtnl_lock_unregistering()"), netns teardown does not wait for such
devices. So cleanup_net() can run all pernet exit handlers for the
device's netns while the device still points to it.

netdev_genl_netdevice_event() handles every NETDEV_UNREGISTER the same
way. On a rebroadcast it calls genl_has_listeners() on dev_net(dev). If
genl_pernet_exit() already ran for that netns, net->genl_sock is NULL:

  CPU0                                 CPU1
  unregister_netdevice_many_notify()
    unlist_netdevice(dev)
    NETDEV_UNREGISTER -> DEL_NTF sent
    net_set_todo(dev)
  netdev_run_todo()
    netdev_wait_allrefs_any()
                                       cleanup_net(netA)
                                         default_device_exit_batch()
                                           (dev not on netA's list)
                                         genl_pernet_exit(netA)
                                           netA->genl_sock = NULL
      NETDEV_UNREGISTER rebroadcast
        netdev_genl_dev_notify(dev)
          genl_has_listeners(netA)
            netlink_has_listeners(NULL)

If a later cleanup_net() run has already freed the struct net,
dev_net(dev) is a dangling pointer.

The splat below came from a 6.6.119-based kernel. The test kept creating
and destroying SR-IOV VFs on two PFs. It also kept binding and unbinding
the PCI devices and moving the VFs through short-lived namespaces. The
VF driver is out of tree:

  BUG: kernel NULL pointer dereference, address: 0000000000000388
  RIP: 0010:netlink_has_listeners+0x5/0x60
  Call Trace:
   netdev_genl_dev_notify+0x42/0x120
   netdev_genl_netdevice_event+0x2e/0x60
   notifier_call_chain+0x56/0xc0
   netdev_wait_allrefs_any+0x1ac/0x240
   netdev_run_todo+0x101/0x330
   jmnd_vnic_remove+0xb1/0x220 [xline_nic]
   auxiliary_bus_remove+0x18/0x30
   device_release_driver_internal+0x19b/0x200
   ...
   unbind_store+0x9d/0xb0

Current mainline has the same code paths. This workload has not been run
on mainline.

The first NETDEV_UNREGISTER is sent while reg_state is
NETREG_UNREGISTERING, under RTNL and before netns teardown can pass
default_device_exit_batch(), so the device-delete notification has
already gone out by then. netdev_run_todo() sets NETREG_UNREGISTERED
before it starts waiting, which is how the rebroadcast can be told
apart. Skip the rebroadcast, as caif_usb and mlxsw already do. This
also stops a duplicate NETDEV_CMD_DEV_DEL_NTF going to user space every
second while the device is stuck.

Fixes: d3d854fd6a1d ("netdev-genl: create a simple family for netdev stuff")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
---
I'm not a networking developer. I hit this crash in our SR-IOV stress
testing and am mainly reporting the bug. The change below is the
simplest fix I could find; if it should be fixed elsewhere, e.g. in
netdev_wait_allrefs_any(), I'd appreciate guidance or am happy for
someone more familiar with this code to take it over.

 net/core/netdev-genl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index c3aa367214ac..0bd6bbbad720 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1506,6 +1506,13 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
 		netdev_unlock_full_to_ops(netdev);
 		break;
 	case NETDEV_UNREGISTER:
+		/* netdev_wait_allrefs_any() rebroadcasts NETDEV_UNREGISTER
+		 * while waiting for references. The device is already off the
+		 * netns device list, so its netns may be gone, and DEL_NTF
+		 * was sent on the first event.
+		 */
+		if (netdev->reg_state == NETREG_UNREGISTERED)
+			break;
 		netdev_lock(netdev);
 		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
 		netdev_unlock(netdev);

base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
-- 
2.43.0

