Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79013264CB
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787992165; cv=none; b=r6Ddu1+9MfEH7DHzxLMEYGsYpYL8HRBmYv8mdKhwzIFlmf6zVCsw0qtTvur6of1CK5+KT7Y6ofz80Z9QG9wJm2JSX8TemESeGDFBinA13BZH56ZVwo8xoj+OAtjFrRbDkwOQyMqzz1DynD3HfVHAgd8aj9Ie1UX3vhk/kaYp3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787992165; c=relaxed/simple;
	bh=08sXDyGSU4xQ+etUyeVsu2g+1cVjdVJzGXqOfnny3YM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6hEsbRRqT9pGRWQh5uStuDdcE5UYuSUO9rqKmBnAPIsnFpXloMU0/1tceAX0X8dM1N/MNCDcPe7N8J6hLOC6+eNoK0agJqaLocg0WfmBWqz1of3aI6g1OzC1oLQ2tfgggromIKb2a5skAVi3I7VzKqCQomHeXbw6AnPM/1ImzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bn6nQx7e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ho/isq4O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bn6nQx7e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ho/isq4O"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T802Kq1353061
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eleVcLontkK7Ez1NeoJaXJcOarHQZdCSrncowtlaLBI=; b=Bn6nQx7epfxonEsd
	qX+Vtjefa+TFtcp0Xnqd3ABAq5OLDJuBUHVF0M4FZts2QKkeeM7d7mq4ffY4sw8m
	SiGlLQEAEj8smwGatVoq+4/l/r06mAlffmL9KJebv+FlwsZVVt4lbouJ93//1wzH
	8mYHz2n4yq2MO5iveXz7hZkDHrTDVi2xYw6aiiKK0IYec2QdIut340Fo4x0fAfnp
	eL7XDzpYSDIiYo8dhZ42tZVXL8sXaxGAdtoSqspmj6xrd2pdqMw+MGw92QnON+Jj
	kxAgJCtBummrnPK5lFfJ04fQ0Y9+Mk+MQv/uT/SBL466YLltqR3KZsDKv3dYvsS3
	O4ZegQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhw8h2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 08:29:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52fc1e88189so24231751cf.1
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787992162; x=1788596962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eleVcLontkK7Ez1NeoJaXJcOarHQZdCSrncowtlaLBI=;
        b=ho/isq4OKlX8WKovoeQf9gHd0LjMtGXBZgwuMJSMspTcfidnUP9+dTjPzri/xLzRQ5
         W4UpoUIRGdVgFj1dJrM0kypTcjL1VyD3+WJVChTWepDrDVXTONBu1/16HgA0nB2knaph
         5f8GiQCrqqgBiOeR0APQZiCmjtuROS8VCNyNAP1dVOI99zMscbL+rDBiyyxAi5Zs8vLl
         8spTaBlJ8EeWMTL8dPFjBpA5/ctTDMkmpKcmy9AWFSlyVIBSfEi9qxaTAvE5AnTiLLbl
         zxu/2HQNYZkV1JZaw0shfDvz68+F7u6vKlhmNv/nTN6iusC2hnjeoidhMosUL5tvYugi
         lHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787992162; x=1788596962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eleVcLontkK7Ez1NeoJaXJcOarHQZdCSrncowtlaLBI=;
        b=I/Tzywe8OLH2nLd6EUHx8hHiEte4c3np9lJw+TggUl55s8lhGCVSy+HvqD3eLGmrYK
         ROWmwo/NsYUnLFabzeseiljdoi/2qJFEKOr8SO7EYIRsQiD0EdZzZroJjy9uBKtmmbtd
         Fk8NOBLq2xi/qJYzfW4VCz7AgOIwj0vYqWq17kLs4TlSltgPQ8UezdC38GtsC06CVECq
         oNS+7X6gnzsRBhmeOtU4Z6d69sjFxkn4pubFfw7my3XwCX5A8CA4WE2UDd5+IkHT/4xV
         k0LGTSDxa9hLGR9c/G+c2buwSfFakcvCuDRRIItrytUdFSPdnYvBoqlWLi/ciW+8i+GE
         FCyQ==
X-Gm-Message-State: AFuF++nAt/LMmvYn114uUrBNc11ukN5BIVMkL/MzdM9FJlZyQJaDKr/8
	LY4IAULtYKiuEk9/b4aDYCO+kmsqg30V8GlZE5Q5kM62pXcOJTAKA9Kl2QEJLYGpy/t1AHOzMGZ
	Jyvd+I79dv7Eovg8WmlIKVKplIWI3WKwiFJxDj0kG5XVGs/G1d7DSibGtzYw=
X-Gm-Gg: AR+sD10aRr7wsmlbWxz0tyfluMpjAJtYpcjeuE5xvj7SofxpuyQYtRU0OvMgr9Ighva
	Hos7C6Aol26vPYcZwC5TaPELfPAkmAMIWqKiHDukTZUwYgj+Uv2SPZegnEJZA1cguyFL3+8V/U3
	n1CLrWlXpMCvtKbU0gNyE/Ml3FfYpUAsF378EOnSFmB54N606Nix0fJF8uGYvCpqk20StvQywww
	HworHq+a6RffBX4yc7MvIlgG0jL4XFIpM1hs1ZqTJPBq14PdjzTv2Tqpl81j5tlH2nMNb4e8kUe
	X0yJSK1A/bkVKWTrpbcaL+du+AG9E1k6zYXoK/7ufy7R5uK8XUtNagHAfMXDPi5rA6QdI9tmZST
	eZu9S+TZaMjaI4g==
