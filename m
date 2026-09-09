Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF4548549
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954007; cv=none; b=NO0iI4EstOxC6kbch3f74LojNtzeAekDcUHBD7/BB7a+FapfP6xB7x17X8QAlGk+vVnESvyeQxuamlZq9D+ix/eKfEP2rUV638NMgjqnKgPmZ3wBZVTW4CUSr81l281gHE8JSkL4xrKdaZ7CA4jdFi7LiOL78ny+NmpNmUlGFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954007; c=relaxed/simple;
	bh=jyBRmYpXCpDJbVY8rOr855AO6lww7636SkJgGsvfo0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khPn9k2R8mOD77Mv4euJXj56MqQHGHRKzVK4u/2D+Z7+Mog2IjdSd13hLg+nx0354Ci5TllJwoLUN4mRdlA24gvKrtOKCuqZ/CF5Fn0vwFOEc3DtSBXRzfHqp2pbDQL9iLpU9p9Y+h/3cm0HOrxoU6E4wvhoBl+0llwE4DEWzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cnxEkMKV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FgrhBDTq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cnxEkMKV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FgrhBDTq"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BUaWT1184748
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9m4Z66gMGNnKI2MZsthj98sX
	oGQbEn+eH/Ga1n5jBmo=; b=cnxEkMKV9Ekj+H4T1ait1R5G9upQEYnuWn9mGbJc
	8IrGEHHYOJ31aJ9xNnF7C66Y32YIQbWb6vmbCYAazDjacrVrhrAVz+sHfryRnSIY
	VaW/kLAnZ9OaisXsN7RfMaRnHom8OVukQGO2Z4L3u1ck5WLbFZ8cOhpoLCudDnBn
	oFV4M7qgSp0YQIqpObCuC3wffTXFRYVGwv4bfcethAM5mq3z7Ch8gvGaut5NlOPc
	e3bnyGfG1gdiDdOFGr/qtKe4R1I+u2Ke98gPIILGJ7BG5ATg/M3J6MgrvG1mC5Lg
	nw4Ux/0+FViOb16JLflu4n3f26bEVrixornVxfyJ1ujaIA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559rd8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 11:39:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso11066662a91.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788953992; x=1789558792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9m4Z66gMGNnKI2MZsthj98sXoGQbEn+eH/Ga1n5jBmo=;
        b=FgrhBDTqoSIqIYgE1yrmmAZ0KZH2FHf0MEUUFDwDply6BVJR8+qqPZ1+qHyCJf4+pv
         B2bB4orpB5czjRZIyvvqSCBCXxXdJUqml2m0hZ0FTXyafqOf/XQdadNM1S6bFCb19TDi
         UqwBoUhWevEzdx2KpJ4r8O1W/ltDYKJnA4N9Tq7cyMqblqz/STSH9B63sTiYZtApZnzn
         4rBMxJrbDZ/Xqf+FmPZyeK/InzFXwL9bLbDuOoQqHZKu678gcKRfOnhEhriXmD1arS2u
         91VB0hj8oHxG2+B3hy26KUs3B/2QnXfanlZG97xeiSrmAWG+CAC79lGz8gluz5LUhaPm
         H+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788953992; x=1789558792;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9m4Z66gMGNnKI2MZsthj98sXoGQbEn+eH/Ga1n5jBmo=;
        b=iZ17D7kuXAhKKBUWBIMcROgGCNGtpv/pQwaazPt6qF3SnkYwHtbmAE+DhEKkuBQtO2
         TngH5waAn5AvNVcXLyO1j1A6fbYKYvw0ksbCe6y3EAjRgdHdWiXVnCgORqrwt/MgVljb
         r5VQgeUkAEpejSYH+OUioqFO3PAwDkR0QT/Obe1H1sGK+r0lDl8WYgT6ZBacKjmV9J4m
         pPz1RVhTcOCqtUBmUfvHkPj2uLbBhSnAYEBsRiuWnJAkoBlPsWPZGsQazQd5SHj+ipS5
         Wyjpog1KN5BMGS5KWInJou27970B3TUZWCKA474y74hJFuI1P2KEiB6/QJmn0mqi9HKW
         lcHA==
