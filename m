Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953F480DDA
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280368; cv=none; b=N2shiHsOfet/J1lYagJKkHoDA1Givf2aaLC6kUfPPVIbaJEyyI1dKV4mDpEqiNAOxvLt+/LwESOEcbH4eAgpFxx82vkEAA8MycBQoVR+rg5c1LpwSlPxQqQe0hocJYocrsXlEFiRxjxLPoPp7ianw0gPwHHQBe+vToGI824DXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280368; c=relaxed/simple;
	bh=BZgGViVjbPQGYXtFEDayGxPACR4KC/doJcmK7GuYL1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHTxAKODdPtXyazyo93IwvyE2s/+ym7SK59FUPx0JhIObH+PVO8GURo7ekUgVi3Zn82KWCiL6m5y9Fh4NKijdOMQvX/ZLyukDjK6794P1FlGsuM/1VFHj9wE5Qej9wWi6O/OUOBvKgP+RE9udxrK9OmjUuY7DslD6yJz4dcE/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iAKp+XfD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NnpDZ/KS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iAKp+XfD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NnpDZ/KS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8W9R2746429
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 16:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BuKOZcrHKSXcLVc+QoGKSs7QdAttA3Z6UguXUeCz26M=; b=iAKp+XfDGoJdfC/C
	8HZlzOEsfvpvzLCDNrOZWu3ofs20hWvUNMFieb4fr+2L6nFaGP6OnmNwF2kr9c0x
	sJB1LNzOi70zLr4JK+sEbfmeopeUdbPiF/42sY4L/u3zehDwcnko43LxrGx+CV0F
	ZtPQrghGVP5nwredo++NfWP46YzhFie4NVAu5B2rKvRB1mxcosdKkBF3fCFi14NZ
	LjOb/q/VL+xmr1TnTRW/f/icTq3AD13PsfymA1ouNKvRc2GhITrOpdnW0ei3oq6/
	tt7tikcik5+tb+jqGg/6LuS1ebaNyN90lepRxTESApcDTl8NwHaSA1cmSb0GGLOm
	hmy/Qg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdvmm1sn2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 16:32:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93903982af1so23897485a.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788280366; x=1788885166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuKOZcrHKSXcLVc+QoGKSs7QdAttA3Z6UguXUeCz26M=;
        b=NnpDZ/KSHPiw/ie/Zb2ApIr2ujebZsleotQ7Hvvl6yjywH2OZXXy9B44JJwCAEp5x0
         R0ol41f9iPzbHpKi7UjalKODf/aeJRFLpWx4IChIFk/qc/BNAvG/3D+Vcuz9pTtUGreN
         E/nmuixLVGF9Nq+eFcX5bfYjSNqA59B5XcmSfIdj/qyhYokNvR6AwFX3K/qkuiO+fAvK
         oJ9hnRNvhFXZpL/lZrPx+07LFWMz40GS5mrluJzzrlmRxhzR01rqrNzANExSgSk0NeQ/
         YriU+yrdt+/YD6Ej95/0Re1DL9b6eB6A7xS1GW+iNww+nZQySgMWWMQfieNlaPGOjEcB
         AfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280366; x=1788885166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BuKOZcrHKSXcLVc+QoGKSs7QdAttA3Z6UguXUeCz26M=;
        b=Qot7bOgFKk5RTeiVPVjzLNmnqwX34Kc+j4NdpjmO+r7LQXYuVNJZa233A5jaLXfaOn
         7WBuYQqClKE9HYUimJsCUHQpGbyqayyPN1+bk4HaXYsaowqSDDt0g2of72YLfUfQcFF2
         vNXiUdkRzVdbvyvrNPvqsqYgQik+ALtAQfQIMFHNtZKOoQvoDfHlS4zhbHpZYM6OuPI4
         L9srBZe6BTyz5zCC6gf+65oMDVW6j0bOO0Yg2+vEPBnrZAbbA8qjhRj59eO2ysctiKQW
         d/JTCvs1PTKuBH4Xoa0woCS/R+P/C/aUATSE7Mpfn3sLLRNLwftEU8zcZIKnJnBanegZ
         +SfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDnVPKOo3zs4PE1pewYQLkpWJXbWpPklGXD93liSPevmoJ/ZJiGiIvwf92nrdmJ1fjdCABsRM=@vger.kernel.org
X-Gm-Message-State: AFuF++lh8FUGOfllAkEdZsd2tD4apn7J5VLUjICVamP8XkZcE+8/7100
	O+2aT+F6t6uMnH5F/nA7MwMGYK2/pwDk2G9QBEcFC3J+lrx5JgQG6wgBQZLZcodHSHNf4Y8ckET
	Rx6E9CjBVcCyMFwrRL02KJeJuYK7uOFjNoxvhDGCULVOYWBXTgHr8+zKE6Xc=
X-Gm-Gg: AR+sD10CDOuE/186KZSEE0g3L8WV4s9u76pWVlMJ5w2VOtYmo4L5JD2LmezzLCu5Hr+
	x88XvJyJM4nexI53r66FRRE7sABkM6J4IFgO9CW97S7o6+1m6XjGvD3A4MoUwI9op9uimuzD41p
	+pbHN4RF9DgGptFyKCWX901wqg4FDOkVDXHRArgnepmhxaTaH47t+z1+GJw4kTxJwJnyRugGsgD
	ml94xb8BRkR76SlTMrOG05cm10n+v+bEIfX+iXxQmE1eF3NnBn45cTsu2F9aGtaZ6sWuTLTARrY
	sdy4ASXqczdj0qeuhKpPgXrOpDXozyyrtLudGjSiyzSTpmFEgaQWPGSyBHmTRQGjo0Z/psBoNE0
	NAvbWnQvSkvU1dQ==
