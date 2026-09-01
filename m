Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBF480DC7
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280363; cv=none; b=kcBa73Nd0QQ3N/yxBjY0pXJT5/Azo5l9LrV8qMNqaoOv8tuYxync3ATT6wWkUeqcrcKIf8wW+/FMXeJHm5THiEFn5FAayf04w8BZ2Lb/vHinEpXYpgInGNjVddNsfLiJSeKhlJB1etThWwxgUMpXYPnChzC0q3DwSscLB9n3N7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280363; c=relaxed/simple;
	bh=LCzTV3Oa4mwsANRey5FLed9yYrH47qFSuDRHn6terT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drR8v1HPkYapARzw+PviVhFbrKG7+pahh0C9GZO6CEYY/tuwAFiDOvhlRKkgN7yRp0WhMr5sfSgGuOpzsUu4/iYcTqyYHFQMFL28CZsBHFDu8N/x+PuPdTtVU2TbzYTKT+DNbVTqBN9KczCn/8ESL4HtvtEzf5ZALw5ehTl0h1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LCsURK0T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UcCIEEfy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LCsURK0T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UcCIEEfy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EAvuU3006393
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 16:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eoTJQI9JSbpKnALhVsO18yqtXzVjccIDUrsWHYzhvrw=; b=LCsURK0TE97ja1O8
	IHkyue9slztsvAhef06LDHbgpyyWpHD/3z+pY4kkzJuk4pfeqYBfxf4JADaek7dc
	jpSanKFgaK6R0BTqjThfa8c5LvfiY4wPO/9W1pV8wxDL5/qaOaiZ/kpCYJgwKRUx
	ALgvFbESV9aJWErTwytM/SS+0WKS+zZlHuoPTuHzTH93z+/yVbAsxJ4XfEtVb2NV
	sb3FnypbPgUHpX3LuPMvfByZJpM6/fWLtQeW/CyoSxNf15I/zd4Qpz6GQmpseUk4
	yX5wEJoUnyreCbXS4rYcfLG32BiZdKBYBlBWd8aBG6UfJlJQepBY5ChjtWIWWCJd
	8XCujw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdqbh3aqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 16:32:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93903622880so237543485a.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788280360; x=1788885160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoTJQI9JSbpKnALhVsO18yqtXzVjccIDUrsWHYzhvrw=;
        b=UcCIEEfykpb5aYf+Ah7Wxjl1OExBgwQLEv0B7utmg3Ipxy5buXC4ssdCPAKDaFPnpy
         rRPABd73bVM2B4kQrk7gVBbXm9/ObRpAYodgnDnwFpCZ9P13y4b36f+rkb5qdjbyMjFe
         hlWq8410g8MFcueLWMWVspUz7Cm4Xv8o/gz6c6JMOM5svj1ZAB5MVJYsAGiXqKQ1oRQS
         z9yKPdqwxOfInpfThZuPZAK6fCvPYyQI4pIW389kupo1avSV2xdhW0rcx2Jcao7FreY+
         wZh8M1cLgRakVW3O67aE5aGIMlH+e5RIY2cSvGFypgECepeCqhf8eU84nCj/VbzUkk7b
         JG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280360; x=1788885160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoTJQI9JSbpKnALhVsO18yqtXzVjccIDUrsWHYzhvrw=;
        b=kNn/4HfMNCByvLLlm88G9pRbQR/2/H2CKty3G4VIJt6nKy8aNvY0Soq7IfXoLarYMd
         et8inRkGxgUTDKWgGC3LtwZFj/qZKq7sf2eT6cOJainPhGSsBhqSqs4vq6+QJQdsWW78
         tLVfrbFERAlYujN3v8iDzsIHezbptq9x2isrfkp9peRBxClpmjCQjg3pdU1jqTTVbeKF
         +bHX+ivu98Ri/tdhnjtoworVTDnNbaYNrEQ0D4FWlPA0hZpraDVsQS3DQI4SvHSJ2ubv
         t8MSOgMosJLCBz2hW6ttPxXawZMttzjxQab+LRO6OBRfAzm7qZsY3E6FEb6jmnnv/RZm
         s1Ww==
X-Forwarded-Encrypted: i=1; AHgh+RpOckAa6jaIF4P4u/0w5EvXunOjVb9twaoKk8oKtwLPhRGOsL7G7IH9F+xyzdpQDpyQ8iElEJ8=@vger.kernel.org
X-Gm-Message-State: AFuF++lpvfbXifSOHMJVvUfJlqO25vPtRla7fs8R5Gz3kb1onMTi3993
	AjK+2d89ZkuSTphuFPTS31G3n/qhivoAyW9QASdRmH8xOb/vYguz33BcNOgsrxmvbptJi3nQkrY
	7LGMpeDGUIvgnsXzS9hGKhLlRaMgGHvr5Yw9fEx/kyJozrRso6JByMBOP3Xk=
