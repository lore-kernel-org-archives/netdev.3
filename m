Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605803;
	b=CJKXsD+ywpT5TipBTswUDAfSFRmmCsF4rpTC+KawJD3rwMFXj/4D+aXsxWm9Dl9dLtiA
	 uoQlU5IFj9rdNBHNc4r+cKdrNbpgUulh0daPP6z7glnW7zPVGgSJK9az73+LmjRXihg/i
	 ZrVksKh3u9fzCdzR6MVc83p6dy5pMf37cUoZAdY44nNvUULDn0A/9UlyKD0hdB890k7eI
	 GZYbI5hbNWEmS2oUUDn7DoltnJdAoEufsuNiETCYG+DL1YhnYQz5iCfG53tqUHvyHyxbA
	 gQGd1u+uX14NvqHspPAUwQr9Jz4XV7YkOGbt9MivTBOnhoJP2+c9YrhymnyGlzcn0Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605803;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=elh99CQp9IfkfP6c6rVHcWjZMVI/UtW+jJfkl3iJqq8=;
	b=aXicrK0IVeQzn5goJODSgmbvF7F9BQ/e9zaFolGGfNDEjxxQrpyZ/iRMDCCSVjgqziaL
	 F1DuMPrbweCJPd+zycylbFmzaiUeopaqJvp+21YEJm8y1W/Xy/f865EUVkHPcBVN/dYCQ
	 HkrYqF9Kiz1N6wq6bJ7P7HWYk45CYA35cCgj1IYv359GDDZzeBRA9+3blAEe2mYmrwoJY
	 +kNWmN54W6t3BNS7lVr7GNR3GDY0TVWQW3bhIsulTPV02fspT7tVIhasqOdnT+amLjBW9
	 muAai1u4iwtNx6IzWAmhPVZ4sHphQpWHG14z6FyvqDEkS8OdFil26LeYgeHsoGinL5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=Y3azZvqc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.47
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773D606A334;
	Fri, 13 Nov 2026 21:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9773D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=Y3azZvqc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCZNJ4mvL6a3v5hfbMgNoF7eSSiKxhKHFXY7Scnh3dJrkTiOnLrQ+8Ck0yNsbWu0DrtMfAMmyNth8DlubQB1nKAhTzH+nzKjA8dXpXYSPFsROfL2kQSocZL1dAxU14i5n4S3C00vENOK9cL/D7RekVl0ziG8wxW26i7B/9r0bDLmtI2nuU6kwM7k3BEA/nnJPJnsGaLYj2erZRl3rs8o4JSq5qzKFf8Cb8ncdR+SqtcK6gs7Zjt6S0JYbLwIYO/tZKmls44n8+AEDOI62kCdUzQiiw6U9o/GJDdnhfcZ976Rxhkq5vcs2RD9UHNShnEcFHt+guWcJ6lKcLf8PS4JHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elh99CQp9IfkfP6c6rVHcWjZMVI/UtW+jJfkl3iJqq8=;
 b=qY5hAaFFdJYWak8fl9vmx4ZCzFM+tJVEcbdOBMm1LUwVvim72z4WYt4522bGbr3iC3GBvWDI6bYuWJicWw7QMsp+FoEaiS8rKTPKKTefEFU2+OsLIslgN3sLb5DWHzXwVnSpDBTzuT8r1MvytmkqI4WV8o7IbfJNm+FMS2agpRW/L4gMUFCZ0PXpsZN/P5j4pNsjZ4oC/TmzRvUmHB80WcDKTCXLJLopON2PS9qwOcqZB+HkAz+IuZC6wEYfl7utsX+3XuxKXU0NBkvCWBUXgr158raLc2tx7+1kt+qaScXIkD5d6Sm8ZFhklcpWCyhUNtdIn62cWL+/IIMl2bUs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elh99CQp9IfkfP6c6rVHcWjZMVI/UtW+jJfkl3iJqq8=;
 b=Y3azZvqcUYyiQgrm+y9RBZAp3+3qM4Rb6ogB5JybDdbaKZQhRQT/TQmKo57GydlmSmAErxo0TBCuQNwLPRf1NMwOhG6r38tGpGURs7Wp1EYzwk4daEyREYM8iJj1QWnM6sYDdBE3vN0rhrjwMCganKnTm4wtnt7apOyg4NKUDCUJjMAyS1Xr19WkUFa1Cf+ttSLAZ++8yS08buK99dOcE2Aan3WbURNKIqeBzdzWs7XW9jTLKEfKhyDlEDiNgK443cDJMybbdkvOtU2+4ld7V4E17wg7rk3VTo04WgPtC69cj8rzAhdS/fbtkePMYGRYPC3eCzUkSKxSxWyExNyGqw==
