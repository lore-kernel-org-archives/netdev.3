Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041C4E01E1;
	Wed,  7 Oct 2026 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397420; cv=fail; b=XgAjJ5NAaDB5DGEPxNVLR0AOUtqq33HL6PnGXo3/9xuZ8vMUv8C8X1RkJcGhzLKssJggIiNhb48bLOHzK14EhIjczsKIOcdkNeLvBgoDm2u6V3bBH/WWsZrRU9E4fms6U34Zg+FLowQKtwI+piMGAOBs86vvqYYjGxJJHCbU5Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397420; c=relaxed/simple;
	bh=remErAr2D6WHA1qvLu6xKv8BMOaWojhWjrFyWN8HXNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oHW6eUJpXQmWJjKb19pNCXGTjlMSJ4hnJSv2O+ICZ+kq11DdtyFAHhdH66mUs5JH4gYbesSdjX+AD+JnPed2Q/clpqU4uAXROKGVF0QWSJHyBjg6VWElh+xpQSvfluWN0Q9MFdDPFNfOU3D6wTC1qGWPJ7oZVNXoZFnGS9OHJVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=eCgh1bNu; arc=fail smtp.client-ip=209.222.82.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="eCgh1bNu"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021127.outbound.protection.outlook.com [52.101.57.127]) by mx-outbound21-220.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 07 Oct 2026 18:23:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxypSwFOZzw56eQiMOgNGDLmyK8TLifXsNfQ/H31m1zmfwcEito3af2uMjcgymF4YT5h7k1hvJtdNNpExDh6Go43B+dyeEvV+TkFoxqFxyxs0y0HnjNOwAHSYoVt0V6xvD+iucwkgnBCieVfEU4Wxg1C2bmztTSRO8rUCNf5R2vLgGE9oao/3anust/3cCewnju2OwWNZuZmszeVgawnbNaQr5c8AzXHUxEwgkHRET6GqZIwp4Lp+hZw0WITlQ0hBIfTZnJp2r+5QZZC8SQUCtpts3pl1U5NnIK/VoVbEVXVD+5h7Hq3CErZg+Pr7RoJG6f8BF+llo/yxPQwCGz5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGa6bKQdXkYyhkrfB/M6eZx4meiGUWPlzJHJN8maNWI=;
 b=r45OuYxty05MUI2P//zSNEhv/zYk7CXXIByjYoG0idvbJRz6xAPPiIC4Ko0UZlSos5R/jy1yIUGg7dU8/PyvMLPFJJQ0YU6jEilYVtTkdlyoSS9IR9kdcqbheMENn5w9tofPlcdnwKCMwg/+kHKNTKsTmFvcfFzbHb/Hj8lTX2HztRPFm1AJ+q05aM4R4NQEohKL/lfWtyzzLtazkAZE9Nc98m4DW61mngD3hlxmsdkmkXGtwlmpeI3ygG5HW2/NdVBrVWCazqFIoqkuE/1NBeajb8U8MaoWdJIp46m7XO1Zr8rvhaeyyhohvD0Rpa8VfZkg1G4Avj+pwGGEZVFyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGa6bKQdXkYyhkrfB/M6eZx4meiGUWPlzJHJN8maNWI=;
 b=eCgh1bNuSKUa+mXDzsmVSccnnN1SC8mSqyUU3gaGszIlmaS2BInVuhxIki4SvTAmARl4UbliNZkPEdFJI/ET90VbV2YhABWKeO/Jp0RziWpZmhuHmLLJELoZEIwyZ438WDlWepcIHUix1f7Zblx4G+KNR+q+TyNggB2qxeM+wE6v7zsFJaOUHMEpmnGIWqVW3yYW/cEjNO4grsE+FRvjyot3QANyGt7dyj+D/WA0pxDXuQtNfvAmAIRm0ar2DAMFq7NTABQ+EVL3iwmZ4aLbNBRiwlkxcKo0siDOEKCdGLBBh3VtcCORaepYpXzVhIitBTuuAiTX5FeftVE5PyRIuQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by CY5PR10MB6142.namprd10.prod.outlook.com
 (2603:10b6:930:36::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Wed, 7 Oct 2026
 18:22:44 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 18:22:44 +0000
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
Subject: [PATCH net-next v8 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Wed,  7 Oct 2026 12:22:37 -0600
Message-ID: <20261007182238.1154851-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007182238.1154851-1-peter.hunt@opengear.com>
References: <20261007182238.1154851-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|CY5PR10MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: a150988b-cc57-4b8b-6244-08df249ffa81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|18002099003|22082099003|11063799006|6133799003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6INI1dhr+ZR3ZmCeS0DekAHtTUV7rzKwitMvrUan3a/MgC6RjZMeevoIgzUA9D80DMQ4cb56KQnaGATF+TtzcdYjuP250r+0382DGHdvtw5wlLEG0g5S52gpQsgHJ/cJm/HqoOrNqA5Sx+yvI1jQ8EyWSUh/HPB1GLZTGjsGiWfP0uo4Ah1U7jT7Le0UZXQPvSgCCiga95sYEvcuwFQV8oNTzUI0PouYqaNwUhNiRX8gCZ0v6XG2dDLIzKvDnB2e9JS4Tpn8skOXqqhDc3T/ctOQfHWnHLYxeAZo1CXFX017XUW85Uzs5CVzUuBmhRx/CIIPqvz/ETBe7QUQb9Fjq4p2YIT9wuFL1Y0Z817+Ir8qoQHuhaJYCQBUk97ifCysnvHJNUB3/ksb++ulO9ta5fqhxKD0vjwNfeH4u2f2vNA9CgCvg+mzgrM1LmJvr6EOlDVVb7EZxpT0cYbphkBZ3PJX7Mf8UaLpMZJhxMM2oCFoIlkTiXL5ms9cvAK8WqiLq8JzXR/vHVz1x17Ag0udUxnFAyGQNYWOOypA2FDxj+UZpbGxOCCOtDKQUMgrdyUtERZFF1s/uYaLdbWLNnW7KMTvoYBNSb9StQrMEOSttYg4reMqrmNoxbL1zkDnA0yICNnxJi3IUbD4nosDna5H0X6zVk11X8CPEsY1W3xa4hY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(18002099003)(22082099003)(11063799006)(6133799003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rxy92bKAnfxXa8C5deakdlf8BECArk9tI90Nvf5h1tRPDCrQoB0zKRy5s6Cw?=
 =?us-ascii?Q?mvESsPhnf1hLJoM7Tx1hkRDKOcy5klvW4WMCTzCQyhFe/8MIOJXChfXzYlXW?=
 =?us-ascii?Q?ewhL8l8foc+Dr52xUaRlsoWfb5rMZnFkITcuk0Wy/WM0d3nWlB+eoap4CrpW?=
 =?us-ascii?Q?KjCklk9D70lX5u9Y0hbw5hGQ4+lH8Gt7tU2Egy9MsVPwp11K5vgF4cEhpGXA?=
 =?us-ascii?Q?SmFHzBx2DGlE5DA4GdbLi+rOW0cxQ3SMW1lNfpo9VN13QiP+TA4Jz1KU+1rr?=
 =?us-ascii?Q?6slSPjFVDfVqt31c0CwiKDlyG3v330x5pCmd2pZopcXsoKiVoBigVLBggr0f?=
 =?us-ascii?Q?sGbtEry0N7GVRLSdvP0RRu31OJlsiKPRjzuU8OpPEetv4YzcSjM1Y9wiP7eF?=
 =?us-ascii?Q?nOwKZkvGqS/0bfq4vbThwa/hhTxks1fcxEIT+xznyRci8XLshRzsTcw1UiG3?=
 =?us-ascii?Q?jLSGI2VDOwE1GFzTRerIBgj2mcQ43r8CfNbpaVdfX4i3X0ylMcYL7Td6gLfd?=
 =?us-ascii?Q?fwxyUKGs4P6riThkvT4DBEn3hFNaG7WaTcZVtNUyk+g5FxLU5dZgpRZ3P1rD?=
 =?us-ascii?Q?IjTjPFoIUch8FsD1YVTyWUg4xS/h61sTQOYbbTLgeeJz0EDNDW7CJogtQO6L?=
 =?us-ascii?Q?Sx5hflfvsyy4kfQrUuxjhF+9fU8iKbiU/WvfFiQgTLd7WKGF+8TBnpWflmNn?=
 =?us-ascii?Q?s8Y8JTjFlkwbt6duGvVruHCdbBtAfttz34GGYbyc5TOS6Q1Vo5S5FrDhe8zz?=
 =?us-ascii?Q?c2RgVkMCEHFGIaO22opKgsu6pmDrb2O5v20Rn6XnltDMUkYVOSsDTEm9+Nqe?=
 =?us-ascii?Q?1agy3YDWSSn0z7I6nAeqsBiIZ6vfbT3uupRM0h7hgkD1sNKRsas5ijIrnreo?=
 =?us-ascii?Q?Eb/R5gOXEFLRk51BIMJKuTdMdHe2eOhTw928Dw0EGU17/5kZ7eDH2VVlscYQ?=
 =?us-ascii?Q?g/JzhNH5VXVvBeDZsYdRe0kHJqR/6g19tBjUZ0PLvHCHViVaFdfPg1vrA0nj?=
 =?us-ascii?Q?Dh2qV67uZqO1bhYKaOgjvOHZZMFFYiEGQSJmFDlc2rGnzQPNIo4WS8Y7kGpE?=
 =?us-ascii?Q?IPp9n+pN4bOoeHFX9/n0RSrkvG/9/EQTpO64jp0+OUdQN1cGvQjooXagkU6b?=
 =?us-ascii?Q?xlTvFXK9fgBNqZnTvnzVO6vBcHSXra06MZcsIoZgNhHBcwBSKga0XG8wblWi?=
 =?us-ascii?Q?F+zvmCqPQTxSTeE2U2dhTRo4n7FgGI2FsbHS4t4RB9T3qtUMCXLiW6/ZkjKO?=
 =?us-ascii?Q?k1J+VBqhTRx7RkjUcqFgwEpo5PYaz56tKIC61hxKCZAuzw91IwDKip+fM+12?=
 =?us-ascii?Q?8KplMkdCX4B9MYhAcGEsy5HhnVapchmBS5bbHzuJgqX/u5C1D7UpUPrHqML/?=
 =?us-ascii?Q?1k+9Q5p0EeyaL+Z9piHDL2uX9+MjBfPSXEQ36caP+1sNtwGPpFKpRpcLAiyh?=
 =?us-ascii?Q?DhI3XiG6Vx9hKOein33jzEMA4rQphreqE6oQrCCwI5MvuA/xjO2xJP9cQa9W?=
 =?us-ascii?Q?AZV5kwMdK+513tgnzAQhpsNl9ER4LIUUCtqnTomD0HUyKNWahjxB8zaBDPqd?=
 =?us-ascii?Q?25Tgb71fe5GHh4s/QSUovBSbD+GNa3ZY1dv1bG6BUlCv+m8yP+ZnXMi2m1lD?=
 =?us-ascii?Q?C2LQcD45U/IBJS/4qY5CjCARvPbwct/nLNSLBYlypBRoGW6fNpNRNNixmGvR?=
 =?us-ascii?Q?8pn88aCnnDXFKDwX/6gb1cVmAAHJgvAdxlZp2PbrIvHj3hE8?=
X-Exchange-RoutingPolicyChecked:
	30o9amQ8kXIbWd1qnHoeEZ/3NM2GmHiSbJsxGTcMQXiy5zBPLQ2V9RkMXFKQZkWId9Y0Ocb7QEeZTeqKY43sTT5166ZNcdiGcLoaFBjBjZlbEPQ/yNLnIMM8xQPWEY/t0VwelGPX4XSgDKmM804C8u0U/WpMBQ32wwszF4einCmHDYzEhhpR6astEmjeLJFxGDr1CdzwSRNEDWjsDSOHl2RPu13+PwWTJa+kajtY+GaIib4lTCRXOKu5FO2foJF7fTmtdUh/u+c8YuQNp6C/bx6gUMu1WzSwJplAVGdXXi8HkzyVPsN0vqz2ojRJCC4MiFFK1FYzdNBB5DYq2gYfnQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a150988b-cc57-4b8b-6244-08df249ffa81
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 18:22:43.2823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pnmIO+9ihv6ZvRdqhlhJjLAzyiE/DaysFyal9ZFZsdQtBsBFB1XrHdNsHnAOLt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6142
X-BESS-ID: 1791397404-105596-9031-19931-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 52.101.57.127
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhZGFkZAVgZQMMnQ3NA40cLY3C
	LF3DQtKS3NxCw5zcjS0DjJINXIPNVSqTYWAEZTHS5BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276674 [from 
	cloudscan12-9.us-east-2a.ess.aws.cudaops.com]
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
away. The raise and drop paths go through two small helpers, which do
the AT port and ->dtr_rts checks and pass the driver the resulting
bitmask.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v8: Add wwan_port_raise_dtr_rts() as the counterpart of
    wwan_port_drop_dtr_rts() and move the open-path handling there, move
    the AT port and ->dtr_rts checks into both helpers, use
    scoped_guard() for data_lock (Loic Poulain)
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
 drivers/net/wwan/wwan_core.c | 69 ++++++++++++++++++++++++++++++++++--
 include/linux/wwan.h         |  3 ++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..4206649d4b45 100644
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
@@ -679,12 +683,52 @@ struct wwan_port *wwan_create_port(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(wwan_create_port);
 
+/* Raise DTR/RTS on first open of an AT port, as a TTY does. Called with
+ * ops_lock held.
+ */
+static void wwan_port_raise_dtr_rts(struct wwan_port *port)
+{
+	unsigned int bits;
+
+	if (port->type != WWAN_PORT_AT || !port->ops->dtr_rts)
+		return;
+
+	scoped_guard(mutex, &port->data_lock) {
+		port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
+		bits = port->at_data.mdmbits;
+	}
+
+	port->ops->dtr_rts(port, bits);
+}
+
+/* Drop DTR/RTS on an AT port. Called with ops_lock held. On last close
+ * the lines are only dropped if HUPCL is set, as for a TTY, on port
+ * removal they are always dropped.
+ */
+static void wwan_port_drop_dtr_rts(struct wwan_port *port, bool hupcl_only)
+{
+	unsigned int bits;
+
+	if (port->type != WWAN_PORT_AT || !port->ops->dtr_rts)
+		return;
+
+	scoped_guard(mutex, &port->data_lock) {
+		if (hupcl_only && !(port->at_data.termios.c_cflag & HUPCL))
+			return;
+		port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+		bits = port->at_data.mdmbits;
+	}
+
+	port->ops->dtr_rts(port, bits);
+}
+
 void wwan_remove_port(struct wwan_port *port)
 {
 	struct wwan_device *wwandev = to_wwan_dev(port->dev.parent);
 
 	mutex_lock(&port->ops_lock);
 	if (port->start_count) {
+		wwan_port_drop_dtr_rts(port, false);
 		port->ops->stop(port);
 		port->start_count = 0;
 	}
@@ -759,8 +803,11 @@ static int wwan_port_op_start(struct wwan_port *port)
 	if (!port->start_count)
 		ret = port->ops->start(port);
 
-	if (!ret)
+	if (!ret) {
 		port->start_count++;
+		if (port->start_count == 1)
+			wwan_port_raise_dtr_rts(port);
+	}
 
 out_unlock:
 	mutex_unlock(&port->ops_lock);
@@ -773,8 +820,10 @@ static void wwan_port_op_stop(struct wwan_port *port)
 	mutex_lock(&port->ops_lock);
 	port->start_count--;
 	if (!port->start_count) {
-		if (port->ops)
+		if (port->ops) {
+			wwan_port_drop_dtr_rts(port, true);
 			port->ops->stop(port);
+		}
 		skb_queue_purge(&port->rxq);
 		clear_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
 	}
@@ -980,6 +1029,7 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 				    unsigned long arg)
 {
 	int ret = 0;
+	bool call_dtr_rts = false;
 
 	mutex_lock(&port->data_lock);
 
@@ -1036,6 +1086,8 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 			port->at_data.mdmbits |= mdmbits;
 		else
 			port->at_data.mdmbits = mdmbits;
+		if (port->type == WWAN_PORT_AT)
+			call_dtr_rts = true;
 		break;
 	}
 
@@ -1061,6 +1113,19 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 
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

