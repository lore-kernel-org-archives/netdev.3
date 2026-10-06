Received: from outbound-ip199a.ess.barracuda.com (outbound-ip199a.ess.barracuda.com [209.222.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C6346766;
	Tue,  6 Oct 2026 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259499; cv=fail; b=pMcImqmyBYe5czE7vvqauIJ256DfbI4e45LJ7vTXi1Zsf0eZhhXqiRonFLlsQfD1v4yOQ8eZRMPcwU5Fzwz4DYVC4JNFwy3iFxCAZ+pkJKIpevKdj5QTgvcF3aJyhkLb4lDYSbQb/GVbR+HR0h3jbHNP5iIjzEfRCTMRfmsGa/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259499; c=relaxed/simple;
	bh=zYKn0SXC2so7GNB7C7580A+HlwR1VkNCIwtBSCFP4M0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XI9dltp4ruoNpU+xpzb/T8tQgIDQOr0nVGaadp5LN+FhS/E6Y0E74ZL7SG/H+81WdydSBdmWAoUXK1JbCPpfJv7QCJGc2cUcziPgIAaNeFv4eDwj/cZjGt6YCXOSSxfXrThubqqWNVZI+9m/7FSB7NIDLRea6alRKJUnIDtByUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=cU8STJBd; arc=fail smtp.client-ip=209.222.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="cU8STJBd"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020083.outbound.protection.outlook.com [40.93.198.83]) by mx-outbound12-109.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 06 Oct 2026 04:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ID9p6PJI+VCynCCdYMTP/fQDBMX+ZqZECZaM+9ZjvZHIdFGf28U8hWgLFUYePonG4VBp8be9rA6M6W4pegBXWw67e8e8gmOj0mYe6fk6YUsnvV8FTMos9T8e9lyAiwij595HXV1eu8B8q0R+J39vHRNddG1QPxcU/pUeEM4JFCaHmIBRdtwteqoj0YlrGwL7uyCKgHtPrOatpT2XYvVJ/v+ddcTeJqjzRr0DcXK3kW2CBN8f/OZr1I3HqPoqhZpxykIRdBnKI56APpkJrNcWw+mXcmFe5IoHAluuxDWnqOdhSuoqQjIDwgdOeeBWBeDzOFnflAx8LLIoLgGfwdWqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+kVPvYN/wwh4uldV66CeG2rX7LAeQCUfM4kIEduqu4=;
 b=uxbmSbWRb886TUPXRgzk3b7bd5qS1MM8Pbrw0ktfl+p3C7lZtPi1C60OFoxEo8tCWKYFRrjvB3RJwfWNBReOWbxrgLa6sMZA85sIZWzUHOxE9Gz2MRRjbv/8MNeMaWCbOUlD/BLnmDqMuI2jPpoLgtih5gGhd73A5zZ1RkYA+47oufWWbsanQVTrxqnrkhMC0uRbBF5WRyM3f0K7RnZVkErQ8W8y0oKXGmnCpRsqeotcSIcFUYpqBT5UzF+Ipr+T05smIGxKtNyuockO0tEBzvdWeNnp+3Kk76RCMeplsP4BoS0JO6TWzzLbbqT3ebMstwU2+q9OhwZYEilqrzPciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+kVPvYN/wwh4uldV66CeG2rX7LAeQCUfM4kIEduqu4=;
 b=cU8STJBdG90O7ewMGYDY3VurMzM/E3TvnOEp3J3DNgwb5Ga6cAeqoflQ0HdND0Z37p48A7mAOzQ8FsYbytYysrma6aoZDfJWYk1qqPF1iEvCelanz9SyKOEEv09bSPRb2KVCETkoThWjm53Mu82lWez1ckgkRwZkPgvnW3uWY/l2q6I/9PNjS/0zbBYij20lNY8mJHH71dew+dSaYy2rVjYgQT51RzmcP0q/shwJmvj3ljAxWvFV7SsaAubFuqhTagHLlo+fcOVQrcmUPBZvRIRP337wY4hZLqhQrbKbfpYRBznVe1ojgXnmdhvYaW1HO3U5p6fVfldoEjVXGxLu1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SJ5PPF1849371D1.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::78e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 04:04:25 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 04:04:25 +0000
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
Subject: [PATCH net-next v7 0/2] net: wwan: support DTR/RTS on AT ports via MHI IP_CTRL
Date: Mon,  5 Oct 2026 22:04:20 -0600
Message-ID: <20261006040422.3208888-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SJ5PPF1849371D1:EE_
X-MS-Office365-Filtering-Correlation-Id: da16775e-cd96-496e-f50a-08df235ee8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|11063799006|56012099006|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qI6DIqa03560y+apXXSKeET0Pp6wKVA8gD7WaO4Yjfd83q1e305jjn0U6CmyYwe2oCKOPX9u++rZIJ2B4B+QpUbU/fy7PdR8Ui5leowY48OoELLBYagRs0NR0iacuk0Dj3hK0sy/l36od8QA5Akbua/I7leSKUJE11Dmhrb19LVsYPYfCIApmLanxwu1mVZXieEz7VPLuwwYoZygKXuZ23mhjAzYwuhAjzGQzl0lEROlBZ/5cBGJUCQbI7GQhasr4PVFOSrJqkx8LP4/7wMQefWjM2gY0nJDWQ1URrBwfOnDVDYE/rB+NF4pJfByv5eIUbSzl2wnelrkzXZoEXUiSrBdIAjQkH2h22Q4lBFnga5L0LDbnFE+ZB5U8Z0G28AsPQ+no9v93u3eAgQAQW6gLqiyTmD65jp/7vkRpuf//psZk5Rhb3dBtKQEwVYceECZ2Mst18ZW65cv4ixHPqFFlaxhnJeYSPlueSzFLt4rd+CYfuZf2sih/KUhyvr9+nwYP7y2BI6Q+xsMqUV2EWJ3ct1BqOYAft3JfObotQYIEwjK8DTxnI9o/qbNX8AYnQV9VGst7hTIYJdlaXPepf8N70LQGt6QJXt63y38vm2J1mwWMHqRpMu5xcm+Cn4DgcESKDTQ6AG53rCPIwj3qlCr00cJt/jLge5ARcWR9ZdHaS4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cKFckRx3xVHqlDA4qLp0ArcIfODLOBza5kjPpJlTqwffdgz8eIGG+RK5bM/3?=
 =?us-ascii?Q?ex+v465h8Ls0A+rmpYfdIFBJPJw8Hpk72YQPRpU3SxD7IJWgDMHDii77Twv0?=
 =?us-ascii?Q?tlHpywD2/+2MMLXkuhN3zYN2fUZ48qGHPbWntvQ4Mk7VD+mAXGwfPfFONlPm?=
 =?us-ascii?Q?FtFgaswOHz4/ihCBQY3XySanw31ChaNTL7ma47kscbMtG8KsITLBpl43Pc4K?=
 =?us-ascii?Q?UrzalqR2Y6hLb2ina2hkDRM7Wwed+LlyhlrF5am5HmzCZWMJTLVDEOYKzY4W?=
 =?us-ascii?Q?OqiyT5vcYH+xAgatAOeJLbT3JxKtdfY445i6VC5xDetCnEgdNfTotYuqvKc3?=
 =?us-ascii?Q?B0epzjtGyv+Dw5IIN8nvJLCWaynJXsZ/PgHg7pSbECSY3Z2coYd+TbH7/6Qs?=
 =?us-ascii?Q?7O8ht1wj3H3NyhYy6Ptv738H6HW2aYr+wkFEjafOut6zZs84zf1HXO0hFcIi?=
 =?us-ascii?Q?Mz+iJbfRxQXP2lE/JJ3kVwz3Pk+zkDzibsUkPYdQ4GNemqGjeS7j4bTjBClE?=
 =?us-ascii?Q?LUuGVpGZOoEvKTMMn7e2NVpKHd36fAz9FwMBL9UcoieL3FaLq5cfS2W23HPv?=
 =?us-ascii?Q?Vclo36up8+hQgm9Pgcg5Mrq0VlXFIFltFnFDjp/IQ8op7i6PFsu3NxSrZxHc?=
 =?us-ascii?Q?kyuQvyT3v10tqF7L+Jn23yMmnxg9zuKygAzoqJBpoERmHBLytb0YAGtRzQs4?=
 =?us-ascii?Q?U1wlbBNeUnRyQb1c2svxag5WnruE7q4sH3m31WcMQ/nlix1fL344fFacBfEQ?=
 =?us-ascii?Q?58Bq2KvWz2NIl46Ojstqt+b9AFjG59FPFRwo6I4eK6hnP1tZwro5YfCnVv8p?=
 =?us-ascii?Q?4u/mhvzok+fGiEPX1nKxomDgbNLarzMtRtewNarHuOtsbqAFjjMtyOEqY4WF?=
 =?us-ascii?Q?eZzRt25m22xNLpeQTJWOyD4cDEfv0qw2MLEfTpHKCjmg4aMWZUVBneiqq/mg?=
 =?us-ascii?Q?wfSSRwY/5Ep+ozTD9EaafPaljl/SETB5mewIeu5+gpiuaT1746MypX6JkgCm?=
 =?us-ascii?Q?Vxd1FbzQ7B5Fg2/AMq5n6AGqsFBkDMm9f2sLBZnds6cqDIrZJPFYH09rGHdM?=
 =?us-ascii?Q?09l/I0OoFbaRBXlhYtzqmLl6hdK6Qva/hmAeY7iaQdEY7jEHgAxvBKEduj3W?=
 =?us-ascii?Q?AE/PrJgDIJIXp4EYGjU2ndcK4NtuOHY6t2bsxKzVcrz+ybYnMsWLzucu+6Pp?=
 =?us-ascii?Q?qMHUVraPKOFgLnVS4BMW8z1CFEaWIizm40JABglMeSG2dk0QU8Ut1ykjPHbM?=
 =?us-ascii?Q?gqwiwqLXkOsx1zL2kO0M0QsVjllaEnv4GwkhHiLmEkCasM5MBwAZfREreHNK?=
 =?us-ascii?Q?xxk+fLKsP8E4nPq2RujZkiBpHoApH9JF3ZW4dfoAqTIZwH25Qx4KDZNCYfNR?=
 =?us-ascii?Q?+4/K1izXAt2yIlQE/NfsCBXS8kmtjCjo+/PkZ6n39VUHdsMoNtUEUG9qCG3Z?=
 =?us-ascii?Q?dzTUAFn28SSmdeb6qeU8wweEsLfk2/GjYDcZROnuPOJgvFbBjQIHR6Ts9hXV?=
 =?us-ascii?Q?8+xZeiRao9K/Aj1h+M87BgsWFdh24cFTB1+0JHophEpBNZ4jsaoVN1yyjBVx?=
 =?us-ascii?Q?MgzjZ7qxTlHJ3HXT8IdA49eReKZNODuVCjUI8bwOYSbxjGpzrdwX62RSurX+?=
 =?us-ascii?Q?kDl+NczFvYSPj6DRbGZqSjfRj+uSwJ8MRMZWrF3YtKktG36Xm9JX/nZuiEbq?=
 =?us-ascii?Q?xqW7dv6cN07vKTl7p4zFM6Xwdso7L7yBAtHKCMimu1W5T48A?=
X-Exchange-RoutingPolicyChecked:
	2jeoHGKdwTHyVPDEpBcyLTRDE0WWCJV9lLXWt5qoHFi3xJql34l9Fj0N44j0ksJ38IGZydShTC9qX42SPOAa4UUu9yGtn+dB+w89yJ93haLBv9y/IlA6yK9NJcKO7S3Did5g27+0KaugFhIK2AZKDdvV6BeTA1f9Egmjcce6ipiDq/vmLzM8REIB1XfXavOmcd3VUaDGpZtfF7gFwj5xTcpAtwJspoOI2wbi1jwYQYx8hKo4qsn6ZKIpB20NbjdHY5p6c5WNCJt8/+TapR7QXBMMaKy3A5Ne0JYYIfk2kL0e3hxwAbTj3T6TAZkfSZKG/pLG7UaRDtkZJlZTCs1xTw==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da16775e-cd96-496e-f50a-08df235ee8f0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:04:25.3276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcwkF6p/MPFxcDOBpilwYyG4K4eYxLIfwC7nukNDfM+I1Li8vW2jKnvT9G475o77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1849371D1
X-BESS-ID: 1791259467-103181-25096-35818-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.93.198.83
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZGRpZAVgZQ0DjFIjnZ0sQ8zd
	LIMDXRMjXVMsnU0NAszSDJItE0zSBFqTYWAIlrVmhBAAAA
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276636 [from 
	cloudscan8-37.us-east-2a.ess.aws.cudaops.com]
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
 drivers/net/wwan/wwan_core.c     |  61 +++++++-
 include/linux/wwan.h             |   3 +
 3 files changed, 301 insertions(+), 2 deletions(-)

-- 
2.43.0

