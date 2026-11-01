Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793559755;
	b=R+dFCDpB0uUGKiB+RXrx/6u4h4qm2tM2Ife9L6VVgrBV/7WuObIBocX9gw3kFPzyZFQu
	 cIje7BBEVKWbuiff6RkW4TVltVc4rxqrwubLVmY5hPfHKTNaOEO5PNrfaeZSAl8HBnT6x
	 1pBHJbMi3zh3O/T6zevU/Q0nlc/pONNNCH1GkVGJ93wFWn1eRRd/PmsRCbTPEo65Mqkrc
	 MFrzTD9eSVyl6FOkRWJkoczWGn/dEMohGyD7SLgAULBsFE4Q1I5Qh6B3RJ2t9BK0KknKX
	 FvdM18LB1czuA6aSaJ1QTadXXysA4qPwp/PPEwbQdySC7d1mmXHWneofq5lhMkw36OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793559755;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VW9jX6l+k1XMF/axnPBeu/GQCOS1nkisIl1Hl7Ayquw=;
	b=gwLIw0Q375VJgIIeoWqN5REzcOdiezEYFAvMvo9dj6aM77X9hCUT5faePgvhEXdeJhsy
	 ctEanY+k3qycZ3j5cy43FqXpNNmGvnrQjhSa3IoCbUkoHd1XLwZM3JLoAGUOWC5nkEWOb
	 s0OYM3oBYzgIRB2+ZZNl/2jca7l8kyRbWKXCC8k4/zsknsKNjV+/jXWmZ0CpPsvhYBLc3
	 nbvxLr1P8DKgZ63UP8MuVf2Cfz7tD2ISWd2jIWyhoNdDLtodF4FHfdpLHv6MNkHEdXMa0
	 EoKgMJB/xWJ7oI8gsCYhPEdmSA+iLUrA9kv13R9vrdkVnC3UPzbhxU36wc5shZAwwkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ArAbnkif;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SLGy0hPv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE64606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE64606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ArAbnkif;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SLGy0hPv
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HRjN4381180
	for <netdev@vger.kernel.org>; Sun, 1 Nov 2026 19:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VW9jX6l+k1XMF/axnPBeu/GQCOS1nkisIl1Hl7Ayquw=; b=ArAbnkifugLyqxe3
	gTXRdXo/f1ibUQJPUwBSEn2jSQH0VcL4BpGIFuacevUoFZ+TcHeCt+wRN7T4xvZK
	ICUxmAmwyChksipJSFGv8lPv4O1MWOppwiFUB5ejghRqrDfY0Sr7SsWf1mlBKx7w
	o2lEpnbKnxVxkQCwm92264kRA1bB5F9CjYAi1XK2YudXR0Ecqj6YTAm1KPIsCskW
	u5XaP+7NhtVPafyp/Q7BWcgHg0o73vxeYl6K9HPJlzkFicR2W8adb70Szxzs67dT
	KAk60gNWLDhn9LNAD9ENcJcqS/iwtdjb7J4JSqb4GbD/GHclH7eTgQr/4R76XX0C
	nlZmmA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7uyhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 19:02:33 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7bf3a0a498fso1899954137.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793559753; x=1794164553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VW9jX6l+k1XMF/axnPBeu/GQCOS1nkisIl1Hl7Ayquw=;
        b=SLGy0hPvo1GDPi4S1MOp2n7Q0bsLEwkS5Qtz6e3Hzgxz4OIzaasrVc7zI1mRz7YHlJ
         ns0G7OydZCrHP6N5zzLpmMPShGroxtrNqzr1KZ5Ue4F8kNTgzQCiKGX59vHJMjc1kqza
         wFMDndHF3yyMwl3nJB+iks84CnkzFUd2e2cYm3URw0G7SWniuI8gV4bi+rNqBult+dZG
         VJCQLVh1Alo7nBmdJK72x3HrL3HBPGWAechQUdczt/Lj/kQ5YvrnJnkHQttvViqFxN1l
         a6aQpOVBqFYaoUr+qpu3T1hfK6ep5FKogiuAHW86qYM/B1uAWGnPWtKW1XuwtgFTnZQ4
         jSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793559753; x=1794164553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VW9jX6l+k1XMF/axnPBeu/GQCOS1nkisIl1Hl7Ayquw=;
        b=KOJtHaqkUc/xSSgV5ik75hbLIprFgb/q//QPT2JuWR0U2b3y5JEfFDttMHywuysSIE
         SR3g2lnffmT5Q8nCwmm3aZ9RJT/qtupqwbfJqcOjCrbIfmzGf4MjzzbVCQNU6wJY+iSN
         8AJ37S8O+iRZ0BdzIgN+7SNFESjtXnI/tIY0TzLb5Sik5gtLig3fOIHo94jCTMej/7Ny
         9RooyJumkFhWyE0zrSj9eVFSD1bWID3/G86boBmRkZVZdh3WO1EC/c8WiKunh9F0chKM
         oBN0OK/8qrglyRDzS4Ol0O7ejkiKcM+eyat7l4rBwJTN01Ad7re4gC1Bo5jN1aQvxHHd
         u3/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLDRxfPImc7OFoBEjzWWEWbzgNMaqVoZIf3cTl4jlcCGNJJUvOTBn0MBu5ibbK63K/Ikac970=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xHl8rxfZfre3TMRjy4dfs4mGhuGAJm09tg2LET4NvpyuL5tWa
	ymwlqxZRflTSR9Cj4/5+QfqYsJ20vXuIV6OZqcYLzRbB0MSAb+FRyY05iMdQZ8LdB6YEPNVwxak
	z0R3bAu6vr0XiIA+ntS028b0IZv8QRPD+EPxalaIZJfYO6PsB6wJo8PuW1gk=
