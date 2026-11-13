Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555976;
	b=3RAMamD+FlE2Y3sJAtdChfw4Kouo8nxbdCUIrzU/lyCaDQ7MTH++zjO1d3riXb3aQAsf
	 8Y01ERrzSI2wqR2qZmBkHkm7ZFNtAJHb3hNUerIg0r5zU20O+5e1nAIChpGc7EqTo9h4Q
	 Ao3E3sDGWNy9WGhUH6oTd0wnR2Gz2VlKhO2voGiXIbBO4QpnnQ5zt+VaCN0H0cgXX5a1k
	 2EizrGPprPSafgVx8WBWEcyJSKvSIkFwoQXqg+O+O5Uxc56LCELDbdiTfCLAIi8eQQApN
	 HftcQ9cam59nKqkZFr2F3Fy+osdCwmTb+iB/gNr4I5qW8bEJ/hkn4vyW5jRm72zu5Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555976;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FMnFKA+4pMDyPqtDTHmVFfRAjC7IXzhIXpiggjzZ9YI=;
	b=KVzNYofoWY5TvYARJJAg/LNPa3mB5V2ORhuTxXsc9lVW2VMnSznxgyT4HbvCT+z0EQ4N
	 Ftfa0zRqNRl97R8zaneaTRH+gH0NjBywfhUgPRH+AGP63HUcRtS1XAZtrQgvcvfQd7GMM
	 r8sSNZMZDHMef0wLebHG2ubGFqz2UnFUc44YLH7bXQ820yqhrq82KDYIsPjgfFCnYIPje
	 bcOMmXSeEAxoF6IPPJN0At8lvTFUep+jqoM3SEqiiTAghCtF6sXGnSnATWCo4PBKjzmV/
	 9Bw/C0kKPtVIG9Od8WTvxsFCp/uHN8QZ9BdwnXWcXdAEA4LBe89eOf5jthpPL5hN61A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zdglxlsq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RfYd9Pef;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C14606A330
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C14606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zdglxlsq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RfYd9Pef
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD6ISsH1164561
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=FMnFKA+4pMDyPqtDTHmVFfRA
	jC7IXzhIXpiggjzZ9YI=; b=ZdglxlsqS1jkrUVZb9JmJJu/zkcwdcocm1GCUFvn
	XB687YlqPWTLsVSHLzxBQbmQFHEwkZfbIOaVL2T1P0fLDLmnfDH7jAa2sDAemnoN
	pbUDelgRJlH8NKWpcbj1it7f4CWA4S+3I2PUK5AF/3bMfvzQVSMNGDMCyQR5uRMl
	X5o+WPBEmxp2QtwEzN6W5AbAgc6KJsU0ZBQkFaevjKjK2Rf4c5RAjUhEDlZ871bM
	iQy+K/ZS/xujAUgeBjNzFKsZx6/HUcTqKmHcfkcrendW+w4C167a1ocWhRTL3n5i
	RJ7aypU3H3r/5OC234slQhJbglJ+Bnw2QfasJ+fvdUeQ4g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hww5r88x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:46:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-370230d93efso3220252eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 23:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794555973; x=1795160773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FMnFKA+4pMDyPqtDTHmVFfRAjC7IXzhIXpiggjzZ9YI=;
        b=RfYd9PefkiE+RDtaXmuhFdpgBYVxwNo9kmqYQdNzV66l08EBCzYl5gN7Wb9LDzqtwA
         9xmYcjc4DxTjDW9DVAlkAJQh1CyPFFyleiBMVENkAemvO2xNUNpvU3Mi3tDNkaSJ286Z
         ADs2q6tJkm8JAIjUZuyfO3fAT6PugDABJZXiuqfIYTRjccRoWtN5lCqWd/rSJVjgyHXG
         2NmTNp9tQOhaLWDPsUgSXySd6YqfEL7bjorMkXImxaHUsEWpMqmaW2svT0qN25dy52tX
         bFchz/m2Oif2eFC9XAqNV95a5MAU2sbbBcEXJ9TNVDwM8V3Ha8IzrM0v4SxUFYhtupsY
         T5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555973; x=1795160773;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FMnFKA+4pMDyPqtDTHmVFfRAjC7IXzhIXpiggjzZ9YI=;
        b=vgad96bIEyszCJ425Hd9ZYGQ4VTdqwkFQjeSbI1fEdcth+q0tsLz9EQONO/pQ92cml
         d7nuz8pTzm7BvC5fCjEsxmY0yd7xY2quG7ND4HYnwP8oCs89/xvSXqKcAE2NcQOC4XmI
         TUVrTfF0J0sNuaSAH4Pig3ioSa74JfFVGhS19ThKAjGKI4ZnHtbu8d0SEgNWsqI6Lx02
         wwRAgWUaMwoZSzbQsg5qzGHoyf56MRDlK5St7MUMwtb5bhrjfQqPzXvPGwzq9nmtRExA
         gio1xsqSibusjPs2EjSvN+XTvk25stoh/BxfnBZv289iEVbAH4W+9EIsQoPcs618C7mU
         9mOw==
