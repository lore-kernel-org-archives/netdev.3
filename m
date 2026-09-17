Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E1742BE95
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633812; cv=none; b=KdBIDJUu+a3oDrJr2fP3vEuXWGqJmbZSTIKdLZVbHJnjbEZpIFL4l3auhFV1yM5sU2+ElUqGiaKcSTSztCaGpLaSRBkjZdmYqadtftW7zDr/sHf6ITk0WhifH4qO5gH3duV/HCJGSsZ7kUjFzU4ocgRMOtTAZjqKXWDVfohucX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633812; c=relaxed/simple;
	bh=lAo34mtydxQy1omPzaU3D4/2R8CaSpwmx9H9o/z5OAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WMTNJXzGxLXfGn/Ap2xywUp/HlGTDtBiRb/2+7yBprkiae4gPNAE24X2jFoZ1RLQ1CSS0cAw3sz6dQyCA4grBVOFrtsukV4BVlQ3mKXl+0BmwJOQuIKhp8+vG+EXsAAlvfr5rBIY+pEH+fC1wf0lai/kseNP13LF11pH3NNoBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WziXlqC7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=borKO+VW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WziXlqC7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="borKO+VW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H7x2wn396216
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YCstRj+9c0olrYCwbrYtmyg7kh95Ei7puue7GO2pQEY=; b=WziXlqC7AMRor96s
	73MdKAYsvHZGHHz48gHfeL7mKnHkvrXC7lEMBJk3OlwbNJQ5p/oP+BSXx8tdq8YB
	Z0SJFEGQps3B4c94+MVe1MeDS6OZ0aY/R/8sdcA3foFwQNMzAKffPPzgLsuYvbMJ
	sTc2Dfy7IPRxm55qAydxFq4B7dkgpX3GwIh4sfQCj0xvrN7uuCGy3maeTkKeH2/a
	eADG59tdBzd4k3L8QvdoLuMv4Mn1y0bcmPdcUw2Z24kgTH29iNIUcSiLOSUyegD4
	ZCp68xeFx3hUumYUYgNhkX3Ua9wZLwllSTfhdao/qrrEns6yGrcj8N2RIAsGlnQW
	pz06zw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grca0r3vd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:29:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0050a554so135546585a.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789633785; x=1790238585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YCstRj+9c0olrYCwbrYtmyg7kh95Ei7puue7GO2pQEY=;
        b=borKO+VW2uHOnQMpdu2utlz5bzVJu4wzf0eNWaEbv83HDKgoEE4bMExXW5fZtYZC4l
         pezvTBLNm6owwy0/BeDa3+EiyVT9aKZF6QLZI31EBxSDz8SGlF+cL8bLJsj+8L1wvlk4
         CdhoHZeSgyvBZ8LU1EQc8nzTgmZxE9cRZwAlTjD8IMBF+WHakfo3m0tD8u3faNNaLd6c
         /8izePKnOmC4V0Botwe3NeeED58X4sYBmz4mNLeVSQfY18NuDDbD+Phrqf09umhhxuhy
         q2xLkeymFNETRJVikagL8jAmh4U8N0dw56gHGlNxulS/4B8/8WpOcXmFmiUcAFNuoSBR
         d23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633785; x=1790238585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YCstRj+9c0olrYCwbrYtmyg7kh95Ei7puue7GO2pQEY=;
        b=Kt+6yWFIY0VRkqorm1OMr+858AgohFIg5+IrdR3t/Cw69lCXvdgFRhLB8KLPJUTd/D
         b7Q+5GYo1CDEQT/2i4xRCAFF7dWNfI2/7Qu09zY7OD7XFHlRc0wZCxWJbQXAbTOtvGAL
         Ls2OIAdqMxs9IzQYK7ryl9op2axRdXEopu4I9zZYn2XK+4GfotMPJr17Yl6r1syYlzdu
         UPuKic4ok/U8U3t4SunoDPRFa5iPs5xStZgrL+vcW0e+uUnaWfYG/8Bcg5p3aDkSBrq+
         wOCzACwqN8MuoTohB1HbFrx7KaPSxCLT3K3g8D3FjxvpeXKHmZl0C5ypHhNZFQ2Guu7H
         fRMg==
