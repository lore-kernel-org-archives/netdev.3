Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC452439F7C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633798; cv=none; b=n1iQuwcrgXb0upCG1oCEgXKMVbpttjeR8/W8a/KLOwXb0UC1TZDOlAQjvIW0pZl2TyYtsVZYFzH0MWKqsm/m4jn6yJgq84pVIU87gbUa3Iqv7mwIgn5ju19VWgGb/LJUr7MP/EcqmPfG4GPAbKUfrElwShrztqzt0LH3HTpNFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633798; c=relaxed/simple;
	bh=AmYTVtq9q2zdn0RuPo3cddtrzQkCt+YTwmkXJN2yUuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fv70FlUFunMZUCxF3fwmKd4iyLlW9axfQ8bV2Uhm4MfIrb4CHWLxd9Nz89Glg9lrWiSTJ8wySUuyqs3v/rIRQGyWtnPdrXmMXreQS6WEm/VFDYhk0CO6ASbPsZniCQmCHTwjegZOKRbkCmIPacEsTTu7tiJUVoZi4DWiRKhtq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QOWqs4N7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TVaaN/MO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOWqs4N7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TVaaN/MO"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H60G0s1924332
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fE4Th4zCBtqTO9C1K+gn1Kc8P08Hlw4ollCF0wc+vGw=; b=QOWqs4N7XiO8h7K7
	7GB9L1hFp58lgOLna4yBkix/bs/EuGHcyefwf6QLrNOnf8GbbK6NUSI05kb9lVoA
	DwZLcFxXhTiNXF1KikKzMnIJI346m+j8sYk+gtI0Y9fL4gvex13lZ9mRrnvZqtbt
	/D1FRA7Mo1Zjfwv2diYV5WACllABxrk5Euyd0YD/RiWtP/0gX1zUgay+/h3tFYNv
	oOmcl9fufnpFWTs/1epBoEsCag8HTy08WLuc78a506jCstkEq0uRIuGgwDqR79xp
	d2dEiNBZ6IC9Rf5VFU4Dt3UM9OgciZcnOmedufCvmh9sipisEnRz7h6tcQQHhKQ0
	flouag==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxw8uen4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93bd22160bbso25846385a.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789633780; x=1790238580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fE4Th4zCBtqTO9C1K+gn1Kc8P08Hlw4ollCF0wc+vGw=;
        b=TVaaN/MO18XQPjgV7jFQJ4duN6g2vRkNlu+7R/v11UZQv/EIzf0bgb+hfFNunCjoY8
         fdjdRFToOODIftowxsYlp81bjtU1gCI70YDowiHn7yIDgD6qJtiOWYG09+pE/NXczoaq
         DcBv/b6ejDAwqtqB2xIUeZXqrF7hN7qT+TEJ5SXM/kvtlakvUxgqmkMj2/w7iH2SVJ41
         AxVE/wMKdydP6Uqh0WMgo4S1L3lrA3p2t0IxBnsL2lFZpU+ZPOyWEw+4tavE0BbFgOGn
         aeb/p4+yd+21RnhpO0Y3Nn2cKa2/hGvXkAZY3vD4L6IDF9rrr3TLTOL4QC2ezcg/vqUU
         1Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633780; x=1790238580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fE4Th4zCBtqTO9C1K+gn1Kc8P08Hlw4ollCF0wc+vGw=;
        b=zkv+/y4fdqnuU3NGkdWvMijcL/jL54A+z3jbSUeZ13+7xx8TfZu2p91PZUzavTVj+t
         b/GyINX2Doen+0Kyz0clhMxNehYAE9d0gj0R0APMswvFORmj5GMLLIEiQOgX/tTWAN2N
         2tQc5KrKR1IcECRTmVcF74P2p9ODDAzhIJETAIVxcZszfcxxZ57U14mr0vCWAVdc62/c
         o6UeO7ljeru/ebOQihPPfKnAp7lHAsqXm0u4KRVE6dXN/H6PaEY3tHeH1Blqkxdxxim5
         1OOIOY5sjxxhTjyjfdUAj8z7PROUewLf49ztrbSpbFP+qVNZODG2NgspeOq0iyfOtKsD
         WoQw==
X-Forwarded-Encrypted: i=1; AKwUvByoMX0uCCZmKFPwFbF4Ho+u/I+XzrAq7dCTqIbFikDkk5U1Vo2OCFqQ+vYeBzrRLMsMwkVLNWU=@vger.kernel.org
X-Gm-Message-State: AFuF++k6UzlYPqDtokBU//776/lwxV3o1xtcIdqa6B7WJZEmtubx4TNR
	KuPO2q6TzAmeOsrFn2iYHy5OFD0MGdyBqwDdbkA70/p20iCRnPUGafxMkgz/04n7+LPhKHU5rSE
	waNp2DeUsgYISxRVqb1W7UM1qfp/M36KJ1jGTWfK6u0awLAcTyx7fkd9kSQg=
X-Gm-Gg: AYBFou1L8I9QjHR7cnxGXCrQjjllvt81/b8WeRHUhll/CT06YESD8CbFEPkSRx/ZJmo
	+CtwI2aDIyfmts5/krIk7T1uOyIVAgocQX8dKC+Q3OYuzUutDTW/Vp235xf7UJGKtJCOCd6zYZJ
	/ZTBz9I7SFMxfVn2W3cjzB7V0kdIETqjrTjPCE4WJ8POdfIOHLWeck9pHrJpSOg2QMYB2z96Jx7
	qHPQfdb1MfW5clH5VJwzUpPLCN8+0oyP1+TRj4MPKTMVu6BdtO7NS/pL2osEli+KdijDdhepvzu
	E52qBKMLrtDGwRHYxsO+DLrOMKWsrdeNFXLZV67823cxPRQ6aXC1oZsCOJV1otDiOdbNXA8Z5OW
	j0q/zANJsf90WLg==
