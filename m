Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA64A7C95
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168256; cv=none; b=Xjyh+hh+l/sp/AXhgt6iD74gM/U8ctVxSJAO5zfdZez7+q2u5FCcIAL4FERf9KqfNLUGgnD4sRp+1uVjhfcA03Arab4gDHWIdEiVChAXV+Forj7ElPeEe5nBJLniwVSPpaggdWU1V4Qu+QVOxoNgisFtHeYeN8ztngAjNohfHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168256; c=relaxed/simple;
	bh=KzkJL9XecANA7DSkd5iLEuklmtZkLKM0ugeoY3qIemo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzZ7OrZnvwejhC0SJJ7mH/k2sFBOQpL27W7vKzBbb2FLXNzGBj0TNd+u7AL5XSgu75wI3jg288Hp7Po23emh2qlyNDDlPa9yzICFG7qavuKDCJk+zwIstvo2Qtt87hPFA8+y4Pi4u2wC8yBJDhGhF7qHyPhE1Ue+8VV/w8KZ0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hGAYGIDP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bkjcPUEm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hGAYGIDP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bkjcPUEm"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbYCd2637962
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=wJmkchd5FFosOFCSNaAhYNUs
	9kr6IgwsEZr7XcXzpQc=; b=hGAYGIDPQ4nJy7/DCaS5ax7FHJcRBp8dG0Rj1gpo
	tusgnm4lFb8uqIP93OQciFk1qwolRc/LNh9Ie83Jp45It/mfT4FMwvxkyIauhFlE
	mo5IrEaKYt3/BI/epa3kUe38Yb76SEViULYxu2pbUjH0WgrNAv9nxNYU9KQ/S+BX
	ywHeGGS6rxF+Gx1wzEgsPLTOYZu9UvvyBsM65TVoRLnyYwFFy//y4mKd4P514sfW
	a6TTFHLMPhog1Q0vUSudfzNZ2VVOux08lkAlfuF9Lgse5vThpxbrffktcMLDTOvI
	yKpYyFmN+o67oVUJ6aaKHk8IIwIhwEXYPQPOOpuEd1jlfA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqhmyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:57:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381250979d5so818542a91.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790168253; x=1790773053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJmkchd5FFosOFCSNaAhYNUs9kr6IgwsEZr7XcXzpQc=;
        b=bkjcPUEmfADCRA/EwwN8Fk+vIB8j9q8Ps+9kwv2rUFtWfUaIvlASQ/mqV45UIlj3Te
         KXgZI/hpYjijt9ZGp6UwNmTNn7Qvm5A7Ordw/4NJ2AOcxZayqxPA9+d9NRxHD80xgeew
         q9UPSbpufD9ueBm7wWIHHofMfNT3WA0qoekHQCHNdbg0A/Vo/42/64Zx6ZA+pBps7u9A
         keAJS8toizFIHjjqOXU7pyph7h476kfnnHHLalMszn8I5tcLS0o0jZ7BRV4w+egMTglX
         CmwMOTv0GvLQHDzts24ATWKyOQhIGTUizX2QEZQ8hBLAekZkmBs5mKhj9maOj1yVQJfi
         8SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790168253; x=1790773053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJmkchd5FFosOFCSNaAhYNUs9kr6IgwsEZr7XcXzpQc=;
        b=0mFv3ylhWT0LzhRs9wZTXV36O7WDMQQmwZkql8U4z/cw2lAfPNGGvswf0i14vByjB7
         nl2eRNfZ+zma5euUA7KofyY9WYMNIAu+yL+wSE9UvPuAu01D9dcBJNEEZWB8WjT6vegu
         roibU26Ex+A4l960KHbogRCwTjdLvi2OoOukoC1HJBjatvGDMPYL+gqx+djp/12f2uXY
         rNEjT5yvDP2JvoPwMlpBFfaN15NZ1aaNAjha/O7pFBkIWf2UnZtli31i0wNrvctLzRTg
         RbWEOhwQIMqJ2pCQFKRgHdHUkA2AVac2b+1z9guUHKkjf865VhqaktXj6JWswdnZ1H88
         1F9A==
X-Forwarded-Encrypted: i=1; AKwUvBxrrTXaI90jTU2jpxy5IFgpx1D83fSKVTkqDrMx5h25FuP2z2uulSud3U7YG1Q6yIq2ua87sSU=@vger.kernel.org
X-Gm-Message-State: AFuF++nlrcnEne0PczQdKeaXd+bgYI2hIGYbMqkv6C4RxGaV5KZritEb
	ju2bfubw32i2a1+1GFZGISL8nhia0ZJgb35OvG/vLFRZ5lC5V08QZYc06lAnewq2LvQKecqBit1
	onD4/qkqj5WFJWY55e5u077l46OQg5BC55ej14orfz9RLElmrfjkiEjn+AOs=