X-Received: by 2002:a05:620a:880f:b0:92e:bd39:9993 with SMTP id af79cd13be357-93913952c79mr4603723685a.31.1788280365258;
        Tue, 01 Sep 2026 09:32:45 -0700 (PDT)
X-Received: by 2002:a05:620a:880f:b0:92e:bd39:9993 with SMTP id af79cd13be357-93913952c79mr4603706085a.31.1788280364574;
        Tue, 01 Sep 2026 09:32:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce3e0desm83257115e9.11.2026.09.01.09.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:32:43 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 01 Sep 2026 18:32:19 +0200
Subject: [PATCH nf-next 4/6] net: netfilter: nf_flow_table: refactor MTU
 check for tunnel offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-4-72e49be8c31f@oss.qualcomm.com>
References: <20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-0-72e49be8c31f@oss.qualcomm.com>
In-Reply-To: <20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-0-72e49be8c31f@oss.qualcomm.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: fBGyOZ1ExPyPgJh2bCwSaDjSHgmiS_1h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0NiBTYWx0ZWRfX6zfkpP6dQrnu
 kXzVb/CVy4sWipzkXfVuRygypoZCc318r8SEQpcti8dLcTc7ZQfQEEy0TU3d03u1xaPOxp9Uzxi
 gq2VhHljo5khuaoCDsRWHd4GRCyg7qc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0NiBTYWx0ZWRfXxKpEqeEU/g7L
 QZ8k2WqKoTZjKtP65wWPjYwh9HWVBoJP0QBgRDS3XYrPi8uvK1C+X0oH4c+fkpA/khtavFbpowA
 kpSrHTRN6ibD3iGbemzPoO7BMgr8zMxVZ7s30jXJAGffycACR7fQ4qvt/nMxwMotgxuYXhgHIpl
 NW6vyIdZ0h5COUwNJVufpXTNVaz4Y0hktQRE4zP/C3lDNrPZcikpgghtGU+6fyGOFebC+cEt/go
 Q0X2BqIsZv1QbWFWC5cJAmEyVu39MQ8SMak+/M2ZQEyN0YQHyl53IiKsRee7HN86XWp1Dqjvu1c
 2JGWrpDG9nVQXTiyUmd5qZ7S7+R58qju+GyFfMk+4mRpx1MxUGHqz9x5TbUqrmchEEwg10b7TKw
 HqEfLaydliWkqL7b1CdTanPYhWIjJGwvqNCqXBWkPfSq5e3p0T6PpG6eUr0w4NRP6nU3J9QitL1
 K6kf6hAs7/yLYnEXbsw==
X-Proofpoint-GUID: fBGyOZ1ExPyPgJh2bCwSaDjSHgmiS_1h
X-Authority-Analysis: v=2.4 cv=GfwnWwXL c=1 sm=1 tr=0 ts=6a96fe2e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=CJUkwBbGfM167N4AH6QA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010146

Introduce nf_flow_offload_check_mtu() helper and use the encapsulated
protocol (tun.encap_proto) to compute the tunnel overhead instead of
relying on tun_num, so the correct inner header size (IPv4 vs IPv6) is
accounted for. Use it in both the IPv4 and IPv6 forward paths.
This is a preliminary patch to support IPv4 over IPv6 and SIT flowtable
tunnel offload.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_ip.c | 47 ++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 3ecc47b57854..0aaf1e07f320 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -470,6 +470,37 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 	return flow_offload_lookup(flow_table, &tuple);
 }
 
+static int nf_flow_offload_check_mtu(struct nf_flowtable_ctx *ctx,
+				     struct flow_offload_tuple_rhash *tuplehash,
+				     struct sk_buff *skb)
+{
+	enum flow_offload_tuple_dir dir;
+	struct flow_offload *flow;
+	unsigned int mtu;
+
+	dir = tuplehash->tuple.dir;
+	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
+
+	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
+	if (unlikely(nf_flow_is_tunnel_ip(ctx))) {
+		switch (ctx->ether_type) {
+		case htons(ETH_P_IP):
+			mtu -= sizeof(struct iphdr);
+			break;
+		case htons(ETH_P_IPV6):
+			mtu -= sizeof(struct ipv6hdr);
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 				   struct nf_flowtable *flow_table,
 				   struct flow_offload_tuple_rhash *tuplehash,
@@ -477,17 +508,13 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 {
 	enum flow_offload_tuple_dir dir;
 	struct flow_offload *flow;
-	unsigned int thoff, mtu;
+	unsigned int thoff;
 	struct iphdr *iph;
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
-	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
-	if (flow->tuplehash[!dir].tuple.tun_num)
-		mtu -= sizeof(*iph);
-
-	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
+	if (nf_flow_offload_check_mtu(ctx, tuplehash, skb))
 		return 0;
 
 	iph = (struct iphdr *)(skb_network_header(skb) + ctx->offset);
@@ -1073,17 +1100,13 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 {
 	enum flow_offload_tuple_dir dir;
 	struct flow_offload *flow;
-	unsigned int thoff, mtu;
 	struct ipv6hdr *ip6h;
+	unsigned int thoff;
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
-	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
-	if (flow->tuplehash[!dir].tuple.tun_num)
-		mtu -= sizeof(*ip6h);
-
-	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
+	if (nf_flow_offload_check_mtu(ctx, tuplehash, skb))
 		return 0;
 
 	ip6h = (struct ipv6hdr *)(skb_network_header(skb) + ctx->offset);

-- 
2.55.0

