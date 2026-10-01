Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1588493D4A;
	Thu,  1 Oct 2026 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790887613; cv=fail; b=txoBAUkq74u6K/wJl2lxnKDB0rB9Cu2Z0ykY7ad3G9S9toHfQjSnGJBcJ8lqsZ2FaIirabB2tYKE42ayAyySFsTKesmD2cEhskgfz1YrLIZFsnoEmL/IL1ySKA1ll2wxEXToNFR+ggZ3BpvblK2p64+BMDvvnNJZAcySpyB3uG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790887613; c=relaxed/simple;
	bh=55xMZWyDuFCROdjWSNz4/KKXg8b6w5iBYvIeMgBB7zs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iezmtsKdoX6neC+VqcoejkOWeNW+Z8JzWaGqC+jxpLuYzhUNDCj9fpNerQC6RYBBIQqppEw1D39TTT1OSVC0JEu/JirzRGIEsufSVl04WXXNK4o1uXEMe10r068owiKJyzEglxrKF+/vIvfTLDL/8ZaDGBuB2d8TOWbo8tMxOv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=EJrBgfVP; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="EJrBgfVP"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023090.outbound.protection.outlook.com [40.93.201.90]) by mx-outbound17-40.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 01 Oct 2026 20:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgOpsOt3fT9oLluaaCWxV4gllfrX4lST1j6thMNWQg52oEdz0usLHjw91QKJx03XAiA4FJHGYQ0d1NmfUrWFtZCFBgeUN+2i55uzQBUbADTkAzha9kGLYlTb3v6VKdQA6CBlPqTV3kaBGMCFF+Mj3CKXZcST4VQ2X16Vw7b6rIx7/bHAd2+huE6hpMKzURX5Ix1h/VBiDkc+fdMHDoPViJ+Xz5JFuVCoHVxkqqO6/lxPJ2GNPyvT5+WaClNGtuDcyF46SDhkVwD204hadwI1gHIkNGIDVQqc8RsFpGHUhND7iDQPOFf8niqr8QCn7v++M6/X6UD3h1U2qLjzNAK0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSMbbfvH4eOLS5xO+CzYPX9mA4SHUsL+WcyYDBp3m+w=;
 b=C+YzeIgUjXSp+eVu+71C9K0YtNypAuXHLhaNyN0ILQ18wFrosTQN8EU6IT9fpVzSlqyLgvHVcvhzQSOkIrVWrrOne/91Earr5tZAGwKyLfE1PRDUN0Q2XlGeXreT7G75nL6lmQJUlrCbKKYcx0QrW50wtbG5eJg4nCJIIH8+JaWeX0BhVTFOeAS5bz3+rOGkXJUUcM0whUzf8QP3CD7RqPZyRAWWTv/bMDsBo+/08+nWS4PmpppOV0lM3m6SLrnlW572a0YqK6yYF3lL/tGo/OrdpcrqpXyqtOs2LOkxhesdAaIfQ4rehuJJon4iGfrmsq4geKN2VRkD8CREpJmJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSMbbfvH4eOLS5xO+CzYPX9mA4SHUsL+WcyYDBp3m+w=;
 b=EJrBgfVPz1IwgULj5Xc7cwHZ377ggFygLUM+03q34VazFp026wOzkn+USFAtbc+06ItdPCOKFFGwQiP9I2b8G9wntbY2yQX6xr/RstEQ5UggLxmgTceug3l5xk1hJBwPOuSFNenaQAz9P7lpP2gl9OA6Xah4006qk+crIxbp2fG+sym5Wo8bZ3ZhJYvOahYFoMDwWMOI6iqULH/9YgiIN4Zeo1dB8c1shkMSV6TqdM4aJM5191p9orsseQK95kbw6a7PWf8TF8dMLbYM0W/wl8RMQpah/5Vm/Ck7z4pMsF0bUkalwiuNRMWMF3yjiPxzXwRpPu149WmIKfojsKwbQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM5PR1001MB2089.namprd10.prod.outlook.com (2603:10b6:4:33::13)
 by IA3PR10MB8489.namprd10.prod.outlook.com (2603:10b6:208:583::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 20:46:18 +0000
Received: from DM5PR1001MB2089.namprd10.prod.outlook.com
 ([fe80::db19:a822:6d47:cfff]) by DM5PR1001MB2089.namprd10.prod.outlook.com
 ([fe80::db19:a822:6d47:cfff%6]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 20:46:18 +0000
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
Subject: [PATCH net-next v6 0/2] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Thu,  1 Oct 2026 14:46:12 -0600
Message-ID: <20261001204614.3481089-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To DM5PR1001MB2089.namprd10.prod.outlook.com
 (2603:10b6:4:33::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2089:EE_|IA3PR10MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e93e2ff-f8b3-424e-5f4e-08df1ffd0b02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|6133799003|18002099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	c4Reml1ydGMmrbw+g/Xt7L/COzukD9s+zGPX0DI2xDK2qQnLxH0qy82J4cqBijY0XAKCi/ZF04nAh07aF2JYbekqBuc/Rb6SyWoXsGHjEw74t4mfjmTDKvMSUsjNF1zEhCW1E4orSQx+HhHGUKJ+t7KfX6utDDQ2F7EgKAlgDyCiLdtOqPFS9YSw/pEnwzSzM8lOdZ2+x2a+ZMT/ovbbCNokv4MPHAnrjkTDsyrmoCp4TtnV6cXp4anYrX5ibMCrhCCpTJvc3mqSJbdaF6NXHIlONCFd7Nr5Gvf/5+sodOgOM78BTl+cbHyVoPnQ71VRyib+6hhRinPJdHmOuMRhoN0gKcs7M04RGRsOs1xRK7Udk5QzuyPYK4s13cflikEVPaUruxhZaUkA2F3xTn0xO24aaa5WFMEzp38+9XM1ShBTXqhUpH03VCbavYd3ghOgMcpIO/Tu76v17f16AOb9zWerz6bh3K91pxKuJE/PbkAxCSP2EO4sionBvR3GI8Uwj5hrjg1pYxtfYYS0XJ7UIwh7gIvciQy16uIHjswntnDYE3Oa6fnRqBkD/pD7FqPkxv0TL9sLpL6DDwjK/YpQsjygCFdrzZWX488BSz01rgDCbywNX7FEcRKF3G77Ipro7Lkxvzmmw1hTBoTob0+kfQesBbBJcPLkIUDLuqSNLB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2089.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(6133799003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9BUy6WEy2YZWgjvQj3/vAddiWNXwtiflFcxn4fRWBkJHOVZHIiT1VnxdDVAw?=
 =?us-ascii?Q?vQ7fRKiyJqOqXmMwI8XFrUUFMJlOdXua4LD/SaesDyXdEuGSqpS5uLPtjePU?=
 =?us-ascii?Q?GO+VrUPXyQkZbPdjq7CMP925rzrY8smotvNv59hgNCg2u9AqTdBpAiSERQU8?=
 =?us-ascii?Q?zSbEmVdYe+y2bUZQ3kZIZ7XbeJYWEotPyhVblEGzwoMDlan9IrwR5+/mCQ8t?=
 =?us-ascii?Q?mYe+Okl+g0ZM6Vy/yYnAY8z9FqbU7mFTcB6dOdAXjfV1TUcVYxjMJPWXtSa0?=
 =?us-ascii?Q?c+l/UjM+DUwx9jDP3RrE+6mAx5U0E4xkGp9AF9PKdjaugToG2Sn7rqx5Qid2?=
 =?us-ascii?Q?v+JYa7ENKJBPbHkAPOF84uCBU/O5qu2WT2Lu2simcQHTr2n7Q3a4CS+HyLlZ?=
 =?us-ascii?Q?3RY5CrDDXoAyZtCtkkRR8WkcBP8NFejl0yuIPFJ21rKhvAJXmjwJQQXXkVPC?=
 =?us-ascii?Q?AbNOmFo0bE84h+LsYJYA5tHMqRx4Y/DK6VGEQbsS3VXho4ilBuK7wyGSELw6?=
 =?us-ascii?Q?JytRxypt8Oe3qI/eYhwyjONu5V2XvuIw+TqlVfVHyhum+WJejABqennJIJS/?=
 =?us-ascii?Q?ov5xoiqV8O413VxgFDzMIfMuIZapSA+HP+bnbkW9urbFywqNgiogyjPL7pjf?=
 =?us-ascii?Q?atEv2rAr03WGuSNbqA9YbnPfusGcB2ylgfHIkdHC4kZ9Vkdg9XGNOOPDjcZ4?=
 =?us-ascii?Q?XJb8FKLBM87nQqFzilZcs6/Tv1rmsS7yAo3uKUcmDmSgJU+NVFauPrx6RkvD?=
 =?us-ascii?Q?eFhX0+kITtqHfcxZFk5/Mgq1OVvl9qvuSTer2vaB9Slglo0XdUD3J2bUKevi?=
 =?us-ascii?Q?unRheHzcHeSro8jzNJt3juiTVRo6KML9gmvv/D9uNt3P9qL02krkv47WUAJQ?=
 =?us-ascii?Q?EEvQwVrvzfJlVrq7RSxKDa/TXnOA5xLE5yc123l8S95iwUeuSrzDGEvyN4+E?=
 =?us-ascii?Q?4OHDkOa90bQ8KdhsKwKTP5OvBohXze1GJrmWd/+hnGe6qg0Dq4SnlhErf/k1?=
 =?us-ascii?Q?gQ5zfkk3kvuCUdTKPIWiJ25zEHW5+t5WzVEswQbhd3Grdcl52atwNo7FEf+e?=
 =?us-ascii?Q?6HkILBOOI25f9rUu9/N/r1Sr/gGm+NfBGKTyabnd0PfR6sWT6xL6jn+o5bAZ?=
 =?us-ascii?Q?XQ9nMo3oNWtZY3fvHe9oiqeZmRimvOo5OBEE9NFRurMwNPlxPcMSlPi0CqWQ?=
 =?us-ascii?Q?OPWPXJFieGgZIyigUfdrFImy5TOWcddry8xk2+6PfTZro9yxEHaggtVry8GA?=
 =?us-ascii?Q?XavDxFJoOVlsryaSslU947DIuRdSewQvVbnUap4paPaXYSdhluaz1lLg1caB?=
 =?us-ascii?Q?FpYdvLVUsCHVPonXWO+6fXSQ7d6gzv31Tp2QS8ST+faTrwdAzToBL26Z5v4Z?=
 =?us-ascii?Q?HjnP0A2FvV6RZruORGsCXQ5cRx8SgsWmeErHa8kegPLdV39YazE0t65Rm/eh?=
 =?us-ascii?Q?pMNdhhilVPvD+R0KBjdCcyE6pPhTdnSn3WvA25Pou5DptJCoXVY/2W6DecY1?=
 =?us-ascii?Q?JcslNuvIQcWh2OB5pX6LSJT/CxqCwT+bJmvHZ5hARWacf4FF57Vbk6SXziq4?=
 =?us-ascii?Q?Waggf6z7ovGSk204Blh5cuIKPkz5xEUTNM7O0LXWh3s9MEEpoBzbGYZV2fzp?=
 =?us-ascii?Q?jowBeB1nAbajC9r/BbKR7C/6qoHdsfnemJcbGzwjjYP0qneb70dj4HtLGRNb?=
 =?us-ascii?Q?L6AuUYxfY9sBxPNsWH/RSgKkbEhMPLATxakHJqeen68tH2Uy?=
X-Exchange-RoutingPolicyChecked:
	V/eu5yXK/wvBcWj9U5YeYYSZzxWukZraxza7PTTHLoTs3xhRLajDwjCW69se5JzSj1104T9Mv4JV7nAdUid/jBsVDfxn90P32gYUzMXnNFChygQOecpaijWfumYA6Aep1cLdCLptnRcuX+SMER5ECEcgFwBUecSreoEx7JB0fpP/LyUQ7DR7YgqIrd7lfDvHlIdiTMZeooOwjYbbrUj5qHYlNbcz8MkLMM1QrfJtJKYrxcnzxSomfUF/EpkfT0jmT/+yZUqT8d7P9BdnC/666E2PWEYCIbFEC25T2IcOH30S/NMKJkZIRPoJcfyixLti5jFw7ojK8CO5hnrXTSlVhQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e93e2ff-f8b3-424e-5f4e-08df1ffd0b02
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2089.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 20:46:18.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9z2sadohpCKwIjvMP1PqkVAuHxX7e9eYxMhyCUuEWy0x506MENgTnAB5E6sRWb13
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8489
X-BESS-ID: 1790887580-104392-7707-5004-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.93.201.90
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsamBpZAVgZQMMUkzcDUyDDFwD
	IxycTMMMnCItXU3CjVwsIgxdI0zThRqTYWAC+d8OFBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276532 [from 
	cloudscan22-150.us-east-2b.ess.aws.cudaops.com]
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
drops them on last close and on port removal, and passes the resolved
bitmask to the driver on TIOCMSET/TIOCMBIC/TIOCMBIS.

Patch 2 adds a second mhi_driver to mhi_wwan_ctrl that binds the IP_CTRL
channel and implements ->dtr_rts by sending the host serial state to the
modem over that channel. The existing AT/QMI/MBIM data path is untouched.

This is now a two-patch series. The pci_generic patch from v5 that
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

Changes in v6:
- Rebased onto net-next, dropped the pci_generic patch (now in mhi-next)
- Patch 1: snapshot mdmbits under data_lock before calling ->dtr_rts from
  the open/close paths
- Patch 2: allocate the IP_CTRL DL sink buffer separately instead of
  embedding it in struct mhi_wwan_dtr (DMA safety on non-coherent
  platforms), and do not requeue it when the DL transfer completes with an
  error such as -ENOTCONN during channel teardown

v5: https://lore.kernel.org/netdev/20260819224927.2274790-1-peter.hunt@opengear.com/
v4: https://lore.kernel.org/netdev/20260816121705.858013-1-peter.hunt@opengear.com/
v3: https://lore.kernel.org/netdev/20260807215042.2714442-1-peter.hunt@opengear.com/
v2: https://lore.kernel.org/netdev/20260806155253.3378294-1-peter.hunt@opengear.com/
v1: https://lore.kernel.org/netdev/20260804233411.1953445-1-peter.hunt@opengear.com/

Peter Hunt (2):
  net: wwan: core: propagate modem control signals to port drivers
  net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

 drivers/net/wwan/mhi_wwan_ctrl.c | 205 ++++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c     |  46 ++++++-
 include/linux/wwan.h             |   3 +
 3 files changed, 252 insertions(+), 2 deletions(-)

-- 
2.43.0

