Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E330483818;
	Thu,  6 Aug 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031676; cv=fail; b=aqsCbc+0Guwa3jriixzuj8VmuBibLlvPXq8qqENmPTrLRKIvra25eFqRdU/oIA/9LbVzhB4eesyn8O/ZeHy84waXWknnuznjyUAvrFcomzXZ5O3IitrtmiJJFSQmj65Hb/5uzh+UT8z8WBTTXc7rDRqI1ccUSoR6b2XJbmz2n7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031676; c=relaxed/simple;
	bh=5nFrqVADIOAXHk5E4LtElK6uK5xYm9fmvOpnQ+kdGkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwrOAGqYhx17qhVlxhzvecXaqzUwle7vFk25d1ZLSmrgHMgiD4hrVria8u3tUJZNL6E+x6H08sImAHB49o36D32a0gWEtK/c3fLXcpr4fFeyBHTfm9IztYkKyz0lDYX/QYPJ7lEF+vFmYSFnpF9xGxVZSBgr1MMZGCFn6+tA9h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=Vk637Lee; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="Vk637Lee"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021115.outbound.protection.outlook.com [52.101.52.115]) by mx-outbound42-229.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 06 Aug 2026 15:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLUXOa3rwTMcUaJzX0/s8VN+0vMGq8Dxz6Nr/fusTHATFFKLQMZg4O5lkp6CyAyXVJGtCzJud9h0tZKgwuo+17iWosQ12MORNE4xJTBEI+zqRU90cFqTmdBkhjZ24BirKmXUGoUkFBbfKWVKrrwSs7aGSo0gX1YZIO25H0R7LU1Zm0x2kJp3DxKJhI/woBvjEZz50UVzy6HWcc1hS/5mqKl6fT0nytY2cSSR2bNr1nQAnongBTtPGWFop7/jBmZMAeb314EeT4aUSV5e6AukJmLqrmef2IZqaP++uHQrr1v0ZICl1hFWFrhbEw3tdD1uO4JDdWirNhu7B+lXIPPr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXujT9uMlRev3VwN6I3NFsudedHDx9YoH/kwIE4AJz4=;
 b=uiUwIhD1CZvWZIFgDJvi9IrW+JoeAyXjuXXwY2hV3MHr1mqGEydNTVRAiNn8wFP1WOcqs3+76vBTUOkg2FWUoR5Infod1rDX43zIOj6rB0wz+DrjjFmzi9H7hJlxlwZRWwJG0HKbXC2hYXziNcO+Y3Iek7TYTmh3EBEHxjDChmerWUbLQNQFny/m052dWleumEv5SaaVUFB2EyNUNBewJmp0nwi4AS9fLvo8yQqzGThGZ6M3Qm08Ht20GCvo3kTN1u1Z2q2DK+EweHwJK3rOzxZ5JD92Wh9upodzE466VJCOz29K77vuc3CUqBb7g49l+W8M0TpUyNj2ixBcrlVicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXujT9uMlRev3VwN6I3NFsudedHDx9YoH/kwIE4AJz4=;
 b=Vk637LeetOoIFB8ndIFrWGShw8zPleeUrQw55pG8mBL1nSP3jjGgD/FzDt1aeMgvFkgP5pLjRtdPSaZXH0W6q6kfcZa+Xu537btZBg1Gawf4owugoB478gLX4/srg40hSikIYQgjoeETkapZSCV0gSJFsKc60ZI/YaDLgpS2UbenrKpjsgCVtqE5nrAU2PEEf2RmiscQmZDqHhOmipDaRnmDK+aP2iY86Phyml/oPLC6tm5wS9y3bLEQZWBplepupbPn5QEDrB37HZK/Zk6n/vMl2blDZrfKM0LPyq5oISktFBuZljA1Njhz6iEnCBjpBDWPR/rQyUu8aI68/eNXNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 15:53:04 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:53:04 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: mani@kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v2 3/3] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Thu,  6 Aug 2026 09:52:53 -0600
