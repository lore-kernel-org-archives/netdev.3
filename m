Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454B2DA759;
	Fri,  7 Aug 2026 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139717; cv=fail; b=jNvp+3lOvrOGbNt5YY44bEGQwwECa8efK6IsSBiXhVBN8cfq1PEenoYuZtzmedf78a+BZKUfSoscq0tNZR/J5SGIOvCulmoeHOUyoAZPwFxDU9ZnCLbri7QPQ8qcyklumNkCLeddrxsUMmGlyPjMb6ODP5yupYrbugoNe/0Ae04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139717; c=relaxed/simple;
	bh=Ff0wZJRrHtMs+pgWDRj3T8ig1fwe7iZ6d1ITvCrv+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwdsT52+MEYZbt7Gok4Fb8eeswnROTigkS4UzoMimVr3bkKyxRugAy8zHlG1+Vq/nXlXfSVa5tudI0Em15tHifjC/AdUAcnfBuobo/ZA9BgtJl4YiND5aQ0Ph6eGE+ij/vUOH1QoFsmkI9L5t3vjg2m2H33XlDn9fVxchYkobT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=FX1FcVWY; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="FX1FcVWY"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023143.outbound.protection.outlook.com [40.93.201.143]) by mx-outbound9-147.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 07 Aug 2026 21:54:53 +0000
