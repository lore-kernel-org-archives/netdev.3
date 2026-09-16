Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E924386568
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572335; cv=none; b=A/IKe1o3PacRu4woxTXa87JdJIaaEDJzyN71zG6Sntc3mlzah8/DA9aFkXGU1Yp+vpUN0rtmf3EvP60300z/+LkjTyG5ecp1iLSbKfryBgVZ/Stg8cYlGtsJ3JT9aiI+1JSOiJJYzY4glPyUqvlPvrnoRU0pjs3dQoo0Kzcod0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572335; c=relaxed/simple;
	bh=2W0TwhuMySQvaR77SSSh55jEdpJlqkuLRl3CZC7LARg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EJ9slkOLMSoHh3nDyfVIN9BSFhO8TTR4XRvqL4NsJCtxkYO8ur7B1OpR3UD1TutmsVI6oWoOC9G5J9XOz6K81SVAeXQz6rLlQT3nNz9+I03FBJmtnsi1uJar7ZaqI3sDwMWWPhX9U4OBBqy/Eb9FpARN/xTuT/MJoDYHgECjgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o16H6UKW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yet/ocef; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o16H6UKW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yet/ocef"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GF9h172935058
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZkC6dAImDRSxbfI8Gyu0PL
	BQyX0+m8Svrvoe8yIAMxQ=; b=o16H6UKWym5Ywe725ILwTKjR5AUBWEe15DmBNs
	HAff0BT9fnPtsVNYZDWg6Qg2twpojwBXc/PwDPUaQdZUX5TMTx6zDNZ9XDR76qpm
	f2OpdXW036tiqM0fAgTj88rARhkG/WtCLmnzSlE8FpOPMarhmA65ZiZW2hhja15x
	Q9xreUXcqpTB8Iqp+rsc2Yov9G0vroDAWLxXhpKpSMOcoOuVK3G4q/OR868V5rzf
	39lAc2Ag+08iv24Q3TAb5sJqohajPI6y+Pz3H0Ikb2hvV9ZvuiekuhM1tFju4gLH
	KIGyDbqPKL7K52ivk8qvTXdyQwNnavzphyN1GQXLHYPrPu2g==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqkv7jr2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:25:30 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c7a31f3af5so1981222e0c.2
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789572329; x=1790177129; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZkC6dAImDRSxbfI8Gyu0PLBQyX0+m8Svrvoe8yIAMxQ=;
        b=Yet/ocefdtRY2kRDxFEolD3yPGROZD1DWRyt2KZFC+qhxIUvQSoLMxfT38RfowMY9v
         lOwQbpISeT3kSQ5Po+0di9/2wqgbdb0JzaBbw+wdCGtt1F/y7uFZw3jd2gJBtfCeXpeW
         QLsRqZ9aOhyMgngJfv88YK2S7/S6Q43yJs5oAH9qOKgujEIINNy4dUvxvzNo3gPShnZo
         mLFkA0Bmmlx5dnV25+TDvlrsQjXIJ6KdKZTJUmVayObZC/AlNkQv9LR2l+CSx+b3HWAB
         WxqTWzWg4wBN5/CAfQO/wPj6sX6b27MGwKjpIGK2UEqvHfr9jWsDxckMv3o2chsxlcgw
         0mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789572329; x=1790177129;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZkC6dAImDRSxbfI8Gyu0PLBQyX0+m8Svrvoe8yIAMxQ=;
        b=bVstW/CnjTmevzlG/+jpEgsWxnCLpX7hd/xAWQIihDRoB5rumeks5kmBlhwJtksxgX
         xeGByxorAz583hZnOfXBzaX4siuIIe9f8qMnmMhq65NmELGo53ACrsvAcqSYQSY+AZjq
         wdlc8LpiefG3C54478eUwhED+yVZ6OazUCaWRwxydJCP5PrD42VaPlolO9b9QmSEg+Be
         jzFgs9UuSr2B2+XIpbpm3j57eWxbq0kYwm3jAwJil+CXm97qr+oMelfwrj2kDGvXDV4m
         N2qF5neOgEPLJ1NJ5osBFz23V45I78ZYITg5Kmf9YMsqtwKZHbBm22cT/6wCrqS7POhp
         JvQg==
