Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714479;
	b=ql9qstYVsnHaUUM5UWSI8waF7DFQ3AHMBIKSnZggUwD3/wgyfpx9nQjwQRfb2RhAe/lx
	 b7IlnMj5bFNyZNA7ToRUfzYWPgDREm7VF2iAiFQ4QFVa6B+9zYxIgRZGKYQi9G85ZwHFs
	 vPRdZyeqCAh7f9DUczo7Apcz5/gXXHnpE1l8jj+tsVUXJSvwLWo8Ge+E+QEi7EvPPi0LY
	 wHRslkze4o8DFukG6QfZXZcfvNqroOsoc0/vGYlUQoehLwkN1RMtXzB/yg2m61ofA3nso
	 YdkZUoxfe3DjuWn8HO6zRFdFWFTQ4u/QygWH93mcZgFMTs43/ZXt42MopRcn+1m4L4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714479;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3SXKAJvkWEfH8lskfIpG/LcDHtbUmYSyuBcyRooPK28=;
	b=YUko6myUHpOvT8TMr01fT4i4mdULZ9XTLwhCAqhlMq/T/J+9JqYQlZ/P1B78QsIUukfU
	 mJremCIYXVuum3xUynYNEtIqIT9P/0Qfqbt3OnmXim7AxnMSgn9LkCr3gYrGteLhpXQA5
	 motQHqcKfGrDLWrkRKqkYrYODjRouTqQG4e2p8L5f121n5a1s3gpsm3mntAwjaZPlazEh
	 tMFQYWi4tV4ewnEDhjJ+4g6eZaN3Zh+RW12QzrW9IJDStNE9RHnJmyaZ6Tkd4mpDredf+
	 kb+3boODsvZXNIj9Zmoed4qjnPqSeL2YJ2XKEGSE9/ggjPCrXjj7Y1mB2xtH8G01lZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="XsK9/Zd1";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AMaUoudv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CA606D820
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E8CA606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XsK9/Zd1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AMaUoudv
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3DZIi33612532
	for <netdev@vger.kernel.org>; Tue, 3 Nov 2026 14:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3SXKAJvkWEfH8lskfIpG/LcDHtbUmYSyuBcyRooPK28=; b=XsK9/Zd1psoocl2V
	TxAJIBou6+7cbmOzzAILQjeFkx6RVVAcVTkoHqcFiN8DpRsAcqUBUXI9c0/Fs3Sx
	L0UM0J7LDmqrmFKUa6solAp/e7rYCp8WVOKsIJBeVGYEVNW6uwEm0AorL6mCpMI/
	YBBiz1ZqPl9tzEADFdpvPnTkq5f0CQfwpTck3LkWitsJXZUbWKcnay2nGQilj1lV
	M+Won/OuXoBHS0Ui2E8l5g7Ank64WMhkf4wc99L6poX4qMpa2tEMtmbL8XmpFh4v
	3XYPdUgdHBuiTKtGMkAZQ7AuI8ORWc/LB4G/sUP+RiqA2uYF2y3fCQWo8j4sdcT0
	H9mrXg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9ajs1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 14:01:18 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eac2cf3905so527453e0c.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793714477; x=1794319277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3SXKAJvkWEfH8lskfIpG/LcDHtbUmYSyuBcyRooPK28=;
        b=AMaUoudvqNw4KdY4SdF6Zf7ZwCJ6lYPoNEQyBjPiEKdQzkxToHKbU9v2qmBBlyOfgM
         gC7gKTFOjgnDNsN5hfgNhJTWcypqAOolGu23rgesgZpkodFvACvOlz8otjBJIL5IpQKP
         rKpHfgYYe3Ea5vDyKitU5beifTFxIAS6YGKe6ugZ0ZA26oaPfrd6Myr1pVcLSkq0fkBb
         sESVu0OrYXf2bQicgBj7GMoogVPO+vYZQBarp/ReQEIci8YtyngxwEdIEjNYbFoFHyFw
         gjfWWa4LRyTrhfzydmMKPSwactoO3+kjxl6GNinreFR+tnb57Xor3hsMbBATepzX31tz
         S3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714477; x=1794319277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SXKAJvkWEfH8lskfIpG/LcDHtbUmYSyuBcyRooPK28=;
        b=BiajEXGeHNEJ4xuDoT4yjebAJANjwOFYvWsqrK381+kEPLLFBOYjOeGY3foyOXmjhP
         YG2ZCEdkD1yGNWW55wYYF2crkW6b9qr7bHDwoKWdMBJgIdQ0tKx6Eq/YuHtLxFH36LX5
         vXNFYV5j2wo6sMrCnfn/Z9MzF9sGNkVanDwxlHXNG704xZNkgo1vfoaqmbxcupH8wWQw
         Ua/Z8wsbnV+X+hfbNO8WohX9fSfyIzUo6REHIIdn2bnbHFbv0FfbI8QMYQaGoElMVKXj
         Yvu62tlTfUc+Tkdx3IBS8+ZS+MkL8zmMRPfoDDK9Hqs5j/7SYMdRf2F2AnNzMfWFGXyr
         0drg==
