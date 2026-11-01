Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559746;
	b=0HBQMpXX9jDisv6e99ySTPByEcpUJ8akQSmNw8aNfdyt3SiToRoNQ//sTutTeFUDrveZ
	 sv/9VqcxeU0LJofrxglYZoNsDu9Fkz7ai35UY/YotSnzgUjQEys1+rPxlMD61L5oR9R+w
	 805DB7CkwDoWTlhzTnberqI4ZtiCiuS92pyui25Pjsv+FjGbCnPZgXtURlVNTATGyLt/5
	 H5klg03B0Um5sXv8gkKKmM6K92+58ueQEZ4zQ83UvzPinwDUZzhF1H0F//sGhjt2B1+IQ
	 5/0/OzJ4D8Ahl6atQfZp4Rq1Z2d4j9M5m8z68ATCqTuRukC8D/urOrgXwo99PpLBbKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3SXKAJvkWEfH8lskfIpG/LcDHtbUmYSyuBcyRooPK28=;
	b=Yjos+1WkhHm988eoqAk18Bh/PrmjC9CHVsRnW6L95loIx5YT38z49RmsGE2XrkM/ZLeJ
	 vRPzvJ4qXkWh0NxXGMXwKzgqx21sIcPm2wYamJhp0ZOIEVrrZNOvmNkpt/vuEbxYXChqI
	 Bq1ctALYNikQyTm3EmL2JsiK8qAUR6E9XJ9c6mA1Hkrv2ac7lDSSyzTPmlJqmKByIkdZI
	 om6cCV5FiOVqJJCL//OLJGgtRX+BqtcURFaY2WO+wHjP92kb7RkBKSLLRMHivGt4PX1Ab
	 n3aEf+gJ0ScwLAva8tCj6Yzavy7D7nx7MlVZ2eoKYL59/S8eiq1MGJMuTNhBvjhbEjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXtmdTwF;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MRFlQLMM;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8C606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD8C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXtmdTwF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MRFlQLMM
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HQDnm378246
	for <netdev@vger.kernel.org>; Sun, 1 Nov 2026 19:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3SXKAJvkWEfH8lskfIpG/LcDHtbUmYSyuBcyRooPK28=; b=CXtmdTwFZqklS/tX
	wirZVFAPARgzifJofkDYUedIOturWsEqDZlqmJIXKpzpLk96l5JXRN2FJvCg0p7c
	twQ9OpISNkrEujeIfOA3lX1BQBzKvVo8oWUr4ddBOGPRSsL1zdhwahkgWcFSdImT
	Vtw/j32cl4FDQksEM1tn2VmU2eIY8rS7wzZzVXGcpNbr1qEtOxUtQlaCXxb2dmWg
	DQs93JiUubLNsoiAWJPuX0lTwKIY4gw+2y60nadaovaxmLye5KfAdIdPVid4ExSB
	zS0Tnz4tKSlrrkw/wawE6mQV4qM0w/fhDRS6XQlSByn4hiwIO3rMLwYqs/mWrrrZ
	GPfdYQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7uygx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 19:02:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9440b27c1feso407502585a.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793559744; x=1794164544; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SXKAJvkWEfH8lskfIpG/LcDHtbUmYSyuBcyRooPK28=;
        b=MRFlQLMMyvIDHYsly6aA664dnSpyJyV1DjaGHWA82z+YZrNv24ocq74qu0yAnJ7Bcv
         YaDyVd6uaaqo3bNRpVGLvt5+enP19fqdoWS+/5RvsE+O63szetWlM13fbGNMz5IpVWdd
         tAeL02pginy8o2tF+XvItRy+S88/N0Csc9Ju2u7JfAcuOAIJjNEZL5K15H9y8rTu9W5+
         d6X2KkI1QunRFePsJMcOPdDru3FfskViQ1thoLX8TQupsn9CmDnn8QezYjVU0qKmPTf6
         HGTRXgOAUiqNrLZJj+g7jWnYRLmuSgK8Gd9hF1ECS7DMyn7FSvl+ucnCARTEKSZyxfTu
         QQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559744; x=1794164544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SXKAJvkWEfH8lskfIpG/LcDHtbUmYSyuBcyRooPK28=;
        b=fjmLlOrL12r0oYIv1a63cSqrwfQREIneDg8X+sA1pg+gjcadElu9XIqfgvlaOab0tc
         yZrITRmOpG4rz7NjQjhKFpJO8kXiSLrWnqdpZNQvmLw6fqXSKBhhu4qVpAjXfa8Nt8Cm
         TyQER1+E2XlJzT3UO3AVzPKc4C/2JMkJinCnQZM4ADj41RK6tSKbvR91H77kAC3/ydcb
         a8VM3IQQKf8bMkXLIuVKvbKYEIR7Fl4kbVwj+HO4IzFH3mw9nWu1YX50exOmeCLao5id
         thBfLp9/uQXaO3997m46d2STthfoqJV3/rzj4wowyEO7scymClUOh8oLJbxosRM6nHAW
         RPMw==
