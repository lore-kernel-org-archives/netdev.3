Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280942;
	b=e6awUCvZf1V00V7/pLQsEJOt7CS/ObhPdGrLiGINadgw/yeivYgIYWe00uQoTMJ0hPcF
	 yE2zFfRaaomYhOaY/bWWacLg7yJzhjFYoMeyjnbXMILoZfaWCBew+kgjpxYBVX68OzstR
	 lVpL2ULeZ3YzpqZ9qGarBB9pVAIDg6kN7hLnXbBzF7B5WEjhihOJREB9UkYhLvBpNJKi5
	 gF4EA7dU8gpBE+khlohAPZ/7j9Fjd2ckcXwolNwYNh8xIXGYfdfE+mRhRYu1UiVXhUtQR
	 P6caz/IIgEolsAB6MeQGzcy6HB2EwSdMCel1q2X1YtN5W9X5/hpXqbdrZy+NSmxAiwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280942;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G0+MB/jUqRMYUuh/ZFNJ9BJObePXpvta6v/irZNtSoo=;
	b=wHxfUqrC+YD9qzGNchhgyfe81CgeE0SzDk0bsA61ZsWZe4WX1Nf3LPj+JoXNS7V2Qt6D
	 luQ8hG+6W1UwrN9Dk1DwM0sfFVN4++dXfhecQztOmxIZKlDiHvrm2/ozzeLDfy8u+mMFr
	 sErHtCn58Yr0u6xSHahavK0p0/d3VawiW0dlhz2GNx5huzVgXCzEmyJpqaPPs5evaqjqd
	 9a9QbgBH7kUUVG9/HIcERfd91ugwj34Bcc0JRQdQvsqLeAMVASjhsIo6OiOfZIsRgFkYH
	 e6oAZeb0zncaJSVwZejzki5t1nE2S4YXi9mROa/GA0mNfN+5xd7GSnxsPG8D42YkngA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="N8CxV/LC";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ku1umrGj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A6606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A59A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N8CxV/LC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ku1umrGj
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCeCVZ061392
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G0+MB/jUqRMYUuh/ZFNJ9BJObePXpvta6v/irZNtSoo=; b=N8CxV/LC7UmMRXYk
	OUejEdvshGFScV/qh/FLsW+MQFM6y10ZuDNUjSDopbIVRCNbAfFWM0i+gEmWUejX
	2g8zcVIojxVsDt0Hwmx3Bvg1T3dgWzq+30/R3kz6Xgv1Rr3+oUuiHYmmXzz0tXt3
	6pKvBcIKSeKyFgq7gKKLGjOl4IxWo128zC75n7D4phYBv66OTRO3rIuhwbDwceyH
	TsKd4H0BS794VSuH0VPzx/ajgpLQkRpD/vZH/JseY9SBv34Q5dvz6w6BbGUHprmZ
	DvnYQlkyFgF+Io3DJIM4bwSRMFpFcfeMKUiSczmlmKtcXVkha4qBf0tr6zARz547
	DHR1PQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpusdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:35:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so379573085a.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793280940; x=1793885740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0+MB/jUqRMYUuh/ZFNJ9BJObePXpvta6v/irZNtSoo=;
        b=ku1umrGj9fT11qf4/4KMYlMxOuG5MmddyEt0ZpE6WAXc6PSRvCDoOE7wDNg8oE3YGh
         Ts8sgaCQESAESVCPF2d0L2apJGhBzGqJyt0IGjgh/nozMNHwzgjGeS3t3iFVM354uTfN
         tzDCzodJFOaZBaZMijyCmC3qNkil76od8dC5FMCoDaXNxF93q4e6CpbncSWLaAlGCNma
         jjUBb8FLxHiMeZuvopcMxsZ/eSXLAKeVk8QS/fxHYAUAgxYcK6aoobyXnELXl9Gpgkn7
         NfQ2Ix1pqlsNNSAhMay0znaJ0ExJ3SUrYyDZ+ut1c7QF5GjjPSeVpNmvTQ/uXL9Zs4Xo
         woow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793280940; x=1793885740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0+MB/jUqRMYUuh/ZFNJ9BJObePXpvta6v/irZNtSoo=;
        b=a2oOYOEQDHmMmRFhepENAUTJ60hSrl5mLynKj7Yu9nZ5DLgnsFKEqWvkawc83sNJ5c
         72xGabxMgNlROoIfzVXQUZd+eUT8HpNzAyc6SUARDyM+pJAAd0jPxtxx/2dyEF4PV2rW
         8RMEEhLQAG4q/3fXqD+h6cmFvfcLoNmHDO6XVjxYNooB3mOoUIyC/ChSjzIfH5h208o+
         JxafYmolW3lz+SZMPzK50oNbSCL9lzoM5GPJZLNd2StEB7vwqP2Ek/Dq49H+aR4eZVJw
         WBFR6ATtQ9SDVewDwW05bFopTc7OZxbWTxVbrnHyLPmSMtZNYiOaeuiKHpnRYtb3/nfj
         dDCQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4fDlNsM0OdUWErPjImY286s+u3FIHPJ+7YS5rw0HW1L9Go5aVg3UqB82XkbBdVnnNex1qmFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSq4QW2b0aqAp4TEtDufJkXbLT4t7/lsjWt2aLw3ox6M07r1H6
	8dk6EKrJgwuodvDS3fsmFLgTU61qxsbHKTZiVGgurv6Y0Q1poKNCPgJduQxmldqPCkWFJlZAeST
	87p2VCn5OHwGho1yvvFka6lm3cNmYLLmLjG3mNdsfpLnhOBb+ABhjPFGIgWg=
