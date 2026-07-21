Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021141.outbound.protection.outlook.com [52.101.57.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C746E01C;
	Tue, 21 Jul 2026 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656395; cv=fail; b=VNF6arDNCUXJzMpX2+qot+K6qfzO4eWqMfiXC5C38CcxsCZzKXiHq0wE+teALTt9E1a8JOaPG21xlFLla4vCSZqkhQksN5R5+nt1pySNQSd8tB4C+f1tu402lpv7oTrIejJfYaFFYNbVW8SX3OWU9tDn4zPTzUBgrGK9ZeiOZE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656395; c=relaxed/simple;
	bh=OPiM7y1qV/6idlvHuk0xk9QyGfCo7pG2I98n8YXvBKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LzAlaH3tv5Ev5Xr0eyLqQvjo8GjQiICNKUbWTCUQ/fUYujYkeLIFcnOItfhvXJQclHhMrIw5e8+AqTiOQN8GQV/A0OAYcvfugj/6bMj35g3SviHbqsyy3rQgNDsM9f3dsFcSkF9DcSsXfuLFs5UljZSz0R24MvrEaqSCWW6hMME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Y23L1NDa; arc=fail smtp.client-ip=52.101.57.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Y23L1NDa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfqfD9oy5ZdNScioAGmuWxxJmA7ELt4CBY5+h1m2s7bqrVVZ8bgb+PSDZkPJTAsn+l3LezkcX8GIauk7wlJ6GiMGJM82EzLjkLIoCrFxHNN/9XoE/wN/SpgrQtoOWzryGHWEKnTkhQKzts5pmmaLM8gg9jQBgVqswtF8qelP9jSvgJs89sMtlC8V4XQdQ8B9YBUnVMesCe1dTSD6jU//jT6+Xd5VBx1aF8g33nLT3pPD9LE0rKmHB/gl29FP29yJLwUDN3i4USuVMOkXstZLgO/AmK5+Ha8JHhcMpEh6fYlvSuC/FzbWTBuBswemlnofgZX1J7ZLYVeJyznR+s8c0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oww8ouWJyNhL3L2yXh7BuNDeTaoRvuUfDd+TlCdyiLw=;
 b=aKOsXg/ko4RQglu0CWnqOjAo5mI9Hq4spfcCrn0DihxwzXxhY1DfHR9CHGowlQjBX6X1ClSbrOYspy7JjCN3eQeArzf7/aFiGM/luT+kwD+vM2omX0FfcW3KgqYs4FWVSszS/MIzkXkr10mFEuyg9bJpVozQ+C9pOe2kaXKtn/duN2ntskK2f/qioQ3sgl5rgSso6dnPSazBhtE9zyWQu5TU4Xl6XAe1rvC+LxZzQMrtJtgCK57fMt3gUnr3n5F44t3Rjjzit8ZcKi++TCOn/8Dy5p9A9An++cFidWtzD3EmoJI/iQQs+7arxkaZ6RT88hKZSWrstdKRqHoKrRcBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oww8ouWJyNhL3L2yXh7BuNDeTaoRvuUfDd+TlCdyiLw=;
 b=Y23L1NDaVmJZucnZnkK3r2GOgTTY1RvLt/2K/piSAvlcSTL9Bn/LfxwaW8C8+o+LN3XH5Z29qs7gt9RnbCmUTbCBDcM9fQlbB+89ItP4D8gwNgF8hO3ClScR9k2Q88rd6A4rEItu9GKjNFiKQd/D4yxARxlIqWweidDdRdjdX40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:53:10 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:53:08 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Huisong Li <lihuisong@huawei.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v45 1/7] mailbox/pcc.c: shmem map/unmap startup/teardown
