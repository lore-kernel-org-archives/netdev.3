Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1EB5678FD
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963996; cv=none; b=S++uQ0sOBg3sP3kSDJQypYf2pw8baAp1ck0u29ZCtVg+tB8BHqHC5KXhSovPrfK7YvdfIbLfhZNeY5tWU40bRjr9BETHz9x9pkvPhIykFh9dLm98NOx57WAYL/pDpHWEPg8oZsKn7/Gyw0VWg5ciy3vbVQcLdzEt2jxG9iqEwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963996; c=relaxed/simple;
	bh=KyQG3fqNgMyfWse8k/Dti2O/gJMM+CLJyWpXpFa3WiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChnIFtG3LWLftkTEivibTjetz/mr6T44tp5Dt7u4aVGQanT/rlRsCZDPi6V/OHJ+11qnarsl6hWhYMtohZeZQcgTM8GO7ZXQB2MvWVguG3tKDg55dYCqSTUWUCdmHql/vgezVF9mVu+r02n3P3EbOQUZdxYVks+kuUsLb7PrSsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bl/ZSY9f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a/pkuMe9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bl/ZSY9f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/pkuMe9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU7U12171738
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 14:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LxOgZcRvRYGuo3XQn/zJemLPSzBU5dwDiN5STI6YNto=; b=Bl/ZSY9fK8jYCkOd
	3j4EeMQEvopYtE8TN4Ah2+TBKXoif/Lhuxc7QW6VW4J9MnInt/08u/uBBJgOHQL4
	NvkG8BjtaIZWuaU4Po8sVz67jBYpWIfLfqhgfCtEeo+FUjlAs8oWjB22yPedtoIg
	Ko7XJfdPm1lnOBYuWgSPBfZ/Dep34ADNO2U7O8ZfSOjKwu5ykrH0SxKQeFqQD+KU
	NhGPOEDZGTOZcIhtFBR3w57IB8nHdrAsHCXW5ICtuSkEgcRKti1Wkv5TQPieeFCP
	hWi2UL7FY30L8x3pFcScn3wHmEsHQW6ltPZGoxbuACOYcnmKXuzmvrya1sKhPUbL
	9zItKQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5rggxfr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 14:26:33 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97e99615e0dso5128431241.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788963993; x=1789568793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxOgZcRvRYGuo3XQn/zJemLPSzBU5dwDiN5STI6YNto=;
        b=a/pkuMe9XmiihLrkmta1TMDbtUc0k4moVKmcLhg7PoNn5Wxfft2rQG/nm3RnmxQjiW
         PUHzWoGxUOpjvs6VBd/SgatdFpRy97/Vxch8F+sydZ4YgRjwaL5lQOqzDu2Q8gnQOBE8
         t+uWzQG8oXe7IpIJbiFqS/g5ZW9m2dX3dPC6eHKvDSfZLxxeBUL0qJ59Al6FWibS657w
         xc38XbaU/N3nuDCcYiSkNXUrYzayfKxaMTjX1Enslt4wEHlXZ16fIIT50XFYtmlHVGJE
         6lJT7J/bhhQIiLQjJfYeNqQcKZMw4pMjuznAe5HHzXFKSLTSteAi/BeTt/SBAMlk8bT+
         M0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963993; x=1789568793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxOgZcRvRYGuo3XQn/zJemLPSzBU5dwDiN5STI6YNto=;
        b=GbE+kpIucRTFTmDx2pUoRChSAfyv4gTnGsqgU650WJK5zzq6+ClKouyC9Z8ki+9nhI
         wg4nO3/eE7pBFfB1OuXtiLm00HXOYxtqaLDNLTdaun62JAJZTmDDp7pX+/7xXj7meckm
         wvR+Gy6xIgg13D/BQlHBQudMRH3hiRVsgBn33WEI6Ao2JCwZgqJE6dKN9p8fNJuRTYz+
         ACpVxEwcQTxjI+7FvofnzRtSXQPju1IFWIoI0QtyjomhzuvmCd8zp2OMpZS+Y/6z/4XM
         H+TepbhGVXw1+xha/Z9o2QJJfk33NEzonrIyDo35IVbzXd7FQZDCp+1cyPUk1mCy0RlP
         Q5Sw==
X-Gm-Message-State: AFuF++nuuBK16Bs4sYASTuT1cdPupUMTAbez9wvAsZR3tvHFwkoW8E0C
	M/744CieTNKGBoTVBsV3h3w6bwuF6USnhUhxqQmlLQ4LU+4KKYj3cNqgVhbeJNpLYqcfBUr2sy5
	+3LocYovUzlXc9z1iHpzuRqQqMmS7Ihb+ipneoS2glC6QZYgYnQz1sMACJJw=