Message-ID: <20260806155253.3378294-4-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806155253.3378294-1-peter.hunt@opengear.com>
References: <20260806155253.3378294-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::26) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f609689-38af-44de-70b3-08def3d2ccea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	89z49wQqDs56L1PYPAn2pBMkHMsv3gNz3gDVSWiRKnX50F0pwxAchy+hJeKkx2w5SiQUkNVUParRur2REgLsGgvT6dC3WK6Mt9FSzi7JpxkMaBXlQdX6kn28+JivttYyyjZKWaCedaFsKC4us+wI239sJc/vpqixC6RLh/kEQPnr+8hW4XWuyoUbWCk7tJQk98cn+muR44cy4KTvFtLHMKZppXqGa8Q4y0wfaP+gfPXnQDREJrVfpeHa/5HIJr5mVGDQMZlihbYlFt1LXkIG37yZjdzwWzBk5TicEVrd7d+mKRYp2DRrcThSv30jUaBgQnhcebopbp5xtutyKmjGbXnH7EAriy6Lb6JuMnWT7aVMKh4q23+EDKN4BvEPsxm32dWQRZvRKVBTyhUInKPg/RaDZxtu+UgZ/AIvW+kbnmZmOGMqCsYHvkjFltHFohM4NqiGM0pEVrHo0Ki3VS/HQpb/8OCPWzwscjuEwTa0tn2jLVXgmbMvfFQ4SlaMhNbu4mzFnfiTpxrp7qfpw7viRY4NDEtIppLi8XnwwML7Xh3AN3fmUWYzA/CAMdI53aCXgTbMo2sApt5QR629dB68CtKBIwo9cuQOCkvGYE3OZSvCuAPyGO64JqLZZAxGmCYSKSzgJXUtoKO/VqIqNao7415ec7pQqICr7j3v9ZhMDBA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sb7j1A/i8ZuQuXYHpycifZlmrhGdWj7STWLRFrKtwI/kQvyYiLOopHXcbLaN?=
 =?us-ascii?Q?h31zA9DT8N+JApuD//BRANP9g76mKKcGuYpdkFL+KX62hUcMHEtAkFGOmmHC?=
 =?us-ascii?Q?hhjtLaVtXkdYXhPTuOHz+Gr7IoqNicjy9c9td3rwxVt/d6GV+qoMhXTWB8wF?=
 =?us-ascii?Q?YCnyHlfpSOthuOxcH89ePb3EOMUUxrldH7Vk2cAV1DveNM9unkLvJNQgbClG?=
 =?us-ascii?Q?WOvlFC3dP5ZX39OMWVT67L8qaCgTHYoO9TVO6l22BHEHG+btAObxZbMOR39Z?=
 =?us-ascii?Q?tStIM7uCTBQkWAWsyAVz7DU3vkbTTEv1Dg2G4OrJT6DEzx5ILJisouB6Qdbg?=
 =?us-ascii?Q?zvYwaHykUN/5XTxcfzPorxMkS52KkmepodB+ivXO96JDVBUQxtnNQ0UOte/b?=
 =?us-ascii?Q?F1ud7T1sBU4/p+jOMXMex42cAgVBC8monH0zIcS0Td0Ys9LFC8ssVL16ZG4H?=
 =?us-ascii?Q?COnEqgpdymu4de1zwP3h1lLKO2POaKxplupGDSZdD9iwT2iR1KicfDubmsW6?=
 =?us-ascii?Q?zcXJOf5DAwwxgufJpDPLa0jE99xoQ4Em6vzmmZEFYgPmahrIImz55yO9xiPc?=
 =?us-ascii?Q?VCzG6WgCC6p9gBimcxpwa5n7uyFHUDHK6qKYC/fnNskZZnHSHYwXRilUt+i8?=
 =?us-ascii?Q?CD5UObQkbvbqcM9UvVQa/vShkoj1OofqAgLgYp0RXKCRcCzUeUji9eVJ57eV?=
 =?us-ascii?Q?uETT5QQsjpD90nuGsHPI5bwPOB2S5sZXwrtqBwKdHer6ISnjoNxuNoiZ7TJK?=
 =?us-ascii?Q?G5Dp6Llxgl2B4HV1y1GhuHQD6IRAeqgjXFczhmfJT24ruulzeEqLVi4k88z1?=
 =?us-ascii?Q?lMBkKCdwARrwab2ATofBzK9gU/AuJO4lrswdtxCKNuv/mzRTJDsKCM4ZdSr1?=
 =?us-ascii?Q?V/AawcVvNqCMcgoKwSr+vFsheBNKQfdCrzzymh39BxX9dGVkIGtWxqUco32S?=
 =?us-ascii?Q?ogEybYWpOmtawsy7vBcYya1FIX6rH2ZWsThj/oP7kEoyJ3oaJfR4KnXWpyfa?=
 =?us-ascii?Q?kuh8lmL970g9XsmyAZi0VhBtHcKfx+mkBcYTDLhUlYKcSVYF44LV7Tgrvzeu?=
 =?us-ascii?Q?5DAsf7GSrny4ohL8EZibYpnveles/nvbdOxpmV5rKBndXfa8h1O8v4/moKhb?=
 =?us-ascii?Q?nx5P1wPgRmjuQzro6Y7L9nB7N0Fj1XJKFnz6BCkXO3ArzlcnRLKhGQzsTzt6?=
 =?us-ascii?Q?22EUsXndD8RWwJoJ5Vk5uhPZr7DbMnX0pjAaT1IXrg4LdGN7AGSe3UR484ZJ?=
 =?us-ascii?Q?wzSBFim375KImY+gczFjHrr8CLjpXjxolqWgH+UmAWcbBTNbSlun8ZKkd22r?=
 =?us-ascii?Q?R0QfWU7CnTO3OAebFO38yPvrRN3pnnhQMpBZDPW42lf7VKnXZZ334pWhTak8?=
 =?us-ascii?Q?hw4DnVBSWph4bsE8Vshu4zs8geenrI3fI9zQakzUMm9p35h2LqCccdVuPByB?=
 =?us-ascii?Q?Rbpko89TUeBTVIPR3tU8NYfSYhUgoW2QknZs9n68H+uPh0LtjCUskoMI0wzz?=
 =?us-ascii?Q?GDLTj2XULDN8pVFKIhjY/1ZTnH8JHBXRgW0ZyugKvS2I23ylnTYuz0t8J7yi?=
 =?us-ascii?Q?jPV/KWEbbQIpFpt4l4i3/NT4OeKait1VkiPDmUqXRPKezOkEfae+svGB2y5e?=
 =?us-ascii?Q?gWXR1+0JbrlPL8IzU0Mo0+i56nA5BqWIYV3f8GWewJoDll1dgoPTjT8fBHzb?=
 =?us-ascii?Q?plyXWe7tAGCbyRh26rioAjFO9bcCi37AsW8NSb+509JbifSm?=