X-Forwarded-Encrypted: i=1; AL+hErHiP2rhz0AFMHou/vc6ZxK3OporE2LsHmY9jCfHZy/8GjjgtrD178YyLWvVxP2Chhe5cuGmrIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9J06NWqwB0aa/doFW2OfuBP9UqwqyaKBidaATZsBdyZytrpLXe
	SQAJUSbaKaJYQwXuYzrb89Waa9II/XbFQXZOwy/YcEJGLHAAJt7ZEXNS+LJgKNXJg0Cpf/dcVqj
	p4B79uHJ7RRw+HnoEnSIvM82O/Uwoc0jbC+Z3a6Soh0tct2uShGnjaiownn8=
X-Gm-Gg: AYBFou041lf4RMhiOWUplzAMCa5DUU2ibwE/xPqoJ0oCLNXZcMVNdJhk0eYLPD19Jbq
	7GIasJKj01vXcst27Qxybgf6QUBdAtNTywqmVY7jrc7UvqInc/he1K+PxksFjlV+EKBAyMizDb5
	Dx6fiv5kp/9hwZ5OlUp2GkEZ4oZ8GujXBIfg5rSgHr/1HmPy/fBzFMeOKOMRUKV3610bso+EJiL
	xyqRggrmm//IIUeXtHTgNh/5KoBSd5cX8VyCxiAroxkJms9Mt7NcNYDWR16qbqGsK95+XB7z52M
	SCjlIaWmolR4WOfY5v8v5xHoNhu1P+kjPcx/LWUl6PsQm2s4+xnMNB02wzUceY6KCyR6hSNB/Q1
	wpW63/54fN2yizSRtOFZXlS5T5824JsK/rXZPl/hUqR7xRt6zV4m/tGgWdpgPr78rremZRNAotI
	au
X-Received: by 2002:a05:7300:8812:b0:379:24d9:cb98 with SMTP id 5a478bee46e88-3796048149dmr1953994eec.0.1794555973157;
        Thu, 12 Nov 2026 23:46:13 -0800 (PST)
X-Received: by 2002:a05:7300:8812:b0:379:24d9:cb98 with SMTP id 5a478bee46e88-3796048149dmr1953955eec.0.1794555972421;
        Thu, 12 Nov 2026 23:46:12 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm6281195eec.19.2026.11.12.23.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:46:12 -0800 (PST)
