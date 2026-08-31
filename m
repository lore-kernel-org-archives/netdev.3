Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E93DE457;
	Mon, 31 Aug 2026 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164375; cv=fail; b=HjhcNKITOx34HlgBTngSBrvAEAzDlM5h6B2ZE5ajdQfDFai9x+lJEKXN8wkYRVOWlB62XFZQ+T973JW0YlbOR2QoXAf/y3ucQ6oDL4SjFMrOtERgh2k9JhLvY880/8QzF4gvbWCdb8VWghl/5yEIZhWfEKCT+fs/43N7BVRQiV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164375; c=relaxed/simple;
	bh=AXh44xJHeZWD47N78mj83NUmpmrLqZpHojnHGQRguig=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=q0M/gq53xEL70xIx/WNSGkJpY7yTr+HiurKs1i+tHfuD4i0OlsEOxmfdDTHKqirnpa1pKH8G3TC9DaLiZX4/6FTxagcm39C8WCZ9JQJpLeuftjK6qzuQ7CZ7UgNOj4DFTk9drij4HTC9a9ZyCzMVcwvRE3J7CFpgsuDXQQQwS9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PDyRyBoD; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PDyRyBoD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2oRqvh/2rPhWICV7vAggTnOSnqATk1vN3hSt4Pt+va6p1YFN0+bKciA3T6mR/ygg7yj8LidEM2TJiAYGCHTBfy5nIHQzH6sq20yQYYa0VBfcvAbSRfKP/WNA0PaUvZ6Y9riUKMhFal74ML/QRecPvC4HWbdVaCC5ThSdAYro+nHURxSaqZNVpWjdPBXTXftLYIdyfgw8n5jseXSlXKQPs8zOU3x9rQ0udEAZARfJlo5NKmCFHaFAPT7bWnap/JNf9xo7wsvYQn+nKP6PS/bBGX6PQ58DScUwAdMxBR6yRadCQBgEQvYPNnD7M2uv+RdZU4E4k8lEExhlwbIbQSdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvCd1HeStVVuRONl3XXPFG70tv6/PVaRgDQCkr0Fp6s=;
 b=jCdaMgXKFrqrpvYuDi+wOoT5cWbPRiiTJk1eLbPVFDW2ez7D0/9xUfQMHulwpyakqw8CXsK086MuQGhw0KXDsDbIiMFsJGduextC+5mdKoDx0E8uDghV9ku8QS49NvN/wfuLFedUWrudz8WcoOtVX3DVGhI7Shv7b7Sp6GdJoqlnGgravYzY79keSVOoUE0NRf6lt1cd94ZADJmPgWP8/gGLn/B01uA9NWLe1yDGDweI+MWjroehzAVJl3a83r99REhfCvoK8LkvL3Qb/QqScS50uWSKDcVPM/0yMDeyKtb0jEpFfhEP1F3bjXSsNPvnYKvK3y72y9OxQV1dsO1xCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvCd1HeStVVuRONl3XXPFG70tv6/PVaRgDQCkr0Fp6s=;
 b=PDyRyBoDlSrJNnEaDLWYiqxcEXGstGajm0WRKjEXDCb2FumP5Rihc+KwL1gpzy0m1xrLF9jVnWYKSeQX/KWiq/xUa4CGIkRgQUOEXSzdSVuLIRPOFjOxN967NngEmhvaSW69hZEpvxNCUFXaDwy84rR4m/LmVbj3Sghfxgh0zs1Bl+NcnshpPggNn/z0bofElRFSUatjhCggrWxXX/JGbtlCuvSvvcHao3gjCt85ZkkBTd8GOhRoJzzz3cnImNCpmWNJscj/zayfvqeJhbpXe+VYn7mR0WGiUzoblgz1zTHTpJcQPK+FkSzDIi4dU9FTgq6JYXyTmi7CPs1pcFQOYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB8440.eurprd04.prod.outlook.com (2603:10a6:20b:3df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:19:30 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:19:29 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 0/8] net: dsa: netc: add PTP support for NETC switch
