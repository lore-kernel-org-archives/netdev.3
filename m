Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84B54785;
	Mon,  7 Sep 2026 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788751421; cv=none; b=WQSjGdqroaMM2+ifYV8y4YMEcUxdsJtdhNBJ60C6SFRacflFMGZOQqDEbh0NtITma9JdxAwXcB1dlwBdaTacTvudtrOVgcJCvikT0z+H4E/wg9MSKKZCvShV2JK5Bu691mPiaIrgDiJIy9ABEzxZEJ/bfVPvJFTKlJu0EcxUv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788751421; c=relaxed/simple;
	bh=Oitk1m4U38ciihxS1JSZ68zljp2pdZEmojp72clRub0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FZLaNa5ALw9tNmXnFN2koE6xnUVuDp424IphmP+lbvYxLUF5Tr/Qvung+JsdFIZq2mi6FmS1fqHm9lk5Z64vO5Mlq2BXU7PyECDyJ2IQcm6wE7G1t6BBby2vEF4Ha+BlBwPWWw3tfflkAUugPAhZ9tfCrAOE+GCEiI+7O1LBDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HPW5mlZO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HPW5mlZO"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6870FgwT1549735;
	Sun, 6 Sep 2026 20:23:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=D8pujKDeUlwxxN7LuYJnjBx
	KAxF4ovJ5i5yrNLkZUBg=; b=HPW5mlZO+7J6oefO6WgqbxX0XNVSi+7HrVZUxIw
	s+yKs8bh6A3Sd9Ya+9zB+vzhT9rnt8JWSKRexlAG3IthcSeDRCFKUcKq2xDsve0M
	NC+pFidXQUB3/cpQ4Usz91p+MwfHxl/rmQ0WRLwH+4mWshdUQcDpjAbxYAyrtVRc
	yrzfU/Es4NM2dxSujS2SVDj0Tf1hke1FFsGorMu+7GqQ63nCmg4YFZE8Gf+MPeA2
	o/15o1OE8N61Jt/cn6PY+AWboYFk0d0XkLIUp7lUQLISIAH83gAqlVeYhVRPx4Br
	GMWgr2O1XcT046fWr7E/Z9lP2Dl5yjEtbSpsPodGcFLvRfA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gggem39gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Sep 2026 20:23:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 6 Sep 2026 20:23:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 6 Sep 2026 20:23:22 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id C2B023F70A1;
	Sun,  6 Sep 2026 20:23:17 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Roy Franz <rfranz@marvell.com>, Nitin Shetty J <nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Subbaraya Sundeep
	<sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Simon Horman
	<horms@kernel.org>
Subject: [PATCH net v3] octeontx2-pf: Fix ethtool timestamping capabilities for SDP representors
Date: Mon, 7 Sep 2026 08:53:11 +0530
Message-ID: <20260907032311.3228168-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lzMNmK38U6xU16MzzH4uNEqSf3vuakZ2
X-Proofpoint-GUID: lzMNmK38U6xU16MzzH4uNEqSf3vuakZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDAzMiBTYWx0ZWRfX6gzYHm6gs2qm
 0UzRVUL+KoAWBIYYV7+blg2IC0bEFgTNUlbSnynt+DVB9Nhhb53w2FSN0tZJRTYE8XCINdp+Lm6
 lMkWKG161fCGghFLxGtj7RpsgsU9/Gy2fxLF3VU0HNiftA99RIguY6TO7nwNe4WltozvR/lp6vY
 YIvGjbSguCFaqYQVEcdIZ6UtjJVqY/ehGjjZwtHXg5dz2wk9+uO2533jdf+/I8BAURA5BywHS++
 +QVS7lBCDdM3ZjV8ef7/qrCZwAwM/K8YJGann7vswLDw3ceUiiS3ErLYPHLbEpFQnJrJjeqXsnh
 iti7VUhOVPVdQUc6isK4TPp5FJnWEZ54mg3naTGk13JdtpDHex/+mMtZc2ITBhiOf9/LK3Bq39n
 K2Byz7OGiIa7UJNvKl8Zf4ZX78GBz+IPygUmjTolJXxWnUM08ChkPKU3mL5CDzf8VR+2/xcPbQY
 PjAgTA1Elmuv3FJfkNQ==
