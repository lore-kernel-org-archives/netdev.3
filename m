Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A24A0149
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196028; cv=none; b=jC/Y9kP3ekTYdUeaWg7sdx561qfqFsuMftVq4VHawKpCCd6uQZfK3gcLQ7edXDgQa+J7Z440mS6GLYli/W4YeVg4asL/OJxN8qGfTRMbpDSSUdpxKmvSmUwGMkR5lqLj/QW0B5yWPIBUDmraBweFln4mJBF8WPmJ3q53vL8e5VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196028; c=relaxed/simple;
	bh=J9HCZfvmQSuAtWtjDbZbwxcdKtxbjkXoBWfmolxiLq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P7h+SEO3KZ72lKuxeZSz1XqyttSGpcmMeBLlH2Ireleb0e5X+tqqK0m5ZVZIcTiSUUgLbXHI0WkiYkieg9uubt+i2OMPB0jhGW2vVEOF15+lfAeQ4Wf/aRYB0/nZOJRQvw5x11HyjnclCpHe9CSivfvf2neH2nkndiuN5Jw4fFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WrDcVwYs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FwcEEp1J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WrDcVwYs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FwcEEp1J"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VFqvMb3524309
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kWsWE2Tj4+vGczTIqCBIte
	lo2Bdn45ZNtPYeVjBV+wM=; b=WrDcVwYscGtAiyqQuY6yerA+F5Idb0jVo4n/gS
	zU/Ochtki94ese9kCcE9FqxSe4AF8JwtNsAwL0RLcnCZ3mbna0ziPKZyZ+ynxws3
	8agHWDXI18zIgLAdPIMb8kCjt+rtxQ6mbvtq8kUS/5ha1sV6b3YwXewObKNtLVSz
	FnF6moEIMXK3uHA3eyu0qjM8MYD7MvLZ3HXW04l58uanHbAwW9MdLKJALrcJpbMl
	DrkvDrO+ACO8bdASF3Vi2EWmaPfeW4emCb7NM10uOqfOuZsWylrNZGfAMhv+pUpD
	wSDYG9J8e3OtEZGAL5ExX/POu1n2Wpj9MWlkt6Jucj0+FRpw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd556thwf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:07:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9390ca1a9abso544274385a.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788196026; x=1788800826; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kWsWE2Tj4+vGczTIqCBItelo2Bdn45ZNtPYeVjBV+wM=;
        b=FwcEEp1JKVTr44HqtQcOTh9ld+BJas3Yz7HGOu9KTnrEwY04kShey/vM7k1Ot7gNh9
         2WqJbtiQc2gJODN5HRAQfKILt0/ntiITaV0JKYeweE0N/eE7ciqbM+VyQ68MctWdnyvg
         5I+aYWHQWqAhb7F0DdpjZqAbyZJMhExnsnbCvipyKVOnipKDtsfjTCm72BQnxdfUexud
         l0d1vAwIKeze8pW55CDyDpx3VNoWRkK21+SXHvoJvY6bw/nOVjFd38XL00kPC89QN158
         ZAxgCWAIIRykly///FAQwms3Z7gzMHlezrtcHjo4U8wPEDfhOYMCEbdSnGEJH1UUegUC
         hORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788196026; x=1788800826;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kWsWE2Tj4+vGczTIqCBItelo2Bdn45ZNtPYeVjBV+wM=;
        b=p/m83umLXjOH3G+47mg2yLPkq1zbYr73yMROUc+LwpdXgVCcCkQ2Lrlfh+rzkB/Rjv
         6bhFxw1E9N5LXzfBFxcXuoWxmIcas5M71f3pPLNlMFKswfuk+bjYgGDxOkRKDCjk4sKX
         FAhtQAjf0VMdEIr9EqHHc6T9hncU+kCc3VVZ7QiSYAwWvBWvb/WMa9DOjfGTsBI9CCG/
         p/Wy2x9P1kQWY9zX6N2KO4uvTc3id6hjpz2ch85+VcUQrCYvbY71J+ifcA9WbJ9ZJy6m
         bLchO35/B5MCt4nW7bOUQ7aaZXn4gfFqSNog8XB4k/a0lunOxi/ioiW0KGUV7qliHA2F
         4KfA==
X-Gm-Message-State: AFuF++mTeWaISZ0wtdmDU05GSF3VJheJ8pdbb3/qQI37G/LaB+xa8wRx
	afRkU34Ym6i0BBieTTuWDWzoNHd8yXH6P+X0STTOPkLs0S0Bats4ZcJkXpXXF+X9qnghUrEAnTX
	lIkTvay5ljixjudAxmYRdIDoEPFdBbJAeXuBrQw6r5aFd//N+DjHqmHXSm/KFNjamoX4=
