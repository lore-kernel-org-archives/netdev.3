Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D949E15D;
	Tue, 13 Oct 2026 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916549; cv=fail; b=QAQuiA1g25G8dDoiL5dNVjaaCI9ZnNiGZ5QGZzsxfm81BeOlu6f0Gi9KkjcG2P+kG5Lq67ZCSaWzrWTXIK3+KjjTA5rIkeGzCUc1wBgkLCdCSsCI3axEZ8ltbdAbeNCfy5DrZs+BPFudq2S9V2NdjkHlCg05eEi2GCle/LD/HYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916549; c=relaxed/simple;
	bh=D1HTfWje0Ujj//vZNWnpCZ8O1wt+76FX4k2OyDZWJAc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YIHND1Xu+bi+G955C5uH/8PkEbQOgj0nB8XLxyyJBHbF9WS07ADn+VAUhFyrbOI3VpJwZN8aLw95lubdWrg8BFY7AM+0nYlA/SoOvNYnwyjsZOlF8E31onoD1z02GnzAopvlfuvUwi/OycV6/SxS3noz44TsoUsBMpI243/TLg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=KIi/5lxt; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="KIi/5lxt"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020117.outbound.protection.outlook.com [52.101.193.117]) by mx-outbound41-111.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 13 Oct 2026 18:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG03sxaLIKAg8nue+9FF/1PsaPU0AL46k4yxONd1biEsqZXf2OgCSIQJJIpWE+0RjHB57u4me+h5FLokGLe2fvkfAIWqwXwADyxqxG/1EA5gU6lWJfbHuuc+NZkZB2EehbfUgk3wPPKX73J1fd4x7Uth++CcNphWD/5ryvPobIa6sTYxsKE5veeiBL5ytcyFIxClmUzb9dWEBNy73TKyucC0LDMS2MUAEr5kXtCfkLVBFry2vVm2sPS0wjU5Fd5/tYujV6JaPSwK9AAfEiQZzyq3DtI633M/H+QT0ob7Dr3i0BaxHPd56u/ptViZOOT8J+s1HaXAWY0VtVv+Clo7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PumN9glec3lJ5iKehM16LjSRCpoYxSyNZMg/5rQxUbw=;
 b=kHq717slGgk965RAIaxtnveKam4G6rm6Ko6CaYDqcL0k6vDoJkPLlUMM7ltkLwtZVd45E15nFW0WJeKMlqoHTm4eeLwQNoV0/2b81hj6/tg9jEPaWsQh+KjIE9AT73FB6F3RnEwvP45ZN7oGa9HMTSx245kM0Fr6nOTjMOnrFH4rS2DGLZ7qcmLY2Yj5ZQiWlKhE+bJL4Ls1hbBheIt7MYXwqK8hv8Dam/YyVzICgRXqg8r0VJG8mswcJk423rDDwN9NTngFF1dl9J2FSZuXWy7Hnvg9mzvwiUV5NIpzrtrHsyYfNc4yakPAbDzCktfzNybYfQfs6Y1E4XRCxjcq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PumN9glec3lJ5iKehM16LjSRCpoYxSyNZMg/5rQxUbw=;
 b=KIi/5lxtgUhmMDWO8HwGkRjZOWpVGjpfJMgMwy+BtL8oQwPwhhnokRxzvZQp4+h2+jVJejHG9yxC/4JTh1v5AMtHrn5stVG/KFcrgQ5cDXxg8w73c29e7VtZCeEbrxsVd1WdkTAEM7El9UyOHppvMlgmdPkqQ70g9f1ZuWjCj+cEg23qsubqaBiASmqF1+Hi4aNhr5RXYRBdwnOQOvz3FX9yZlZD9stBFDYW2MOn4hIkrMHMybHfYUG8YnDvHxaj2NQjpB7LlrOfvw6t4O6q6Z+Z1wV/dmwJdEpIPKyO37G8trwoAbyqvuTMaJgrCkHmUN2YOazCvzoiJNKTS90Jkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by BY5PR10MB4161.namprd10.prod.outlook.com
 (2603:10b6:a03:213::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Tue, 13 Oct
 2026 18:35:05 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 18:35:04 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: Daniele Palmas <dnlplm@gmail.com>,
	johannes@sipsolutions.net,
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
Subject: [PATCH net-next v10 0/2] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Tue, 13 Oct 2026 12:34:58 -0600
Message-ID: <20261013183500.261229-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::27) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|BY5PR10MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d56b72f-24e1-46a2-19fe-08df2958b297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|10067099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hkWHeGu6p/isydesCycPcCsAkXJY+UVq2Y2a6ELxMSAVHCl1XPyp6EtiESE46VJUrmyBp/kbnOzXMMOmfmILuV6bhcauHXJGjDgZ3uEdBvCNFxY3xoTuJn5wMv34yR/nfBcts+q/QrABH3SmjigZR4bpZ7pBrH/mVGHqYAwgy6PXC1ah62jOx87igr2TUNGg2nxuzQO4fN+VgQqAfkj7XRStQI3Vl29YUvo1XqYA3vI3k7ZUEUP08gRcZyxuSaxc0GN/hrrdFaSc8TJzlW2P8o23CVFxhUz0ujkw2qBmYAB1PDzo1piPIRX0LCz5FsXrgLoTxLeOisopVJ6/d4Tw4X4yQTTbvj4bVA3omZVNxC8QYYS0FmV1jl9fakAMm0StLIurF4ItZ79mh4OCe+Usv/uSj7fIsTWwzIiX6ZQI2Dp8wBTzz1nE5zsOBL2X80Z2R7Fkzv8Xg5wA8cT3k3DUGo+flX60piWMT9DOJf7VpcDD4B7uzRy89TZvrFXYoeuZ+szaAC3bIaELiTsyeyS0JGPtRyWCggJ2hgs0UBdHu77E2c3QRYV2RFf1DwQ30ymHvMEZ8GfG0shgi9RwditYg4VD7dd08P4/zlgaxQiJCEx47Bgnos0zIRYNp617TFdk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(10067099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQz0tAlMC9uwhhoke/dYq0OOZIFhMiabySO+xC6OcsMegFl8lO3VWpLKm2hg?=
 =?us-ascii?Q?j9g5ikjrxMXRrvRTY9bTfKe49YYkSxUn0S+sVAfy8PLWvYqN0J8STWMGj4nw?=
 =?us-ascii?Q?FRHfYLVyZ9gZxia8YYbs3q3kcwjaCnJ3LS2+Z3LMad+r8G6psGxqHwLLXeLB?=
 =?us-ascii?Q?btTtNpH0pndHfujVwN2+tpN/QcOlYsuZEM/XVuTLFdXBZkUrUBSiYCZbEWse?=
 =?us-ascii?Q?O7erxFoHR50hTv7OWMy3S7ksRbG/3TZtFxM7/rNl0OSUgUrcKvsh+J7uyvNY?=
 =?us-ascii?Q?kusb7KWyVWw/dOerVZcMHAQMuCxxR9t6uahHZb4WmqGv+EMOVRNauiEbi/7l?=
 =?us-ascii?Q?6WvkBRDt6UzGajz1wLWQPPb38q0OPUkn477tYwOIcjJxRMgfo4bgnrN/7gN+?=
 =?us-ascii?Q?b07HA3vQzbpwa4fZE6M3Sf6EZoQ3L7CQ5S8DUbrkKfl+kuMjT+oz5i5+rwPS?=
 =?us-ascii?Q?JezQL3jIdjplUi+KfAZVqQmgcM4eKA6fnE5wciaQw/K4y9nu+ruhfljwbk6i?=
 =?us-ascii?Q?1ETSx58L+w9MEktALfcKuuQh2+t3JePEwB9CVywJzzClCHxwwoBcp9ZMhh/b?=
 =?us-ascii?Q?7uOF/7znDKro4iXGOyDtJPkTCPkx9fVwygJqBTUDZz4cqRneZI0/XUw68UrG?=
 =?us-ascii?Q?kd2xmiy7WFc3dI08OLSbdf8Cn+nKxWqcHvj0Qk7ir0Mtb9jDLVNlLwOe3mTb?=
 =?us-ascii?Q?PtwLgeBUiE9hEqNgm2jSXQzrTqMfzuLYMNddDjm+HU8V/MsO2VnsJ6RCt986?=
 =?us-ascii?Q?J4v9qskhEOf+9kvaTVqXByPX3ZAyRo0YlQ1qyySBMYUMc13+9SNKMDxiMJSe?=
 =?us-ascii?Q?Czchbxw20WnJ3bhpZc0kWEKJ7lasyLmtLXVl7eJv/w2P9Q3dsaWvLpMP7fjG?=
 =?us-ascii?Q?s+Dk5jcfJ3rmIci/ThkNcPCEXf7Vfexyy7vpSzxJftwovdJA1FgC+mkyaATo?=
 =?us-ascii?Q?r2G3vmFxQKNgOTfDKxoOgDCaf5ec36tB6gOJtu1i4hbxAw6M411KIETj/Ney?=
 =?us-ascii?Q?LvIIOGIF5xy5SSSBXibu4Mc8ugUi0UxhhurhOG3yzi3baALBVTv4efb9eb8T?=
 =?us-ascii?Q?TrLfOJPXChJt5L4aDpH36+k39kaBFZj61D4jXCfRlmrBf+DA7DHMRz3z2KcL?=
 =?us-ascii?Q?Y7PdvnJ0TFmkrHxe2AhG87wm3oHk9kMQOFoD0PjGWCMXoZkOY6JYwlkr5KeC?=
 =?us-ascii?Q?8zTti3F6vSFrcxN8nXepqEpzL8n7hbR2VPJoK3zwJT5hktRjgiKtUkIY8GSk?=
 =?us-ascii?Q?PkBLddFTmxXTLBd8skmY2WGx9EEgV8x0FtRu5W7saG6FLP2WVY5rjMxIiNWg?=
 =?us-ascii?Q?gN3uNTEPRetscAdmHvoBCSJSF4KcXe85p4Y9YzIGQjG8i29vnc/6FECeXkVt?=
 =?us-ascii?Q?QuWzk42/NOm40uyeLUlUXcg9DzPbhjl3J6pwK6oKNFK7IKTo9ll8Qthg94PJ?=
 =?us-ascii?Q?sl4ycRpFxuxtcbrLOFavtTLfL0dW1Y3PWG74vuhX9ZSrZdDe5kCwuVbuKp9R?=
 =?us-ascii?Q?OyNP1a9zTmboh1k7xQ35LGXx4vbIEEwEnpMb3V0ZdaHjR9s92z6iGrcCrjyX?=
 =?us-ascii?Q?wYlnB8z1k7JhfgM8x/xiO+V8IPJ5j5FFKLIcBUQcXBChMx+cT3cOI2IlkgJq?=
 =?us-ascii?Q?Y9Xl0vAwNTT32a2K+KRUsHe8pgWUOf5KV2TnQggrU+Nwj9EhHleMm0Uw4BEM?=
 =?us-ascii?Q?gHB3OPfogLyPawrbCmmQwGjhGPDflIQOosaZocJJCunOGGi/?=
X-Exchange-RoutingPolicyChecked:
	TIO2YyfRO0YjAfFlZwwn/iCFIBGL3F/ZJg1kKu3EgcxicieAyuf1nJesdY5C6TSTnjkSiDhjANcZIHAMOH5/XM1OBY6K16MwOb9sGAWfwqmb2fW7/csjIl6mK29ohvKjtAfSGA1sxMSCJLmwddZ4KSejDDzjTKww6Uq0qVr34VQG8DpmCugNulYTcqWmPeZz8jfWfF4ZtM9pFWDkNR1VGY9OJ1q1lKrsv++6dXTu0yzi/+QsBDN0tGVyTjKsMzQKjSAV/GycQsM1/NBXFyu36uBsWFU291ElrP4HJ1TD6U8yFInOvpFH6OvB2SBNHg2pS/T4AMm96r6kDKkDFKVDVA==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d56b72f-24e1-46a2-19fe-08df2958b297
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:35:04.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9d9oyoarWmmLaNUgID1cODBjpL2IqwPcNXz33xPLd7CpmBRpKAjUarMw5k1udvtF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4161
X-BESS-ID: 1791916507-110607-9058-3181-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.193.117
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmbmJoZAVgZQ0MQsKTHFIsnM0j
	w5yTgpKdEkMQ1IGKQaJaWlJJmbJynVxgIAr/BV8UEAAAA=
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276817 [from 
	cloudscan18-30.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
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

Changes in v10 (Sashiko review of v9):
- Patch 1: the AT/QCDM ioctl handler only holds ops_lock around the
  termios/TIOCM state, never across a user-memory copy, returns
  -ERESTARTSYS when interrupted, and no longer takes ops_lock for
  ioctls that don't touch that state (TCFLSH, TIOCEXCL and friends,
  and the FIONREAD fallback). Still ops_lock only, as agreed with Loic
- Patch 1: word the TTY comparisons and the ->dtr_rts kernel-doc more
  precisely (the baud rate is not used, removal only drops the lines
  while the port is open, open only once ->start() has succeeded)
- Patch 2: send DTR/RTS changes from a per-port work item that
  coalesces bursts and retries a send that fails because the IP_CTRL UL
  ring is full or memory is short, so the modem always ends up with the
  final state. Stress testing showed rapid toggling could fill the ring
  and drop updates. Loic, I've dropped your Reviewed-by on this patch as
  the send path changed

Changes in v9:
- Patch 1: drop data_lock, so the termios/TIOCM state and ->dtr_rts
  calls are all serialised by ops_lock, which the AT/QCDM ioctl handler
  now takes interruptibly (Loic Poulain)
- Patch 1: raise DTR/RTS inside the existing first-open branch of
  wwan_port_op_start() (Loic Poulain)
- Patch 1: mask TIOCMSET/TIOCMBIS/TIOCMBIC to the output bits, only call
  ->dtr_rts when DTR or RTS changes, and commit TCSETS/TCSETS2 only on a
  successful copy (Sashiko review of v7)
- Patch 2: requeue the IP_CTRL DL sink buffer only from the refill work,
  and disable it with disable_delayed_work_sync() before
  mhi_unprepare_from_transfer() in remove() (Loic Poulain, Sashiko
  review of v7 and v8)
- Patch 2: leave unpreparing to mhi_probe() when probe fails, and name
  the wwan core commit in the commit message (Sashiko review of v7)
- DTR/RTS stays limited to AT ports, as agreed with Loic and Daniele,
  and the ->dtr_rts kernel-doc now says why

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

v9: https://lore.kernel.org/netdev/20261012172219.3668624-1-peter.hunt@opengear.com/
v8: https://lore.kernel.org/netdev/20261007182238.1154851-1-peter.hunt@opengear.com/
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

 drivers/net/wwan/mhi_wwan_ctrl.c | 262 ++++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c     | 172 +++++++++++++-------
 include/linux/wwan.h             |   9 ++
 3 files changed, 385 insertions(+), 58 deletions(-)

-- 
2.43.0