X-Forwarded-Encrypted: i=1; AKwUvBwWNFRxYBtJokMSPzUdtv/UQmANLEfOUeu3Hbhm2Oku5zw89WAe1tEpVczRNvJf7K2rO+iBerI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iUFEEtaj3HvB0LnfLh4UkxrMYu/G6c7YxZd5zs97ktb9maBoA
	qcd/z3Seuk+FDD3GxdmBgaaY2F1NWCq8+0ZXo10mukgo2Yjn+2qE0zy9vwpoUJpgMl+dkt5gfTQ
	oKqhiEG9ihknxpPfyXkG7IlBoKGHVEya2ct1gFDYZ6Nfr5H/6yyji34AHVdg=
X-Gm-Gg: AYBFou0WQyjnXhSyU/FIB20oyOZOK+GwZ4MXkMuApJ1cT3AYSsZotQi5eLRKcEseafk
	aExf16wdtRHDcRqpwCnHC6JP05J+xwJDn7Zl8dzIYddac8W9N/6KO2+e3Go5kTKnL1DKOxFFCIC
	totv9icSPnngH012180RQ7GNxn2YtMg3x7Z/xJJMXhYnd4C3mqvlFn11KNRdNw071jM4iDjnV3Q
	O9pFKwaOabIO7DuOcvaKXgEfBQSD4lHWGvcoGK3izct/5b4YL+a7EjPjy1hhCuQnenJoBwg+YrC
	g7h+p7u1yKxmy47x1sQT5QyFLwGtx9ePiWECp4FNmpql8hZkDlvubtmxL7XxM2QuCz1DG7T78B2
	Vq9AEn07Sgn9zpSZvepTuuEbk7j6SQv+IClfsbgZCdFDKBFexzyBe0DToLHjYgQY=
X-Received: by 2002:a05:6122:1d53:b0:5e9:7a1a:5ad5 with SMTP id 71dfb90a1353d-5ec689672a0mr5271299e0c.20.1793714476906;
        Tue, 03 Nov 2026 06:01:16 -0800 (PST)
X-Received: by 2002:a05:6122:1d53:b0:5e9:7a1a:5ad5 with SMTP id 71dfb90a1353d-5ec689672a0mr5271199e0c.20.1793714475995;
        Tue, 03 Nov 2026 06:01:15 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78c10sm24929252f8f.25.2026.11.03.06.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:14 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 15:00:44 +0100
Subject: [PATCH nf-next v3 3/8] net: ip6_tunnel: add IPv4 over IPv6
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
Message-Id: <20261103-flowtable-sw-accel-ip6ip-sit-v3-3-60b5f063f1df@oss.qualcomm.com>
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
X-Proofpoint-GUID: Lj2NFxpccd7hD4P-w6bheASZj4l3hbwo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfX5+Yri9tGVSCB
 xgA9Px1JOzrzUnbPZz9puurgIAb4fd/nNEAYAgeZLwQPpR+rntyto0/yYe0HWrhK/DhRtT3Xrvh
 S2Almw9Yfi4yQYEBMlczRf4NhsrfYRg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NSBTYWx0ZWRfXy+0i7C9IRA50
 fEvXP4nh+W5SIAocE3Oxrmok4hvFfPjRBVmW9w6CeLf/6c1rfduniuO9Bk8JuZ+2VpaBlpTclGJ
 A+gAPyEfzPcASptCnZFOP4a4ggk7njW8EdGhmlHM7efpgAIXd3SgUPbZs54wuAk7adqV4Ta2Utb
 zahfr51ogPA6o7+VcT3F6GXWpFPh6wiY3TBZbILFAGsJQyKuzhwTHHin5kXELacFiobTd14pBqW
 PBiVoYDufBZ6M8O2sRqiC9N4ME3FoDCKeexskaTbhHuVcwbw0z4dgXxLCS//WQun8sQKWbc8Lb+
 3dMYGGE/mZeiJbcLl3CHAblYhswdsIHgi2T8g2o+q68daG8cpfj237SjeiUo1sxVx7/JqJy7HbD
 CAIg1UjTSkQT93fVKCkAR8E5qleTFrl++BcENmKuWQYsG4iPaBz8NwSQ7EuzRyN8BywwSxUsqv/
 2hQ5TJqaEMupPk5B/jg==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae9e92e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=j_WIp6COnZI3mYKyEBAA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: Lj2NFxpccd7hD4P-w6bheASZj4l3hbwo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030055

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

