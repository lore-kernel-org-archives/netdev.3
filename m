Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794601582;
	b=rFzX/oia7eWuHB1MPKfKgycSwGjqW3+wRwpgFbabuv4wz/0xfUMDrewEUzaC1VmCHOS3
	 SAF2x9kRQSu9nIYM4RYzPiYj+FXVc5zEHOqhTSp1R3xm9UO53LPe+t7PhdF3W5Wf1WmHu
	 Y9tRQinkVpboCVHL6Oo4oZuOyCjLeFRoXmTAfakUUkApUmgYOtYcn8Q7uHbgGu5EqdGZA
	 Tg8MdTa8+JJRjSjJKxjoQXp1M1wHy4HF0ZwMpddOQhOICq027x4uNoNAZeDye0u4XqT4M
	 S07njWZlgyTtnURtp5Fsuj+iotxbH260Kvq/2bhBDl61GrK0VJhEWIkKUnUtlDdOsLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601582;
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
	bh=wwk5eF2+mMKXqIe+VtISN1H4/bzuwk2VGacuFAA5OwE=;
	b=LKxoW6K8IdkWlESVFfWTyNcMlroxJM8refHOoGKjL5kJ6rgTfl/4T0TiltNqekve7tYE
	 yojZwg1+HH77HRUVL7ACUv4FLBirhv50dZN7TdXGbdwCVB0dVExUeKaYVIGzItiS32rYS
	 EYxjYKbk/FVmFYN4lCTqlfxBad2Pcg1eZbYwquJJEW4JRfLo3hhiooW1rUoU22j4fAsOt
	 wOQwfiRFWVnykMW4Jti7XGp/4QxrJnJJaquKs1aHCEoxcwjr6Ir2Le6a8JACt2m1bgO0c
	 DWGwdveGBt8ZtqEEHisuLZB7kiQ8XWpKp6DLfkMG8NExMtn09r2fZbdG+o4ENGTlV2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=EOaPgsvQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.30
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D2606A335;
	Fri, 13 Nov 2026 20:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E3D2606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=EOaPgsvQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5/u0s2lhUNi79myt7Zez6ZYzd3zMAkeZ1nDW5C7aTrLN49dyoNFCiTB+P971gXkFMDOsQbgNeYem7crb9OiKbRprYRBYji5obT8o/LZkye1/lTn2tGcNxatEsakqzcG4qbKmMDlj4cmfBZ0YoIO2yfNdzeKVZ3idn+qcm01MdK03VFYpsEcaLpA+1jQw3mMyoJmlHNNscETuuH6ldObkS+2lw5qrS4nUv+lv97SuLsFJjgeTjtafxa4JM5ttbTI2rhNTjwKQ3tLV2eOqvm3AJ1y5PhDpYLK2HFsY09XTGYf69o00PXKsf8miBspPYDkJnMyzY1R81yVxnOz4riJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwk5eF2+mMKXqIe+VtISN1H4/bzuwk2VGacuFAA5OwE=;
 b=nBMgUDOlOJQM9P5o5rH+gowPLPpnByqxB1Gy6i22cB8RH1S/Nmju9z6S/JLC7J0g2gQxBJBdl9YyronHiYRSwyLrVMYJHpyW954Z+uk9G6L/is8mSfiJlEy6Gm6zr7fqkpM/Bgbu8lk0MG11gDHE8zn8w5v6cmnilo8oz0Opa/tYorjtFhX3xP3urUlLiXIaxDGpkua5iq9JTAoxT66gkAuRKIqoxmGE/rqI776lYEIVNzenZW+HqAvt+D2PNttCPDuD0CMfjr73Q/PUgkV+FDNQrJHf7eQAc6nefVWKPCHVJxGOTHWJXZXJcDEQ6o1rmJS4lj3aix46yaVMEIIsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=davemloft.net
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwk5eF2+mMKXqIe+VtISN1H4/bzuwk2VGacuFAA5OwE=;
 b=EOaPgsvQDL4DXR368JPlRBbDG6MHvU7l3zoslYj3GAiwuxf6MyPcee+5ByxZfnWLOev1P09JSINyxB3dkrlm+Fsx3CP3THIWvFDlr7VH5BYAPRj81x470E3dO7D/Bq4u8WqElZlvjmwHHt14tddEjLGFR7ir3qXGg9ntQ1rgrs2LEtgFpJ2Ci/3W909jd2djDYXy4gW4515WLB/4/HbwFKsEkscMlS1PL7ljdjMLtggXXdmnrnJzC/2YKqv0ruJx7CXDp32GVv00c+hX19I8D75mNrESkATLddImnNjr89aQJUKNS2MUin/JK+ATAck1uWkGdZQgf2MaGISdLBQuyQ==
