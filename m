Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94149282F08;
	Tue,  4 Aug 2026 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886487; cv=fail; b=rUf1PsDpeB/0Y58VTjrIeZcUaljo/R4M9j9eBrEVk1+ilCvtHmAU/4jZNslN2iV0mQyEVt6TvJRuLyTtVq5wc70Ji082sYDgvzR5MwSHUr3y/NRZY+SlMYcFt/AUCVMbq6wBJXC3/f4rwF7I+6PEI47JDwJe/HGOZGhC2ZZ8VXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886487; c=relaxed/simple;
	bh=vETO1hIlIKdaV89Jl4rsH95Kc+3d/5Z/z2J5Nz9mPc8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J2GOCf2mn3KjIRufusHj2aywjSt1iOb5p0H0uPJzfp//4ap34+19y4OcjQX/MXTPj4Dcs+3OPoILSLCbx3Xb5nMPVObdnlz24nFdSnwL2sFzmdmEcLmrCbASIUyRMesxvHSdioYfjIojOMVWpyFP9rX0A8iiaVgOHoQ63+9yQXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=DbM5THBe; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="DbM5THBe"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021137.outbound.protection.outlook.com [52.101.52.137]) by mx-outbound44-90.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 04 Aug 2026 23:34:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxTb1ep6yxtvU+fy4+ykelxBibT8jryNNrioKuSXi2C6aIlk0glLiXbX1vnact9DUdhhXntFWR1x3URxJnz8jvrUWu1GCIu9RdcvDzlXW4jITzsLl7qa2RWZ+jToXEqF+I0/iuJSER613QUTJIWBJczuz3qAyCDCHHUa7Usd89jLe6dkjeFykW8H//buP18plp0NfqNCuN9prGZHSKuFUmFTbDZGpeAxrhPg+zPmPaaD0Z7MMdPD9oH7ijhKcMCeBWZiGZANmHuhMX3l9Q+Xf3pHgfjE94EIALZFsdyv1WPOmnKP1OgpezkP0WPa/+kmOprDdoDSz6TYB/7ODbgnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FFglXgHLisGZZdAv3ZZZvsgplU+8CFUkejlyB7pDOU=;
 b=P5U89C5kl7VTAhdxpo4VCGLjKb6uo/yRXJD/I/x6Ed3r1QlYHSfqmLFnSdkz+ZeewkMslrGAQZLAuwTAZHu9fSsefo/IIj8ws9sceZxMB+7ZCtjsyK9hHKlQKi3WAQjYsWVJyyRDSorSl3ufBl3Vum47gie2/1CpGjnrceToWgEi6jBk+I+347GApU4JtcerDTVEq5D0/hyPeULMBPMMijLuHJ3he9DAm/HWDqTMGJ0zWqghqyEfQgJhMLh19yM2KKOA6tXzdCFFcF0abbgmJ9xiOunjo9cYK5tZXJ5dhshX9p8f6CXr+YIntQvnkTY0Bdzo6zrfSn04R9Mn6h5wUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7FFglXgHLisGZZdAv3ZZZvsgplU+8CFUkejlyB7pDOU=;
 b=DbM5THBetGs8DKpzeShx1nE1NWMsZ0o2sqjUaKG3ZdFb4V5PoSPTeq6xZA9ElqJpIFj9vWGoylwUbVH+cEqrb0UqaEkCrhVdlv9b8DgOS+wWIOLL6RqrT3FygVk7gHZMX27rlwgO+9BHn5yeJLLiNElIKgEn0XzWFLDatTOHSIUTsDfeiNYKCf52kV0Q0nkkKD0o6p3Dfto9CRBsgsa4o4M48nQtwAcvlXxY/Lry0+hyD6OE1jZhTvL9SsnAAodctr9h51veqEcWoAmEXUGiihDQM+7JaRsJkIEgN3UmMuxku1cwXqLataOFqVcPNe/hMRBQfpTAIMSdtMRIDxKUXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by IA0PR10MB7352.namprd10.prod.outlook.com (2603:10b6:208:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 23:34:16 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 23:34:16 +0000
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
Subject: [PATCH net-next 0/3] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Tue,  4 Aug 2026 17:34:08 -0600
Message-ID: <20260804233411.1953445-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::18) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|IA0PR10MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3c3bb3-1de5-4b7c-cf4e-08def280e5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|56012099006|11063799006|10067099003|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	eUwWCF7VXzXbEaZLKeZB6M8W7IacTJDfCzyy8841kghtp/tUDaB00ea2FjAKRSTaFRfhuQ5xwr75iJFrSaxqUbkwRjy78ezTzBJ7+rKpQRZT4jFNnwrsAVqdytsoS403BNLXgXrAb6YgMBMu5/8V1HF6SvzaEvZCuq9j66xmR3Agu+x/ZiuMJ8WBZjZ06OHEn3dtWcwxmk2/VOnYc0JzODDVHipqsFIaYeVwCPlzSJ5hasyY0CgjAEvdKfTNUYKDWHF62m2HnWT62wmfAhDj0hlV7TmYCN2xgHFsQ9XrDd3orG1wgSjqG+Gl6sCPI0jLhZxy+oGn4y5wwBrDjpJTV1GLj2kFnY+nHi7fRBrcucAz3cS12nvXCi9U27Vwx3/rR07FzDPDhtjlRsvcjtVkK3Aup2kc2yfwhEu3O7p1WVS6YX/0tIHxHwXkB+oQi7aghXXdVzqH75WvqNOp02UHH8vI8rIy5yrHnv2hOnPHkKb4mNlY71KGwhnGRNjuKcdimQiexdnzDU+zoUPkA8Gt304hqnGetyoatvLiNANOe8MpYJZh9yYlNDd4exyABOGpgWG/w0WYcwh8Yp3hOKBBjlQok0Wg1sc5ah9K2sMefv6q0Oy4GXO5E7mSIEAKsTNGRWMPiAdoKQ4jWZ3c8HthzKnlXq2S6s/b35jm0UNk0g4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(11063799006)(10067099003)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q4obgYMxad6zGZ5xgXltZWCWqcPSnDjBmIZDZ0OyD83tmEUOg8NGQn1/uZSD?=
 =?us-ascii?Q?Ztv01SpWkEl0IvHSgTVdzchKRzSkhFrK2qcxJwBLGdX3jk3MWUjLO4e4prhn?=
 =?us-ascii?Q?45yoqT41xNb+MGemKnY8/riq7rgzFSWxAPow5uHw/g1eYYdETlwHwZ6VCeQg?=
 =?us-ascii?Q?8a2FCA/YQ6qk5ooEAQElMu27sdemg+s0M0vrnrrC9U6SiarllzhUdVLF1EoN?=
 =?us-ascii?Q?WCZGU3pG4mBu3MPJt+1MK0qVbaVFLCLFSislhDj++VGbGbF5sKeb+UCNVFrT?=
 =?us-ascii?Q?UQbG9sOANZ8bnQtENxNaOyrx8xmelVE8omdr0Sc0CVHCfj/PlzVFH8j6BlMC?=
 =?us-ascii?Q?uMH3ebF9gZQWkoX7e0OhBPUxnDzQ6/76ibAxLR9YLXOOdzXW63airiUeygBO?=
 =?us-ascii?Q?A4yAJCf8Q25SyivHt6pgK7kWCWnRykdjD1QzC5ua8zOjdUOJw0HCYFGr72JR?=
 =?us-ascii?Q?1fp+LiaJSHpmuytO/5a2paA4GGKT+N9JrvWCDhPmLbIh5Mulrk6CnOxC1YTy?=
 =?us-ascii?Q?4We2MDo3opNKQn8LbBOOFTqGlEr89qkSDdVHLC5EUccIY2d7iBGj+uzHgVac?=
 =?us-ascii?Q?Lo34rNfTDkkS6u8Pv43kzS6Tpo+/JsrFhRBMGeBCHf3kMylBlBADHKSSm//s?=
 =?us-ascii?Q?6tsIVfWhPvHC/fkGmTe296neBf5qsTrBU/fjKqidpcgCG8AAonoXMqwllVqO?=
 =?us-ascii?Q?9llR11p1pSFI56phyERfslJ9Xh0VF70bU1hOuKP21pJQYo599B5FsH94MqN1?=
 =?us-ascii?Q?/nA0UWRr6k+TNbIqubgmGs2jGftmt9WCAXOQ/5Z8d7brllRFe2suh5IGm29R?=
 =?us-ascii?Q?k9jiwF13hjA1KNej9XQ1AzoZNCRZAq1K5tQY1GmytyrlCRs/GkABhURw0MoC?=
 =?us-ascii?Q?giFleKh9so9ebWmk9qhtsGcTAR6GF0Z0f/JQqCuAgp61CJU4ZwwOjkvaxQmx?=
 =?us-ascii?Q?zdD9nLis+bKTds3HE1Zg9pq81Yh7uHx0OpotHBIbzygkaBzMXYpxrhTkJCzG?=
 =?us-ascii?Q?M2vC1gT5kE5lBbB5PBg5Cd4bqzQ8HoZbNQlXZ9wMiZpvKwYZUYMEMJa26718?=
 =?us-ascii?Q?3Z/VA2Zv5Bxj3HFZRPy6KLeeEVvLIu2+kAV1ChCq/A2EBZnZAC/Wp5d+HQbE?=
 =?us-ascii?Q?cyAJzARjGJf6gDFxzIMNcTVUpR8QH33M8nyg7D5caxF3fKGRT3HB/myYLC71?=
 =?us-ascii?Q?e1Iq0uKtPtnp9zeQyxGmY29OdETmSaPMAjGTNrE+T6YWmE36tvew05jW82HO?=
 =?us-ascii?Q?LVzUYIiwse0Lsie4BgLjG3KC1NekolHsDAUHXQHjpO0kjFZtutv+wAfW1BRG?=
 =?us-ascii?Q?VSpGCf995NHLAGQAiB3DSaqLk4id3tcChfN9xseTAVpEiEmiF9CwXoe2h+g9?=
 =?us-ascii?Q?mUYR1lf1j6UhUnzNJFxtstCFixqrW6R6/iFwscnNgzKJ9FQZL4LtnItrcIZG?=
 =?us-ascii?Q?DPCHcBJWqrA0QW2KOhOTQjZLB326BrPvlHkaEg4F9l268/cNcvkHsZ+yjzF1?=
 =?us-ascii?Q?FryIcNyPB1TngB9HO8tKFhtsbSaSLSG8NLHlDFB92/08ISg7yAju7CKB260S?=
 =?us-ascii?Q?bltH3/vQ3HCYjsqTlqmLl11h3wCB5J7Lk5LmdWXja3JGb4ircWWsq30iyixb?=
 =?us-ascii?Q?7L9jY9AYkitQq49tjyRY/4i9z5vRzma/keaL/rC9SBUxQUwzo6R6nF0JAZ0A?=
 =?us-ascii?Q?dffnb7XWF4pZHkYo9gV+IqWSZDLNcHKrqTmw20oygOlH79ZC?=
