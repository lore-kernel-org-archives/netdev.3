Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D632BE644;
	Wed,  5 Aug 2026 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888575; cv=fail; b=lCnzEwrhl/UoqwCGCAb6h2AK+Uu4TraQB+O2YpfJf/ZtFIF4V2s7Oa9kpgWwJP86ucnyEBib48rpcBV8ANz6TaynwYmIOD5aWSd7F3kNPmY8xMYaIYS5JvZvtxuLO6yySqMa6iPSuEQ5Y/MYvpLeUhZFYnnmtQbAsmHxfYCDsEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888575; c=relaxed/simple;
	bh=PE6AmeiBUzAH2LHl2qQxLf6NXPckoPiH5q4tonpz23Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igiyA9bYIOyPvd34GDUPb+wDoj9IauW2gaCN3RUr5+Fonfjx0GRnJ8l6zJJv0ghVX6jXLxPZ9XLDHAcScJup0oGTs+AJRUV9dIWvzxMjQVKK2TyzSFkzWIjGLQKt/veuKTeQgczSAVg8q4nVfSUZ5h2L4C6TlTEjgs4NuGcVPkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=FD7UgqPa; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="FD7UgqPa"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020140.outbound.protection.outlook.com [52.101.193.140]) by mx-outbound-ea9-161.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 05 Aug 2026 00:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RACkLzTLMngSmwt2kVbNN9WGw8XwwEKZeBLZHFxOtlVSCa57IuXa8z6/UCOYVWpCxXFE77aZtNyR1qttv7E0XQ8JsChEJ7CCbDx3ACLHXlbsx0YRy+dkFEjAyYJG3ONK7xn1KuEKSXf8i797r8NhUIfjdwnL04AgVC4hb2WH6pQ3VCghirPEYwVuNwS/6aPpXL+61Qo75MkcrGS5N6zXW/+r2YTXFBdxT13Gy4s6J9a6B0DlVVkmynd3kdA0gXYGAlT9k2dBnu477wjGfY95gHib/Jnlcyu4tWoy77FZlD7R5udQvMEUBP6VfVVO5WLaXUdYFomDiHrT1NLOJdYnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dKv6aT0riFLiKADqh0erEC25rxLC0X5DO7YaGY0gVo=;
 b=aodKeKVBYLGRyyHeSueFdWDjnIVDaRC3l9RS0+tBYYlOAY0sMb+81sZ9RAfVHQV22UCLCi7kiyzsYNJm7l/vZ+QHWghmPthCtBJt49fA5lCP0Lg4IXF9TFu7OfuYmrlBxnhNQshFCbwTUJRkqK+i5cAkG0iX01OS/0M18BYzpX/jpi0dSNDXcidusVkIXf1i8vwF76BXj2TWZ73kEnWrNjCb8P5W+A00c33e/J7DgFGo0e2EuOdxJ8UNI5s8Y4pwmVUu7B/ZUtIHxkepgdBG9SUpL1321YdE6esh6kNCXRDsvMOZEz9c71kdvH9LOahryYeTq9daraILmfi8zKhw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dKv6aT0riFLiKADqh0erEC25rxLC0X5DO7YaGY0gVo=;
 b=FD7UgqPaL4nIRrK/TeZHmbSTVXJTb6IHMolswvVd/wlVOnuHZJhpBc4paHRhg/6oSgZohykqnEUKo7ndRj+k6UIATGCy5YeQlmAYh0DK3qW/thcxbMiILA3KPPqRKY8bVTmI9F2V5RFfT9bze0D6PUReY2oOvWYHKe36ROkBr5o2a3orH0f5IZ9XepJx3F78/En0QepRiGwwgLBxjHjJpeSgmlcUQPhfMygogR3HkYeMgTcK0+DVRk+B73oDd5SNGRRgEsBvfWvUgVscWh3EQoSLftOHIdlUhxX2k04pfz/V4TUt2+QEBRm5jJl39h8DIDqoPkhg2ftC2iQrnaUTJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 23:34:22 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 23:34:22 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: mani@kernel.org,
	loic.poulain@oss.qualcomm.com,
	sergey.ryazanov@gmail.com
Cc: johannes@sipsolutions.net,
	netdev@vger.kernel.org,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next 3/3] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Tue,  4 Aug 2026 17:34:11 -0600
