Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555752;
	b=OcM/TXd9xugMYBYYUcdxuv/mOCxf+OUmGicaH8ejDg1JCyvmJiEdktOWkWZYx5+vqrA4
	 kHQYQyVXM7NeauT5a5LYqceHownJAfkx+6m30eZrklYFozo6UkmhCmgRPyWEhMXXbgln6
	 4F+IlFQxfxgyaQBSqlB30tUhsQK2l1j2BsrO/En5gpcW/a/seSFaxEC7NoMEzqtyvKSz4
	 zRwdLiL+oLjk4i11a/ui2PxAzZlhjfveLF29/aymu7d3mWSfbbIgCC1tRm5JnJcAYsqwN
	 P+8ReldinhT9ISQjJrRS661Zaeyb2epOjWvvSIw3XmAyfd6XI9QaN0RnDcXiRCS6JIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555752;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NUl3m6J5h7TCNp52N0g9QRpKf+c3/loK8kBHxy8vOxQ=;
	b=gtS1ncW1kQTpeBIZ+ehESB4h3i4Sbt704wflBPgzwuDD9Lgtph3bET8H4dV43U1C2IbS
	 um1eQad2hhFAM3pWAuUjuKj60W9uokY/qxDKEdetbYf6Liiw4WIDGHB0dsCXGkyqeEl9Q
	 73T0oK7DAvDwemgdvWvkFUp2/JuO25qGSnzzCBfNOKCfPmnyr70WQRGQW83BhMbWndigs
	 UHTFcbTfFOENKWcLgyJPBAIyh18oeVIa8OnjJ4hPQSrN+TxJj2mHkPiegJxSlClWYHv9D
	 CD7y3xWEmz8Q6amFG3fCvnwhRtf6mFsdVk8C09EheWQUaYX/GpAef2B2oJUjTgMcZyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IKrqBXbW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="kr/XEq95";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E7606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A76E7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IKrqBXbW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kr/XEq95
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD57656073405
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NUl3m6J5h7TCNp52N0g9QRpK
	f+c3/loK8kBHxy8vOxQ=; b=IKrqBXbW+S1yf2L+Lm3ZghG01nzAfsaaUMKMZR6d
	2Y9uuJZNT2swj+FR1QJJ8zT9MJQ+nroqqhjwN9IFSABNwUpnm0iABq1jVx4Kur+E
	vp2mIERuTNtqhXtGjuJKef+NrF5rUMZAuiDP5DmubXsdORit1TNHbQbV+4I5FCz3
	aK8Y4QHyT6pQ4xwh9WOqetFA7KvBlxPB7occy19Cka00JJKnZduvMK9/q2+ELYiX
	SMglpDVmAJjthY1D5bTZmocJ4zM8S8+9icDBuWVdblifaoOpixwVxAu8iYVLE3i2
	0yHmgraIYz4RJ2h2pqiEw/U5T+vF2uq7cW9jT34dYYMLmg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs0421f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:42:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so1112398eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794555749; x=1795160549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUl3m6J5h7TCNp52N0g9QRpKf+c3/loK8kBHxy8vOxQ=;
        b=kr/XEq959Hr+MdasQEucxRQHib3AH4Q09htxKsgHwxvYqWuC72NjtI3ggQfqve2Kea
         bLGx/X0EUf9qVhy+gFrF9jA6BoaPx4CojA0kzvNkk+9wbEmFa54LA6P6FrNxhWIWo4cY
         yb9xeZZtEmnMrxHcrEcTtKPSbcqCU6sEL8nwdkOKL/TEaLUixjO/gzEKfrOBTXSvZJTT
         a0O3leFJiE9weDrJ3HmB7ayucqk4TOixq/dyigGkzn497n0ZewrMoA1dyFFoRXXLm9gq
         fEWmn+sDW7KLk65RenuSmEUoB7SM3RpJr9or0xdFSy+VyS9+NgniD6juFO00A+Gx9bFm
         eYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555749; x=1795160549;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUl3m6J5h7TCNp52N0g9QRpKf+c3/loK8kBHxy8vOxQ=;
        b=sCAjLRaF7fGxrnbjytUSvqu71hp+dEnkckXhlVMchgIS+gtnGTLsOblJofzwpxyLQS
         VizFjdtj/KJuuusgF6jQA5Bo+bm4FTu9Hq8ilfgCDAs3VGLJQFEV0cxv0kS2WElRZCsa
         63LUGzxmEZ+VU7ceigE0O09NphaX07Zbt2A05OAHJdUukYJZTeALmGG/zYXq2HcEEBiZ
         u47tK3QhmkX7nnFR/5JneD9SI76EKpleU9mDv6Wb+rWbYLKycXeUyAZtRMDhWZS3wI6/
         F+Z59PQqBoqEDGdH72a3yPIACqvC30Tggujvm1Xbjk2GbnRE71c/fRdl+g7npVyHSiuQ
         O6kA==