X-Forwarded-Encrypted: i=1; AKwUvBxcT1anDEG/6U6wpsk41eerkFWeS7O+EjlAuysgw8vJr8zDP4MLbn4ewQ/HfpxET40fCfhCHLE=@vger.kernel.org
X-Gm-Message-State: AFuF++mwQeqKuL6UTWKZKqlMMNFsn4nfKQaBZDKgnsMRwx4AW4DLDYR7
	BH+hyqjOI5UOlpKk3p49sR75hA6BREuYEMXGUlybqcMtTU6PQ+PWDIBb0Y3/Gxi2ilzalUzpz3e
	B7NGhvXU9D1YQmboHgjVnLnsS5WtkqNC2liP/BrM8V2QD/XLCUJjxj682WAI=
X-Gm-Gg: AYBFou0Pmx0F/4KTnaljj/vKR+v63fCDd412V0Gb6Qey7xlmiVthry3l+GSihJYkMrC
	nIJ3SOt4G7dB1FVop1HJE0/lK8QiAKmJ/YxSC0q5/zAGSAOf0iYmF4MyfItUsx7Hf0OVAD0dJFX
	iyIcUkIpCVAeU70gWf0d5w9ECbZN82ZTinV4GtKnRV9fZf6604Emdn7Fcdv4W8v3YZlRpmmEHLA
	USe0Y4V+v8yKi2jPEWRbMJDxT0KHs3RAAuB6nvXmmPIpwLx/mAyU0juylyyaAZ23c18yvlEiwtD
	hh0R0Y34+qukBDbRna9aWdtuUHgKu1AyiOPCb/nf6y/wutClQ6L8YR3VwG3Gp8Zq0dARkafOBNW
	Td9kX6q9EVXePsQ==
X-Received: by 2002:a17:90b:3a0f:b0:398:de23:9af6 with SMTP id 98e67ed59e1d1-39bac34a3c3mr7585793a91.15.1788953992508;
        Wed, 09 Sep 2026 04:39:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3a0f:b0:398:de23:9af6 with SMTP id 98e67ed59e1d1-39bac34a3c3mr7585750a91.15.1788953992067;
        Wed, 09 Sep 2026 04:39:52 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm36764429eec.6.2026.09.09.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:39:51 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:09:44 +0530
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
Subject: Re: [PATCH PRELIMINARY 1/5] arm64: dts: qcom: shikra-iqs-som: fix
 GPIO138 reservation
Message-ID: <aqFFgPpqsHG2N96X@oss.qualcomm.com>
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>
 <4aee70eb-bd1d-4320-8921-e55bb8e0d176@kernel.org>
 <98602703-4a1c-4e91-b7bf-934bb9894eb7@kernel.org>
 <aa6ec351-70a3-4edb-9c8d-a1cd2565fc29@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6ec351-70a3-4edb-9c8d-a1cd2565fc29@kernel.org>
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa14594 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=eU4lnWU2jQs4ucgFyO4A:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: aVA0OQ1uRJ9t5HKFZRKDcZPVPq32ivhG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMCBTYWx0ZWRfX67sYXVyfqD/A
 QQCnKoaDlut5PwZOhk9BnE+5mHtizsJfszdadJLC5cjuIGWci5C04BallPMedBm3ENVOA3fjhzP
 M++YGf6BjUQBKXLFMO0pSaC2N5xSLts=
