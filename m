Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8F35C1A1
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974180; cv=none; b=mzIYbbixQ8NUzuzF6KOh0xQF9teyfOcSeYWhWGvoKFEU84UERwfgZ0U+efv3T6s8U+Dp7ZeCo7ilvmvHbnInJrWiVUelQdYfBaVwCJn0vJsrXCXH/Q26h7SE7E4jqe1s7INrQKHkQQP4kU47g0bpsVhaUdG0hYZOVGsXYUbPG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974180; c=relaxed/simple;
	bh=Edmagecg2PaIU44/PLytw5C3Adgmsos2KNBXGxIxnCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4Kg/rXOo8vSaSU2a8lsLyRbBexWdOszbE+QYN/FB1XULA5kE2y2G1Ewv0Mcr8lqx5Uwf4XmlDwIyIAgTM8gExOwLD98HV3+eZhIxvcJuirbDatuuI13ZsSWCLLhdyaTARj3LJVXFpjv+wmM9G1biV0lChRjWWCkw3ElLVZDuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S72Welgf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P/AdubD5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S72Welgf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P/AdubD5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689H86F01938177
	for <netdev@vger.kernel.org>; Wed, 9 Sep 2026 17:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NrIsFfwedfuLeKvzU70rKNtT
	+rVIhJ0VJ39qxRIr5Qw=; b=S72WelgfsaZtrz5JllU+R+NP9CCOf2QzT2nd3iR6
	wVf8+viNAnTjKlWgnXqmTJa+2+dOvFTecJ/+pvjjoef8HDQrzr3XkftTUg//NuT5
	QE2XVeIArXON82vf2exGclBNbCWt9I8jtGwOKQAOesYkbRJCpqFlVqVHwI7H4oCF
	j8otjdTeVixQT3MxPzRBRHAmjqQWv5JN1oO39r2VPoj9ccSctHWm5xJVArVMH3Fr
	khQaXcy0sO/7WGuWyZPw68FrU0mR/J3a+mR8p31Wx0leOSVanwZrRR86HEdyCSXx
	MZhI/FigkoPuuT56ufkksltirKf6M6JnMHyWflixtksxOQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk559syqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 17:16:16 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6751db2792dso881632137.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788974176; x=1789578976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NrIsFfwedfuLeKvzU70rKNtT+rVIhJ0VJ39qxRIr5Qw=;
        b=P/AdubD5CbjshzP1yZdjveCGdDZ9/HPX72/8sINHn+fiYgnL4C3gaZItFWtxacGgkB
         nTZeoE/5r7Sfyzn/oSjoq/wPffaNI1LIcHPeEof8w5MJBlEnqYD7IuhWDCcjsDdBbBvh
         VlHAnKMFzMOm6kEAA9PMHuidnfyea3dlShc89akxCkILVCic1aOJU1B0yFUfhfiP9NSi
         GvkAZUkAXb/vGRpGseAEqZGSASF5R6gUqLvtMQP14K8Gj9BuFB29/DEYotP20X2EKvoC
         2iPg49lJWLC7nkGEPl5N+PD8/eVZ6tQF2+0Ve1lKOd7hIegru6HUg3AQ2Ty8NIeiRLEa
         NN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974176; x=1789578976;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NrIsFfwedfuLeKvzU70rKNtT+rVIhJ0VJ39qxRIr5Qw=;
        b=NZ3VCxrkMBxje1Iu7bT2XDYUruZgZ4D1H8x2L7eiriUkR1GOqp5mW2RzUrJWvhUL0U
         N7CzxI3WwY4gfwqaWKO3sHEv8kIARaxm5GLTRDTrr3u7MQtycqpEF5D8GMTKmKvZjiSW
         gXN6CX7387uuRuIU/98+vU0H9Bc81jOsN7ENs4BHtarqHMTNwDZzAl5jp/lluQlZ00FI
         49WpW6mxZeCuR7UfZX8psMsm2YsDmByGhw2M6z2K4LQAb1Cxa1fVyoQqB94wuT9Ijkvw
         GFxJzRXNb8HWfAcGKbIq1L4boivC6EUemP0i2bgvVR2EFNHRS2F5i1bxx2Z/kNf/Lyrk
         6huw==
X-Forwarded-Encrypted: i=1; AKwUvBy3xinGA8B8VBYUBbpabso+b5lXNXFLK9F7mhZ/4u3BUbsH++O3YeyRTWUmajaQFMeh6QI+mVY=@vger.kernel.org
X-Gm-Message-State: AFuF++k+6MmGoRsVB2yZxKHYu6jaePC166g54AHGKXUEhzWrBp3m7uwW
	Rj2vl2RcwRGBGneCuU0DTkYV44lhn7O39pBaD2eUi+WviTb3nRTLYg0JEqxLmvssD5H3GX4XdWl
	wcDokhHfCBFbyYFV4q2baCPPT9/vuqdc/TRu9+zyncjAudp0G/x0Jk00rP/s=
X-Gm-Gg: AYBFou2qpbfZyrNBjER4LNBOWPkEFPaA+gtybRoHa/oqyH2c8B4YEtPavvkf3A9IyPX
	GhCljsWJ+Lr/JOHAITthoSE0eQrEU1SgfMUt+cYln+PpxHfVcO2GadDndNm9OGwwB9zFQQ4KBtA
	vGLQOCQ5RluhideQwCJ3XY+feVqdWLyaNgqmKasTTauW04FRQXmr8uaIUZqzCq7KyU7HuEaxpbc
	gcofMbhSOY2Pxy89QSW3zBN7JAOJgwcA8gM6imYvxHJ9mKRhfecJa+63fQgLA5WSf8OHZ4L7hvC
	gVtMpWzuobfLa08jETOPFKWofsqmHrocQ8LKIY6NM1KVgq19U4IdUx0GAhiU81Omkd7TtqxngAb
	qvNrONXoiYBGGLw==
