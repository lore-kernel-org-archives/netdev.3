Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF147ECD8;
	Thu, 20 Aug 2026 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246616; cv=none; b=VEdGM9jbYlplrZpbMIdPlwQf06ybi42wGgp1fIMXSncDdci6zGEX7/JgNHFrf0qaSGtwPLwW8drNLOCKFEdWeel4hCwT0U45kx4cyax7UJjMqq9Ee2jmeu4l/khjgR3X5v75zylc7hePF4RkYE+jMZiugffUm+yMCpKbMltKkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246616; c=relaxed/simple;
	bh=cwsKtQ+m0+cW4baO1y8ONp6n/xPdyTmjJPD5j+hOm2U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tk8am/GzHzq7VgdJjiBYRyNztQOboUDW5fVIdw5fE4YlEhWVzK2KHUHdAfXp4W/k2U+mHS0tWfNh+NQvLzBScY3X8R+fKFhvRM6dYzBhgEkN97nFTRMzsD3Tz7+0riiMwhDPfQ5O4+loX3bFcJmq93+X5PdPzTkjiglHJAHgc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RsFX6MKO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RsFX6MKO"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KGGZnN2415133;
	Thu, 20 Aug 2026 10:23:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=kkaPLeW92IeNZVnLVcg0Bq9
	6k1olQCefj032Su0i+NU=; b=RsFX6MKOFhFJEboOeDqmsEGFKcnHhTZLpno+bDM
	ZO8PkqyRof5FnDzMaDmNkZSc7Xvwk/+KostbDEpth/kCH5SMfB1Q0uT0Dmih0LLD
	TdALIDWWWdVmeqZFisPX8wEFDMw+GfTqtOOa7R/IY1G/3sYDHSyfhbYA0xEtsZFL
	MdwqrK61G2UUgdydI1M+wzuNiSghbefdLyhrS5eXwBnOibh9dB23/g+Y6lKnQf2j
	MK8HK7CgnD9ZGx+OEsGhKaPHXrjK88LT9Tw7K8hVeZqu7pTl4qS0ZNw27MrOO84B
	E8FVd3kEKLjAUcLkLdy0tZWYIiEfsAe5fSdp2IIHsYHJmIA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g602esybx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 10:23:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Aug 2026 10:23:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Aug 2026 10:23:12 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 18AC43F7053;
	Thu, 20 Aug 2026 10:23:07 -0700 (PDT)
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
Subject: [PATCH net] octeontx2-pf: Fix ethtool timestamping capabilities for SDP representors
Date: Thu, 20 Aug 2026 22:52:53 +0530
Message-ID: <20260820172253.2010182-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Swuvqr5m3sGbM3INjcvD1KeC6qZW4fNM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEzMSBTYWx0ZWRfXwir+aEb06Ruv
 CCUQSWos02fgDRSNP+sSWmQRgCthCkTtNyHrJ2ioG4ClAoKOPtqo7DIqYZyXGGUvelrBkw2gUvp
 SlJ/DCK/6KrWtpnE4u5iAFZjAQtga/meZQZrtuNStc3zPKM3IgCeLnZtyihUqDd+7A9CrpyLCWK
 F47izjmsI44pWA0y15g4opWEM5DNg9TQ2vh3Qltfpl4UTV59eiIdIaNUo+wuJibW80+pZ0KDabl
 zQqsLrRGZgnz2nm+gOMcLNhqyWLV6WjvaI8QnZMSq9PfDEo1OYRUYjENHf75wYTezNPG0mHVZMP
 sJf4LgphM3nZRW32hjZVA0tvWRlrNUJg+7F+L5IgMunCDwpuPdWu7QWT5tOtpfvU5OsOYPEYxPe
 RCvgMzzKH6tDS9uSxXgy1fNxC72HH7Da2LsJcKNlKDMA9nBMaZMGldczCw42hHYtbqHEDg84z7+
 ZIEjAfZZFkH5ckpxxOw==
X-Authority-Analysis: v=2.4 cv=NNvlPU6g c=1 sm=1 tr=0 ts=6a873801 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=uyw0fmahrVPj6f5YuYcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEzMSBTYWx0ZWRfX6+qtvOJAJgWr
 9ZXfm2vLYW+EhkODax1aN1/2m0detp+EDNhYpH59Y/EIEZAA6CMcxNxlLGBWsWul1EZW5gfAQpV
 VMk5akDWvqiWgb9PAEcTwgY/iULRLRs=
X-Proofpoint-GUID: Swuvqr5m3sGbM3INjcvD1KeC6qZW4fNM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01

From: Roy Franz <rfranz@marvell.com>

SDP representors do not support hardware timestamping. The current
implementation of otx2_get_ts_info incorrectly advertises hardware
timestamping capabilities and a PHC index to userspace for these
interfaces.

Fix this by checking if the device is an SDP representor and returning
the default software timestamping capabilities instead.

Fixes: 2f7f33a09516 ("octeontx2-pf: Add representors for sdp MAC")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Roy Franz <rfranz@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index a0340f3422bf..f7a2202c4a3e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -978,7 +978,7 @@ static int otx2_get_ts_info(struct net_device *netdev,
 {
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 
-	if (!pfvf->ptp)
+	if (!pfvf->ptp || is_otx2_sdp_rep(pfvf->pdev))
 		return ethtool_op_get_ts_info(netdev, info);
 
 	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
-- 
2.48.1

