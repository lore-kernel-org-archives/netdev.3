Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF66476683
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628917; cv=none; b=mY36aSokLj9jnoqFhE7cWTiS0LNMjtRW1xkPfChQGmL00z872iNk+ANbhm0vIgt5uRx7ybHFScjj2ARgIh22IRd5vlmhfY8IAPZHlP+A+tqGPVnpqSVdindNULVw7YleO7IF8lBAkAYyJCoW6jzK9t4TuIu04o3oZEbfsLfPq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628917; c=relaxed/simple;
	bh=+JeOcCKCJT9TzZJOqCr35ckMrsBUUbL5W5ule19GD10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kFod9iw+2OKqBhloGthMmrfXekFPKzcAAGrJDRaa93+gj1zDJwALf77+Y3SBO1j6h7dcI1CJNqwcUdr51nfGpovSXegEXeoXtnbUCP+kwz/8meXaw/YC/vynQk1G+kvQE6B+Z5MnPPr8uVKtshpKUxX21WLe6WItPQlvc86cjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZvDGX5jE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XJk3xemn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZvDGX5jE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XJk3xemn"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H61Dve133030
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FvKzqYphaIeLTQrNu5cABi1Q09xRTU6c92RkEhIvSW4=; b=ZvDGX5jELdG/1TuK
	WedbuiquKmbLPNq2yz8NBFSwany6WnHfJrXVXvhYONvjE3a3ujemYddOM8D5Hbx4
	zLnBS2BoUc2wHBPOjOkieI/KrqPv71Gkca0tZ2j071ufmbW3egtug2XCp3ANWo8o
	6oqMkoloXaMqDGvd61+1WlgQ8MFm3iVgqXq4QxrODmZMTorlyhQYOb726SKkDiY1
	hqeXbevjeCCVUqP/Siosp8LsGiH//PRbh9LsA8xQbMAhkfcJ9C8X0d3V/9zRvSOR
	4moZLGBcE3dWZ1c/PuGc7ziv70gK6VqMEfc9PrAsF8ezAEXBDZGaiIxYzNaQjCvB
	M6+d2w==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqtn549mq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 07:08:34 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6b1b7932ec2so523641eaf.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789628914; x=1790233714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvKzqYphaIeLTQrNu5cABi1Q09xRTU6c92RkEhIvSW4=;
        b=XJk3xemnnw1Fj7ouu4Gmq9JAGJjyiAaOK46D0yF3K+q/LJT1pN6RcuGRvmXG0s/+S/
         9P/gc0+Pee9/NJcaF69f+ocdB96pKt1s1mamFruCHVOCUwNpNI8+8kveTKDT+Nl/uXZr
         pDEKCL6N++pHNzKXurgFtQmiulVrK0xL5ZlWBHfYDug76e3icVGvosbvPc20XPcw1LP+
         aP/JkV7Z/5EaIY++QheB1H1ARY/LrV0AkhD+z6lQuSEqeB2AhEJ14X7T36urfyZKaskD
         griIT2bDek34bWk458FLAkwmkMBKdNH1UPZcCBnTSxPqFo1jAdwGkRz1x9l2avijpoRO
         4EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628914; x=1790233714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FvKzqYphaIeLTQrNu5cABi1Q09xRTU6c92RkEhIvSW4=;
        b=1vv71slw4qYucyiX/7E22eYLIDwKLagdQysF/CU9U0DN70Sb8Dtndbg35jKkXAxVQS
         ogmdQbXbAkdXrlLBhxLGMGms4gXpSFJah6TslkOTe+I6mPOKh50POPkOceqAO6nhVT9p
         /HQG3TcfQ4TxvEVvViYQ16QF/phCWXMacTG9fW1mGH3jav3d5ngIQVcU301xbfS25LAL
         hqsMJ8ci6yVTTOdPumhhZYfI8pCi45I9FRYW1X+UTOEP/zBCGsjwrZJiuSZNeigLbsja
         e6VPLrmxqBQDaQhtox636HH8CtcVoq+gQ2ft6yOB2/WFd7s1cY1jxcHGZZiC1rXJN1E0
         VYeQ==
