Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E5415F20
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766451; cv=none; b=cmpX3aptc6wS0emXLNeExxa9pXGdcz96FzoWPVwYl1bQpIrqsnIfdoYCwn3KT8BtofA+WHRCdPP+4mVILT0sL3/GRhyMd+FOB1qXeIo1oT058lbLr5KFvBCVyMqtfCVFzfAyK/F2WaizuT2Jvrj1IGYgsow62i+9jl8G4oQLY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766451; c=relaxed/simple;
	bh=lHVF8s0Wcz9LBxO8G6crtjxSLQILW6JFK03HQ68HxHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DbukUFgsoI9LTrGppcWFMq48IhXIlgVzM4hQZJmImXFwhHD2yUVJ4PMoseK8PpAPnRqT0MCQxVCKr9iwWTRJA77k0BmMWGGT0WPvFjh+sMbgOyZ67AzBKwWCOeEZQ4r0bVBBA23S8M1O0IH43mfmnXFCtXnu0OgSs4CvH/R+62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ecnvviY3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d2GjgiHx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ecnvviY3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d2GjgiHx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6877NNHV333057
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 07:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPPpF5ergNhRT/pW00RFS37TyyLLqr/jihR+fYpv5CY=; b=ecnvviY3wGMI1gMe
	y2TIqbcELMGotD02zoo0z+VQKj25dq8XEsRbb1yRe4qT/kaiC4TfKls2pRkkwuVR
	VDNCnT6cXqA7FTPFgjPxc3c0yhWzwuuRLc823yMEYRjYHwyl/d5A2WDo54Yjc1va
	KoPB+nnBdB7NIw7INS5pVAp85wAPkObs6F+KhY0FTZkT0macq91GrO/+Otm3Skpe
	0xizKncYNzf5GdBdDyZG/KlQewS7j/ijFF2UQhQRoZ+mTFB0gLzgi2JVeLK67p4/
	Hz80X0tTb59U076oMjmvpyF/rFKUTUoqOk+YetwIGdbjzlDtlrhZZYD5rsyMZEZX
	T3FJWg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghrua8550-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 07:34:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-933023a5980so166559685a.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788766448; x=1789371248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bPPpF5ergNhRT/pW00RFS37TyyLLqr/jihR+fYpv5CY=;
        b=d2GjgiHxAaFVpOPOYbX6q/UCBhW8ARwNJRkugaO1rvmsfYDMfNonnKyffdo1xmkQZf
         czznPxVClRYwi/bxFdAenJpnNp0djV/aG9Or26jbyTYpvKYQm66Hh/hJKoebeX00ru3B
         FAVHIC4fD+bNIuC9YRY7bx/3MjC1JzXyEtqNYNXKX+onab9i7Nf0XpsInM3xCoir8pLf
         /l2cKkjNTfaVe6aWmsLmn2GmdxHzO7mOIqzptk1SO4cDccEzX9tsQQnnlzigxqpw3zNh
         eJVd6eSH/3Vk8MGKQuUkXqMvNcXV3k4e7vhV7brD7B0ohYq2HV66tBb+qvNCQPHeH4BV
         BYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766448; x=1789371248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPPpF5ergNhRT/pW00RFS37TyyLLqr/jihR+fYpv5CY=;
        b=pHJYXiNGAeEahY+vw2xfW7AYxVf+O4IawUQ9VEn7qxDur9OFuvN7651+HjwEQMmeX/
         sQjxobjQmpRZqNPRWRqsmRt77PzzyoCJzVhLWHLmw16bINzO2TbsIpFFzdAfweq639Y4
         C1AQ7vnnXFGROSkM0WXE/BvR7mvvnmD5z4CL6FRZKBxTWO69HHr8cXk3N+sdkn2DOgI8
         DOdPmItYZ+6YLnoqcR4xLcwjGxrCXhG4wT+byPmSYwHDSBG3v/k2QaQXX3iS33XwSec/
         WJB7HXqlW2S8bR4NWtpud9rKa1Pz+tWLBr0syhBXcCkZZpR89O3vb54eEdgR2pmo9Iic
         5O8Q==
