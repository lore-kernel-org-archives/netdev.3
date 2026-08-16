Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7F81AA8
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786884648; cv=fail; b=jGxxDWu+Y9+sswhESHbX7P0G12dLSSO0qFLY0WVMdyc6YkvFkocI2HcxO4MpP7ZVaNJZn+LnJeXBFDlNmhFHie2lVfp09U59zjQrDHbmSV+AK72dyC+PWQb3m+1nQqewQ++rFj5948DQ6R6sZC3vAS4kmUur3LGzn1a76/hi5e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786884648; c=relaxed/simple;
	bh=io75ktw+CcxQ3sXmoMddgawggIkIfdL86Vbqv1+hZYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l5G0lrLyhpAZtuBwVF83eIi4YsvUYCA4oz4RZgHH+V0xYR38ZM2gr/H8udZQEBWupTIkiaBBjBzPy9cAJ5qlS9T8LtfaYxWnwEH7CadFJ/wLBT1XNQfk/tykzPi/xCGLF+j7OJg/oxn6Ryj5uaOcWDgAvF0FWhlDIYBVwy3E3wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=e6JiNQov; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="e6JiNQov"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022126.outbound.protection.outlook.com [40.107.200.126]) by mx-outbound20-226.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 16 Aug 2026 12:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIm3gx3ROLabM7phVI5+Hms2HmLOlWVpUjZaRuCW3z3VxfhsBlHAFHKj6yqy6UBkil+tVGN6Ic/bl7RwzZERjRP/gG7+gErBNPN+3RqFGOYlkh3yRcgdZR4PVLXnQXBMs3wU+4CmPUfAbVFElJGmATkQy3XVMP6o56Rr/IS3pp6Xi945qnw9AEbbcx09+C3AbFeU22NNJ+bjA/9XtwgtTz5KtW6Pj60c0iT7J8pOpmuzMgGRcgx8srAVQxtpKesPa4ORJ6RrGbpej2k9x1f/JB8MXzGaCf8583UAYyTdd4/aK9NK//CVN2RB81bHvlxizAYNU4G4HdlnDqJHe//oPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQIaVo8+5N2ns2M1E605eDlWPIRIULXSL6XkzDbN8U4=;
 b=AY2jVn/7dDT5+sfK6o0qZnRwQG5lav6fIY5gsxOeDWLq/eT/xLu5Hs8C4RcqLzO4GU/Zwv2w/LpCSofn10csBJc+9hMDWXke8f4NVrvfUNEuP5I/1b9UAzi6lEqUCeeA4HDsi0aXSS+HxllxNsjL1Nvr1VZF6xIJopDsyQhhw10iz1klRTZEoqJcJJTMuYoLpJDxgUpLszpk1U4hG2E2S4f9DSktyo9P3C6yngI+EPJ9WZcufm+bLgEpQvCpv0xColZfzdz/rE0KSzzq2OjX8lYzUV4X/AdNNiuzemU4GfflDge0VcbuvYZ5P83g7/TuA4ajx+shfR/VCW9oGSAMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQIaVo8+5N2ns2M1E605eDlWPIRIULXSL6XkzDbN8U4=;
 b=e6JiNQov0puXVZqTqA9tTcAmCW9ObG+vL2yYtR2sGYj1dYMVfmOOMsQMc+VLZ9kO2qW9s10K1POp0zVyCM0IUIfi2Z7tn2BsLCKclzjN5Y18AEzYUtWucwF6oASFDLhL3rhMpBebsiQPQCua6zKQ/FkRhWrZIDxmkl/SbgVKiK2mBTR6/t6PopbuDkQ14/JvwzlILr8HwRk2z6JV4lbgWOMFNi7yLwnAFeNx4tK2GwcrjQvKtxWfEkRStElX5SQ/duzO34yxodN7gkjo6goB6Z3TVpgDZWDVinM2fo6pSDZu0EYwFDTZ8UGmqd25prgYYyD3b+uT2/bNWrpyhAPEmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:17:30 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:17:30 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	mani@kernel.org
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v4 3/3] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Sun, 16 Aug 2026 06:17:05 -0600
Message-ID: <20260816121705.858013-4-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816121705.858013-1-peter.hunt@opengear.com>
References: <20260816121705.858013-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0127.ausprd01.prod.outlook.com
 (2603:10c6:10:1b9::16) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d939f24-63ef-4819-42f2-08defb9057e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|3023799007|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uIM+hqfWsmbczDBON388VtGY0koKTZGo+Cis4ZIYxbmL38Kz7ANaFlrgbquNK8mbr+7n7rJr5KqM/W7+/WA/Mtm2SktXQcHhvjR1OKsOhahgxqBsRDR/PtZJeSsbGE85KfPHOLvJNr7jGZBkyEfB+0q18pAcmnqV15j07SbpiZMaAOXQ83W5VC6MuavIlJ1P04Biv3fNZrGx/AKIqpYoF3yDuOTHAxLbT3X1e1DcN3sjZxTqdR7EyWG2xuc0CZpHrN22YJfc8ewkFHG14R05ymPHWSyTBbQMj5wkB92/k+I+/Yiq4X+Ew+yHWCEGeMoZQHP66OTp1ObnXwycILDpzT7frhntmJL0NpWkyenMCG5skI0TANapqj2Vojl8mQhCVIboTz+4lPQWekpGBXDFqI//o1zYrpsK2utUqh46nPVHmhtm2im4ENwLLwBkvtY9ZZy8tIdL1rV0b7xjHLFMo1OotPrvognCG/m0sOMUFhjBonS92/ZwM0tZ/F6YuSESTRCcbbIJurBTWelmGomxq2GM8ybNreXVAzyyVxUq9B1DDXUjZBsis1cBAaiA3xVYnFD8hddizySWD8jztS/8oaOwqsK8lS66auK8sHYS+1fJ1ANZvmLl1Pe6D07XvLsZ/MWsE9bG1GPiHxSAhrroGZ554Ull1fladx5FnpTJkVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UyzztDOifwqocnywqSdGImPF0osQR1VYUuV2CAZpAGaZq/jZU7KIbox/k01H?=
 =?us-ascii?Q?3zx5DZSipzsvLVRhth5X8ZG5wAfSGHFgT4T7CeyisBEU87zKxxy0GC4PrN93?=
 =?us-ascii?Q?CjkO9jZTQkgXOQ08v/b+ZuJPL/vbcP9wKV8T7oWS+s7VpitR6XhJDcSKG3Ou?=
 =?us-ascii?Q?ekAqR+/O2OGtIqkUBlnLtcrJ5jB6sOyd/6sScHw1Xp+oP1MI1DltZprR99FD?=
 =?us-ascii?Q?xZDtMCN0UGRKzgzFPHQA71yIYVp7e0eL1u5xdV8SzMlwruqaEtEAO2KSqF1G?=
 =?us-ascii?Q?zA77+m2YObu2bREZGgn8iNtwEJiNR9/wLqoduvj7I0DWeSJg69cyfs2mMJ1Z?=
 =?us-ascii?Q?+EpYm3YdQhXq9PPT2Q02IHxJ+VTGgdl5do3qflArMKDayFCZ7H0Zc2pkafyS?=
 =?us-ascii?Q?5V/EF70cCK8F+OtQwm43SdO0Aj5cSLKqD+S+7KIfkOxa2ebCEsE30vRAut0B?=
 =?us-ascii?Q?G9zsfXpGHrKvCCmpqZAXHlhG6TROd7CylSNIhaJjeodI2+2PCGFXheklZLcm?=
 =?us-ascii?Q?zaP7pcwJmHGfVprKFNY3upCnIUngMthnzXl/WEVpghu7+vdoROejwIszzmL8?=
 =?us-ascii?Q?ZgESqz/Eudx8I8iN2Eo6VTzX6FavE217c4MSO6SsJuxNjPC4DeGPGTeAymen?=
 =?us-ascii?Q?L+ktwd1rDR91G6Ram7RhHtE+vbuT6JGcUyh8i4OvBrH9P61M+bkSEh2BQVqH?=
 =?us-ascii?Q?3aQ7czgNURxJXlT3dTEuzfFsjt/NPzWG3H/MqXtaZywV5nOgKA2GIGqgI3tW?=
 =?us-ascii?Q?7PCMCUcwEKBWOme6Iw9wvlcR9WhfI0lah5KZCq4cSV142r5Rv/ITT0Y0ER+P?=
 =?us-ascii?Q?/sWj6f4CI1VkH5RtDPxORBsYX/DhIwzGGL0h9L8kT1gXNQDrv/h5CdmbGEjL?=
 =?us-ascii?Q?e6lH1HDP1rw9Siy9fqM3xJb5xgyTe1P/QVTcderN0dEqnR4VbSyuH0yvaFm1?=
 =?us-ascii?Q?YmAyuk7k+lRddEGbq+xPPKyE0zrn1p818NX7REChvTe9Eb+J90WGWQS9wF20?=
 =?us-ascii?Q?wnyT7IBgWH1B9y+lKlH2614jGiRSHwPWFaIJZ05N6l5JSABoSpVaCxKdZhNd?=
 =?us-ascii?Q?oa6AOVNFY51sWYzMTJeua9oU3xZ8bWz0kaWOu9VID1cvmTEmO75BOK39H/4I?=
 =?us-ascii?Q?nUmew1zArwrWQPhV5PRejEeKf5W6ZW9VejG6z8MQJlC435Zh83Irw077EE1Y?=
 =?us-ascii?Q?DWEbnqPh1fBXE7cYyaQ3Emks5EuNpYbNLVZCrNKynNFZCnmgPkR6rSt4HxDx?=
 =?us-ascii?Q?qPdXml+HCqJplHig2zYRPWtmwsBX42hio0kGihKoMo5/QfvQkw0WZLEgXmCJ?=
 =?us-ascii?Q?k3Hc58MVdW11u7ERPj8P1oMuocSaXA0OXBTZvFVTvXvAcdTPwfzgSVPOiZam?=
 =?us-ascii?Q?U3Ry8a94WmCNPmItuJe2mhCjULkxC1ItRlCH/MnINjodNmXglODAo+raDSUw?=
 =?us-ascii?Q?bL4dZcucmMMP6QtiDfxnDCrq1AWWyFBPTuWYL6mvYmC/nbgj69zLdcJsJe9L?=
 =?us-ascii?Q?/iWy+B8i9ike6c4D17RDdOjd/l5Oir8Mw0p3qTnTjGgF1D12rczXDzr8+3K7?=
 =?us-ascii?Q?oyW2QEIsLRq2H7UjlDxbGYLq9sYM7sTtUAjHU1BLcxQ5/Bk6DUmMsfLEdy/Z?=
 =?us-ascii?Q?MR+x78ti6Y3qG6RFKIP7fRCfpEoZFIzCM3judpME6WgzOGx6btlnMPEj3nuD?=
 =?us-ascii?Q?NcUvw3cb7YioxVZDR5P3TPMQruaXAVCool7Gnz/USlE2clbf?=