X-Proofpoint-GUID: aVA0OQ1uRJ9t5HKFZRKDcZPVPq32ivhG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMCBTYWx0ZWRfX9UEq8l+F5W0s
 uHLE+q2N6MG0CF8Eqy2qsGfyO2XD+mlSPlY/O3bPFjgmnSaehwsEkeN/EMbWNXZ5rFl/nH8t/ir
 wquHE+/XUDWPcwmHbNVKMuFWYVEbb8bKWBCVoupBKVdba5JZ0sfiXDl/uG8AVRtLGBX2q6ipvWT
 DkXjxtl2Yl9LDeY31WdzOPegU5ZWJc0fcrRAfuV9IiF0vxyYoGNnh/Nh0zQdWA3GZNboZq+DFXa
 /UTHpQ2HC9r5Arr/x4UMGNbFyzZFE9vmbXMVYTiZp/JIwtbRNEddtmQbgPFd+CGf5XBCp/mFYNK
 +R7FjAiKld/kXCLPgtpYFS2+0LNdl4UQ8U7tIi5sCnvRJRFlVDGZcUPAOpO9PfWgohqp8UnNXU+
 O/dL8E7dnagAnKiW93j48AHCNkU9vu1Bbjl4jrmwkptYesEgSoUoEdiFsVz/BJ4vvYgPrXNb3OZ
 l/t8PgINzwT20uo4Mcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090130

On Wed, Sep 09, 2026 at 01:33:57PM +0200, Krzysztof Kozlowski wrote:
> On 09/09/2026 13:30, Krzysztof Kozlowski wrote:
> > On 09/09/2026 13:24, Krzysztof Kozlowski wrote:
> >> On 08/09/2026 08:23, Mohd Ayaan Anwar wrote:
> >>> The GPIO mappings on the IQS variant differ from the CQ variants.
> >>> GPIO138 is connected to the RGMII1_RX_CTL pin rather than the NFC ESE
> >>> Secure IO pin; the latter is connected to GPIO49. This incorrect
> >>> reservation causes the probe of the second Ethernet port to fail:
> >>>
> >>>   shikra-tlmm 500000.pinctrl: error -EINVAL: pin-138 (5d20000.ethernet)
> >>>   shikra-tlmm 500000.pinctrl: error -EINVAL: could not request pin 138
> >>>   (GPIO_138) from group gpio138 on device 500000.pinctrl
> >>>   qcom-ethqos 5d20000.ethernet: Error applying setting, reverse things back
> > 
> > 
> > Apply this patch and reproduce it. Is is possible? Didn't we talk about
> > this already?
> > 
> >>>
> >>> Replace gpio138 with gpio49 in the reserved list.
> >>>
> >>> Fixes: 779aead2dace ("arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm")
> >>> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
> >>> ---
> >>>  arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>
> >> This looks duplicating:
> >> https://lore.kernel.org/all/20260820085347.822-1-xueyao.an@oss.qualcomm.com/
> >>
> > 
> > Ah, no, mixed patches. Duplication is between other works:
> > https://lore.kernel.org/all/20260820085347.822-1-xueyao.an@oss.qualcomm.com/
> > https://lore.kernel.org/all/20260826-shikra-dtpm-v4-1-8476223184de@oss.qualcomm.com/
> > 
> > But nevertheless I am sure we talked about this, that commit msg and is
> > not accurate... Cannot find the thread, though...
> 
> So here was v1:
> https://lore.kernel.org/all/20260612-shikra_ethernet-v1-9-f0f4a1d19929@oss.qualcomm.com/
> Where I commented that code needs changes and now we see again v1.
> 
> What is with this patch versioning? How is it supposed to work:
> 
> b4 diff '<20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>'
> 
> ???
> 

During the RFC, I mentioned that I will split out the series after
initial feedback. So the RFC (after incorporating the feedback) was split
into:
1. This series (v1)
2. Changes for net-next (v1 and v2 have been sent out):
  https://lore.kernel.org/netdev/20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com/

This particular commit message needs to be rewritten as its not breaking
anything in the current tree. I will fix that and drop the Fixes: tag.

	Ayaan