X-Exchange-RoutingPolicyChecked:
	ASowO5WOGFLTBWNRiRwOVxcrNMSxMvG3aSMVxIIa0HVuZuc7gwYb5nMVIp1coo9Cim15oDnT896B/wlw4awP4mPjojC5GhuWCQL150UhCUqtN92qpuZs9EZ9cXuEpmST5YF83MfZIZnm3+Udklfga6YWfzy7pda853aUr6rq6hUG4Kut9C4gt8YDHIXVuFFQTvMB33v3hhG9Y0vM5xZLDyRPXnM4jfgVusiD/vriTxTlfKCxds4tIgm7VphubYLftaVnJHnfw8kytlp0UiwM38Y8tKbGQMO5WAxvyirlEbBt35YW54tuRujpYXWyabKMojC3qvMxZdrcqcIrv7kE0A==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f609689-38af-44de-70b3-08def3d2ccea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:53:04.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgsM6z+1mEF2+7L0SyteUcBDGNqdqwS/aQuXdTiXPGAvJ+uyNnxQJgvCj9Gn/oVp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-BESS-ID: 1786031589-110981-15308-2975-2
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 52.101.52.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVham5mZAVgZQMCk51TIxzdDAKN
	nANDnN0MIgLTHJ0iTNNNXc0szU1DJZqTYWAOGbXYVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275190 [from 
	cloudscan16-109.us-east-2b.ess.aws.cudaops.com]
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

