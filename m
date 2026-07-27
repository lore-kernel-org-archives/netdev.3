Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B452D8391;
	Mon, 27 Jul 2026 06:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785132051; cv=fail; b=W+yASTPmdKH3GPgkKuJOdQXykb7IASDwg82d2MLaiOEYZ6nXl3bjzm1v7jv8e1NM9kQL2MR5teil9ZRuxjCD1rzUWxEOHFI9BpuyMRaRiIMoK3rJ1MrwJmCWzi9BQyQBeTN/jqe62/pzrd9+ayUa/Y7eGKWSVjx+xi5kNZ5nG8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785132051; c=relaxed/simple;
	bh=xhlD/rKYCh6p773nWaSm8ZuW3xAkLnuoPWP5vTyLZmw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Zoa9qspY1g08E3ATrAUiHu/4QBZrhhnrwSSvoRdsRh1qqdQ31rKQp6hDOcwuUIKNYUW5IwhFnn5Qb4HZR0ns3motl47er2uPSaZTJKkjg1o1fJaCcoWti1ZvecPQOyaV2TD06D9brkmHZ16K1QU4EUrhWDJkbpG+TdOElt/aaBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Mvkab9FU; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Mvkab9FU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eq6iU/pz2o/IZ+e6EZzCFWZhiDNmBJFwKtpSvcflpY3boutA9kjeDlH5s0ZMFA0bxSJCBB+XuOEr1JqaCzph7mSN/KyRJl64XCWdAeU597yV2gXng0kzMRrWY++TbxPH6JOJLOURjw3g/1BYs1NIk8kUalrs2UPdwQvn0BA3KM7VvOm1CTf+vk3v5fycP/LW+kaclu5fx9nKDs/yrpPKwH+H7mtZknIxC2XXz67HpWXWL1xUMWjjToxAHMue+b0uGoEDZdg3YNCET7loSagCmoRK7pqTshNZkptWe19V4EEaKSyVc71lzAKO4glO+QsOjomdH+7ppaZcfjyHMAAUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqsLrZgcZFObHQCrOQuga6cYMfJrGcQ4ATZSaoJMp5w=;
 b=DphkK9enM2UJi3cWghD2SkiW/q8GYbVCh08CRutfQBLF8PoNDsPDVPzUVA6C76Xz8kcH+1bTsPrrLbg3GXkJwP2V1tMljv6a7NWMa0AQxmhNwRHl3skl5apnZZOeytVUNslc+GW9dZasTQ8xZqSaXUlKKjS+iGbEpzh4JfmWGDp/Y6Q4MEYkRHaWgNdexnfk+Dc4bbQhAP4vn9aQkX0RsLbfWx17wLGXR46PP0Ti9ER1ghhID2WQE7jyLFKXKQ7XLcvYd6s7ltKW4Eu++R6xr9Xdv2cN6fQ8n3Hl9we849dsYP5g0pVYyzUGEFQ4bybRR4n9+e8efqHJOleAJxSWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqsLrZgcZFObHQCrOQuga6cYMfJrGcQ4ATZSaoJMp5w=;
 b=Mvkab9FUgRXZS91D2YtB2d/heyJm4JBWRyIqL992omg4+0c5qesFlHns2+yHh/b/4wWMtmXTp1qCMd9MCUtpt+K8eSuUVhroMpQ+GgYYnDPUNbzUDH9/OR2SqnxpX/mQX08h4UdcUvtRgYtT5grHARvzi2Pn3A+w8/lIdkwSJRiIkbLIji+THZlXNaD/qJrhvFGkDUoeC3iCDXYnK7lYTywbH0jNzxl81eqq6bzkTcrKFO4JzlpyZzXbB7QkMOfFJ7jTMmQXCmluBAoLyj9TVGunHH8mG0xQFYvPvHV2kCYmNZ7vM4NmRbLMclwLjekPvrAW0ymgz9MBcwQn6CL87g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by BESPR04MB12585.eurprd04.prod.outlook.com (2603:10a6:b10:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:00:46 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:00:46 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com,
	vadim.fedorenko@linux.dev
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] ptp: netc: fix potential interrupt storm caused by incorrect unbind order
Date: Mon, 27 Jul 2026 14:03:48 +0800
Message-Id: <20260727060348.1887464-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|BESPR04MB12585:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fdad3a-3388-4d6a-9ebd-08deeba4662f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|19092799006|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xVO8+s8RQqeCqi8XEBUU0n/ohYju67hcT5SEFEsIEhCqxdfxLoaIDiKAKv+nXcu8A4AjjcbRgRQNnzfiBqLM8Mnv0iYrOeva9XNEDRISN/5Ho+PVSDiZtJ5rlm3i3Em71bfj9tQfle7DACE2FlM/3dT2Sk1Qzm3iYh8L5NOTggj/uCYFZrL1zisAg9zog6t27xkSN7jP+gPU/bNnuK9e+erwrESZG/u4LTrtUN1Y2OtwXca+6LaPDFpZ6bZAQo655FAR3zO7GY37gXjNs7wDzvdJmSpRH9vvdzp9kPr6cUFAFT0Fd9vOk21M+f3LKE9UUS+G1o4nbDbRTiecGjM8fA7GEHBZYrrOvRpNIbXsWSfh69kVBxhGpLDlsAuhT0LFhMlNMRpSslUl6CXU1/Hu8ByJysPFRNeRK/ffYT4ygLXR2F6LBv4TClgr6/QNg8CAK2h35sy2KOrg0ttf1i0CqTWYLZvRBxmZU42SE5CmP+cH9Zp0vYVG/sufcG/qO8Gmp2RHUZkQfxQTej1w7kQmKwSj2gkcV/jDE8D1fsfBO4hDjDEuUOlQF0ecUdPygqCRpiEgQ2zyeQPfbwnDHT6ZDH/3wX7CI1u8RYz6e5DQcVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(19092799006)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8eAZOJzU9b8pOTPS2lK3qM3ZQBEC5+5QmPO7mLBLzJhFonboJIqdKwNvjlhY?=
 =?us-ascii?Q?CNpFqtJ5Fm4tnZ8yyCtPqCc38aS24KHy9zcACl4mGXmP9lsZTSax1ZfuZCzg?=
 =?us-ascii?Q?FLWhoYMBhe0xPKbbHTgquit7YlbluntFXCsoZuNBWJr4e9f7YchxC+58w8+g?=
 =?us-ascii?Q?D4SwoYuFD2ipP+GxuC6nCVZJmxKaexJhAv1/ZtVzCuGcRMBY9RVXxsoyqdOd?=
 =?us-ascii?Q?ucE42ZZt4YIOF3hxUes4cTOlJLrGeSasHVOOFiXR+Jbwd06alNAik0GZO7FG?=
 =?us-ascii?Q?6KxmD2iZQeObOrhgI5P/Fy4QSK8cqG4R6EX11MqSEfvAdZT1YoX0x+NUbiQd?=
 =?us-ascii?Q?FjvJSwReQuJzdxbMPi6e7YyMj9kzGz2EoI1tj+fdw80uFxMpNTQxxBjtyNmH?=
 =?us-ascii?Q?xbNy36QideADJf0VyFTDMJtVWrlTvm/hdd5e44jpWt9KHDNJZcYEPijvKcs2?=
 =?us-ascii?Q?vSkkVnt45DAP3J2XCNqcWHKLSrv4Xgr7Zrm4ASzkf72Ao3UFoicnzeUpxJFX?=
 =?us-ascii?Q?VYRnFut6hr3iKk3b3OAGDVgZwRlmnRLAQo7YBymxFS1X+NQiM/iCdj4gLnjn?=
 =?us-ascii?Q?MjzxYHcEJmmpmszIVVt9srNsGnznYGqgjdFyy+zIYovFnKh3oO4F1DhMix/6?=
 =?us-ascii?Q?erA8cSE1epAijnQJvrkmgbE60cO+XfHwrRLBO2FqFf3r1BjRNyO/aZLGWtLs?=
 =?us-ascii?Q?JqM4lckD/7/Z1Cfg16hjzUG4emQGk7LGSixEOoOqt8PWYkm8ugZZrpdYXdqw?=
 =?us-ascii?Q?nLbCkjLdoM/mb82gfHb2RBHU1to3u/isW92PAtDARDXQN9DU0yvccksPbIj4?=
 =?us-ascii?Q?OlOitP4t4ebQBbaQWZ2bqXVshdWTH4CJRAFGQPcRdAVXcsNmXowfDcWNoplA?=
 =?us-ascii?Q?wzvZ+wwLwG8bdg6jOYMHWVBMr98GHcbyV2k4o2tzmtFfiJV1xdH96BHDIjeq?=
 =?us-ascii?Q?ZInC2tkLwK+9FUGvSRaZnTTkUxRTy8Za6M2vacBdnOG7Npocy6nMXwoKi+2+?=
 =?us-ascii?Q?uFJttnehBNrsLpjAv9TqpsdE1f1HxYA62x2XBFKeVb82z+uYtvlaZQoSu2/r?=
 =?us-ascii?Q?Xi342RmM4H0jbc4m5w4dljaGvw5wJ5XITXyiTbFE90wzVzvF+O0llfjaZ7hy?=
 =?us-ascii?Q?pEpMgvkKiWeR0mWRVNQjTSKvpdCrMa+6Ec3IHn2P8QbIzW8fTrshJ1bQ8Gmg?=
 =?us-ascii?Q?0HV0XQY0iP4D/4wxAXdPJqJ0mDKFPq5yseaTIA9T2lRZ90xoyzsGLj+ZA0O1?=
 =?us-ascii?Q?LK0a0Ev1j9jdTNL34MrDRX1iG90nkihPHV4x9e4clB4VQY8IFRIKDjEFzTNY?=
 =?us-ascii?Q?jlgztihyHdMRUoslWHcosaMXCiAW90IWoVRZxm1lbNzCvblq+CsdQJjJSFUl?=
 =?us-ascii?Q?VBKaduJeReWwzhqE8iXxcbrUFopusWFuHxAeqlBNVr9TIyJ6GS8JbwEEGLEo?=
 =?us-ascii?Q?1jw04+KwrlnCfF6xk+0O4KVPuQHNhnUa7lADREtVyWVAuTEQ8bfG+j/CN1yI?=
 =?us-ascii?Q?vl82DCav6FLjPhWxenLbHPWJRgVH5eYUKnJAyfNCl6NOg7xZT1H7GS8rS+W7?=
 =?us-ascii?Q?5OMsjnqz1S+mjXZ9uJxxJ8m/JBgiNjOicTRohxKgGFZ++BKcCJJQLQ7m17hM?=
 =?us-ascii?Q?/zec6GKMkK26YKwEBipwnEq/eL6Ue74Cu3Yw0z/qCZYPtFkfl/J1Un46EolA?=
 =?us-ascii?Q?yhY46bypnsq5yBi5DRt/mwrfUjm27FZrMQcYZ/33ti7nWp5meqcYNuOnqGKz?=
 =?us-ascii?Q?4DQGwhzgyXbn33TBeFSx2a6rfl9NEELQB6KXlaVEgKilVaVEMXAO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fdad3a-3388-4d6a-9ebd-08deeba4662f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:00:46.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+pafQTOlbPWysDxhv9LaLfViS0h40WgTIlpMeEdYI/KWDwF1ORFLc+Q8tRMdStAwGpcHq1q4O71pIaNuRAH7OnG1paL8IeLLT1Z51u7yWOdJSZnMRx3Q7Ob9Gf7T99y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12585

