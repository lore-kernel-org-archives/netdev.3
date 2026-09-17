Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA058423A66
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633810; cv=none; b=S8KIyr9KHBXTYbxRN5aPGrPE7omj/Nq/pv7JD84hHhAsb9HAwEb2i5YeoBNtP5Y91njmfiUkVRLs19Sk2vKKWWmNpvslFFVHGCI4o/qNLc7L/rUdWZrP/z0vHig/WiJyS2ng36+9vCXvIR+9GlsN++V/oYr7tV0EKsNz9NmaDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633810; c=relaxed/simple;
	bh=ObImdCRctrqV/c4iowlCxHzbW8PQspAWlX7/vA5RNkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kW1gAP9RwnmXpY1LD4kV3aIvbv2E1aTUWKc18RNqL69eBx0PLTMyMol6xZp3PmgTHEfjl24GIrbMpcRhoYEFym3lIxc/aQoEtHB1ZXklRyTPbZqHh9TIW6ZFc1KyOt9IM1zkkLfp8KmjNj4nF7o1ERGbZy9CqtBGwIR7fsigNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VK2y/1am; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dKNhl5ep; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VK2y/1am";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dKNhl5ep"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H61Y6J776821
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rh33Ui9H5SWpvWB3yrjhBwzPLRQ1S9PELIWm3yJzGZ0=; b=VK2y/1am/ePEju8N
	PkFwfKOfKuJ9gf0fuO7OhqFefOoflvwvuYpKRca/5gNXxforbQJV0m58aaXYeC/y
	Wk0mC8WHrOx1Vwq9kxIBeUoABpvsFtotwdDcdNiLiUrWmIvNafE+qSE9W7qrIZXP
	kteBRH5SEpTp2VnhtjTD8hZL8ndDxRUgeNWNMAZUjhOpVPqgG/paH67ege6sO4lM
	8YUDvWydzDUoySDocwgYsMxIOtnuqlo+N/DyREr1+iGh6DSX+hrmWcVFJqgTieGF
	qXPVm8wMXn3X6akw8N3ETMx6j7DLWtD/NLIrh4HrG3Oi2qGpCKJc4J3b0hrKeAkX
	U9UOUA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquw2va2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so155532985a.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789633784; x=1790238584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rh33Ui9H5SWpvWB3yrjhBwzPLRQ1S9PELIWm3yJzGZ0=;
        b=dKNhl5epfZiehtOvHmMZNiCo454G5PQbVmpsMhfvKPx67Zz+FvNpAwNsg9R+n+SZEo
         hlME0Tb1Tvqm3EGSS4XsM2JLQjRLLpDwi7STul/+c1jNHKYCbbO5b8/PveE1++DILd5W
         2uWsu6Y1Qts6pkXMsyzY2nmKyrtlff1aMXrO2sDtvsp5Kc8E7PKMEFVtW0cWPyNF2NBR
         0mQkgWdW1lBzX1eLAOOb6JLhnYOeXGSrRd+9jM3MtdDDG9PryvWWMt++p3RmWdVu0SPI
         4xRBd4huxKAi3vouOi+HC/Jmd3wmhVDjrVojYT7xngcqTEk7jts2S6pQJrTMct2rtqaf
         RaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633784; x=1790238584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rh33Ui9H5SWpvWB3yrjhBwzPLRQ1S9PELIWm3yJzGZ0=;
        b=H2uATtvlQsjHM4r6jVlI7xZy7EIhM9lL5UkXYoS8kLVXhW1oJv/jocKT+8XDFpxdGj
         FhL25Tbw0tHz171JQx3MNaMTM029O5Ejiiz+PxK+j2keyb2JA690VJ/OQJquazEnhwLl
         //AhlypFyVQCApanP8MJ1o3sLVvF4t5dq5a8ZID/M6yPJV4xii1oioB9YHasakDnIVu4
         6wb8o0y9sy+JmkyJESZKp9CUzXkCUAfxeHgyJd3YrRHKqvPNUCzL3fgzXYFDjX6MDQxq
         N9JgwQohOkaVX3LAGiUZBfPTqV4NU/JVAEZ0x754eG633z3AeP6/qzY91DVWsUEWhKc+
         ALEw==
X-Forwarded-Encrypted: i=1; AKwUvBzQuAPbN30/j44NgKmkfCL7Ew8OyHotLkajniYwcJcsXNXNP7jGAcJbneAEkJo2BH/sxVgZDlQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k23eOtmcQdEtzVDSBncxDj/db0DY8EJhkZqRDZwF+DbLICYgpF
	hfRYXmyzQON+rOusfyW1XxgwQZlbos7MV3dGz55ojNmn78t/38BTBJizZtWS+Egx3tCmIqL0EP2
	t6QCmgVTnTkDWxg+zPUxNEhLKDTmD5V8KKHRhmsUnUVZB7ud/7ulRI34YW1g=
