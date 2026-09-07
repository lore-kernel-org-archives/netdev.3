Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CD416103
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766457; cv=none; b=tiNFAfj/vNzzaMF5bNne0q9nn7RlU6poShYlIO60oVD0kaXGLvyUNprQtJ/mxEJ9nDf4QNbnRyxoAikst6Xw5rI6hrJTNs16QZ2cOm2wfkQNyU9ee/eaPVcxgZiDTO4qV2hVMBOjyZiTuSucEqSU43sLqQw72H8ndKFvbG1yMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766457; c=relaxed/simple;
	bh=heg60N7YYlggEVkJ3E13NDQsqfVr8dYU9bp7pifaMfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmyCtWAQnyjYrCWfS+MsDYTm2l1qRUoduXvx3+hWdUnPb4wZHk8WJPwC4ZKq3nICsrrsLiQeno8EyYPXJS5ecku7nxxRqBx8osFuqN07i6fptSLkGwPOyxn1aGtoC6gZothg0U2PYPMoeNSu/tzo91Ib4g7NDuJQ7Fy2dDSQyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=drgUz3Gt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qd+IWJTf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="drgUz3Gt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qd+IWJTf"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777LCJ3363366
	for <netdev@vger.kernel.org>; Mon, 7 Sep 2026 07:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RLpedcZhZDsyKBGVCsCCJ50Ygn6ZAg7z+aYYIAJfKWU=; b=drgUz3GtjcNCaxdq
	fjchKEc+hmxGysQ7d7o44Jg45fuLfuWK+4AH43SoLdzO9/5ZGN839P1kdGnX0HC/
	CDIVgBZRyAg+LtbfoFc0+g8kEAJLNcY1AO1xNkKR4ol7H37w8ylxbSYclrctUVuP
	NshSA3TI0f5oI6m9JaJCd98jxfvSmh7AI0vh+ybsHCoqomDLGRc6sAP1kuijoRta
	tO/uxe9tDCOgJRsKgarDW7dv23RutBtiT0sF/J2oH+m5V/d88A9/qhRS/j1G31/d
	RBjZ8OUfclPvVNmWciG9l1/mtKXwfpLb0hJVtu+JzrJF4Z1IbA+gilZzZRZWm1Sz
	Ewys8Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghnmj0t2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 07:34:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-936708f129aso401145385a.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788766454; x=1789371254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLpedcZhZDsyKBGVCsCCJ50Ygn6ZAg7z+aYYIAJfKWU=;
        b=Qd+IWJTfdj464N4hrZF1HaE6Dkcvr0GnFfyXa7T0224Z6CDMOTUtWXeP5M8hqgcUaY
         DkVGa/sABs4r1Xh8b7QEQ/p5Zc5uo/Q2lWbbcfTkVl23Fkx5pGvnq32dMncs9WXThOgw
         8U9eABfVKg8qbAgm/Fmyj1n9rVtuBqIFzDzzRB0spGbB1TbDT1HF2fcDUOevSN516Ku7
         A3gNlQwQXsUEYX6H1Z5jTyOYpQBkSwIaqEH5+S9n8+S946u/m/tYIabL51VF5lCBu2dq
         Lrv9tpLMKarS6ToN0lMwbzHQJLu1Ty7vWPNObcfpOMRkv6+hUwYk9l2PpCDFCriqatTJ
         +GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766454; x=1789371254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLpedcZhZDsyKBGVCsCCJ50Ygn6ZAg7z+aYYIAJfKWU=;
        b=ivSFmJ/9LG21Hg+TKOfXSGlRaeqz7cM8FormmBoaOPFlsrYKubZ7zC3hqYdNMusEeH
         H/kr45UlpzUN8qi+VVsrUImnSBGS9IhHwHZhWYfC3Zps8tNpPb6rnqo81Dbj0pCl7aio
         0ThLrvPlpX/1OIHjOuKp2hSPuIlfJvax9HEB4b4Cw2+Q83/xZnq+9V1Bli84I7k9afPp
         XF4zsClMC1WZ/hNl6YnOXh2u2OV4fy7uK91t5eeinpT2B1NmILFQn+HzT9MJ+6UTcoAd
         mLDFj/nyqkox9BW0CxNWFPjHkw1WpIpoMjc5cXlz3uYjn+cg86lOVw1OLg6qYsagkLOf
         TnFA==
