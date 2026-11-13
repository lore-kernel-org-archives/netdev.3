Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794601600;
	b=JTuKSy8VcOwfxgqOMVLYjhqyMAsVTAIOsD+jTg2I7P3i98DHVGZb4EISCeSLZGgu658R
	 4dO7EMuOu0eIqPRinty29VWt7D1X/MTv9OTYt8g22ryfBe5d7+T/bYGL/cS3PUrnlSW5Y
	 eYgK19pgOWG0V4QvuAeQJTYEDm+lK+u6rztkFZ+ZZ2AoMnLsXfdNCyH8XzSUBeMgJcTzo
	 0vc3daoz2ivSHoUntVXClCJZIAg3geWj6GBwAtmF9GLt5qsqN6zWKLU8EaBWMAKfIF3L8
	 72IdGMac6QKlZVwBTvmF0wRk9AloihjmU8l/cEtF+ZEGrxVFH7F2Pye7XGlvw6ou2FA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601600;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0RDgVkhSi/0wMMlphcNvwt/rdWbZcKkrHiEjMhvpZOk=;
	b=06UXwiXyXw/W9ZIU+6B6iNNR0soSapalNWbOL+76NliSR6SM2A04jbWX3a7MLprG+oMD
	 +jeRyCSlArpmAOPUz911FDpTP4+9ypVYIOPSfmB6Vygq+esqdhwiDVEMQfMLd55WiaZku
	 BZuYNmPpTF22UkrKQPV6SAKYLUfbwOvwSh0dpHce/HgtXb303E2PKmGRM3dtR15yP+b/l
	 6aMo7VZMfDA7ugisHLdySeExLHPx4j287HCKeyqF+lG86stYxSfk6v+tvub8gQ8eLXzmm
	 lEdF+jbq3c3Ywwa0HFxL0J0h5qSmTK7PltyWe0AuydPk8mu70jeLnPAGWti8c8TcTHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=SPcz56Ub;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.23
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E4606A330;
	Fri, 13 Nov 2026 20:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 683E4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=SPcz56Ub
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2imMB3/CvaUzwQuDd+UZ9mUWpORkghzyCQ8R6AwYIysainCpTJUSlx5k3EcCYuiFQodmlQA3ZVn/u3JrHCLP6RSLJaQRaRxJLR3Q76gsPKS/S6pV2ON/ZEQ1/UpeYUWGhDoQzmfpSnd5Unf6XA3Bw7T1s+8mwtRYGZ7Ibhp7OB/p4FjYck6dIrca5jTJWK9FM41w+Kq6oWZdt0cIH5QQ7mSWdgcXb5Eld03yyYhumIRpxgpnTyjmcuufyewxGe92xLIiQz/YtVriLfNcmF2C26JjjXpluHijDtlzjlQ4AiGOyA+CvGp4+Sr6nqOBFIkuFbWVagb0lGzppf2doF7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RDgVkhSi/0wMMlphcNvwt/rdWbZcKkrHiEjMhvpZOk=;
 b=voSebsXc3VX+xkTDykmyySmO2YSnuf2MfwVPqIU5mmvFyuIu1ZLfhpXGoDdHiS5tKTOSLUqCA3HCJOsg/yEmEnbJ2/uKSYIVrW0iUEp176mua7rc7r1mAyzX1NQRZB953HP5FxnEYYvCoER1RZzjrr9LDj8j8RVLNYmYQHboVIyl2Xo5k1cjzyCcOtUuADT3q5ttshOsKHOmiL6cVeGNagmFnUWhNpElm3wAf6gt+0Bo3AGtVwx8fqHU2dvDJNlYRBao0YoFv2EeMr0rB0dNh77I9xPQJHBhPdjSCNAA6KMedx/GlXX9KgQZ0GJo92hiIPir3acEXiTE4BmnXNQ/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RDgVkhSi/0wMMlphcNvwt/rdWbZcKkrHiEjMhvpZOk=;
 b=SPcz56UbEPyLATq9WL0q3nm1mcFfzLo4xI6LGAd8Pjr62MfFs25Jkbxj+opt63h1hXRvaCThf7nB5KzyX+9J9y4TyBPQ9MhEUJesrcFX79jgzNXrz5gx/WaUxiHVT4jVQmdLgmcXFcNaQEfPhPYYwtnB93WxkNqaLpKIc7aFi5BGQpa8SjY7PHq3N5psHsbnsLnsNBv8WyR2Np30sv/8w5DyYla+N7sAR0IC0YqEq1lb1UrULgPLfvLzYfk9Cn7q9Gi/7X/w5qexLZAB1dxnbzqKCKSRZQBOz3a4I8X2zC19UcKszn1nJOcCZkJTRpR23tHtJrSyK3wNaqa+bTahVw==
