Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F7B3603C3;
	Mon, 31 Aug 2026 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146548; cv=fail; b=ZjirjQjS4l8hG0iwCUWf3pWsq0t82E4VbHSeyoGL3VHMWzzRsMeVrtkKotUhddNQCyYFRV+38xIQYygonR0TuoyVa2NssnTpC+AngqjFbaqeJeHMweTTPNlOtLK+IT4giMkCb8PKx0NhaI+hUgQDqHnp5301TP5zRzufnLAQQxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146548; c=relaxed/simple;
	bh=n5H93LAyuiELqvY4M71OpQg8ZDrw5G2E302y5FpY4mo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tg35hMItYGvYhksIpAkXhQ556Lhr8VoILmG5utZOq8w2BIp8RFg87MN6ZHZfKImrCoi42BhnkEsXAHprYoBSn8VIS//w9RXM7Jl3FF/qDRudHO0TLtkaLQ68FcJuJiAyEpT0aacPi1HU31R/EoRfXRosqPu3WB9bzhrL+oNhf/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YiA4FESM; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YiA4FESM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtphMY4IpCSx3VIN2FyAHY0+RkmQ2KrF/cbmSMj00Ld+mDhog9XLm4trQ0xW9TkZ3D6ZFjY7RanFyD57bTXLVBJqyqgqnLyUb96RGZsdk3it2p/BSThifS8gQKDelXMa4B761ecSvPlFbHBXrNYDEqTd5pbfPbcxLFUjNRHzWQGIp37i1sv3gwKxkGu/XIcPQq80YzxaoRqptAqeePuyKXRodiVJTuuy5fbDknGOP5ntRH6EI4DZ8JpSZAJTyfDD7YUfubq7SHyaFH8ThNRrP/HJYPW52XV7VXMJvZoku1aT8Y+IzImdc9jukkrj8gzyuvPf9JWTu1SmvcR6AJDy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZHhyWDew8XGKUBVSMYChtgsGZFwkpUslF1rxjI22v0=;
 b=NSNsrW2KWZ+0TucEJ7SxiZScDB9+4AwmOH2nPm7iImjXa0ZYHJE7jLGfacoPZ0BVFNiY9n/FLk+dK0vyQQ0bqs+iXdUU+OWoEDxpE5FzCPGWqGiPLhetDDeuep60Lli2FefHhyOOPzzMdo6Q/aOxL6ZvMfQclOV1aJdx8gy8NYy9JcNvsfc2jlWZEF+9pnsXQpmAA9/wddfFFfn7OQIDKpEdU0GlNf/BxsuViqysqJpth0UWBvaqK4U47OHeBZxWNzLw5XNSMZK4xz8f5CCq5iZlaAXa0knaak2Lq0UFbmMRd8T6+WMw+yLgxEzSAgDH0zWutiU01vx+qH2jUoJvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZHhyWDew8XGKUBVSMYChtgsGZFwkpUslF1rxjI22v0=;
 b=YiA4FESMZFnzQQR6CDKQLYjJcWhx+DN433Zlztt41gih9XBgM1CvEvTU4oiaqYCkD5xnjZcAxtzkFQQgTGc/KPNrNvFxe3dd3gLhammDbEC7jTbygAxuDV4+93PxS+dv+kAVXhbNNom04MQWyda3L/3erZvO1OAkhyVVLiel87Hyudyb109q+OYiNrUF4V2KPZan7JkWyJhU/efY4kOY5/3hsI9PxQv4ecjNERfC4Gb/bEVUb6MSoW1F/5yNd9WiIdE1Y/bK8ceuZ/KcsPSveujXfur4CBYH1NofPZgaeUX51bGMN7jIzgZmUC8kdsZtUJMxfxD5ty3g9U7MZtcvgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:22:20 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:22:20 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 00/15] net: enetc: SR-IOV improvements and ENETC v4 VF support
