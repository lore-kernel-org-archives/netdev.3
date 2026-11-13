Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605225;
	b=qhpm3bcFjlpwbOq+xWJvVbai/AyiY/a2i/MxNsloT8jlBwEtLKAnEErXC61u1fk72mGs
	 Dl80xZuYBrGL/pG9+v09KEIg2JHr5WMSm6ZiBZiBPI7iQqP16FTgfYSs1kFXSg1qga9rJ
	 xzI5/A4zNHu3FbG4YBuu+Kf0PVxkgddxB/7AZ+Dv1eaQQJLRiMGXaheuTgw9sdcV66bm7
	 J98TuOP9o5jiay+b2mK6xKWAbn0BO4a+5VWl0xP4uwL2vHUg5wzrVxFF5gpjaKRy+hbaF
	 hqwtbDWK3CLFyxLE2ZGap8EidntGgTjoe3x9ZJjM/A/8jtbISJJSRt4Zh6u7wf/JWnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605225;
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
	bh=Emax/NcE05afarsrgOa4WJsnCfOvWJQ2DKXwhR+o0c0=;
	b=2CoceJfGhdW69HPpnOrwLyspOuFc2yRH8XDHUztzYDeIf3dEf9FOoQlYKXrFG78KfRsN
	 QWtbhiU8ZjDd+vBrszikSQ9cpgWNS+Ky5TtOGRqhBufR6NdJU59wElerfmq4GD8HqzwaM
	 s1lGEGugvg1AbLDX/h1Td5soLLzflGpKRsXk+C8oXv5g+wdan8dNmoA1vUtUGAOkLhRs1
	 Npv+xuDMH9fGK8Xe0vn20eRmLQ/uyTHTi454Eb4iiKrGR/JFHT2f9gXStiZcD4ucSr3pT
	 +VbNzI2f4p9rYbxZuERSe6SdjGMQ/gZ7XeeZQfSOnBo/WaASIuNHXhA7okmdUGrf8QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=YBQnegfg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.15
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AC606A89A;
	Fri, 13 Nov 2026 21:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 934AC606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=YBQnegfg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqoyB6pfcqTR/ryzFQt7r/tct/1ojOuB+snUwjhoZEFxCHuVeGbdXUgzIcSSVvAijZbeHjjfv+K12IVru2R9/YFm3IZLhdVo/+Pse1X8wkQbpVLuWR3P51Vufab8y35pxL/1W7WdR+XhMDO6yroreBh9chaStdahq8+Wp5UrSH7n6i6EFQu58uupOAhBgZrPEKLAmSatvi/falv7kJtagR8JdgYEuDtNNxuA0YdvBBW4tgFyj/PMmsJEN/uaPc3UGlfc/5widKEzhel3IrnjhehXmuHU/i5tys3FE5TscEy0ZNqBQRvUOcgABXFdTsyV3/25NngIdV5cOFs6hGH9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Emax/NcE05afarsrgOa4WJsnCfOvWJQ2DKXwhR+o0c0=;
 b=i40IvxxkMw7ZZfgx3ic9UjNhsiVLIRNx4OvWE/ikcAr1Pv2PkdyDfvxq0UmGLQZupAIwvIwOJpLp695LaZysmenySHf6iEgAQl7wiwH4Z50WcJwa3AkffD634lfa58XBM7upxTijUySMLFpUCs5dGq5IjiO9RH4X4P0Yg/sbavKNvTWFlcHkBTtw87+28fLmN5K+usTrEgCzJC0woHyvFhkaT/C6nrP5CPqBQsg7MukRQOFMH59+LSMUdtJoq2hEV1mzT272S5ww6/kdAVmw0ZC44fg9p2L8O5be5Vw2BJvrppM2jzjhunmeP2L9qkgPZzsUzzK5afpruReGoz5tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Emax/NcE05afarsrgOa4WJsnCfOvWJQ2DKXwhR+o0c0=;
 b=YBQnegfggZLNRi3U7tQUt+E6eFqnbp5oQOnSXXC2J4Humu0uFHCYGlTOK8uGr9hDgFhQLekqWmFMxlJBPuGMyDBH2ff4cpb9f87/TqLdeLcn2McJFoWYkOU/amZLtmcPyrW3Vz/Gj3QrI2UgN5Rcc+uDtP0hM6iJn7r5u6+FzIwkNwZ2ZnEb2TsjtNJggi3HgKpwB2b/DXQ7yexpBG62ygQEMa2JYXhccoeD3EjuRGipIdd9IoWYR5+V8vmszO/jnNiYnyODFWtHJ1vvJT5asDmCOuoNLbeOAm7cKjw4aKwCg4qPMiljQZJgF8dworScmwxl+1qHHy0GTVX8SOswwA==