Date: Fri, 13 Nov 2026 13:15:58 +0530
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
Subject: Re: [PATCH 4/8] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <20261113074558.al5xktcizxfklkaz@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-5-mukesh.ojha@oss.qualcomm.com>
 <73bb47d6-af10-41d0-8fd2-173eadbaa937@oss.qualcomm.com>
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
In-Reply-To: <73bb47d6-af10-41d0-8fd2-173eadbaa937@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX5Uh912PmdNcE
 UGymTHhcOU2R0+vzQU5P1dKXj34Bn8sRSbPH28tpgOh7R8GH9dVTkwGV93Aj7RC0DHII9pk3v/3
 6cKCzCYs/JamBkbfJm2HURwBpG56RwrOldih5PXeDajN89bqXWErPgDzuPpJvvLXe6Cmh2Ohg4h
 rkw5UEnflYsUDYDvU08w5gwj3qTb3UJHMJUW0IQFDNMJxOr06lx3RXGI54nMegh4OjEdNN5YMLf
 q4BZ7QwtcGFnOGqzJsgU36rY/X3hkpu2LwndVQ2N9o/hxvKCdrmV4N1mwpI6c4G0s0NF1q+QvQI
 KvC4HBjEqfSI1cSmtOla1lk8H3UwRsxRaGv+ziqZqOaagJXHbs7HAn0mXcRp4ZZHUBbeNGpbQQm
 lX5cAHBfO253v5v6+uV38v5Z80Ba84S7kuyLfCY5hM14LAM7DzcR4Fl6ovHUuqFPHb9q2lgY0Fg
 xZRg7+6YDQK3sj06cDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMCBTYWx0ZWRfX7R2Zha09jT9T
 bELey81M96rAPpFqWa+wJlkLFtGW9SMv9hZ5vbQwZhQ56GCfXjDrd27thGcDSZmckW8SpTALl0A
 0g3qKlU0wQsd/Xngvyqans0n+L4fqMo=
X-Proofpoint-ORIG-GUID: GVhp9qG3vieIEHO_eyIlOW3xXIDRp3fD
X-Authority-Analysis: v=2.4 cv=Vqq2kO2n c=1 sm=1 tr=0 ts=6af6c046 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8RL4tSxfe4pX_uSLj0sA:9 a=CjuIK1q_8ugA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: GVhp9qG3vieIEHO_eyIlOW3xXIDRp3fD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130030

