Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559743;
	b=oluDLHCvaoTm+Kan9YjPxmAO4x3ztYwnuDRJUpSPag9U4+f9uv79XI9pPtcO1F3yOQ2U
	 NLCfgu2v6vauyYkeR3JOYdMe781xVin5cbjh6Qog1b7SlwF3TIph2dqG1B3rzT4++DCf+
	 fx+j7O63pnkfVpfB3GZ6IScmfeEn4E9+fz7iaN08B6zoFMWADQ2OlPxWmuYBWhWTCudAN
	 eOo+SO3xvvMb82doAkhcsgK40AAQjQkXGU518fiqT4m8p/fyG9rPXYDEkA2aAkkzMQWT7
	 7QkGCA8tysKs3KqbaiqYjDP2vO2eyA9kG42I+4caGe5t+85GdtGwmL9m1meILy3p11w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559743;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=G0+MB/jUqRMYUuh/ZFNJ9BJObePXpvta6v/irZNtSoo=;
	b=r3WFAnRfzzK39iQdLW+i+KhEDgoREvgXHZ6bi5kM/tn8Fvgs7NMjz3xafC1SfuUNwQK+
	 PdmphBR1wfFG13Fj+1T8XBWGnzPLsvZWE9+jnRdrzaTnrtI5a3UMynhLERSSJgQQoikKW
	 S94vcUG68djdrm8M98bFHdEOz6L3t7kWFtKlay7k3Yq2CV872RVEY7g2tcUu3GRtIrWJX
	 SqKyE6tuFkfl22wR20Y78CHrLTDJ8iVqOei//HY+c0J/tJFXnBIVm2YVnepTwRQlRmo41
	 2gbadQlsOPDJr9FhZ6HwL3sPA+QojEtH4ftYSSPAbrOurwcbjI5X8thU3ejo8RvCA1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="A5/BXzV0";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ejosh6dk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA8606A335
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00FA8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A5/BXzV0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ejosh6dk
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HQa661100271
	for <netdev@vger.kernel.org>; Sun, 1 Nov 2026 19:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G0+MB/jUqRMYUuh/ZFNJ9BJObePXpvta6v/irZNtSoo=; b=A5/BXzV0mGaroje9
	CnHteb7bEaQL2yBH9r8wbmoMgoZYzdJrgh5e6XZaJ12tykRgTol3IcCjFwh71H61
	I8ZPFhRCqerNfgM4i+DASl/tOkCY4dCZO/BvpgeJtLemJLfKMmld+NC2rILvtd4x
	c/uzCB6051ObBKiMbRMwyturhO2J+CTiTpyUhgPpMiKLnOA9Is25Ay5H/aK3Im5x
	/W3MJASTsxw61+mEx68Kp9WLo0iWDjIkVFSzfBCM6w/1V6IYz2QLuvvf6yanztOA
	Fr6DWGEClL0sRQ0tC3lWyJH7mqb3H0Mi53oWthW9lIIzzUQKQzYilWTImHuEByhh
	bLGc7A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfv3s8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 19:02:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1e62510cso530471985a.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793559741; x=1794164541; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0+MB/jUqRMYUuh/ZFNJ9BJObePXpvta6v/irZNtSoo=;
        b=Ejosh6dkzD1KmRgRwcFx9GduiNwBXi5JkWt+dK+1gdQbFGjU2NV6Ep4se9+1jFkqqb
         W2MGd4e/X9zZKyX2QLHaVP98MiQPhTNwO2sDNUUnNht2ohfABK4pzDVVPh9+8n+BLbu2
         JAZj8Yg088R+eGJDHuzfJaQBO91X47OtMaeAYXvmglASzLxiS1U3aCz+sSl6oCjpdNUu
         rIl3lsl2JL+EUTEBoBci1DKIeTkjRXqQpEm/nkuXDXWfGP4jOzy+Q8lWRqFUT+dw33cO
         Oc6NWplhbdww1SktD3GENZqKZHFUwJWI1+PSBnSHfjLE/YB3fXFarXMGMM2NAsh/ev0w
         AaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559741; x=1794164541;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0+MB/jUqRMYUuh/ZFNJ9BJObePXpvta6v/irZNtSoo=;
        b=SBjX0RxpRVn4064s7+y1vqWBNQZLUKq7e46doC1gcK94cWSyLCeUlwsYHQeHog1p+8
         +yExrxfgRmxPn3yo5GXuWLouL0oagBPF1rGTiT3skdd/s2J+H4vMI/rgbbPvAG1aPcr2
         WJeHg+gnmGOtdNXvlHumY6LZNaiimdiTdpsgNRFpljhcXxUe3esKGia1RczGJdO4IfWi
         VYMb5/Bpt8CfCJjuvLU+MoZQj/nPdN63p2UiTodIWvmIUzlKmZMPGTA8+9NQ79Qjx7uw
         eUX8AZUmKz1z7DYc4RPwGi8sQq7EDeoQJKUuKyx73ybVMEcMPzParEf3K5C9HX9URQe6
         8Q8A==