X-Forwarded-Encrypted: i=1; AKwUvBz83ilGkMrYvuY79OqrdAywrhQpLdo56wX/R7+LM49CDEr1jYgoOjysCJARcRe7q+BEvUX7oTM=@vger.kernel.org
X-Gm-Message-State: AFuF++k7N3IYkVWAcoXHVZhsrGwQHFbIkJZojSF52LXTHDF7oL/uNvO4
	+4JKRVNjN9xoSDA/5y4rMYvVFLzDWuUfhjmMvBS67mLPg0fl/0PvzexVuzUCeZKN1thEtLeEY3R
	GSA4TafSXtBZ2FGCL8dAzt/Y/lE37zshhPJmAxz3T8ZZbeE6uVMX3bgqosmo=
X-Gm-Gg: AYBFou3yWllFTPz/BoCNXscJJxDXjj3jC5kQGiQfnzwgB7UNKfoS0tZRjX5I3EQ7yOO
	WD9uYuDzK+xuc0+Np+1d63xLIxvr3RJq9qo77WRvfwLywjd5eOyuEFB9D+74L77+iyvTeKZ1XTe
	KbcagrUCHqlfU/co36ndQsQPvB2rjLfHJz0lEnWqsMbtZAk9bewZ/FIabOd93ZA367DED6nZF30
	7Tzj9iqn/b2OlRlTGNG6KRu9K8Dwo4h/fmOWOEEN5lscBy4X6mCj5K91crMJiv5wNBvT6c+DzfG
	HvTqExKgouKqz+7U9ZIYz+V+DA3nrQNSDF808mmIuF5cRuU49n/twgeLp+7YNiUS5F+2xil0mCN
	luD/L30/Wc706GQ==
X-Received: by 2002:a05:620a:aa0c:b0:937:2e9f:70a8 with SMTP id af79cd13be357-939804af824mr2326255185a.39.1788766454158;
        Mon, 07 Sep 2026 00:34:14 -0700 (PDT)
X-Received: by 2002:a05:620a:aa0c:b0:937:2e9f:70a8 with SMTP id af79cd13be357-939804af824mr2326242685a.39.1788766452676;
        Mon, 07 Sep 2026 00:34:12 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7736132sm284363575e9.12.2026.09.07.00.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:34:11 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 09:33:39 +0200
Subject: [PATCH nf-next v2 4/6] net: netfilter: add encap_proto to
 flow_offload_tunnel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-4-7c6ac1750725@oss.qualcomm.com>
References: <20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-0-7c6ac1750725@oss.qualcomm.com>
In-Reply-To: <20260907-nf-flowtable-sw-accel-ip6ip-sit-preliminary-v2-0-7c6ac1750725@oss.qualcomm.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MCBTYWx0ZWRfX/5iY4E99LMhV
 VFpLKSMgg+z4l9kWPy5vu/ITWdcoQx3JLWJc0dFHwvndytY3mtNJ+yYlwn5bcJSsXwzt4Go0Wm8
 lf4v6ACf0tqYYmvVOyX0UFJ5+ophkIp59keTfzpyvGiFMJiDcjIAXkD2JSNrtjusf7/tnSrbi1v
 aoEumih02cAFIRBCFGvhzEUqOxIRUJfZyw/0LgBTWx7nB5uB4yc3p2tsJPN724wvRdZ2WRnG+aX
 sHW6t4ka7WqhH/TS+XsIgzPvlEnwp1bVtZUg5ful4SFLMHrUrX3kHpG5aODFxNJWNdodX5y5QL9
 Clh/s3J5h0pBQ85c+lxFb5a5w+CNhBWVZWitDH8G0VzgOP2C+mo+gFtVAR8tC3YdO1KxQWmwzCs
 Tx1i2t3/djZWMoZfGvlDEmPREnUD5dZmPODtJq/BuqTI3QHDzHiU8bCIFUeqIgpD3noZTvWUKxK
 tKaVgmPOh69kWoOQ4Lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MCBTYWx0ZWRfX14cbuWCo2Mfl
 xqjwIf5yexLdd/WKkM6OSko5jdBfqoqFI86si7G1mjJjLpFG8gMc36zxDHANt/n0HiZHhSJN0uB
 fVKFkzKngaMavqiu39t/BvCW6nbi/Ck=
