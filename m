Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDDA51A759;
	Wed,  9 Sep 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950136; cv=fail; b=TTtRBoL4gTG0VFA//CDXwnSGbwZBJUADpnRXNRmCOqOf34C/kldeo0SbZ97Y52MsLW6BHrqcYOyqtwyO1MwAa+Cn1wLtQYzk+GEEm7o8QKzhAlqTAZS4zZTaP1xcTN1bDKjc1k2b2TQAAE1b/tjjk+YGhXoG951zA0+gRHJROr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950136; c=relaxed/simple;
	bh=yGp6A9DebWIMtkIZupDRqZA8FtpkXdoZRcR3bgEwdSg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Nuya4rKhkOAH2mV2avsDDyVVTt/CUCUeHIjehDFH6FdLYc+2YYZF5bfS4Ib2JcjpKWJC1Kk3FKQPM4uZmh2BwG8aNMUYpIwSFMepWjEYfbJIGL+u3Vn/JSmbXPD76Z019uisk6+q/LfrAfkYb6X+R1pRcoDRvg/5LxG3jbSba0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OaQVkDxN; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OaQVkDxN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnsY4WqqZm7tDGBbsZMWIODEKT7cbfZoPJ1hO4p8i7WF2p59T17kA68oWGXRq45Fb8zu663eYwnp9wZ3lyJrRjZQZgao6MyvCLURCz0NzfGhZgqEvI/lSunjEDEOgagVniSKCb4ylbwHs4whO5ik/ytgiZVafIMQ6+Z1GR4hs9oGxOuB5BYYSkVdh2EdDYFWOboOV3TzHh5/2nEdAHADLUDur2CNuQYU2AmcNChu4h5zZki/yUHhoVYZEHOQWB7fS8ImnK2PI0wiqA7758ph+hA2nnybQ+8C+euHPIego1m8oloQRLEDJkpAQLIMJ8HwI6NVtWkIhReDteIkZlobBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avwOKqhQHVgygvuzWmNHRNtdjuMmULsYtT2wREu0u2U=;
 b=ax+caAc8tKcKTaAlhc7eO9y1Jq+dBtDCg4YPNB2VuK6Lgb2m9ay1Rmp50MrPbhTqo7bqFF/LkB/tY7GKy0GPKYQvbqo4Ko37CZm9m9+OfXNqdkQFsDjAixyyQAgCrLNjX+mQUasoLI1W0BLj63zjX7DofYy6DU5zjo41V4LNOu3009uXvna4GLIvV7HdwoxhKG3JrMvjd6s4xkbWteutZ9hjVRmec0vjydbgU8HsN8aGRYwj0Z5CvwfVaaOuSLWFd15E8FrAPsQ6EnV+8yPGByxNewCcelU+yUfZYkQp52OVgth8gohPPOj+26o+3rRWmiFm2I4ga35KUUCJtRBjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avwOKqhQHVgygvuzWmNHRNtdjuMmULsYtT2wREu0u2U=;
 b=OaQVkDxNYpK09NX0tp2/bye+LxNa3AOMcoFK5JbPjMU6ETqA7c2ySIK9vLH/xYhbsuQCvt16W8PQCO+0iJdtfBQWSMxt/mKvD5VMK6Q23oUBv0oWMtBzlxJ7xuh6CgZaxturyyBx+JDUjbd+hQ8AuVBJ+9zV3EvNxRvk6euKlds+SV7eOdPOSXwYVPT2JZuNGFLF2oSIIX6cnDt7tRMQ8IJy95urQvMYMsjWTtJPhwi3z4y5grfc1oVFjvhxitA5HEFgumgT0tS1HJ9pRnFrfrkm563Z2+/1IWlin6cz80ItxjnHPC0HEmHXYYLig8qdLEcGsqjRdwf/eLgMtYbneg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB8PR04MB7066.eurprd04.prod.outlook.com (2603:10a6:10:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:35:30 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:35:30 +0000
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
Subject: [PATCH v4 net-next 00/15] net: enetc: SR-IOV improvements and ENETC v4 VF support
Date: Wed,  9 Sep 2026 18:07:18 +0800
Message-Id: <20260909100733.1139689-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:295::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB8PR04MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 07dcd246-3158-436b-0456-08df0e5e11e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|10067099003|5023799004|11063799006|56012099006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	fRaYNIgnsNXxR9q707/orPlwxwyHyjUOmPkr3T7o63v9+cxwmstDI5QJp0rR0ySOsjZje8p/xfyZKjV/9w5IVr9jsAQrOY7R4duo5iDU6Grmb8RAYUpj4xHDHx6oASx0q4RVNawjzmi/j1LK0o30F9UdtfMCeWJspZIpcHWjkAjzYa6lYbFxDR4d27KO1Cpmleb3oWyFBp8+6/zJopFTUlRnjKGIQYkppHSwb9lkveWLYXhU2Wa3zakJyV1GAfGuNuz4QDAD0ZxN/ZmHrQlXAvHWnykxtMCE+KqOIgtVZ++Dty7U62A2lcqTddVKpeFzkCxAHgrZ5gYHLK4sdK91w2wM5pxzRa7XfoJ9eGUHHPsgmoDxZ8K/S0zKLZoVimbIKhmA+s1Dpr8skfn8Ce0dUUbDafedUTzVzage7icHD6gruMdEyIjM+MlBBGmOXLepTyB5IzTeO/CfKdnUnysxOWe9GgOk45oLdaoPWtSBp/wCzP7hna1auva8wyW0uipdst8J10EpTG7EnICTjTAIPcdokWHdAGUNR2kNfx/ou6foRyACZyDJEc4heERXCnuKfbP1r0HE3I+XzJBGABIz5mHefxRHDGbqRfXFfUVb584V18Hy1qrvpwdRBCfSxiF2QVZnfsC2meKkdrwKJ5ZTRxwMGzID4RyKfzmfwuOhRfWiXX7kd3gMniTpASJBNLzW3mDl/RUoCOFYiTA3rhuG/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B6Y+5gnf3hKUQ1DomEFXCJehVY60C2QnOmFgj5aGZo1qV9ZG+hM4l0N9SZVm?=
 =?us-ascii?Q?qi176RjXLWFFbDXhgDl37mYt5VXiko33681tiNXIJ4f9UkTUGyFRIdt195J6?=
 =?us-ascii?Q?+CnVAZCf6Nty/ft3WUczallT1MuLsga1XVoA/jJ7CKh8dXlRXxwFgXLgEQg3?=
 =?us-ascii?Q?uMIdOwhyjuLrKuRNLLa6utPLYfdqKsa0y9rBk3xDVYT1ONL+svw3KMqmhZOz?=
 =?us-ascii?Q?tKWMt4wcupxMMHzMzda6G8XiDt+BRkREo8zFKlujd+F4B3FvTGwpsQmFWTdU?=
 =?us-ascii?Q?H1LuUzS4VDYXuR5h0+/kJ1QYWBNqNNecH7R56LSnOBZtKqPs1Z1FTPRjcK7q?=
 =?us-ascii?Q?15UVnkj/JpyMRB3KzcOqgMJL5pqrO2Qj1SMYo/3kYOnti8wdfVoMxZ2VSCoI?=
 =?us-ascii?Q?I55trTGfdNrU7j4Qp2nJUwa5D8DFozy1pzradGxjqnYWdp9haIQuyzI+eEiI?=
 =?us-ascii?Q?4dw0VTvPPbpt2ygwiIOt6gwe2pQkK1unLlyWsrb5di29/bXj3zdMiCW2edHT?=
 =?us-ascii?Q?pKWOR33CUMsg2navHxKfzs4F0qSRdOi+gfesAM6Naw01GHPgv8AGWoMf9ref?=
 =?us-ascii?Q?b1HuVLRTWcV4bbmANwp1acNCcYIIaGOnY2bntfQuN7k9VoStVC+7qssyAYYW?=
 =?us-ascii?Q?M2rvLFpHAIShFNGQoxhNRwnPhzJt1N0l7i6SXW/SZOyyLsICSe6CodILRcNl?=
 =?us-ascii?Q?K7BeODoDkdpTX6JH7Oq4NKdJcbElUXFstbwAQpivZWdgv/z4eBq4HchYn2O/?=
 =?us-ascii?Q?jZIMQl2b8T5ZkGeHil/bFmfwi3NMtrAdiLFfWMvEs/yH7Q/6qlybUwVQl58k?=
 =?us-ascii?Q?C19ztZCl1sRQwnjP571AwUMs11VK00+LoBmJ5/SUw7b/YxlsHx6ld064V7Xn?=
 =?us-ascii?Q?VROEC5ZLVs3nxlr1XW7zUV3ywawQSSwyGkPE7LbDy+05g3TXRkgkLlFEjALi?=
 =?us-ascii?Q?INqeUN/TQpVvlERWRJzAM/GOfFAJ33OGsgmDQni/2ultt5AHjklU/IW8z264?=
 =?us-ascii?Q?WQToqeUXsiAirUEQUDNdCeu0KdiPEnbgeIHuJU3s/VNSRvx802gazCbhcvRQ?=
 =?us-ascii?Q?1NwkV4yjkI8N1Mfiexh3a82L0Rh1h+Df5c4jbJ4NNRJrgqVF1MR8JWw4byKD?=
 =?us-ascii?Q?LBWLpGIrVxGH8f7aTLwuKXHdJrSsl0APHauV6sViyVxTbxyB6JqrfBi1fLcO?=
 =?us-ascii?Q?hw8sEa5JMSYUAqiqnQKtGJ6Y9yQOJ/BbW6di5JdUa9Zo5CV6mY4SQI2NFRyu?=
 =?us-ascii?Q?SGqPTp8cMsX8iQD8vfHlEk34LtOGM9ivmtTWt06GbP195APhF7v04zjL/uVv?=
 =?us-ascii?Q?ixk0iyp+7ft1WJ40btx/3yv9LM/d+k9fs2WBVAeO7hkoXayGmvM5w069LpEF?=
 =?us-ascii?Q?lYqqL5lo6f8YZZ3/rcaVt8p7OyxKAAUmX/BhiWPICdfKnaDXgfInjAUfoy/7?=
 =?us-ascii?Q?gIynhfW4Fi7ykn0oe7JKIoJvQ9bWSssWIRfBv7aic8SzuLWf0bsodtaTJ4Cg?=
 =?us-ascii?Q?FCFCZcmiMXaA/uDcQCF0C1lL7ozv0yTVY2q/0xT5jCE3O+kZt4pnfnnxRnVS?=
 =?us-ascii?Q?I79Qb1h8uLGzeqP0qMu3X5g3809fy6TrhACfubciwlNYIhWAwR1EDqvxRnSJ?=
 =?us-ascii?Q?8i8KyWA+/HbD+osjZub4oFScw3qrmhHYd4PhjQvNdVhPLE3rrC1XvFoBMfQA?=
 =?us-ascii?Q?8Y4MGjRYi0C9oy8j1rWtwl6HnI0BBPrN1Tk3Wb9ajbHtQlLgrcxHKEahOjHK?=
 =?us-ascii?Q?+Hc+qzXFWZYQNsGFYTX61/0p3JvMpwDd98Wmig2w5wqvR3hmNC9L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dcd246-3158-436b-0456-08df0e5e11e0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:35:30.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeaUxUJaSVmRCasiGA5cQiBksclCitTKsWCUhlatlbxExbKEdlh6m77/kT0gY5DSjE6KXSD4zwTVOpW6l5soN04eob27jM6GfY29O9S8AxWILE07+oHF1OWlkM61RErF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7066

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
v4:
1. Use the existing si->gen_lock instead of pf->msg_lock
2. Link status notification sending is now deferred to an ordered
   workqueue, instead of sending inline under a mutex
3. enetc_pf_send_link_status_msg() with a retry loop (up to 200ms)
   polling the MS bits, and a per-VF msg_fail_cnt that clears a VF's
   link_status_ms_mask bit after 10 consecutive failures
4. Remove a stray blank line in enetc_sriov_configure
5. enetc_vf_set_mac_promisc() now takes separate promisc and flush_macs
   booleans
6. Refactor enetc_vf_set_mac_hash_filter(), now it takes explicit uc/mc
   presence, builds mac_filter_type/tbl_cnt incrementally, and no longer
   reads ndev->flags directly
7. Restructure rx_mode logic into three helpers:
   enetc_vf_enable_iff_promisc(), enetc_vf_disable_iff_promisc(),
   enetc_vf_enable_iff_allmulti(), with detailed per-step error logging
8. Add a separate enetc4_ndev_ops for ENETC v4 VFs
9. Disable promisc and clears MAC filters on VF removal
10. enetc_phylink_connect() moved to after Tx/Rx resource allocation
11. Remove the ENETC_LINK_STATUS_NOTIFIER_REGISTERED flag
12. MR interrupt handler now explicitly writes VSIIDR_MR and reads
    VSIMSGRR to ACK the PF
13. netif_carrier_off() and enetc_vf_enable_mr_int() are moved before
    register_netdev()
14. Guard spoofchk reporting with is_enetc_rev1()
15. Refine commit messages
v3 link: https://lore.kernel.org/imx/20260831025441.635045-1-wei.fang@oss.nxp.com/
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
 drivers/net/ethernet/freescale/enetc/enetc.c  |  63 +-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  11 +-
 .../ethernet/freescale/enetc/enetc4_debugfs.c |  51 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |   1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  85 ++-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   6 +
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  26 +
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 109 ++-
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 643 ++++++++++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.c   |  64 +-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  21 +-
 .../freescale/enetc/enetc_pf_common.c         | 146 +++-
 .../freescale/enetc/enetc_pf_common.h         |  19 +
 .../net/ethernet/freescale/enetc/enetc_vf.c   | 449 +++++++++++-
 15 files changed, 1568 insertions(+), 127 deletions(-)

-- 
2.34.1

