Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4963BE638;
	Fri, 18 Sep 2026 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716314; cv=fail; b=aRB9pu5EVKBalOolZRrm+5188YEdn3ZwVlwroEGNK6ojfX9BFccBU5Yn0RvwCEcPLmMew+3ZK9RPAFeVNHbMn3dSfPxmCL9Vx8NZ69EUGc4CeTX9Caq+V7w1FFJKs3h+Z0OQWW6DF8w2Y26WXSz0xFSk5kOKNxMfJz1S5nzgJ9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716314; c=relaxed/simple;
	bh=trYneSJHUcz9usZ2qbgXWCFPnFrXVKtqB4Pf8UnuVSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PT/S3VA6SztmeY4JkWCq6Rc5BwpwQ5ciJVrEfqZpLsLWgnkiBfLMqGq69YvpepLqq++OeXYSc+27jySQmq52ZpdVxpvxkUpeX+iuRX6CpoxSvepPewX3+ltWyP56ASj6+l1vpqC55ZSQj03fpd4a8dxVxY9BY7AA7wxLYeSUbpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mPLTD9go; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mPLTD9go"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ca+IgyPYqh2X/htgJ3EG/+AeA0qulRuSc6seY4t/dNSfcYWKEDmkPV5cUD9Gwc//eNPQm9Gt46rNkKNqo9MUL4ssNqIqc6lX5lKHiUrjCTm1lWytpYK+1J/R9m0nIeY6yNkc88JntyYKA1TL36OPiC+g1fBd4HCoQvj7qvdaNU5VPe43/RE1PxyYIo2LsveAgNQnF/9pKoIUEPkYHDDGHUgS6cHe0h6vBcvovhjX5LEjljllR9lUPk7wFlch9XPY8ud10+3MYIDnMc22fKFO9OREDuRlfITkNCy1jhUpDmQktrQNYpgvS3w6KaUqQZ565egpbdcAn3wG9kpgYk+AtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiolPTOUk6JF2CcdSe71/oCx5b0BAcr2XASZk6tt4oo=;
 b=P5DtQusg3aLVtlA5ViJPFIJJIPLkt6k1Zm2sGUHFYTCLC8W0Kct2Mgsd7bElD7wU9uMJaOR/s94K/OO+bSGE2tynnmKm7F2a+YecN5QygpaXystpDRs5XsDfvpjyGPn28eQExHU2RmLGh6+wqdoWUPJ0+pfpxJvzufp607GVMFIHiCzjL90WeveiUqDYlLbz1C46RAjB/8ZN3yUSoufTR5S6pAsRxIdSvp5U8IM4wj4FtLYGd47fLBAFdcLuhxXBduGsRKig6WVUMOdnW2erQUIChoHvU7ynIURAhiv8MG1wXxlSfX/uYSPUYYoGq949GgZf/hSiGWl8E33sgHboVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiolPTOUk6JF2CcdSe71/oCx5b0BAcr2XASZk6tt4oo=;
 b=mPLTD9goZHAooJlW5KTiJDdPz9YKFA14mR799g0Xc8IIJ58i1IxDpqnVlWuOaYYL2afT2G/iAK1gUcMGIt2oRilNpCDR4dcXejA2/WaDw2zVq6CwyUMQaqhL7T4Y1QdF5UKaIeizb3CdXiizivMjfj5PubP3UX4tTeSmKBxR7gLVh5RjNophn4v00F3756rnlRODWsbvQ2+2B0PjxxmIB9PjuthTWiydP1/OVF0Hz3ZoXAhLPcC3TIPzBghsj4uSO8hjRFElaPy2SISQv3+zbsNodGhzPJyDQOtuf1TRyR/lRh4wTByO4M0d6CCTxFpVxGjY5pxFHSWV26QyE8ieLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 07:25:02 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:25:01 +0000
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
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 3/8] ptp: netc: export netc_timer_get_current_time() for cross-driver use
Date: Fri, 18 Sep 2026 15:28:47 +0800
Message-Id: <20260918072852.501420-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918072852.501420-1-wei.fang@oss.nxp.com>
References: <20260918072852.501420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e43cb4d-a1fb-433d-6082-08df1555f3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	badTaL8GEUOrEatXJvHRyNZqx9X+w6x0+jtSHdzfIxyzxrYByTayr27xZe2mpRSi2YVI61R+eXD3Ojy2S+m7+n9S3cu6cWWM8GQa3fnNyW/E8HrJxzlx/6MlAoIr9fOQUXOSn/CaOMOR7oScNMBODqKGlenDlSeAU4Vw2Vb2Itt/PaT0rYm5UgLlSvhffY9RQb/hXb3LHJggFpXWyMCvyTm2Bv49g5tWLsxSbZpUvAaYD8Y+dLft4hZAe68LxD+AirOOPlycFl4SY+/yQH86/F2qVt5PvZJECPjJ1OeD5oB3UxSCRpX0JVqbYvAetGw/gsutrqXDZh2o0ZUvB0w26nTt1ZzpGUJ72huku0KXSzjmYIOsT8qJoV+usscK++4d5HyR1Te0JppjdVpICaTOoGzcnswsUDBIq7FCUwfruzjocIcfMxWm4I0u+dzdFfx3gyid8JMMWw2YEPvrHc+PNKJNvGcaCopUGJ7rgZIzu3SZjM+aA/dtH2ZpBe5CJHVm5Jle2KrmxQDGuU/0Mc258uGXIFDZIEqOd16RSAq1dIF41CiLi5mR1mIpX1cbRbtiarjeLOX0xY33xjwTKOeKBxm5nSxh9yLVq6qSxZMkQaALQn+VIvhGQeeZAAL9u+AJusr06oijAoygTz+rjwJMvF73yF0OovYekwd8XydNIvpGjxYdZuc3WVA/xue20AZKrtBST+CYmhdyOOOUMcXuTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?62vsF8n8qGVUumFo0xqGsEAy3OLYZYzbWotEWj5RirfSw7kKh/nahfIQ4DwF?=
 =?us-ascii?Q?KingUYCJwZOlzSLu0MPscNv2eK/tArl9GaVdYN722qF+e0+MJMWwrI2K3zR9?=
 =?us-ascii?Q?L4D8+YuaLKkLrddaYeQTbuzYCx1TsrlOn+GE/LJ3WMJUcfW36XEXsndNBoo1?=
 =?us-ascii?Q?UdeyMDfTViBLLJ+wuMtoXSY8ueA7TcsFCWgqsGSzMGWX1tPdx3AiusS2s400?=
 =?us-ascii?Q?BiK4FGnxmODVD+WnveGZeZtegTBNasswp0i+sFPOPqJp1MpzQgIO+KjS1eMn?=
 =?us-ascii?Q?EjggYlzUljUiYT14UHtYO5XGhNvufWm3RpRfBB8KQZ5yN2OzNi4C4tqOiqE3?=
 =?us-ascii?Q?7N51zM89sCRhkoAogTO567nXWZ5jF/7RiezMMPwIAXQpVWRbCssTlUflGYYm?=
 =?us-ascii?Q?Urjf8tpdayCrrE6GhroXGrt07QuxiZWDT62ElZfGgwnJGnxpksl/Ss/4XPlY?=
 =?us-ascii?Q?Mid55DSLbnggPSXeWlDtQsKxBc7YQ6qWrqbb3rx231vw9O0kWEDdYAL5Zq45?=
 =?us-ascii?Q?p8sMDKWMhkn+GY+8g9NjGI7nYOGLIeQ5T+PzZAuTbhB+Hhydiu56GFXw4bpy?=
 =?us-ascii?Q?hR9ueH+0CLjlfqfxK0s4Nyux9uURZeOkEut5OJuxxXJou0M2bAcqhRaZ1hWC?=
 =?us-ascii?Q?IBPZYYdApsrb6BBlpqB8ZaILF23rRU+Fl4OsPmYCw4f9K3ONB45aZ2vNUWYr?=
 =?us-ascii?Q?1xnCm+6bhzO/ZuIruTV3ZHXDEbwlEz7qNrUmq9cjItplujUWkdaltyyUggKT?=
 =?us-ascii?Q?GtQm7pvsusQysVb8vAO7BIJMTWYc2v/h2ctlSYiQ1KWqBKmqnLiLjG0WxKK9?=
 =?us-ascii?Q?AaErRedk1AHVyaKpFYTHsYO7UKogNGsyx62WO0RTFwKFTmW0vLjDlBRWhCw0?=
 =?us-ascii?Q?UI4aLYtOHfOkXUkfm8noSGg3CdVOP/jcutu2xv4PiX+Jun2QVSXJw4KM/YfQ?=
 =?us-ascii?Q?1PnRCw8fA32hjMXM0D94Z6fEydEAryW8YWr7nT3KR609/ubPC+R5jykq8E0f?=
 =?us-ascii?Q?u2/a1S5j7tGU6/se/WpadYBoorqd4gssCGX/QGQrgVcNtobbSTWdntIQjGl1?=
 =?us-ascii?Q?Om/YgLCqk9YJ+66L6mxIOahb4lvKmCqP6uoi9IroMOGv/9aiNgjBWS0HMZRl?=
 =?us-ascii?Q?n46nPDyqhshEMk5IbthBrDN4KTeXqej+BR7VsDmiKn+BcPVP88k7f0UTa2kD?=
 =?us-ascii?Q?5dhu7QZnh2qF/bCSr6jyM9ygBelEtxvhvA1M8ovcbMmgxpTCDu2YwO0Qka1a?=
 =?us-ascii?Q?foCgrbXpznGAES9BhB2/SWDSwDn70IgffGFxJVXpNOILMqkya+c91pHPHakz?=
 =?us-ascii?Q?C1aGfWpbJI0Z6O4mY8zF8Q0HPzBhw2PJDIy0os2o6lO8hVYfYq/17Jp0SyIZ?=
 =?us-ascii?Q?i91ATJ5SwzsheN1IlEKI5BPqqZWILc5m4NQhXKq2KbsE2Fi2p/wxyvXNcYPS?=
 =?us-ascii?Q?yDxtV5+T1+5wt7jmcr7HH5HPmh4QVhWVqH+OwPvESxtHJAX/k2ShEnOy2HhF?=
 =?us-ascii?Q?m+BtXVYwceWG2E4n0Xu03r7zFV7GTeKBtqP+NN91oa/Uwntg6+DFDw+GHi3k?=
 =?us-ascii?Q?bQ1uHoY5qYbYJsoZP8S2vVk69PK6INrXEzN0Vu8E9RLaLu51lKHe+UiOeQP+?=
 =?us-ascii?Q?VdsRY6gSXjmKEMYE7bsAyiVKdcxrjsb7iPh563YwpPqAP2y01+JiuFmH/UTL?=
 =?us-ascii?Q?HsEECkvWWIARBYAAT1vm2l+piQv+/c2Za8Yl8WzwgXfWmZykLnP/JF5A7pBy?=
 =?us-ascii?Q?fckIDVGn04d0OdhPNXIOR+DgTmiNDbgnSXNz1qYUtEh853ke16nA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e43cb4d-a1fb-433d-6082-08df1555f3a7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:25:01.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4innTPESuGH2Yd3OBuJ6se4RBcFLwoTlbUJhio5763u0M42GDV0skqPnmftQmjqzJsRVHxvWIEEjE4wB4yXJoBfrSm/ka0b3VSO7T3Xskdmqu+KMQZczQ7IK5HVf6b9A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

