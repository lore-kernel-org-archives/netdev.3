Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0747ECDE;
	Wed,  6 May 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075910; cv=none; b=izvWGD4mDPf9MiPwnGp7cNJ2QrOvmLn6dOXyJ4Tm3lqT4TuFM1TBK8acDR1fhpgB7tY4NzuofnTkygRXFNo5kolKgXxrLmAJ/6ZmhMvKZR4dVPRI5d7VNdsqQEgWIgyp+9BQj9IQksFPcJL2nJWYNjrMtoUxUJjz1xJBHXpQMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075910; c=relaxed/simple;
	bh=PhY45nTJrZsT2sZclP3aMDoTnqVhyD7cWv/vottTDkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myvfAm/bpWQn44AKq2W1/IgQazqNuyfVKMO1+GNlxnZa/a2nDgnYSQIiUOdw9Wps8ej3gMfCC7TD3xEacebrZcPa1extRrOUZZIjIVMbtzl7ske6Y2r9xevSapc7uE9G1vIgm+wZmgeM9k8Y1FTDxenzzFWsERba8JBKirwHxMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iofWNnXn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iofWNnXn"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BvE133908631;
	Wed, 6 May 2026 06:58:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	UsXOIb7sjUhVm9XZcULBy90X19VInSaFQauJs8V39c=; b=iofWNnXnV+U0uqodh
	LPW3QqMWJxxHeq95IYX0xMHzwcrIH9uc+HXtWZPFxNqq5oqYSWZ7Yd//HyDpAAQv
	Is9cbSsQqhxRwqSLfTA7pUYkJNUczU/pj+7ngc4DzrerYR+7mdSKCORXrUhWntHD
	SRaqqQdMLB2O06XFkUshagzT6NXH1ix1ImBWRPPLb0VIRZ118g+YExU3iCiAYoUl
	G9nLoj8DB1Rdexgc8N6xvxPMcEc3e1HsKaXVP9ESjYRVKBVtBEgi303lkr5ZluKA
	bkRzWhH8cyY46DOiOv4D9/kcBN4Hdyp6ty4C2HPHX52RQYMEaHmITbag8+7Nb8my
	2OBnQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e026pgm7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 06:58:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 6 May 2026 06:58:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 6 May 2026 06:58:17 -0700
Received: from BG-LT92649.marvell.com (BG-LT92649.marvell.com [10.28.166.218])
	by maili.marvell.com (Postfix) with ESMTP id 8FE633F7095;
	Wed,  6 May 2026 06:58:13 -0700 (PDT)
From: <sukhdeeps@marvell.com>
To: <netdev@vger.kernel.org>
CC: <irusskikh@marvell.com>, <epomozov@marvell.com>,
        <richardcochran@gmail.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
        Sukhdeep Singh <sukhdeeps@marvell.com>
Subject: [PATCH net-next 2/9] net: atlantic: move active_ipv4/ipv6 bitmap updates after HW write updates after HW write
Date: Wed, 6 May 2026 19:26:59 +0530
Message-ID: <20260506135706.2834-3-sukhdeeps@marvell.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260506135706.2834-1-sukhdeeps@marvell.com>
References: <20260506135706.2834-1-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Y/LIdBeN c=1 sm=1 tr=0 ts=69fb48fb cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=gSoh3b3hW_7NMvOQyb8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 0tq5cjqj7XLdar4Arj02zH0lGGPaelMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNyBTYWx0ZWRfX64Hl8w1eGqYu
 m3U2G/YWKGQ2qAA8HGLStmzRWi5OQwKcW6Y/SZGfN3k0fnf119DSj1zUWknNwOU7csF2m9DvBLa
 7v9NjaJSj81nm8JMqxypRJgyMQuvobMn/Bd4Bb8XUJAs3sBQBqoPvzpe20/VI+6OtNUlLJ8brjX
 RWiencg7sWC9rlHSfsDXNXfy+gGeHtn7d3RxwWqItKJNmYn7TsNEwI+mp2f/Qwf0e5Tajb89wiX
 IQzBcWiuX9iT7aKKr72DN6GkTQxn6jlVxMayuyWB1gnU2rruTgfHSJdYotgRxkHDiklXJ+kqgY/
 yJaehBp7jHaKasUkW61mAunlfXdHULdObNLFTALcgrBlaNCjFGG2peApnoQ4wk6mEcF1/pHRwoK
 rDMAuwj/JAgpbpTcDzoxZbI9ZQrF1YdlXOownmECFh1jhQiDMHwi0HPvyqMuoXM4IG5SugmGTto
 dtP3w4UPLEJaRaZoIBw==
X-Proofpoint-ORIG-GUID: 0tq5cjqj7XLdar4Arj02zH0lGGPaelMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01

From: Sukhdeep Singh <sukhdeeps@marvell.com>

Move active_ipv4/active_ipv6 bitmap updates from aq_set_data_fl3l4()
into aq_add_del_fl3l4() after the hardware write succeeds. The bitmaps
track which filter slots are actively programmed in hardware and must
only be updated once the HW write is confirmed.

Also remove bitmap manipulation from aq_nic_reserve_filter() and
aq_nic_release_filter(). These functions manage filter slot reservation
counts, not HW filter state. Setting active_ipv4 bits at reservation
time (before any filter is programmed) and clearing them at release
time (regardless of HW state) results in incorrect state visible to
aq_check_approve_fl3l4() for IPv4/IPv6 mixing validation.

