Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C131F990;
	Thu, 30 Jul 2026 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399802; cv=none; b=K1eT9cDaXERQz/4WEL5wgX07Zn/7EyufHvVWTniG9xHYgJfHzPpLs1k4/mU9XVz7tDuTZm9Vj2PbBBisKSwQ+V11jHUh36oGutla2PgNwhQKte78ZwYHjpqH9SpU8XFOWF6E0G8hUb6rJURgqq/YA7ynZ8xNgtKPK5q7x72VzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399802; c=relaxed/simple;
	bh=dMd4DUDUT7mwP6egGqc3fHAhafvY9eRasCVwBfyGKI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bsFsTIwRMm+7e3sb6p4hbuScwV9TAK9X10G7mzuZbGfmECxKMYa9QT9w30vYfNq3qocg6cCeVBpjM4dpe9Ms+ulAN5I8WMxZbsC+rGdKFqG+akC8sLjioKZrBBz343JfJGZURixgAFJr4iuB+cJ/rpY+yzIptEGCNYLmaJztIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=on7Vrxn5; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="on7Vrxn5"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U854He3533738;
	Thu, 30 Jul 2026 01:22:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=AJH9ttkwm
	cDicpqtYSk4/DRUPXwNt6JgGGESAjM9ziw=; b=on7Vrxn5JvDYBgVAxRO7gl9XP
	VXMwz9K4Mkzup3PBJI9Djm9qT26FqbuOzUASE3UrOb9JbfmXeMLb832lZ8iEZm2B
	2GxZ1vPeYvaf4/lYqGG5vpfGTR19Dof6HFI4jHkjAjRoRISQwgmRQRY50A7QAwTJ
	8OsjpkHgriz7c6FjtvPBAStO1SxvrNxDpkPfFG9eRamk/bUE39aLGPBe/JurNMKN
	v0vffvHp80BJzN6/lbAowDbc6O5Vkvgy3+6CtiUUUhCxeDBp54p0eaN6w3zESErj
	2+YIrkzF3DgmS0vIKw1MfbwwXskQO7q+GAkVl0qxjRZyw6d2Qecm24NAn5N9g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fr2spr0ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Jul 2026 01:22:42 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 30 Jul 2026 01:22:41 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 30 Jul 2026 01:22:39 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH net v3] net: erspan: set lltx to avoid sch_direct_xmit deadlock
Date: Thu, 30 Jul 2026 16:22:38 +0800
Message-ID: <20260730082238.676845-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ZMznX37b c=1 sm=1 tr=0 ts=6a6b09d2 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=ADlydbMj1Wbzk9vhUvkA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA1OSBTYWx0ZWRfX56AqZ4wZab3U
 Il29Z9Ydn+hJzi0+p2M6hNRcKDZN+Nq/C3gw/QMjUCDbo3+w/NLdgPpTQanViyKXZUN579kJA4q
 Dw0G0BLhCBartdaIYC7lRocYipYnAo/kR6IAGi2hV9UHQeaZ6AGB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA1OSBTYWx0ZWRfX/6yaJZyJgbCh
 FOU+dl4SjDAbN8seP7lkwdW2jZjzGteddnpaKj9uEtBQJUeoUZ83eLzn2I6wopP/7ee8bQ6NyZV
 6+FYCw11mYdMw1FhrtjN362la4Sg+qcLfkurojIYTlKbEeX+w6U7TgD12AwJW+sLcLsXo8mhk5M
 yu/PVyYjqDTT9TNeIKZ66CQom1VIT15a+IGED/DSI2tIwnJgrS4hWmUOpHaJBaCv2kJwEgZgtR0
 9U6RzJuGKKdtjYGhyYau47K6UfUzjefs8pvXIJwfJJ8r2BxuuuDzb0SQnvKygL8G2dbAnKAwilR
 ZDl8d1ZWHFmfv8DC5dRwJbRJawcEP4HZyVtuyEiW92d5068Pkx3KIsai8UIvU8jBaRxCTl5SEA1
 a1C7lmXTY/d6EukITQCJRA3/V9mCVtpZRX5A7nK+9lpHKrULmmGY43JOwFBMtsXb60SCtKhfG/t
 Psm5qYUslHr0Is2KZ7w==
X-Proofpoint-ORIG-GUID: iRy2sgmZ4zfJ3R-AIpFE9_bNgwGJ23Um
X-Proofpoint-GUID: iRy2sgmZ4zfJ3R-AIpFE9_bNgwGJ23Um
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300059

erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
nested acquisition of _xmit_lock on the underlay device while already
holding the ERSPAN device's _xmit_lock. Both are ARPHRD_ETHER and share
the same lockdep class, creating an ABBA deadlock:

  sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
  ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
This is safe as erspan_xmit() has no shared mutable state: o_seqno is
atomic, stats use atomic_long_inc, and dst_cache is per-CPU. GRETAP,
the sibling device with identical xmit structure, already sets lltx.

Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
v3:
  - add fix for IPv6

v2:
  - change subject prefix to [PATCH net]

 net/ipv4/ip_gre.c  | 2 ++
 net/ipv6/ip6_gre.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 0ba1e94e9012..8c5ad8ec8d09 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1363,6 +1363,8 @@ static int erspan_tunnel_init(struct net_device *dev)
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
+	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
+	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b843116e9b70..143166e3e586 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1870,6 +1870,8 @@ static int ip6erspan_tap_init(struct net_device *dev)
 		dev->mtu -= 8;
 
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
+	dev->lltx = true;
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
-- 
2.43.0