Date: Mon, 31 Aug 2026 16:23:27 +0800
Message-Id: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f11b4c-3ba9-4d8c-b413-08df07389401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|19092799006|366016|23010399003|376014|18002099003|11063799006|6133799003|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	jr5ZHd1GM5TMbqe28jLC2TO5N/SuJWljaWTHugAPVUMOyNhl04Bq32woMISKre0nnnup/1l+cv3r1xPkLGPmvzwGIi9wTdEQQtxRkdk2gTswunDk7zzIiYnFYpbv1rpYaNLNGg/lrsZHIj0U+/pj1ZCUVz/Avvc3FjYmy32EOEwizFIG4hYEUHQPRJNJwD8BvAl3ugyTxgZ7aV8kkFbvSUCqBQGbbosmdGMjATgZYes/7u3nCTu1ImZXb0IOiQOzC7nTpNQ8yfQE0H2eFl+25HUbEnYfto+CCNB59P39TzgROTHmqqALmspcPkEVhk6dHabb0JJG5SzhRvC6OxSbSt/26Wj4ARHKwF3a0guDRJ2U/BUkGtWu6BWRVOzUmXrAXBOdIUW6eg53TO9bfKIVMsnjdi2EW5Y8j7eFImLpRKqyqrPc/Pyt26Nqk/ZZxLLS+/cgjiFNmUKJ89GNavQIiGLGDoZgXD8MYcW/5nf0OvBwBEhOBPbBDLy0NuuFl+1vQbcb+NEkKTvILbiuvLaDCCxlLOm/qDXhYKSzLtI/Mm4ohU+GNmkk4MlJ9TTrb4d+6dbGM1WNraqgA78OO4Ff9q2slurspl50H977WP4H8ZpyfrbSnxWQnj4KLXzVd8eZl+4po8NWE6NDccBfunCOOs6o4JgXU8AVerRlsMvffPedWPJZ7EuBFsaiTk+v/HyHwAFcmYczsJJ4D45F1X19aA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(19092799006)(366016)(23010399003)(376014)(18002099003)(11063799006)(6133799003)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dpYKZnFUP+Akn924VvofOXd2ZTdH8lIPvkF4U/Dj2knmB918h5HQgSE1gwck?=
 =?us-ascii?Q?76bxjUmKarbJopjJyytEQJdhODBKctIPXbNB0oex5s9TDYk4merGA304RC1Q?=
 =?us-ascii?Q?Jd9LX4Htpqqr2ZPEsXdIp7B1RnrkfpGh6/qvKvWDgink5vqGT9qrCw8nv68z?=
 =?us-ascii?Q?V5DcDlanDvnGhkgjEeGxZThkVpJzFF/jjvMSFjLnC8+4F6EEu8lKZNsv3nAj?=
 =?us-ascii?Q?AAWfPrn4UNPgzbQ8pgcKxSsw2mhTcx871NhcJmTXuTvSAoWWSXiBrHQa2hx+?=
 =?us-ascii?Q?Mde/aiR1CUDjfNbEGDNpIkO5P9K9hoaVxXhqqYyHC6VFZk6ROoVYLbNT0Nm8?=
 =?us-ascii?Q?y2gkhYoH5RrB0dboShNE2kVkyA6+oHmYwIsPFUoVWgXPxY44pyYzYo2OWmwQ?=
 =?us-ascii?Q?aAEF1sb4E6ZgLbBG0/262+9ONUoX8eOWn8hcCGgvidt5FLUkb1r2L+D2BBD/?=
 =?us-ascii?Q?M/xQbOZlwArA9k8LFhXiGyZWnVmY5vKt0X4IqIU21jab+YgtObFN4AZYMBpy?=
 =?us-ascii?Q?yX/iLK/y7Mpx2Lx2MYFS3DhqlhI7hsn4JHBYA8Z/BNslLqSauhzWPZzhn2Tt?=
 =?us-ascii?Q?8UC9Oqr4ZU5hBsUitpTnSn1PnV4L0BoVlNl4JauWNZ7hsedusCgqLV7ZoTT1?=
 =?us-ascii?Q?j1Z+aHgM1+Y07dVjewBxVMo7mIJuzJqghxL7XIPct4fNPDY5A+5OJJKriSCV?=
 =?us-ascii?Q?qOO5y62bdXYuPoDzcMnqMsktk3V08yCki/3L5cn5Vo4gkP0fVhtnySqE/isE?=
 =?us-ascii?Q?rfta2MwublEoHJNIxHEzeptbZLvbJUN2CnCqKDWTHD6mV4Gbb5nun8bl2utH?=
 =?us-ascii?Q?hcsjIg2nd9MgOXQxXLNI4scgHnt0u1t+o9o9DDDBJWNhX+oBUZbXIl+2b9BC?=
 =?us-ascii?Q?C/ZnMIWMcriZ7Q36saQ37NLLy8PnswXRnLF18objs/uJpw/Dapx7Vlp6fBZO?=
 =?us-ascii?Q?567bbVxkdDNu98eo9T7nl0/Mc5lkDnKWaxbs34ar+vWGvI1uzpIF+1ELeQzP?=
 =?us-ascii?Q?OOYv+qthHW6QPopqldYmLQbpPIgtg/M4rJdsLOwFstsb2WygX8xToaGaa+eF?=
 =?us-ascii?Q?7wojKPFsMW1Rko8NIxiDUDhSZbvB4Phas8lLWbzd2Njowdm4QjGdI3bCuAN/?=
 =?us-ascii?Q?N0+i7dFGOhdM/chNTRnY3RuqH7WoJKXwGV7QnFtEKfGzxm10mexlhWHS+3qv?=
 =?us-ascii?Q?M1j0yoh4hebkAwRlgZBYlNAmZcJfL12iBWByBN+KXxEcFnYDtWmVDxI7692F?=
 =?us-ascii?Q?QO+Bww2RCiD99Dr3jseve4l8/75cKuMXVUngdaB89gdS6uXNupUsmiCq79hA?=
 =?us-ascii?Q?mGkRhuhats7TB7+szuKY5P6DIqVhDmxWIG59Rblh/ix4tcgWqZUuXThzA9ZS?=
 =?us-ascii?Q?kE7yd/6vfxCDIMfmmVRUqlLst8aa9g+4Vuv3n90mLSEK2Rle62KvIsc3nPHN?=
 =?us-ascii?Q?cvhGN3+sKChUx/SEHhEChdx8Y1alTOuMd0Mu+qyZF2a26n2KELFCeqLxDO5p?=
 =?us-ascii?Q?uXx2QDi8ySUOB4K9PwtkaM6LpmOwsANAmNiMwYn34xJkrprE7shuWpUYL4u4?=
 =?us-ascii?Q?CCOu5genZijjz1hdFGcpwsQ1EjEVL6V04JA6Ux4VXOuQTIWl9aZoPVy83I65?=
 =?us-ascii?Q?zAATA9xFWipJigaIzRUILQPj2QcEYBNykYgEOuTGMxW40Q7F7t4xefCvGCvK?=
 =?us-ascii?Q?9K1TVBSbJ23wFdfzjke1NXvztjeenKnh2Qn3EGAFYiDuMagLLrzOSxL5HFCO?=
 =?us-ascii?Q?ca8sKo2AR+Pgxgvy1CXMurzDvWRVk8FKX19HWc1W/Iqp9jXluOsa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f11b4c-3ba9-4d8c-b413-08df07389401
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:19:29.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S161NEkG1XshDb7h0RVD8NFOnnyYf9FBmp9oj5mx6R8FRa/7wskUd0MdXmE8NV34eAINPfe+ewCLb8X3AWrAzLn03QZZ2R8Th+ZHOuQ4nDY2mXuBKNW1CgJmLOgSrdFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8440

