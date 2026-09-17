Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D043B3F6
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633794; cv=none; b=GBr9Mcf1u97hD/QdmKcGYyKJCyr+E+Fm7Z5xskJ+YRDVQQ0EUCyG3d5E4Cg305pgv6HYDvfNwRUExl07VYwtWIJa4HT4tqDpyvyJULlglKixUKDiENBU8naysRnC3BkeuGE2qJaie0IJfjMX7EqOq9KRhbMUXHF0mFfFknkl+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633794; c=relaxed/simple;
	bh=rNxxPYZvvS0xziEix65HCNH7tYsfMS2iHJ3mRY5rHkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SL6zZBPRS/mp4a4uW3GGHJ1+ebdIDmt+6Lvj++76P6inyl+o1UeceBFDv/qvlMtRclkLcNu2YOEFhLT9xM/IDx4OuxdZbYwZ5SSMaZ7DacAilZj/LOOVPUkfcAvYl52K4VFK/Mpz4AoIYz5GVgZlXx8QVZR8S34Wi9Trnnq2Z5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pvEhesEH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=doeRefQX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pvEhesEH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="doeRefQX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H60vg1902044
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xCN7YOfm7t7aL8aoNmpZZk363y9KqRhIlG7E2MGmIUk=; b=pvEhesEH16daytUF
	hgc/XtxMR6ux0LJ1wqd1P51KlXzWGVVWu9JXv4ngu2hDIdiMmHuhjlCbeCSDK1DO
	2L0L6ZYfwydOK2/YPnKVeJMyxffyVU+wC+6sjUH8zAVKXIcw9V/tI3jRvLd/4Hj2
	UoApT70qZA/RVZfsyZyZFn+oRzedx7qygUtPi+t/1tgTdhUfbx6gh8BhHRyFrCpF
	s433e/k/nh0u2bIXoZJPrCdJOISUqlKxTcgAMZjed0vS0AGrZxOPS/Ee/NaXtZmo
	meOWN+yy9hZie7fGd5M+papQcye1PUjPb/ZCzecTH/INABNc88lFvO3Z+E17X8Ve
	tiI/qw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d3dns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so103690285a.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789633782; x=1790238582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCN7YOfm7t7aL8aoNmpZZk363y9KqRhIlG7E2MGmIUk=;
        b=doeRefQX3x8nif67EB2o0618VeAOE6GNmxTkQITpPlQJNlRiW0gx5OgjdP+dCgHv8c
         8oXZ1gTkZq1Tl9Gzef2oDMNFno19Dxnfl88dZ1oeKD50VZmURPLgR8Kpfc4NqhWXML2R
         SJsoYgREYrc5WCuAqnymzqocg3bf2FnXrPYx1S4goRui8WoIEOIXQWNszFJEPe6mrit0
         ReIEVGyn7Ifv33aNbiEnD9yVfTcP2WEA3odc0K2EFVRuQZGXqjOig+0NhJHsHNXWEBeY
         k65DnwQA8Ka0+ARfvw4Z+9Fs5NQTPTR3GCyaKXKqCGaPhcl0Q1RLKXGOr+IVkkTHzNNR
         dedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633782; x=1790238582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xCN7YOfm7t7aL8aoNmpZZk363y9KqRhIlG7E2MGmIUk=;
        b=IMwR3y+f8JTL6CpqNnSsl/C3x5OVmK4qqjm/y5SrAEkPbVce+4RKU6p5BnOmC9cgpE
         fkM/F0wJ3jkSkCGAvRXagAAlF1hY7gbbNloi+DYi8ormtB9v2gXjnADOTUjMl7ewreXM
         gPNlX4McNycQXP5qJ6CAPHLRPed/x2JXqq0ygcnuuoD4gqgs8H8FMVqDfA+wu9M0g9Gm
         Dc77dNPSSXc5BGCyLccOxOLlV8WW2P+f8CtyFZeuLsYXFQYaTHlm6MU3wfGyPN/8Yubg
         CKlAetsRjq+HQqcXuojdzZgrlFiSCjp7f+3kqQ8KBir2Xch7VT/dJlTcbH7GatdsFEjT
         OEQw==
