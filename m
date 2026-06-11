Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7526F212548;
	Thu, 11 Jun 2026 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143817; cv=none; b=Y3RedUaodwdCVfg+d/4rTPhn8DKcIfZchPO2ypgLP2svfCd2IvWFit1uYBK5E5FVHf/N0R3/GqhdUAYGF+5kBZlBHI13/0hhrNWOIJoY8i5eJLu2kmmB9su9+53rcb0Yj95HTivFRt5jaoklnOedC4yezRpRzIGFHoXD0sUeuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143817; c=relaxed/simple;
	bh=3u0uePHG657GZkDSDJlLqAjiR6FEg2432iwPZ0hfm4o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kCI/X6zrPOqc1GUKaTBKdDXjt3y45Lgp9s+WTX/93MIqMSr0NmPZY/IXPhhjqs/Vom3guJTFltt+8hpSfh0vmZoIwuS6Qz8pzNUSmUXGlJFfTyN2oRVhG2D3EaJtkAiqjbrB5jEUWoNP+F3cyvwjgvsG0BUsUhitwvHwJj3OT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XFsma1Bl; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XFsma1Bl"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B0wC4C1997295;
	Thu, 11 Jun 2026 02:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=JmIgl9b7k
	jvlIgIXTBzDAmk/QoVsJy1DjIZQim1COdk=; b=XFsma1BlPmMuM/onhHv/OKi6G
	rbSZp3fjkktRZLkCUNA5PJ9kBLfp7ZLiYl4zKfoXV3Me5QbDImj6ccZ4fPxzYqGj
	p1aPv6otNEr0F2yWRKkKrAitmaYuVWaXup8Gdl7WmtFuNYP2bA1UAPfnc8s2v6op
	BvTa8I4MR7DqpqJowOwTjNdO/yo9IRB25xAj9t4j8G1n2JWEGbzmcu6HuuxaHRmI
	pAkVaSRU44pvOeL1rtmXgk3JEkqJjO1VmGqwtIDhMZi2392Gla2hZHpG/gVhBxC9
	hhFBbpnlYmwKUZfy1+6JncS3Cu/h43CZ1T0XIgnwbb7P4QFCYH4S6BrEYR+BQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eqe7egdkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 11 Jun 2026 02:09:39 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 10 Jun 2026 19:09:38 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 10 Jun 2026 19:09:36 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yun.zhou@windriver.com>
Subject: [PATCH] net: mvneta_bm: add suspend/resume to prevent crash after resume
Date: Thu, 11 Jun 2026 10:09:35 +0800
Message-ID: <20260611020935.1933865-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TW0G3DwtW3T_2TkrusrsrSV7vqCBzVRC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAxOCBTYWx0ZWRfX3TJzcWj0LZB/
 G0qdOFYX2FFjU8rkIxrIhs4DLcq7mmk6ab7FqoSIiF9GY5QDKhT4Feg8nLoRlM7GdNNdgP1V9kb
 h/+VnlB4RWJLJP9atsON/eRdfri5eVDyjvqtvDIODC3DWD0DtWWzQzdHmTsimM3wxqxK3hOqIsp
 /CPTDmdgczqdr0J6QSK/QE+PWb9aYcyltXDJ7LSDL/8ltaQ9wTc8X/rUl+fZZb3Hc0Um+bRX5Ls
 zQCoUo8ST5uF8BNYl+gjIQI1xneJENK3qE7JXR6VyYBmDrsWhz5i0WzGY/876gXVbeFjllu7iw4
 2rw7SGqGIVzqVVNwGWC9VPOpmpfFgG6VMzWjmJR3W/LaJGjI/qiMMwMhdPb4/WW5t9zIyqF+MVf
 MOyQioqC/E5dYOKu3KPOrM/HtusgF5jVPZ1IGeuZye89gAQoZ1gw5ZvNz95rXu4ZyKVe558a5Js
 LdarhADLqPiU9AqAn+A==
X-Authority-Analysis: v=2.4 cv=cN/QdFeN c=1 sm=1 tr=0 ts=6a2a18e3 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=f1RklR2ecivHCchGhFoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAxOCBTYWx0ZWRfX2iwzng8yB2o6
 kFRKRxN9X3TBX+viwZ+bPFlR8gK37tneUxazTL5mfSRgRLem/mV9k4+di9EFlCyTeA9sKY9iUyP
 L2PehaSBU5wHXVeXSCk9gFgJ4E2zooiQybUYElU9HNQEEvvm0Een
X-Proofpoint-GUID: TW0G3DwtW3T_2TkrusrsrSV7vqCBzVRC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110018

The mvneta driver uses the hardware Buffer Manager (BM) for RX buffer
allocation. During suspend, mvneta disables its clock, causing BM to
lose all buffer address state. On resume, mvneta_bm_port_init() re-
attaches the BM pool to the NIC, but BM hardware returns stale/garbage
buffer addresses. When NAPI poll processes these buffers, DMA cache
sync hits an invalid virtual address causing a kernel panic:

  Unable to handle kernel paging request at virtual address b0000080
  PC is at v7_dma_inv_range
  Call trace:
   v7_dma_inv_range from arch_sync_dma_for_cpu+0x94/0x158
   arch_sync_dma_for_cpu from __dma_sync_single_for_cpu+0xc4/0x15c
   __dma_sync_single_for_cpu from mvneta_rx_swbm+0x6c8/0xf48
   mvneta_rx_swbm from mvneta_poll+0x6fc/0x70c
   mvneta_poll from __napi_poll.constprop.0+0x2c/0x1e0
   __napi_poll.constprop.0 from net_rx_action+0x160/0x2c4
   net_rx_action from handle_softirqs+0xd8/0x2b8
   handle_softirqs from run_ksoftirqd+0x30/0x94
   run_ksoftirqd from smpboot_thread_fn+0x100/0x204
   smpboot_thread_fn from kthread+0xf4/0x110
   kthread from ret_from_fork+0x14/0x28

Fix by adding suspend/resume callbacks to the BM driver:
- suspend: stop BM unit and disable clock
- resume: enable clock, reinitialize BM defaults and restart pools

Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 drivers/net/ethernet/marvell/mvneta_bm.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 6bb380494919..a0800b99c007 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -477,6 +477,30 @@ static void mvneta_bm_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mvneta_bm_suspend(struct device *dev)
+{
+	struct mvneta_bm *priv = dev_get_drvdata(dev);
+
+	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_STOP_MASK);
+	clk_disable_unprepare(priv->clk);
+	return 0;
+}
+
+static int mvneta_bm_resume(struct device *dev)
+{
+	struct mvneta_bm *priv = dev_get_drvdata(dev);
+
+	clk_prepare_enable(priv->clk);
+	mdelay(1);
+	mvneta_bm_default_set(priv);
+	mvneta_bm_pools_init(priv);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mvneta_bm_pm_ops, mvneta_bm_suspend, mvneta_bm_resume);
+
 static const struct of_device_id mvneta_bm_match[] = {
 	{ .compatible = "marvell,armada-380-neta-bm" },
 	{ }
@@ -489,6 +513,7 @@ static struct platform_driver mvneta_bm_driver = {
 	.driver = {
 		.name = MVNETA_BM_DRIVER_NAME,
 		.of_match_table = mvneta_bm_match,
+		.pm = &mvneta_bm_pm_ops,
 	},
 };
 
-- 
2.43.0

