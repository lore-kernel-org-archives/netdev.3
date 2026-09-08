Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A6514756
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859906; cv=none; b=BvB4nt59YuRoCyrnKjLZunK1ENQ08zSPYaUq5L3WhA+34092ZYapPkV6fVFBtfrbmJCAI3DKQN4w2qHDZyjzFqQ5MbHF76PAJJ0xvnXGKWMUJsKsf27XrNwQkzpe9JLJQnie+9Qn1s/9RciKcuiHLu1OqPh8UxVFj+EbCi9+NRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859906; c=relaxed/simple;
	bh=NtWIdZwWcBMt/vTHkLK/bNAMKB0wwpukukTBna3f/Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STUP8w/w4Oe48lOaTO9b11AqfUgSB+XqAWH5LRqVOuZhds0qiKn2XdgRS3Y/8dp3sLPCBfsXtyfuu4G+VcrauetGWu1Dc8r4Sr6I/NYMGeKC7/YLyak78pCiiKfJ9AvJbzhc+g+4CVMLzeAoeFQ/Vz6Ye+9MGX0T28axAfpFqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eGwJ8llX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hn9abTrm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eGwJ8llX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hn9abTrm"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6889MYol3121013
	for <netdev@vger.kernel.org>; Tue, 8 Sep 2026 09:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pFQuRhixWFDDoRatZnflwom3
	l9EKIkxU8GYrNZNTb/A=; b=eGwJ8llXiMuCqx3KHD8pVIrj1nhM4g13dzAKg9v9
	GLK0xeHqgc551xVatJtTI5IOplramD5HkVvlljigI1z96VwZDSkQmokw+dMpz+aS
	CKqEg6f5dcXc62tEofYxdzUPD9pPMPo6nYRuglWDTeTAm6FlZh9pQuFqnPVaovjk
	gE+hcVAK2+8FTNQbxRQzOG5SRLT6Kuy8k1q9wgk6Bub+fMMz3cCHXvzLvY3qiG93
	GQ1qu3/uN4Ze2bb7/j2fPQVu1aVYEaJ74KtH5Us2gheObhD4LKjxMO0vgSEfl5HB
	TrLFdfm/53jR5ohC/+F/Zn8ox0AejtuHF7tCucl6aVDDcA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp4819c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 09:31:44 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6b1b19eab8bso2375767eaf.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788859903; x=1789464703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pFQuRhixWFDDoRatZnflwom3l9EKIkxU8GYrNZNTb/A=;
        b=Hn9abTrmdA22Q9S0oT101b0vashHwCIy3Qerln5C8rcoipyMoemv2T1CtNxnAY0ynr
         iG8U/LnVmac5nyDAWJ5agmY6RVcjTbmsHyIOJWrgzMfqlI3BtVp/tWDokZOYAv1PPHEr
         cgRFogfHpDzD9+7gcxIkg8v1pgmf4oyQgitijY4ocal07P2HN1dV22qm4LalNLPycGmm
         GtSoFgBBfEjaRN6vYbnHoPllBBe2Cjehp4atZVlz+CeQe2haoZkw3uu3CD0/h5YLWEQf
         SK85zcAUe+djzuNdDYmi8YYKoaemsSUhyOrQ9Ykhn1hRtsOiBvKu6ZnDhyz8sjZMy35O
         k64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859903; x=1789464703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFQuRhixWFDDoRatZnflwom3l9EKIkxU8GYrNZNTb/A=;
        b=I8X3o7gtruVPsx6ES67OqsAqQwmZM27IVOaxWfD7slS5871bik7/SWwcM8bpGKtBYZ
         p3x5KEL0F0010WbMUq/im1IKOM86AlucCmUlsAZLRlqOVnJb0kfqGUxAfH75pxtaD1LW
         ddJcIjChgavto/UtnzFhqd49wdVvZZd2bbyaACCAjp7U0rU2M39Bc2w5Khr240Cdf6m8
         3pMMKkVXizz/mmwR1ogNW4rNKSS4Sr9i5rGQQOgaqcLnTXmtouuKKnYILVsklX3a1Ru3
         tFVbMbjeTKUDcIqZgBeaEtPVpVQvOKMNh9BYLkxOjUJb/EKOkpfI5WTyRbzfXlCAw9ne
         gF+A==
X-Forwarded-Encrypted: i=1; AKwUvByFSHWTa9/nFnsyRNJnqnU1DrX5E4f19ln3HTh3GfVvloghN6IadY22YKMG4B6+4EbVHynd2TU=@vger.kernel.org
X-Gm-Message-State: AFuF++mxLsDeyF1Jx0TfLMPsaUDSqWJq9Dgi5czaxWVcdEBuWd2jcPME
	S91lAcafHUHbTLNuRZHkxJ33FXAwDn8WnFChKdrFi7KoJGGDcj62YzQ1XjOuLiSdxZVcAImEaTV
	SJlHvNRG3kzuV1d/SkBsIMaauRX962SWrYKPNLORc1vwZJXHMtNqGFvYi2Ms=
