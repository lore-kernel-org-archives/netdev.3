Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C63375C3
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766772; cv=none; b=BFRPmH7YVjBpuwun33LQj0JVuokQGPnWYhrN9SCCPn+MPY6Axf/5KWmqgWcOCYGo+R6xSg7CNNwn4nPOMTfGe+JnH7J9GYjGDpFu8and1pqREjgykuqNBf5WCOBX2wPNDV+ifNHYh5mbHTeGP1pS6JdKP6lrKeLAdsu4XZKn6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766772; c=relaxed/simple;
	bh=AmYTVtq9q2zdn0RuPo3cddtrzQkCt+YTwmkXJN2yUuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O+ceAOtz+hOuug+u+SnXppEkkiuJh7BWkHACsHj7yo6dyLspein7ov6qUe718Mj09l0Dq82q3fEMkkqB1Xmcph+idp/wH2HLYgOSHbMm6Kiy8IqnYtq1Ijw6ujmOqd37G6jXdJK4oDFxfPTVBLZJzhKM7gOtj/LGBPx7eUyjAVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aqBawn7U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gt/GpCBU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aqBawn7U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gt/GpCBU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777LVI3363489
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 07:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fE4Th4zCBtqTO9C1K+gn1Kc8P08Hlw4ollCF0wc+vGw=; b=aqBawn7UPQKb2I/B
	/MFAC09C6D0z2fnwiCEfVWt4OOQ35gHZkdRDbx3CTV0Emee5xccVQy6bbN1DVKDk
	iQHFiXneu2LiXBfwC/qg1XQv1I/GXppXvOHoqM/H0+regLtbAiks6nIEJfE7TDwV
	3VMqVqo0ybvKec4EHxgC5f4UZ07XUM9OpZsCPlsiygINeZcvhnlIq97pDH2bxeVR
	Mi1iHrsMsquoL3Tbizkv1RRw5XobIJ2HRuSEv8LT71zv37E+XuqS846ftp7FKnYJ
	DbtmFwo9mxlRjX+alYEQrY5C3eEe1XO7sLZkyVOCi8k/vUKhThW5Dp6Ulrj1Wr50
	vb73Iw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj0tq1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 07:39:30 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-46a12cfc288so3450783fac.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788766769; x=1789371569; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fE4Th4zCBtqTO9C1K+gn1Kc8P08Hlw4ollCF0wc+vGw=;
        b=Gt/GpCBULm6HRUmMMQqa9rdHyXQcd2DoFvr/IXMsHuIxvXtUoE3FsbtffQx9pHWmi3
         /OyyZUk38KrEJaJRDH+eWlgecvCeLLN6J0XvizU3GZ94LI668QMF4Huhb8cNcmCkh2gi
         LbzQFkQtpvGALnHQEgdFgcWi8+kZp8y/hMGy5QAUwAXezcmUO8HjdxsKo6ET335FmMff
         g1/dmxb65PmXf+ckPk78zW3S3waHRYYX6TYP3/60vliTwABrdegGQN/xlFw2sH/KbEm+
         9K0qogs7WxplwKY+ADQTHLRwxpC9LAzmFGkG8oIdiPh+OqWzGpZsoQBclU6LmOEA1XK5
         x52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766769; x=1789371569;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fE4Th4zCBtqTO9C1K+gn1Kc8P08Hlw4ollCF0wc+vGw=;
        b=rtwmXm/KRH6B+EZFS2Ua2DhfYWQevsu5mdqchxmsZwl9s/zoHA1x5bv4Qjg+Li+ZXI
         ssCqoVKfaUfknLwq2+IyzVO9CUz85Lt1z2gzSVUTSoAnc+5hK1o5j3cTHyiog+TbR9SJ
         aVtLaiuB3MscptraFgo0KushAZFFFfqtNqbISZ5SjazGMEVHFYwgtW0gmebJxyWkVfL/
         BJ4fc6JCAeQtMRmBThqsYOuxn1flmWBNQzF+qOKpFfXCCbqRRE+LJzx0JS8gQmFAyjzs
         aVT4ImxDd/l4y+eLwsxoLYs0bsil7ktWDcCw91TOnnjBYiDNa0NiyjqhPS9VryRLdGmG
         /+Mw==
