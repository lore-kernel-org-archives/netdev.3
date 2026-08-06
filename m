Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3E481245;
	Thu,  6 Aug 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031661; cv=fail; b=hBdi+GvjJ37P6SbaAUWZvW09E7bk5qPm+hWpWKi/t0GJyCyjYuoHw3XYeNxWxBYhBkQZnZijhrwNjOHXYopCPh6IC4JA1bSmLlnJTbbQPS3L1/Bqp19ULiFqa4HjfNFmGWZro7faAmeaK7vPrxzvd8N9/yV7WUwGczT239ODU98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031661; c=relaxed/simple;
	bh=429D+43G7soDc1m+TzKMQmU0XI++NYiKUeLg4WCIEP4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Uc9S3JaRVBkcvhmKOSvxewPamqw8B0rwyrIWts6gWvMktL3Hnqabtd1HTc8ncylVNjOISP2oVcW65NB4ybqz0UF6q9ccFDvZ5LtkS1N9TpzhyGpxsbKTYvxl8p16eqCLMtvOJqmFQqmg9k69wIWLENNUk81R+yK4KHUDQrOJoK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=Z+aRtgV/; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="Z+aRtgV/"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021115.outbound.protection.outlook.com [40.93.194.115]) by mx-outbound21-228.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 06 Aug 2026 15:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaNoBPj80nU9re+sBu4wsoCM5U91V3UIU5Fkl/uRfcNtW9cVQADF5XhVGIR2JZI5EhDw5di5GKIwVPJo/8IoTQCmUQ7Az/F34UqG336BIjFxwiP7geoRwwxITAhSDTt0bj7O2/VjctkSRcCqDvMM06WxVtM9z4scysHQIQfUqMB38prjie89hXGWamz4twWwLtHD7ivrPiBOdQlq+kHlSy1+suTjX/BEfQixf4UNKBolMTfs6BgsXXBsxe0u8TY5JZzLgC2GQN6G+wfRj1bAhHqPLGjuzsel3A3tikMOkIXS1fS8a6rBYczAHAFzRbyPyuoH2GCAb11QeASIh4Txag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4x6vOKVsK+y7kcpFO3O2wjoIfvsc3bnxaIwvga0RGM=;
 b=snv3GcQi3vT2Cs/SNguB0UNqSVDhAy25+xUJ1ItOcSvlFodXlsV8n9mj6pQIX+I/Num1ov4EnNxNlj2FYwR9gxuWO/bDK4+f8ThLYL/CV5mDLalsoMkALuzu8Ifeui/Ofgck12MFDNAvOvM8L30i5vdGhSpIVazaNvuYfkcnIlm7fBOAL7P6DiDOiZ6ckk94sGw3+sXsIG01ck4b/HXlR4IPe6XG32XoE3eD9l8pTpAjgD6vcvjHBJDdnOAafeGe6pKa0XSCaLP3IXk4T6EX3fqHaVmRo0lCo2yN5eNVyyOgf6iqD4H3vXyRFQ1N/rr7wg0canMThPCI/Bwfz/w2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4x6vOKVsK+y7kcpFO3O2wjoIfvsc3bnxaIwvga0RGM=;
 b=Z+aRtgV/bzf/d14Nh7+LP6onwS6bszARx4+1TDXhtm9z9lxE9jmllUkv8y9o/yJE9AgT4JhjqO4or5E78AeS5u9V2pZjhefux3p7Ntn5zndSvVeq+wETtS27YHfpgy7jkHezUKIXSdrDhnjSxtGcuwGnufJeRN3drqfnOYKLo73kB0bomQhTITIzDnpBjAq5qr3JJLzX1xPciUDDG4lHDvjFbnsR5gy6Icx5zfw3bkVKO1sut63e6rciUk681gsADjWj9OQ+KBvybVQd5bwkWcSOftyVDW1EbEZf797YP4caMdVgcdateJAKEKS64GJ/cVOVzPftNiuHVfYuCLJfCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Thu, 6 Aug
 2026 15:52:58 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 15:52:58 +0000
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
Subject: [PATCH net-next v2 0/3] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Thu,  6 Aug 2026 09:52:50 -0600
Message-ID: <20260806155253.3378294-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:610:e6::22) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: c9217415-db56-4ff5-7dfe-08def3d2c930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	PiU0R69Orc9nNmJdMl1XlAlkZDDbEclb7S8B5HWRqTQghWYKfidzn+J3qEX3Yc8qLm1ULFd42yAOp4O/NRxL0StFm/40gKWlRbcmjK0CVfnt0rH52T0SG30wx57TKHKgFno/SGTMwnmIHJ3OnkZ1s5eoFCeGDfH7KBU7X87sVsdnTVAGVvMIvmh1MLhVjdUfSgsNjLqyVEGBy4FyxPeRxm6y/uyDSlRqSvvWCQRHUGrLDqFavWaLOeodzNV3aO9i/t8IoGBaBxgPvZg+cc13MNpaLRNbI1jjQNcx9dA2S1Yep+/sseIKQBLGesSiuaHoPDAbhC526EFAFlfzzrT7H4K5m5l8pgBYqmog2Sad12TbD1ZqsOOiQn60mdo/NSKx4ve8o2bQuKFYMVGEBol1+iTuW+7g4Qrp2KNUHxhIdJeZgTeKwyjCZfqTY/2L8UqwDvMTAqtfw9I6+wEqFPibEnaJQM2wgjzRsQQhg+4ktLHnYd9DSmLkQdFdztbHpTrE/6pQGovVpFJenuqatmeDw2h9pJKDH0MsRQTUwBnpa0zUzchMbFMJ6Iee4IJfRM59JXeKrOjlMH1YaomojNbIXjyG2iEhfTkcnTDkN60jyfNsgJt00FMVszuPZfcLff72fEtl4LtKh+aXSO1ipYEj7VcaBXHTuPlDU2RsTSFP0v0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xjo39wBK+Nx76y5slHaYH5UimcEt+jV1M/evr9Y+Rbt7qCrf6U33cTE7Gh3s?=
 =?us-ascii?Q?uJBEP11UFMzeXy6qbfEmd6D6JUW8wjPUEv1zl5qsP44NvUSe0/e4sjtCG+Xs?=
 =?us-ascii?Q?WZbXUHysw96YYwcvK+ir4kBrpXvpgq70HwGXVLzsKollO2Wag9/lO93uZ+gd?=
 =?us-ascii?Q?u6PTa923UTxVa187H58wstV7Y6QLyDEq2rQJNgedYnpNSwIwHw/N12KKPzkm?=
 =?us-ascii?Q?cdbvj1GtQqM4JGHvPnhPMG68qIoEwM8vyujY6buVvbYicQzg4Ox9c1UUsF0s?=
 =?us-ascii?Q?MQlaVS77IUlIlcNGF/am9WtrsSlrAuDhaq+qn6TZhg6XJ5Z+wq1rdv8dp+Cc?=
 =?us-ascii?Q?Gts55Jg0DB0H07K7dCbIybZ85xzjJ4SeNSXSDouJFBV7v6v2VhElED1DvuzC?=
 =?us-ascii?Q?fXftjYPqU9D11NAKWly+5EkPHBPjIpG/ODtARpwkwHaDtIkyJN4MCLX8vAZG?=
 =?us-ascii?Q?a1x3vNGULkrHk4pDZP9g0P4ozSl0s+1KjPQPhSm1OBMphddN3svPoDY3te6s?=
 =?us-ascii?Q?s3BisRNZCbqNrQwzk6KIndWE/PYch9Cin4ppVW4IwO6brnaaBXJx/D8/foHG?=
 =?us-ascii?Q?Kvvs8Tnfldu4Pzx1H+laSNK2msRtzSC/f/2FC7H6QX0/lAZHpHfo+ff8DAKt?=
 =?us-ascii?Q?v9A4lig+x8NvBRf0SZUOnHkeOryL7R/CAjkuVlr48KVNPgOXWo1rh6cc8Vzn?=
 =?us-ascii?Q?xxMqAIezdGiuW0Qi5/G5pyAzXv9H1r+Q7AzMCCIeomxAqX3YlCwn5mbevHJZ?=
 =?us-ascii?Q?U6GE3oPJjvkh2SL+B+fxusAqUuev0BeTc99jLHiBVRm16716xPMskEIvq9oe?=
 =?us-ascii?Q?SZCGoJsIj9FjWFatSKiKnrumQqJ7Kcb+R0F47NgRf+Tt2Cj9yN3PIu+8f2GF?=
 =?us-ascii?Q?gK/0IjUn4kTrSZWmmZmNvFgj4W2q+Gtv7M9g4WL39b5WyuPFvZnDt4qUOnwV?=
 =?us-ascii?Q?NHg+IIvkw/Wj/oNk9fwRL5RicIZsh2xHlmKU9GrUdBSBCn6Mwh0+fIkriw0b?=
 =?us-ascii?Q?BzQHeYoyvBaJAPqDCI94gg0JBelJ4DL7UR0v23b1O+bvqTR6+ZHc5lGkLLmK?=
 =?us-ascii?Q?S+duzCInUUsUXJbNtELVZA4hQjRmZlPyGuX37BGqwasaub5rMgJNNlKBnUlr?=
 =?us-ascii?Q?SdI6qtvlZi7oNjXbLeqjFfwbV8QBK9ANiLzbhTz4hHd80PrO6RFbwph6fs25?=
 =?us-ascii?Q?MD21wffjmkIWLkdOzUJv8oWUQh3e0yjrhXFWr37u0Fob6YIn7T+C78LXLEte?=
 =?us-ascii?Q?1K+6jrlQlLFTVTckeChJzkvsGyxtd0iBvyQyfq25l9wfc8rM/bSRZiPrP2WX?=
 =?us-ascii?Q?EurDRtex9o6Akb4PlATWcvIfvI4vXi7UxaOZRoUJVlv5g3V698cYZn3IXN5e?=
 =?us-ascii?Q?nPlUwPlnO5Jf6EyvrMDhQyQGaP/5b4jz5kAyU+dOhBzlELdfbcNGOtF5vuS0?=
 =?us-ascii?Q?Le0cQJLNH+rgcFvgC2Wnz94LDTY4WlRyOpMpaKVaKSWMvT7qUSuk0/Ilz7yY?=
 =?us-ascii?Q?8lapN1TpeSezb2u50HqaJuJcC/F3H5OX2zsGj99RnVIjcFCy9meHqYDejUKT?=
 =?us-ascii?Q?XVG8rga+uvQNFpxb47wJ1psW4Gn4ygd36i6CgrC38/pnX8hiyG1a2hMIyntl?=
 =?us-ascii?Q?CEr8JAvUIX2B12wOfaiBLZq00VjG04CrOKNwecsTv2Q9EeIqzrIXa3PZQ4Ow?=
 =?us-ascii?Q?/AojzBncLm5Qc+U/ss28yR+dZAaBxSMh0Pn59uA5vArUGrVLGXYHckrQ5WUX?=
 =?us-ascii?Q?8XAY4qyDdg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	LK4UeG+hfrIPgq2/GShjDaunX+icjw8GDJNfq6hN2mGTIbAUIIU3MGrU1NOM/xBKurZ9b6R3eCpBHjn+6JJx6IDjBkdzmSzGGNxcr/paygy8a8RBWTRulVQ0SseQc12aQ+Xk1Szj1baiIZL6UPot75ZRpMXbrPNHaE8YGM519ay9kf5XU5msWcDNzIgFSahTZw3G3KDdfPpESemr8dAQcnr2pJsDgWsZ7JPzWJ8jI5hzUU8LsHphC0ipa/ycd7A3QTZ5j9wcNVVAgIUIyvKU43a8p/bGonJuVSA+qtZkKGDcDF/SeY3DGlfOzpxmsWdN90AzxlMqujCvTcbF8C1Amw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9217415-db56-4ff5-7dfe-08def3d2c930
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:52:58.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNx0k2NDxqVGoJGWKyrovq0q/C6ZL6D+UDDXmLoQMpfIEmo/DCpUCUsf/kLXQO69
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-BESS-ID: 1786031625-105604-7725-24966-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 40.93.194.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGRoZAVgZQ0DDJ1NQszcQs0c
	DSMtHc0iLJ0CjJyDLRxDDN0tzC0NBEqTYWAEzWr4JBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275189 [from 
	cloudscan17-136.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The WWAN character device emulates the TTY modem-control ioctls
(TIOCMGET/TIOCMSET/...) for AT and QCDM ports, but the result is only
stored in port->at_data.mdmbits and never reaches the port driver. A
driver therefore cannot act on the host raising or dropping DTR/RTS.

This matters for Qualcomm/Sierra SDX55/SDX65 MHI modems (e.g. Sierra
EM9291): they withhold unsolicited AT result codes (URCs such as +CREG,
and OMA-DM/LwM2M session indications) on an AT port until the host
asserts DTR, while still answering solicited commands. mhi_wwan_ctrl
exposes the DUN (AT) ports but had no way to signal DTR, so URCs never
reached userspace -- unlike the TTY-based USB and legacy PCIe drivers for
the same hardware, where the TTY layer raises DTR on open.

Patch 1 adds optional ->tiocmget/->tiocmset ops to wwan_port_ops and
wires them into the AT/QCDM ioctl path (drivers without them keep today's
store-only behaviour). Patch 2 enumerates the IP_CTRL channel -- a
standard Qualcomm MHI control channel, not Sierra-specific -- on the
Sierra em919x/em929x config, which is the device tested. Patch 3
implements ->tiocmset in mhi_wwan_ctrl over IP_CTRL, and mirrors TTY
semantics by raising DTR/RTS on open and dropping on close, so existing
userspace (ModemManager, terminal tools) behaves as it does with the
TTY-based stacks.

The IP_CTRL channel is bound by a second mhi_driver inside mhi_wwan_ctrl
with its own callbacks, leaving the AT/QMI/MBIM data path untouched; the
control device for each MHI controller is tracked per-controller so
multiple modems are supported. The consumer is device-agnostic (it binds
purely by channel name), so any Qualcomm modem whose pci_generic config
enumerates IP_CTRL gets DTR support with no driver change.

Note: the series spans two subsystems -- patch 2 touches drivers/bus/mhi
(MHI BUS), patches 1 and 3 touch drivers/net/wwan and include/linux/wwan.h
(WWAN / netdev). Patch 3 depends on patch 1 at build time; patch 2 is
independent (without it, ->tiocmset simply returns -EIO). Suggest taking
the series through net-next with an Ack from the MHI maintainer on patch 2,
but happy to split if the maintainers prefer.

Tested on a Sierra EM9291 (SDX65) over PCIe/MHI: with the series, opening
/dev/wwan0at0 raises DTR and +CREG / +DMI OMA-DM URCs stream, including a
successful LwM2M server registration; without it, no URCs appear.

Changes in v2 (patch 3 only):
- Use __le32 for mhi_dtr_ctrl_msg fields and cpu_to_le32() on assignment
  (Loic Poulain)
- Use guard(mutex) instead of manual lock/unlock in mhi_wwan_ctrl_send_dtr
  (Loic Poulain)
- Return 0 (not -EIO) when IP_CTRL channel is not enumerated so that
  TIOCMSET does not regress for devices without IP_CTRL (Loic Poulain)

v1: https://lore.kernel.org/netdev/20260804233411.1953445-1-peter.hunt@opengear.com/

Peter Hunt (3):
  net: wwan: core: propagate modem control signals to port drivers
  bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra
    EM919x/EM929x
  net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

 drivers/bus/mhi/host/pci_generic.c |   2 +
 drivers/net/wwan/mhi_wwan_ctrl.c   | 183 ++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c       |  12 +-
 include/linux/wwan.h               |   4 +
 4 files changed, 199 insertions(+), 2 deletions(-)

-- 
2.43.0