Received: from DU2PR04CA0080.eurprd04.prod.outlook.com (2603:10a6:10:232::25)
 by FRZPR07MB12363.eurprd07.prod.outlook.com (2603:10a6:d10:1ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 20:26:35 +0000
Received: from MAD0EPF000008A8.eurprd04.prod.outlook.com
 (2603:10a6:10:232:cafe::42) by DU2PR04CA0080.outlook.office365.com
 (2603:10a6:10:232::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 20:26:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 MAD0EPF000008A8.mail.protection.outlook.com (10.167.241.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 13 Nov 2026 20:26:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 50CF056261;
	Fri, 13 Nov 2026 14:57:04 +0200 (EET)
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next v3 1/4] tcp: export CE count in rate_sample
Date: Fri, 13 Nov 2026 13:56:25 +0100
Message-Id: <20261113125628.2893742-2-chia-yu.chang@nokia-bell-labs.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008A8:EE_|FRZPR07MB12363:EE_
X-MS-Office365-Filtering-Correlation-Id: 8194a67c-cb48-43a8-7150-08df41c468e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|36860700016|1800799024|18002099003|22082099003|921020|56012099006|261021121427099003|11063799006|261026121527099003|261022075727099003|261022113327099003|261021123027099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	g06neziBrK7QqLASTiL9x2wjb2/BbC2UYL0E2Kf22guF+0gjmQ8Ri2xfhUDCFoOC8lW1/2/LAj6JCNjSuZ5dDx1RqOEXnSHcuDJlJdqXL1RtluRgab7j8LuUJ9kh/3IaiVKyoDI6AcyoO0h8m2gNmKOfHaeD6qZk4YmficqgbNfQ/vIYMLirO9MvsQktzmz+X+T9FA8kvoY+fka/ls0bm75W3TvVE5+8mnDI2tTZoCrj9+s/YN5tvfkopCC8bSzM/5fQcnkYybQTCza5+kCtUUEY2+BqheBoQgkeWh/fiJwZRsLRI/NANV9kQVf6MV4VG63hkg7EXqcjetyqy/LF4J5/B7/T2IrPFNoV+OH3IJ4GBC796lD9IwjQRO4+Iah5IV70AaFaquhnSmwnFCs4CCX1bqvQRD2if19Oew62aBR2KjXT7ByzELWdPcf23X9kqO3HXkOlTqCmpDzEj3sTlIvzFfBihLltIHm3rYhnV6eC/mJCCtz8Pfhvo+rOUvu4m4qJhEo80RPEc4G7TsQmdz7pdxcJB8KwB9qGwQhebShNELlN808Bml/g0eRGNyxfsdW65AN7zL2q1KhMkWWEEStM07XiyyYDW3br3wwPS9lPNHIbET0zGEFc/X5curyg0UruA4LZ8LpSpbSUoaYfgb4/MJOi0y+Bh5Fd9aW5o+tfu6DfeY1AGGlAASW+gt/7RL3OPy/ppYV6cinQF59aD4+XEtXnIYJm07QjtMU7iXK3vicnrYv6rR1UW4uV9C56
X-Forefront-Antispam-Report:
	CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(921020)(56012099006)(261021121427099003)(11063799006)(261026121527099003)(261022075727099003)(261022113327099003)(261021123027099003)(261102123227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oR8VZt28hd42JI9c6UcnkRGRoVXfiKbv/DSgnjQmhVql/FYrwJYpBqEASL3j4XbYzigrIgG+QZTINzQqaSqJak/mzLyAL7vCamt63OPkj1KA0zksQ8qLnDlihiL2XEGkGnwk4hz3TkCbBKlfgm1KJcK7uGjIKEXsP0oGfzWC6YVT57JeZfuavKqIhu7+anJbfQbqDUAlYk+jLuwFKWY/139bzbTw52soX+UYSkQlDtbGgDPzmRKgB3RjeDjrxtREFxY5Z26/3Oi3PHGuXBJ5LCl6k1rShpPlTOSGcYQEADpZEpxYbBbJBgJ6DFOPq9aNiNzmsVVzuxkxmcVYPShC17dtFAfe/dOYlaD7g7W19fu1Nzx5/QmoNgFBrFJOIdRQm/0bNCUGP7Hh+EzC1zGcrofAlDQXwHcn+EdOHk5nwH21IPdwQnRjRGD3LAfNyrRn
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:26:33.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8194a67c-cb48-43a8-7150-08df41c468e0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MAD0EPF000008A8.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR07MB12363

From: Ilpo Järvinen <ij@kernel.org>

Store the number of newly ACKed/SACKed CE-marked packets in rate_sample.
This will be used by upcoming congestion control algorithms, e.g.,
TCP Prague, that need access to AccECN-derived congestion info.

For RFC3168 ECN mode, acked_sacked_ce equals delivered when FLAG_ECE
is present. For AccECN mode, it carries the derived CE-marked packets
from AccECN options or ACE field based on RFC9768.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

--
v3:
- Improve commit message
- Rename ece_delta to acked_sacked_ce
- Remove redundant rate_sample initializer
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 40 +++++++++++++++++++---------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 25d11fab1b03..4b1159e6c125 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1353,6 +1353,7 @@ struct rate_sample {
 	long rtt_us;		/* RTT of last (S)ACKed packet (or -1) */
 	int  losses;		/* number of packets marked lost upon ACK */
 	u32  acked_sacked;	/* number of packets newly (S)ACKed upon ACK */
+	u32  acked_sacked_ce;	/* number of packets ECE-marked upon ACK */
 	u32  prior_in_flight;	/* in flight before this ACK */
 	u32  last_end_seq;	/* end_seq of most recently ACKed packet */
 	bool is_app_limited;	/* is sample from packet with bubble in pipe? */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fe21d30e3094..92f5a011198f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -616,9 +616,10 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	return safe_delta;
 }
 
-static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, u32 delivered_bytes,
-			      u64 prior_bytes_acked, int *flag)
+static void tcp_accecn_process(struct sock *sk, struct rate_sample *rs,
+			       const struct sk_buff *skb, u32 delivered_pkts,
+			       u32 delivered_bytes, u64 prior_bytes_acked,
+			       int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
@@ -628,11 +629,11 @@ static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
+		rs->acked_sacked_ce = delta;
 		/* Recalculate header predictor */
 		if (tp->pred_flags)
 			tcp_fast_path_on(tp);
 	}
-	return delta;
 }
 
 /* Buffer size and advertised window tuning.
@@ -4248,8 +4249,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
-			       u32 ecn_count, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, struct rate_sample *rs,
+			       u32 prior_delivered, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -4260,8 +4261,9 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
 
 	if (flag & FLAG_ECE) {
 		if (tcp_ecn_mode_rfc3168(tp))
-			ecn_count = delivered;
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+			rs->acked_sacked_ce = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE,
+			      rs->acked_sacked_ce);
 	}
 
 	return delivered;
@@ -4327,7 +4329,6 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
-	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4441,10 +4442,9 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	tcp_rack_update_reo_wnd(sk, &rs);
 
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb,
-					       tp->delivered - delivered,
-					       sack_state.delivered_bytes,
-					       prior_bytes_acked, &flag);
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4470,7 +4470,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+	delivered = tcp_newly_delivered(sk, &rs, delivered, flag);
 
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
@@ -4481,17 +4481,15 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 no_queue:
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb,
-					       tp->delivered - delivered,
-					       sack_state.delivered_bytes,
-					       prior_bytes_acked, &flag);
-
+		tcp_accecn_process(sk, &rs, skb, tp->delivered - delivered,
+				   sack_state.delivered_bytes,
+				   prior_bytes_acked, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4518,7 +4516,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, ecn_count, flag);
+		tcp_newly_delivered(sk, &rs, delivered, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
-- 
2.34.1

