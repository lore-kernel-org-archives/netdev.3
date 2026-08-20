Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA204339398;
	Thu, 20 Aug 2026 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787215020; cv=none; b=CN/mRMmVY0T27fUTNEXZYez2vKCKNUTRZWL8d1FREljajQdceJ2csVJXhZjVkA02Q1aYrXdFzQnmdaFKC0S1IFn7t7J5+QUdPKltDziYcmD19lbkHlrUYoN8WznHqPucreFEDy5W6XsupGN+ZS1NXX5wllPXhCf406CN2QWecxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787215020; c=relaxed/simple;
	bh=7eytI4yX8yMn1CWTJ9shmCsF0txTNe1CbIBhtmGz8jo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AWHllpANOiyJHZviUV1N6az+86oLvDAmuUQQ6pMw09TSgMlM7S9Jmqbm9teNsUY3cLgZhf9I8IU7D7QX8HCV0hqQwnVSGV+rdx8zghIdS+9TgpaRDs2VU9BcqQ3WXSix4nB+YwFgGnrkGMAhsfw2mSaUmgIgoSD57P9IrNqxyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EbauOuaZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="EbauOuaZ"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K6ckDP1176072;
	Thu, 20 Aug 2026 01:36:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=RvttJWDyCJhvTLufhP1gnRu
	ztSjOtC0Of4OeqqAO2Fg=; b=EbauOuaZ0BZBLrjFNeb3bspDFTH9xfH+bH0mQiF
	ZwaHK5m6dwkxMEQYAN3teR1ukDYratk0X8McOAnR35lMkcYIGGvcZOqO2iaPT0FT
	lSxmczYOfRbYSXuQsJa7UgymtfBUQNT53Np5xnjsf+XvLpP7SqttxN7+CUYrY6bt
	ZIoUvA5pPZnIqGqbgMztrX+tC9EMyYyLDtUvoM4XtK6VVwwJ4ul/Pt8FaOQekV7a
	j8iOQM6cGZvoGAYLQy4lx1VR55nbjMPgAlqNIu7Cdhe7xtHn/P8bCvwx9TiBFnoA
	m01tqbA+BAhwhz0WoGAuc2YDaLt84gjfJTfXkq4LwljYZig==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g5vg508ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 01:36:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 20 Aug 2026 01:36:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 20 Aug 2026 01:36:42 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id D34813F707E;
	Thu, 20 Aug 2026 01:36:37 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Anshumali Gaur <agaur@marvell.com>, Nitin Shetty J <nshettyj@marvell.com>,
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
        Naveen Mamindlapalli <naveenm@marvell.com>,
        "Sunil
 Kovvuri Goutham" <Sunil.Goutham@marvell.com>
Subject: [PATCH net] octeontx2-vf: fix workqueue and netdev race in probe/remove
Date: Thu, 20 Aug 2026 14:06:34 +0530
Message-ID: <20260820083634.1641740-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA2MSBTYWx0ZWRfX5MaV1mFIjH9p
 pDiBGFrXEDB9PsvL7uXfpr8xkvtfLlJg5B2BqyY9BRofvoxuB4eedLEQ1z8SER2jl+Os1oaM7gw
 Ev5XOELxCeUaxZ/Cg5cCZ4x+O3MhcxOwiMCTmyrtDsLo5RN/VPTbhRrfVxN5TktF80r4yMmUzdc
 DxDOQUPKryAKHYcbTo4TXZPn818xlrWxrPibamARB2vBpyrlkBiuEPzZxfOg4pAtVC4ocnJ8z+k
 STW/PXUi1+hToQww13qwQKwCKgRsM+OYPrQmRkc4hnQrT52yo6fGad2ibSAdBVzrd+9sSP/bpvg
 y+Fi215dxKAzjNzAZbBml5rd1S+pM7nc0yw1zegtCnfhzk4RiRfz85rRyTENozeE1sxArytGTmE
 GxFRUiFvmKphfOkIJMKfExRtGAA2n7O6g+Z5Pmo4k/wYbu5Cc4DjN3X70Rl+2sZ6HVrKEp8lmtJ
 kmrigNZvYGK6MUKW4Cg==
X-Proofpoint-GUID: XVYQXM27iaDafybm5Gt4oCZuUzuzE3x8
X-Authority-Analysis: v=2.4 cv=B7qJFutM c=1 sm=1 tr=0 ts=6a86bc9b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=VRz9UsUYjh-wbl8M3HoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA2MSBTYWx0ZWRfX16kUNjRDYVzH
 IG8h6JIF6ml2Bh+cgBlgpNLaD1WhSBY87Kiyt3SBpgGm3HrTMaYTAeA9Ru3VUIxyuEUBt2lOhEf
 es0eksRgkVjlVVtLa3okVbF8myoHMwU=
X-Proofpoint-ORIG-GUID: XVYQXM27iaDafybm5Gt4oCZuUzuzE3x8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01

From: Anshumali Gaur <agaur@marvell.com>

Initialize the VF workqueue before register_netdev() so ndo_set_rx_mode
does not queue work on a NULL workqueue. Unregister the netdev before
destroying the workqueue, and add proper probe error cleanup.

Fixes: cbc100aa2205 ("octeontx2-nicvf: add ndo_set_rx_mode support for multicast & promisc")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index b022f52c6845..fcdf891f90b5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -737,16 +737,16 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (err)
 		goto err_ptp_destroy;
 
+	err = otx2_vf_wq_init(vf);
+	if (err)
+		goto err_ipsec_clean;
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(dev, "Failed to register netdevice\n");
-		goto err_ipsec_clean;
+		goto err_wq_destroy;
 	}
 
-	err = otx2_vf_wq_init(vf);
-	if (err)
-		goto err_unreg_netdev;
-
 	otx2vf_set_ethtool_ops(netdev);
 
 	err = otx2vf_mcam_flow_init(vf);
@@ -789,6 +789,10 @@ static int otx2vf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	otx2_shutdown_tc(vf);
 err_unreg_netdev:
 	unregister_netdev(netdev);
+err_wq_destroy:
+	cancel_work_sync(&vf->reset_task);
+	cancel_work_sync(&vf->rx_mode_work);
+	destroy_workqueue(vf->otx2_wq);
 err_ipsec_clean:
 	cn10k_ipsec_clean(vf);
 err_ptp_destroy:
@@ -836,11 +840,13 @@ static void otx2vf_remove(struct pci_dev *pdev)
 	}
 #endif
 
-	cancel_work_sync(&vf->reset_task);
 	otx2_unregister_dl(vf);
 	unregister_netdev(netdev);
-	if (vf->otx2_wq)
+	if (vf->otx2_wq) {
+		cancel_work_sync(&vf->reset_task);
+		cancel_work_sync(&vf->rx_mode_work);
 		destroy_workqueue(vf->otx2_wq);
+	}
 	cn10k_ipsec_clean(vf);
 	otx2_ptp_destroy(vf);
 	otx2_mcam_flow_del(vf);
-- 
2.48.1