Message-ID: <20260804233411.1953445-4-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804233411.1953445-1-peter.hunt@opengear.com>
References: <20260804233411.1953445-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::35) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|IA0PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1f6f5e-460c-48dd-be4f-08def280e947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 rD8XsJhy+bdWBrho53EyFSAX3TzeD47I1TIFM+VC8T++GeQzXmk9Szn8zYqts7mjoJTLtv4UBNAhjlelbtEVOPsSfziChOdU0DBxVydWjyKP/GoAGceZzPwI/CcXrtY6i+oJgH8oXErPxGDSLO7YbsFu5sqZlgBYqYh1Nr+NPBKQCxt8Sknr+IEk1XhIk4BRpBB1PTMuCqnQ5BGh04vhbgclOFc8GBmmEXYGOI/I1oMQUHzYWGJc+hDhNgQXjX3ZC11A55SCe+Aphb0rMqmmi+hLE2Rbj7FXzETfiWkj6bw1pWuWpE72kYup20qYU9mnZIXbGYl/5lWKIHYcIRI+33Qo7SuFSFIR7uNKi7VH5V2TGR5Ppb6zcRSnQeyw9cw7/tvDRiy3qe1iiSYtxIGN08cWvp5y+WECK7eOvADws87HOg6MGgajNOf6VgPCGspxT3yDv/CHbHgtPBMbMcNx4gGfCZcvQuWgNxv1pHPV1pbXRGqm2B9YdMKxR9k7jMVXog5NqOkwwp8HqN94Y3NivAsOrxABjNys9enxKR7L6lmcyRRTp+vgWTbJE40r+LXA8XAMkV3ON0H1saLpslA4ArSqGOQ3mJ37OsvGN/89ouC+6IN1meMTaLE7DmXH2Lr9RRyYMvMsFxxQ0ZHij3j2IUM/xHsbl6bL7LK8rYSvJxA=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?B4Md/epgFggIdtIRakMIGZs/KanxJatU3O3igRrPY0rZw19PvpvPhg7/QAQR?=
 =?us-ascii?Q?f3GhVOqgBL4ZLBRZ14Gp8ys0hN5fgPglk3VlqZrDfgMadPUKluKJlTgR/9yq?=
 =?us-ascii?Q?isthq1IY2IWbPDx8gubX/WSKb8Sr315+fNGn9To86XGAz7VZ3VrGN1nzCG9W?=
 =?us-ascii?Q?Kr6lebFSWQp6+6/mV+Xq2mreOsqcCtOwj9tZ+DHUQ/ehwCxHIWJ1rFEXet11?=
 =?us-ascii?Q?csdkWfyGspVdLuona7GQDcWb9fpFLBEJxtkUrhXRSN+6LVXal+1gf6qebR61?=
 =?us-ascii?Q?BgTJqMTKp218gUTyX8grwUHwLOj9pzW9VTpBPIoWMtmzDkFUB9Vy4YuV0HoD?=
 =?us-ascii?Q?k6jx5kwyxAoNxZ3faOarlMfYTwAbHgOP8qGQobeK23Kh321y/5rfdRSYsEuq?=
 =?us-ascii?Q?aIh124ADVhs8SkclZtsjmS2daSOtfcZT1Xik3SSOtCgTSnlMGwysBa4M+Kf1?=
 =?us-ascii?Q?62U2V85tBZ5Ot0H4XX1EglPFwgJwy4zIgKliSh9gNYcDgDE9BrN3N/nVpvl1?=
 =?us-ascii?Q?vNceuO/FOM5jYZY9C4z6QJkxQcoQGeGkc2OEi0orKlTxjgsf7rAEH7//+INO?=
 =?us-ascii?Q?VTUdKwVdFqK4lSw+Sr0AFDE6i59GLpUMX0QXk/G9jIjO6ylmKx4wLVTEUx/0?=
 =?us-ascii?Q?vn4DySMeRWbxypxNlYqbqIZoEZ4RASlTtirdBwaFwzCpXne7BGBQzpSSu5Ww?=
 =?us-ascii?Q?r/oieFGVmE3YQoUcXZEoja/rEWQng/DxgCryU2C+vyWzJTxr5KM5BUfS3E+V?=
 =?us-ascii?Q?gI4dHZd5/MNYTrWwfJZkAFLtM+6GrflhiRJzYA/3B5JM37Ij0BO/WvHzD7Zf?=
 =?us-ascii?Q?54fXg7d5zDJ3qPG0dHDRVViM5cK6hVtEXHj7lBPxRJFn4H3x/iyM3VZQwru0?=
 =?us-ascii?Q?/g9/JUmgBopYkg98Izfe5tXLlWjr9Z63ZT2xNL/L3Z9HsFrTmPZZG3Ai05XL?=
 =?us-ascii?Q?5Rs0jbFxcq0W/bzp9YRQsrOTZVMLsHGflHmCcmtnWy7zE5jLgotUWU2g/B3A?=
 =?us-ascii?Q?oGu66ZIV+Z163S+bvZbZe43pcBDFWAgDYsuSOEYpPRxzd4CvkHJ1OQ+TaPo0?=
 =?us-ascii?Q?ApliQIS907thZN54nYwXlZSt/xWLfY7VJ57nWmJhCrzoK4SSwiUhzuZJLl2W?=
 =?us-ascii?Q?a8QdpYODBEfO/+4IRx7HCKLvfCHDJvPZsn8suPpUQDBhtsC7i7TZgLV5c9lv?=
 =?us-ascii?Q?WxNuQqlEjfh/7OiB+eLxAJ6QA6TAAb6ZDumJ0NM5qDBbabx13btxO0wdZCnd?=
 =?us-ascii?Q?Jqx1DoK8tieBt7sk0YR03GKlqrtC0Hbb69KaFnEyRZuy9Uvg9cTh1IFdy/5M?=
 =?us-ascii?Q?gL0AoWsJvScOM7M04n6TJGhX/mCzko55TJWacNRp6oc4XuDKPQzDKKfdWJdq?=
 =?us-ascii?Q?58jhvSf13rV5TUaR2xst9eADQoduYRGPNcCNn8852HXRyMn1d19hbGUoR9Mn?=
 =?us-ascii?Q?IQ7GybtAAt9Shv2DlvUORlrOrvEtexOiWZPuySHg0XJpkd6EpnUDBQeOJ1C+?=
 =?us-ascii?Q?+Lhz15IwufmyeJK57JsPKYXNZgLP8lckXA3SCgoIQZYkW9VEYEjfSKa7e7W3?=
 =?us-ascii?Q?exCtFXMPVVLatlOjCRnW6Rmh/IqdXGJbfFfRsfMaGmLYjx2rZrsO2gkWg4Tt?=
 =?us-ascii?Q?4UM6mPoWXNumq4+3YreCzmU6RTBbF+t6IKa52aYPesAhvnX9CHoMZtCIB1gI?=
 =?us-ascii?Q?RHZvV+DXhoTCcpSyZNS1vT9gkFZxoK2+Ykrd27EhdrEWWUQY?=