X-Forwarded-Encrypted: i=1; AKwUvBzFkiZwufRYnZwQ8GYeV34SK9gzD4s9sg6u0aaDUzUidG1GrhB2ej027U8k6JcSxN01tr1lTJQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lEy0XeGXCtlNgvne0xbB5no+iOWbX88aymf70R9l3NXSYqQ8Yd
	A0VOWAK4kQdW4Q7SJf7Jqar7HcnaE8hNQHvVzOzoBODyfT1sjbgLZrEtmv5p9cLlkvJ9jy4q9sQ
	iExr+zDe1vkdA07XNJdnk8P1ZM5Vq2Xow4hB6CA0ZPLmenqxkkPCxe4jtgR8qAALkTi8=
X-Gm-Gg: AYBFou3zV+hYw1jdcCIlazGFtka7JWYjSO6CGQsfn4BexeI/RqiIA3l12BFG5r6Rqv8
	BnPgcJ/YSxcQpBGu41Hrr5O9IV9wfMowIFvJgKt987dyX2wM/SuXvDM9Tx0FYLMgjXzdxlC5Blb
	edCYYVA51expnJnapK0E7x3qWzZWxejlAADOnqpwd++koekD+c5IFKR8PXLe62/6gJUqy0BQSq3
	pJ6OCnoOSy4sMh8RFxEAlRHRU8UQ2dtDf2vvrcoGX29TxoDIs4vgifUllA/GqutirHpiVYKzRHU
	WJgTtM0MaGlCvhfwzqzgDPjZSCknLq0pmDIrxkYVX/BevBxM6T+OXG4EyfxRsMinKC1VA2yHLVx
	M2BvSQGdraPge6w==
X-Received: by 2002:a05:6870:3349:b0:45e:6cd1:9a3f with SMTP id 586e51a60fabf-4754ece1b35mr23481662fac.0.1788766769591;
        Mon, 07 Sep 2026 00:39:29 -0700 (PDT)
X-Received: by 2002:a05:620a:936c:b0:939:6d2a:6e38 with SMTP id af79cd13be357-9398044643emr2074255485a.33.1788766450579;
        Mon, 07 Sep 2026 00:34:10 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm232774415e9.14.2026.09.07.00.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:34:09 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 09:33:38 +0200
Subject: [PATCH nf-next v2 3/6] net: netfilter: nf_flow_table: populate
 tunnel tuple regardless of inner protocol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-3-7c6ac1750725@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MSBTYWx0ZWRfX1Xu8PEwlRMsq
 bfrQHCiQAZN4BBJNqzk0HOH13Y1uyllt4zQ4Vm+mDHTH/FDpoYw9csDzvW+oLVkMUl4M9dMO7sm
 PQaAdEL03c+Iywq0oD1pWmJM22J61y6aG+DatCEp9wW3nMTOpdfqJ6BGDlu1LeAUjOSvCiNH+yP
 cHDdXnETtlLG2DJx91PQEofIQBbxspo2pBshZNSZyC9Qi3Qn3eYe3M64PZ+iCRUK+Z4Y4QZfj6M
 Jn+pZnT7fnlUESxk492RQUT3Ua6DZFg1uKTAJVPxeaBOXGkcZjB0UX1pyTHF0+NhpBwTMNgCK/I
 agMcPvg1GXGdwQtu/miK8ffzvqJQs97dwzzyyNUNNkNq83r+K7/hUyyCtaXV2O83FKIFiYVUc2K
 x+JLuluPxOO8hkSoVg8yXanwN6lLVnCvNeNyoWd/NlRFptr+X8ImlnRBUEc/Vo5yW61JXJWgWnn
 295fwBoIwhkDIJ2GZYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MSBTYWx0ZWRfX8b/BFTOubcQo
 TDmUFdyESNHNJIsoXZ4CedwT8K2e0am+QOg6mYDPFBHQwr8BZV4LT8pHMYPn09bLbCVL2CxOBhM
 xzsakh1fun/Cs9aqx9dNYcU4FUk7Riw=
X-Proofpoint-ORIG-GUID: I5BCZcZzWNhhWHc0n1w8j1iex7c990or
X-Proofpoint-GUID: I5BCZcZzWNhhWHc0n1w8j1iex7c990or
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9e6a32 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=9AI-LCzJV_BIknmlFlkA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070081

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

