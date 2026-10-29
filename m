Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280938;
	b=VnSsorwWMA13S4W5SFbnDqsK7tdek5ShW1L6K3IS67QOWiOq8AOnejB/GLVIzhVEHDlz
	 GT5tzEJviPfoWTNwwQzs3QoQzxdH0LfAwHRRwhGj0qpbJINOl3e/P2dhHn2v+jKA0fktP
	 E1HagGCTx2PEvcUGn3aXuxv2JHOP7AgGlzIB5UP8ZgtkGscO9ZlVQFKIyPnpRWHfNQ+p8
	 YnGvn7j3/lQ5FS6lXbpvumdJn/F5oEqijV76lFV4PdZImW2RpI9LlpX3bUX7v5627do0c
	 osJzgOPJppQbnP2t4xsYlTKm081eWCC7RfvPqrh1+GvECeiv6stD88+Er4we0DZPMVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280938;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
	b=dA7LWhh23pa8/3tEkBNkkBC/DKNsInIMrnIlEw5UnzSU7QoNAiSo6jORbopNKOku78A6
	 s1seFxM7CDsjcyePFnZKKEauAvLEW8kvkX2//zBE8vqqPZpQuHKtyI7Y77us40uLO5+/5
	 AOntfomfNHMAobhBFmDRbWHzmMqemAgajJs8vztBfltDLC5nMwP2uUqu06gMU6mgRV+Is
	 KBt/aWujl5UbQ9EbqHdJxq6iyxt0dCfm4QbNfilVxjJEfmmpuvkvnGsQWQyZ6IAnGloWD
	 uLYQEnB3xDp9NIBTe79lEiegoxpS/psq3mTrI7K8UeL2MrGbX5DbRVdTVHwKJOiWtbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="H6Q/oBOp";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QyNN+Opt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076F606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6076F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6Q/oBOp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QyNN+Opt
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCeHlW2761914
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=; b=H6Q/oBOp4C932Isz
	95Ph55eoKHZKtyWrS9f1sFFb7ZyN1znXBqF9ZURV9k7H4M7D+wAMl5jgRrZs5WJh
	ztgPaMKCGzH5V2/JL8eJR4TnuSPfJzvfmdTO2PRnCY70G5XworKevioSN6PRzPSN
	8F0MxYlJtsvI1UYsCNq62bLh5ZaRP78t2FkV5dK4Er975Ah082f5gIAoXdG0ONph
	hnWD9FDMLIp6o9nbf5zn/PB1wmC50ULhf+zQZzGhrAHKZj8vCFmAjCzqwONIYYSP
	Yrmqj3a+auuOHFg0hoMgLu6hCywgBLKlIYuIFW/OEIM+cSViBLivifVVFMrSR1CM
	B4EHlw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b10re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:37 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-988bbb0ed9aso1780548241.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793280937; x=1793885737; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
        b=QyNN+OptFdlFF0K7m/VFTglUKgXllGt0KkClDb+0MaVnmzNfWr7Xs4rOEiqeHyuSBI
         F32On/ltUjvOuHSJaSoTcz1CUm7MRF0nEKivPdbgeHlWMzqdy2eTsycxyfWbSgaqipYp
         oUvyugLGKMlK30fylRIJ40xnyQWmouXNMamPWVPgC03PcYXMcQRVMb7SITP03HKM4jxW
         bPnCLaTbmZqkomGpSCwiC1jAVibMGccjE7Scd3qNIu9zQrRZ2ujOG0AZtW3bpWnk1p1e
         KzHHLM316f+6ENSUEMY73ITAijHxorQ79psHYW9v3iFixIZ/cBtIL+pRUMbA9JY3BiTw
         MJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280937; x=1793885737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
        b=BDCMnBGpfdwRvM5aSBfssybIlqDz7sPP+gw7cydClNPLrK+R5YSspyG+67mYS7+Zqi
         fNQEyLqoopm7z71656xMawcgUVsNim9auZ7y69U1zLE6fBl4OtohGoc4abnAUIiTQnhP
         fx41N5+EiUe88WH4He0v40MrtMtd75HcllE01kODcdNNp446YgwSoXZU7mghYcdGZPYi
         47C0Y6+laJjNE+nzqdDry6DF23ZD3ymLhdleXDuiWm4JmK0OyhbhYewHirnQOXJnfMLH
         rN/QyXCrOatV1xkgpjUvpK8IEvv8A12vU6FmB8YwOvNVrbHRy1mntl4UfKjGq6LJUCug
         Oiig==
