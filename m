Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C238F64E
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782130; cv=fail; b=tGG/4p8eTpXM9gQiRS3iTvCiqgMFtlv5rtjLXDKJatUEQc6BFiC/MkxcwkkIwiRUO3gDu+ncYT5uPgjfxDqMbxM+D4O3XEXz2v9zMwwrQY8GdKpGWefLw0uqyFQq802n9cdB/Cd8dpkQa4NhvaymJqiIy5dwfIgIT3NcSq+x2ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782130; c=relaxed/simple;
	bh=ur+znVNYUXPQkUaPaEu9F/74IjKN+LYF17LzBS5KiKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kghQFPt5faAEfsUdLN6gHfRsq3Qx5l3o0kIvPejoqrGKzZBrI+6z+AmPi4GUbHQbtPaW9lpb7xz8qz7fJotDYxxtSExHANS5qwXml9DnzPeVrZhmtGZJFIYQnXvTzcrVLcEG2BWOf7Ep/FfYcZ57UwUqQskrOXGT2ZjCh1gyT70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=dU4zxtU8; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="dU4zxtU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQYQozN4Qqmdc1S5GHHn2iaE2uObx+bmAlkgPYnmC8U8wkALufdRD9rRxttkxnHuy2fXijEEwT8TcUVHnn9Peqfen8XoG5wCk5uMbNje57JnLIKjg28rkMLndc9QnongEF78yW5V21vPgwxF5HBkr+5ZFJzO90zD2ojzd1OGOFCXz0LaqsCb+I2eVjCzZHfxlK7mB/mB+/WnwibtVcQlJkZgIfD76mMk7pCaAxlUdCX4m5gIJUrC6zFRnocKK0qtHmUQGIY0+Px3NtCiSw4X7EPick2pW23OmAvrLkumq0+kHdU8auhApwjNwEHO4a+P4zJVJoJF73YcGwabr8iCuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4KqWcNSz36Vl6E+8ZxqVLXmxTJrwULd8IGj5IW61w0=;
 b=k/9nVOmB4o0xrwxwWN7Vt9wbGWNJlhrmSMAclS8iYjvZRKg1CDgLjuQqFmrOtcwjDI1pkSGcY9FkjfoLJSENdE4yEEM1OT2IR2tS1XqSz5oYzjl2EHQb0696NfhBYw56zECNlcuLBy3IZpEzfcZ2z8Dgpr5e1Tagb9cVvGJT8lDUo08w1Bg4POGe4oVXwPfH9HqHMZbu0Oo8eHFJcxK54MB2bVhOPAdKEOdjdP0WgtLhwPzX1poEzEq4ttEpuXK/Qlq49nDmKNM82UftEXhfOyDdAta+FSXOPvOk4PH46qsaIAMOEH9Ni0SADsXlIGm+B7G1schHE8gu+oFrXYoCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4KqWcNSz36Vl6E+8ZxqVLXmxTJrwULd8IGj5IW61w0=;
 b=dU4zxtU8GZV0syz3CSxRAQPmRsknypqiI7dWQgoxjnOpZJKBzLYtpwvA8THoY5wN1+PVC3VuaGn5C1Bm9zIAJvoB6DDY3HfL5bL0c6KPuUCF1FT9Pm9fZPhaoZ5/VgfEYVQGf3NTZwMjZ2D5mGt8jd6JJAD45/rFUyeZbCpfnrm4mp6ucVL88ubCO8vXWDJJCMOinTCj2HMQ8PnG6W2fqlzO5Da1nwNhroZyI4ne/6rxfojsGuNlTHH+spGB8JTdmawa8CUrnag5enCtabg2GONhc0bM9BQ6TiR3z12e1bwLgKzC4hbTEJetIMsMltKSvH7rT5xUq8ZYhO1Xroo2QQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS8P189MB2578.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:632::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5; Thu, 23 Jul 2026 04:48:26 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0270.004; Thu, 23 Jul 2026
 04:48:25 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ren Wei <enjou1224z@gmail.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "vega@nebusec.ai" <vega@nebusec.ai>,
	"xizh2024@lzu.edu.cn" <xizh2024@lzu.edu.cn>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>
Subject: RE: [PATCH net v2 1/1] tipc: avoid use-after-free in poll trace queue
 dumps
Thread-Topic: [PATCH net v2 1/1] tipc: avoid use-after-free in poll trace
 queue dumps
