Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAEC3E3D91;
	Wed, 19 Aug 2026 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179868; cv=fail; b=bk4Iylhjtmr2rwHMz9pFjVgV5c2xXst3aYQdZSS+bqZPVUzj4rx/dP3Ou1+joRc0rVJao+N+7nD/pMLzffzP6lX9kDdqC3NoRTw+6Ovf8XMhtXl6H8qU4+xOM70CcTvu680sHhluhEId6120lcvGiHd0UgiAuxlKIcOF9IcZqb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179868; c=relaxed/simple;
	bh=hA2mdmSCEmjUeYM+wovSc6+6StCHieasz74IJh/Gkvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T19xQXvZpi2a6GbHAormKVXWWV6H/27EN0qANFqukQ8hGYCQo5ads2HkQmEJQijutPFMUpybt55hgZaXSEO6ip6+Fg59VhSDesqInMUe1Z9bvONkO+RSTLqtzH6bdxwH3Z92dRnWijdMpHCU28bijwnsOHAsuxVs6xZaz5kEeOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=gl5X3lmt; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="gl5X3lmt"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023091.outbound.protection.outlook.com [40.93.196.91]) by mx-outbound45-182.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 19 Aug 2026 22:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu04pdGWDReCxkT0OCNcFyZewBQG5PkcB3ivUUiYWDjXAQymJURKyu5gkRGF+hxVD4EQ+QpoU9dEb9aNC5h+KPAkujetaHujjfYhQc/dbhFSJW0yFKTdPCKNOnw8+PB8HBZMEG9aWvzDrOAIr6oJmwQQoOTNmcGCKfEkcEOauMVgU/0+4MwotiNp8jXbcFIqxD8mut5uGY/Nqy0JQh0F6VoHdX7WLjNJDCqFPYBhjq7VdGUgYkVk0VLWzydjzqh6Sc5wsgV9AxQ/dkKu7Wtu4WQDPsr1WxPh/W3yJ210gA/4g8jRW1wH3jl5kS7S9clazOKZGm6Ai5B/YPCQ5qc+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiyvHxpsyVGAM6SLwuBj0BFrutBjdVHJLdF1A68hd4g=;
 b=TEzo3yv7PkVDUHv6f2h9e3rFIftduQG319IVRA/jcdxJ4Mmzley1Zp9rdx9ICwjDcxZaBBrv1L6JUhI/yuCH/YcB6SgWXD6JX1n8HCsN8qDPypn5nd0w2cZf65GGcLMxAlXX+qf6Z5YjhiZEgAbTfzNJjcCAFXzrJTPWDATYVnyywFPds/+rH7FgtW7h1mnCzpCQ5nPDgnpvflcHqkG5Ll5JnVIZhpWbZhDPFRoYw0CzP1mT+96bLYL7uqgbezVN3u9lWkDMzPPum3NxIUh7FdkpH1udITha3aTQAQGmv5popBgXwoQPOmvHkqN0HB2y1IjQA7okZ6ZPXLFaW9gZQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiyvHxpsyVGAM6SLwuBj0BFrutBjdVHJLdF1A68hd4g=;
 b=gl5X3lmt7mqh45GuK155klR4WnMBDyLqb4VNJrB0QEfgN0Vx0Wt3KobC0Yxx+TS+B/umFpXvmgDFY25WRJF9Mxpq8sElzSY7hkd9vM8/cNs3OsxCrWBMmKXl1+WPPrWdcqUrM8eWPc3LqkLk8r99QRHaB1JeEYxbQp2BsDUGUNPBFn8t5v/O89ccd5wIchBKblQ7pgp/n0/GEcRWLkdLkr4KUOGqXhq0L93uIrenrOO8mEa74e7Daabwb50VUKb6yvGpaNa6S0ii0tWwRiDotf+rj2ISI9hulHJAoyyNo8158lJyqJ4Ls8xgHJLezrcKc8uwqzSs9C+rI4toE/us7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by CO6PR10MB5602.namprd10.prod.outlook.com (2603:10b6:303:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 22:49:51 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 22:49:51 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	mani@kernel.org,
	ryazanov.s.a@gmail.com
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next v5 3/3] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Thu, 20 Aug 2026 08:49:27 +1000
Message-ID: <20260819224927.2274790-4-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819224927.2274790-1-peter.hunt@opengear.com>
References: <20260819224927.2274790-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY8P300CA0027.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:29d::30) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|CO6PR10MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 36368db0-5206-4595-b465-08defe442dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qACeQATsOkaNbLs3zwY+juTpynJTfu9dDG3rm/FS+/eMIyLMY5Cr4UbpfD8MdbyndiJ/XOvO22TDlVjwg+Z5lDM8wpVYapByZ6xi60pBhdiKLDVOXw/9MO2n/aLA7k7vX2Yo/y+ZIjVums+h3PNXG1YiUceE4eoWAgW1pkMVIGXL0WVym1wwRdR2E0I1WkD3gCUyYKS1dD2KBseQOT84cDUx7XA4RyD74bUuNQ0GC7HMXkRPd/vAvSigbi4pQnFZq1OO1210WP6kR1bwAfoan9bERV4c7jrSHmDDrLfohTVUh7tRk3+5XaFJ02vdLIZ8sMSwVBfh7Tvg4Yww08/bCi3CdGfKMZoL577oE70GHJM7r31YNAclQOM/0vXbOz2AUl2wD4KfAPSnIBQHjKV7uqzR6+X3DBzgigy890T9oGCFqyNJhwucstpTrPJ0LXJv/bqjF2By3m7TR5jSY07ws+ffkCUMae20gl1IQxUyzH3VGVL4dZcBvQdSedE0F8TO1VFMIFjcHU0Qz0hmxlbpTrF2TO0qcao3H5GVt9d+sOVlgrZQGdENZiU3ptiLmicXZTXjYx5Uzf1Ck+hOGteMVvBBYmPa5hqcK8YmnxSekqN6iDFJy5TmPxPCqC6niuncOWrYjOKOt/mTmaVzjmHI+4EfzCJN/RrOtO1/kpNEARs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57wqoA/IQ7hQQUagkCt91LVwpxU7fezMQnU3MChRJ/RrN6NqKNZuaNa6cTxw?=
 =?us-ascii?Q?MO42NIyogkkGwFTZoZtEgtkDcfyHrnWXdmjciXOyyRqqQLtKTmQ0Ur8GQEpx?=
 =?us-ascii?Q?LVkIRsvcnmO8ldnVuQLrDuMtOiJ6QXGKMTWFJtm3Pc+W5//l+jw72hoSINPT?=
 =?us-ascii?Q?/QbuqQC/a522wEEzVDovkrATWRp+6K0LJpadSWGZpxEcOyizzRwlIngg5u6Z?=
 =?us-ascii?Q?2Wxw8oHHFg8vgq4X0GZw9tfIKKMr5wfR58aXCHYmUqevqq8EUvQMdJazVFhX?=
 =?us-ascii?Q?s6e6iKzEvr6t9ITNwb4JixUa1jPFIiEDWbS0INQGcw1mq0Iv8fuXSNArVsx1?=
 =?us-ascii?Q?IitOkA1hAihXxPnmIE+GS0Vycilj5FF9/MxxOO8S4xy+PVUGKe8m2zT31cbJ?=
 =?us-ascii?Q?j76TCgzTXfIOvKeVvNmMQqcaBc9s0G+8LQO7lAf33DVofCjJcrLsNdFAKYKM?=
 =?us-ascii?Q?ZY1smGqDiU/dBXm3NOBxPhN44tvc490IkHWlj/e+P86FDaLPh51R3yp+GPyg?=
 =?us-ascii?Q?zIduKqoWrZyeY5SS7MadSEyxwO+CYXqIFyp9Y+218/9V964u5IpyTeGKfS7K?=
 =?us-ascii?Q?NOae6af0e5HeEC9Efi6q0EKgcQdGYpiNEALT9AYIiuz7yuSeWB9O2mx4XLk3?=
 =?us-ascii?Q?TJBwcXTHZWG1483O1CbjAkQxuXVAXTf6i0uaH3oEIilb6vA2T8O9Sw2+r2GN?=
 =?us-ascii?Q?DGZ2/KgEAj0H2RAke01KCEbGneA+sSkK36AUlUvjUhTBUZBTgkXZhhHqV+JT?=
 =?us-ascii?Q?zVqhN1Ah/eY7iJYzXmx6e5zOF5oYgwrauYUMDyLBgvzzS+hcZ9GetuNakOVs?=
 =?us-ascii?Q?lCZLezfktz6QlKKHTYVcWUAKNO5XwAdQBJs3TMHezs+c0of2f2ujyD8HBVK/?=
 =?us-ascii?Q?AFdQ7Lh7escahSdBasYJALcFH1m/tlBAmNSHM8O3hzbaz5YOruiBrPzMpvx6?=
 =?us-ascii?Q?8/NX/iKurAKoDAgsGTGn9t3FQDRCXg9TukE/ehgP5IcBafxyFqU+GgWptheJ?=
 =?us-ascii?Q?VTJQkDwQFd1XEld+xJst9R26TDDBzRbPLainR6KMi3V8jsv5szGqUSs+JtED?=
 =?us-ascii?Q?zWfYPvSY7QIoHXmgXYVbvz+dJCfMr1s1CFPDIvn5GC1tBFvAN5SENhJIfoHI?=
 =?us-ascii?Q?zvjOcNXNXVd9SfPMB5lZd8CQt8eYvjR+90vcVEnsp1pzOO9ZwfzvP/PhExlX?=
 =?us-ascii?Q?MSeozIucs97dTEbPT2RYqrjwZLW/G4cfscKGMoT2ksnwulw8OEbl8Jnrv2VP?=
 =?us-ascii?Q?oE98vNlmQWbX5Twa9+vD5qZXP4H1lJFgyoyxIiglOgFEkeKhKvQxs9w8IO+S?=
 =?us-ascii?Q?q/dRWUoI0AjzA2MSKUuhX1Qd9qS28OlaF3hx3PnMdeGZ3hvCVVdS4yfSKGff?=
 =?us-ascii?Q?MbhjaS4/dqkOYHCeoIrIEavxDxNONiH3HKHtS3g2dXsJm6PDrI+ehHbTLXfz?=
 =?us-ascii?Q?qMREdb7rdSmk/W8CVpYIxa7V7di4AHK5Yt7mDVwrv4m1Uq7xS1aK8CK2pZRI?=
 =?us-ascii?Q?TEk8eRIqrJVxfLgxwKH/F0/nmmxGYw2mOEubKNWyjH/EEGB4pzTWSh49NZMv?=
 =?us-ascii?Q?QFjpGgaxlHUgDq/BU6STH1tzwAXK5bRazIzPiKzNj8j8pBBDIIH1LuMv08o/?=
 =?us-ascii?Q?E8sMhIHjODBy9IDxrXJ8bTeQqxpw4V03zcAeuyML1ft5MK4mAUnU0GQ/Dujf?=
 =?us-ascii?Q?GCpzSP+dPwK8Wu3P3xQLQDEcH3hyW+cfZHnb4tLTIeXxtBFn?=
