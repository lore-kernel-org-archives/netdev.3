Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539E3AFCFD;
	Mon, 31 Aug 2026 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788146603; cv=fail; b=hLqYhpBG+XEzZyQXo74xixw9DWLsLTazn5//MNrTQL2VRgxy9n59Jv7crd/4JzQKU4Puf32ETbpAJxYceK0k+aehWQlaPJt9BJop40q1OfNCAaCNzskjp+ZwECaeJbJDyzmLxj1iHtRc2dkZ6wO88WOG9R3G9kM7XqHRIsUqIaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788146603; c=relaxed/simple;
	bh=aDlos4K6gKOiYRKdeefIROnH6ltUHHN1XCCrZ6TSm4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AfApapJ/lZWt54Yxow2m2glr0HASj5syGOUxCiG/VWEKEcheeJY1xEh/8FFf9pZs7UdfRDC4tTnwXPP0CnBAmWrTPIrOJs7TSPicQ4lOk6TRx+kb37pD/+vzBmNpB75XMU+IeenS1TDlvUTHbtx8h5zy68tqOirks7dsRTCssvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Qhi8Gvtz; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Qhi8Gvtz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+7X3IyruPcoIaNySFah1Q0yHb2sq/CH8Oq81Q/rVGB3sjacTBksAZh064zN6I2prwYJJf8YxUEV6CKylO9LCy0OqkIJQB9BWr7WZhx5YQFOtAZlu/lo/OFmu06IeyEYL3fCf2IpWzOcP8GYC+3mUojJErMAZxFwknRzA9uUB5PuiHEmPYzkZM6WjK2eW3bz+f0hu9YtznuumudFJTim8pwD3R1XzCagcOWvVdso2EF6VrLksw7DOi75nvD78CWGz1mK+oipXfFdHgqSDgtBf6nQoqrQFroeGJC+LUIPFtzg0+7lK5a93nlz56R/8CqkVUHuXy6Knhz/IXvgJCDI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3HZVjG/h+qvh8or0A5Iw/BaSNQzWorufxWbOLDnDsw=;
 b=o5wo2k50mq0x5f2k7Frkg8/68DQYI4aoDMlFGmZtlbImFHaP4fF00S1+CVN4TWgpzJ50BT3/Xx5qyN8xYXTBMYIiiYQiqqocy5jFo/yN7KJoi99yEQfOyMXLfugtHKmP3L9Wk+AL1DqN6sP9PnwUVoGpU7hMd9Qd6WbZWAcmo5SRtFzlAO0d4Un4pxAnlMIcoiMPxUN7/pxv3AbyPwdEBqc2of0mlXsTzeRx9TMp9a4pOIsv+8h7+1IAUU16T+oSHxiOReu4tKY/zOKqXdtgOKvBZgJdCOVeXsrXehl3NPMXjMp5S8OQ5GiDrAANHFjpfYFzIBU/DPN6Jp8Cu8F/0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3HZVjG/h+qvh8or0A5Iw/BaSNQzWorufxWbOLDnDsw=;
 b=Qhi8Gvtzp1GJV7RAgFS/SgnxY23Rd/f/doapYgnDyzrUXmiumjXaJ6gDfJ7UL0u+EK9749VmyPEiW3TJT0dSNCyy1PNARVul08AqnLhf8C+3CYFJkTq1TW0L88nEbNlkp+N5RR/p2Af06Y7Ut6SbiqyPqIStoISdBpeKD+p7OJAPP4xSUNf1SCUHoB0SwROCy9SGZJ+AaRl08Ry70BYh/vMTgnWJfRxWxUyhNqXALvEsI5pjTpxSYe3tK0QR9FZxflN9gGYuKdvPVe5W0nNwo0aAsPtJ3lLlSKHND6ubKIZQlSKSM2WBQdiHIRMZjYWntuxaBQWt8gdqoZbKPwpx5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by PAXPR04MB8474.eurprd04.prod.outlook.com (2603:10a6:102:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 03:23:17 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 03:23:17 +0000
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
Subject: [PATCH v3 net-next 10/15] net: enetc: simplify and rename PSIIER enable/disable helpers
Date: Mon, 31 Aug 2026 10:54:36 +0800
Message-Id: <20260831025441.635045-11-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831025441.635045-1-wei.fang@oss.nxp.com>
References: <20260831025441.635045-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|PAXPR04MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ac281d-eaf8-4354-4549-08df070f3335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|23010399003|7416014|56012099006|10067099003|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	EsRH1qCHxuKfux+B0e72OaD7zF4YclER7oDuCuWKLb4BGwlQHH+wf/9XZdpjA+yJdTrynd0scQhZODSFI5zoaVEly0ilHn5q/lUxr/LGrFD36QNvxBfxr4bdRWi3oPxbqFVFvbM9NMOq2MNKsxhWX/SvZeEQchYDHKQyG+9w3r5NmMGWzlBbntwSbMNk+BHsF74OTBkswelUcIsLrfICm/hOR0lrAJyPry9AWcmsKdt5Rwif0gcgmC4PZQi2w5NL+HzSmDeXg0oyycYggXrZNe7//nZ7fuet3EzxZmYQ717bOhJA1SxVXAKtGN+YAWsP7QEu9JaIs9nB82lEDrhxrfn/kEoQubNHviqZ8VBVIH7N6GvnJrJiYsouhYjJ9/7mBB5UO5Pr9ExopKVcO90CvFKG8AH9p/8z2y6YrLgyh4qlqLEpNCjnLi5r8R01VCtTKzH5VqQjODBtCD30sI2ggYNHIRNsRqjs9/agmeGqSyzpeDx8lxxPpeWdKqHelvTiLowVxFUb9ZyuygU7atI3JVXIi/7mQocHxP23oH0ajw7+UMvKe/InC8tmQ/V8li27zLjPAbDRYlA9lUAAyAQZfW2D91F8x2KaMWgxZkLkl/p/dy2ymO7N0VhCS+znzwzUoWR04T2QR928yuhTOtvVln04SLoHDr8gqQuJPj0s6D3LbaRpj10P0sR5hQVOkE/pZZ7Y29zQqmSUQkui7/0OIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(23010399003)(7416014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SSVgl+zvbSYG0MiNqKrZTz8oOt0uVRain74bwv1HyIGCsZ0NAHn6B1CgbCM0?=
 =?us-ascii?Q?imMg1TCGMZ1vOE+pfDC/Iq+ZWN7RPrS7EB3BSEfHskMNAw14xo4DsoRRA9Dg?=
 =?us-ascii?Q?0HxvEHgFp+NyXW9o/Hnipive9H1ANefESAlzskyJgUpWtMs9Eb6HLf/NnlCe?=
 =?us-ascii?Q?Mf8Vus05RUCkpDdVpPPOlkPN9L+6l5LjsVWoFZxhW0ly8LEcQ2+ab3OEwJDn?=
 =?us-ascii?Q?Df/A76ZYIXSSySXh3EJo1au0+x/+X0/lDmeltc7AuZoeACpZSb740hMLnnYx?=
 =?us-ascii?Q?fDSpkR22F6xrqyaHefEY5l3iYpzjl1n+aa8rNgrGsT4kRCxU7JRtjUFGm0T+?=
 =?us-ascii?Q?OSaKzsaon4N6lPvLr6mMstFTHlpQGrcmj6f2h60Aan+xeSnDleqVeecCS7vh?=
 =?us-ascii?Q?W/yOV1IBR4QVAHcP+/51Hf5rye7UizH9ESSZrn6DNAcVW9jmcxoKx6LZpvfC?=
 =?us-ascii?Q?WFVEMTtgPrlARsSreDohor7BvOziVIZuRwupUHTsCr1c5lEC7b8QR4fxjX8f?=
 =?us-ascii?Q?haUJawLLsgEPF//PQkplTyU/+Xwp/dFefSeH14++MTsGQYOGg3A/2gD5zIQj?=
 =?us-ascii?Q?9EnHeH9Guz+uRA/cFYcYEFDlngvO+K5zC2Z7hmilfVRAbPkGbMpLNxvB25bW?=
 =?us-ascii?Q?XcxiXjF93ND/l38fdNbU/8rKdg/oYljZPN/LKNTxV/KWSOCeXva3u+VjGF+q?=
 =?us-ascii?Q?uQg9opMx9WPO/IC3aE6zzPhCMQgHUEgkF9s4m9GzCItXMNilOWZhr3KFAOJa?=
 =?us-ascii?Q?c9PUTheUIdsUranNv3RmmSsOfGFS2B4LUvnhD6nc5d8ROa5ajqD2bGBtmEpM?=
 =?us-ascii?Q?NWFyFFir3vhu/xt8XCWOW8ajpVGxkckvpC/BoaCZcp+ChWcNEO+cGSg0Fo27?=
 =?us-ascii?Q?6u5gQ3YkFVvBNEufsupc+GPPEHhAHSwWUGCB0WwUkWmTpPb38U1AkZHrGYnm?=
 =?us-ascii?Q?hKEZyDXQPqYrSfcpsBcr0ty5WjRmgJ3JQyRtJiuGeavnOVH0LLyl0q+hRBmg?=
 =?us-ascii?Q?496S33C7fSz7T6qM0i+MUzrImVxCb/RBrZAcLW03M+oAFXonxu/WfvPP2Txf?=
 =?us-ascii?Q?djLP9RCRxxTdBLN2hmmXP5Owk75JcXbU2IN52GZLmm2YerVueY0swuFWNeuJ?=
 =?us-ascii?Q?Jbaqw34VIFpQ9XdZThQcAH24RNYttmrkfMbDltN3NcKHtt5hGFvw8J08zoR7?=
 =?us-ascii?Q?1lMe6Aa54cVQuuLBhBzJnpy57cJ74XYdSNZ5qH6b+2MGb3LFGzXojj7NgSCb?=
 =?us-ascii?Q?RY1uox1W9BaOHtZDzUeBd3ZQve42f5ph97ryLSPo/t7DWeSDxCz1jnI+ISx9?=
 =?us-ascii?Q?kVKgw2xjuuUh1tQUAJTNpcn3gBubmgKhxPqP9dbvRBUn6IwaIHd8pY7b54ff?=
 =?us-ascii?Q?Dvi7h1+G14JPh8jHADiKfwVOaPncQDyujSl7AdrGloFdSuDLuEugE+RVFZ0Y?=
 =?us-ascii?Q?36ZKzazBZj4wLoJecCuer/zGjehX5JGo8qauCJ8v61xwmmm8gl9oK2zECkuO?=
 =?us-ascii?Q?s8c6uAXLM2HM1jqCxIYTBoNGmASnHlWdYqvNnJ9W4wmEYqXnVnCAE2F5yWs7?=
 =?us-ascii?Q?VYRbHfgMdIhFNyvCo9WRLSVNMO4Mq81/+o/RImPEELr5U4qhn/P79gHPqDWH?=
 =?us-ascii?Q?9ofALrR8zd9ZcjhCaIqdz4LNFiaeP1QTSWapHsre+rtpOG4l9kEcIst6qIn0?=
 =?us-ascii?Q?p9Zwwl3+qGYCH/yicAs99K+nRW4IoxYJ07B/5bv+sHxINNRayPupklei5f0a?=
 =?us-ascii?Q?foglEiq0HoO5lGFRK/GzyKf4SfQs/n58OenCku11wL6hjJxd6XdK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ac281d-eaf8-4354-4549-08df070f3335
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 03:23:17.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lHNJ+2SbD67soXc+l1B1ZUMav0hz20hYrsr75DyuW2QyRv75XDiAqPFsoR3rVYdh7IjMzfyPn7PESrpmYuGjsDP7Omi5zHrmi522rXq12lU7PpyOa2kbN+ArPdcVrVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8474

From: Wei Fang <wei.fang@nxp.com>

The PSIIER register controls two categories of interrupt sources:
message-receive (MR) interrupts, which fire when a VF sends a mailbox
message to the PSI, and VF FLR interrupts, which fire when a VF
performs a Function Level Reset.

The current helpers enetc_msg_enable_mr_int() and
enetc_msg_disable_mr_int() use a read-modify-write sequence to update
only the MR bits in PSIIER, intending to preserve any other bits that
may be set. However, VF FLR interrupt support is not yet implemented,
so PSIIER only ever holds MR interrupt bits at this point. The
read-modify-write is therefore unnecessary overhead.

Simplify enetc_disable_psiier_interrupts() to write 0 directly to
PSIIER, disabling all interrupt sources at once, and simplify
enetc_enable_psiier_interrupts() to write the MR mask directly without
reading the current register value first.

Rename both helpers from the MR-specific names to names that reflect
their true scope, i.e. managing all PSIIER interrupt sources rather
than just the MR bits. This prepares the code for a future patch that
adds VF FLR interrupt support, at which point
enetc_enable_psiier_interrupts() will be extended to also set the
corresponding FLR bits.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 30 ++++++++-----------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index d58fbaeaf46c..4aabeb23a386 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -15,23 +15,17 @@
 					    ENETC_MSG_CLASS_ID_MAC_FILTER) | \
 				 FIELD_PREP(ENETC_PF_MSG_CLASS_CODE, (code)))
 
