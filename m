Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714530;
	b=Zpldr2Oju+UmkpMI48+f9g50wm2r4l5WfHWhvBX7s8aLXRhpnqvdWigK7Asy097cP3Ak
	 i4KSn7nPSV6OgpuBamuhOvmvZs0PaWc5cQwnko7tShmacf4vZti46OXDuQJKzkHFBLz6w
	 bq0nMGJOWvE+qrDKvePoCsIg4mWCK5THzWHxnDzSKz42mYh7duzN8qC6x3ZkKgM016RSA
	 moADU/qWcN+2VSvEa/EM+PyGaYiBPX11woDUE8Ohg1X+MPauVkIFM2nmq/DWLbSZV4d8x
	 yVpvoCKyfa865iDnMkB5YRsNeuz5/rUpKmVHQ1cX/S5Qy5+y8XNgW8lRPpNqZ8Ht+sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714530;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ET+B6ryXZSjsDmJogt9NhGamDLd5Mr29EJGHgALtRKA=;
	b=oad7m96wMOqZjEHbUTpAqzq+zYnYtUdXJnO4/UdoyCKFm0KWa8Vil7My4q+5GPS+n+H5
	 IdNbXciQLIU4p1NxXLNHMB4I8paZ/r4b/bxDTJAvfz48QBrE3USSSq9OsN/PZHQ0QBz/S
	 N5KxGBBRlX4hjOIdWdmOXabZv+rpoZkTasJeHI/XYxcfX9cSbff4c1G5R3TTExPkqwzYW
	 ws79l5/1kxty08iZ7MKktbyAlc7BeO1IsnXR1UliuDGue04ToKnANZb9zqW6UkTXiv7WU
	 1/WDV9C5558TYaawOcawYH9ZZ2G3sqpBLPoJzihu9AWvGb7fqo+R9DV0Sv3yNDwsojQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jSaVoowX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CRQP67cS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B88606A338
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0B88606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jSaVoowX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CRQP67cS
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DZJkp3581565
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 14:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ET+B6ryXZSjsDmJogt9NhGamDLd5Mr29EJGHgALtRKA=; b=jSaVoowXxs9DoOm4
	+Nk7j53T/b/1qZSTZnDZiHyopZfm33nSdPEIfR2uiXoT0ajmtzZRsWyXFM8p7MMx
	JBq96hMQjZY3304YncA1fH4Ax2DKmmzkDHZBPOsXfFjIx8A1SFpx+u+v5Yg63JFv
	3VDLXQGsPYMMYQ1qqcoC72hCsM1L019JYU405zv1t2j+qbRmqQVpmCQh1Hxo2YUV
	ynD2af9y4Ds9LWLMLEWdPQc4lBL/MgJmO/gqKGWyqcJLsxobCrtlyuZ00Vkt8uOG
	d/M5+Y9ds4bHFflBVTcII24euNGwfTk4o2X4EIt+bdq+rZWy9e4nhVwnQbsM+5Np
	ylwc0w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq94ct1jb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:02:08 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ec17386b57so3473769e0c.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793714528; x=1794319328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ET+B6ryXZSjsDmJogt9NhGamDLd5Mr29EJGHgALtRKA=;
        b=CRQP67cSDz/JUAcknysBYuaBtVkR0baUaQoTJqREcjSpkZxLk5Qbs7ip7B0o9QF9TG
         JBLv+L64MlXP5WWY64BBXaTWJ3AICovvruSWJIqGqe3ld/qY1WY0RMUQzDLGbiZd336T
         8Al0KLFCK4kxaJ4i/mAqRtzv1aWNZIZGvhWkO1hil+I0Lo8Ib8ubmd30SPmDakisPmGA
         op7fuoHlQU8w+VUGgneWvhPINip0RbdQ+Sw/3wE6b0ph65K6qpSm91+obFwEEzuGFHdK
         3jBby+peDuHyCsf4GI/rBWxp73m59EWGKl9Ltd4HIPwJ3t2FPflmUho7ePdguam0lSyh
         b9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714528; x=1794319328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ET+B6ryXZSjsDmJogt9NhGamDLd5Mr29EJGHgALtRKA=;
        b=S/zQmBj38GaQSeYTV4Zn8DSCtxmuHURWodVg9Qbeq/wEeJDpPSE+7Hmhhs09OkdPwb
         cqUkmF7ep1ZlCCM7Qt22SdrTvZTM+4AoVOcT15t5PU/MjvTJtI/iigDfhZxAg3zK29tY
         iW2w873+h27nEbur9u/c+lEGBk7ULKne0qSkrhPgv7e2kz0xdOx6jeTU9ppjd1t14sRk
         d79F8to1nnNVx9IARA2rj5YF+g4ZZKUrOPFuSORyJu3uCi5jGvHfb7hwUY8hCyCOsvaw
         k2egoi77fxhDaW2UvR/Dghis2UBerGwwn6XtYtqB+qO9IW3xPQ/GULCpnTiOpmPGWEQh
         1ejQ==
