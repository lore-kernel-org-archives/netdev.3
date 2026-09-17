Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C604248F004
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628930; cv=none; b=KByVticiQSq3j6smk0XyXBJkcmDrykEyu84Zys/FxDR3eOqGSeKoVx59lpBTBpcRD0qUb08Mxivaor/HLUQlMsu8ivuDRGRwjBEoAlVhFTV47q+1QDDr31iXRVeTIpJSwd5L9AerUH3tjFxwH3GSPLEJ8VJUBHHdZBhBkh11aCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628930; c=relaxed/simple;
	bh=OED1Xg9S3SY51ta3t3mrt819UPQ3wW6IVv1lWH/7UEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3kr3kD1Qht/5ZbcaalvRXdopH7Ag4g7+0R0M/o9pQbxLEziWICk+rJTktGPVYKsTvY0UARE8fS7PjQD+Lm3wkOrzaP3NEOZ7g84mKu0cXNV2k7MslrbMNZU0j9PXt7vdQEwhmB3Bckv6Quo/hSZm6vev6l7uyHty7+CfV2FAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dJsDnUwm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RHwPOUSW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJsDnUwm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHwPOUSW"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H60MC83702421
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gYxybknD8fyl/ZIeJU/5fWIVVbydgp9JHWKqHgXGOx4=; b=dJsDnUwmZ6T+ylZW
	MnZ1y7IHLV6y9+rz3xQtFkPBkJNo1DE1wl2nviWAq5klmOKfvA9TEz/FjB94+SOw
	hfVmoIa0N4aEhtfF5Ecp+sFMN3dJjbivK2NYUGpW7W6eVHZ6Vuv4scbZ7mLoV2T3
	oYPejvfUOvHafio2YjPDlm+8V6rPcoKu9CTBptsygt0YWlqfAdSn2QauGyl+QM25
	XGLrwXd826ieySuDolaQ46gh4xOGmABPfqr150g8wpIMQ42TGVYuRDWHOdPHNE2U
	6/e7fYOlOtbfHTrB1QdkUm+Hsn2gEIF2peyBcYpE7T4GLtcXErb/xUe2zCnpflEI
	J70hoA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gr7uc8vch-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d94a158dc8so11267715ad.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789628927; x=1790233727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gYxybknD8fyl/ZIeJU/5fWIVVbydgp9JHWKqHgXGOx4=;
        b=RHwPOUSWyX3XQy2/xnPT6MKRFGbY03xUFvXhmyu0+X3KkVfGy6KpPaHTOnD06gQ5HN
         JKu4Z1wOnNiLVIkfLdCQBpRjmKyCANcAYy8l/pj+iJ5wtTRcnUAZUMOKr96PRXJ+UHAh
         l/iTHKEHIBw0Ory7yHWBzcFp0bb7HhpVUJHcO9qg/OJW+Vln0Pv6W24bFjikmDReGayW
         vdWwX7l102gguOpqq+/6gAVumP3QMjAcS3czAw0sDni2BWGij05koAQBEG9BRBJPPNDR
         l1tY/n6aJRygKYmrGDjy+0tXpHpqJ/vkS2+1tw+ARH9cOUx4Bkx/ZM2aYuY8q/7vLA6c
         iiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628927; x=1790233727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYxybknD8fyl/ZIeJU/5fWIVVbydgp9JHWKqHgXGOx4=;
        b=Yhs2F4A98k0rtfx0S2Yo7rbWlLiQFcic+ynhTdXkNvmlAJcthXXdMCmPaVR1+aRXbz
         17iiRXs2A68e+0pwXt4VuYM3EqDyD5RRKaVZ1Gi9y0iWZFXbldACfL6EDO4NGwFCJD7x
         tBHDkTDcCrcbQkGSUf9TGiqvujClGpQY+epynfVNerGxsXUMGJEOc7NPOEb4aRiwerXD
         0ivVecHPKpaernmnph17UT02jFp53uX0PRkLqRZn+EbtwDg1rfP4XyEpY/muUbUYEzM/
         9zJnyGvS/ERwu1tjsCL6Jrc9tZ2ERKEzvntUaXo7VTDVLdMilGP2bm4WadXU6CAj+aiE
         rCgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLfftF9UtjtFpge7hws4CRPeOkAlQUvV/rSQaZ1Djx61z7gwjNu/14C9jsu0lT4HZYh72tli8=@vger.kernel.org
X-Gm-Message-State: AFuF++kEczzluBvagUy7uT2JaYky/Q88IG1DM7H7Jzwr+34/xbgfcWHB
	8hnzXHflzOuMtUCv+kmcybflgsOobOX227MVBgSrwBWgHYUuUMpNyFVca5UQMKFWhOuN/u8OVFN
	rlxijq8mTqIFjt8dnKzv78A0Phs+snSm9FSpcH2sF1I0mR5U/F2PBwJTxOgU=