Received: from CPCP307CA0004.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::17) by
 GV4PR07MB10953.eurprd07.prod.outlook.com (2603:10a6:150:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 21:27:00 +0000
Received: from CPH1EPF00000521.eurprd05.prod.outlook.com
 (2603:10a6:380:0:cafe::2a) by CPCP307CA0004.outlook.office365.com
 (2603:10a6:380::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 21:26:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 CPH1EPF00000521.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 21:26:58 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 788C523BD0;
	Fri, 13 Nov 2026 14:57:09 +0200 (EET)
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
Subject: [PATCH net-next v3 3/4] tcp: add TCP_ECN_SEND_ECT_1 flag for congestion control
Date: Fri, 13 Nov 2026 13:56:27 +0100
Message-Id: <20261113125628.2893742-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF00000521:EE_|GV4PR07MB10953:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e26dec92-7ce5-4bd0-4750-08df41ccd91e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|18002099003|22082099003|3023799007|921020|11063799006|261021123027099003|261026140227099003|261028144727099003|261026121527099003|261021121427099003|56012099006|261022105027099003|261009223027099003|261102123227099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	y55DwBc64RZEKmf232qM/qUjTbBIBZfoDG8jErFeU+ByjGJ6KAMS6Fq1GOVYOAxaTq+odSSgR5gXdW3Kmpq5U4XVtiThpGgOq2lhWv5mHajezHLkbvblP9SVUUUEonb4gOS8P30+6IH4ZSCdlGaZeM4w8knSqU/uvisheNdKUJ10KR5Se81P5eQWazLduoIOGXVtUrgSjAfq3sVDYUgopTrOR3G+OtjFuUFIMT3+3AkCxg88ZBXL/ebF1Q068F2UEpainutw7rxtaafShxk4GaVRDQZQMK7Plawd7TfAOPKXm65cADFwOOHQkKbxVQR9PEukL/dNU+TpW96xrdx/gjN6YVgDKglGDw6KW74TLYlvbUnxQWhAKxRWixcw7GHxORYT2SpnwOl1xxHpViXbdj3M6SVjZ84fE++WGHcpUoRaZ8/OMbSYdIZWshCdW/Sd7j99r5+Tx9bVogC0O5XaEmCAxLSei7v5ibOW4sk1HXdLnM3sfgi+N2pfrGoTD+pCW6AffsUJOpjNORT5W0W7pLs0c36fYG4d5QsQce4dKjwf/63SZaCq2U7SAPSy3GWTBlZKLdo5SEeFbUrAbqMKGcITaaqweARXK4hcVV3A5RTB6k/P05yX029GUlJdF7jGKZqXNDVbx3FmwDIUjEhq5536OEVSQHNXdAu6ThclvnJjrS/McCsu3AEcfYHlZfdqLG/LHfZkSs06kA4h60ffj8ZW1+gIyebhBEA4/ot5GqrKjIUpkBjvQr4oprf84hPz
X-Forefront-Antispam-Report:
	CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(18002099003)(22082099003)(3023799007)(921020)(11063799006)(261021123027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003)(261102123227099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SAq7Zze399c5+TnsHZUxsMEfwzN8PKLY3W6coo6Yt359Z/pZScL9I69KhCWk8RK/bBIuU+cwvtveu03ze9n/ul49Upg6cJPxPvSjtWGJzYwFDmq1rUiDR28/dhRpfiedYCb2qVe/tzSXwuWZtaCQtTuWBOzlSjLmZG2IE0ZvlG40ol59dk+VLpL3eJn5XOoMmWYt1a09mDlgMF0bogVX+l1xPQ9CcYT4ObNHnrEwMqwKa5BUvTp0AIckXzux3d/qiZXJIqHItwtoDj6xLN1MYUoA+c3zJy30jAYzSEu2kM5x741inzG2jHdyYzpEA3xuGf9D/2EHCf8L7kDBNyvk26rFjCxa2ZZQmGN9knuA7bybmN1PX88G2Ijty5k4Tcf6Xbu/gn2EwXPzxFIwM1kWmrvK0OIAR4dU6SZc11nuPtv9ncGFah7apyQhXhgBY1kL
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:26:58.0515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e26dec92-7ce5-4bd0-4750-08df41ccd91e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CPH1EPF00000521.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB10953

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

This patch introduces the new TCP_ECN_SEND_ECT_1 bit, which enables
a congestion control module to control whether the connection
transmits using ECT(1) (if the bit is set) or ECT(0) (otherwise),
when congestion control is initialized after ECN negotiation.

A congestion control module, such as the upcoming TCP Prague
using L4S ECN, can set this new TCP_ECN_SEND_ECT_1 bit if it
wants to send the ECT(1) code point in outgoing IP headers.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

--
v3:
- Update commit message
- Update flag name and helper function name to eliminate confusion
---
 include/net/tcp.h     | 1 +
 include/net/tcp_ecn.h | 6 ++++++
 net/ipv4/tcp_cong.c   | 4 +++-
 net/ipv4/tcp_output.c | 2 +-
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4b1159e6c125..0242fd6bbb07 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -428,6 +428,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_SEND_ECT_1	BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 9ca016d98972..ff402cdb988d 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -38,6 +38,12 @@ static inline void INET_ECN_xmit_negotiation_ect(struct sock *sk)
 	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
 }
 
+/* Apply either ECT(0) or ECT(1) based on TCP_ECN_SEND_ECT_1 flag */
+static inline void INET_ECN_xmit_established_ect(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_SEND_ECT_1);
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 3331679c81d7..43b0634f7673 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -240,7 +240,9 @@ void tcp_init_congestion_control(struct sock *sk)
 	tcp_sk(sk)->prior_ssthresh = 0;
 	if (icsk->icsk_ca_ops->init)
 		icsk->icsk_ca_ops->init(sk);
-	if (tcp_ca_needs_ecn(sk))
+	if (tcp_ca_needs_accecn(sk))
+		INET_ECN_xmit_established_ect(sk);
+	else if (tcp_ca_needs_ecn(sk))
 		INET_ECN_xmit(sk);
 	else
 		INET_ECN_dontxmit(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 08d0d4a639fe..7b694479095e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,7 +350,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 	if (tcp_ecn_mode_accecn(tp)) {
 		if (!tcp_accecn_ace_fail_recv(tp) &&
 		    !tcp_accecn_ace_fail_send(tp))
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_established_ect(sk);
 		else
 			INET_ECN_dontxmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
-- 
2.34.1

