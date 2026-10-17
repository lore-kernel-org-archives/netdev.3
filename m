Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D538B12D
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253108; cv=none; b=RaEs0agPZJbkF8wTM+Z3AQ02FSI7WAIBykcZ+jpq+CxABbPMzqyGAxZxS3uc5B/DHwxjpwqQGwWd7X+WTiqnUmn9TFzw0Lv7sRjVMoGaDUsEOn4Vn41I6DEPEObzS1PYHxOy0fJe36ar+3wdkFV4qr9aWmpnm+lQq7vz+YXS/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253108; c=relaxed/simple;
	bh=a0z4sCr/GkQOta5mnr6iXDV256GLldZRMrqr2W45m0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOx2zrCgvKqXnQiPJUAcJ5AwGCV40npoyoxjW8c48/dBg6SOa29JyBDresaSqhCv3eoMWTDvu3i+xUQMr/1n8Xl9BT01qEpbs0dWmk74E37Jbl9RmzAWA/RHffpKcGzeVcYD+Adxjk/DPEPILo7QWpJ0bhLX0b43A4BLDBhwq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K+MQVgGM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kA9iCX6l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K+MQVgGM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kA9iCX6l"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HDEpqp1127083
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AR3F248zW2l1oh2ByOU133KA
	OQzd3pYgIfSBxic3/p4=; b=K+MQVgGMAR++3JL59vtKO35/QBMDqreoBx3tzLjP
	kPCxZ7ljpfI7e6P8Wkkp9wdvvD0XL/2SG7fI+HwnwV26VMptBlnuZn5D3fieEI+X
	Cn0blykevVvToWUZSe7AXsC83ntesfyirD/OU/LmfIYR73UYb8BQ1aQG/9sMlBAn
	ju77XoxXRQMHI+ty4JJXd2tMll3AJjbEQ8cUx3m83zuS/cOYKst8jev6OgoDn4+p
	SAj+wpjkv3KCrXFL961cyiCvQRh9aDORYYC1F3A5LP72IGIqxyyfJJcejegtjZOE
	c7eDHmgBE5NN6vo8ervECxtKcKgZCBH2aFAzqmCBjcreNg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc13us8ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:05:06 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35fb6be0f9fso2335843eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792253105; x=1792857905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AR3F248zW2l1oh2ByOU133KAOQzd3pYgIfSBxic3/p4=;
        b=kA9iCX6l9L5bNFROpiG5zc4X3EChcO/KTdWnD/0UZcAPwNFBojxROfTxCuSAEJaD7V
         WrzPKYFn2R3FlZGGJkRoxRWDbQp2BkUjJKydyr3J4+Mfn6CWWH1udCc0MikmxiwreIFd
         xV16iHt76nIMUM8tUkiD1J8Rioko5kfTBluytfw5mDeTBUaMmAx3/Uh3PET1Q4/TByIa
         nBCFosUCN1y2vdTgk8jtUHcw/GMBxbkTxPobDk3ioUN6QIcjZrAs74GGygWVuUk6+Hy4
         0gWnuohRg8mBa3ZTcSa/QgkGGW+kZ3RmSfK7VPLuxdvbKrgPdfig2yTV10ERx7uLrwyM
         1i6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792253105; x=1792857905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AR3F248zW2l1oh2ByOU133KAOQzd3pYgIfSBxic3/p4=;
        b=SAFr/oY5CalWP4c2TltSsclHRL85mHMOvpO9uiz0Nxcha10yK9o/SEAsge1VR6A6ql
         yYfnB+q1K0r1JlQkGSdp0zTq8u7WgW5yJrdntrjXvxwSQAdGJUoF1w6eUpoQnHfOqVrC
         41QqAKReCqLwgeNnKtQPtdNckomZtLz1ZtNB2ar3gsrfkpE7IHgtMh5WF3kLGNLGtufC
         zgsQ518Mo+tFQlWev0lU+glGvhiTP7tqV3Adfoz6TDbuD4eU8Np3zjQGRZ65OgyKGdTS
         i2hJ856tjXRPH6OAErsTJhagXcnAdf5GDFmuRMBzk4cqVA78DN5Vc89b/bv90wuzXjQQ
         KhnA==
X-Forwarded-Encrypted: i=1; AKwUvBzhCONbE48utVPKgqYWOHYyJ70HPbWUWG5naeZnoPCNHlnLRvXsnRcVNCjyqnLWtaaCWhWINd0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGYaQ5TU6L1Ptxoi4aQw34RIhqM2aXUdsRfDWjhriT4U8T6Van
	qc81bVLFbcGPajo5fz1DjZx3vNq+yGbWA264HcP3OswUnY/fLAcxrh1ZPH850NeW06qPH7rcpsE
	QMJBe5sZ6SUaW2phgCHM9aDD5CIJ5rVgWrSY/f6PnxXQqaQT07fhOLtJ43ZM=
