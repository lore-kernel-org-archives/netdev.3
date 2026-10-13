Received: from outbound-ip199b.ess.barracuda.com (outbound-ip199b.ess.barracuda.com [209.222.82.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055549D5BB;
	Tue, 13 Oct 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916633; cv=fail; b=Z14Z5fvBHX82YnK99AOzhnz5mp0bKiNznjpphdsrrzkF9+YrZFyrd9V9a3MsxcZ1NQCJTZwa0W91m4iBHthBSXeSJobNacdcMA4kOKNBFKeeKJDWU9oK7b2nUDYPJe4zBSNbCEMye1iyMp84AuW6zRD0nZZKMkymmpcWzvx+/zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916633; c=relaxed/simple;
	bh=46rtcqMzA9B82KB1zeN1SU8zLRkGjSDbCCPvzGIB3t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ot+tX5+PiID/mNmH3MoD1cGHWfnFx6icXKRZyJ1YDVEdIC5Z6hjbDYUvye2uYcKIl7MQPipjXa4eitr5yxXneDY85rNAfyVf2FyYF43tidwyZUn/eU1pHxBF7Lku6q/hhnZevHOkEfLdTxjkQWGAqhXWnV2tya6ZbEwvcxpMY3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b=lWWiGhMU; arc=fail smtp.client-ip=209.222.82.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opengear.com header.i=@opengear.com header.b="lWWiGhMU"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022119.outbound.protection.outlook.com [40.107.209.119]) by mx-outbound41-111.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 13 Oct 2026 18:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtRpURbO61D63pM/aq6ZeXUutpyje5AHvHOaY1fk7n8AVrCnybS3nju7QQK5k8VXD4eETtH2JlQ7FPAzm/4wwLhvxEINCI7RjpjWmT2GmJ7if9lpgA7drOMDoEoqjXOr75M7YtDRzSi5j+yACf1r8/+TmAes3HvVZBsncCFVB5n09+a/xWbrhHHkXtqbTLFHfTbkwaNAflC22/DuWLMGf94H9JHkNpIoczzjvzdYshABx+AmiaFm4SakYOrx6G1F7dArrTTmNCrNQQDXZdgWWkkfXoCuGoDFqfuAwykycTo4xk8gtMX8sjYg+K5h1PipMOWzb7+2Yq96CPF/Bg91LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cYdkDOLYpjX9/TASwzDrwv+O/RUcTv62Ovo2y+azzE=;
 b=angmjfyOA3bMIlHd4JTFcZ7mrs1RbjdmY6wax7FRJdefdhQZNXKNxRa1l6IpwE+mp9THUav1Apt6dpyIgjj+pMtROMP23oJNxoaTjeBn49sG1Af8fORjgVnVngBpTt+eWvPMa+a0OtqeLTTuK2Siapo424qyajyKeHptud9hCR9g7Rfvl00ZyK4CIXkeDOdL5Nll3t62TA+HT46Sry++JwHIiScSrN4kXXAJ3yNL6n6/j7Iq8m1CfgaHp3yyO5KgC+sXRuIuTVYoJMFh7xDKBy81nT+QyJMDFj/jpW8MKzMEwvte6FgLqRcepUPJxSID2De+ojIPndMK8FwUE7c82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cYdkDOLYpjX9/TASwzDrwv+O/RUcTv62Ovo2y+azzE=;
 b=lWWiGhMUbpXxsNVDYdjXcBuC4KDq0S8X1dILiQyrtHa1i4Vrpvy4STNr/AhsvUZGMaqPAeDKZaVkMh8wQwAocZ9gCm/ncQqQuG+n0tyEUqQIyvViJ3i4lCDkFfKaBQY+lCeuKz9TlCyhTuRxE5KQt0B72gD8Pkn35NWS8QEYA1ZFo9aZcuMFAZpDDDFnm9wBYlDI3wo2ML1r6wMOrD6fl4nD8UNDjTiTVZl2WwlVWDuuP7VUQQ3q47TsjIwSb+jLwNp6qwrIFB6rjLgDY4pIATc9KPM4cVA0DSJq3niPW3Eg2Ww0roNZ0o376HCD6S4PT3U0X+PUzUJinHATGUEHKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) by PH0PR10MB5870.namprd10.prod.outlook.com
 (2603:10b6:510:143::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.9; Tue, 13 Oct
 2026 18:35:06 +0000
Received: from MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017]) by MWHPR1001MB2095.namprd10.prod.outlook.com
 ([fe80::3933:62ac:2729:f017%7]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 18:35:05 +0000
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
Subject: [PATCH net-next v10 1/2] net: wwan: core: propagate modem control signals to port drivers
Date: Tue, 13 Oct 2026 12:34:59 -0600
Message-ID: <20261013183500.261229-2-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013183500.261229-1-peter.hunt@opengear.com>
References: <20261013183500.261229-1-peter.hunt@opengear.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25c::15) To MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e8e5ca-505b-45f0-47e6-08df2958b3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|23010399003|376014|56012099006|5023799004|11063799006|261009223027099003|18002099003|10067099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GzRWBtxNDbsRasvvnSy8h6bFbrKBHTrIFzHQyUR/CeDleD+qpxtDb6b4zVK0k28lIih6O/QE5RV7NJnWzmu3IJN+YbrKknnMyen1MBJNbjn3SRlPaBSrFW1gbcRk5ctlP1rCM4TqtR63sbgHuM2LFDTPvyajk9BJ3EEcBC3zCiL0Pu0VeODcOWMLKdbvoY9SBp7R5Aq4SB7w34fHASsodexI26XJP5rz5YJe56nEZOh8YsrT7yvaLZ6kvXdYvRSUher9IkHfHhbRxrEYtXnIQsOkawgkqi02qvCvFIjK0WrMxNLSPwHCUl1wWvUeV+mtu4BMYm8tEQkEv6JwCesqMRiveWqbX6Obev4ZoZWgy6gGzzDQ4VTG6Wa2jkXCmU5zuFI4qlhAGtOPxpYh0jH5G6HtpVAw2LRmjv0RPTbZyn4gWtJriPjcTVx/6k2yoP6d9hLZEz6th7j6BrWrxmDfZNEzwXF93BpE7IUBxv/zoXsLpSnCVqWmmc1DO+DMTf9OYLYOkVwdc2fjETlHoLLErSUTRRXyPS3LokjFmvOstnmdvSD87pXh79D+R6ZL91U8SdqorqniBdb1VT6CZfr9ULiMHL2vavUHH/neU/mBk7+KtfIgCBCWP0snWsdwZ4QyN3HmXoO/QPvQYx4IbxLP2VNZzKgYQNBfrIOuo6SOMJU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2095.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(56012099006)(5023799004)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yYWezkygKPgaLa0DGrEH3g7tpEim4smuEWbGWKk7lWqyePaOMbQArtq3m0MJ?=
 =?us-ascii?Q?IneYeHmgz+AM//boTcc1Tc/+xuj2RVj24u4PXoFBGWuTZjsWh3dPwZurbpoZ?=
 =?us-ascii?Q?z79sYhDYkFVWFMwyl05v+xzuTJrD2+32Uvaf6tUL5/0OOEf6SUL54Mo9UqX/?=
 =?us-ascii?Q?vJWwiLmqmLOG7GZZ2I+wpD4Y1iMc7Nw7oqxQy7GWsu2zSlS+HRgg9IObjjP6?=
 =?us-ascii?Q?aYWcZZvMxhyMNGli5wHdCG4SLBYVYF0AjUhdhisLlcWxdF+TD1n5OBvyYluo?=
 =?us-ascii?Q?JeVB9ac0eG01zy0dbYdkyqhpaOLazq6RIenub3UM7pS+IDle8QXNmtoc90MO?=
 =?us-ascii?Q?JRGaTr2LaAcZkXSjMmGfSycSilwLJHoW/IgkQ67aJHF/P46KmwS66dkBqRox?=
 =?us-ascii?Q?Cr+d0qyyaSGueZp4BhwsYUz03fnK8ANCNnAxfG1t+PtRC2fxMtyBTDHBvZ+T?=
 =?us-ascii?Q?V4peVL6XJoa4EMJBWTbrWDAI+pTOCJ6hAnFsZLw+ibGg2V1ctj42/J+pwMV8?=
 =?us-ascii?Q?sUb+3oQ4T4a9QLuvdpMeCC1nIseHZPAFCW5q5uDJEv7Bz7dkiNCHQLLSEmLj?=
 =?us-ascii?Q?vFgxEbWTU6foXOszv6Q2hw9dgdG5FLihLLJatSLpFfkQRxO7042xBw6ocjJY?=
 =?us-ascii?Q?gByCDPbS6NhhvpDqlUUKAeaEtRRBNLNNm4gwPlRAd98QQfKwTMhLNaORgF2G?=
 =?us-ascii?Q?+nAH11IhtOmj6s/rJHOAMw1nz3vonOCgFQ2Rdq5Qr+PgpvOAUgifxFvucl9/?=
 =?us-ascii?Q?fZnIOJmBh8+Is9NoK6Q1Rq67Fy4CwyTH8XWXQylqujfRWTmR8BYItYltVfzY?=
 =?us-ascii?Q?N3HisddWIRfJYQNCgVTIRwSBwIWVStxfi84T+LosqrmCJ2gpHQ0Ym1lFmMCg?=
 =?us-ascii?Q?T/4kObiqZO8/4Bk0kW322CYkRGjhEMyQOQNIncjgNgytE+UjQxlevN28F6en?=
 =?us-ascii?Q?Ydr9WpTdNay6+NFbKearnlvY5RdqwSuK4mL3PTtXs2lLaRMvOIPaK734aW38?=
 =?us-ascii?Q?VdbzMgtBjBzhOtct0xONz4uIHQtbWag1iE3qXbDPwUEmKbA6PLaGGaQU9JUI?=
 =?us-ascii?Q?W1Ajf5tc34368x03gzMPcdq4zcVPEg9XJpRxboZOUHEVhgLukuMqmpzYHgiN?=
 =?us-ascii?Q?BFza6UJk6NLYxzpysKMLE50o59o1rYZHJMeuYjIzc+7e8vxDOzDJUpqsNwj0?=
 =?us-ascii?Q?l/x7KDSuT3ewJ6DSKhtVi9rNr1Zt5ZLxi85IB84dHlq1cQi4JmYx32xh3LCI?=
 =?us-ascii?Q?IkUZggDpLhVWtgruWdLyyhBpmCvs2hKnqN59hOZkabfnU9GF0OcQSi59Wfh/?=
 =?us-ascii?Q?xiYJUg6AAX5U4Xmgv6yKfcdgbqYnYYz7mFdkSz6Eh57DGeUWufXXYSt8INcM?=
 =?us-ascii?Q?BVlfBL9a9AEFYsPsm+dXlc28zZIJEMEOsHXRXn5TEjtTAgpeSWDdTIWkvdG4?=
 =?us-ascii?Q?vJoNiiC/vpN3FEXThSwH7sCM/gEm43nnV2LZmLe8Ihb1DUED+lxNHDMGoONV?=
 =?us-ascii?Q?GznZuXfjHmtrc7I0ngIskD0AF0lVcBYXlBPnV8X1D8KNYGEt1EksqgCjHFhh?=
 =?us-ascii?Q?U4drMoOh8ophiL4mq1IC5aXwKAjUrGGKX8V6DsTL23/bOSY3pK/XsH5rJRJB?=
 =?us-ascii?Q?nSXHtIR2kPGnOErKA9heuFrLgix04H5zwCdQPmkLxsIsfvoX72l55aD6lR2F?=
 =?us-ascii?Q?8eSjOebEJjQyO76RJpFnbphbLljBhMpCfmDM392b27edeoh3?=