Date: Tue, 21 Jul 2026 13:52:50 -0400
Message-ID: <20260721175258.87600-2-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
References: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:ed::7) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a77e6b-18ea-4eb6-fe65-08dee750ec95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|22082099003|55112099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4I6Kxj0s+nu1/x2CC+5MrMxga/QZjqGb5th2mOM9+YRureeZBs7RDbf+tQ2Odpeq0UMzu5Y+k6USTxCKpJeO7L3m//GRpOIU1M5d5T8hFt7CXvwDDJr7N0iLuyjYu1yojOlPOtgOS5ExPSCu0ALoEHsyIEugmPzisVOXOb84wGeb6wAT8+176CCd4hjhu+hC91KveSu5wFjY0AY4i8s1hmi2QLlVAb8nnrG97esTIjTF3EEviIKSqxyUGDQzqVhU/MkiHDoxw3ZF/3zXRecVaUq5vmTU9GQvWBZGs4VZhSvi+wNN8mQfau74TPMWKw1PszO//Mr0JT291RasCiXX+qIMS+810wm5Lyi1SCik3D/5cHjvP3JoJeVZcQi+BNr4SfOrWBwTgi6JoWhM88j8RMvtZBWN0rsFu8Gu47QTT3JyT6VY091kfe2ySSgpwCdP2XASuxpkMS1A9g0Wc+W8uZePMaORe290OTGPydVY1fobDWrt4MuXmqCOPhukwkLlMyZBcn8iKTrQDOIg0KLsKymZbCy81AbH0kWD0kfz0H41rJ3xu+owlVtxOl3Bm0QZ8zBKyK/mTWVcLbtnlsacbGlYcuZd7U4DNZaHubU1ieSI9osdHEkzZ1o1U+56+frQH6tLvlnF+O+6VooCeNEJBDfLiFb5IB4z1gcQwixRxPU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(22082099003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IgHJuPvZ23Au2L2v/FSMkUWmX4sipdYsmb54yfcukrjmzNahG68oqt5rx5/p?=
 =?us-ascii?Q?sA9dor1gCMeFaBa7BiuTBDAHX3xY9nmLneFmuBycnXotzaGuBtzIiS3zfT1N?=
 =?us-ascii?Q?luW7P+PYqwrK7CcXytxO8QPlYtk8RRWqbBsXDmIYF3fKfN2yebxNWgReQpgf?=
 =?us-ascii?Q?KacmZNSmhSug5Wp0jkubg0Zlj00MwwnAlWVugrq5NDTIj9LTRgPJr0oV0zK3?=
 =?us-ascii?Q?TYUXeVXaHAH7kltpjwNUjcqrUjXkZo1oQLk9O/6GZrBfnXSO1fpb7ONtduYS?=
 =?us-ascii?Q?tuAwdZlffXdpXfLQAjp3WLYwrd21z/TxKsH4Kt718TJ9YAwRK5q51I/aK5KF?=
 =?us-ascii?Q?DNxQ1apVljgf++RckPUiNaIw8jXz7nrw5YJXZRaBY3A50Vjh4rtI+rQX2iUH?=
 =?us-ascii?Q?kcN8dmjpNWbuFVuLfOcI5r/Is99bF86fe7O6kUbmtNwZvb43CsZhXJDGqvaa?=
 =?us-ascii?Q?bN1tjwpYgnhTJhPqt8hccLbK97KbOc5u/3jt4Li5sLT2ieqNbCb2FmtZrq4N?=
 =?us-ascii?Q?80A9ErZoid15QWM2F8QhReWhYJPRZNGgMmRP0Jg28VpAxHxGL+NBPDnBK+d0?=
 =?us-ascii?Q?v/pTazXHsIqdNhO+4R/vwF4/dQ/sK+Okao0JdhcQ4VkwQCEcZwWFBKoJdnS8?=
 =?us-ascii?Q?17Ykew5RirGCKYyczt02ruPCFBUlrBcWhoYEPbuoBVttBxyBxRaGzrtsS0VF?=
 =?us-ascii?Q?0FR6FSBJhuCnnii2dOb54Gs1I7jsviRIHnXSEogFzGspanMLPuSoGnRf+j2t?=
 =?us-ascii?Q?9MFUWtX1G/EW/a7JH+/pCJ3zgy4aTSe+Z7JNg935C9Nmyr4jdHsLL35o/sDb?=
 =?us-ascii?Q?FCHrwfEJ2U3Eowib98x4S/K6sGkJTv9n25GKUzot8jtZEdyxiwQWw7Gly3Qk?=
 =?us-ascii?Q?mDkTCfV3kW2kd8kwEG+1mI6hKDQZGSe8QVXhJJeb5fGFdqMxNz20fdGl/xYA?=
 =?us-ascii?Q?Lkz20fl/0EA3YyOeVOwMgp4SfmxaPouE2NQTjWpeTENv/hZzwEIGc1V/8/yL?=
 =?us-ascii?Q?74puYW3WLF6PCmAqiXlzPnZh4eaU2FK8xMQrBbtTOaBXZSzx6kbq3IvLfTxl?=
 =?us-ascii?Q?Ucw6P4sIZ1mmcD/lAo/6gm5NVnMhN/lt4sB86NNA4V97VVJ8JdFYYJvUHyRj?=
 =?us-ascii?Q?5YwkEtWTWo3FnM0KIN3wuVwZQZuLtTt/qUSNZpmDG3eApuQcP3z5b0oL590y?=
 =?us-ascii?Q?0uNvcDqWu0zZHob//aVGpq/SGJEjT+AdiCY55DrUBI7mD85dVt7DjgJgL1hr?=
 =?us-ascii?Q?7TnouxcUsvYETGxPhHUYxkq+DJwi40FCPmy2KXy9Mk0VmY2+yPllcJ8iA4TT?=
 =?us-ascii?Q?/EPGLeGcVeorsXlZC0vfvmKixDciWYM5TGhKLiaG6wx0kKxOUwbn55KGJnt0?=
 =?us-ascii?Q?FwLJjC9z5LVxGmNSvkTuajThXurGlbPnqp0RWCJFwZCrBvSoe6jzF+cd4Dx3?=
 =?us-ascii?Q?CrtbfvTCHMlt8+k10bp6ipe85n1/Jbam4AHXI+i2/zthFeDmm4y/MZSmNe7W?=
 =?us-ascii?Q?qBGeiQK5l+UvNAhvZsmc6DVPGcuMCqCWk4GiCMeSoiudejTw99A1zNimED3f?=
 =?us-ascii?Q?ySIOHVML/yKhdsa+WQyQd62Bds+n2fHznWmxDNHJNmbI0HwLR5Pt7+UyZDNW?=
 =?us-ascii?Q?3QY68jNg0YbHJ6L0PzAWuEDhGUPm5RBfEWcdP5agJs5zN6M+LFbCdRV/oDUY?=
 =?us-ascii?Q?0TpYOfua6gX4Ar4d5ifFtNlObAdBnaXAjoIaPD/aCX402fnyR7GWRPobXihP?=
 =?us-ascii?Q?VhafY7B/UQFpczjnqB1ddABCW1Nqf+qgC2GcMYp2HH5yGT+MizH9pFJK/2Oy?=
