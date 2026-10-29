Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280944;
	b=i7JIHHUJhej2YLxUHYs+nmcKEWVXyfo/aor1IguDLA1pOcafVOmld0QSXIJ6vT+6ES/A
	 e/Pf94DGKMjlsi2cr1Gdc6p4TFT5NaFU4l688ZIpYx88x0qlvF2kjjv6gc5hL9svfKNb2
	 65222qJWYUduWL8/ny8F9Dj5tVicilurOka5a/sSJwps+gl1NxSyG6w/tMYrong2rFIWS
	 Tdxcv5P3ojRwtQCaX4gLxkqRrRS5rgM3ZsWr5i199iK7hKeNkWVFtkoMt7iglAJaenLpu
	 dYV26mi5dv1gABtiu+JCDUvj4cZQyqsXJ2291HSooIxdKhlwsg6zYC/navi+OevcIOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=/28GQRdfBjNpaKqoNfgQNMIhyHphRu4eJhHEmguSmaM=;
	b=e5LSXSTzYHcnu7jewD0a95ZUuf3NkC3dLnjmGojRbBm03p8m7Ol2qNzqidO0WtUpC1wX
	 6FhBZVcoQcYIzcYb8GvLnkNZJXaV5w8p8Fw3RwUTTotnz841TsqQOFuSC/mDKhXw5n9Eo
	 CRFb2Xn2heYslDJH10wQBY1IpiCNV6R2tGAwUNIKYidzprixpPUDjgZuH6gWHUS3reJ4d
	 CztJjBC/fsz9SNFcgrM/9j5CA5jm919qMQiZlNzFUvjw9/g3mS0Ugx1VSrpqjhtX4ewRC
	 i52l066GM17i1XVE7BbkU5+7+kuJLcfyfatZ9I7GwmudRc0Mgv8UoH/1cmfaoYCj4NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U+hV56lE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N99pk5SG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE160A2608
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CE160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U+hV56lE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N99pk5SG
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCePQJ3215077
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/28GQRdfBjNpaKqoNfgQNMIhyHphRu4eJhHEmguSmaM=; b=U+hV56lEhV87Txso
	hODZ4Tr9YC/5TkCyrk+ByAID7mE+2r5YtkPcx/NR7XWq0jTAZPROCUB161LureqN
	ZjVQl/lomhnWcDgQ61Ty3ppo6gwRExs1vVsCP8SpeZLKNrZE6Zm5hRDA33PfQOtj
	brIBEIrEOyBZqOzgNv5Lo2YCm00TPvsGR9Kdp8scg0d6mlF+vBI7KfYivROFlgZt
	qJOiDux0zijRCy03pjD2kYyW/lW3xo/v3lbTsIJPSxR+BV9TVod+nZhDFQpt9UGN
	UyoJcYJUoZBnyc2eMiRtF+NHmXG8Diwp2WnAXezICCgD2TJiU0TopJGfkQfRnGfL
	GEdiLQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5s9we4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1f2fafeaso264756285a.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793280942; x=1793885742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/28GQRdfBjNpaKqoNfgQNMIhyHphRu4eJhHEmguSmaM=;
        b=N99pk5SGLMZ3awEIZWchYcuiyaRBimT3d0SVYd8Qisr2QB82xM/d2cUGE8VJEZ8HLv
         P1AZ06ex8JCZlw2BTOL7Ycb8xZQwbV7mBY46+grMgxo4S4mRg22Kh39Fi4yIxGDjeuOx
         VtiJBWdplX43R/6fh3lP1kSraoKKi8KdGBJTtLd7BRN7fYIbiUTPaNfCdsxu18fFf1If
         yj48TOYGaVeFc+ParUGThVTwgG322xrKRu9a8TvgIrGGVF5uZPFJfsrPLmBGsrxXUBDw
         ZcEIvlQx+WAIRRtQvNYCjRgJafDVk/HGrQED6P3vVevidez2j+BepkcXlt3N57dyi6A/
         0SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280942; x=1793885742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/28GQRdfBjNpaKqoNfgQNMIhyHphRu4eJhHEmguSmaM=;
        b=ied28WMAwlEWgM0kNOvXWFS7THwt4VIz7KNBZJiqFkBuGKlQ2IVnyg5cOQaGBk6lk3
         tI5PbIpCMElZk/HeCyDRtvDprCljOCaAzvXb+Zv241K3JPzKO5rhRNUtYJkLlO0hI63V
         1Z895VNm9nS685xFxnDBYkRt0lbEDE/Son4sRV8EC3UOmCTLN6c1wU72E2zTCavFM6Ww
         33dhKTpsh77FgMQInq1E3pgvFEqIfVT/9+l2G/+YBqeF2onfCUsHECpEZ9xSn35Pulb8
         2khAMHyOMZ9a0KQlLc/HsM/vBPAF35cmzHeAruxKIgsAqxZ1QJ6pCpwGsEGTrOztUt+i
         TGhg==
X-Forwarded-Encrypted: i=1; AKwUvBx3W7d2kPFVjVKjsjcdgG0WuK7znMpQqsnLlq6O1/8DmWcKfxcfyiF/q63hJrTbGQm0BNifNGY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1w93vJ7Z+3/WMgoxQmX04ZmzNaHqORqjbqhGF46gWD5E4axEi
	ZyoBVO2l334ljY15Kcf5WgLpkXbXR+9Yrb8IgdQAxMwS8rNKknlbUfefhwjnXR4sw4p3Oj4nOeU
	Mm9yqyJs4GdO4tNMEi2YfKANw6/xs8b+pv68ygHq7VIDymqjMpQkcrLe8BOQ=