X-Forwarded-Encrypted: i=1; AKwUvByOWHtbeqpoCyg+E6aceEPeE6PgTAn9nBQ+Ytk7+yGWYVITNEuE33ZKhqJQf8h43MXOldyelV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYK93qlpZ75RHLMPSiJumCsWqEjkaOOxC5vX1wttGXz3MmSMF0sS
	XxhugyZaf1HMZubAhtpklLh3AujEKuQHcgJLSnnhoiVCNAGA+wlEV0N5uSVbAjLuszhza9IUxrb
	wVTMZ/SFb2ArWSJWiSKnvtuC54DW2QNlgkR7CWDyTrGfgPsissfP1bSw17vU=
X-Gm-Gg: AYBFou2yCVAQUSl3MeqVUT1bXOYAMO/mtj4tDVXmqThYutk4kaHjoIbS5nXI/XFQNgg
	PsSxFE/+RSkh6ofKMoANt4WTEETqnVnVKZULgdKdLp5Do5Wx82KW2h3tnZ0ez+QYWmq2WPR28Xj
	fk+FxL29AK4RoFwXUa7LgiY+aa1WzyHVNZvcaBTvWFL5qAK+L8k2FxGiKLSFoPnTZOoMKQE2E60
	J0viw3LcW8omPjiKCgi3VDzOvrqJSgykhTSTsNGmKQSQG86DPbi6qCAr+zbPwC/Qi+TaGYxd5zM
	P1Dmtz3fWYnhFwmSeJEZjTHsm0tzx7xjy8lWkflNBXKSwY0ucS/j90UoZsLlF8DfoH7OobdRq4p
	zWBnhBovTkWo7n4EGzSyM0wCKIrZ6KjP7izDA3NlWuPte5HFbFSBBxjKGQwIbMiM=
X-Received: by 2002:a05:620a:2b89:b0:93f:4d4e:ff6b with SMTP id af79cd13be357-94421585ce2mr1281217285a.12.1793559743783;
        Sun, 01 Nov 2026 11:02:23 -0800 (PST)
X-Received: by 2002:a05:620a:2b89:b0:93f:4d4e:ff6b with SMTP id af79cd13be357-94421585ce2mr1281211385a.12.1793559743192;
        Sun, 01 Nov 2026 11:02:23 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm327969315e9.11.2026.11.01.11.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:02:21 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 20:01:57 +0100