X-Gm-Gg: AYBFou2QNdc+PG+/7UHSz6wrRcm/dN7GzsYQ/0T8ot+1Ka5ub/DbBRhLin7cKlBkPuC
	z3BzLdiPo8cre+PZ9IvIk0E627YLmWfLBtqoUNAPoVJuwzZ16zxkuFd3LhO3Xw9jWDBDBoxMdCb
	vkHBvgPH67Wk20IfErTgjMjYYa7nHaBH8MxP/8Ml5m1yDpbyNpvZCENHvPE0Ybas1Sv7VXxZdue
	jai+MepmdLKPRXF5FOmIWne6AZ0yrSeDeMxs5nleji1xqZuoy3r/oroabKSch4L9x26ZCR/9Vwd
	WjUVF9ZbwsFYlN8RrmLPIuwU62PWQNptlOeMMf6HHsiUD0tTj6fHAEnPPEDv2E4CAeRSj5oLuwX
	3DnY+poFebNqE
X-Received: by 2002:a17:90b:33c9:b0:39e:6a81:f34a with SMTP id 98e67ed59e1d1-3a07e6be363mr1943541a91.36.1790168253027;
        Wed, 23 Sep 2026 05:57:33 -0700 (PDT)
X-Received: by 2002:a17:90b:33c9:b0:39e:6a81:f34a with SMTP id 98e67ed59e1d1-3a07e6be363mr1943518a91.36.1790168252430;
        Wed, 23 Sep 2026 05:57:32 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dbc5451sm5788341a91.7.2026.09.23.05.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:57:32 -0700 (PDT)
Date: Wed, 23 Sep 2026 18:27:22 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>,
        Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Subject: Re: [PATCH RFC net-next 4/9] net: pcs: xpcs: add Qualcomm Nord
 platform support
Message-ID: <arPMslTgeohefnX6@oss.qualcomm.com>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923-qcom_xpcs_nord_emac-v1-4-4b1c682af70f@oss.qualcomm.com>
 <b7cab76a-c2f9-472a-bdde-162e1fcb5fd0@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7cab76a-c2f9-472a-bdde-162e1fcb5fd0@lunn.ch>
X-Proofpoint-GUID: h41B2otikhx2tZyUGsFA2Ilse9qwR3Tc
X-Proofpoint-ORIG-GUID: h41B2otikhx2tZyUGsFA2Ilse9qwR3Tc
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab3ccbd cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=mHhYrMsX9GfO8_TZ82YA:9 a=CjuIK1q_8ugA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MSBTYWx0ZWRfX7oqBOt3AGuYv
 2Vt+k3f2A1o4sFLUxcvUfTc6MV4IThqzCPlOJJyPZaasszD89AqCA9zTfyvYcd9Vc3f92vLAZCc
 N4O4ibxLKYLAR+psBSjxkGljKOeIieY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MSBTYWx0ZWRfX3/fa43WreNtb
 KxviPfkarmWMAojBb1X0JHIvG5AVYWMN5vlUtOyf4b7lOF6/2aK4zCAoJU2mYa47sZWcjY7vKPG
 yHDngRxy9Bb94hHJVAQHA7mtvtBuU8ROC9Y/hE41C2fhI/H3YUQuNwI0KjpX3wD1tftnokH3DA+
 V/2QyMMrgkrv+iDMbKEXrSOsTHQHSuHjOE6pSEhh65Q6F/VAGJ6CPlkdiuU+EEOU1wTUNyOZqb4
 JrgDz/fYQ6X5+j1Axa29E7jGFexUJAz0EfbGodmEtqPj4gLezPZ3rGSgKgWyjYoFQdwfuxUUdjq
 1TunNXBHD4wjvDt/idTMA29iRDzwOWDIyCwhba93YQacTkJ+dMVS1Ow0Wg17aVSXxn+ScwQcFdD
 2Zsqd0e057k3AN7GtfibRQaRnUeNmxwsBLlDcP3X7+scBVm/cpUqx55QYZgqUkdebKlzELYEVvf
 O+Q/vFHqZ9In8OPV5iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230051

On Wed, Sep 23, 2026 at 02:07:07PM +0200, Andrew Lunn wrote:
> On Wed, Sep 23, 2026 at 06:37:30AM +0530, Mohd Ayaan Anwar wrote:
> > Qualcomm Nord exposes the DesignWare XPCS register blocks through
> > separate direct-MMIO windows instead of the standard contiguous
> > MMD/register layout. Add accessors that translate MMD accesses to the
> > Nord windows:
> > 
> >   MMD 3 (PCS), standard registers: SR_XS at 0x0000
> 
> What does standard mean? 802.3 C45.2.3 defines registers 3.0 -
> 3.32767 as standardised. 
> 
> >   MMD 3 (PCS), vendor registers:   VR_XS at 0x2000
> 
> and 3.32768 - 3.65535 as vendor.
> 
> However, with a length of 0x2000, there is only space for 8192 of the
> standardised registers, and 0x1000 gives 4096 vendor registers.
> 
> >   MMD 1 (PMA/PMD):                  SR_PMA at 0x3000
> >   MMD 31 (VEND2), standard regs:    SR_MII at 0x4000
> 
> What do you mean by standard registers when talking about VEND2?

This is incorrect, these are non-standard VEND2 registers.

> 
> >   MMD 31 (VEND2), vendor registers: VR_MII at 0x5000
> 

Overall, it's a mess, with some registers marked as reserved, and some
not defined. I will go through the list once again and document them
properly. Thank you for the pointers, this is the first time I am
working with this IP and I have found the specific version of the
databook to be confusing.

	Ayaan