X-Exchange-RoutingPolicyChecked:
 q+dYWQJm7If4mWtHNc9vBEoGvOGib9GDO+q6+sBv01gFacm7SKzTnjRr9pcMPA1QvvRxvfS6PhL9Ls8B92U6XPyy+v5lVc2W+Hizqr8yE+Z6VcVC6obPmGatUCVorldbZ/2CpeW79Tv8OCMU/dupBS7vWRN8qPzK8keyG5owD8yMDwDhwPdxddTL+dS1ufJ/TpsYpx/rpXIutexS1UUFcru8wdMtOILjc5dNfv5fcvwjNZTuDDDf18WcOB0/dKwyczOZ8eDCpFP+1TU/Wb7/zJ+ff6J2MDlg+M4rFDK8h39m3pJ0g+0D8HdS4XHS09NJ86NTBmZHDmJpoMXqJC6xOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1f6f5e-460c-48dd-be4f-08def280e947
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:34:21.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tD/eil+4r+EN19+AsVgZ5V0NgMdsUq3TC56UNCeokSBGaKCtFm1PRgWWBHPeM01o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-OriginatorOrg: opengear.com
X-BESS-ID: 1785888564-102465-27679-12855-1
X-BESS-VER: 2019.3_20260804.2013
X-BESS-Apparent-Source-IP: 52.101.193.140
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhbGhgZAVgZQMDUxJTHVMtnYyD
	jZxMDI0MAw2cLAMMkkLS3NIinRLDlFqTYWAPB4dWlBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275152 [from 
	cloudscan14-195.us-east-2a.ess.aws.cudaops.com]
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
 drivers/net/wwan/mhi_wwan_ctrl.c | 186 ++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..00725904333a 100644
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
+	u32 preamble;
+	u32 msg_id;
+	u32 dest_id;
+	u32 size;
+	u32 msg;
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
 
