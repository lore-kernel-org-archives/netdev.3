Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794603199;
	b=sWhmtqWcq3xgF17QXj6hnaRZmwLRw/kuqSgXPrjdOdLQh4Lw1irc9jjjmpMZKkZkJvP4
	 rRKasT4kRxN1V6weLxr9o0b5+qhMbecWwPTvUs9Hy3i7XEgwZ8tshxJKYj/OOUM28HsZW
	 vNoX8RDEBRGQrMTNbIfXWCFUnchrlmjUthyaXW35hSIIDC1ZSHbkEjSXSIlhZS67g+DXl
	 6JSboPQGoCetr9Gqq39fOAJZjKtWqkcmtqkrt/Ec1JVf644/HyIhI/Iol+1tUby11cqhh
	 qxYOpZcj6Y6gxJza4+le4QUqC00lckBCat7iONVy9al3BgedIY2HiL5Qkw2dBSB1Iaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603199;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=vbJs1WBJaUcoreIKbex9CfghBlcbgLiuK2ZYSeX6pvs=;
	b=TNhVBb01tBOt1tVhQfdNZ/EB6/bo5tQf9XfNrq/J75gIhUqkRdfRRgc5LMzN/2onPYn2
	 rBMVYmYgyAalKoDQs0izwILcP+aX2xQcYd3o6jzw5NKv0KZYJ4EL+0YlORzkRzDVSz3b6
	 cWL8d3J7PkXWD9a0szcx3z1uNBpS+NQbxCTzxLkzXql4GlM6IsgYrwK5tQgjxi3BTSdhs
	 yvuHrrvXiwqxu7z640KJht4uc3dOihFgogsvZAe1XRJqwRU6NMQprMeW5gVOl6HPrtIHP
	 mDgiW6RaGxCoqOEyVBuPuMajZXYfCg4RsParOup2goQ295UsT9eon5kfZXjvRt/dTSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=dl8wDFTt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.37
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012037.outbound.protection.outlook.com [52.101.66.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3F4606A323;
	Fri, 13 Nov 2026 20:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C3F4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=dl8wDFTt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kL22p8BZF/Emfj8IJkbvDzCaUJdCVWlN8Le2jw0n/OLcE9U9DIIcqIx8tSTlhAjHxzYBx5Tj7nC2KFqwuL6jS60jVuk6QxNtqK9kfoIE3pAH9k6ik+kJBsyMl3cct5cC7cjQNoCoxrqVdezm3hf2HmFvh3p9ec0PE9VTN8k1UCCFuMruVTrpLp3QBkAauSbZ+3e1dNDXrqMelcZx3jhtLogAzTsfHtgKJtTUOkWICf5gs3Gl+40o/TXPjsp0BxRF6V9dDZwMCHk7m7Zq9sTTDJt5CTyfIyRfssNvzoJCl71hNXGESLSziqACOyq8UJi9ZA0i/RxIfblKrWD6A8qEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbJs1WBJaUcoreIKbex9CfghBlcbgLiuK2ZYSeX6pvs=;
 b=NfmO6Tgsr7k0+ZBmT5OKZBjbtqfpFCBPaRuQgLoaRUc8QmSqwOl8mWKInYY3b9bmG3lbhf9K/HUc0JB7kRMNvMPywbskIr581sr+Al1GdfDt1xkKcUethRppb+9YcqZEaxKj2vUkyj2gS2MfjXZEA9GBAhKdJbLIp8ZgzoOpOKc2p1Rr1nGmiR0gowJr0TkaW0Qd0+Y+LHW8A9jciuhd9vQaGOFmtcrxwGfCF4RIvF1NIVuV5UyLYgixXVBBzvCxctRbpGp6wvNnC9iIg+Znj2FthUBsv/eqAQ38a06YOGVrWdIwEvUWfQI38gLeWzxchhOlTHZN2MTp8k6HYil6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbJs1WBJaUcoreIKbex9CfghBlcbgLiuK2ZYSeX6pvs=;
 b=dl8wDFTtq6tsCVZ2/hNvzbKllW+o7L6zunmn7fGrmcsijJazhuQtBivZsF9gC+X11LcRpAXiiN1TuyETQBtXhz9TnOCsr8DRYhPfNq2wbOh9qLo2aEUw4aBSciBqNsEjTj+VjUL/q9iShQTXDkL4yF0ndaAW6t8/2BgMfhrpTv/HBJ9wykReoZYWMc7r9MDwPZM7kC/VJD4R3VwDLKMZKJWvzjueRDjP8TzuYXL6LaIsUS9r5iN9NTB5kNFbb4xU4raZfA50tYh2N0zhNCgXQA/sZIhaXwIEh+h+plFmcfa+ocrEjXwG8t1Hbcc6vOf+IcH4r4I9mvzB+7Q0jtYOhQ==
Received: from PAZP264CA0074.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::9)
 by AS8PR07MB9397.eurprd07.prod.outlook.com (2603:10a6:20b:637::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 20:53:14 +0000
Received: from ZR1PEPF0000E6B0.eurprd05.prod.outlook.com
 (2603:10a6:102:1fa:cafe::93) by PAZP264CA0074.outlook.office365.com
 (2603:10a6:102:1fa::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 20:53:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 ZR1PEPF0000E6B0.mail.protection.outlook.com (10.167.241.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 20:53:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id AC22255B67;
	Fri, 13 Nov 2026 14:57:01 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuniyu@google.com,
	ij@kernel.org,
	ncardwell@google.com,
	koen0607@gmail.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com,
	Mike_Rudolph@comcast.com,
	Jeff_Howe@comcast.com,
	srichard@netapp.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next v3 0/4] TCP Prague preparation series
Date: Fri, 13 Nov 2026 13:56:24 +0100
Message-Id: <20261113125628.2893742-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B0:EE_|AS8PR07MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 6224384f-f06f-40cd-17ac-08df41c82170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|36860700016|1800799024|18002099003|3023799007|921020|11063799006|10067099003|56012099006|261009223027099003|261102123227099003|261102130727099003|261026121527099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	8a+WSusvS5xeQemooL6J7XFBRs/wxG1rGASY210j3isLJinHfzJ8yzqMw/o6KRg1nmXV9bEeeQkaQ8nyQvEG9zyqNw2IJDtrLsma1dlLQjG1UUnoXHMkhtD+XPFwhjVb5uqQUl4dnMDyEQYr2i6RA4jhcHCmsDOH0JUoqbTA19/ATINFCNgBk1cw0LfGFiG9BBFWd17cN8H4bybjRyVY+Sz2w9/wOnAPRONnRpl+3lv8Axcmm5cow1QyvR0W9E1hyb97rUPRL3iEzrfW9F2C8rfU977uuupQzs/wBaubUMyxwBt8ZM5QP5zlw6zdoUA/c5TGxuAsIdQA1+uQhHi4PH1mwocPqS7gMX3MBlgA9CXfIrVeQdPIcY5Y/ZxOrvAQ0QZfPX72PDbtlG177S3N14I2aATgdIw4rX37g5gGwwK9HoVgRdvl38tWPZshVW7ss/ecn8dUMWfdyMbf6+3HwuoYqFh9d6b8KcWvLV/Dq68B9RQ8elO3CAJS5ypIOA+YOQAYjUHjwM53zGB64zlChdHpC6JWCc/uxg1/4YYbA3+CN2x0EQ4KIc7IwQIH7MEvNn4Nqy2Xy8O7j0gXxYna/mKZmi9EHua+4SSwjlgJdgixyDA878Spkw6DBi4dZWwXmv6eE4oNxI54K5P0JFrsDZDVuGZu20QB6XMedJAwrTe7XQnYU6ee6Q5ZwrajJLKF/T+Z/lxnKDWJnv3IJf0ULS4dOYZcd5x1EwBcDSl5qqopq1IkunCoQhOwi77tUVG7
X-Forefront-Antispam-Report:
	CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(36860700016)(1800799024)(18002099003)(3023799007)(921020)(11063799006)(10067099003)(56012099006)(261009223027099003)(261102123227099003)(261102130727099003)(261026121527099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DBIvnOOaaKfRFujQ9LnrKsthLipPGUbOWZ3he649kpc4GxbtaUUPQZhdFyC1QTuoDe98yC9Er1fR2w2rU7hn7tS9Fpt7o1MbPzRsAvYX8GIXY5jImHL1Tcl/hu2xw+4mGzGooKclhpcWlxRbiVxiJkeC56PRKUEf0SZOy5ldh2n/diBPMwxW9mfeeFRfy+SVMkq3E0Adp9LbLe51z0/mQdJrsI1AjAXtC4y3vyXgaezcxuyNqdJHUUFprW4m9+LHZvMwT6Zdy4lF/Tdqcnugqboh6sj5DqZT/VScG51RJ1qSjH9dKgS5aFlvj+DQrnpo1o18e1HTX26YASfWvCr/xOu3e5u7JxGop4TRA8Dm4m/xNrmkDMHDizlOzbrQn7VkgLWWFkzSCdS9XM2KAIbp59WUa1A3FN0HzOLNKR4RQcfgRIbsKMlTIl3w3B4l/kp8
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:53:11.8843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6224384f-f06f-40cd-17ac-08df41c82170
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-ZR1PEPF0000E6B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9397

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v3 TCP Prague preparation series, and TCP Prague will
be submitted after this series.

This patch includes the following additions:
(1) Add ece_delta to rate_sample;
(2) Rename existing rename ECN transmit helper function;
(3) Add TCP_ECN_SEND_ECT_1 to use ECT_1 after negotiation;
(4) Add MSS ceiling callback for congestion control to limit MSS.

Best regards,
Chia-Yu

---
Chia-Yu Chang (3):
  tcp: rename ECN transmit helper function
  tcp: add TCP_ECN_SEND_ECT_1 flag for congestion control
  tcp: add MSS ceiling callback for congestion control

Ilpo Järvinen (1):
  tcp: export CE count in rate_sample

 include/net/tcp.h     |  6 ++++++
 include/net/tcp_ecn.h | 12 +++++++++---
 net/ipv4/tcp_cong.c   |  8 +++++---
 net/ipv4/tcp_input.c  | 40 +++++++++++++++++++---------------------
 net/ipv4/tcp_output.c | 18 +++++++++++++++++-
 5 files changed, 56 insertions(+), 28 deletions(-)

-- 
2.34.1