X-Gm-Gg: AYBFou2lzJHGFz2CR9gdeetEVMv1sF9D8j1CwA9LZqlPRhCW/8HCpKGPHL8YTzqDxWr
	QHLOw0f0mHXcDcV1xDVF1hbSk77OKCpKP0DFBLe+QtTEGssHwTCb9L4GysXPIKpKXJKu644UsuY
	SfWusfoUSNMJgFFqOtt2D6gTMcb6eFHrPBqjAgM7WoPKOh2eInRAwrmd3mFPRCID8vWLKykbNuZ
	fdGFtpwZ0C1XDI2gCkIOkZ3IRX/ydG6fYcdJtD0RCaAVhlLCknZ3wWbtJuCIU6l7aQRwb1B9E52
	irpaCkHnV0ozApqTkwk504V+ZwSJ66qeAkpkx2QMspw1SK5UPZ3zgnyG/+qaTmEWVqQIYAedqWv
	zNd7rmBzv96X4yiEhvkTg3i2YpoCdXW/aZRL2RV89se4W5MKbDgP2C1S31ChwMxM=
X-Received: by 2002:a05:6102:5128:b0:7cb:6954:109a with SMTP id ada2fe7eead31-7d054180f14mr3593380137.12.1793559752766;
        Sun, 01 Nov 2026 11:02:32 -0800 (PST)
X-Received: by 2002:a05:6102:5128:b0:7cb:6954:109a with SMTP id ada2fe7eead31-7d054180f14mr3593361137.12.1793559752159;
        Sun, 01 Nov 2026 11:02:32 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm17462072f8f.7.2026.11.01.11.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:02:30 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 20:02:01 +0100
Subject: [PATCH nf-next v2 7/8] net: netfilter: add SIT tunnel flowtable
 acceleration
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
Message-Id: <20261101-flowtable-sw-accel-ip6ip-sit-v2-7-c6c282cab5cb@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: SJDtZweehyr2LeL2JgnKFKTc9oUe83za
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX5AIVQdpRlM1g
 8mKXMtDkg8SyCdSruuO66dHDqxtnK39n9/07hh34Gj2pspI6n5S4xzljQYmWY1jPtQc93ROpyx2
 uz/DDOG2ZS1RLRCrsmrblB0hI5gfW40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NSBTYWx0ZWRfX4hrOQQQonumZ
 D/3bTbKH0BfBX9qCPAfwHU2E5oPQkc+bPUMF0TJd4LgZlUGVop7SiGTUfMXWYrV1dd61VKXAYOD
 8vhDPY3pDrCs0p+2iqt4jn0fPCnmI58zdvcXPfyWeTaJ+nzrWRTayN+spg9gxS9mj4Iu1zhF1me
 vZgCu1gqjzA5nA0Vb9+n4hY+gkS1R1ODcM2YGRWWhJ8Rue3oRAN4niRaFBHUnXhBm7F2lX2zm9C
 Ug2m5P1XxTe8Sn7kyTe/Ap0B+aLKUsl8wmFuY5GLt6PWahNFo9VmAWX7bBX/H52EE4sFjHMeuJL
 KKCufWK2IilHAd1rS/kJsVygbChLkAXeFenOWoNL56nY7ae4rttW6T7WC7dBuKSuAjTIHpooyv5
 vkcwgn2p0D5TKWjfC9KYXt5p70vwnkzAgqITjK69ARltte3ykgGeUwDILWFGNQxldWRgpvb1oXN
 2NbVqpXknhLYsw7Y1MQ==
