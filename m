Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD71364058
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094368; cv=none; b=f2IrzOHGn+yYWifYtmXt0S7jwEZdmXfxrMT0fi7EhfcdjYVx+X73piAwILYOSjBepYKNQAaACEPZpe3OVejQcX+u0lkSfPUN8FLRetoTEV5FdATSScJpq5yHiLEhf58BIbmAvIPg4tR5uTAO60ogy6IwvTrZ2f7iHP0jcacyEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094368; c=relaxed/simple;
	bh=0w7a3xkM6u90vT/e1ENEzAz58Tpb6DjxD9xyswzgy1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q0Lk6xYRFFdNfqdtCDWpn9zaOiJlsfFb5YczvOZZNsJ2vw52GYsX/e8H812zG/EtId8nQPCME7zxAptQORP8sxMdv71lgyXmCl0oxyNvCCTdvt8DsCQdKv8Acf8DuWMJzPpQu93qJSLl2RNqZ5UE44G/v0uRmmx3O3hChSnTxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMp92PmU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gVIxsG9O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMp92PmU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gVIxsG9O"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67781mLE3176962
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 09:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1HpwTUnxe33ENewEj5Ahqp
	xZhSrjir1efQIZseCOhNU=; b=CMp92PmUak1gmOC2m62viwmZFyFzCxKYgsB08V
	IMwdECQnuu/A+papE+TOQ7Pl/aMpdcCnVU0HFRe3YyGqqGyBQYx0Mxfi+zIGNYI1
	3ykbUnnS809Fdt2MLkciaUpFtKw2G7SbCTynuOPAmPv3+ERTzJwKZITWFK9dM9oK
	sH2pmKt0ZbbinuIjXfHrgsjHdICgwXGxLA7b8HLPX0V0WowEwKWPjk2SoE3TQ4gd
	JhxAp/6Yda0/ZXiIsPqMPd/JfsCB6Ejn4mPsj0FuOyejWWTZBetngQ6ujt169UDh
	XIUsvrLnk3kYU7im9orZDdRY5wuVho11a2tF9tlzM1Ow0i+g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jk5g8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 09:19:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1b4d961dso15613241cf.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786094363; x=1786699163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1HpwTUnxe33ENewEj5AhqpxZhSrjir1efQIZseCOhNU=;
        b=gVIxsG9O8uZcgPGMTYqFqe9eYMIVoZsyHGuRZf+dgZbGuVk/vhm2cmRztRK9+/ztNp
         WoMCfqhPu24esT1EOxvmg3eOo3L/C40jyDk/RvS1H6il5PVHDSdilMRc5JlZ8WEKp02R
         u/VYtBRfE1Z9uLKRE0rGa2m7/IFsjOFo3I1Lrd57hZwFNGdgq5o3HJp/LeimZnsA0K0u
         W6m6LDcazbOedB2tVJj2n6lk9gVnf1dXPOaT3M+w73065hZd7IvM+MGPe3EhFgisXt6l
         iJGTqyyqJVE4bs4vKiS4MlD0eZTXXDbBc+QPhkM8GNK0+f/xDfanX0xAr13+Cp8Mhn5L
         aEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786094363; x=1786699163;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1HpwTUnxe33ENewEj5AhqpxZhSrjir1efQIZseCOhNU=;
        b=Lyz6jzINeltdpHALN5ZyEcqkCC4VrkZO7lipSx3DNYuKa/T3O1iO5xvmjERxmgwHgC
         +jc4aeTGeFPXKAWIEOzydKCXG4TMmR/CdL3ZeCXtjzJ6bqq4YR3p9ui6GdtFRH2MluV1
         iiQR+pWv37hVtOHpezdBGyP76m7wDdyqLQwjZ+gYk4luXm5zwrKJEl7LHMdn0lOBuLSA
         +CtDY1pz01xwbCnZsmHKnENDHd7VlcX2uO7x5Iea72YFvuyuDEgv2p0pIdNsjKU7BT3j
         tR1YzvOUtB7Zjfr29tSnvywmlV1UFH9QNzpgoxUq/mZAoTRW07Ml1Kzef9uGsWx56Ahe
         73Tg==
X-Forwarded-Encrypted: i=1; AHgh+RqC3GS2bbUif3j/lohw6kCWnTUnXeBscWiijIYZzjiybkB1cqmx6A+iW8AMeXv8/6iEEHMffac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykv2oNmOuWdQH0zhrEpAH4aarhFYDW//jPZquHTClLZH4IfOoK
	jg28jtr5g2yKucXcgg4T1GNaasj/vfFWNPUJaIRUDiFUsFRu8syNNw24GkCGoD73JdZ0OP53gQg
	s/8vfZucSkvwW0n03TsrWH6QeuLqdvteSwZG64FjAyxdAnxMKzCoujedLvmA=
X-Gm-Gg: AR+sD13mc/DKEhVkhcrNT8o/BQNjb36q+fQtYiIWekZnXDYBOC9Ha7Lc0jz8pVGFFP2
	p3Q6YZ3Zx7o6ednMMcdm/SQ8fNfbNAbt2VPJfBF6c1gio5XlxdMwll55qzGmqoLyvu1tD0qu9b/
	+VnSWaWON8oKr37vYI3bUHr+kUrZufIm6lkuzLtPVf97mNmLXT7kn3EE6e772eNXun+6Q88ztpD
	Prvz4HP4ecs0DgoEdMi7GswORYmDj0Gq8d36kmdq5aM9tP/1nm4i5BsNHFtWVBBwKqurMVtZQUu
	zzujqxWjDU51pkau9VyA6FDOO7S91RF6r3riHp4s0omArMDiv3UT1+Z1J7SXBeFqN3dN9wIZhoD
	vuLYvW6uz8UzSlQA=