X-Exchange-RoutingPolicyChecked:
	Qs3Bs6vmRg/lCKojNuwfUpq9XzZo0hwuvKHv7kiRnICTZK3FN91+F4rOpupANQcjLlCMg0nt5tta9BucGK+CrMOUUtt1yjtCbQAwvAD1+YWeTnSjbZc8dH0Miz8v739Rhjnv2TC6ORO4ny6m8ojWCzbVv1THrYeXguLO856IlWuqX4jmvzViAbb1tBJeZmYml+1hnmDaHm8NY/WTcTtqNOAuMmd227WEmjbHul2jXwAqQIXXUH84UOZ8mJn2vg/3Ipo2oPXmlTlfYkm/eU2wKahqgjkaSDTQUuKNrduqOoW8tiVMbkbNQa7B2wUO5whc+8gbDJ7K5KcCDyVaATfBmQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36368db0-5206-4595-b465-08defe442dca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 22:49:51.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hh37oTjwr8ZjLZbqzGTeiXfznLIXV71EzCocGvmHvD7aYKfFbyQ8HpDPQ3TwidGz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5602
X-BESS-ID: 1787179775-111702-12581-7781-4
X-BESS-VER: 2019.1_20260817.1854
X-BESS-Apparent-Source-IP: 40.93.196.91
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGxgZAVgZQMDE1Mc08zSLZ1C
	jJOC3VNDHFyNzQzMLcxNgy1TzN0NJcqTYWAHT3THVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275506 [from 
	cloudscan15-71.us-east-2a.ess.aws.cudaops.com]
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