X-Exchange-RoutingPolicyChecked:
	dr7QUDC63xDyzRKQOuqQ2g8/Kpk9sOj2QelFeY/Os6y8WRd5tszBeEMSKdMuUhzQBEe4WSuHs5t36EOkXxZDUMk6kM3xjX2JL4lssgK3HRGD0glWWZgKueaxI493PT1d0/hZrtLZWmTB9CUBRWSqRdPilCYy1a2CucAtyNrCnwP28hnpV7MglJC8Tu+F6XBuJW9J3SDpdr00Ig9aa525Qo8tgnoim+nea6iJm0mKviYeTxUDbNdRyTXwv/C+YROZrHw5d2+0P7D7oEOSuTndKPwvbrR3fAHG7e8vWetfkKNccgNRJdYd+pv1fBbrdXk6zgFTo+hHGjvrPFh0x0L1lA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d939f24-63ef-4819-42f2-08defb9057e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:17:30.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWHwhoByftI5pNovp2r/nFaotCZbUH6HY+gMWI0y4SGYkQsmcBI6tRnQDxny+Jt0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-OriginatorOrg: opengear.com
X-BESS-ID: 1786884643-105346-7729-7751-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 40.107.200.126
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuamFqZAVgZQMNEw2cgs2SzNJD
	nFyDLZMNXIzNDMxNTYzNjSKNHSMtlEqTYWAJZjcLNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275424 [from 
	cloudscan23-110.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Qualcomm/Sierra SDX55/SDX65 modems (e.g. Sierra EM9291) withhold
unsolicited AT result codes (URCs such as +CREG, and the +DMI OMA-DM/LwM2M
session indications) on an AT port until the host asserts DTR.
mhi_wwan_ctrl exposed the AT (DUN) ports but had no way to signal DTR, so
URCs never reached userspace.

Carry the host serial-control lines to the modem over the dedicated
IP_CTRL MHI channel, which this module now also binds. IP_CTRL uses a
separate mhi_driver with its own callbacks so the AT/QMI/MBIM data path is
untouched; the control-channel device for each MHI controller is tracked
in a small registry so an AT port drives the IP_CTRL channel of its own
modem (multiple modems are supported).

The wwan core (patch 1) raises DTR/RTS on first open and drops them on
last close for any AT port whose driver implements ->dtr_rts, so no
open/close handling is needed here. The new ->dtr_rts op lets userspace
assert or de-assert them via TIOCMSET/TIOCMBIC/TIOCMBIS. Received
device->host serial state is not needed and is ignored.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v4: Add dev_dbg when IP_CTRL channel is not enumerated for this controller
    and when mhi_queue_buf fails, to aid diagnosis of the "URCs missing"
    case on controllers that do not declare IP_CTRL
v3: Remove is_at_port; implement ->dtr_rts instead of ->tiocmset;
    open/close DTR raise/drop handled by wwan core (Loic Poulain)
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 178 ++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..a917df9bb17b 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/mhi.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/termios.h>
 #include <linux/wwan.h>
 
 /* MHI wwan flags */
@@ -14,6 +18,30 @@ enum mhi_wwan_flags {
 
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
+};
+
+static LIST_HEAD(mhi_wwan_dtr_list);
+static DEFINE_MUTEX(mhi_wwan_dtr_lock);
+
 struct mhi_wwan_dev {
 	/* Lower level is a mhi dev, upper level is a wwan port */
 	struct mhi_device *mhi_dev;
@@ -103,6 +131,62 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
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
+static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, bool on)
+{
+	mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port),
+			       on ? TIOCM_DTR | TIOCM_RTS : 0);
+}
+
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
@@ -163,6 +247,7 @@ static const struct wwan_port_ops wwan_pops = {
 	.start = mhi_wwan_ctrl_start,
 	.stop = mhi_wwan_ctrl_stop,
 	.tx = mhi_wwan_ctrl_tx,
+	.dtr_rts = mhi_wwan_ctrl_dtr_rts,
 };
 
 static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
@@ -255,6 +340,59 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
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
+static void mhi_wwan_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
+				    struct mhi_result *mhi_result)
+{
+	/* Modem serial state is not needed, drop it */
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
+	ret = mhi_prepare_for_transfer(mhi_dev);
+	if (ret) {
+		kfree(dtr);
+		return ret;
+	}
+
+	dtr->cntrl = mhi_dev->mhi_cntrl;
+	dtr->mhi_dev = mhi_dev;
+	dev_set_drvdata(&mhi_dev->dev, dtr);
+
+	mutex_lock(&mhi_wwan_dtr_lock);
+	list_add(&dtr->node, &mhi_wwan_dtr_list);
+	mutex_unlock(&mhi_wwan_dtr_lock);
+
+	return 0;
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
+	kfree(dtr);
+}
+
 static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "DUN", .driver_data = WWAN_PORT_AT },
 	{ .chan = "DUN2", .driver_data = WWAN_PORT_AT },
@@ -278,7 +416,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
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