On Tue, Oct 27, 2026 at 03:05:14PM +0530, Gourav Kumar wrote:
> 
> 
> On 9/25/2026 9:27 PM, Mukesh Ojha wrote:
> > venus_load_fw() uses qcom_mdt_load() for the TZ path and a bare
> > memremap()/qcom_mdt_load_no_init()/memunmap() sequence for the non-TZ
> > path.  venus_boot() then calls qcom_pas_auth_and_reset() which skips the
> > shmbridge prepare step required before TrustZone authentication.
> > 
> > For the TZ path, add a pas_ctx pointer to struct video_firmware so the
> > context can be threaded from venus_load_fw() where it is allocated to
> > venus_boot() where authentication happens.  Replace qcom_mdt_load() with
> > devm_qcom_pas_context_alloc() and qcom_mdt_pas_load(), storing the
> > context in core->fw.pas_ctx, then pass it to
> > qcom_pas_prepare_and_auth_reset() in venus_boot().
> > 
> > For the non-TZ path, pass NULL to qcom_mdt_load_no_init() directly,
> > removing the explicit memremap()/memunmap() since qcom_mdt_load_no_init()
> > handles the mapping internally when mem_region is NULL.
> 
> That is only true after patch 7/8, which adds the NULL mem_region
> handling to qcom_mdt_load_no_init(). Until then a NULL mem_region is
> rejected, so the !use_tz path fails between patches 4 and 7, which
> breaks bisection. I would suggest rearranging/splitting the patches so
> the qcom_mdt_load_no_init() change comes before this one.
> 
> Gourav Kumar
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/venus/core.h     |  2 ++
> >  drivers/media/platform/qcom/venus/firmware.c | 29 +++++++++-----------
> >  2 files changed, 15 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> > index 46705a666776..adcf67043bf6 100644
> > --- a/drivers/media/platform/qcom/venus/core.h
> > +++ b/drivers/media/platform/qcom/venus/core.h
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/bitops.h>
> >  #include <linux/list.h>
> > +#include <linux/firmware/qcom/qcom_pas.h>
> >  #include <media/videobuf2-v4l2.h>
> >  #include <media/v4l2-ctrls.h>
> >  #include <media/v4l2-device.h>
> > @@ -223,6 +224,7 @@ struct venus_core {
> >  		size_t mapped_mem_size;
> >  		phys_addr_t mem_phys;
> >  		size_t mem_size;
> > +		struct qcom_pas_context *pas_ctx;
> >  	} fw;
> >  	struct mutex lock;
> >  	struct list_head instances;
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 3a38ff985822..4ea4c7769ac3 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -86,7 +86,6 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
> >  	struct resource res;
> >  	struct device *dev;
> >  	ssize_t fw_size;
> > -	void *mem_va;
> >  	int ret;
> >  
> >  	*mem_phys = 0;
> > @@ -117,21 +116,19 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
> >  		goto err_release_fw;
> >  	}
> >  
> > -	mem_va = memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> > -	if (!mem_va) {
> > -		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, *mem_size);
> > -		ret = -ENOMEM;
> > -		goto err_release_fw;
> > -	}
> > -
> > -	if (core->use_tz)
> > -		ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> > -				    mem_va, *mem_phys, *mem_size, NULL);
> > -	else
> > -		ret = qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
> > +	if (core->use_tz) {
> > +		core->fw.pas_ctx = devm_qcom_pas_context_alloc(dev, VENUS_PAS_ID,
> > +							       *mem_phys, *mem_size);
> > +		if (IS_ERR(core->fw.pas_ctx)) {
> > +			ret = PTR_ERR(core->fw.pas_ctx);
> > +			core->fw.pas_ctx = NULL;
> > +			goto err_release_fw;
> > +		}
> > +		ret = qcom_mdt_pas_load(core->fw.pas_ctx, mdt, fwname, NULL);
> 
> qcom_mdt_pas_load() passes the ctx to qcom_pas_init_image(), which keeps
> the metadata buffer in ctx->ptr, and qcom_pas_prepare_and_auth_reset()
> does not free it. Who is expected to call qcom_pas_metadata_release()
> for venus?

I already replied in the other thread; it is taken care of with below
change, as clients like venus and iris do not need to call
qcom_pas_metadata_release() since the default value keep_mdt_buf is set to
false for every client that is not interested in saving the context
pointer.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=2aa8fafc08e777e9da356307c1a0117e7f4277cf

> 
> Gourav Kumar
> 
> > +	} else {
> > +		ret = qcom_mdt_load_no_init(dev, mdt, fwname, NULL,
> >  					    *mem_phys, *mem_size, NULL);
> > -
> > -	memunmap(mem_va);
> > +	}
> >  err_release_fw:
> >  	release_firmware(mdt);
> >  	return ret;
> > @@ -237,7 +234,7 @@ int venus_boot(struct venus_core *core)
> >  	core->fw.mem_phys = mem_phys;
> >  
> >  	if (core->use_tz)
> > -		ret = qcom_pas_auth_and_reset(VENUS_PAS_ID);
> > +		ret = qcom_pas_prepare_and_auth_reset(core->fw.pas_ctx);
> 
> ctx->use_tzmem is not set for venus, so the shmbridge creation in
> qcom_scm_pas_prepare_and_auth_reset() is skipped and the behaviour is
> the same as the old qcom_pas_auth_and_reset(). Please reword the commit
> message accordingly, since it currently implies that the prepare step is
> now performed by the new API as a fix.

Sure.

> 
> Gourav Kumar
> 
> >  	else
> >  		ret = venus_boot_no_tz(core, mem_phys, mem_size);
> >  
> 

-- 
-Mukesh Ojha