X-Received: by 2002:ac8:5749:0:b0:516:7a83:8c37 with SMTP id d75a77b69052e-52cfb00272dmr137976581cf.11.1786094363215;
        Fri, 07 Aug 2026 02:19:23 -0700 (PDT)
X-Received: by 2002:ac8:5749:0:b0:516:7a83:8c37 with SMTP id d75a77b69052e-52cfb00272dmr137976101cf.11.1786094362570;
        Fri, 07 Aug 2026 02:19:22 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8b09sm4312877f8f.23.2026.08.07.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:19:21 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 11:18:58 +0200
Subject: [PATCH net-next v4] net: airoha: add HW GRO offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-airoha-eth-lro-v4-1-12d11ecb77d4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQz2rDMAyHX6X4PBfZSpx4p75H2cF/lMas2MMJo
 aPk3efmlBEXnX6IT5+kJ5soB5rY5+nJMi1hCimW0HycmBtNvBEPvmQmQSpoJXATchoNp3nk95y
 4ab1wqFD0QrAC/WQawmMbeGWRZh7pMbOv0hnDNKf8u5kWsfXfDV0ELyW1c4idUqQv35Qj3c8p3
 16SjStV5YCsIwtkBod77rXDIvfeIy8LLxuSRlNnUHdVr4Aq1zaWtLbaSN8evLj39gceC+89aCc
 GCwBU83YIVa78Xiv00PT0/951Xf8A9AT7T98BAAA=
X-Change-ID: 20260520-airoha-eth-lro-a5d1c3631811
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
        Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2OSBTYWx0ZWRfXxevOWJXkyx7Y
 L4Qc07tjr9m3vpj7Rl55zGyPifHpiYilVnFKhxGKRb1cfouAAU4/G2Ijstfv/YniuJ9nHzIGV+U
 5rOX4+hJ8i9Wtefo5XBTOurZuQHJBknhWVLJjnjXZkjWFmU10laJ5mxVu2Lc5EB6oOms12y2US5
 aDSoHQpJhIiWBSADwCsx4D4EfC88mGsW0k+SkEKWCUTMgP+1XkKhFrl1+7gaJgwCxlbVJYRl9/x
 ibptJIq+ZzTcsbkWR4+bnyGQI5yPCZnKLsGdV+75ozc2akiCgK6xctqKwnsERM6eYsrLINFV+3P
 Bw1Uaa5IlTvOGiXcXxfYndWc1JX6x7KCo9jeh+ICZFSZWmIFZJ8lW4xmnujMMs5ER82IeP6hUse
 ekJG8kmIMfzg47lp40BlTMgBeMSbYRKOex8pEj7ZUBai3ooHlVp69cv9rY7MhGQbcQZtwpDv0cK
 znvu+rc+GiRlbN6Rw/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2OSBTYWx0ZWRfX5hc1fh85Y0RT
 kZZqDL+vHLSGT4klEq91qz2564qnRlsnjCoj9J44Ay/4wyStlOJ3/YCxL4l4fAHDdUY2IIGOFDc
 viljzak6QCYu2HEowvEn+rl2fDSLuVw=
X-Proofpoint-ORIG-GUID: 0ZrhpftwQCsibVniLRIImWvA7yCmzO_-
X-Proofpoint-GUID: 0ZrhpftwQCsibVniLRIImWvA7yCmzO_-
X-Authority-Analysis: v=2.4 cv=e5Y2j6p/ c=1 sm=1 tr=0 ts=6a75a31c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=JGXwu8-eAAAA:8 a=EUspDBNiAAAA:8 a=o8TCZH9JdqHYbdZnS3wA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=-p01NfQuWD51nzoNXB_L:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070069

From: Lorenzo Bianconi <lorenzo@kernel.org>

Add hardware GRO offload support to the airoha_eth driver, leveraging
the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) so
it is required to increase the page_pool allocation order to 2 for RX
queues 24-31 (LRO queues).
Since HW GRO is configured per-QDMA and shared across all devices using
it, HW GRO is mutually exclusive with multiple devices bound to the
same QDMA block. Call netdev_update_features() in airoha_dev_set_qdma()
so that NETIF_F_GRO_HW availability is re-evaluated whenever the QDMA
user count changes (device registration and runtime QDMA migration).
Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
so that L3-forwarded traffic is correctly handled by the GSO/TSO path
on the egress device.

Performance comparison between GRO and HW GRO has been carried out using
a 10Gbps NIC:
GRO:    ~2.7 Gbps
HW GRO: ~8.2 Gbps

Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v4:
- Fix qdma user check in airoha_dev_open().
- Disable hw-gro in airoha_dev_stop().
- Check hw-gro configuration in airoha_enable_qos_for_gdm34() running
  airoha_dev_check_hw_gro().
- Enable rx interrupt for queue 31.
- Check tcp_ts_reply from hw descriptor.
- Add more sanity checks in airoha_qdma_lro_rx_skb().
- Move airoha_update_netdev_features() in airoha_dev_set_qdma()
- Link to v3: https://lore.kernel.org/r/20260730-airoha-eth-lro-v3-1-631963d048e3@kernel.org

