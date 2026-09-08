Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235739E9DE
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853166; cv=none; b=bLFVV6T08KMg/dUxuPtDOffOud/ljX/mS3f4WTlAI5HLoEwyAnhTByAo5upEdhbsf8h1i6GtescSc8lGPEgKEe7tEUkmy9Qm8VhPluapERnODQL6ozUKjlLWnZnliMbUs2uuKQogzG+J8DEiBbX9QOVDfCQGSXdvwtnqWy9DT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853166; c=relaxed/simple;
	bh=ndiQlkOabMvz2xRfex4FJpIVycP1b2hV2Ntdbd/KTmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kui+psb6wYB3d4EniECmtH7ZiAIgwASGPxYQZyHfbQxXsWXmKKjuvWTXuJO9tpZQB+gLRTJ+WtwOL6bb6OCod0lihvV7u6EAnpEhw4L035I39a+I30HdwR6N14CmGjUbVBhkpPTPZFlO7pBvueHUfGFFDLwc7XvW2CE/0tXrOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XWkQPERk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZC8unHgk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XWkQPERk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZC8unHgk"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886LqHY2172782
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 07:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Jnh6/unQ/9XWBJ9cydh2x/HD
	zEEBeHRIBD4szcO5/UU=; b=XWkQPERk/SJnvY1Kg6J4/nK3lXG04D+vm2X2Pu51
	nmZFWvjP17uighXN/Kc3CFy2U3G3h+ADg0xwexAID9uv368cqi3CGsBuqLylQBaV
	WDX/iS+owaGTSb5586+8OLJHxPmRHN5JU8LsXM4RvguUuOaZvJyNqz1gXJwgXHWe
	F555Nm21UAp0gpPRBqTbe/ze5h37HIoipbMPSXO4//uf6NVpd66CRmsNLYevgKVf
	mTV19pvzFTi5P9XOrXeDZzRnv73P19X4K7Kz6zsZ4IujA9ycHMdXM7Q1QeMiyOv6
	JxVbZmPU23wDlwM0gOHg/7SiBxzJ/ni9zELIVBDMsykVIA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rrjadc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:39:24 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b34c5c6de4so4675122eaf.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788853161; x=1789457961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jnh6/unQ/9XWBJ9cydh2x/HDzEEBeHRIBD4szcO5/UU=;
        b=ZC8unHgko+pySsAR1fyMQq4hCjIiGOLLRoY3wzbL/iFXbT1zPZmL2xcG45rcp+dPJx
         /CaPjSBVqbaXEhoRyiA4/H+y8JUwq4/d/1ZyeUW/c2FHwPDIWYljfLpcNe/F1LJv8cT1
         UJkOK9OeH7n1yBkuDhuenlrbv3YHQQpF1uaG4z//DQhSffJwgAW8zrSKXVYopHqomxHG
         CkaWpY/Z9tQchGjZambqiR3RVG1nGLv1wSw4kXZMMiW2FT3ovn1pbEtmG7vPDVEFhZwY
         qUsZ3K4YgAorelXAzxclP9luQtmbxkuHkWSont5TFhnpybpy+jFaw4F9BWiPiTH5jknI
         tueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788853161; x=1789457961;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jnh6/unQ/9XWBJ9cydh2x/HDzEEBeHRIBD4szcO5/UU=;
        b=Aa4WhPBftvQzVz6meDwOpKCm7FLbzxImfPtrJP8f0iW2x2gN6Unbw0I23/SIzomAtl
         25jX1/pXR3vOvXZ6dsGdySTPwq7r07Gm/PnHO5vFjditXrBA9g7hgHjVe9yAnxdcKFuj
         Z8EsCiTWh5zHnDMAtkcYkSkTWR8nFTOg8po/PWMLVfC4rbU/oABj90rz3lwEuThKinfZ
         FD/KyhvDfQsp89y3+IAuYzkp2SiaTgW8IxqZqHsF657icNrHPriI1xBx7AuKi4Nky/4F
         BCbnQ2xabOT/8KwMF9iYMfAlKTbd4tLccrhvmvDoFMaJIkDZlfq8P5WEMHiiT2HSfCfJ
         B6zA==
X-Forwarded-Encrypted: i=1; AKwUvBxSvSknd9sn11w9FJ1NKgif5e5SSTe4AEv5EpwIzs5HADeqO0cTb8gXK5uq2nmVQY8myuXZHko=@vger.kernel.org
X-Gm-Message-State: AFuF++l39mdV5RwqrtFtK/1db1QzHWXkZMm2XBTiMQ8/nJxaw5o0GwZs
	eLMPRJFNOAW9gLqChfJE0valjMUcDUM4HHIlJ4161Ar4nDs+6/IgyOqC9S+8jFR6Sl3j6c2SQxb
	3tPjOfLlmfJS8L/lJex0K1bi4/b47X5g2sKuFLpdhLJeB1Kx3H+nn0DsYP2U=