X-Proofpoint-ORIG-GUID: 5UM7_qUiMy4L-pZnbwRuoSH7wMCVhDMK
X-Proofpoint-GUID: 5UM7_qUiMy4L-pZnbwRuoSH7wMCVhDMK
X-Authority-Analysis: v=2.4 cv=LZYMLDfi c=1 sm=1 tr=0 ts=6a9e68f7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EiAgCLLKtgnx6EotJx8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070080

From: Lorenzo Bianconi <lorenzo@kernel.org>

Add encap_proto (AF_INET or AF_INET6) to struct flow_offload_tunnel
to allow its use as part of the hash table key during flowtable entry
lookup.
This is a preliminary change to support IPv4 over IPv6 tunneling via
the flowtable infrastructure for software acceleration.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 include/linux/netdevice.h             | 1 +
 include/net/netfilter/nf_flow_table.h | 1 +
 net/ipv4/ipip.c                       | 1 +
 net/ipv6/ip6_tunnel.c                 | 1 +
 net/netfilter/nf_flow_table_ip.c      | 2 ++
 net/netfilter/nf_flow_table_path.c    | 2 ++
 6 files changed, 8 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 8454646d6a45..4531e4de8416 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -910,6 +910,7 @@ struct net_device_path {
 			};
 
 			u8	inner_proto;
+			u8	encap_proto;
 		} tun;
 		struct {
 			enum {
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index f2e2771f188f..306e7d9ec3ec 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -118,6 +118,7 @@ struct flow_offload_tunnel {
 	};
 
 	u8	inner_proto;
+	u8	encap_proto;
 };
 
 struct flow_offload_tuple {
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index f684baf8e58f..c06ea32ec1df 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -379,6 +379,7 @@ static int ipip_fill_forward_path(struct net_device_path_ctx *ctx,
 	path->tun.src_v4.s_addr = tiph->saddr;
 	path->tun.dst_v4.s_addr = tiph->daddr;
 	path->tun.inner_proto = IPPROTO_IPIP;
+	path->tun.encap_proto = AF_INET;
 	path->tun.dst = &rt->dst;
 	path->dev = ctx->dev;
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..64a184bca467 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1868,6 +1868,7 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
 		path->tun.src_v6 = fl6.saddr;
 		path->tun.dst_v6 = fl6.daddr;
 		path->tun.inner_proto = IPPROTO_IPV6;
+		path->tun.encap_proto = AF_INET6;
 		path->tun.dst = dst;
 		path->dev = ctx->dev;
 		ctx->dev = dst->dev;
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index a53393f8eda0..1b9360d54dfc 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -199,12 +199,14 @@ static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
 		tuple->tun.dst_v4.s_addr = iph->daddr;
 		tuple->tun.src_v4.s_addr = iph->saddr;
 		tuple->tun.inner_proto = ctx->tun.inner_proto;
+		tuple->tun.encap_proto = AF_INET;
 		break;
 	case htons(ETH_P_IPV6):
 		ip6h = (struct ipv6hdr *)(skb_network_header(skb) + offset);
 		tuple->tun.dst_v6 = ip6h->daddr;
 		tuple->tun.src_v6 = ip6h->saddr;
 		tuple->tun.inner_proto = ctx->tun.inner_proto;
+		tuple->tun.encap_proto = AF_INET6;
 		break;
 	default:
 		break;
diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 1e55644f2edb..90360406d11e 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -135,6 +135,7 @@ static int nft_dev_path_info(struct net_device_path_stack *stack,
 				info->tun.dst_v6 = path->tun.dst_v6;
 				info->tun.inner_proto = path->tun.inner_proto;
 				info->tun_dst = path->tun.dst;
+				info->tun.encap_proto = path->tun.encap_proto;
 				info->num_tuns++;
 			} else {
 				if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX)
@@ -246,6 +247,7 @@ static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
 		route->tuple[!dir].in.tun.src_v6 = info.tun.dst_v6;
 		route->tuple[!dir].in.tun.dst_v6 = info.tun.src_v6;
 		route->tuple[!dir].in.tun.inner_proto = info.tun.inner_proto;
+		route->tuple[!dir].in.tun.encap_proto = info.tun.encap_proto;
 		route->tuple[!dir].in.num_tuns = info.num_tuns;
 		dst_release(route->tuple[dir].dst);
 		route->tuple[dir].dst = info.tun_dst;

-- 
2.55.0