X-Forwarded-Encrypted: i=1; AKwUvBwU4HKJ13NtOEE6KSAqeL/t8LTNBP4qc231pLZ1EhMOJBILvSDk3Earlj71y9u8BeZnM4O8Mwc=@vger.kernel.org
X-Gm-Message-State: AFuF++mMUnUwLGmbK4g+Ccca7nZ185M5FuRX/eaGUwtF3ZaF7YaZnrSQ
	2jiryb8bqcAV7H9sN07Gs6f95TM0fMXU3ybUTJDFkYZDCWJgdZOp2qrweplACvzek+96Mw5QAT1
	o1jAcNpwa1VcQoNeiLc8ThRhl9gX3mze4qbuq3Lg5ErEOSBtDnkF17Kxevjk=
X-Gm-Gg: AYBFou3Q/tDJvi3g1MArS1svuNQQjuJYYkTVGpvs5bXRdN3PfUO+YP0Gd0ZpUjMd3sV
	tAbjW88tbcuQ3CocLoHY+rgjgdFszEVhc3QdiV9RxdzjUK7du/v/ArlAenRbLv3DHHRuyP6tZrH
	OapMvcvmmr5M4aGpOMYVT38sRPSidK5GP5Y+zhUs3fOhBZfnOPI9lm6U+Bz+7WdP++e9ZIFtfcF
	gJON8BatjuGgbYEdD4H7iFwk7Sm/no90kM+TxKVJ1CMhWywf2kAWv5wXbzWrObYCHXWi4GGgzUz
	yWgytHW3B3PfN93dpgdip9iaunlJHtjPpHBbQKLdPwYqbPObvttu7OQegGebVCmbyHRRVK2tycg
	CF9M9QovWNBWEwg==
X-Received: by 2002:a05:620a:890b:b0:93a:2ea6:4c6e with SMTP id af79cd13be357-93bb794cb7cmr1057577485a.45.1789633781947;
        Thu, 17 Sep 2026 01:29:41 -0700 (PDT)
X-Received: by 2002:a05:620a:890b:b0:93a:2ea6:4c6e with SMTP id af79cd13be357-93bb794cb7cmr1057575085a.45.1789633781560;
        Thu, 17 Sep 2026 01:29:41 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd32c5e1sm82617415e9.5.2026.09.17.01.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:29:40 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:29:10 +0200
Subject: [PATCH nf-next v3 4/6] net: netfilter: add encap_proto to
 flow_offload_tunnel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-4-fd2ea96fac7d@oss.qualcomm.com>
References: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-0-fd2ea96fac7d@oss.qualcomm.com>
In-Reply-To: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-0-fd2ea96fac7d@oss.qualcomm.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 3vKVo2956R-SBCDi7yxE7r7Ex0zHgQ-l
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfXxtQxE4se/KK5
 sx1zpv/nKpDDiCRthyaAxG6todCq6vU5LKMeREsrX760C11RpcW4jr6xirteajOzxATb87lHl7T
 X/+dPAW4MKduF1lBWIenUBiEYHMbPps=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aaba4f7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EiAgCLLKtgnx6EotJx8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 3vKVo2956R-SBCDi7yxE7r7Ex0zHgQ-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfXxamAAxkMiKEY
 PUDlay+kHlFyJFW5ZA5vdE6NiwyLDx3wSGdJqkKrvk6zc2k07rxArcfyt9KdmVwsSwN4L7l/9s0
 mla8Uk9cDsjO6f60Rsm8Mv5ZXizhrFdY5pFXzjEwzzQFrkhPuu99teoxvgNzmapqGg4OU+qwjPD
 MawDWena1ARKnytMhCCAy19UW33BoINB2+wDt1R0Utn/w3tFdJj6XuJtEAPOYEvAdC1B+HBQsZc
 GTg2P63JmQQaMZ3IkQ6exl48dZkRM7bMkRTMfgigwTEx84hc0Ibrt27k/a8p8qqkUcpFmxPMRI8
 Ai0KE8rjWF1u+M0UE37aIE9iHWK1yFQk4WuJuDbNFIsCwNLYAX/7SvhT588hbRbB7IuOJ3vAnym
 OctrOY6uNAIPxTKK+qx8a7NwRGzAO7kbfpYcFHaSEtRAkRWFE2kvTHRmeBrRXjF4nCW5+JUrOvR
 P3UBCEu9pPrVdSmmoIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170115

