Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2C2D9796;
	Thu,  1 Oct 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887636; cv=fail; b=FBe9KxDcEKt2MKEK2MHz+AmD8ZsKUAgp/WqLlBeF937zUNj7Mzka0mMCTnPaEFeQSkcNY0MFMK4t4EwUX5p2DPcqsiwNQRXnIWB+W4TiWPcW4t59LxZEvneSs2gk5kO3n2pulPqeRVAVah38lQVFfVZfzUOs0XCx+8vAbn+vkEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887636; c=relaxed/simple;
	bh=sJcm5EqCTA2v/5Asc9IKXQaC8WdM4uqA/Z+lBZ/KAmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lm33kFRwH7F+pSP2ULOO2VZGzo315JWNDNt+HgOsc1k/moW9Fq0HfASTnMXOnnroY9VVJYkMXAI3ey3tvQXli6sW0V2HqpLbCQMvAH2kk9D+CF3bSupgWQUR6YRrhG7VeLWWcplldnu2u7ALpgseQNXN0M++LoxHU0tIbxWCh4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=rL6g1v+m; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="rL6g1v+m"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022137.outbound.protection.outlook.com [40.107.200.137]) by mx-outbound12-208.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Oct 2026 20:46:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4W2kY1eSqpqSbpdk7Ho6Oe8M0/JnDnMzAdSPBdRAz6bG5MZ0ZFVvdg8VI6hNwgYSqY8LCKrJ5ISpn9gcvrtvSVs7hx94I5MVBUUNhgHzbmGtJt/0ZhxkYwVEoAMFovC9PHl1sBKRH63SHOIOAdRtzTkf3NasvclaiC7DGBj+2SmIEsmawUsUpghvyb6c+6i1mEXAMqe0tQHWAICvduXUxWZGuHJcYRhEpvR7ThZcaFBqrajt4ffmUW7w//EXo2ZKGWNb1H8VeWV09IhtiNXHG5cGmbgnyu+G6aeNPk2E6bSEz/nD+i0rnvDIcPa3tXOIkdRcnbJ021/67OziSNLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGoRR6jVv0zBDz2kgG9rWaHO/0PjpnbQ4FcSrCYhrIs=;
 b=R/8/gsLgT0l7VwDzhm4tcQtP/k0PLv8fXVwCg8V7MiXiOMuI0JLafbITW2T90hk6TpKG/LqMKAcZKkIU4nWQWlIdjV6/MRx6lIBIb6D1kxza74Bwv6dBmW66effMHul3by0tHDKsMexW+kaHqqQoCsxjRub7Z0cGbtOhsPSbBIz2UhWfGqX5WiaQFBPagMI/5ya7ZjknBI7SBLHXrGHzUP+Kcf/N5/3dv7i1R4Xu4E8lnnvG9mBKCdc0SeLpcJCJUnzjYTEuOTUhxXIjzrOmM28NSWzR39VAnIRWMHZWoGr6yxv41ICeuDMTbYLgypFO4HhTHqCUU0Aykte6mB6GeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGoRR6jVv0zBDz2kgG9rWaHO/0PjpnbQ4FcSrCYhrIs=;
 b=rL6g1v+mOUAyNN2Tahl1+7iSyLKgGqVYrkER4bJHaWqMP+p7E1V5jeRqzcZExGCiO8VvmcSQkzJDk8bRe/Zf2PxDmoBjF4PyvO1/Y9TyPTFF9q6IkeuhxMySxSbeC1BquAriODvq8opUlww2ck7h/evtizNxFJudTF0MIIDgCAkiptjbuDw2sqY/eOqyQF5MPa9c+4n0Mx/GLNsfgE51YIyeDF8bm/Bb4Fo5dVD1Ap4eUZl6lHPqhXNRDup8wpuEQ+Hk/fTQBmlgp7Z6LQ3xXV6EG7v04BMhjdx8ztgXOyVnVtYP8Nc2gSzn0lB0NksNfpqbM51ARImULIocBkJhRw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM5PR1001MB2089.namprd10.prod.outlook.com (2603:10b6:4:33::13)
 by SA1PR10MB6589.namprd10.prod.outlook.com (2603:10b6:806:2bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Thu, 1 Oct 2026
 20:46:25 +0000
Received: from DM5PR1001MB2089.namprd10.prod.outlook.com
 ([fe80::db19:a822:6d47:cfff]) by DM5PR1001MB2089.namprd10.prod.outlook.com
 ([fe80::db19:a822:6d47:cfff%6]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 20:46:23 +0000
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
Subject: [PATCH net-next v6 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Thu,  1 Oct 2026 14:46:14 -0600
Message-ID: <20261001204614.3481089-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204614.3481089-1-peter.hunt@opengear.com>
References: <20261001204614.3481089-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To DM5PR1001MB2089.namprd10.prod.outlook.com
 (2603:10b6:4:33::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2089:EE_|SA1PR10MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4fcfb3-05e8-4d19-699e-08df1ffd0d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003|3023799007|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 VTxl9YHWo8iIIDbw6K4dTKEHJycFFcNgWjPELUNPSdMwyUe+XSxfpvv9anWY2N74DKilxgf7Xj7Br5UecIkxlYWkLa0AYDxxRIunWJurH5i630hucI/cFzjTbh9Hlfo1YRmgS3qs7TiG4ON/LfU2VrZPTT/Uy78kwgSjTWKumg6j/6TZxoIJo/3XkfM0S01L0o/W8rM94Qylddn4Aa2hrPwe3SWdr69BWd3t289zUrzLTjB3YfJ4OTfRWbjRXzkVT7yJx/7tCnkEvfZN0dOx30/eA+lrB1rZ0xNNgU0+b7qtTqUBT2iLf47M/ed8KaHXopgXEYJb2dhXRhmAw78JJLjEXenggPBTn9Dddwr1eYQfOwbIYshGYSSq8QwBg9EHVkltn1eksJBceCFjzyWewRQM95mwn2eCCFqh7t4snFXQQFKHKn1ecWETYJvjP1vQvNgkNKFwvVHxtrzSME1kGkVgMCAeLshM8tD+oQJoBGPEnQRTr+D8iUWKFw2U5jXPFBOjcfdxMsIypxkfvcvk/OW1WXjN7HZjUVFuBmQOInTFrfSDhDbiPyLqUAllgalV7nVP79OjWVYvlFw71vrLnwA58RGXfP8drjd/7BsRHWQIgwxgz7pQX23UQo/xQkiNpqVeP/3SnzDeY7UmsQYGpwXn6o9g96/3wqIsfzVCdCw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2089.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?8RbOLoA1/TQPkuTM3z88Nn0RuSP2GeBHADqraBmokfsJq9BDh7o7kDUzRCa7?=
 =?us-ascii?Q?1wMCbLPPaCQoGSEFL39UpqB+begRAz2XYaDhIRYPTcHXQjPyhnCYt5Cq3aEp?=
 =?us-ascii?Q?iqIbkwLHylncws1G0ysQU8GvK/n82LYbxP4jFzUPW+J0S7G1THBpNq8bitj6?=
 =?us-ascii?Q?jZPisY/AJOniamcflpvbCP6aOwTV5rzYpWI/chMBs6O90248eLVgWKQC3ZOg?=
 =?us-ascii?Q?nG13WTAvsWnK4pKJWd7kFv6A4qvXeJFvB13IoewWGIkVRKX7/SbaZP9FH5oP?=
 =?us-ascii?Q?1JbI0w8zYvRaUWp/OZFNv8pAgDN5o0ijiOWHJnDb7Tsx7NbRW7d8cz488c8t?=
 =?us-ascii?Q?uZ1GxJJX3MaaOYAkCXgtb+JnlaQUnotboWSgMPYprMJs8QJik61sjZgjn050?=
 =?us-ascii?Q?SvMqnINKSDFwjV1hpu5/5KmMb54CWjMPOWTrMd84PyclAJvYeTLZlEn6V6cu?=
 =?us-ascii?Q?nmtzxN1ebOfhrBLBzL4aQZZKtqR14rRGAzAmLptPUMGq81X5lsQzEIQm5shN?=
 =?us-ascii?Q?ulS/udkX2XzKFrB1DFZmmguSj2KvYi0Xxeb282mfhcEFpE+nszKRaJKop8Ea?=
 =?us-ascii?Q?O/wt/RTTBGHyrCW6GAf3IX0s/RV2Coz9gm1RZCzy7rWMOmDytk6AW9IepLT5?=
 =?us-ascii?Q?cWUBMLfFCICTWyDt/3IgISUDtft7MCZECV2u72vlSrMcRU14Wctlgp2AQief?=
 =?us-ascii?Q?R+jbSDvLAQa8N2SNfa0SN3ucQ15MtNxBXESOf9CKr5AeyW32pDOkq4dA7xrC?=
 =?us-ascii?Q?s76AT7+8WJyO3UpnijxenROKUsRY7Y9s6IqloBZuAevojhn1w8YZ6RsAGptD?=
 =?us-ascii?Q?URAVA0oXdf/zDPzxS2NHF5vkCL7/vuO+kYz4x0yES6ADEy+fvACVhmRcRUyT?=
 =?us-ascii?Q?PxDBYPp/NUiXDdc/9gHDxveEXhiM+cgdOtuUfQYVlGvv4c9ygh+OvFa34g4e?=
 =?us-ascii?Q?tH/9jpqDCgz1IJcSJb/zNj1NXbyIaq6PF3eLj2nphxQEj9G9xkWEwpms+553?=
 =?us-ascii?Q?eHdDUV3OxDJJwzPv7Lxh+AcWoNPaAjyhUKqyUKIFotVSPv2qjf9Yjw8O2E79?=
 =?us-ascii?Q?jdqZfpV5xZQ646eKZgupyXMurMtOf2V+DUaUDnFopOiCfrAlHI7EAf3paLDv?=
 =?us-ascii?Q?F7g7ROOjDIvpFQuSmnZCwhACgTZPObcisptyyLsl2fNnTaQdHSI54Oxge0wM?=
 =?us-ascii?Q?AQ5SSPOqD5kiIa+WaAgyWj9v8LY/whXn7QUHyNcmFG7bVw4AOgXg3tq582Wc?=
 =?us-ascii?Q?MDPxy5gnDpD/yuxHw0VWni6i0AXBjVShGfbeJ0Fds0ygGzorKd329XFaPbs4?=
 =?us-ascii?Q?hWRVqeD3LQKgCFAEB9314H1pqf5SXMTBDQmmnu2KA/esLkwszCBQYfm4T2Zh?=
 =?us-ascii?Q?o6shvPwhaI7XmhdZLnYKLF8L4T2stHhtInRdZTmC2GBNfHoR0fCB5YLuiKW8?=
 =?us-ascii?Q?S3cKFMt4BDxaftCptmRfPV7JMEqfB/h3vj/4oZzF6l3A+CsJ3ah4MGRH4xfc?=
 =?us-ascii?Q?ROgjxmysEDAyqQeK78Z9oTM6Nngy1DWzAhSYrv7/ykeskR+jzji5nSVFiN2P?=
 =?us-ascii?Q?fFiqntyIrmYKFRh78B9vXLJb5h37oqqZKoKb0CtWGqYV51DX7Kpp5/12yB3Y?=
 =?us-ascii?Q?O2MTsxKSqKHl2GpS18WmHwKukXYkOL2F7pkIpartI2z6KORVFKPvK1Omuqkv?=
 =?us-ascii?Q?1oIcxkmVeW4Ll+5t/+jt46tjlQk6DomNOSVCxPyn10g/uukW?=
X-Exchange-RoutingPolicyChecked:
 QkiZlqm9XzW2wJFzsCZN1vLHT96YXG6z0HON/KTwRppuiGekctaueLIUlk1hpkTh2Zrzq/JHTptDZhiQQZrb2U8X1+a4nnwsSj+3XnSaMG3l31zIEC6HauaWxiUApSOeADoAfM1o75RWgG3cgsgY76pryDOLBlMJ4dPQe6OQimII1Hpuz9UPkazbeZyYDKL6z0iaMC6iKYCY3GN3NITYpHettvYnkY207PYx13/BtndNXowQCv/oxNZPDTy+LMuRJP90mrutWvTMCn/Van6QUlMWsvzbSTiFNNJ3zZOmZD0EdjpR5AI5GrSj2uy6MOdWYN7THrYhWyW44mbouxvi5w==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4fcfb3-05e8-4d19-699e-08df1ffd0d8b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2089.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:46:22.6275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ny0sUQK1TTlP+LNN73mJouJumvdhrXnpXsEDC1oAKNCGGjFhlfZOBf1qi1ZcHk7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6589
X-BESS-ID: 1790887619-103280-32484-15402-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.107.200.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpamJgZAVgZQ0MTC3NQgxcDMwt
	Q40dLCzCw52TjZItHUPM3IxNw40cJEqTYWANw2i0FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276532 [from 
	cloudscan17-162.us-east-2b.ess.aws.cudaops.com]
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
 drivers/net/wwan/mhi_wwan_ctrl.c | 205 ++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index a31d8540fbb8..b94484a1657d 100644
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
+	struct mhi_dtr_ctrl_msg *rx_buf; /* DL sink, separate allocation for DMA safety */
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
@@ -255,6 +340,86 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
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
+	/* Channel is being torn down (e.g. -ENOTCONN), do not requeue */
+	if (mhi_result->transaction_status &&
+	    mhi_result->transaction_status != -EOVERFLOW)
+		return;
+
+	/* Modem serial state not needed, requeue the sink buffer to keep DL ring live */
+	mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
+		      sizeof(*dtr->rx_buf), MHI_EOT);
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
+	kfree(dtr->rx_buf);
+	kfree(dtr);
+}
+
 static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "DUN", .driver_data = WWAN_PORT_AT },
 	{ .chan = "DUN2", .driver_data = WWAN_PORT_AT },
@@ -278,7 +443,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver = {
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