This corrected state management is required for the AQC113 L3L4 filter
path introduced later in this series.

Signed-off-by: Sukhdeep Singh <sukhdeeps@marvell.com>
---
 .../ethernet/aquantia/atlantic/aq_filters.c   | 36 ++++++++++++-------
 .../net/ethernet/aquantia/atlantic/aq_nic.c   |  3 --
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
index eef52f23166d..150a0b1af26a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
@@ -479,15 +479,8 @@ static int aq_set_data_fl3l4(struct aq_nic_s *aq_nic,
 	data->is_ipv6 = rx_fltrs->fl3l4.is_ipv6;
 	data->location = HW_ATL_GET_REG_LOCATION_FL3L4(fsp->location);
 
-	if (!add) {
-		if (!data->is_ipv6)
-			rx_fltrs->fl3l4.active_ipv4 &= ~BIT(data->location);
-		else
-			rx_fltrs->fl3l4.active_ipv6 &=
-				~BIT((data->location) / 4);
-
+	if (!add)
 		return 0;
-	}
 
 	data->cmd |= HW_ATL_RX_ENABLE_FLTR_L3L4;
 
@@ -515,11 +508,9 @@ static int aq_set_data_fl3l4(struct aq_nic_s *aq_nic,
 			ntohl(fsp->h_u.tcp_ip4_spec.ip4src);
 		data->ip_dst[0] =
 			ntohl(fsp->h_u.tcp_ip4_spec.ip4dst);
-		rx_fltrs->fl3l4.active_ipv4 |= BIT(data->location);
 	} else {
 		int i;
 
-		rx_fltrs->fl3l4.active_ipv6 |= BIT((data->location) / 4);
 		for (i = 0; i < HW_ATL_RX_CNT_REG_ADDR_IPV6; ++i) {
 			data->ip_dst[i] =
 				ntohl(fsp->h_u.tcp_ip6_spec.ip6dst[i]);
@@ -574,16 +565,35 @@ static int aq_set_fl3l4(struct aq_hw_s *aq_hw,
 static int aq_add_del_fl3l4(struct aq_nic_s *aq_nic,
 			    struct aq_rx_filter *aq_rx_fltr, bool add)
 {
+	struct aq_hw_rx_fltrs_s *rx_fltrs = aq_get_hw_rx_fltrs(aq_nic);
 	const struct aq_hw_ops *aq_hw_ops = aq_nic->aq_hw_ops;
 	struct aq_hw_s *aq_hw = aq_nic->aq_hw;
 	struct aq_rx_filter_l3l4 data;
+	int err;
 
 	if (unlikely(aq_rx_fltr->aq_fsp.location < AQ_RX_FIRST_LOC_FL3L4 ||
-		     aq_rx_fltr->aq_fsp.location > AQ_RX_LAST_LOC_FL3L4  ||
-		     aq_set_data_fl3l4(aq_nic, aq_rx_fltr, &data, add)))
+		     aq_rx_fltr->aq_fsp.location > AQ_RX_LAST_LOC_FL3L4))
 		return -EINVAL;
 
-	return aq_set_fl3l4(aq_hw, aq_hw_ops, &data);
+	aq_set_data_fl3l4(aq_nic, aq_rx_fltr, &data, add);
+
+	err = aq_set_fl3l4(aq_hw, aq_hw_ops, &data);
+	if (err)
+		return err;
+
+	if (add) {
+		if (!data.is_ipv6)
+			rx_fltrs->fl3l4.active_ipv4 |= BIT(data.location);
+		else
+			rx_fltrs->fl3l4.active_ipv6 |= BIT(data.location / 4);
+	} else {
+		if (!data.is_ipv6)
+			rx_fltrs->fl3l4.active_ipv4 &= ~BIT(data.location);
+		else
+			rx_fltrs->fl3l4.active_ipv6 &= ~BIT(data.location / 4);
+	}
+
+	return 0;
 }
 
 static int aq_add_del_rule(struct aq_nic_s *aq_nic,
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index ef9447810071..3cec853e9fad 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1522,8 +1522,6 @@ u8 aq_nic_reserve_filter(struct aq_nic_s *self, enum aq_rx_filter_type type)
 	case aq_rx_filter_l3l4:
 		fltr_cnt = AQ_RX_LAST_LOC_FL3L4 - AQ_RX_FIRST_LOC_FL3L4;
 		n_bit = fltr_cnt - self->aq_hw_rx_fltrs.fl3l4.reserved_count;
-
-		self->aq_hw_rx_fltrs.fl3l4.active_ipv4 |= BIT(n_bit);
 		self->aq_hw_rx_fltrs.fl3l4.reserved_count++;
 		location = n_bit;
 		break;
@@ -1543,7 +1541,6 @@ void aq_nic_release_filter(struct aq_nic_s *self, enum aq_rx_filter_type type,
 		break;
 	case aq_rx_filter_l3l4:
 		self->aq_hw_rx_fltrs.fl3l4.reserved_count--;
-		self->aq_hw_rx_fltrs.fl3l4.active_ipv4 &= ~BIT(location);
 		break;
 	default:
 		break;
-- 
2.43.0

