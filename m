Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714473;
	b=WZH0mewCRjPUA2sKQojLlmBcgVgZMUktn7Y6vTBFOmnfiNq4LwS7pdJwVmN6TsLzkn93
	 ZCUBB7qhmYvs3IOW60szoGfSra7JePIr7qwry306uF0JZITr6RdHS0E2SsfwPRv9Jg83z
	 9Twy7JyED5JcI1f/yZglJ+LP7ikHsz6IdG5UqGF2N1kuM2BHs6VLYmf5S0RelQxRuyKkc
	 jPVBbNmLV64BuH8iM0Yf485+5bot9lTkFn+lzAGyNSFFEOT+KNT1wUplbP1pgDjUXkNMv
	 xnSJAfzPEFV6vT9WCyP+OD+wykuYhLW0wj0/Dy8cCWrSqOR3CtgCQQx5j2EEnW1k/HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714473;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
	b=QezEN/DL4bgJaF5rWQcPz8TCGSNd/D+GS3e8/w50dS9S7tiJYFa7huNnz8Dd7W2M3daV
	 zRL35tmuxAYUSIIufjCKrbe32p+gdEKl6g1Pa78CwtoRXOmQik2WM1SG3HfFlUgWWz86C
	 SeDZChcPyZojuRH2WTvzEMTXktbiD16iVOqLOGm+2GQcl8p1PzUl5ZfGn2oh9cr8gpCVS
	 31osF10M73f9G0++hDgAWKLhgFrotChSRaKkwesouW4RAofUXVIdkym1HZwgZiXgV/ZwZ
	 LMjrUTyol14FMi8FViSCaxaKGi3CE9mIXCFXSfAB+JN52MaVVlMP+Z7zY6F2h3umj0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AuODcAX+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T8ak817K;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9A606A330
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13C9A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AuODcAX+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T8ak817K
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DZf8u3003083
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 14:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=; b=AuODcAX+odnE96rG
	unhsBxUS8tw/cE8LXCIiTpdx5fVoTH8v/HB0Z12EykOwm6/kUjnwZWHRlxxOR5nS
	TiiIjhWzqSXaaO2LWfzLTzSvsWcpsX31guEY68T+8aog21zNLuwHIFyivU6oegb8
	a+MCJV1ZxoZZPxs4KF1S4UZeZVVJ0SjONEfg8C7yujr/nSO7VszYgcbO6c3eM9N1
	jilCdGh5YBx8qfqxgVime+DBVKLjINQvkG+firwAlgfrzgig+rkqkM/tfG5wn5BK
	f/kM7pY5gP5XCfByR1lgZPK4SC33IWqVEEpboPieJo2wsI2oTFQrTfq9MFlR1GwB
	pIVY4A==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq08741qu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:01:11 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eacd2f2229so4101941e0c.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793714471; x=1794319271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
        b=T8ak817Krnd/5fdUXW/nnHWEku0BfbVUzjXQYXMBGFAD65s2H6XQLYopfHJgX6AvbE
         nc9EleofFDNrgLWOecdQwtHq88cYCSXBFme/yYlVXmXVZq0IMyWBXbYMW0Ek4sYVV1AR
         pid8UvherAdkYQrevq5a9ebLe384xaZLB3vdU1eE+7gzztzDr5ocjAu9F4zen4F/n4A0
         OHa3JunW0sxiNnt90f5gWid8RgEh7/SIKsIGubvih7n+jMWF1bs+RWanHNn4SnEc0/mT
         Xy8yS2rGCHMZqy+GgB46X46QQXQ/V4g68TlxE7z5oGQ3Q0bFVAf4p3nD1xsYlsAS3Qbx
         lh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714471; x=1794319271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7QJTXk+yyu2noyd0AhwDq/i52OWJ/qR9UIyjE9rMjs=;
        b=N0LcSm/GTwUBNoXIYWSJnWQ2LUANmPYs6GiZSMBV/DVDbUHp8+00/lPKDNlhidQfX4
         uE/vBn+E4s+9f5ddNYYD/5yubTG1ANLdRhiBG1F3IbBQk96LwVcbTYLzPP86k/5RzJw8
         LVhjga74qPKJjpvK7waXQSWSxcGJHhswM4zfIQJKAgGRVjhSj89c3e0+zBoFp6D+OpKA
         zkQ+bYreUlw9DD+YtF67p/+VWrNJ1M+sMtW7pLqLC+IgoK0y0BM8UIOpFbQImKjgMrpJ
         w7UUNepfZcU6gY0X0TmOiZdcRclD4tvi4eHCC6AnAAHQtB+1tz17TG/VoerZoiGWsjEK
         pPlA==