X-Authority-Analysis: v=2.4 cv=DIe/JSNb c=1 sm=1 tr=0 ts=6a9e2e2b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=NdNGLfErlwAa1tt2dosA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDAzMiBTYWx0ZWRfX8U7jv7ouDCbA
 wjLJWcVP7HXHsIg4wejgY7WpQhLDYqbjApFFsBIrlVPQy+DugYF6K+/nKBvaWQFdRyWicGMAHpE
 62kuqdaw6vfgBVjr0tsr6OfG4pCC0I4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_04,2026-09-03_01,2025-10-01_01

From: Roy Franz <rfranz@marvell.com>

SDP representors do not support hardware timestamping. Fix this by
skipping PTP initialization for SDP representors in otx2_ptp_init(),
similar to how it is already skipped for LBK VFs. This ensures
otx2_get_ts_info() reports only software timestamping capabilities
to userspace.

Also fix otx2_config_hwtstamp_set() to return -EOPNOTSUPP with a
descriptive error message when PTP is not available, and add null
checks for pfvf->ptp and sq->timestamps in otx2_set_txtstamp() to
avoid a potential NULL dereference.

Fixes: 2f7f33a09516 ("octeontx2-pf: Add representors for sdp MAC")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Roy Franz <rfranz@marvell.com>
---
v3:
- In otx2_config_hwtstamp_set(), replace -ENODEV with -EOPNOTSUPP and
  add NL_SET_ERR_MSG_MOD() to provide a descriptive extack error message
  when pfvf->ptp is NULL (hardware timestamping not supported).
- In otx2_set_txtstamp(), add guards for pfvf->ptp and sq->timestamps
  being non-NULL before entering the hardware TX timestamp path, preventing
  a potential NULL pointer dereference on interfaces without PTP support.

v2:
- Disable PTP initialization for SDP representors to cover both
  ethtool capabilities and hwtstamp ioctl handling.
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 7 +++++--
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c  | 2 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c0e2100de1d9..b231f5c6b23f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2532,8 +2532,11 @@ int otx2_config_hwtstamp_set(struct net_device *netdev,
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 
-	if (!pfvf->ptp)
-		return -ENODEV;
+	if (!pfvf->ptp) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Hardware timestamping is not supported");
+		return -EOPNOTSUPP;
+	}
 
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
index 95b0a1e7c936..7b0a51f453ce 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
@@ -386,7 +386,7 @@ int otx2_ptp_init(struct otx2_nic *pfvf)
 	struct ptp_req *req;
 	int err;
 
-	if (is_otx2_lbkvf(pfvf->pdev)) {
+	if (is_otx2_lbkvf(pfvf->pdev) || is_otx2_sdp_rep(pfvf->pdev)) {
 		pfvf->ptp = NULL;
 		return 0;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 8d2d607bc92f..94da021d452e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1135,7 +1135,8 @@ static void otx2_set_txtstamp(struct otx2_nic *pfvf, struct sk_buff *skb,
 	__wsum skb_csum;
 	u64 iova;
 
-	if (unlikely(!skb_shinfo(skb)->gso_size &&
+	if (unlikely(pfvf->ptp && sq->timestamps &&
+		     !skb_shinfo(skb)->gso_size &&
 		     (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))) {
 		if (unlikely(pfvf->flags & OTX2_FLAG_PTP_ONESTEP_SYNC &&
 			     otx2_ptp_is_sync(skb, &ptp_offset, &udp_csum_crt))) {
-- 
2.48.1

