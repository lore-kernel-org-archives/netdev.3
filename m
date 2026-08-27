Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511E49362B
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814757; cv=none; b=d2/iJKXTaWdtbErBtFDfu/jtzfMstdYPeavfRYDj7w0/CKDF2wTi3M8A7xG+feW6K7C2gfhJsyL+tBPMtmq/wQXLSew7rCuoq4yBJCv9nv5ztvvnDutb2nCpYM7nJFAoDVDgTHtuA0e3BfDHyk6VtOy+BbRvaqktVX8cM3m6BbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814757; c=relaxed/simple;
	bh=xUSjSRwGFAdmrIwybPZD5/Yji5FlWxfcGH61ABWgEpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lkiIFFXEVD5KdxRY+xmlAwaGbLkyhIbS3/Y37i0sYggJa/gFsDd0L5Mei2LFHtOGjaRUcBOYH6FmrVTAC1Uua+MRg/2ssPL/shUQAAQA1A9EAq0xMRsZ6Ic1LCNuXygyIMHYlUtb4GmbE9KpRCDIeHwwUaWqrto6aJkPuDGF854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VL4l6mIa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EbM6XXi/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VL4l6mIa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EbM6XXi/"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R2wv2619437
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Mi+Svbuqx9D6XBJSnUg0zv
	QizCn5oa9oDvU2DwzH9oQ=; b=VL4l6mIay+UDayw2kICVhTZ0DNh8q7Zj/iM4ef
	FUSFgSFVo9EB2m645Vvm4Vhp8zG0TtsuQ+U+aWel/pixaChj6W+R1/GI8TNpo+48
	rsKYzFeBaitRcUN5+rvpsz4glD3FZRQc7jADGyMCUtOrXKLlYjJILMDUHxBv3Trh
	NyVHD0sPowDKhsnHe2ZU1kmHs9wdEm2enTOiUq5BWgU2r99Bj2iZx6daCCmwosYF
	aJ8Cw3ec63hBqcqVjDuLI3CAhgjfvXny00lv1BWEUre7Kdi3QnqLQAOulioIAfJe
	rSloa3cDWVnqG2wp2+6T4Vn6Li37d81MqrvJCLGM2OmaMIhA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03u3r6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 07:12:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52f9f6b85cbso8794431cf.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 00:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787814754; x=1788419554; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mi+Svbuqx9D6XBJSnUg0zvQizCn5oa9oDvU2DwzH9oQ=;
        b=EbM6XXi/V8EfPeifEYO1jSHY1FfLXyXGqQxyBPEWJoGLBF6kMcXRJEsShmXgWmodEc
         zWK24MHBFrzt4wl6km4fH/WRDiLtY01/DZOd/3SkwAEggxlgbQeogHCehS3avhBYBz9E
         FlWVRik93zk+/B7ifrL2+l8Dt3Uw/BntSSaPXHMQ/VXk+kU5Uh7qoXHNNt4l1M6+usCb
         /b7SWWErmybBTZBigLlBcqWrD3+OXT8giyLUz63Hkcnbf+idYzCMBpYuwm/4uhcj9Xn7
         3BI5FwySVex3c4ASOXnLiEEmUe5H2sHN0hRYQzgYJIUHuLnoY1h8KgKYGWZdRRATlX+u
         FTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787814754; x=1788419554;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mi+Svbuqx9D6XBJSnUg0zvQizCn5oa9oDvU2DwzH9oQ=;
        b=ZL4MhF0NRMwDzHht74wVtw+dqo+sV9YLoOuv3nCiU8CoyV0JueNRDp/ZYJwujRy+wm
         SRxZB1x3YPi5hw6Exf2e2/b3eyEgeu1rhgjgoBX4GOH0vIcL3PXtvLNeDCLsAQ+snuDk
         1W2jrBlSoU8VkgvnhFxco+s7xdIWV7wNjiRcLxu6JmahWKqgd9r64xIlewce1S0D5uGn
         3GGTJ+WX8YEvkayihjhFpr6EKrTjpcm2ZZElP96PjYn6hbLp/z3aPkJNfM1NiCviiG7J
         EeY/ey7vZ2lhcYirPdOYCwl3GcDa+kM++4xoPC/2w8hFJzeRm6AO7adsb+mJnvEGsDmy
         YBNg==
