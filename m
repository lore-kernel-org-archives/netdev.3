Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559742;
	b=fEoEHtoJDNgeY1tpJv0BIKflAGWLgP2QUy7c8xSMY54iRJqv9yKraCt+dXPp1JCSheg7
	 DNlDYy8NlvoKxoh6f2ZzrnGNUVmL+OV7TeI2dt1jAl5BjZdiW6aW7PAWdJGyXuAXOlJB8
	 TRfmDXLimB3yAM9vXc6C3nJngsT2OSUS/SbWfSsbmnuBqM6nFp61kkVHp7HMQknwefkni
	 vWa6n0jMXJEdCiw4/Dr1+FfsJxYhM9QT+X95XO0BL8Xi184OaG4FEWqRUG8y3NQPfRPA4
	 JQvFoauu58OSWvc2kAW62dHzgJnPd0R5ISpTOYywFO/FqGTbgHZoeh+YtD73y5tP/FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559742;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
	b=PWFFAvndtt6ooArU9pwutjPnVfcmw77Wzikk5tqcuutLMPpbvFhsoJ2ZWclN1D7TSHDS
	 vurjSMBtmXTxldHcYdMxEans7q5VeVuHMgM538W0iUi5r5bM8LsZmKVunOT7oRwLwiMzf
	 ombuSH3L/MOkMs13KuK7Hq2I05BgC8OjkfwGNJfDUQl9ZqHNzb4XDuBjB1cU/WN358kXC
	 2FZYOPzhfwiCJKtN04KDYrXP7Ozh5SrFeeNFRBlX4X1zYtn4kwm5Y8zVAra9pH/WNLi30
	 u9x5ZDxBKq/Zva6WXpZlYrLb86RHapmRjb+XE4yWvu9GnQN7vebspdeyQBtgSoBj90Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=biN1YAb9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="JPMMT/PD";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C33606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C33606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=biN1YAb9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JPMMT/PD
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HQLVf1452791
	for <netdev@vger.kernel.org>; Sun, 1 Nov 2026 19:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=; b=biN1YAb9EyBE1Cv0
	iPyf7+JX0Ql5uxcicbd6kqsSgjK+yn2lDQvdEgpTVsRkDRU56bZm2UYqal5+aNoG
	AwWe42Dsd1zFxTqawpAkIurQ91jSPxyqQx0dl0QyMpfnOMWj/NI+phXIty35pBQU
	nUJGfQ2GlVsO8A7Wqca0k79W1JbyTbB126Vxb4psPI+tP4Qxy6P3PIOuCaBz5rKw
	qPwAEYsXsYLH8DXNWpTA33fB9eM71QQqN8nVFa1s762tNMRZ7egrF0X/d37ZRRMZ
	Dt8kYwEYQBu+qw9GIRRNpG04mbpFQdeb3eLJyOBWQqi/3+6jGm4wwrLgUAvWJ01F
	cA2EsQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkmd1g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 19:02:19 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7c0f07b4e97so1880328137.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793559739; x=1794164539; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
        b=JPMMT/PDG/Qb0ePQ9PRt2YliE3wIZdmbzZUDkeA4/2LgnkkKn7m/dDsZfTcjElVNNP
         nLt1QV9k3lEh4Ild8KGgRjjJS4/wmrF2D6iA9upf2zqs+Ir6YrcklCEl3usfnYiWnI1P
         52uS4WZqazOsPdOYnnNGVoUi0UrNEYmHPjqQtL2N14it05czj8Ux9VCoPCJb43SAj1zJ
         d8mZukNXPyYjFT5NJdZewJQRoLvM1BYHEM/0JAtVgPcJPf8BCxud7rDZSiX3cWqI9je7
         bKSi/1ldpeCGtIh3BGrgnegqgYH1vn9jDxhHiXPYg47uSS55EBdat8Gy08jIIbbqiITC
         497A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559739; x=1794164539;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
        b=BAJqrEQSJmtqnA2S3KpfQooaasSQoVKut53gPM6QOMhfDrK/Srn+vZp+ztOgxR7+Sl
         K/SwJ2prSenjSjxLzUPe2QELatAoukHQzR8xMy+eipklpiksSQHzHL+TcnhkGQoGpms/
         +Wp69p3vzQhEB2Ii4nZTc1mHON6Ekjnl6UjIq0qmea1wXT1ToswvXaGWhMT/quFhl2TJ
         Nqw8Yo/38HHgorUM0KjuHaSMYfRHSvz8jzZ1bUk28URioW5a/NEmIQ9pCVdK5qKApeTr
         cOzoykSBdbavYbC/fMJfEZSfSx5gPfqxwTb4LXXwlPHohvJeAKOtXgUSS/6dJ6azX361
         jw+A==
X-Forwarded-Encrypted: i=1; AKwUvByuKPYftHIQvws8ZFK7TDhFeQW8l5d7BJEWcvZTkTl68lnOvO9l2RqNed+BigN7rjjj9+Ate3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z/EjTgq5/Sg94M6/cVGBZq6sbveYXkCKkCYy+DKjHyk4f4Y5sV7
	VyP6opQibI1ROiZwPKIQnJ3S4IjbwcDowPpfJrFyZJud9te++8IlJ8hZgFG0lzuouyvnkAOM+nA
	XTRff5OLHoMrVb51OCjRi3DET1K3ALkonlfHLIVwHg5LnhY+J+hGYKMIDOD0=