X-Received: by 2002:a05:6102:5698:b0:78f:f234:75b9 with SMTP id ada2fe7eead31-790726d342emr1955915137.0.1788974176144;
        Wed, 09 Sep 2026 10:16:16 -0700 (PDT)
X-Received: by 2002:a05:6102:5698:b0:78f:f234:75b9 with SMTP id ada2fe7eead31-790726d342emr1955829137.0.1788974175459;
        Wed, 09 Sep 2026 10:16:15 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1fb04f1esm60278055e9.0.2026.09.09.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:16:13 -0700 (PDT)
Date: Wed, 9 Sep 2026 19:16:13 +0200
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
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
Subject: Re: [PATCH net-next v2 4/9] net: stmmac: qcom-ethqos: convert
 ethqos_rgmii_macro_init() to void
Message-ID: <aqGUXf4aaPNGhuJm@lore-desk>
References: <20260908-shikra_ethernet-v2-0-bbe3389d0652@oss.qualcomm.com>
 <20260908-shikra_ethernet-v2-4-bbe3389d0652@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jz3BLvdJrcEnCQaB"
Content-Disposition: inline
In-Reply-To: <20260908-shikra_ethernet-v2-4-bbe3389d0652@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KP1qylFo c=1 sm=1 tr=0 ts=6aa19460 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=VkhmObMS16-UOsR-uKgA:9 a=CjuIK1q_8ugA:10
 a=Ytgtto6viW8UiwRGLNEA:9 a=ODZdjJIeia2B_SHc_B0f:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: maw4ipV6yqkj5Njj1es--zEXfvnzFnEb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5MiBTYWx0ZWRfX6jeg0G6HRSSh
 Q1pJhBlSJ5KMU6rpFmFtTHgpax8HwvUfwDyTVZSBKKuTkVVoK+9m5DSHTnSNhteDDUrjsKYo4gS
 dhc2sHZwr74ExB6NToLr103EyjyRg3U=
X-Proofpoint-GUID: maw4ipV6yqkj5Njj1es--zEXfvnzFnEb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5MiBTYWx0ZWRfXwiVJGTS6MGGX
 nNXFI1fZBxkMcjQ8TTlW81Vwn4ayN+Ka4+HcVxyzrOOE/GwS1+WcLsoHE1Ug65vGSGeTnzSZ8Sr
 gpT3P4u73BR0V3I9rfJN4R4COw5ZYCc1KL2Nmm3JnrM+PsvtfNKvoQt/i0OQg4TIU2qFEeWKz2t
 +5RcnoDZFhVurR7H/gOZLUdXNR0sIW29BeigkWMNt8kxGgmPBBM63pSXbJAPMK3xAL5+lRGe7Bl
 MoHh3ya3p6njPnm+5ZMnKI7kHoI+DWdS0Op4gyZfryPGq/LaZlRFK2MbWV/IxjWr8eO5ji8cjLH
 cUcYLab4Qf+HMknmXmbTbVKMlwoaPHzUj91jKeSENf6wb940drYuEZxQSvgj0cVbAoXwc4/rLtW
 /1RFWFLA+mph91iObBZUROqVBH1tbU62Lorwax0a8v6ApDGpyHT1OFJpiNhJ9HrioM/00pNZ9/+
 SgsrkgECBZ+HTRYg5Uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090192

--Jz3BLvdJrcEnCQaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The return value is never checked by its sole caller and the speed
> validation duplicates a check higher up the call stack.  Convert to
> void and remove the dead code.
>=20
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/dr=
ivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index ac7d6d3e205a1ab5b391def879d6f1033a0961b6..44270c25d874f72e7f971757f=
ec659d36468c315 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -371,9 +371,8 @@ static int ethqos_dll_configure(struct qcom_ethqos *e=
thqos)
>  	return 0;
>  }
> =20
> -static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int speed)
> +static void ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos, int spee=
d)
>  {
> -	struct device *dev =3D &ethqos->pdev->dev;
>  	unsigned int prg_rclk_dly, loopback;
>  	unsigned int phase_shift;
> =20
> @@ -384,11 +383,6 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqo=
s *ethqos, int speed)
>  	/* Select RGMII, write 0 to interface select */
>  	rgmii_clrmask(ethqos, RGMII_CONFIG_INTF_SEL, RGMII_IO_MACRO_CONFIG);
> =20
> -	if (speed !=3D SPEED_1000 && speed !=3D SPEED_100 && speed !=3D SPEED_1=
0) {
> -		dev_err(dev, "Invalid speed %d\n", speed);
> -		return -EINVAL;
> -	}
> -
>  	rgmii_setmask(ethqos, RGMII_CONFIG_DDR_MODE, RGMII_IO_MACRO_CONFIG);
> =20
>  	if (speed =3D=3D SPEED_1000) {
> @@ -479,8 +473,6 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos=
 *ethqos, int speed)
> =20
>  	rgmii_updatel(ethqos, RGMII_CONFIG_LOOPBACK_EN, loopback,
>  		      RGMII_IO_MACRO_CONFIG);
> -
> -	return 0;
>  }
> =20
>  static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,
>=20
> --=20
> 2.34.1
>=20
>=20

--Jz3BLvdJrcEnCQaB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaqGUXQAKCRA6cBh0uS2t
rIibAP0S/gGVaDgOtJQrrnNWdWnIJWz20hm/VIyYD9SKCquKdwD/YToyiF5E74NX
CzVfv/b293W/qNrfSESKxGxMQFlq6A8=
=s/dw
-----END PGP SIGNATURE-----

--Jz3BLvdJrcEnCQaB--