Changes in v3:
- Add missing TCP header length check.
- Fix TCP checkum calculation.
- Disable LRO running ndo_stop callback.
- Implement packet header split in order to support HW-GRO
- Link to v2: https://lore.kernel.org/r/20260610-airoha-eth-lro-v2-1-54be99b9a2d5@kernel.org

Changes in v2:
- Rebase on top of net-next main branch.
- Link to v1: https://lore.kernel.org/r/20260606-airoha-eth-lro-v1-1-0ebceb0eafc3@kernel.org

Changes in v1:
- Please note this patch depends on the following patch not applied yet
  to net-next
  https://lore.kernel.org/netdev/20260606-airoha_qdma_users-no-atomic-v1-1-86e2d6a1bfaf@kernel.org/T/#u
- Restrict LRO to single user QDMA.
- Introduce some more sanity checks.
- Disable scatter-gather for LRO queues.
- Run netif_receive_skb() for LRO packets.
- Link to v3: https://lore.kernel.org/r/20260528-airoha-eth-lro-v3-1-dd09c1fb000e@kernel.org

Changes in RFC v3:
- Fix double-free of the page_pool of airoha_qdma_lro_rx_process()
  fails.
- Set AIROHA_LRO_PAGE_ORDER according to PAGE_SIZE.
- Add missig gso metadata for the LRO packet.
- Link to v2: https://lore.kernel.org/r/20260526-airoha-eth-lro-v2-1-24e2a9e7a397@kernel.org

Changes in RFC v2:
- Improve performances fixing buf_size computation.
- Fix possible overflow in REG_CDM_LRO_LIMIT() register configuration.
- Require the device to be not running before configuring LRO.
- Fix configuration order in airoha_fe_lro_is_enabled().
- Check skb header length in airoha_qdma_lro_rx_process().
- Do not check net_device feature in airoha_qdma_rx_process() before
  executing airoha_qdma_lro_rx_process() but rely on
  airoha_qdma_lro_rx_process() logic.
- Fix possible double recycle in airoha_qdma_rx_process() for LRO
  packets.
- Always use AIROHA_RXQ_LRO_MAX_AGG_COUNT macro for max LRO aggregated
  fragments in airoha_fe_lro_init_rx_queue().
- Link to v1: https://lore.kernel.org/r/20260520-airoha-eth-lro-v1-1-129cc33766e9@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 434 ++++++++++++++++++++++++++++--
 drivers/net/ethernet/airoha/airoha_eth.h  |  28 +-
 drivers/net/ethernet/airoha/airoha_regs.h |  22 +-
 3 files changed, 454 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64619e9a704d..e0d74d0cb36b 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -10,8 +10,10 @@
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
 #include <net/dst_metadata.h>
+#include <net/ip6_checksum.h>
 #include <net/page_pool/helpers.h>
 #include <net/pkt_cls.h>
+#include <net/tcp.h>
 #include <uapi/linux/ppp_defs.h>
 
 #include "airoha_regs.h"
@@ -491,6 +493,88 @@ static void airoha_fe_crsn_qsel_init(struct airoha_eth *eth)
 				 CDM_CRSN_QSEL_Q1));
 }
 
+static void airoha_fe_lro_rxq_enable(struct airoha_eth *eth, int qdma_id,
+				     int lro_queue_index, int qid,
+				     int buf_size)
+{
+	int id = qdma_id + 1;
+
+	airoha_fe_rmw(eth, REG_CDM_LRO_LIMIT(id),
+		      CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK,
+		      FIELD_PREP(CDM_LRO_AGG_SIZE_MASK, buf_size) |
+		      FIELD_PREP(CDM_LRO_AGG_NUM_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGG_COUNT));
+	airoha_fe_rmw(eth, REG_CDM_LRO_AGE_TIME(id),
+		      CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK,
+		      FIELD_PREP(CDM_LRO_AGE_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGE_TIME) |
+		      FIELD_PREP(CDM_LRO_AGG_TIME_MASK,
+				 AIROHA_RXQ_LRO_MAX_AGG_TIME));
+	airoha_fe_rmw(eth, REG_CDM_LRO_RXQ(id, lro_queue_index),
+		      LRO_RXQ_MASK(lro_queue_index),
+		      __field_prep(LRO_RXQ_MASK(lro_queue_index), qid));
+	airoha_fe_set(eth, REG_CDM_LRO_EN(id), BIT(lro_queue_index));
+}
+
+static void airoha_fe_lro_disable(struct airoha_eth *eth, int qdma_id)
+{
+	int i, id = qdma_id + 1;
+
+	airoha_fe_clear(eth, REG_CDM_LRO_EN(id), LRO_RXQ_EN_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_LIMIT(id),
+			CDM_LRO_AGG_NUM_MASK | CDM_LRO_AGG_SIZE_MASK);
+	airoha_fe_clear(eth, REG_CDM_LRO_AGE_TIME(id),
+			CDM_LRO_AGE_TIME_MASK | CDM_LRO_AGG_TIME_MASK);
+	for (i = 0; i < AIROHA_MAX_NUM_LRO_QUEUES; i++)
+		airoha_fe_clear(eth, REG_CDM_LRO_RXQ(id, i), LRO_RXQ_MASK(i));
+}
+
+static bool airoha_fe_lro_is_enabled(struct airoha_eth *eth, int qdma_id)
+{
+	return airoha_fe_get(eth, REG_CDM_LRO_EN(qdma_id + 1),
+			     LRO_RXQ_EN_MASK);
+}
+
+static void airoha_dev_lro_enable(struct airoha_gdm_dev *dev)
+{
+	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+	int i, lro_queue_index = 0;
+
+	if (airoha_fe_lro_is_enabled(eth, qdma_id))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(qdma->q_rx); i++) {
+		struct airoha_queue *q = &qdma->q_rx[i];
+		u32 size;
+
+		if (!q->ndesc)
+			continue;
+
+		if (!airoha_qdma_is_lro_queue(q))
+			continue;
+
+		size = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
+		size = min_t(u32, size, AIROHA_MAX_RX_SIZE);
+		airoha_fe_lro_rxq_enable(eth, qdma_id, lro_queue_index, i,
+					 size);
+		lro_queue_index++;
+	}
+}
+
+static void airoha_dev_lro_disable(struct airoha_gdm_dev *dev)
+{
+	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+
+	if (!airoha_fe_lro_is_enabled(eth, qdma_id))
+		return;
+
+	airoha_fe_lro_disable(eth, qdma_id);
+}
+
 static int airoha_fe_init(struct airoha_eth *eth)
 {
 	airoha_fe_maccr_init(eth);
@@ -616,6 +700,7 @@ static int airoha_qdma_fill_rx_queue(struct airoha_queue *q)
 		e->dma_addr = page_pool_get_dma_addr(page) + offset;
 		e->dma_len = SKB_WITH_OVERHEAD(AIROHA_RX_LEN(q->buf_size));
 
+		WRITE_ONCE(desc->tcp_ts_reply, 0);
 		val = FIELD_PREP(QDMA_DESC_LEN_MASK, e->dma_len);
 		WRITE_ONCE(desc->ctrl, cpu_to_le32(val));
 		WRITE_ONCE(desc->addr, cpu_to_le32(e->dma_addr));
@@ -657,18 +742,188 @@ airoha_qdma_get_gdm_dev(struct airoha_eth *eth, struct airoha_qdma_desc *desc)
 	return port->devs[d] ? port->devs[d] : ERR_PTR(-ENODEV);
 }
 