X-Forwarded-Encrypted: i=1; AL+hErHF4kJGnB1x6OCozX9V65/zYq3PBe5cNdoDTj9z7si32qEE45GwaDZGi8fV9XfVVVwsb2l1eVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8G9u7U9Me2sCKRY9b6O76HYnAeV5rx2TfXxIO2toWsVusTQLyJ
	JNyQkruHiNvYBLVbE7wiY6L4iYFkiVRTXJcF07QEYiPWZFf41+ivxsUGMowRkSgIuLGMLf7+lBs
	Ju3mCohbIaNWDB8SamrDjveyKGDbQIDkQIDI8q0xLi2rVdRMOo+4axogTsnU=
X-Gm-Gg: AYBFou0Ajc7dgLxhrI4zClIDIP0WKmIIz/C+OKTm/DaQG/Nvhv6zxI4fVSS2+ZjkoPS
	aFltDN1XxjuNpUvbbuYprAENv80CFDfj49eKZq6q7w3Nh+5ewVD7sg5wcEfQi4ngxF845LGEwl9
	7r7bF1buTPqypBcvlDo0SZRqmu+aA/icTgKPOvVd1uzCYGq6CCNNEY2gzfBFLi6eoUgUq+65Fpg
	8DbrfnrZTQqiVH5HGjwhRFuirg1ZKMHoLmaAcwjLsjlXwp+YD9didq75AK6gFw4j5MlGfpM3pYl
	4vV6b2ZKompWycvTiBbaPFYzL99wlCmiC6G3S3Y8cgqFOD1UnN2FIe2UOsf/HO6WT3KLAv5Ttsi
	KlgTtPSaBVti7zl1XIvPU69zkS/xC4Ex8pDbTPHGJg1ZAGj+dKrn19WFBcEFyJP2P/nR6dkVGCT
	0M
X-Received: by 2002:a05:701b:290a:b0:16c:3408:760b with SMTP id a92af1059eb24-1b503121292mr1619116c88.32.1794555749327;
        Thu, 12 Nov 2026 23:42:29 -0800 (PST)
X-Received: by 2002:a05:701b:290a:b0:16c:3408:760b with SMTP id a92af1059eb24-1b503121292mr1619067c88.32.1794555748517;
        Thu, 12 Nov 2026 23:42:28 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50309b2b5sm4436549c88.1.2026.11.12.23.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:42:28 -0800 (PST)
Date: Fri, 13 Nov 2026 13:12:16 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 3/8] media: iris: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113074216.5md7myragcw2xkf2@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-4-mukesh.ojha@oss.qualcomm.com>
 <aa70a256-eba2-483f-8326-c3bd2ff3d33e@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa70a256-eba2-483f-8326-c3bd2ff3d33e@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX6q0UtlvyITgT
 WkdXyqCjs1tI6YHQyj/GUrNjdlImsmPRPApQRf6geg6s7+GzdXTCiWUvZm1ZKEf9WMtJxWUrnXx
 RiA1E5va163ww1D3uzDeYV+Vn4pm+ZpkSVjMfs8Bw7kBvAozVuyCeuvGcfVK5q+0nU85poq+Bel
 jLx9UlLrIWw8lU2rzkU+o3GQP1VfAtJ2/3jYeyLivwnu/b0Y7w4h/dtP7WTJs7E2t7Gf66wrXmR
 TKAbCklL5WgkzwUnc9Nl/DUO2sUSXdPQ1oHLjGF69SjV4qZbF7Si+tnlfh0x09fq2967aA5lSGy
 OJ18vZ/HjsD5MDZO5XOt7wDKLUURL+08V2kpKrWT+Mono9niPcrUNVHjcTcZjc2Oy4hBr4NP2WG
 2Yyl8XIjXlM8CdW6SOinP/RPJ8eOEzNDCzzq8k6NbEZmWZq/yF7A4KY/y7FbOol6XmhtB8NVSWv
 ko+Ji+8xiDlAfuZ5aKw==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af6bf66 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=sX6kAIEwX3NwIotb1QIA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX1XYktsbvTvwY
 Ge19smL/J9UOOFpkBiaoOzzvmHm9QNT4zprPicpqGfebzyZZNI+L0CtNyeH4SZ0ugGRNWcRjqR/
 LXpDvahh9Vp1NSIJT5lfF/V+5QKdpgk=
X-Proofpoint-GUID: WpAAkhY2sT2nYV6kMmSOXCq5-r3mXi2D
X-Proofpoint-ORIG-GUID: WpAAkhY2sT2nYV6kMmSOXCq5-r3mXi2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130030

