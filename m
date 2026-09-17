Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8942A14D
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633790; cv=none; b=BBKTNFYPYIQyIhDCy/RbnKMXrbo9+FEwBhY11EnhgEI8CN83yjo4X9QyeziFLyVA6pj3MJf1pOBq2bDFgB2nlwx7awDx7qvBFvx/g0T+MnnaXWccHGPnFVOrxpwPbUYsFZmqRatZW0dXNVinUKKJBhT6M2piSKyqGzbMiT8LQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633790; c=relaxed/simple;
	bh=CFRrn4x6ponRYhQFZSF7DOt0uGwt2i4dOTnusXvOQb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZOmFuhIvcH5hRbQ0WNDFkKrKyVFUJcnBmBpJCzfcehNvqlBPUHlJZmALYMNxG7QODve8WQyAeYB9iVGatzJYSd3NPkZ0QT/kxU263n37iiASahLhjCLQ9VeX877rWN+kmpPE6/Wi/3z8PgrrWtPNOPYezYsdrzG5kXSkcYjqPOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nep53tXD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eqbmLGoO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nep53tXD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eqbmLGoO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H7xMWS396668
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LoFiFadfWvsKDJXbfNr3lKGOOeQeasFcKWql2l4h94M=; b=Nep53tXDRmyvNxjO
	UdWe3HxdJMbHkxJkXsLVuZgfX4eyf9bbheqRvNPFp1RGyxHD1Mrcwdn7hlHpmhWE
	dqSHFmXhutcfrZk//Ta6XX59KUTDmLRH/TX5ORBhjVWFvp1od9Eu7VMu02absITx
	s0TnbZTvccHYtrHjbltIQof8xB5955cCCWa+fT60Z37oaLcQO+3xYO5+wKcg82ds
	VJcu95N/z/F/I8sx/UScBqv1joVb60ZlJbn5TiIwhHigBe1d33CRFgZEIvCP8IwK
	yyeW/LUg4/v3iyPF+W7az8ueIUOTxId8dPdSCcj1MGVNipmDDq7K4FYxjR7NgVga
	DDiN5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grca0r3ur-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f925ba4eso143102885a.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789633779; x=1790238579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LoFiFadfWvsKDJXbfNr3lKGOOeQeasFcKWql2l4h94M=;
        b=eqbmLGoOB7K+4rSeccq8QnX8Mcb+3Pttj3qmit4Dl4eG2UjYpKNyrpG4EgzRX4M7B8
         l/XdlivywPNwwjp/WFqoEXzGh6Wg/xf6+59aPOJNAbuDEcd9hFF9Zm9dAStp6ql/77vO
         g50PTyxddE81LJG5xDganX3FBIzL0PZJCEbacR/QM/vQ8DX9sRx7yVgWJPZs3Ve0rlT5
         noDjFYw8PZiRQvofLheR1/H8ZeDZE+kHg32iP4feevnuY08/WL8CKQsjaYqmt8w5Mft9
         NKiyvl0AnpdnMa0/1X7N7nONgHhogdK3ZyE3fwiTsP9JbTiCtYjhnt+/cibpNyrF+7o+
         FeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633779; x=1790238579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoFiFadfWvsKDJXbfNr3lKGOOeQeasFcKWql2l4h94M=;
        b=yrIFAENAm2d4eVNzMtJsTLfPGnPuDORrjppJQUrPS8R4cJCVQS8ofK0Dp5dymphuf0
         kDdec5ODRyp1kwwJrGiAPasiHhWgLGJzSGoABb2pjucH2i6NBaRPkdAtCq1u7VtM3aLQ
         JzQD/WECZj1Iw7GdTLDZVsrstgNNpDyTjtFaQioBftVpkiZtsQwtpj6OjYtCCfIfdDg5
         ZMdOo5BvFQ0MU/sI5M5TXFIABsj6jD9vRpdwVF13tAlab0LkjcPsHeQhZw/Xqbu5V990
         BOrFE1Eu4vdjDNDI4vGxTjgSvby0a15RtPQwgvFg7i4x3KMkaSA74n76XkgIOylL0yg2
         mILg==
X-Forwarded-Encrypted: i=1; AKwUvBxbHX7SDmIPsJiH/A9xGLS7S+ZdJRcVjGOLEJ1lVOdOZ+oIKbvN8WxuRwFRQ2a13Ih6LA281Ns=@vger.kernel.org
X-Gm-Message-State: AFuF++lx3Q6MAFnsrCd7aLJToLntgm9m3Gh1rwGqYwOjdngE/w5zyQRN
	3+p6+HuPMSaXLfpOXttRo1TiOmccs431A4YNsojy058NWafqB9bDAsZdHqh3lp1VvOP98NJXsif
	8U6qoQclPaniSRYGs5o7rP/3YwYsBaZeqTfdOO90/LE6+LFYzFUZ5VdwV1Yw=