X-Gm-Gg: AYBFou3CpF15JzWPEGzUD5sjV2sKWNdECbb5z/x8vcXRiT+6GiXChQbx+OQKsgvhc54
	Kw4RNe5HKBO7G8vWGqV6Lx0yOn3ICEBt0H5pHduV7EPccQvCgk15/2nhbn1gyIA0qTYPZRxnr7O
	N9av1X+kyvqD5TAzNtd77uND58dXtxXSpze1RLiWtv0JKRrU6n1BYFhsjotmqgYgFmjuAep/7T4
	1ECUXQmBXLQwWPsH1IEIvFxDsoMq4lDsgwuwm/X91o0XtraywCIJzhoHRCiDCGMlwB/56S3mw+q
	Tlbd5DMYOEzsSKC5BDjE2LFhT46samXOOHIQQh9j+HVOSjOY/7AERCwnJhg5ETtlf2NOdJmBLFY
	RczBHJCArFQMH6Q==
X-Received: by 2002:a05:6820:16a2:b0:6b1:4280:9e18 with SMTP id 006d021491bc7-6b6fb8d26c1mr16621476eaf.13.1788859903147;
        Tue, 08 Sep 2026 02:31:43 -0700 (PDT)
X-Received: by 2002:a05:6820:16a2:b0:6b1:4280:9e18 with SMTP id 006d021491bc7-6b6fb8d26c1mr16621437eaf.13.1788859902560;
        Tue, 08 Sep 2026 02:31:42 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm54654325eec.16.2026.09.08.02.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:31:42 -0700 (PDT)
Date: Tue, 8 Sep 2026 15:01:34 +0530
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
Message-ID: <ap/V9mzGUA5lIbLi@oss.qualcomm.com>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <e9388ffc-ddc8-456f-ad7f-1d185d35ab69@kernel.org>
 <ap+zd/2QmerMwi0o@oss.qualcomm.com>
 <c23369fc-84ff-4881-8327-c18fc3692306@kernel.org>
 <ap+3+Xhq6ygnPzQ7@oss.qualcomm.com>
 <fd428d1c-646f-47f1-9fbb-91f3b50760dd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd428d1c-646f-47f1-9fbb-91f3b50760dd@kernel.org>
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6a9fd600 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=H1_jG3o4hEjZ8bdWLZ8A:9 a=CjuIK1q_8ugA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-ORIG-GUID: e3cIUlS2NYAYapSLb2PGs4ctH26pMZ1K
X-Proofpoint-GUID: e3cIUlS2NYAYapSLb2PGs4ctH26pMZ1K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDEwMCBTYWx0ZWRfX1RwFfaDpcUDz
 /N7UtYNKnSDfcLEXu2Wps82ixL6QP/AKgwyuZaDXi9BWM58ZR/bhDHjsSkkBVpVtanWZ+MtJSdI
 RiS6fz6wwZMs+rWx72knpoiusuXSHIocy5GX8Ij2QJ1J4L+YB5R4pkT/5u76VQqdZvVjoB5aWJF
 WJzbPK0/J0y8z3UeyBznMilyQScfowsQ+3L0OP3uhb+R3WHRESrMegx9feT2vf4B2Qt1285U9qd
 WNL1Rw6DxNtma2UH80gkjgnSE09fS4OZKxFszPuETAI9zsFknuUKdENVfDvRJfxG4wl5fRfqom8
 V12seg5CFZm+enRKd3S44YyR+vU1G/2lY9VREl5ysGOu4aRucIH9shKI6vXtgTGIAa2MosKoCXJ
 jOZZbV1cenBt/81MBoCLIjjf4Z7Q1O904kYdjAFGWZK78ysYEtYWx9lmw63Fy0DJEYFB/ed01hX
 1lNYRnWuFwmxogOiiyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDEwMCBTYWx0ZWRfX9wIajIR8216k
 fe0PPj0R9pKJAwxJWXP4/40BDgdRoA/LqRi1Ndlv0qsxIo53Sqp2tZ7vnMJDg0/DKOosnuPoJFV
 D0GnlK1UAj78DudHvtA1bA6BhA5Ruyc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080100

On Tue, Sep 08, 2026 at 10:40:45AM +0200, Krzysztof Kozlowski wrote:
> On 08/09/2026 09:23, Mohd Ayaan Anwar wrote:
> > On Tue, Sep 08, 2026 at 09:14:45AM +0200, Krzysztof Kozlowski wrote:
> >> On 08/09/2026 09:04, Mohd Ayaan Anwar wrote:
> >>> On Tue, Sep 08, 2026 at 08:56:39AM +0200, Krzysztof Kozlowski wrote:
> >>>> On 08/09/2026 08:23, Mohd Ayaan Anwar wrote:
> >>>>> Hi,
> >>>>>
> >>>>> This preliminary series adds the DTS changes required to enable
> >>>>> Ethernet on the Qualcomm Shikra CQM, CQS, and IQS EVKs.
> >>>>
> >>>> What is "PRELIMINARY" patch in upstream? Where is this process
> >>>> documented or expressed?
> >>>>
> >>>
> >>> My apologies. The code is ready, and I was hoping that sharing the DTS
> >>> changes would make reviewing the driver and dt-bindings a bit easier.
> >>> The original RFC had them together, and I split it out for net-next
> >>> and linux-next.
> >>
> >> Yeah, but why calling it completely different than every other patchset?
> >> Why coming with different style? Why this cannot be RFC?
> > 
> > Agreed. In hindsight, this should probably have been an RFC v2. I saw
> > some recent series using a PRELIMINARY tag, but I see that its
> 
> Where?
> https://lore.kernel.org/all/?q=s%3APRELIMINARY
> 

Please ignore me, I should have labelled it as an RFC. I mixed up two
very different things (some off-list patch I was CC'd to and LKML
patches).

I should have waited for my morning cup of coffee before hitting send,
sorry for wasting your time.

	Ayaan
