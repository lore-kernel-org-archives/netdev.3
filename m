Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280946;
	b=aVua9r3KqeKZ7ngI4UpnMRl2TZ5cZ4/1/PjbXkzTMlihoU1wvSpHd8MmFaTwZYHM5QbH
	 BPXWqSW1xjSndOY36QsaapRFZUA9ND8UIEVmW7mWPLGt9I4WWAaL1vRlqgQsvazfJAQ6E
	 tHhJXFe0dYEBZIseCnKcXg1FG2j+l9gy0TK6HJB8x9R+UrTU+ddXiPiCvMc6+6wTU28TN
	 sM9FqQQYA2TjNm0AWkE1jDcL4x3BoUEEc4FWEmLkL4kLiqZtJOYHcYY2t2BFyIx3JAeKh
	 R9Q87MVA0oJIkYJj4M7CQWbDGXdPDEOsWgF9PtldsPnQzx+SRek+o502h8PxmQyG/Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280946;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ET+B6ryXZSjsDmJogt9NhGamDLd5Mr29EJGHgALtRKA=;
	b=YT1YgoSSQmOM6BdAJa8gWxoRRBJm07xRd6LvJTgH8dAPI7HONWV0CcAFr2X/rfpZFi12
	 XL8xv83X92RQlGegZJXXBuUBVurOZsArQyfUjwALM9/zxLqlZUPDSwgJ3fjy+PyeIHb9h
	 H6H59eXZrPOp1c8oqlpV79N8gAd1O9m3tUicuIlXnvESZEUEVRWil9obFbNZmEuXLH66f
	 1wjacEkVAcQDAvLLzjLHoGaVhM2Zk1lL8O+5IoCt2E3+4F5oP7DVkfqHRxl7HeQtehy5N
	 p/bEFdUCxnTJO83X6LNk6M5XEAOd0aLD9ROzuldPkSWqdSQH76r+T8IBBSRl9Cvzanw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLNZWpNu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="MuUEM/7z";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247560A2615
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8247560A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLNZWpNu;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MuUEM/7z
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCe2qj3943841
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ET+B6ryXZSjsDmJogt9NhGamDLd5Mr29EJGHgALtRKA=; b=FLNZWpNuL69Y9q+J
	hA87m+KpiHVjpjWNpAoFy/iUnLvdRh4XlAdZZHOMjD70IKfe31wC8IgwrZ1KO4iX
	ZfJD7guBApgv5G9nz8XoTHikXNh44aDal0v/iJ93dZrMbpX6AM/bQKuXnGv02oDQ
	as7z6YLGwhwcn4wW7gS/ctCA8qGoynes7S1zEmeyWMFjYiRqPAt+hmbiNAnS+5Gs
	FstETjx/WZthnmAGr50Prt+Wrk/QSBFv2RIsE4cMIn7cjVZIRXBAArT2DzIgYRBb
	VTrn7Tty8SepSllJpKCeSZWVBfOyVvNLgDMGVCR/oZLNJS+pIN4qnxi3P1vbe1An
	gY+qgg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fgqjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f62934ef6so242761485a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793280944; x=1793885744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ET+B6ryXZSjsDmJogt9NhGamDLd5Mr29EJGHgALtRKA=;
        b=MuUEM/7zT+dPVXiS/DLA9tzqHBiQtr7MVZw9M9n1knQcPF48QBSMkMXw2gfa/mI6ku
         o+si8iurpWiU9o8ROy5YhhyRrht6Jdh2qve6gIvjzvlhvonqBP54l5q8usYGFmtmTkyL
         p9RQ3TYykzCFCIz0+0MmU7fBa57t2TIXCcIo1djmS6fvGRSHgJL95jZ8PWtBUCM9UWQb
         kYqTkZaU3dwZcMFMFDb+qGiPftS1voaDOO+FWzLvHv6ZnmSNC0dyDKaSy5CrsK301aV+
         c4tLr8QvBG90KWnRadlKrK2E7lzurnz9Yd7lRiFJW0xnRaqj+5VlT220MBhWbQy1HjgA
         /VRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280944; x=1793885744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ET+B6ryXZSjsDmJogt9NhGamDLd5Mr29EJGHgALtRKA=;
        b=lv1DVXE1eX/ixY7+fkHCOsR1EWRCq0ijiifezpFC2azrEwM3G03BpVHvjeOcTWz+CI
         72vA6C3i8ktcvBkhRMpbnawNeZMZ4j2WZW0TWM6DgMpA2BDfr/r+jQLR9aFqs50iSY0c
         GJh8io7uSUva4zwNMRrbD7RUud1NAFiFUk6CF7Uu8QkolPBAE+FDAlqOFBdetRaShsmV
         AISq8Y+OnBGIduVxXDe1UtnYdDxRN4qLSpIhgIxOUi6FWTafn0EShGjiQr7PrUi5nXe/
         MCPGMJHelshLUXZnpPxKx5spGcnRvoEvTbVFHz4+SvF28/aaZoz+sfmKnTAyMv5EHOpV
         CGsA==