X-Gm-Gg: AYBFou0z2j48gMc2cVu6QV7sXwPz5fAkMUVBYTTSvaPdtg61hA/JGkYQm3iXa/6qLhz
	OrK1iwYVLesedx1+RDyc36NR5W+MNes7hJsvyGnSSNMTJCGgj2uWQejaEAgpdOBCuImOd41vEpR
	Wnw5on4LqmHRav0rFAlbxMPcFo0Rs3TT9b8jpgOTxb+80QCOzTaLqpqjuzCe93w6XlOvE3BPa0d
	i1oBZy6BkAn8f0nxWlja7WjOUXA8UObpoD95MAmsWceYvUS5CFpd0hmTHwY+Yzy8du6n+L5K5bF
	oZlYG+Wc6KZIMQ94lLFsqmHV3xeiasb+6qXrIQLt2Xa4W9TeHzw245iTSQx/2xJMbB/naOGJfbk
	O2xyjyy8eB/4mGQ==
X-Received: by 2002:a05:6102:30c6:20b0:780:c9c:bfcd with SMTP id ada2fe7eead31-78a2f00e2a9mr8076606137.17.1788963993029;
        Wed, 09 Sep 2026 07:26:33 -0700 (PDT)
X-Received: by 2002:a05:6102:30c6:20b0:780:c9c:bfcd with SMTP id ada2fe7eead31-78a2f00e2a9mr8076539137.17.1788963991349;
        Wed, 09 Sep 2026 07:26:31 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm128366565e9.4.2026.09.09.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:26:30 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 16:26:10 +0200
Subject: [PATCH net v2 2/2] net: stmmac: preserve real_num_tx_queues on
 mqprio setup failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-2-8158b8333b3d@oss.qualcomm.com>
References: <20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-0-8158b8333b3d@oss.qualcomm.com>
In-Reply-To: <20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-0-8158b8333b3d@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2MCBTYWx0ZWRfX3dJU6lgJTQWt
 4AVRslOa3G2xykVQxEZjlRNwu5QOWqgk1YOlDRkZ5Vx1BZBiTdTCVQ2rm3ulRmYUrZfx0tmV+ej
 Wu5f64/ybKNUISAHc5kaV9FV1sTA0lo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2MCBTYWx0ZWRfX6TdbM2jbEmiJ
 7D/lCdedjmsHVGUqbBllPQ73Q+WdVIirk59H6AvmSFy20eZYNtsfvthOOZrc1/sD80CdP3UmaRG
 v9cRz2vrQj+0qzU1lKE3R8BFrpbyrQ5NZ1soLrTE0wHEdHX+lSZidpEkWvfZNLWSJbdd6HvbYsj
 IehhQ1n6TrVGMWQshHClQJIB9phksvMIvSJ99Uc7Kzq25ZcBuYfzcjY4/67eMuWwS7XOkTf4sK3
 rLbt1xipjqME4ClA/bIk3epPAsSAWZLbdHbDZIHaNs+tenoVbixQwDtiEkwGeaGyvEyyt2eWkRT
 DD8YoKjQawFbehjDDcqkpr+PV0lUUrpo4B09juDGBKkW4Tpt7kNkqGYcQi4E8GiZsj+z2DM/z4N
 EYUhjZyeSKFUOG12h20u7OPNb6r86uUL6kBBxAIRGXV/kTyspHJ/jwvLyOvl8GDyZI7RqXOB2E4
 O/ciBfA1HdCEk/nNFbA==
X-Authority-Analysis: v=2.4 cv=B6qJFutM c=1 sm=1 tr=0 ts=6aa16c99 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=0NSVpFHRlRhN2sU1BpMA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: doHn5hzdw3GPz8DMfiILi9IJcUuhYZHZ
X-Proofpoint-ORIG-GUID: doHn5hzdw3GPz8DMfiILi9IJcUuhYZHZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090160

With the FPE preemption-class mapping error now propagated from
stmmac_fpe_map_preemption_class(), tc_setup_dwmac510_mqprio() can fail
on the mapping step. The error path used to call stmmac_reset_tc_mqprio(),
which resets the number of real TX queues to priv->plat->tx_queues_to_use
(the platform maximum), overwriting the value that was active before the
offload was attempted (for example a lower count left over from a previous
mqprio configuration).

The issue can be triggered using the following configuration:

  # First mqprio config lowers the hw queue count.
  $tc qdisc add dev eth0 root handle 1: mqprio queues 4@0 4@4

  # Replace mqprio configuration with a second one that fails FPE
  # preemption-class mapping. stmmac driver resets the real_num_tx_queues
  # to the platform maximum, losing the previous configuration.
  $tc qdisc replace dev eth0 root handle 2: mqprio queues 2@0 2@2 fp E P