+static struct sk_buff *airoha_qdma_lro_rx_skb(struct airoha_queue *q,
+					      struct airoha_qdma_desc *desc,
+					      struct airoha_queue_entry *e,
+					      u32 len, u32 agg_count)
+{
+	u32 msg1 = le32_to_cpu(READ_ONCE(desc->msg1));
+	u32 msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
+	u32 msg3 = le32_to_cpu(READ_ONCE(desc->msg3));
+	u32 th_off, tcp_ack_seq, data_off, data_len;
+	struct skb_shared_info *shinfo;
+	u16 tcp_win, l2_len;
+	struct sk_buff *skb;
+	struct tcphdr *th;
+	struct page *page;
+	bool ipv4, ipv6;
+
+	ipv4 = FIELD_GET(QDMA_ETH_RXMSG_IP4_MASK, msg1);
+	ipv6 = FIELD_GET(QDMA_ETH_RXMSG_IP6_MASK, msg1);
+	if (!ipv4 && !ipv6)
+		return NULL;
+
+	l2_len = FIELD_GET(QDMA_ETH_RXMSG_L2_LEN_MASK, msg2);
+
+	if (ipv4) {
+		struct iphdr *iph;
+
+		if (len < l2_len + sizeof(*iph))
+			return NULL;
+
+		iph = (struct iphdr *)(e->buf + l2_len);
+		if (iph->protocol != IPPROTO_TCP)
+			return NULL;
+
+		if (iph->ihl < 5)
+			return NULL;
+
+		th_off = l2_len + (iph->ihl << 2);
+		if (len < th_off)
+			return NULL;
+
+		iph->tot_len = cpu_to_be16(len - l2_len);
+		iph->check = 0;
+		iph->check = ip_fast_csum((void *)iph, iph->ihl);
+	} else {
+		struct ipv6hdr *ip6h;
+
+		th_off = l2_len + sizeof(*ip6h);
+		if (len < th_off)
+			return NULL;
+
+		ip6h = (struct ipv6hdr *)(e->buf + l2_len);
+		if (ip6h->nexthdr != NEXTHDR_TCP)
+			return NULL;
+
+		ip6h->payload_len = cpu_to_be16(len - th_off);
+	}
+
+	if (len < th_off + sizeof(*th))
+		return NULL;
+
+	th = (struct tcphdr *)(e->buf + th_off);
+	if (th->doff < 5)
+		return NULL;
+
+	data_off = th_off + (th->doff << 2);
+	if (len <= data_off)
+		return NULL;
+
+	tcp_win = FIELD_GET(QDMA_ETH_RXMSG_TCP_WIN_MASK, msg3);
+	tcp_ack_seq = le32_to_cpu(READ_ONCE(desc->data));
+	th->ack_seq = cpu_to_be32(tcp_ack_seq);
+	th->window = cpu_to_be16(tcp_win);
+
+	/* Check tcp timestamp option */
+	if (th->doff == (sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4) {
+		u32 topt = get_unaligned_be32(th + 1);
+
+		if (topt == ((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
+			     (TCPOPT_TIMESTAMP << 8) | TCPOLEN_TIMESTAMP)) {
+			u8 *ptr = (u8 *)th + sizeof(*th) + 2 * sizeof(__be32);
+			__le32 tcp_ts_reply = READ_ONCE(desc->tcp_ts_reply);
+
+			/* The field is pre-zeroed in the posted descriptor,
+			 * so a non-zero value is the hardware confirming the
+			 * timestamp echo reply is valid. Leave TSecr
+			 * untouched otherwise, since the hardware may not
+			 * populate it for every aggregate.
+			 */
+			if (tcp_ts_reply)
+				put_unaligned_be32(le32_to_cpu(tcp_ts_reply),
+						   ptr);
+		}
+	}
+
+	if (ipv4) {
+		struct iphdr *iph = (struct iphdr *)(e->buf + l2_len);
+
+		th->check = ~tcp_v4_check(len - th_off, iph->saddr,
+					  iph->daddr, 0);
+	} else {
+		struct ipv6hdr *ip6h = (struct ipv6hdr *)(e->buf + l2_len);
+
+		th->check = ~tcp_v6_check(len - th_off, &ip6h->saddr,
+					  &ip6h->daddr, 0);
+	}
+
+	/* Split network headers and payload to rely on GRO.
+	 * We need to do it in the driver since the NIC does
+	 * not support it.
+	 */
+	skb = napi_alloc_skb(&q->napi, data_off);
+	if (!skb)
+		return NULL;
+
+	__skb_put(skb, data_off);
+	memcpy(skb->data, e->buf, data_off);
+
+	page = virt_to_head_page(e->buf);
+	data_len = len - data_off;
+	shinfo = skb_shinfo(skb);
+	skb_add_rx_frag(skb, shinfo->nr_frags, page,
+			e->buf + data_off - page_address(page), data_len,
+			q->buf_size);
+
+	shinfo->gso_type = ipv4 ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+	/* HW does not report the per-segment MSS, so approximate it as
+	 * the average segment size. For a stream of MSS-sized segments
+	 * with a shorter tail this still re-segments into exactly
+	 * agg_count segments, keeping gso_size/gso_segs and the packet
+	 * accounting coherent, while never overestimating the MSS.
+	 */
+	shinfo->gso_size = DIV_ROUND_UP(data_len, agg_count);
+	shinfo->gso_segs = agg_count;
+
+	skb->csum_start = skb_headroom(skb) + th_off;
+	skb->csum_offset = offsetof(struct tcphdr, check);
+	skb->ip_summed = CHECKSUM_PARTIAL;
+
+	return skb;
+}
+
+static struct sk_buff *airoha_qdma_build_rx_skb(struct airoha_queue *q,
+						struct airoha_qdma_desc *desc,
+						struct airoha_queue_entry *e,
+						struct net_device *dev,
+						u32 len, u32 agg_count)
+{
+	int qid = q - &q->qdma->q_rx[0];
+	struct sk_buff *skb;
+
+	if (agg_count > 1 && airoha_qdma_is_lro_queue(q)) { /* LRO */
+		skb = airoha_qdma_lro_rx_skb(q, desc, e, len, agg_count);
+		if (!skb)
+			return NULL;
+	} else {
+		skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM, q->buf_size);
+		if (!skb)
+			return NULL;
+
+		skb_reserve(skb, AIROHA_RX_HEADROOM);
+		__skb_put(skb, len);
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	skb_mark_for_recycle(skb);
+	skb->dev = dev;
+	skb_record_rx_queue(skb, qid);
+	skb->protocol = eth_type_trans(skb, dev);
+
+	return skb;
+}
+
 static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 {
 	enum dma_data_direction dir = page_pool_get_dma_dir(q->page_pool);
-	struct airoha_qdma *qdma = q->qdma;
-	struct airoha_eth *eth = qdma->eth;
-	int qid = q - &qdma->q_rx[0];
+	struct airoha_eth *eth = q->qdma->eth;
 	int done = 0;
 
 	while (done < budget) {
+		u32 hash, reason, msg1, msg2, desc_ctrl, agg_count;
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
-		u32 hash, reason, msg1, desc_ctrl;
 		struct airoha_gdm_dev *dev;
 		struct net_device *netdev;
 		int data_len, len;
@@ -692,24 +947,21 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (!len || data_len < len)
 			goto free_frag;
 
+		msg2 = le32_to_cpu(READ_ONCE(desc->msg2));
+		agg_count = FIELD_GET(QDMA_ETH_RXMSG_AGG_COUNT_MASK, msg2);
+		if (agg_count > AIROHA_RXQ_LRO_MAX_AGG_COUNT)
+			goto free_frag;
+
 		dev = airoha_qdma_get_gdm_dev(eth, desc);
 		if (IS_ERR(dev))
 			goto free_frag;
 
 		netdev = netdev_from_priv(dev);
 		if (!q->skb) { /* first buffer */
-			q->skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
-						q->buf_size);
+			q->skb = airoha_qdma_build_rx_skb(q, desc, e, netdev,
+							  len, agg_count);
 			if (!q->skb)
 				goto free_frag;
-
-			skb_reserve(q->skb, AIROHA_RX_HEADROOM);
-			__skb_put(q->skb, len);
-			skb_mark_for_recycle(q->skb);
-			q->skb->dev = netdev;
-			q->skb->protocol = eth_type_trans(q->skb, netdev);
-			q->skb->ip_summed = CHECKSUM_UNNECESSARY;
-			skb_record_rx_queue(q->skb, qid);
 		} else { /* scattered frame */
 			struct skb_shared_info *shinfo = skb_shinfo(q->skb);
 			int nr_frags = shinfo->nr_frags;
@@ -800,12 +1052,10 @@ static int airoha_qdma_rx_napi_poll(struct napi_struct *napi, int budget)
 static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 				     struct airoha_qdma *qdma, int ndesc)
 {
-	const struct page_pool_params pp_params = {
-		.order = 0,
+	struct page_pool_params pp_params = {
 		.pool_size = 256,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.dma_dir = DMA_FROM_DEVICE,
-		.max_len = PAGE_SIZE,
 		.nid = NUMA_NO_NODE,
 		.dev = qdma->eth->dev,
 		.napi = &q->napi,
@@ -813,9 +1063,10 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	struct airoha_eth *eth = qdma->eth;
 	int qid = q - &qdma->q_rx[0], thr;
 	dma_addr_t dma_addr;
+	bool lro_q;
 
-	q->buf_size = PAGE_SIZE / 2;
 	q->qdma = qdma;
+	lro_q = airoha_qdma_is_lro_queue(q);
 
 	q->entry = devm_kzalloc(eth->dev, ndesc * sizeof(*q->entry),
 				GFP_KERNEL);
@@ -827,6 +1078,9 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 	if (!q->desc)
 		return -ENOMEM;
 
+	pp_params.order = lro_q ? AIROHA_LRO_PAGE_ORDER : 0;
+	pp_params.max_len = PAGE_SIZE << pp_params.order;
+
 	q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(q->page_pool)) {
 		int err = PTR_ERR(q->page_pool);
@@ -835,6 +1089,7 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 		return err;
 	}
 
+	q->buf_size = lro_q ? pp_params.max_len : pp_params.max_len / 2;
 	q->ndesc = ndesc;
 	netif_napi_add(eth->napi_dev, &q->napi, airoha_qdma_rx_napi_poll);
 
@@ -848,7 +1103,12 @@ static int airoha_qdma_init_rx_queue(struct airoha_queue *q,
 			FIELD_PREP(RX_RING_THR_MASK, thr));
 	airoha_qdma_rmw(qdma, REG_RX_DMA_IDX(qid), RX_RING_DMA_IDX_MASK,
 			FIELD_PREP(RX_RING_DMA_IDX_MASK, q->head));
-	airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid), RX_RING_SG_EN_MASK);
+	if (lro_q)
+		airoha_qdma_clear(qdma, REG_RX_SCATTER_CFG(qid),
+				  RX_RING_SG_EN_MASK);
+	else
+		airoha_qdma_set(qdma, REG_RX_SCATTER_CFG(qid),
+				RX_RING_SG_EN_MASK);
 
 	airoha_qdma_fill_rx_queue(q);
 
@@ -870,6 +1130,7 @@ static void airoha_qdma_cleanup_rx_queue(struct airoha_queue *q)
 					page_pool_get_dma_dir(q->page_pool));
 		page_pool_put_full_page(q->page_pool, page, false);
 		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->tcp_ts_reply, 0);
 		WRITE_ONCE(desc->ctrl, 0);
 		WRITE_ONCE(desc->addr, 0);
 		WRITE_ONCE(desc->data, 0);
@@ -1896,6 +2157,34 @@ static void airoha_update_hw_stats(struct airoha_gdm_dev *dev)
 	spin_unlock(&port->stats_lock);
 }
 