X-MS-Exchange-AntiSpam-MessageData-1:
	rfEMnjnN5WuTrwxS2JSQ6Jlq4zT4guUN+Wfdq77ge3tcllFsIlDKQTvF
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a77e6b-18ea-4eb6-fe65-08dee750ec95
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:53:08.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgSkHJcopHds12zap1yGpKWP2o1s4wLmSvIdNgZduZQRfxvMJFTajyLW1ogeI4W8L1lwkLUL/qly5MjnbPsV7QuEKXTQkFz/MjRzepCD+w3/q+ikLfDKGP7uX6wh1+oI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425

The mailbox IRQ and shmems are not cleaned up atomically, so there is a
race condition. If the shmem is torn down while the IRQ is active, a late
interrupt can trigger a write to un-mapped memory.
If the shmem is torn down while the IRQ is active, and another thread
requests the channel again, we can end up with a channel that has had
its shmem unmapped.

By moving the map to start up and the unmap to teardown, we can let
the mailbox mechanism prevent re-entrance into the startup/teardown
functions.

Avoid doubly unmapping the region by removing the unmap in the
direct error handler for the request.

Assisted-by: Codex:gpt-5.4
Fixes: fa362ffafa51 ("mailbox: pcc: Always map the shared memory communication address")
Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
---
 drivers/mailbox/pcc.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 636879ae1db7..da26578a8aab 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -360,7 +360,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 struct pcc_mbox_chan *
 pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 {
-	struct pcc_mbox_chan *pcc_mchan;
 	struct pcc_chan_info *pchan;
 	struct mbox_chan *chan;
 	int rc;
@@ -375,20 +374,10 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
 		return ERR_PTR(-EBUSY);
 	}
 