X-Forwarded-Encrypted: i=1; AKwUvByQVPgq+/tS8u5ZAkrMt7UVjaNHox+Wv7dNqIa/HcFgOUE1ZMN6un690vmvOpvLXRTV7QsDja0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYjuCk7ReVOdx+g2A0hodMcX4W2sq+LJCaiSDghP/xggf0Id/l
	fBBMdg1/eNi6dPICoHP+0wnscVJrCG220XRGpgyE9fOiPD7jM3MgorTZibQMMvU44TZh5Zji+vD
	KMQQOf1Fe21P2WJBwGxPsH6t2GGiQFPLrl6zUL31sirBXFXzqt+4gI3/Id+g=
X-Gm-Gg: AYBFou0DFrIXKHr0mq8HQ0eenMe92O4Cr1TYMEyhGroqZhw42IWTio4DOLYyBZRpl07
	Jru7jERcuv/85D8NaUgmN76djfAj5uGB7IgyszrsRZz9IGLZFeUfdbPPgEmcxxoiP+dbxFTlZ7H
	naQKpemEQbgzC6tt/4E1Ngz9kqb/1/1ib1/aDlVvDINSg+kboHYCr6ztOZ+fGeVdIBRCCMqJcrO
	CqTqG7bbl/uK1YPLUji/HoqIo8R6ptY0u/Njngyx7Bd3JoROYkeI2ZF45VAB6EEj2VAmPZtxy/f
	pWq0VGdi9NYgd0X0+nVfnQFMRCQL2nIAbo/3r6UdBaEx9cWk5WTyHdAKciixOA3Zfn9vx9XC9CT
	LUiz/86PWSqR2Y7N4I3WMqpXcHYAgtnIlKTup/TSE0XVhG/6kzyDZiJp2DwsRdnok4VO3UQms79
	u02qddPMGzGQkSoaYBbcFqBw==
X-Received: by 2002:a05:6102:f9c:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d03a499792mr2652615137.18.1793280936656;
        Thu, 29 Oct 2026 06:35:36 -0700 (PDT)
X-Received: by 2002:a05:6102:f9c:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d03a499792mr2652592137.18.1793280936084;
        Thu, 29 Oct 2026 06:35:36 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e69ffb93asm2380618f8f.8.2026.10.29.06.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:35:35 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:35:12 +0100
Subject: [PATCH nf-next 1/8] net: netfilter: nf_flow_table: recognize
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
Message-Id: <20261029-flowtable-sw-accel-ip6ip-sit-v1-1-6a17c54f9fb7@oss.qualcomm.com>
References: <20261029-flowtable-sw-accel-ip6ip-sit-v1-0-6a17c54f9fb7@oss.qualcomm.com>
In-Reply-To: <20261029-flowtable-sw-accel-ip6ip-sit-v1-0-6a17c54f9fb7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX7BD9JJa6WDX/
 vdo+Pvs+NQ/xRGACTWTUZ/CTY709A2EvpjnGq7hgQFT9DFwg5JmXI7wY1ZVSzOFsBhQCufOUu7s
 lVgd77LmDvYnE9njzPlvFalp2NTCJLk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX/DI/wdCXUggG
 vth+rLnNzObYIk2sLWonCtHD1HlD0GsmpBWfTvXRme5NTP1MDG7Aea/87mySwxHwRnIaPq6Lwea
 wIlYmr3O3pBtpwyVl8yYe5el1jJz1kpZnphVFoqHm5yB9YCJ7N57x1N3qVFvoKLVPf6dvZPHeap
 tG9AjGgGLoRo/7SqRv/VivrZOsHggJzXioixTxTkvRyo+oJHkPnD+2vnjfkgO3xtRZHz+ABMQUs
 9CzMWzXqNXM4Z7nIfk1gK+1Mkfi2H7ZbBQfE+Fv9pVymCzW/L9Q/Y5RFCXJF5A89RNnyXC0Dwdl
 2K8k/TSU8hPF4d5gUoMqtpu192xo8drKqSWbjirnR6BrjO91j4R7QIk9lfobWbyP72hEDYgqf7t
 2YTu1nWRGoAdOtfboUbaBaf4ivxklIOqdBz8n/EXXLRRGOT6hGfV6Kg15Z2Cq6N/dSEXQu+NhNH
 FPEds9LDlKv9940sWnA==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae34ba9 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=m99eJ5p7w77CmUfuVTAA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: B3fIK7EFi-ICgoiyEfvetKqqeZKjRtoX
X-Proofpoint-ORIG-GUID: B3fIK7EFi-ICgoiyEfvetKqqeZKjRtoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290053

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

