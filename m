Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1EB41D20E;
	Thu,  8 Oct 2026 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452348; cv=none; b=VtATAp2Hkmh1GGN1v40/PpEWKqjowulPfyNnCb9xaT9xmPgZcLkvZ+EaERstyd40CwkVpADLc9WDrdvTlGKsJMGBPeu58LjrD5/ftMcKK+RuUipLrGUjQldyT2dOW3i6BfoxKsUkfZVgRP5MmOWrpbnqlYO/Mg00q1+GB3z9PKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452348; c=relaxed/simple;
	bh=JWFUKYrLgQ6dq9l/y0c7tgWopS/+KUXEmCswNnlI3cY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s2toQY6Iup01+/7XMTQW2jy9ZhDzRSij1rNLQuZLXVBnVlxW60s+6WJz9PtSK1KkNWqD2cNdCtLDlocCT6isjpi9l9He/eQ/QFWuIdAI8tfv8NJW7HeEFiONjiWkOB1c+Wf9M5QEQ09uA2DdAjyXsuYWUjd1dXRx4w2pY92CfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Fjeey1JA; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Fjeey1JA"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987LUd62735077;
	Thu, 8 Oct 2026 09:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=csVWkH2lG
	rKcfNkbNQtuol3DZFG+gs5X8j6BXyrn5No=; b=Fjeey1JAJN6+M9h7yrk5U9UeA
	h9LDGipWVKti0Ox07D23Ok+3v/Ytqa2wdk2oGvmD7k8skPgzPFody53UnUXwIIAa
	rqUj5u9TCIAcIC/VOydrqGqYIw2iahoKi3kKL5pWTdGDmDckWogYSb2vcm0c54MV
	SUQBTjZL4repL2Bs1QjU/oZ8Km0Z8PRP15sV4cbFn0FIOWnq70gnhYpDsxDsfNJu
	XGFiBOGO+pC2H63gS4o27G4q/zeZ/ant0Cs4bSJkrD8ANmcW7FNWCS/EkDSbXlfG
	hzxx/QjiWLklFubSRziuVq9ZEn0xW4Z6+dz/s9NLnO6pLcEt+SI+5J9srHmDw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4h5xemgm43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 08 Oct 2026 09:38:29 +0000 (GMT)
Received: from ala-p2exch02.corp.ad.wrs.com (10.11.226.102) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 8 Oct 2026 02:38:27 -0700
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-p2exch02.corp.ad.wrs.com (10.11.226.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.46; Thu, 8 Oct 2026 02:38:26 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 8 Oct 2026 02:38:24 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH net v5] net: erspan: set lltx to avoid sch_direct_xmit deadlock
Date: Thu, 8 Oct 2026 17:38:24 +0800
Message-ID: <20261008093824.119453-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5KPNk-jzKRVwiGJe_SXcmyvFvlYXgGDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX8sjXPfx9KwfJ
 Gw9RO421usUxU31IHQAwbnJ/O8JhgKDPIXAkqD6B3mlFHNBjFwvwlofLtrsDtP039lBB7uMaZZU
 ogB4UyE7+ijpeZUgeNXFnxot8O2pIuDuacaQdEcOx4xy3ZeLg6ts22pbxtC8NZetWqeA3VqGSks
 aZUE7rjErdcrcySeGYcymvsSfsuJCjexGV2RKStXTrEknjlEcQq/dbyA0o+PYbG75cJtG6lbbjB
 q49s273wYiF/PIarGXXCcrku8wQ/LiAl+w0k50FVQn8L03ju65VnBUL6vr/8he6m0zt/OtNYWW3
 P2+hBuJIdujHHqVLcdsSDm0IScD+1GH3gNGFP72kcWR+z44sFWwJZKocFLTlpkxZsJaVyCdsvfK
 Bndv1jMXZKu7qSijBjRQmMe1WXAVtrsND8SyMg4iB2UmF+oBb0O//Lln21tFU+LMJTMSOUaHe+v
 VQ+tNGyLjkBRl+qaKwA==
X-Authority-Analysis: v=2.4 cv=I6vw19gg c=1 sm=1 tr=0 ts=6ac76495 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=zwNXk_Rqs_FK0udf33wA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX/rHyUm1M3TMW
 tpw39XXlakYtLvIxjN6Q5eUm7hoHHR05W6QoPRGUgGQnJpwVasMtWgwfEsTlKmIeD/jQAqmOxFW
 wo3rb4T3P7Zmb31P97kWI+tkintKqWPzhNFvdAO95e1ix3ZByK1S
X-Proofpoint-ORIG-GUID: 5KPNk-jzKRVwiGJe_SXcmyvFvlYXgGDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080038

The ERSPAN xmit path re-enters the network stack, causing nested
acquisition of _xmit_lock on the underlay device while already holding
the ERSPAN device's _xmit_lock, creating an ABBA deadlock. This happens
for both IPv4 ERSPAN (erspan_xmit() -> ip_tunnel_xmit()) and IPv6 ERSPAN
(ip6erspan_tunnel_xmit() -> ip6_tnl_xmit()):

  sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
  ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

  sch_direct_xmit [lock erspan] -> ip6erspan_tunnel_xmit -> ip6_tnl_xmit ->
  ip6_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
This is safe as the ERSPAN xmit path has no shared mutable state: o_seqno
is atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
o_flags is no longer modified in the xmit path since commit 9958e69b9893
("gre: fix ERSPAN o_flags race/corruption in xmit and fill_info").
GRETAP, the sibling device with identical xmit structure, already sets
lltx.

Reported-by: syzbot+9bda1b9fbb7fbdf9b62b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9bda1b9fbb7fbdf9b62b
Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Cc: stable@vger.kernel.org
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
Note for stable maintainers:
This patch depends on commit 9958e69b9893 ("gre: fix ERSPAN o_flags
race/corruption in xmit and fill_info"), which moves the o_flags
read-modify-write in erspan_xmit() / ip6erspan_tunnel_xmit() onto a
local copy.

v5:
  - describe both the IPv4 and IPv6 ERSPAN xmit paths in the commit message
  - drop the inline comments, keep only dev->lltx = true

v4:
  - refine commit message

v3:
  - add fix for IPv6

v2:
  - change subject prefix to [PATCH net]

 net/ipv4/ip_gre.c  | 2 ++
 net/ipv6/ip6_gre.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 82309efd417e..38a24a659fcc 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1367,6 +1367,7 @@ static int erspan_tunnel_init(struct net_device *dev)
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
+	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 8ebda0b6a78b..82957e4fedd2 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1871,6 +1871,7 @@ static int ip6erspan_tap_init(struct net_device *dev)
 		dev->mtu -= 8;
 
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	dev->lltx = true;
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
-- 
2.43.0