-	pcc_mchan = &pchan->chan;
-	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
-					   pcc_mchan->shmem_size);
-	if (!pcc_mchan->shmem)
-		return ERR_PTR(-ENXIO);
-
 	rc = mbox_bind_client(chan, cl);
-	if (rc) {
-		iounmap(pcc_mchan->shmem);
-		pcc_mchan->shmem = NULL;
-		return ERR_PTR(rc);
-	}
-
-	return pcc_mchan;
+	if (rc)
+		return ERR_PTR(-ENXIO);
+	return  &pchan->chan;
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
 
@@ -400,19 +389,13 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
  */
 void pcc_mbox_free_channel(struct pcc_mbox_chan *pchan)
 {
-	struct mbox_chan *chan = pchan->mchan;
-	struct pcc_chan_info *pchan_info;
-	struct pcc_mbox_chan *pcc_mbox_chan;
+	struct mbox_chan *chan;
 
+	if (!pchan)
+		return;
+	chan = pchan->mchan;
 	if (!chan || !chan->cl)
 		return;
-	pchan_info = chan->con_priv;
-	pcc_mbox_chan = &pchan_info->chan;
-	if (pcc_mbox_chan->shmem) {
-		iounmap(pcc_mbox_chan->shmem);
-		pcc_mbox_chan->shmem = NULL;
-	}
-
 	mbox_free_channel(chan);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
@@ -462,9 +445,15 @@ static bool pcc_last_tx_done(struct mbox_chan *chan)
 static int pcc_startup(struct mbox_chan *chan)
 {
 	struct pcc_chan_info *pchan = chan->con_priv;
+	struct pcc_mbox_chan *pcc_mchan;
 	unsigned long irqflags;
 	int rc;
 
+	pcc_mchan = &pchan->chan;
+	pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
+					   pcc_mchan->shmem_size);
+	if (pcc_mchan->shmem  == NULL)
+		return -ENOMEM;
 	/*
 	 * Clear and acknowledge any pending interrupts on responder channel
 	 * before enabling the interrupt
@@ -479,6 +468,8 @@ static int pcc_startup(struct mbox_chan *chan)
 		if (unlikely(rc)) {
 			dev_err(chan->mbox->dev, "failed to register PCC interrupt %d\n",
 				pchan->plat_irq);
+			iounmap(pcc_mchan->shmem);
+			pcc_mchan->shmem = NULL;
 			return rc;
 		}
 	}
@@ -488,15 +479,22 @@ static int pcc_startup(struct mbox_chan *chan)
 
 /**
  * pcc_shutdown - Called from Mailbox Controller code. Used here
- *		to free the interrupt.
+ *		to free the interrupt and unmap the shared memory.
  * @chan: Pointer to Mailbox channel to shutdown.
  */
 static void pcc_shutdown(struct mbox_chan *chan)
 {
 	struct pcc_chan_info *pchan = chan->con_priv;
+	struct pcc_mbox_chan *pcc_mbox_chan;
 
 	if (pchan->plat_irq > 0)
 		devm_free_irq(chan->mbox->dev, pchan->plat_irq, chan);
+
+	pcc_mbox_chan = &pchan->chan;
+	if (pcc_mbox_chan->shmem) {
+		iounmap(pcc_mbox_chan->shmem);
+		pcc_mbox_chan->shmem = NULL;
+	}
 }
 
 static const struct mbox_chan_ops pcc_chan_ops = {
-- 
2.43.0