X-Exchange-RoutingPolicyChecked:
	4ZcpPRN8X3nDboaghWhBQYpcbolF4xe+moyZYSlOlMMT0JRkP3X2UcJ7DkeiqqI1JAtxVxt97PELX9+gIlYmxwe3B8wH4bav52fYFv14R8tHBy79TgE0nhuUNnhqC9P/JwBFUONs6BKkxDPiVcjLtT4D/B82PH9cqlrj6QcVFhYgSzo1WzkittyYviAJLoLhzZZQcHyWhQnlQyqp3C5XbrNd0uAzrjYHqboMYUzWy6KlYHJf+Q7EMpH2objLMPQgdcdp96OOXX0kPBgEq3k9mw08X3g1lGZYeO0XoyQuvoUIy/DnweK7/ysY/w/uLacseKTL75kBFHOGtK+5oB9G8w==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e8e5ca-505b-45f0-47e6-08df2958b3a6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2095.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:35:05.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEV57e7oYEWa2hMycnCIFhJGLuhBcz3hz3xz8UlUseFtBCz1BF0XXG6zL3f/9doS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-BESS-ID: 1791916612-110607-7731-3510-1
X-BESS-VER: 2019.1_20260924.1519
X-BESS-Apparent-Source-IP: 40.107.209.119
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoamJuYWQGYGUDTJ2NQy2Tgt1S
	DRItkkOcUy1dDcwtLS0DAlxcLIJDE1Tak2FgBnMJRpQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.276817 [from 
	cloudscan18-226.us-east-2b.ess.aws.cudaops.com]
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