X-Gm-Message-State: AFuF++kYDFcT4g5bzi/3Dm4XglWEBnkZLxqK1IAXZxXxVcFGAJaToDxM
	kBF6077f4jcC6VaDIJuo6qOK8gGrksqod4yUFroNFl4hl8vu5DFkheNvfACUlg1nQS23P3nnqUw
	IQ/tS2TMze0f+2QE1cv6RyGhK9fJcSgEzg0+IhkwbmK5NlO4J2Aky/kiCMrMm3tTtLiw=
X-Gm-Gg: AYBFou14DeUa0julSTa++InQa8VbgbbQ4sx24Rhp7XM/ukLTPMDQPWARwvLifOUcbv0
	RUFMTvIaYBIbMN9t9hUnuKFhvCaBrVsXGLC2gnNyQ39+aikjgREXh6ZGfJ6OXQ0lnuRembXUpHr
	X3tnpsNuTHCiwPgaaPhOT6QXryu9slppA0uqzrMo+e2wiheIZ6uc35zeyLRKX0Ozmp+h19eUL89
	x6o6lOzcY5z10iljG/uwREj+USI2CwML+QPet0pfz+3kgYLumUa1+9izpx/kbTvzkLPrsHFtwuW
	4ZG9jSzA1KGKBytb46ED8swFyxQ5ETX29P0cfo3WWiPpHxhMx+WqNJU1APpqzgCZhOaUQ6LyPdx
	ACRe40CPMAx7DXQ==
X-Received: by 2002:a05:6122:3310:b0:5bf:7f98:9657 with SMTP id 71dfb90a1353d-5c99accd48cmr3861692e0c.6.1789572329323;
        Wed, 16 Sep 2026 08:25:29 -0700 (PDT)
X-Received: by 2002:a05:6122:3310:b0:5bf:7f98:9657 with SMTP id 71dfb90a1353d-5c99accd48cmr3861532e0c.6.1789572328756;
        Wed, 16 Sep 2026 08:25:28 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm8971364f8f.1.2026.09.16.08.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:25:27 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 17:25:14 +0200
Subject: [PATCH net] net: stmmac: fix rx Scatter-Gather support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-stmmac-rx-sg-fix-v1-1-b49b7b8f725f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W9gmiPoV8VBdnT04ZRURZH93e
 EwgeUE5CSsM1QuJb1E5YgFbV7BsFAOj+MLgjGtNb1vUa99pwfSgBlzlQeq88x01MxkLJTsTF/0
 vR4h8wZTzB1ljzM9nAAAA
X-Change-ID: 20260916-stmmac-rx-sg-fix-a8d2d8a3ba01
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
X-Proofpoint-ORIG-GUID: v7OT0vVh6Ti34a2eG-dC8MWvcsPlUwEq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwOSBTYWx0ZWRfX8uRg+kx2D3wC
 Bc5TVBSZvnN4f8Uxgvz9Y8NVmXVmhEea976+jGHEAL6T8GOpatLVqQ25Bmn8JcNQ7mn06zv4MXt
 U/rFKIzdQwtdb+SH/yMvw5NNVoBA1EWeU4+jHvOo6fycHKl/UXmWPTEcoUxm8Vao9mY0JJ74SZm
 DhYAdB96wX8hT11UmkMYD5jgRvCGxbVo/FIm064J+j4Ui5y+/xNKW0BU9a7lc0VREoMKmbeORW7
 Kvgwhq02MYXvLFn9Z9QCL2pr0UXmtPn9vC6BzF9ceroKPMa3b7npm1HyLocwdUBoG4nbqJ+rDCF
 +9Xh5lXrDqsb7tos7Il0v567/3kfyObYgXCNmZWDGZyVaZN6BAM1jkHhWHWjxZ7xzdl3OkwTJdU
 V8SErPoa87GsliW8njrPeHaWhJxnINOts11Zv4q3w+F1eZ5ZBwzeGJJuWnmoNkkZ7Jzf29qs6FT
 XtcY5BIQgYtzlLKoiJw==
X-Authority-Analysis: v=2.4 cv=eKmGH3p1 c=1 sm=1 tr=0 ts=6aaab4ea cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KoM1OlzK6_DTh_BYGA4A:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwOSBTYWx0ZWRfX3DftXxcmaMgN
 VcIA5sHZ8HGt/ineAxR4OUD3GJYggQuUmeMFCtGiXowXTQn83Rvumg3b7V4lE8PaOG7n1iva7ek
 5Sht0pIp2eyyF4qPMxjW8DMxiMWQh/I=