X-Gm-Gg: AYBFou2/NLT0CMBdAPwMnfF5avFSI/LTs4u8dMjblWktbz4SJWswzem+CrMzk5A+uTT
	xlHPGoHMGEPdZB48krlz9k0tcVCwvWTI9BwmI9eusZUC3Vd10Xx44awM84gKA2Fo19X1sAp3KrY
	E51OkQVDW0+mHy1ai50ekfQ398JZsgwwU85JH6R19YSh8sPTUUL1cd9GAiPBwQgcLoUArg/9bjb
	Bn0WaNi+XxY0zPVyXFGrtB+F0GCs4oPOIhraUqodM+JTL2qmwiGQyBaNWHlPNJpA/CNYdFbrRDJ
	8o1hnl+1l2wHuEZfn4hQ60L3O0mEsOYaek1XH0n7Iy9XtAlHMeclM4ixna6L9xGGrUr6G8OnYab
	Lk6OBFw3nDJdhmJ7y8nchO+9x+H59dKSzWlImqwmMlbgRb0Sp3CqIwz4fNNNav0YIWqIkJoK+nn
	eGIq9Y6OQNNkijiD6UAWYViA==
X-Received: by 2002:a05:620a:1729:b0:93c:2726:77ec with SMTP id af79cd13be357-94408930698mr808310585a.5.1793280939701;
        Thu, 29 Oct 2026 06:35:39 -0700 (PDT)
X-Received: by 2002:a05:620a:1729:b0:93c:2726:77ec with SMTP id af79cd13be357-94408930698mr808304385a.5.1793280939062;
        Thu, 29 Oct 2026 06:35:39 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a969e61f9bsm84350285e9.2.2026.10.29.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:35:36 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:35:13 +0100
