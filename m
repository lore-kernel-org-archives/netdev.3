Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB14E5338
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665494; cv=none; b=r0YAzm+aj5fjtK5tGlmo4YiVK8aCmywT+piBNgo5QOQguiItIpG9LHR0OWQzQDWKG/UbBFhxnqTwA44/UGMUnxSK8Frrj5N8oazxeq9JEKVjNtZsNrx1PfxOZ9iboSuTv+IVf7Y6tgjew7ZTUaOhqWm6VJGqsvFxZROwZSorPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665494; c=relaxed/simple;
	bh=JSrGIbjkM8d0NQvST/BovBGlv6xJHhXtQq99el/iQKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvZkcJRokimDBMaiEOEuQ07chFpjiAMNgTdC8Y+Y13Ivf3jzHiIPHSR5rMttOInbc6194WjTGcvRqz//CKX24ey/aPVOCHnV/S+zdEFGX5kFYzyw8AFhEDowxE1Ogo/WMEw0jdLxe0xbr6SyDn18I6S1i3eUctQD1bK4olHrCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YudlXxSM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cLTib6XH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YudlXxSM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cLTib6XH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH5if92553418
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UU3OPZ+AZXcwBF+ykx1YfK6Z
	7ZZ5v6mM/Pmv+b1riFA=; b=YudlXxSMbVq1R/3U+hw0kCNdYy6DO5XxrXM66HYC
	eUxrlmQryFDx1VW/AMcLRuUorMWLDwcYkHz2JgXJtOYXT0SnhUROWP+gbSG9nzLQ
	UmSmuetkRbCqUqZqO1hoRPRnNpjtKOlTep8dsEQQXIfztW+YAABQmNAq6psXU67K
	k4HfRon9RnjzSDkjKsRcudzzSvpgi4gKLPdHMOYuohzZQ2D+iKCVTJlf6ATa9Zmm
	IiNg56w8fXBpgyIQYO/uvX9NwJ20KbtcGDOafBluYlIHZmtivJGe/t0y14bvukbt
	gJG34CRLYpDFgBhIYiwBJqKyfPwqGVj+KfRiy3jyKur6Mw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grfu41jq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:18:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so1174309a91.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789665490; x=1790270290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UU3OPZ+AZXcwBF+ykx1YfK6Z7ZZ5v6mM/Pmv+b1riFA=;
        b=cLTib6XHpom/q/6450SOAP+x4+9f2kskf/XFnsNW/MuFZQtoCC5bYkkwZ6Y/EEYygM
         uPR+ZUzow4GJMQlAYE7fhF39XaTx3VC/04n2mkF7Itr+w/3D36KkcgQr+zAToK3dV4yS
         HQ0wySiylDSxtlpfmYJAb7mJJTrunlaxQEf+5Wklnf54XrTfs90Lvg8zoYqv79xshivm
         dayDoTgheey+7yeIefI13H6oh3wNO8f0GuLRquP6OgIXyd31vhK39ncExqaj4IMHQxOu
         er1WfXGJTTlnC4iwnn8mLPy5yfx+NNVNoPYzt/2s7rQrTzJmD3SNbHrT9R+vUvjnupn8
         /kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789665490; x=1790270290;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UU3OPZ+AZXcwBF+ykx1YfK6Z7ZZ5v6mM/Pmv+b1riFA=;
        b=m2dB1nhKYbDZo7qjG6XpjxXGgaw8VFQ8i8aay8jnpTRs+4coOKg7iajPIqdS7MqCPz
         glIYeK/UGekezIDAF7WWwgCcHPWI+vY3fNtkbeYOwQ4k2/YVt0WhwDLn7xif1mXU9/AA
         XZyGPBxVE9sxl24o4f6wwznL47dq8wy3pknE5XXllHKLJ1d/8m9YYDbm7Evm8DYThK6e
         6Gh5iel5beDEvYUfLobgsPRDRpXemw/qLWPg6M7iB4Q3+inPE8VogqlYu96m2LSdsRpZ
         VvnP7+GtsGhwMvpypA2kPSHR3+eI0DS5wefWDzBFDCgiU7nFzTfaq4bQdO8eNpiU9nVO
         QNnA==
X-Forwarded-Encrypted: i=1; AKwUvBzICU6JfGw9X5AwsyoJXpvjIDk8GBVnIO+RwASmkuzc615o0wnJrlhx9em97RDmm37H0HoxPvY=@vger.kernel.org
X-Gm-Message-State: AFuF++nRF7q+jK//9n21lwIRzRCFF+ebplqt9lsPiVbt5+UsOVDuV7U/
	uLZf4MfLfB3/ZWmdVS6/zI1zsldU0yZ4v0t7fV5h8015HX6h+7gmGRH+j49hqnPcs0q9+4kpQu4
	1AcCVubCcObujSkOAmCWuJSdjt2tIdgxlu8JdZK4MOCHqV6hXIRp4OGM3My8=