Thread-Index: AQHdGS+DR1r9/aX9IkOZXO7a3111h7Z6fi6g
Date: Thu, 23 Jul 2026 04:48:25 +0000
Message-ID:
 <GV1P189MB198899830101F43A05F8FD78C6C02@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1784642230.git.xizh2024@lzu.edu.cn>
 <b0e80e22320459e0f4a3afb30c0c02ab2df03003.1784642230.git.xizh2024@lzu.edu.cn>
In-Reply-To:
 <b0e80e22320459e0f4a3afb30c0c02ab2df03003.1784642230.git.xizh2024@lzu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS8P189MB2578:EE_
x-ms-office365-filtering-correlation-id: f8614a09-6359-49a7-0955-08dee875a1cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|11063799006|56012099006|38070700021|10067099003|4143699003|3023799007|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 JAzZowmK02CFbKim36sOW9ZRUvirQahDB9TxBGq86T+QQSamvpfPwbPJN2tSDdJ/QTMQ9V7cxjOzzHHAYK8p0yELuiPPq0HirEmqvjJ8aAfzZTcXR4/3TgWEA4ADiaeJgCmjMhv+OjLNSTi7yElPcmY7r1wSSXaD1GH7JKeOAdP85FvJtXwEk6kHYoifq5p6PFZh3RjzL/psEpTz7ayFamK43Zdta9yQEkbD9auRYu1c7rXu6bEoydtSPdUJqnzKPljmRjB8Cd1WDy9zpLzvJ6A0pQuaC1Mht7LjXfeMqYIcJqhJJaM6pNBm8iuNi2Vig6RwOEEo/7KFg2a8dAeQ0FdSa5Bi4uXO8T9aJRAr+SmTolzZ6p6rlC8TB6drRawNM2eIbOvt2EZYZ3tfAf/QOm0cbhZI55u5QMwI2gizpAwzg4LSlmqXm5rDRTFVWvwSGTe30vlkxgyhehfg32aOjPVU+jXc1JkFGR97OV0Nm11IExrca/lCM+//5usurvA36MvH53IuQ0fEcwj2r3ThF80AmTfUp6zdacY6+duims4BcoDk3Ux44DVo2i3nVcGH5BFrxXdq1Wu5eQ2JMt9V/6LklAjI7Z+cwnOg8GodCIa2oLDkXIGzpuCyVNk15wRVka7MEpa0cMVQmPhHChxYu1bXmsjAB/3LzVaaAgYkQo6OcTeUWNc/T7h8fXC5G9SzoFDOw3quSQffJ1prRWg5vr/4ogwK1bGF5+190CNYcqs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(11063799006)(56012099006)(38070700021)(10067099003)(4143699003)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n1vOSkLW+hETLKc5fuVyCfhWplY+gMKuWwHKt67/wYTyYSWauFRwbaYqamg/?=
 =?us-ascii?Q?lPtqvwCMZVIHxsFWAr/amyvZMYy+G+GOhdQ6h4iyIbMr/y8FwG7t9JWPg829?=
 =?us-ascii?Q?0/Pp22IoXAN9mRk1fb35/ImC47Rdi2S+Jm1m+FJ9BbEKkhghYKLTvLadkjiO?=
 =?us-ascii?Q?OTZayc7AbDTD0tJh41cgQMdU1SxGWal7jVTL9Z04KhIKkKrjVHK/DhPhWl4Q?=
 =?us-ascii?Q?dq/d+ZMnRgoXSW2HDW7MDjQk35YRc1tvWZk2O01Y1xFw7vOS1/7Q9fnFYMj7?=
 =?us-ascii?Q?s9NiSS+kz+9Pd0arI00YXrnonmCqphSrQsuEn/bwfDhGwxTgPfTxTuCnnzH2?=
 =?us-ascii?Q?ihlMWanLvkzqiHQaGlCXr16u+4l9HfjWTHx631xrt8sx67shJwu+zA4EiETc?=
 =?us-ascii?Q?A1KsvgP8j8vQhI7fmRWMqdSxpK/TGi4XVeb3RjEd3JquKEUPJ0StPCjhpEFJ?=
 =?us-ascii?Q?dy62IVJxeF+bODxNR8VsuiZbPZdKO/e3UgiSTtJVSzF62s58jvUcf0GrCjQZ?=
 =?us-ascii?Q?+c87BE1ydXsySMlBpVgiSoKDZClL6Ank5tAsUUlcIr8aVGNhqZw2U7xcetWX?=
 =?us-ascii?Q?EvUvXs0/7WCjrMrDE15YaAlQFBswf4KZcR8vBZKQA2Gjh4USHNr3qNJnpcrp?=
 =?us-ascii?Q?fQ+EXxMw/TGMjKDf7nGEiAiPbp4AY3R5hGUJmKLK6fYndcNzVzRGmrwV52XO?=
 =?us-ascii?Q?RHVbHoD9AvxBISObtVZuW/3waZEbF4ykeD9pgilms7QGklTvLvwVc4Sdv2EE?=
 =?us-ascii?Q?EV2ExJ233sNcNZ+J7akbcNGmp+LKosiWNCU7PaKdE+XlL5Bh0QrO8/xQiBsI?=
 =?us-ascii?Q?vCPaRuTD8C/gKCR16fwQd/vCHnwLQiraR5O/8S+47ngskYoVuFJxV1t/lOz3?=
 =?us-ascii?Q?fFQd5VjKtFiMtprIb7WGa7sMMYncq1p7Oe+2ab25PXaKEV+n33zrP6uA+vLV?=
 =?us-ascii?Q?dSuJ2XYkqlgZSMUtd+bJ3uPNDqpRQPojreXfrmebpW59KCgPvqxICVAlJgEg?=
 =?us-ascii?Q?PX5MgNcMx/rd2INfJpyDQPcuOjFoqtY7Xytk25vWaBCseJV9ZN70ZNeBQnoc?=
 =?us-ascii?Q?e/f7RLvS6MHPztQVV7f68bCZ2KCq1k1qy2azarbC+9SngOJklcJWHwkS0WsY?=
 =?us-ascii?Q?RfwjYz1TIRkkU6v8qNJ2W+ktgNlyma+TXKIu9uLowrWxrmLL6yrYBUcP2i08?=
 =?us-ascii?Q?htMo5t+CtJkB/dP877vWgpQJh0aLy2K9FeMX4kBPo4esp9AusxQ1mYEFFN1P?=
 =?us-ascii?Q?6FMUSHKtCMGykxvtcvGnbtbUWSWf8O8nDWtCHrLbLxwQYABtNwwmtOgC8e0n?=
 =?us-ascii?Q?GT84xMlZMjKxy2Lqt95ooxsAJKuyk83KYcoodMNbjlQVMvFXlD/PkVj0/Qvo?=
 =?us-ascii?Q?x62XRZdZ2BYx1vH5ncjdPpHAt5W/A0aLTQ9XFMwvUdy/SnY+q7BXRRRybbkw?=
 =?us-ascii?Q?qbB1PvJgGt7mtmI0uFrybcQhcVzDrA3IxcJq0oWFfyjfTlRyXJn8sfyPDr6O?=
 =?us-ascii?Q?sjIBSc/JxeeU5pr+NilOjwJYfQJgrfr1P3wa7W/3TIHrv4/3bZB+8Xsiy92h?=
 =?us-ascii?Q?q/zMRq9+Www9S0X7eA/qm1k4Ng771gJQkLd1xKgKj9U7NT2nYYd6DHxBr4U9?=
 =?us-ascii?Q?vJs1jyCrCa33FcIoATEY3bM+xsWcmPINJUx8h34sDjqKyoLqD/l+PwREQ6gz?=
 =?us-ascii?Q?k3YP8gxs2F/KpRkal+Vml20eqsU6oYUMho7fbtOHj9yHCIiRLJsqjjcKcDJn?=
 =?us-ascii?Q?MD6EXda8UA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f8614a09-6359-49a7-0955-08dee875a1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 04:48:25.6648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUWNfZs94zuPXRYVwGLuv09MxT1WeUxpw6EYMn2O4E2c5ppfSkSjzFL/OBN46O0nSkonMT2MHEZNB1T0Qxd1VCEfQ1QNl8g50BxtsMCEMEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2578