X-Exchange-RoutingPolicyChecked:
	Y7QEVmRIyM6axWGCV3cDqqFmF3/PsAzsH6GUYnOF6/iwLnswekBQQKIDO3h6ZUFkuQdgI0STnRAEX5pGRMx0RrM9M8LixiY9+ig8ByAqlORjUsbN7nPY22zac3CAa0C3z3cZbIxEPoy1rsyoCSKXC0JArkO9GyQbYtrJIOIzPEa3bLOyf9SCQk3441FxdaoxXHaty3kstV+VYoTqyRItRNgVOK6QIPZrcU0tdOPkOawEGXWPi5eJOHaw1R96/JWVICj46HOUo+JcbK5Hzf4jBpyRvcpDqZX4bnqF6TBwW1PrsRrWM0hs1FvRG6t54LlMLqGGnsJAdSNAbO1C7oHAuQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3c3bb3-1de5-4b7c-cf4e-08def280e5ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 23:34:16.2624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfJfMMiGAL/3fiu4j2d7hdxOG9BB5aaC1eX5y2+EsQ49GMcnA/XgLHGs1fWSctrX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7352
X-BESS-ID: 1785886459-111354-22195-13887-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 52.101.52.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWFkZAVgZQ0MDA0DTVwNjUwi
	zJMC01JTHNIiXFKNk4zTjV0tTIONVCqTYWACiwmP5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275151 [from 
	cloudscan18-27.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

Peter Hunt (3):
  net: wwan: core: propagate modem control signals to port drivers
  bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra
    EM919x/EM929x
  net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

 drivers/bus/mhi/host/pci_generic.c |   2 +
 drivers/net/wwan/mhi_wwan_ctrl.c   | 186 ++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c       |  12 +-
 include/linux/wwan.h               |   4 +
 4 files changed, 202 insertions(+), 2 deletions(-)

-- 
2.43.0

