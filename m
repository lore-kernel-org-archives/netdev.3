Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076093EB102;
	Wed, 16 Sep 2026 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789539262; cv=none; b=G9EFiW9nHxcpr0L05fohtuXEpzyV9QX1j8ijugAk++u3qNyS/pxWQi2SzFbSf0ADLErUTUZZHjQ7foWVIRhThDRgEZAchvPk/iPU91C9qgHFZKR5NWuljvGOZv++k4ySNRlfNj/0F/VSNlBe+I9vTBF7i0/eSMG2MjavF91of2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789539262; c=relaxed/simple;
	bh=RNDR+sG9zdyOQJx9RySBjdia4ulkJqhiwv+War1tASA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DoFFc1DJmPczBrKeT1y1XBUksz2x7AdGnAs5jdsRk+7gkPVfhgd8OoXgS2gex5ZB64FfDgSSU9Jn2OB467w8kr7iOQGstjuOjSO5m/7iBFQk0X0qT+8Amx83Jbl/NFJrzJ2TEnaVuQrAb+K5YF1f6vvXv10RKhQ05EUe1Krg0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=GVvDzbgj; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="GVvDzbgj"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G5Sk821057722;
	Tue, 15 Sep 2026 23:13:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ntuxtt4gG
	nsVBcAFXGQ8aJAjQcFLPsUHiO457fHN7yQ=; b=GVvDzbgjNC7e361CndqOSFoyj
	v9iSSS0ypsM4Np/+ikjd5RJCO48TUmfxPriFtGZejwdJMIbx9tdIXM3zRe+Y9EhD
	MJNQtNtQteKOcwaRR5CTN/3cRS8iuib/JUM/ghCrI391JWTROUojhlFz6KJAx5KF
	kR0CGVYAHLR8d9GXoqZzrC4TLcPyYkWeS3tA1ZGGt2fQIcgZoHF9DlzWUZlF/ZOz
	FWSlBHCN/vSmnQWfP/8gV2K4DiUbAZNfYXh5qqtEAJpnp2bdVnnats1ZfVl7h0tK
	JbMYCT1xL30gU2U5xOaNDDej7Ne4DLAvFadC9j1OwXevYLicpG/YwAXoOoCrw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4gn68g6m8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 15 Sep 2026 23:13:19 -0700 (PDT)
Received: from ala-p2exch02.corp.ad.wrs.com (10.11.226.102) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 15 Sep 2026 23:13:18 -0700
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-p2exch02.corp.ad.wrs.com (10.11.226.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.46; Tue, 15 Sep 2026 23:13:17 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 15 Sep 2026 23:13:15 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <dsahern@kernel.org>, <idosch@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH net v4] net: erspan: set lltx to avoid sch_direct_xmit deadlock
Date: Wed, 16 Sep 2026 14:13:14 +0800
Message-ID: <20260916061314.936440-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qI3tRm4fj95qIaLf_a0UpMKMdUZHWkDI
X-Authority-Analysis: v=2.4 cv=cswOAF4i c=1 sm=1 tr=0 ts=6aaa337f cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=ADlydbMj1Wbzk9vhUvkA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: qI3tRm4fj95qIaLf_a0UpMKMdUZHWkDI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA3NyBTYWx0ZWRfX1nhFubCE8mRf
 Y7De/Pej6mrLcy62RbQ1eXdX2lXqerlZwMc23WLxb/m00qUjZY4zCTwj9JlwWkPiqOoD13Apyoh
 Wksob0rxhC1CrKtO+p1HkprVQE8H8mQUXepAkbmoH67R947S60hn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA3NyBTYWx0ZWRfXwpWP0mFr1Jkh
 szBzAYBL8j09ZbJY6ZVI8lNXlkQRVkAQfFTE4nyHHt3uMGiJhCqnH10Gai5YA41yJQS2DVRfyct
 2ldhopLKoCoFoR27lR6aXpfurE/rCgxXFTDNav7vfr2dHBqMvnfpdG+kVDJpfYXGSPsV6ypuzM9
 oFjmJC94b0/8jHvsZaxdO63i54KYAenAjOZlyfbSmw5z/xY+N++4eMgQkAtNMQIpLBVYKw3uIKQ
 oshqHdOoWp4Me2pVRX4IszEkIAvAmpmfdxXkfL5TJqI0cRJTah03oYHmb2erq9VRmBJLayZ56BJ
 oPDBAsOM0pUHJqt7+rZf5fJdLfFQFKS3iuCbD41tlW89t2zB17qxvZSqfiWXOsAuwpMp5qHM1IP
 NShQpdKDfZdA0cV81FESWMuvvYNVvm6sEhnT3zg6s4e2HlP7UHjelYgR6YUYqNBJnkjU9x0zWWZ
 j2dedA2qZRvIBUJiyew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160077

erspan_xmit() re-enters the network stack via ip_tunnel_xmit(), causing
nested acquisition of _xmit_lock on the underlay device while already
holding the ERSPAN device's _xmit_lock, creating an ABBA deadlock:

  sch_direct_xmit [lock erspan] -> erspan_xmit -> ip_tunnel_xmit ->
  ip_output -> __dev_queue_xmit -> sch_direct_xmit [lock underlay]

Set dev->lltx = true so HARD_TX_LOCK() skips the spinlock for ERSPAN.
This is safe as erspan_xmit() has no shared mutable state: o_seqno is
atomic, TX stats are per-CPU u64_stats, dst_cache is per-CPU, and
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
index 82309efd417e..0058cb20e36a 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1367,6 +1367,8 @@ static int erspan_tunnel_init(struct net_device *dev)
 	dev->features		|= GRE_FEATURES;
 	dev->hw_features	|= GRE_FEATURES;
 	dev->priv_flags		|= IFF_LIVE_ADDR_CHANGE;
+	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
+	dev->lltx = true;
 	netif_keep_dst(dev);
 
 	return ip_tunnel_init(dev);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 8ebda0b6a78b..578fb3475f8c 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1871,6 +1871,8 @@ static int ip6erspan_tap_init(struct net_device *dev)
 		dev->mtu -= 8;
 
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	/* Skip TX lock: xmit re-enters stack, risking ABBA with underlay */
+	dev->lltx = true;
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
-- 
2.43.0