+static void airoha_update_netdev_features(struct airoha_gdm_dev *dev)
+{
+	struct airoha_eth *eth = dev->eth;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
+
+		if (!port)
+			continue;
+
+		for (j = 0; j < ARRAY_SIZE(port->devs); j++) {
+			struct airoha_gdm_dev *iter_dev = port->devs[j];
+			struct net_device *netdev;
+
+			if (!iter_dev)
+				continue;
+
+			netdev = netdev_from_priv(iter_dev);
+			if (netdev->reg_state != NETREG_REGISTERED)
+				continue;
+
+			netdev_update_features(netdev);
+		}
+	}
+}
+
 static void airoha_dev_set_xmit_frame_size(struct net_device *netdev)
 {
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
@@ -1913,14 +2202,28 @@ static int airoha_dev_open(struct net_device *netdev)
 	struct airoha_gdm_port *port = dev->port;
 	u32 pse_port = FE_PSE_PORT_PPE1;
 	struct airoha_qdma *qdma;
-	int err;
+	int qdma_id, err;
+
+	/* HW GRO is configured on the QDMA and it is shared between
+	 * all the devices using it. Refuse to open a second device on
+	 * the same QDMA if HW GRO is enabled on any device sharing it
+	 * or if this device has HW GRO enabled in its feature set.
+	 */
+	qdma = airoha_qdma_deref(dev);
+	qdma_id = qdma - &qdma->eth->qdma[0];
+
+	if (qdma->users > 1 && (airoha_fe_lro_is_enabled(qdma->eth, qdma_id) ||
+				(netdev->features & NETIF_F_GRO_HW))) {
+		netdev_warn(netdev, "required to disable HW GRO on QDMA%d\n",
+			    qdma_id);
+		return -EBUSY;
+	}
 
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
 	if (err)
 		return err;
 
-	qdma = airoha_qdma_deref(dev);
 	if (netdev_uses_dsa(netdev))
 		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
 			      GDM_STAG_EN_MASK);