X-Forwarded-Encrypted: i=1; AKwUvBz5Tgsym8VyjAyRzTFjNn3m7gzVyQ3jsT3TVaKo31GjyflFvIjrF2ep0JlJGz4CwOJX8ltU2Ko=@vger.kernel.org
X-Gm-Message-State: AFuF++kDpmfIBEIgGiPvjEo82EGREM6Po8tLbqEPKb/mgP//dIsnnaaq
	2cTAkNxXTZmdYGBozwoZqAsXnrBwRGdh6gwmZHLwqM+xIWqzRDUTLz+5mQhMz1IdgsSBTF/8Usw
	jffqJBSjKGe60AXQMXoLNwvXdXvKhXbCg37Dy0nkZl/503s4VEgIizV7KqWU=
X-Gm-Gg: AYBFou1bda8PHn16JsfUQrz51KqiMa60tkkWFUPsSGPwI8cUAhztIYSQwg+boJuUnyb
	Ldd/R+7qremcdUtwUiGytHuGuySNJoRcJkwg9upyxdu+nJvkZ+OaDJK/Lw2XkK5QGCACLBtmibX
	7lIh0I21z2MH7N5O9QD05yweYe4J++enuPbMKveSsQYStQEKfY7ZPKuF1MMiPp4U2Ir+8HvHl02
	sy4j/oko1Ij3mHVJHn8isr+19ogEzI8g0ldFBQzR8jWafFau/m10vjcH3sEWbHuElUYv9pU7kln
	F32+jlUKvFq5a/ZqL1kb8kWAful8GHq7u0/sRJ8HbZ3LevqkVTexgrN1b0wfnVEtOxHtfxVtLxr
	s/ZtyXig6VUeiPg==
X-Received: by 2002:a05:620a:2990:b0:939:ff11:532c with SMTP id af79cd13be357-93bb7986362mr1007820185a.49.1789633785351;
        Thu, 17 Sep 2026 01:29:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2990:b0:939:ff11:532c with SMTP id af79cd13be357-93bb7986362mr1007815385a.49.1789633784709;
        Thu, 17 Sep 2026 01:29:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm13654357f8f.13.2026.09.17.01.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:29:43 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 10:29:12 +0200
Subject: [PATCH nf-next v3 6/6] net: netfilter: nf_flow_table: unify tunnel
 push for IPv4 and IPv6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v3-6-fd2ea96fac7d@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: I89vuZnbBL6yQRmfn30VM8eVSBcqyV3A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfXzLF2W8RYo83g
 S+g72kERgRyKRRST0j9CGJyPq+5GekgzhDdnjKqINMgMacp3IlKCzn8FGFKm/UZMs1/Xf0xq9T8
 BfXQoeHDOZBeP3ySIsfY91TZ70MbV5E=
X-Proofpoint-GUID: I89vuZnbBL6yQRmfn30VM8eVSBcqyV3A
X-Authority-Analysis: v=2.4 cv=dOQzC+Zb c=1 sm=1 tr=0 ts=6aaba4f9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=cMyh4mXVLOFZSk9BkfcA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX+xWyWnzyYo9p
 dYabZYQUdjK1I2G4HzwaPCbBB3qTcWrd7lUKHd0FxExvhoYbN8AG1A8Q6sBJZmcUzI5xWYuDLdT
 bDIVgUK4LeGwdOODi9EuFwfw3kyPzeVK6OmDJ8QtC/z3mfcfJqo8ZtC+tpeua/iLl6Ue8/KFp1V
 VCTRRzj28CTyyjUEi9XdfO4me/tB8z2EYm7/S9sxMmBXiWvYOrLQjFX/xIQHI60iQsVtA25gqN5
 HO2PbA3y9qxfojVLn8Dibz986CbudikkT6TSiQ0vUjL0dTp8VDEvih9+K1BjmlLVhIMohJW/DAc
 PgyafL8xHqLeRE5QZ3uT3TSyjs0UucxZZHM7bdIDW/C1rKj1GPO0q+l9Ur2SwWS6y7nE7JF3TyQ
 2WI+hWLyvOjA2PYknYuigf491+93X0GX/VVlfLCy8/TeH5YerEob3y4IAjpR3d8L+btaV7c7obz
 7z+EIm8UcY33NhIbCSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170115

