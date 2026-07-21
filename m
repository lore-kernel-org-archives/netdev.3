Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF447DFBF
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629419; cv=pass; b=ZswPOkT0AXHPQ/G5T+XaZqjeDNBrvf+a7VQkG37ckLMSFEx9mA/gzLucNBYwAtF0P2eBaVIUaCGY+AupL+w87AYD+b/NDFojBl2iBCT7OXPzqNudPO+eI876rz2wI7fr8pRXoMJFdpIyIHnM0NI1JQvbbYRZoPTb1bdkyuIGu+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629419; c=relaxed/simple;
	bh=dAg65rfGUktkEyRGS6LHi1HlhBVqv2aq5WVTQI9cBnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+9ZV3s5r84QLLBPaTrhDQdRJB14YtBYzWUACsexxebVMAi+4d4121mtSR22bzY3YWB28za5O+auE+e7ZX/XTeUaeXRdybo8LwyE4XvgoJYZpQo0HnbbX3dl5NlP9JYuk/mUV3G9ImV5EXEiZh0V3BHJinc2crKjvRs9XgMgtqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YkZU9qx6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a+9NFGkQ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YkZU9qx6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a+9NFGkQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LA7Esv1564204
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=; b=YkZU9qx6lnMX4N5K
	Do0b62EpRlotw+/e8mEbhWDllZ3QfTEvVcxyBwNAymMa+RQMcZQyFEuQy7fXxd9Z
	rWH4cWFfbPEGE74FlVO+pJA4iZDM+btPk9jltI5eWsv1UAL6mEo05qZHc0IR+y0z
	RJsUEtKoGNdiMaoLigiqBrxnJsAIW/jkcyEcEb2/Ff2hxrfXhIsfC3c5NR0SSa5G
	7y0HXEdC1VzjBR0o4gRORznyxuibrXiiQ2YD0U1oyc1mN4nSgSvfjlan7Iy2q5or
	tQ7kd/Y3Ni1XNudl9Rhgf4CDLVN9VCLP+AO3YviOI66wsozf3nEO/8J4yKJpE4ju
	0TPZmQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3g23x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 10:23:37 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-667c40cd608so3884058d50.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 03:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784629416; cv=none;
        d=google.com; s=arc-20260327;
        b=Vjcz3DSb4ZiXOsubtbHQDxrEF4JzPItjxCEOCquQGyf0B09VRzxBKmdduYfVJD0TST
         tRL3wweEcUI0Xo5Sg8GxS16ugLTH2nxQYAS+QFRNOUTeP1XFjs96/f0rEBr6J6B3YTNa
         38H4sH/dYXFppzArWSA/5UrRQzcAU6Lu1GdKL/mpRbFkZPTVI4A7n4VEQ3ClE4biXjfI
         4wJbFTC5ykVV4V4c+0NAQHiRGS6DbT8raIkXA/oqvzS28pE9yHailZYsNez3cHNrRAPV
         TuRyVZ8Ex6QmJFv99AEsGF0IcNfW3A8KDA83+UFA7l6nUCcnb6J/axDM7nvG1tyMMdAe
         d8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
        fh=tJBGldyMUHMKVGWGWrY6PezDneH9QF6UBnhC96ZUUWY=;
        b=GME3viXkwioxQQQw3pY3jaTwFXv/Em8jOYlhV1gl21fibgYrktehoPOY5Noj+Z8iVm
         GXjWQDRFyoIFZiJpjP/zeSqZAC5YEeFHmma8idxpj3HG3lIb+LGmgeU2+BFZdADNZcPr
         39RQ9vmoV/3LuDvtSABtQF0AGsKQDUElTaIzu9NFfhbySLn7LbtcoGhyGeZv9pQTYkfG
         iMcU5DWGPcurWJ5oVxaVyND+j1gCMEr9jTtFarbMXLjUunbNPwjZqHeMAXdUWQhtS6zZ
         w3HCjyvfTTYHMtONIWra3DhdMc3/rTWHRJV+Or3l+CQQIx/hZQMVsJZ/6vKheWLwntPC
         zXrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784629416; x=1785234216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
        b=a+9NFGkQzqDbR4UJTTXL2nX41AQ2LKh+fb3qfJ7xzTcCnZBzuEjZKlsriGLROVw9pm
         02K8x1LR1Kg/31neA5TeGFddMhUCGGESNaKaTpwEYcNIZUqb8WV7R768NJmbeatVgpyX
         A36Dv5177kb3gGouuGkOGq9ztgb016vjqB6ihO+sd1TpinEOrexUaBQOBAUJmmfryxgT
         DsA5d9MmKIsZ2TbkM8/rY5Ugmn6dJm7rauTie/S618CWKYy5dZRCVgo8ITUA63G0dnZg
         CA7OnLAzpDL6Q4zGNcEaRacNRhQef73krPY+Djj3ta8RRnfdWv0UCqxMZY2395o2lRjA
         VLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629416; x=1785234216;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
        b=Pe8PBKzdQ9J+nM2RyVk9ncqdP3hYFO9y0k1d1FTTbLCa+1pxa9/H6erUXr3n4fvZvN
         7FZEu3bHXKI1IwLPDPJnX0IDYZ37dF/ILI1a/ZtiAa6i583M95dQ9Zqhtf5J6yJjdiLG
         J2N0a8mMfOWtachmbr4i0s652WJnAlsTLbDOWj6jpTUIw2QAtT0P/qpcSlXIWk+uwcGC
         q2ZQC8tT0wxmraq6LqnAAfkQOHX3ffodvtwhnzq3KYzJfRA/wAYdAHLDc7Df+Ng13Xmg
         LlFkLpQMGL1CBK5PbZlmHTceJZZTD/CLKV3hDAj4aIw4EI/YtyUqMHjnrIxxMGJEvi8g
         FDHA==
