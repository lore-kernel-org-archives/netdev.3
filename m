Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAB35C190;
	Tue,  6 Oct 2026 04:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259555; cv=fail; b=g7910uVddAZ8SfXWIevrbMZxkfTOKMO48RKBS91ZvzykB5mGj8K9WQQPnX9N6Hbz+E++qh75SIb+Bdg5t4kEOEg3U/A3vCFKUuBGKRxkVYeUw5IiQWExWhsJAeARiL0BRwSkPumjsYk0Z2tu8LSD1CXhwqdqeprJeVlVmX9nLrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259555; c=relaxed/simple;
	bh=pBSF7MLhXNlEb5HE4dJADMMpRYrxFkQeHsgM893IjBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rT6C1O8tY1DALTLH9X1dwLMTK5nmxdGsL+UACtVjIH8L8ROaF+TBYCLWC7KvGF+LPE0AHWeOmLxekOxyfQ+Rgh846KwDytRm9BMcMgT4ko8O0DYrQynvQiyVhbzGPGvpHIh7JZfrXngc3f9QwhZaBgt918KcmUaM6sV0WzAAuaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=XJFEMVXV; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="XJFEMVXV"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020083.outbound.protection.outlook.com [40.93.198.83]) by mx-outbound12-109.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 06 Oct 2026 04:05:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhTdQ8D4aCb1lV39vCaYAhx9sk+M48tLDEeLWDEXNb7wXY8EYcU3MxZ6HITri3pC6pirDScXSXEXcVMnrlkJw8iC/7HrllGMNo9HiI+7uX1x7rqrblLu4q+5yY58TmCWSAIM98AO41fHG4I1LYuPoQzBGNqkWAPB8ZpaRcwhyZvp1lsz1Pj0RtoXxN8sAkpdV088Jk8jTUr2I/D/dMAqynzRfSCmPwa3dLGcHPoV5ptyHR5HR/O+oifNFv0mfuimYKlExDhoX8Pdi+WZhxa0IFHI+nhrDYEKFqoa/bJSpRKU4zsHe/y9Tvd21WGxMg46ND+K91IUGeLA5t2fPn9Gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9lg7Rhj5aFigeEfyziwUEWqIFnaUPMN7vq/Gu1rbIQ=;
 b=uJEoSJvMXyLmP5LRfZGrPNUfxrdftoJwI13geYWjoQyaaZ+wVnBLSN2S9jzqv8hgpMzzz1bhgCJ3EWl2OnS596NgfdHvZkF0HZUYgj+DLWXyumvlcHMFdtdvBBWcNTpiT3lPQ1g93UHqsZvYR7Wzmt+3FI+vWI8s/5u0kdPZWqEGbWu4VbubENeQD1xsNuvmeIhSe8OjSpz27fb5vsX0zJjEuy0qJ3xgXrMVU6uXNGxVkhUS99/GVJV1sb4KY5Xd0p8hUXIGroyzAj9+R9qWqnE+H8D6FnPP+pOpiVaT0sggAB6RVECI8NewoxXAaPOPx2x1V1x6mSeL5Z0r6bhhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9lg7Rhj5aFigeEfyziwUEWqIFnaUPMN7vq/Gu1rbIQ=;
 b=XJFEMVXVBYc8oUtPxnvxLQHKIuNd8vioUUZR9HLyU7dSoARktS07PYJfKTbwPZ+h/DjmqVyoHzeLj1G6nRDc6jyhhknMZK4odohkRnftwznBwgqcqVQ/nERqKrimNF212yeXv7NKqky8pwysdk913hcPjxyVWpDlyr9bXj8d/v2rsE/DjpvLLYWPvWhABWNwSlEuhneAN/6Yuh8IF/luOR+YUpXZnja8S28Pdj/kvvaGFWErkoMLxnyixe6xGVrmM/8uHvM7NiPauayvl90OJukxncjeuhNP7Kg5F5nH67OKoe9TXAv5y6yyM91viXjcFfSNtsTOIH8YWevPmSHl4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SJ5PPF1849371D1.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::78e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 04:04:29 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 04:04:29 +0000
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
Subject: [PATCH net-next v7 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel
Date: Mon,  5 Oct 2026 22:04:22 -0600
Message-ID: <20261006040422.3208888-3-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006040422.3208888-1-peter.hunt@opengear.com>
References: <20261006040422.3208888-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0157.namprd05.prod.outlook.com
 (2603:10b6:a03:339::12) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f32efc-d525-432e-9c49-08df235eeb37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zRxFqpdxtI0gdtof4zgJiPRgl1Od7aiHwtp7mMPUYP5CL+6DnNk86j9OOVsROOYNR9Vvk+0OBVVbxSEU/uUo5mxYJrfELiWQG+zI0qpVXoP50q/VdbAYguRNYpWCUQtfEytELjJJk4MbrukJ7KcpBKLo4/J98OxX6gqx9ug7nqcmze7eib2Vlbyr/MggWBIuxlcvydhEdF9gphpuah3Mq9f38z8np5W2dPb3/kYCOsciIvS6cSyQCn8vNlUhe/+oKQDCGhAgdd2+9AKQ1c690TDu98SA2EP+66SiIF+xsLslKZxJ+oNi2KIsj2EgDUmlwrJnaSQacb1W6xGKV9NmP86wdElqtXC945eLK1Lao/8FGw620gdcth5RIAzPHffue0+4NhHgVP/+lmgAf4ZOqle5G1hqEuUlX1oR+dzs1VFMSTkL72TBh9VWpFl1VwHu8gfWCTJUw/lgnF38s17cx9zqlFvSRPqBRD6TyhZJrK8d0z10JrKNDoGDE9Gh9klFhvVnDvGFDgngpX1hvTk13AGfWcl6QUG/sUksdowaHwlO5n6I06KrYmpgZ1kq6hx1nKP7dspIrMUxX3/X3A8J3HxQiDWBF5ubL1gy4A/1wE1OySABHAl6gr7RnDEsxldxYEBOcWzxM5kpdTHT9Toi+I2ZZQ5n/97GzpgSzocXFGQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1HmN6TXPm6sb8Oe9zRjedzmsgcE0vWpcjjlQwt0sAliiIxAGqxJYSUKVvtc?=
 =?us-ascii?Q?5S8YbVRuXWkYB6CBCxjXj4irwJglqJcJ1fN8jVXChBJZmGCXKaqjOtk8lYPC?=
 =?us-ascii?Q?Th20VEnDR8mbvHl3IlqlVB9e4fgufWntgBr8q2BKtCFKOot9avQPjimoH+JE?=
 =?us-ascii?Q?3zRGZqM7H1U94ySWWAJS+2LQ+Cm7qHBWi3YOASpdi+aXSwDxQ66gf23Wk5k+?=
 =?us-ascii?Q?HRPeteXttNBRAJrCzCRdt5Ba3oI0s3qfbi2YqEVF56bJazzRATVdTYcw0nCa?=
 =?us-ascii?Q?s2KNVJqK7oEdSUbK49Y9e1bcTicsjDwyJfPiToS2OTwUPrEbA3PHo1uyNH4N?=
 =?us-ascii?Q?c+2yJVNUUF774e7M+WNhMPfJtknja0hMA7046JzJpFaf/Su4KrWZhti+tcJL?=
 =?us-ascii?Q?AC7cxF6npZ4oAflZsS4cn+E55xV0j/dQ2hHD/99vumDw+NSaRzLTV4l2s9gd?=
 =?us-ascii?Q?NgZMzDuliC3Y4YTahNhrdcU7HQkjgxx542M75FNBsiKoi2S0D9JZo5vbsIVi?=
 =?us-ascii?Q?LGZTYaj9bRU7Ds5zKuDPCr7E/1/f9HxCcmKkdxZiA6CFcAuG1Ce3MJcOgY6L?=
 =?us-ascii?Q?uR3Xb4Qp+e/tIglU/itzjdXifco2AWAboz19cakpFo8wT2ixWXmCSKOinUfl?=
 =?us-ascii?Q?Q0Ip5J1S5gChr1FGFNPT7+EYTWhsXlLVl60aaxSVuvafPtGApaxpOFu2Gxv2?=
 =?us-ascii?Q?7ysNxhWauD/tQwqrlPS1V0eJDxYZlBQ+iHx7NcUAVlF/7CHejyBUgK2PkPwk?=
 =?us-ascii?Q?iOEWpxIZHP+BkphwY1L1JFr7olMMacXOdIprJua/IsT6JkRH9OtPZfGllqBo?=
 =?us-ascii?Q?VTZPVeIPRaR3kcHnSwFr0KUYMCjY+E1gljCxKxlFTWaT84NBUvtwLKjCw8zW?=
 =?us-ascii?Q?4SgjqV9+SqnFxGKQLDuNfJb73gYWed2mEqU9QFiBPXeWPapeSit0xeuWGLmk?=
 =?us-ascii?Q?vmXRN5LmYTIetnuPsrtUhhuLiECM9DYgtNAH+A3qO0OKWsukJCbvm3UrGYMr?=
 =?us-ascii?Q?mefkdGOGSTxcOBLEMfJUj7US4v2JLSRsjG8Fa2HTqHWpqDzfskCIGKc0ATHg?=
 =?us-ascii?Q?bATsiT1F6bLymXvJ97zfpcOu4ReoO8kmnCw/qPgitJCAkp7IvvlbT5x1s7Kk?=
 =?us-ascii?Q?VpXVVpceFi/SMUNkHjSbgY5XohuYyGJQHD2cxJGtMqEu7W1efNsNkDIApUHj?=
 =?us-ascii?Q?KnuMTLztJyO9vrDp4/BITadQ7c0OABK2T3KrkT1JLCI8xK49ORWCSnMZ5GZe?=
 =?us-ascii?Q?cnMWiyqSqGDkg7gtr4XdJ83BOjbaCJGYUkdK+rfImzpLpoLVqOLo/tLyavZA?=
 =?us-ascii?Q?paMNAbT9uE7oPv7peeJ1BW21m2rG3rwkLKb2ZXkTyCRVx1XZNnIfCTG89XUW?=
 =?us-ascii?Q?wS4ooDJyQd18ls48h9KB8cPUotYFHzaXXi3PVuAYenHvQgs+ln2PZFHQamjN?=
 =?us-ascii?Q?38ZYQrmhV3K6fwlrjlt24VOfI8U5u7TFYQIgbK57Voxca3zKxDFzJiHuhF/t?=
 =?us-ascii?Q?mVPGlH+G7L8WmcQqR1nNUs9WJwkJSzk7eGVzH8vVLelosiJkzeIhWSQKuip5?=
 =?us-ascii?Q?lAtbcyfAUPOwVGfxKSsvWVwHmwE1EOkMePn5GxPEzaWxSJyOQr3WznpjXFnG?=
 =?us-ascii?Q?ZuWHvRqTolwlbvi/uZmnJb+5AHdH09FTKUPetX3/IyX2szG/HTnxijY/m1Ls?=
 =?us-ascii?Q?WYKjiHwhGZWu0uBWWMLVeIoaXYIBG+CwZ4OSDgmNevfsp4Nh?=
X-Exchange-RoutingPolicyChecked:
	IEgGHidbYupwTixCIhJI+DaTsSiD/wA8+llVmRyer34ysQoVEvr+DJfZsB0Z5qbnTWIdULp1MSU5IXhqwTEpBGVFTdEVITpInsOvFlMLOETfrBSLVihhAkkoy9Dlc0/hlHTPzNgKmsY5vNPiu3j2mfk5klEAHDX3G7ZWqVxgPOn0FUJPFE/+ZFiaW7xmeXQNuM4McdHDxM2Fn6JVukRv++22MALsV3IZZLTOTtSJv6ZvbItgG8WhpbNH4MLxg3hhmoLBlfd0TyiHp0mADiCt8sOAK9CAcStJXCXQXLXj7BjFKXAsA4CkQ+tbZm4Th2E2GJDrZPJhnPJ5IWXAzX2eyw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f32efc-d525-432e-9c49-08df235eeb37
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:04:29.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5YRHQtaGDWGwLQZMysYneUSFGyDFOVyZ3ljf2lbU28lruIvvXTVM2JK/XxkLLS3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-BESS-ID: 1791259467-103181-25096-35818-3
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.93.198.83
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGxqZGQGYGUNTEzMjA1NQg2c
	jM3Mg8Nc3CwjjJxCgt2czEJNXMPC3NXKk2FgCHg2K6QgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276636 [from 
	cloudscan21-7.us-east-2b.ess.aws.cudaops.com]
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