X-Received: by 2002:a05:620a:a2d1:20b0:93b:b84c:9720 with SMTP id af79cd13be357-93bb84c97afmr692326785a.49.1789633780484;
        Thu, 17 Sep 2026 01:29:40 -0700 (PDT)
X-Received: by 2002:a05:620a:a2d1:20b0:93b:b84c:9720 with SMTP id af79cd13be357-93bb84c97afmr692324285a.49.1789633780023;
        Thu, 17 Sep 2026 01:29:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fa7dsm13614369f8f.8.2026.09.17.01.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:29:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:29:09 +0200
Subject: [PATCH nf-next v3 3/6] net: netfilter: nf_flow_table: populate
 tunnel tuple regardless of inner protocol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-3-fd2ea96fac7d@oss.qualcomm.com>
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
X-Proofpoint-GUID: n_KR1c7wE3z9oBVtbInrqJrkQl5yGlYa
X-Authority-Analysis: v=2.4 cv=bY3+w+PB c=1 sm=1 tr=0 ts=6aaba4f5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9AI-LCzJV_BIknmlFlkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX/20AiN1K3wmD
 Z96F0nTVGDWqOMs3wCmVfRiovm8pQuVbRPxP+Vg7F/7bcpmmTb/EBL8KovZDF0ZlJlFe4HHhvIQ
 RwWHs+cOMp1QkIKVlBtq/w8/87Z7LZA=
X-Proofpoint-ORIG-GUID: n_KR1c7wE3z9oBVtbInrqJrkQl5yGlYa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfXwLrdAy3PyIE2
 9NeU8pN5gqafVVm5bWV704gKWtsEaGnBD/ghqC3f8sSpY0KGbQK/ZSqRdDNJvRjCSVMVDN87qtH
 0ZXy71PLxC9GSRq5RQ8sDFibXzMtGNTv9g7Hx5GLQIeGEglE7Wmx+j0ZZzDLNdsPaiNvxYoWYY8
 +z3za8NMtDhqLmT0nySd5eSl1FS8PFBCNpliXdtykz0kS5OryK5xpo8ZbRmGoW46Zx7TXPn+nX+
 FqviuDEhnlWU1CDcQsOVFtxUqoWiln5c4zi2Kg873nbdWMc+tEzXGiHIT6EtWax0s/170qkAkp7
 /++3SYPSdNrdjuThMe2kuaf/sa+FnF6MM7cfFNGMcSqaaqVffJ3alHZDGZBxp2aGbZ7v+y6GmDo
 O8CF1mo46C++n6Zvw9ac8hUaQEN8YvGLr4/tVJmEft/eWPvwuocMoR4lff5B/FhiRuVKjnCU3T5
 2MP+6HnVGKLVR5XwAUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170115

Store the outer tunnel addresses and inner protocol in the flow tuple
unconditionally in nf_flow_tuple_encap(), instead of only when the
tunnel is IP-in-IP or IPv6-in-IPv6. Bail out early when the inner
protocol is neither IPPROTO_IPIP nor IPPROTO_IPV6.
This makes the tuple usable for cross-family tunnels such as
IPv4-over-IPv6 and SIT, where the inner protocol differs from the
outer address family.
This is a preliminary patch to support IPv4 over IPv6 and SIT tunnel
flowtable offload.
Please note IPv4 over IPv6 and SIT tunnel flowtable offloading is not
enabled yet.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_ip.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index cd636b4cf74b..a53393f8eda0 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -189,22 +189,22 @@ static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
 		break;
 	}
 
+	if (ctx->tun.inner_proto != IPPROTO_IPIP &&
+	    ctx->tun.inner_proto != IPPROTO_IPV6)
+		return;
+
 	switch (ctx->ether_type) {
 	case htons(ETH_P_IP):
 		iph = (struct iphdr *)(skb_network_header(skb) + offset);
-		if (ctx->tun.inner_proto == IPPROTO_IPIP) {
-			tuple->tun.dst_v4.s_addr = iph->daddr;
-			tuple->tun.src_v4.s_addr = iph->saddr;
-			tuple->tun.inner_proto = IPPROTO_IPIP;
-		}
+		tuple->tun.dst_v4.s_addr = iph->daddr;
+		tuple->tun.src_v4.s_addr = iph->saddr;
+		tuple->tun.inner_proto = ctx->tun.inner_proto;
 		break;
 	case htons(ETH_P_IPV6):
 		ip6h = (struct ipv6hdr *)(skb_network_header(skb) + offset);
-		if (ctx->tun.inner_proto == IPPROTO_IPV6) {
-			tuple->tun.dst_v6 = ip6h->daddr;
-			tuple->tun.src_v6 = ip6h->saddr;
-			tuple->tun.inner_proto = IPPROTO_IPV6;
-		}
+		tuple->tun.dst_v6 = ip6h->daddr;
+		tuple->tun.src_v6 = ip6h->saddr;
+		tuple->tun.inner_proto = ctx->tun.inner_proto;
 		break;
 	default:
 		break;

-- 
2.55.0