X-Gm-Gg: AR+sD12hDHCxSzSd2l7vYnCzGlpeg2VxnOvbNwGNkfbUghKZzG4NMmUoFUAq+1B++pi
	hR7UwwovT6S+4flN7DgJqK9F8YXjqk5B5D0sm5entrd4m8eqsTZnmPXGb8d30rj2LQVeTy7QTv0
	7Y3DU35zIwXpGWvTjbS8RwqMkdMvoWCMmSwHkWfTMbnno7WttGzqzaBIniT6fvxSQWXo8yuda5d
	ZtMiduvx3C9lfDjevGJWlYCLoNQoaALgx5DlaEJmgj+aJ3h01Z6JOoVpINghqlLuetDMk4nKm82
	E9b+P3vu2T6rueNJfibbCnDLNuQb3mBUqiC/MfPLQu1loxMc9ECK1LqCv26t2Oy5gniArkyJjXG
	T7BGcE1tFnKgGYQ==
X-Received: by 2002:a05:620a:28c8:b0:930:9cbc:7121 with SMTP id af79cd13be357-9394bbd27dbmr828064885a.3.1788280359943;
        Tue, 01 Sep 2026 09:32:39 -0700 (PDT)
X-Received: by 2002:a05:620a:28c8:b0:930:9cbc:7121 with SMTP id af79cd13be357-9394bbd27dbmr828051385a.3.1788280359177;
        Tue, 01 Sep 2026 09:32:39 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeae34sm117397f8f.32.2026.09.01.09.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:32:38 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 01 Sep 2026 18:32:16 +0200
Subject: [PATCH nf-next 1/6] net: netfilter: nf_flow_table: recognize
 IPv4/IPv6 in tunnel proto matching
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-1-72e49be8c31f@oss.qualcomm.com>
References: <20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-0-72e49be8c31f@oss.qualcomm.com>
In-Reply-To: <20260901-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v1-0-72e49be8c31f@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0NiBTYWx0ZWRfXyn1poegTc+Dt
 39l1GkHctxATqGhEuBveMeFTggELJV2zhERwSWYXbkEqMgFxE2UJPqtStlV+2fcaREwVky0u9vS
 4IzuiIdeAvvAaRdAsrU8zOtCcUwGSSQ=
X-Authority-Analysis: v=2.4 cv=R9wz39RX c=1 sm=1 tr=0 ts=6a96fe28 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-vexEuCU66S_koW1hhoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: xzr5WdRHlfL3UVfE_kAezxwk8mQ6qtTY
X-Proofpoint-ORIG-GUID: xzr5WdRHlfL3UVfE_kAezxwk8mQ6qtTY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0NiBTYWx0ZWRfX13A1h8VJJ4Y0
 BC/hGPTtAI4SnWkTwtA2xjYZdLWOWeTi2/4n3wckQU4rquPUFlp7OTC8OTlguMnV/nuuC421Imu
 xwR13H0biwIf2QTxdLC2cJJ6iKCodf4PZCwwhtC+hvhlnbKmNO5QUy16qFGEm3vHLVCg951brHL
 QT7C8v4DKbIBCyCEERqlZ3/op5V4j+F32o7Upfcuc9Td5msFG0B9Vb0pN97cIT6l9DEuCjmDDtW
 iVBQFDVBZpOUywZPCdPWncvtKpWNkeoR5QY/4anYKe6VxsQeTaq5S4FmHQu6Y0xWsQCyprGxF8e
 e0I4j6gKdJQcN/sVMoV2vvwyTo+rxDn/uk6sid/bL+EGhS5ojO0armlgzoMf23OusPmobiY+qC2
 KrZmdjJPdyipdRdbgUS4flZB3QRcGcMVTv0ob3FkJYRqjDZnsA7xm3avP0aWEqy7Cbvt/yIhYXW
 JC04xJ/nSMnSeK0Ourw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010146

Allow the flowtable to parse IPv4-in-IPv6 and IPv6-in-IPv4 tunnels by
accepting both IPPROTO_IPIP and IPPROTO_IPV6 as the inner protocol when
walking the outer header in nf_flow_ip4_tunnel_proto() and
nf_flow_ip6_tunnel_proto(). This is a preliminary patch to support IPv4
over IPv6 and SIT tunnel flowtable offload.

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