X-Gm-Gg: AYBFou11x7J0nX1WtDIN9xJ9XrDoZKXIPDWjxZP2lpxNMFgbVX/TP+rgAMXMGc7lMQI
	KD13lKGc7Us5hVOc3ugr5VaY/fY0wfSWA3Ve/oRv7SiLMBt/nYp/iiRvNB/RNegbcfPebIU7y39
	lFGpzXC+AqG1pBVLfpq20kDSjWlsdirKcmA2GBuOt7gV6MxsvOtQnWqPm7JEK3xh8rrtRaK+avG
	IvNRcadffUNBp5W5iMplv/QWGSHv38V18cOYdKKCssxEwWGBkFSf7tQ3MkGpnjoboRD1J/fzOTv
	XMsQBqN9tIEWq86tL+FB+kKT2h7oo3trcYa62L1E/xmvzRf3VYKfKuz4WczsHh1YL7ECOYe8pZU
	OrODDaQqyQ3dooA==
X-Received: by 2002:a17:90b:4c0d:b0:39e:464d:ebc3 with SMTP id 98e67ed59e1d1-39e464df3a0mr4120360a91.12.1789665490382;
        Thu, 17 Sep 2026 10:18:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0d:b0:39e:464d:ebc3 with SMTP id 98e67ed59e1d1-39e464df3a0mr4120256a91.12.1789665489670;
        Thu, 17 Sep 2026 10:18:09 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35df6112sm6159114a91.7.2026.09.17.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:18:09 -0700 (PDT)
Date: Thu, 17 Sep 2026 22:47:59 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
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
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/9] net: stmmac: qcom-ethqos: add
 per-platform NOC clock voting
Message-ID: <aqwgx/ZpgKG/7Sw7@oss.qualcomm.com>
References: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
 <20260908-shikra_ethernet-v2-8-bbe3389d0652@oss.qualcomm.com>
 <aqGp1D6ySJpTK1fB@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqGp1D6ySJpTK1fB@lore-desk>
X-Proofpoint-GUID: K6TvEOvzw0jodvk3X9EWd-u_1ICQ8ExW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0NiBTYWx0ZWRfXyyJWA9Klevir
 jmO77F2/pfngwqx1ERZhcqP/oPulD9oJU7v0sDXCqhaqD4aHwc/FnZFatEs1XGOOut77HtcM9kk
 /vbmBH+C2/A12T4qRDYNrjXiimgs8to=
X-Proofpoint-ORIG-GUID: K6TvEOvzw0jodvk3X9EWd-u_1ICQ8ExW
X-Authority-Analysis: v=2.4 cv=LbipeTfi c=1 sm=1 tr=0 ts=6aac20d3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=oHFBo8UbpOLoADWG0oYA:9 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0NiBTYWx0ZWRfX588UWpT3E1dW
 u61KMluaxT2oJlaHW6oAZ2VMPvH73gNeZ4Bbd5rFhR8ZiLhtd9nubhURixMQ2noxe2b3IVy6PJC
 NINXg+Tsu2h36WOicjjsHW8ABYCJiW1MRqDwTMixNhhPYd9mp0PaCA4mX6RwrOX9M1nvSWN5V9Z
 5NejiLKkX9a/p7OwN0sKn3diooQcZ/iKO49C8G8SVZqWoQ4fZQ94/axWDUf4ratGQINYZ7ugzvD
 sY34gzfnIZF9OGnf/tIMFYYxLiBhavK2LW5Q6IaPN6PoNqmVF5fvmrb1YSugZH695SoIHO3BjWB
 DXUTdROuQR5uWbYaCQkaX+vUEspfoP2uprzswHvtaDOS2v715tNB6aLcNCJnyD5Nw/nmVQbYO3K
 M67mvGkYwc3yJaBmk491hlblu/sjQPhiNwOkAsmyXHwW+qWItITEbSj6RXhFU8Tr3KSUpibuCs5
 3v6nK/lZhSolxxHUYJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170246

Hi Lorenzo,

On Wed, Sep 09, 2026 at 08:47:48PM +0200, Lorenzo Bianconi wrote:
> >  	if (enabled) {
> > +		if (ethqos->num_noc_clks) {
> > +			ret = dev_pm_opp_set_rate(&ethqos->pdev->dev,
> > +						  ethqos->noc_clk_rates[0]);
> 
> assuming the first clock is always an OPP device seems a bit fragile to me.
> Can we find a way to enforce it? (e.g. have a dedicated clk_bulk_data struct
> for it).
> 

As Konrad also pointed out in patch 9, the opp table support needs to be
fixed. I will fix it for v3.

> >  static int qcom_ethqos_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *np = pdev->dev.of_node;
> > @@ -795,6 +895,12 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
> >  	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
> >  	ethqos->needs_sgmii_loopback = data->needs_sgmii_loopback;
> >  
> > +	if (data->num_noc_clks) {
> 
> I guess you can drop this check since it is already done in
> qcom_ethqos_init_noc_clks(), right?
> 

Yes, this can be removed.

	Ayaan


