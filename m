Received: from outbound-ip173a.ess.barracuda.com (outbound-ip173a.ess.barracuda.com [209.222.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A7330D24;
	Sun, 16 Aug 2026 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786882670; cv=fail; b=sVEH/9tptybK7EltRVGAZF9jRwH7GUozXbu/QI8H9nfNgfht5yHb5AT7vB8GP5rDdbRYrDHWquW8w7h1WXftTtIsIi5U0zMmFf4ISvfPlSInfFKm+eIrOcwDK9V5z3KB8RGLRaOlKo7tmdyPoAzRRtC6IzeijPKYMJgsr1JUL3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786882670; c=relaxed/simple;
	bh=FsXbVYNX0hKoGTF2R9+AovbJvY9LMNeWCDhPdjTLru8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KUaqjg2yDsiCACoVTHeuHycVz4vKtiWziJO4swg/Nv8NvgbJZ57+BGZ4RwxbvTI42adR60bb3OxP6FwJT5FT2F1/Nbis6cQ6lHlNYWyJigSINfV0iyp1LihGtYOXs9tFyOkucDXPt7jsT4AECWuMubCecw2vvhuvQCStTCrF55s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=LcfQY8xJ; arc=fail smtp.client-ip=209.222.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="LcfQY8xJ"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020120.outbound.protection.outlook.com [40.93.198.120]) by mx-outbound46-112.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 16 Aug 2026 12:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+LeAvDwfQjgT+EE2v4kEY0vY5hkous8EPod7EHWXBlbs1cTP8+3ITkDwC7+KCdBjm6sJanAWY0r6xwXBItoxzCNqNYizXCHa6AtnBXZOkvJNgTIVBTGSF3tMfUDUs7p37dC9/6rQaE+0yO0eaO1UBdkRrlHQJv1uFND+bPHJjP8QYHyX5/4gAaYlVgDmeFbU5xlB0r5qdg9QDrn5Vt8sndBlLBv+BpkTtukikbTdY3/byJro+GGJOCcglpKSLKsZpVhUD3TrT3W4nDbtowPTKrtWSBmwKqYm9cb3IZYu8nYUbXkHXET5q6fO4rrAtARw2azCBUuzhXX0ubjyI7v1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOp0Mt0Zmk55cW3XunHwvYTudUFhQsIDIiTkgHVwKdg=;
 b=vTceceEA574DFACpuF29FDPS+hznlxDfmO663hoy5Sg2H2yea4qf7Nf5vPj8OwLOYxXknoU7xXwEAsg/SAxevn0X5uAQgpyGCjBzOyK39jIxHSXOyjcFrIFaHrGppxFJ03vNArhZfSrkJWkI7DbTRKUme7lqpCUh2me6qsBcaT5EqjSf9sPkP8sDNGILBlXwF4270a9QkGx2In/pU700OTngknmDVvcaULL4181OPmAd/tS+WWXYbL63Gzwn4fVaFERBHLt5EivsJFAAySVztb/y8vaXTODEDVC+7s1q48J4EwJUlEXFTv3w7f91Yy8d4U+TSHf6QDw2Ci22Nk93PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOp0Mt0Zmk55cW3XunHwvYTudUFhQsIDIiTkgHVwKdg=;
 b=LcfQY8xJVl4WRlH+KTzOAgib9fEpSdzzQ2LrZuAXkjgW8XsrUxs9SE69ccr9PG2i4vsqySl/mFIMUBG8D7kV1skIn26xMeKEX3m41CmHYNweEFtok/cGgMYrUBmXbxsmDO/Gx88zf/587z+HONz3QsoMA+Vmk9MJiK5nUE1F13uMV2SCLrZsGaA9BkGr6M3dWkSPKC08NsLVv8aK4JkWYA8oxwsRkc1/SHBdiVm2SyH5OxHRpqBWPiF0OzyDstLrUQFjjU76Hvnbc3hGnkKBaWGBnKQVaC28g4l/1C5uLTP4R+FQZsS1BuN5/YdZphTeLabCoJU8MZXVGuQkvmP4Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 12:17:13 +0000
Received: from DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a]) by DM6PR10MB4139.namprd10.prod.outlook.com
 ([fe80::19e9:d558:fd6c:8e5a%6]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 12:17:12 +0000
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
Subject: [PATCH net-next v4 0/3] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Sun, 16 Aug 2026 06:17:02 -0600
Message-ID: <20260816121705.858013-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0001.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::14) To DM6PR10MB4139.namprd10.prod.outlook.com
 (2603:10b6:5:21d::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: e977ab48-3edc-4d75-1ca2-08defb904d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|3023799007|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HPVGc9EGkQwSwBmkllA12N+kwFuZC6oAJBMNYAV1AnVB4BJXp+vyCH0iZwErxkLJYGTybrPrLiOIB8QUV+xrv/SY0PVcL0nuSRE6QRaKto43TBRjY7XdDmD/92LbPvwpb+SY43z8rjzW26Hjz+8j06zHTUnT2+Y5HzUjOtuDMXzzoPbtn9sQ4ARkbZRjLFBnOkIRz4gTsiIERPoXT5oW4cHODVGEmms4UiKQRCl9Dn24jbdwy1TiLPJ+lOFo/QJyxKVd4Xvpl4oBdS8jUa7nd+SK2SyrjNO7ddBjcZyi2AqSnrUtOtV/fzlcbSFxAIw2Tcn61oYvjOzQFTwdRSrqLfX3lu5cdBgchkLgIwhjUdKBjzPWQL+sNRujccUlOQ4aytLfZuJdx/FAWjrtC8+h1dSjtISo755kcmqIlqbCWkM8jWU1p4KOk67pvtNDTWuLcFuqq2/kxPwoTack2GizGuepavXuJWzY68tR32IAPP43CLWV2g2iz6maBSY0IZoQUAVwQEoLRxezkqUJgutmk6D8vEFYeTlEJEg1AYkYtF6hp2NUCXlWDwnbZYXMq2fHx5Be6/PYZS6Rn18VyoTKAEhU6BqAVpZ8If3S/+NhspgoyV2Bu2tsmvSpt6j5ASp+aZMELAMvCLIwoWhOpwgMyDVmOeeZdfw91VgVQD2qHf8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4139.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tX3EcBQD6SPGxsKP2q+T+TMJJAK8DCKD4wo3zlqEh3BY4xZ3pGh83ZAXiL8P?=
 =?us-ascii?Q?ukiB2ufSiChvsv6kdXIS8ZpuN7gebbHdDb+06cDJHDL5v/veAYTYJ9BY7UP9?=
 =?us-ascii?Q?DHM+2b1v3jYU6q0FeUtWjg0q+wLZfQ39VzWRPzhCuSwBV0inCH3D+IT69+Cl?=
 =?us-ascii?Q?UhMJMuBVrxf2nS+6aIf83gGA8WO7kbIXCrhtMzXD3pGTOMuJeyPh8HapHop2?=
 =?us-ascii?Q?LgNSGZsJHy44ZBZIUgN/xMbKqqwrbwYChcAI38IbmuqBIdUIT4ulIWFUvkmZ?=
 =?us-ascii?Q?HQK10avmMRGs6hsK2YF9x/if/zhXgKsjaUZ9Hvz704zADr1iM7XMlJuVvFYU?=
 =?us-ascii?Q?6io7e3Oi6a2rr+OB0tM4os0eqxK/ygE+N4YnFNQlz9EJNr1bu3/rc4QpTItX?=
 =?us-ascii?Q?bfMQc5LwElR8AzARG/AmPgNxaXsLAqX+Wj0nCimdyEAcTk6t/IzIcNmLBSs2?=
 =?us-ascii?Q?6bW7AXnjd/JIpDyh7T3rQa4X/fwrQBCs4QZj56wevy/ub/RORS8trD1xCe/V?=
 =?us-ascii?Q?G7G8laGmkV3Ls2Y+d3iuI5ZAPqS6Ybj5nMQCxsZpPSKLaQCN/azSjnZQlcxz?=
 =?us-ascii?Q?NgafY0uopMPhGhJocpVlDxIvlwhGERg5hEpzdvS+M7XNNiybpGbFa+qPkz1a?=
 =?us-ascii?Q?u/MpUXqikXEnZe7iI7r4WeoOcIh2RnF+12Ye9yuRzOxUuYZpvsT6PvUVLtVd?=
 =?us-ascii?Q?Lpe7UAmADKEnAywEpGq2XcJVbCVnNj57LJTQZZWgEO4L6L1mt3n7DwbxlbO1?=
 =?us-ascii?Q?khXXKSBHIMu6nJLLrm0kD1AzKgUiglKdQWNR/+E56JsrPdVG3ue6e3JPfR0G?=
 =?us-ascii?Q?w/xn8cJE3VYbiLWc9m2eMnZ10mZOkA5BEUzMQbFlwpKDaQSkHALh84I6j1pz?=
 =?us-ascii?Q?4hdivLKV6i5UO73PkoLyN/hpsVybiV/T9Oz0CZxhFMwBmYu26WpfQFmVpQD0?=
 =?us-ascii?Q?oirJrD7CI5oBIPUohK150I0qlxqxA+tLhNsc5724fR8iRyalTnJW5lFQc1ik?=
 =?us-ascii?Q?MHUo9TsWYocuIxguPAXCWmjjaI2118AFtLQfaZzw30NYGqJdeLgyO0JuWyjF?=
 =?us-ascii?Q?18y+x6aSKNerYe7Q2d1w6l4Icc3SnX4Y9TegHJdS7Xh6qxskp+iqAQsIs404?=
 =?us-ascii?Q?g2Lqn1fIVvvj6dcuO4dJOX4PdCBWIH9s8dC4PRv5lcHP+7ihoJov4QrSjQYg?=
 =?us-ascii?Q?yAe7Gn/MhlW8UWLJShSJI4SH235kEcJQhPkIqMbCMsVSoReFhJsPBDEtt3x4?=
 =?us-ascii?Q?rMy+znBHkZIYWidi99n92C08dqpFP/t9o/IxMlqeQ8xpD3AKPDl3Ez+V5on6?=
 =?us-ascii?Q?nM343dYF4jqji6hWl40mEi2ek5k4+rv3rQ3ycdDprZr4ufiM5CZtYyndUABf?=
 =?us-ascii?Q?zdW/O0naIvaGcmuRll3/BGqMLjvA086wiG8vUOBFoo8+hGyCOnYx82P6teps?=
 =?us-ascii?Q?BjIqxbVlEeXAt7Vj8sHmaF1Lh7iEbsP1bZqv1LPxD3UG8vSqYsrQCAA09VDt?=
 =?us-ascii?Q?qBZytVhRlG6YtM1ze5k9Hwb7YTYp8/Ws6tRjwQxw45+OdOiM7Eunlh0kqgnx?=
 =?us-ascii?Q?rTypaIGJ+epaggYpG5f82PpgfOAO8gy0bWFn0cwIRV8q3L4NpoPJSFPp3z5Q?=
 =?us-ascii?Q?t8ewFGW+fgdK5cC+g+53mKBgTVCUkUODJ4LT0KbSbihKpRxgWLtlV5OXzSfF?=
 =?us-ascii?Q?2vIX4a0MScCgsgLhek/THGuHDyNjTgYZSLfmH+FYayHj/pGa?=
X-Exchange-RoutingPolicyChecked:
	fiiAqlaGux04bq449emiP7ZPSt+ugCIxhLKhr8/g3Dvb6jYQ/1LEkdN42e3B8rOT/fD0ryEsnskOYpP1vtaJeRlgmlios2dckZnvDZ2eQ9P4J73fnggsgUNp1nh/TPfcktXZiHQ66FGE8cGew/FUwbzBz3LHndl8wcs57E7HKM7U0ROj9OhNjg06T7sz5E1O5OxIuO6lhE1DBfuHExAqHc0s2UhAJumGubrvGN9ErNgM7N+Y/InlIHDO4+aLreOQiG6sDaT5g+SoDAS7TsPH1+W2/0NqgX/+S40IKyiOYSEsEUm2awYSNFI0/vxD++obHBMO2NJtTjf5DjQkiXc8pQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e977ab48-3edc-4d75-1ca2-08defb904d87
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4139.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 12:17:12.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4qid6sFYJIVGOqymgnqiGhwHYm62AgQP/DRBSy2km9u0bHQCqOkgwpzlIoZo+IF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-BESS-ID: 1786882635-111888-7724-2186-1
X-BESS-VER: 2019.1_20260804.2006
X-BESS-Apparent-Source-IP: 40.93.198.120
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGZsZAVgZQ0Mgs2dg8NTkpxT
	I5ydzE0twg1TQ11SzRyDDR0DLJ0NJCqTYWALVKrlZBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.275424 [from 
	cloudscan21-75.us-east-2b.ess.aws.cudaops.com]
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
assert/de-assert signal reflecting the DTR line.  The core raises DTR/RTS
on first open of any AT port whose driver implements ->dtr_rts and drops
them on last close, mirroring TTY semantics.  at_data.mdmbits is
serialised under data_lock; the ->dtr_rts call is made after releasing
data_lock and re-acquiring ops_lock so that it is serialised against port
removal.

Patch 2 enables the IP_CTRL MHI channel in the Sierra PCI table so that
the IP_CTRL driver (patch 3) is actually bound on those controllers.

Patch 3 adds a second mhi_driver that binds the IP_CTRL channel and
registers a ->dtr_rts op so that the wwan core's open/close DTR raise/drop
and userspace TIOCMSET calls both reach the modem.  The existing AT/QMI/MBIM
data path is untouched.

v3: https://lore.kernel.org/netdev/20260807215042.2714442-1-peter.hunt@opengear.com/

v4:
- Protect at_data.mdmbits in wwan_port_op_start/stop under data_lock
- Release data_lock and acquire ops_lock with a NULL check before calling
  ->dtr_rts from the ioctl path, preventing NULL deref and use-after-free
  on port removal
- Gate ioctl ->dtr_rts on WWAN_PORT_AT to match open/close behaviour
- Reduce TIOCM boolean to TIOCM_DTR only (DTR governs URC gating; RTS is
  tracked in mdmbits but driven together with DTR on open/close)
- Add dev_dbg when IP_CTRL is not enumerated and when mhi_queue_buf fails
- Reword forward reference in patch 2 commit message

Peter Hunt (3):
  net: wwan: core: propagate modem control signals to port drivers
  bus: mhi: host: pci_generic: enumerate IP_CTRL channel for Sierra
    EM919x/EM929x
  net: wwan: mhi_wwan_ctrl: drive DTR/RTS via the IP_CTRL channel

 drivers/bus/mhi/host/pci_generic.c |   2 +
 drivers/net/wwan/mhi_wwan_ctrl.c   | 178 ++++++++++++++++++++++++++++-
 drivers/net/wwan/wwan_core.c       |  31 ++++-
 include/linux/wwan.h               |   3 +
 4 files changed, 212 insertions(+), 2 deletions(-)

-- 
2.43.0

