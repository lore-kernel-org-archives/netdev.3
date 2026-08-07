Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C74570C6;
	Fri,  7 Aug 2026 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139471; cv=fail; b=kXm2kXQkK64CKC9JBw9cpIvD1L/1Zra/SBZFdq1lx3GNeOIK8UCEyJjGmAd3JLou9Kl4JYgNOxp3itSA2PvUO14EVcIR3JxOtOUxnKQgnZIQvYER4lWNZqo9kgz9UmAneWWyY8WPhE7bF5KLveo5hROFEtRzf3mXZDUoC4qHtOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139471; c=relaxed/simple;
	bh=mEYXzNpPuJj7mUC5mr4+oIMjksBUyRUDxAhQ4ThpWzk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IkyNHdd0mNnGYdSYuO8z4d+dOzDW4T8lRlyFPnEiSVRKGqAfnFd09FxFfZv+ledtn0xYUw7rvWIJwWfFEz4b6iAhZyCpzjyp1SUKebtrb9xeGWd5svGx1GBuuSaHzcmrbUC0Qnh8nWLrXGxfdgwuvZqvgEYHZIt8HDbVnqr0DAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=S4QW6QiR; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="S4QW6QiR"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022127.outbound.protection.outlook.com [52.101.48.127]) by mx-outbound19-33.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 07 Aug 2026 21:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnwZM2I+xYE4Z4Wr+M8PkD60rLtROHCfqEXzW4c2Kn4eG3qOAMkAkJDd7FgRSjfwnxayO5hmKu/xZ+NVWqv0Ms8dB5Zr9OX7P7/wBZspltWaZbCTvS+0I0TV5P4lCbPFd+V1OhjjwPFTPDten6dFN6/9KUjel3R6d+vAasK+zBt7W46BlYryV8ufdDTvgSRhUWREo0F+02UAmJKaLwNpoEOJiTxUf6Fx0DrHkPXxKtrCnafx2XoOVCe0OAwmY9QkF9SOY1MNQ/UNqcrQD30v3Svt+rkxpweXb0A4qKa6LhEesX257XH+1G/Hq7FKYQZ9SjUm6C7i1jcCUlG8l5/V6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIxxcUTyJ0sScoCge1L5ZTHRVMsMRzcnottz8JmdM0A=;
 b=uzczJItagCk90G0qXsB6ACycQvjVdmYJ2HJCb3vG1fj0fXIy8NqFPdUTVTXB8n+ugrFZ9j6wpIrTFOmqDq1Yb9EDdFEx6wMSsUpHX2yW0fvoScS2vek/3w0aXK5w21cCzP7STKZcPkkahR0CavoIT2lmPHs4b90msO8SE77xDWGr96ol7j4cjCGeKism17qlWIY6eeW6oGLBP0UaiB5IvwZEWrQnKgKSkCoNBnJt1MTj9TKgc3pq8zB6E8iQXmki95NrMLudpEqXl88halTE5LsGKG/1ZQzyavCX8Vnd3GLXwG6J1yBDIRDo8kos6UBHz6UNHOavfLqlMrTO9O/57A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIxxcUTyJ0sScoCge1L5ZTHRVMsMRzcnottz8JmdM0A=;
 b=S4QW6QiRbv8yI9zz8g49/M5jlmQwlXNl9p9fDqm9YpKjtd5/sj7fJ+vSniDdKwCRcsKDNuAML3nWZWaU+2MbtFEHR2EpqaNEK2vawa+RGtYaAEhsNC7VVWnKZt0KriayiVqEKK09GFbQR5+2YG9ZY04cSUqEKfPDJZMAURd+LXHEgWWS5OsfLIwNrinT5CLA/643i9N5/Sck/tploX8mwtGdFglSiCMM/1UEmN9ExgWpGWAA32wCP8smbYgleKX8eqdw5q0GSEm6UHWGE9qktjZKR1znfMMqPYbF0RSIXk8kamjU7AYT84T0Iz0uvbQqZEsOV5ddR5douZqQyiJh+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Fri, 7 Aug
 2026 21:50:45 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 21:50:45 +0000
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
Subject: [PATCH net-next v3 0/3] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Fri,  7 Aug 2026 15:50:38 -0600
Message-ID: <20260807215042.2714442-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:8:2b::21) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|BLAPR10MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d5ac2c-fa3e-4b31-8c58-08def4cdef58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|10067099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	S2f4aZ8VZY2eZ4QwmVtN7P8tuJtsEQPdIqBDSQ+BvQll5R/+1rhRHQf1E6DhK72shItXfsQCyOB9HIBNQTI/ia9BMRl4l+HLGpcz6c0QVqqDO9k1AeuLkSQNnv0uQDgKJLzpaYEpp1RUttrtdjjaEWgSAWN76YCVql8LsuME9m3l/+1owndql7R/KSlEtrnj1Cv3kKyXmPpK4aQ1oQBn+odVjiE09H+y5wn+oZUh5XEIUhyPWut8Wu0Sq+EaFEerESaBOGTcd4yDqaiXMasD7Kz0rgQ3eGfbc5Mj5TkTob0693JxBgKEPLyouZwt7HaTBz7nMtGfj/ZpbGl7Sze34845rE2M/bQGtO03OVDy/puzV8pcV4m0Cn0Wq7trNbGsf52TFzpFQaewFlpckf1w5Y1B0GAKzKmjo29sOn4LdUYYzeAthLkLqiopUpxeOB6ffuZScPaLXf/vuAOmNef1nmygDRBYTMi7Gj5qwKK1jEW7bw3Lx2YqZJwfBj3nGdwkKvqJHqQ+gAwOuuW33SrbE50QqLnDagvb7BJj7kTLv6aD2hsIRxH/qBbCCLrXxeEzczXO80K5QUXXn92cPUTAkdA4W4weWOf/TL87yz3okGqk/5kJEIrk+1yhifATDkfykz18SL9y9XYk0+21Nh30NbssIb8GI5i8OGK94n0aaik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EJnl9YX5qVASzHkMaMQkHh7Y7xLLPcSMt5wZZgXQAOADDpS8ngvRjtSYh6Gv?=
 =?us-ascii?Q?kFKF1ayB7eVUn43hGuuRBxlhZ5L6+jH/XArv2KYNZDIo6QXTx8jFC7WGtf5e?=
 =?us-ascii?Q?aLjowRhAbS8QyluOn+IS67m38fHEqXJp7v5d3KnfoPHwEVWYNGObKw9HRyxv?=
 =?us-ascii?Q?3tfJBtyXDQ3zb8qOlcVMoUH55pUqjROqyZUGaX9p2WRGwSdxnED60K338gJO?=
 =?us-ascii?Q?t48qoaft/SRbj5i6U4H4x2x9nup+1Pe/nzZFKa6Io/MulVna0AMGcDtFoVce?=
 =?us-ascii?Q?4aV60w2mTUT5vB5j32gQZXrUEctlMBlTzciA7XWydClKgGflKAgxYOSeIkBh?=
 =?us-ascii?Q?dXXX4UZSRBAh0I27s/MxWvmFF1lHRN7dfr81Xw7McfT63iQN37YWtm+IPhrf?=
 =?us-ascii?Q?AYhym4QCg2GrdJJ6KDy4ejsMJjZjVoRv6aqEkAhLM3l1rQ55rispJUhpLcB1?=
 =?us-ascii?Q?yrMBNanYzk24ktnfePwEJVbmoMWmNPMCO9DyEpAUMC777ED1plZBAZOUry9P?=
 =?us-ascii?Q?Epabe9nFvAKEpAAZEttZ/6bhmUb+dxKHm3ttQ4zGclM8HxJfEISuFcRB3BWs?=
 =?us-ascii?Q?mtA5IP3De1Y6f5qpgoijO7VmcoeW0/YFgJHiuNFgN6VxGuNzw+TxvX3DxM6X?=
 =?us-ascii?Q?vM33OgFHfkF6M5/vqNzN5F0zQC7ENA/GLVVsdcnSeQ3H4Fdr+AC9Ce5Bgfsn?=
 =?us-ascii?Q?QPXfkjuE7l49pN3+N3Tt7d5/ljzOPUgtsBuPhY7CYCjwm1/laoz2M5F4xlbB?=
 =?us-ascii?Q?grzdtgzjoCKcLzlSP0r763z6WEN4wkwz4MroRpjrMmeu1Gn6xtXoNAEXFhEZ?=
 =?us-ascii?Q?A+C+U82yNJg+SHssSV2T9/DK7O0+FnmYzGduB7/fthPGyITkGInPfXQm1TOa?=
 =?us-ascii?Q?n3KjVditV/fFvaI60E2uVbDzqV6y5RFbQG4JSpSS+ZypjmYDz3ngJsyRzVcn?=
 =?us-ascii?Q?wCpISWJfSkILDq6kHo8KITzgCHeopQMcZLdx2D8HpEscQweuWQy712TxfMs6?=
 =?us-ascii?Q?f+xuPnxUeXEaJxl2/kBArEVzKyYTe4jqkjgU2xsr7r0Kr0xT5AkwFnPEalbY?=
 =?us-ascii?Q?F0dLHejf2I5EymAUyksiV9sRjesjQMuJROigs4qsTq+Y9qcpaDucrvogMcXH?=
 =?us-ascii?Q?KHXfaBppSSYHKlDhWSKzEmVTyt3mIyPat/6EaWDb1+dSgy30OacNg5JQgHX7?=
 =?us-ascii?Q?crnvO5Ob9fBA97MdIi/2e7L6DHJ/vWAE+LExT9NjlhGQEAkB5k43JzFdgrao?=
 =?us-ascii?Q?r8+bd7xs5GpwdiF4tjf30Dti62spZgZx6/Gdr4GS9PyNsZzADATcYX+ujke4?=
 =?us-ascii?Q?cL0aSMKU2or9GBRCvIbdjCbOCqGvdPvyT/ZH7M5eyb0WobfSYkSeniJ7GuXc?=
 =?us-ascii?Q?iHPPwg5j2tws+sA+7/IuRQBHTM1cjQW8TS79EHhhZvkeMqqPR3AJxMdlUUtH?=
 =?us-ascii?Q?oSDiqClnHZd2Gju6JcZ//Dv3IvBnWY/mbxfgb8wyFYpzxcwrN6E2m/JlcQgh?=
 =?us-ascii?Q?olT/mN5zR46vDBeehZ6RRScwr6aKDJ2uy5wI/EdhExjdwpLJXdoNNaHZZOzr?=
 =?us-ascii?Q?qNIgyxW9TPo/6qPAimhMT6teMmyI02pbUd5M+P/uclQ+mqBnimy2lv9VXINT?=
 =?us-ascii?Q?z2d2tiisM2j4IY15PdsPlUeMh4JsTIJlTQ7j6WbQoiEaPtiY4lfio5j0+Ptx?=
 =?us-ascii?Q?VxdQAxrl/k3xnJ/y4DDq+0ZUjyxNmeLfySyv4/oG7V+FDTlv?=