X-Forwarded-Encrypted: i=1; AKwUvByh3+/uZU09S7IVTv8DwNdFWEMqn49dOWckqjm4qJNP484pLHOqLJ4UaJntg++Oto6Iae7fRgY=@vger.kernel.org
X-Gm-Message-State: AFuF++npZA4LuzhXaZAMUK1wycTTauidP/TVP3dslp3CqwnGkaDB+TUY
	LflQ4gSm4bGrTDLoefbsL6t1kqegxPSVsUZnz3WQGoYbsjyi+E8ECLFsWkbyaKtoyXtPK7md5M2
	dMQ4m7u/FB1nCrX0455+Ei2dGIpCmeIMNn1MnRjoO7OkXiP9iS/vy8uuKNpD1yELUUNw=
X-Gm-Gg: AYBFou0W67bsCFtpD6AOGY0WR02y8Wrgtdtnob1IVQTvZTueD/DLI03idmBYtvHyxPw
	2c9om2d2zeCKJhd4r5AORTa4KJ0VoO5VuWIjdam6O0ugnu3Oa0XMl+rsYD6OU7M0BTaoxXy4izk
	buxUBU9ddM46lZqBY231J0sjJVYxN7VT1BQoUclfb/WoHILJ7to0U2vCJLHa1d84KAR+2ZteAUu
	jXk43siDoYBwEkfm8bFRiLWL0eTwcOSbGTfbIusCqdqyaDTV23S0bttgSLtCBSOrdXHPhfG+4tv
	TyB6IqmfoP1Yyk53wC9/JJHk8HCdneO82ePbkem385SM6Vl6yu4Nl7CxqDmV4DvGZEXQJEGSmF9
	YsJMDTCVr94cl0+KsIiEoO+8dlZqouLam7A0=
X-Received: by 2002:a05:6820:1899:b0:6c0:66ae:ba91 with SMTP id 006d021491bc7-6c7d0ee5129mr4794608eaf.28.1789628913545;
        Thu, 17 Sep 2026 00:08:33 -0700 (PDT)
X-Received: by 2002:a05:6820:1899:b0:6c0:66ae:ba91 with SMTP id 006d021491bc7-6c7d0ee5129mr4794593eaf.28.1789628913142;
        Thu, 17 Sep 2026 00:08:33 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm13280835eec.15.2026.09.17.00.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:08:32 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:38:02 +0530
Subject: [PATCH v3 1/6] bus: mhi: host: Add support to read MHI
 capabilities
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-tsc_timesync-v3-1-6826d5d2d527@oss.qualcomm.com>
References: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
In-Reply-To: <20260917-tsc_timesync-v3-0-6826d5d2d527@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>,
        Sivareddy Surasani <sivareddy.surasani@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789628904; l=3082;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=JclDFIoQQmU13ybasYFbXZ7aKUGUQ3PPLi7vjPeAauw=;
 b=dWhPBK3oKBwqaXPL4W4EjaTr6g3gbUYII/k9qYfnqAqLMsDoscAd2NEWHr7hsbXw/7d4ln4Ny
 PZ1ugcCeg+KBXaA9KkDH1WFik8LwsAQfemljUID9++iWggEIW7HuaP5
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NCBTYWx0ZWRfX3xUB7CmBc4ts
 5PwGKDSoeiMeLtz20H5dtvM+5j1OlLBzEK4XNN4Lq6gwhkxn0zcXt5R44vmjvcSM8O6mn1I5Isq
 5S4TqH3jsN68WI6luxr8ueOLoNsJalk5GrsT/rGaJTmlzi33X4i3Ez+8Je7kTt1ikjKQffKI5JU
 B8LWi5oLR6UQosK/mIAAHt3ErRqR67lMuSyrb8Gx89elVgwG49qMPJpdoJMh97K6OOaSR0iC+qH
 vSorWNmJWc1YFCJbGzwMAeS9nH87StDl7+Bj+bXZf9kHsz4eQy10TtVKIX0urgYjHqxVP2hfwG3
 Xhz8IBAD/mC1/E3FXXhhdUy29PqCzz/e2SwAA6mwKVsJ4pr+tuNhmtGjpZpATUMfLfAmR1czURQ
 l91sxJUOqjpewLarBwn+SXmsy1TIMIdoUduK3fN44xHGgKegXaE9L0tHApQaQiXrZ2HpnbjGE9j
 718DaRBFK1/clt3mbsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NCBTYWx0ZWRfX0/muuTdY66Fs
 /TU1z7D4kRmtKbqm8k+qdXLRzrSgx8vakC5TyAp6PBJZ4ughm2Lp8y4AOFL07J+PhZh+OvqjXRB
 AnDHeA6/GjvVzdrr5eDHCOOkG2v8Kwo=
