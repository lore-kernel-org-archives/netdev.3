Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA904BA1CE;
	Mon, 12 Oct 2026 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791825801; cv=fail; b=ftgRQlUhe4dtXAyoppDtj3ZeAwHe5yfVLHTmQoFjwS1jxrzfCog8qEmsLlvr2ytZDFy0Dy+CvUXJds3Ojw+tQmDxrIo+JHFwH5uQOzSMvi7CrKndL+x6MB+o2HyrLuLLxtj8L6gVBptR5EBcLm8gYnVPdHbTBQE364ULrODn8Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791825801; c=relaxed/simple;
	bh=Px30mzEvv85G8gP2GSLLNGkuqdM18CrRAGgiCZZuumc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pvth5/joDgOvvBz7BnewHetkTcSt2PpttvcnrfrU1FZPymy2+yjPENzexEAW1l95IYVtqpTp+A1QMRoKxhAZxYW1IOJ7yEdUyyRzjCsxxuqTX5eCs2tWr4tCF/VoiyrqvcFTPe6A7wsCN5G/UPLUO9ohv2Cfadt1xG1OeivFbuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=rZTYB276; arc=fail smtp.client-ip=209.222.82.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="rZTYB276"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022127.outbound.protection.outlook.com [40.107.209.127]) by mx-outbound43-229.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 12 Oct 2026 17:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2CkWW0hIMiLqO3v9aQrPtp6K08VCDhSxexycISg4JhSTW0gqI3PqW+f5dQU21JF1tpbHdxC4NB7WyLxkvyhcpF1HbPNjglrd9cZCvfBvgw3axC97kxCDDr8euew7lAzGX0/YFt1x2+nK8BxGsPW7j/LdScWWmX1PRmXpyfyUmgJ1+DUOWRMBz/mVMBz+s4/jwQgQRHRjz5hdO3c95kCZOhWToCdBtyYcyGfUMGX4xn/aFOIOWs9Jjo9DgMlcXjaawa/RkH2mwIyCchtUvzLUqIcOi7YCG8SH6LouZT7QZ2jlqJMRpMVcE5/4/+sknr0JrQDIcwVZNpsFriRerZc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDFYaLBuaKxkwhLxU57A15x6Ktd65vjHwwszbL8G52w=;
 b=Yb1+m521l4fG1+BP41SrRkeFG4eLk4aZnLdhdA0ULogj0ZKE5QCp8PaWfe05fgpBHm07+1FxGIEMcBZ3FtNGwGNfoVTEOtsvZtf/hVeXG7Lvz3K+obTfQPAGxKiqtRcDB2zbhdEzhwrp3V+OY2TnxAOSd/DlfIJfTpxtGhauRlBrjQO1RAh0vFzpd1AF+3SVU7KGZA33I4gwd3tDze7Ms0qt3BuqSuRzg+cgH/8JphHJb33jzhzp75EByETnzDXT7B9qmN0q+Xjb6/tDsBzcMPDHfqjIwNrwKQT1+4IdajAeB73W49kRjd0RYOEkp9d0Sbe2JtoMaXwBwEh9WOoPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDFYaLBuaKxkwhLxU57A15x6Ktd65vjHwwszbL8G52w=;
 b=rZTYB2766iBEkPUfUpUmqyyeoK21jIjHUx4a+nKEDeGx7VHeEjm+/kJgP8CMRNROFX13yj8Icir+yYHZfQbLakRpz+1jay4BOFKE4RW6cEUxotkySJxA6EMGkske+bDmjaiYLfREPTSwMBiO9UwAjUyBaKaLODltpVQWU6uB3dI7dUeanMcGR4cMpuKDeZrN7mNScFxuGEza4ZBi9jDgtPVSxm9AS5YGIgCtY77IcUlYaJLZPHRzbli0pL8S4XCThXpr2UaJji2MKvwle2dWGq+pLzvSLer/4XZlRJJIUgVpKBieA680Eob9oC+V8QDDquI0z5RAY7Y67odC4bqOBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by SJ0PR10MB5669.namprd10.prod.outlook.com
 (2603:10b6:a03:3ec::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.8; Mon, 12 Oct
 2026 17:22:26 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Mon, 12 Oct 2026
 17:22:26 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com
Cc: Daniele Palmas <dnlplm@gmail.com>,
	johannes@sipsolutions.net,
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
Subject: [PATCH net-next v9 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Mon, 12 Oct 2026 11:22:18 -0600
Message-ID: <20261012172219.3668624-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012172219.3668624-1-peter.hunt@opengear.com>
References: <20261012172219.3668624-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|SJ0PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f632d35-a6ea-4456-ed02-08df288562c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|261009223027099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	OjSwA4p0cv2wEXDyiq0CGMSh5J6x/biwnp0VubEn2R4qEJQEscd0DQnuKYE6ydS/Yb5sxkgmu/8gwq9IoO/AA8m4x9T4W4m1n7H7rE5Oo3SaX0P0LBq2gHU2leWpk8t5ktD9tIUP5fbCJWtY76tLxDulUDD+OpL73qToaeyMfXQ2FYnwmapEiWqoL1ifKAKVL5jEOdOj7YmBv7cBJknOZpf4k0D4Ss4/SbZN7Ed8oHJhDZNyYLLLV4SGiNT8t5V5RIGDqOa90iuRbpREHG3QxiZGkFgR8Yesdxzipf1kSd73ztNupiGU2itEsn9gMBx6jBNcSYwGKJL14TFQXlWCG7euEmBigh4qNPc4X94G66xrZKzOJInibJefuiWD1P6n2dw8MDfs8m6LV44Q375fru4o/1PO39c1NOChqyfIX123ZfrzjxuSfJUVHJ7wTv6v3QRXOPQq/OutZhjJ2hYt0cm928PP4dT5tG7M94g9EJV5/43fxuzjxtjrHiAO/3OYGvsJQ461aJRto8GW84wLkXa7JwAHexBJO9rnAviUXebzU+7gBImb6VojUIA5ht5jwSstvBnnN8xP1jC27pF7hImFw3FylNQpEXgzdPmuwbq4t+CXHoZ+bWdf3SveiNNztkBrCiVYNItYhC1VN2uCBcsBiMuSrEbov15gpp9tf/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pJAHJy4G2sOWVc7jyGNq8xuOem7QrT+K/vH/EsgKXVXOlltLZ40fSLAPkYH2?=
 =?us-ascii?Q?eayevWeuQOTUC+khSPlMAlBFNZuOWirMLIXY82kHpiEEow5nCzgc8AZuqLnw?=
 =?us-ascii?Q?HccZcZ9dx6d32W3MIDIkfZgpz1RYkny7vyQtgyODoqM6xstmAax6SKLFNhal?=
 =?us-ascii?Q?wu4eS0wi+06yfDboivwGKjMK38/k76bdonTgvlIXMeoZ8bYW97zFtGRRusBO?=
 =?us-ascii?Q?yU5eLTrCV7Jx+liwz2DcZ1t1wFJmF0D5uTIfNxLU4XGd5yf/uRwNlO0zJvW4?=
 =?us-ascii?Q?7O9ZFX+x04jDnkUvN3SFN9Rxmm5ThXgsItoOayYbxfDGUg5yg6SWXOb/kwIR?=
 =?us-ascii?Q?MgxfVd1F6Qzk596Ro/1w4IrCyLcBcPuP3bZITaRGlrIpXB1AnfrusHik2AhS?=
 =?us-ascii?Q?nN8gmT1aYceUo4R8Qg59lv6vPlBYudyHjj1Pfxb8glYdPu0s6bFeP2hlejRn?=
 =?us-ascii?Q?3pmSDXkauJx7culRrmdrozEDs4tpe5onM8a9CUGGNISX2YrfNjQuagDyOimD?=
 =?us-ascii?Q?59EHnNxjT1Qf5wzfC00+3pCD1qnQ+lrOckm2vSRlBFZle65J5vw0EMWcPs4X?=
 =?us-ascii?Q?9s1LKKaOvDLofxuCdmg3n4Lf3YFR3faOuffx4NoktF4i2f3FuPqNlxaOMdeO?=
 =?us-ascii?Q?ABjxfWEZlbD+JcVry43JyCD6CI/CrSt9puyjsOJ9m5qpzJiuheBdz/9alK6J?=
 =?us-ascii?Q?mu9GssnOq5lRXY9UV9HPgKxVK3eu/hUCaTyCB5/Sxldq0+V9X7cTIMqK6Ei9?=
 =?us-ascii?Q?0TBgSna5MKEqWCqgSW5MqnuOIh5A8/O1aPUDukBtqkBA2tJ+I8x+rgTenRdX?=
 =?us-ascii?Q?XWp6tmD699LZFJUkdkw/sPBHdekkhWxirwJDQ6I/myU3t2dJt9EonGZKaDzz?=
 =?us-ascii?Q?EOu/ABPGQChdkcYS7VpLkDQiiNB3xnDJvJRgfx7TJZXoF1nxwEMA+48777OE?=
 =?us-ascii?Q?Uiz+GQl/tsFM+M94o9V59H1gdXwB4Wk2WKQkkkxR/Z3RomgQ3Fgalu9pMmfj?=
 =?us-ascii?Q?9/12nu3IjP/HNxLEfghXpWLG6DJfVM6z94sOCcIt1JOLKj/3yvzBJNM641Np?=
 =?us-ascii?Q?CAppwrvDktprrvpSpTIpTHYOSm3x4UYGj7xx+UkbQRD3c0p9/vB7R7/8XBm0?=
 =?us-ascii?Q?/3MLWWCmSP2bY7enQHNi0A1z2iaUXI2eusrckmAHEToYWvJP9qmKn4/Y6NKy?=
 =?us-ascii?Q?pnMWPxpsOZVU27ZsD2c76xbtEcu5gMHMEhdD4+XHeZq3PheMnyEou2K2EMLw?=
 =?us-ascii?Q?LFtVkPe6rtPWQC+MFrWMV91oBnP6m8mR04u/voXinEYTpuDmreLHqgayBoan?=
 =?us-ascii?Q?jUlWKMuPMb5TRgOANYDSznKQhlI9DVXIa+9yQTdL2p4KGk4qe0AIvn1S/800?=
 =?us-ascii?Q?+h81vpD4NNGMb76fZ7XcLqlthNGvvSRTfDpcoIGSa3ddkG6s0HzUmWTblwle?=
 =?us-ascii?Q?Nz8ptYRD6hI5EysIupqIGSZRGyJufpz+0dKsvlBE0arsHqavh73ni0CfpaBf?=
 =?us-ascii?Q?ZXpfpYGtjEWlwbdXimEmFqU1yrwJE8TAhJ1EC+MFCSmdUkwjvuTY4TBHimK8?=
 =?us-ascii?Q?1NMuieBwWw5dRAr4aElV1PKFs24RCiwL63iR+6//P6ERxekAb3G++tjg3BQF?=
 =?us-ascii?Q?GPY1TMnBUzdVNmhCKY4jIaWeHbRfeTNnASoGqH094UXFPyMj5oJrs76jva4u?=
 =?us-ascii?Q?0oVg4oZgmCRpZB17LE2mfJ2Fos00HLXhSSj98jL2tXlvisR4?=
X-Exchange-RoutingPolicyChecked:
	m1uQCXpKgT8MXkY7scPfcuwaioxqFffzsRnQ6HumAT/6T2Jnt/kBJ+wOu6jG7sNjRtOffborycu3qI0CkQH3kfNEFjyK6ZYAOBx4O3FHpbWQzuHnS9YtJtSiPz0fbD47Ycq5LlfYvsDAaRFDXLDpFX2HySlMlFTPXWmFdHdvGXbIEnB/vi1Bk29iFn/Efr/KmEWJCbne/EdVLt5OwrJeVsmvwi0E/q2c0Lb0g4dHV8CW1Ud+CAKWxLyTR6uDoM6fMA9cLz0ZEXlVg/i1eB2rfpUrr3TzV8rd3WEqrmNViMnCObIV9XwepTKmMKJ1X890uOiiSCWZM26Pkbd5YjwFww==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f632d35-a6ea-4456-ed02-08df288562c6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:22:26.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jNQ5O04r801gOPQNtChtRk+vUeD+K2isDvDkc0qWPHwrBJVKI/5tXmnJ8Mao0Nm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5669
X-BESS-ID: 1791825783-111237-7735-6828-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.107.209.127
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZG5saWQGYGUDQt0dg0zcwiOc
	kyydIiNc3YPMnS0jzRxNjCzNQixdLIXKk2FgAlwlGJQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276792 [from 
	cloudscan20-15.us-east-2b.ess.aws.cudaops.com]
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
Drivers that implement it receive the TIOCM output bitmask so they can
assert or de-assert DTR and RTS independently. As in tty_tiocmset(), the
wwan core keeps only the output bits (DTR, RTS, OUT1, OUT2, LOOP) of the
TIOCMSET/TIOCMBIS/TIOCMBIC value in port->at_data.mdmbits, and calls
->dtr_rts when DTR or RTS actually changes, gated on WWAN_PORT_AT to match
the open/close raise/drop behaviour.

Also raise DTR/RTS in wwan_port_op_start on first open of an AT port when
the driver implements ->dtr_rts, and drop them in wwan_port_op_stop on
last close if HUPCL is set in the port's termios. This mirrors TTY
semantics and means individual drivers do not need to implement this
themselves. As on a TTY, HUPCL defaults to on for AT ports, and userspace
can clear it with TCSETS to keep DTR asserted across close, for example so
that closing the port does not end a call on a modem set to AT&D1/AT&D2.
TCSETS and TCSETS2 now only commit the new termios when the copy from
userspace succeeds, so a faulting call cannot silently clear HUPCL.

->dtr_rts must be called under ops_lock, which serialises port ops and
protects against port removal (removal clears port->ops under it). So
that the TIOCM state and the line state sent to the driver cannot get
out of step, the termios/TIOCM state now also lives under ops_lock and
the separate data_lock is removed. The AT/QCDM ioctl handler takes
ops_lock interruptibly, since a driver's blocking write holds it while
it waits.

wwan_remove_port() also drops DTR/RTS before ->stop() when a port is
removed while still open, regardless of HUPCL since the device is going
away. The raise and drop paths go through two small helpers, which do
the AT port and ->dtr_rts checks and pass the driver the resulting
bitmask.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v9: Raise DTR/RTS inside the existing first-open branch of
    wwan_port_op_start(), and drop data_lock so the termios/TIOCM state
    and ->dtr_rts calls are all serialised by ops_lock, taken
    interruptibly in the ioctl handler (Loic Poulain). Mask
    TIOCMSET/TIOCMBIS/TIOCMBIC to the output bits and only call
    ->dtr_rts when DTR or RTS changes, commit TCSETS/TCSETS2 only on a
    successful copy, and describe the calls in the ->dtr_rts kernel-doc
    (Sashiko review of v7). Document in the ->dtr_rts kernel-doc why it
    is AT-only (Loic Poulain, Daniele Palmas)
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
 drivers/net/wwan/wwan_core.c | 96 +++++++++++++++++++++++++++++-------
 include/linux/wwan.h         |  8 +++
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..27ae6583d3e0 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -25,6 +25,10 @@
 #include <net/rtnetlink.h>
 #include <uapi/linux/wwan.h>
 
+/* Modem control bits userspace may set on an AT port, as for tty_tiocmset() */
+#define WWAN_TIOCM_OUTPUTS	(TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 | \
+				 TIOCM_OUT2 | TIOCM_LOOP)
+
 /* Maximum number of minors in use */
 #define WWAN_MAX_MINORS		(1 << MINORBITS)
 
@@ -73,11 +77,10 @@ struct wwan_device {
  * @start_count: Port start counter
  * @flags: Store port state and capabilities
  * @ops: Pointer to WWAN port operations
- * @ops_lock: Protect port ops
+ * @ops_lock: Protect port ops, and the AT/QCDM termios and TIOCM state
  * @dev: Underlying device
  * @rxq: Buffer inbound queue
  * @waitqueue: The waitqueue for port fops (read/write/poll)
- * @data_lock: Port specific data access serialization
  * @headroom_len: SKB reserved headroom size
  * @frag_len: Length to fragment packet
  * @at_data: AT port specific data
@@ -88,11 +91,10 @@ struct wwan_port {
 	unsigned int start_count;
 	unsigned long flags;
 	const struct wwan_port_ops *ops;
-	struct mutex ops_lock; /* Serialize ops + protect against removal */
+	struct mutex ops_lock; /* Serialize ops + at_data, protect against removal */
 	struct device dev;
 	struct sk_buff_head rxq;
 	wait_queue_head_t waitqueue;
-	struct mutex data_lock;	/* Port specific data access serialization */
 	size_t headroom_len;
 	size_t frag_len;
 	union {
@@ -374,7 +376,6 @@ static void wwan_port_destroy(struct device *dev)
 
 	if (dev->class == &wwan_class)
 		ida_free(&minors, MINOR(dev->devt));
-	mutex_destroy(&port->data_lock);
 	mutex_destroy(&port->ops_lock);
 	kfree(port);
 }
@@ -653,7 +654,10 @@ struct wwan_port *wwan_create_port(struct device *parent,
 	mutex_init(&port->ops_lock);
 	skb_queue_head_init(&port->rxq);
 	init_waitqueue_head(&port->waitqueue);
-	mutex_init(&port->data_lock);
+
+	/* AT ports hang up on last close by default, as a TTY does */
+	if (type == WWAN_PORT_AT)
+		port->at_data.termios.c_cflag = HUPCL;
 
 	port->dev.parent = &wwandev->dev;
 	port->dev.type = &wwan_port_dev_type;
@@ -679,12 +683,44 @@ struct wwan_port *wwan_create_port(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(wwan_create_port);
 
+/* Raise DTR/RTS on first open of an AT port, as a TTY does. Called with
+ * ops_lock held.
+ */
+static void wwan_port_raise_dtr_rts(struct wwan_port *port)
+{
+	lockdep_assert_held(&port->ops_lock);
+
+	if (port->type != WWAN_PORT_AT || !port->ops->dtr_rts)
+		return;
+
+	port->at_data.mdmbits |= TIOCM_DTR | TIOCM_RTS;
+	port->ops->dtr_rts(port, port->at_data.mdmbits);
+}
+
+/* Drop DTR/RTS on an AT port. Called with ops_lock held. On last close
+ * the lines are only dropped if HUPCL is set, as for a TTY, on port
+ * removal they are always dropped.
+ */
+static void wwan_port_drop_dtr_rts(struct wwan_port *port, bool hupcl_only)
+{
+	lockdep_assert_held(&port->ops_lock);
+
+	if (port->type != WWAN_PORT_AT || !port->ops->dtr_rts)
+		return;
+	if (hupcl_only && !(port->at_data.termios.c_cflag & HUPCL))
+		return;
+
+	port->at_data.mdmbits &= ~(TIOCM_DTR | TIOCM_RTS);
+	port->ops->dtr_rts(port, port->at_data.mdmbits);
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
@@ -756,8 +792,11 @@ static int wwan_port_op_start(struct wwan_port *port)
 	}
 
 	/* If port is already started, don't start again */
-	if (!port->start_count)
+	if (!port->start_count) {
 		ret = port->ops->start(port);
+		if (!ret)
+			wwan_port_raise_dtr_rts(port);
+	}
 
 	if (!ret)
 		port->start_count++;
@@ -773,8 +812,10 @@ static void wwan_port_op_stop(struct wwan_port *port)
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
@@ -979,9 +1020,15 @@ static __poll_t wwan_port_fops_poll(struct file *filp, poll_table *wait)
 static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 				    unsigned long arg)
 {
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&port->data_lock);
+	/* ops_lock serialises the termios/TIOCM state with port ops and
+	 * removal. A blocking write holds it too, so wait interruptibly.
+	 */
+	ACQUIRE(mutex_intr, lock)(&port->ops_lock);
+	ret = ACQUIRE_ERR(mutex_intr, &lock);
+	if (ret)
+		return ret;
 
 	switch (cmd) {
 	case TCFLSH:
@@ -995,11 +1042,17 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 
 	case TCSETS:
 	case TCSETSW:
-	case TCSETSF:
-		if (copy_from_user(&port->at_data.termios, (void __user *)arg,
+	case TCSETSF: {
+		struct ktermios termios = port->at_data.termios;
+
+		/* Commit only on success, a partial copy must not clear HUPCL */
+		if (copy_from_user(&termios, (void __user *)arg,
 				   sizeof(struct termios)))
 			ret = -EFAULT;
+		else
+			port->at_data.termios = termios;
 		break;
+	}
 
 #ifdef TCGETS2
 	case TCGETS2:
@@ -1010,11 +1063,16 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 
 	case TCSETS2:
 	case TCSETSW2:
-	case TCSETSF2:
-		if (copy_from_user(&port->at_data.termios, (void __user *)arg,
+	case TCSETSF2: {
+		struct ktermios termios = port->at_data.termios;
+
+		if (copy_from_user(&termios, (void __user *)arg,
 				   sizeof(struct termios2)))
 			ret = -EFAULT;
+		else
+			port->at_data.termios = termios;
 		break;
+	}
 #endif
 
 	case TIOCMGET:
@@ -1024,18 +1082,24 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 	case TIOCMSET:
 	case TIOCMBIC:
 	case TIOCMBIS: {
-		int mdmbits;
+		int mdmbits, old = port->at_data.mdmbits;
 
 		if (copy_from_user(&mdmbits, (int __user *)arg, sizeof(int))) {
 			ret = -EFAULT;
 			break;
 		}
+		mdmbits &= WWAN_TIOCM_OUTPUTS;
 		if (cmd == TIOCMBIC)
 			port->at_data.mdmbits &= ~mdmbits;
 		else if (cmd == TIOCMBIS)
 			port->at_data.mdmbits |= mdmbits;
 		else
 			port->at_data.mdmbits = mdmbits;
+		/* Only signal the driver when DTR or RTS actually changes */
+		if (port->type == WWAN_PORT_AT && port->ops &&
+		    port->ops->dtr_rts &&
+		    (old ^ port->at_data.mdmbits) & (TIOCM_DTR | TIOCM_RTS))
+			port->ops->dtr_rts(port, port->at_data.mdmbits);
 		break;
 	}
 
@@ -1059,8 +1123,6 @@ static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
 		ret = -ENOIOCTLCMD;
 	}
 
-	mutex_unlock(&port->data_lock);
-
 	return ret;
 }
 
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 1e0e2cb53579..5bd9842885bd 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -57,6 +57,13 @@ struct wwan_port;
  * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
  *               to the device.
  * @tx_poll: Optional routine that sets additional TX poll flags.
+ * @dtr_rts: Optional routine that updates the modem control lines to match
+ *           @mdmbits, the TIOCM_* output bits (DTR, RTS, OUT1, OUT2, LOOP)
+ *           currently set for the port. Called on first open, on last close
+ *           if HUPCL is set, on port removal, and when TIOCMSET, TIOCMBIS or
+ *           TIOCMBIC changes DTR or RTS. Only called for WWAN_PORT_AT ports,
+ *           as only the AT (DUN) port carries the modem's virtual RS-232
+ *           control signals.
  *
  * The wwan_port_ops structure contains a list of low-level operations
  * that control a WWAN port device. All functions are mandatory unless specified.
@@ -70,6 +77,7 @@ struct wwan_port_ops {
 	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
 	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
 			    poll_table *wait);
+	void (*dtr_rts)(struct wwan_port *port, unsigned int mdmbits);
 };
 
 /** struct wwan_port_caps - The WWAN port capbilities
-- 
2.43.0