Date: Mon, 31 Aug 2026 10:54:26 +0800
Message-Id: <20260831025441.635045-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e9d4e3-77ca-4950-ab4f-08df070f1117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|23010399003|1800799024|7416014|376014|10067099003|6133799003|3023799007|18002099003|11063799006|5023799004|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	1ZNGtm5QgnYE+Cl4ErxAR8sm9mzrBbDbmiayRPcH+nMU6rmDe4gOhSmqbmrGW3CB3YHy/5/lAreQ8xFmzSUOp4e3/dUVAaJ4vcjtSHxATJ1EHGsV5WvHkNWL/4HDgSYRk0n3fHlniisnUJEthfBI8t0eziq6D/RHs6MZ9GOAE/q8gbimW1ghGkX9Tagbjg4HcXZf7ARi6koKEsjhpXDhYnOY7LDXMz6fOXifc8TAkJv04TdTOgtoJzeEQn8avYnaoOYeaVTM8A8QU7+QUu30voopvTHlNnpKWIqtb5S3lTQiOCwMNemUf0Trpao3b2GCifFQf/p3SHtyb0qM5Gsd2A2ya474DmRzaFTDsZjqjHC5r7SBWn+bbnJN1rklzmHBQBUEYvvD6b+CG666KtExwNPJmffQDGespZdE5Rd1j1BxO9nHVQ5+J4hiHG08yqudFS/MXcEYxL5ogAtGgzVbmPVC8sq69afSBREGoCgLy791RnDmkDlL8mV8EJ2vyrD2IaJk1LCBuS5d7qiqgu6D7T/ihdAB+C+R4PEiNl4+20nmNyz2ToCsJ88PJ0mb1B3LRn3u8WDqRah5al23iGJH6c0TN43P6n2R6W2Nb3RfAmXC+T3HnKUXIBtyL+QCckDxVKq4v76nEI/Tah9BHbj/Q9uswa4QNAITLtyf+26Xe2ra9V5i1m+8CUMTfwiMKNITudxSmzbQAvcMO8qlx5sbsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(7416014)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(11063799006)(5023799004)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KTbOoEsfQQ/RwpIM8xltmBRtkvrIzcB0QT0CTUjNLv8Nd5qf78BNwjJHLdmd?=
 =?us-ascii?Q?whl3oMscfUq9vCe0qfYPWBCz6/W6pUwpKuTZE/7NAaeNdvSk4jY3CZD7rCZY?=
 =?us-ascii?Q?3qPRKoeUmuRk2yYsu6s4E8LdwJ8JQT5WgUGGUHRMpbGTwe6HgGgq0bQ3iieE?=
 =?us-ascii?Q?QUo9DaUAah613zOqu8MLvZzEVveNrgLcWkhnoVbBoiGCV3NnWHisARuzra5X?=
 =?us-ascii?Q?0k2MaVv/SvR54wv/NDv/LC6vZr2v9aZhC8WPxr0noqcWWVyxXfh5H2rtoFsc?=
 =?us-ascii?Q?2mLvwccX8XFXlvExszf0jkQnebjxd+MW/KtuyMc+g9m/kBI5VeYjjpxiNJgm?=
 =?us-ascii?Q?IERh0wcc578orb8KCKpw+2VFLXtBJ9HHY7r/3HqxnwrG9XfK3aX29acbsLBU?=
 =?us-ascii?Q?B8u8/NXgkMiCPxo5RtB6BnH70QfP497JwoDRFjrM9qSi+4BR1c0usZrzXcuq?=
 =?us-ascii?Q?ChT4EF4cMea9bixHZcZ0vKgGZcsL/8A4CwuUA+XOXlnGXwI/hU662Gxsl7Nz?=
 =?us-ascii?Q?HNmyZKnwytJOMfFNARQ+rDZLFk1np+XvhNlYVwZSQuevg9ogrigD+yDYDBJe?=
 =?us-ascii?Q?E04QJD7luTjyNBFbA+Ow4NG6NWZg5CcL+1x4qKfoTmJA6fLZHS/mJYePVKfQ?=
 =?us-ascii?Q?puMwRWGmkOs/g5nNB1vicL3WNmmctugey3aVSkXc9K9q3a+pziQC5yvLm80y?=
 =?us-ascii?Q?p7SE12Co5KvGw0b7bobFr2CRHPvfTmAj42JWG5wNPLGUqyGwkyxn8rCHw6yV?=
 =?us-ascii?Q?4fczuaG8NPLAns9+fxV+ITZj1UVs+uzVo2P1uhleWhgXz/h9tDGnym9SD3At?=
 =?us-ascii?Q?RwHn7mSi29bpS9i7iQuwYdt76tJZjsszRveT6yBTSFo4B80bn5/cJgja6Gif?=
 =?us-ascii?Q?fULfcU9gK31/QO3uPVE3fXtZIa2NE1M6/obrPYkjUMYcB4JU1qZ3GrKd624Z?=
 =?us-ascii?Q?zFIRnUA1segMl1xKYojoa/e5PJg6l6Wby9/dm+G6TC4YEfLX+CsnYF2ixSb3?=
 =?us-ascii?Q?9jEtKqp/z0bd8eEh/wT0ze7LQU9BqrM8hqTfldczJFPjbnRsrDgQ8PvCfyRl?=
 =?us-ascii?Q?CXW17i9ClNYs89SE790uNB5ZTp2o+5J91yojNvbYoJTQUjH2otTIVasrlUMT?=
 =?us-ascii?Q?VXbzZ45Hv39+ch/pLbiSi8RYnj/FSpXmGWvsdkqSv0uOxL+mDEjgStS19uKc?=
 =?us-ascii?Q?+6KyPcaOJQrNeC50fogKQ2yRLs1x3pSKfGm/pRBvnZVSLtZnIy/bBX2U7Aqk?=
 =?us-ascii?Q?CW1NEUE4+tLX8Zr2CLHkhSNmFyvDxoiPVHlQDCJ+9wR8F2sYkrD448SDReDO?=
 =?us-ascii?Q?8d1B+6LFZ7f3dR1wGCO9lA60rqGAiv37YFKoSIGtOUedtsGdR/+O0UY2ZNxn?=
 =?us-ascii?Q?7q18IoKw9CK/zLtJ8tXydbb5g4qHb9T4C4jJwQBRrdNGuloGR4ZCBW1nmiqQ?=
 =?us-ascii?Q?LQ2Ov1Yy12QFGpXdoZweHVYZ0UovXssDV7A7ml+DfJ4F6oBv/P2xfLsjTYfx?=
 =?us-ascii?Q?YVzHci/UmccNjQFO2hNskhDA0JLkgaZrauan12MnwBVReLpVO7RWEMc4pl7I?=
 =?us-ascii?Q?cvfLW1EPGavJUbPLebMSMSIqn44dxwZpD7yPbqahR/hQEx8qs4ouBe157fRb?=
 =?us-ascii?Q?yp/HjzyXJn11KgSCSyClMyapxDdhIrAxl538i9+4Y6c03590tG6FW3en9w5j?=
 =?us-ascii?Q?vmFv7BekhNolnnHt4z2sJ+prR+FTD/2q9L2QRbd3kb0rObSqNmVJ4Ay7OpSg?=
 =?us-ascii?Q?KUm1YLygeJxQ9jFyiRU6LT/dbjLWqALL8i1y12k1d9FgmO3mwXnw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e9d4e3-77ca-4950-ab4f-08df070f1117
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:22:20.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBVdyJ71Y/cseQ9mrvG2oURoO7YmrPk1feM875mYElRlOb+tDr7iHI+I2SyqmE/KPs0sKcw/7QUM8by2EbqOP16dPe5oPSODVUMWyb2JFqGJXrhCApBd8BNaFM9H4hRj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