@@ -103,6 +134,58 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
 	}
 }
 
+/* Signal the modem's DTR/RTS lines over its own controller's IP_CTRL channel */
+static int mhi_wwan_ctrl_send_dtr(struct mhi_wwan_dev *mhiwwan, unsigned int mdmbits)
+{
+	struct mhi_controller *cntrl = mhiwwan->mhi_dev->mhi_cntrl;
+	struct mhi_device *ctrl_dev = NULL;
+	struct mhi_dtr_ctrl_msg *dtr_msg;
+	struct mhi_wwan_dtr *dtr;
+	int ret;
+
+	mutex_lock(&mhi_wwan_dtr_lock);
+
+	list_for_each_entry(dtr, &mhi_wwan_dtr_list, node) {
+		if (dtr->cntrl == cntrl) {
+			ctrl_dev = dtr->mhi_dev;
+			break;
+		}
+	}
+	if (!ctrl_dev) {
+		mutex_unlock(&mhi_wwan_dtr_lock);
+		return -EIO;
+	}
+
+	dtr_msg = kzalloc_obj(*dtr_msg);
+	if (!dtr_msg) {
+		mutex_unlock(&mhi_wwan_dtr_lock);
+		return -ENOMEM;
+	}
+
+	dtr_msg->preamble = MHI_DTR_CTRL_MAGIC;
+	dtr_msg->msg_id = MHI_DTR_HOST_STATE;
+	dtr_msg->dest_id = mhiwwan->mhi_dev->ul_chan_id;
+	dtr_msg->size = sizeof(u32);
+	if (mdmbits & TIOCM_DTR)
+		dtr_msg->msg |= MHI_DTR_MSG_DTR;
+	if (mdmbits & TIOCM_RTS)
+		dtr_msg->msg |= MHI_DTR_MSG_RTS;
+
+	ret = mhi_queue_buf(ctrl_dev, DMA_TO_DEVICE, dtr_msg, sizeof(*dtr_msg),
+			    MHI_EOT);
+	if (ret)
+		kfree(dtr_msg);
+
+	mutex_unlock(&mhi_wwan_dtr_lock);
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
@@ -122,6 +205,10 @@ static int mhi_wwan_ctrl_start(struct wwan_port *port)
 		mhi_wwan_ctrl_refill_work(&mhiwwan->rx_refill);
 	}
 
+	/* Raise DTR/RTS on open so the modem forwards unsolicited output */
+	if (mhiwwan->is_at_port)
+		mhi_wwan_ctrl_send_dtr(mhiwwan, TIOCM_DTR | TIOCM_RTS);
+
 	return 0;
 }
 
@@ -135,6 +222,10 @@ static void mhi_wwan_ctrl_stop(struct wwan_port *port)
 
 	cancel_work_sync(&mhiwwan->rx_refill);
 
+	/* Drop DTR/RTS on close */
+	if (mhiwwan->is_at_port)
+		mhi_wwan_ctrl_send_dtr(mhiwwan, 0);
+
 	mhi_unprepare_from_transfer(mhiwwan->mhi_dev);
 }
 
@@ -163,6 +254,7 @@ static const struct wwan_port_ops wwan_pops = {
 	.start = mhi_wwan_ctrl_start,
 	.stop = mhi_wwan_ctrl_stop,
 	.tx = mhi_wwan_ctrl_tx,
+	.tiocmset = mhi_wwan_ctrl_tiocmset,
 };
 
 static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
@@ -223,6 +315,7 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi_dev,
 
 	mhiwwan->mhi_dev = mhi_dev;
 	mhiwwan->mtu = MHI_WWAN_MAX_MTU;
+	mhiwwan->is_at_port = (id->driver_data == WWAN_PORT_AT);
 	INIT_WORK(&mhiwwan->rx_refill, mhi_wwan_ctrl_refill_work);
 	spin_lock_init(&mhiwwan->tx_lock);
 	spin_lock_init(&mhiwwan->rx_lock);
@@ -255,6 +348,59 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
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
@@ -278,7 +424,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
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