X-Gm-Gg: AYBFou08ttVicsahR5oHtjuRXXQmX75Fuz8mhitMkQnAZs6GiYWdKIJM8Ug6g02xYun
	QpM5665ss22MIkDUDDNSYadMOIA6rFg8TcdT9ropDAPrrE+iE84/i1UhRjEmXCzg4Sup5RWc0Wt
	a0Xg4esKWpEv25Jfq/aTt7wCfTHp52cmpnYH4sYWWJNZBTr1cuR0W9yUFIUMd9GL0itKjuOFRc7
	FtLukboIakvGMsD5nmYMnun5lWhab0nwVDyMN49bbzcoV6FBICLw/j4gweagcVAjO5vScPWMbS5
	c+4OzSHqkFdtbX1NzwQjnBhjXc1Jee9yeI7V2RXbCgY/9Aor3Jz5EYsjcBvJum9VHfC/Zyb7bRd
	f8PossdmFL69kvSrbIUPHfuS5Q8+6HJ94c00=
X-Received: by 2002:a17:90b:5866:b0:39d:f97c:bb2f with SMTP id 98e67ed59e1d1-39e1e25a32fmr12976113a91.3.1789628927177;
        Thu, 17 Sep 2026 00:08:47 -0700 (PDT)
X-Received: by 2002:a17:90b:5866:b0:39d:f97c:bb2f with SMTP id 98e67ed59e1d1-39e1e25a32fmr12976047a91.3.1789628926542;
        Thu, 17 Sep 2026 00:08:46 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm13280835eec.15.2026.09.17.00.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:08:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:38:06 +0530
Subject: [PATCH v3 5/6] bus: mhi: host: Export mhi_read_reg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-tsc_timesync-v3-5-6826d5d2d527@oss.qualcomm.com>
References: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
In-Reply-To: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789628904; l=768;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=OED1Xg9S3SY51ta3t3mrt819UPQ3wW6IVv1lWH/7UEk=;
 b=j6FqE8uIa9myda6e0cGJaEMyZV5FzuN+gNvRGsEJK2+iBFQtaMsERaolLY+L5XroL4jWTvl82
 pnUZEryBqnfAggYjQK3PyeHlbN+6jhhaD9e1BpY8eiIcZcSeTmvBpbW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NCBTYWx0ZWRfX5hUVkFg6naWB
 NjPPxiEfpphFJ6ZSf4XSbt+lWuf1TBdd2GivYGqPMZ2Or0Ez93sbcgxFbhBmOll1jJcRVDY5Mxl
 E62EsM/mbhsoHo0ehvUAMiTFTRAcQoyJl1HaUD2VvOgr+qShXdZoXyqTVLAVa1gZY0H/p5BgmVM
 P12ojoqACxRVEQgvDzXhIEb9CuW1cUPO3oaWuEhEhXXteHiN+T9zNVfcWJ/caOFwM9PCueew5/a
 X3jg4nDeS3V3S99hHmCX6N7l0RFHKKPwxnLau3QUfe6ABoh1G1Rg9pHvzCN6molZh7HynOZD/ee
 zOoGk0fZlNQCp9KOro3soBkgC/mZg4XJKJGbGSbKCVU2Bws988ycUFf5MUI90OvpbzM1zJGzvBj
 z9dJvLzulRShNw+iOdVa/I4oslBcKM4Q+aHOBWkkEOIqI5YPl9QTon8kv4wwY1UYwiRjU9+ODjo
 nH60SuvbGAbVMbp44iQ==
X-Proofpoint-GUID: Yi6btxLc7KtAIrlj8btU70t7mLN45DSx
X-Proofpoint-ORIG-GUID: Yi6btxLc7KtAIrlj8btU70t7mLN45DSx
X-Authority-Analysis: v=2.4 cv=F9zC5ahN c=1 sm=1 tr=0 ts=6aab91ff cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=V1CThsli6YUvQZXG0mQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NCBTYWx0ZWRfX0zsW7Ap+LNX8
 Cr9Vp3wFpiCtL0PYVaAxUxr1VysyPfm8AVkmxiyMzYu/sRc+pnqGc4mf2HCIhIJ68MWORmI5wMK
 oopYYaqw2UtCDfTiq9xkScaWt6bjXhA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170094

Export mhi_read_reg() so it can be called from other MHI bus modules
that are built separately from mhi.ko.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/host/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index bfeb5cf53448..1ca9f781bbdb 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -22,6 +22,7 @@ int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
 {
 	return mhi_cntrl->read_reg(mhi_cntrl, base + offset, out);
 }
+EXPORT_SYMBOL_GPL(mhi_read_reg);
 
 int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
 				    void __iomem *base, u32 offset,

-- 
2.34.1

