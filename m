Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DAD4DF4B4;
	Wed,  7 Oct 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397401; cv=fail; b=VnjL10d9qvNpDLQPRFpLgi9W2txR/sEj8ybj5APE+zSv8xQpFD1gGMuy/sqByKeJUEyn1ISD+ni2ZupQ7yU0FFYM52gTdEJfEe6NxQnAU9sPKgDcF+1N0BHRzwaihqpIxWsmV7kIJCXlhoB5ppikdkz0eiVp9NhVlEKGIC+rgDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397401; c=relaxed/simple;
	bh=J7QH/zY/wLDciJH0UsOrQ+H5CvWmLg+Vf7/TaVWrVvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWu5VCD6WIYvw2fYhzRWGt3pejRTXBryvzSYJktGgpO7LivhQQ2I9UF5NiAaD6fKO+IF3fAvY6Rrowlge95XNkusKisJb5dyr/fbGgvmUmAeJJgjScl2XnWuLvWw2oA81hU3QGdKANvfDNgY/RS2i+GRlcUsReXBlTCqxLeLSgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=XKRsEb5a; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="XKRsEb5a"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020103.outbound.protection.outlook.com [52.101.46.103]) by mx-outbound13-181.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 07 Oct 2026 18:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goKmes4voabCJkJQu4bxOgNmFYXQNz1bOXXgCJG+MrrM5EPJ+6q3MzuifXrcJslchc+QLJpk0mQe8jkq7J5bqLhtoxqfWLW3jW1S6h9PJQRmn3bQFB59UJMRXwKMpl0dekvc8cgn3gh4PX6DaYTToJQPaCD81fncYi3fa4AIFSzuCvN7QQZ2AjkiHDE0RqdWTYkfBFgDZPXFLSYxb5X/nNBeZBGnaYfqnE2vZ4lgqqL8J54SB0ZhWeJjNwyqj/+LH65Oe4RRUjsSYAiFM1aF+VBLadC369g4AaLAzRe4bN6cb3lhEtVU+l9oxKWTfjqGAAAqwdn5aziY+BlE62wvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XQpAvw9RcR01BruDnkTDpwkh5aLofsPNeU2RBnxWoc=;
 b=fdpmbsZOR7KGRBmzPoEFdVdfGfbR519Qluqk82Z2nUKkPHKi03qWtI7a270z2W/iLrRYTI1Pys2Opmj0Cr+yqlX9EXvgITdojANggiUtDZI2SN9w39T2y00n9LCCkcNLQGPNaID8eQGDjHaDBxC25EyKrsio8EYE51Rtz9aWiHXkr2RPIOeSdsxdc393K5ZEkCOQI/bTJIRz82ldsji4IbRdhoCtsm01J9fKriyuPxj6h7S7dl6ic/PeDMq0+BIv1umVmvgoUr7kOEciQ30a3pfC3pmi8L9GkzrCjeurHqqsPGJLgp50bD0tOqYU0bhm6f0dmM6ZR9u8qwNiD2/JkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XQpAvw9RcR01BruDnkTDpwkh5aLofsPNeU2RBnxWoc=;
 b=XKRsEb5aF+oMe2tJVzCnR6vhYoYzMxrE75R5aHA7c6nA5hadKODSeaAE9a8V/FIrw7NXISJYaf8no6v07SPrpIJ8IwJJhc6Tn3JJJGihuxlzBtAjZ/psb+VHCY7ol2m/uC/vfZzIYcOp8R/T4HIYShofpoulxHe6rk2WJ+6+3Z+zoCyinXOoCkdn822DXF0QF3hEELccUwo8nCMditponCOKoMNSV/5nm21ye7F7kHY++zGM4zK9J0Cgx+NMeTlwXzM2Cj8Yg3yCEh3mW4DYQ/Ro9jXe0ik4wD9xMceX5CjJMIicf/eYI0g0A0ERTpWoNOg1Q7E2pCFvplm+u7OriQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by LV3PR10MB8057.namprd10.prod.outlook.com
 (2603:10b6:408:291::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 18:22:45 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 18:22:45 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	mani@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v8 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Wed,  7 Oct 2026 12:22:38 -0600
Message-ID: <20261007182238.1154851-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007182238.1154851-1-peter.hunt@opengear.com>
References: <20261007182238.1154851-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:a03:254::25) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|LV3PR10MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: faff62c0-4d41-48b5-0ecd-08df249ffba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	35T5IeppaBFxQ0DxUYjoq5K24mui+nocYwwqo/8aM3ezcJ+2RQodvdh1ZyOPMJEFl1vn9tj3mQREI5VCk1hFVy05SSbmlZ0pg1fCxz8vPSROeyNlnM4ezEw9VDe2U/XHsMV+ZW66nWHHM512zm+R1d8YXeTH9EwwexrHqyMQ6y2ucMzzg4A7OLNbuFc1h05AurJkKLC/bmAwxou5MBiCTSPwIGwutDU1XQnv4jDiTbQvJXr8acEeGO2Ko4twdj9ZptotKYFLroS8CrC02HoOsQbnl/YVkvughy8cIUysHtN1qsheHTNxJO235FnjStsqPYQNU+SidmcfQYM7coeoJFRLZlK4ARkPA01Q6DGcr7312Lf/Jhg/C93Zz3H9L2iSvOeKNwMQxe5hWEtqtR4irf6PoCCQi3in6mGigrUWIax+y7CjrWp94BLL/aMEMe/wxP5mFfaRpiD+B9qWiDiRdb9xSmKe3/rGylAU+db5jAXQJRW1lQpbVlPegwKEpusMkUrG9HMLoDs1LOHoxGozEZzNm6VW5kkaI4UPaSm2AyH6KdtpZNtk0Xa4+sn3HMgaWjxiPUkt1ijW5tfZpNW0ru6fgoDoQAyjonQc8reyi8Ah1ZcQEd+EYwLNmAxwKiCJLDPFiInpxd1h+A4iU7O4yXwcJ7u/WLIMi1LT9Kfhpo4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y78e0JY9VAzCKOzkYsRQ1MPB0n7b7cal/AvFPfjeOENr7dvyaDYTQh/Tc3qC?=
 =?us-ascii?Q?dOd+GA5O+/JO/3iVhggaDi+v7baOhjlXQKjdKNHeAGmydpi741A+L46Oy9sA?=
 =?us-ascii?Q?txZpzhPyRVVy8vkmK644RlRxXkRW2sUhmuyLJQ/Mdz8C8ze5A2Y3t8+WHRVD?=
 =?us-ascii?Q?lg+MXTZ2FLO1e5GcIJNLd3cjm4OBb9EOsGGDMRnzqcwIw8Qfxp+RkMBI9PUm?=
 =?us-ascii?Q?9C9sS/boBPCJi8gP5Q7ehhU/KK9SyvpWZB3XSv2FzpwRSa/UCj3E/3vAqRGe?=
 =?us-ascii?Q?2kTS8B08Q2lArxZYFhs0BxUMy3vAla9eRkhUQ9HR/Xvsnv1CXiT6GywBKPEJ?=
 =?us-ascii?Q?IaYjaX8kBQUm9Z7Mdw9FAMv1pgVdhfZW7ti8rDp7I86X7To2Q3etnAff6Smu?=
 =?us-ascii?Q?SBT8RQTdYUVOB/38WX5JMmW8B5jbX0W1Eu9nFfvM28wSkQZ0UM6UIgsDuf4x?=
 =?us-ascii?Q?TTl+btA3hPWn73pWLHv+cJk8G9iiMeZy7ofonoqZHr1/67YpkiO0ooilYHau?=
 =?us-ascii?Q?gqlFlVsSvwQ6JJvoRsQm0Tfi4oKUUURiuMmIoArx3R7fyDy7f8efzDW36Mxz?=
 =?us-ascii?Q?KevXSVPzLLoauvmdpFVUxXNWY32Z+peghXFgymvqwvt8jjomYggZ2I5an6I8?=
 =?us-ascii?Q?H5LlZnCeKvBcKsh1Y82IKpN/XNdgr61G7DPJjySpHL8wGstT/0cXjYDn1WfT?=
 =?us-ascii?Q?M5oIyq/OSBtxU+rieUtqlXxvgZn1c30alKSg5BhBDUcv6vpQPVo2+Jrn3ZLl?=
 =?us-ascii?Q?YyAES2FI70TaTVyzpUcBlS64wLllCfnFK0yx+wVZTFNxzq+M3R/ovKY9o/pd?=
 =?us-ascii?Q?LSOMBzOgLi5ozL27/3BPEOhdqQu9IKxRzJ6wGIKGPdBCLvfU/3sadUkamqml?=
 =?us-ascii?Q?6WMbSxRKIp5Mz8TXSKTt+Iv3P9VaJW599BjYDbv52tgnxOd65O1Fvsw5E8kR?=
 =?us-ascii?Q?kiCk6GUl3gkQWrw4R3PS8K3PNw3ebucDClLhUFs3XF0SItYuZZf4WWXxNJbD?=
 =?us-ascii?Q?Est3D3NG9DNYpdgc9Ee1EjNd/nQMhUZtUrTBLrmc82yc2t8l7F3MqALGqUZ5?=
 =?us-ascii?Q?AG9C8TTjbky1FhNRV29HK78N4BenQvJQ8va/LAcFXliBX9r3Np2SnHSa6iaO?=
 =?us-ascii?Q?06aQ+cXFmU4It/34smWIejqgrFaJiB9Um8Xt296aUgYJ5EeZCOgH0CVEeoo5?=
 =?us-ascii?Q?6dEqA/TC04X74gmL8MLQFB7elfEBD9ySlAkaoqOpg/d54wNgc7Pm2LZP2dRg?=
 =?us-ascii?Q?R1N4alJ1SXPcg2GG4pZfuN3YFrn23LvSdhzXnTuVx2BlFfcn/QfGfREvDxvm?=
 =?us-ascii?Q?Gms4otqt6Hk+R8gXKTequ9lrPTc8Slgfa81u1veySXng3CUcWQgYMzO06UUz?=
 =?us-ascii?Q?nMnghu25LugvhdUXNYRQ4bktuCzFLV18yGGSHX4z8G7j0jMUi1qYioRNIeRN?=
 =?us-ascii?Q?/Ra5YFdA828//wl+ovAGnu69r0sOdHlG51yaPGtKh5NybW5NSRZ3J94eBqIv?=
 =?us-ascii?Q?3zTeCoi7KSMbEwOnDVApUpjxVQf6lBcxMMP7BDhdiUy8PkVD1f+Ap4/oqyvK?=
 =?us-ascii?Q?fjgh2VhOOkRwqiwhc9i7A/T4ZFjskljGb/m9VBC5/sa5nNA/zkCXZwpCodiH?=
 =?us-ascii?Q?BTHTYLJbsfoPdBBDE15/wpK8NFICfer4TWFvTxoh21SqCuMmnOGTcEkGQjeG?=
 =?us-ascii?Q?QgFGmUBhFOknrRS0AC00ItTVTGlk6p4/wcpm1++tFdScQh4h?=