From: Wei Fang <wei.fang@nxp.com>

In netc_timer_remove(), hardware interrupts are disabled by clearing
TMR_TEMASK before ptp_clock_unregister() is called. This may cause a
race condition during driver unbind that could leave hardware interrupts
active. For example, a concurrent PTP_CLK_REQ_EXTTS ioctl can re-enable
TMR_TEMASK after it has been cleared, leaving a pending hardware
interrupt when the driver unbinds.

Since the NETC Timer does not support PCIe FLR, hardware state is not
reset during probe. When the driver is rebound and the IRQ is registered,
the pending interrupt fires immediately. At that point priv->tmr_emask
is still zero, so netc_timer_isr() does not clear the interrupt status
and unconditionally returns IRQ_HANDLED, resulting in an uninterruptible
infinite interrupt storm.

Fix this in several ways. First, request the IRQ with IRQF_NO_AUTOEN so
it is not enabled when request_irq() runs, and clear TMR_TEMASK in
netc_timer_init() before enabling it. The IRQ is only enabled at the end
of probe once the timer has been reprogrammed and the PTP clock has been
registered. This ensures a stale pending interrupt from a previous unbind
or an unclean shutdown cannot be delivered before the driver is fully
initialized.

Second, in netc_timer_remove() call disable_irq() before
ptp_clock_unregister() and move the TMR_TEMASK/TMR_CTRL clearing after
it. disable_irq() masks the line and waits for any in-flight
netc_timer_isr() to finish, so no ISR can dereference priv->clock after
ptp_clock_unregister() has freed it. Unregistering the PTP clock before
clearing the mask also guarantees that no in-flight or concurrent ioctl
can re-enable hardware interrupts.