Also raise DTR/RTS in wwan_port_op_start on first open of an AT port
when the driver implements ->dtr_rts, and drop them in wwan_port_op_stop
on last close if HUPCL is set in the port's termios. This follows TTY
open/close semantics, although the termios baud rate is not used, and
means individual drivers do not need to implement this themselves. As on
a TTY, HUPCL defaults to on for AT ports, and userspace can clear it
with TCSETS to keep DTR asserted across close, for example so that
closing the port does not end a call on a modem set to AT&D1/AT&D2.
TCSETS and TCSETS2 now only commit the new termios when the copy from
userspace succeeds, so a faulting call cannot silently clear HUPCL.

->dtr_rts must be called under ops_lock, which serialises port ops and
protects against port removal (removal clears port->ops under it). So
that updates to the TIOCM state and the ->dtr_rts calls are serialised
together, the termios/TIOCM state now also lives under ops_lock and the
separate data_lock is removed. The AT/QCDM ioctl handler only holds
ops_lock while it reads or updates that state, never across a
user-memory copy, and takes it interruptibly since a driver's blocking
write holds it while it waits. Ioctls that do not touch that state, such
as TCFLSH, TIOCEXCL and the FIONREAD fallback, do not take it.

wwan_remove_port() also drops DTR/RTS before ->stop() when a port is
removed while still open, regardless of HUPCL since the device is going
away. The raise and drop paths go through two small helpers, which do
the AT port and ->dtr_rts checks and pass the driver the resulting
bitmask.

Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
v10: Only hold ops_lock in the AT ioctl handler around the termios/TIOCM
    state, with user copies done outside it, return -ERESTARTSYS when
    interrupted, and leave ops_lock alone for ioctls that do not touch
    that state. Word the TTY comparisons and the ->dtr_rts kernel-doc
    more precisely (the baud rate is not used, removal only drops the
    lines while the port is open, open only once ->start() has
    succeeded). Both from the Sashiko review of v9, still using ops_lock
    only as agreed with Loic Poulain
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
 drivers/net/wwan/wwan_core.c | 172 +++++++++++++++++++++++------------
 include/linux/wwan.h         |   9 ++
 2 files changed, 124 insertions(+), 57 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index ffbcf11e4e68..7097b58dafde 100644
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
+	/* AT ports default to HUPCL, so DTR/RTS are dropped on last close */
+	if (type == WWAN_PORT_AT)
+		port->at_data.termios.c_cflag = HUPCL;
 
 	port->dev.parent = &wwandev->dev;
 	port->dev.type = &wwan_port_dev_type;