X-Gm-Gg: AYBFou3FaKZAlpmAlsLnELoVN6g3AYtEl3ymOg4ZE9IvTCytttGZt6cGYwQ4isp2PaH
	nOvLHvhixjvehSYQQqpCtdHNSF3mwmpG0vMekNLV1pznkPY0WsTCBEnv923mBdRP3PeFdhRiyWJ
	87TZGMXX650qxTYB3kxepjiHgHy6g8jrLsGQN01YL2fSlW7qhIFOonmzj/6h0fuX8n8VN6wuWkd
	xry3sMz1n0dZXgezrx4iv92F4ZXCg7/g8iNbpWEpqBwom8WBkh61X/OL/T1i68FCT43Tx8pH2fs
	PVTYQlQnfPrVegxZTPMHVNXi1NxgEY34ujii/TxrSuqEJeopa8QsI9NfUvCd6YXZ/e039EYBtIO
	l2Owao0IcHY/CmaDwYQiqRhw3J9REp502S/bZAXPNYiCpHsX0Rufje7rTPauWxEO4JjNSsIJuxA
	itYjm1u1tc9qe2oNKSc5ymxA==
X-Received: by 2002:a05:620a:4489:b0:93f:633b:ee13 with SMTP id af79cd13be357-94408a268efmr789318085a.28.1793280941773;
        Thu, 29 Oct 2026 06:35:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4489:b0:93f:633b:ee13 with SMTP id af79cd13be357-94408a268efmr789313485a.28.1793280941196;
        Thu, 29 Oct 2026 06:35:41 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa813d2950sm65071465e9.8.2026.10.29.06.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:35:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:35:14 +0100
Subject: [PATCH nf-next 3/8] net: ip6_tunnel: add IPv4 over IPv6 flowtable
 tunnel offload
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
Message-Id: <20261029-flowtable-sw-accel-ip6ip-sit-v1-3-6a17c54f9fb7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX9XL6sdkhf1Y2
 P5jbleKq4GmcMkavwYh+Jj1uaVgZ0SuBUBV2wmv+LYTA2T5fYni7LYcEPTGePFI5JGUCHR+W6a4
 udawAo09KBUpm1gSXFONwb/67ftQaupky6qn3yJXmVae5G3go9h/R8ZAEYJJnR9owEoYkh5M5RM
 KcAkZxmjXKvZJI8Z8LeWWkbQEe1p6eUo7WEcCMGASapx7d0SQ384kPnoXbxD5990seOcY0aPlGk
 +q10++x1Z9ThDqACSOwyQ0CBC7Dx96A3yQe05lBCRQ+0KRy1QkqxbQ8SbVqztS0gxHodcw1kdL2
 ZjeIIauAnugu7GNUJoDw9XrSoToM9It1glz6OGrilnx/k26wwiWHgSNd9goVlWrH3Yfnf9w7f30
 94V7sxc+zy+PjOSKf6DJ1yjCD5MiHn/Yl+zMhHE6L+UQojJkyUPJjjDthtYxzHnQLlrcaT19miC
 JQoDjhXtNfnTyBModyg==
X-Proofpoint-ORIG-GUID: IrUWEs-HUjOLPnv5N41rFONb19w-unlv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX4hZZFW242Adc
 xp8Eo3OUa0cdFFTUvuNPbiaSAaVvry3Q7bE5Vc05Wg/Al0tYNtgg35iFdE9fxbV9eOgRc0Jmbxt
 /2c4+GbHOuoyoI450KAozHqXZlOaadY=
X-Proofpoint-GUID: IrUWEs-HUjOLPnv5N41rFONb19w-unlv
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae34bae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=01qIw42SU59cxVdbmxoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290053

Allow ip6_tnl_fill_forward_path() to set the inner protocol for IPv4
packets (IPPROTO_IPIP) in addition to IPv6 (IPPROTO_IPV6), so that the
flowtable can offload IPv4-in-IPv6 tunnels.

Return -EOPNOTSUPP for any other ethertype.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/ipv6/ip6_tunnel.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 64a184bca467..9ae14977c900 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1844,8 +1844,16 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
 	struct flowi6 fl6;
 	int err;
 
-	if (ctx->ether_type != cpu_to_be16(ETH_P_IPV6))
+	switch (ctx->ether_type) {
+	case cpu_to_be16(ETH_P_IP):
+		path->tun.inner_proto = IPPROTO_IPIP;
+		break;
+	case cpu_to_be16(ETH_P_IPV6):
+		path->tun.inner_proto = IPPROTO_IPV6;
+		break;
+	default:
 		return -EOPNOTSUPP;
+	}
 
 	if (t->parms.flags & (IP6_TNL_F_USE_ORIG_TCLASS |
 			      IP6_TNL_F_USE_ORIG_FLOWLABEL |
@@ -1867,7 +1875,6 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
 		path->type = DEV_PATH_TUN;
 		path->tun.src_v6 = fl6.saddr;
 		path->tun.dst_v6 = fl6.daddr;
-		path->tun.inner_proto = IPPROTO_IPV6;
 		path->tun.encap_proto = AF_INET6;
 		path->tun.dst = dst;
 		path->dev = ctx->dev;

-- 
2.56.0