X-Gm-Gg: AR+sD11h4Nd2j1Md0oP2IxzD2qHx/zbPjHf05czCEau5ieVJQBv+xCgT4PZLoYcPbHJ
	tfKkwbTBt2QnxZ+hfuJ58fk0dDILJ2VfdKn71wvCSf/4xdKx4um/D8GBsCHnk5KNdZJSTqC5Lo3
	7wXk7+X6twrFQ7q7OMjKtxF+KIrk7hNWoSpt1svxP4qCon9BJzAq8sHfXgaGEi31pducs1+HyyF
	Zc2skgTUXc6ojFu6C3e3t+TEJLfLSSAl1cBs5WilcLefykjX2OdkB3EsJ4mDbF+WwPEiaYAbPa2
	cSlACKeVcJ6+WkFrD3GDpd/47hN+pO+UV0EtVYnDT4GWLruGgX2SnWxcI9Q8R4lMMPw+mRRr98T
	b+jna469Sl33G2A==
X-Received: by 2002:a05:620a:27c3:b0:939:e62:bf0c with SMTP id af79cd13be357-939137af559mr3428180785a.4.1788196025637;
        Mon, 31 Aug 2026 10:07:05 -0700 (PDT)
X-Received: by 2002:a05:620a:27c3:b0:939:e62:bf0c with SMTP id af79cd13be357-939137af559mr3428167885a.4.1788196025134;
        Mon, 31 Aug 2026 10:07:05 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1a3fesm5455835e9.12.2026.08.31.10.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:07:03 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 19:06:38 +0200
Subject: [PATCH net] net: stmmac: reconfigure RX packet parser table in
 stmmac_hw_setup() after reset
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-stmmac_tc_cls32_reconfigure-v1-1-21cb459e64ae@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MUQqDMAwA0KtIvldoK07nVYYUF6MGZpWkykC8u
 2Wf7+edoCRMCm1xgtDBymvMcI8CcO7jRIaHbPDWP21TOqNpWXoMCQN+tfRBCNc48rQLGVd/sLL
 WNf41QB42oZF///0NkRJ013UDz/UCFHIAAAA=
X-Change-ID: 20260831-stmmac_tc_cls32_reconfigure-17bc5001829d
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0OCBTYWx0ZWRfX8gR2QKSUOom/
 pyJvtnJkVhD6gj/nzr9X2XecqNF+oJzvRX75yZ3jY0GFT0ch+WvwUVAIBvlCRUxPj1ZXQ+ZMR5t
 n2Al3l+hlrewMtVG1YtipHDhW9uxZ3g=
X-Authority-Analysis: v=2.4 cv=O7sJeh9W c=1 sm=1 tr=0 ts=6a95b4ba cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EO0qJuiELdOth16Gsj8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: mcGyQgTWO72BiGMZFraDjW95iCXL4a3i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0OCBTYWx0ZWRfX9LXi0bNDdt+2
 W+Zmt8mgZjB5ZzSODREngblmNAiva06Np+aViLziJ/2QI0a5FxVTZbzzO8HFE/CCo3T8YBBNQP1
 WRc8VUSEnSWfBqkWBrO1BIZajjv63YZwGMes+54d1I4COKkjWd9AC2cyFc/ncxlKMRWffq17RxI
 kVE4QyHtf4tBM30/QALFWawt7QRp4or2QGnDQrshShR7CrBi4XAhtQul4RGTf+E82TUfIDyocUs
 rPRiz0+p9HVirwoSZo9qarZlGPuyZVfTSHj/hEmgRjhFluAkEPF4O803+7Hrjw1yVi7Ix21jT+b
 gytKjkQ0QnhC8H+3YiOhhuggkv/uqmNzD7YyuODoqyuqDxtJDfBDaNJ1ecxLKxieh92UI5cSXEG
 SGZAnD/Vlu7RvcIkJQ3WyLXW4kg7YzG/NtF0VC3N3zHn68PI/35x4en/IEGQIzHeWdZ+rmHHtNH
 dKD3BB+abkEit63X/FQ==
X-Proofpoint-GUID: mcGyQgTWO72BiGMZFraDjW95iCXL4a3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310148

The core software reset issued in stmmac_init_dma_engine() during
ndo_open() callback clears the MTL RX packet parser registers, but
stmmac_rxp_config() is only invoked from the cls_u32 add/delete paths.
After an ifdown/ifup cycle the hardware therefore runs with the default
all-pass table while priv->tc_entries still reports the filters as
installed. Re-apply the RX packet parser table from priv->tc_entries in
stmmac_hw_setup(), right after the software reset, so the filters are
restored when the interface is brought up again.

Fixes: 4dbbe8dde848 ("net: stmmac: Add support for U32 TC filter using Flexible RX Parser")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d576059c04df..24656b35350b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3676,6 +3676,14 @@ static int stmmac_hw_setup(struct net_device *dev)
 	/* Initialize MTL*/
 	stmmac_mtl_configuration(priv);
 
+	/* Apply the RX packet parser table */
+	if (priv->tc_entries) {
+		ret = stmmac_rxp_config(priv, priv->hw->pcsr, priv->tc_entries,
+					priv->tc_entries_max);
+		if (ret)
+			return ret;
+	}
+
 	/* Initialize Safety Features */
 	stmmac_safety_feat_configuration(priv);
 

---
base-commit: 1376afc7660bad2a1a5ee0876898312a486cf8bd
change-id: 20260831-stmmac_tc_cls32_reconfigure-17bc5001829d

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