@@ -679,12 +683,44 @@ struct wwan_port *wwan_create_port(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(wwan_create_port);
 
+/* Raise DTR/RTS when an AT port is first opened, as a TTY does on open.
+ * Unlike a TTY the termios baud rate is not used. Called with ops_lock held.
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
+ * the lines are only dropped if HUPCL is set, as for a TTY. When a port is
+ * removed while still open they are always dropped.
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
@@ -976,92 +1017,109 @@ static __poll_t wwan_port_fops_poll(struct file *filp, poll_table *wait)
 }
 
 /* Implements minimalistic stub terminal IOCTLs support */
-static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
-				    unsigned long arg)
+/* TCGETS/TCSETS and their termios2 variants. @size is the size of the user
+ * structure, a prefix of struct ktermios. As for the TIOCM ioctls, user
+ * memory is only accessed outside ops_lock.
+ */
+static long wwan_port_termios_ioctl(struct wwan_port *port, bool set,
+				    void __user *uarg, size_t size)
 {
-	int ret = 0;
+	struct ktermios termios;
 
-	mutex_lock(&port->data_lock);
+	if (!set) {
+		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->ops_lock)
+			termios = port->at_data.termios;
+		return copy_to_user(uarg, &termios, size) ? -EFAULT : 0;
+	}
+
+	/* Commit only on success, a partial copy must not clear HUPCL */
+	if (copy_from_user(&termios, uarg, size))
+		return -EFAULT;
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->ops_lock)
+		memcpy(&port->at_data.termios, &termios, size);
+	return 0;
+}
 