Refactor nf_flow_tunnel_ipip_push() and nf_flow_tunnel_ip6ip6_push()
into nf_flow_tunnel_ip_push() and nf_flow_tunnel_ip6_push(), keying the
inner header handling off tuple->tun.inner_proto so both IP-in-IP and
IPv6-in-IPv6 inner protocols are supported regardless of the outer
address family. Replace nf_flow_tunnel_v4_push() and
nf_flow_tunnel_v6_push() with a single nf_flow_tunnel_push() that
dispatches on tuple->tun.encap_proto, and set skb->protocol explicitly
after pushing the outer header.
This is a preliminary patch to support IPv4 over IPv6 and SIT tunnel
flowtable offload.
Please note IPv4 over IPv6 and SIT tunnel flowtable offloading is not
enabled yet.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/netfilter/nf_flow_table_ip.c | 143 ++++++++++++++++++++++++---------------
 1 file changed, 87 insertions(+), 56 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 96dbdadba4e7..7a62a70593ed 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -608,23 +608,44 @@ static int nf_flow_pppoe_push(struct sk_buff *skb, u16 id,
 	return 0;
 }
 
-static int nf_flow_tunnel_ipip_push(struct net *net, struct sk_buff *skb,
-				    struct flow_offload_tuple *tuple,
-				    struct dst_entry *dst, __be32 *ip_daddr)
+static int nf_flow_tunnel_ip_push(struct net *net, struct sk_buff *skb,
+				  struct flow_offload_tuple *tuple,
+				  struct dst_entry *dst,
+				  union nf_inet_addr **ip_addr)
 {
-	struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
-	struct rtable *rt = dst_rtable(dst);
-	u8 tos = iph->tos, ttl = iph->ttl;
-	__be16 frag_off = iph->frag_off;
-	u32 headroom = sizeof(*iph);
+	__be16 frag_off = 0;
+	struct iphdr *iph;
+	u8 tos = 0, ttl;
+	u32 headroom;
 	int err;
 
+	switch (tuple->tun.inner_proto) {
+	case IPPROTO_IPV6: {
+		struct ipv6hdr *ip6h;
+
+		ip6h = (struct ipv6hdr *)skb_network_header(skb);
+		tos = ipv6_get_dsfield(ip6h);
+		ttl = ip6h->hop_limit;
+		frag_off = htons(IP_DF);
+		break;
+	}
+	case IPPROTO_IPIP:
+		iph = (struct iphdr *)skb_network_header(skb);
+		frag_off = iph->frag_off;
+		tos = iph->tos;
+		ttl = iph->ttl;
+		break;
+	default:
+		return 0;
+	}
+
 	err = iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4);
 	if (err)
 		return err;
 
-	skb_set_inner_ipproto(skb, IPPROTO_IPIP);
-	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
+	skb_set_inner_ipproto(skb, tuple->tun.inner_proto);
+	headroom = sizeof(*iph) + LL_RESERVED_SPACE(dst->dev) +
+		   dst->header_len;
 	err = skb_cow_head(skb, headroom);
 	if (err)
 		return err;