Received: from BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11)
 by BY5PR10MB4163.namprd10.prod.outlook.com (2603:10b6:a03:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 21:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF5vpuCLPgsQBYkaxfupszPoVDiXlUdrgrlVJf7TyFcP+tUP2nVkSCCQqTs4EX/9n62O9ZYhjrJQavRZo4Nf3mOjR5YK8XWFSfZ15PzWq+zRhND5S0NO72on/x1gxNdFZ0CyL3lYlEV7h9uwzOl5c5L/my5sCSTr19prTeRBqv8BQ6e5rjX5ccRQ7S5/w1HGng3U1P3TR5iTcnKjgP+2vKAVGOWF7Flj6R7La040OwYQpvRBl6j00gFNxdrvVt+GE1oX8sJ+4pSZlOY48/yBm81IQbCeu9sRrbItd9sBcSspdi+THo6jElLwK24JYP6ipB6hImFnTiC/hjCbK4AGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDj4wI/Up89etrIhEnhc7Owf0u2B8lOB6QsaY1Ig4CY=;
 b=phLx9VuIJrGutnHJqajgItn3exWAz/n3+kqebk3oBYIgKzIwHqJYhoxszO19qB2jzhFUvFtgsU6O4pGjqt+KRax7HhPagr0MxRCDZmEpT1iVik958b8DEp+AqglFlgS2ii8zJvmQhVKQYUzR0HEi9IJGLDFbfIBqYroa4rscV308vOKHxpS1yNdxpYKDFS9UuRoIK3Mb+miJpY9D+nE+kK6tPfg+UThhdcYD7tYdFV8XEuImQuwG/TZJ+BP1z4Yo4qpgLMpSHYSm3g51x2FvR43nqBAnD9ckb6HC0SVPmJ4otwDYkXQttaVA2NIuGv0uSjPtyMVTlP7TVJJbTm5CQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDj4wI/Up89etrIhEnhc7Owf0u2B8lOB6QsaY1Ig4CY=;
 b=FX1FcVWY7rPy/fkoPidh7W3xk2mLnDgVbBM2kOaPuGwixgsrjQnl8ycrR5FQP77pnURJ22GV8ePRYzGPEdaqUWzbV3ck6FDZ+5iKpRegYKrilF0s82Dwq8PfOH24Gnz+pzdZBf44x5ic6ZMU4vi1FeWZf0o0ZKPvHRjpAJ3l2vzPXQD12tL0VCiR63nXhSmAkqw54H9ocdAUhgGB+v2cnlj/ajPC6ZHZDdewTnXmp6rvAjbUVe6ZYFzoBDXwqOhKmN9MZakgQubcZDyZRusRbpY3TrotlLtwGRbeaFWo3EGa0x5ssGfRsWUoO5/51uByDYAx6METm+5JjTJP5T9c8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Fri, 7 Aug
 2026 21:50:51 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 21:50:51 +0000
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
Subject: [PATCH net-next v3 3/3] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Fri,  7 Aug 2026 15:50:41 -0600
Message-ID: <20260807215042.2714442-4-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807215042.2714442-1-peter.hunt@opengear.com>
References: <20260807215042.2714442-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0107.namprd07.prod.outlook.com
 (2603:10b6:5:330::21) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6PR10MB4139:EE_|BLAPR10MB4899:EE_|BY5PR10MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 7008562d-319b-4990-43ed-08def4cdf2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
 4JcgiyPdClxmV34SQxXihOVRoJxuuFrhlEAqAgd1J7K5gonlfkPTJ9rmBMEV1VrRal5/3TgxJnJjc2B4XqhJasBS5B2dqDeC8qkjOD7qeLokcyPo0QuwlC3IqJ0rQTJkX7aPRrF7oZVbNEGLV9Nh7ki3uogn8osmE05egIr/BViRtmsBYxRzdMuk5cuc1pRvd914sjQOr2K2dEHE23Jk9kdp0IVMAnsiKXWb8SZhQSNUTFXGl6AS5OWuRU9wv7Ej2qZ6irgOwMCzHOLHAczF8FNG9l+62uuaZEvhohuvhoBxjlas6uJ+PXexDXlC6Ljx3DfcAads368CpLC2MLAWr7jYvoL7nw6nLIElg8Gagjf1YQlVV0coeXKNvfnODXjYfdNMg+G2z82IpVzDay27By76LF4zSHEtpnSxtDwgSdLxhGR8GDGpMDA1wTgoQvgkWJRSQm9A2XVtAKJXx4DvOojOp/xyhfgvYNgc3+GZHqiNBMd/Ym8YX8CbzHOlB5K3+d01T/0VC8HxPYCJ0QeWj4TXi9GeAC/JEUjYfQTNOp7jE+QnSAkdCssa95vZe78mIhsJaB9LvxVqMa9UUw0GKoEVD5yeDf+I3IngId/RbhcVCbZxCozchOFTRaXB6NS6Nz1D/Rr14xMAPIb7jgzWk6Kv050hGn7GiW1DKKeI5kI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?zgKoNqmX9zBdEk9CBf/dtpAhf1GWRah5Le2ZgNUkZq3jv+4D2jMdBATIA3FF?=
 =?us-ascii?Q?LhJ7q5/1dEbxgyQlNsEhuF/kbY+hBxJUwBAWuGgjMCZxhSM3IBzpBjLSYsGz?=
 =?us-ascii?Q?Sds7l09DUqKRsYG6y6Mc4HIcb09NqbrZ7FyWeFYMt9dxMVHK1FiU+xROI6xr?=
 =?us-ascii?Q?Dh6Ks2+h+c2W1HiK+HXukqhLoFkP4iE+aKZL6kg165dsY0A7K1SlK9G07Hem?=
 =?us-ascii?Q?knncsmx16bFtJUhklp90WcFcmfPgONqNAJASL/3tymSV1oIBgAOY4A8mPc6U?=
 =?us-ascii?Q?rt6QF1i/orqOE/Y9ae0oeHA7q89fueo9wJippLXuiiRjpSPBuAHUlV48n1WB?=
 =?us-ascii?Q?wPcmjFKG+V9x0w1adohp2nBq4ymIo0gt8X0UI6vDKaiAAW2tg7DDH9i3rcPz?=
 =?us-ascii?Q?myjVNANcOQ81tZ88qAsmTi8HbHZxPZMfegFhvLZWtHSxOoIZrSVimXwud+KX?=
 =?us-ascii?Q?OhgteigkcvqlSDgtJsHwGx+PUyO+o9DSxcCZKirXq2xPmyYXt5DAeKlpJip0?=
 =?us-ascii?Q?3rHwo9YMvNAMi6MKr6uankAHJquVsnaREdJS9q+f4Tvj+0r3nF5k58plxCrU?=
 =?us-ascii?Q?2gEeeuOZ6v5Wrdr9F8J+SHIlGW6881gaFJjUq4G8+EnYX5CdPouEejLOkhd8?=
 =?us-ascii?Q?ZaoyyVNANNo1jU4MpW1QiYTYM0LSFqH+i8XsXDRK+7quylyhW2eEIMnLyZFg?=
 =?us-ascii?Q?TejwHtvB2b0bj4sNgFls6YuyMiHIPpVHw1oinzaH3vHlyldq8bLOaYfluYT6?=
 =?us-ascii?Q?Uy4LiQYuj0tSONU7oWkXGo4PDTFZ/ki+P5NdFRlhkh4aAGdqDHvzIcv43vyo?=
 =?us-ascii?Q?keZ+89eaqorP+ccqfHc45IUcXuUqrLbE3uL6Eer+7J5zPynD1OjiCBWHZ/gZ?=
 =?us-ascii?Q?IwDSPflK8ksKad47B9KKTtehuYqu34kx3sPaGvjwJQHMAejCP71yWVRgr0pt?=
 =?us-ascii?Q?8kc0Dlpq4N4VX2lWOvfPWQauTP+VoTSf5HgNccAoTuU/6teBjO+gRYPVEq8A?=
 =?us-ascii?Q?JVkHOdXrf3566xqbRT3ZdTGXg+gdPKjvC4NaXyFiGdts6zzxm7UOm2sTv+rS?=
 =?us-ascii?Q?/mIyr8w9Lp6EdJ1JvyXxRjszlp2DBNaM4gGmyNkPyZ0aWJgEexoCfQYrsRLK?=
 =?us-ascii?Q?J5a/lvnTo8plARJSfEtVnJ/IELFHKeWqBJDSFzocBWd9ve9wOjWMLB7FVUxw?=
 =?us-ascii?Q?WaiT7es0EJHteOkYK+/o+ff2bht/03V1SkOZ18bg3qEzxLOKfKLg9qeyIMgL?=
 =?us-ascii?Q?7sCgkBYQ/piQvn+xKce62gHcTmAZUh/elTuuuz5la66sRK9nEcpArlFgGJ9B?=
 =?us-ascii?Q?mrMlpSgc9RZFcb1zrOq6s6KwM6B+m1BoY2Mc3cV50VClG9xse/Hf6PK+sW+B?=
 =?us-ascii?Q?kIgV9sm1WluGmBlzvOgjHwbh4hDOkzM4LKLiKuhf6B41ikKx3MuAqBguU/Cb?=
 =?us-ascii?Q?pbkSFLNJQdDHgt1YmUnVkvmRJy0gzzpp2METe8t1DLtALxbaUZW2RQfX1In+?=
 =?us-ascii?Q?RPKpcu99xeNbtTCl9Y3TyYLk6WzNX68UxCcuwyIgw9eCYb8kZq4rGdLQ+h8D?=
 =?us-ascii?Q?+VL850MPK2GuGrdEIaVk0tP7jIQ/gexH4a41ACLth7IZq/sfGv1rO0kx5HEq?=
 =?us-ascii?Q?2vtbz5Fo3/Hyawzx033B2wfriH9dPY7+dqfYMf5vvrP63dQe+lzzcU5/+45l?=
 =?us-ascii?Q?W7JA+6aOrDIXoiaS7hwE4LDOdjNBjkOX1EqxGwm9Ril/aWU1qizBi0XwUK84?=
 =?us-ascii?Q?wyNRjyikYQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
 iVh+5I81QkcQpgnb93+TW884Gw1tSj0ammsvvkyk5EuKkLw5oOm4XneOk9DfeFTWSBnbHRA6Qvaq+Ng0vq6BXxtyNGuJaMBgeqDlKJhVYneF+d2we981WmgGuYznkFjqD0bJRxxcYjKW489moqRd4ci/5F05KuieO1wJzXU1b6HQ9jqpIM1UvBdymSVLFJ0g/5UogQC0KY+0aU+sOe6ShZsAHmx6rIWErNv2znaH56PMTvOeQGfhdkkf+iizA4vSTOKRlDeYPxMiPRVFsH5BPvnWZ/KGADZQxIKBvtKkzQ8ynh0YWdOVDrGnSuo40mogxONZ2StZ3vEBWmEO6PDfIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7008562d-319b-4990-43ed-08def4cdf2cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:50:51.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvPkj2dyf8MWKxREOPuJg4uH0JL8yb/cC7lW1WyDAZ+AmQ3aai8e17t+tz+27+U0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-OriginatorOrg: opengear.com
X-BESS-ID: 1786139692-102451-7727-4985-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 40.93.201.143
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuZGJoZAVgZQMNkgMdnMLMXQON
	U4ySLFJM3ULDnZIC0lLcXYONnEyCRZqTYWAEer9IFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275220 [from 
	cloudscan18-147.us-east-2b.ess.aws.cudaops.com]
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
v3: Remove is_at_port; implement ->dtr_rts instead of ->tiocmset;
    open/close DTR raise/drop handled by wwan core (Loic Poulain)

 drivers/net/wwan/mhi_wwan_ctrl.c | 172 ++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..3aef90ec2176 100644
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
@@ -103,6 +131,56 @@ static void mhi_wwan_ctrl_refill_work(struct work_struct *work)
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
+static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, bool on)
+{
+	mhi_wwan_ctrl_send_dtr(wwan_port_get_drvdata(port),
+			       on ? TIOCM_DTR | TIOCM_RTS : 0);
+}
+
 static int mhi_wwan_ctrl_start(struct wwan_port *port)
 {
 	struct mhi_wwan_dev *mhiwwan = wwan_port_get_drvdata(port);
@@ -163,6 +241,7 @@ static const struct wwan_port_ops wwan_pops = {
 	.start = mhi_wwan_ctrl_start,
 	.stop = mhi_wwan_ctrl_stop,
 	.tx = mhi_wwan_ctrl_tx,
+	.dtr_rts = mhi_wwan_ctrl_dtr_rts,
 };
 
 static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
@@ -255,6 +334,59 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
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
@@ -278,7 +410,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
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