X-Gm-Gg: AYBFou0nEm8mxeA6VoXiTY1JVJ4giY7Pa3Wg3XlCm8AflPsuORpGumeyJ7vZkVMFUam
	W/5ekhJxL3zKLz9fSQ2sFKL0Lr+yqRKnNJ1G/xDaeGZNX1BCq16J/YI1y60wwa/TPjNVYV+e7Oo
	2oT6UdRlWDWHkHue+hxFTx94PNcfrg7Mfpsy9fObIa7BxOfHJcgBVBg7lQtcT/kEAaAf1XUYowc
	ix2clET/iTUPxy9SrD2GHl5nzTTvqo34eAcoI2fDumWt3Hvr+OqjQqC+zsEHIuyCMzOVtQJMXYc
	zCMMHJNIUJRIttI8lbEYwMBqXAjHA4awNnC1BoMM6EWOsYSE3x5Tv8G92tC34NHmY5A9DSlB4VV
	iSCwXG3umlEpaFw==
X-Received: by 2002:a05:693c:415a:20b0:361:aca0:522b with SMTP id 5a478bee46e88-361aca053bcmr4384779eec.11.1792253104751;
        Sat, 17 Oct 2026 09:05:04 -0700 (PDT)
X-Received: by 2002:a05:693c:415a:20b0:361:aca0:522b with SMTP id 5a478bee46e88-361aca053bcmr4384739eec.11.1792253104117;
        Sat, 17 Oct 2026 09:05:04 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm29199920eec.28.2026.10.17.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:05:03 -0700 (PDT)
Date: Sat, 17 Oct 2026 21:34:53 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 4/9] net: stmmac: qcom-ethqos: fix RGMII_ID
 mode to use DLL bypass
Message-ID: <atOcpTqukIRILloe@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-0-26a8beb44b8f@oss.qualcomm.com>
 <20261017-shikra_ethernet-v3-4-26a8beb44b8f@oss.qualcomm.com>
 <17aea8bf-490f-4006-880f-1999aed1df59@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17aea8bf-490f-4006-880f-1999aed1df59@lunn.ch>
X-Proofpoint-GUID: pzmoF7tz_5IZMmJoq3BtyrQpacwODuep
X-Proofpoint-ORIG-GUID: pzmoF7tz_5IZMmJoq3BtyrQpacwODuep
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX0ceD9oEX4tvp
 PmhUsdf5W37UeF7V+XP7sSSOXW6dC5UQP0BTaTezirm+uitFVlk4scB1mB/lhd24sqhqs7fUp14
 4dxbEFazEphOoEmmwgk1HBojrtbDtbI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NCBTYWx0ZWRfX4reKNQsYEFG5
 bmXWZybdvd6s+PCo4c4jUC2b4RQHbA7WIMnmAbF6hunbmdYsXmSUmPyKMjbyGSzZHtBGMnGlEEq
 NhHuUk1R5y7Ca9vAlJ06eTODukbIvDKOiQ8iB8awcZsbeIVFB5RfrGBJhlfaUqkOsYPRzuFLHs8
 42bVsqsrMxQ8TjIkzaDTS+ZisH2tuwyuilY5sPg0LnrmitsDy9DJSOakKCgg4+/cMgvPxAojmWj
 ijNQtbCDwUY1reYCoZmcTa0V+0VpEL03Bjh9JpEhztY5RW3F+xR8Ao4arRmufo89MtKDk2iWU5j
 bqxW4l0F2HliDV+jIW1s9UrKM4kbSi22KtOroVuxNXop8UI6k4s/w0Jl7E7Ni7CkNPYmw4KK4n/
 9ZNxsuPBONfhtJ4Ui3eW2+PVmCwZ55y2gktH1SGv+RkRhXC/q1ejRdRxtJBkjOFnumxBARpiO+Q
 q6kcF3l85YRxZmkMcfg==
X-Authority-Analysis: v=2.4 cv=SKzXx+vH c=1 sm=1 tr=0 ts=6ad39cb2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=2_h2fYecv1F4Ojg9QoMA:9 a=CjuIK1q_8ugA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170064

On Sat, Oct 17, 2026 at 04:00:27PM +0200, Andrew Lunn wrote:
> On Sat, Oct 17, 2026 at 03:15:15PM +0530, Mohd Ayaan Anwar wrote:
> > When "rgmii-id" is selected the PHY supplies both TX and RX delays, so
> > the MAC must not add its own. The driver currently falls through to the
> > generic DLL initialisation path which programs it to add a delay.
> > 
> > Power down the DLL and set DDR bypass mode for RGMII_ID, then program
> > the IO_MACRO via a new ethqos_rgmii_id_macro_init() helper. Also fix
> > ethqos_set_clk_tx_rate() to not double the clock rate in bypass mode at
> > 100M/10M, and remove RGMII_ID from the phase-shift suppression in
> > ethqos_rgmii_macro_init() since RGMII_ID no longer reaches that path.
> 
> How many different boards have you tested this on? How confident are
> you there will not be regressions?
> 

Apart from the new compatible, I have tested this on three different
board designs of the QCS615 SoC. The EMAC on it is identical to the
"qcom,qcs404-ethqos" version. Two of the boards have the Microchip
KSZ9031 PHY while the third has the TI DP83867 PHY.

> Since you are adding a new compatible "qcom,shikra-ethqos", you could
> limit the change in behaviour to just this.
> 

That sounds like a better idea. I will restrict the new sequence to just
"qcom,shikra-ethqos" and "qcom,qcs404-ethqos" using something like
data->phy_managed_delays = true. I will change the warning patch to also
check for this boolean, so any users of "qcom,qcs404-ethqos" can be
notified.

The two other RGMII designs ("qcom,qcs404-ethqos" and
"qcom,sc8280xp-ethqos") can continue using the legacy flow.

	Ayaan

