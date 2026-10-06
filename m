Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3173563FA;
	Tue,  6 Oct 2026 04:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259521; cv=fail; b=dV1ukDarpvLxtAcSHYIDhKuFYJt/V9pbyjAmZfXEFDG9ny3GV3W2fmkFJpkn6DgPlagc1amKkUW6f/yMv0UFeFMvqmkLVPM7EcAfdMG/y7JZpOoI9FthlY1EBodk656UrUcfBhLJnZdaTW9L4g2DnTzVzC/dIXzUqaFNL01VgyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259521; c=relaxed/simple;
	bh=YmHPpEqYPBrgaEiFpdkmIeF34HVuuzRK8IbQ8lRHncE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agn4DZ9LyaS7dfCIauXmo21AKg1IISBkDbgoFrqltt0K9/vK4IgboJmL2p9lVPPtM0g2U7vNoHUc9DWT2N+EqBFJPlwZ584HXVAJuTCZ8nc/KBfekI9T75SpKqlrLrl067APvsjgT2nF6wDxu0HaGuOYKFkLqHZxPX0if2k+V0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=rPRGZ+Tr; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="rPRGZ+Tr"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020083.outbound.protection.outlook.com [40.93.198.83]) by mx-outbound12-109.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 06 Oct 2026 04:05:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hovvDDn5EjsVh47QV52sIU5rZwvsAOEX599VT+57QF5sOoFdQObS+Wy1HJ/2y/ZmEsiLwQ7gUCIyWHWDpXVpQzQdaWk/MealUDcP8UWtQxSEbQrshn59OsXQ7+N1uF0LYuacjQ9MextpHP621N2xBHQWgOtBJi9Vx9+4vi5L46mrTC7F7WnICCsyKZkYvK7suILqpYlxjPojeY8G68s5a3UwKBIBK7MRhM8Sl3KcAJi86LetkHDDUlLtRZZngOP1IQv1P2SFxtPN1ifOfwkDKWaVQvScjMt43FGhLjNKe3BUmmNiAA095hnCP8Zt/i0OxjlemLvsZZPmxnmsAxP/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otmzSrTeeyC6x9Fr2N4cHYsB0E/i/1km1V6y8GxOBhk=;
 b=LBRz3fAvPA3yx0UJg5qhKluaczqXx/31LL0IwYcGiq4GtaFMtcqhsaCh9xv5lcUGI729c6elgWXVSgPmWwOqU1gwMoMPpnODkNzY21i7NvxQU67Tpy9StvBNNZOCXwbW8IxeoWgPWkjLEmQpWhmEOQiOAc4UWYLv1fmLIdDbCLo4KxwwsNbs30DN7KwZEgf6iOKJN6lxx/P1bjh6W+0OzTwV/rpzBEululxDopFS3quHSQ5emMN+P4QOBNjZNDPoXwpgXTpozUflvFHmZkMH1T6wIGBqeVdkaiB4rayO3Y1y3vS+kndEiRhgCtJYT39KqJm9w+doCMlIBK5pOX0G1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otmzSrTeeyC6x9Fr2N4cHYsB0E/i/1km1V6y8GxOBhk=;
 b=rPRGZ+TrvVFVncVePqwp7gDZ1kYmh6sBy4pNchgLGs8CjIh8/iVu20WjnHZQ7dA+sF0GwjYNl66IZSlYSmN5loaVdEC/939LzSjD0bR98YaLsqap7Kjrd7NupXclLtnSAFPF3MHwrOPQUlfWmlwrycgC9Ux4UDwSlsA+GqrbWSlah1PS3ZeTLQR0Xguu9P6g/ZyIt53r8h+KLl51pgne9yHKklp+n15F89sRnvEXTn1xlJMtnsrYcsJNghf3BD1podfaaG7CF1cttIW6VggZRBjdZ9+6ztdzxgqKdCYi9wlX/Hq+EO0v7CHNrK1TVY47UxM2vFZMRN79F6s0bDnh3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SJ5PPF1849371D1.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::78e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 04:04:27 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 04:04:27 +0000
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
Subject: [PATCH net-next v7 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Mon,  5 Oct 2026 22:04:21 -0600
Message-ID: <20261006040422.3208888-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006040422.3208888-1-peter.hunt@opengear.com>
References: <20261006040422.3208888-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 223155ed-4a9a-423d-b597-08df235eea06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|11063799006|56012099006|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iJ+ksBYW1D8/P7t6RMP9jmhi75gxU5QoD69Tmidgl+HbTVbJXAGvpcWvh4llac5KGFGpEkrwwAkTi6P55J8Lfos0iu/o3O12RHn2Kc7n9IpmKVlmH/zTX1yFa3hECIcjeQjnfqzj4dLa+6fdTX6zpZV3urh8JL1asqcrqQoNpvczoaNfltQNn7Ygpx8qNuSQSPBdEoU9OqmwW1IjJXgfLcECuRYLBpjuRU8XldGdKBW6X6f5XWlsb08Kjtgc8IpWjQjF97SoV+uEw3Y9Jf/MOfc8uJr+ILwYLxlNjmHs/NAIPlOH7m54CpjDfXiK5A9GfUgJUWV/5rrn1c/uf7GmKuEX+1Rqyf1A7Saii5jNd955eDhUroWoVb7g8VAhrRZZl0xSaVjY1n8sFPOfiz1rGJcgVIvKkOLT+wUPLrzg26lO6s07xsM8i/K/mqyqO05wDf6f+dApLm5As+RIQMKj/d7roMA7dsyQpbOW0Des3XyCaDijW58DzlbS4fl+NjXskcIRL1onhMoZhN1/NXOJyrh8ZMkCtq8a7zHNvsvRJK8zjQ/Kd1nimjNj+uOhaU1ki7E4H3347A+VYrxNvvQhMPF2cQjcsR1rPXQmsg65wpzpkFR/31zb64w31bd7V4FDPB3pSIzbCe0zGDDib2f5SGkA2T7thpqzLtknKug1Ugk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pB/kk0jeP1FlFOBypCsmnmhH3BOrnKmhqgHGF1uB2BGc2NAca8qUSUZuksaL?=
 =?us-ascii?Q?rHPBIxT4djNYMcQvW0QU/YN47mEt5f5taxAJnTYr0Cu3DYs5epqFUpIrpUA6?=
 =?us-ascii?Q?Uhd3Ai49fsA2O77pQmG3fuqdNrZIXcAjSUS09tM1MzovoNOmtBi80h8JI1Cr?=
 =?us-ascii?Q?zY0ptpNZMrfn7KEsmbyawfmMeebEmwGoiC5BmeNwHOana9zZt8Xk20rv6h17?=
 =?us-ascii?Q?+cYmwM5/SIs38qwlrHB0k0sBtItVvCT3bcwKF+1y+1dXa5FALxryZ6VuGc7n?=
 =?us-ascii?Q?mhwqsh2JziHkUXXN0prj861FBgP3OGlln5loJ9xxqCa61kXyHPO+19SMVQzl?=
 =?us-ascii?Q?nuvLtRgBIUzjloFQ7YSFLnbOxGVPme+tjx+t4KiEwnOhWlMnsqfXCgFiA5ac?=
 =?us-ascii?Q?Hvf/74uGyrCEL0KIARMyB+qtuptNwP2F00q8CrZrwcU/pgeuSG8XciUoK2i7?=
 =?us-ascii?Q?t3G4RbmWVbH6VaGresV4dqk/N8Q4M3NcKAogY9dDix05oPN6uIH50ERuM12B?=
 =?us-ascii?Q?7Y/WRqisoUsbEctsw3gYmdoNwQPd9EQs81I9100C96Csw1jopMVSdsdB+8WI?=
 =?us-ascii?Q?Iurb7tQYOTgqWBTm8jfDUhH4dpbsfH09WMKtSbn7392osrl0i7/y4JkTDEXu?=
 =?us-ascii?Q?rqkbH4Gaznzy7//3WWTmb/E3KfrlMk23wLLZuNVD1aA1QpdFvEfutCUaoktp?=
 =?us-ascii?Q?NIhIIjkraaDzrqXHLbVK7SnOii7EB/pMU2Vhq2T6sy4wTpdaTFkB+7I6wN92?=
 =?us-ascii?Q?GhCUr0Y2SyreiOAQ5BJfGpDZl3jfTO6+WM0cJ6gY39GpfsFwc9FQLZ6ojx6j?=
 =?us-ascii?Q?0lh4Fe9SzYq30GPCxlda82IRxLCQ2TZyh+/NUwxl+VtddURL3na4SNETaQ9m?=
 =?us-ascii?Q?HM75Jgdp0OFocdYZrsPKgpqZQ37SCDVbBCPcGZnji2VxyMQaiQZKESTJZ3vG?=
 =?us-ascii?Q?H96i9le0CMkWCNG3PFKHcCmpi3N8kCWQGIuUHZI9OgIzvRUTdbilJOmBGEef?=
 =?us-ascii?Q?kYoDjxgL0JsLSP7/LLVdtv/lxv0cnK0Mu6u6cnEtFACQEdh1SSt3lZ2rr260?=
 =?us-ascii?Q?b9nGy2vp6TCUk2u37O/K+TJhtXmdTJwvapc5MAe05+b3CTzIAUWSYwX5x6LO?=
 =?us-ascii?Q?NJ7oh2owB4h23ghFWEnTGEfhSsQsD6dwoD9jVWeHINxIRNjjgoRFj1ujjONj?=
 =?us-ascii?Q?z6vkrBLFjVIFuhcCsi/7E+9xVj2CRMamTzEp1Jnp5D0yuN4scN7DZ9n+sirs?=
 =?us-ascii?Q?iMJ9GilFqJ/JXYdf71ZT9UNcczc5OaK+lw84vnj9FWpdhSKv+tReGfk8dVpd?=
 =?us-ascii?Q?l7Hvx+0S0rWrwQ/wz6K69wR6uwI9S1a9EGkx9FXt20lfdDyvCFgHMjan3cML?=
 =?us-ascii?Q?2VcP9OU8vWksq07Uk40bSwWD8FMSfXpRaPfGv5OT5tFnGVJusVURNkx0VvnJ?=
 =?us-ascii?Q?PoxVvv8Z+JoAzxip02SLTaXmMMM9Ialqelhx/p//WAkK9XsEjdSnS2x5q39n?=
 =?us-ascii?Q?9pyiJq7RPFawke17cJTxIxyFinPChmYupO5oIWTFdm/CfSBgZ6zP1eHCL97k?=
 =?us-ascii?Q?8jbsvKFVofuvDg8er9FHtCBUHF88P36HQd/mBbcbOVn8xgZNplA4iFUM/WPG?=
 =?us-ascii?Q?QZfKj/9FP1LW0L20ltwn0JmTkbFXbQ+LvejHPjwu2uw8EBxUWB1annt8XN5J?=
 =?us-ascii?Q?VIH0bzivZsHlO4CFredsNBETuX3fAryDjTpYV/bzxlP0x2jE?=
X-Exchange-RoutingPolicyChecked:
	pBRy9sZeJO9X8nQOoiLzXamwu58kLWKZSHNdp7m1zIId7FCqt6Esi1PKGjYwtk5lA/7c5oE91Wq4vqT09zo06DUl/oSRRHrGaInpQ/Ry7lN5wWMKcHCAf5Dg5WoRDuvValBG8buksypO9TL+F4RdJMq0Ricz1fv4NbtV2U5jjrx5mTnD5/7ztChjVKGtsOFtSnE6yzQlbNovvNt5OFQKaxj4cV0Bo8c6wQLcrubWpdZTwYAtzw0MSavWFREy8X3KX2EplfwRxKC6SunMH3VhdtUT4A5MdV2kzsCRskc7OozZyggUsLx4MGrvXiK58ONpJhqqkAth6oVD+2T9btpGUA==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223155ed-4a9a-423d-b597-08df235eea06
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:04:27.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSVJLHc0/kJ0G2q+1YQw3HyGkMPGa6Xeb7qr65aKLAVQabrr6zO7Pk+qUUsyI75u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-BESS-ID: 1791259467-103181-25096-35818-2
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.93.198.83
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYGBhZAVgZQMDXZ0sIiydLYMj
	nZyNLcwCwxzSDZwCLV2Mg80dwsOS1RqTYWAOg6Z0FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276636 [from 
	cloudscan21-7.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

The WWAN character device emulates the TTY modem-control ioctls
(TIOCMGET/TIOCMSET/TIOCMBIC/TIOCMBIS) for AT and QCDM ports, but the
result is only stored in port->at_data.mdmbits and never reaches the port
driver. A driver therefore cannot act on the host raising or dropping
DTR/RTS, even though some modems depend on it (e.g. they withhold
unsolicited AT result codes until the host asserts DTR).

Add an optional ->dtr_rts(port, mdmbits) operation to struct wwan_port_ops.
Drivers that implement it receive the full TIOCM bitmask so they can assert
or de-assert DTR and RTS independently. The wwan core tracks the full TIOCM
bitmask in port->at_data.mdmbits and calls ->dtr_rts when it changes, gated
on WWAN_PORT_AT to match the open/close raise/drop behaviour.

Also raise DTR/RTS in wwan_port_op_start on first open of an AT port when
the driver implements ->dtr_rts, and drop them in wwan_port_op_stop on
last close if HUPCL is set in the port's termios. This mirrors TTY
semantics and means individual drivers do not need to implement this
themselves. As on a TTY, HUPCL defaults to on for AT ports, and userspace
can clear it with TCSETS to keep DTR asserted across close, for example so
that closing the port does not end a call on a modem set to AT&D1/AT&D2.

at_data.mdmbits is protected by data_lock. In the ioctl path the ->dtr_rts
call is deferred until ops_lock is held, where mdmbits is re-read under
data_lock, so the value passed to the driver always reflects the committed
bitmask under ops_lock and is serialised against concurrent ioctls and
against port removal (which nulls port->ops under ops_lock).

wwan_remove_port() also drops DTR/RTS before ->stop() when a port is
removed while still open, regardless of HUPCL since the device is going
away. Both drop paths share a helper and pass the driver the resulting
bitmask.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v7: Drop DTR/RTS on last close only if HUPCL is set, and default HUPCL on
    for AT ports. Pass the masked mdmbits rather than 0 from
    wwan_remove_port(), via a helper shared with the close path. Both
    from the Sashiko review of v6
v6: Rebase onto net-next. Snapshot mdmbits under data_lock before calling
    ->dtr_rts from wwan_port_op_start()/wwan_port_op_stop(), rather than
    reading it after data_lock has been released
v5: Change ->dtr_rts signature from bool to unsigned int mdmbits so DTR
    and RTS can be driven independently; re-read mdmbits inside ops_lock
    in the ioctl path to close a concurrent-ioctl ordering race; add
    de-assert call to wwan_remove_port() for the hot-unplug case; update
    kernel-doc to note the op is AT-only and describe the mdmbits argument
v4: Protect at_data.mdmbits in wwan_port_op_start/stop under data_lock;
    release data_lock and acquire ops_lock with a NULL check before calling
    ->dtr_rts from the ioctl path; gate ioctl ->dtr_rts on WWAN_PORT_AT to
    match open/close behaviour; reduce boolean to TIOCM_DTR only
v3: Replace ->tiocmget/->tiocmset with ->dtr_rts(port, bool on) modelled
    on tty_port_operations.dtr_rts; raise/drop DTR/RTS in
    wwan_port_op_start/stop rather than in the driver (Loic Poulain)
---
 drivers/net/wwan/wwan_core.c | 61 +++++++++++++++++++++++++++++++++++-
 include/linux/wwan.h         |  3 ++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..eba4b0582b5a 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -655,6 +655,10 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	init_waitqueue_head(&port->waitqueue);
 	mutex_init(&port->data_lock);
 
+	/* AT ports hang up on last close by default, as a TTY does */
+	if (type == WWAN_PORT_AT)
+		port->at_data.termios.c_cflag = HUPCL;
+
 	port->dev.parent = &wwandev->dev;
 	port->dev.type = &wwan_port_dev_type;
 	dev_set_drvdata(&port->dev, drvdata);
@@ -679,12 +683,34 @@ struct wwan_port *wwan_create_port(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(wwan_create_port);
 
+/* Drop DTR/RTS on an AT port. Called with ops_lock held. On last close
+ * the lines are only dropped if HUPCL is set, as for a TTY, on port
+ * removal they are always dropped.
+ */
+static void wwan_port_drop_dtr_rts(struct wwan_port *port, bool hupcl_only)
+{
+	unsigned int bits;
+
+	mutex_lock(&port->data_lock);
+	if (hupcl_only && !(port->at_data.termios.c_cflag & HUPCL)) {
+		mutex_unlock(&port->data_lock);
+		return;
+	}
+	port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+	bits = port->at_data.mdmbits;
+	mutex_unlock(&port->data_lock);
+
+	port->ops->dtr_rts(port, bits);
+}
+
 void wwan_remove_port(struct wwan_port *port)
 {
 	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
 
 	mutex_lock(&port->ops_lock);
 	if (port->start_count) {
+		if (port->type == WWAN_PORT_AT && port->ops->dtr_rts)
+			wwan_port_drop_dtr_rts(port, false);
 		port->ops->stop(port);
 		port->start_count = 0;
 	}
@@ -759,8 +785,20 @@ static int wwan_port_op_start(struct wwan_port *port)
 	if (!port->start_count)
 		ret = port->ops->start(port);
 
-	if (!ret)
+	if (!ret) {
 		port->start_count++;
+		/* Mirror TTY semantics: raise DTR/RTS on first open of an AT port */
+		if (port->start_count == 1 && port->type == WWAN_PORT_AT &&
+		    port->ops->dtr_rts) {
+			unsigned int bits;
+
+			mutex_lock(&port->data_lock);
+			port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
+			bits = port->at_data.mdmbits;
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, bits);
+		}
+	}
 
 out_unlock:
 	mutex_unlock(&port->ops_lock);
@@ -773,6 +811,11 @@ static void wwan_port_op_stop(struct wwan_port *port)
 	mutex_lock(&port->ops_lock);
 	port->start_count--;
 	if (!port->start_count) {
+		/* Mirror TTY semantics: drop DTR/RTS on last close of an AT
+		 * port if HUPCL is set
+		 */
+		if (port->ops && port->type == WWAN_PORT_AT && port->ops->dtr_rts)
+			wwan_port_drop_dtr_rts(port, true);
 		if (port->ops)
 			port->ops->stop(port);
 		skb_queue_purge(&port->rxq);
@@ -980,6 +1023,7 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 				    unsigned long arg)
 {
 	int ret = 0;
+	bool call_dtr_rts = false;
 
 	mutex_lock(&port->data_lock);
 
@@ -1036,6 +1080,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 			port->at_data.mdmbits |= mdmbits;
 		else
 			port->at_data.mdmbits = mdmbits;
+		if (port->type == WWAN_PORT_AT)
+			call_dtr_rts = true;
 		break;
 	}
 
@@ -1061,6 +1107,19 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 
 	mutex_unlock(&port->data_lock);
 
+	if (call_dtr_rts) {
+		unsigned int bits;
+
+		mutex_lock(&port->ops_lock);
+		if (port->ops && port->ops->dtr_rts) {
+			mutex_lock(&port->data_lock);
+			bits = port->at_data.mdmbits;
+			mutex_unlock(&port->data_lock);
+			port->ops->dtr_rts(port, bits);
+		}
+		mutex_unlock(&port->ops_lock);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 1e0e2cb53579..57406139304e 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -57,6 +57,8 @@ struct wwan_port;
  * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
  *               to the device.
  * @tx_poll: Optional routine that sets additional TX poll flags.
+ * @dtr_rts: Optional routine that updates the modem control lines to match
+ *           @mdmbits (a TIOCM_* bitmask). Only called for WWAN_PORT_AT ports.
  *
  * The wwan_port_ops structure contains a list of low-level operations
  * that control a WWAN port device. All functions are mandatory unless specified.
@@ -70,6 +72,7 @@ struct wwan_port_ops {
 	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
 	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
 			    poll_table *wait);
+	void (*dtr_rts)(struct wwan_port *port, unsigned int mdmbits);
 };
 
 /** struct wwan_port_caps - The WWAN port capbilities
-- 
2.43.0