Finally, return IRQ_NONE from netc_timer_isr() when the masked event
status is zero, so the kernel's spurious interrupt detection can disable
a stuck line instead of looping forever.

Fixes: 671e266835b8 ("ptp: netc: add periodic pulse output support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260720012508.23227-1-wei.fang%40oss.nxp.com
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2:
1. netc_timer_remove(): add disable_irq() before ptp_clock_unregister()
   to avoid an ISR touching priv->clock after it is freed.
2. request_irq(): use IRQF_NO_AUTOEN so the IRQ is not enabled too early.
3. netc_timer_free_msix_irq(): drop redundant disable_irq() (free_irq()
   already handles it).
4. netc_timer_probe(): enable_irq() only at the end of probe.
5. netc_timer_init(): clear TMR_TEMASK before enabling the IRQ.
6. netc_timer_isr(): return IRQ_NONE when no masked event is pending.
7. Commit message: rewritten to describe all of the above.
---
 drivers/ptp/ptp_netc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 5e381c354d74..1c20d7efab92 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -769,6 +769,7 @@ static void netc_timer_init(struct netc_timer *priv)
 		   TMR_CTRL_TE | TMR_CTRL_FS;
 	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
 	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
+	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
 
 	/* Disable FIPER by default */
 	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
@@ -901,6 +902,11 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 	/* Clear interrupts status */
 	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
 
+	if (!tmr_event) {
+		spin_unlock(&priv->lock);
+		return IRQ_NONE;
+	}
+
 	if (tmr_event & TMR_TEVENT_ALMEN(0))
 		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
 
@@ -936,7 +942,8 @@ static int netc_timer_init_msix_irq(struct netc_timer *priv)
 	}
 
 	priv->irq = pci_irq_vector(pdev, 0);
-	err = request_irq(priv->irq, netc_timer_isr, 0, priv->irq_name, priv);
+	err = request_irq(priv->irq, netc_timer_isr, IRQF_NO_AUTOEN,
+			  priv->irq_name, priv);
 	if (err) {
 		dev_err(&pdev->dev, "request_irq() failed\n");
 		pci_free_irq_vectors(pdev);
@@ -951,7 +958,6 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
 {
 	struct pci_dev *pdev = priv->pdev;
 
-	disable_irq(priv->irq);
 	free_irq(priv->irq, priv);
 	pci_free_irq_vectors(pdev);
 }
@@ -1005,6 +1011,8 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		goto free_msix_irq;
 	}
 
+	enable_irq(priv->irq);
+
 	return 0;
 
 free_msix_irq:
@@ -1019,9 +1027,10 @@ static void netc_timer_remove(struct pci_dev *pdev)
 {
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
+	disable_irq(priv->irq);
+	ptp_clock_unregister(priv->clock);
 	netc_timer_wr(priv, NETC_TMR_TEMASK, 0);
 	netc_timer_wr(priv, NETC_TMR_CTRL, 0);
-	ptp_clock_unregister(priv->clock);
 	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
 }
-- 
2.34.1