@@ -635,11 +656,12 @@ static int nf_flow_tunnel_ipip_push(struct net *net, struct sk_buff *skb,
 	/* Push down and install the IP header. */
 	skb_push(skb, sizeof(*iph));
 	skb_reset_network_header(skb);
+	skb->protocol = htons(ETH_P_IP);
 
 	iph = ip_hdr(skb);
 	iph->version	= 4;
 	iph->ihl	= sizeof(*iph) >> 2;
-	iph->frag_off	= ip_mtu_locked(&rt->dst) ? 0 : frag_off;
+	iph->frag_off	= ip_mtu_locked(dst) ? 0 : frag_off;
 	iph->protocol	= tuple->tun.inner_proto;
 	iph->tos	= tos;
 	iph->daddr	= tuple->tun.src_v4.s_addr;
@@ -649,81 +671,91 @@ static int nf_flow_tunnel_ipip_push(struct net *net, struct sk_buff *skb,
 	__ip_select_ident(net, iph, skb_shinfo(skb)->gso_segs ?: 1);
 	ip_send_check(iph);
 
-	*ip_daddr = tuple->tun.src_v4.s_addr;
-
-	return 0;
-}
-
-static int nf_flow_tunnel_v4_push(struct net *net, struct sk_buff *skb,
-				  struct flow_offload_tuple *tuple,
-				  struct dst_entry *dst,  __be32 *ip_daddr)
-{
-	if (tuple->tun_num)
-		return nf_flow_tunnel_ipip_push(net, skb, tuple, dst, ip_daddr);
+	*ip_addr = (union nf_inet_addr *)&tuple->tun.src_v4;
 
 	return 0;
 }
 
-static int nf_flow_tunnel_ip6ip6_push(struct net *net, struct sk_buff *skb,
-				      struct flow_offload_tuple *tuple,
-				      struct dst_entry *dst,
-				      struct in6_addr **ip6_daddr)
+static int nf_flow_tunnel_ip6_push(struct net *net, struct sk_buff *skb,
+				   struct flow_offload_tuple *tuple,
+				   struct dst_entry *dst,
+				   union nf_inet_addr **ip_addr)
 {
-	struct ipv6hdr *ip6h = (struct ipv6hdr *)skb_network_header(skb);
-	__u8 dsfield = ipv6_get_dsfield(ip6h);
-	struct rtable *rt = dst_rtable(dst);
 	struct flowi6 fl6 = {
 		.daddr = tuple->tun.src_v6,
 		.saddr = tuple->tun.dst_v6,
-		.flowi6_proto = IPPROTO_IPV6,
+		.flowi6_proto = tuple->tun.inner_proto,
 	};
-	u8 hop_limit = ip6h->hop_limit;
+	u8 hop_limit, dsfield;
+	struct ipv6hdr *ip6h;
 	int err, mtu;
 	u32 headroom;
 
+	switch (tuple->tun.inner_proto) {
+	case IPPROTO_IPIP: {
+		struct iphdr *iph = (struct iphdr *)skb_network_header(skb);
+
+		dsfield = ipv4_get_dsfield(iph);
+		hop_limit = iph->ttl;
+		break;
+	}
+	case IPPROTO_IPV6:
+		ip6h = (struct ipv6hdr *)skb_network_header(skb);
+		dsfield = ipv6_get_dsfield(ip6h);
+		hop_limit = ip6h->hop_limit;
+		break;
+	default:
+		return 0;
+	}
+
 	err = iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6);
 	if (err)
 		return err;
 
-	skb_set_inner_ipproto(skb, IPPROTO_IPV6);
-	headroom = sizeof(*ip6h) + LL_RESERVED_SPACE(rt->dst.dev) +
-		   rt->dst.header_len;
+	skb_set_inner_ipproto(skb, tuple->tun.inner_proto);
+	headroom = sizeof(*ip6h) + LL_RESERVED_SPACE(dst->dev) +
+		   dst->header_len;
 	err = skb_cow_head(skb, headroom);
 	if (err)
 		return err;
 
 	skb_scrub_packet(skb, true);
-	mtu = dst_mtu(&rt->dst) - sizeof(*ip6h);
+	mtu = dst_mtu(dst) - sizeof(*ip6h);
 	mtu = max(mtu, IPV6_MIN_MTU);
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 
 	skb_push(skb, sizeof(*ip6h));
 	skb_reset_network_header(skb);
+	skb->protocol = htons(ETH_P_IPV6);
 
 	ip6h = ipv6_hdr(skb);
 	ip6_flow_hdr(ip6h, dsfield,
 		     ip6_make_flowlabel(net, skb, fl6.flowlabel, true, &fl6));
 	ip6h->hop_limit = hop_limit;
-	ip6h->nexthdr = IPPROTO_IPV6;
+	ip6h->nexthdr = tuple->tun.inner_proto;
 	ip6h->daddr = tuple->tun.src_v6;
 	ip6h->saddr = tuple->tun.dst_v6;
 	ipv6_hdr(skb)->payload_len = htons(skb->len - sizeof(*ip6h));
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
-	*ip6_daddr = &tuple->tun.src_v6;
+	*ip_addr = (union nf_inet_addr *)&tuple->tun.src_v6;
 
 	return 0;
 }
 