From: Wei Fang <wei.fang@nxp.com>

The NETC Switch does not have its own time registers and must obtain
the current PTP time from the NETC Timer bound to it. As they are
separate PCIe functions with independent drivers, add
netc_timer_get_current_time() to the Timer driver and export it so the
Switch driver can call it.

The Timer may be unbound while the Switch is calling this function,
which would free priv and unmap the MMIO region under an in-flight
read. To keep priv valid for the whole read, track each probed Timer
in a module-private list keyed by its pci_dev, and protect the lookup
and the register read with a global spinlock. A list hit proves the
pci_dev is bound to this driver, so priv is valid. remove() deletes
the entry under the same lock before tearing the device down, so no
read can observe a stale priv.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c          | 63 ++++++++++++++++++++++++++++++++-
 include/linux/fsl/netc_global.h | 10 ++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index aa9be8e2a630..1211aa9a37d3 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NXP NETC V4 Timer driver
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/bitfield.h>
@@ -123,8 +123,12 @@ struct netc_timer {
 	u8 fs_alarm_num;
 	u8 fs_alarm_bitmap;
 	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
+	struct list_head node;
 };
 
+static LIST_HEAD(netc_timer_list);
+static DEFINE_SPINLOCK(netc_timer_list_lock);
+
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
 
