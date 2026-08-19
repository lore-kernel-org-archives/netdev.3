Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B53368A5;
	Wed, 19 Aug 2026 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179802; cv=fail; b=j2HS1a9At7Ond1YWGc88m8u4QNPIGp19gCdpT1dw7aT8lJFvOA4mBCz0oJD3BHZHQCretyu67jAUGZt4fr6kt9VEaLLyC7L1/sg/CyoXC0l5p/w0e8L381WsZAFgqX+Lsz2pANEFqKpG+iBQ7jqO7txk/vynQk7PyCN1SZ76Suo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179802; c=relaxed/simple;
	bh=dBurVVOB6YvJazrL8pydTaKNXoJ3s6K8SP07QfdQ7W0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cYAf3CgKpfF1w1wy+TmJHXzXCXsyMaif5W450hVIxsnRkpy54EGJLpQzPHhWmWOIVXR84vm/LTuTvPnhYEE63E2h51kxnfvbowUCI43EgvUU+FkxNHxby6izqkXI453s+SYfvpW/+1s++4Wp/1nWY1jhOaRFqiR9E5dnYXd71Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=QjwqGLfw; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="QjwqGLfw"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023091.outbound.protection.outlook.com [40.93.196.91]) by mx-outbound45-182.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 19 Aug 2026 22:49:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQIuYpqTRILw+klu8EEq5PBV5E04SEYV0e66EychZd5sY1gC+EzL7DkB9A2vmUBFkw7UsrYqoENxDtGUSbCQCBI8M0Q008AZxurwGakOWcGyxoFAG2evOceRK9uFktIUPZTwLfucYoZfI8N1Rp7Q168vLsBQZN71gHegg1IWoLMD9gqenoXkx9drOpa3xEUMZ9YYj90FCfG8obGGoNGQkPjS/8s9UEkg2L0/GFx9SpSC3zTKvv7RkhYl69sfcsjylb+xjvveKhlH+87CvzXycbebOOGjzWNyY3r+8uUjHoYWKAppONc+T6u3/WHi74jy7UoVCZ4geKgtr/d1nxx5iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUBUiXTMA1fwa8HNY4SMMh1AGOIZXs6uvP+4i27u8W0=;
 b=l/pXSvw4dlfqtwL90RFOJcBzimsKw08+TNv0gBiHDqlzCN0eCd6I9iLSER4DGQAptSWhwUNG7wDZMAmOmmApIVlk5sKuOHBiSmOv1cLny5gYDYWuHg3qCxuEu5Uq+2SOz+AzYIKt7Zqb2CS3vAZPzozmJj67XoCG9V75mUVYfNX4Fy5qinjQvPBvBC4RTtb1fMdWJ0RO1AW4WQiryr9DpGy+0fFRlORVJ/GpljqQUjiWA7tibtoyG85cHasTGxedJ4Vl7Y7E546ECa+Ih70rQGZN1lpFFPZfqSXBDpqOHUwYgw3jRjTXZ0O2H/8qNsgMAr4kexjaVzzUiNTzjPbr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUBUiXTMA1fwa8HNY4SMMh1AGOIZXs6uvP+4i27u8W0=;
 b=QjwqGLfwCeRzn7zs0rtZk/LOH8qDGtUp03YN4o1xxcQBCvsaZR3W8e+PIiqntj3lAZHRfb9j0pZznILw2zQE1/CP48fDAMnff1eAJVrTF3akNpedoNZ/BqKLGAiAz5EiHphvX9vJE0RcLdZs9h/8DP1pGxjsgkGwes86fbwty/Z5top8l40ssNd922Xr4/sJDPmzHidJoIhtrNnGeoPBfSPdZB3aN+PRaaAY22RZle2ejdNvS58/VFqprpVw+GWohX3V/9dDG+pDnJGpdzxCBsGfxAy0hA/hEbwqsyMb2diwlFIeAvm2hBnnRDrjfDJkeSS3kX1zMAjYEbUjWx5BIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by CO6PR10MB5602.namprd10.prod.outlook.com (2603:10b6:303:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 22:49:33 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 22:49:33 +0000
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
Subject: [PATCH net-next v5 0/3] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Thu, 20 Aug 2026 08:49:24 +1000
Message-ID: <20260819224927.2274790-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::22) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|CO6PR10MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ca00555-2945-402c-e196-08defe442316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|3023799007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	wCtt3Gq5+yAskkG+AIVB2WFGBrcNkPKxx/1ORRgvW480WTLy/wCAaGFtg7JaS00V9P/di4Gy2291AFmzE0WxlieuX4lVEki8AH6PHJyp/Ur5IvKMAgIEJIllHuttG9ctvaT6WQfntG13q5usbOa/CSK/UhnAWtKzrZaF7y1G7rZpHwAoBZ1BM2gXup7GlNZ3CDLB9HwkScUKMfE+Wmn2FH0xMBYDNaOOqea/Se72WiduY6gUCyNoo3N2CPk7vxOtdw00V8Ijw1Ay5QKZaVlKfCV55Ayx7WPH5fYYbnF2y7iMIyq4h7fXX03SE7UcajJJU0Ozf3v5cAiZh/iDv71eepxhtozKl8/e4wSirIEGUsWFg9PXg5S+gVyHuW/lCfSbsdTm6egeMAELJZ8Te5QICmufmxcZtEYA5EzkFCxPg/JbjjeP2s0o0OQhpSWs3OEs/IexcGI8kVpsxpfppTC8mTeF/3romJMHSduPS6IE2pSz3KC5r2OL8w304MHiFJ0mgrnAnnc84DGQYjE6WXERRYZ2HKEUSZ8aizD8k4uuvw+JtwifHdJq10IKJe09u9EauPVIZUnIGM4998bBIF+OwJf11sPNUsM0az7tvxvbQ1sO0XWeUfVtMNxRO7up4L/Xb5TugACBIMd5XS+Bo06OgPBi58L/d1lrMV/CUJgPTxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KcTuq+e0rfu+5YsKsORnbTzdCddMQU4OdPWDv/kegTNgaAE/HFwn/9/yEhRl?=
 =?us-ascii?Q?T0HHKjKS9q1qrGULcskto/iZyxWXbpg5gEVLCRmkKI3kidCjlCB4stEe8pDu?=
 =?us-ascii?Q?dAZAFkWTJ3boGjv19wp/12IgCdk2ShLREAeWFFwugHkFhg6dWl/2530IxjyE?=
 =?us-ascii?Q?iBdZlVzndtw/tZcMKk4eVDDmexh8vbCUPSVZU04hoHpEYO4k1fjEePQYTqap?=
 =?us-ascii?Q?Xds2aOr3n5xfpMPwzjSIKBirlNC7bIZVesZwhiksjMv8hc3XZNZD6Onrko/F?=
 =?us-ascii?Q?V+Wj7+xOp2bQ6ewHOnjgdqVB6Q/sqBk/pxwiQhFjRshtpGyKHTNqkDE9cNCk?=
 =?us-ascii?Q?cQdXwa2VySbyaISjQirZ6I9K9OYuR/+tAs6zbsGqIGwZBPBM3ulD+QFK4BIc?=
 =?us-ascii?Q?D6+sS/e+D/aVQv1+Mz+Yzl4SDG9M5aNnEW0YcrAkK64Zwr9hXbpgHi5QUX1+?=
 =?us-ascii?Q?DHzqIqpaB06udbfCxdtcMffPNcngV7n2UDIGZBFS0QCxh68WitqaZd9yuvX3?=
 =?us-ascii?Q?U7wxc3lfOnrO8M0faLJ8wQbke9HRenZNdV0AQ/V8ptxpSP+0BRLTSvoqiuX4?=
 =?us-ascii?Q?AO9UJR9O+W2wQaA/6PN3sGarVCA89pU6GOLq060wqB2OXkcrK39Dxb8pr6O1?=
 =?us-ascii?Q?AlFkk5YIpH+O0FFx587KoOMDPXAJiCVfT70FTdgGWWxmASVn7Pybp+aX6aTj?=
 =?us-ascii?Q?T1c+COB+AyGg2D9Zp4NUd6/9artGeNkH65MhW15lq4FtOTNpilpcSsp2eoO5?=
 =?us-ascii?Q?EdAbteGM3knyLuitY5QxhN4OiQQJUXW+htsb3jwj1I+eGmYFbcWmVxLGKSN6?=
 =?us-ascii?Q?jsY9rTqK2lAQg/jZG2627VNjd5J6z8XAhjsMFm6gxKjoRmyec7Y0DAKYSLYs?=
 =?us-ascii?Q?tpUG1e4dLH3usB704RYtICCUhLo+Wl6q8Rwkm81n+3EMy/7+Lr5gd++5DhUu?=
 =?us-ascii?Q?YcmlyLaww1Zy9KKrjV/jTUMsJJQ3PmnrtlnYQGxyQd71ixAkItDFNVHy5wqM?=
 =?us-ascii?Q?QV3rmgkf0XzxTkiTcBzmek5gdUgJfMATlfvkMRu5mhxv/2Z5IjfMHrSaJONN?=
 =?us-ascii?Q?6QyffUlAY+gs5ut6egAfcWYTdK6wl0BD9Z5f6LvUpbMZcduZgACDZw5nsK5E?=
 =?us-ascii?Q?/S038rEZlQdN4kmtAbrBg+erTlNqBiPZcs2aHp5eixYkNfhttvLX286Wa5DR?=
 =?us-ascii?Q?9ApEPb9UHe/2f4JLa4vze1d/MPQccD2PMTuRW0Lm/pFjdg6w9zXZVGDB1HNc?=
 =?us-ascii?Q?r3tVhu89bZCijskdwqWZKOctyy82izqDVUoDabUOXcqCi1n8Rkdc+6IvClfX?=
 =?us-ascii?Q?G4PuZdSWjb2p3ukc8z+zeq2iBPIHp6OM4aVFuF6htBvOSZY1NO6ZT5Cnhi3N?=
 =?us-ascii?Q?ZVTCsVKLNfksw/MWvmpONS89jewMmun6VuTo/1JgsoWCIfVAQ7GeG1YnWgZ/?=
 =?us-ascii?Q?BN0c04AcrPLv0rkr0kAPURYRNW/U2NytY19yv/JBFjqKY6XOBrt6/mIEvPYd?=
 =?us-ascii?Q?1h/FbcnxR3a0ebDTpx/Da8O1uVaUw61bw2avwOKwPfZ6VKixZTW9YX3WgOKN?=
 =?us-ascii?Q?bAIyuzWYNRKFaD6rXfF+hLaVp2Y+bI4LiOXaGzB/x0DhOfNAIL2gO9E9aJtQ?=
 =?us-ascii?Q?BzxNIQK30xRYXKyZ0ykvCGrLO4bENhyhXQYWD2CPzwA0yINGKm8v8jc94HoH?=
 =?us-ascii?Q?dQfhHlYqqazLNsnxIoDTUwjR7qhThqxE0szngkcHihEzZTaf?=