Save ndev->real_num_tx_queues before lowering it and restore it,
together with the TC-to-queue and priority-to-TC mappings, when the FPE
preemption-class mapping fails, instead of resetting the queue count to
the platform maximum.

Note that a failed setup makes the qdisc layer run mqprio_destroy() on
the new qdisc, which resets dev->num_tc to 0; that is qdisc-layer handling,
out of the driver's control, and the driver-side restore remains correct
for the still-active previous configuration.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 80 ++++++++++++++++++-------
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 5398616fcdfe..7d73b0c16f50 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1237,6 +1237,30 @@ static int tc_query_caps(struct stmmac_priv *priv,
 	}
 }
 
+static int stmmac_set_ndev_tcs(struct net_device *ndev, u8 ntc,
+			       struct netdev_tc_txq *tc_to_txq)
+{
+	int i, err;
+
+	netdev_reset_tc(ndev);
+	if (!ntc)
+		return 0;
+
+	err = netdev_set_num_tc(ndev, ntc);
+	if (err)
+		return err;
+
+	for (i = 0; i < ntc; i++) {
+		u16 count, offset;
+
+		count = tc_to_txq[i].count;
+		offset = tc_to_txq[i].offset;
+		netdev_set_tc_queue(ndev, i, count, offset);
+	}
+
+	return 0;
+}
+
 static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 				  struct netlink_ext_ack *extack)
 {
@@ -1251,43 +1275,59 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 				    struct tc_mqprio_qopt_offload *mqprio)
 {
+	unsigned int ndev_num_tx_queues, num_tx_queues = 0;
+	struct netdev_tc_txq ndev_tc_to_txq[TC_MAX_QUEUE];
+	struct netdev_tc_txq tc_to_txq[TC_MAX_QUEUE] = {};
 	struct netlink_ext_ack *extack = mqprio->extack;
 	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
-	u32 offset, count, num_stack_tx_queues = 0;
 	struct net_device *ndev = priv->dev;
-	u32 num_tc = qopt->num_tc;
-	int err;
+	u8 ndev_prio_tc_map[TC_BITMASK + 1];
+	int i, err, ndev_ntc;
 
-	if (!num_tc)
+	if (!qopt->num_tc)
 		return stmmac_reset_tc_mqprio(ndev, extack);
 
-	err = netdev_set_num_tc(ndev, num_tc);
-	if (err)
-		return err;
-
-	for (u32 tc = 0; tc < num_tc; tc++) {
-		offset = qopt->offset[tc];
-		count = qopt->count[tc];
-		num_stack_tx_queues += count;
+	if (qopt->num_tc > ARRAY_SIZE(tc_to_txq))
+		return -EINVAL;
 
-		err = netdev_set_tc_queue(ndev, tc, count, offset);
-		if (err)
-			goto err_reset_tc;
+	/* save current tc values for reset */
+	ndev_ntc = netdev_get_num_tc(ndev);
+	for (i = 0; i < ARRAY_SIZE(ndev->tc_to_txq); i++)
+		ndev_tc_to_txq[i].combined =
+			READ_ONCE(ndev->tc_to_txq[i].combined);
+	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
+		ndev_prio_tc_map[i] = READ_ONCE(ndev->prio_tc_map[i]);
+
+	for (i = 0; i < qopt->num_tc; i++) {
+		tc_to_txq[i] = (struct netdev_tc_txq) {
+			.count = qopt->count[i],
+			.offset = qopt->offset[i],
+		};
+		num_tx_queues += qopt->count[i];
 	}
 
-	err = netif_set_real_num_tx_queues(ndev, num_stack_tx_queues);
+	err = stmmac_set_ndev_tcs(ndev, qopt->num_tc, tc_to_txq);
+	if (err)
+		goto error_reset_tc;
+
+	ndev_num_tx_queues = ndev->real_num_tx_queues;
+	err = netif_set_real_num_tx_queues(ndev, num_tx_queues);
 	if (err)
-		goto err_reset_tc;
+		goto error_reset_tc;
 
 	err = stmmac_fpe_map_preemption_class(priv, ndev, extack,
 					      mqprio->preemptible_tcs);
 	if (err)
-		goto err_reset_tc;
+		goto error_reset_num_tx_queues;
 
 	return 0;
 
-err_reset_tc:
-	stmmac_reset_tc_mqprio(ndev, extack);
+error_reset_num_tx_queues:
+	netif_set_real_num_tx_queues(ndev, ndev_num_tx_queues);
+error_reset_tc:
+	stmmac_set_ndev_tcs(ndev, ndev_ntc, ndev_tc_to_txq);
+	for (i = 0; i < ARRAY_SIZE(ndev_prio_tc_map); i++)
+		netdev_set_prio_tc_map(ndev, i, ndev_prio_tc_map[i]);
 
 	return err;
 }

-- 
2.55.0