X-Gm-Gg: AYBFou0r8UEhhQexgHxwO+3sVAv37ThkfZ9EHCBu/yJtpvTV58MMZvlnEGiD4D4WXsW
	zu4Q/nPXxSwLQD+EIQC6gJDWTs1Jo6dcrCkLbBYB4Va8XDzd9ZpdA6LMP1RZdN/NPfcjuxBB8DE
	cOK89IdiPYb7n5ErRJ3Gqy2uvScs3i5b0U1ET+V4t3sTF7VSy7lwdozoxdZ4S8+RIK7/jeUFIwU
	SCvSDz5D9tNUBfJDHRPJfRI3pu4uT1abG8DMT+GsiZatztXVFZQQ5t5yib6mOyFpvjkQa348e0x
	k7C69trjNaUzqg1Dg4B9+WMmbzqgJBqR6I2Cy7viXybhfoE2ELjO+lk5bqWgejz9Zg8LUI+HJq7
	HhpU+juj2nEFDgw==
X-Received: by 2002:a05:6820:f034:b0:6b7:46fa:16a0 with SMTP id 006d021491bc7-6b746fa1a27mr14489626eaf.53.1788853161219;
        Tue, 08 Sep 2026 00:39:21 -0700 (PDT)
X-Received: by 2002:a05:6820:f034:b0:6b7:46fa:16a0 with SMTP id 006d021491bc7-6b746fa1a27mr14489613eaf.53.1788853160705;
        Tue, 08 Sep 2026 00:39:20 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm29571562c88.3.2026.09.08.00.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:39:20 -0700 (PDT)
Date: Tue, 8 Sep 2026 13:09:12 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH PRELIMINARY 0/5] arm64: dts: qcom: shikra: add Ethernet
 support
Message-ID: <ap+7oEcW6GONVdEk@oss.qualcomm.com>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <e9388ffc-ddc8-456f-ad7f-1d185d35ab69@kernel.org>
 <ap+zd/2QmerMwi0o@oss.qualcomm.com>
 <c23369fc-84ff-4881-8327-c18fc3692306@kernel.org>
 <ap+3+Xhq6ygnPzQ7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap+3+Xhq6ygnPzQ7@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX/OaOyoUtmCgt
 4xjniO3w8yIEivGABBovqsuCNg4CeUuxpYzlNvmpUqXGhFs42o2LH8RCxepsMUCgTLdlKOy+LY1
 her9LorsPGOy6QuKpz+dHpY4Y7gfGnY=
X-Proofpoint-GUID: G3weDdunKaskzujSBMvnykE811hulDhl
X-Authority-Analysis: v=2.4 cv=NsjhtcdJ c=1 sm=1 tr=0 ts=6a9fbbac cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fpx1x3OIhUlXpLwz0nAA:9 a=CjuIK1q_8ugA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3OCBTYWx0ZWRfX74UdSxjM/nsV
 xoS8XuT8U/ovrzKXypIpqEoFK2ZvxglZwe5oDVZs8amKc95XQhZ2Gf2DorDKu9mwDWcF8dGRb7d
 cPTfINbLRUNoW2JcWjU3su9rjUM17+rHtVQpmKV7lMBIuFn/6HfxOH5/DvWA0FVzVdNc4GDFlKR
 PTgZQM92qbzD10TZORhnDSCAk/AiXKPMnjLPP2Q3xsc1jVsUo0RK/WIz+wzcXETJist7PRfhCwm
 lTPDt+hndPIwQT6AaXp0CvGs5Jzgtiw+HlJhoQNvzT2O322ZuKbRcEqOYfqEkx9RNCeqGh48eTX
 OXFLddfo2izkgrxpwSWaxgdY81lL3Pi+J6gEDYy5r78m8GoYclctcczBEkpaWR4Vil3PkyCMmpn
 xpWb4LwGAws3TFVQl6hhYLUA11XJK5YVKgNXAWb88m/dtkALYS/RkO3UFmFHdwITlqgafmcUjsZ
 3pahDcx13rKyemwEQeA==
X-Proofpoint-ORIG-GUID: G3weDdunKaskzujSBMvnykE811hulDhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080078

On Tue, Sep 08, 2026 at 12:53:46PM +0530, Mohd Ayaan Anwar wrote:
> On Tue, Sep 08, 2026 at 09:14:45AM +0200, Krzysztof Kozlowski wrote:
> > On 08/09/2026 09:04, Mohd Ayaan Anwar wrote:
> > > The only reason I added a PRELIMINARY tag was because these DTS changes
> > > should go in after the driver changes and dt-bindings.
> > > 
> > 
> > DTS cannot go after the driver changes. If that is your requirement,
> > then original work is broken and needs to be fixed.
> > 
> 
> I should have worded it better. I am only worried about the dt-bindings
> going in before this DTS. The driver changes just add support for
> whatever we are desribing in this series, they can go in after
> dt-bindings and DTS without any issues.
> 

...would it be preferable to instead have the split like this?

  - This series + dt-bindings (on top of linux-next)
  - Only driver changes from [1] (for net-next)

	Ayaan

[1] https://lore.kernel.org/netdev/20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com/