@@ -1937,6 +2240,9 @@ static int airoha_dev_open(struct net_device *netdev)
 	airoha_set_gdm_port_fwd_cfg(qdma->eth, REG_GDM_FWD_CFG(port->id),
 				    pse_port);
 
+	if (netdev->features & NETIF_F_GRO_HW)
+		airoha_dev_lro_enable(dev);
+
 	return 0;
 }
 
@@ -1954,6 +2260,10 @@ static int airoha_dev_stop(struct net_device *netdev)
 		airoha_set_gdm_port_fwd_cfg(dev->eth,
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
+
+	if (netdev->features & NETIF_F_GRO_HW)
+		airoha_dev_lro_disable(dev);
+
 	return 0;
 }
 
@@ -2104,6 +2414,34 @@ airoha_get_wan_gdm_dev(struct airoha_eth *eth)
 	return NULL;
 }
 
+static int airoha_dev_check_hw_gro(struct airoha_gdm_dev *dev)
+{
+	struct airoha_qdma *qdma = airoha_qdma_deref(dev);
+	struct airoha_eth *eth = qdma->eth;
+	int qdma_id = qdma - &eth->qdma[0];
+
+	if (airoha_fe_lro_is_enabled(eth, qdma_id)) {
+		struct net_device *netdev = netdev_from_priv(dev);
+
+		netdev_warn(netdev, "HW GRO is enabled on QDMA%d\n", qdma_id);
+		return -EBUSY;
+	}
+
+	qdma = &eth->qdma[!qdma_id];
+	qdma_id = qdma - &eth->qdma[0];
+
+	if (airoha_fe_lro_is_enabled(eth, qdma_id)) {
+		struct net_device *netdev = netdev_from_priv(dev);
+
+		netdev_warn(netdev,
+			    "HW GRO is enabled on destination QDMA%d\n",
+			    qdma_id);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
 {
 	struct net_device *netdev = netdev_from_priv(dev);
@@ -2120,6 +2458,7 @@ static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
 
 	rcu_assign_pointer(dev->qdma, qdma);
 	netdev->irq = qdma->irq_banks[0].irq;
+	qdma->users++;
 	synchronize_rcu();
 
 	ppe_id = !airoha_is_lan_gdm_dev(dev) && airoha_ppe_is_enabled(eth, 1);
@@ -2136,8 +2475,12 @@ static void airoha_dev_set_qdma(struct airoha_gdm_dev *dev)
 			airoha_qdma_rr(qdma, REG_CNTR_VAL((i << 1) + 1));
 	}
 
-	if (cur_qdma)
+	if (cur_qdma) {
+		cur_qdma->users--;
 		netif_tx_wake_all_queues(netdev);
+	}
+
+	airoha_update_netdev_features(dev);
 }
 
 static int airoha_dev_init(struct net_device *netdev)
@@ -2288,6 +2631,36 @@ int airoha_get_fe_port(struct airoha_gdm_dev *dev)
 	}
 }
 
