Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F233BF699
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255372; cv=none; b=eGSX2AgDvyHbiS4+8+BrgrGVRivtJp3CSHjy07L3s84gytvPtXipjQRolTkRLbE5Efq8WqlWv7Z6p/jZB28yF1gDiKhr2brqR99pmMcUrZenRMRdE7FAnMOT52hWR/pEJMwXarD9+FySEg+k4AVFRr7bd2V5D0qb4+r1uJBU8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255372; c=relaxed/simple;
	bh=oqtbq2GGeLimTwMiPXXLtV6CRd56cCRXZHus+yXgxlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSQKWRjdM/barhAelcqcbR8OYaWS/4riO10lEH7HcYI1lEdDFXDihq0xihG7HcWCDzoAdh8XFqi/kbhqkzaWzN5M24NvAvgM51esxwVEGMykBWloZLUFz/YmxgPdeEMiat/9rx73fYcRI/LAOeDTXSY9x+MHxeFlzt34V4lT9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lNhoZ5Km; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V0xBkvDV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lNhoZ5Km";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V0xBkvDV"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HG9xtg2534001
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A5QXkyLgqve2yg7aR0QbgBy6
	tWTAd+S8xlmq02cu4VU=; b=lNhoZ5KmND8CPcI2ztJrmEz30rkXHlfA6ZXPZ/BF
	dIjaldaBjswQDQz152ahMBvv8elLhUYIikte8R33fvDM1XFYB4bJJwxbmkydvHs9
	eShIPCBWf8E5pwxIyBHGeuDQy6qdqbdVggs0w6DviKRSBV4mr+P3cTJTp4wdY74Z
	5KS3ymg6PgRQRKbX/+YVIu7Re+hZZAA+q5SytRzeNXF0f5SCG5w6ckx/tUicRxJW
	NwxJhIQeClRVZ0OtvWLuWHL0rqEzv6Gfy7aqB1TktkhdKtYwuruOrhAkDsgnYJJ5
	WmRvDQrRAWN6umuhYE7m35Y2hOg40tfgMs8wZ1wwrVlYWw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys1gdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:42:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-359b81ad4e8so1325130eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792255369; x=1792860169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A5QXkyLgqve2yg7aR0QbgBy6tWTAd+S8xlmq02cu4VU=;
        b=V0xBkvDVCCZqAGH5Cr5IQ5SYSrweZgJGMCJZvlp4QOyF6LOvZCLk0KmLNig/hEyhrw
         MTIFPCwh8UR2AfCntw/X1ueFjqSGe3JzV1mBX7Drs7x1RLU9J7Eqo0a9r+hXl+78JgjR
         63IcXgV1rqh/OGfN5y6uFtzKgYGFWXEx6XR5zd4gibZ9VA1hvVbUbozZN8S1ArJGRzvD
         bPJVqnY2HjRZZgCJoXsaaTHK6XHahraEPJnupEddg6BMRzy0fRb45Xh7YNaXZS9LMc99
         qprDVLlQK1FKDUplcMfYBVeuzut4iCupCPn53iHAKBW5mCWm31x1iSU3+gxH7j89ARph
         mFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255369; x=1792860169;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5QXkyLgqve2yg7aR0QbgBy6tWTAd+S8xlmq02cu4VU=;
        b=cLOaXfyujcS63U7WVoG0gHn93uOQZeaL+SdttkYyQH73Il0H/3gJZgOJuF36iFrxaF
         scKpUOwJko+X5G1G944gcLZwTVCExmXiqKMCwXjkcU6sy73i3ZerjRSw7f4QyqSOOwqF
         F47ufZOr2DHtTKjrE3CkGN+zp3fuOxHBcgIJ+wJaBkveG0Gcw4diTg1NZvE02voTH2bz
         3OhXYx50JIuNMkaPF/eTd0w0s8lXE5GvhZwjxobmg7pMhXRm9qJr0Hfo85Pv91GS+L/L
         tTo2DBh8I//JzeLO0XwWxQHW1fGCrMwF2mGrXppS17DJlQBnLpaI82O6DB1rRbcD7ZKq
         l6ug==
X-Forwarded-Encrypted: i=1; AKwUvBxLolEvZlF3XUSxyuB7z0jERag7W4iSsR4vaAINqm+BDahffACdwT568HDqWaBzI6PChKMhiKU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV9nGx4ce5DRKAPlA+BZqRPb5CbZv0aak0JhdUC3a2IZ/agdCi
	RDBH6kihX0VymZCs/zS/99Ziz8o1sBwLD/b0PEL2vXMLHwFWpvSH42qxwQNPj4VBrklj1oQ0Kzd
	jklEBSR/xb/G5KvzLbp28VNipl3s3Irh0bK7hp0+u6CXIwTkLABFBqmAdJw8=