X-Gm-Message-State: AFuF++nan6QF2/9sVLlTdvpDgrrt9Jr/IOH9OzGOFj4c/DAonn2U2fBB
	deEvmdnljq4iUfJ3L7M/xQ1YXJhFRFV3i+4Q399bpE/n9eRPBuUWwk7ix58sMwTSMIwPARSlPKV
	p2fGyz40ch6k2XwdboBPmTsKdYzYV9fu2/e+x2CzeXwP05Ps60NXUaZtLROQ=
X-Gm-Gg: AR+sD10OjT5jr/7u1LEMEinyc7vqxGO/HkKEuyuIvHR/6ishy4hptpaons1iM36QC+h
	ehzHATGNkZay/Sm8kGkU8gZp9K4GbRev3/h4EjZLvl3TsrYQa+t4e9bG95bWQr4/HFHhHsYgppE
	1EwRLg1pKGgZwSgELraA9BuPA0XCQ3omga4dVgjpqGRr4+Skn6ZB+buh8wVtGcy498ICM96vtSC
	LUamJWKcfcA1NGtBcPmtacGIgrCMHyeitUe22qiMrsfAJi0urL57Wz5uxUZdc6GnfK6IMFr8G7+
	c6wkYogEav+FzdD6ByKQFzfpe20d0KyubPqNtqTHtTc1+GbHR0xNtbLw1nLIFT8rUuvKtqILvPs
	3UCeRSRSOcagk0A==
X-Received: by 2002:a05:622a:13c6:b0:52d:d12c:3eee with SMTP id d75a77b69052e-52e423462ffmr129777281cf.23.1787814754141;
        Thu, 27 Aug 2026 00:12:34 -0700 (PDT)
X-Received: by 2002:a05:622a:13c6:b0:52d:d12c:3eee with SMTP id d75a77b69052e-52e423462ffmr129776791cf.23.1787814753562;
        Thu, 27 Aug 2026 00:12:33 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27ab6d0sm6637501f8f.13.2026.08.27.00.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 00:12:32 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:12:15 +0200
Subject: [PATCH net v2] net: stmmac: hold runtime PM reference in setup_tc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-stmmac-setup-tc-enable-pm-v2-1-a9b8a5948f41@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBREr2L+2k9oLSCuvIdhUcpXmtAW+wvRE
 O5uwwncTPJmMjMbMEVLDLfTBpFWyzb4DPJ8AjNq/yK0Q2aQpazLq1TIyTltkCktMyaD5HU/Ec4
 OhWq1rurL0LQN5P4c6Wk/x/YDPCXosjlaTiF+j79VHNEf06tAgaoSjRykElr198BcvBc9meBck
 QW6fd9/CdUNkM4AAAA=
X-Change-ID: 20260824-stmmac-setup-tc-enable-pm-149aa563d797
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1OCBTYWx0ZWRfX0pcTf2c6mqpJ
 uDAiziSaHYY81RHtwAlkdYvnDVpRmMkaMSg14lxt7jnvlTcljSD3ohxO/EBGZ1pVkP1X1hZJ0SF
 YLAsc9L96uYSA9bjbdq1NynMntsWxdCGxmNfXEYsZ7xHjmtZ4NCZGqyHKPejzvi1NOYmjG2qGHp
 Ht59MALfM38HQyyPD9wNZGtE6RJdxYzoku9JKMG6bEGenqY4AcFSYbNpOXz4m25uLY7Nr+BFL08
 oTqIlMPNqTJt75fQV9UOdL6pIWXxNrEn04RUoW5ScNsPsNljTbAbASAMhNdMI4VWzeqJKmabXWw
 DfL0jXD22oBK6st/lVRACma8WgJ80GbdYT0ZyJN4RJ0uqySmrIFOeOCq0Q3tLZZT4dFQIcyCz4q
 bfSg4SfaOmTb7b77+muP8aFL/ddks80unEYvYcCF/0B8/35nnU4Aqim0Y6NhykkyDdXiDzg82r2
 vpl5JRf5dvSV8kb2QIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1OCBTYWx0ZWRfX+tQCeQE9i0a+
 r1j3YhMf6JYuQ9n0qiETz772sDAJqqTOV14vSFSEohUFEAVpn5LlRRMlqNdqDQp+4RkuYYLYJQE
 nQiaSe0qdPn+tDzy/Ihu4AIZGQVRDYo=