+static netdev_features_t airoha_dev_fix_features(struct net_device *netdev,
+						 netdev_features_t features)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct airoha_qdma *qdma;
+
+	qdma = airoha_qdma_deref(dev);
+	if (qdma->users > 1)
+		features &= ~NETIF_F_GRO_HW;
+
+	return features;
+}
+
+static int airoha_dev_set_features(struct net_device *netdev,
+				   netdev_features_t features)
+{
+	netdev_features_t diff = netdev->features ^ features;
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+
+	if (!(diff & NETIF_F_GRO_HW))
+		return 0;
+
+	if (features & NETIF_F_GRO_HW)
+		airoha_dev_lro_enable(dev);
+	else
+		airoha_dev_lro_disable(dev);
+
+	return 0;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
@@ -3199,7 +3572,7 @@ static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
 	struct airoha_gdm_dev *wan_dev, *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 	struct airoha_eth *eth = dev->eth;
-	int err = -EBUSY;
+	int err;
 
 	if (port->id != AIROHA_GDM3_IDX &&
 	    port->id != AIROHA_GDM4_IDX) {
@@ -3210,6 +3583,10 @@ static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
 	if (!airoha_is_lan_gdm_dev(dev)) /* Already enabled */
 		return 0;
 
+	err = airoha_dev_check_hw_gro(dev);
+	if (err)
+		return err;
+
 	mutex_lock(&flow_offload_mutex);
 
 	wan_dev = airoha_get_wan_gdm_dev(eth);
@@ -3218,6 +3595,7 @@ static int airoha_enable_qos_for_gdm34(struct net_device *netdev,
 		    wan_dev->port->id == AIROHA_GDM2_IDX) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "QoS configured for WAN device");
+			err = -EBUSY;
 			goto error_unlock;
 		}
 		airoha_disable_qos_for_gdm34(netdev_from_priv(wan_dev));
@@ -3343,6 +3721,8 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_stop		= airoha_dev_stop,
 	.ndo_change_mtu		= airoha_dev_change_mtu,
 	.ndo_select_queue	= airoha_dev_select_queue,
+	.ndo_fix_features	= airoha_dev_fix_features,
+	.ndo_set_features	= airoha_dev_set_features,
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
@@ -3430,11 +3810,9 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 	netdev->ethtool_ops = &airoha_ethtool_ops;
 	netdev->max_mtu = AIROHA_MAX_MTU;
 	netdev->watchdog_timeo = 5 * HZ;
-	netdev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM | NETIF_F_TSO6 |
-			      NETIF_F_IPV6_CSUM | NETIF_F_SG | NETIF_F_TSO |
-			      NETIF_F_HW_TC;
-	netdev->features |= netdev->hw_features;
-	netdev->vlan_features = netdev->hw_features;
+	netdev->hw_features = AIROHA_HW_FEATURES | NETIF_F_GRO_HW;
+	netdev->features |= AIROHA_HW_FEATURES;
+	netdev->vlan_features = AIROHA_HW_FEATURES;
 	SET_NETDEV_DEV(netdev, eth->dev);
 
 	/* reserve hw queues for HTB offloading */
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fa9a8edce22f..9b55abc63048 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -45,6 +45,18 @@
 	 (_n) == 15 ? 128 :		\
 	 (_n) ==  0 ? 1024 : 16)
 
