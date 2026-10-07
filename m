Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC873E5A38;
	Wed,  7 Oct 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397398; cv=fail; b=PN8t7hX2XQtQHByulwFo497S+Fpa1G13bSTm6RtcYAwmI11OgSwGpuVlk8iumf5zMumV3YhstU6zxdr/LLbamgljkEnxL0W/JQpY5rGQ+XFu6oCCAe3sGBSifZneeEb6/UuoatN+LT6kiUbc0IljEA8AOovZq/YjQkw31ndKpiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397398; c=relaxed/simple;
	bh=rioOcZZzJ1n37mMt4vTZwu1xUip8xMEfORGQOpeORa0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HSWKIRrJ985LOJ2tRBE/XSpW0jAn7JfrscbM1Cl8mI8GiC8lz1fFCEAzslXv9kDlNo6+NDlApXDn8tnzamHLwohiIAsqwVXXZ33xSbndDHDBug0OMiLUqWVtrlfTB+nkHNO4LcnO97F5NhN+T+fv8UrBzTLa1IuQQckvInEylhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=ED82x0kR; arc=fail smtp.client-ip=209.222.82.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="ED82x0kR"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023090.outbound.protection.outlook.com [40.93.196.90]) by mx-outbound22-136.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 07 Oct 2026 18:22:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lto1sYGDONnj1QJ3lwTxgyhBp9FVf2YvCEGO45iOzuXNPG8t+2lohBNNF1yGsyvRw9gUla2iT9AZBRnLR0V4vHFEWiEjP7ihxD1Oa1glr7GomTvOjKc0MQxI2bKDBbNRK/UT5MsgOPBYOWvWZTleimHjiKaHB4b6XlKNPU5VxoW1+djNNGQe3MKJeOuYZJ7rKnQWFJeuX3xNuMjKkNpCptSWAtLhg4m+ju3VIdNxzYVaeCf1gzVKvzcQyxP81+g6hReeYupChfYlsUNNyHzRrpjCQ3POEMBYHR7F5Pgph1oj9xdwphNDCMuwb6k8colU9lnl5H3ydzgmeL9KSFOjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC9AAdAy4w/WWDQdUSbHObcQsKLUv64UvKZWctrh7M4=;
 b=ZzgURo44sBgC7mEMV+WUETvkVox8c2LUWF7rHUESCnerVUdg2dpUPLc/IXl5lr1MHQWvCv0U31V2IONceu8jIe4/ro3nT0LHFv+Vkyg4VyKLjEFAQiwmcRRABjLTIdYStL1ySx7ULFoJCbUmkbQFrmjUX3rIO00IZ2CDJxpgr7gX64sHd+xyYR4OmDgPqJW44ixviffWR1lh6ydBU38MZLDdp/1+QZUM3EmfiEYXXBcj6En6dVJX4NgXsIY16DnNtAa/coPIqFaSxCCmFFxLI8SFPBJdMItrFpYz4+e6rRCvOc68tdeUvn6omwWv+roQIbOZStHDiFnltFtIRP5rtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC9AAdAy4w/WWDQdUSbHObcQsKLUv64UvKZWctrh7M4=;
 b=ED82x0kRcLVMtnd2uhDKiraa5KBPRZK87ln6zOeUci+RF56GjmkYijF4AavQf+rzaDNGCHFwhZ7m8AQk6QttvCVAZ6lZqvjjHm1b7GPZDVjfAlQwIWa9dRcoCKL1q8AHDEtY3chfYFi/pn3Odw2cQwxvwhUVJPJtoQkeLs26HCv9fKD/HhSnAEre6wFppWAF2URGe9HtoMwHMUP20ztdCICaj46H13OQhl1n2eco8nkknRIpg6KbrbKj9KL6EBCQFT0vD0XMOGDdZExnwSoet1/3K4bbOhSlpDjIFTECWnpjrMMbiwxX6fz90EI3DVd7H0OZXqm23z2PuW9nDTy/eA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by CY5PR10MB6142.namprd10.prod.outlook.com
 (2603:10b6:930:36::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Wed, 7 Oct 2026
 18:22:41 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 18:22:41 +0000
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
Subject: [PATCH net-next v8 0/2] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Wed,  7 Oct 2026 12:22:36 -0600
Message-ID: <20261007182238.1154851-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: e88df0ca-390a-40b4-98e3-08df249ff981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|11063799006|6133799003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gkMGMxjmf4klm9tsdyqtasm70ICtoT04yzLVtAjngFjmOMI+dJ5nZ0plyt3Y+NGl1CpS/FnodgZ9EKwzz/mV5jkpmoZ2Xi6BUKi8KAe3HF6rV5YinAC8Plo6RwZvs6Kej1xV/M+sRC9MJ77ei9BXIoOdvbOxU3t0ao7cXVJHAl+NMYq6FD6VWL6dgjmLtqSaSEmI27lCh/zS0aIQReXS7m2gCQV5mtC/DljYcoQ7jl6yZjhNUmdJ7GEs/1X/AcJ/JPq01JoIKOgynY+MZhZpU+md6qwc84UiBvuTaQTjTe/B3yKb0XIBUqL2huLT2gy5/zi386Nn9A4ofpP/0LtjyNo8ElFmNKRAlBXYl+bmFH1WYY7k/+o/oO/XMSOZ+Uu/bVpP+3xViOEld74wML1q87JVainDkrUUt0qeCFkW96z9NSGMMtdXiftLWe7io5kh+sDYWwixfB1rZVdBCmku+u43BchtYWUSGNXzr7HbFBtv+nnLABVrKe7QQWD6n0rwPD/hbDO5mQYdS3lmiiQwt/Oe+CietWvpD23HbptjqoGFKmMcGJi3UK1gKV8Mkr17RmFl2nCf0rRRKAL0T55+cWZKtrCqAxsxuVB1jj8xgi3OUjz7s8/oGjRIQOjoxoQAZM8vDpMLQJyZ+8ECG+5Y9Qt+dZ2BvkOTOpYOTdX0G30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(11063799006)(6133799003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qnaAYrxnG623WsXtCSXtOJ4JPuLzV/O+z/1XcwXtGnoHbLMzdYpYz7rspaon?=
 =?us-ascii?Q?2YDRSQ1yKjezf++l+OGS21vl+6J4e1PMOVm3ZNKNesu2C2+fBVYARrMlTuTz?=
 =?us-ascii?Q?DOwZ0EwZtXlzx2+kBDecgTLseg0syS0AdPcJenFKp3cgvZEwhvk7SZuMoVLJ?=
 =?us-ascii?Q?X9F9FLJ4hPQ1X/Zp4iiMIQz1c5nHaYVHj5Vzu0bih0mGhXPks3LLuQpikK5d?=
 =?us-ascii?Q?eB8W5DsZvOW1SyBaBWqzndJMNztaA/KVynG4RYzfvPttvKoxoLzu1M7co/0w?=
 =?us-ascii?Q?32oEe86tm7PP3+3hZUydbP57vrtngm2OrCCIcIGC9LplTVQAHDiNv9baQIud?=
 =?us-ascii?Q?vqM1QDjWO30WuTkzIek6dYb/m5zZpphzR3K+W0jhTfmID9JI3s+x9Civxk48?=
 =?us-ascii?Q?LhB4h3E5NRvD+ETAcTggpgvTFFwZOeKwMHa1EWRuXXazq4LlL7CgSagZ94+U?=
 =?us-ascii?Q?KChVpRFyjM8Cv9gdULcwifC0I7wKGV7Z9egUIBHna0LoS3e70dwkjayck64R?=
 =?us-ascii?Q?gsX1SWjh9ltA7LYGwcmYUF92IfRqnn/nwHTwJa3e0kj4BMXOGobqhNPAbHQJ?=
 =?us-ascii?Q?IHPWdmVay4uPX7kkZzeuIlLh96YBXygrfMuK/BZx2inIhh4aPU1RBG/TQ/k0?=
 =?us-ascii?Q?34T5hRzqgGT428oRbjmt6UV9yS5a603hfFyQj5+qUb8bGOnRP8iJ6OR6oMQa?=
 =?us-ascii?Q?IPWKBUvowDoEVXKFQHhYr7VEUezrGCaX6ROKRWi8HcplMcOu/hphXdVXmJPY?=
 =?us-ascii?Q?BmNbFjd+oiH04207k4+BjCNVIRwaM4iRLzxGeouLOunSfaML6X3R9MSNFapB?=
 =?us-ascii?Q?/cVV64UubXtaCiNzZZ5nAe/LVldGuftji6KMAR2/eUQCfoJoT6/O2YK2ptzJ?=
 =?us-ascii?Q?8wiF24A5HanZVdl0XTJ+FELL0Y3lipyJRWs8mZAx9mo9Lu0COQWJF+E5KpPE?=
 =?us-ascii?Q?N7Y12F36MnYDMAuuHDRUKghhUT9+1CrA6Esd5MkULZKZPSx7JBrS0MfO735H?=
 =?us-ascii?Q?C/rskaaZn/+kteEYlRgd8utma34nHfa7+RDcvondvWpp1ZWnmWsbk88290DZ?=
 =?us-ascii?Q?Mqc7jiOsXfT03AXnxJb6dmnnCyPG+/EntqHhagt9qSAdESHA+STMrJPSSX14?=
 =?us-ascii?Q?pq4erkoPp30yz5GK7dz8JKuXpX83AAEziTAWTg4ONVHRWJ4h3pixGf67z1Zv?=
 =?us-ascii?Q?qGpBtUi99puv3PU+3tBqi+Lpe3/maz/WyeCFNiI3dYrzYQwChzIqjZ46Ud7o?=
 =?us-ascii?Q?wvH38MOgTdfUVnVUS1qyoJilctT9TgBBeftSE/b9oDCi3ks0kWHFTTovEy1D?=
 =?us-ascii?Q?OaO30VN/jVrQHuYaQPvQhcqlmquOYDnRvd/2RPn+vhY4wpfS6sae7vKfVYZs?=
 =?us-ascii?Q?vtr6BRUttsys2eGBFhaJYya6+FDEBqeZUtGQ4pVFF+qzvn3OtTYgpEG2n+Xt?=
 =?us-ascii?Q?4t2c31vnnTDNrvL4sirCRo7i5rhKtNl86/FZknXPYoYRNoN8RZd17ghGzBzu?=
 =?us-ascii?Q?Kjt/ozdm4IlvpbTqCm9BA9dBcNGhQ8e6M/q4GxTO+xJwprkgzB0CzzVUDJGG?=
 =?us-ascii?Q?991Yy/GrIyVsI/I75p8v8LRfQK1kExT94Qc89hkKoktI8xsbAgz4tLVMLmN0?=
 =?us-ascii?Q?r2G4MYuhLt/fajuJSK0kQnAHGIfaVlRkoUOOIe7wYDQzz5SbrEcFiVqDfqGn?=
 =?us-ascii?Q?plmSKDW76+2d+NcrwkzuPsgCUKXoDhvkmzZy/23bOe2lDMse?=
X-Exchange-RoutingPolicyChecked:
	yQwlsF0vQnZR6grzX24TplBnapSxahlW19T3ZhgqmVXJ9VESGh+1ZTF4H/gBqj189I0x4pZULpZ+tKSJOM/iuuhsM9WrvJ0gbHv5pXBKwy2GcIKn+6FN3QzB4rCNS1T1VS313IGwFxv1kcR0rvmFw3PjTsFRCEHLEGAN9UO7pecrDooT/zEzLB3ZDnPv3ON8aNYWiHzvv/Z7jyrJkqaZ1ajxL45URVxddlx/WEBwrInOj59P6oX58KzkCY8AwP8T2neEicf+S3G33lN+tYxPUc3iZnVWef1YEi7smCdJBCdcAjhSs3bAFnNigxeYIbxgLAqVv37D7K2dpdbxywKvQA==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88df0ca-390a-40b4-98e3-08df249ff981
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:22:41.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJXkysMe6AZ7eOXu1BVoMEBZCgDbZlqZH2sqUJGx8D87j3XzBQFFEJPfqp70eHuB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-BESS-ID: 1791397366-105768-9835-2110-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.93.196.90
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZmxpZAVgZQ0DIlLTHRKDk1zT
	QtKTkpxdTI2NIyzcQ4zSIxycjAINFQqTYWAIPrBG1BAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276674 [from 
	cloudscan13-20.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status:1

Qualcomm/Sierra SDX55/SDX65 modems (e.g. EM9291) withhold unsolicited AT
result codes until the host asserts DTR. The in-tree mhi_wwan_ctrl driver
exposes AT ports but never signals DTR, so URCs never reach userspace.

Patch 1 extends the wwan core with an optional ->dtr_rts(port, mdmbits)
port op. The TIOCM bitmask state is tracked in the wwan core, which raises
DTR/RTS on first open of an AT port whose driver implements ->dtr_rts,
drops them on last close (if HUPCL is set, which is the default for AT
ports) and on port removal, and passes the resolved bitmask to the
driver on TIOCMSET/TIOCMBIC/TIOCMBIS.

Patch 2 adds a second mhi_driver to mhi_wwan_ctrl that binds the IP_CTRL
channel and implements ->dtr_rts by sending the host serial state to the
modem over that channel. The existing AT/QMI/MBIM data path is untouched.

This is a two-patch series. The pci_generic patch from v5 that
enumerates the IP_CTRL channel for the Sierra EM919x/EM929x has been
applied to mhi-next by Mani as commit 83c29a55b89e ("bus: mhi: host:
pci_generic: Add IP_CTRL channel for Sierra EM919x/EM929x"). There is no
build dependency between the two, without that commit the IP_CTRL driver
simply never binds and ->dtr_rts is a no-op.

Note on the ->dtr_rts signature (Loic):

In v3 I replaced ->tiocmget/->tiocmset with ->dtr_rts(port, bool on)
modelled on tty_port_operations, and moved the TIOCM handling into the
wwan core, as you suggested on v2. Review of v3 and v4 then pointed out
that a single bool cannot represent the two lines independently. With
TIOCMBIC/TIOCMBIS on one line while the other is in the opposite state,
the line state sent to the modem no longer matches what TIOCMGET reports
(e.g. RTS re-asserted after TIOCMBIC(TIOCM_RTS)).

Since v5 the op keeps the dtr_rts name and the core still owns all TIOCM
handling, but it is passed the resolved TIOCM bitmask instead of a bool,
so the driver can drive DTR and RTS independently. I kept the dtr_rts
name deliberately, following your v2 preference over ->tiocmset, even
though the signature now differs from tty_port_operations.dtr_rts. The
open/close paths still behave as tty_port dtr_rts does. Is this
acceptable to you, or would you prefer a different shape, for example a
bool ->dtr_rts for open/close plus a separate op for the ioctl path?

Changes in v8 (Loic Poulain's review of v7, no functional change):
- Patch 1: add wwan_port_raise_dtr_rts() as the counterpart of
  wwan_port_drop_dtr_rts() and move the open-path handling into it
- Patch 1: do the AT port and ->dtr_rts checks inside both helpers
- Patch 1: use scoped_guard() for data_lock in the helpers

Changes in v7 (all from the Sashiko review of v6):
- Patch 1: drop DTR/RTS on last close only if HUPCL is set, as a TTY
  does, and default HUPCL on for AT ports so close behaviour is
  unchanged unless userspace clears it with TCSETS
- Patch 1: wwan_remove_port() passes the masked mdmbits rather than 0,
  via a helper shared with the close path
- Patch 2: retry a failed DL sink buffer requeue from a delayed work
  item on -ENOMEM, and log other failures
- Patch 2: note in the commit message that the IP_CTRL channel entry
  for the EM919x/EM929x is 83c29a55b89e in the MHI tree

Changes in v6:
- Rebased onto net-next, dropped the pci_generic patch (now in mhi-next)
- Patch 1: snapshot mdmbits under data_lock before calling ->dtr_rts from
  the open/close paths
- Patch 2: allocate the IP_CTRL DL sink buffer separately instead of
  embedding it in struct mhi_wwan_dtr (DMA safety on non-coherent
  platforms), and do not requeue it when the DL transfer completes with an
  error such as -ENOTCONN during channel teardown

v7: https://lore.kernel.org/netdev/20261006040422.3208888-1-peter.hunt@opengear.com/
v6: https://lore.kernel.org/netdev/20261001204614.3481089-1-peter.hunt@opengear.com/
v5: https://lore.kernel.org/netdev/20260819224927.2274790-1-peter.hunt@opengear.com/
v4: https://lore.kernel.org/netdev/20260816121705.858013-1-peter.hunt@opengear.com/
v3: https://lore.kernel.org/netdev/20260807215042.2714442-1-peter.hunt@opengear.com/
v2: https://lore.kernel.org/netdev/20260806155253.3378294-1-peter.hunt@opengear.com/
v1: https://lore.kernel.org/netdev/20260804233411.1953445-1-peter.hunt@opengear.com/

Peter Hunt (2):
  net: wwan: core: propagate modem control signals to port drivers
  net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

 drivers/net/wwan/mhi_wwan_ctrl.c | 239 ++++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c     |  69 ++++++++-
 include/linux/wwan.h             |   3 +
 3 files changed, 308 insertions(+), 3 deletions(-)

-- 
2.43.0