X-Gm-Gg: AYBFou2SjKabtKseZiXspX0RbJkO5jMmNHzpy91y5pZ54N8Xi0rv6R4d9xGU67SECX7
	+V3918hlZ2pfZXm09YfO7O+otoaOuknNrU30ROR9zH/QmaWDGeIi5miG9UelUuu0w12v0bGjV8x
	PnhEdcZBQTr4rUX1+1EdoJ2sNuqTRPxkyodRXgEwfTfbbxalZSPuLrDrWsRGf3Waw/1kxKQyUJk
	U39fnOGInx+qmdg/R5idQZHdJmc9ffXz5JnLmxumpCwhTUX439QHnBX+jZerca/Vk5APBYlAYN1
	/w0iArkrCvZINATCXbdm5Sl/9GDx6xiw7ZT+m64uAViyuQbneE9EI0pwwKsWtrAkiKL7vJix9Jn
	zCYGgsJOHMfpAug==
X-Received: by 2002:a05:620a:7018:b0:938:fc91:91ce with SMTP id af79cd13be357-93bb771e83cmr987990385a.20.1789633778991;
        Thu, 17 Sep 2026 01:29:38 -0700 (PDT)
X-Received: by 2002:a05:620a:7018:b0:938:fc91:91ce with SMTP id af79cd13be357-93bb771e83cmr987985585a.20.1789633778521;
        Thu, 17 Sep 2026 01:29:38 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27198sm13477625f8f.15.2026.09.17.01.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:29:37 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:29:08 +0200
Subject: [PATCH nf-next v3 2/6] net: netfilter: nf_flow_table: set inner
 protocol when popping tunnel header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-2-fd2ea96fac7d@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 8Yr4kvfs9lgeqU5oAQmokzVtzeYO667F
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfXwbPPOyia5cwT
 jiJEgwaJtJa3NVwl8pQb7AToQYwNHaW4DL6uNJos3tJVIscnz/vin7wmKX6Y9oG3swEoFM1cK9m
 wzHgMMRKt92zLgNA7Xm0NhMXw/QgQDQ=
X-Proofpoint-GUID: 8Yr4kvfs9lgeqU5oAQmokzVtzeYO667F
X-Authority-Analysis: v=2.4 cv=dOQzC+Zb c=1 sm=1 tr=0 ts=6aaba4f3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=gKarwEfFoU5_EcFYj1IA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX+d8RgcXZhs0d
 cFsPCFLp9/CVilu4QEORjOMhbiQ2mpbxPXMAJXzddpFN525NCKsKnAQjYoOLZfCTtievZiOe5dx
 wfxqNtLkwO9yOgpwBVav4CW9PeOJ1mKeUtBa13pb2gJv8ga3ZwJQMlDbRXqUMLKcycFiOftGmIG
 9siHQOF4N06cja+i+yXB7vSjNCme7EgAAvQZGA9zLfyKVc+nm9KbfAJpKjfr/9gsqNqjaCsHbOO
 BeCeSNMtwVK+m6eFw/ncrySbji3Mj7Pd0Lkj4wEW8Qdn0FA+4U86MZKAI4QjG270G83n2e2cK9l
 IyRkWmxa1VFdFeIPh0PzhJuX4B85TnmsQS3WsnO51acb/HECp4pgL3JmGounaY1gQEvn7nWDqex
 KrF6RiXEYgOImJAswLS/BdeMT1tj799YMyrkLD8bbf/qTsIi4FKSYYQojScIIKY58ReJvfUIDHl
 HtRumFj+bYRDYOqiRug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170115

Pop the outer tunnel header and set skb->protocol to the inner protocol
derived from ctx->tun.inner_proto in nf_flow_ip_tunnel_pop(), instead of
bailing out unless the tunnel carries IP-in-IP or IPv6-in-IPv6.
This is a preliminary patch to support IPv4 over IPv6 and SIT tunnel
flowtable offload.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_ip.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 42e8de696474..cd636b4cf74b 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -372,6 +372,11 @@ static void nf_flow_ip_tunnel_pop(struct nf_flowtable_ctx *ctx,
 
 	skb_pull(skb, ctx->tun.hdr_size);
 	skb_reset_network_header(skb);
+
+	if (ctx->tun.inner_proto == IPPROTO_IPIP)
+		skb->protocol = htons(ETH_P_IP);
+	else
+		skb->protocol = htons(ETH_P_IPV6);
 }
 
 static bool nf_flow_skb_encap_protocol(struct nf_flowtable_ctx *ctx,

-- 
2.55.0