X-Exchange-RoutingPolicyChecked:
	cK3hNRgeBqQd7E0Sm0bW6FCEFlIgvLKoE4GLeGTfcKnEdKzSTC7tu9Co/8dnedJ2fK0C3abYv1i3MhQ1y3hhxKCAxyjmIDhu0cOyCItsRiYTlO7FCbHlWNfjTpEUYBfBfZ0ijC3Ic5OFZiYJpGC5wlAf2EkaNu0+Ocl27QIMUeR5RBpJpVclqXojwxBoMa97mm7gQCOgNJ8gjU78eYriybMZeNtNtTk66iRleLZIZ2bmRq2pDlA6OdIlIVOA/3mG1JvLrLCeGv57EeFsl2PE83twN1hop9rqCaZll0/qzALd3pPyzhOToNBIuC35He0rO2kAvOoUmYD4ErtOxSr1WQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faff62c0-4d41-48b5-0ecd-08df249ffba1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:22:45.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzGpPPRx1dSwqpRjOk6S4LverMQtu3LIXre1GeGTMhu7R9hbjLP5ZDAXyNAEdq09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8057
X-BESS-ID: 1791397370-103509-9706-11800-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.46.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGxmbmQGYGUDTZ0sjU1NAkJd
	XQwizRODXFwsTMNNnM3DQ5Ock0xcw4Wak2FgDsZeWkQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276674 [from 
	cloudscan15-127.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Qualcomm/Sierra SDX55/SDX65 modems withhold unsolicited AT result codes
(URCs such as +CREG, and the +DMI OMA-DM/LwM2M session indications) on
an AT port until the host asserts DTR. mhi_wwan_ctrl exposed the AT
(DUN) ports but had no way to signal DTR, so URCs never reached
userspace.

Carry the host serial-control lines to the modem over the dedicated
IP_CTRL MHI channel, which this module now also binds. IP_CTRL uses a
separate mhi_driver with its own callbacks so the AT/QMI/MBIM data path
is untouched; the control-channel device for each MHI controller is
tracked in a small registry so an AT port drives the IP_CTRL channel of
its own modem (multiple modems are supported).

The IP_CTRL channel has to be declared in the controller's channel config
for this driver to bind. For the Sierra EM919x/EM929x this is done by
commit 83c29a55b89e ("bus: mhi: host: pci_generic: Add IP_CTRL channel
for Sierra EM919x/EM929x") in the MHI tree. On controllers that do not
declare IP_CTRL the driver does not bind and ->dtr_rts is a no-op.

The wwan core (patch 1) raises DTR/RTS on first open and drops them on
last close (if HUPCL is set) for any AT port whose driver implements
->dtr_rts, so no open/close handling is needed here. The new ->dtr_rts
op lets userspace assert or de-assert them via
TIOCMSET/TIOCMBIC/TIOCMBIS. Received device->host serial state messages
are silently discarded; a single recycled sink buffer keeps the IP_CTRL
DL ring live so the modem's transmit path does not stall.

->dtr_rts is void, following the tty_port_operations model it is modelled
on. Delivery is best-effort: at_data.mdmbits always reflects the committed
userspace intent for TIOCMGET regardless of whether the IP_CTRL message was
queued, and the next ioctl or open/close cycle will resynchronise the modem
state. If requeueing the DL sink buffer fails with a transient -ENOMEM it
is retried from a work item, so the DL ring does not stay empty.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v8: No changes
v7: Retry a failed DL sink buffer requeue from a delayed work item on
    -ENOMEM, and log other failures. Note the dependency on the IP_CTRL
    channel entry in pci_generic, now in the MHI tree. Both from the
    Sashiko review of v6
v6: Rebase onto net-next. Allocate the IP_CTRL DL sink buffer separately
    instead of embedding it in struct mhi_wwan_dtr, so DMA cache
    maintenance on non-coherent platforms cannot touch neighbouring fields.
    Do not requeue the sink buffer from the DL callback when the transfer
    completes with an error (e.g. -ENOTCONN during channel teardown)
v5: Implement ->dtr_rts(port, mdmbits) and drive DTR and RTS
    independently. Pre-queue an RX sink buffer in probe and requeue it in
    the DL callback so the IP_CTRL DL ring does not run empty and stall
    the modem's transmit path
v4: Add dev_dbg when IP_CTRL channel is not enumerated for this controller
    and when mhi_queue_buf fails, to aid diagnosis of the "URCs missing"
    case on controllers that do not declare IP_CTRL
v3: Remove is_at_port, implement ->dtr_rts instead of ->tiocmset,
    open/close DTR raise/drop handled by wwan core (Loic Poulain)
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 239 ++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..feb9c03b6392 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -1,8 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mhi.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/termios.h>
+#include <linux/workqueue.h>
 #include <linux/wwan.h>
 
 /* MHI wwan flags */
@@ -14,6 +19,32 @@ enum mhi_wwan_flags {
 
 #define MHI_WWAN_MAX_MTU	0x8000
 
+/* IP_CTRL channel message that sets the modem's DTR/RTS control lines */
+struct mhi_dtr_ctrl_msg {
+	__le32 preamble;
+	__le32 msg_id;
+	__le32 dest_id;
+	__le32 size;
+	__le32 msg;
+} __packed;
+
+#define MHI_DTR_CTRL_MAGIC	0x4C525443	/* 'CTRL' */
+#define MHI_DTR_MSG_DTR		BIT(0)
+#define MHI_DTR_MSG_RTS		BIT(1)
+#define MHI_DTR_HOST_STATE	0x10
+
+/* Per-controller IP_CTRL channel, used to signal DTR/RTS to that modem */
+struct mhi_wwan_dtr {
+	struct mhi_controller *cntrl;
+	struct mhi_device *mhi_dev;
+	struct list_head node;
+	struct mhi_dtr_ctrl_msg *rx_buf; /* DL sink, separate allocation for DMA safety */
+	struct delayed_work rx_refill; /* retries a failed sink buffer requeue */
+};
+
+static LIST_HEAD(mhi_wwan_dtr_list);
+static DEFINE_MUTEX(mhi_wwan_dtr_lock);
+
 struct mhi_wwan_dev {
 	/* Lower level is a mhi dev, upper level is a wwan port */
 	struct mhi_device *mhi_dev;
@@ -103,6 +134,61 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
 	}
 }
 
+/* Signal the modem's DTR/RTS lines over its own controller's IP_CTRL channel */
+static int mhi_wwan_ctrl_send_dtr(struct mhi_wwan_dev *mhiwwan, unsigned int mdmbits)
+{
+	struct mhi_controller *cntrl = mhiwwan->mhi_dev->mhi_cntrl;
+	struct mhi_device *ctrl_dev = NULL;
+	struct mhi_dtr_ctrl_msg *dtr_msg;
+	struct mhi_wwan_dtr *dtr;
+	u32 msg = 0;
+	int ret;
+
+	guard(mutex)(&mhi_wwan_dtr_lock);
+
+	list_for_each_entry(dtr, &mhi_wwan_dtr_list, node) {
+		if (dtr->cntrl == cntrl) {
+			ctrl_dev = dtr->mhi_dev;
+			break;
+		}
+	}
+	if (!ctrl_dev) {
+		dev_dbg(&mhiwwan->mhi_dev->dev,
+			"IP_CTRL not enumerated; DTR/RTS not signalled to modem\n");
+		return 0;
+	}
+
+	dtr_msg = kzalloc_obj(*dtr_msg);
+	if (!dtr_msg)
+		return -ENOMEM;
+
+	if (mdmbits & TIOCM_DTR)
+		msg |= MHI_DTR_MSG_DTR;
+	if (mdmbits & TIOCM_RTS)
+		msg |= MHI_DTR_MSG_RTS;
+
+	dtr_msg->preamble = cpu_to_le32(MHI_DTR_CTRL_MAGIC);
+	dtr_msg->msg_id = cpu_to_le32(MHI_DTR_HOST_STATE);
+	dtr_msg->dest_id = cpu_to_le32(mhiwwan->mhi_dev->ul_chan_id);
+	dtr_msg->size = cpu_to_le32(sizeof(__le32));
+	dtr_msg->msg = cpu_to_le32(msg);
+
+	ret = mhi_queue_buf(ctrl_dev, DMA_TO_DEVICE, dtr_msg, sizeof(*dtr_msg),
+			    MHI_EOT);
+	if (ret) {
+		dev_dbg(&mhiwwan->mhi_dev->dev,
+			"failed to queue DTR/RTS signal: %d\n", ret);
+		kfree(dtr_msg);
+	}
+
+	return ret;
+}
+
+static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
+{
+	mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port), mdmbits);
+}
+
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
@@ -163,6 +249,7 @@ static const struct wwan_port_ops wwan_pops = {
 	.start = mhi_wwan_ctrl_start,
 	.stop = mhi_wwan_ctrl_stop,
 	.tx = mhi_wwan_ctrl_tx,
+	.dtr_rts = mhi_wwan_ctrl_dtr_rts,
 };
 
 static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