Subject: [PATCH nf-next v2 3/8] net: ip6_tunnel: add IPv4 over IPv6
 flowtable tunnel offload
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
Message-Id: <20261101-flowtable-sw-accel-ip6ip-sit-v2-3-c6c282cab5cb@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: WGDsnG1FRE6Rh3jGl0sZ2Q49igKnin-x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfXzv5RYkoorINF
 gD9G9tmc9+l3W4Et4n93KP9sIOGXQn02NRUhLf7pssct4oXXXp7Jb/k7TErfgM9ChccswVTwuWu
 Ff4YWeE3mye2U953XK4deVeHnwHcGOs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX1mwqE9RUjnUV
 t4HfD5TYR/+4FMhKzP/xcxvP0IQa2ASU3Bch3UghDYF6ivTDu4UBRtvsDgRs+rZVdQ7FucdvBEp
 Kz5Zy3bEWI430xq+gdHqtlcetpOuEM411QfVEBtrh94fm60FLLONcga4kfdXvbLmc0NpiFCAMUU
 egPv13A2/xokHiW6d5+mekftirs5uxohBayRYIikQcUu83UivP4TG3xM3OF3h6v/hXUsYXLzND9
 kBVMAztW/z4qycaq6FR4Aab6nJ2II8TViWhcNuLtLfOcd69w2DbRWJXEtow2zUnI++e3ZW7Zx5c
 fHMB1+GXtVsuUZMyoMSAkpNGQN//4gaOijP8Sfa7/h9t/zf0P0seEVFfzH5p9z0Qe7uBNw+YgVl
 0JuXaLKXSxmziMnqQEII4tZu1QArB+rWMMSU2pcwaShfO+1oLkSYliOJQF7ESslxb1MKG1Tp7lW
 t5M2EihMggUoTrHxFjg==
X-Proofpoint-GUID: WGDsnG1FRE6Rh3jGl0sZ2Q49igKnin-x
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae78cc0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=j_WIp6COnZI3mYKyEBAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010075

Allow ip6_tnl_fill_forward_path() to set the inner protocol for IPv4
packets (IPPROTO_IPIP) in addition to IPv6 (IPPROTO_IPV6), so that the
flowtable can offload IPv4-in-IPv6 tunnels.

Return -EOPNOTSUPP for any other ethertype, and when the tunnel is
configured for a specific inner protocol (t->parms.proto) that does not
match the inner packet protocol, so the fast path does not bypass the
check enforced by ipxip6_tnl_xmit() and ipxip6_rcv().

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/ipv6/ip6_tunnel.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 64a184bca467..920eb231945a 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1840,13 +1840,11 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
 				     struct net_device_path *path)
 {
 	struct ip6_tnl *t = netdev_priv(ctx->dev);
+	u8 tproto = READ_ONCE(t->parms.proto);
 	struct dst_entry *dst;
 	struct flowi6 fl6;
 	int err;
 
-	if (ctx->ether_type != cpu_to_be16(ETH_P_IPV6))
-		return -EOPNOTSUPP;
-
 	if (t->parms.flags & (IP6_TNL_F_USE_ORIG_TCLASS |
 			      IP6_TNL_F_USE_ORIG_FLOWLABEL |
 			      IP6_TNL_F_USE_ORIG_FWMARK))
@@ -1858,6 +1856,20 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
 	if (!(t->parms.flags & IP6_TNL_F_IGN_ENCAP_LIMIT))
 		return -EOPNOTSUPP;
 
+	switch (ctx->ether_type) {
+	case cpu_to_be16(ETH_P_IP):
+		path->tun.inner_proto = IPPROTO_IPIP;
+		break;
+	case cpu_to_be16(ETH_P_IPV6):
+		path->tun.inner_proto = IPPROTO_IPV6;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (tproto && tproto != path->tun.inner_proto)
+		return -EOPNOTSUPP;
+
 	memcpy(&fl6, &t->fl.u.ip6, sizeof(fl6));
 	fl6.flowi6_mark = t->parms.fwmark;
 	fl6.flowi6_proto = 0;
@@ -1867,7 +1879,6 @@ static int ip6_tnl_fill_forward_path(struct net_device_path_ctx *ctx,
 		path->type = DEV_PATH_TUN;
 		path->tun.src_v6 = fl6.saddr;
 		path->tun.dst_v6 = fl6.daddr;
-		path->tun.inner_proto = IPPROTO_IPV6;
 		path->tun.encap_proto = AF_INET6;
 		path->tun.dst = dst;
 		path->dev = ctx->dev;

-- 
2.56.0