The wwan core (patch 1) raises DTR/RTS on first open and drops them on
last close for any AT port whose driver implements ->dtr_rts, so no
open/close handling is needed here. The new ->dtr_rts op lets userspace
assert or de-assert them via TIOCMSET/TIOCMBIC/TIOCMBIS. Received
device->host serial state messages are silently discarded; a single
recycled sink buffer keeps the IP_CTRL DL ring live so the modem's
transmit path does not stall.

->dtr_rts is void, following the tty_port_operations model it is modelled
on. Delivery is best-effort: at_data.mdmbits always reflects the committed
userspace intent for TIOCMGET regardless of whether the IP_CTRL message was
queued, and the next ioctl or open/close cycle will resynchronise the modem
state. mhi_queue_buf failing on a stable IP_CTRL channel is not expected in
normal operation; the DL sink buffer ensures the channel remains open.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 190 ++++++++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..1cb91b59256e 100644
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
@@ -14,6 +18,31 @@ enum mhi_wwan_flags {
 
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
+	u8 rx_buf[sizeof(struct mhi_dtr_ctrl_msg)]; /* sink for modem serial-state DL */
+};
+
+static LIST_HEAD(mhi_wwan_dtr_list);
+static DEFINE_MUTEX(mhi_wwan_dtr_lock);
+
 struct mhi_wwan_dev {
 	/* Lower level is a mhi dev, upper level is a wwan port */
 	struct mhi_device *mhi_dev;
@@ -103,6 +132,61 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
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
@@ -163,6 +247,7 @@ static const struct wwan_port_ops wwan_pops = {
 	.start = mhi_wwan_ctrl_start,
 	.stop = mhi_wwan_ctrl_stop,
 	.tx = mhi_wwan_ctrl_tx,
+	.dtr_rts = mhi_wwan_ctrl_dtr_rts,
 };
 
 static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
@@ -255,6 +340,71 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
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
+	struct mhi_wwan_dtr *dtr = dev_get_drvdata(&mhi_dev->dev);
+
+	/* Modem serial state not needed; requeue the sink buffer to keep DL ring live */
+	mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
+		      sizeof(dtr->rx_buf), MHI_EOT);
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
+	ret = mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
+			    sizeof(dtr->rx_buf), MHI_EOT);
+	if (ret) {
+		mhi_unprepare_from_transfer(mhi_dev);
+		kfree(dtr);
+		return ret;
+	}
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
@@ -278,7 +428,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
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