Subject: [PATCH nf-next 2/8] net: netfilter: nf_flow_table: refactor MTU
 check for tunnel offload
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
Message-Id: <20261029-flowtable-sw-accel-ip6ip-sit-v1-2-6a17c54f9fb7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX0TAaPO3BaqLj
 VyJvrewn6Qi72rX0tUIQg0GnSOsPk0eVtPfQRv3frqqM4B88nwjS/+hy5U1Pbe6gqSnc+JbPNtZ
 F9nBluG70YOG9D3Xxdbt86sN5nxYtg4t45jcFWZYCJ0exNEPZw1/tnIHck5qHIxV0XS7ZMAXOC9
 /ln0TfQR77HnNnPGvS6PyqpV6iqaTcW9D5Uo6RvgG8ab8TBoUCmOgTq+6O6Xm8lVbKSvVCUHwhf
 mOCNZsIO6MYhiaVMBcBvjnOgxL3ID3TFrNXB79yfgs4AB8gkNMx8N8IL119sYQf4vPrdjNEnlMb
 YmERHIAeHjnY+uCoSHXUJzwQDVGXHZEG6b01qRLIM/DB95u8Gt/rM+Ly9oHTqRzys3z06bVfLjR
 QfPBPYVBtLsfXnMgsgx5294OA+osv1rHmrwLjM8vTH6WBaZdVeLtT04xvbiK2Nr8cS+eP/sazhG
 xgWFVTuN02MAzfFR58g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA1MyBTYWx0ZWRfX+6hdTp+VaWES
 9BUZUa0CM5Vg5X7EqAaXyQOBtmSBlZzYG7eQ2hnGn673UtgR2vQSDmAdNil5WjgUsD6sS+CqV23
 LTtezkf3SW2M6kYgaZE/+UyQUssrzd4=
X-Proofpoint-ORIG-GUID: ZLFpb_JOByoD8XDzbYOkSvPz-iKufftk
X-Proofpoint-GUID: ZLFpb_JOByoD8XDzbYOkSvPz-iKufftk
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae34bac cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9AI-LCzJV_BIknmlFlkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290053

Introduce nf_flow_offload_check_mtu() helper and use the encapsulated
protocol (tun.encap_proto) to compute the tunnel overhead instead of
relying on tun_num, so the correct inner header size (IPv4 vs IPv6) is
accounted for. Use it in both the IPv4 and IPv6 forward paths.
This is a preliminary patch to support IPv4 over IPv6 and SIT flowtable
tunnel offload.
Please note IPv4 over IPv6 and SIT tunnel flowtable offloading is not
enabled yet.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_ip.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index e07fa9327eb7..902b9b595677 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -472,6 +472,31 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 	return flow_offload_lookup(flow_table, &tuple);
 }
 
+static int nf_flow_offload_check_mtu(struct nf_flowtable_ctx *ctx,
+				     struct flow_offload *flow,
+				     enum flow_offload_tuple_dir dir,
+				     struct sk_buff *skb)
+{
+	unsigned int mtu;
+
+	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
+	switch (flow->tuplehash[!dir].tuple.tun.encap_proto) {
+	case AF_INET:
+		mtu -= sizeof(struct iphdr);
+		break;
+	case AF_INET6:
+		mtu -= sizeof(struct ipv6hdr);
+		break;
+	default:
+		break;
+	}
+
+	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 				   struct nf_flowtable *flow_table,
 				   struct flow_offload_tuple_rhash *tuplehash,
@@ -479,17 +504,13 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 {
 	enum flow_offload_tuple_dir dir;
 	struct flow_offload *flow;
-	unsigned int thoff, mtu;
+	unsigned int thoff;
 	struct iphdr *iph;
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
-	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
-	if (flow->tuplehash[!dir].tuple.tun_num)
-		mtu -= sizeof(*iph);
-
-	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
+	if (nf_flow_offload_check_mtu(ctx, flow, dir, skb))
 		return 0;
 
 	iph = (struct iphdr *)(skb_network_header(skb) + ctx->offset);
@@ -1108,17 +1129,13 @@ static int nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
 {
 	enum flow_offload_tuple_dir dir;
 	struct flow_offload *flow;
-	unsigned int thoff, mtu;
 	struct ipv6hdr *ip6h;
+	unsigned int thoff;
 
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
-	mtu = flow->tuplehash[dir].tuple.mtu + ctx->offset;
-	if (flow->tuplehash[!dir].tuple.tun_num)
-		mtu -= sizeof(*ip6h);
-
-	if (unlikely(nf_flow_exceeds_mtu(skb, mtu)))
+	if (nf_flow_offload_check_mtu(ctx, flow, dir, skb))
 		return 0;
 
 	ip6h = (struct ipv6hdr *)(skb_network_header(skb) + ctx->offset);

-- 
2.56.0