On Tue, Oct 27, 2026 at 03:01:41PM +0530, Gourav Kumar wrote:
> 
> 
> On 9/25/2026 9:27 PM, Mukesh Ojha wrote:
> > iris_load_fw_to_memory() calls qcom_mdt_load() which bundles metadata
> > init, memory setup, and segment loading with no PAS context, and
> > iris_fw_load() calls qcom_pas_auth_and_reset() which skips the shmbridge
> > prepare step required before TrustZone authentication.
> > 
> > Since the auth call is in a different function from where the PAS context
> > is allocated, add a pas_ctx pointer to struct iris_core so it can be
> > threaded between the two call sites.  Replace qcom_mdt_load() with
> > devm_qcom_pas_context_alloc() and qcom_mdt_pas_load() in
> > iris_load_fw_to_memory(), storing the context in core->pas_ctx, then
> > pass it to qcom_pas_prepare_and_auth_reset() in iris_fw_load().
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/iris/iris_core.h  |  2 ++
> >  .../media/platform/qcom/iris/iris_firmware.c  | 20 ++++++++-----------
> >  2 files changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
> > index 24da60448cf2..68e6adcc1dfd 100644
> > --- a/drivers/media/platform/qcom/iris/iris_core.h
> > +++ b/drivers/media/platform/qcom/iris/iris_core.h
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/pm_domain.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <media/v4l2-device.h>
> >  
> >  #include "iris_hfi_common.h"
> > @@ -123,6 +124,7 @@ struct iris_core {
> >  	/* encoder and decoder have overlapping caps, so two different arrays are required */
> >  	struct platform_inst_fw_cap		inst_fw_caps_dec[INST_FW_CAP_MAX];
> >  	struct platform_inst_fw_cap		inst_fw_caps_enc[INST_FW_CAP_MAX];
> > +	struct qcom_pas_context			*pas_ctx;
> >  };
> >  
> >  int iris_core_init(struct iris_core *core);
> > diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> > index 21cdf1c39835..e73a5dd98b88 100644
> > --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> > +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> > @@ -115,9 +115,7 @@ static int iris_load_fw_to_memory(struct iris_core *core)
> >  	struct resource res;
> >  	phys_addr_t mem_phys;
> >  	const char *fw_name;
> > -	size_t res_size;
> >  	ssize_t fw_size;
> > -	void *mem_virt;
> >  	int ret;
> >  
> >  	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
> > @@ -125,7 +123,6 @@ static int iris_load_fw_to_memory(struct iris_core *core)
> >  		return ret;
> >  
> >  	mem_phys = res.start;
> > -	res_size = resource_size(&res);
> >  
> >  	firmware = iris_detect_firmware(core, &fw_name);
> >  	if (IS_ERR(firmware))
> > @@ -134,21 +131,20 @@ static int iris_load_fw_to_memory(struct iris_core *core)
> >  	core->iris_firmware_data = core->iris_firmware_desc->firmware_data;
> >  
> >  	fw_size = qcom_mdt_get_size(firmware);
> > -	if (fw_size < 0 || res_size < (size_t)fw_size) {
> > +	if (fw_size < 0 || resource_size(&res) < (size_t)fw_size) {
> >  		ret = -EINVAL;
> >  		goto err_release_fw;
> >  	}
> >  
> > -	mem_virt = memremap(mem_phys, res_size, MEMREMAP_WC);
> > -	if (!mem_virt) {
> > -		ret = -ENOMEM;
> > +	core->pas_ctx = devm_qcom_pas_context_alloc(dev, IRIS_PAS_ID, mem_phys,
> > +						    resource_size(&res));
> > +	if (IS_ERR(core->pas_ctx)) {
> > +		ret = PTR_ERR(core->pas_ctx);
> > +		core->pas_ctx = NULL;
> >  		goto err_release_fw;
> >  	}
> >  
> > -	ret = qcom_mdt_load(dev, firmware, fw_name,
> > -			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
> > -
> > -	memunmap(mem_virt);
> > +	ret = qcom_mdt_pas_load(core->pas_ctx, firmware, fw_name, NULL);
> 
> qcom_mdt_pas_load() passes the ctx to qcom_pas_init_image(), which keeps
> the metadata buffer in ctx->ptr, and qcom_pas_prepare_and_auth_reset()
> does not free it. Who is expected to call qcom_pas_metadata_release()
> for iris? I don't see it called after authentication (or on its
> failure), unlike in qcom_q6v5_pas.c.
> 
Below change is merged, so buffer will be freed in the call itself, no need
to call qcom_pas_metadata_release() explicitly for clients who are not
interested in saving their metadata context.


https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2aa8fafc08e777e9da356307c1a0117e7f4277cf


> Gourav Kumar
> 
> >  err_release_fw:
> >  	release_firmware(firmware);
> >  
> > @@ -166,7 +162,7 @@ int iris_fw_load(struct iris_core *core)
> >  		return ret;
> >  	}
> >  
> > -	ret = qcom_pas_auth_and_reset(IRIS_PAS_ID);
> > +	ret = qcom_pas_prepare_and_auth_reset(core->pas_ctx);
> 
> ctx->use_tzmem is not set for iris, so the shmbridge creation in
> qcom_scm_pas_prepare_and_auth_reset() is skipped and the behaviour is
> the same as the old qcom_pas_auth_and_reset(). Please reword the commit
> message accordingly, since it currently implies that the prepare step is
> now performed by the new API as a fix.

Sure.

> 
> Gourav Kumar
> 
> >  	if (ret)  {
> >  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
> >  		return ret;
> 

-- 
-Mukesh Ojha