X-Proofpoint-GUID: v7OT0vVh6Ti34a2eG-dC8MWvcsPlUwEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160209

When a received frame is larger than dma_buf_sz, the DMA scatters it
across multiple RX descriptors (rx Scatter-Gather). The secondary RX
buffer (sec_page) was only allocated and programmed when split-header
(SPH) was active, so for regular frames buffer2 was neither allocated
nor backed by a valid mapping. As soon as an incoming frame overflowed
buffer1, the DMA wrote the overflow into the unmapped secondary-buffer
address, triggering an SMMU translation fault on IOMMU-based platforms:

arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x00000000, fsynr=0x7f0011, cbfrsynra=0x1c90, cb=11
arm-smmu 15000000.iommu: FSR    = 00000402 [Format=2 TF], SID=0x1c90
arm-smmu 15000000.iommu: FSYNR0 = 007f0011 [S1CBNDX=127 WNR PLVL=1]

Enable scatter-gather for non-SPH frames: always allocate the secondary
RX buffer and always mark buffer2 as valid in stmmac_init_rx_buffers()
and stmmac_rx_refill(), and account for it in the buffer length
computation. stmmac_rx_buf1_len() now returns min(dma_buf_sz, plen - len)
on the last descriptor, while stmmac_rx_buf2_len() returns the remaining
bytes on the last descriptor and dma_buf_sz on the intermediate ones. The
GMAC4 + split-header path keeps using the accumulated payload length
semantics, since there an intermediate descriptor's buffer2 can be only
partially filled.

Fixes: 88ebe2cf7f3f ("net: stmmac: Rework stmmac_rx()")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++---------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1fb5f804ea23..be7cb0cafeb5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1659,17 +1659,14 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 		buf->page_offset = stmmac_rx_offset(priv);
 	}
 
-	if (priv->sph_active && !buf->sec_page) {
+	if (!buf->sec_page) {
 		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
 		if (!buf->sec_page)
 			return -ENOMEM;
 
 		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
-		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
-	} else {
-		buf->sec_page = NULL;
-		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
 	}
+	stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
 
 	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
 
@@ -5097,7 +5094,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 				break;
 		}
 
-		if (priv->sph_active && !buf->sec_page) {
+		if (!buf->sec_page) {
 			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
 			if (!buf->sec_page)
 				break;
@@ -5108,10 +5105,7 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
 
 		stmmac_set_desc_addr(priv, p, buf->addr);
-		if (priv->sph_active)
-			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
-		else
-			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, false);
+		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
 		stmmac_refill_desc3(priv, rx_q, p);
 
 		rx_q->rx_count_frames++;
@@ -5160,7 +5154,7 @@ static unsigned int stmmac_rx_buf1_len(struct stmmac_priv *priv,
 	plen = stmmac_get_rx_frame_len(priv, p, coe);
 
 	/* First descriptor and last descriptor and not split header */
-	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen);
+	return min_t(unsigned int, priv->dma_conf.dma_buf_sz, plen - len);
 }
 
 static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
@@ -5170,10 +5164,6 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 	int coe = priv->hw->rx_csum;
 	unsigned int plen = 0;
 
-	/* Not split header, buffer is not available */
-	if (!priv->sph_active)
-		return 0;
-
 	/* For GMAC4, when split header is enabled, in some rare cases, the
 	 * hardware does not fill buf2 of the first descriptor with payload.
 	 * Thus we cannot assume buf2 is always fully filled if it is not
@@ -5188,8 +5178,9 @@ static unsigned int stmmac_rx_buf2_len(struct stmmac_priv *priv,
 	 * Thus 'plen - len' always gives the correct length of buf2.
 	 */
 
-	/* Not GMAC4 and not last descriptor */
-	if (priv->plat->core_type != DWMAC_CORE_GMAC4 && (status & rx_not_ls))
+	/* Not GMAC4, or non-SPH and not last descriptor */
+	if ((priv->plat->core_type != DWMAC_CORE_GMAC4 || !priv->sph_active) &&
+	    (status & rx_not_ls))
 		return priv->dma_conf.dma_buf_sz;
 
 	/* GMAC4 or last descriptor */

---
base-commit: ceac0de741bfb47ca255eee075257b3bb31f0651
change-id: 20260916-stmmac-rx-sg-fix-a8d2d8a3ba01

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