X-Proofpoint-ORIG-GUID: cJQhUa5LdGcIQpIQyKd5uBU75JWCPu6g
X-Authority-Analysis: v=2.4 cv=RcqgzVtv c=1 sm=1 tr=0 ts=6a8fe363 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=O7mAVgsXz2YliqE_5DUA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: cJQhUa5LdGcIQpIQyKd5uBU75JWCPu6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270058

The qdisc offload callbacks invoked by stmmac_setup_tc() program
MTL/MAC registers, but they can be reached while the interface is down,
when stmmac_release() has dropped the runtime PM usage counter and the
device may be suspended with its clocks gated. Accessing the registers
in that state can trigger a bus error.

Hold a runtime PM reference while configuring the register-touching
qdisc offloads (mqprio, cbs and taprio) so the device is active, and its
clocks enabled, whenever the MTL/MAC registers are programmed.

The TC block callback stmmac_setup_tc_block_cb() programs the MTL/MAC
registers as well, but it runs asynchronously from stmmac_setup_tc(),
outside the runtime PM reference held there. Hold a runtime PM reference
for the whole stmmac_setup_tc_block_cb() call as well, covering the
cls_u32/cls_flower setup and the queue enable/disable accesses.

No reference is held for the TC_SETUP_BLOCK bookkeeping itself, the
TC_QUERY_CAPS query or the tc-etf path, since none of them touch the
registers synchronously. In particular the block bind/unbind must reach
flow_block_cb_setup_simple() even when the device is suspended, so the
driver never leaves a stale flow_block_cb on its block list.

Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
Fixes: 4dbbe8dde848 ("net: stmmac: Add support for U32 TC filter using Flexible RX Parser")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Return -EOPNOTSUPP in stmmac_setup_tc_block_cb() for unsupported TC
  blocks.
- Link to v1: https://lore.kernel.org/r/20260824-stmmac-setup-tc-enable-pm-v1-1-45172d241a4b@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 35 ++++++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index efa35cfecc4f..90753d5af6d6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6393,9 +6393,13 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				    void *cb_priv)
 {
 	struct stmmac_priv *priv = cb_priv;
-	int ret = -EOPNOTSUPP;
+	int ret;
 
 	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
+		return -EOPNOTSUPP;
+
+	ret = pm_runtime_resume_and_get(priv->device);
+	if (ret < 0)
 		return ret;
 
 	__stmmac_disable_all_queues(priv);
@@ -6408,10 +6412,13 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 		ret = stmmac_tc_setup_cls(priv, priv, type_data);
 		break;
 	default:
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
 	stmmac_enable_all_queues(priv);
+	pm_runtime_put(priv->device);
+
 	return ret;
 }
 
@@ -6421,26 +6428,46 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			   void *type_data)
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret;
 
 	switch (type) {
 	case TC_QUERY_CAPS:
 		return stmmac_tc_query_caps(priv, priv, type_data);
 	case TC_SETUP_QDISC_MQPRIO:
-		return stmmac_tc_setup_mqprio(priv, priv, type_data);
+		ret = pm_runtime_resume_and_get(priv->device);
+		if (ret < 0)
+			return ret;
+
+		ret = stmmac_tc_setup_mqprio(priv, priv, type_data);
+		break;
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &stmmac_block_cb_list,
 						  stmmac_setup_tc_block_cb,
 						  priv, priv, true);
 	case TC_SETUP_QDISC_CBS:
-		return stmmac_tc_setup_cbs(priv, priv, type_data);
+		ret = pm_runtime_resume_and_get(priv->device);
+		if (ret < 0)
+			return ret;
+
+		ret = stmmac_tc_setup_cbs(priv, priv, type_data);
+		break;
 	case TC_SETUP_QDISC_TAPRIO:
-		return stmmac_tc_setup_taprio(priv, priv, type_data);
+		ret = pm_runtime_resume_and_get(priv->device);
+		if (ret < 0)
+			return ret;
+
+		ret = stmmac_tc_setup_taprio(priv, priv, type_data);
+		break;
 	case TC_SETUP_QDISC_ETF:
 		return stmmac_tc_setup_etf(priv, priv, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
+
+	pm_runtime_put(priv->device);
+
+	return ret;
 }
 
 static u16 stmmac_select_queue(struct net_device *dev, struct sk_buff *skb,

---
base-commit: f967455fb2a5a2079b9eb5823e9ccf359174bf9f
change-id: 20260824-stmmac-setup-tc-enable-pm-149aa563d797

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