-static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
+static void enetc_disable_psiier_interrupts(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 psiier;
 
-	psiier = enetc_rd(hw, ENETC_PSIIER) & ~ENETC_PSIMR_MASK(pf->num_vfs);
-
-	/* disable MR int source(s) */
-	enetc_wr(hw, ENETC_PSIIER, psiier);
+	enetc_wr(hw, ENETC_PSIIER, 0);
 }
 
-static void enetc_msg_enable_mr_int(struct enetc_pf *pf)
+static void enetc_enable_psiier_interrupts(struct enetc_pf *pf)
 {
+	u32 psiier = ENETC_PSIMR_MASK(pf->num_vfs);
 	struct enetc_hw *hw = &pf->si->hw;
-	u32 psiier;
-
-	psiier = enetc_rd(hw, ENETC_PSIIER) | ENETC_PSIMR_MASK(pf->num_vfs);
 
 	enetc_wr(hw, ENETC_PSIIER, psiier);
 }
@@ -41,7 +35,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_si *si = (struct enetc_si *)data;
 	struct enetc_pf *pf = enetc_si_priv(si);
 
-	enetc_msg_disable_mr_int(pf);
+	enetc_disable_psiier_interrupts(pf);
 	schedule_work(&si->msg_task);
 
 	return IRQ_HANDLED;
