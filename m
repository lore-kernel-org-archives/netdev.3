Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5493B14A8
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633797; cv=none; b=UJRnUpRkhCbU3V8Bdoe33ZfSq3uk+YFcByZsFdyXgChm0huSyOxHzxvqHyRDdwZC32UnWTD/xfYeITyevd3C6F4tYKYCwW50KoO+itC3MCY6aihcIxZR7x+7nHfxhd+ffTDnAUsR7u5UyjBChjlt5Tl1WQhr6qzd8joR2lweohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633797; c=relaxed/simple;
	bh=lHVF8s0Wcz9LBxO8G6crtjxSLQILW6JFK03HQ68HxHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XC4l7hJ3kPwVrDLct/d/I0Ol2RWCFkMZXVTXQo62AFzmKuoiZlyG/PeBS+MpMP+VLqnFFq5Z9L2EI7nq9XKFyd8qebZZZOh3C5mL5cVxdPsRi6bjxtr5dgQ/Fh55hi3BFVQwUhZFH1Fess7Va8eEVUgZteywZ916TcqA4rP/RNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SKRikF3R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KIchJn4X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SKRikF3R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KIchJn4X"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H60IHx1924362
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPPpF5ergNhRT/pW00RFS37TyyLLqr/jihR+fYpv5CY=; b=SKRikF3RtqYA1Kpg
	fcEmjIOh1ebiWa+/VmuK9tREQROdOWelHHILKSd2enSBEZF4ePmpaZ0CADVk3df7
	t8OHaV4rC5nbjswXUTJixOZOHlji03TNX/sx4yYKYHY5KDtqufVRYcmNM9ORrOM9
	DXoibWKG0Ubxl/2n2ItzC742AeF4guLqvZTF4DOmGjOOPR+3oW+g6Es9luEEXIn6
	Rzuh+RxAMCsF7IIA7mpT+7xID6Xcdy6repJ0e2B/UtkESfdy92z8rDhxZw9Y13YV
	+5dL+y6PJeXc8+hxbKWlUAweojL1QK8Gi2Wv99Um6znZB3faJ1SsPYYAK8lCaMh3
	Nfjs8Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxw8uemy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9394ad7f64aso78130285a.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789633778; x=1790238578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPPpF5ergNhRT/pW00RFS37TyyLLqr/jihR+fYpv5CY=;
        b=KIchJn4X0XCypxVM2WatmW5CRtIWczU4+C6z8+uBzps93F7fWcU6/AHopyruOAC+c6
         dV5X1sqYRTgYl+hrvarOk4Rk1X/dddGOEXwgavcUrHr/rOa+jy4lSIR2hlf5oxVGHh/E
         FL043WPEfDqI9WoCZzNibTq6TtT3tJhCmeJMakfqaKzqgtAYfpmQrSS4RmVeDU2K54CJ
         6z13gQmPPTxRz2zxqDUaincoVYf4ot7N0bw34YwqPbAli7kCSByeM8Gv+o6XRnW6d82u
         m0Pk+vKPfPa/WLetO45fY/VvgqdWKGn29H+Akd8ABMeqBKpi/jaU4n/V+dXBYYl5nhNJ
         wH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633778; x=1790238578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPPpF5ergNhRT/pW00RFS37TyyLLqr/jihR+fYpv5CY=;
        b=jq6s07wFfoUbyZjMK1rdh9OOLgWDIQi110I8cxHQawLH1NN/O4EoxBWXPthGLqGcLD
         JCpl2HFxj5wOY2Ef/OCdzriVFcp7ETOEL4RO6apUQp27KAxALfyGuVdDrPHlA/t03SKs
         mENYM7pjl1MddEd9cw/qvgjygmU74akp1PsvkMaAsqeO895dtwjoHAb3CXkCKKabv6lo
         dWseG0U79BCt0bbxotxZzleUuLZKbPj/WGFZdeuHPLrc7Ymclb/k5AWdzduMLmiL7kZS
         ckhvtcMCvsG7gQLI5Jq+5y5Lrd3wmlq/I6f5U3uOy0wgue0kmeO3E6HXrYbmsdYBBMVi
         IQqg==
X-Forwarded-Encrypted: i=1; AKwUvBztQ/kLG72V/kUfCLTKpdmts+ZU9WmQd4UMbqcKsL91Y/PZDZLo6/OEBf+yI0XD7HQmpuekPJk=@vger.kernel.org
X-Gm-Message-State: AFuF++mUUEX/q5Njq09yF4KvJ7TqcgCo9kJ0EVgL9bgmfUFMASVe0Pm3
	iEdu9UIIOTiMiIuKgjg96wA4Ofve5RMOu24snDxsC+1TYRH1Cl7MMdQvF+8HJ42cnPOAqldMFHO
	uZCM9//nGhi6OJaI5R5CMAZkatnf/wPNDKUxIAqzHaWGYwDQGvd18uhV0RDdB42Evvhs=