>Subject: [PATCH net v2 1/1] tipc: avoid use-after-free in poll trace queue=
 dumps
>
>From: Zihan Xi <xizh2024@lzu.edu.cn>
>
>TIPC socket tracepoints dump queue state through tipc_sk_dump(). Most
>queue-dump callsites already serialize that walk under the socket lock or
>sk->sk_lock.slock, but tipc_poll() calls trace_tipc_sk_poll(...,
>TIPC_DUMP_ALL, ...) without holding either lock.
>
>That lets the poll trace path reach tipc_list_dump() and backlog head/tail
>dumping while another context dequeues and frees an skb, leaving the trace
>helper dereferencing a stale queue entry.
>
>Keep the existing trace output, but serialize the poll trace snapshot with=
 the
>socket lock. Gate the locking on trace_tipc_sk_poll_enabled() so the hot p=
oll
>path does not take the lock when the tracepoint is disabled.
>
>Fixes: b4b9771bcbbd ("tipc: enable tracepoints in tipc")
>Cc: stable@vger.kernel.org
>Reported-by: Vega <vega@nebusec.ai>
>Assisted-by: Codex:gpt-5.4
>Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
>Signed-off-by: Ren Wei <enjou1224z@gmail.com>
>---
>changes in v2:
>  - Keep the existing queue and backlog trace output intact.
>  - Serialize the poll trace snapshot under the socket lock.
>  - Gate the new locking on trace_tipc_sk_poll_enabled().
>  - v1 Link:
>https://lore.kernel.org/all/24f7311aed0c9ff06b8ea982647b82bf543ec369.1784
>454542.git.xizh2024@lzu.edu.cn/
> net/tipc/socket.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/socket.c b/net/tipc/socket.c index
>e564341e0216..51692c4a0e47 100644
>--- a/net/tipc/socket.c
>+++ b/net/tipc/socket.c
>@@ -794,8 +794,14 @@ static __poll_t tipc_poll(struct file *file, struct s=
ocket
>*sock,
> 	struct tipc_sock *tsk =3D tipc_sk(sk);
> 	__poll_t revents =3D 0;
>
>+	bool slow;
>+
> 	sock_poll_wait(file, sock, wait);
>-	trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
>+	if (trace_tipc_sk_poll_enabled()) {
>+		slow =3D lock_sock_fast(sk);
>+		trace_tipc_sk_poll(sk, NULL, TIPC_DUMP_ALL, " ");
>+		unlock_sock_fast(sk, slow);
>+	}

No lock should be held in tipc_poll() even only if trace event is enabled b=
ecause it affects performance.
See below throughput regression after applying your patch.

trace event is enabled:
node1 ~ # client_bench -c 50 -p tipc -t -n

Before patch:
+--------------------------------------------------------------------------=
----------------------------------------------+
|  Msg Size  | #          |  # Msgs/  |  Elapsed  |                    Thro=
ughput                                           |
|  [octets]    | Conns |    Conn     |  [ms]       +-----------------------=
----------------------------------------+
|                   |             |                   |                 | T=
otal [Msg/s] | Total [Mb/s] | Per Conn [Mb/s] |
+--------------------------------------------------------------------------=
---------------------------------------------+
|        64      |   50      |    64000   |     5654    |       565899    |=
         289         |              5               |
+--------------------------------------------------------------------------=
---------------------------------------------+
|       256     |   50     |    32000   |     3010    |       531423    |  =
      1088        |             21              |
+--------------------------------------------------------------------------=
---------------------------------------------+
|      1024    |   50     |    16000   |     1974    |       405193    |   =
     3319        |             66             |
+--------------------------------------------------------------------------=
---------------------------------------------+
|      4096    |   50     |     8000    |     1366    |       292728    |  =
      9592      |            191              |
+--------------------------------------------------------------------------=
---------------------------------------------+
|     16384   |   50     |     4000    |     2166    |        92321     |  =
     12100     |            242              |
+--------------------------------------------------------------------------=
---------------------------------------------+
|     65536  |   50      |     2000    |     4765    |        20984     |  =
     11001     |            220              |
+--------------------------------------------------------------------------=
---------------------------------------------+

After patch:
+--------------------------------------------------------------------------=
----------------------------------------------+
|  Msg Size  | #          |  # Msgs/  |  Elapsed  |                    Thro=
ughput                                           |
|  [octets]    | Conns |    Conn     |  [ms]       +-----------------------=
----------------------------------------+
|                   |             |                   |                 | T=
otal [Msg/s] | Total [Mb/s] | Per Conn [Mb/s] |
+--------------------------------------------------------------------------=
----------------------------------------------+
|        64      |   50     |    64000   |     5711    |       560231      =
|         286        |              5               |
+--------------------------------------------------------------------------=
---------------------------------------------+
|       256     |   50     |    32000   |     3046    |       525207     | =
       1075        |             21             |
+--------------------------------------------------------------------------=
---------------------------------------------+
|      1024    |   50     |    16000   |     2209    |       362152     |  =
      2966      |             59              |
+--------------------------------------------------------------------------=
---------------------------------------------+
|      4096    |   50     |     8000    |     1544    |       258934     | =
       8484      |            169             |
+--------------------------------------------------------------------------=
---------------------------------------------+
|     16384   |   50     |     4000    |     2549    |        78452     |  =
     10282      |            205             |
+--------------------------------------------------------------------------=
---------------------------------------------+
|     65536   |   50     |     2000    |     5449    |        18350     |  =
      9620       |            192             |
+--------------------------------------------------------------------------=
---------------------------------------------+

>
> 	if (sk->sk_shutdown & RCV_SHUTDOWN)
> 		revents |=3D EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;
>--
>2.43.0