@@ -633,7 +627,7 @@ static void enetc_msg_task(struct work_struct *work)
 	}
 
 out:
-	enetc_msg_enable_mr_int(pf);
+	enetc_enable_psiier_interrupts(pf);
 }
 
 /* Init */
@@ -708,8 +702,8 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	/* set one IRQ entry for PSI message receive notification (SI int) */
 	enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
 
-	/* enable MR interrupts */
-	enetc_msg_enable_mr_int(pf);
+	/* enable PSIIER interrupts */
+	enetc_enable_psiier_interrupts(pf);
 
 	return 0;
 
@@ -750,16 +744,16 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	struct enetc_si *si = pf->si;
 	int i;
 
-	/* disable MR interrupts */
-	enetc_msg_disable_mr_int(pf);
+	/* disable PSIIER interrupts */
+	enetc_disable_psiier_interrupts(pf);
 
 	/* de-register message passing interrupt handler */
 	free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
 
 	cancel_work_sync(&si->msg_task);
 
-	/* MR interrupts may be re-enabled by workqueue */
-	enetc_msg_disable_mr_int(pf);
+	/* PSIIER interrupts may be re-enabled by workqueue */
+	enetc_disable_psiier_interrupts(pf);
 
 	for (i = 0; i < pf->num_vfs; i++) {
 		enetc_msg_free_mbx(si, i);
-- 
2.34.1