X-Gm-Gg: AYBFou0SElKkGeIlqGhgoLjprUWD2Ajxjf1PK2aOwIMiQlV9nJ+AUQmXHpzUzH0RTXh
	L+3hjh3sC+2Q3akCtk6vmE+hGYdU18gYOMRKPIpQ24d1on9HKv0cdaUSDw0x9ICiosVsxgcDzu6
	DDK4FEAVeDV+EL4OJNvUDF5N+RXnm7N7YNAF+cT/qlownsLVGMmmC+CCYa5Od40+NJzemn07oKe
	dDRmrRazHNHSYYt/N84NTJrYhTaJ10Ylwb9bBBWypQ0wIMsyGoq491MOV2GrItlPUiwaqjSsR2T
	mwhttUY3K2Rx7hDYraqMrZhaCQKRl00hDdJESdkwRVMZsJ71ucstC+dYl58v5epy/gkuQWdOaQi
	xthrfkFyul4ZQHw==
X-Received: by 2002:a05:620a:4592:b0:939:31b5:4e08 with SMTP id af79cd13be357-93bb7267e92mr1068901085a.0.1789633777927;
        Thu, 17 Sep 2026 01:29:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4592:b0:939:31b5:4e08 with SMTP id af79cd13be357-93bb7267e92mr1068890585a.0.1789633775780;
        Thu, 17 Sep 2026 01:29:35 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27a41sm12854951f8f.18.2026.09.17.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:29:34 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:29:07 +0200
Subject: [PATCH nf-next v3 1/6] net: netfilter: nf_flow_table: recognize
 IPv4/IPv6 in tunnel proto matching
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-1-fd2ea96fac7d@oss.qualcomm.com>
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
X-Proofpoint-GUID: HoEWMQmJiDnOYC3S_WLhBSXjQulw_h6N
X-Authority-Analysis: v=2.4 cv=bY3+w+PB c=1 sm=1 tr=0 ts=6aaba4f2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=m99eJ5p7w77CmUfuVTAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX30ZhgrzK10Qj
 TqQMMzxXBXgXHLTEgaoq8XQqO0NOTX+D55xQOygW0Aj06B9HdrSILfhJjPosEeMX0QC/c6nZDdP
 8f2pOrvbakgH3mxq8oy3AErkPV8t+z8=
X-Proofpoint-ORIG-GUID: HoEWMQmJiDnOYC3S_WLhBSXjQulw_h6N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX98Ghk24qA1Xi
 633BoBJwOw+hx0Bwo33GmXHJBZ/CMmKr2/KZjGPQcFiBhRGtq4ZrglLcMrycIyrpSObZgSaf4YL
 18F+10WywMTh/zONqjFkdrRQzBEkVgFxsH2WJfHbM6l5AsyauCqTmbEChSaPMsy7DBE7/yhl2SW
 s6cupwfEK1gNLgiVD4k5Z87/aoXhIriLGMcg1mAVS1wBt31431Mc5elhAkDAvxnHU22Yc6z/zog
 /22uOJNg3C6MN6uuZLTQi38VjN/5Pmbr/fG4B0jKg6uEL/jkkjIeKvOfyXC6HAWOwyMFSsTyW1N
 xE/4zcQv+S6xRXMQSKyAN9aoMlfKFVjiX2p3k431iunDIC8fMREkz1pU9gKHXWMngtoo/LDDJm4
 I9b5xozlEdI53dWhnDHdu64gISawI4A+Ds6KLyU2dKZrGA9eFJhH8p+Qln+MM1Dp1nC9Y+xURPC
 M2qyHABQ56G6e9Mj4HQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170115

Allow the flowtable to parse IPv4-in-IPv6 and IPv6-in-IPv4 tunnels by
accepting both IPPROTO_IPIP and IPPROTO_IPV6 as the inner protocol when
walking the outer header in nf_flow_ip4_tunnel_proto() and
nf_flow_ip6_tunnel_proto(). This is a preliminary patch to support IPv4
over IPv6 and SIT tunnel flowtable offload.
Please note IPv4 over IPv6 and SIT tunnel flowtable offloading is not
enabled yet.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_ip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index c8c29a9a1684..42e8de696474 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -326,7 +326,7 @@ static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
 	if (iph->ttl <= 1)
 		return false;
 
-	if (iph->protocol == IPPROTO_IPIP) {
+	if (iph->protocol == IPPROTO_IPIP || iph->protocol == IPPROTO_IPV6) {
 		ctx->tun.inner_proto = iph->protocol;
 		ctx->tun.hdr_size = size;
 		ctx->offset += ctx->tun.hdr_size;
@@ -351,7 +351,7 @@ static bool nf_flow_ip6_tunnel_proto(struct nf_flowtable_ctx *ctx,
 	if (ipv6_ext_hdr(ip6h->nexthdr))
 		return false;
 
-	if (ip6h->nexthdr == IPPROTO_IPV6) {
+	if (ip6h->nexthdr == IPPROTO_IPIP || ip6h->nexthdr == IPPROTO_IPV6) {
 		ctx->tun.inner_proto = ip6h->nexthdr;
 		ctx->tun.hdr_size = sizeof(*ip6h);
 		ctx->offset += ctx->tun.hdr_size;

-- 
2.55.0