Received: from PR3P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::11)
 by AS5PR07MB10005.eurprd07.prod.outlook.com (2603:10a6:20b:681::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 13 Nov
 2026 21:36:38 +0000
Received: from AM7PEPF00000053.EURPRD83.prod.outlook.com
 (2603:10a6:102:56:cafe::2) by PR3P192CA0006.outlook.office365.com
 (2603:10a6:102:56::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 21:36:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM7PEPF00000053.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0
 via Frontend Transport; Fri, 13 Nov 2026 21:36:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id CDF0755BC6;
	Fri, 13 Nov 2026 14:57:06 +0200 (EET)
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
Subject: [PATCH net-next v3 2/4] tcp: rename ECN transmit helper function
Date: Fri, 13 Nov 2026 13:56:26 +0100
Message-Id: <20261113125628.2893742-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113125628.2893742-1-chia-yu.chang@nokia-bell-labs.com>
References: <20261113125628.2893742-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000053:EE_|AS5PR07MB10005:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fe915f09-5b0c-44db-85b7-08df41ce325d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|1800799024|376014|82310400026|921020|261022075727099003|261009223027099003|11063799006|261102123227099003|261021121427099003|261021123027099003|261026121527099003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	9oYwKZS1sBWoZjPTo0+HoZa2cLYpVHEMAWNbbhHXNaOPEq7L/Asfjq7Jcw8ambpTzDaJmTTj9b906cvTImaY1W7tJWusoqzyyNGAm2mrLKN4NHIamtKSPnxZOFHtdqriUV1ar4GhXrzV5u8zdwf8TOsvoKcKSU4Qxo7e7Hb73KVU8HDjwsz2SEeGj9cgKyi32ybRckOO8HPCnnDqQixGc+DbozQaCXEBNHTvaOzdv5beR65d8n4tTtZBgxvi9RcHsZLXHvkO/iETepr28Kd5xeTUNT5/Ow07njCYF5e61F5LKN2M85xlTv0i9DRJaBADjP56Aj4FWN1G+nsSoDAI+2XFO1ZkhP0W+pGFAY7zxOG7b1/I8VKd8/QSrzvUbaHsIx6C60Uttg1IuFufkPy6seXC6+YCJjqtcQ5ICGQv0sA9X2lwt5ewq2yCKk7oVPz7sLJMgTgF1/YE6libBBfSjmUODMKmGUgC92RcAn9T3a/8/pa63ekng8kxSKVe2MeHqrsw1K7SioyBkl0GdhQgNu9dxNCkoVoklfDdMI4AD8Fcl+xcP+9bPxQRqtFsdr7oRUZQAPejEsIou3QOnCrtKTFgdstswUUtWIMK2J6Lv7ztVR3cNX1UcBgVtnusNJ2qDGcWJEC78T7dL3dRvtn10VXYQ8Puo7WvGmjvkDpNAOCXqe0njvW45oygOcQXRwyjMG7tUTq7iCwoOfFgkEPL2BUIN5QLyyZ6t9efuccOHs+0Yq/WdKxIaVUmXAfZiGkr
X-Forefront-Antispam-Report:
	CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(1800799024)(376014)(82310400026)(921020)(261022075727099003)(261009223027099003)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(261026121527099003)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	byazRfgwFn3E9WDW0xFbQOtRtkuxZZlCiEIroQ/Fs9S3jQHOlLTZs7v4nkBLNfQYgYzVkiatLtVykx+zCqCFBWl7ml8/H867ahV/LNr1VpIt7K9HHXfpoi4wLJXcayWnnuiBCtyS7ZJ8jbm/znnltWPklkJzc4wMlS8kFQ/oooE4Gu0RVW3NjrGU2iMoIQHnTYBeAbnKOPGB/YKdrcnYtpZCj0wzCfAGWmDnfIHEHlH7Tj3BfcmJVonoOTeKv1KDG0u3emaGhkaYtdx/Qws0H5WB7+4k8t2TBQA0DZVsFqtwp9U2tD1m9cF1N0fD+sgo+efpJKwmn33w2kxL4u2vp1OFDvI8598jKFj113sA4zuqD/ecpe8Z2HB9R0tqkLkUjIdAor1wLT49JD4dIROuq+EqjExOumN4PFHBrHYTCgd6YiQO9jywA64XPL/T+jJW
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:36:37.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe915f09-5b0c-44db-85b7-08df41ce325d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM7PEPF00000053.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10005

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Rename INET_ECN_xmit_ect_1_negotiation() to
INET_ECN_xmit_negotiation_ect(). The previous name suggests that the
helper always uses ECT(1), while it actually chooses the ECT codepoint
to be used during the ECN negotiation.

This renaming also prepares for the introduction of a similarly named
helper function for established connections in the followup patch.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

--
v3:
- Rename helper to better reflect its behavior
---
 include/net/tcp_ecn.h | 6 +++---
 net/ipv4/tcp_cong.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 865d5c5a7718..9ca016d98972 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -33,7 +33,7 @@ enum tcp_accecn_option {
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
-static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
+static inline void INET_ECN_xmit_negotiation_ect(struct sock *sk)
 {
 	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
 }
@@ -583,7 +583,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit_ect_1_negotiation(sk);
+		INET_ECN_xmit_negotiation_ect(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -618,7 +618,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit_ect_1_negotiation(sk);
+			INET_ECN_xmit_negotiation_ect(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index e3f462f161dd..3331679c81d7 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -228,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit_ect_1_negotiation(sk);
+		INET_ECN_xmit_negotiation_ect(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -258,7 +258,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit_ect_1_negotiation(sk);
+		INET_ECN_xmit_negotiation_ect(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
-- 
2.34.1