From: Wei Fang <wei.fang@nxp.com>

This patch set adds PTP timestamping support to the NETC switch, so that
the switch ports can be used for IEEE 1588 PTP synchronization.

The NETC switch has no time registers of its own and instead shares the
PTP time of the NETC Timer, which is a separate PCIe function driven by
its own driver. The first 3 patches prepare the Timer driver for this
role: tidy up its 64-bit register access, drop an ineffective reset, and
export netc_timer_get_current_time() so the switch driver can read the
current PTP time across the driver boundary in a race-free way.

The switch redirects PTP frames to the CPU through the ingress port
filter table (IPFT). A few patches harden and simplify the existing IPFT
and host flood handling first, then enable the ingress port filtering
lookup by default so PTP filter rules take effect without extra software
tracking.

On top of that groundwork, the switch driver gains RX timestamping and
both flavours of TX timestamping. Timestamps are carried between the
hardware and the driver through dedicated switch tags: the ingress and
transmit timestamps ride in To_Host tags, and per-frame requests ride in
To_Port tags. Two-step TX matches a queued skb clone against the
timestamp response echoed back by the hardware. One-step TX defers the
Sync frame to a per-port work, where the driver reads a fresh PTP time
and writes it into the Sync frame's timestamp field, then programs the
single-step register and transmits the frame so the hardware can add the
residence time to the correction field on the wire.