X-Forwarded-Encrypted: i=1; AKwUvBw54AJqKhpMmlRS2N1oXaTla1wifgBTHUR2p2k/WSCnN89d/qnMhZpInUWvpzAkfMR37iPmdGg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLD+/+QfkPRrPX2PrOzSrQUjn9w5fMe0kUIpiJZTjbSJatU9eXo
	Hr9uQUpoqwNT7VNn5HtA65MNbep9h/+lzBKVEEeS2XMZYm1DjSUPrFnUACtfJ/+f3GdKHgBJOz8
	ZR2INwltTqwuonupqrdlcupL8PQfzNjNM3+zeZxg68MqK3sN1oC870+1vsls=
X-Gm-Gg: AYBFou0zUphBkbDfchRany0K/CFhTA9zmtnEvoVQCmEQY9qRpA4+SJ4CDKqsgBxkB0r
	Bg3eLnJ9+/CfXTBrLUqpXcRBxJ8UoeJ3ok8SnQk8ZB/VRiSXNep6OlbQuA9u6YgOybCn0e8gugq
	JhAs0Gbrf3trnj+/fHcVYc9mkVp6SPzBvcbzvLZ662TPBaZkch0yl0LNMi1UBuajRpzUwULqMFW
	Np5JuA0znhDzpNQpctnLE0JTs4kV7A2BAgMxHQ2ag79SNitpa4cZHaj1gDRYPp5DbJQJRR16F+D
	0BlzegdvASuPs04oVQZGpaDKYpx133GZxuqjdb+YtV/KkKfYJOXlMK2WZA4Nixtx80qT4B9DMm5
	cxg7Scj0gdSq0vSN6ZzkHcompS5uNpY1fIYI3NhxFbvr/xhpMP0p5u9PoPAkCbTA=
X-Received: by 2002:a05:620a:468e:b0:942:e4f7:6104 with SMTP id af79cd13be357-944217a23cdmr1327688585a.55.1793559741239;
        Sun, 01 Nov 2026 11:02:21 -0800 (PST)
X-Received: by 2002:a05:620a:468e:b0:942:e4f7:6104 with SMTP id af79cd13be357-944217a23cdmr1327683585a.55.1793559740689;
        Sun, 01 Nov 2026 11:02:20 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab61d8b9f4sm259126635e9.12.2026.11.01.11.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:02:19 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 20:01:56 +0100
Subject: [PATCH nf-next v2 2/8] net: netfilter: nf_flow_table: refactor MTU
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
Message-Id: <20261101-flowtable-sw-accel-ip6ip-sit-v2-2-c6c282cab5cb@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfXwMsyov74laHD
 KEg7D2ybYGYg9T3HPGtZBSorizp6wVc1mSO/GKRudoNr+B6OiKJ8sYTOk6kL7X6OgZRFDyUdNP6
 u8shDrU8Ii1fwVko+Bp9k14nheDdnPQ=
X-Proofpoint-GUID: 21s-uSBWP4nfgAayquOckmPPe84mZGgy
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae78cbd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=9AI-LCzJV_BIknmlFlkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 21s-uSBWP4nfgAayquOckmPPe84mZGgy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX+XGkhUMlLqn1
 Yq31tW01NOgCFmgHD4BG/oghSzZJTuNcRWvzGoM75voHr73u/XfYgtNw7fAKpY/G1eZxr45H25O
 mHF55J1b9nPSZGofWlbu/LO++caVDzP2DFx0LHXb2JPav8H46sArY+jOj+rpFYSZHT0oCzUZWrH
 la0EZ7S4ye2l9uMgVFjMO/cNjtUaWH+7AJQvUerv4eGmMHvvNeSBXdA0fKTMqAU9XgX13YKJ4Sx
 R8mx3ymvtz1ER3KhDiNXx/ZL/1CcwHUQKWuIzwjrMoNsTFvCX7MGt3FfB4yONliGUPzdi1Wz4mm
 Lec1WPvn7Qh2fire3B6UwuwhdnYVqhZnpaFbs5m32OrlyWY6eUs5GJTm2s/x4rs23cgWfHmRXhF
 8HqoSG00pZAPeUn0RtsPG/tg3JLGAcnYAmzHOjcwllkszYWNk/bNxAVE7O4G28fpsMleZvar6Uo
 v9qN29gAqcrW4EvyhIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010075

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