From: Wei Fang <wei.fang@nxp.com>

This series enhances SR-IOV support for ENETC v1 and adds VF support
for ENETC v4. For ENETC v1, the trusted VF management and per-VF
configuration query via ndo_get_vf_config() are added. For ENETC v4,
preliminary VF support is introduced for i.MX94 and i.MX95 platforms.

On the PF side, the series introduces trust level management and MAC
address assignment for VFs, and implements ndo_get_vf_config() so that
userspace tools such as 'ip link show' can query the current per-VF
configuration. The PSI-to-VSI messaging infrastructure is extended to
handle link status and link speed queries from VFs, enabling DPDK-owned
VFs to obtain accurate link information from the PF.

On the VF side, MAC address filtering is implemented via the VSI-to-PSI
mailbox, supporting both unicast/multicast hash filters and promiscuous
mode control. Since the ndo_set_rx_mode callback is invoked with BH
disabled and is incompatible with the mailbox polling path,
ndo_set_rx_mode_async is used instead. Link status notifications are also
supported: the VF registers with the PF and receives PSI-to-VSI messages
on every PF link transition, keeping the VF carrier state in sync without
polling.

VF Function Level Reset is handled explicitly to restore the PF-managed
MAC promiscuous policy after each reset, since the hardware default after
FLR enables promiscuous mode regardless of the policy set by the PF
driver.