@@ -985,6 +989,10 @@ static int netc_timer_probe(struct pci_dev *pdev,
 
 	enable_irq(priv->irq);
 
+	spin_lock_bh(&netc_timer_list_lock);
+	list_add(&priv->node, &netc_timer_list);
+	spin_unlock_bh(&netc_timer_list_lock);
+
 	return 0;
 
 free_msix_irq:
@@ -999,6 +1007,10 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	spin_lock_bh(&netc_timer_list_lock);
+	list_del(&priv->node);
+	spin_unlock_bh(&netc_timer_list_lock);
+
 	disable_irq(priv->irq);
 	ptp_clock_unregister(priv->clock);
 	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
@@ -1021,5 +1033,54 @@ static struct pci_driver netc_timer_driver = {
 };
 module_pci_driver(netc_timer_driver);
 
+/**
+ * netc_timer_get_current_time - read the current PTP time from the NETC Timer
+ * @pdev: PCI device of the NETC Timer
+ * @ns: Output, the current PTP clock time in nanoseconds
+ *
+ * Read TMR_CUR_TIME from the NETC Timer bound to @pdev. The lookup and read
+ * run under netc_timer_list_lock, so the Timer cannot be unbound and its priv
+ * freed during the read.
+ *
+ * Context: Process or softirq context. Must not be called from hardirq.
+ *
+ * Return: 0 on success, -ENODEV if the Timer is not present (not yet probed
+ *         or already removed).
+ */
+int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
+{
+	struct netc_timer *priv = NULL;
+	struct netc_timer *tmp;
+	unsigned long flags;
+	int err = 0;
+
+	/* Serialize against driver unbind, so holding it here ensures that
+	 * priv remains valid for the entire duration of the register read.
+	 */
+	spin_lock_bh(&netc_timer_list_lock);
+
+	list_for_each_entry(tmp, &netc_timer_list, node) {
+		if (tmp->pdev == pdev) {
+			priv = tmp;
+			break;
+		}
+	}
+
+	if (!priv) {
+		err = -ENODEV;
+		goto netc_timer_list_unlock;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+	*ns = netc_timer_cur_time_read(priv);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+netc_timer_list_unlock:
+	spin_unlock_bh(&netc_timer_list_lock);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(netc_timer_get_current_time);
+
 MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
index 5b8ff528d369..d4a26c17f99a 100644
--- a/include/linux/fsl/netc_global.h
+++ b/include/linux/fsl/netc_global.h
@@ -6,6 +6,7 @@
 
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/pci.h>
 
 static inline u32 netc_read(void __iomem *reg)
 {
@@ -22,4 +23,13 @@ static inline u64 netc_read64(void __iomem *reg)
 	return ioread64(reg);
 }
 
+#if IS_REACHABLE(CONFIG_PTP_NETC_V4_TIMER)
+int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns);
+#else
+static inline int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
+{
+	return -ENODEV;
+}
+#endif
+
 #endif
-- 
2.34.1