X-Gm-Gg: AYBFou0UtNpaHnSmuw7apIdbcS8Let5dDg19I48vZ36+P7JJ5tMoYZh1AZoA6aPURQ3
	nsxJE047LZtCKOqZ1g3nH0vNvsNaMlt0o4ZP51xb8SOHpI9xSxj6wtkRlzSAVshFu+6wUne+1B5
	aKwtJ/5kbbBcvVp833Sgqgp8EZYRYKjRU/rqS9b/DXSArXVMCmLpB+h0yIQMNolC2SbBdCTMecM
	Q1rMCE8gVd+zPEEWtpNjUd3D14UqklTq3LzYeAetW3XWWDPtXNA2tYLwdkfkxg86DfGAOqm5Mbh
	j3ZE5bNqlE9d5aftHovqErHIJxFNg8ahUPnburpzr6qpnSbpM3ameBW+RqVpMcmpSGsjNiQtmSr
	Gh9GzvjzyPhutYg==
X-Received: by 2002:a05:620a:2711:b0:939:869:a8bb with SMTP id af79cd13be357-93bb7715c0bmr930940685a.14.1789633783597;
        Thu, 17 Sep 2026 01:29:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2711:b0:939:869:a8bb with SMTP id af79cd13be357-93bb7715c0bmr930938385a.14.1789633783187;
        Thu, 17 Sep 2026 01:29:43 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de45449dsm247645666b.22.2026.09.17.01.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:29:42 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:29:11 +0200
Subject: [PATCH nf-next v3 5/6] net: netfilter: nf_flow_table: refactor MTU
 check for tunnel offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-5-fd2ea96fac7d@oss.qualcomm.com>
References: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-0-fd2ea96fac7d@oss.qualcomm.com>
In-Reply-To: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-0-fd2ea96fac7d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX1MfBZxvYe2hR
 0DIJlQFf+3mLEhWP49p+G/+KiT+2yyGgWaPORFudUaUrDdm0IqVGUpW+W7rl0XD8X5mgs9BcP0+
 fz+sITvONS89lgR/Sh+NbFnXmxn0yW4=
X-Proofpoint-GUID: oJyInzF1xN3gX-bO323wBYRKxHYO_2Np
X-Authority-Analysis: v=2.4 cv=N4m8hG9B c=1 sm=1 tr=0 ts=6aaba4f8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=9AI-LCzJV_BIknmlFlkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: oJyInzF1xN3gX-bO323wBYRKxHYO_2Np
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX6P6xXS1GWSDG
 UNh9WNfA0N4nCONA8D+gK6CLpcnBjyKplQ8YMp9SpcIVdOg6wydr0RuyuFaN8BTMFovS0SgI52K
 4zETKeWiZnHsg+Z4xruoiH+3PGwa3HFAPmqMdyrl7Tn/9eDUbB12nI0W8obsuXZiHuE238zYNeS
 Enf/TDgno46VY86YLZSCxKu2R9Amx+T2e5f21D0VDpLsQNNHTCJfKGSvE+E5BecIBNs8udeE6uW
 3ndhbPauKsBUlEbAOXjChmKg7iNof8FZBcCrOGUiY85ze/1Bn8Fsfoq7D2eQ5pf6aCppNH9oudl
 G2J1NtpYyHl0VX5zVKhfIo/3K4FybOLaMeSkmk+y4XlvNlB1nGEtCkF4TWguivISCJ39LdRXb+p
 e04Sw96i4Ft5ihBNCGFt+ugjLsFuWtLRe+2sybyN29QtZgtelQ2vFREnmlRZNYsPF8GrE+IUOZW
 D91C/O5CWdQRBf58FlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170115

Introduce nf_flow_offload_check_mtu() helper and use the encapsulated
protocol (tun.encap_proto) to compute the tunnel overhead instead of
relying on tun_num, so the correct inner header size (IPv4 vs IPv6) is
accounted for. Use it in both the IPv4 and IPv6 forward paths.
This is a preliminary patch to support IPv4 over IPv6 and SIT flowtable
tunnel offload.
Please note IPv4 over IPv6 and SIT tunnel flowtable offloading is not
enabled yet.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_ip.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 1b9360d54dfc..96dbdadba4e7 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -472,6 +472,31 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 	return flow_offload_lookup(flow_table, &tuple);
 }
 
+static int nf_flow_offload_check_mtu(struct nf_flowtable_ctx *ctx,
+				     struct flow_offload *flow,
+				     enum flow_offload_tuple_dir dir,
+				     struct sk_buff *skb)
+{
+	unsigned int mtu;
+
+	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
+	switch (flow->tuplehash[!dir].tuple.tun.encap_proto) {
+	case AF_INET:
+		mtu -= sizeof(struct iphdr);
+		break;
+	case AF_INET6:
+		mtu -= sizeof(struct ipv6hdr);
+		break;
+	default:
+		break;
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
@@ -479,17 +504,13 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
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
+	if (nf_flow_offload_check_mtu(ctx, flow, dir, skb))
 		return 0;
 
 	iph = (struct iphdr *)(skb_network_header(skb) + ctx->offset);
@@ -1075,17 +1096,13 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
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
+	if (nf_flow_offload_check_mtu(ctx, flow, dir, skb))
 		return 0;
 
 	ip6h = (struct ipv6hdr *)(skb_network_header(skb) + ctx->offset);

-- 
2.55.0