X-Forwarded-Encrypted: i=1; AHgh+RrW3SMPcVLFgi5oXNnX/FcyHeWUF8q9MXikDkcZ5pqMm+xF5C/KLf80DK1ozj8vT+j1EXJ/lto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8gmCsq27nnwXDTBd13eFdwwgl/wAJ4/DWpadk02TVZs5jU/c
	mmqhmBllUOFRTecAV41mlIbeTSx6dqNSH8j3IaLWXmlRrBpJIjdrkAsHKOX/CqztlqfPSetNAJ9
	nhF2bgX9PN+FXx8hE8K9LlwIz2tfhqzXjNq64OxtUtAOO/J2Yno7ArUQRyID2job1Nq4zMLilsk
	LCy2cV4Ptw0EfCxLRcfSYpIJ4BjGG75pRdoQ==
X-Gm-Gg: AR+sD10dP2shhfeXyS2+iJUuCBxdUD4r1xMzHrl0CqCodeSy/DcZF5ar31c0qA6t37U
	FTryQV0recFNPbHKzo8g8dubw81MED1g8xi4nKDFEqzMExGJJO6Bnz7Ju2SfEUZx+xWP0SsbKda
	ohwkoj9MBssUfBGtgNyyI+ZkOJxsMRzLCnqVeXxYB+iUnkQ72hIsmfpeXatA==
X-Received: by 2002:a05:690e:148e:b0:668:85e8:7cb with SMTP id 956f58d0204a3-66885e80a8fmr310945d50.38.1784629416523;
        Tue, 21 Jul 2026 03:23:36 -0700 (PDT)
X-Received: by 2002:a05:690e:148e:b0:668:85e8:7cb with SMTP id
 956f58d0204a3-66885e80a8fmr310932d50.38.1784629416151; Tue, 21 Jul 2026
 03:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-10-sumit.garg@kernel.org> <alJpc3nFX9D7_8i1@baldur>
In-Reply-To: <alJpc3nFX9D7_8i1@baldur>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 15:53:25 +0530
X-Gm-Features: AUfX_my8FmFS_RPsD9P_wAO_xi3w3rSS9J18xqmBVD6VnuXnMyKuUdz39cXSwBQ
Message-ID: <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
Subject: Re: [PATCH v9 09/14] media: qcom: Switch to generic PAS TZ APIs
To: bod@kernel.org, mchehab@kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        konradybcio@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMCBTYWx0ZWRfX6vVwhnkcMhW5
 N4XtfCn64bdjgHYjsx7iq77SEPMi1LF22n3pycYW31CpGO96Ry/znGQ7xmf3Bsaw4uxjnsBUaV0
 uM4D9IL13S5pir0k1YjabEWpIY3bbd/bxVVhvy9EVbSY4Vd+P/TQvmOpzx6o6DZ/Bsbd1DjqMY+
 eg8MhxXnQyGQE7DLCu7+vSgnMev+tMcQzIHsXeyF9Lbd9PDMBOqSAWyU6c0ymUESynyJ4WHRxkH
 SmZhXi6dMHbDUPCAlNB9bKUBZp+BBj9FrFv8GwD5KqMd9tGW3S7atOAKnAUhYFJv/hPWpXOwe2E
 g7d3HeRtJNH0MHTffsuDktMLAlJZluN+ZYLn7cM90FhIZh80TklPeRUTtmuIWzV4QOn+l9EkkA0
 gVovoJU8xGOYdrVgRmSaCm0nAaMms+d/ye+EtEjSC9m0+O9B1LfVIUeOEhf6gbV8sSh5PTyNbYW
 Md/hrYnC2xzVwxKy7GQ==
X-Proofpoint-ORIG-GUID: 3bae4B18-kEWwKf8RyEIc6u9JffOFGJ_
X-Proofpoint-GUID: 3bae4B18-kEWwKf8RyEIc6u9JffOFGJ_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMCBTYWx0ZWRfXxiOPKaSk9BeE
 R8Xgv5iduQ/HaMpP5AGO+G0iF39vON0LvyWhf7yYJwdC9NM57sWFsmKVkvFflw8FYKMUus9KRST
 39DbHC/vdKKpfvHLQ1WzdYt3AlXscdo=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5f48a9 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lt5aTsHmsBbDyw7JONsA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210110

Hi Bryan, Mauro,

On Sat, Jul 11, 2026 at 9:36=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Thu, Jul 02, 2026 at 05:28:25PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic P=
AS
> > TZ service allows to support multiple TZ implementation backends like Q=
TEE
> > based SCM PAS service, OP-TEE based PAS service and any further future =
TZ
> > backend service.
> >
>
> Please find an immutable branch with the dependencies for this patch at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702=
115835.167602-2-sumit.garg@kernel.org
>
> Alternatively, if you think there will be no conflicting patches in the
> time leading up to next merge window provide an Ack and I can pick this
> through the qcom tree.

Just a gentle reminder for this patch to be picked up as only the Qcom
media client is left in the next branch for migration to the generic
PAS layer.

If there aren't any conflicts then please allow Bjorn to pick this
patch since the cleanup patch dropping the old SCM APIs is blocked on
this.

-Sumit

>
> Thanks,
> Bjorn
>
> > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