X-Received: by 2002:ac8:59cb:0:b0:52d:6de2:906c with SMTP id d75a77b69052e-52fb94297ccmr149837041cf.14.1787992162119;
        Sat, 29 Aug 2026 01:29:22 -0700 (PDT)
X-Received: by 2002:ac8:59cb:0:b0:52d:6de2:906c with SMTP id d75a77b69052e-52fb94297ccmr149836681cf.14.1787992161713;
        Sat, 29 Aug 2026 01:29:21 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb34ae6sm10017652f8f.37.2026.08.29.01.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:29:20 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 29 Aug 2026 10:28:49 +0200
Subject: [PATCH net 1/2] net: stmmac: preserve real_num_tx_queues on mqprio
 setup failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-stmmac-fix-graft-overwrite-v1-1-a4f84c4c264e@oss.qualcomm.com>
References: <20260829-stmmac-fix-graft-overwrite-v1-0-a4f84c4c264e@oss.qualcomm.com>
In-Reply-To: <20260829-stmmac-fix-graft-overwrite-v1-0-a4f84c4c264e@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: pzSkfx8fp2RKeIDljPFirZKjSkGkBxlb
X-Proofpoint-ORIG-GUID: pzSkfx8fp2RKeIDljPFirZKjSkGkBxlb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA3MiBTYWx0ZWRfX5u1h7sSCNnVg
 Ymo6I7BKdgH4TzobNOB4g7MYbfIidl0Y5b36fW6X2wlol6C7katPcvEQr32cNGUVgawQAScDrAv
 YViuMAFkiKoqKd9m6Q/s+/9IY0TE/KI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA3MiBTYWx0ZWRfXze2MdGKYJ2cO
 Eoj96NgSqnpwHITepwQWqshdN6nwcrSlxDA2eQkmIiEb4//vPLpUC3CW88cN3QxbKL3sLUMIQbq
 b+TXENe5leoxHHcCmIRG2KwajMoJFs9BLEStqr3x4P2zW0KyrRXLkFjOm2cN1r0YwFsDrHrBH4Q
 Q6icpvyl+XEjGp03jg4606OmkQdWykGOSUja9PTco7aANQh0A3lsEksqRxdDfp7BoXMX9tboGpx
 BOHhBOCGJeD6qWt9sd1aNbf4OPmXfIufK6Tb4fgu1Xp3f/udS/992QWCvKJFi3GXboE1fDQ0LYy
 Xaru+JbM368s4+3X32t1y52zsgi3xUzB6lQCRXf728nFS/DWojgTS4mjXi5GsKJvoFSnr0yy7h3
 x1xGzmKBGub4RYKCgW8ToXbm3FupCqPKlGJKtRbBntS4XG7nu1RXNTDu5NwR9UMDWUZB4JnGUXW
 fKNJhYxkGvhn20+sfAw==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=6a929862 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=dfU3YGO4DwT6tcRypCgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290072

In tc_setup_dwmac510_mqprio(), if stmmac_fpe_map_preemption_class()
fails after the number of real TX queues has been set to
num_tx_queues, the error path calls stmmac_reset_tc_mqprio(), which resets
the number of real TX queues to priv->plat->tx_queues_to_use
(the maximum the platform supports).
This overwrites the value that was active before the mqprio offload was
attempted, which may have been lower than the platform maximum (for
example after a previous mqprio configuration reduced the queue count).

Save ndev->real_num_tx_queues before lowering it and restore it if the
FPE preemption-class mapping fails. Drop the use of
stmmac_reset_tc_mqprio() from the error path: the queue count is now
restored explicitly and the TC-to-queue mapping is restored to the
previously saved values.
Introduce stmmac_set_ndev_tcs utility routine.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 75 ++++++++++++++++++-------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 14cabe76e53e..be8ddda2aa76 100644
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
+	if (ntc == 1)
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
 static void stmmac_reset_tc_mqprio(struct net_device *ndev,
 				   struct netlink_ext_ack *extack)
 {
@@ -1250,45 +1274,56 @@ static void stmmac_reset_tc_mqprio(struct net_device *ndev,
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
+	int i, err, ndev_ntc;
 
-	if (!num_tc) {
+	if (!qopt->num_tc) {
 		stmmac_reset_tc_mqprio(ndev, extack);
 		return 0;
 	}
 
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
+	ndev_ntc = netdev_get_num_tc(ndev) ? : 1;
+	for (i = 0; i < ARRAY_SIZE(ndev->tc_to_txq); i++)
+		ndev_tc_to_txq[i].combined =
+			READ_ONCE(ndev->tc_to_txq[i].combined);
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
 
 	return err;
 }

-- 
2.55.0