X-Exchange-RoutingPolicyChecked:
	mnuBlni3RICPIfl96j9WhJN9U9Y+e6pDn7umGnisAsRD5mcM6et+yDSY35VM5iaMOEkMvIrL0jNA7R+WR/4t+mRph8eo6P7OmxhM71gZZVdmhloyHCxmbeaxP2olb4H/GRwricYC1Mi2MmrmmGaMEVUZKHjCFuIoTTLdt5O2LnPG01CKwPoCKCd/N1Y9fq+WK/OTGzlsKwK82xvwaohTTu7fjJnAL4piKtIFXbsrL4VqSPzeL3MVMTpitwKu3EzUEcz0X2V3vmt5HLks0fF77bqefanNnPtZlPdjRFJUCkO4b7ZYLHqztyzx/1j4VROyT0d2H+4EuWwg/XpWtENDXQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d5ac2c-fa3e-4b31-8c58-08def4cdef58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:50:45.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zktkrs5ryAJcQoNKfSc8Kqkx2ewKhxG2JTURan02QS6LQ3wS+T1tbl52x9aL0ckc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-BESS-ID: 1786139447-104897-7739-10102-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 52.101.48.127
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGZmZAVgZQ0Dg10cgg0cDUJM
	U8xSjNxDw1KdnMwMDCIDEtxTg1NTFNqTYWAJdo9a5BAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275220 [from 
	cloudscan12-172.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Qualcomm/Sierra SDX55/SDX65 modems (e.g. EM9291) withhold unsolicited AT
result codes until the host asserts DTR.  The in-tree mhi_wwan_ctrl driver
exposed AT ports but never signalled DTR, so URCs never reached userspace.

Patch 1 extends the wwan core with an optional ->dtr_rts(port, on) port
op, mirroring tty_port_operations.dtr_rts.  The TIOCM bitmask state is
tracked entirely in the wwan core; drivers receive only a simple boolean
assert/de-assert signal.  The core also raises DTR/RTS on first open of
any AT port whose driver implements ->dtr_rts, and drops them on last
close, mirroring TTY semantics without requiring each driver to duplicate
that logic.

Patch 2 enables the IP_CTRL MHI channel in the Sierra PCI table so that
the IP_CTRL driver (patch 3) is actually bound on those controllers.

Patch 3 adds a second mhi_driver that binds the IP_CTRL channel and
registers a ->dtr_rts op so that the wwan core's open/close DTR raise/drop
and userspace TIOCMSET calls both reach the modem.  The existing AT/QMI/MBIM
data path is untouched.

v2: https://lore.kernel.org/netdev/20260806155253.3378294-1-peter.hunt@opengear.com/

v3:
- Replace ->tiocmget/->tiocmset port ops with a single ->dtr_rts(port, on)
  callback modelled on tty_port_operations.dtr_rts; TIOCM bitmask state
  stays in the wwan core (Loic Poulain)
- Move DTR/RTS raise on AT port open and drop on last close into
  wwan_port_op_start/wwan_port_op_stop in the wwan core (Loic Poulain)
- Remove is_at_port from struct mhi_wwan_dev; rely on wwan core instead
  (Loic Poulain)

Peter Hunt (3):
  net: wwan: core: propagate modem control signals to port drivers
  bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra
    EM919x/EM929x
  net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

 drivers/bus/mhi/host/pci_generic.c |   2 +
 drivers/net/wwan/mhi_wwan_ctrl.c   | 172 ++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c       |  18 ++-
 include/linux/wwan.h               |   3 +
 4 files changed, 193 insertions(+), 2 deletions(-)

-- 
2.43.0