-static int nf_flow_tunnel_v6_push(struct net *net, struct sk_buff *skb,
-				  struct flow_offload_tuple *tuple,
-				  struct dst_entry *dst,
-				  struct in6_addr **ip6_daddr)
+static int nf_flow_tunnel_push(struct net *net, struct sk_buff *skb,
+			       struct flow_offload_tuple *tuple,
+			       struct dst_entry *dst,
+			       union nf_inet_addr **ip_addr)
 {
-	if (tuple->tun_num)
-		return nf_flow_tunnel_ip6ip6_push(net, skb, tuple, dst, ip6_daddr);
-
-	return 0;
+	switch (tuple->tun.encap_proto) {
+	case AF_INET:
+		return nf_flow_tunnel_ip_push(net, skb, tuple, dst, ip_addr);
+	case AF_INET6:
+		return nf_flow_tunnel_ip6_push(net, skb, tuple, dst, ip_addr);
+	default:
+		return 0;
+	}
 }
 
 static int nf_flow_encap_push(struct sk_buff *skb,
@@ -830,10 +862,10 @@ static int nf_flow_queue_xmit4(struct sk_buff *skb,
 	struct flow_offload_tuple *other_tuple;
 	enum flow_offload_tuple_dir dir;
 	struct nf_flow_xmit xmit = {};
+	union nf_inet_addr *ip_addr;
 	struct flow_offload *flow;
 	struct neighbour *neigh;
 	struct rtable *rt;
-	__be32 ip_daddr;
 
 	if (unlikely(tuplehash->tuple.xmit_type == FLOW_OFFLOAD_XMIT_XFRM)) {
 		rt = dst_rtable(tuplehash->tuple.dst_cache);
@@ -846,10 +878,10 @@ static int nf_flow_queue_xmit4(struct sk_buff *skb,
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 	other_tuple = &flow->tuplehash[!dir].tuple;
-	ip_daddr = other_tuple->src_v4.s_addr;
+	ip_addr = (union nf_inet_addr *)&other_tuple->src_v4;
 
-	if (nf_flow_tunnel_v4_push(state->net, skb, other_tuple,
-				   tuplehash->tuple.dst_cache, &ip_daddr) < 0)
+	if (nf_flow_tunnel_push(state->net, skb, other_tuple,
+				tuplehash->tuple.dst_cache, &ip_addr) < 0)
 		return NF_DROP;
 
 	switch (tuplehash->tuple.xmit_type) {
@@ -860,7 +892,7 @@ static int nf_flow_queue_xmit4(struct sk_buff *skb,
 			flow_offload_teardown(flow);
 			return NF_DROP;
 		}
-		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, ip_daddr));
+		neigh = ip_neigh_gw4(rt->dst.dev, rt_nexthop(rt, ip_addr->ip));
 		if (IS_ERR(neigh)) {
 			flow_offload_teardown(flow);
 			return NF_DROP;
@@ -1154,7 +1186,7 @@ static int nf_flow_queue_xmit6(struct sk_buff *skb,
 	struct flow_offload_tuple *other_tuple;
 	enum flow_offload_tuple_dir dir;
 	struct nf_flow_xmit xmit = {};
-	struct in6_addr *ip6_daddr;
+	union nf_inet_addr *ip_addr;
 	struct flow_offload *flow;
 	struct neighbour *neigh;
 	struct rt6_info *rt;
@@ -1170,11 +1202,10 @@ static int nf_flow_queue_xmit6(struct sk_buff *skb,
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 	other_tuple = &flow->tuplehash[!dir].tuple;
-	ip6_daddr = &other_tuple->src_v6;
+	ip_addr = (union nf_inet_addr *)&other_tuple->src_v6;
 
-	if (nf_flow_tunnel_v6_push(state->net, skb, other_tuple,
-				   tuplehash->tuple.dst_cache,
-				   &ip6_daddr) < 0)
+	if (nf_flow_tunnel_push(state->net, skb, other_tuple,
+				tuplehash->tuple.dst_cache, &ip_addr) < 0)
 		return NF_DROP;
 
 	switch (tuplehash->tuple.xmit_type) {
@@ -1185,7 +1216,7 @@ static int nf_flow_queue_xmit6(struct sk_buff *skb,
 			flow_offload_teardown(flow);
 			return NF_DROP;
 		}
-		neigh = ip_neigh_gw6(rt->dst.dev, rt6_nexthop(rt, ip6_daddr));
+		neigh = ip_neigh_gw6(rt->dst.dev, rt6_nexthop(rt, &ip_addr->in6));
 		if (IS_ERR(neigh)) {
 			flow_offload_teardown(flow);
 			return NF_DROP;

-- 
2.55.0