X-Forwarded-Encrypted: i=1; AKwUvBy93mHUPj8kRQhmLqhEbQKhqDoQxVGSTUE18StwRl0EDP3efSc2XAIv0erP8J7sdH97Pc6gscE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9icvD8hFK4/5LCiHdVPEhHyC0vECY82Z+Ew2+Yqjlbyn/uQwja
	SnXCXpw+ZUiCtjdQevbemutRdYj9V0e6qHOYBxOGbelmjO1hhsNddH9FadwOPZP4fcc92BXUm2o
	baIJ1bIG5IGxX36QVTF83n5JeCVdqMJLPx/o1Jasl1tuUvcX0azK2WN4+qik=
X-Gm-Gg: AYBFou3YDmNNFRiPickSViAFMCxNVpRRxb24Kdef3SBmMcHjYNmXLekUsFxsHo7IldV
	aVH7XlRnQA6ktfxJnC1BgQj4hp2KN8RnEBvcP3MplJV80HRXCPYR/2zwPxgcrK9p3JokORt1/hW
	WcNbTmSqvVePpUqllGG5YMto3BEz9a4RpFUgRYMJ1jcpXIeu39WK7fTLx00AP3MX53tJXS+ctzG
	xDhW7nK/03RYvNNjWif02ISJ8lsyUuzzhsHKTvNPfvStqx1e6UbR3sGzjSqZak+9k00WLb/Xi+F
	ZjRONzA+1p9C5O5LbMaJtpJtc+50gDJdsusJAo6gdCNWOHfGMB+tvVkM3aAVZ5sAaXXNkwlBkHM
	gUOOYlur8jugetttLKbWZSnSBLmcQkvFX/e0Qccsgz8U5yQlWdl7xpXrcmOQGh/w=
X-Received: by 2002:a05:6122:4d86:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5ec6871d3d2mr5829650e0c.4.1793714471154;
        Tue, 03 Nov 2026 06:01:11 -0800 (PST)
X-Received: by 2002:a05:6122:4d86:b0:5ea:aedd:6087 with SMTP id 71dfb90a1353d-5ec6871d3d2mr5829582e0c.4.1793714470476;
        Tue, 03 Nov 2026 06:01:10 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2afee292bsm65369595e9.4.2026.11.03.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:08 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 15:00:42 +0100
Subject: [PATCH nf-next v3 1/8] net: netfilter: nf_flow_table: recognize
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
Message-Id: <20261103-flowtable-sw-accel-ip6ip-sit-v3-1-60b5f063f1df@oss.qualcomm.com>
References: <20261103-flowtable-sw-accel-ip6ip-sit-v3-0-60b5f063f1df@oss.qualcomm.com>
In-Reply-To: <20261103-flowtable-sw-accel-ip6ip-sit-v3-0-60b5f063f1df@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfXxlJgYM9P34lg
 ikdCFRmHjRXoTR8nbxRu+hu90pNRMu9umpVQIm7Qnu9Hy7A6Sn6WndWrxqMA40SmVfkyqR2jRsd
 14qqlPuup+KGOdCrJECr9SK6NUElDYY=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae9e927 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=m99eJ5p7w77CmUfuVTAA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX7yF/2dFPbTtY
 yksBK8yaB8B/FZG8uc6Vmhw25PBLSYprg2d6fYRU6hg2CKOrXTi1eVvDb9TBhEBTHYBKCwx9zPz
 2WdBcwmfBKAyZrIcgNV3KDCJ9P5vALhfqpq/SteGj71/zJ1alp1UpI4syYvLpggBi4SZC/yTabu
 xu1bhkrPxVpp2/IQoqPBR1OG2wLZEQg4kCnNw5N0Nbejs/7ywVunLDTX5+W2lVbumFr0q4Ix/np
 szH0nWT8ZBMuwnpvlpBbnyWvtRYBrXrL/kwHH3VBNrKAJ/qWjK630WT4Rd/7nuVqou1EEZVjxI0
 sSqGb6s2dtu4pR5CC5ZWuD2WU9hHyxNpO1D0gZ1RRzlYKtNQgO1KqPTcvO/Rv7cYFx3iYBlIwCB
 6hEHyII59CHrWaEucHck7k+s28bZIxlDYIUKF3u/HVTQNWtGnWKjP+pzWpitFs2LIO6Cy+ZYjeW
 nfqqAJHFAuT++O+S/5w==
X-Proofpoint-ORIG-GUID: 3bWO4V-1G81ape8t84YMEWS8iCWmDEvx
X-Proofpoint-GUID: 3bWO4V-1G81ape8t84YMEWS8iCWmDEvx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030055

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