Received: from AS4P191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::28)
 by DB9PR07MB11255.eurprd07.prod.outlook.com (2603:10a6:10:60d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 20:26:14 +0000
Received: from CPH1EPF00000530.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::69) by AS4P191CA0045.outlook.office365.com
 (2603:10a6:20b:657::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 20:26:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 CPH1EPF00000530.mail.protection.outlook.com (10.167.241.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 13 Nov 2026 20:26:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id AC8C056265;
	Fri, 13 Nov 2026 14:57:11 +0200 (EET)
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
Subject: [PATCH net-next v3 4/4] tcp: add MSS ceiling callback for congestion control
Date: Fri, 13 Nov 2026 13:56:28 +0100
Message-Id: <20261113125628.2893742-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF00000530:EE_|DB9PR07MB11255:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5096c10f-2cf3-4c8f-ea54-08df41c45cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|921020|10067099003|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261102130727099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	OOgtSwmo3fkFodCKPUOSuUawo0nXPnsST/6shFPE75bglSfzEBrFjMgyUjSNTZxFGWRndpdENVQ/ZC7fFNACLLlqAsNzQXOYGnzeoIvZq/13GdOzV3tMEl8j36HjrxeTVwVDbVZ6JmDlw82PpzQFsrzbeq08J7rTmfZJvnOWVFISliiG6r5oa4pwoRcp3hr+EWDiA5922lhTv7vv12mN0PWAZtRdXNkbinLqRwLihah7rMrz1UPqraT7A5DpRfDFXDPINoYW1cR2AweYEfUsyKpI4Aenrg7JPiTQKOJKscz9nhkVdrefMrgG/i83DVhuAjBTqIDdTP5yGzlxPLpuo8GrQArJK2YPMjLAKlVQNyP0rZC0wsI38C9xctM4UvHMekQWUTlMY2W0hwGdgpGefFANjqCcEiMr35tqoT2L0a7hsJj8k+7IF6FQAqKIpcfuaCbBy5vR+B9AzUsYrSRPOcJjrHj/+zVf20GiWcavbizzUvPxmPxtxv1cWUNfxRoS/lVsIJEYlyOl3uVzb9LOZDdyDdGKqggonJDSRhTkIwfYwiK5qZJ736d3utUeVGcY8JnTyJpCm9FTRp1WYLRP9jD8v6tLUOZElFz7c5KDDWMbx+56/AysHblavadma7seeQByWyLfBrgiUdWe5C8zGTu8cDnGENKtc533JWLsRGp94c8P9PsD21zaaIqeVwxEHOR9qaQY5BAwRDYH9X+6aSWfcNjrV0l6wt7W9pHNWCEd63+usWuOnrjqEBC9dunX
X-Forefront-Antispam-Report:
	CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(921020)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261102130727099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bvFlgIZ5OXZvzp+LALL9ZYru/Rmw2JPWLsjtGvwaF81kAy3KFT4CqzWPEx8KonYK7B+pUW5cN3UKcgYdCmafytGVAlNoPtlOdTTvED2uOWwRPWwyXU77RKjkG6pZk6E0WNusfvZgFRjdexDrhU77o/OTajl1XfJTMIdbj9yjRg9iSkC3xUVLZC4Pj4d86vXFAPLb1NeJliVZhnWYjQ0R5dYnhmEjnxOCgM+6r1w7J4mKNo2bIZI5IzLx6iUA8pSsfF1GQI/pnfh38FXNxySPw7K7fwaQJC1aokS9gRcf43gk0dANQ7YBiWesEEnOu0vH5U1AZNMS1RAA95istYUoTmVPqUYchlqVL18jzVa/AJNL4AWVb280r0sAn3fKUDeZM3ob77K0dNYONmXlH7yXe9MgAgrRw9UVcHk1jI3mM4yUKwp1aQLdM6KkEAl/D2/d
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 20:26:13.4007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5096c10f-2cf3-4c8f-ea54-08df41c45cb8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CPH1EPF00000530.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11255

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Allow congestion control modules to provide an optional MSS ceiling
through the new mss_ceiling() callback. The TCP stack derives MSS
from PMTU discovery and existing MSS constraints, while the congestion
control may further reduce the effective MSS when needed. The ceiling
is applied during MSS calculation and remains subject to existing PMTU
updates.

Also, tcp_update_mss() is added to allow congestion control modules to
request immediate MSS recomputation after changing their MSS ceiling.
This will be used by upcoming congestion controls, e.g., TCP Prague, that
perform fine-grained rate control at very low rates, e.g., below 1Mbps,
and benefit from reducing the effective MSS while still preserving normal
PMTU handling.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

--
v3:
- Replace mss_cache_set_by_cca with mss_ceiling() callback
- Add tcp_update_mss() helper for immediate MSS recomputation
---
 include/net/tcp.h     |  4 ++++
 net/ipv4/tcp_output.c | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0242fd6bbb07..9d398ae09015 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -858,6 +858,7 @@ static inline void tcp_clear_xmit_timers(struct sock *sk)
 
 unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu);
 unsigned int tcp_current_mss(struct sock *sk);
+unsigned int tcp_update_mss(struct sock *sk);
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when);
 
 u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