X-Exchange-RoutingPolicyChecked:
	DQcoLsUfzOXTtq94lti0SLhLgv65uMqMgOsPRiS+VecxGP7dnHzH5PNBDJwIrXanVogD2YSetO+A6ic5gCs2Qv1fifMNRsoUdAmt2I5rQ8fg15lLfzXbv+eQvl1VjpwDi1r2c8hwzRBi/gy1zFe+WN46ypkI/Zeq8BIlNq4qPUBXa7oOj3IOsmou7g5lrDpyxAYMx5HWVO0L/fffD/OBkb0aT7HSgYn3pz86J3YqnTkzGhbtAuW26uG/KsIA5/BcB/D8IpzPIcLrgI+bqNyfwC5Z6qw41tBKwAj5t08P0NvE42zhH0HoCFFAswNM+0VI48sR2OfJCY71Pl1xNXhOUg==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca00555-2945-402c-e196-08defe442316
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 22:49:33.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WZglV+Kf0OAk84CzQ1mfsem7uiQDQt1qs6iKoA1Z0JIeXoQVPTHyBhpqK4b3nlf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5602
X-BESS-ID: 1787179775-111702-12581-7781-1
X-BESS-VER: 2019.1_20260817.1854
X-BESS-Apparent-Source-IP: 40.93.196.91
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkZmlhZAVgZQ0NDCPCk11TApKS
	051TTNMsXSxDTJwCAl0cjAzDDZwNRIqTYWAM9rpblBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275505 [from 
	cloudscan8-248.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b
X-BESS-BRTS-Status:1

Qualcomm/Sierra SDX55/SDX65 modems (e.g. EM9291) withhold unsolicited AT
result codes until the host asserts DTR.  The in-tree mhi_wwan_ctrl driver
exposed AT ports but never signalled DTR, so URCs never reached userspace.

Patch 1 extends the wwan core with an optional ->dtr_rts(port, mdmbits) port
op.  The TIOCM bitmask state is tracked entirely in the wwan core; drivers
receive the full bitmask so they can drive DTR and RTS independently.  The
core raises DTR/RTS on first open of any AT port whose driver implements
->dtr_rts and drops them on last close, mirroring TTY semantics.  In the
ioctl path mdmbits is re-read under data_lock inside ops_lock so the value
passed always reflects the committed state and concurrent ioctls are
correctly ordered.  wwan_remove_port() also de-asserts on hot-unplug.

Patch 2 enables the IP_CTRL MHI channel in the Sierra PCI table so that
the IP_CTRL driver (patch 3) is actually bound on those controllers.

Patch 3 adds a second mhi_driver that binds the IP_CTRL channel and
registers a ->dtr_rts op so that the wwan core's open/close DTR raise/drop
and userspace TIOCMSET calls both reach the modem.  A single recycled sink
buffer keeps the IP_CTRL DL ring live so the modem's transmit path does not
stall.  The existing AT/QMI/MBIM data path is untouched.

v4: https://lore.kernel.org/netdev/20260816121705.858013-1-peter.hunt@opengear.com/

v5:
- Change ->dtr_rts from bool to unsigned int mdmbits (patch 1 + 3): DTR and
  RTS are now driven independently; fixes RTS inversion when TIOCMBIS/BIC
  changed RTS with DTR in the opposite state
- Re-read mdmbits inside ops_lock in the ioctl path (patch 1): closes a
  concurrent-ioctl ordering race where two racing TIOCM ioctls could leave
  the modem line state inconsistent with TIOCMGET
- Add ->dtr_rts(port, 0) call in wwan_remove_port() (patch 1): ensures
  DTR/RTS are de-asserted when a port is removed while an fd is still open
- Update kernel-doc to note ->dtr_rts is AT-only and describe mdmbits (patch 1)
- Pre-queue RX sink buffer in mhi_wwan_dtr_probe(), requeue in dl_xfer_cb
  (patch 3): prevents IP_CTRL DL ring from running empty and stalling the
  modem MHI transmit path

Peter Hunt (3):
  net: wwan: core: propagate modem control signals to port drivers
  bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra
    EM919x/EM929x
  net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

 drivers/bus/mhi/host/pci_generic.c |   2 +
 drivers/net/wwan/mhi_wwan_ctrl.c   | 190 ++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c       |  40 +++++-
 include/linux/wwan.h               |   3 +
 4 files changed, 233 insertions(+), 2 deletions(-)

-- 
2.43.0