X-Gm-Gg: AYBFou18labIJD1y9CE/x8veDLu7t/xrE8RxC/LdcVRFYKEoH8COoW9l2GUy+5Mo/GF
	6/U1A4nA3hDQhO8wbSxlGI46KxhSnS/PFu28/Qtr4oDGoIVYhjVyfJuHzz54nOpIf+mcxKRtzJN
	PPFuNGj3lACOgU6b5WZ4pJVEbEVvcECSMhqkmuTmR5HK/kmB8jVvXv/5Lx+p9uqTCPuzv0UK3AA
	b1PzHBeFqSTd7OBMgSCCE5mv4M2W7SW7SPK+Ucs9ImFDB/Td6J6QqF7qnswDFfwWJA+0qo4L9qR
	Hr2H3DPSppo43tIxRoS5ZzfHf+cq3RvvlMVIps6fO6HNf/H78NumPlqKeIM7u5g9fcpZpliVts3
	WDnpkOUeyRcOzoQ==
X-Received: by 2002:a05:7022:7e89:b0:14d:ef19:246f with SMTP id a92af1059eb24-18513e7b18emr4689747c88.45.1792255368766;
        Sat, 17 Oct 2026 09:42:48 -0700 (PDT)
X-Received: by 2002:a05:7022:7e89:b0:14d:ef19:246f with SMTP id a92af1059eb24-18513e7b18emr4689692c88.45.1792255368055;
        Sat, 17 Oct 2026 09:42:48 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm15041602c88.5.2026.10.17.09.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:42:47 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:12:32 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vinod Koul <vkoul@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jan Petrous <jan.petrous@oss.nxp.com>, s32@nxp.com,
        Romain Gantois <romain.gantois@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Eric Dumazet <edumazet@kernel.org>, Radu Rendec <radu@rendec.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Drew Fustini <dfustini@tenstorrent.com>, linux-sunxi@lists.linux.dev,
        linux-amlogic@lists.infradead.org, linux-mips@vger.kernel.org,
        imx@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, sophgo@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v16 5/7] net: stmmac: qcom-ethqos: reuse the
 address of ethqos_emac_driver_data
Message-ID: <atOleDtybJde/UE8@oss.qualcomm.com>
References: <20261014-qcom-sa8255p-emac-v16-0-0266c2ead980@oss.qualcomm.com>
 <20261014-qcom-sa8255p-emac-v16-5-0266c2ead980@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-qcom-sa8255p-emac-v16-5-0266c2ead980@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA2NiBTYWx0ZWRfXy4PdYrX4zRdO
 LF0+hJtAAJzJXFZrHYYMpmnInE7mHfoxV5NXmeawoVDjJmsEpaQVwpt8zrrT12muJBiqcbH/uIM
 T+MQgMY1P1MbZ4ZTzUFq9jswQwsdUaJi1Z0oDt9dF5HizZE6SE9HNwrGOr4+TElU/vCvQV08apG
 UmI6vGQop+cigtXoBh9cW4aLZ5PtDYcMoxar960GAgqIwVH5N9L7LvoD7RanVmE/wYEl4o95waG
 ecdJvGk4epHJa1XfMu0V9JuDCTK67C+vLW2z4Zm2u7pZmgl23ExZ8HVP9HkplGQmPlQlvHg1FLI
 3s0yI/+9zJWUeM3NtXHO0CPWWdUhysDAcJV6n/1Jr7zw/umnUicOmF9xg7G5Jq8/oYBLexfv5pS
 7PmNGGMhCTb7sc0C2oiAO+DU5uTR7f5ru3mLDYa9mPwBD9gQayEXgoaqomkY/zj0xcT1QSycDuZ
 hY8Ni7q6jlmTDDMo6zQ==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad3a589 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=XX1oeNa5M8xgm1Jp0F0A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: 1K3IVB6zvCR1xS4Ln6JwdQL1eSWRMzZT
X-Proofpoint-GUID: 1K3IVB6zvCR1xS4Ln6JwdQL1eSWRMzZT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA2NiBTYWx0ZWRfX+lYuL7zBL9XF
 Klt6TGljMF9wbLvFuoLiIJ3zw/aY9Ao+XyE3Vwsd6MzGKCjfFoiuqKjmY0itPQv2fPSMvgmZHN7
 EWvLxMH8yLqnL9ZUiCdVmF4LmuWYZUg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170066

On Wed, Oct 14, 2026 at 02:36:44PM +0200, Bartosz Golaszewski wrote:
> Instead of needlessly copying the fields of ethqos_emac_driver_data into
> struct qcom_ethqos, just use the address of the former as a reference.
> It's .rodata after all. This is done in order to avoid having either two
> calls to of_device_get_match_data() or having to extend the latter with
> another field when adding support for SCMI.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

After testing it on a couple of legacy non-SCMI boards, I did not find
any issues with this patch, so:

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