X-Forwarded-Encrypted: i=1; AKwUvByxWF/im6e+NdjeqYMxbMGcv0jzaaDjZpQnCc8KXz1+wcCNnb828uig16XvGqMG1VUtmprBuMs=@vger.kernel.org
X-Gm-Message-State: APuU4Z88vu4XYNCNR+UKFf8d+Dhs5yHhKrMsssgUmyiY4K84ozsoxsf0
	PU2tOAXv5aw/8QDlRdUWJaH5P/q6sBnvTGSACQudFr7z0dxtnVDVaM1+Awvh0XCqQ3q5Mpc3trx
	7wyHK12O4z/i10iJ+kq6xaWa4MxVaAq6tmKVyZf2wujgFjq5FIy9U9b2TGVI=
X-Gm-Gg: AYBFou2euFc1Zc5mEfll0vzGPbFsfjNiI2susxmWCS/c5iCOuw4flv+Ey4j0Pd/HijR
	ey6aMGmzK4D68luM8brWsPzWr9OgXStvx5WOe5N0WUKJ3zVks5TewvqKBlMwjn35CxmDzkXwG0W
	p2h5BlY4gHHQLdTCxCayspjhMVNr7E+Pv8XvtsTeCenkT1itozq9ddJ1FwtDlu1ElP0F5XPUNrN
	8lbmVCwPDRpI1BSqLSsXxkPWrAZp8K/YIgbPgIDEZSqLZpJ895ScBMnHa/3kq/tNVZyOHwjX8tk
	8E0oZNAEPsjI2vYhLjaHnBxRGG2EE6Syhfd4/uwIe9Xthgd2ikHjUbidnkYUYb61FKVHUCnWLEq
	KziE/ZknAW5pODvipOzmBnNVqwirxpqjjJj7Q0rkTkRKGSnD5HnOMcpwXvAh4kXI=
X-Received: by 2002:a05:6122:4892:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ec6851cd6cmr5729578e0c.2.1793714520085;
        Tue, 03 Nov 2026 06:02:00 -0800 (PST)
X-Received: by 2002:a05:6122:4892:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ec6851cd6cmr5724949e0c.2.1793714478743;
        Tue, 03 Nov 2026 06:01:18 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b81c74sm25057443f8f.36.2026.11.03.06.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:17 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 15:00:45 +0100
Subject: [PATCH nf-next v3 4/8] net: netfilter: nf_flow_table: use tunnel
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
Message-Id: <20261103-flowtable-sw-accel-ip6ip-sit-v3-4-60b5f063f1df@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=O+KsLx9W c=1 sm=1 tr=0 ts=6ae9e960 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=BwFUO5JFP4DfzLIXruUA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: rLYUEVYYldVSO5J7rUn4THDZtFyjNKiG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX5vbvmRcC/mDQ
 dwd113tXyycznCbt2q1/yJcv5ejR2kjx0ZwH1WsQNQxmMoxpLk9oXmKFo3PIYr+JZzVdmd+HtzN
 x2hthpdZW7dgrijCoJFMPBxRHsDh6ytoBt9tLh2Ka4zqRTJrFdS/UxQtQApmg2Vp9f1FKEfizuN
 RFyPZEHhU06MmfUqYerjbL417ecMPqggRz7XHEI+v4pZX0H8d4vDEXeTGuTEnSnj4mAZqDCzEcW
 7znzcCbJ9hGOJKzajYRpWb45PZiu9mHBE+nE7SB1mQ+7qsD9+j3r3JGeGQIchk/kvlvvKd5wGJe
 ljhiMmf5DcQNbsdT/NPX9PHiI36ihOatlm3eCOdGPgEFUTjEu7kd4lJc3bRquGTPiO34ap8Fm+u
 cKAjkUNJEb+iYHy5Kqy8ZiC2P71ql+FHvkJot8ulxV9RE54XsnKYbwDdddGeU7jLJb8rHjN+i1Q
 L8d4QStNDY4dsuOw3Kw==
X-Proofpoint-GUID: rLYUEVYYldVSO5J7rUn4THDZtFyjNKiG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX02baMv/G36S9
 v6LO+z5t3Z/3mUoqL28GTs8MVXqbkoFmw9ewoISRqNHDP2N7JGnkFqdY7SzX3NkXxdysVItejQv
 Aoka9BKdoCDnqExciBn86hG5R+MTe+Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030055

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