X-Proofpoint-ORIG-GUID: DtfBJs1PiB7M0fHHgw3JNI8UK8P5t2V8
X-Authority-Analysis: v=2.4 cv=K7O3jCWI c=1 sm=1 tr=0 ts=6aab91f2 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=CnzCB1l8zP_khqs2e6IA:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-GUID: DtfBJs1PiB7M0fHHgw3JNI8UK8P5t2V8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170094

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
located after the ERDB array. The location of this group of registers is
indicated by the MISCOFF register. Each capability has a capability ID to
determine which functionality is supported and each capability will point
to the next capability supported.

Add a basic function to read those capabilities offsets.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
Signed-off-by: Sivareddy Surasani <sivareddy.surasani@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h    | 11 +++++++++++
 drivers/bus/mhi/host/init.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index dda340aaed95..4c316f3d5a68 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -16,6 +16,7 @@
 #define MHICFG				0x10
 #define CHDBOFF				0x18
 #define ERDBOFF				0x20
+#define MISCOFF				0x24
 #define BHIOFF				0x28
 #define BHIEOFF				0x2c
 #define DEBUGOFF			0x30
@@ -113,6 +114,9 @@
 #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
 #define MHISTATUS_SYSERR_MASK		BIT(2)
 #define MHISTATUS_READY_MASK		BIT(0)
+#define MISC_CAP_MASK			GENMASK(31, 0)
+#define CAP_CAPID_MASK			GENMASK(31, 24)
+#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
 
 /* Command Ring Element macros */
 /* No operation command */
@@ -204,6 +208,13 @@
 #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
 							       MHI_PKT_TYPE_COALESCING))
 
+#define MHI_CAP_ID_INTX			0x1
+#define MHI_CAP_ID_TIME_SYNC		0x2
+#define MHI_CAP_ID_BW_SCALE		0x3
+#define MHI_CAP_ID_TSC_TIME_SYNC	0x4
+#define MHI_CAP_ID_MAX_TRB_LEN		0x5
+#define MHI_CAP_ID_MAX			0x6
+
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
 	MHI_PKT_TYPE_NOOP_CMD = 0x1,
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index fd3050889412..7ca2fe48c9ac 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -465,6 +465,38 @@ static int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	return ret;
 }
 
+static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability)
+{
+	u32 val, cur_cap, next_offset, cur_offset;
+	int ret;
+
+	/* Get the first supported capability offset */
+	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF, MISC_CAP_MASK, &cur_offset);
+	if (ret)
+		return 0;
+
+	do {
+		if (cur_offset >= mhi_cntrl->reg_len)
+			return 0;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, cur_offset, &val);
+		if (ret)
+			return 0;
+
+		cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
+		next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
+		if (cur_cap >= MHI_CAP_ID_MAX)
+			return 0;
+
+		if (cur_cap == capability)
+			return cur_offset;
+
+		cur_offset = next_offset;
+	} while (next_offset);
+
+	return 0;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;

-- 
2.34.1