@@ -255,6 +342,118 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
 	kfree(mhiwwan);
 }
 
+/* IP_CTRL channel driver, bound separately so the data-port path is untouched */
+static void mhi_wwan_dtr_ul_xfer_cb(struct mhi_device *mhi_dev,
+				    struct mhi_result *mhi_result)
+{
+	/* MHI core has done with the buffer, release it */
+	kfree(mhi_result->buf_addr);
+}
+
+/* Requeue the single DL sink buffer so the IP_CTRL DL ring never runs empty.
+ * A transient mapping failure is retried from a work item, other errors mean
+ * the channel is going away and the next probe queues a fresh buffer.
+ */
+static void mhi_wwan_dtr_queue_rx(struct mhi_wwan_dtr *dtr)
+{
+	int ret;
+
+	ret = mhi_queue_buf(dtr->mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
+			    sizeof(*dtr->rx_buf), MHI_EOT);
+	if (ret == -ENOMEM) {
+		dev_warn_ratelimited(&dtr->mhi_dev->dev,
+				     "failed to requeue IP_CTRL RX buffer, retrying\n");
+		schedule_delayed_work(&dtr->rx_refill, msecs_to_jiffies(100));
+	} else if (ret) {
+		dev_dbg(&dtr->mhi_dev->dev,
+			"failed to requeue IP_CTRL RX buffer: %d\n", ret);
+	}
+}
+
+static void mhi_wwan_dtr_refill_work(struct work_struct *work)
+{
+	struct mhi_wwan_dtr *dtr = container_of(to_delayed_work(work),
+						struct mhi_wwan_dtr, rx_refill);
+
+	mhi_wwan_dtr_queue_rx(dtr);
+}
+
+static void mhi_wwan_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
+				    struct mhi_result *mhi_result)
+{
+	struct mhi_wwan_dtr *dtr = dev_get_drvdata(&mhi_dev->dev);
+
+	/* Channel is being torn down (e.g. -ENOTCONN), do not requeue */
+	if (mhi_result->transaction_status &&
+	    mhi_result->transaction_status != -EOVERFLOW)
+		return;
+
+	/* Modem serial state not needed, requeue the sink buffer to keep DL ring live */
+	mhi_wwan_dtr_queue_rx(dtr);
+}
+
+static int mhi_wwan_dtr_probe(struct mhi_device *mhi_dev,
+			      const struct mhi_device_id *id)
+{
+	struct mhi_wwan_dtr *dtr;
+	int ret;
+
+	dtr = kzalloc_obj(*dtr);
+	if (!dtr)
+		return -ENOMEM;
+
+	dtr->rx_buf = kmalloc_obj(*dtr->rx_buf);
+	if (!dtr->rx_buf) {
+		ret = -ENOMEM;
+		goto err_free_dtr;
+	}
+	INIT_DELAYED_WORK(&dtr->rx_refill, mhi_wwan_dtr_refill_work);
+
+	ret = mhi_prepare_for_transfer(mhi_dev);
+	if (ret)
+		goto err_free_buf;
+
+	dtr->cntrl = mhi_dev->mhi_cntrl;
+	dtr->mhi_dev = mhi_dev;
+	dev_set_drvdata(&mhi_dev->dev, dtr);
+
+	ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
+			    sizeof(*dtr->rx_buf), MHI_EOT);
+	if (ret)
+		goto err_unprepare;
+
+	mutex_lock(&mhi_wwan_dtr_lock);
+	list_add(&dtr->node, &mhi_wwan_dtr_list);
+	mutex_unlock(&mhi_wwan_dtr_lock);
+
+	return 0;
+
+err_unprepare:
+	mhi_unprepare_from_transfer(mhi_dev);
+err_free_buf:
+	kfree(dtr->rx_buf);
+err_free_dtr:
+	kfree(dtr);
+	return ret;
+}
+
+static void mhi_wwan_dtr_remove(struct mhi_device *mhi_dev)
+{
+	struct mhi_wwan_dtr *dtr = dev_get_drvdata(&mhi_dev->dev);
+
+	mutex_lock(&mhi_wwan_dtr_lock);
+	list_del(&dtr->node);
+	mutex_unlock(&mhi_wwan_dtr_lock);
+
+	mhi_unprepare_from_transfer(mhi_dev);
+	/* No DL callbacks after unprepare, and a pending retry now fails on
+	 * the disabled channel without rescheduling
+	 */
+	cancel_delayed_work_sync(&dtr->rx_refill);
+	kfree(dtr->rx_buf);
+	kfree(dtr);
+}
+
 static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "DUN", .driver_data = WWAN_PORT_AT },
 	{ .chan = "DUN2", .driver_data = WWAN_PORT_AT },