X-Forwarded-Encrypted: i=1; AKwUvBykPsDzrHS38KpU2YfoEezE8cq+Uovh3wTj4TVL/Rri02R9G6TFFtp6Z+a9GaQnM99aB7CKgco=@vger.kernel.org
X-Gm-Message-State: AFuF++lrMkWXqungLK99b61Avu26FQEgIbxQAG2ih2WPg40NJy69vpzO
	G8EbV7TNuknagk+gZlDNYGv0dlvLPa37yrkqZcfVEizW64RlX0b3GDZgz3C+wTe6UybLfWtyfDm
	g1LnSX72p32Yh/OkfF5yxoB65VQGkU8MQ3s2ZtpE6K3aaCaSe0Dl6BToWVzc=
X-Gm-Gg: AYBFou1DkWwERzG8cwe6fxwr/fRZLeJK44dc1F67CmnY+2PwVYtIlGBJ7zbOQ0ZeT3H
	z8+aNCpoLNI0G2SYcg9OZKq0vBabY6vLFABYLZg3BI4SGuwsQDyCHxzsN74YbtdAukGIdC5r/Vr
	tBxXn5MrlqzqkrURcDnG293uILU+Mvx8Vdy8GO3mUCNmxBQXC0M44AkS0tCrt/j8RvBuzcS0D3P
	XEP6Ni6TPaaGiBYWg0YbvS5CzLU4cDj0D8XdWy0PkyS7B60reI0j/P6FfFQ39mfQ2jkmfiygHUj
	hp7cX3kQKLRljZA0GJ/k/05BRh97V2mPPEH//TsrYay8I+J3RS4Jn3ttfKse7RDXfGdGsCOBiGa
	MvpPrc+KekYLH8w==
X-Received: by 2002:a05:620a:4042:b0:939:869:a8bb with SMTP id af79cd13be357-9398034f09bmr2154007185a.14.1788766447962;
        Mon, 07 Sep 2026 00:34:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4042:b0:939:869:a8bb with SMTP id af79cd13be357-9398034f09bmr2154002185a.14.1788766447478;
        Mon, 07 Sep 2026 00:34:07 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm284358105e9.12.2026.09.07.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:34:06 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 09:33:36 +0200
Subject: [PATCH nf-next v2 1/6] net: netfilter: nf_flow_table: recognize
 IPv4/IPv6 in tunnel proto matching
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-1-7c6ac1750725@oss.qualcomm.com>
References: <20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-0-7c6ac1750725@oss.qualcomm.com>
In-Reply-To: <20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-0-7c6ac1750725@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 7latPMbQ5xqMt03xybslcNDVUoDV81lt
X-Authority-Analysis: v=2.4 cv=U+aiy+ru c=1 sm=1 tr=0 ts=6a9e68f1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=m99eJ5p7w77CmUfuVTAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 7latPMbQ5xqMt03xybslcNDVUoDV81lt
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MCBTYWx0ZWRfX60Yio5qUGaIA
 Pw6yjNnceX+vFamWjKSsrOGLbkbdjSYz4ZlE6eklU6hThRUjWSbo3zy8kvwqaOYK+fVkB0YSN5i
 9P6XP2m8XvpKP0644edqNXgTWjjzS4g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MCBTYWx0ZWRfX6VU0HKj79yGg
 FiYl0h4KmYC3VY0zg04RSgKIT/hIsYviIv1VEeIWcpCjLfeIgHTWVntgmj+Wy8V8E0Od6ashENk
 Rug5KXFvhwUKLhgTbmBVTgTSDAAyoezm5v9UjQiU3EGYSGwMzUAjsoJWkalESGOKFYqSI/GbRKF
 safLJ8ycq0QEmEgVniXRinZykPQImZ6SnnI9lmceTFIgybbQ25Spybck8/euXWeOmfTbEzWmnGL
 X0oecuz7hWGySmpeN1V8PXtRi6NqWEm+nA2gt3r28wUH7384iXIZdjzB6o/7kmKDm317yvKyy7M
 0K0FiVFuwvdv2GucLL3vdOyRRQm7i9N9orH1yRwI0vW3hUGRKAu2/1fuHbeQzmC+ufIdLBZL287
 qm9WZTRvhWc3Rtg4NS23K37lWfPhO8My5hosbqoTlUCpnhb0B9WhZG6s7asTH/nZfP77vo3RUz+
 qY1lum+pzM82U5UxsAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070080

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