Mirror TTY semantics: an AT port raises DTR/RTS on open and drops them on
close, and the new wwan ->tiocmset op lets userspace change them via
TIOCMSET. This matches the TTY-based USB and legacy PCIe drivers for the
same modems, where DTR is asserted on open. Received device->host serial
state is not needed and is ignored; ->tiocmget is left unimplemented so
the wwan core reports the cached bits.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v2: Use __le32 for mhi_dtr_ctrl_msg fields and cpu_to_le32() on
    assignment. Use guard(mutex) in mhi_wwan_ctrl_send_dtr. Return 0
    when IP_CTRL is not enumerated so TIOCMSET does not regress for
    devices without IP_CTRL.

 drivers/net/wwan/mhi_wwan_ctrl.c | 183 ++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..95f4f0e6e4aa 100644
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
@@ -23,6 +51,9 @@ struct mhi_wwan_dev {
 	unsigned long flags;
 	size_t mtu;
 
+	/* AT (DUN) ports raise DTR/RTS on open to receive unsolicited output */
+	bool is_at_port;
+
 	/* Protect against concurrent TX and TX-completion (bh) */
 	spinlock_t tx_lock;
 
@@ -103,6 +134,55 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
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
+	if (!ctrl_dev)
+		return 0; /* IP_CTRL not enumerated; best-effort, not an error */
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
+	if (ret)
+		kfree(dtr_msg);
+
+	return ret;
+}
+
+static int mhi_wwan_ctrl_tiocmset(struct wwan_port *port, unsigned int mdmbits)
+{
+	return mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port), mdmbits);
+}
+
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
@@ -122,6 +202,10 @@ static int mhi_wwan_ctrl_start(struct wwan_port *port)
 		mhi_wwan_ctrl_refill_work(&mhiwwan->rx_refill);
 	}
 
+	/* Raise DTR/RTS on open so the modem forwards unsolicited output */
+	if (mhiwwan->is_at_port)
+		mhi_wwan_ctrl_send_dtr(mhiwwan, TIOCM_DTR | TIOCM_RTS);
+
 	return 0;
 }
 
@@ -135,6 +219,10 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *port)
 
 	cancel_work_sync(&mhiwwan->rx_refill);
 
+	/* Drop DTR/RTS on close */
+	if (mhiwwan->is_at_port)
+		mhi_wwan_ctrl_send_dtr(mhiwwan, 0);
+
 	mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
 }
 
@@ -163,6 +251,7 @@ static const struct wwan_port_ops wwan_pops = {
 	.start = mhi_wwan_ctrl_start,
 	.stop = mhi_wwan_ctrl_stop,
 	.tx = mhi_wwan_ctrl_tx,
+	.tiocmset = mhi_wwan_ctrl_tiocmset,
 };
 
 static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
@@ -223,6 +312,7 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi_dev,
 
 	mhiwwan->mhi_dev = mhi_dev;
 	mhiwwan->mtu = MHI_WWAN_MAX_MTU;
+	mhiwwan->is_at_port = (id->driver_data == WWAN_PORT_AT);
 	INIT_WORK(&mhiwwan->rx_refill, mhi_wwan_ctrl_refill_work);
 	spin_lock_init(&mhiwwan->tx_lock);
 	spin_lock_init(&mhiwwan->rx_lock);
@@ -255,6 +345,59 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
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
@@ -278,7 +421,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
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