+#define AIROHA_LRO_PAGE_ORDER		get_order(SZ_16K)
+#define AIROHA_MAX_NUM_LRO_QUEUES	8
+#define AIROHA_RXQ_LRO_EN_MASK		GENMASK(31, 24)
+#define AIROHA_RXQ_LRO_MAX_AGG_COUNT	64
+#define AIROHA_RXQ_LRO_MAX_AGG_TIME	100
+#define AIROHA_RXQ_LRO_MAX_AGE_TIME	2000
+
+#define AIROHA_HW_FEATURES			\
+	(NETIF_F_IP_CSUM | NETIF_F_RXCSUM |	\
+	 NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |	\
+	 NETIF_F_SG | NETIF_F_TSO | NETIF_F_HW_TC)
+
 #define PSE_RSV_PAGES			128
 #define PSE_QUEUE_RSV_PAGES		64
 
@@ -538,7 +550,7 @@ struct airoha_wdma_info {
 
 /* RX queue to IRQ mapping: BIT(q) in IRQ(n) */
 #define RX_IRQ0_BANK_PIN_MASK			0x839f
-#define RX_IRQ1_BANK_PIN_MASK			0x7fe00000
+#define RX_IRQ1_BANK_PIN_MASK			0xffe00000
 #define RX_IRQ2_BANK_PIN_MASK			0x20
 #define RX_IRQ3_BANK_PIN_MASK			0x40
 #define RX_IRQ_BANK_PIN_MASK(_n)		\
@@ -560,6 +572,8 @@ struct airoha_qdma {
 	struct airoha_eth *eth;
 	void __iomem *regs;
 
+	int users;
+
 	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
 
 	struct airoha_tx_irq_queue q_tx_irq[AIROHA_NUM_TX_IRQ];
@@ -714,6 +728,18 @@ static inline bool airoha_is_7583(struct airoha_eth *eth)
 	return eth->soc->version == 0x7583;
 }
 
+static inline bool airoha_qdma_is_lro_queue(struct airoha_queue *q)
+{
+	struct airoha_qdma *qdma = q->qdma;
+	int qid = q - &qdma->q_rx[0];
+
+	/* EN7581 SoC supports at most 8 LRO rx queues */
+	BUILD_BUG_ON(hweight32(AIROHA_RXQ_LRO_EN_MASK) >
+		     AIROHA_MAX_NUM_LRO_QUEUES);
+
+	return !!(AIROHA_RXQ_LRO_EN_MASK & BIT(qid));
+}
+
 int airoha_get_fe_port(struct airoha_gdm_dev *dev);
 bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 			     struct airoha_gdm_dev *dev);
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 442b48c9b991..0ec41c3b4c06 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -122,6 +122,20 @@
 #define CDM_CRSN_QSEL_REASON_MASK(_n)	\
 	GENMASK(4 + (((_n) % 4) << 3),	(((_n) % 4) << 3))
 
+#define REG_CDM_LRO_RXQ(_n, _m)		(CDM_BASE(_n) + 0x78 + ((_m) & 0x4))
+#define LRO_RXQ_MASK(_n)		GENMASK(4 + (((_n) & 0x3) << 3), ((_n) & 0x3) << 3)
+
+#define REG_CDM_LRO_EN(_n)		(CDM_BASE(_n) + 0x80)
+#define LRO_RXQ_EN_MASK			GENMASK(7, 0)
+
+#define REG_CDM_LRO_LIMIT(_n)		(CDM_BASE(_n) + 0x84)
+#define CDM_LRO_AGG_NUM_MASK		GENMASK(23, 16)
+#define CDM_LRO_AGG_SIZE_MASK		GENMASK(15, 0)
+
+#define REG_CDM_LRO_AGE_TIME(_n)	(CDM_BASE(_n) + 0x88)
+#define CDM_LRO_AGE_TIME_MASK		GENMASK(31, 16)
+#define CDM_LRO_AGG_TIME_MASK		GENMASK(15, 0)
+
 #define REG_GDM_FWD_CFG(_n)		GDM_BASE(_n)
 #define GDM_PAD_EN_MASK			BIT(28)
 #define GDM_DROP_CRC_ERR_MASK		BIT(23)
@@ -887,9 +901,15 @@
 #define QDMA_ETH_RXMSG_SPORT_MASK	GENMASK(25, 21)
 #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
 #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
+/* RX MSG2 */
+#define QDMA_ETH_RXMSG_AGG_COUNT_MASK	GENMASK(31, 24)
+#define QDMA_ETH_RXMSG_L2_LEN_MASK	GENMASK(6, 0)
+/* RX MSG3 */
+#define QDMA_ETH_RXMSG_AGG_LEN_MASK	GENMASK(31, 16)
+#define QDMA_ETH_RXMSG_TCP_WIN_MASK	GENMASK(15, 0)
 
 struct airoha_qdma_desc {
-	__le32 rsv;
+	__le32 tcp_ts_reply;
 	__le32 ctrl;
 	__le32 addr;
 	__le32 data;

---
base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6
change-id: 20260520-airoha-eth-lro-a5d1c3631811

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