@@ -278,7 +477,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
 	},
 };
 
-module_mhi_driver(mhi_wwan_ctrl_driver);
+static const struct mhi_device_id mhi_wwan_dtr_match_table[] = {
+	{ .chan = "IP_CTRL" },
+	{},
+};
+MODULE_DEVICE_TABLE(mhi, mhi_wwan_dtr_match_table);
+
+static struct mhi_driver mhi_wwan_dtr_driver = {
+	.id_table = mhi_wwan_dtr_match_table,
+	.remove = mhi_wwan_dtr_remove,
+	.probe = mhi_wwan_dtr_probe,
+	.ul_xfer_cb = mhi_wwan_dtr_ul_xfer_cb,
+	.dl_xfer_cb = mhi_wwan_dtr_dl_xfer_cb,
+	.driver = {
+		.name = "mhi_wwan_dtr",
+	},
+};
+
+static int __init mhi_wwan_ctrl_init(void)
+{
+	int ret;
+
+	ret = mhi_driver_register(&mhi_wwan_dtr_driver);
+	if (ret)
+		return ret;
+
+	ret = mhi_driver_register(&mhi_wwan_ctrl_driver);
+	if (ret)
+		mhi_driver_unregister(&mhi_wwan_dtr_driver);
+
+	return ret;
+}
+module_init(mhi_wwan_ctrl_init);
+
+static void __exit mhi_wwan_ctrl_exit(void)
+{
+	mhi_driver_unregister(&mhi_wwan_ctrl_driver);
+	mhi_driver_unregister(&mhi_wwan_dtr_driver);
+}
+module_exit(mhi_wwan_ctrl_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MHI WWAN CTRL Driver");
-- 
2.43.0