X-Forwarded-Encrypted: i=1; AKwUvBwTGCFoLJ5Y1bXpOaofPHl4vJP3avuPNmb0Mtor0QUmJUGeNpHwddt+FQH3pA2Sr52DKkCcyi4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1iKd9s51YXSVdCehHlcXLm2+B+U8azJ7ZwN3BqYlu7TtoL9h0
	hG0ZNgavvA7pPFX4f8oGL+evqgwHF0nGgAC+QFurtMvT+t/CV0sZftIC+cwpl3+GLFpItgWqfrx
	Ews75MVFccJUpRpZMLC3sys7TfWHamReQ8wzu6Jp2QskJzdXLV/WW7358Xbg=
X-Gm-Gg: AYBFou0CRv849HM1PS9kNdH/k18oVw2+sYTYG8SyChQgqttUNs95LWUX2kFy39W7fYj
	h9TGlJhmUTDzOBrw3RM1lI/8Ur0iSt/o7h6cZFDM0bTax+RXvgwJMA3iT6/TplAFwOzLsuBgaGx
	96riZChGaH3PVFadVAnMKVuAfRuezhesOv4GDvTX8BMUWsk3csdHAgzcqfuiQhDikbXbRPv0rGy
	7NnOf1D0wx4IZlNvLDikmuW+3DQ/lyR30EdUQ6P3S41DH2ifnk63hfSzb3tGrcRXH+XCggQrtjp
	6ifK5PYISD/fGZOZS8iW+BfT3/hhmpEMpSmJ8XvfjneVg5RobjG6mKT6plqq693HVejsI1TZQsS
	+DOkMwtPcNaqQeGqxzZSEla02fZlCpVOHkSoX87funTKWuxS9BNvof/sQPh+W2JGNw4tC7ITBC1
	6NVjPLfT3FtSO6wm8Ch0rn5g==
X-Received: by 2002:a05:620a:450a:b0:93f:25a0:6aeb with SMTP id af79cd13be357-94408cf411fmr898994985a.23.1793280943530;
        Thu, 29 Oct 2026 06:35:43 -0700 (PDT)
X-Received: by 2002:a05:620a:450a:b0:93f:25a0:6aeb with SMTP id af79cd13be357-94408cf411fmr898989185a.23.1793280942985;
        Thu, 29 Oct 2026 06:35:42 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7fdb7691sm64955305e9.11.2026.10.29.06.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:35:42 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:35:15 +0100