X-Proofpoint-GUID: SJDtZweehyr2LeL2JgnKFKTc9oUe83za
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae78cc9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Azys4kmTdsnWQ9nIUdYA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010075

Introduce sw flowtable acceleration for the TX/RX paths of
SIT tunnels, relying on the netfilter flowtable infrastructure.

Only plain SIT tunnels are offloaded: NBMA tunnels (ISATAP, 6to4, 6rd),
FOU/GUE encapsulation, inherited TOS, and packets whose inner protocol
does not match the configured SIT mode are rejected.  Tunnel parameters
are read from the RCU-protected snapshot and the outer route is resolved
in the tunnel netns using its fwmark, mirroring the slow path.

The feature can be tested with a forwarding scenario between two
NICs (eth0 and eth1), where a SIT tunnel is used to reach a remote
site via eth1 as the underlay device:

    ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (192.168.2.2)

[IP configuration]

6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
    inet6 2001:db8:1::2/64 scope global nodad
       valid_lft forever preferred_lft forever
7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.1/24 scope global eth1
       valid_lft forever preferred_lft forever
8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
    link/sit 192.168.2.1 peer 192.168.2.2
    inet6 2001:db8:200::1/64 scope global nodad
       valid_lft forever preferred_lft forever

$ ip route show
192.168.2.0/24 dev eth1 proto kernel scope link src 192.168.2.1

$ ip -6 route show
2001:db8:1::/64 dev eth0 proto kernel metric 256 pref medium
2001:db8:200::/64 dev tun0 proto kernel metric 256 pref medium
default via 2001:db8:200::2 dev tun0 metric 1024 pref medium

$ nft list ruleset
table inet filter {
    flowtable ft {
        hook ingress priority filter
        devices = { eth0, eth1 }
    }

    chain forward {
        type filter hook forward priority filter; policy accept;
        meta l4proto { tcp, udp } flow add @ft
    }
}

When reproducing this scenario using veth interfaces, the following
results were observed:

- TCP stream received from SIT tunnel:
  - net-next (baseline):                ~118 Gbps
  - net-next + SIT flowtable support: ~148 Gbps

- TCP stream transmitted to SIT tunnel:
  - net-next (baseline):                ~131 Gbps
  - net-next + SIT flowtable support: ~147 Gbps

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 net/ipv6/sit.c                   | 72 ++++++++++++++++++++++++++++++++++++++++
 net/netfilter/nf_flow_table_ip.c | 22 ++++++++++--
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index a7ec800216ad..851dfd37b518 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -29,6 +29,7 @@
 #include <linux/icmp.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/inetdevice.h>
 #include <linux/init.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/if_ether.h>
@@ -1483,6 +1484,76 @@ ipip6_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
 	}
 }
 