Several preparatory refactors are included to share infrastructure
between the PF and VF drivers, such as moving msg_task and mac_filter
from struct enetc_pf into the common struct enetc_si.

---
v3:
1. Add link_up flag to struct enetc_pf, refine
   enetc_pf_notify_vf_link_status() and enetc_msg_notify_vf_link_status()
2. Link state is now encoded as bit flags in the 8-bit class code:
   ENETC_CLASS_CODE_LINK_DOWN (bit 0) and ENETC_CLASS_CODE_TX_PAUSE_EN
   (bit 1), so that convey the PF TX-PAUSE state so the VF can decide
   whether to enable RX-ring congestion mode
3. Refactor the shared enetc_build_link_status_msg() helper, link state
   cached in a new pf->link_up field instead of reading netif_carrier_ok()
   each time.
4. Add mutex_lock(&pf->msg_lock) protection; reset link_status_ms_mask = 0
   under the lock on the pci_enable_sriov() failure path
5. Uses pf->total_vfs (not num_vfs) to gate the notify path
6. Replace the hardcoded speed enum (10G/25G/40G/50G/100G) with a
   formula-based scheme, capped at ENETC_MSG_SPEED_MAX = 0xff, so any
   future high speed is supported without touching the enum/switch.
7. Refactored speed lookup into a new enetc_build_link_speed_msg() helper
8. Use bitmap_to_arr32() instead of memcpy()
9. Remove the ndev->state check, refine enetc_vf_wq_task_destroy()
10. VF MR interrupt enable moved to enetc_vf_probe(); explicit
    enetc_vf_disable_mr_int() added in probe-error and remove paths
11. Remove set_si_mac_promisc(), set_si_mac_hash_filter() from struct
    enetc_pf_ops, use the generic helpers enetc_set_si_uc/mc_promisc()
    and enetc_set_si_uc/mc_hash_filter() directly
12. Remove get_si_mac_hash_filter() from struct enetc_pf_ops, use the
    generic helper enetc_get_si_mc_hash_filter()
13. Introduce ENETC_VF_MC_HASH_BITS_MAX (8) constant instead of the
    magic number 8
14. Add enetc_msg_clear_vf_config() to clear promisc/hash config on
    SR-IOV teardown
15. enetc_vf_set_rx_mode() now returns int (was void), with proper error
    propagation and goto out cleanup
16. VF MR-interrupt helpers now take struct enetc_si * and are no-ops on
    ENETC v1 (is_enetc_rev1() guard); disable now writes 0 outright
17. Workqueue switched from create_singlethread_workqueue() to
    alloc_ordered_workqueue(..., WQ_MEM_RECLAIM, ...)
18. Update commit messages
v2 link: https://lore.kernel.org/imx/20260610091844.3423693-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260605065550.3038579-1-wei.fang@oss.nxp.com/
---

Claudiu Manoil (1):
  net: enetc: add trusted VF support

Wei Fang (14):
  net: enetc: move msg_task and msg_int_name to struct enetc_si
  net: enetc: add link status message support to PF driver
  net: enetc: add link speed message support to PF driver
  net: enetc: use enetc_set_si_hw_addr() to set VF MAC address
  net: enetc: relocate enetc_pf_set_vf_mac() for common PF support
  net: enetc: add .ndo_set_vf_mac() to the enetc v4 driver
  net: enetc: move mac_filter from struct enetc_pf to struct enetc_si
  net: enetc: add MAC address filtering support for VFs of ENETC v4
  net: enetc: simplify and rename PSIIER enable/disable helpers
  net: enetc: restore VF MAC promiscuous mode after FLR for ENETC v4
  net: enetc: add VF support for i.MX94 and i.MX95
  net: enetc: implement ndo_set_rx_mode_async for ENETC v4 VF
  net: enetc: add PSI-to-VSI link status notification support for VF
  net: enetc: add ndo_get_vf_config() support

 drivers/net/ethernet/freescale/enetc/Kconfig  |   1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  57 +-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  12 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  51 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  48 +-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   6 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  26 +
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 104 ++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 615 ++++++++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  64 +-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  20 +-
 .../freescale/enetc/enetc_pf_common.c         | 145 ++++-
 .../freescale/enetc/enetc_pf_common.h         |  26 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 385 ++++++++++-
 15 files changed, 1443 insertions(+), 118 deletions(-)

-- 
2.34.1