@@ -1417,6 +1418,9 @@ struct tcp_congestion_ops {
 	/* returns the multiplier used in tcp_sndbuf_expand (optional) */
 	u32 (*sndbuf_expand)(struct sock *sk);
 
+	/* returns the MSS upper bound (optional) */
+	u32 (*mss_ceiling)(struct sock *sk);
+
 /* control/slow paths put last */
 	/* get info for inet_diag (optional) */
 	size_t (*get_info)(struct sock *sk, u32 ext, int *attr,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 7b694479095e..f70dddd7283b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2062,6 +2062,10 @@ static inline int __tcp_mtu_to_mss(struct sock *sk, int pmtu)
 
 	mss_now -= psp_sk_overhead(sk);
 
+	/* Apply MSS ceiling from congestion control module, if any */
+	if (icsk->icsk_ca_ops->mss_ceiling)
+		mss_now = min_t(u32, mss_now, icsk->icsk_ca_ops->mss_ceiling(sk));
+
 	/* Clamp it (mss_clamp does not include tcp options) */
 	if (mss_now > tp->rx_opt.mss_clamp)
 		mss_now = tp->rx_opt.mss_clamp;
@@ -2082,6 +2086,7 @@ int tcp_mtu_to_mss(struct sock *sk, int pmtu)
 	return __tcp_mtu_to_mss(sk, pmtu) -
 	       (tcp_sk(sk)->tcp_header_len - sizeof(struct tcphdr));
 }
+EXPORT_SYMBOL(tcp_mtu_to_mss);
 
 /* Inverse of above */
 int tcp_mss_to_mtu(struct sock *sk, int mss)
@@ -2190,6 +2195,17 @@ unsigned int tcp_current_mss(struct sock *sk)
 	return mss_now;
 }
 
+unsigned int tcp_update_mss(struct sock *sk)
+{
+	struct dst_entry *dst = __sk_dst_get(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!dst)
+		return tp->mss_cache;
+	return tcp_sync_mss(sk, dst_mtu(dst));
+}
+EXPORT_SYMBOL_GPL(tcp_update_mss);
+
 /* RFC2861, slow part. Adjust cwnd, after it was not full during one rto.
  * As additional protections, we do not touch cwnd in retransmission phases,
  * and if application hit its sndbuf limit recently.
-- 
2.34.1