From: Lorenzo Bianconi <lorenzo@kernel.org>

Add encap_proto (AF_INET or AF_INET6) to struct flow_offload_tunnel
to allow its use as part of the hash table key during flowtable entry
lookup.
This is a preliminary change to support IPv4 over IPv6 tunneling via
the flowtable infrastructure for software acceleration.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/linux/netdevice.h             | 1 +
 include/net/netfilter/nf_flow_table.h | 1 +
 net/ipv4/ipip.c                       | 1 +
 net/ipv6/ip6_tunnel.c                 | 1 +
 net/netfilter/nf_flow_table_ip.c      | 2 ++
 net/netfilter/nf_flow_table_path.c    | 2 ++
 6 files changed, 8 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1f0710eef185..1feebe423c66 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -910,6 +910,7 @@ struct net_device_path {
 			};
 
 			u8	inner_proto;
+			u8	encap_proto;
 		} tun;
 		struct {
 			enum {
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index f2e2771f188f..306e7d9ec3ec 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -118,6 +118,7 @@ struct flow_offload_tunnel {
 	};
 
 	u8	inner_proto;
+	u8	encap_proto;
 };
 
 struct flow_offload_tuple {
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 2ffe64e736e0..15189e1fa068 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -379,6 +379,7 @@ static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
 	path->tun.src_v4.s_addr = tiph->saddr;
 	path->tun.dst_v4.s_addr = tiph->daddr;
 	path->tun.inner_proto = IPPROTO_IPIP;
+	path->tun.encap_proto = AF_INET;
 	path->tun.dst = &rt->dst;
 	path->dev = ctx->dev;
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..64a184bca467 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1868,6 +1868,7 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
 		path->tun.src_v6 = fl6.saddr;
 		path->tun.dst_v6 = fl6.daddr;
 		path->tun.inner_proto = IPPROTO_IPV6;
+		path->tun.encap_proto = AF_INET6;
 		path->tun.dst = dst;
 		path->dev = ctx->dev;
 		ctx->dev = dst->dev;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index a53393f8eda0..1b9360d54dfc 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -199,12 +199,14 @@ static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
 		tuple->tun.dst_v4.s_addr = iph->daddr;
 		tuple->tun.src_v4.s_addr = iph->saddr;
 		tuple->tun.inner_proto = ctx->tun.inner_proto;
+		tuple->tun.encap_proto = AF_INET;
 		break;
 	case htons(ETH_P_IPV6):
 		ip6h = (struct ipv6hdr *)(skb_network_header(skb) + offset);
 		tuple->tun.dst_v6 = ip6h->daddr;
 		tuple->tun.src_v6 = ip6h->saddr;
 		tuple->tun.inner_proto = ctx->tun.inner_proto;
+		tuple->tun.encap_proto = AF_INET6;
 		break;
 	default:
 		break;
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 1e55644f2edb..90360406d11e 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -135,6 +135,7 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 				info->tun.dst_v6 = path->tun.dst_v6;
 				info->tun.inner_proto = path->tun.inner_proto;
 				info->tun_dst = path->tun.dst;
+				info->tun.encap_proto = path->tun.encap_proto;
 				info->num_tuns++;
 			} else {
 				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX)
@@ -246,6 +247,7 @@ static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
 		route->tuple[!dir].in.tun.src_v6 = info.tun.dst_v6;
 		route->tuple[!dir].in.tun.dst_v6 = info.tun.src_v6;
 		route->tuple[!dir].in.tun.inner_proto = info.tun.inner_proto;
+		route->tuple[!dir].in.tun.encap_proto = info.tun.encap_proto;
 		route->tuple[!dir].in.num_tuns = info.num_tuns;
 		dst_release(route->tuple[dir].dst);
 		route->tuple[dir].dst = info.tun_dst;

-- 
2.55.0