Together these changes let standard user-space PTP stacks drive hardware
timestamping on the NETC switch ports.

---
v3:
1. Change the prototype of netc_timer_get_current_time(), and check the
   pdev driver before accessing the driver data
2. Patch 5 is a new patch
3. Add netc_port_tstamp_timeout_work()
4. Check the return value of ntmp_ipft_delete_entry(), and in
   netc_port_add_ipft_ptp_entry(), check whether the entry already exists
   in IPFT before creating a new entry
5. Remove netc_port_purge_onestep_queue() from netc_port_disable()
6. Add netc_port_purge_onestep_queue() to netc_onestep_destroy_work()
7. Add try_module_get() to netc_port_onestep_alloc() and add module_put()
   to netc_onestep_destroy_work()
8. Use consume_skb() instead of the err_free_skb label calls kfree_skb()
   for NETC_TAG_TH_SUBTYPE2 frames
9. Add subtype check in netc_flow_dissect() and update the comments
10. Check onestep queue length before enqueue
11. Update commit messages
v2 link: https://lore.kernel.org/imx/20260808032146.2335723-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260728104548.3301214-1-wei.fang@oss.nxp.com/
---

Wei Fang (8):
  ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register
    access
  ptp: netc: remove unnecessary pcie_flr() call in probe
  ptp: netc: export netc_timer_get_current_time() for cross-driver use
  net: dsa: netc: use entry ID instead of pointer to track host flood
    rule
  net: dsa: netc: check return value of ntmp_ipft_delete_entry()
  net: dsa: netc: enable ingress port filtering lookup by default
  net: dsa: netc: add PTP two-step timestamping support
  net: dsa: netc: add PTP one-step timestamping support

 drivers/net/dsa/netc/Kconfig          |   2 +
 drivers/net/dsa/netc/Makefile         |   3 +-
 drivers/net/dsa/netc/netc_main.c      | 252 +++++--
 drivers/net/dsa/netc/netc_platform.c  |   1 +
 drivers/net/dsa/netc/netc_ptp.c       | 904 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  93 ++-
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 drivers/ptp/ptp_netc.c                | 125 ++--
 include/linux/dsa/tag_netc.h          |  43 ++
 include/linux/fsl/netc_global.h       |  10 +
 net/dsa/tag_netc.c                    | 236 ++++++-
 11 files changed, 1551 insertions(+), 123 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

-- 
2.34.1