+static long wwan_port_fops_at_ioctl(struct wwan_port *port, unsigned int cmd,
+				    unsigned long arg)
+{
+	/* ops_lock serialises the termios/TIOCM state with port ops and
+	 * removal. It is only held while that state is read or updated, never
+	 * across a user copy, and is taken interruptibly as a blocking write
+	 * holds it too.
+	 */
 	switch (cmd) {
 	case TCFLSH:
-		break;
+		return 0;
 
 	case TCGETS:
-		if (copy_to_user((void __user *)arg, &port->at_data.termios,
-				 sizeof(struct termios)))
-			ret = -EFAULT;
-		break;
-
 	case TCSETS:
 	case TCSETSW:
 	case TCSETSF:
-		if (copy_from_user(&port->at_data.termios, (void __user *)arg,
-				   sizeof(struct termios)))
-			ret = -EFAULT;
-		break;
+		return wwan_port_termios_ioctl(port, cmd != TCGETS,
+					       (void __user *)arg,
+					       sizeof(struct termios));
 
 #ifdef TCGETS2
 	case TCGETS2:
-		if (copy_to_user((void __user *)arg, &port->at_data.termios,
-				 sizeof(struct termios2)))
-			ret = -EFAULT;
-		break;
-
 	case TCSETS2:
 	case TCSETSW2:
 	case TCSETSF2:
-		if (copy_from_user(&port->at_data.termios, (void __user *)arg,
-				   sizeof(struct termios2)))
-			ret = -EFAULT;
-		break;
+		return wwan_port_termios_ioctl(port, cmd != TCGETS2,
+					       (void __user *)arg,
+					       sizeof(struct termios2));
 #endif
 
-	case TIOCMGET:
-		ret = put_user(port->at_data.mdmbits, (int __user *)arg);
-		break;
+	case TIOCMGET: {
+		int mdmbits;
+
+		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->ops_lock)
+			mdmbits = port->at_data.mdmbits;
+		return put_user(mdmbits, (int __user *)arg);
+	}
 
 	case TIOCMSET:
 	case TIOCMBIC:
 	case TIOCMBIS: {
 		int mdmbits;
 
-		if (copy_from_user(&mdmbits, (int __user *)arg, sizeof(int))) {
-			ret = -EFAULT;
-			break;
+		if (get_user(mdmbits, (int __user *)arg))
+			return -EFAULT;
+		mdmbits &= WWAN_TIOCM_OUTPUTS;
+
+		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &port->ops_lock) {
+			int old = port->at_data.mdmbits;
+
+			if (cmd == TIOCMBIC)
+				port->at_data.mdmbits &= ~mdmbits;
+			else if (cmd == TIOCMBIS)
+				port->at_data.mdmbits |= mdmbits;
+			else
+				port->at_data.mdmbits = mdmbits;
+			/* Only signal the driver when DTR or RTS actually changes */
+			if (port->type == WWAN_PORT_AT && port->ops &&
+			    port->ops->dtr_rts &&
+			    (old ^ port->at_data.mdmbits) & (TIOCM_DTR | TIOCM_RTS))
+				port->ops->dtr_rts(port, port->at_data.mdmbits);
 		}
-		if (cmd == TIOCMBIC)
-			port->at_data.mdmbits &= ~mdmbits;
-		else if (cmd == TIOCMBIS)
-			port->at_data.mdmbits |= mdmbits;
-		else
-			port->at_data.mdmbits = mdmbits;
-		break;
+		return 0;
 	}
 
 	case TIOCEXCL:
 		set_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
-		break;
+		return 0;
 
 	case TIOCNXCL:
 		clear_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
-		break;
+		return 0;
 
 	case TIOCGEXCL:
-	{
-		int excl = test_bit(WWAN_PORT_EXCLUSIVE, &port->flags);
-
-		ret = put_user(excl, (int __user *)arg);
-		break;
-	}
+		return put_user(test_bit(WWAN_PORT_EXCLUSIVE, &port->flags),
+				(int __user *)arg);
 
 	default:
-		ret = -ENOIOCTLCMD;
+		return -ENOIOCTLCMD;
 	}