X-Gm-Gg: AYBFou2vZ1DlkRo2Dvj1AWAdk0XSRnzOTUCcgZiD/RSEV/i4Xej9ZwAJxwaM0DhQOpN
	HsASRi9XYxdmPJbhUh3AhP1UQUSMyMl+Hl1U3qdOn0kBSop8qveA1pgxUJvPqPIoOOK+U1d1Fxq
	LTh7Mn2cNqkiy2D4lUxzInQZrqvqEE/07B9uPK8pJLl3ddrJ3esjofHrYUgnsxkk+NQROUYVEuq
	u233ZWgja1oDwKCvpHCtSXZJwCte/rUbvDQgcJetKFQ1lc2CgDSu7rkOBZztasw9dvWK6K1K2BC
	XK+uBqVdK1m97fKZVAhNnPaDLYGwsi98u/cL07z3KOndj+lBDBDSrlFIa3QwNh+KcJRq11VUwu5
	wbdua6GP9GOL7K8QTR0e9X2p5IEp+oySFTi/M/mNEO6uFbTxwLrJBBCaT4ahurFA=
X-Received: by 2002:a05:6102:1499:b0:7c1:9f20:36ad with SMTP id ada2fe7eead31-7d0728aff1fmr3992477137.2.1793559739284;
        Sun, 01 Nov 2026 11:02:19 -0800 (PST)
X-Received: by 2002:a05:6102:1499:b0:7c1:9f20:36ad with SMTP id ada2fe7eead31-7d0728aff1fmr3992464137.2.1793559738768;
        Sun, 01 Nov 2026 11:02:18 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a84esm17150159f8f.39.2026.11.01.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:02:16 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 20:01:55 +0100
Subject: [PATCH nf-next v2 1/8] net: netfilter: nf_flow_table: recognize
 IPv4/IPv6 in tunnel proto matching
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-flowtable-sw-accel-ip6ip-sit-v2-1-c6c282cab5cb@oss.qualcomm.com>
References: <20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com>
In-Reply-To: <20261101-flowtable-sw-accel-ip6ip-sit-v2-0-c6c282cab5cb@oss.qualcomm.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: x6DYozih05OBNcNUpTAUFTEpMKFl63eJ
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae78cbc cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=m99eJ5p7w77CmUfuVTAA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfXwWanKdFqtQya
 cMvPQemi9f/irSqXCAioXNuCURSTiTsgQZbhPVFjlbO4xEtz6Pw17c/bK1G42zw6Tf2B1IAPVO2
 sPh64xG08B7nmuxxXMdHKvxMblQ8Tnw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX2woKuHZcC9K8
 ZzIQVhJ0xHmBGQuGxTj4yQ/XeQ/5TH2HriXZuchkIh3dfi/PdiCiyT1gHCYFpumiu6i1dXCL+FL
 Zsp57iQmnnba5gJkdE8dFfaYbNr9VaL9EClNouhRiZN5pLmEOCnQwJpAXk0NBqj2AgmzVXdImvz
 7Zk4uYU54n/mfio6yqEYPqyZzN8Fk0qq8HV8a8/3P5TUC1BwKu1MzNyvjxNvagQVM7Kd7S/9tCe
 Rh1lzdgA4SVcr3dTZGU0YpTdLU64/fX5N+C0F2fhL7WBmDR/AVrkzJf+FB3jkCCe1dyIuh1gc/d
 plvQdYW1YQOLK93rXZ+bGVBrA9Qt1Kq8sKvy2yxJN7jtaA3jNvW8VImhxAV9a/EwVaJFT/9Pqlf
 lx/NWOZ1aGWK7oXljzBeCEdRATcF0JYrUEJkFX/KZ77VC4TvqUU5L5qlMyFXlifUrJlBx9UYNJH
 p8vCa2sOCliU+BZOQRQ==
X-Proofpoint-ORIG-GUID: x6DYozih05OBNcNUpTAUFTEpMKFl63eJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010075

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
index 19cafae748ab..e07fa9327eb7 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -328,7 +328,7 @@ static bool nf_flow_ip4_tunnel_proto(struct nf_flowtable_ctx *ctx,
 	if (iph->ttl <= 1)
 		return false;
 
-	if (iph->protocol == IPPROTO_IPIP) {
+	if (iph->protocol == IPPROTO_IPIP || iph->protocol == IPPROTO_IPV6) {
 		ctx->tun.inner_proto = iph->protocol;
 		ctx->tun.hdr_size = size;
 		ctx->offset += ctx->tun.hdr_size;
@@ -353,7 +353,7 @@ static bool nf_flow_ip6_tunnel_proto(struct nf_flowtable_ctx *ctx,
 	if (ipv6_ext_hdr(ip6h->nexthdr))
 		return false;
 
-	if (ip6h->nexthdr == IPPROTO_IPV6) {
+	if (ip6h->nexthdr == IPPROTO_IPIP || ip6h->nexthdr == IPPROTO_IPV6) {
 		ctx->tun.inner_proto = ip6h->nexthdr;
 		ctx->tun.hdr_size = sizeof(*ip6h);
 		ctx->offset += ctx->tun.hdr_size;

-- 
2.56.0