+static int ipip6_tunnel_fill_forward_path(struct net_device_path_ctx *ctx,
+					  struct net_device_path *path)
+{
+	struct ip_tunnel *tunnel = netdev_priv(ctx->dev);
+	const struct ip_tunnel_parm_kern *parms;
+	const struct iphdr *tiph;
+	struct flowi4 fl4;
+	struct rtable *rt;
+
+	/* NBMA tunnels (ISATAP, 6to4, 6rd) resolve the outer destination
+	 * per-packet from the inner IPv6 address; not offloadable.
+	 */
+	if (ctx->dev->priv_flags & IFF_ISATAP)
+		return -EOPNOTSUPP;
+
+	parms = rcu_dereference(tunnel->sit_parms);
+	tiph = &parms->iph;
+	if (!tiph->daddr)
+		return -EOPNOTSUPP;
+
+	if (tiph->tos & 0x1)
+		return -EOPNOTSUPP;
+
+	/* FOU/GUE encapsulation is handled in the slow path by
+	 * ip_tunnel_encap(); the fast path only pushes a plain
+	 * IPv4 header and would skip the UDP encapsulation.
+	 */
+	if (READ_ONCE(tunnel->encap.type) != TUNNEL_ENCAP_NONE)
+		return -EOPNOTSUPP;
+
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
+	if (parms->iph.protocol &&
+	    parms->iph.protocol != path->tun.inner_proto)
+		return -EOPNOTSUPP;
+
+	flowi4_init_output(&fl4, parms->link, READ_ONCE(tunnel->fwmark),
+			   tiph->tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
+			   0, 0, tiph->daddr, tiph->saddr, 0, 0,
+			   sock_net_uid(tunnel->net, NULL));
+	rt = ip_route_output_key(tunnel->net, &fl4);
+	if (IS_ERR(rt))
+		return PTR_ERR(rt);
+
+	path->type = DEV_PATH_TUN;
+	if (tiph->saddr)
+		path->tun.src_v4.s_addr = tiph->saddr;
+	else
+		path->tun.src_v4.s_addr = inet_select_addr(rt->dst.dev,
+							   tiph->daddr,
+							   RT_SCOPE_UNIVERSE);
+	path->tun.dst_v4.s_addr = tiph->daddr;
+	path->tun.encap_proto = AF_INET;
+	path->dev = ctx->dev;
+	path->tun.dst = &rt->dst;
+
+	ctx->dev = rt->dst.dev;
+
+	return 0;
+}
+
 static int
 ipip6_tunnel_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 			    void __user *data, int cmd)
@@ -1533,6 +1604,7 @@ static const struct net_device_ops ipip6_netdev_ops = {
 	.ndo_siocdevprivate = ipip6_tunnel_siocdevprivate,
 	.ndo_get_iflink = ipip6_get_iflink,
 	.ndo_tunnel_ctl = ipip6_tunnel_ctl,
+	.ndo_fill_forward_path = ipip6_tunnel_fill_forward_path,
 };
 
 static void ipip6_dev_free(struct net_device *dev)
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 2bdebd3ff5f9..7393ee782ce0 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -158,6 +158,16 @@ struct nf_flowtable_ctx {
 	} tun;
 };
 
+static int nf_flow_tuple_ipv6(struct nf_flowtable_ctx *ctx,
+			      struct sk_buff *skb,
+			      struct flow_offload_tuple *tuple);
+
+static int
+nf_flow_offload_ipv6_forward(struct nf_flowtable_ctx *ctx,
+			     struct nf_flowtable *flow_table,
+			     struct flow_offload_tuple_rhash *tuplehash,
+			     struct sk_buff *skb);
+
 static void nf_flow_tuple_encap(struct nf_flowtable_ctx *ctx,
 				struct sk_buff *skb,
 				struct flow_offload_tuple *tuple)
@@ -466,8 +476,12 @@ nf_flow_offload_lookup(struct nf_flowtable_ctx *ctx,
 {
 	struct flow_offload_tuple tuple = {};
 
-	if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0)
+	if (ctx->tun.inner_proto == IPPROTO_IPV6) {
+		if (nf_flow_tuple_ipv6(ctx, skb, &tuple) < 0)
+			return NULL;
+	} else if (nf_flow_tuple_ip(ctx, skb, &tuple) < 0) {
 		return NULL;
+	}
 
 	return flow_offload_lookup(flow_table, &tuple);
 }
@@ -959,7 +973,11 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 	if (!tuplehash)
 		return NF_ACCEPT;
 
-	ret = nf_flow_offload_forward(&ctx, flow_table, tuplehash, skb);
+	if (ctx.tun.inner_proto == IPPROTO_IPV6)
+		ret = nf_flow_offload_ipv6_forward(&ctx, flow_table, tuplehash,
+						   skb);
+	else
+		ret = nf_flow_offload_forward(&ctx, flow_table, tuplehash, skb);
 	if (ret < 0)
 		return NF_DROP;
 	else if (ret == 0)

-- 
2.56.0