-
-	mutex_unlock(&port->data_lock);
-
-	return ret;
 }
 
 static long wwan_port_fops_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 1e0e2cb53579..23a8a8ee473d 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -57,6 +57,14 @@ struct wwan_port;
  * @tx_blocking: Optional blocking routine that sends WWAN port protocol data
  *               to the device.
  * @tx_poll: Optional routine that sets additional TX poll flags.
+ * @dtr_rts: Optional routine that updates the modem control lines to match
+ *           @mdmbits, the TIOCM_* output bits (DTR, RTS, OUT1, OUT2, LOOP)
+ *           currently set for the port. Called when the port is first opened
+ *           and ->start() has succeeded, on last close if HUPCL is set, when
+ *           the port is removed while still open, and when TIOCMSET, TIOCMBIS
+ *           or TIOCMBIC changes DTR or RTS. Only called for WWAN_PORT_AT ports,
+ *           as only the AT (DUN) port carries the modem's virtual RS-232
+ *           control signals.
  *
  * The wwan_port_ops structure contains a list of low-level operations
  * that control a WWAN port device. All functions are mandatory unless specified.
@@ -70,6 +78,7 @@ struct wwan_port_ops {
 	int (*tx_blocking)(struct wwan_port *port, struct sk_buff *skb);
 	__poll_t (*tx_poll)(struct wwan_port *port, struct file *filp,
 			    poll_table *wait);
+	void (*dtr_rts)(struct wwan_port *port, unsigned int mdmbits);
 };
 
 /** struct wwan_port_caps - The WWAN port capbilities
-- 
2.43.0