Subject: [PATCH nf-next 4/8] net: netfilter: nf_flow_table: use tunnel
 encap proto for route lookup
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
Message-Id: <20261029-flowtable-sw-accel-ip6ip-sit-v1-4-6a17c54f9fb7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfXxKvKjmJrM8T4
 qIkQlUhbBaHB7L27fJdNVY9lFj7KmOWXrFVnpmUgnIx3VivvAw1mlw+Y/ge6drbZ8zr2MLTjYro
 3vrcIiMs204Ers+j9OIjbqMigwWlvg1yi0ukBY+QUmVAboaSsRz4bAwon25kBT87OkVcOjuQDmp
 zCf19cCHEKq/n1bwluPgLz4e6dZVEZJodrSKU8KLiOY17AnUt6JltCs23/JWr1aesQpqhRNGOXE
 KyP801EqVEbbHc1iNoyla82StlebEPGmVbaZzU/h0UxeJ/ou6wDHjsRsFLepRWrZPX4Z9aPoCzK
 1D5ecRG74B0pVeQrVMKPqWuUgMwgXjC14igSRDaVhR6DPkqSLZlAJBXBvHMKuRIW7GkzynFeP4H
 Zf/Ls15Hx2H671PW4NcCTWnaVLnNk67R3PkkW8j9ca99LrzaOpowJLU7Sokvr9tsBpKDLuF99jc
 c2OOvrvFQAtt+KzwDZA==
X-Proofpoint-GUID: IefKoXWu1LM9qYF7D4600s_A126HqLkZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX8G8h82M5xs99
 RuLLn9sYYbCzF6Ff5R+1fu5HuaIYQy476HvGk3gARVQe9qbzHOpKqa0SxutdMrV6EtgVIrNkfVO
 3W6a5nRapVVA/XY7Gs2mF7LJkW8yhSE=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae34bb0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=BwFUO5JFP4DfzLIXruUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: IefKoXWu1LM9qYF7D4600s_A126HqLkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290053

For IP tunnels, resolve the MTU and the dst cookie against the tunnel's
inner IP protocol (tun.encap_proto) instead of the flow's l3proto, so
the correct header size and route cookie are used when the flow is
carried over a tunnel.
This is a preliminary patch to support IPv4 over IPv6 and SIT tunnel
flowtable offload.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 0d72dc8ae47a..aa8e3f42b23f 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -76,9 +76,10 @@ struct flow_offload *flow_offload_alloc(struct nf_conn *ct)
 }
 EXPORT_SYMBOL_GPL(flow_offload_alloc);
 
-static u32 flow_offload_dst_cookie(struct flow_offload_tuple *flow_tuple)
+static u32 flow_offload_dst_cookie(struct flow_offload_tuple *flow_tuple,
+				   u8 l3_proto)
 {
-	if (flow_tuple->l3proto == NFPROTO_IPV6)
+	if (l3_proto == NFPROTO_IPV6)
 		return rt6_get_cookie(dst_rt6_info(flow_tuple->dst_cache));
 
 	return 0;
@@ -100,9 +101,15 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 {
 	struct flow_offload_tuple *flow_tuple = &flow->tuplehash[dir].tuple;
 	struct dst_entry *dst = nft_route_dst_fetch(route, dir);
+	u8 l3_proto = flow_tuple->l3proto;
 	int i, j = 0;
 
-	switch (flow_tuple->l3proto) {
+	if (route->tuple[!dir].in.tun.encap_proto) {
+		/* For IP tunnels we need to consider tunnel IP protocol. */
+		l3_proto = route->tuple[!dir].in.tun.encap_proto;
+	}
+
+	switch (l3_proto) {
 	case NFPROTO_IPV4:
 		flow_tuple->mtu = ip_dst_mtu_maybe_forward(dst, true);
 		break;
@@ -130,7 +137,7 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		if (route->tuple[!dir].in.num_tuns) {
 			flow_tuple->dst_cache = dst;
 			flow_tuple->dst_cookie =
-				flow_offload_dst_cookie(flow_tuple);
+				flow_offload_dst_cookie(flow_tuple, l3_proto);
 		} else {
 			dst_release(dst);
 		}
@@ -144,7 +151,8 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 	case FLOW_OFFLOAD_XMIT_NEIGH:
 		flow_tuple->ifidx = route->tuple[dir].out.ifindex;
 		flow_tuple->dst_cache = dst;
-		flow_tuple->dst_cookie = flow_offload_dst_cookie(flow_tuple);
+		flow_tuple->dst_cookie = flow_offload_dst_cookie(flow_tuple,
+								 l3_proto);
 		break;
 	default:
 		WARN_ON_ONCE(1);

-- 
2.56.0

